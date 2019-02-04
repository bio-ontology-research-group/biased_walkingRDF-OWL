__precompile__()
module Node2Vec.jl
    using SimpleWeightedGraphs, Word2Vec

    export node2vec_walk, simulate_walks, learn_embeddings

    include("rw.jl")
end # module