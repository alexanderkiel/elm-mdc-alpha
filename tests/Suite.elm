module Suite exposing
    ( checkboxTest
    , elevationTest
    , radioButtonTest
    , selectTest
    , textFieldTest
    )

import Expect
import Fuzz exposing (intRange)
import Html.Attributes as Attr
import Material.Checkbox as Checkbox
import Material.Elevation as Elevation
import Material.Options as Options exposing (styled)
import Material.RadioButton as RadioButton
import Material.Select as Select
import Material.TextField as TextField
import Parser.Advanced as Parser
import Test exposing (..)
import Material.TopAppBar


checkboxTest : Test
checkboxTest =
    describe "For Checkbox"
        [ test "using `Options.id` as property is possible" <|
            \_ ->
                let
                    _ =
                        Checkbox.view [ Options.id "id-132935" ] []
                in
                Expect.pass
        ]


radioButtonTest : Test
radioButtonTest =
    describe "For RadioButton"
        [ test "using `Options.id` as property is possible" <|
            \_ ->
                let
                    _ =
                        RadioButton.view [ Options.id "id-132935" ] []
                in
                Expect.pass
        ]


elevationTest : Test
elevationTest =
    fuzz (intRange 1 24) "Elevation classes" <|
        \z ->
            Expect.equal
                (styled identity [ Elevation.elevation z ])
                [ Attr.class <| "mdc-elevation--z" ++ String.fromInt z ]


type Msg
    = Select Select.Msg
    | TextField TextField.Msg


selectTest : Test
selectTest =
    describe
        "For Select"
        [ test "using `Options.id` as property is possible" <|
            \_ ->
                let
                    model =
                        Select.init Nothing

                    _ =
                        Select.view Select model [ Options.id "id-132935" ] []
                in
                Expect.pass
        ]


textFieldTest : Test
textFieldTest =
    describe
        "For TextField"
        [ test "using `Options.id` as property is possible" <|
            \_ ->
                let
                    parser =
                        Parser.succeed ""

                    model =
                        TextField.init parser identity Nothing

                    config =
                        { lift = TextField
                        , printer = identity
                        }

                    _ =
                        TextField.view config model [ Options.id "id-132935" ] []
                in
                Expect.pass
        ]
