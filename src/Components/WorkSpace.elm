module Components.WorkSpace exposing (view)

import Components.DraftEntering as DraftEntering
import Components.Highlighting as Highlighting
import Components.Main.Model as Model exposing (Model)
import Components.Main.Update as Update exposing (Msg)
import Components.SegmentStyling as SegmentStyling
import Data.SaveAble as SaveAble
import Data.UiState as UiState
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Theme.Styles as Styles


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
            div []
                [ model
                    |> Highlighting.view
                    |> Html.map Update.HighlightingMsg
                , viewExitHighlighter
                ]

        UiState.SetSegmentStyles ->
            model
                |> SegmentStyling.view
                |> Html.map Update.SegmentStylingMsg


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
        [ img [ alt "Highlighter Icon" ] [] ]


viewExitHighlighter : Html Msg
viewExitHighlighter =
    button [ onClick Update.ExitHighlighterMode ]
        [ text "Finish Highlighting" ]
