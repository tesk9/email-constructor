module Components.Highlighting exposing (Model, update, Msg(..), view, Color)

import Colors
import Css
import Html exposing (..)
import Html.Events exposing (..)
import Styles
import SaveAble
import TextUp


type alias Model a =
    { a
        | fragments : List ( String, Maybe Color )
        , draft : SaveAble.SaveAble String
    }


type Color
    = Yellow


type alias HighlightStyles =
    { yellow : Css.Mixin
    }


highlightStyles : TextUp.Config HighlightStyles
highlightStyles =
    { plain = Styles.preserveWhiteSpace
    , yellow = Css.mixin [ Css.backgroundColor Colors.neonYellow ]
    }


toTextUpString : ( String, Maybe Color ) -> TextUp.TextUpString HighlightStyles
toTextUpString ( str, maybeColor ) =
    (,) str <|
        case maybeColor of
            Just Yellow ->
                .yellow

            Nothing ->
                .plain


type Msg
    = NoOp
    | Highlight


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Highlight ->
            { model | fragments = model.fragments |> List.map (\( str, maybeColor ) -> ( str, Just Yellow )) } ! []


view : Model a -> Html Msg
view model =
    model.fragments
        |> List.map toTextUpString
        |> TextUp.toHtml highlightStyles
        |> \fragments -> span [ onClick Highlight ] [ fragments ]
