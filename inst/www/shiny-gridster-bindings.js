var first_load = 1;

$(function() {
  
    //Handler to load selected dashboard  
 /*   setTimeout(function(){
          $('#sel_dashboard').data('selectize').on('item_add', 
          function($item, value){if(first_load == 0){window.location = '?='+ $item;}else{first_load = 0; alert('here')}});
    }, 500);*/

    //var $navBar = $('<nav class="navbar navbar-inverse" role="navigation"></nav>').prependTo($('body'));
    //$('.container-fluid .row').addClass('toolbar').appendTo($navBar);

    $(document).on({
      mouseenter: function () {
        var $el = $(this);
        $el.find('div.btn, button.deleteme').fadeIn(duration = 100);
      },
      mouseleave: function () {
        var $el = $(this);
        $el.find('div.btn, button.deleteme').fadeOut(duration = 100);
      }
    }, ".gridster ul li ");

    setTimeout(function() {
      $(document).find('.gridster ul li div.btn, .gridster ul li button.deleteme').fadeOut(duration = 100);
    }, 1000);

    //Delete widget button handler
    $(document).on('click', ".deleteme", function () {
      Shiny.unbindAll();
      var gridster = $('.gridster ul').gridster().data('gridster');
      $(this).parents().eq(0).addClass("rmv");
      gridster.remove_widget($('.rmv'));
      $(this).parents().eq(0).removeClass("rmv");
      $('.gridster ul').trigger('widget.removed');
      Shiny.bindAll();
    });

    //Set active chart input
    $(document).on('click', ".qry", function(){
          Shiny.unbindAll();
          $('#active_chart_id').attr('value', $(this).attr('chart-id'));
          //setTimeout(function() {gvisRefresh()}, 400);
          Shiny.bindAll();
    });
    
   //Disable gridster when tinyMCE active  
   $(document).on('click', '.gridster ul li div.shinytinymce', function(e) {
        var gridster = $('.gridster ul').gridster().data('gridster');
        gridster.disable();
        gridster.disable_resize();
        e.stopPropagation();
        $(e.target).closest('div').focus();
    });
    
    //Re-enable gridster when tinyMCE loses focus
    $(document).on('blur', '.gridster ul li div.shinytinymce', function(e) {
      var gridster = $('.gridster ul').gridster().data('gridster');
        gridster.enable();
        gridster.enable_resize();
    });
    
    
     //Go to specified URL
    Shiny.addCustomMessageHandler('shiny.go_to_url', function(message) {
      window.location = '?='+message.url;
    });
    
   /* //Remove all widgets
    Shiny.addCustomMessageHandler('shinyGridster.remove_all_widgets', function(data) {
      Shiny.unbindAll();
      var gridster = $('.gridster ul').gridster().data('gridster');
      $('.gridster ul li').each(function(){$(this).addClass('rmv')});
      gridster.remove_widget($('.rmv'));
      $('.gridster ul').trigger('widget.removed');
      setTimeout(function() {Shiny.bindAll();}, 300)
    
    });*/
    
     $('.gridster ul').gridster().data('gridster').options.serialize_params = function($w, wgd) {
      return { id: $w.attr('id'), col: wgd.col, row: wgd.row, size_x: wgd.size_x, size_y: wgd.size_y };
    };
    
    
    Shiny.addCustomMessageHandler('shinyGridster.add_widget', function(message) {
      //console.log(JSON.stringify(message));
      Shiny.unbindAll();
      var gridster = $('.gridster ul').gridster().data('gridster');
      //console.log(data);
      //console.log(gridster);
       gridster.add_widget(message.html, message.size_x, message.size_y, message.row, message.col);
      
      //setTimeout( function(){
      tinymce.init({
        inline: true, 
        selector:'.shinytinymce',
        plugins: ["advlist autolink lists link image charmap print preview anchor",
      			      "searchreplace visualblocks code fullscreen",
					  	    "insertdatetime media table contextmenu paste"],
		    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
      });
    
    Shiny.bindAll();
    //Shiny.unbindAll();
    //setTimeout(function(){ Shiny.bindAll();}, 100);
    });
       
       
    
    //Input binding
    var shinyGridsterBinding = new Shiny.InputBinding();
$.extend(shinyGridsterBinding, {
  find: function(scope) {
    return $('.gridster ul').gridster();
  },
  getValue: function(el) {
    return  JSON.stringify($(el).data('gridster').serialize());
  },
  setValue: function(el, value) {
    //$(el).on(data('gridster').options.resize.stop
  },
  subscribe: function(el, callback) {  
    $(el).data('gridster').options.resize.stop =  function(e, ui, $widget) {
                 var widget_id = $widget.attr('id');
                 if (widget_id.indexOf('gItemPlot') >= 0){
                  var chart_id = widget_id.substring(2);
                  setTimeout(function() {
                    $('#'+chart_id).data('chart').draw();
                  }, 300);
                 }
                 callback();
         }; 
    $(el).data('gridster').options.draggable.stop =  function(e) {
                 callback();
         };
    $(el).on("widget.removed", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
  //$(el).off(".incrementBinding");
  }
});

Shiny.inputBindings.register(shinyGridsterBinding);
    


});
