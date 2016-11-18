module Model exposing (Flags, Model, init, UiState(..))

import Components.Draft as Draft
import SaveAble
import TextUp
import Styles


type alias Flags =
    {}


type alias Model a =
    { uiState : UiState
    , styles : TextUp.Config a
    }


type UiState
    = EnteringText Draft.Model


init : Flags -> Model {}
init flags =
    { uiState =
        EnteringText
            { draft = SaveAble.new
            , error = Nothing
            }
    , styles =
        { plain = Styles.preserveWhiteSpace
        }
    }