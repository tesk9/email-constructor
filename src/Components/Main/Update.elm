module Components.Main.Update exposing (Msg(..), update)

import Components.DraftEntering as Draft
import Components.Highlighting as Highlighting
import Components.Main.Model as Model exposing (Model)
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import Data.HighlighterColor as Highlighter
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
                    model.draft
                        |> SaveAble.toMaybe
                        |> Maybe.map
                            (String.words
                                >> List.intersperse " "
                                >> List.indexedMap (,)
                            )
                        |> Maybe.withDefault []
            }
                ! []

        DraftMsg draftMsg ->
            Draft.update draftMsg model
                |> tuple2 (Cmd.map DraftMsg)

        HighlightingMsg highlightingMsg ->
            Highlighting.update highlightingMsg model
                |> tuple2 (Cmd.map HighlightingMsg)
