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
biased_walks=simulate_walks(g,20,100,Int64(ARGS[1]),Int64(ARGS[2]))
biased_out=open("../graphdata/biased_walk.txt","a")
for data in biased_walks
    for da in data
        da=string(da)*" "
        write(biased_out,da)
    end
    write(biased_out,"\n")
end
close(biased_out)

edge_list=Dict()
for n in 1:Int64(size(graph)[1])
       head=string(Int64(graph[n,1]))
       tail=string(Int64(graph[n,2]))
       combine=head*" "*tail
       combine1=tail*" "*head
       edge=string(Int64(graph[1,3]))
       edge_list[combine]=edge
       edge_list[combine1]=edge
end
newfile=open("../graphdata/biased_walk/biased_graph.txt",'w')
open("../graphdata/biased_walk/biased_walk.txt") do f
       for line in eachline(f)
           data=split(strip(line)," ")
           for index in 1:length(data)-1
               head=data[index]
               tail=data[index+1]
               combine=head*" "*tail
               query=edge_list[combine]
               if !(index==length(data)-1)
                   write(newfile,head*" "*query*" "*tail*" ")
               else
                   write(newfile,head*" "*query*" "*tail)
               end
           end
           write(newfile,"\n")
       end
end
model=word2vec("../graphdata/biased_walk/biased_graph.txt","../graphdata/biased_walk/embedding.txt",window=10,size=100,iter=30,verbose=true)

