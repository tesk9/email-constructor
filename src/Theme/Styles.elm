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
        [ minWidth (px 400)
        , padding (px 16)
        , firstChild
            [ backgroundColor clay0
            , maxWidth (px 400)
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
