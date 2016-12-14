module Components.Output exposing (Model, view)

import Data.HighlighterColor as Highlighter
import Dict
import Html exposing (..)
import TextUp
import Theme.Styles as Styles


type alias Model =
    { styles : Dict.Dict String (List ( String, String ))
    , draft : List (TextUp.TextUpString Highlighter.HighlightStyles)
    }


view : Model -> Html msg
view model =
    div []
        [ div [ Styles.class [ Styles.OutputContainer ] ]
            [ TextUp.toHtml (Highlighter.getStyles model.styles) model.draft
            ]
        ]
