module Components.Draft exposing (Model, update, Msg(..), view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SaveAble
import Styles


type alias Model =
    { draft : SaveAble.SaveAble String
    , error : Maybe String
    }


type Msg
    = NoOp
    | InputDraft String
    | SaveDraft


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        InputDraft value ->
            { model | draft = SaveAble.draft value } ! []

        SaveDraft ->
            case SaveAble.save model.draft of
                Just savedDraft ->
                    { model | draft = savedDraft } ! []

                Nothing ->
                    { model | error = Just "Please input your draft." } ! []


view : Model -> Html Msg
view model =
    if SaveAble.isSaved model.draft then
        viewSaved (SaveAble.toMaybe model.draft)
    else
        viewInput (SaveAble.toMaybe model.draft) model.error


viewSaved : Maybe String -> Html msg
viewSaved maybeValue =
    span [ Styles.class [ Styles.PreserveWhiteSpace ] ] [ text (Maybe.withDefault "" maybeValue) ]


viewInput : Maybe String -> Maybe String -> Html Msg
viewInput maybeValue maybeError =
    div
        []
        [ hr [] []
        , label []
            [ text "Draft"
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
