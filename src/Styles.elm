module Styles exposing (css, CssClasses(..), class, classList, id)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = Page
    | PageHeader
    | Container
    | SectionHeader


styles : List Snippet
styles =
    [ (.) Page
        [ fontFamily sansSerif
        , boxSizing borderBox
        ]
    , (.)
        PageHeader
        [ textAlign center ]
    , (.) Container
        [ displayFlex
        , property "justify-content" "space-around"
        ]
    , (.) SectionHeader
        []
    ]


css : String
css =
    styles
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
