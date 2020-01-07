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
    controls:b coords crossOrigin data dateTime default:b defer:b disabled:b
    download encType form_ formAction formEncType formMethod formNoValidate:b
    formTarget frameBorder headers height high:f href hrefLang htmlFor httpEquiv
    integrity keyParams keyType kind label_ list loop:b low:f manifest
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
    about datatype inlist prefix property resource typeof vocab
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

  svg_bool_attributes = %w[externalResourcesRequired preserveAlpha]

  svg_int_attributes = %w[numOctaves tabindex]

  svg_float_attributes = %w[
    accent-height ascent azimuth bias diffuseConstant divisor elevation fr k1 k2
    k3 k4 limitingConeAngle overline-position overline-thickness pathLength
    pointsAtX pointsAtY pointsAtZ refX refY scale seed specularConstant
    specularExponent strikethrough-position strikethrough-thickness
    stroke-miterlimit surfaceScale targetX targetY underline-position
    underline-thickness version
  ]

  svg_string_attributes = %w[
    cx cy fill-opacity fx fy height markerHeight markerWidth r stroke-dashoffset
    stroke-opacity stroke-width textLength width x x1 x2 y y1 y2 accumulate
    additive alignment-baseline attributeName attributeType baseFrequency
    baseline-shift baseProfile begin_ calcMode clipPathUnits clip-path_
    clip-rule color color-interpolation color-interpolation-filters
    color-profile_ color-rendering contentScriptType contentStyleType cursor_ d
    direction display dominant-baseline dur dx dy edgeMode end_ fill fill-rule
    filter_ filterUnits flood-color flood-opacity font-family font-size
    font-size-adjust font-stretch font-style font-variant font-weight from
    gradientTransform gradientUnits href image-rendering in_ in2 kernelMatrix
    kernelUnitLength kerning keySplines keyTimes lengthAdjust letter-spacing
    lighting-color local marker-end marker-mid marker-start markerUnits mask_
    maskContentUnits maskUnits max min mode opacity operator order overflow
    paint-order patternContentUnits patternTransform patternUnits pointer-events
    points preserveAspectRatio primitiveUnits radius repeatCount repeatDur
    requiredFeatures restart result rx ry shape-rendering stdDeviation
    stitchTiles stop-color stop-opacity stroke stroke-dasharray stroke-linecap
    stroke-linejoin text-anchor text-decoration text-rendering to_ transform
    type_ values vector-effect viewBox visibility word-spacing writing-mode
    xChannelSelector yChannelSelector
  ]

  svg_attributes = [
    [svg_bool_attributes, "bool"],
    [svg_int_attributes, "int"],
    [svg_float_attributes, "float"],
    [svg_string_attributes, "string"],
  ].flat_map do |(array, type)|
    array.map do |name|
      [name, type]
    end
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
    onDblClick:Mouse
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

  quote = -> name { name.gsub(/-(\w)/) { |m| m[1].upcase } }

  unquote = -> name { name.gsub("_", "") }

  `git ls-files -z`.split("\0").grep(/\.erb$/).each do |path|
    out_path = path.gsub(/\.erb$/, "")
    File.write(out_path, ERB.new(File.read(path)).result(binding).strip + "\n")
    if out_path =~ /\.ml$/
      system "ocamlformat", "-i", out_path
    end
  end
end
