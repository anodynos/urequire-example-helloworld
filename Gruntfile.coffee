module.exports = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        dependencies: paths: bower: true  # find the paths to libs using bower
        clean: true

      lib:
        path: 'source/code'               # the root to our code
        dstPath: 'build/lib'              # where to output converted files
        template: banner: true            # add a standard banner derived from 'package.json'
        resources: ['inject-version']     # add a `var VERSION = 'x.x.x';` in main module's body

      min:
        derive: 'lib'                     # inherit the whole 'lib' config
        dstPath: "build/urequire-example-helloworld-min.js"
        dependencies:
          rootExports: 'index': ['hello'] # 'window.hello' will hold main module (by default on <script ...> execution only)
        template: 'combined'
        optimize: true

      spec:
        path: "source/spec"
        dstPath: "build/spec_combined/index-combined.js"
        template: 'combined'
        afterBuild: require('urequire-ab-specrunner')

      specWatch: derive: 'spec', watch: true

  grunt.registerTask "default", ["urequire:min", "urequire:spec"]
  grunt.registerTask "develop", ["urequire:min", "urequire:specWatch"]
  grunt.registerTask "all",     ["urequire:lib", "urequire:spec",      "urequire:min", "urequire:spec"] # in pairs of 'lib', 'spec'

  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig