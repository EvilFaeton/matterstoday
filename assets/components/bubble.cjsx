React = require('react')
mui = require('material-ui')
window.$ = require("jquery")
velocity = require("velocity-animate")
_ = require("underscore")
PointerPosition = require("./services/pointer_position")

module.exports = React.createClass

  componentDidMount: ->
    do @renew

  getInitialState: ->
    {
      currentIndex: -1
      timeout: null
      bubbleHided: false
    }

  componentDidUpdate: (prevProps, prevState) ->
    if prevState.currentIndex != @state.currentIndex
      if @state.bubbleHided
        velocity.animate($(@refs.bubble.getDOMNode()), "fadeIn", duration: 500).then =>
          @setState timeout: _.delay((=> @stepTo(@state.currentIndex+1)), 5000), bubbleHided: false
      else
        @setState timeout: _.delay((=> @stepTo(@state.currentIndex+1)), 5000), bubbleHided: false

  renew: ->
    @stepTo(0)

  stepTo: (index) ->
    index = 0 unless @props.list[index]
    if @refs.bubble
      velocity.animate($(@refs.bubble.getDOMNode()), "fadeOut", duration: 500).then =>
        @setState currentIndex: index, bubbleHided: true
    else
      @setState currentIndex: index


  render: ->
    if @props.list.length > 0 && @state.currentIndex != -1
      <div className="bubble" ref="bubble" style={PointerPosition()}>
        <mui.Paper zDepth={5} rounded={true}>
          <div className="bubble-inside">
            {@props.list[@state.currentIndex].title}
          </div>
        </mui.Paper>
      </div>
    else
      null
