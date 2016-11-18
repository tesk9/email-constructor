module Components.Highlighting exposing (Model, update, Msg(..), view)

import Colors
import Css
import Html exposing (..)
import Styles
import TextUp


type alias Model =
    { fragments : List ( String, Maybe Color )
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


view : Model -> Html Msg
view model =
    model.fragments
        |> List.map toTextUpString
        |> TextUp.toHtml highlightStyles
