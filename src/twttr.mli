[@@@js.stop]

val available : unit -> bool

val conversion_available : unit -> bool

type html_element = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t

[@@@js.start]

[@@@js.implem
let available () =
  Js_of_ocaml.Js.Optdef.test Js_of_ocaml.Js.Unsafe.global##.twttr]

[@@@js.implem
let conversion_available () =
  Js_of_ocaml.Js.Optdef.test Js_of_ocaml.Js.Unsafe.global##.twttr##.conversion]

[@@@js.implem type html_element = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t]

[@@@js.implem let html_element_to_js = Obj.magic]

[@@@js.stop]

val init : (unit -> unit) -> unit

[@@@js.start]

[@@@js.implem
open Js_of_ocaml

let init f =
  Js_of_ocaml.Js.Unsafe.global##.twttr
  := object%js
       val __e = Js.array [| Js.wrap_callback f |]
     end ;
  let fjs =
    Dom_html.document ## (getElementsByTagName (Js.string "script"))##item 0
  in
  Js.Opt.iter fjs (fun script ->
      Js.Opt.iter script##.parentNode (fun head ->
          let js = Dom_html.createScript Dom_html.document in
          js##.id := Js.string "twitter-wjs" ;
          js##.src := Js.string "https://platform.twitter.com/widgets.js" ;
          js##.async := Js._true ;
          Dom.insertBefore head js fjs))]

type event

val ready : (event -> unit) -> unit [@@js.global "window.twttr.ready"]

module Widgets : sig
  val load : unit -> unit [@@js.global "window.twttr.widgets.load"]

  val load_html_element : html_element -> unit
    [@@js.global "window.twttr.widgets.load"]
end

module Conversion : sig
  type pid_options

  val pid_options :
    ?tw_sale_amount_:int -> ?tw_order_quantity_:int -> unit -> pid_options
    [@@js.builder] [@@js.verbatim_names]

  val track_pid : string -> ?options:pid_options -> unit -> unit
    [@@js.global "window.twttr.conversion.trackPid"]
end
