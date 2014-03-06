
// SiteCategories Module
var SiteCategories = angular.module("SiteCategory", ["ListView", "Filter", "Anim", "Fields",]);

// SiteCategories configuration section ---------------------------
SiteCategories.config(["$routeProvider", function($routeProvider){

    // Add any route you need here
    $routeProvider.
        when("/site_categories", {
            templateUrl: template("site_category/index"),
            controller: "SiteCategoryController"
        }).
        when("/site_categories/new",{
            templateUrl: template("site_category/new"),
            controller: "AddSiteCategoryController"
        }).
        when("/site_categories/:id/edit",{
            templateUrl: template("site_category/new"),
            controller: "AddSiteCategoryController"
        });

}]);

// SiteCategory index controller -------------------------------------------------------
// This controller is responsible for list page (index)
SiteCategories.controller("SiteCategoryController", ["$scope", "gettext", "Restangular", "catch_error", "$location", "$routeParams",
                                      function($scope, gettext, API, catch_error, $location, $routeParams){

    
    
    

    // details_template is the address of template which should load for
    // each item details section
    $scope.details_template = template("site_category/details");

    // Buttons for top of the list-view
    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            permission: {
              name: "create",
              model: "SiteCategory"
            },
            route: "#/site_categories/new"

         },
        {
            title: gettext("Duplicate"),
            icon: "fa fa-files-o",
            classes: "btn tiny red",
            permission: {
              name: "create",
              model: "SiteCategory"
            },
            action: function(){
                var selected = _.find($scope.site_categories, function(x){
                    return x.is_selected === true;
                });

                if (selected === undefined ) {
                    error_message(gettext("You should only select one item to copy."));
                }
                else {
                    $location.path("/site_categories/-" + selected.id + "/edit");
                }
            }
        }

    ];
    /*
     * On delete event handler - `items` is an array of objects to delete
     */
    $scope.on_delete = function(items){

        var query = [];
        items.forEach(function(item){
            query.push(item.id);
        });

        API.all("site_categories").customDELETE(query.join(","))
            .then(function(data) {

                $scope.site_categories = _.filter($scope.site_categories, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            }, function(data){
                catch_error(data);
            });

    };
    
    
    API.all("site_categories").getList()
        .then(function(data){
            $scope.site_categories = data;
        }, function(data){
            catch_error(data);
        });
     
}]);

SiteCategories.controller("AddSiteCategoryController", ["Restangular", "$scope", "$location", "$routeParams", "gettext", "catch_error", function(API, $scope, $location, $routeParams, gettext, catch_error){

    

    $scope.select2options = {};
    $scope.editing = false;
    $scope.obj_id = null;
    var is_copy = false;

    
    
    if( "id" in $routeParams ){
        $scope.obj_id = $routeParams.id;
        $scope.editing = true;
        if ($scope.obj_id < 0) {
            is_copy = true;
            $scope.obj_id = $scope.obj_id * -1;
        }

        var obj = API.one("site_categories", $scope.obj_id).get()
                .then(function(data) {
                
                    $scope.name = data.name;
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
        $location.path("/site_categories");
    };

    $scope.save = function(save_another){
        $("small.error").html("");
        $("small.error").removeClass("error");

        var site_category = {site_category: {
            name: $scope.name,
            description: $scope.description,
            __res__: 0
        }};
        if (($scope.obj_id) && (is_copy === false)) {

            API.one("site_categories", $scope.obj_id).patch(site_category)
                .then(function(){
                    success_message(gettext("SiteCategory updated successfully."));
                    if (save_another) {
                        $(".form input").val("");
                    }
                    else {
                        $location.path("/site_categories");
                    }
                }, function(data){
                    catch_error(data);
                });

        }
        else {
            API.all("site_categories").customPOST(site_category, "").then(function(){
                success_message(gettext("SiteCategory created successfully."));
                if (save_another) {
                    $(".form input").val("");
                }
                else {
                    $location.path("/site_categories");
                }
            }, function(data){
                catch_error(data);
            });
        }

    };
}]);

