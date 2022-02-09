---
title: "基础算法2——高精度算法"
date: 2022-02-09T21:36:04+08:00
hidehome: false
draft: false
tags: ["算法","高精度算法"]
categories: "算法"
series: ["基础算法"]
---
本篇主要记录了高精度算法的相关笔记。
<!--more-->
共四种，待补充高精度*高精度以及高精度/高精度

## 高精度加法

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
#include <vector>

using namespace std;

const int N = 100010;

vector<int> add(vector<int>& A,vector<int>& B)
{
    int t = 0;
    vector<int> C;
    for(int i=0;i<A.size() || i < B.size();i++)
    {
        if(i<A.size()) t+=A[i];
        if(i<B.size()) t+=B[i];
        C.push_back(t % 10);
        t /= 10;
    }
    if(t) C.push_back(1);
    return C;
}

int main()
{
    vector<int> A,B;
    string a,b;
    cin>>a>>b;
    for(int i=a.size()-1;i>=0;i--)
    {
        A.push_back(a[i]-'0');
    }
  
    for(int i=b.size()-1;i>=0;i--)
    {
        B.push_back(b[i]-'0');
    }
    auto C = add(A,B);
    for(int i=C.size()-1;i>=0;i--) printf("%d",C[i]);
    return 0;
}
```

## 高精度剑法

注意A、B长度的判断

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
#include <vector>

using namespace std;

const int N = 100010;

// A>=B
bool cmp(vector<int>& A,vector<int>& B)
{
    if(A.size() != B.size()) return A.size()>B.size();
    else{
        for (int i = A.size()-1; i >=0; i -- )
        {
            if(A[i]!=B[i]) return A[i]>B[i];
        }
        return true;
    }
}

vector<int> sub(vector<int>& A,vector<int>& B)
{
    int t = 0;
    vector<int> C;
    for(int i=0;i<A.size();i++)
    {
      t = A[i] - t;
      if(i<B.size()) t-=B[i];
      C.push_back((t+10)%10);
      if(t<0) t=1;
      else t=0;
    }
    while(C.size()>1&&C.back()==0) C.pop_back();
    return C;
}

int main()
{
    vector<int> A,B;
    string a,b;
    cin>>a>>b;
    for(int i=a.size()-1;i>=0;i--)
    {
        A.push_back(a[i]-'0');
    }
  
    for(int i=b.size()-1;i>=0;i--)
    {
        B.push_back(b[i]-'0');
    }
    if (cmp(A,B))
    {
        auto C = sub(A,B);
        for(int i=C.size()-1;i>=0;i--) printf("%d",C[i]);
    }
   else{
       auto C = sub(B,A);
       printf("-");
       for(int i=C.size()-1;i>=0;i--) printf("%d",C[i]);
   }
    return 0;
}
```

## 高精度乘法

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
#include <vector>

using namespace std;

vector<int> mul(vector<int>& A,int b)
{
    int t = 0;
    vector<int> C;
    for(int i=0;i<A.size() || t ;i++)
    {
        if(i < A.size()) t += (A[i] *b);
        C.push_back(t % 10);
        t /= 10;
    }
    return C;
}

int main()
{
    vector<int> A;
    string a;
    int b;
    cin>>a>>b;
    if(b==0){ printf("%d",0);return 0;}
    for(int i=a.size()-1;i>=0;i--)
    {
        A.push_back(a[i]-'0');
    }
  
    auto C = mul(A,b);
    for(int i=C.size()-1;i>=0;i--) printf("%d",C[i]);

    return 0;
}
```

## 高精度除法

```C++
#include <iostream>
#include <cstring>
#include <algorithm>
#include <vector>

using namespace std;

vector<int> mul(vector<int>& A,int b,int &r)
{
    vector<int> C;
    for(int i=A.size()-1;i>=0;i--)
    {
        r = r*10 + A[i];
        C.push_back(r/b);
        r %= b;
    }
    reverse(C.begin(),C.end());
    while(C.size()>1 && C.back()==0) C.pop_back();
    return C;
}

int main()
{
    vector<int> A;
    string a;
    int b,r=0;
    cin>>a>>b;
    if(b==0){ printf("%d",0);return 0;}
    for(int i=a.size()-1;i>=0;i--)
    {
        A.push_back(a[i]-'0');
    }
  
    auto C = mul(A,b,r);
    for(int i=C.size()-1;i>=0;i--) printf("%d",C[i]);
    printf("\n%d",r);

    return 0;
}
```

## 笔记
{{< embed-pdf url="/alg/基础算法2 高精度算法.pdf" >}}

