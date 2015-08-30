React = require('react')
mui = require('material-ui')
_ = require("underscore")

module.exports = React.createClass

  componentDidMount: ->
    @setState
      country: @props.country
      feed:    @props.feed

  getInitialState: ->
    {
      country: 'us'
      feed: 'Economic'
      zoneItems: [
        { payload: 'us', text: 'USA' },
        { payload: 'uk', text: 'United Kingdom' },
        { payload: 'ru_ru', text: 'Russia' }
      ]
      categoryItems: [
        { payload: 'Economic', text: 'Economic' },
        { payload: 'Entertainment', text: 'Entertainment' },
        { payload: 'Sci/Tech', text: 'Sci/Tech' },
        { payload: 'Sports', text: 'Sports' }
      ]
    }

  __onDialogSubmit: ->
    @props.onChangeSource(
      selectedCoutry: @state.country
      selectedFeed: @state.feed
      selectedSourceType: 'GNews'
    )
    @refs.selectSourceDialog.dismiss()

  open: ->
    @refs.selectSourceDialog.show()

  onCountryChange: (e, selectedIndex, menuItem) ->
    @setState country: menuItem.payload

  onFeedChange: (e, selectedIndex, menuItem) ->
    @setState feed: menuItem.payload

  indexByPayload: (type, payload) ->
    el = _.filter(@state["#{type}Items"], (e) -> e.payload == payload)[0]
    @state["#{type}Items"].indexOf(el)

  payloadByIndex: (type, index) ->
    @state["#{type}Items"][index].payload

  render: ->
    standardActions = [
      { text: 'Cancel' },
      { text: 'Submit', onClick: @__onDialogSubmit }
    ]
    <mui.Dialog title="Select Source" ref="selectSourceDialog" actions={standardActions}>
      <div>

        <label className="dialogLabel">Region:</label>
        <mui.DropDownMenu
          menuItems={@state.zoneItems}
          selectedIndex={@indexByPayload("zone", @state.country)}
          onChange={@onCountryChange}
        />
      </div>
      <div>
        <label className="dialogLabel">Category:</label>
        <mui.DropDownMenu
          menuItems={@state.categoryItems}
          selectedIndex={@indexByPayload("category", @state.feed)}
          onChange={@onFeedChange}
        />
      </div>
    </mui.Dialog>
