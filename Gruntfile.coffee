module.exports = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        dependencies: paths: bower: true
        clean: true

      lib:
        path: 'source/code'
        dstPath: 'build/lib'

      min:
        derive: 'lib'
        dependencies: rootExports: 'index': ['hello']
        dstPath: "build/urequire-example-helloworld-min.js"
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