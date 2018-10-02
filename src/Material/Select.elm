module Material.Select exposing
    ( Model
    , init
    , Msg
    , update
    , view
    , label
    )

{-| MDC Select provides Material Design single-option select menus.


# Install

In your application install:

    npm install "@material/select"

In your Sass file import:

    @import "@material/select/mdc-select";


# Model

@docs Model
@docs init


# Update

@docs Msg
@docs update


# View

@docs view


# Properties

@docs label


# Reference

  - [Design](https://material.io/design/components/text-fields.html)
  - [Develop](https://material.io/develop/web/components/input-controls/select-menus/)

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode
import Material.Internal.Options as Options exposing (class, styled, when)



---- MODEL --------------------------------------------------------------------


{-| For each select, place a model value in your model.
-}
type alias Model =
    { focused : Bool
    , value : Maybe String
    }


{-| Initializes the select menu with the following value.
-}
init : Maybe String -> Model
init value =
    { focused = False
    , value = value
    }



---- UPDATE -------------------------------------------------------------------


{-| Internal message type. Create a message which transports messages of that
type.
-}
type Msg
    = Focus
    | Blur
    | Change String


{-| Internal update function. Has to be called by your module on messages from
every select menu you use.
-}
update : Msg -> Model -> Model
update msg model =
    case msg of
        Focus ->
            { model | focused = True }

        Blur ->
            { model | focused = False }

        Change newValue ->
            { model | value = Just newValue }



---- VIEW ---------------------------------------------------------------------


type alias Config =
    { id : Maybe String
    , disabled : Bool
    , labelText : Maybe String
    }


defaultConfig : Config
defaultConfig =
    { id = Nothing
    , disabled = False
    , labelText = Nothing
    }


type alias Property msg =
    Options.Property Config msg


{-| Renders a select menu.

    Takes a message lifter and the model.

-}
view : (Msg -> msg) -> Model -> List (Property msg) -> List (Html msg) -> Html msg
view lift model properties items =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties

        focused =
            model.focused && not config.disabled

        isDirty =
            model.value /= Nothing

        allItems =
            Html.option [ Attr.disabled True, Attr.selected (not isDirty) ]
                []
                :: items
    in
    Options.apply summary
        Html.div
        [ class "mdc-select"
        , class "mdc-select--disabled" |> when config.disabled
        ]
        []
        [ styled
            Html.select
            [ class "mdc-select__native-control"
            , Options.id config.id
            , Options.attribute (Attr.disabled True) |> when config.disabled
            , Options.onFocus <| lift Focus
            , Options.onBlur <| lift Blur
            , Events.on "change" (Decode.map (lift << Change) Events.targetValue)
                |> Options.attribute
            ]
            allItems
        , styled
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
        , styled Html.div
            [ class "mdc-line-ripple"
            , class "mdc-line-ripple--active" |> when model.focused
            ]
            []
        ]


{-| Sets the label text. The selects label will be empty without setting this.
-}
label : String -> Property msg
label str =
    Options.updateConfig (\config -> { config | labelText = Just str })
