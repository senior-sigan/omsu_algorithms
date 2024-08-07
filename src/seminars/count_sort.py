def count_sort(arr, n=256):
    counters = [0] * n
    for el in arr:
        counters[el] += 1

    res = []
    for i in range(len(counters)):
        cnt = counters[i]
        for _ in range(cnt):
            res.append(i)
    return res


def test():
    arr = [6, 123, 51, 121, 250, 4, 6, 17, 2, 2, 3]
    out = count_sort(arr)
    print(out)


test()
