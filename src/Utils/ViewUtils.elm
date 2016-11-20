module Utils.ViewUtils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


tuple2 : (b -> c) -> ( a, b ) -> ( a, c )
tuple2 transform ( a, b ) =
    ( a, transform b )


viewIf : Bool -> Html.Html msg -> Html.Html msg
viewIf predicate view =
    if predicate then
        view
    else
        text ""


radio : List (Attribute msg) -> List (Html msg) -> Html msg
radio attributes children =
    input
        (type_ "radio" :: attributes)
        children
