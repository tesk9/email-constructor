module Components.Highlighting exposing (Model, update, Msg, view)

import Data.HighlighterColor exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TextUp
import Theme.Styles as Styles
import Utils.Utils as Utils
import Utils.ViewUtils as ViewUtils exposing (radio, onChange)


type alias Model a =
    { a
        | fragments : List ( Int, String )
        , highlightedFragments : Dict.Dict Int Color
        , highlighterColor : Color
    }


type Msg
    = NoOp
    | Highlight Int Color
    | SetHighlighterColor Color


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Highlight index color ->
            { model
                | highlightedFragments =
                    Utils.dictToggleOrReplace index color model.highlightedFragments
            }
                ! []

        SetHighlighterColor color ->
            { model | highlighterColor = color } ! []


view : Model a -> Html Msg
view model =
    div []
        [ hr [] []
        , h4 [] [ text "Highlighting" ]
        , model.fragments
            |> List.map
                (\( id, content ) ->
                    { id = id
                    , content = content
                    , color = Dict.get id model.highlightedFragments
                    }
                )
            |> viewFragments model.highlighterColor
        , viewHighlighterColorSelector model.highlighterColor
        ]


viewFragments : Color -> List { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragments color fragments =
    div [ Styles.class [ Styles.HighlightingBox ] ] <|
        List.map (viewFragment color) fragments


viewFragment : Color -> { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragment color fragment =
    span [ onClick (Highlight fragment.id color) ]
        [ TextUp.toHtml highlightStyles [ toTextUpString ( fragment.content, fragment.color ) ] ]


viewHighlighterColorSelector : Color -> Html Msg
viewHighlighterColorSelector color =
    Html.form [] (List.map (viewHighlighterColorRadio color) highlightColors)


viewHighlighterColorRadio : Color -> Color -> Html Msg
viewHighlighterColorRadio selectedColor color =
    let
        colorName =
            colorToString color

        id_ =
            "radio-" ++ colorName
    in
        span []
            [ label [ for id_ ] [ text colorName ]
            , radio
                [ selected (selectedColor == color)
                , id id_
                , name "highlighting color"
                , onChange (\_ -> SetHighlighterColor color)
                ]
                []
            ]
