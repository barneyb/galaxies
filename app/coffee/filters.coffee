"use strict"

# Filters 
angular.module("galaxies.filters", []).filter "interpolate", [
    "version"
    (version) ->
        return (text) ->
            String(text).replace /\%VERSION\%/g, version
]