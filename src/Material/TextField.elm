module Material.TextField exposing
    ( Model
    , Msg
    , fullWidth
    , init
    , label
    , outlined
    , update
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Internal.Options as Options exposing (class, styled, when)
import Parser exposing (Parser)



---- MODEL --------------------------------------------------------------------


type alias Model value =
    { focused : Bool
    , parser : Parser value
    , value : Maybe value
    , parseError : Maybe (List Parser.DeadEnd)
    , input : Maybe String
    }


init : Parser value -> Maybe value -> Model value
init parser value =
    { focused = False
    , parser = parser
    , value = value
    , parseError = Nothing
    , input = Nothing
    }



---- UPDATE -------------------------------------------------------------------


type Msg
    = Focus
    | Blur
    | Input String


update : Msg -> Model value -> Model value
update msg model =
    case msg of
        Focus ->
            { model | focused = True }

        Blur ->
            { model | focused = False }

        Input str ->
            let
                ( val, parseError ) =
                    case Parser.run model.parser str of
                        Ok v ->
                            ( Just v, Nothing )

                        Err err ->
                            ( Nothing, Just err )
            in
            { model | input = Just str, value = val, parseError = parseError }



---- VIEW ---------------------------------------------------------------------


type alias Config =
    { labelText : Maybe String
    , labelFloat : Bool
    , value : Maybe String
    , defaultValue : Maybe String
    , disabled : Bool
    , dense : Bool
    , required : Bool
    , type_ : String
    , box : Bool
    , textarea : Bool
    , fullWidth : Bool
    , invalid : Bool
    , outlined : Bool
    , leadingIcon : Maybe String
    , trailingIcon : Maybe String
    , iconClickable : Bool
    , placeholder : Maybe String
    , cols : Maybe Int
    , rows : Maybe Int
    , id : Maybe String
    }


defaultConfig : Config
defaultConfig =
    { labelText = Nothing
    , labelFloat = False
    , value = Nothing
    , defaultValue = Nothing
    , disabled = False
    , dense = False
    , required = False
    , type_ = "text"
    , box = False
    , textarea = False
    , fullWidth = False
    , invalid = False
    , outlined = False
    , leadingIcon = Nothing
    , trailingIcon = Nothing
    , iconClickable = True
    , placeholder = Nothing
    , cols = Nothing
    , rows = Nothing
    , id = Nothing
    }


type alias Property msg =
    Options.Property Config msg


view : (Msg -> msg) -> Model value -> List (Property msg) -> List (Html msg) -> Html msg
view lift model properties _ =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties

        focused =
            model.focused && not config.disabled

        isDirty =
            Maybe.map ((/=) "") model.input
                |> Maybe.withDefault False

        isInvalid =
            model.parseError
                |> Maybe.map (\_ -> True)
                |> Maybe.withDefault False

        finalValue =
            case model.input of
                Just val ->
                    val

                Nothing ->
                    Maybe.withDefault "" config.value
    in
    Options.apply
        summary
        Html.div
        [ class "mdc-text-field"
        , class "mdc-text-field--focused" |> when focused
        , class "mdc-text-field--disabled" |> when config.disabled
        , class "mdc-text-field--dense" |> when config.dense
        , class "mdc-text-field--fullwidth" |> when config.fullWidth
        , class "mdc-text-field--invalid" |> when isInvalid
        , class "mdc-text-field--textarea" |> when config.textarea
        , class "mdc-text-field--outlined" |> when config.outlined
        ]
        []
        [ styled
            (if config.textarea then
                Html.textarea

             else
                Html.input
            )
            [ class "mdc-text-field__input"
            , Maybe.map Options.id config.id
                |> Maybe.withDefault Options.noOp
            , when (not config.textarea) <|
                Options.attribute (Attr.type_ config.type_)
            , Options.attribute <| Attr.value finalValue
            , Options.onInput <| (lift << Input)
            , Options.onFocus <| lift Focus
            , Options.onBlur <| lift Blur
            ]
            []
        , if not config.fullWidth then
            styled
                Html.label
                [ Options.class "mdc-floating-label"
                , Options.class "mdc-floating-label--float-above"
                    |> when (focused || isDirty)
                , Maybe.map Options.for config.id
                    |> Maybe.withDefault Options.noOp
                ]
                (case config.labelText of
                    Just str ->
                        [ Html.text str ]

                    Nothing ->
                        []
                )

          else
            Html.text ""
        , if not config.outlined && not config.textarea && not config.fullWidth then
            styled Html.div
                [ class "mdc-line-ripple"
                , class "mdc-line-ripple--active" |> when model.focused
                ]
                []

          else
            Html.text ""
        ]


fullWidth : Property msg
fullWidth =
    Options.updateConfig (\config -> { config | fullWidth = True })


outlined : Property msg
outlined =
    Options.updateConfig (\config -> { config | outlined = True })


label : String -> Property msg
label str =
    Options.updateConfig (\config -> { config | labelText = Just str })
