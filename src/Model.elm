module Model exposing (Flags, Model, init)

import Components.Highlighting as Highlighting
import SaveAble
import TextUp
import Styles
import UiState


type alias Flags =
    {}


type alias Model a =
    { uiState : UiState.UiState
    , styles : TextUp.Config a
    , draft : SaveAble.SaveAble String
    , fragments : SaveAble.SaveAble (List ( String, Maybe Highlighting.Color ))
    , error : Maybe String
    }


init : Flags -> Model {}
init flags =
    { uiState = UiState.EnteringText
    , styles = { plain = Styles.preserveWhiteSpace }
    , draft = SaveAble.new
    , fragments = SaveAble.new
    , error = Nothing
    }
