Return-Path: <linux-kernel+bounces-197255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF158D683C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FC7B2486C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86D17C223;
	Fri, 31 May 2024 17:39:31 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E32E3F2
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177170; cv=fail; b=jBRTj02cleEksbFXKthFTzsy4HdNbFjs1MQBrjmgXg7yWZajnrk4lTQknHUDQxfE/xuHwza0XsuNtLVQAWbJD3rELhrTHg6kwOxSX+FFgtOQOC+wOgYc4zMRXZRxHTdob2O5U+mo9+dGymnz2IpsY8l7PlN0czQk2I52h30afPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177170; c=relaxed/simple;
	bh=thrJkWv/ORPiDvlVNKE6SHPwmGZKqtgrnx9dBNyWPm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMjR78BBKLTpGuu3gXWX5J6XN1DGxNxvqwisrVVl/9p8rxASxfZQRwWmZWIIuz8lvxF6jb1xE6VC+3Mr6kOM9Sc/n6HrvAWtqfV+3g/V2b7ucypy88vYPLu/s9GVreinKrlM+P3r3HF1WJA3r9scw4kRpKw/xROGRPHNSqqPmUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9VjNF005522;
	Fri, 31 May 2024 17:39:06 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DAVAYJMMTP+XXlGfUcSw0KKVhYJZJPac1A8vIybN/f5I=3D;_b?=
 =?UTF-8?Q?=3DHCBb3Vbwvg8zW+pCtZN7FfizbeNRlOdYtqWoPSuSWo+GOLyoN7Of35NCdCAZ?=
 =?UTF-8?Q?x7JEW006_VkbIskzYPUOtA6sY3Yk7iotofMJSjaVNUZumCmiLC9fyQA9ni19T2y?=
 =?UTF-8?Q?timGWMv7mO9Z26_z9Zsycl5I3AbkXqaxvVjmpI8Rc8c7glmMp0dsifzhTAO4q0g?=
 =?UTF-8?Q?sbjaaGF5evdE0EqfMMlE_IBQSRvhZ8lEfvCy6hx37my8aWcUfI7xuv2nwybOla/?=
 =?UTF-8?Q?H9hsEvFW6q1DspHNgvEeB+G2rQ_v4igyXwm+foxb4pGvg7uBz8WQJxpBma7MUFm?=
 =?UTF-8?Q?yv8NaaUlrT7B/4iSl0Q199raYx2UtaAp_TQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4bqdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 17:39:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VH1Pgc019309;
	Fri, 31 May 2024 17:39:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yf7r2rk1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 17:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8oeW3Tt7xroCcla/cC3gIqxYtEfXMV05ecBbuMOumrEhrl+vZanTwB5AoW4fd7YT7spnW1cuyw/mLuAPY5RenQX62UH/3KFDMw6N2jL4RqfFciFkyHIUQUtos3MjkL8n9G9TaIH+/fkT95YfJ0Lqd98lh4b21QCG+0BYK4z7HsD5t47/DyHndjpP2eV+AM3rsHgU1vB0a+VBAO8yHDZOHb5uWPHfvbmLkHiqNq3NyZ4yNyX3feX8DlOREHFXAvEF69UQTZCtuhGIbd81IGEcLEQmvtRP1ng9D0V6Jp5oIKP4bxnjemKC55uMLu0fMpkg0npuyL4ofwdep/HJ19vTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVAYJMMTP+XXlGfUcSw0KKVhYJZJPac1A8vIybN/f5I=;
 b=noA9LOcmxg76P/AzeYScdnjaO6EkOrSbDz4O7mcf4fkjRkF/konKEIBYrZAXoXkCn3BocA8UjJt2l1zHSIZIyoprnMma55qMf+hJ9DEhba82JK1qWZrRmlPyEo7AjxaSdp6ALMsJNEMePCIczq3F9EUqbjnUK0QEcdq+CBy2fFiXWN9F5bswKvgYD3ipKxQFxuszKx47CbzXm/7Ppodz8vGTg8tO/atnf9JEE709PBfd9fHsNaFtJtkrrroSFr2+EGYMuythylR5lV59awEbkQkuHy3DXi7TCKjJ7KtFlGCPTGmHHfJKubF/n41re5dSxGOAy9JXcoLU/ijX3ZhwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVAYJMMTP+XXlGfUcSw0KKVhYJZJPac1A8vIybN/f5I=;
 b=O86bWz6Hikb2s2qXNBPgvY1pvz3GdXd0otcaFkbtPCUW9GzZymsJAhYWoEPoxbEgPq84/Mf0Ch9q0mxPhfyahcMHMPJbK8D6yeF5OEeGYwV752pTv4k+xVu21Myq72pTYnQLEE/NsO13EuBH0knLDZtbBzGMaqogbeBYQk6wgZE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 17:39:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 17:39:03 +0000
Message-ID: <25dd4f6b-5c2c-4d29-b088-e8308e1e300c@oracle.com>
Date: Fri, 31 May 2024 10:39:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: mm/memory_hotplug: use a folio in
 scan_movable_pages()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc: akpm@linux-foundation.org, vishal.moola@oracle.com, muchun.song@linux.dev,
        osalvador@suse.de, willy@infradead.org
References: <20240530171427.242018-1-sidhartha.kumar@oracle.com>
 <fe37643c-93a0-4220-b547-a5cae36b3231@redhat.com>
 <dec62086-8170-4fea-987a-9cc514cc4b27@redhat.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <dec62086-8170-4fea-987a-9cc514cc4b27@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a91b26-f629-408e-a383-08dc81988fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFphLzR3alBuUlBIOWxrRmRDdnZ1S1Fmb0FZN1R3ZG54aGVTWWhTbE5mT1NK?=
 =?utf-8?B?K1JkbVRrVjBpWjArMS9lWCtaSk1FN1VISmlKdGxvTGE2d3F1Y29KazR2NTNy?=
 =?utf-8?B?emVFcWR5ZHpOYkFJMGdRcVpXRWZrTHl1bW5IREFmK1FJRk9IMTVRU2tpemFo?=
 =?utf-8?B?VzRPdW5XYlpUeW5KaUlmOHRhemJqWi9aSGpvZWZ6eVpTN0dpdkxhZ0RuZTky?=
 =?utf-8?B?ZTd1SlRsc0d6aWNhN3A3T205bHJ4UzZYdnlvWm1TdGQ4c1hLMTYvdlpzSjc2?=
 =?utf-8?B?NGMzai81c3hKbmVySVR2dVQ2dXdKSHFVaVFPc3Q2SXhtYXpsbFVOVmI2dWlv?=
 =?utf-8?B?ZjRyQWVtbk1YL09wbEIwdm9CeWlZY3FGTHk0SVNva1hhY2VnVmxHdHBQVS9R?=
 =?utf-8?B?YXVHZzRkQStJQkk5VHZmY1M1Wm1vMUdLb2RZWUVCaFlVN0FlQm82OXVyNzZ0?=
 =?utf-8?B?d1hlbU5vT29IeHdGK0tENUd0czI4WDdPZ1h5YmcwNEtPR00xYU9CY3AyeWZu?=
 =?utf-8?B?WUs2akc2MWR3ZW9PYlhwMlBlVDBjd0k3OE4wclVoRVBNTVgxa2syMkpnM1pT?=
 =?utf-8?B?Q0lTeEtjN29LRDRGaW1zOW9xWVZyYlhINHg4aVRIYnhUVDlvSGY1bTVaZkdC?=
 =?utf-8?B?dW9TcWNjbjFmc21nZE9kd1dsTzV2V1Y0YlpPMmEwREpZZFQzSFZUK3ZEaDJ5?=
 =?utf-8?B?b0JyR1BoSHBSQS9jTlRield2V1hDTWhtT0JOWUsyZ282MmdJUUNxb3ovTmdn?=
 =?utf-8?B?OUtmUnpMQkdCRnVKOTgvcWxuUmpuSDRHWWdjMXNad0hUaUZ3Y2l3QjRzejlS?=
 =?utf-8?B?SEtYa1lNSDJTMUFsTEtZN0xnRkZRSFBUdHlQSkZzdUNZbXVwWmJ0Mk5lbFAw?=
 =?utf-8?B?TFF6YXdzVWtQUVIxUVZUWlpaa2pnYjA5cTJSSHlCZElsTU1jZ3B2dDNlZ25X?=
 =?utf-8?B?N1JoTUFlMG0zYytZc1Jlc2VnYlRiYVdKaWs5aVBwaTFuTWUzV3NZMjZUT0Nk?=
 =?utf-8?B?TjVQSFBRRVRRWjU2RXJrK2RNRVdXZ0UwRnV2WGJKelhZMDlpUi9rZTExd01I?=
 =?utf-8?B?UXgvOE5KL0hXRTBrazN4RlRNNy9MbHRNcThzcTZKRVMwYS85QTJqVDI0K1pl?=
 =?utf-8?B?UW1pSTJMc1Z6aGtpaW9iY29FNnRWcFdDZjFaMDhnMXY3SWlYbFhDWkxTL1Ft?=
 =?utf-8?B?MXRqZUdxajJmV3ZRdEttSVJnZGw4ckFmT0l6WG9JMjZhajNOeVJqWnc3T3lG?=
 =?utf-8?B?M29LcGxPZVByMGlGaHVzaHlxZ3FKWmhIb0lTSGs1VHlGdmIxdzR3cGkyaDFY?=
 =?utf-8?B?Nm5zbGVwdlU4NlRrdm44VU5ObDlDUjhkdTlGZHowQ2ZkenBURFFldEdVWjRn?=
 =?utf-8?B?SDFpTENqaCtUQjR1Ym5tTlh2MDBPRTluUHRqdFBnMHI5K0pBdE4xbHBSQVc3?=
 =?utf-8?B?QkFVdGJnYWtDOXh1SDRta2VDZjNITFBXVGdaT3dZWEpPU2MvMkh0dGUrQ0d3?=
 =?utf-8?B?cHRwcDFZbTFNekVCancxS0N4RVVod3M1cm9WNVRsb0xQVEFrQ002OUkyREh2?=
 =?utf-8?B?YjFETHVpRUxoeHk1cERMeXBGeXZnQzNaeE1VbW1nRTFvUERUNmxPUThuVFJp?=
 =?utf-8?B?TTFWQnl5a25USHdESGFNdGpKMldmdWJvZEY1Z3F2TDlQTGIrQnFUa21uTmdS?=
 =?utf-8?B?cCtYViswS1RYZlowQXNCWkZybnFIVTAzL1FjNG5KamQvT01NK1lLa293PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHcrdis0WW00anFpY0dJTFpManFZT3RwQVhZSktUdnk2MW1Vc3ZwaU51dSty?=
 =?utf-8?B?NFRMZUVNR2ZYK3FVb1FYVnNZSkNGOHR0UGFtVEhUSmtoRXRMQVZiajV1ZlJq?=
 =?utf-8?B?bWtoUGtYeENJSUh0VHJXN3VGS1FHVlpwVGdxd1Z2NHp2bStGTDlONWpHZ0ZJ?=
 =?utf-8?B?K3hURmQ1ZW1QNldxRHZ3amZGZlovQW9uam5jVlFCYzBpa3QrSDBQeDFDM05F?=
 =?utf-8?B?NmsxRTVodVRPc3J0eDFmNjlWdUZjYk83U1orL25CUTB2SWxsY0hYQVJKVEpY?=
 =?utf-8?B?eDNsM0ltL1JKQy9FMnBSWjhtTi83SHcrMm81bXEyZTRhTDBHd0xCZ0IydERl?=
 =?utf-8?B?TUFXY2pBQllpYUFjOHhTajdQc0l5aVlxMFNnT3R1OEFCalMwSFJqYVkvM2ht?=
 =?utf-8?B?MHV3MmtwUHhCTFlDS0QrUE8yWW5HNnBUK0NZcmNkS0ZiSnhrSGNxMVR4SUVz?=
 =?utf-8?B?d2RYdDQyR1Y2RnNEYi9hbTc3VkhHMDZwRTh4ZEFEZTBmZ3YzbWRSWVJ4dTUw?=
 =?utf-8?B?RktUWmg2YkhvOUk4VVRqaWpOaXVJaGZMMndZYkJ0eEJyVmlyQnVkZitYbElu?=
 =?utf-8?B?cDlybHUyNG1mY1V2bERUZEdGUUk2YUU2K3AxR1dSLzErWFhKZFpEbUxRRHBu?=
 =?utf-8?B?ZHYva1pKcVlweHlKbGw0WDkvQi9Fa2YvRGc2RTIxQXlzbDFiMGFQcXJxbSsx?=
 =?utf-8?B?TlZrYlphZDRuRG1oa0JYZXFkamlDczZkRHp2bmZWK2phMytaamJNcnZNVkQx?=
 =?utf-8?B?ZDM3RkZYV0Flak1nb3FUMS9QYUxJc0t5cUVPYWpaOGJMd2tvcVdraGhxVDZP?=
 =?utf-8?B?aCtIOVR2Z0ZwcHdSL0RzME1TRnI0TmZEZjhKSTBITlJmMkVMWXdLaklrK0Qy?=
 =?utf-8?B?SC9uMzZLd3FvKzBZTE5qTVBOc3JybFFDQXFlUGJETnViak1MTDl5QVNWNERv?=
 =?utf-8?B?NDhNNXF4eDJ6MG80MkhTL1VVVzdQaDRxa3BtcjdoOTFwLzB3YkRUb0lEbjlp?=
 =?utf-8?B?OGZoWGFJc21BeTlBWGxLc1hIU256MGREa0s3MkJLMnN5RGtaZDR6M2tIVjdD?=
 =?utf-8?B?OEFnS3ExYVQvc2dRTUdCNGROYStucGtVYlU1RkVaTlVneWJ0dEthdStsRzFZ?=
 =?utf-8?B?a2JoTVJETS9weWV4Tk1tNFgyNS9CSys1LytrK3V2c0g1NTgwcGlmV25wQVZT?=
 =?utf-8?B?RFFGS0FUcUd5MzR6UDR4dU1wSlhXN2p2ejlvcmY3TXJkQ254RXpyNTNYbW5S?=
 =?utf-8?B?eTg5QUhvaGVYTVNzbjhRaGdiODg0Vk5zQzl1bVByYjd1Nkdtc21ITW5Nb3N4?=
 =?utf-8?B?c09ZK2FVNTVsRCt2Sy9id0EzQU5ieWR1dkJqU3BTdFBWVlIwakF3bU9WZkJI?=
 =?utf-8?B?OFNZTEFHV0NCcTBDTDB3MGxLMVdoNFBLUnFTZW8xcGVqQWFJc0hhMldkTlpo?=
 =?utf-8?B?TUhDSGRBam5HeSswcTZuZTV5M2MveXBHLytlMDRBQmZuM2YvRFJNMmkrQjBU?=
 =?utf-8?B?VWZ3cC9zU2ZKNkQ4TlNpdXBadGNxSGhJaVo0V1VhQjFyLzZkY2dpRWFUTjFF?=
 =?utf-8?B?a0YvV3k4UUVUaDc1L2xJZnJobkV2c29pZlJhZCtpdHVnZWZ3RzBTTUk2N1B2?=
 =?utf-8?B?L3NmK1ROeTVQUXZzeUJza3Q4TEMvOHZ4akJGVlZZSlAxVlZvUXlrUGc1K0Uz?=
 =?utf-8?B?dWFpZlNPaFR2UWhvRk00ZjRMbFZ4ZlpRUnZRSEc0S28zQmR1b0JWQUw5S3hW?=
 =?utf-8?B?K3hMWDhWVks0OFV0dHJrcGhwRC9EdlNJWTExWk9DWjh6cnhpWnFyYnhFKzUr?=
 =?utf-8?B?NjdCWGZrY3ArUmtKRXJsMloyaFExTk9Sa2FKeXM4aFE2cDJtUXZ2bHB0eVFW?=
 =?utf-8?B?UXkrbzVLcmxTVTVvdFpac0pBdXA4Q3FqZGR5M3FxNnllanZubmZUY1Q4am1Z?=
 =?utf-8?B?Ny8vMGc3d3FWTjZPY2p4WVZYMlZnYkFFL2NuSzVEWFNiNHlwUW1JSW9oR2ZU?=
 =?utf-8?B?R1NkL1kwTjYvcThoWHVUVzJBTzJnWE40eHQvZ1lIT25HRHJBTUNSUTZzcGpj?=
 =?utf-8?B?QktNOVpjVk9uOWhlUld2Rkt5blpJYnlBN0svMi9LVnU5bytGeU1EeWg2TnZw?=
 =?utf-8?B?RVp2c2lDOTJpcWpQM2RucmprU1NRdytVckZIdmhFKytHVXpCdTZBODN5d3VK?=
 =?utf-8?Q?cXasri37f1uyeyoycdz3fS8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7VUPSFdrhMiLyTZSv6IuLf09s6SmG4eWJYYnfwXFWWfF1W4N03jc8mm4PCI3zbRquO81XVWe2RosRCvNfSk0jxK747lHArug+sVfeevAquTD7ypuuuk6KoKcmRH4wJT5RpxbKuXiBeyJW1l9YrAwusGuBdGlGvj7ndsungf8oa5Qq9rr39eMFdSzV7+uLsUUK6wuvsUF1BK6y9BF41GGyKjT5Dc+X1hzwZJVvqSzvpCxJoAYlI7W0933N1QZgicFpVo0G8ticWLZDmFTmcm1CZJa4boPkhDJl1omsgMIhrSIGyW7IXzTLSrH63/Bo4iI53XNiHIsBgBqtE7ugeMeJzOUSrL73Ve5q6gCwCJ6Ts7awZY0fcf4L9ktbIA2F5PGjWXP0+V9Iv/OAIIMxcHB4qCnLmb/PMRMDb7B4aS2Ai4WGNmIYv67wWT6rP3XUXPZUKIR+gH+eb+/tgBP7yZYhDS1Mu1spwks9ec93HuzPlgdYNlYFUCk/OKRFPVmjSH2xwB6cpvlq5uz1/3Dx2bbenHyrC6+5+9D83VGoIGb9hhep4qCJrNRxSESHXIIp/TgMwK6urcmFcYM+yOiE2qy2HvacP+hGZa/P9igTQ5c8JI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a91b26-f629-408e-a383-08dc81988fdf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 17:39:03.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWVnzwTsCcGAZTv/r8+21EhhJptZMXYcBwLnDGcU0VbsclRz3WMJjmS0s/LPaZza4+elWOxQqvbObCIQ8+MfqEVhZw6edSxY5y/9RQHc8f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310134
X-Proofpoint-GUID: fjevafYN3EQL0gTNL3cqHqqwQkg38hb-
X-Proofpoint-ORIG-GUID: fjevafYN3EQL0gTNL3cqHqqwQkg38hb-

On 5/31/24 6:05 AM, David Hildenbrand wrote:
> On 31.05.24 15:04, David Hildenbrand wrote:
>> On 30.05.24 19:14, Sidhartha Kumar wrote:
>>> By using a folio in scan_movable_pages() we convert the last user of the
>>> page-based hugetlb information macro functions to the folio version.
>>> After this conversion, we can safely remove the page-based definitions
>>> from include/linux/hugetlb.h.
>>>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>>
>>> v1 -> v2:
>>>     simplify pfn skipping logic with pfn |= folio_nr_pages(folio) - 1
>>>     per Matthew
>>>
>>>    include/linux/hugetlb.h |  6 +-----
>>>    mm/memory_hotplug.c     | 11 +++++------
>>>    2 files changed, 6 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 15a58f69782c..279aca379b95 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -616,9 +616,7 @@ static __always_inline                        \
>>>    bool folio_test_hugetlb_##flname(struct folio *folio)        \
>>>        {    void *private = &folio->private;        \
>>>            return test_bit(HPG_##flname, private);        \
>>> -    }                            \
>>> -static inline int HPage##uname(struct page *page)        \
>>> -    { return test_bit(HPG_##flname, &(page->private)); }
>>> +    }
>>>    #define SETHPAGEFLAG(uname, flname)                \
>>>    static __always_inline                        \
>>> @@ -637,8 +635,6 @@ void folio_clear_hugetlb_##flname(struct folio 
>>> *folio)        \
>>>    #define TESTHPAGEFLAG(uname, flname)                \
>>>    static inline bool                        \
>>>    folio_test_hugetlb_##flname(struct folio *folio)        \
>>> -    { return 0; }                        \
>>> -static inline int HPage##uname(struct page *page)        \
>>>        { return 0; }
>>>    #define SETHPAGEFLAG(uname, flname)                \
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 431b1f6753c0..9c36eb3bbd3b 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1731,8 +1731,8 @@ static int scan_movable_pages(unsigned long start, 
>>> unsigned long end,
>>>        unsigned long pfn;
>>>        for (pfn = start; pfn < end; pfn++) {
>>> -        struct page *page, *head;
>>> -        unsigned long skip;
>>> +        struct page *page;
>>> +        struct folio *folio;
>>>            if (!pfn_valid(pfn))
>>>                continue;
>>> @@ -1753,7 +1753,7 @@ static int scan_movable_pages(unsigned long start, 
>>> unsigned long end,
>>>            if (!PageHuge(page))
>>>                continue;
>>> -        head = compound_head(page);
>>> +        folio = page_folio(page);
>>>            /*
>>>             * This test is racy as we hold no reference or lock.  The
>>>             * hugetlb page could have been free'ed and head is no longer
>>> @@ -1761,10 +1761,9 @@ static int scan_movable_pages(unsigned long start, 
>>> unsigned long end,
>>>             * cases false positives and negatives are possible.  Calling
>>>             * code must deal with these scenarios.
>>>             */
>>> -        if (HPageMigratable(head))
>>> +        if (folio_test_hugetlb_migratable(folio))
>>>                goto found;
>>> -        skip = compound_nr(head) - (pfn - page_to_pfn(head));
>>> -        pfn += skip - 1;
>>> +        pfn |= folio_nr_pages(folio) - 1;
>>
>> Likely not exactly what we want?
>>
>> pfn |= folio_nr_pages(folio);
>>
>> Would make sure that we are "one PFN before the start of the next
>> folio". The pfn++ before the next loop iteration would move us to the
>> next folio.
>>
>> Or am I missing something?
> 
> Okay, I got it wrong.
> 
> "folio_nr_pages(folio) - 1" gives us the bitmask to land one PFN before the end.

ya because folio_nr_pages() will be a power of 2, subtracting 1 turns it into a 
bitmask.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks for taking a look at this.

>>
>> It might be cleaner if we would handle the "pfn++;" on the "continue;"
>> paths inmstead, and simply here do something like
>>
>>     pfn = ALIGN(pfn + 1, folio_nr_pages(folio));
>>
>> instead.
>>
> 


