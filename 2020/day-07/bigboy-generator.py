import random
import string
from collections import defaultdict
random.seed(2020)
g = defaultdict(set)
gsn = -1
FRONT_LO = 200
FRONT_HI = 300
NS_LO = 100
NS_HI = 200
N_FRONTS = 100
nodes = list(range(random.randint(FRONT_LO, FRONT_HI)))
nbags = len(nodes)
for n_front in range(N_FRONTS):
    ns = [nbags + i for i in range(random.randint(FRONT_LO, FRONT_HI))]
    if n_front == 10:
        gsn = nbags
        ns = [gsn]
    nbags += len(ns)
    for nn in ns:
        for _ in range(random.randint(NS_LO, NS_HI)):
            n = random.choice(nodes)
            g[n].add(nn)
        # ensure lots of bags in shiny gold
        if random.randint(0, 5) == 0 and gsn != -1:
            g[gsn].add(nn)
    nodes+=ns
 
names = set()
names.add("shiny gold")
n2name = dict()
def rname():
    global names
    name = ""
    while True:
        p1 = ''.join(random.choice(string.ascii_lowercase) for _ in range(10))
        p2 = ''.join(random.choice(string.ascii_lowercase) for _ in range(10))
        name = p1 + " " + p2
        if name not in names:
            break
    names.add(name)
    return name
    
for n in nodes:
    name = ""
    if n == gsn:
        name = "shiny gold"
    else:
        name = rname()
    n2name[n] = name
 
def print_bag(b):
    global n2name
    c = random.randint(1,2)
    print("{} {} bag{}".format(c, n2name[b], "" if c == 1 else "s"), end='')
random.shuffle(nodes)
for n in nodes:
    print("{} bags contain ".format(n2name[n]), end='')
    if g[n] == set():
        print("no other bags.")
    else:
        os = list(g[n])
        for o in os[:-1]:
            print_bag(o);
            print(", ", end = '')
        print_bag(os[-1])
        print(".")
