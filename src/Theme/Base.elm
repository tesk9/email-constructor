module Theme.Base exposing (styles)

import Css exposing (..)
import Css.Elements exposing (..)
import Theme.Colors as Colors exposing (..)
import Theme.Mixins exposing (..)


styles : List Snippet
styles =
    [ selector "textarea"
        [ editingBox
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
    , everything
        [ fontFamily sansSerif
        , boxSizing borderBox
        , color blue4
        ]
    , ul
        [ textDecoration none
        , listStyle none
        , margin zero
        , padding zero
        ]
    , label
        [ fontSize (px 12)
        , marginRight (px 4)
        ]
    , input
        [ preserveWhiteSpace
        , marginRight (px 8)
        ]
    ]
