# ocaml-twttr
Provides an ocaml binding to the `twttr` Javascript plugin ussing
gen_js_api

## What does ocaml-twttr do ?

Binding to plugins like
[vue-twitter](https://github.com/chiaweilee/vue-twitter) using
gen_js_api. You can see the [twitter official developer platform
API](https://developer.twitter.com/en/docs) for more details.

This plugin allows you to add *twitter* functionnalities into your ocaml
mobile app, feel free to add bindings to others `twttr` functions to it
if you wants, this plugin goal is to reunite all the `twttr` functions
into 1 library.

## How to install and compile your project by using this plugin ?

You can use opam by pining the repository with:
```Shell
opam pin add twttr https://github.com/besport/ocaml-twttr

to compile your project, use:
```Shell
dune build @install
```

Finally, install the "twttr" plugin with:
```Shell
cordova plugin add twttr
```

## How to use it?

### `Twttr.[XXX]_available` functions

The `Twttr.available` returns a boolean that indicates if the `.twttr`
module is available in your current dev environment. In the same logic
function with a name that end with *_available* indicates if a given
function is available in the current environment, it is recommended to use
these functions before trying to cast functions frome this plugin.

### `Twttr.init f`

This function executes a script that initiates the *twttr* plugin in your
current dev environment. You have to use this function before to use
other functions of this plugin if you want it to work. The `f` parameter
is a function that will be used as a callback; once the script execution
ends, a good use of this parameter would be for example to use it in
association with a synchronous programing tool like *Lwt* for example
(see the [Lwt official
documentation](https://ocsigen.org/lwt/latest/manual/manual) for more
details).

Note: this version currently only accepts *(unit -> unit)* function as
the `f` parameter, if it trouble you for your work feel free to add a
request for change.

### `Twttr.ready`

This function is a *callback function*.
You can use it to wrap your event bindings into an asynchronous function
queue that will be invoked once everything has loaded.

### What is a `html_elt` value ?
The `Widget` module of this plugin need a `html_elt` value as first
argument for some function, it is a value of type `Dom_html.element
Js.t` from the `Js_of_ocaml` library. You can see more details about
this type on the Js_of_ocaml official
documentation](https://ocsigen.org/js_of_ocaml/3.1.0/api/Dom_html.element-c). You
can obtain that kind of values with functions like
`Eliom_content.Html.To_dom.of_element`, you can see the [official
documentation](https://ocsigen.org/js_of_ocaml/latest/api/js_of_ocaml-tyxml/Js_of_ocaml_tyxml/Tyxml_cast_sigs/module-type-OF/index.html)
for more details.

### `Twttr.Widget`

This module allows you to use function from `twttr.widget`, thoses
functions allow you to load *Twitter* elements such as tweets into your
application.

#### `Twttr.Widget.load`

See the [twitter official
documentation](https://developer.twitter.com/en/docs/twitter-for-websites/javascript-api/guides/scripting-loading-and-initialization)
for more details.

### `Twttr.Conversion`

#### `Twttr.Conversion.track_pid`

This function takes a `pid_option` value as optional parameter, a
`Twttr.Conversion.pid_option` value can define 2 optional *int* values:
`tw_sale_amount_` and `tw_order_quantity_`.
