'use strict';

module.exports = function (grunt) {

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.initConfig({
    jshint: {
      options: {
        jshintrc: true
      },
      all: ['js/*.js']
    },
    concat: {
      dist: {
        src: ['js/frag/start.frag', 'ext/json2.js', 'ext/gridster/jquery.gridster.min.js', 'ext/gridster/shiny-gridster-init.js', 'js/googleChart_init.js', 'js/shiny-gridster-bindings.js', 'js/shiny-gridster-init.js', 'js/shiny-gvis-bindings.js', 'js/shiny-tinymce-bindings.js', 'js/frag/end.frag'],
        dest: '../www/ShinyBuilder.js'
      }
    },
    uglify: {
      options: {
        sourceMap: true,
        sourceMapName: '../www/ShinyBuilder.map.js'
      },
      dist: {
        files: {
          '../www/ShinyBuilder.min.js': ['../www/ShinyBuilder.js']
        }
      }
    },
    cssmin: {
      combine: {
        files: {
          '../www/ShinyBuilder.min.css': ['ext/gridster/jquery.gridster.min.css', 'ext/gridster/shiny-gridster.css', 'css/main.css']
        }
      }
    },
    watch: {
      javascript: {
        files: ['js/*.js'],
        tasks: ['jshint', 'concat', 'uglify']
      },
      css: {
        files: ['css/*.css'],
        tasks: ['cssmin']
      }
    }
  });

  grunt.registerTask('default', ['jshint', 'concat', 'uglify', 'cssmin', 'watch']);

};
