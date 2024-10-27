module Tests exposing (associativity, sanity)

import Expect
import Fuzz exposing (Fuzzer)
import Test exposing (Test)
import Tree exposing (Tree)


sanity : Test
sanity =
    Test.test "Basic implementation check" <|
        \_ ->
            Tree.add
                ([ Tree.leaf 4, Tree.leaf 3 ] |> Tree.nodeN 2)
                ([ Tree.leaf 1, Tree.leaf 2 ] |> Tree.node)
                |> Expect.equal
                    (Tree.node
                        [ [ Tree.leaf 4, Tree.leaf 3 ] |> Tree.nodeN 3
                        , [ Tree.leaf 4, Tree.leaf 3 ] |> Tree.nodeN 4
                        ]
                    )


associativity : Test
associativity =
    Test.fuzz3
        (treeFuzzer 4)
        (treeFuzzer 4)
        (treeFuzzer 4)
        "Is addition associative?"
        (\x y z ->
            Tree.add (Tree.add x y) z
                |> Expect.equal (Tree.add x (Tree.add y z))
        )


treeFuzzer : Int -> Fuzzer Tree
treeFuzzer maxHeight =
    if maxHeight > 0 then
        Fuzz.oneOf
            [ leafFuzzer
            , Fuzz.map Tree.node (Fuzz.listOfLengthBetween 2 4 (treeFuzzer (maxHeight - 1)))
            ]

    else
        leafFuzzer


leafFuzzer : Fuzzer Tree
leafFuzzer =
    Fuzz.map Tree.leaf (Fuzz.intRange 0 8)
