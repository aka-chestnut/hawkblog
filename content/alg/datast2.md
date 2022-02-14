---
title: "Datast2"
date: 2022-02-14T20:47:38+08:00
hidehome: false
draft: false
tags: ["算法","数据结构"]
categories: "算法"
series: ["数据结构"]
---
本篇为基础数据结构的笔记。
<!--more-->

## 字典树

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;

int son[N][26],cnt[N];
int idx;
char st[N];

void insert(char st[])
{ 
    int p = 0;
    for (int i = 0; st[i]; i ++ )
    {
        int u = st[i] - 'a';
        if(!son[p][u]) son[p][u] = ++idx;
        p = son[p][u];
    }
    cnt[p]++;
}

void query(char st[])
{
    int p = 0;
    for (int i = 0; st[i]; i ++ )
    {
        int u = st[i] - 'a';
        if(!son[p][u]) 
          {
              printf("%d\n",0);
              return;
          }
        p = son[p][u];
    }
   printf("%d\n",cnt[p]) ;
  
}
int main()
{
    int n;
    scanf("%d",&n);
    while (n -- )
    {
        char op;
        cin>>op;
        if(op == 'I')
        {
            cin>>st;
            insert(st);
        }
        else
        {
            cin>>st;
            query(st);
        }
    }
    return 0;
}
```

## 合并集合

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;

int p[N];

int find(int a)
{
    if(p[a] != a) p[a] = find(p[a]);
    return p[a];
}
int main()
{
    int n,m;
    scanf("%d%d", &n, &m);
    for (int i = 1; i <= n; i ++ ) p[i] = i;
    while (m -- ){
        char op;
        int a,b;
        cin>>op>>a>>b;
        if(op == 'M')
        {
            p[find(a)] = p[find(b)];
        }
        else
        {
            if(p[find(a)] == p[find(b)]) printf("Yes\n");
            else printf("No\n");
        }
    }
    return 0;
}
```

## 联通块中点的数量

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;

int p[N],c[N];

int find(int a)
{
    if(p[a] != a) p[a] = find(p[a]);
    return p[a];
}
int main()
{
    int n,m;
    scanf("%d%d", &n, &m);
    for (int i = 1; i <= n; i ++ ) 
    {
         p[i] = i;
         c[i] = 1;
    }
    while (m -- ){
        string op;
        cin>>op;
        if(op == "C")
        {
            int a,b;
            cin>>a>>b;
            if(p[find(a)] == p[find(b)]) continue;
            c[find(b)] += c[find(a)];
            p[find(a)] = p[find(b)];
        }
        else if(op == "Q1")
        {
            int a,b;
            cin>>a>>b;
            if(p[find(a)] == p[find(b)]) printf("Yes\n");
            else printf("No\n");
        }
        else
        {
            int a;
            cin>>a;
            printf("%d\n",c[find(a)]); 
        }
    }
    return 0;
}
```

## 堆排序

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
using namespace std;


const int N = 1e5 + 10;

int heap[N];
int n,m;

void sink(int site)
{
    int t = site;
  
    if( site*2 <= n && heap[t]>heap[site*2]) t = 2*site;
    if( site*2+1 <= n && heap[t]>heap[site*2 + 1]) t = 2*site+1;
    if (t!=site)
    {
        swap(heap[site],heap[t]);
        sink(t);
    }
}

int head_min()
{
    int x=heap[1];
    heap[1] = heap[n--];
    sink(1);
    return x;
}
int main()
{
    scanf("%d%d", &n, &m);
    for (int i = 1; i <= n; i ++ ) scanf("%d",&heap[i]);
    for (int i = n /2; i>0; i--) sink(i);
    while (m -- ){
        cout<<heap[1]<<" ";
        heap[1] = heap[n--];
        sink(1);
    }
}
```

## 模拟堆

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
using namespace std;


const int N = 1e5 + 10;

// hp 堆中点的插入次序。ph 次序插入点的下标
int heap[N],hp[N],ph[N];
int idx;

void heapswap(int a,int b)
{
    swap(heap[a],heap[b]);
    swap(ph[hp[a]],ph[hp[b]]);
    swap(hp[a],hp[b]);
}
void sink(int site)
{
    int t = site;
  
    if( site*2 <= idx && heap[t]>heap[site*2]) t = 2*site;
    if( site*2+1 <= idx && heap[t]>heap[site*2 + 1]) t = 2*site+1;
    if (t!=site)
    {
        heapswap(site,t);
        sink(t);
    }
}

void swim(int site)
{
    if(site / 2 && heap[site] < heap[site/2])
    {
        heapswap(site,site/2);
        swim(site/2);
    }
}

int main()
{
    int n;
    int m = 0;
    scanf("%d", &n);
    while (n -- ){
        string op;
        cin>>op;
        if(op == "I")
        {
            m ++;
            int x;
            scanf("%d",&x);
            heap[++idx] = x;
            hp[idx] = m;
            ph[m] = idx;
            swim(idx);
        }
        else if(op == "PM")
        {
            printf("%d\n",heap[1]);
        }
        else if(op == "DM")
        {
            heapswap(1,idx--);
            sink(1);
        }
        else if(op == "D")
        {
            int x;
            scanf("%d",&x);
            int tmp = ph[x];
            heapswap(tmp,idx--);
            swim(tmp);
            sink(tmp);
      
        }
        else
        {
            int x,cx;
            scanf("%d%d",&x,&cx);
            int tmp = ph[x];
            heap[tmp ] = cx;
            swim(tmp);
            sink(tmp); 
        }
    }
}
```

## 笔记
{{< embed-pdf url="/alg/数据结构2 并查集、堆与字典树.pdf" >}}

