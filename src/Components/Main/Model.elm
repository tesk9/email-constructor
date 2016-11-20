module Components.Main.Model exposing (Flags, Model, init)

import Components.Highlighting as Highlighting
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import TextUp
import Theme.Styles as Styles


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
