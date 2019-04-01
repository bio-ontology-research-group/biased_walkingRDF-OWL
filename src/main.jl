using PyCall,DelimitedFiles,Random,Word2Vec,LightGraphs,SimpleWeightedGraphs
include("rw.jl")
# nodes=readdlm("../../graphdata/mapping.txt",'\t')
graph=readdlm("graphdata/outWrapper.txt",' ')
# dic_nodes=Dict{String,Int64}(Dict(nodes[i,1]=>nodes[i,2] for i in eachindex(nodes)))
g=SimpleWeightedGraph()
last_node=67166
add_vertices!(g,last_node)
sz=Int64(size(graph)[1])



intersection=[566,19,881,563,51905,12]
for n in 1:sz
    if n%10000==0
        println(n)
    end
    start=Int64(graph[n,1])
    if !(start in intersection)
        des=Int64(graph[n,2])
        add_edge!(g,start,des,1)
        add_edge!(g,des,start,1)
    end
end


# deep_walks=simulate_walks(g,20,100,1,1,start_des)
# deep_out=open("deep_ralk.txt",'a')
# for data in deep_walks
#     write(deep_out,data)
# end
# close(deep_out)
biased_walks=simulate_walks(g,20,100,1,0.5)
biased_out=open("biased_walk_1_point5.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)
biased_walks=simulate_walks(g,20,100,4,1)
biased_out=open("biased_walk_4_1.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)
biased_walks=simulate_walks(g,20,100,2,1)
biased_out=open("biased_walk_2_1.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)
biased_walks=simulate_walks(g,20,100,1,2)
biased_out=open("biased_walk_1_2.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)
biased_walks=simulate_walks(g,20,100,1,4)
biased_out=open("biased_walk_1_4.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)
