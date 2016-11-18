module Update exposing (Msg(NoOp, DraftMsg), update)

import Components.Draft as Draft
import Model exposing (Model, UiState(..))


type Msg
    = NoOp
    | DraftMsg Draft.Msg


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        DraftMsg draftMsg ->
            case model.uiState of
                EnteringText data ->
                    Draft.update draftMsg data
                        |> (\( newData, cmds ) ->
                                ( { model | uiState = EnteringText newData }
                                , Cmd.map DraftMsg cmds
                                )
                           )
