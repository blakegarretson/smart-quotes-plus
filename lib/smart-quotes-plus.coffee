# Test case:
#   "'test' test 'test'" and "test" and 'test' 'tis 'twas '90 '90s '90a ... (C) (R) (TM) 1--2 a--b c---d ---
# Yields:
#   “‘test’ test ‘test’” and “test” and ‘test’ ’tis ’twas ’90 ’90s ‘90a … © ® ™ 1–2 a--b c—d ---

module.exports =
    activate: ->
        atom.commands.add 'atom-text-editor', 'smart-quotes-plus:smartreplace', ->
            editor = atom.workspace.getActiveTextEditor()
            smartreplace(editor)

smartreplace = (editor) ->
    if editor.getSelectedText()
        text = editor.getSelectedText()
        editor.insertText(doreplacement(text))
    else
        text = editor.getText()
        editor.setText(doreplacement(text))

doreplacement = (text) ->

    open_double_single = "“‘"
    open_single_double = "‘“"
    open_double = "“"
    open_single = "‘"
    close_single_double = "’”"
    close_double_single = "”’"
    close_double = "”"
    close_single = "’"

    # quotes
    text = text.replace /"'(?=\w)/g, ($0) -> open_double_single
    text = text.replace /([\w\.\!\?\%,])'"/g, ($0, $1) -> $1+close_single_double
    text = text.replace /'"(?=\w)/g, ($0) -> open_single_double
    text = text.replace /([\w\.\!\?\%,])"'/g, ($0, $1) -> $1+close_double_single
    text = text.replace /"(?=\w)/g, ($0) -> open_double
    text = text.replace /([\w.!?%,])"/g, ($0, $1) -> $1+close_double
    text = text.replace /([\w.!?%,])'/g, ($0, $1) -> $1+close_single

    # single tick use cases
    text = text.replace /([\s])'(?=(tis\b|twas\b))/g, ($0, $1) -> $1+close_single
    text = text.replace /(\s)'(?=[0-9]+s*\b)/g, ($0, $1) -> $1+close_single
    text = text.replace /([^\w]|^)'(?=\w)/g, ($0, $1, $2) -> $1+open_single

    # misc chars
    text = text.replace /\.\.\./g, "…"
    text = text.replace /\(C\)/g, "©"
    text = text.replace /\(R\)/g, "®"
    text = text.replace /\(TM\)/g, "™"
    text = text.replace /([\w])---(?=[a-z])/g, ($0, $1) -> $1+"—"
    text = text.replace /([0-9])--(?=[0-9])/g, ($0, $1) -> $1+"–"

    return text
