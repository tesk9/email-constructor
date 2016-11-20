module Theme.Mixins exposing (..)

import Css exposing (..)
import Theme.Colors as Colors exposing (..)


editingBox : Mixin
editingBox =
    mixin
        [ display block
        , property "resize" "vertical"
        , height (px 200)
        , width (pct 100)
        , border3 (px 2) solid blue3
        , backgroundColor mustard1
        , color blue0
        , fontFamily serif
        , padding (px 4)
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
