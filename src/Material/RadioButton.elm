module Material.RadioButton exposing (Property, disabled, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options


type alias Config =
    { disabled : Bool
    }


defaultConfig : Config
defaultConfig =
    { disabled = False }


type alias Property msg =
    Options.Property Config msg


view : List (Property msg) -> Bool -> Html msg
view properties checked =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Options.apply summary
        Html.div
        [ Options.class "mdc-radio"
        , Options.when config.disabled <| Options.class "mdc-radio--disabled"
        ]
        []
        [ Options.styled
            Html.input
            [ Options.class "mdc-radio__native-control"
            , Options.attribute <| Attr.type_ "radio"
            , Options.attribute <| Attr.checked checked
            , Options.when config.disabled <| Options.attribute <| Attr.disabled True
            ]
            []
        , Html.div [ Attr.class "mdc-radio__background" ]
            [ Html.div [ Attr.class "mdc-radio__outer-circle" ] []
            , Html.div [ Attr.class "mdc-radio__inner-circle" ] []
            ]
        ]


disabled : Property msg
disabled =
    Options.updateConfig (\config -> { config | disabled = True })
