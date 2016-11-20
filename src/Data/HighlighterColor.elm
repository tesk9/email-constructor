module Data.HighlighterColor exposing (..)

import Css
import TextUp
import Theme.Colors as Colors
import Theme.Mixins as Mixins


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


highlightColors : List Color
highlightColors =
    [ Yellow ]


colorToString : Color -> String
colorToString color =
    case color of
        Yellow ->
            "Yellow"
