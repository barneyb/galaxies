"use strict"

# Directives 
angular.module("galaxies.directives", []).directive "appVersion", [
    "version"
    (version) ->
        return (scope, elm, attrs) ->
            elm.text version
]