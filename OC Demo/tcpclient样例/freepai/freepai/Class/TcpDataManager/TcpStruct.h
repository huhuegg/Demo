//
//  TcpStruct.h
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

/*
 类型	定义	说明
 BYTE	typedef unsigned char      单字节	          char	                  %c
 WORD	typedef unsigned short     双字节无符号整数  unsigned short int	  %hu /%hx /%ho %hu/%hx/%ho
 SWORD	typedef signed short       双字节符号整数	  short int		          %hi %hx %ho
 DWORD	typedef unsigned int       四字节无符号整数  unsigned int		      %u/%x/%o
 SDWORD	typedef signed int         四字节符号整数    int		              %i/%x/%o
 QWORD	typedef unsigned long long 八字节无符号整数  unsigned long long int  %llu/%llx/%llo
 */


#define REQ_EXAMPLE_IFNAME @"example_one"
#define NOTIFY_EXAMPLE @"notifyExampleOne"

#define ERROR_IFNAME @"normal_error"
#define NOTIFY_ERROR @"notifyNormalErr"

//////////////////Define struct/////////////////////
typedef struct
{
    unsigned int error_status;
    char error_desc[64];
} normal_error;

typedef struct
{
    unsigned short int number;
    char example_name[16];
    char example_desc[64];
    unsigned int return_code;
    char example_result[64];
} example_return;


