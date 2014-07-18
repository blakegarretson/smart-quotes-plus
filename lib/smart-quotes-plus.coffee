module.exports =
  activate: ->
    atom.workspaceView.command "smart-quotes-plus:smartreplace", => @smartreplace()

  smartreplace: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    editor.insertText('Hello, World!')
