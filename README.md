# smart-quotes-plus package

This package replaces straight quotes with smart unicode curly quotes, as well as a few other handy replacements.  Straight quotes like " and ' are converted to curly quotes (including apostrophes in contractions) to turn `"this"` and `'this'` into `“this”` and `‘this’`.  The default key-binding is `CTRL-ALT-'`.  You clearly would only want to run this on prose.  If it screws something up, just hit `CTRL-Z` to undo the replacement.

The goal here is **NOT** to create yet another markup language.  This is just a convenience function that lets you write the way most people type, that is, using the straight quotes on your keyboard without any special markup to signify opening or closing quotes.  You can use this in conjunction with a lightweight markup language like Asciidoc, or even a full markup language like LaTeX. The problem with most markup is that you still need to use fancy notation to produce correct curly quotes.  Smart Quotes Plus lets you type with easy-to-use, normal straight quotes (`"` and `'`), and then convert it before running it through Asciidoc, Markdown, etc.  It’s all about minimizing the focus on markup during typing, and focusing on the writing itself, which is the spirit of most markup languages anyway.

#### Quote replacement:

Input Markup|Character Name|Output Unicode Char|Notes
:-------:|:-------:|:-------:|-------
`"`|double quote|`“` or `”`|figures out which to use based on context
`'`|single quote|`‘` or `’`|figures out which to use based on context
 
#### Other replacements:

Input Markup|Character Name|Output Unicode Char|Notes
:-------:|:-------:|:-------:|-------
`'`|apostrophe|`’`|for contractions, only invoked when surrounded by letters
`--`|en dash|`–`| only when \-\- are surrounded by numbers
`---`|em dash|`—`|only when \-\-\- are surrounded by letters
`(C)`| copyright|`©`| 
`(R)`|registered|`®`|
`(TM)`|trademark|`™`|
`...`|ellipsis|`…`| 

There are a few other special apostrophe cases like `’tis` or `’70s` where the closing quote is the appropriate character even though it is at the beginning of a word, so an exception is made for those situations. 

#### Example

This:

`"'This' is 'a' 'test'". "This" isn't. (R) (C) (TM) 1--2 Em---dash 'tis 'twas, in the '70s`

yields this:

`“‘This’ is ‘a’ ‘test’”. “This” isn’t. ® © ™ 1–2 Em—dash ’tis ’twas, in the ’70s`
