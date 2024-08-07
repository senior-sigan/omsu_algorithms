import random


def h(s, a=31, n=181):
    out = 0
    for ch in s:
        out = (out * a + ord(ch)) % n
    return out


def rnd_word(a, b):
    n = random.randint(a, b)
    return "".join([chr(random.randint(ord('a'), ord('z'))) for _ in range(n)])


def check_collision(n, min_wl=3, max_wl=6):
    keys = {}
    for _ in range(n):
        w = rnd_word(min_wl, max_wl)
        hw = h(w)
        if hw in keys:
            keys[hw].append(w)
        else:
            keys[hw] = [w]

    keys_list = set()
    counter = 0
    for k in keys:
        counter += len(keys[k])
        for k in keys[k]:
            keys_list.add(k)
    print(counter/len(keys))
    return keys_list


def gen_actions(keys, n=10000):
    ops = ['put', 'get', 'delete']
    keys = list(keys)
    lines = []
    for _ in range(n):
        op = ops[random.randint(0, len(ops)-1)]
        if op == 'put':
            k = keys[random.randint(0, len(keys) - 1)]
            v = rnd_word(3, 8)
            lines.append(f"put {k} {v}\n")
        elif op == 'get':
            k = keys[random.randint(0, len(keys) - 1)]
            lines.append(f"get {k}\n")
        elif op == 'delete':
            k = keys[random.randint(0, len(keys) - 1)]
            lines.append(f"delete {k}\n")
    with open('out.txt', 'w') as fd:
        fd.writelines(lines)
