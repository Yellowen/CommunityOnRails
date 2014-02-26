// Settings Module
var Settings = angular.module("Settings", []);

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


Settings.controller("SettingsMenuController", ["gettext", function(gettext){
    this.menu_items = [
        {title: gettext("Themes"), url: "/settings/themes", permission: {action: "read", model: "Permissions::Theme"}}
    ];
}]);
