# dz_10_sorting_tasks.py
from random import randint, seed
from time import perf_counter

seed(42)

N = 100_000

arr1 = [randint(1, 1_000_000) for _ in range(N)]
arr2 = [
    {"num_1": randint(1, 1_000_000), "num_2": randint(1, 1_000_000)}
    for _ in range(N)
]


def bubble_sort(a: list) -> list:
    n = len(a)
    while True:
        swapped = False
        last_swap = 0
        for i in range(1, n):
            if a[i - 1] > a[i]:
                a[i - 1], a[i] = a[i], a[i - 1]
                swapped = True
                last_swap = i
        n = last_swap
        if not swapped:
            break
    return a


def main():
    print(f"Generated: arr1={len(arr1):,} ints, arr2={len(arr2):,} dicts")

    FORCE_FULL_BUBBLE_SORT = False
    BUBBLE_DEMO_SIZE = 5_000

    if FORCE_FULL_BUBBLE_SORT:
        data_for_bubble = arr1.copy()
        label = "bubble 100k"
    else:
        data_for_bubble = arr1[:BUBBLE_DEMO_SIZE]
        label = f"bubble demo {BUBBLE_DEMO_SIZE}"

    t0 = perf_counter()
    bubble_sort(data_for_bubble)
    t1 = perf_counter()
    print(f"{label}: {t1 - t0:.3f}s | sorted? {data_for_bubble == sorted(data_for_bubble)}")


    t2 = perf_counter()
    arr2.sort(key=lambda d: (d["num_1"], d["num_2"]))
    t3 = perf_counter()
    print(f"arr2 .sort(key=(num_1,num_2)): {t3 - t2:.3f}s")


if __name__ == "__main__":
    main()