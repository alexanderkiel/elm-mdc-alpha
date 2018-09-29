module Material.TextField.HelperText exposing
    ( Property
    , persistent
    , validationMsg
    , view
    )

import Html exposing (Html)
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    styled Html.p (class "mdc-text-field-helper-text" :: properties)


persistent : Property msg
persistent =
    class "mdc-text-field-helper-text--persistent"


validationMsg : Property msg
validationMsg =
    class "mdc-text-field-helper-text--validation-msg"
