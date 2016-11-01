# SwiftHoedown

Swift bindings for [Hoedown](https://github.com/hoedown/hoedown), a Markdown parsing library.

## Installation

The recommended way to include SwiftHoedown in your project is by using [Carthage](https://github.com/Carthage/Carthage). Simply add this line to your `Cartfile`:

    github "njdehoog/swift-hoedown" ~> 0.1

Make sure to link to both the `SwiftHoedown` and the `Hoedown` framework. (The separate `Hoedown` framework is a workaround for [this problem](http://stackoverflow.com/questions/25248598/importing-commoncrypto-in-a-swift-framework)).

## Usage

Import the framework
```swift
import SwiftHoedown
```

### Convert Markdown to HTML

```swift
let markdownString = "# Hello Markdown"
let htmlString = Hoedown.renderHTMLForMarkdown(markdownString)
```

### Specify HTML rendering options

```swift
let markdownString = "# Hello Markdown"
let htmlString = Hoedown.renderHTMLForMarkdown(markdownString, flags: .Escape)
```

### Specify Markdown rendering extensions
> `Hoedown` has optional support for several (unofficial) Markdown   extensions, such as non-strict emphasis, fenced code blocks, tables, auto links, strikethrough and more. 

```swift
let markdownString = "# Hello Markdown"
let htmlString = Hoedown.renderHTMLForMarkdown(markdown, extensions: [.Tables, .FencedCodeBlocks, .StrikeThrough])
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

SwiftHoedown was developed for use in [Spelt](http://spelt.io). If you like this library, please consider supporting development by purchasing the app.

## License

SwiftHoedown is released under the MIT license. See LICENSE for details.

_For the Hoedown license, see the [Hoedown](https://github.com/hoedown/hoedown) repository._

