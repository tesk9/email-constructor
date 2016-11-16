module Main exposing (main)

import Html exposing (..)
import Html.CssHelpers
import Styles
import View.Controls as Controls
import View.Output as Output


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { update = update
        , view = view
        , init = init
        , subscriptions = \_ -> Sub.none
        }


type alias Flags =
    {}


type alias Model =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    flags
        |> update NoOp


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


view : Model -> Html Msg
view model =
    div [ Styles.class [ Styles.Page ] ]
        [ Html.CssHelpers.style Styles.css
        , h1 [ Styles.class [ Styles.PageHeader ] ] [ text "Email Constructor" ]
        , div
            [ Styles.class [ Styles.Container ] ]
            [ viewSection "CONTROLS SECTION" <| Controls.view {}
            , viewSection "OUTPUT SECTION" <| Output.view {}
            ]
        ]


viewSection : String -> Html msg -> Html msg
viewSection header contents =
    section []
        [ h2 [ Styles.class [ Styles.SectionHeader ] ] [ text header ]
        , contents
        ]
