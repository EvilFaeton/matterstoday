React = require('react')
mui = require('material-ui')

module.exports = React.createClass

  componentDidMount: ->
    @refs["rssField"].setValue @props.rss

  __onDialogSubmit: ->
    @props.onChangeSource(
      selectedRss: @refs["rssField"].getValue()
      selectedSourceType: 'CustomRSS'
    )
    @refs.customRssDialog.dismiss()

  open: ->
    @refs.customRssDialog.show()

  render: ->
    standardActions = [
      { text: 'Cancel' },
      { text: 'Submit', onClick: @__onDialogSubmit }
    ]
    <mui.Dialog title="Custom RSS" ref="customRssDialog" actions={standardActions}>
      <mui.TextField
        ref="rssField"
        hintText="RSS URL"
        floatingLabelText="RSS URL" />
    </mui.Dialog>
