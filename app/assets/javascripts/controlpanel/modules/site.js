// Sites Module
var Sites = angular.module("Site", ["ListView", "Filter", "Anim", "Fields",]);

// Sites configuration section ---------------------------
Sites.config(["$routeProvider", function($routeProvider){
    // Add any route you need here
    $routeProvider.
        when("/sites", {
            templateUrl: template("site/index"),
            controller: "SiteController"
        }).
        when("/sites/new",{
            templateUrl: template("site/new"),
            controller: "AddSiteController"
        }).
        when("/sites/:id/edit",{
            templateUrl: template("site/new"),
            controller: "AddSiteController"
        });
}]);


// Site index controller -------------------------------------------------------
// This controller is responsible for list page (index)
Sites.controller("SiteController", ["$scope", "gettext", "Restangular", "catch_error", "$location", "$routeParams", function($scope, gettext, API, catch_error, $location, $routeParams){

    
    
    // Cache object for each field name possible values
    $scope.cache = {};

    // Change event handler for field_name combobox in bulk edit
    $scope.field_name_change = function(x){
        var current_value = $("#field_name").val();
        $scope.current_field= _.find($scope.fields, function(x){
            return x.name == current_value;
        });
        if( "to" in $scope.current_field ){
            if (! ($scope.current_field.name in $scope.cache)) {
                $scope.current_field.to().then(function(x){
                    $scope.cache[$scope.current_field.name] = x;
                });
            }
        }
    };

    $scope.columns = [];
    $scope.fields = [
    ];

    // details_template is the address of template which should load for
    // each item details section
    $scope.details_template = template("site/details");

    // Buttons for top of the list-view
    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            permission: {
              name: "create",
              model: "SiteFramework::Site"
            },
            route: "#/sites/new"

         },
        {
            title: gettext("Bulk Edit"),
            icon: "fa fa-edit",
            classes: "btn tiny yellow",
            permission: {
              name: "update",
              model: "SiteFramework::Site"
            },
            action: function(){
                $scope.$apply("bulk_edit = ! bulk_edit");
            },

        },
        {
            title: gettext("Duplicate"),
            icon: "fa fa-files-o",
            classes: "btn tiny red",
            permission: {
              name: "create",
              model: "SiteFramework::Site"
            },
            action: function(){
                var selected = _.find($scope.sites, function(x){
                    return x.is_selected === true;
                });

                if (selected === undefined ) {
                    error_message(gettext("You should only select one item to copy."));
                }
                else {
                    $location.path("/sites/-" + selected.id + "/edit");
                }
            }
        }

    ];

    /*
     * On bulk save event
     */
    $scope.bulk_save = function(){

        $scope.view_progressbar = true;
        var value = $("#field_value").val();
        var field = $scope.current_field.name;
        var type = $scope.current_field.type;
        var field_name = $scope.current_field.title;
        if ((type == "has_many") || (type == "belongs_to")) {
            value = parseInt(value, 10);
        }
        var requests_count = 0;

        $scope.rfiller = 0;
        $scope.sfiller = 0;
        $scope.success = 0;
        $scope.failed = 0;
        $scope.total = _.where($scope.sites, function(x){return x.is_selected === true;}).length;

        _.each($scope.sites, function(x){
            if( x.is_selected === true ){
                x[field] = value;
                requests_count++;

                var rwidth = (requests_count * 100) / $scope.total;
                if (requests_count == $scope.total) { rwidth = 100; }
                $scope.rfiller = rwidth + "%";

                API.one("sites", x.id).patch(x).then(function(data){
                    $scope.success++;
                    var swidth = parseInt(($scope.success * 100) / $scope.total);
                    if ($scope.sucess == $scope.total) { swidth = 100; }
                    $scope.sfiller = swidth + "%";
                    x[field_name.toLowerCase()] = data[field_name.toLowerCase()];
                }, function(data){
                    $scope.failed++;
                    catch_error(data);
                });

            }
        });

    };

    /*
     * On bulk cancel event
     */
    $scope.bulk_cancel = function(){
        $("#field_name").val(0);
        document.getElementById("bulk_form").reset();
        $scope.view_progressbar = false;
        $scope.bulk_edit = false;
    };
    
    /*
     * On delete event handler - `items` is an array of objects to delete
     */
    $scope.on_delete = function(items){

        var query = [];
        items.forEach(function(item){
            query.push(item.id);
        });

        API.all("sites").customDELETE(query.join(","))
            .then(function(data) {

                $scope.sites = _.filter($scope.sites, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            }, function(data){
                catch_error(data);
            });

    };
    
    
    API.all("sites").getList()
        .then(function(data){
            $scope.sites = data;
        }, function(data){
            catch_error(data);
        });
     
}]);


Sites.controller("AddSiteController", ["Restangular", "$scope", "$location", "$routeParams", "gettext", "catch_error", function(API, $scope, $location, $routeParams, gettext, catch_error){

    

    $scope.select2options = {};
    $scope.editing = false;
    $scope.obj_id = null;
    var is_copy = false;

    
    $scope.category_data = {
        type: 'belongs_to',
        to: 'site_categories',
        name: 'category'
    };
    $scope.namespace_data = {
        type: 'belongs_to',
        to: 'namespaces',
        name: 'namespace'
    };
    
    if( "id" in $routeParams ){
        $scope.obj_id = $routeParams.id;
        $scope.editing = true;
        if ($scope.obj_id < 0) {
            is_copy = true;
            $scope.obj_id = $scope.obj_id * -1;
        }

        var obj = API.one("sites", $scope.obj_id).get()
                .then(function(data) {
                
                    $scope.title = data.title;
                    $scope.category = data.category.id;
                    $scope.namespace = data.namespace.id;
                    $scope.description = data.description;
                }, function(data){
                    catch_error(data);
                });

    }

    $scope.have = function(field, obj_id) {
        var tmp = _.where($scope[field], {id: obj_id});
        if (tmp.length > 0) {
            return true;
        }
        else {
            return false;
        }
    };

    $scope.cancel = function(){
        $(".form input").val("");
        $location.path("/sites");
    };

    $scope.save = function(save_another){
        $("small.error").html("");
        $("small.error").removeClass("error");

        var site = {site: {
            title: $scope.title,
            category_id: parseInt($scope.category),
            namespace_id: parseInt($scope.namespace),
            description: $scope.description,
            __res__: 0
        }};
        if (($scope.obj_id) && (is_copy === false)) {

            API.one("sites", $scope.obj_id).patch(site)
                .then(function(){
                    success_message(gettext("Site updated successfully."));
                    if (save_another) {
                        $(".form input").val("");
                    }
                    else {
                        $location.path("/sites");
                    }
                }, function(data){
                    catch_error(data);
                });

        }
        else {
            API.all("sites").customPOST(site, "").then(function(){
                success_message(gettext("Site created successfully."));
                if (save_another) {
                    $(".form input").val("");
                }
                else {
                    $location.path("/sites");
                }
            }, function(data){
                catch_error(data);
            });
        }

    };
}]);



Sites.controller("SiteMenuController", ["gettext", function(gettext){
    this.menu_items = [
        {title: gettext("Namespaces"), url: "namespaces", permission: {action: "read", model: "Namespace"}},
        {title: gettext("Sites"), url: "sites", permission: {action: "read", model: "SiteFramework::Site"}},
        {title: gettext("Categories"), url: "site_categories", permission: {action: "read", model: "SiteCategory"}},
        ];
}]);

