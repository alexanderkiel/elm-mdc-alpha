module Material.Dialog exposing
    ( actions
    , button
    , container
    , content
    , onClose
    , open
    , scrim
    , scrollable
    , surface
    , title
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Button as Button
import Material.Internal.Options as Options exposing (class, styled)


type alias Config msg =
    { onClose : Maybe msg }


defaultConfig : Config msg
defaultConfig =
    { onClose = Nothing }


type alias Property msg =
    Options.Property (Config msg) msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Options.apply summary
        Html.div
        [ class "mdc-dialog" ]
        []


onClose : msg -> Property msg
onClose msg =
    Options.updateConfig (\config -> { config | onClose = Just msg })


container : List (Property msg) -> List (Html msg) -> Html msg
container properties =
    styled Html.div (class "mdc-dialog__container" :: properties)


scrim : List (Property msg) -> List (Html msg) -> Html msg
scrim properties =
    styled Html.div (class "mdc-dialog__scrim" :: properties)


surface : List (Property msg) -> List (Html msg) -> Html msg
surface properties =
    styled Html.div (class "mdc-dialog__surface" :: properties)


title : Property msg
title =
    class "mdc-dialog__title"


open : Property msg
open =
    class "mdc-dialog--open"


button : Button.Property msg
button =
    class "mdc-dialog__button"


content : List (Property msg) -> List (Html msg) -> Html msg
content properties =
    styled Html.section (Options.class "mdc-dialog__content" :: properties)


scrollable : Property msg
scrollable =
    class "mdc-dialog--scrollable"


actions : List (Html msg) -> Html msg
actions =
    Html.footer [ Attr.class "mdc-dialog__actions" ]
