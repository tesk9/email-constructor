module Main exposing (main)

import Css
import Html exposing (..)
import Html.CssHelpers
import Styles
import Components.Draft as Draft
import Components.Output as Output
import SaveAble
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
    = EnteringText Draft.Model


init : Flags -> ( Model {}, Cmd Msg )
init flags =
    { uiState =
        EnteringText
            { draft = SaveAble.new
            , error = Nothing
            }
    , styles =
        { plain = Styles.preserveWhiteSpace
        }
    }
        |> update NoOp


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


view : Model a -> Html Msg
view model =
    div [ Styles.class [ Styles.Page ] ]
        [ Html.CssHelpers.style Styles.css
        , h1 [ Styles.class [ Styles.PageHeader ] ] [ text "Email Constructor" ]
        , div [ Styles.class [ Styles.Container ] ] <|
            case model.uiState of
                EnteringText data ->
                    [ viewSection "CONTROLS SECTION" <|
                        Html.map DraftMsg <|
                            Draft.view data
                    , viewSection "OUTPUT SECTION" <|
                        Output.view
                            { draft =
                                SaveAble.map (\draft -> [ ( draft, .plain ) ]) data.draft
                                    |> SaveAble.toMaybe
                                    |> Maybe.withDefault []
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
