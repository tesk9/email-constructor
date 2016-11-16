module Components.Output exposing (Model, view)

import Html exposing (..)
import Styles
import TextUp


type alias Model a =
    { styles : TextUp.Config a
    , draft : List (TextUp.TextUpString a)
    }


view : Model a -> Html msg
view model =
    div []
        [ div [ Styles.class [ Styles.OutputContainer ] ]
            [ TextUp.toHtml model.styles model.draft
            ]
        ]
