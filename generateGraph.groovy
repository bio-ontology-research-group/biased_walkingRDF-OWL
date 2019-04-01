def map1 = [:].withDefault { new LinkedHashSet() }
def map2 = [:].withDefault { new LinkedHashSet() }
def map3 = [:]
def map4 = [:]
def map5 = [:]
def map6 = [:]
def uniprotids = new LinkedHashSet()
new File("goa_human.gaf").splitEachLine("\t") { line ->
 def id = line[1]
 uniprotids.add(id)
}

new File("protein.aliases.txt").splitEachLine("\t") { line ->
 def stringid = line[0]
 def val = line[1]
 def type = line[2]
 if (type?.indexOf("GeneID")>-1) {
   map1[val].add(stringid)
   map3[stringid] = val
 }
 if (type?.indexOf("UniProt_ID")>-1) {
   if (val in uniprotids) {
     map2[stringid].add(val)
     map4[val] = stringid
   }
 }
}



def done = [:].withDefault { new LinkedHashSet() }
new File("goa_human.gaf").splitEachLine("\t") { line ->
 if (!line[0].startsWith("!")) {
   def uid = line[1]
   def anno = line[4]?.replaceAll(":","_")
   if (map4[uid] && map3[map4[uid]] && !(anno in done[uid])) {
     done[uid].add(anno)
     def gid = map3[map4[uid]]
     // println gid+ ' has_function ' +anno
     println "<http://www.ncbi.nlm.nih.gov/gene/"+gid+"> <http://bio2vec.net/relation/has_function> <http://purl.obolibrary.org/obo/$anno> ."
   }
 }
}

new File("protein.actions.txt").splitEachLine("\t") { line ->
 if (line[0].startsWith("9606")) {
   def id1 = line[0]
   def id2 = line[1]
   def type = line[2]
   def score = new Double(line[-1])
   if (score >=700 && map3[id1] && map3[id2]) {
     // println map3[id1]+ " has_interaction " + map3[id2]
     println "<http://www.ncbi.nlm.nih.gov/gene/"+map3[id1]+"> <http://bio2vec.net/relation/has_interaction> <http://www.ncbi.nlm.nih.gov/gene/"+map3[id2]+"> ."
   }
 }
}
