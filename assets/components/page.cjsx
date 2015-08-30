React = require('react')
injectTapEventPlugin = require("react-tap-event-plugin")
injectTapEventPlugin()
mui = require('material-ui')
AppCanvas = mui.AppCanvas
AppBar = mui.AppBar
IconButton = mui.IconButton
Navigation = require("./left-nav")
SelectSource = require("./select-source")
About = require("./about")
Bubble = require("./bubble")
CustomRss = require("./custom-rss")
FeedReader = require("./services/feed_reader")
_ = require("underscore")

module.exports = React.createClass
  getInitialState: ->
    info_icon: "action-info"
    selectedSourceType: "GNews"
    selectedCoutry: "us"
    selectedFeed: "Economic"
    selectedRss: "https://news.ycombinator.com/rss"
    rsslists: []

  componentDidUpdate: (prevProps, prevState) ->
    checkered = _.every(_.map(["selectedSourceType", "selectedCoutry", "selectedFeed", "selectedRss"], (el) =>
      @state[el] == prevState[el]
    ))
    unless checkered
      do @rssUpdate

  componentDidMount: ->
    do @rssUpdate

  __onMenuIconButtonTouchTap: ->
    @refs.leftNav.toggle()

  __hoverInfo: ->
    @setState info_icon: "action-info-outline"

  __unhoverInfo: ->
    @setState info_icon: "action-info"

  __selectMenuItem: (item) ->
    if item == "select-source"
      @refs.selectSourceDialog.open()
    if item == "custom-rss"
      @refs.customRssDialog.open()
    if item == "info"
      @refs.aboutDialog.open()

  __showInfo: ->
    @refs.aboutDialog.open()

  __googleNewsRss: ->
    topics =
      Economic: "b"
      Entertainment: "e"
      "Sci/Tech": "t"
      Sports: "s"
    "https://news.google.com/?output=rss&ned=#{@state.selectedCoutry}&authuser=0&topic=#{topics[@state.selectedFeed]}"

  rssUpdate: ->
    feed = if @state.selectedSourceType == "GNews"
      @__googleNewsRss()
    else
      @state.selectedRss
    FeedReader(feed).then( (data) =>
      if (data.responseData.feed && data.responseData.feed.entries)
        items = _.map data.responseData.feed.entries, (e) ->
          {
            title: e.title
            link: e.link
          }
        @setState rsslists: items
      ).catch =>
        @refs["rsserror"].show()

  closeError: ->
    @refs["rsserror"].dismiss()

  onChangeSource: (data) ->
    @setState data

  rssName: ->
    if @state.selectedSourceType == "GNews"
      countries =
        us: 'USA'
        uk: 'United Kingdom'
        ru_ru: 'Russia'
      "Google News: #{countries[@state.selectedCoutry]} #{@state.selectedFeed}"
    else
      matches = @state.selectedRss.match(/^https?\:\/\/(?!(?:www\.)?(?:youtube\.com|youtu\.be))([^\/:?#]+)(?:[\/:?#]|$)/i)
      "Custom RSS from #{matches && matches[1]}"

  render: ->
    <AppCanvas predefinedLayout={1}>
      <AppBar
        className="mui-dark-theme app-bar-matters"
        onMenuIconButtonTouchTap={@__onMenuIconButtonTouchTap}
        title="MatterToday"
        zDepth={0}>
        <div className="bar-about-rss">
          <div className="bar-about-rss-desc">
            {@rssName()}
          </div>
          <mui.FlatButton label="Change" primary={true} onClick={@__onMenuIconButtonTouchTap}/>
        </div>
        <div className="bar-info">
          <mui.FlatButton label="About" onClick={@__showInfo}/>
        </div>
      </AppBar>

      <SelectSource ref="selectSourceDialog"
        country={@state.selectedCoutry}
        feed={@state.selectedFeed}
        onChangeSource={@onChangeSource}
      />
      <About ref="aboutDialog" />
      <CustomRss
        ref="customRssDialog"
        rss={@state.selectedRss}
        onChangeSource={@onChangeSource}
      />
      <Navigation
        ref="leftNav"
        onSelectMenuItem={@__selectMenuItem}
      />
      <mui.Snackbar
        ref="rsserror"
        message="Error occuried due to parsing rss feed"
        action="close"
        onActionTouchTap={@closeError}
      />
      <Bubble list={@state.rsslists}/>
    </AppCanvas>
