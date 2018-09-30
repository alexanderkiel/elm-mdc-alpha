module Material.Button exposing
    ( Property
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
import Material.Internal.Options as Options exposing (class)


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

        iconElem =
            config.iconName
                |> Maybe.map (Icon.view [ class "mdc-button__icon" ])

        newChilds =
            iconElem
                |> Maybe.map (\x -> x :: childs)
                |> Maybe.withDefault childs
    in
    Options.apply summary
        Html.button
        [ class "mdc-button" ]
        [ Attr.disabled config.disabled ]
        newChilds


outlined : Property msg
outlined =
    class "mdc-button--outlined"


dense : Property msg
dense =
    class "mdc-button--dense"


raised : Property msg
raised =
    class "mdc-button--raised"


unelevated : Property msg
unelevated =
    class "mdc-button--unelevated"


icon : String -> Property msg
icon name =
    Options.updateConfig (\config -> { config | iconName = Just name })


disabled : Property msg
disabled =
    Options.updateConfig (\config -> { config | disabled = True })
