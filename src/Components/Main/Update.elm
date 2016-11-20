module Components.Main.Update exposing (Msg(..), update)

import Components.DraftEntering as Draft
import Components.Highlighting as Highlighting
import Components.Main.Model as Model exposing (Model)
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import String
import Utils.ViewUtils exposing (tuple2)


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
            { model
                | uiState = UiState.SelectingSegments
                , fragments =
                    if SaveAble.wasEverSaved model.fragments then
                        model.fragments
                    else
                        model.draft
                            |> SaveAble.toMaybe
                            |> Maybe.map
                                (\draft ->
                                    String.words draft
                                        |> List.intersperse " "
                                        |> List.map (flip (,) Nothing)
                                        |> SaveAble.draft
                                )
                            |> Maybe.withDefault model.fragments
            }
                ! []

        DraftMsg draftMsg ->
            Draft.update draftMsg model
                |> tuple2 (Cmd.map DraftMsg)

        HighlightingMsg highlightingMsg ->
            Highlighting.update highlightingMsg model
                |> tuple2 (Cmd.map HighlightingMsg)
