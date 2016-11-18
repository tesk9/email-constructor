module Update exposing (Msg(..), update)

import Components.DraftEntering as Draft
import Components.Highlighting as Highlighting
import Model exposing (Model)
import UiState
import Utils exposing (tuple2)


type Msg
    = NoOp
    | EnterHighlighterMode
    | DraftMsg Draft.Msg
    | HighlightingMsg Highlighting.Msg


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        EnterHighlighterMode ->
            { model | uiState = UiState.SelectingSegments } ! []

        DraftMsg draftMsg ->
            Draft.update draftMsg model
                |> tuple2 (Cmd.map DraftMsg)

        HighlightingMsg highlightingMsg ->
            Highlighting.update highlightingMsg model
                |> tuple2 (Cmd.map HighlightingMsg)
