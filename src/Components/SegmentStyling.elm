module Components.SegmentStyling exposing (Model, view, update, Msg)

import Data.HighlighterColor exposing (..)
import Dict
import Html exposing (..)
import TextUp
import Theme.Styles as Styles


type alias Model a b =
    { a
        | fragments : List ( Int, String )
        , highlightedFragments : Dict.Dict Int Color
        , styles : TextUp.Config b
    }


type Msg
    = NoOp


update : Msg -> Model a b -> ( Model a b, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


view : Model a b -> Html Msg
view model =
    div []
        [ hr [] []
        , h4 [] [ text "Segment Styling" ]
        , model.fragments
            |> List.map
                (\( id, content ) ->
                    { id = id
                    , content = content
                    , color = Dict.get id model.highlightedFragments
                    }
                )
            |> viewFragments
        , viewStylesBySelectionColor model.styles (Dict.values model.highlightedFragments)
        ]


viewFragments : List { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragments fragments =
    div [ Styles.class [ Styles.HighlightingBox ] ] <|
        List.map viewFragment fragments


viewFragment : { a | id : Int, content : String, color : Maybe Color } -> Html Msg
viewFragment fragment =
    span []
        [ TextUp.toHtml highlightStyles [ toTextUpString ( fragment.content, fragment.color ) ] ]


viewStylesBySelectionColor : TextUp.Config b -> List Color -> Html Msg
viewStylesBySelectionColor styles colors =
    ul [] <|
        List.map (viewStyleBySelectionColor styles) colors


viewStyleBySelectionColor : TextUp.Config b -> Color -> Html Msg
viewStyleBySelectionColor styles color =
    li []
        [ h4 [] [ text <| colorToString color ]
        , hr [] []
        ]
