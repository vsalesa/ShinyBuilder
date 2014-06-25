# Copyright (c) 2014 Clear Channel Broadcasting, Inc. 
# https://github.com/iheartradio/ShinyBuilder
# Licensed under the MIT License (MIT)

.onLoad <- function(libname, pkgname) {
  require(shiny)
  require(RJSONIO)
  addResourcePath("ShinyBuilder", system.file("www", package = "ShinyBuilder"))
}

.onAttach <- function(libname, pkgname) {
  require(shiny)    
} 