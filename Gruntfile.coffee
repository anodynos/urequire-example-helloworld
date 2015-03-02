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

  splitTasks = (tasks)-> if (tasks instanceof Array) then tasks else tasks.split(/\s/).filter((f)->!!f)
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: "min spec"
    develop: "lib specWatch"
    all: "lib spec min spec"
  }
  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig