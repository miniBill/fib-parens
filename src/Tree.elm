module Tree exposing (Natural, Tree, add, leaf, node, nodeN)

import SeqSet exposing (SeqSet)


type alias Natural =
    Int


type Tree
    = Leaf Natural
    | Node (SeqSet Tree)


leaf : Natural -> Tree
leaf n =
    Leaf n


node : List Tree -> Tree
node children =
    case children of
        [ Leaf n ] ->
            Leaf (n + 1)

        _ ->
            Node (SeqSet.fromList children)


nodeN : Int -> List Tree -> Tree
nodeN n children =
    if n <= 1 then
        node children

    else
        node [ nodeN (n - 1) children ]


add : Tree -> Tree -> Tree
add l r =
    case r of
        Leaf n ->
            if n <= 0 then
                l

            else
                add (node [ l ]) (Leaf (n - 1))

        Node rs ->
            Node (SeqSet.map (\re -> add l re) rs)
