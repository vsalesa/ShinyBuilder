(function(){



 var gvisRefresh = function(){ 
      for (var k in window) {
          if (k.indexOf('chartgItemPlot') === 0) {
            var divId = k.substring(5);
            var availableHeight = $('#' + divId).parent().height();
            var newHeight = availableHeight - 43;
            $('#' + divId + ', #' + divId + ' > div, #' + divId + ' > div > div, #' + divId + ' > div > div > table').css('height', newHeight + 'px');
            opts = JSON.parse($("#"+divId+'_opts').attr('value'));
            window[k].setOptions(opts);
            window[k].draw();
            $('#' + divId + ', #' + divId + ' > div, #' + divId + ' > div > div, #' + divId + ' > div > div > table').css('height', newHeight + 'px');
          }
      }
     };     

//Works:
$(document).on("click", "button.charts-buttonset-action", function(evt) {
  Shiny.unbindAll();
  for (var k in window) {
      if (k.indexOf('chartgItemPlot') === 0) {
        var charttype = window[k].getChartType();
        var chartopts = JSON.stringify(window[k].getOptions());
        var container = window[k].getContainerId();
        
        if($('#' + container + '_type').attr('value') != charttype || 
        $('#' + container + '_opts').attr('value') != chartopts){
          $('#' + container + '_type').attr('value', charttype);
          $('#' + container + '_opts').attr('value', chartopts);
        }      
      }
  }
  Shiny.bindAll();
  setTimeout(function(){gvisRefresh();}, 300);
})

  
  

/*var shinyGvisInputBinding = new Shiny.InputBinding();
$.extend(shinyGvisInputBinding, {
  find: function(scope) {
    return $(scope).find("[id^=ggItemPlot]");
  },
  getValue: function(el) {
    console.log('chart'+$(el).attr('id') +': '+ window['chart'+$(el).attr('id')].getChartType());
    return window['chart'+$(el).attr('id')].getChartType();
  },
  setValue: function(el, value) {
    //TODO
  },
  subscribe: function(el, callback) {  
// $(el).on("change.shinyGvisInputBinding", function(e) {
  //    callback();
    });
  },
  unsubscribe: function(el) {
  //$(el).off(".incrementBinding");
  }
});
Shiny.inputBindings.register(shinyGvisInputBinding);*/


})();