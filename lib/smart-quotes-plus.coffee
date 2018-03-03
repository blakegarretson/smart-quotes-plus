# Test case:
#   "'test' test 'test'" and "test" and 'test' 'tis 'twas '90 '90s '90a ... (C) (R) (TM) 1--2 a--b c---d ---
# Yields:
#   “‘test’ test ‘test’” and “test” and ‘test’ ’tis ’twas ’90 ’90s ‘90a … © ® ™ 1–2 a--b c—d ---

module.exports =
    activate: ->
        atom.commands.add 'atom-text-editor', 'smart-quotes-plus:smartreplace', ->
            editor = atom.workspace.getActiveTextEditor()
            smartreplace(editor)
        atom.commands.add 'atom-text-editor', 'smart-quotes-plus:dumbreplace', ->
            editor = atom.workspace.getActiveTextEditor()
            dumbreplace(editor)

smartreplace = (editor) ->
    if editor.getSelectedText()
        text = editor.getSelectedText()
        editor.insertText(doreplacement(text))
    else
        text = editor.getText()
        editor.setText(doreplacement(text))

dumbreplace = (editor) ->
    if editor.getSelectedText()
        text = editor.getSelectedText()
        editor.insertText(dodumbreplacement(text))
    else
        text = editor.getText()
        editor.setText(dodumbreplacement(text))

doreplacement = (text) ->

    left_double_single = "&ldquo;&lsquo;"
    left_single_double = "&lsquo;&ldquo;"
    left_double = "&ldquo;"
    left_single = "&lsquo;"
    right_single_double = "&rsquo;&rdquo;"
    right_double_single = "&rdquo;&rsquo;"
    right_double = "&rdquo;"
    right_single = "&rsquo;"

    # quotes
    text = text.replace /"'(?=\w)/g, ($0) -> left_double_single
    text = text.replace /([\w\.\!\?\%,])'"/g, ($0, $1) -> $1+right_single_double
    text = text.replace /'"(?=\w)/g, ($0) -> left_single_double
    text = text.replace /([\w\.\!\?\%,])"'/g, ($0, $1) -> $1+right_double_single
    text = text.replace /"(?=\w)/g, ($0) -> left_double
    text = text.replace /([\w.!?%,])"/g, ($0, $1) -> $1+right_double
    text = text.replace /([\w.!?%,])'/g, ($0, $1) -> $1+right_single

    # single tick use cases
    text = text.replace /([\s])'(?=(tis\b|twas\b))/g, ($0, $1) -> $1+right_single
    text = text.replace /(\s)'(?=[0-9]+s*\b)/g, ($0, $1) -> $1+right_single
    text = text.replace /([^\w]|^)'(?=\w)/g, ($0, $1, $2) -> $1+left_single

    # misc chars
    text = text.replace /\.\.\./g, "…"
    text = text.replace /\(C\)/g, "©"
    text = text.replace /\(R\)/g, "®"
    text = text.replace /\(TM\)/g, "™"
    text = text.replace /([\w])---(?=[a-z])/g, ($0, $1) -> $1+"—"
    text = text.replace /([0-9])--(?=[0-9])/g, ($0, $1) -> $1+"–"

    return text

dodumbreplacement = (text) ->

    # quotes
    text = text.replace /“|”/g, "\""
    text = text.replace /‘|’/g, "'"

    # misc chars
    text = text.replace /…/g, "..."
    text = text.replace /©/g, "(C)"
    text = text.replace /®/g, "(R)"
    text = text.replace /™/g, "(TM)"
    text = text.replace /—/g, "---"
    text = text.replace /–/g, "--"
    text = text.replace /•/g, "-"

    return text
