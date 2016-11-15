module Styles exposing (css, CssClasses(..))

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = Container


styles : List Snippet
styles =
    []


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
