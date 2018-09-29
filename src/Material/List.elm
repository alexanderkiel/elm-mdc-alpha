module Material.List exposing
    ( Property
    , group
    , item
    , metaIcon
    , primaryText
    , secondaryText
    , subheader
    , text
    , twoLine
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Keyed
import Material.Icon as Icon
import Material.Internal.Options as Options


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> List ( String, Html msg ) -> Html msg
view properties =
    Options.styled Html.Keyed.ul (Options.class "mdc-list" :: properties)


item : List (Property msg) -> List (Html msg) -> Html msg
item properties =
    Options.styled Html.li (Options.class "mdc-list-item" :: properties)


text : List (Property msg) -> List (Html msg) -> Html msg
text properties =
    Options.styled Html.span (Options.class "mdc-list-item__text" :: properties)


primaryText : List (Property msg) -> List (Html msg) -> Html msg
primaryText properties =
    Options.styled Html.span (Options.class "mdc-list-item__primary-text" :: properties)


secondaryText : List (Property msg) -> List (Html msg) -> Html msg
secondaryText properties =
    Options.styled Html.span (Options.class "mdc-list-item__secondary-text" :: properties)


metaIcon : List (Icon.Property msg) -> String -> Html msg
metaIcon properties =
    Icon.view (Options.class "mdc-list-item__meta" :: properties)


group : List (Property msg) -> List (Html msg) -> Html msg
group properties =
    Options.styled Html.div (Options.class "mdc-list-group" :: properties)


subheader : String -> Html msg
subheader title =
    Html.h3 [ Attr.class "mdc-list-group__subheader" ] [ Html.text title ]


twoLine : Property msg
twoLine =
    Options.class "mdc-list--two-line"
