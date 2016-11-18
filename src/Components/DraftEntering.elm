module Components.DraftEntering exposing (Model, update, Msg(..), view, viewSaveDraft, viewEditDraft)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SaveAble


type alias Model a =
    { a
        | draft : SaveAble.SaveAble String
        , error : Maybe String
    }


type Msg
    = NoOp
    | InputDraft String
    | SaveDraft
    | EditDraft


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        InputDraft value ->
            { model | draft = SaveAble.draft value, error = Nothing } ! []

        SaveDraft ->
            case SaveAble.save model.draft of
                Just savedDraft ->
                    { model | draft = savedDraft } ! []

                Nothing ->
                    { model | error = Just "Please input your draft." } ! []

        EditDraft ->
            case SaveAble.edit model.draft of
                Just editingDraft ->
                    { model | draft = editingDraft } ! []

                Nothing ->
                    { model | error = Just "Sorry, you can't edit that." } ! []


view : Maybe String -> Maybe String -> Html Msg
view maybeValue maybeError =
    div
        []
        [ hr [] []
        , viewDraftInput maybeValue
        , perhapsViewError maybeError
        , viewSaveDraft
        ]


viewDraftInput : Maybe String -> Html Msg
viewDraftInput maybeValue =
    label []
        [ h4 [] [ text "Draft" ]
        , textarea
            [ onInput InputDraft
            , placeholder "Enter your draft here..."
            , value <| (Maybe.withDefault "") maybeValue
            ]
            []
        ]


viewEditDraft : Html Msg
viewEditDraft =
    div []
        [ button
            [ onClick EditDraft
            ]
            [ text "Edit" ]
        ]


viewSaveDraft : Html Msg
viewSaveDraft =
    div []
        [ button
            [ onClick SaveDraft
            ]
            [ text "Save" ]
        ]


perhapsViewError : Maybe String -> Html msg
perhapsViewError maybeError =
    maybeError
        |> Maybe.map
            (\error ->
                div [] [ text error ]
            )
        |> Maybe.withDefault (text "")
