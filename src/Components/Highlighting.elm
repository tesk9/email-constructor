module Components.Highlighting exposing (Model, update, Msg(..), view, Color)

import Css
import Dict
import Html exposing (..)
import Html.Events exposing (..)
import TextUp
import Theme.Colors as Colors
import Theme.Mixins as Mixins
import Theme.Styles as Styles
import Utils.Utils as Utils


type alias Model a =
    { a
        | fragments : List ( Int, String )
        , highlightedFragments : Dict.Dict Int Color
    }


type Color
    = Yellow


type alias HighlightStyles =
    { yellow : Css.Mixin
    }


highlightStyles : TextUp.Config HighlightStyles
highlightStyles =
    { plain = Mixins.preserveWhiteSpace
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
    | Highlight Int


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Highlight index ->
            { model
                | highlightedFragments =
                    Utils.dictToggleOrReplace index Yellow model.highlightedFragments
            }
                ! []


view : List { a | id : Int, content : String, color : Maybe Color } -> Html Msg
view fragments =
    div []
        [ hr [] []
        , h4 [] [ text "Highlighting" ]
        , viewFragments fragments
        ]


viewFragments : List { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragments fragments =
    div [ Styles.class [ Styles.HighlightingBox ] ] <|
        List.map viewFragment fragments


viewFragment : { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragment fragment =
    span [ onClick (Highlight fragment.id) ]
        [ TextUp.toHtml highlightStyles [ toTextUpString ( fragment.content, fragment.color ) ] ]
