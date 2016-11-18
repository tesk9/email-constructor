module Update exposing (Msg(..), update)

import Components.Draft as Draft
import Components.Highlighting as Highlighting
import Model exposing (Model, UiState(..))
import SaveAble


type Msg
    = NoOp
    | EnterHighlightingMode
    | DraftMsg Draft.Msg
    | HighlightingMsg Highlighting.Msg


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        EnterHighlightingMode ->
            case model.uiState of
                EnteringText data ->
                    { model
                        | uiState =
                            SelectingSegments
                                { fragments =
                                    ( Maybe.withDefault "" (SaveAble.toMaybe data.draft)
                                    , Nothing
                                    )
                                        :: []
                                , draft = data.draft
                                }
                    }
                        ! []

                SelectingSegments data ->
                    Debug.crash "Cannot advance beyond this step; todo: handle better."

        DraftMsg draftMsg ->
            case model.uiState of
                EnteringText data ->
                    Draft.update draftMsg data
                        |> (\( newData, cmds ) ->
                                ( { model | uiState = EnteringText newData }
                                , Cmd.map DraftMsg cmds
                                )
                           )

                _ ->
                    model ! []

        HighlightingMsg highlightingMsg ->
            case model.uiState of
                SelectingSegments data ->
                    Highlighting.update highlightingMsg data
                        |> (\( newData, cmds ) ->
                                ( { model | uiState = SelectingSegments newData }
                                , Cmd.map HighlightingMsg cmds
                                )
                           )

                _ ->
                    model ! []
