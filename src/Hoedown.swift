//
//  Markdown.swift
//  MarkPub
//
//  Created by Niels de Hoog on 17/04/15.
//  Copyright (c) 2015 Invisible Pixel. All rights reserved.
//

import Foundation
import Hoedown

class Hoedown {
    class func renderHTMLForMarkdown(string: String, flags: HoedownHTMLFlags = .None, extensions: HoedownExtensions = .None) -> String? {
        let renderer = HoedownHTMLRenderer(flags: flags)
        let document = HoedownDocument(renderer: renderer, extensions: extensions)
        return document.renderMarkdown(string)
    }
}

protocol HoedownRenderer {
    var internalRenderer: UnsafeMutablePointer<hoedown_renderer> { get }
}

class HoedownHTMLRenderer: HoedownRenderer  {
    let internalRenderer: UnsafeMutablePointer<hoedown_renderer>
    
    init(flags: HoedownHTMLFlags = .None, nestingLevel: Int = 0) {
        self.internalRenderer = hoedown_html_renderer_new(hoedown_html_flags(UInt32(flags.rawValue)), CInt(nestingLevel))
    }
    
    deinit {
        hoedown_html_renderer_free(self.internalRenderer)
    }
}

class HoedownDocument {
    let internalDocument: COpaquePointer
    
    init(renderer: HoedownRenderer, extensions: HoedownExtensions = .None, maxNesting: UInt = 16) {
        self.internalDocument = hoedown_document_new(renderer.internalRenderer, hoedown_extensions(UInt32(extensions.rawValue)), Int(maxNesting))
    }
    
    func renderMarkdown(string: String, bufferSize: UInt = 16) -> String? {
        let buffer = hoedown_buffer_new(Int(bufferSize))
        hoedown_document_render(self.internalDocument, buffer, string, count(string));
        
        let htmlOutput = hoedown_buffer_cstr(buffer)
        let output = String.fromCString(htmlOutput)
        
        hoedown_buffer_free(buffer)
        
        return output
    }
    
    deinit {
        hoedown_document_free(self.internalDocument)
    }
}

struct HoedownExtensions : RawOptionSetType {
    var rawValue: UInt = 0
    
    init(nilLiteral: ()) { self.rawValue = 0 }
    init(_ value: UInt = 0) { self.rawValue = value }
    init(rawValue: UInt) { self.rawValue = rawValue }
    
    static var allZeros: HoedownExtensions { return self(0) }
    
    static var None: HoedownExtensions      { return self(0) }
    
    ///-------------------------------------------------
    /// @name block-level extensions
    ///-------------------------------------------------
    
    static var Tables: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_TABLES.value)) }
    static var FencedCodeBlocks: HoedownExtensions    { return self(UInt(HOEDOWN_EXT_FENCED_CODE.value)) }
    static var FootNotes: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_FOOTNOTES.value)) }
    
    ///-------------------------------------------------
    /// @name span-level extensions
    ///-------------------------------------------------
    
    static var AutoLinkURLs: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_AUTOLINK.value)) }
    static var StrikeThrough: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_STRIKETHROUGH.value)) }
    static var Underline: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_UNDERLINE.value)) }
    static var Highlight: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_HIGHLIGHT.value)) }
    static var Quote: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_QUOTE.value)) }
    static var Superscript: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_SUPERSCRIPT.value)) }
    static var Math: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_MATH.value)) }
    
    ///-------------------------------------------------
    /// @name Other flags
    ///-------------------------------------------------
    
    static var NoIntraEmphasis: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_NO_INTRA_EMPHASIS.value)) }
    static var SpaceHeaders: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_SPACE_HEADERS.value)) }
    static var MathExplicit: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_MATH_EXPLICIT.value)) }
    
    ///-------------------------------------------------
    /// @name Negative flags
    ///-------------------------------------------------
    
    static var DisableIndentedCode: HoedownExtensions  { return self(UInt(HOEDOWN_EXT_DISABLE_INDENTED_CODE.value)) }
}

struct HoedownHTMLFlags : RawOptionSetType {
    var rawValue: UInt = 0
    
    init(nilLiteral: ()) { self.rawValue = 0 }
    init(_ value: UInt = 0) { self.rawValue = value }
    init(rawValue: UInt) { self.rawValue = rawValue }
    
    static var allZeros: HoedownHTMLFlags { return self(0) }
    
    static var None: HoedownHTMLFlags      { return self(0) }
    static var SkipHTML: HoedownHTMLFlags  { return self(UInt(HOEDOWN_HTML_SKIP_HTML.value)) }
    static var Escape: HoedownHTMLFlags    { return self(UInt(HOEDOWN_HTML_ESCAPE.value)) }
    static var HardWrap: HoedownHTMLFlags  { return self(UInt(HOEDOWN_HTML_HARD_WRAP.value)) }
    static var UseXHTML: HoedownHTMLFlags  { return self(UInt(HOEDOWN_HTML_USE_XHTML.value)) }
}
