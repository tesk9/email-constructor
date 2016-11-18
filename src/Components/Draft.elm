module Components.Draft exposing (Model, update, Msg(..), view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SaveAble
import Styles
import UiState


type alias Model a =
    { a
        | draft : SaveAble.SaveAble String
        , error : Maybe String
        , uiState : UiState.UiState
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
                    { model | draft = savedDraft, uiState = UiState.SelectingSegments } ! []

                Nothing ->
                    { model | error = Just "Please input your draft." } ! []

        EditDraft ->
            case SaveAble.edit model.draft of
                Just editingDraft ->
                    { model | draft = editingDraft } ! []

                Nothing ->
                    { model | error = Just "Sorry, you can't edit that." } ! []


view : Model a -> Html Msg
view model =
    if SaveAble.isSaved model.draft then
        viewSaved ((SaveAble.toMaybe >> Maybe.withDefault "") model.draft)
    else
        viewInput (SaveAble.toMaybe model.draft) model.error


viewSaved : String -> Html Msg
viewSaved value =
    div [] <|
        [ hr [] []
        , h4 [] [ text "Writing Sample" ]
        , div [ Styles.class [ Styles.SavedDraft ] ]
            [ text value ]
        , div []
            [ button
                [ onClick EditDraft
                ]
                [ text "Edit" ]
            ]
        ]


viewInput : Maybe String -> Maybe String -> Html Msg
viewInput maybeValue maybeError =
    div
        []
        [ hr [] []
        , label []
            [ h4 [] [ text "Draft" ]
            , textarea
                [ onInput InputDraft
                , placeholder "Enter your draft here..."
                , value <| (Maybe.withDefault "") maybeValue
                ]
                []
            ]
        , perhapsViewError maybeError
        , div []
            [ button
                [ onClick SaveDraft
                ]
                [ text "Save" ]
            ]
        ]


perhapsViewError : Maybe String -> Html msg
perhapsViewError maybeError =
    maybeError
        |> Maybe.map
            (\error ->
                div [] [ text error ]
            )
        |> Maybe.withDefault (text "")
