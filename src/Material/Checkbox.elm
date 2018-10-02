module Material.Checkbox exposing
    ( view
    , checked
    , disabled
    )

{-| Checkboxes allow the user to select one or more items from a set.

This module implements CSS-only checkboxes without state.


# Install

In your application install:

    npm install "@material/checkbox"

In your Sass file import:

    @import "@material/checkbox/mdc-checkbox";


# Example

    import Html
    import Html.Attributes as Attr
    import Material.Checkbox as Checkbox
    import Material.FormField as FormField
    import Material.Options as Options


    FormField.view [ Options.onClick Toggle ]
        [ Checkbox.view
              [ Options.id "my-checkbox"
              , Checkbox.checked <| Just True
              ]
              []
        , Html.label
              [ Attr.for "my-checkbox" ]
              [ Html.text "My checkbox" ]
        ]


# View

@docs view


# Properties

@docs checked
@docs disabled

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (attribute, class, styled, when)
import Svg
import Svg.Attributes as SvgAttr


type alias Config =
    { id : Maybe String
    , checked : Maybe Bool
    , disabled : Bool
    }


defaultConfig : Config
defaultConfig =
    { id = Nothing
    , checked = Nothing
    , disabled = False
    }


type alias Property msg =
    Options.Property Config msg


{-| Renders a checkbox without label. Childs are ignored.
-}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties _ =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Options.apply summary
        Html.div
        [ class "mdc-checkbox"
        , class "mdc-checkbox--indeterminate" |> when (config.checked == Nothing)
        , class "mdc-checkbox--checked" |> when (config.checked == Just True)
        , class "mdc-checkbox--disabled" |> when config.disabled
        ]
        []
        [ styled Html.input
            [ class "mdc-checkbox__native-control"
            , Options.id config.id
            , attribute <| Attr.type_ "checkbox"
            , attribute <| Attr.checked <| config.checked == Just True
            , attribute <| Attr.disabled config.disabled
            ]
            []
        , Html.div [ Attr.class "mdc-checkbox__background" ]
            [ Svg.svg
                [ SvgAttr.class "mdc-checkbox__checkmark"
                , SvgAttr.viewBox "0 0 24 24"
                ]
                [ Svg.path
                    [ SvgAttr.class "mdc-checkbox__checkmark-path"
                    , SvgAttr.fill "none"
                    , SvgAttr.stroke "white"
                    , SvgAttr.d "M1.73,12.91 8.1,19.28 22.79,4.59"
                    ]
                    []
                ]
            , Html.div [ Attr.class "mdc-checkbox__mixedmark" ] []
            ]
        ]


{-| Indicates whether a checkbox is checked.

    `Nothing` puts a checkbox in an indeterminate state which is not checked
    but visualized with a flat bar. The indeterminate state should be used on
    parent checkboxes where not all child checkboxes are checked.

-}
checked : Maybe Bool -> Property msg
checked val =
    Options.updateConfig (\config -> { config | checked = val })


{-| Indicates whether the user can interact with a checkbox.
-}
disabled : Bool -> Property msg
disabled val =
    Options.updateConfig (\config -> { config | disabled = val })
