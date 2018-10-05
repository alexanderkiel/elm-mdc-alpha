module Material.TextField exposing
    ( SimpleModel
    , Model
    , init
    , Msg
    , update
    , view
    , fullWidth
    , outlined
    , label
    , withLeadingIcon
    , withTrailingIcon
    )

{-| Text fields let users enter and edit text.


# Install

In your application install:

    npm install "@material/textfield"

In your Sass file import:

    @import "@material/textfield/mdc-text-field";


# Model

@docs SimpleModel
@docs Model
@docs init


# Update

@docs Msg
@docs update


# View

@docs view


# Properties

@docs fullWidth
@docs outlined
@docs label
@docs withLeadingIcon
@docs withTrailingIcon


# Reference

  - [Design](https://material.io/design/components/text-fields.html)
  - [Develop](https://material.io/develop/web/components/input-controls/text-field/)

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Icon as Icon
import Material.Internal.Options as Options exposing (class, styled, when)
import Parser as SimpleParser exposing (Problem)
import Parser.Advanced as Parser exposing (Parser)



---- MODEL --------------------------------------------------------------------


{-| -}
type alias Model context problem value =
    { focused : Bool
    , parser : Parser context problem value
    , value : Maybe value
    , parseError : List (Parser.DeadEnd context problem)
    , input : Maybe String
    }


type alias SimpleModel value =
    Model Never SimpleParser.Problem value


{-| -}
init :
    Parser context problem value
    -> (value -> String)
    -> Maybe value
    -> Model context problem value
init parser printer value =
    { focused = False
    , parser = parser
    , value = value
    , parseError = []
    , input = Maybe.map printer value
    }



---- UPDATE -------------------------------------------------------------------


{-| -}
type Msg
    = Focus
    | Blur
    | Input String


{-| -}
update : Msg -> Model context problem value -> Model context problem value
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
                            ( Just v, [] )

                        Err err ->
                            ( Nothing, err )
            in
            { model | input = Just str, value = val, parseError = parseError }



---- VIEW ---------------------------------------------------------------------


type alias Config msg value =
    BaseConfig msg
        value
        { labelText : Maybe String
        , labelFloat : Bool
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


type alias RequiredConfig msg value =
    BaseConfig msg value {}


type alias BaseConfig msg value a =
    { a
        | printer : value -> String
        , lift : Msg -> msg
    }


defaultConfig : RequiredConfig msg value -> Config msg value
defaultConfig { printer, lift } =
    { labelText = Nothing
    , labelFloat = False
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
    , printer = printer
    , lift = lift
    }


type alias Property msg value =
    Options.Property (Config msg value) msg


{-| -}
view :
    RequiredConfig msg value
    -> Model context problem value
    -> List (Property msg value)
    -> List (Html msg)
    -> Html msg
view requiredConfig model properties children =
    let
        ({ config } as summary) =
            Options.collect (defaultConfig requiredConfig) properties

        isInvalid =
            not <| List.isEmpty model.parseError

        focused =
            model.focused && not config.disabled || isInvalid

        finalValue =
            if focused then
                Maybe.withDefault "" model.input

            else
                model.value
                    |> Maybe.map config.printer
                    |> Maybe.withDefault ""

        isDirty =
            finalValue /= ""

        iconAllowed =
            -- only in default or outline mode
            not config.textarea
    in
    Options.apply summary
        Html.div
        [ class "mdc-text-field"
        , class "mdc-text-field--focused" |> when focused
        , class "mdc-text-field--disabled" |> when config.disabled
        , class "mdc-text-field--dense" |> when config.dense
        , class "mdc-text-field--fullwidth" |> when config.fullWidth
        , class "mdc-text-field--invalid" |> when isInvalid
        , class "mdc-text-field--textarea" |> when config.textarea
        , class "mdc-text-field--outlined" |> when config.outlined
        , class "mdc-text-field--with-leading-icon" |> when (config.leadingIcon /= Nothing)
        , class "mdc-text-field--with-trailing-icon" |> when (config.trailingIcon /= Nothing)
        ]
        []
        [ -- icon
          if Nothing == config.leadingIcon || not iconAllowed then
            Html.text ""

          else
            Icon.view
                [ Options.class "mdc-text-field__icon" ]
                (config.leadingIcon |> Maybe.withDefault "unknown")
        , -- input or textArea
          styled
            (if config.textarea then
                Html.textarea

             else
                Html.input
            )
            [ class "mdc-text-field__input"
            , Options.id config.id
            , when (not config.textarea) <|
                Options.attribute (Attr.type_ config.type_)
            , Options.attribute <| Attr.value finalValue
            , Options.onFocus <| config.lift Focus
            , Options.onBlur <| config.lift Blur
            , Options.onInput <| (config.lift << Input)
            ]
            []
        , -- label
          -- no label in fullWidth
          if not config.fullWidth then
            styled
                Html.label
                [ class "mdc-floating-label"
                , class "mdc-floating-label--float-above"
                    |> when (focused || isDirty)
                , Options.for config.id
                ]
                (case config.labelText of
                    Just str ->
                        [ Html.text str ]

                    Nothing ->
                        []
                )

          else
            Html.text ""
        , -- icon
          if Nothing == config.trailingIcon || not iconAllowed then
            Html.text ""

          else
            Icon.view
                [ Options.class "mdc-text-field__icon" ]
                (config.trailingIcon |> Maybe.withDefault "unknown")
        , if config.outlined then
            -- TODO how should we add svg for outlined and label above problem
            styled Html.div [ class "mdc-notched-outline__idle" ] []

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


{-| -}
fullWidth : Property msg value
fullWidth =
    Options.updateConfig (\config -> { config | fullWidth = True })


{-| -}
outlined : Property msg value
outlined =
    Options.updateConfig (\config -> { config | outlined = True })


{-| -}
label : String -> Property msg value
label str =
    Options.updateConfig (\config -> { config | labelText = Just str })


{-| -}
withLeadingIcon : String -> Property msg value
withLeadingIcon iconName =
    Options.updateConfig (\config -> { config | leadingIcon = Just iconName })


{-| -}
withTrailingIcon : String -> Property msg value
withTrailingIcon iconName =
    Options.updateConfig (\config -> { config | trailingIcon = Just iconName })
