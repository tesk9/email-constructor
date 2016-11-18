module Components.WorkSpace exposing (..)

import Components.DraftEntering as DraftEntering
import Components.Highlighting as Highlighting
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import SaveAble
import Styles
import UiState
import Update exposing (Msg)


view : Model a -> Html Msg
view model =
    case model.uiState of
        UiState.EnteringText ->
            if SaveAble.isSaved model.draft then
                viewSaved ((SaveAble.toMaybe >> Maybe.withDefault "") model.draft)
            else
                DraftEntering.view (SaveAble.toMaybe model.draft) model.error
                    |> Html.map Update.DraftMsg

        UiState.SelectingSegments ->
            SaveAble.toMaybe model.fragments
                |> Maybe.withDefault []
                |> Highlighting.view
                |> Html.map Update.HighlightingMsg


viewSaved : String -> Html Msg
viewSaved value =
    div []
        [ hr [] []
        , h4 [] [ text "Writing Sample" ]
        , viewSavedDraft value
        , DraftEntering.viewEditDraft |> Html.map Update.DraftMsg
        , viewEnterHighlighter
        ]


viewSavedDraft : String -> Html msg
viewSavedDraft value =
    div [ Styles.class [ Styles.SavedDraft ] ]
        [ text value ]


viewEnterHighlighter : Html Msg
viewEnterHighlighter =
    button [ onClick Update.EnterHighlighterMode ]
        [ img [ alt "Pencil" ] [] ]
