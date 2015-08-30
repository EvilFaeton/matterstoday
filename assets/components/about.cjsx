React = require('react')
mui = require('material-ui')

module.exports = React.createClass

  open: ->
    @refs.aboutDialog.show()

  render: ->
    standardActions = [
      { text: 'Ok' },
    ]
    <mui.Dialog title="About Matters Today" ref="aboutDialog" className="about-dialog" actions={standardActions}>
      <p>Matters Today - fun project about important news over world</p>
      <p>Created by <a href="http://twitter.com/evilfaeton">@evilfaeton</a> and <a href="http://twitter.com/KathieKiwi">@KathieKiwi</a>. Sponsored by <a href="http://resumup.com">ResumUP</a>.</p>
    </mui.Dialog>
