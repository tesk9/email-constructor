module Components.Highlighting exposing (Model, update, Msg(..), view, Color)

import Css
import Data.SaveAble as SaveAble
import Html exposing (..)
import Html.Events exposing (..)
import TextUp
import Theme.Colors as Colors
import Theme.Mixins as Mixins
import Theme.Styles as Styles


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
    div []
        [ hr [] []
        , h4 [] [ text "Highlighting" ]
        , viewFragments fragments
        ]


viewFragments : List ( String, Maybe Color ) -> Html Msg
viewFragments fragments =
    div [ Styles.class [ Styles.HighlightingBox ] ] <|
        List.map viewFragment fragments


viewFragment : ( String, Maybe Color ) -> Html Msg
viewFragment fragment =
    span [ onClick Highlight ]
        [ TextUp.toHtml highlightStyles [ toTextUpString fragment ] ]
