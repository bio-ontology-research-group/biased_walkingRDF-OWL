train=open("train.txt","a")
test=open("test.txt","a")

go_data=[]
gene=[]
with open("result.txt","r") as f:
    for line in f.readlines():
        if "GO" in line:
            go_data.append(line)
        else:
            gene.append(line)

from sklearn.model_selection import train_test_split
go_train, go_test = train_test_split(go_data, test_size = 0.2)

gene_train,gene_test=train_test_split(gene,test_size=0.2)

for data in go_train:
    train.write(data)
for data in gene_train:
    train.write(data)

for data in go_test:
    test.write(data)
for data in gene_test:
    test.write(data)
