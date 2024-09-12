Return-Path: <linux-kernel+bounces-325917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB5975FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C662843DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813FE126C17;
	Thu, 12 Sep 2024 03:34:05 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F457DA61
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112045; cv=fail; b=sOdk5yHPEmqC5rmB96z9Zv/DotE1h62ys0j5sEqkDilBSL3XrOsb2NBXnabfMBnQbpUeS6cnpP+ixwqtNzqSnC7F3l52MZ91InlIl/MNdT1hDc5dQkvneB5fsfDvGBtVrBR+ifyEZmhV9gJSe5SciBj7xz3AE3H2iOm8Ye8HlvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112045; c=relaxed/simple;
	bh=GQEvNd/KDdwRD4fy2RTh+LHTl45XqCSOi50OBIf5IAw=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=cD1RiMl3WCjrFaN7hsgz3Shog45Lov6mW3+80Xp6k6nKIuNTILML8Vi7vQcg32vcmmaKJHzWNhgrARuVUhDGbhhccVX6K6t7wIk0dJ32THnehi28MKmQg5MJYUCbtWu119r6QJzuu89Tk0jbtqiiqQaxt5+zCXU9N7nTCH065rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C201lG030249;
	Thu, 12 Sep 2024 03:34:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gc215hvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 03:34:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orf3KM4sIoU7e5N+qdY+o9yqJ1tvp9VCZX+TVcG3qPTWWUy0NPViDNjI7YMulbRRJXoJMOODTMfkkTKpgzcPdPHYtIpc0e1fOo93JTxlxDtcyiKJbIYNMXq0nyULcdLs5qKUEjpq/ky3vh+Mrdm6O/YtLSa46aLod/YTI5HSp8rE3v3kNYz5zxv6LT+xjVIBhfKJq4wBmbZlp+US69O+BhYqqwaXkIR4NYxswuxyyVl8NW2jfNFACMJF9bRPQsDPjFdp8Xfxr+omVv1KwYD9A+Uzv8d003DNz9yAKLyslQ/6Ar/i9UUxva/wLXkgxLEVW4tWnP8B5IFKmZEbX9x9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQEvNd/KDdwRD4fy2RTh+LHTl45XqCSOi50OBIf5IAw=;
 b=NV3YIT7JJya/pvQK+91hy11yeO1bdLCRRS4Jj/OExgZENTEVM1+fnnpW3OkpJgC9RbbJTQyN4rBm8xIj96Ky77fRQm2rDVIMAN6pXYDpXqM2zmfls5YEisGBgkCglqWqcJcxy5MGrzUG/QnnRMT9aWldTD+nz5zJVOGQr9N0YIjNxaqT+8XpMi9RFiZqnrQeqz5WQAvLsLC4EU80Z9tQ7XoE66yw1+ZNlJkipwd46e7lL7J7JpqXHo5076188ZSAfJCjXI0ZF8lliroWcvyYpKbQdPZe2tMeJiqE5L5F1EHz3eokEUZDZ6MClFqz4exVDG5HVHhHdWlhdCrENMhSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 03:33:59 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%5]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:33:59 +0000
Message-ID: <2c7135e8-c279-4307-8264-179eb69090fe@windriver.com>
Date: Thu, 12 Sep 2024 11:33:47 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Subject: Porting fix for CVE-2024-38545 to linux-5.15.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|DS7PR11MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 603f468e-ff7d-4098-8bfa-08dcd2dbbcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3BuSGNSRXh5T05Qb2c5eTdPWTd3Ump2ZVFlTXhNYWdTNnVnN2NXbnBHSUZF?=
 =?utf-8?B?dG9ORmcyQThHbWJhQjdwbERPdlJ5QjFMaW1obTVLeGtwaHJ0VFV0UFhBQXVz?=
 =?utf-8?B?bVhLN1JXRHJFakF6VjB0bzdVYXBXVXZTYkFTOUUrRG5iQnBwV0lqVkp0MkZ0?=
 =?utf-8?B?cnRiNzBXblBkbFhXSmZ6UTF4dUpUNW9ZU2p2V3Jpc09QbUZRWVVidWtwdzJH?=
 =?utf-8?B?QUZQNGd4VGdtTmdFcWN1dWIwUHFIM3ZjTWdmd3RVd0FWcGU2WkhKYUllV1oz?=
 =?utf-8?B?aWthWVAwQlJYMGVJTlRvSFB2Tk1tUTFaTGl5OU53ckE5ZzY4L0p0V0IvN0dn?=
 =?utf-8?B?My9VMnpBMUF5K3lEOXdxbkxRbzlrSy9NUGVpQngyWXlSbTUvOFZ2QUVKd2pL?=
 =?utf-8?B?SkZaWlF2UGoxYnc3ZmN5dnhzMU5ybkJoV1ZsdUFMZHplMVp3dUNNQUtBWjJH?=
 =?utf-8?B?NmtQVWkrdjhoUXdISERvWUtRbm1hMnZHNERjeDlHSWliNDdHN1ZNNWVwTW9v?=
 =?utf-8?B?clJ5bWh4V0xmbEp4Z216YWxqaisrTzFXbzEybENwNW9rRlZWc0RZMU9zL0s3?=
 =?utf-8?B?RE9wdlpsdGo1ZFlsNGZzajQxTHl0T3ZnMlJHS014bEtydGtEQWM0YVhvdmFt?=
 =?utf-8?B?Z3ZUSG1pNkdFZzFLSTE4TFdqaWZkQ1h3cUVua1FpUWp5NEJZbEd5NE5VMi92?=
 =?utf-8?B?Y2QzeXh4QmZaREo2ZXJmZU5JSFQ2b3ZKM1hUeS9XdGZySk93R2pKR2xjbGhL?=
 =?utf-8?B?a0haemJhKzZnblZuRCtldm5oRVIyYnp3VCtadXluQ1djb3FZWVZJVjJEMlFz?=
 =?utf-8?B?ZnJqQU1UcFV4VzVSeW8xSVBOVUVvQUNsMzVWWFFxeUJkUGJyb1JJRFFoUTNX?=
 =?utf-8?B?MVhVSGxOeHN2UU9Na3UrM0tVNFA1eVliOG0xa0lKN01lLzQvQ1VUMUFjOW1y?=
 =?utf-8?B?YWJUaEdnNko2R3NtbzZRZUo5VHg1UzkxbmcwUjg0WmdsWHlBNkdHV1doZlJK?=
 =?utf-8?B?YnhQaVBHZVZIUFR4ZGVHOFJrMmluZUxFclJiTzVjcllvdVhpWGFKVHZ4WDZP?=
 =?utf-8?B?ZjN0cnNZeldTbEt5Y3ltSVpPalcrbzdrWWNKbFkxWGUvVlBKaGV4em9hc1g5?=
 =?utf-8?B?TUQrTUNhdHZzaHErNXhFU1B2Tk5KYWRnMlZVUXpqTXhlVzZRbGRZcURtbGNP?=
 =?utf-8?B?MGhVb1YxVS9vaUxHS2U4SUtwL2Zhc2daM3N1Unl4RzFrRlJSYjRxSDVVOCty?=
 =?utf-8?B?R3p4Unp0SExpenQwR3VUNTlXWFpyalk4SzVQTUxGSlRDSXVKTVA0L2ZzVG9S?=
 =?utf-8?B?ZGYyUzc2UXZMMnVTdWJOTFFJa25TN28yZGY0ZFBjYXNTOTk5QXdvdE5HcFlh?=
 =?utf-8?B?OUNBMmp4NFlxaTRaTldIMElWVElOYVFEcHZ3aHY4a0hWd3pDcHZZMXBGbWdC?=
 =?utf-8?B?RTNKSHN0QnM4by9iYmJSUkIwY1JNaEF2NndzT0ZrZUpBYWtITW9sWjJ5OWNM?=
 =?utf-8?B?N2Jmbi9aY0VKSldYMmdxWjZ3M2tWZFpxU3haZkJOUXlWTzVCTGoyQ2xZUlF4?=
 =?utf-8?B?NS9McWxUS3JHNlFaTDVJZDcwNjhOa3RrN3hEQ0I4QnR6c2trd2crZzRqTkZu?=
 =?utf-8?B?cTZWbGJlMWYvaUZtbmpWL0NDSE5DazJoNytZYmNMaFNFN1AxOW8wbTQzZVpS?=
 =?utf-8?B?b04xWlh1Wi92bE1RT2ZOR3YvMmQycjQ1bzl1NEtjRVNBZGJrTHgvZEFGa0tC?=
 =?utf-8?B?enpqbGptVjhXYUNDQmM1QWdidFhxRnE0UHJVRThYeG1tdHBtT2s4c0pJcFU1?=
 =?utf-8?B?QVJSeW5mUGx0R0NaRlBTQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NEUTl1K25BU3lCK05sSkJEckUzVFhzRlFCaTNXWUtVUHY0amp4K0w5dVBm?=
 =?utf-8?B?K0k5bUNTRUVteVEyVjBxVjJVME5NVzlENWFOeGNwQjNlV01Cc2t6UFUvUlFI?=
 =?utf-8?B?QWdHaVBqS09ISGxQRDZKRVdFeHN1cEozUEUxcmU2T2xGV3pzVWkwaGl2dlh0?=
 =?utf-8?B?djhZSUhGYWNaakFrMkhXSW81ZmNpVDRubkJtMlhJK0ZBZjhQK0JEWmpXUjVM?=
 =?utf-8?B?SGpXUnA5SGpEVWF5YVE5MkRhUDMrdXR4VTNHUm5nOWNYODZvekZqK0RMVFFV?=
 =?utf-8?B?Q1F4bnZNTWhSY2FNbnpIdUQ4Ui94MytLdmNVaGJjaW9tTEFKTzV3VnBURzNt?=
 =?utf-8?B?VjdMS1RpcWtHNnVrSkZ0ZVcvNTNzQmRJclRWY0FiV1ptN3p2dXdOZWgyK1FL?=
 =?utf-8?B?NU5TcGJGak10cnhxNFl6RmhhZ2hRWGJXR2gzMWJkLy91ZlhGMm5PQzJYZ09L?=
 =?utf-8?B?MGM3Nmx4ZTFybGNtVGxOM2NNVFh3SlBhYVVDcXMwM1NxMkxkcFYzMDBialRo?=
 =?utf-8?B?U0N3a3M4V2ltaDZrTk9lQUdONU9laTNJYTdEU1Mydk9PMitsV000enZFNmdI?=
 =?utf-8?B?QXM1SE9pc3VHUko5UXlqL3JvZ2pHbm9kOEJ2dHNXODVEcmc2SFFyVU5uRk5Q?=
 =?utf-8?B?S01ibWFKZ2dwNFpiYldidXR3KzdxYkdEYllYZXBJSTh1NndxVmRKUXpPN3lL?=
 =?utf-8?B?bHlOMGgwRHN5c0J6aUNFSTc2SDhaUW5Qc01relFPNmpPR3Y2N2E2RUdXRFhF?=
 =?utf-8?B?aC9yQXdoQnFmenNzKzUwaFdweFZlbTJQN3JxKyt1UWFDNE1nUG9YckdubENv?=
 =?utf-8?B?UDJKTFg3N2ttMlVwUnZwYjRZNEpTSmNMNnFsSkN6L1dSU0JkZ0tocEVZT2dM?=
 =?utf-8?B?QnFDeDM5WXZ4OVZLZ2lxQkhLeHR1VzkvdmgxR3R3MUdHR0NLdUMzYXhKRHM4?=
 =?utf-8?B?S29XcWt3K3JKNWwrRmlyWXhwUXZWeWFQOVpSeEJMRzJ3cW0xQ3N3NDZrdDRs?=
 =?utf-8?B?eXhpZllHWkFVbG0xUHVuRFpNSi80d0NsMlhQdUpWaG41K0hBeWdiTzdtSksx?=
 =?utf-8?B?MzVCL3llRlp3UEN4cUlsWTNZRS94Q1BWZmpLOW9BMWlWWExUSnRYN1I1ZDlO?=
 =?utf-8?B?eWhVSnFFK2JBS0psczhRQTFMbW90bWo3TUVQYjhzNE5MRThhRE9QeGdoL2Ix?=
 =?utf-8?B?aTJsZnlBVC9wdDVZRDZCYjZ5NXF0Q0hmeHBUVjNjVGY5UmF6SDlVUVNaRlJH?=
 =?utf-8?B?TkI0ZE9vNEUwVCtzT0J3NmYzcjFMd0pkaHYrZytmeTFFWTFUR0t1OWZXODBX?=
 =?utf-8?B?Y0VFL1R4RTQvcVV5YmZBY2kvdnJFR2lRcm9PVnlqVGxSOEwvK1hyWEYzZUdr?=
 =?utf-8?B?WkMxcGxRYkd0S0dlNlV6bGJiMVJvamVPSmFHcnhkWXJrQ3VYa2pRK004a1F0?=
 =?utf-8?B?M3ljaEVyVUpiT2ZZbEZVdUtmK0FsUmRCaFNSa3czQ3ZKelI1VjZNYW40R3VS?=
 =?utf-8?B?MW5HTXhIdVlWUlFXaEZDN0JTL2lzU01GRkt4UnlWN0ljUWpQVTJVcEc5MmtW?=
 =?utf-8?B?THI0cEl5Y3FhYkg3bGZoQk11bjYrcmpsaU9qSkE3YnpVbTFnSDJvREd3bGFU?=
 =?utf-8?B?UnhsaHZhSXlGc1VyeDNWZXdiODd0aFhpRGJBTmJvTUlnK0RUbkZjM0k2NWZ3?=
 =?utf-8?B?Qmh3V1ppckRmTUtEeCtQY3pZcFlsTzRTN0dSMGVhaFNycDFjVTdRYnVDSDFl?=
 =?utf-8?B?dFBtUUpCUkErRFY2dzdnY05pcjhjWVUzaWhpNG9ZZnFUeGVnVTZlSW5lZHln?=
 =?utf-8?B?aUQ4VmxMby90bjZLQnYrdWVhc0R1ZEF4dU5BK0RHams4TkFpTDFJTmFNeTdx?=
 =?utf-8?B?NzZSd0pGaDZsYjcyZm5Zb1oyVWcrcWRWeEtrYk1wT1lnVUhvR1FoblRYZDZO?=
 =?utf-8?B?RTFFendFd1c4czI3UllNY1c5Z0Rmb216dWhiYUR4N01RTWFINFlVajdOVUFI?=
 =?utf-8?B?QXlGMU1vdlZHRk5YaDNWMTJDM0R1TjZnK0FoMkEySVV5UDJEOHRhdEthcDhw?=
 =?utf-8?B?ZVVQdFNPdmxKUTBXZklVQXZFM2tIYlNmUHZLK0JBZytLQWQvWmQxajR4anVx?=
 =?utf-8?B?RW9Lb2ZJd21JTk1FemE4TEV5c1ovRjZ6WGpUMUR3VmNOZEtPOHhnVjJHVkxO?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603f468e-ff7d-4098-8bfa-08dcd2dbbcd3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:33:59.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zGwMV1XTT6H3wwCHIDnJWYzNpG7tJml5m+Iv/xr0/u0x0JYNbGC0+J8tVEjyFJC8sIwTGseI+njFHK+a7634OqG1/a/dSybIAMMD1NYXJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-Proofpoint-ORIG-GUID: 4Ny7RUprWaxxyd-JJRQwcRa_Iw9jB5_-
X-Authority-Analysis: v=2.4 cv=PvDBbBM3 c=1 sm=1 tr=0 ts=66e26129 cx=c_pps a=x8A/wAfU1CBlff9R7r/2ew==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8 a=51EsuFGLM32FmWhwLFAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4Ny7RUprWaxxyd-JJRQwcRa_Iw9jB5_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=526 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409120024

Hello Greg,

Could you help to porting

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a942ec2745ca864cd8512142100e4027dc306a42

to the stable version linux-5.15.y

Thanks,

Haixiao


