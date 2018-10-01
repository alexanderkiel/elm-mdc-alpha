module Material.Select exposing
    ( Model
    , Msg
    , Property
    , id
    , init
    , label
    , update
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode
import Material.Internal.Options as Options exposing (class, styled, when)



---- MODEL --------------------------------------------------------------------


type alias Model =
    { focused : Bool
    , value : Maybe String
    }


init : Maybe String -> Model
init value =
    { focused = False
    , value = value
    }



---- UPDATE -------------------------------------------------------------------


type Msg
    = Focus
    | Blur
    | Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Focus ->
            { model | focused = True }

        Blur ->
            { model | focused = False }

        Input str ->
            { model | value = Just str }



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
            , Maybe.map Options.id config.id
                |> Maybe.withDefault Options.noOp
            , Options.attribute (Attr.disabled True) |> when config.disabled
            , Options.onFocus <| lift Focus
            , Options.onBlur <| lift Blur
            , Events.on "change" (Decode.map (lift << Input) Events.targetValue)
                |> Options.attribute
            ]
            allItems
        , styled
            Html.label
            [ class "mdc-floating-label"
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
        , styled Html.div
            [ class "mdc-line-ripple"
            , class "mdc-line-ripple--active" |> when model.focused
            ]
            []
        ]


label : String -> Property msg
label str =
    Options.updateConfig (\config -> { config | labelText = Just str })


id : String -> Property msg
id str =
    Options.updateConfig (\config -> { config | id = Just str })
