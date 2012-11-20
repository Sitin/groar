module.exports = function (grunt) {
  var options = require('./roar');
  // Project configuration
  grunt.initConfig({
    pkg:        '<json:package.json>',
    test:       {
      files: ['test/**/*.js']
    },
    coffeelint: {
      main: [options.coffeePath + '/**/*.coffee']
    },
    coffee:     {
      main: {
        src:     ['<config:coffeelint.main>'],
        dest:    options.buildPath,
        options: {
          bare:          false,
          preserve_dirs: true,
          base_path:     'coffee'
        }
      }
    },
    lint:       {
      files: ['*.js', options.buildPath + '/**/*.js']
    },
    watch:      [
      {
        files: ['<config:coffeelint.main>'],
        tasks: 'default'
      }
    ],
    jshint:     {
      options: {
        curly:   true,
        eqeqeq:  true,
        immed:   true,
        latedef: true,
        newcap:  true,
        noarg:   true,
        sub:     true,
        undef:   true,
        boss:    true,
        eqnull:  true,
        node:    true,
        strict:  true
      },
      globals: {
        exports: true
      }
    }
  });

  grunt.loadNpmTasks('grunt-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');

  // Default task.
  grunt.registerTask('default', 'coffeelint coffee lint test');

};