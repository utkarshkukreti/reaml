require "erb"

task :default do
  # https://html.spec.whatwg.org/multipage/indices.html#elements-3
  html_elements = %w[
    a abbr address area article aside audio b base bdi bdo blockquote body br
    button canvas caption cite code col colgroup data_ datalist dd del details
    dfn dialog div dl dt em embed fieldset figcaption figure footer form h1 h2
    h3 h4 h5 h6 head header hgroup hr html i iframe img input ins kbd label
    legend li link main map mark menu meta meter nav noscript object_ ol optgroup
    option output p param picture pre progress q rp rt ruby s samp script
    section select slot small source span strong style_ sub summary sup table
    tbody td template textarea tfoot th thead time title tr track u ul var video
    wbr
  ]

  # https://html.spec.whatwg.org/multipage/indices.html#attributes-3
  html_attributes = %w[
    accept acceptCharset action allowFullScreen:b allowTransparency:b alt as_
    async:b autoComplete autoFocus:b autoPlay:b capture cellPadding cellSpacing
    charSet challenge checked:b cite_ classID cols:i colSpan:i content
    controls:b coords crossOrigin data__ dateTime default:b defer:b disabled:b
    download encType form_ formAction formEncType formMethod formNoValidate:b
    formTarget frameBorder headers height high:f href hrefLang htmlFor httpEquiv
    integrity keyParams keyType kind label_ list_ loop:b low:f manifest
    marginHeight:f marginWidth:f max maxLength:i media mediaGroup method_ min
    minLength:i multiple:b muted:b name nonce noValidate:b open_:b optimum:f
    pattern placeholder playsInline:b poster preload readOnly:b rel required:b
    reversed:b rows:i rowSpan:i sandbox scope scoped:b scrolling seamless:b
    selected:b shape size:i sizes span_:i src srcDoc srcLang srcSet start:i step
    summary_ target type_ useMap value width wmode wrap
    defaultChecked:b defaultValue
    accessKey className contentEditable:b contextMenu dir draggable:b hidden:b
    id lang placeholder_ slot_ spellCheck:b tabIndex:i title_ translate
    role
    about datatype inlist prefix property_ resource typeof vocab
    autoCapitalize autoCorrect autoSave color itemProp itemScope:b itemType
    itemID itemRef results:i security unselectable
    inputMode
    is
  ].sort.map do |string|
    name, type = string.split(":")
    type = case type
      when nil then "string"
      when "b" then "bool"
      when "i" then "int"
      when "f" then "float"
      else raise "?"
      end
    [name, type]
  end

  svg_elements = %w[
    a animate animateColor animateMotion animateTransform circle clipPath
    color-profile cursor defs desc discard ellipse feBlend feColorMatrix
    feComponentTransfer feComposite feConvolveMatrix feDiffuseLighting
    feDisplacementMap feDistantLight feDropShadow feFlood feFuncA feFuncB
    feFuncG feFuncR feGaussianBlur feImage feMerge feMergeNode feMorphology
    feOffset fePointLight feSpecularLighting feSpotLight feTile feTurbulence
    filter font font-face font-face-format font-face-name font-face-src
    font-face-uri foreignObject g glyph glyphRef hatch hatchpath hkern image
    line linearGradient marker mask mesh meshgradient meshpatch meshrow metadata
    missing-glyph mpath path pattern polygon polyline radialGradient rect script
    set solidcolor stop style_ svg switch symbol text textPath title tref tspan
    unknown use view vkern
  ]

  svg_attributes = %w[
    color height id lang max media method_ min name target type_ width role
    tabIndex:i crossOrigin
    accentHeight accumulate additive alignmentBaseline allowReorder alphabetic
    amplitude arabicForm ascent attributeName attributeType autoReverse:b
    azimuth baseFrequency baselineShift baseProfile bbox begin_ bias by calcMode
    capHeight clip clipPath_ clipPathUnits clipRule colorInterpolation
    colorInterpolationFilters colorProfile_ colorRendering contentScriptType
    contentStyleType cursor_ cx cy d decelerate descent diffuseConstant
    direction display divisor dominantBaseline dur dx dy edgeMode elevation
    enableBackground end_ exponent externalResourcesRequired:b fill fillOpacity
    fillRule filter_ filterRes filterUnits floodColor floodOpacity focusable
    fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant
    fontWeight format from fx fy g1 g2 glyphName glyphOrientationHorizontal
    glyphOrientationVertical glyphRef_ gradientTransform gradientUnits hanging
    horizAdvX horizOriginX href ideographic imageRendering in2 in_ intercept k1
    k2 k3 k4 k kernelMatrix kernelUnitLength kerning keyPoints keySplines
    keyTimes lengthAdjust letterSpacing lightingColor limitingConeAngle local
    markerEnd markerHeight markerMid markerStart markerUnits markerWidth mask_
    maskContentUnits maskUnits mathematical mode numOctaves offset opacity
    operator order orient orientation origin overflow overlinePosition
    overlineThickness paintOrder panose1 pathLength patternContentUnits
    patternTransform patternUnits pointerEvents points pointsAtX pointsAtY
    pointsAtZ preserveAlpha:b preserveAspectRatio primitiveUnits r radius refX
    refY renderingIntent repeatCount repeatDur requiredExtensions
    requiredFeatures restart result rotate rx ry scale seed shapeRendering slope
    spacing specularConstant specularExponent speed spreadMethod startOffset
    stdDeviation stemh stemv stitchTiles stopColor stopOpacity
    strikethroughPosition strikethroughThickness string stroke strokeDasharray
    strokeDashoffset strokeLinecap strokeLinejoin strokeMiterlimit strokeOpacity
    strokeWidth surfaceScale systemLanguage tableValues targetX targetY
    textAnchor textDecoration textLength textRendering to_ transform u1 u2
    underlinePosition underlineThickness unicode unicodeBidi unicodeRange
    unitsPerEm vAlphabetic values vectorEffect version vertAdvY vertOriginX
    vertOriginY vHanging vIdeographic viewBox viewTarget visibility
    vMathematical widths wordSpacing writingMode x1 x2 x xChannelSelector
    xHeight xlinkActuate xlinkArcrole xlinkHref xlinkRole xlinkShow xlinkTitle
    xlinkType xmlBase xmlLang xmlns xmlnsXlink xmlSpace y1 y2 y yChannelSelector
    z zoomAndPan
  ].map do |string|
    name, type = string.split(":")
    type = case type
      when nil then "string"
      when "b" then "bool"
      when "i" then "int"
      when "f" then "float"
      else raise "?"
      end
    [name, type]
  end.sort

  # https://github.com/DefinitelyTyped/DefinitelyTyped/blob/28e745f92dfa682e673a012d23ed0b4950d27d27/types/react/index.d.ts#L1137
  events = %w[
    onAnimationEnd:Animation
    onAnimationIteration:Animation
    onAnimationStart:Animation
    onCopy:Clipboard
    onCut:Clipboard
    onPaste:Clipboard
    onCompositionEnd:Composition
    onCompositionStart:Composition
    onCompositionUpdate:Composition
    onDrag:Drag
    onDragEnd:Drag
    onDragEnter:Drag
    onDragExit:Drag
    onDragLeave:Drag
    onDragOver:Drag
    onDragStart:Drag
    onDrop:Drag
    onAbort:Event
    onCanPlay:Event
    onCanPlayThrough:Event
    onChange:Event
    onDurationChange:Event
    onEmptied:Event
    onEncrypted:Event
    onEnded:Event
    onError:Event
    onInput:Event
    onInvalid:Event
    onLoad:Event
    onLoadStart:Event
    onLoadedData:Event
    onLoadedMetadata:Event
    onPause:Event
    onPlay:Event
    onPlaying:Event
    onProgress:Event
    onRateChange:Event
    onReset:Event
    onSearch:Event
    onSeeked:Event
    onSeeking:Event
    onSelect:Event
    onStalled:Event
    onSubmit:Event
    onSuspend:Event
    onTimeUpdate:Event
    onVolumeChange:Event
    onWaiting:Event
    onBlur:Focus
    onFocus:Focus
    onKeyDown:Keyboard
    onKeyPress:Keyboard
    onKeyUp:Keyboard
    onClick:Mouse
    onContextMenu:Mouse
    onDoubleClick:Mouse
    onMouseDown:Mouse
    onMouseEnter:Mouse
    onMouseLeave:Mouse
    onMouseMove:Mouse
    onMouseOut:Mouse
    onMouseOver:Mouse
    onMouseUp:Mouse
    onPointerCancel:Pointer
    onPointerDown:Pointer
    onPointerEnter:Pointer
    onPointerLeave:Pointer
    onPointerMove:Pointer
    onPointerOut:Pointer
    onPointerOver:Pointer
    onPointerUp:Pointer
    onTouchCancel:Touch
    onTouchEnd:Touch
    onTouchMove:Touch
    onTouchStart:Touch
    onTransitionEnd:Transition
    onScroll:Ui
    onWheel:Wheel
  ].map do |pair|
    pair.strip.split(":")
  end

  # curl https://www.w3.org/Style/CSS/all-properties.en.json | jq -r '.[].property' | sort | uniq | xargs
  css_properties = %w[
    align-content align-items align-self alignment-baseline all animation
    animation-delay animation-direction animation-duration
    animation-fill-mode animation-iteration-count animation-name
    animation-play-state animation-timing-function appearance azimuth
    background background-attachment background-blend-mode background-clip
    background-color background-image background-origin background-position
    background-repeat background-size baseline-shift baseline-source
    block-ellipsis block-overflow block-size block-step block-step-align
    block-step-insert block-step-round block-step-size bookmark-label
    bookmark-level bookmark-state border border-block border-block-color
    border-block-end border-block-end-color border-block-end-style
    border-block-end-width border-block-start border-block-start-color
    border-block-start-style border-block-start-width border-block-style
    border-block-width border-bottom border-bottom-color
    border-bottom-left-radius border-bottom-right-radius border-bottom-style
    border-bottom-width border-boundary border-collapse border-color
    border-end-end-radius border-end-start-radius border-image
    border-image-outset border-image-repeat border-image-slice
    border-image-source border-image-width border-inline border-inline-color
    border-inline-end border-inline-end-color border-inline-end-style
    border-inline-end-width border-inline-start border-inline-start-color
    border-inline-start-style border-inline-start-width border-inline-style
    border-inline-width border-left border-left-color border-left-style
    border-left-width border-radius border-right border-right-color
    border-right-style border-right-width border-spacing
    border-start-end-radius border-start-start-radius border-style border-top
    border-top-color border-top-left-radius border-top-right-radius
    border-top-style border-top-width border-width bottom
    box-decoration-break box-shadow box-sizing box-snap break-after
    break-before break-inside caption-side caret caret-color caret-shape
    chains clear clip clip-path clip-rule color color-adjust
    color-interpolation-filters color-scheme column-count column-fill
    column-gap column-rule column-rule-color column-rule-style
    column-rule-width column-span column-width columns contain content
    continue counter-increment counter-reset counter-set cue cue-after
    cue-before cursor direction display dominant-baseline elevation
    empty-cells fill fill-break fill-color fill-image fill-opacity
    fill-origin fill-position fill-repeat fill-rule fill-size filter flex
    flex-basis flex-direction flex-flow flex-grow flex-shrink flex-wrap float
    float-defer float-offset float-reference flood-color flood-opacity flow
    flow-from flow-into font font-family font-feature-settings font-kerning
    font-language-override font-optical-sizing font-palette font-size
    font-size-adjust font-stretch font-style font-synthesis
    font-synthesis-small-caps font-synthesis-style font-synthesis-weight
    font-variant font-variant-alternates font-variant-caps
    font-variant-east-asian font-variant-emoji font-variant-ligatures
    font-variant-numeric font-variant-position font-variation-settings
    font-weight footnote-display footnote-policy forced-color-adjust gap
    glyph-orientation-vertical grid grid-area grid-auto-columns
    grid-auto-flow grid-auto-rows grid-column grid-column-end
    grid-column-start grid-row grid-row-end grid-row-start grid-template
    grid-template-areas grid-template-columns grid-template-rows
    hanging-punctuation height hyphenate-character hyphenate-limit-chars
    hyphenate-limit-last hyphenate-limit-lines hyphenate-limit-zone hyphens
    image-orientation image-rendering image-resolution initial-letters
    initial-letters-align initial-letters-wrap inline-size inline-sizing
    inset inset-after inset-before inset-block inset-block-end
    inset-block-start inset-end inset-inline inset-inline-end
    inset-inline-start inset-start isolation justify-content justify-items
    justify-self leading-trim leading-trim-over leading-trim-under left
    letter-spacing lighting-color line-break line-clamp line-grid line-height
    line-height-step line-padding line-sizing line-snap list-style
    list-style-image list-style-position list-style-type margin margin-block
    margin-block-end margin-block-start margin-bottom margin-break
    margin-inline margin-inline-end margin-inline-start margin-left
    margin-right margin-top margin-trim marker marker-end
    marker-knockout-left marker-knockout-right marker-mid marker-pattern
    marker-segment marker-side marker-start mask mask-border mask-border-mode
    mask-border-outset mask-border-repeat mask-border-slice
    mask-border-source mask-border-width mask-clip mask-composite mask-image
    mask-mode mask-origin mask-position mask-repeat mask-size mask-type
    max-block-size max-height max-inline-size max-lines max-width
    min-block-size min-height min-inline-size min-width mix-blend-mode
    nav-down nav-left nav-right nav-up object-fit object-position offset
    offset-after offset-anchor offset-before offset-distance offset-end
    offset-path offset-position offset-rotate offset-start opacity order
    orphans outline outline-color outline-offset outline-style outline-width
    overflow overflow-anchor overflow-block overflow-inline overflow-wrap
    overflow-x overflow-y overscroll-behavior overscroll-behavior-block
    overscroll-behavior-inline overscroll-behavior-x overscroll-behavior-y
    padding padding-block padding-block-end padding-block-start
    padding-bottom padding-inline padding-inline-end padding-inline-start
    padding-left padding-right padding-top page page-break-after
    page-break-before page-break-inside pause pause-after pause-before pitch
    pitch-range place-content place-items place-self play-during position
    quotes region-fragment resize richness right row-gap ruby-align
    ruby-merge ruby-position running scroll-behavior scroll-margin
    scroll-margin-block scroll-margin-block-end scroll-margin-block-start
    scroll-margin-bottom scroll-margin-inline scroll-margin-inline-end
    scroll-margin-inline-start scroll-margin-left scroll-margin-right
    scroll-margin-top scroll-padding scroll-padding-block
    scroll-padding-block-end scroll-padding-block-start scroll-padding-bottom
    scroll-padding-inline scroll-padding-inline-end
    scroll-padding-inline-start scroll-padding-left scroll-padding-right
    scroll-padding-top scroll-snap-align scroll-snap-stop scroll-snap-type
    scrollbar-color scrollbar-gutter scrollbar-width shape-image-threshold
    shape-inside shape-margin shape-outside spatial-navigation-action
    spatial-navigation-contain spatial-navigation-function speak speak-header
    speak-numeral speak-punctuation speech-rate stress string-set stroke
    stroke-align stroke-alignment stroke-break stroke-color
    stroke-dash-corner stroke-dash-justify stroke-dashadjust stroke-dasharray
    stroke-dashcorner stroke-dashoffset stroke-image stroke-linecap
    stroke-linejoin stroke-miterlimit stroke-opacity stroke-origin
    stroke-position stroke-repeat stroke-size stroke-width tab-size
    table-layout text-align text-align-all text-align-last
    text-combine-upright text-decoration text-decoration-color
    text-decoration-line text-decoration-skip text-decoration-skip-box
    text-decoration-skip-ink text-decoration-skip-inset
    text-decoration-skip-self text-decoration-skip-spaces
    text-decoration-style text-decoration-thickness text-decoration-width
    text-emphasis text-emphasis-color text-emphasis-position
    text-emphasis-skip text-emphasis-style text-group-align text-indent
    text-justify text-orientation text-overflow text-shadow
    text-space-collapse text-space-trim text-spacing text-transform
    text-underline-offset text-underline-position text-wrap top transform
    transform-box transform-origin transition transition-delay
    transition-duration transition-property transition-timing-function
    unicode-bidi user-select vertical-align visibility voice-family volume
    white-space widows width will-change word-boundary-detection
    word-boundary-expansion word-break word-spacing word-wrap wrap-after
    wrap-before wrap-flow wrap-inside wrap-through writing-mode z-index
  ]

  quote = ->name { name.gsub(/-(\w)/) { |m| m[1].upcase } }

  unquote = ->name { name.gsub("_", "") }

  `git ls-files -z`.split("\0").grep(/\.erb$/).each do |path|
    out_path = path.gsub(/\.erb$/, "")
    File.write(out_path, ERB.new(File.read(path)).result(binding).strip + "\n")
    if out_path =~ /\.ml$/
      system "ocamlformat", "-i", out_path
    end
  end
end
