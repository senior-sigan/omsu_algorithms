def insertions_sort(arr):
    for i in range(1, len(arr)):
        j = i
        while j > 0 and arr[j-1] > arr[j]:
            tmp = arr[j-1]
            arr[j-1] = arr[j]
            arr[j] = tmp
            j -= 1


def test():
    arr = [1, 2, 3, 4, 5, 6, 7, 8]
    insertions_sort(arr)
    print(arr)

    arr = [8, 7, 6, 5, 4, 3, 2, 1]
    insertions_sort(arr)
    print(arr)

    arr = [-1, 2, -5, 3, 9, 5, 199, 4565, 1, 0]
    insertions_sort(arr)
    print(arr)


test()
