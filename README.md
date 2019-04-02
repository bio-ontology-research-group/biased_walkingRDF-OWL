# biased_walkingRDF-OWL

the idea of biased walking RDF and owl is to use the biased random walk to generate features from the ontology and knowledge
graph. the original idea is from the paper Neuro-symbolic representation learning on biological knowledge graphs <https://academic.oup.com/bioinformatics/article/33/17/2723/3760100> . it is using deep walking to generate the features. 
biased random walk is trying to balance the depth-first search and breadth-first search. 

# to run the code
For example, to classify the RDF graph RDFgraph.nt using the OWL ontologies in onto_dir with the ELK reasoner, and writing an edge list representation of the inferred graph to outWrapper.txt, use the following command:
~~~~
groovy walking-rdf-and-owl-master/RDFWrapper.groovy -i RDFgraph.nt -o graphdata/outWrapper.txt -m graphdata/mappingFile.txt -d onto_dir -c true
~~~~

RDFgraph.nt is the rdf graph data you need to imput. onto_dir is the ontology directorr. it will then generate outWrapper.txt and mappingFile.txt files.

# to generate the embeddings of biased_walkingRDF&OWL
you could run the code
~~~~
julia src/main.jl 2 3
~~~~

the first argument 2 represents the p value, the second argument 3 means the q value. for the meaning of p and q value, you could refer to the paper <https://cs.stanford.edu/people/jure/pubs/node2vec-kdd16.pdf> 
then you could obtain the embeddings in the graphdata directory.
