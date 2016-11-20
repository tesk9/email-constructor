module Components.Main.Model exposing (Flags, Model, init)

import Components.Highlighting as Highlighting
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import Dict
import TextUp
import Theme.Mixins as Mixins


type alias Flags =
    {}


type alias Model a =
    { uiState : UiState.UiState
    , styles : TextUp.Config a
    , draft : SaveAble.SaveAble String
    , fragments : List ( Int, String )
    , highlightedFragments : Dict.Dict Int Highlighting.Color
    , error : Maybe String
    }


init : Flags -> Model {}
init flags =
    { uiState = UiState.EnteringText
    , styles = { plain = Mixins.preserveWhiteSpace }
    , draft = SaveAble.new
    , fragments = []
    , highlightedFragments = Dict.empty
    , error = Nothing
    }
