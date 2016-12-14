module Components.SegmentStyling exposing (Model, view, update, Msg)

import Data.HighlighterColor exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import TextUp
import Theme.Styles as Styles
import Utils.Utils exposing (dictInsertUpdate)
import Utils.ViewUtils exposing (onChange, onEnter)


type alias Model a =
    { a
        | fragments : List ( Int, String )
        , highlightedFragments : Dict.Dict Int Color
        , styles : Dict.Dict String (List ( String, String ))
    }


type Msg
    = NoOp
    | SetStyle String Int ( String, String )


update : Msg -> Model a -> ( Model a, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SetStyle colorString index style ->
            let
                --TODO use a dict instead of a list
                updateStylesById styles =
                    if index == List.length styles then
                        (::) style styles
                    else
                        List.indexedMap
                            (\id value ->
                                if id == index then
                                    style
                                else
                                    value
                            )
                            styles

                newStyles =
                    dictInsertUpdate colorString style (Maybe.map updateStylesById) model.styles
            in
                { model | styles = newStyles } ! []


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


viewStyleInputs : String -> List ( String, String ) -> Html Msg
viewStyleInputs colorString styles =
    ul [] <|
        List.reverse <|
            viewStyleInput (List.length styles) colorString ( "", "" )
                :: List.indexedMap
                    (\id styleTuple ->
                        viewStyleInput id colorString styleTuple
                    )
                    styles


viewStyleInput : Int -> String -> ( String, String ) -> Html Msg
viewStyleInput index colorString ( property, val ) =
    let
        idBase =
            "input-" ++ colorString ++ "-" ++ toString index

        propertyId =
            idBase ++ "-property"

        valueId =
            idBase ++ "-value"
    in
        li []
            [ label
                [ for propertyId ]
                [ text "Property" ]
            , input
                [ id propertyId
                , value property
                , placeholder "font-family"
                , onChange (\newProperty -> SetStyle colorString index ( newProperty, val ))
                ]
                []
            , label
                [ for valueId
                ]
                [ text "Value" ]
            , input
                [ id valueId
                , value val
                , placeholder "fantasy"
                , onChange (\newVal -> SetStyle colorString index ( property, newVal ))
                ]
                []
            ]
