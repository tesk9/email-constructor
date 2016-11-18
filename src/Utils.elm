module Utils exposing (..)

import Html


tuple2 : (b -> c) -> ( a, b ) -> ( a, c )
tuple2 transform ( a, b ) =
    ( a, transform b )


viewIf : Bool -> Html.Html msg -> Html.Html msg
viewIf predicate view =
    if predicate then
        view
    else
        Html.text ""
