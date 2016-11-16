module Styles exposing (css, CssClasses(..), class, classList, id, preserveWhiteSpace)

import Colors exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


defaultStyles : List Snippet
defaultStyles =
    [ selector "textarea"
        [ display block
        , property "resize" "vertical"
        , height (px 200)
        , width (pct 100)
        , border3 (px 2) solid blue3
        , color blue0
        , fontFamily serif
        , inputFocus
        ]
    , button
        [ borderRadius zero
        , border3 (px 2) solid blue4
        , backgroundColor mustard1
        , color blue4
        , margin2 (px 4) zero
        , inputFocus
        ]
    , hr
        [ border3 (px 1) solid clay2 ]
    ]


inputFocus : Mixin
inputFocus =
    mixin
        [ focus
            [ borderColor blue2
            , outline none
            ]
        ]


preserveWhiteSpace : Mixin
preserveWhiteSpace =
    mixin
        [ property "white-space" "pre-line"
        , property "word-wrap" "break-word"
        ]


type CssClasses
    = Page
    | PageHeader
    | Container
    | SectionContainer
    | SectionHeader
    | OutputContainer
    | PreserveWhiteSpace


styles : List Snippet
styles =
    [ (.) Page
        [ backgroundColor blue0
        , descendants
            [ everything
                [ fontFamily sansSerif
                , boxSizing borderBox
                , color blue4
                ]
            ]
        ]
    , (.)
        PageHeader
        [ textAlign center
        , marginTop zero
        , paddingTop (px 8)
        , color blue1
        ]
    , (.) Container
        [ displayFlex
        , property "justify-content" "space-around"
        ]
    , (.) SectionContainer
        [ minWidth (px 400)
        , padding (px 16)
        , firstChild
            [ backgroundColor clay0
            , color clay4
            ]
        , lastChild
            [ backgroundColor mustard0
            , color mustard4
            ]
        ]
    , (.) SectionHeader
        []
    , (.) OutputContainer
        [ property "width" "60vw"
        , property "min-height" "70vh"
        , border3 (px 2) solid mustard2
        , padding (px 8)
        , backgroundColor white
        ]
    , (.) PreserveWhiteSpace
        [ preserveWhiteSpace ]
    ]


css : String
css =
    (defaultStyles ++ styles)
        |> namespace currentNamespace.name
        |> stylesheet
        |> (\stylesheet -> [ stylesheet ])
        |> compile
        |> .css


{ class, classList, id } =
    currentNamespace


currentNamespace : Html.CssHelpers.Namespace String a b c
currentNamespace =
    withNamespace "constructor-"
