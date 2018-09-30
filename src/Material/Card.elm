module Material.Card exposing
    ( Property
    , actionButton
    , actionButtons
    , actions
    , outlined
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Button as Button
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    styled Html.div (class "mdc-card" :: properties)


outlined : Property msg
outlined =
    class "mdc-card--outlined"


actions : List (Property msg) -> List (Html msg) -> Html msg
actions properties =
    styled Html.div (class "mdc-card__actions" :: properties)


actionButtons : List (Property msg) -> List (Html msg) -> Html msg
actionButtons properties =
    styled Html.div (class "mdc-card__action-buttons" :: properties)


actionButton : Button.Property msg
actionButton =
    class "mdc-card__action mdc-card__action--button"
