module Material.Button exposing
    ( view
    , Property
    , disabled
    , icon
    , outlined
    , raised
    , unelevated
    , dense
    )

{-| Buttons allow users to take actions, and make choices, with a single tap.


# Install

In your application install:

    npm install "@material/button"

In your Sass file import:

    @import "@material/button/mdc-button";


# View

@docs view


# Properties

@docs Property
@docs disabled
@docs icon
@docs outlined
@docs raised
@docs unelevated
@docs dense


# Reference

  - [Design](https://material.io/design/components/buttons.html)
  - [Develop](https://material.io/develop/web/components/buttons/)

-}

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


{-| Buttons property type.
-}
type alias Property msg =
    Options.Property Config msg


{-| Renders a button.

import Material.Button as Button
import Material.Options as Options

Button.view 
    [ Options.onClick Inc 
    , Button.disabled False
    , Button.raised
    ] 
    [ Html.text "Plus 1" ]

-}
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


{-| Styles an outlined button that is flush with the surface.
-}
outlined : Property msg
outlined =
    class "mdc-button--outlined"


{-| Makes the button text and container slightly smaller.
-}
dense : Property msg
dense =
    class "mdc-button--dense"


{-| Styles a contained button that is elevated above the surface.
-}
raised : Property msg
raised =
    class "mdc-button--raised"


{-| Styles a contained button that is flush with the surface.
-}
unelevated : Property msg
unelevated =
    class "mdc-button--unelevated"


{-| Adds an icon with `name` to a button.
-}
icon : String -> Property msg
icon name =
    Options.updateConfig (\config -> { config | iconName = Just name })


{-| Indicates whether the user can interact with a button.
-}
disabled : Bool -> Property msg
disabled val =
    Options.updateConfig (\config -> { config | disabled = val })
