module Material.Button exposing
    ( Property
    , class
    , dense
    , disabled
    , icon
    , outlined
    , raised
    , unelevated
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Icon as Icon
import Material.Internal.Options as Options


type alias Config =
    { ripple : Bool
    , link : Maybe String
    , disabled : Bool
    , iconName : Maybe String
    }


defaultConfig : Config
defaultConfig =
    { ripple = False
    , link = Nothing
    , disabled = False
    , iconName = Nothing
    }


type alias Property msg =
    Options.Property Config msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties childs =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties

        attrs =
            [ Just <| Attr.disabled config.disabled ]
                |> List.filterMap identity

        iconElem =
            config.iconName
                |> Maybe.map (Icon.view [ Options.class "mdc-button__icon" ])

        newChilds =
            iconElem
                |> Maybe.map (\x -> x :: childs)
                |> Maybe.withDefault childs
    in
    Options.apply
        summary
        Html.button
        [ Options.class "mdc-button" ]
        attrs
        newChilds


outlined : Property msg
outlined =
    Options.class "mdc-button--outlined"


dense : Property msg
dense =
    Options.class "mdc-button--dense"


raised : Property msg
raised =
    Options.class "mdc-button--raised"


unelevated : Property msg
unelevated =
    Options.class "mdc-button--unelevated"


class : String -> Property msg
class name =
    Options.class name


icon : String -> Property msg
icon name =
    Options.updateConfig (\config -> { config | iconName = Just name })


disabled : Property msg
disabled =
    Options.updateConfig (\config -> { config | disabled = True })
