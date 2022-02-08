---
title: "基础算法1——快排、归并排和二分查找"
date: 2022-02-08T16:36:23+08:00
hidehome: false
draft: false
tags: ["算法","排序","查找"]
categories: "算法"
series: ["基础算法"]
---
本篇主要记录了快速排序、归并排序和二分查找的相关笔记。
<!--more-->
## 快速排序

### C++版本

```c++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1000010;

int q[N];
int n;

void quick_sort(int q[],int l,int r){
    if (l >= r) return;
    int mid=q[(l+r+1)/2],i=l-1,j=r+1;

    while(i<j)
    {
        do i++; while(q[i]<mid);
        do j--; while(q[j]>mid);
        if(i<j) swap(q[i],q[j]);
    }
    quick_sort(q,l,i-1);
    quick_sort(q,i,r);
}
int main()
{
    scanf("%d", &n);
    for (int i = 0; i < n; i ++ ) scanf("%d",&q[i]);
  
    quick_sort(q,0,n-1);
  
    for (int i = 0; i < n; i ++ ) printf("%d ",q[i]);
    return 0;
}
```

### Python3版本

```python
def quick_sort(q,l,r):
    if l >=r: return
    i = l-1
    j = r+1
    x = q[int((l+r+1)/2)]
    while i<j:
        i+= 1
        j-=1
        while q[i]<x:
            i+= 1
        while q[j]>x:
            j-= 1
    
        if i<j:
            q[i],q[j] = q[j],q[i]
    quick_sort(q,l,i-1)
    quick_sort(q,i,r)
  
  
  
def main():
    n = int(input())
    q = list(map(int, input().split()))
    quick_sort(q,0,n-1)
    for i in q:
        print(f"{i}",end=" ")
  
if __name__ == "__main__":
    main()
```

## 归并排序

### C++版本

```c++
#include <iostream>
#include <cstring>
#include <algorithm>
using namespace std;

const int N=100010;

int n;
int q[N],tmp[N];

void merge_sort(int q[],int l,int r)
{
   if(l >= r) return;
   int mid = l+r >> 1;
   merge_sort(q,l,mid);
   merge_sort(q,mid+1,r);
   int i = l, j = mid+1 , k=0;
   while(i<=mid && j <=r)
   {
        if (q[i]<=q[j]) tmp[k++] = q[i++];
        else tmp[k++] = q[j++];
   }
   while(i <= mid) tmp[k++] = q[i++];
   while(j <=r ) tmp[k++] = q[j++];
   for (i=l,j=0;i<=r;i++,j++) q[i] = tmp[j];
}

int main()
{
    scanf("%d", &n);
    for (int i = 0; i < n; i ++ ) scanf("%d",&q[i]);
    merge_sort(q,0,n-1);
    for (int i = 0; i < n; i ++ ) printf("%d ",q[i]);
    return 0;
}
```

```python
def merge_sort(q, l, r):
    if r <= l:
        return
    mid = int((l+r) / 2)
    merge_sort(q, l, mid)
    merge_sort(q, mid+1, r)
    i, j, k = l, mid+1, 0
    tmp = [0 for _ in range(r-l+1)]
    while((i <= mid) & (j <= r)):
        if (q[i] <= q[j]):
            tmp[k] = q[i]
            i += 1
        else:
            tmp[k] = q[j]
            j += 1
        k += 1
    while(i <= mid):
        tmp[k] = q[i]
        i += 1
        k += 1
    while(j <= r):
        tmp[k] = q[j]
        j += 1
        k += 1
    i, k = l, 0
    while i <= r:
        q[i] = tmp[k]
        k += 1
        i += 1


def main():
    n = int(input())
    q = list(map(int, input().split()))
    merge_sort(q, 0, n-1)
    for i in q:
        print(i, end=" ")


if __name__ == '__main__':
    main()
```

PS: 一定要注意边界条件，特别是对`i`赋值那里。

## 二分查找

### C++版本：一定要理解两种模版的

```c++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 100010;
int n,m,k;
int q[N];

int main()
{
    scanf("%d %d", &n, &m);
    for (int i = 0; i < n; i ++ ) scanf("%d", &q[i]);
    while( m-- )
    {
        scanf("%d", &k);
        int l=0,r=n-1;
        int mid=0;
        while(l<r)
        {
            mid = l+r>>1;
            if(q[mid]>=k) r=mid;
            else l = mid+1;
        }
        if(q[l]!=k)
        {
            cout<<"-1 -1"<<endl;
            continue;
        }
        cout<<l<<" ";
        l = 0,r=n-1;
        while(l<r)
        {
            mid = l+r+1>>1;
            if(q[mid]<=k) l=mid;
            else r = mid-1;
        }
        cout<<l<<endl;
    }
    return 0;
}
```

### Python版

```python
def main():
    n,m = list(map(int,input().split()))
    q = list(map(int,input().split()))
    while m >0:
        m -= 1
        k = int(input())
        l,r = 0,n-1
        while l<r:
            mid = int((l+r)/2)
            if q[mid]>=k:
                r = mid
            else:
                l = mid+1
  
        if q[l] != k:
            print("-1 -1")
            continue
        print(l,end=" ")
        l,r = 0,n-1
        while l<r:
            mid = int((l+r+1)/2)
            if q[mid]<=k:
                l = mid
            else:
                r = mid-1
        print(r)
  
if __name__ == "__main__":
    main()
```

## 笔记
{{< embed-pdf url="/alg/basic1.pdf" >}}

