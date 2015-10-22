//
//  Markdown.swift
//  MarkPub
//
//  Created by Niels de Hoog on 17/04/15.
//  Copyright (c) 2015 Invisible Pixel. All rights reserved.
//

import Foundation
import Hoedown

public class Hoedown {
    public class func renderHTMLForMarkdown(string: String, flags: HoedownHTMLFlags = .None, extensions: HoedownExtensions = .None) -> String? {
        let renderer = HoedownHTMLRenderer(flags: flags)
        let document = HoedownDocument(renderer: renderer, extensions: extensions)
        return document.renderMarkdown(string)
    }
}

public protocol HoedownRenderer {
    var internalRenderer: UnsafeMutablePointer<hoedown_renderer> { get }
}

public class HoedownHTMLRenderer: HoedownRenderer  {
    public let internalRenderer: UnsafeMutablePointer<hoedown_renderer>
    
    public init(flags: HoedownHTMLFlags = .None, nestingLevel: Int = 0) {
        self.internalRenderer = hoedown_html_renderer_new(hoedown_html_flags(flags.rawValue), CInt(nestingLevel))
    }
    
    deinit {
        hoedown_html_renderer_free(self.internalRenderer)
    }
}

public class HoedownDocument {
    let internalDocument: COpaquePointer
    
    public init(renderer: HoedownRenderer, extensions: HoedownExtensions = .None, maxNesting: UInt = 16) {
        self.internalDocument = hoedown_document_new(renderer.internalRenderer, hoedown_extensions(extensions.rawValue), Int(maxNesting))
    }
    
    public func renderMarkdown(string: String, bufferSize: UInt = 16) -> String? {
        let buffer = hoedown_buffer_new(Int(bufferSize))
        hoedown_document_render(self.internalDocument, buffer, string, string.utf8.count);
        
        let htmlOutput = hoedown_buffer_cstr(buffer)
        let output = String.fromCString(htmlOutput)
        
        hoedown_buffer_free(buffer)
        
        return output
    }
    
    deinit {
        hoedown_document_free(self.internalDocument)
    }
}

public struct HoedownExtensions : OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    init(_ value: hoedown_extensions) { self.rawValue = value.rawValue }
    
    public static let None = HoedownExtensions(rawValue: 0)
    
    // Block-level extensions
    public static let Tables = HoedownExtensions(HOEDOWN_EXT_TABLES)
    public static let FencedCodeBlocks = HoedownExtensions(HOEDOWN_EXT_FENCED_CODE)
    public static let FootNotes = HoedownExtensions(HOEDOWN_EXT_FOOTNOTES)
    
    // Span-level extensions
    public static let AutoLinkURLs = HoedownExtensions(HOEDOWN_EXT_AUTOLINK)
    public static let StrikeThrough = HoedownExtensions(HOEDOWN_EXT_STRIKETHROUGH)
    public static let Underline = HoedownExtensions(HOEDOWN_EXT_UNDERLINE)
    public static let Highlight = HoedownExtensions(HOEDOWN_EXT_HIGHLIGHT)
    public static let Quote = HoedownExtensions(HOEDOWN_EXT_QUOTE)
    public static let Superscript = HoedownExtensions(HOEDOWN_EXT_SUPERSCRIPT)
    public static let Math = HoedownExtensions(HOEDOWN_EXT_MATH)
    
    // Other flags
    public static let NoIntraEmphasis = HoedownExtensions(HOEDOWN_EXT_NO_INTRA_EMPHASIS)
    public static let SpaceHeaders = HoedownExtensions(HOEDOWN_EXT_SPACE_HEADERS)
    public static let MathExplicit = HoedownExtensions(HOEDOWN_EXT_MATH_EXPLICIT)
    
    // Negative flags
    public static let DisableIndentedCode = HoedownExtensions(HOEDOWN_EXT_DISABLE_INDENTED_CODE)
}

public struct HoedownHTMLFlags : OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    init(_ value: hoedown_html_flags) { self.rawValue = value.rawValue }
    
    public static let None = HoedownHTMLFlags(rawValue: 0)
    public static let SkipHTML = HoedownHTMLFlags(HOEDOWN_HTML_SKIP_HTML)
    public static let Escape = HoedownHTMLFlags(HOEDOWN_HTML_ESCAPE)
    public static let HardWrap = HoedownHTMLFlags(HOEDOWN_HTML_HARD_WRAP)
    public static let UseXHTML = HoedownHTMLFlags(HOEDOWN_HTML_USE_XHTML)
}
