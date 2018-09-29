module Material.FormField exposing (alignEnd, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties =
    styled Html.div (class "mdc-form-field" :: properties)


{-| Position the input after the label.
-}
alignEnd : Property msg
alignEnd =
    class "mdc-form-field--align-end"
