module Material.Card exposing
    ( Property(..)
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


type Property msg
    = Class String


view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    Html.div [ Attr.class "mdc-card" ]


outlined : Property msg
outlined =
    Class "mdc-card--outlined"


actions : List (Property msg) -> List (Html msg) -> Html msg
actions properties =
    Html.div [ Attr.class "mdc-card__actions" ]


actionButtons : List (Property msg) -> List (Html msg) -> Html msg
actionButtons properties =
    Html.div [ Attr.class "mdc-card__action-buttons" ]


actionButton : Button.Property msg
actionButton =
    Button.class "mdc-card__action mdc-card__action--button"
