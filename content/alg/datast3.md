---
title: "数据结构3——模拟散列表、字符串哈希"
date: 2022-02-21T01:28:46+08:00
hidehome: false
draft: false
tags: ["算法","数据结构"]
categories: "算法"
series: ["数据结构"]
---
本篇为基础数据结构的笔记。
<!--more-->
## 模拟散列表

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 2e5+10;

int hs[N];

int null = 0x3f3f3f3f;
int q = 2e5+3;

int find(int num)
{
    int site = (num % q + q) % q;
    while(hs[site]!=null and hs[site]!=num) 
    {
        site++;
        if(site == N) site = 0;
}
    return site;
}
int main()
{
    int n;
    scanf("%d", &n);
    memset(hs,0x3f,sizeof hs);
    while (n -- )
    {
        char m;
        cin>>m;
        if(m == 'I')
        {
            int num;
            cin>>num;
            hs[find(num)] = num;
        }
        else
        {
            int num;
            cin>>num;
            if(hs[find(num)] == num)
            {
                printf("Yes\n");
            }
            else
            {
                printf("No\n");
            }   
        }
    }
}
```

## 字符串哈希

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;
typedef unsigned long long ULL;

const int N = 1e5+10;

ULL s[N],p[N];
int jz=131;
int main()
{
    int n,m;
    scanf("%d%d", &n, &m);
    p[0] = 1;
    string str;
    cin>>str;
    p[0] = 1;
    for (int i = 1; i <= n; i ++ )
    {
        int tmp = str[i-1] - '0';
        s[i] = s[i-1] * jz + tmp;
        p[i] = jz * p[i-1];
    }
    while (m -- ){
        int l1,r1,l2,r2;
        cin>>l1>>r1>>l2>>r2;
        if((s[r1] - s[l1-1]*p[r1-l1+1]) == (s[r2] - s[l2-1] * p[r2-l2+1])) printf("Yes\n");
        else printf("No\n");
    }
}
```

## 笔记
{{< embed-pdf url="/alg/数据结构3 哈希表与stl.pdf" >}}

