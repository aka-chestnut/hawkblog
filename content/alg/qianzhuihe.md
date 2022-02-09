---
title: "基础算法3——前缀和与差分"
date: 2022-02-09T21:39:45+08:00
hidehome: false
draft: false
tags: ["算法"]
categories: "算法"
series: ["基础算法"]
---
本篇主要记录了基础算法，前缀和与差分的学习笔记。
<!--more-->
## 前缀和

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1e5 + 10;
int n,m,l,r;
int a[N],s[N];

int main()
{
    scanf("%d%d", &n, &m);
    for (int i = 1; i <= n; i ++ ) scanf("%d", &a[i]);
    for (int i = 1; i <= n; i ++ ) s[i] = s[i-1] + a[i];
    while (m -- )
    {
        scanf("%d%d", &l, &r);
        printf("%d\n",s[r]-s[l-1]);
    }jjkk
    return 0;
}
```

## 二维前缀和

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 1010;
int q,x1,x2,y1,y2;
int a[N][N],s[N][N];
int n,m;


int main()
{
    scanf("%d%d%d", &n, &m , &q);
    for (int i = 1; i <=n; i ++ )
        for(int j = 1; j <= m; j++)
            scanf("%d", &a[i][j]);
  
    for (int i = 1; i <=n; i ++ )
        for(int j = 1; j <= m; j++)
            s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + a[i][j];
  
    while(q--)
    {
        scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
        int ans;
        ans = s[x2][y2] + s[x1-1][y1-1] - s[x1-1][y2] - s[x2][y1-1];
        printf("%d\n",ans);
    }
    return 0;
}
```

## 差分

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N = 100010;
int n,m;
int a[N],b[N];

int main()
{
    scanf("%d%d", &n, &m);
    for (int i = 1; i <= n; i ++ ) 
    {
        scanf("%d", &a[i]);
        b[i] = a[i] - a[i-1];
    }
    
    while(m--)
    {
        int l,r,c;
        scanf("%d%d%d",&l,&r,&c);
        b[l] += c;
        b[r+1] -= c;
    }
  
    int res=0;
    for (int i = 1; i <= n; i ++ ) 
    {
        res += b[i];
        printf("%d ",res);
    }
    return 0;
}
```

## 二维差分

**PS: 存在优化空间，b的插入操作可以写成一个函数，每次调用！**

```C++
#include <iostream>
#include <cstring>
#include <algorithm>

using namespace std;

const int N=1010;

int a[N][N],b[N][N];

int n,m,q;

int main()
{
    scanf("%d%d%d", &n, &m, &q);
    for (int i = 1; i <= n; i ++ )
        for (int j=1;j<=m;j++)
            {
                scanf("%d", &a[i][j]);
                b[i][j] += a[i][j];
                b[i+1][j] -= a[i][j];
                b[i][j+1] -= a[i][j];
                b[i+1][j+1] += a[i][j];
            }
        
    while(q--)
    {
        int x1,x2,y1,y2,c;
        scanf("%d%d%d%d%d",&x1,&y1,&x2,&y2,&c);
        b[x1][y1] += c;
        b[x1][y2+1] -= c;
        b[x2+1][y1] -= c;
        b[x2+1][y2+1] += c;
    }
  
    for (int i = 1; i <= n; i ++ )
    {
        for (int j=1;j<=m;j++)
        {
            b[i][j] = b[i-1][j] + b[i][j-1] - b[i-1][j-1] + b[i][j];
            printf("%d ",b[i][j]);
        
        }
            printf("\n");
    }
   return 0; 
}
```

## 笔记
{{< embed-pdf url="/alg/基础算法3 差分与前缀和.pdf" >}}

