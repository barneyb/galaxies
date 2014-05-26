"use strict"

# Declare app level module which depends on filters, and services
angular.module("galaxies", [
    "ngRoute"
    "galaxies.filters"
    "galaxies.services"
    "galaxies.directives"
    "galaxies.controllers"
]).config [
    "$routeProvider"
    ($routeProvider) ->
        $routeProvider.when "/view1",
            templateUrl: "partials/partial1.html"
            controller: "MyCtrl1"

        $routeProvider.when "/view2",
            templateUrl: "partials/partial2.html"
            controller: "MyCtrl2"

        $routeProvider.otherwise redirectTo: "/view1"
]