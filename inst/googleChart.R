# Copyright (c) 2014 Clear Channel Broadcasting, Inc. 
# https://github.com/iheartradio/ShinyBuilder
# Licensed under the MIT License (MIT)

#require(shiny)

#Render Google Chart as Shiny output
renderGoogleChart <- function(expr, env=parent.frame(), quoted = FALSE){
  func <- exprToFunction(expr, env, quoted)
  function(){ 
    val <- func()
    val
  }
}

#Generate Google Chart Object
googleChartObject <- function(data, type, options){
  formatted_data  <- googleVis:::gvisFormat(data)
  dataLabels      <- toJSON(formatted_data$data.type)
  dataJSON        <- formatted_data$json
  return(list(dataLabels = dataLabels, dataJSON = dataJSON, chartType = type, options = options))
}

#Shiny chart output element
googleChartOutput <- function(chartid){tagList(
  HTML(paste0('<div id = "', chartid, '" class="shinyGoogleChart" style = "width: 100%; height:100%; overflow-y: hidden; overflow-x: hidden"></div>'))
)}

#Shiny chart editor output element
googleChartEditor <- function(id, target, type = 'Table', options = '{}', label = 'Edit Chart'){tagList(
  #singleton(HTML('<script type="text/javascript" src="//www.google.com/jsapi"></script>')),
  #singleton(includeScript(paste0(getwd(),'/www/googleChart_init.js'))),
  
  #ChartEditor Button  
  HTML(paste0("<div class = 'chartEditor btn' style='display:inline;' onclick='openChartEditor(\"", target, 
     "\");' data-target = '", target, "' options = '", options,
     "' chartType = '", type,"' id = '", id,"'>",label,"</div> ")),

  singleton(tags$script(
       "var openChartEditor = function(chartId){
        var wrapper = $('#'+chartId).data('chart');
        var editor = new google.visualization.ChartEditor();
        google.visualization.events.addListener(editor, 'ok',
             function() {
              var new_wrapper = editor.getChartWrapper();
              new_wrapper.draw($('#'+chartId));
              $('#'+chartId).data('chart', new_wrapper);
              $('#'+chartId+'_editor').attr('chartType', new_wrapper.getChartType());
              $('#'+chartId+'_editor').attr('options', JSON.stringify(new_wrapper.getOptions()));
              $('#'+chartId+'_editor').trigger('change.chartEditorInputBinding');
            }
        );
        editor.openDialog(wrapper);
        };"))
            
)}