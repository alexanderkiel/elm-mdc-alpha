port module Main exposing (Model)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Material.Button as Button
import Material.Icon as Icon
import Material.LayoutGrid as Grid
import Material.Options as Options
import Material.TextField as TextField
import Material.TextField.HelperText as HelperText
import Parser as Parser exposing (..)
import Url exposing (Url)
import Url.Parser as UrlParser


type alias Model =
    { counter : Int
    , buttonDisabled : Bool
    , textFieldModel : TextField.SimpleModel String
    , text : Maybe String
    }


initModel : Int -> Model
initModel flags =
    let
        initTextField =
            TextField.init parser identity Nothing
    in
    { counter = flags
    , buttonDisabled = False
    , textFieldModel = initTextField
    , text = Nothing
    }


init : Int -> ( Model, Cmd Msg )
init flags =
    ( initModel flags, Cmd.none )


type Msg
    = Inc
    | Set Int
    | Fun (Int -> Int)
    | ChangedText TextField.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            ( updateCounter (\n -> n + 1) model, Cmd.none )

        Set newCounter ->
            ( updateCounter (\_ -> newCounter) model, Cmd.none )

        Fun f ->
            ( updateCounter f model, Cmd.none )

        ChangedText tfMsg ->
            ( { model | textFieldModel = TextField.update tfMsg model.textFieldModel }, Cmd.none )


updateCounter : (Int -> Int) -> Model -> Model
updateCounter f model =
    let
        newCounter =
            f model.counter
    in
    { model | counter = newCounter, buttonDisabled = modBy 2 newCounter == 0 }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header []
            [ img [ src "/images/logo.png" ] []
            , span [ class "elm-bkg" ] []
            , h1 [] [ text "Elm MDC alpha" ]
            ]
        , Grid.view []
            [ Grid.cell [ Grid.span 2 ]
                [ Button.view
                    [ Options.onClick (Fun (\n -> n - 1))
                    , Button.raised
                    , Button.dense
                    , Button.icon "remove"
                    ]
                    []
                ]
            , Grid.cell [ Grid.span 1 ]
                [ text <| String.fromInt model.counter
                ]
            , Grid.cell [ Grid.span 2 ]
                [ Button.view
                    [ Options.onClick (Fun (\n -> n + 1))
                    , Button.raised
                    , Button.dense
                    , Button.icon "add"
                    ]
                    []
                ]
            , Grid.cell [ Grid.span 2 ]
                [ Button.view
                    [ Options.onClick (Fun (\n -> 0))
                    , Button.raised
                    , Button.dense
                    , Button.icon "refresh"
                    , Button.disabled model.buttonDisabled
                    ]
                    []
                ]
            ]
        , Grid.view []
            [ Grid.cell [ Grid.span 8 ]
                [ myTextFieldView model
                ]
            ]
        ]


myTextFieldView : Model -> Html Msg
myTextFieldView { textFieldModel } =
    Html.div []
        [ TextField.view
            { lift = ChangedText, printer = identity }
            textFieldModel
            [ TextField.label "Label of input"

            -- grab whole space
            , Options.style "display" "block"
            , Options.id "id456"

            -- , TextField.leadingIcon "add"
            , TextField.trailingIcon "remove"

            -- TODO: TextField.outlined => label does not work correct atm
            ]
            [ Icon.view [] "add" ]
        , HelperText.view
            [ HelperText.persistent
            , HelperText.validationMsg |> Options.when (not <| List.isEmpty textFieldModel.parseError)
            ]
            [ case textFieldModel.parseError of
                [] ->
                    Html.text "Helper text"

                es ->
                    Html.text <| "Invalid. Expecting a decimal number."
            ]
        ]


parser : Parser.Parser String
parser =
    Parser.succeed identity
        |= Parser.oneOf
            [ Parser.end |> Parser.map (\_ -> "")
            , Parser.int |> Parser.map (\n -> String.fromInt n)
            ]
        |. Parser.end


main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Elm MDC example"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
