let a = Reaml_Core.element "a"
let abbr = Reaml_Core.element "abbr"
let address = Reaml_Core.element "address"
let area = Reaml_Core.element "area"
let article = Reaml_Core.element "article"
let aside = Reaml_Core.element "aside"
let audio = Reaml_Core.element "audio"
let b = Reaml_Core.element "b"
let base = Reaml_Core.element "base"
let bdi = Reaml_Core.element "bdi"
let bdo = Reaml_Core.element "bdo"
let blockquote = Reaml_Core.element "blockquote"
let body = Reaml_Core.element "body"
let br = Reaml_Core.element "br"
let button = Reaml_Core.element "button"
let canvas = Reaml_Core.element "canvas"
let caption = Reaml_Core.element "caption"
let cite = Reaml_Core.element "cite"
let code = Reaml_Core.element "code"
let col = Reaml_Core.element "col"
let colgroup = Reaml_Core.element "colgroup"
let data' = Reaml_Core.element "data"
let datalist = Reaml_Core.element "datalist"
let dd = Reaml_Core.element "dd"
let del = Reaml_Core.element "del"
let details = Reaml_Core.element "details"
let dfn = Reaml_Core.element "dfn"
let dialog = Reaml_Core.element "dialog"
let div = Reaml_Core.element "div"
let dl = Reaml_Core.element "dl"
let dt = Reaml_Core.element "dt"
let em = Reaml_Core.element "em"
let embed = Reaml_Core.element "embed"
let fieldset = Reaml_Core.element "fieldset"
let figcaption = Reaml_Core.element "figcaption"
let figure = Reaml_Core.element "figure"
let footer = Reaml_Core.element "footer"
let form = Reaml_Core.element "form"
let h1 = Reaml_Core.element "h1"
let h2 = Reaml_Core.element "h2"
let h3 = Reaml_Core.element "h3"
let h4 = Reaml_Core.element "h4"
let h5 = Reaml_Core.element "h5"
let h6 = Reaml_Core.element "h6"
let head = Reaml_Core.element "head"
let header = Reaml_Core.element "header"
let hgroup = Reaml_Core.element "hgroup"
let hr = Reaml_Core.element "hr"
let html = Reaml_Core.element "html"
let i = Reaml_Core.element "i"
let iframe = Reaml_Core.element "iframe"
let img = Reaml_Core.element "img"
let input = Reaml_Core.element "input"
let ins = Reaml_Core.element "ins"
let kbd = Reaml_Core.element "kbd"
let label = Reaml_Core.element "label"
let legend = Reaml_Core.element "legend"
let li = Reaml_Core.element "li"
let link = Reaml_Core.element "link"
let main = Reaml_Core.element "main"
let map = Reaml_Core.element "map"
let mark = Reaml_Core.element "mark"
let menu = Reaml_Core.element "menu"
let meta = Reaml_Core.element "meta"
let meter = Reaml_Core.element "meter"
let nav = Reaml_Core.element "nav"
let noscript = Reaml_Core.element "noscript"
let object' = Reaml_Core.element "object"
let ol = Reaml_Core.element "ol"
let optgroup = Reaml_Core.element "optgroup"
let option = Reaml_Core.element "option"
let output = Reaml_Core.element "output"
let p = Reaml_Core.element "p"
let param = Reaml_Core.element "param"
let picture = Reaml_Core.element "picture"
let pre = Reaml_Core.element "pre"
let progress = Reaml_Core.element "progress"
let q = Reaml_Core.element "q"
let rp = Reaml_Core.element "rp"
let rt = Reaml_Core.element "rt"
let ruby = Reaml_Core.element "ruby"
let s = Reaml_Core.element "s"
let samp = Reaml_Core.element "samp"
let script = Reaml_Core.element "script"
let section = Reaml_Core.element "section"
let select = Reaml_Core.element "select"
let slot = Reaml_Core.element "slot"
let small = Reaml_Core.element "small"
let source = Reaml_Core.element "source"
let span = Reaml_Core.element "span"
let strong = Reaml_Core.element "strong"
let style' = Reaml_Core.element "style"
let sub = Reaml_Core.element "sub"
let summary = Reaml_Core.element "summary"
let sup = Reaml_Core.element "sup"
let table = Reaml_Core.element "table"
let tbody = Reaml_Core.element "tbody"
let td = Reaml_Core.element "td"
let template = Reaml_Core.element "template"
let textarea = Reaml_Core.element "textarea"
let tfoot = Reaml_Core.element "tfoot"
let th = Reaml_Core.element "th"
let thead = Reaml_Core.element "thead"
let time = Reaml_Core.element "time"
let title = Reaml_Core.element "title"
let tr = Reaml_Core.element "tr"
let track = Reaml_Core.element "track"
let u = Reaml_Core.element "u"
let ul = Reaml_Core.element "ul"
let var = Reaml_Core.element "var"
let video = Reaml_Core.element "video"
let wbr = Reaml_Core.element "wbr"

let ref (value : Dom.element option -> unit) =
  Reaml_Core.property "ref" (fun (element : Dom.element Js.Nullable.t) ->
      value (Js.Nullable.toOption element))

let abbr' (value : string) = Reaml_Core.property "abbr" value
let accept (value : string) = Reaml_Core.property "accept" value
let acceptCharset (value : string) = Reaml_Core.property "accept-charset" value
let accesskey (value : string) = Reaml_Core.property "accesskey" value
let action (value : string) = Reaml_Core.property "action" value
let allow (value : string) = Reaml_Core.property "allow" value
let allowfullscreen (value : bool) = Reaml_Core.property "allowfullscreen" value
let allowpaymentrequest (value : bool) = Reaml_Core.property "allowpaymentrequest" value
let alt (value : string) = Reaml_Core.property "alt" value
let as' (value : string) = Reaml_Core.property "as" value
let async (value : bool) = Reaml_Core.property "async" value
let autocapitalize (value : string) = Reaml_Core.property "autocapitalize" value
let autocomplete (value : bool) = Reaml_Core.property "autocomplete" value
let autofocus (value : bool) = Reaml_Core.property "autofocus" value
let autoplay (value : bool) = Reaml_Core.property "autoplay" value
let charset (value : string) = Reaml_Core.property "charset" value
let checked (value : bool) = Reaml_Core.property "checked" value
let cite' (value : string) = Reaml_Core.property "cite" value
let color (value : string) = Reaml_Core.property "color" value
let cols (value : int) = Reaml_Core.property "cols" value
let colspan (value : int) = Reaml_Core.property "colspan" value
let content (value : string) = Reaml_Core.property "content" value
let contenteditable (value : bool) = Reaml_Core.property "contenteditable" value
let controls (value : bool) = Reaml_Core.property "controls" value
let coords (value : string) = Reaml_Core.property "coords" value
let crossorigin (value : string) = Reaml_Core.property "crossorigin" value
let data'' (value : string) = Reaml_Core.property "data" value
let datetime (value : string) = Reaml_Core.property "datetime" value
let decoding (value : string) = Reaml_Core.property "decoding" value
let default (value : bool) = Reaml_Core.property "default" value
let defer (value : bool) = Reaml_Core.property "defer" value
let dir (value : string) = Reaml_Core.property "dir" value
let dirname (value : string) = Reaml_Core.property "dirname" value
let disabled (value : bool) = Reaml_Core.property "disabled" value
let download (value : string) = Reaml_Core.property "download" value
let draggable (value : bool) = Reaml_Core.property "draggable" value
let enctype (value : string) = Reaml_Core.property "enctype" value
let enterkeyhint (value : string) = Reaml_Core.property "enterkeyhint" value
let for' (value : string) = Reaml_Core.property "for" value
let form' (value : string) = Reaml_Core.property "form" value
let formaction (value : string) = Reaml_Core.property "formaction" value
let formenctype (value : string) = Reaml_Core.property "formenctype" value
let formmethod (value : string) = Reaml_Core.property "formmethod" value
let formnovalidate (value : bool) = Reaml_Core.property "formnovalidate" value
let formtarget (value : string) = Reaml_Core.property "formtarget" value
let headers (value : string) = Reaml_Core.property "headers" value
let height (value : string) = Reaml_Core.property "height" value
let hidden (value : bool) = Reaml_Core.property "hidden" value
let high (value : float) = Reaml_Core.property "high" value
let href (value : string) = Reaml_Core.property "href" value
let hreflang (value : string) = Reaml_Core.property "hreflang" value
let httpEquiv (value : string) = Reaml_Core.property "http-equiv" value
let id (value : string) = Reaml_Core.property "id" value
let inputmode (value : string) = Reaml_Core.property "inputmode" value
let integrity (value : string) = Reaml_Core.property "integrity" value
let is (value : string) = Reaml_Core.property "is" value
let ismap (value : bool) = Reaml_Core.property "ismap" value
let itemid (value : string) = Reaml_Core.property "itemid" value
let itemprop (value : string) = Reaml_Core.property "itemprop" value
let itemref (value : string) = Reaml_Core.property "itemref" value
let itemscope (value : bool) = Reaml_Core.property "itemscope" value
let itemtype (value : string) = Reaml_Core.property "itemtype" value
let kind (value : string) = Reaml_Core.property "kind" value
let label' (value : string) = Reaml_Core.property "label" value
let lang (value : string) = Reaml_Core.property "lang" value
let list (value : string) = Reaml_Core.property "list" value
let loop (value : bool) = Reaml_Core.property "loop" value
let low (value : float) = Reaml_Core.property "low" value
let manifest (value : string) = Reaml_Core.property "manifest" value
let max (value : float) = Reaml_Core.property "max" value
let maxlength (value : string) = Reaml_Core.property "maxlength" value
let media (value : string) = Reaml_Core.property "media" value
let method' (value : string) = Reaml_Core.property "method" value
let min (value : float) = Reaml_Core.property "min" value
let minlength (value : int) = Reaml_Core.property "minlength" value
let multiple (value : bool) = Reaml_Core.property "multiple" value
let muted (value : bool) = Reaml_Core.property "muted" value
let name (value : string) = Reaml_Core.property "name" value
let nomodule (value : bool) = Reaml_Core.property "nomodule" value
let nonce (value : string) = Reaml_Core.property "nonce" value
let novalidate (value : bool) = Reaml_Core.property "novalidate" value
let open' (value : bool) = Reaml_Core.property "open" value
let optimum (value : float) = Reaml_Core.property "optimum" value
let pattern (value : string) = Reaml_Core.property "pattern" value
let ping (value : string) = Reaml_Core.property "ping" value
let placeholder (value : string) = Reaml_Core.property "placeholder" value
let playsinline (value : bool) = Reaml_Core.property "playsinline" value
let poster (value : string) = Reaml_Core.property "poster" value
let preload (value : string) = Reaml_Core.property "preload" value
let readonly (value : bool) = Reaml_Core.property "readonly" value
let referrerpolicy (value : string) = Reaml_Core.property "referrerpolicy" value
let rel (value : string) = Reaml_Core.property "rel" value
let required (value : bool) = Reaml_Core.property "required" value
let reversed (value : bool) = Reaml_Core.property "reversed" value
let rows (value : int) = Reaml_Core.property "rows" value
let rowspan (value : int) = Reaml_Core.property "rowspan" value
let sandbox (value : string) = Reaml_Core.property "sandbox" value
let scope (value : string) = Reaml_Core.property "scope" value
let selected (value : bool) = Reaml_Core.property "selected" value
let shape (value : string) = Reaml_Core.property "shape" value
let size (value : int) = Reaml_Core.property "size" value
let sizes (value : string) = Reaml_Core.property "sizes" value
let slot' (value : string) = Reaml_Core.property "slot" value
let span' (value : int) = Reaml_Core.property "span" value
let spellcheck (value : bool) = Reaml_Core.property "spellcheck" value
let src (value : string) = Reaml_Core.property "src" value
let srcdoc (value : string) = Reaml_Core.property "srcdoc" value
let srclang (value : string) = Reaml_Core.property "srclang" value
let srcset (value : string) = Reaml_Core.property "srcset" value
let start (value : int) = Reaml_Core.property "start" value
let step (value : float) = Reaml_Core.property "step" value
let tabindex (value : int) = Reaml_Core.property "tabindex" value
let target (value : string) = Reaml_Core.property "target" value
let title' (value : string) = Reaml_Core.property "title" value
let translate (value : bool) = Reaml_Core.property "translate" value
let type' (value : string) = Reaml_Core.property "type" value
let typemustmatch (value : bool) = Reaml_Core.property "typemustmatch" value
let usemap (value : string) = Reaml_Core.property "usemap" value
let value (value : string) = Reaml_Core.property "value" value
let width (value : int) = Reaml_Core.property "width" value
let wrap (value : string) = Reaml_Core.property "wrap" value

let onAnimationEnd (handler : Reaml_Event.Animation.t -> unit) =
  Reaml_Core.on "AnimationEnd" (fun event -> handler (Obj.magic event))

let onAnimationIteration (handler : Reaml_Event.Animation.t -> unit) =
  Reaml_Core.on "AnimationIteration" (fun event -> handler (Obj.magic event))

let onAnimationStart (handler : Reaml_Event.Animation.t -> unit) =
  Reaml_Core.on "AnimationStart" (fun event -> handler (Obj.magic event))

let onCopy (handler : Reaml_Event.Clipboard.t -> unit) =
  Reaml_Core.on "Copy" (fun event -> handler (Obj.magic event))

let onCut (handler : Reaml_Event.Clipboard.t -> unit) =
  Reaml_Core.on "Cut" (fun event -> handler (Obj.magic event))

let onPaste (handler : Reaml_Event.Clipboard.t -> unit) =
  Reaml_Core.on "Paste" (fun event -> handler (Obj.magic event))

let onCompositionEnd (handler : Reaml_Event.Composition.t -> unit) =
  Reaml_Core.on "CompositionEnd" (fun event -> handler (Obj.magic event))

let onCompositionStart (handler : Reaml_Event.Composition.t -> unit) =
  Reaml_Core.on "CompositionStart" (fun event -> handler (Obj.magic event))

let onCompositionUpdate (handler : Reaml_Event.Composition.t -> unit) =
  Reaml_Core.on "CompositionUpdate" (fun event -> handler (Obj.magic event))

let onDrag (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "Drag" (fun event -> handler (Obj.magic event))

let onDragEnd (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragEnd" (fun event -> handler (Obj.magic event))

let onDragEnter (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragEnter" (fun event -> handler (Obj.magic event))

let onDragExit (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragExit" (fun event -> handler (Obj.magic event))

let onDragLeave (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragLeave" (fun event -> handler (Obj.magic event))

let onDragOver (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragOver" (fun event -> handler (Obj.magic event))

let onDragStart (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "DragStart" (fun event -> handler (Obj.magic event))

let onDrop (handler : Reaml_Event.Drag.t -> unit) =
  Reaml_Core.on "Drop" (fun event -> handler (Obj.magic event))

let onAbort (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Abort" (fun event -> handler (Obj.magic event))

let onCanPlay (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "CanPlay" (fun event -> handler (Obj.magic event))

let onCanPlayThrough (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "CanPlayThrough" (fun event -> handler (Obj.magic event))

let onChange (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Change" (fun event -> handler (Obj.magic event))

let onDurationChange (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "DurationChange" (fun event -> handler (Obj.magic event))

let onEmptied (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Emptied" (fun event -> handler (Obj.magic event))

let onEncrypted (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Encrypted" (fun event -> handler (Obj.magic event))

let onEnded (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Ended" (fun event -> handler (Obj.magic event))

let onError (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Error" (fun event -> handler (Obj.magic event))

let onInput (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Input" (fun event -> handler (Obj.magic event))

let onInvalid (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Invalid" (fun event -> handler (Obj.magic event))

let onLoad (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Load" (fun event -> handler (Obj.magic event))

let onLoadStart (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "LoadStart" (fun event -> handler (Obj.magic event))

let onLoadedData (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "LoadedData" (fun event -> handler (Obj.magic event))

let onLoadedMetadata (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "LoadedMetadata" (fun event -> handler (Obj.magic event))

let onPause (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Pause" (fun event -> handler (Obj.magic event))

let onPlay (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Play" (fun event -> handler (Obj.magic event))

let onPlaying (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Playing" (fun event -> handler (Obj.magic event))

let onProgress (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Progress" (fun event -> handler (Obj.magic event))

let onRateChange (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "RateChange" (fun event -> handler (Obj.magic event))

let onReset (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Reset" (fun event -> handler (Obj.magic event))

let onSearch (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Search" (fun event -> handler (Obj.magic event))

let onSeeked (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Seeked" (fun event -> handler (Obj.magic event))

let onSeeking (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Seeking" (fun event -> handler (Obj.magic event))

let onSelect (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Select" (fun event -> handler (Obj.magic event))

let onStalled (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Stalled" (fun event -> handler (Obj.magic event))

let onSubmit (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Submit" (fun event -> handler (Obj.magic event))

let onSuspend (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Suspend" (fun event -> handler (Obj.magic event))

let onTimeUpdate (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "TimeUpdate" (fun event -> handler (Obj.magic event))

let onVolumeChange (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "VolumeChange" (fun event -> handler (Obj.magic event))

let onWaiting (handler : Reaml_Event.Event.t -> unit) =
  Reaml_Core.on "Waiting" (fun event -> handler (Obj.magic event))

let onBlur (handler : Reaml_Event.Focus.t -> unit) =
  Reaml_Core.on "Blur" (fun event -> handler (Obj.magic event))

let onFocus (handler : Reaml_Event.Focus.t -> unit) =
  Reaml_Core.on "Focus" (fun event -> handler (Obj.magic event))

let onKeyDown (handler : Reaml_Event.Keyboard.t -> unit) =
  Reaml_Core.on "KeyDown" (fun event -> handler (Obj.magic event))

let onKeyPress (handler : Reaml_Event.Keyboard.t -> unit) =
  Reaml_Core.on "KeyPress" (fun event -> handler (Obj.magic event))

let onKeyUp (handler : Reaml_Event.Keyboard.t -> unit) =
  Reaml_Core.on "KeyUp" (fun event -> handler (Obj.magic event))

let onClick (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "Click" (fun event -> handler (Obj.magic event))

let onContextMenu (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "ContextMenu" (fun event -> handler (Obj.magic event))

let onDblClick (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "DblClick" (fun event -> handler (Obj.magic event))

let onMouseDown (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseDown" (fun event -> handler (Obj.magic event))

let onMouseEnter (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseEnter" (fun event -> handler (Obj.magic event))

let onMouseLeave (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseLeave" (fun event -> handler (Obj.magic event))

let onMouseMove (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseMove" (fun event -> handler (Obj.magic event))

let onMouseOut (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseOut" (fun event -> handler (Obj.magic event))

let onMouseOver (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseOver" (fun event -> handler (Obj.magic event))

let onMouseUp (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "MouseUp" (fun event -> handler (Obj.magic event))

let onPointerCancel (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerCancel" (fun event -> handler (Obj.magic event))

let onPointerDown (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerDown" (fun event -> handler (Obj.magic event))

let onPointerEnter (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerEnter" (fun event -> handler (Obj.magic event))

let onPointerLeave (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerLeave" (fun event -> handler (Obj.magic event))

let onPointerMove (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerMove" (fun event -> handler (Obj.magic event))

let onPointerOut (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerOut" (fun event -> handler (Obj.magic event))

let onPointerOver (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerOver" (fun event -> handler (Obj.magic event))

let onPointerUp (handler : Reaml_Event.Pointer.t -> unit) =
  Reaml_Core.on "PointerUp" (fun event -> handler (Obj.magic event))

let onTouchCancel (handler : Reaml_Event.Touch.t -> unit) =
  Reaml_Core.on "TouchCancel" (fun event -> handler (Obj.magic event))

let onTouchEnd (handler : Reaml_Event.Touch.t -> unit) =
  Reaml_Core.on "TouchEnd" (fun event -> handler (Obj.magic event))

let onTouchMove (handler : Reaml_Event.Touch.t -> unit) =
  Reaml_Core.on "TouchMove" (fun event -> handler (Obj.magic event))

let onTouchStart (handler : Reaml_Event.Touch.t -> unit) =
  Reaml_Core.on "TouchStart" (fun event -> handler (Obj.magic event))

let onTransitionEnd (handler : Reaml_Event.Transition.t -> unit) =
  Reaml_Core.on "TransitionEnd" (fun event -> handler (Obj.magic event))

let onScroll (handler : Reaml_Event.Ui.t -> unit) =
  Reaml_Core.on "Scroll" (fun event -> handler (Obj.magic event))

let onWheel (handler : Reaml_Event.Wheel.t -> unit) =
  Reaml_Core.on "Wheel" (fun event -> handler (Obj.magic event))

let onInputValue (handler : string -> unit) =
  onChange (fun event ->
      match (Obj.magic event)##target##value with
      | Some value -> handler value
      | None -> handler "")

let onCheck (handler : bool -> unit) =
  onChange (fun event ->
      match (Obj.magic event)##target##checked with
      | Some checked -> handler checked
      | None -> handler false)
