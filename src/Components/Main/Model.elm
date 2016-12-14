module Components.Main.Model exposing (Flags, Model, init)

import Data.HighlighterColor as Highlighter
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import Dict


type alias Flags =
    {}


type alias Model =
    { uiState : UiState.UiState
    , styles : Dict.Dict String (List ( String, String ))
    , draft : SaveAble.SaveAble String
    , fragments : List ( Int, String )
    , highlightedFragments : Dict.Dict Int Highlighter.Color
    , highlighterColor : Highlighter.Color
    , error : Maybe String
    }


init : Flags -> Model
init flags =
    { uiState = UiState.EnteringText
    , styles = Dict.empty
    , draft = SaveAble.new
    , fragments = []
    , highlightedFragments = Dict.empty
    , highlighterColor = Highlighter.Yellow
    , error = Nothing
    }
