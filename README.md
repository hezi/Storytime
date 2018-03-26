# Storytime

Storytime is a framework to parse and render Interface Builder Storyboard files.
Support for more componenets and output formats soon.

By [Jorge Cohen](http://twitter.com/jorgewritescode), See the LICENSE file for license info (it's the MIT license).
If you find this useful please consider [buying me a beer](http://paypal.me/jorgecohen) :) 

## Motivation
If you've ever developed for iOS/macOS you've probably tried to QuickLook into a storyboard file only to be disappointed.
I've created Storytime as a why to visually display storyboards outside of Interface Builder, This could be QuickLook, Git Client, etc.

## Internals
Storyboards a actually very simple XML files so parsing them is pretty stright forward.
Initially I tried using XSLT to transform the Storyboard into HTML but ran into some issue.

This version parses the storyboard into classes conforming to a protocol `STTElement` which defines the `-htmlRepesentation` method.
Using the Ratchet CSS framework and the html produced by the various elements you get a pretty (although not 100%) accurate visual representation of the storyboard.

## Known Issues
There are a lot of them!

1. Views (`-htmlRepresentation`) are coupled with the models (`STTElement`) which is due to me being in a hurry to get this working
2. Various rendering issues
3. CSS coupled with HTML template
4. etc.

Feel free to create issues when you find them.

## Questions

### Why Objective-C?
It's what I like using, also, it's required if you want to create a QuickLook generator.

### Why is the code like this?
Well, this started out as a quick hack and I got excited when things first started showing up so I wanted to release it as fast as possible :)

## Acknowledgement

* [Ratchet](https://github.com/twbs/ratchet)
* [TouchXML](https://github.com/TouchCode/TouchXML)