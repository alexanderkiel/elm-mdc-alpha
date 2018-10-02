module Material.RadioButton exposing
    ( view
    , checked
    , disabled
    )

{-| Radio buttons allow the user to select one option from a set.


# View

@docs view


# Properties

@docs checked
@docs disabled

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (attribute, class, styled, when)


type alias Config =
    { id : Maybe String
    , checked : Bool
    , disabled : Bool
    }


defaultConfig : Config
defaultConfig =
    { id = Nothing
    , checked = False
    , disabled = False
    }


type alias Property msg =
    Options.Property Config msg


{-| Renders a radio button without label. Childs are ignored.
-}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties _ =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Options.apply summary
        Html.div
        [ class "mdc-radio"
        , class "mdc-radio--disabled" |> when config.disabled
        ]
        []
        [ styled Html.input
            [ class "mdc-radio__native-control"
            , Options.id config.id
            , attribute <| Attr.type_ "radio"
            , attribute <| Attr.checked config.checked
            , attribute <| Attr.disabled config.disabled
            ]
            []
        , Html.div [ Attr.class "mdc-radio__background" ]
            [ Html.div [ Attr.class "mdc-radio__outer-circle" ] []
            , Html.div [ Attr.class "mdc-radio__inner-circle" ] []
            ]
        ]


{-| Indicates whether a radio button is checked.
-}
checked : Bool -> Property msg
checked val =
    Options.updateConfig (\config -> { config | checked = val })


{-| Indicates whether the user can interact with a radio button.
-}
disabled : Bool -> Property msg
disabled val =
    Options.updateConfig (\config -> { config | disabled = val })
