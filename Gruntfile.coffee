module.exports = (grunt) ->
    outdir = "public"
    grunt.initConfig
        pkg: grunt.file.readJSON("package.json")
        less:
            compile:
                files:
                    "app/css/_app_less.css": "app/less/*.less"

        coffee:
            compile:
                options:
                    join: true

                files:
                    "app/js/_app_coffee.js": "app/coffee/*.coffee"
                    "test/js/e2e/_tests.js": "test/coffee/e2e/*.coffee"
                    "test/js/unit/_tests.js": "test/coffee/unit/*.coffee"

        uglify:
            vendor_js:
                files: (->
                    r = {}
                    r[outdir + "/js/vendor.js"] = [outdir + "/js/vendor.js"]
                    r
                )()

            app_js:
                files: (->
                    r = {}
                    r[outdir + "/js/app.js"] = [outdir + "/js/app.js"]
                    r
                )()

        cssmin:
            app_css:
                files: (->
                    r = {}
                    r[outdir + "/css/app.css"] = [outdir + "/css/app.css"]
                    r
                )()

        htmlmin:
            index_html:
                options:
                    removeComments: true
                    collapseWhitespace: true

                files: (->
                    r = {}
                    r[outdir + "/index.html"] = [outdir + "/index.html"]
                    r
                )()

        concat:
            vendor_js:
                src: []
                dest: outdir + "/js/vendor.js"

            app_js:
                src: ["app/js/*.js"]
                dest: outdir + "/js/app.js"

            app_css:
                src: ["app/css/*.css"]
                dest: outdir + "/css/app.css"

        copy:
            static:
                files: [
                    expand: true
                    cwd: "app/"
                    src: [
                        "img/**/*.*"
                        "index.html"
                    ]
                    dest: outdir + "/"
                ]

        watch:
            less:
                files: ["app/less/*.less"]
                tasks: ["less"]

            coffee:
                files: [
                    "app/coffee/**/*.coffee"
                    "test/coffee/**/*.coffee"
                ]
                tasks: ["coffee"]

            vendor_js:
                files: ["lib/**/*.js"]
                tasks: ["concat:vendor_js"]

            app_js:
                files: ["app/js/*.js"]
                tasks: ["concat:app_js"]

            app_css:
                files: ["app/css/*.css"]
                tasks: ["concat:app_css"]

            static:
                files: [
                    "app/img/**/*.*"
                    "app/index.html"
                ]
                tasks: ["copy:static"]

        clean:
            all: [
                "public" # not outdir, in case we go up...
                # children of outdir
                outdir + "/css"
                outdir + "/img"
                outdir + "/js"
                
                # internal stuff
                "target"
                "app/css/_*"
                "app/js/_*"
            ]
            static: [
                outdir + "/data"
                outdir + "/img"
            ]

    
    # Load the plugin
    grunt.loadNpmTasks "grunt-contrib-less"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-contrib-concat"
    grunt.loadNpmTasks "grunt-contrib-copy"
    grunt.loadNpmTasks "grunt-contrib-clean"
    grunt.loadNpmTasks "grunt-angular-templates"
    grunt.loadNpmTasks "grunt-contrib-uglify"
    grunt.loadNpmTasks "grunt-contrib-cssmin"
    grunt.loadNpmTasks "grunt-image-embed"
    grunt.loadNpmTasks "grunt-contrib-connect"
    grunt.loadNpmTasks "grunt-contrib-htmlmin"
    grunt.loadNpmTasks "grunt-exec"
    grunt.registerTask "build", [
        "clean:all"
        "coffee"
        "less"
        "concat"
        "copy:static"
    ]
    grunt.registerTask "default", ["build"]
    grunt.registerTask "client", [
        "build"
        "watch"
    ]
    grunt.registerTask "package", [
        "build"
        "clean:static"
        "uglify"
        "cssmin"
        "htmlmin"
    ]
    grunt.registerTask "deploy", ["exec:deploy"]
    return