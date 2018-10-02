module Material.TextField.HelperText exposing
    ( view
    , persistent
    , validationMsg
    )

{-| Helper text conveys additional guidance about the input field, such as how
it will be used. It should only take up a single line, being persistently
visible or visible only on focus.


# Install

In your application install:

    npm install "@material/textfield"

In your Sass file import:

    @import "@material/textfield/helper-text/mdc-text-field-helper-text";


# View

@docs view


# Properties

@docs persistent
@docs validationMsg


# Reference

  - [Design](https://material.io/design/components/text-fields.html)
  - [Develop](https://material.io/develop/web/components/input-controls/text-field/helper-text/)

-}

import Html exposing (Html)
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


{-| Renders a helper text paragraph node. Place this right below your `TextField`.
-}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    styled Html.p (class "mdc-text-field-helper-text" :: properties)


{-| Makes the helper text permanently visible.
-}
persistent : Property msg
persistent =
    class "mdc-text-field-helper-text--persistent"


{-| Indicates the helper text is a validation message.
-}
validationMsg : Property msg
validationMsg =
    class "mdc-text-field-helper-text--validation-msg"
