React = require('react')
jquery = require('jquery')

require "./material.less"
require "./styles.sass"

Fluxxor = require "fluxxor"
actions = {}
stores  = {}
flux = new Fluxxor.Flux(stores, actions)

document.addEventListener "DOMContentLoaded", (event) ->
  React.render React.createFactory(require("./components/page"))(flux: flux), document.getElementById("main-container")
