module Theme.Styles exposing (css, CssClasses(..), class, classList, id)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import Theme.Base as Base
import Theme.Colors as Colors exposing (..)
import Theme.Mixins as Mixins exposing (..)


type CssClasses
    = Page
    | PageHeader
    | Container
    | SectionContainer
    | SectionHeader
    | OutputContainer
    | SavedDraft
    | HighlightingBox
    | HighlightingOptions


styles : List Snippet
styles =
    [ (.) Page
        [ backgroundColor blue0
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
        [ minWidth (px 500)
        , padding (px 16)
        , margin2 zero (px 20)
        , firstChild
            [ backgroundColor clay0
            , flexGrow (num 2)
            , color clay4
            ]
        , lastChild
            [ backgroundColor mustard0
            , maxWidth (px 500)
            , color mustard4
            ]
        ]
    , (.) SectionHeader
        []
    , (.) OutputContainer
        [ property "min-height" "70vh"
        , border3 (px 2) solid mustard2
        , padding (px 8)
        , backgroundColor white
        , preserveWhiteSpace
        ]
    , (.) SavedDraft
        [ minHeight (px 200)
        , border3 (px 2) solid blue3
        , fontFamily serif
        , preserveWhiteSpace
        , fontSize (px 12)
        , color blue4
        , padding (px 4)
        ]
    , (.) HighlightingBox
        [ editingBox
        ]
    , (.) HighlightingOptions
        [ displayFlex
        , property "justify-content" "space-between"
        ]
    ]


css : String
css =
    (Base.styles ++ styles)
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
