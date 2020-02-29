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
let data_ = Reaml_Core.element "data"
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
let object_ = Reaml_Core.element "object"
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
let style_ = Reaml_Core.element "style"
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

let about (value : string) = Reaml_Core.property "about" value
let accept (value : string) = Reaml_Core.property "accept" value
let acceptCharset (value : string) = Reaml_Core.property "acceptCharset" value
let accessKey (value : string) = Reaml_Core.property "accessKey" value
let action (value : string) = Reaml_Core.property "action" value
let allowFullScreen (value : bool) = Reaml_Core.property "allowFullScreen" value
let allowTransparency (value : bool) = Reaml_Core.property "allowTransparency" value
let alt (value : string) = Reaml_Core.property "alt" value
let as_ (value : string) = Reaml_Core.property "as" value
let async (value : bool) = Reaml_Core.property "async" value
let autoCapitalize (value : string) = Reaml_Core.property "autoCapitalize" value
let autoComplete (value : string) = Reaml_Core.property "autoComplete" value
let autoCorrect (value : string) = Reaml_Core.property "autoCorrect" value
let autoFocus (value : bool) = Reaml_Core.property "autoFocus" value
let autoPlay (value : bool) = Reaml_Core.property "autoPlay" value
let autoSave (value : string) = Reaml_Core.property "autoSave" value
let capture (value : string) = Reaml_Core.property "capture" value
let cellPadding (value : string) = Reaml_Core.property "cellPadding" value
let cellSpacing (value : string) = Reaml_Core.property "cellSpacing" value
let challenge (value : string) = Reaml_Core.property "challenge" value
let charSet (value : string) = Reaml_Core.property "charSet" value
let checked (value : bool) = Reaml_Core.property "checked" value
let cite_ (value : string) = Reaml_Core.property "cite" value
let classID (value : string) = Reaml_Core.property "classID" value
let className (value : string) = Reaml_Core.property "className" value
let colSpan (value : int) = Reaml_Core.property "colSpan" value
let color (value : string) = Reaml_Core.property "color" value
let cols (value : int) = Reaml_Core.property "cols" value
let content (value : string) = Reaml_Core.property "content" value
let contentEditable (value : bool) = Reaml_Core.property "contentEditable" value
let contextMenu (value : string) = Reaml_Core.property "contextMenu" value
let controls (value : bool) = Reaml_Core.property "controls" value
let coords (value : string) = Reaml_Core.property "coords" value
let crossOrigin (value : string) = Reaml_Core.property "crossOrigin" value
let data__ (value : string) = Reaml_Core.property "data" value
let datatype (value : string) = Reaml_Core.property "datatype" value
let dateTime (value : string) = Reaml_Core.property "dateTime" value
let default (value : bool) = Reaml_Core.property "default" value
let defaultChecked (value : bool) = Reaml_Core.property "defaultChecked" value
let defaultValue (value : string) = Reaml_Core.property "defaultValue" value
let defer (value : bool) = Reaml_Core.property "defer" value
let dir (value : string) = Reaml_Core.property "dir" value
let disabled (value : bool) = Reaml_Core.property "disabled" value
let download (value : string) = Reaml_Core.property "download" value
let draggable (value : bool) = Reaml_Core.property "draggable" value
let encType (value : string) = Reaml_Core.property "encType" value
let formAction (value : string) = Reaml_Core.property "formAction" value
let formEncType (value : string) = Reaml_Core.property "formEncType" value
let formMethod (value : string) = Reaml_Core.property "formMethod" value
let formNoValidate (value : bool) = Reaml_Core.property "formNoValidate" value
let formTarget (value : string) = Reaml_Core.property "formTarget" value
let form_ (value : string) = Reaml_Core.property "form" value
let frameBorder (value : string) = Reaml_Core.property "frameBorder" value
let headers (value : string) = Reaml_Core.property "headers" value
let height (value : string) = Reaml_Core.property "height" value
let hidden (value : bool) = Reaml_Core.property "hidden" value
let high (value : float) = Reaml_Core.property "high" value
let href (value : string) = Reaml_Core.property "href" value
let hrefLang (value : string) = Reaml_Core.property "hrefLang" value
let htmlFor (value : string) = Reaml_Core.property "htmlFor" value
let httpEquiv (value : string) = Reaml_Core.property "httpEquiv" value
let id (value : string) = Reaml_Core.property "id" value
let inlist (value : string) = Reaml_Core.property "inlist" value
let inputMode (value : string) = Reaml_Core.property "inputMode" value
let integrity (value : string) = Reaml_Core.property "integrity" value
let is (value : string) = Reaml_Core.property "is" value
let itemID (value : string) = Reaml_Core.property "itemID" value
let itemProp (value : string) = Reaml_Core.property "itemProp" value
let itemRef (value : string) = Reaml_Core.property "itemRef" value
let itemScope (value : bool) = Reaml_Core.property "itemScope" value
let itemType (value : string) = Reaml_Core.property "itemType" value
let keyParams (value : string) = Reaml_Core.property "keyParams" value
let keyType (value : string) = Reaml_Core.property "keyType" value
let kind (value : string) = Reaml_Core.property "kind" value
let label_ (value : string) = Reaml_Core.property "label" value
let lang (value : string) = Reaml_Core.property "lang" value
let list_ (value : string) = Reaml_Core.property "list" value
let loop (value : bool) = Reaml_Core.property "loop" value
let low (value : float) = Reaml_Core.property "low" value
let manifest (value : string) = Reaml_Core.property "manifest" value
let marginHeight (value : float) = Reaml_Core.property "marginHeight" value
let marginWidth (value : float) = Reaml_Core.property "marginWidth" value
let max (value : string) = Reaml_Core.property "max" value
let maxLength (value : int) = Reaml_Core.property "maxLength" value
let media (value : string) = Reaml_Core.property "media" value
let mediaGroup (value : string) = Reaml_Core.property "mediaGroup" value
let method_ (value : string) = Reaml_Core.property "method" value
let min (value : string) = Reaml_Core.property "min" value
let minLength (value : int) = Reaml_Core.property "minLength" value
let multiple (value : bool) = Reaml_Core.property "multiple" value
let muted (value : bool) = Reaml_Core.property "muted" value
let name (value : string) = Reaml_Core.property "name" value
let noValidate (value : bool) = Reaml_Core.property "noValidate" value
let nonce (value : string) = Reaml_Core.property "nonce" value
let open_ (value : bool) = Reaml_Core.property "open" value
let optimum (value : float) = Reaml_Core.property "optimum" value
let pattern (value : string) = Reaml_Core.property "pattern" value
let placeholder (value : string) = Reaml_Core.property "placeholder" value
let placeholder_ (value : string) = Reaml_Core.property "placeholder" value
let playsInline (value : bool) = Reaml_Core.property "playsInline" value
let poster (value : string) = Reaml_Core.property "poster" value
let prefix (value : string) = Reaml_Core.property "prefix" value
let preload (value : string) = Reaml_Core.property "preload" value
let property_ (value : string) = Reaml_Core.property "property" value
let readOnly (value : bool) = Reaml_Core.property "readOnly" value
let rel (value : string) = Reaml_Core.property "rel" value
let required (value : bool) = Reaml_Core.property "required" value
let resource (value : string) = Reaml_Core.property "resource" value
let results (value : int) = Reaml_Core.property "results" value
let reversed (value : bool) = Reaml_Core.property "reversed" value
let role (value : string) = Reaml_Core.property "role" value
let rowSpan (value : int) = Reaml_Core.property "rowSpan" value
let rows (value : int) = Reaml_Core.property "rows" value
let sandbox (value : string) = Reaml_Core.property "sandbox" value
let scope (value : string) = Reaml_Core.property "scope" value
let scoped (value : bool) = Reaml_Core.property "scoped" value
let scrolling (value : string) = Reaml_Core.property "scrolling" value
let seamless (value : bool) = Reaml_Core.property "seamless" value
let security (value : string) = Reaml_Core.property "security" value
let selected (value : bool) = Reaml_Core.property "selected" value
let shape (value : string) = Reaml_Core.property "shape" value
let size (value : int) = Reaml_Core.property "size" value
let sizes (value : string) = Reaml_Core.property "sizes" value
let slot_ (value : string) = Reaml_Core.property "slot" value
let span_ (value : int) = Reaml_Core.property "span" value
let spellCheck (value : bool) = Reaml_Core.property "spellCheck" value
let src (value : string) = Reaml_Core.property "src" value
let srcDoc (value : string) = Reaml_Core.property "srcDoc" value
let srcLang (value : string) = Reaml_Core.property "srcLang" value
let srcSet (value : string) = Reaml_Core.property "srcSet" value
let start (value : int) = Reaml_Core.property "start" value
let step (value : string) = Reaml_Core.property "step" value
let summary_ (value : string) = Reaml_Core.property "summary" value
let tabIndex (value : int) = Reaml_Core.property "tabIndex" value
let target (value : string) = Reaml_Core.property "target" value
let title_ (value : string) = Reaml_Core.property "title" value
let translate (value : string) = Reaml_Core.property "translate" value
let type_ (value : string) = Reaml_Core.property "type" value
let typeof (value : string) = Reaml_Core.property "typeof" value
let unselectable (value : string) = Reaml_Core.property "unselectable" value
let useMap (value : string) = Reaml_Core.property "useMap" value
let value (value : string) = Reaml_Core.property "value" value
let vocab (value : string) = Reaml_Core.property "vocab" value
let width (value : string) = Reaml_Core.property "width" value
let wmode (value : string) = Reaml_Core.property "wmode" value
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

let onDoubleClick (handler : Reaml_Event.Mouse.t -> unit) =
  Reaml_Core.on "DoubleClick" (fun event -> handler (Obj.magic event))

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
  onInput (fun event ->
      match (Obj.magic event)##target##value with
      | Some value -> handler value
      | None -> ())

let onCheck (handler : bool -> unit) =
  onChange (fun event ->
      match (Obj.magic event)##target##checked with
      | Some checked -> handler checked
      | None -> ())
