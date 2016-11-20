module Data.HighlighterColor exposing (..)

import Css
import TextUp
import Theme.Colors as Colors
import Theme.Mixins as Mixins


type Color
    = Yellow
    | Blue
    | Green
    | Pink
    | Red


type alias HighlightStyles =
    { yellow : Css.Mixin
    , blue : Css.Mixin
    , green : Css.Mixin
    , pink : Css.Mixin
    , red : Css.Mixin
    }


highlightStyles : TextUp.Config HighlightStyles
highlightStyles =
    { plain = Mixins.preserveWhiteSpace
    , yellow = highlight Colors.neonYellow
    , blue = highlight Colors.neonBlue
    , green = highlight Colors.neonGreen
    , pink = highlight Colors.neonPink
    , red = highlight Colors.neonRed
    }


highlight : Css.ColorValue compatible -> Css.Mixin
highlight color =
    Css.mixin [ Css.backgroundColor color ]


toTextUpString : ( String, Maybe Color ) -> TextUp.TextUpString HighlightStyles
toTextUpString ( str, maybeColor ) =
    (,) str <|
        case maybeColor of
            Just Yellow ->
                .yellow

            Just Blue ->
                .blue

            Just Green ->
                .green

            Just Pink ->
                .pink

            Just Red ->
                .red

            Nothing ->
                .plain


highlightColors : List Color
highlightColors =
    [ Yellow
    , Blue
    , Green
    , Pink
    , Red
    ]


colorToString : Color -> String
colorToString color =
    case color of
        Yellow ->
            "Yellow"

        Blue ->
            "Blue"

        Green ->
            "Green"

        Pink ->
            "Pink"

        Red ->
            "Red"
