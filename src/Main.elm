module Main exposing (main)

import Css
import Html exposing (..)
import Html.CssHelpers
import Styles
import Components.DraftEntering as DraftEntering
import Components.Output as Output
import TextUp


main : Program Flags (Model {}) Msg
main =
    Html.programWithFlags
        { update = update
        , view = view
        , init = init
        , subscriptions = \_ -> Sub.none
        }


type alias Flags =
    {}


type alias Model a =
    { uiState : UiState
    , styles : TextUp.Config a
    }


type UiState
    = EnteringText DraftEntering.Model


init : Flags -> ( Model {}, Cmd Msg )
init flags =
    { uiState = EnteringText { draft = "" }
    , styles =
        { plain =
            Css.mixin
                [ Css.property "white-space" "pre-line"
                , Css.property "word-wrap" "break-word"
                ]
        }
    }
        |> update NoOp


type Msg
    = NoOp
    | DraftEnteringMsg DraftEntering.Msg


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        DraftEnteringMsg draftMsg ->
            case model.uiState of
                EnteringText data ->
                    DraftEntering.update draftMsg data
                        |> (\( newData, cmds ) ->
                                ( { model | uiState = EnteringText newData }
                                , Cmd.map DraftEnteringMsg cmds
                                )
                           )


view : Model a -> Html Msg
view model =
    div [ Styles.class [ Styles.Page ] ]
        [ Html.CssHelpers.style Styles.css
        , h1 [ Styles.class [ Styles.PageHeader ] ] [ text "Email Constructor" ]
        , div [ Styles.class [ Styles.Container ] ] <|
            case model.uiState of
                EnteringText data ->
                    [ viewSection "CONTROLS SECTION" <|
                        Html.map DraftEnteringMsg <|
                            DraftEntering.view data
                    , viewSection "OUTPUT SECTION" <|
                        Output.view
                            { draft = [ ( data.draft, .plain ) ]
                            , styles = model.styles
                            }
                    ]
        ]


viewSection : String -> Html msg -> Html msg
viewSection header contents =
    section [ Styles.class [ Styles.SectionContainer ] ]
        [ h2 [ Styles.class [ Styles.SectionHeader ] ] [ text header ]
        , contents
        ]
