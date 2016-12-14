module Components.SegmentStyling exposing (Model, view, update, Msg)

import Data.HighlighterColor exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import TextUp
import Theme.Styles as Styles


type alias Model a =
    { a
        | fragments : List ( Int, String )
        , highlightedFragments : Dict.Dict Int Color
        , styles : Dict.Dict String (List ( String, String ))
    }


type Msg
    = NoOp


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


view : Model a -> Html Msg
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


viewStylesBySelectionColor : Dict.Dict String (List ( String, String )) -> List Color -> Html Msg
viewStylesBySelectionColor styles colors =
    colors
        |> List.map Just
        |> (::) Nothing
        |> List.map (viewStyleBySelectionColor styles)
        |> ul []


viewStyleBySelectionColor : Dict.Dict String (List ( String, String )) -> Maybe Color -> Html Msg
viewStyleBySelectionColor styles maybeColor =
    let
        colorString =
            maybeColorToString maybeColor
    in
        li []
            [ h5 [] [ text colorString ]
            , viewStyleInputs colorString <| Maybe.withDefault [] <| Dict.get colorString styles
            , hr [] []
            ]


viewStyleInputs : String -> List ( String, String ) -> Html msg
viewStyleInputs colorString styles =
    ul [] <|
        viewStyleInput (colorString ++ "new") ( "", "" )
            :: List.indexedMap
                (\id styleTuple ->
                    viewStyleInput (colorString ++ toString id) styleTuple
                )
                styles


viewStyleInput : String -> ( String, String ) -> Html msg
viewStyleInput idBase ( property, val ) =
    li []
        [ label
            [ for ("input-" ++ idBase ++ "-property") ]
            [ text "Property" ]
        , input
            [ id ("input-" ++ idBase ++ "-property")
            , value property
            , placeholder "font-family"
            ]
            []
        , label
            [ for ("input-" ++ idBase ++ "-value") ]
            [ text "Value" ]
        , input
            [ id ("input-" ++ idBase ++ "-value")
            , value val
            , placeholder "fantasy"
            ]
            []
        ]
