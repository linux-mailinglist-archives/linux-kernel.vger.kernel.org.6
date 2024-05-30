Return-Path: <linux-kernel+bounces-195547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCFB8D4E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB546B23414
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7817C9F2;
	Thu, 30 May 2024 14:47:29 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB06132129
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080449; cv=fail; b=mzmKziH9qnaPE36V8/OJ6JueSo7VSgIhO5F+3/ndn2xnf0JiVJUhrhzUI410U1hstxvbv1m9Ndy5xaI8owSa99cuSk1CswyEK/xw3FelpT9QtoumCyyUgTR9ppOhryWkTOgyr2ZbQt/pBklyMntM4sKu9OlX39H1L2YkGZ2xkXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080449; c=relaxed/simple;
	bh=KzxttmW/DJCZbvJJdlzjiDX9LRg/pCq4DJYO/Kj0yWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WxpgcvV8F6O9dYx6E5a7S8WORhIncmRPR2cEKxb+9SMz2CPvEutacifWigJv1nF6DXfNPCA/I3TdIM2I8nJeTSXS7CF1XwI4QiXRvn0IOpVtbxuempIuwIi0yjXMWNa9kbv/8KHaMJghFqwXkH+7CvxReA6LlFji1XDj4LbhHVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nbkp004539;
	Thu, 30 May 2024 14:47:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DcEmwLiAw4rWjAzcxtchMaT5LtxhQkeTJvnDiGlAcnq0=3D;_b?=
 =?UTF-8?Q?=3DEgF/Cd6U8TjAfMx4WgP1aTVWG77blH7wPInSJnR3RmSx025S4uWs7y8mxSVO?=
 =?UTF-8?Q?vlltmoel_QsUSJJrFGecAodeI8yaTMXvQyMvXQvWKnd0RiJAEuSXej6Vv3Ssbsr?=
 =?UTF-8?Q?C6+iuSKULkhVst_5FDPCLgRJp/mgMRoj95c4IocJsha3ZHWQUGTl+uft2El4wt1?=
 =?UTF-8?Q?xqhFZULphDEsSbEHsi/n_xs0x8wZE74PaLvoVZtjLB01Ih+LCeIU2A2Nlgqpyp5?=
 =?UTF-8?Q?ZURq5SasadxWyHWIKsW+bAGm38_BItOAQIiS80nLu+RY1Q9I783ZEXCqq/cwPl7?=
 =?UTF-8?Q?mZJGTBPE3+DjqU3PeQg8G8/ARC18deJY_xQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg97ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 14:47:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UDiCPX026577;
	Thu, 30 May 2024 14:47:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc508neqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 14:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAdjv8WKaSTwD9nukKUPOatgjPN4qX0w/gJtyw2aChS+bZjtbTcdl9cmu+MuvQpSn9dAUzUpj+fE1q25vwXlUlzNNUEA/j47vVH+2zWeR/00dUdy25OQlIzTbNCEPaA7kfz8llMqybfZVBR+eQWHZ0qTDh3OrzBq19D0YjT2NRn90tzVNjD2uqoYKsXt1eqGaggqN4oTbk1V0JN4XSLqtK7jIR+NlXjd+4vioafqqgcok+MQKPWRF6XgCOkv2m242c42nCGto/9+G8IKSUUO4etigVr9kOGfIbyHco8rdTUWC+VwxRxNZ3RmiCvoIiUyDxWdMHf9X7xRXkSDYxT2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEmwLiAw4rWjAzcxtchMaT5LtxhQkeTJvnDiGlAcnq0=;
 b=TZlRzEm3g+0BBD3lMlgLTEjwFgG/nc83AW4d9RvdTLEMTT173QUUIj6tnZZJvx/qidneVgyO4gI3XTUdCaoaB6Tcfgm+iyATMGsqMJGedmbxOQLzAdHV1M+72zTTOCPomFlM5stOmjSfk/54jXtaF3Qe8Ia1PtvDoQaPAjEHKsRwtrPLCgLp4iqJUHCZorXHl/7m8CsnRtbn8swwujUC++7Q8SDxN60IWeLxwKcmysD//rrCYs29g+MsuNBqtZU2ATYNkgXpFwpi9cW2oR9c7YxEukZp4LfApV9/NX1kKXvpykTBFwqw/2AUTG8Z3X+lMiIepc89u31an+jm8cZbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEmwLiAw4rWjAzcxtchMaT5LtxhQkeTJvnDiGlAcnq0=;
 b=vJ+B0tjDAX+aCP2/Cb0GCss1M035piQkeFz7ptsEtQDCJJBdDoJDgzexZVAXvd8GRdKwieaRIQqf5W1XeL2bWe+M43MH2lyzMkop4Z0KuFSNN0ZnUU8whBuw8dro6MqUmK7usvQ9XpBllclILXC0L3ch0+jAM8QEPwZ0tn3KWXg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 30 May
 2024 14:47:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:47:07 +0000
Message-ID: <a66819c1-1ee1-47e1-8831-c0f1a22a12c9@oracle.com>
Date: Thu, 30 May 2024 20:16:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [input?] [usb?] KMSAN: uninit-value in asus_report_fixup
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+07762f019fd03d01f04c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dan Carpenter <error27@gmail.com>
References: <000000000000915d550619389e8a@google.com>
 <tencent_9FA58DAAA5CF0D8B9250DDB2DDF4192FCF07@qq.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <tencent_9FA58DAAA5CF0D8B9250DDB2DDF4192FCF07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 695099b2-eed8-44e5-e35c-08dc80b760d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dk4xVWFoU1pMUkVwYTFQY09uNi9GVmxzQU42QlQ4U1BqdDJYN2x4WGpwWG11?=
 =?utf-8?B?MGVIOGtRRW1senFocnJrZXlWMWczNWM3aGdVN0o4RDN0ZHVTL2grY29RdWkw?=
 =?utf-8?B?N1AyZ2NFRllVaEE3RWx3WDRYMzhVSEluU3MrUndZRXVtcy9uajV0cXoxTmFr?=
 =?utf-8?B?Mk0wU3Q5WFh4RXFNcWdqZ0xZbldwa0daVXlvclZGK2t4dExidzhDT3JIZ3Zq?=
 =?utf-8?B?aklLcy94RmxSMU1mNzhkdFl4ZXZPSzczN0FhNlZ3aTdHL2h5aVhudXhZWDBQ?=
 =?utf-8?B?NVF1bjcyTE00THlCSDNUOFg4SVpQWWRSc2FJMi9Sb2hrZGxMaHVyTDgxYk9q?=
 =?utf-8?B?dnVPelNTMGsrSy93dmpMcXFjQWVPZEFqbHRVNkhVbXVyOGo5UXhndUpYSTE0?=
 =?utf-8?B?YXBxbE5BYVdYV3hiWWNLVEMrQ0lQck9EY2xhT3BoV2R1TlFQUkNBSG5ZZSt4?=
 =?utf-8?B?N29CY05hSDF6TTRyb3VRcDV5SEczaXZnTTRTc3RWeUhycHBrZW0wWFRiRGhm?=
 =?utf-8?B?d1dsVVdzR1EzSWJveWhpcU1hcGxRcDRZZTZzL1ZsYlRSK1k1MTUxTHoyaEx1?=
 =?utf-8?B?b3pKa0RCRlRUSUdreGVwVDYvVDRvR1pFcnB0WWFoOE9ISE1xMUl4MElhdi9x?=
 =?utf-8?B?YzJqMy9wRERoakNzUkpFRzUrTHJLa0tFcFVnSVg1T0Y0TExxN2JURHAxbHJs?=
 =?utf-8?B?a3hTMFlnTXJMajZSc3RJcmZCRGNtQUpTT1YwbEVReDVxc1o2SUp4YnJhbUI1?=
 =?utf-8?B?WmRHUHdZaFlHajhkUDI5U0VPSE9MVkdvR29hMXNUOTdZRGNiMkJLR2ViZzdx?=
 =?utf-8?B?MnFyZE1uUE5ZSTg2K0IzODMzaUVTQ05zYnFLK1dlQzRQcXBHUW9qYXhjU2s5?=
 =?utf-8?B?UWJhcTdrd3RveXh1ODR2RlF0UEo4UndrZ084aXV5TVNuUjlvUW5lODA4Ymk4?=
 =?utf-8?B?ZTBmSHBtdloyeTlNSmMwVU41Q0g2U0Z3QTNmYXJVZnF4a0Fad1JHdE9CTzd5?=
 =?utf-8?B?VmNEQmxQUmVja0d3aWFoSzIyTU84MEllSzhTM0RNVEhLTkdDNWFaMHlTKzlJ?=
 =?utf-8?B?dlgxWVliQ3BnMWw5cGEvcVFTcFVuQ0F5a20rOXhybFJOOGdINjZmSHVRM2Mx?=
 =?utf-8?B?eUljVmZ3TFNxa2lhaWIxQlVJd05UalN3WDAxOHFJZ3FRL1lvWnovS0VTSU1a?=
 =?utf-8?B?Q1pNd0xQVFh3U1YxbVFxTEd3VDJTUGJ5L2dod0dpU2RWQTBhVlZtYit3R21l?=
 =?utf-8?B?emNyc05tWnVscWZCaXJoK01oUW5CR3pKUlY2K21rU1FWSElFTEtIK1B0d3p6?=
 =?utf-8?B?K1lrMi94T1lndUlyU2RTN1NNZHJ3Y256WitteHZZWlZCNU54WWFRQms5a1RM?=
 =?utf-8?B?S0hZck1vMysxRUw5NEUrYVpZdEk2WVo0QWZwRnFPR1BJWkd6WVB6eFcrUHFC?=
 =?utf-8?B?Um9GR3c1T21GaVRTQXNXQkxXRUZzWXh4Nnp6azJPZzJRQVIxTlN1KzV3aXBZ?=
 =?utf-8?B?RHYyTmIvenpjOGJEb2hvZGorckd0K3lMcTFVZ0g3bmlNZncwK3UvNVYxSlhx?=
 =?utf-8?B?YlI5dnpEMHdUK3hLYStsR1piNXN2bkEySC9PSlAvWjFHTHNaTUU0aXFBeWNO?=
 =?utf-8?B?N2lQMzY5c2FmNXdaZERhbnhsMlBNckE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NzFCcngwaFV5dUV2OFZvMEF4SU9QNjE3ZjVKVG5CV3VUOHJ5TGtNSUN6T0s0?=
 =?utf-8?B?VVJjOTFMRWc5bVFvQ29BMzQ2MzRFbU9tVkh4Tm15OGNvZFlwSmg1bkJrVTU1?=
 =?utf-8?B?d21wQXBYeFFLdzdGVmxJYWVRcVl1aCtXckFOUk92LzhXU3h0dzdqVFZBRUF6?=
 =?utf-8?B?YThxMXJyMlZoY2VqYjNCaEt6Z0luaVRyQnU5aTdKdndJNVFXSjhRVnVSRGIv?=
 =?utf-8?B?UlBMR3FURWVTVVVheW9Fd3lia1ZXU3R2b0I2SlFDT3BodURkQ1Vid0t5T0M4?=
 =?utf-8?B?NE5WOU5GVDJUN05HT0doY3FKTWx6bnY2QUpUNnB0UGpHQithdHJSN2hITHZO?=
 =?utf-8?B?eW1Ga3NOK1J1bFhSSmhRbk1mSFJGOFFuTlR6cXFndE0rV2dqVHAvN1ppSldL?=
 =?utf-8?B?N0NYc0YvWXNwaUxlK3pjdUtZMHEzck42Q3BkTEtITGYwZ1ZNOVpGRzl2NlZl?=
 =?utf-8?B?WndlRjBaazY5TGY2MmV1QS9WZUNPbS81R0t2UDE4RG5lYkxYQUR2dzVrRUt6?=
 =?utf-8?B?U0ZJRWpCd3dvcXZSV2dxS3JVVkZ1VVp2YUN2eDh0czhXUWlNM2kzaVBHTWsw?=
 =?utf-8?B?S0pMOEkzUmVGczJ3dVR4RmxTdHNIOC95RHoxSzErN25FMFpMaysrNFhwamhW?=
 =?utf-8?B?dWI0cG9qd0V3dG5kd0NrRW9QdStLNWJnV1N0ZE80WEhacnlPaWpLdUJVaXF6?=
 =?utf-8?B?OWVGOXF3eVlPckI3bHM1Y1BWTGdvK2xQeHNRa2xjOUoveG5Bek1yc1V3bS9C?=
 =?utf-8?B?cm5BSkhrVk9jcU5BQ0FpeFlGdU1JMmVteGlXZGxXTk1zT1cyWXc0Uzg2VHp5?=
 =?utf-8?B?NHZHd1VtdG5rd05DYmJLdkIxMDNIVzF6RUdnc2JFdUJ2WHF1dHBYalFGUjVs?=
 =?utf-8?B?MURPWEpETjhyNVRGaWpPcExyMTdjMzB0L3RNaTRHYk4wN0plYm9oTVlRdzAx?=
 =?utf-8?B?eE95eGp4ZHBFR3pua3c2aWgwYnNzMWQ0RlBXZGRIeGE3S3pEdDIyMEtGN3R4?=
 =?utf-8?B?RkpVakpqRi85ZXZRRjA0eVo1ZTE0ZklQUG0yOGZRZkEreFJ2R3hzVDJNZmpC?=
 =?utf-8?B?NGJyL3pkdGdNNWxDRTQ0NnhOa3hjcGlCMzJLd3pvd0ZwU2N6WXdBRGlhR0Qw?=
 =?utf-8?B?UWxKY3Q5QSsxSVRSWE9hSXBNdGhWRTZxUytNcGV5Zk5HTjJpdS9YYnJNcm5r?=
 =?utf-8?B?S1pCeURQVzlyVkJiT3QyOWNTYk5HdFJ5aDRZTUk0NHloWnoxK2NNNFNsWkFo?=
 =?utf-8?B?L0lPQXZhWjhRMU1hQmNaS3VTU1JFbFU0ZWpHWWdrNXU2a1BmVU82Z2VyQzAx?=
 =?utf-8?B?RC9XZUsvTlJ6dm5OWEZDT2FFQTN1V3VETTJDZWloV2t3YU5PL1NudXhoTDFF?=
 =?utf-8?B?Uzg3MHNURFAyUE9lWGRRc1BvbDhWQjRBRWMrdHdzMVR0VTM3RmtVNmtGckJJ?=
 =?utf-8?B?Zy9hRldZNENQTG5Fb0I3WVNrbHNUOUdtQkoyMHlyc1BQNDZ1cVhyREg4ckZo?=
 =?utf-8?B?MWVvb2JrajQvTGN3RjJ3b0dYa0dWcE1pV2h4ZG5lUEtvcTFZZWJKVkxESGtu?=
 =?utf-8?B?eUpoelhzZkZ4QzdiYTY4MW5iZkt1SWprYThUeGJTRFlmUkJWTWt5dHRZQ1B6?=
 =?utf-8?B?TGZrR0x3OURRWUxGWTVwS0o0VWRIc0R3UFZIeDV6MkVacjJpZXJmdldXNWRZ?=
 =?utf-8?B?dGZpZHdxZHA4ZFFaL3NWZDA5Q2t3UmdZaFNwVVFWSzFIU3hZdHF6Nm1yZFgw?=
 =?utf-8?B?ZG1rKzNzTk1HbkJGZHRVOUZXejI4OFkvTGJ1OUhkOFVwN2F2aURaUExUVWVM?=
 =?utf-8?B?WUZkWS9EblVja3JEa0NJRTlmTGRpbzg0NG5DamxiNi8yOXpSbnQ4b2NHeExk?=
 =?utf-8?B?RkphNjRDa2Robzl5UUU0S29LWTNmWXc2NGRCeFgxeEpqM0lBK0V1eHExTHVI?=
 =?utf-8?B?MjB3emFMWHlVU2pERkZzWnd5WnRIL00wNGhWYXBHK3dvRDJsY0gyaE5jdUtP?=
 =?utf-8?B?RzRBVzRoVGtla25XWlFQd1pBZkFRUHpCbHpyUzY0ZldYczZCQjhZNUVOdUVN?=
 =?utf-8?B?RjY3ZTJTQlZuWHpHbDlnKzNnQlNhOTlwU3lXWklkWXE0ZDF3b1FrNnYvbnZF?=
 =?utf-8?B?ZWl5UjQyeHgyend5VDZGZWJuWHdvTlArOXkrTWpILzQ0NitJREUySkxOWFVq?=
 =?utf-8?Q?EF9oF2vNppd95Pe8F8efX9Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vhcHkIf1ddz8zYkSUZuQkKdUFJkNmY5aTkh49Nk7ifFyuNf8xfzg1GeXU5/ig1aThSvAF3uz+dNmezKXk8zCTh+tcOH8nSZXjgxOu1PNj7Em/nxDsjWk9tKobPKhyy3AWgNWG4R1zqOf95c2RQi7i7fC/DhDNvpRkoDnccO3pm/RwkFwxyZUzJOefnpxSxG7JZC3mpvcsAicLJeKTD6NJTGYKGuiF/jVQVjH9Z21fGPaWOQOHsWRwuFjZg2RsHrsIgz7C3DSH6qDdYV4T2Zu+55k3Q96Du9sqDYuOGDtkoIAvnsZjEDrazpKQ9LFRaGau4EMCa9ybJEevkYs2uVuy0toLHpWJw3e72q00BGViFD8wo4hGdkEHu38UvfQntMvKSR8Z4zC6Motfbf9VYlPQumCRp8ug6adKmpetwqdQbeZYDVpjGt5+oBCxh2m61AHF0RjEkxjieVpEucE12nm4OlZNZxh8Dao7B0Yav5wOxzakKSDInd1w5HGp2Ugvzul3NwzLj1+SAAr6YmBZUFVgZekLKpdB14BgPqvbAbViX7DB24Zso0HsweMhSlZ8M+AnEdEiqaSZe5IKDNmlRBQQZxufYtrMg+ZDM5/YA+uM2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695099b2-eed8-44e5-e35c-08dc80b760d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:47:07.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw2VPBIBNJQByrxjUu9u93uWg0YcYfAJ4rO8h8JO+1OABZ8dmSaZQSTKZNDKHiaERbGC/o9warGrfd/6DbtfRM+hhun3kPlJqEO1tz3BfCpPRstD0R7vWYkmPP7mJrDS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300111
X-Proofpoint-GUID: oh2uSW5LGiTT50a9iHWbn0uWKqeIMG0j
X-Proofpoint-ORIG-GUID: oh2uSW5LGiTT50a9iHWbn0uWKqeIMG0j

Hi Edward,

On 28/05/24 17:58, Edward Adam Davis wrote:
> please test uv asus_report_fixup
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 70ec81c2e2b4
> 

I have tested the below patch:
and it prints something like this: No KMSAN failure.

[ 1200.138915][  T760] rdesc: g.�.�.�.I, asus_report_fixup

I don't see boot failure like syzbot did(and that looks unrelated to 
this bug that is being worked on(hid related))

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 02de2bf4f790..1a92392967fc 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1204,8 +1204,9 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>   	}
>   
>   	/* match many more n-key devices */
> -	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> -		for (int i = 0; i < *rsize + 1; i++) {
> +	printk("rdesc: %c.%c.%c.%c.%c, %s\n", rdesc[0], rdesc[1], rdesc[2], rdesc[3], rdesc[4], __func__);
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && *rsize > 15) {
> +		for (int i = 0; i < *rsize - 14; i++) {
>   			/* offset to the count from 0x5a report part always 14 */
>   			if (rdesc[i] == 0x85 && rdesc[i + 1] == 0x5a &&
>   			    rdesc[i + 14] == 0x95 && rdesc[i + 15] == 0x05) {
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index a90ed2ceae84..9f0e09f667b1 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1029,7 +1029,7 @@ static int usbhid_parse(struct hid_device *hid)
>   		return -EINVAL;
>   	}
>   
> -	rdesc = kmalloc(rsize, GFP_KERNEL);
> +	rdesc = kzalloc(rsize, GFP_KERNEL);
>   	if (!rdesc)
>   		return -ENOMEM;
>   
Thanks,
Harshit
> 
> 


