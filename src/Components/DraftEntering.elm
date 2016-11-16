module Components.DraftEntering exposing (Model, update, Msg(..), view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { draft : String }


type Msg
    = NoOp
    | InputDraft String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        InputDraft value ->
            { model | draft = value } ! []


view : Model -> Html Msg
view model =
    div []
        [ hr [] []
        , label []
            [ text "Draft"
            , textarea
                [ onInput InputDraft
                , placeholder "Enter your draft here..."
                ]
                []
            ]
        , div [] [ button [] [ text "Save" ] ]
        ]
