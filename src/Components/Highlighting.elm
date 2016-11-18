module Components.Highlighting exposing (Model, update, Msg(..), view, Color)

import Colors
import Css
import Html exposing (..)
import Html.Events exposing (..)
import SaveAble
import Styles
import TextUp


type alias Model a =
    { a
        | fragments : SaveAble.SaveAble (List ( String, Maybe Color ))
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
            --TODO: actual logic on this highlighting
            { model
                | fragments =
                    SaveAble.map
                        (\fragments ->
                            List.map (\( str, maybeColor ) -> ( str, Just Yellow )) fragments
                        )
                        model.fragments
            }
                ! []


view : List ( String, Maybe Color ) -> Html Msg
view fragments =
    fragments
        |> List.map toTextUpString
        |> TextUp.toHtml highlightStyles
        |> \fragments -> span [ onClick Highlight ] [ fragments ]
