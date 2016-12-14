module Data.HighlighterColor exposing (..)

import Css
import Dict
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


plainStyles : TextUp.Config HighlightStyles
plainStyles =
    { plain = Css.mixin []
    , yellow = Css.mixin []
    , blue = Css.mixin []
    , green = Css.mixin []
    , pink = Css.mixin []
    , red = Css.mixin []
    }


highlight : Css.ColorValue compatible -> Css.Mixin
highlight color =
    Css.mixin [ Css.backgroundColor color ]


toTextUpString : ( String, Maybe Color ) -> TextUp.TextUpString HighlightStyles
toTextUpString ( str, maybeColor ) =
    (,) str (maybeColorToAccessor maybeColor)


maybeColorToAccessor : Maybe Color -> (TextUp.Config HighlightStyles -> Css.Mixin)
maybeColorToAccessor maybeColor =
    maybeColor
        |> Maybe.map colorToAccessor
        |> Maybe.withDefault .plain


colorToAccessor : Color -> (TextUp.Config HighlightStyles -> Css.Mixin)
colorToAccessor color =
    case color of
        Yellow ->
            .yellow

        Blue ->
            .blue

        Green ->
            .green

        Pink ->
            .pink

        Red ->
            .red


highlightColors : List Color
highlightColors =
    [ Yellow
    , Blue
    , Green
    , Pink
    , Red
    ]


maybeColorToString : Maybe Color -> String
maybeColorToString maybeColor =
    maybeColor
        |> Maybe.map colorToString
        |> Maybe.withDefault "Default"


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


setStylesByStringColor : String -> Css.Mixin -> TextUp.Config HighlightStyles -> TextUp.Config HighlightStyles
setStylesByStringColor color styles current =
    case color of
        "Yellow" ->
            { current | yellow = styles }

        "Blue" ->
            { current | blue = styles }

        "Green" ->
            { current | green = styles }

        "Pink" ->
            { current | pink = styles }

        "Red" ->
            { current | red = styles }

        _ ->
            { current | plain = styles }


getStyles : Dict.Dict String (List ( String, String )) -> TextUp.Config HighlightStyles
getStyles styles =
    styles
        |> Dict.toList
        |> List.foldl
            (\( color, colorStyles ) allStyles ->
                setStylesByStringColor color (toMixin colorStyles) allStyles
            )
            plainStyles


toMixin : List ( String, String ) -> Css.Mixin
toMixin styles =
    styles
        |> List.map (uncurry Css.property)
        |> Css.mixin
