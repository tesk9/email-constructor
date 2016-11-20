module Utils.ViewUtils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Json.Decode


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


onChange : (String -> msg) -> Html.Attribute msg
onChange msg =
    on "change" (Json.Decode.map msg targetValue)
