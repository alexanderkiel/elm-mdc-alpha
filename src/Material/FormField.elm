module Material.FormField exposing
    ( view
    , alignEnd
    )

{-| MDC Form Field aligns an MDC Web form field (for example, a checkbox) with
its label and makes it RTL-aware.


# Install

In your application install:

    npm install "@material/form-field"

In your Sass file import:

    @import "@material/form-field/mdc-form-field";


# View

@docs view


# Properties

@docs alignEnd

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


{-| -}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    styled Html.div (class "mdc-form-field" :: properties)


{-| Position the input after the label.
-}
alignEnd : Property msg
alignEnd =
    class "mdc-form-field--align-end"
