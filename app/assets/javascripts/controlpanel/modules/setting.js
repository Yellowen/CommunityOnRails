
// Settings Module
var Settings = angular.module("Setting", ["ListView", "Filter", "Anim", "Fields",]);

// Settings configuration section ---------------------------
Settings.config(["$routeProvider", function($routeProvider){

    // Add any route you need here
    $routeProvider.
        when("/settings", {
            templateUrl: template("setting/index"),
            controller: "SettingController"
        }).
        when("/settings/new",{
            templateUrl: template("setting/new"),
            controller: "AddSettingController"
        }).
        when("/settings/:id/edit",{
            templateUrl: template("setting/new"),
            controller: "AddSettingController"
        });

}]);

// Setting index controller -------------------------------------------------------
// This controller is responsible for list page (index)
Settings.controller("SettingController", ["$scope", "gettext", "Restangular", "catch_error", "$location",
                                      function($scope, gettext, API, catch_error, $location){

    $scope.filter_config = {
        list: API.all("settings")
    };
    $scope.settings = [];
    

    // details_template is the address of template which should load for
    // each item details section
    $scope.details_template = template("setting/details");

    // Buttons for top of the list-view
    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            permission: {
              name: "create",
              model: "Setting"
            },
            route: "#settings/new"

        },
        {
            title: gettext("Duplicate"),
            icon: "fa fa-files-o",
            classes: "btn tiny red",
            permission: {
              name: "create",
              model: "Setting"
            },
            action: function(){
                var selected = _.find($scope.settings, function(x){
                    return x.is_selected === true;
                });

                if (selected === undefined ) {
                    error_message(gettext("You should only select one item to copy."));
                }
                else {
                    $location.path("/settings/-" + selected.id + "/edit");
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

        API.all("settings").customDELETE(query.join(","))
            .then(function(data) {

                $scope.settings = _.filter($scope.settings, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            }, function(data){
                catch_error(data);
            });

    };
    /*
    API.all("settings").getList()
        .then(function(data){
            $scope.settings = data;
        }, function(data){
            catch_error(data);
        });
     */
}]);

Settings.controller("AddSettingController", ["Restangular", "$scope", "$location", "$routeParams", "gettext", "catch_error", function(API, $scope, $location, $routeParams, gettext, catch_error){

    $scope.select2options = {};
    $scope.editing = false;
    $scope.obj_id = null;
    var is_copy = false;

    
    $scope.theme_data = {
        type: 'in',
        choices: _.sortBy([{name: "default", title: "Default"},{name: "clean", title: "Clean"},]),
        name: 'theme'
    };
    $scope.theme_choices = _.sortBy([
        {name: "default", title: "Default"},
        {name: "clean", title: "Clean"},
    ], "title");
    if( "id" in $routeParams ){
        $scope.obj_id = $routeParams.id;
        $scope.editing = true;
        if ($scope.obj_id < 0) {
            is_copy = true;
            $scope.obj_id = $scope.obj_id * -1;
        }

        var obj = API.one("settings", $scope.obj_id).get()
                .then(function(data) {
                
                    $scope.theme = data.theme;
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
        $location.path("settings");
    };

    $scope.save = function(save_another){
        $("small.error").html("");
        $("small.error").removeClass("error");

        var setting = {setting: {
            theme: $scope.theme,
            __res__: 0
        }};
        if (($scope.obj_id) && (is_copy === false)) {

            API.one("settings", $scope.obj_id).patch(setting)
                .then(function(){
                    success_message(gettext("Setting updated successfully."));
                    if (save_another) {
                        $(".form input").val("");
                    }
                    else {
                        $location.path("settings");
                    }
                }, function(data){
                    catch_error(data);
                });

        }
        else {
            API.all("settings").customPOST(setting, "").then(function(){
                success_message(gettext("Setting created successfully."));
                if (save_another) {
                    $(".form input").val("");
                }
                else {
                    $location.path("settings");
                }
            }, function(data){
                catch_error(data);
            });
        }

    };
}]);

