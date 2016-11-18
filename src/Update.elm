module Update exposing (Msg(..), update)

import Components.Draft as Draft
import Components.Highlighting as Highlighting
import Model exposing (Model)
import Utils exposing (tuple2)


type Msg
    = NoOp
    | DraftMsg Draft.Msg
    | HighlightingMsg Highlighting.Msg


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        DraftMsg draftMsg ->
            Draft.update draftMsg model
                |> tuple2 (Cmd.map DraftMsg)

        HighlightingMsg highlightingMsg ->
            Highlighting.update highlightingMsg model
                |> tuple2 (Cmd.map HighlightingMsg)
