module Components.Output exposing (Model, view)

import Html exposing (..)
import TextUp


type alias Model a =
    { styles : TextUp.Config a
    , draft : List (TextUp.TextUpString a)
    }


view : Model a -> Html msg
view model =
    TextUp.toHtml model.styles model.draft
