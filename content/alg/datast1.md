---
title: "数据结构1——链表、栈与队列、KMP算法"
date: 2022-02-12T14:01:52+08:00
hidehome: false
draft: false
tags: ["算法","数据结构"]
categories: "算法"
series: ["数据结构"]
---
本篇为基础数据结构的笔记。
<!--more-->
## 单链表

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 100010;

int e[N],ne[N];
int head,idx;

void init()
{
    head = -1;
    idx = 1;
}

void insert_head(int num)
{
    e[idx] = num;
    ne[idx] = head;
    head = idx;
    idx ++;
}

void insert(int k,int num)
{
    e[idx] = num;
    ne[idx] = ne[k];
    ne[k] = idx;
    idx ++;
  
}

void deletek(int k)
{
    if(k == 0) head = ne[head];
    else ne[k] = ne[ne[k]];
  
}
int main()
{
    init();
    int n;
    scanf("%d", &n);
    while(n--)
    {
        string a;
        cin>>a;
        if(a == "H")
        {
            int num;
            scanf("%d", &num);
            insert_head(num);
        }
        else if(a == "I")
        {
            int k,num;
            scanf("%d%d",&k,&num);
            insert(k,num);
        }
        else if(a == "D")
        {
            int k;
            scanf("%d",&k);
            deletek(k);
        }
    }
    while(head != -1)
    {
        printf("%d ",e[head]);
        head = ne[head];
    }
    return 0;
}
```

## 双链表

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 100010;

int e[N],l[N],r[N];
int idx;
// 0 左端点。1 右端点

void init()
{
    r[0] = 1;
    l[1] = 0;
    idx = 2;
}

void insert_l(int num)
{
    e[idx] = num;
    l[idx] = 0;
    r[idx] = r[0];
    l[r[0]] = idx;
    r[0] = idx;

    idx += 1;
}
void insert_r(int num)
{
    e[idx] = num;
    r[idx] = 1;
    l[idx] = l[1];
    r[l[1]] = idx;
    l[1] = idx;

    idx += 1;
}
void delete_k(int k)
{
  
    r[l[k]] = r[k];
    l[r[k]] = l[k];
  
}
void insert_lk(int k,int num)
{
    e[idx] = num;
    l[idx] = l[k];
    r[idx] = k;
    r[l[k]] = idx;
    l[k] = idx;
    idx++;
}
void insert_rk(int k,int num)
{
    e[idx] = num;
    l[idx] = k;
    r[idx] = r[k];
    l[r[k]] = idx;
    r[k] = idx;
    idx++;
}
int main()
{
    init();
    int n;
    scanf("%d", &n);
    while(n--)
    {
        string op;
        cin>>op;
        if(op == "L")
        {
            int num;
            cin>>num;
            insert_l(num);
        }
        else if(op == "R")
        {
            int num;
            cin>>num;
            insert_r(num);
        }
        else if(op == "D")
        {
            int k;
            cin>>k;
            delete_k(k+1);
        }
        else if(op == "IL")
        {
            int k,num;
            cin>>k>>num;
            insert_lk(k+1,num);
        }
        else
        {
            int k,num;
            cin>>k>>num;
            insert_rk(k+1,num);
        }
    }
  
    int head = 0;
    while(true)
    {
        head = r[head];
        if(head != 1) printf("%d ",e[head]);
        else break;
    }
  
    return 0;
}
```

## 栈

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;

int stack[N];
int head;
void init()
{
    head = -1;
}

int main()
{
    init();
    int n;
    scanf("%d", &n);
    while (n -- )
    {
        string op;
        cin>>op;
        if(op == "push")
        {
            int x;
            scanf("%d", &x);
            stack[++head] = x;
        }
        else if(op == "pop")
        {
            head --;
        }
        else if(op == "query")
        {
            printf("%d\n",stack[head]);
        }
        else
        {
            if(head==-1) printf("YES\n");
            else printf("NO\n");
        }
    }
}
```

## 队列

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;

int queue[N];
int head,tail;

void init()
{
    head = -1;
    tail = -1;
}

int main()
{
    init();
    int n;
    scanf("%d", &n);
    while (n -- )
    {
        string op;
        cin>>op;
        if(op == "push")
        {
            int x;
            scanf("%d", &x);
            if(head == -1) head++;
            queue[++tail] = x;
        }
        else if(op == "pop")
        {
            head ++;
        }
        else if(op == "query")
        {
            printf("%d\n",queue[head]);
        }
        else
        {
            if(head==-1 || head>tail) printf("YES\n");
            else printf("NO\n");
        }  
    }
}
```

## 单调stack

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

const int N = 1e5 + 10;

int s[N];
int head=-1;

int main()
{
    int n;
    scanf("%d", &n);
    while (n -- )
    {
        int num;
        scanf("%d", &num);
        while(head >= 0 && s[head] >= num)
        {
            head --;
        }
        if(head == -1) printf("-1 ");
        else printf("%d ",s[head]);
        s[++head] = num;
    }
}
```

## 单调queue

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e6 + 10;
int hh,tt=-1;

int a[N],q[N];

int main()
{
    int n,k;
    scanf("%d%d", &n, &k);
    for (int i = 0; i < n; i ++ ) scanf("%d", &a[i]);
    for (int i = 0; i < n; i ++ )
    {
        if(hh<=tt && i-k+1 >q[hh]) hh++;
        while(hh<=tt && a[q[tt]]>a[i]) tt--;
        q[++tt] = i;
        if(i>=k-1) printf("%d ",a[q[hh]]);
    }
    printf("\n");
    int hh=0,tt=-1;
     for (int i = 0; i < n; i ++ )
    {
        if(hh<=tt && i-k+1 >q[hh]) hh++;
        while(hh<=tt && a[q[tt]]<a[i]) tt--;
        q[++tt] = i;
        if(i>=k-1) printf("%d ",a[q[hh]]);
    }
}
```

## KMP算法

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e6+10;
char p[N],s[N];
int ne[N];

int main()
{
    int m,n;
    cin>>n>>p+1>>m>>s+1;
    for (int i = 2,j=0; i <= n; i ++ )
    {
        while(j && p[i] != p[j+1]) j = ne[j];
        if(p[i] == p[j+1]) j++;
        ne[i] = j;
    }
  
    for (int i=1,j =0; i<=m;i++)
    {
        while( j && s[i]!=p[j+1]) j = ne[j];
        if(s[i] == p[j+1]) j++;
        if (j == n)
        {
            printf("%d ",i-n);
            j = ne[j];
        }
    }
}
```

## 笔记
{{< embed-pdf url="/alg/数据结构1 链表、栈与队列、KMP算法.pdf" >}}

