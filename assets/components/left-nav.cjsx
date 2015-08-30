React = require('react')
mui = require('material-ui')

menuItems = [
  { route: 'select-source', text: 'Select Source' },
  { route: 'custom-rss', text: 'Custom RSS' },
  { route: 'info', text: 'Info' }
]
module.exports = React.createClass

  _onHeaderClick: ->
    @refs.leftNav.close()

  toggle: ->
    @refs.leftNav.toggle()

  _onLeftNavChange: (e, key, payload) ->
    @props.onSelectMenuItem payload.route

  render: ->
    <mui.LeftNav
      ref="leftNav"
      docked={false}
      isInitiallyOpen={false}
      header={null}
      menuItems={menuItems}
      selectedIndex={null}
      onChange={@_onLeftNavChange} />
