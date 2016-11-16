module Styles exposing (css, CssClasses(..), class, classList, id)

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
    ]


inputFocus : Mixin
inputFocus =
    mixin
        [ focus
            [ borderColor blue2
            , outline none
            ]
        ]


type CssClasses
    = Page
    | PageHeader
    | Container
    | SectionContainer
    | SectionHeader
    | OutputContainer


styles : List Snippet
styles =
    [ (.) Page
        [ fontFamily sansSerif
        , boxSizing borderBox
        , color blue4
        ]
    , (.)
        PageHeader
        [ textAlign center ]
    , (.) Container
        [ displayFlex
        , property "justify-content" "space-around"
        ]
    , (.) SectionContainer
        [ minWidth (px 400) ]
    , (.) SectionHeader
        []
    , (.) OutputContainer
        [ maxWidth (px 400)
        ]
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
