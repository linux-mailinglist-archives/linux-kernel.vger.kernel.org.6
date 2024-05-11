Return-Path: <linux-kernel+bounces-176570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58E8C31C6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9685C1F21579
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDAF535D9;
	Sat, 11 May 2024 14:14:14 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2133.outbound.protection.outlook.com [40.107.121.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75B7F6
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436854; cv=fail; b=r0gJbiWxCZVWHXllh+8Yen3vRnsrLX39r8CqwqvS2BbuUiLYhCIAt3sVgFCxk3Vj9hK5+1EVdycqXi7BQu3SOcLXZh34BJwQvpgPeiibQ+iJHNrU5aoZJba6Cm/P2pN55ZXFNbZwavr4+AbuZNlIJ0LOb48KHmAghe6rPBlcQBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436854; c=relaxed/simple;
	bh=V8yklgQwhdkhIYXSlN1CVytHaR49CgMRe7m3oRb/Zhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=te3T6r3FWHlXL6UTYhU+d2LaSKxL8s7Ty4vK2hhw3Rw1Hw5amLKx8hitEiPnGjXc27sB5LCacKd+Kq6/BXF5Yp4aQfg7npvgHFIQbDCs5eTAIScB55Hznm4g7VIMwLISybGU8X2WDNwAhroupOXj1IVybSljDevx5lff74zpiAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.121.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjoQVG7g3paYQo6V2RLNpRY95AuWrt9lHdiL9U6SjQg41zKF6RWEOR3sWGiqobr3F9/whmIsNdGdOF9gmFpfA81Yzyk+jYSWCl1WBSURrAdybrN2su4726/dhBOkKj2gAxI5nODTs1hCbvL8NmPKih4zxSEtw+bSAKZBt8L9E2AjI+BBs5I7sk9vOSthMKOxMzic/E5FQXP6mUelN2GU9JDA6sWGqqnT/s2x2rKIJD3cN1HPIfUiQhaXt3Tg/27kR/+kQzh7mhcg2Yu5Dolzw9vENtbifICh9dJVqMqG31GJTQU8HsV6yRH40SPI4P58LhiIGVSBK0hsRfzc9OdWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoHQdjjSzauRdljt9q3nygyGTzBIonFSpYGGSS9XtOA=;
 b=lc/SAlNl6VYKw9HmKB0mvckm0Ur8WJMqwSF6IAFDoEVPyQUe3FBhxQr9/igSg70p2txNLXjj/3js1jEMevAl6GmTRL9/Yf/yuz0fZmJw3TmVNdhKAWi7orRSSAnqOP9eJ2BW5bNDivU4+OtyVkCIgPTzHit49v7fR2YK7sYq9Xh56t8mW//hyabF5SeM2pFrkoMGo+eDzuwhdZwJGNZyy6sAhN+XNqd8Z5sUYL86raSPYxMuawGlFeE08hUW4lkHL5b+1vXjLTvLg4s5HiizyhWsjX8HfNqMcst6OSjdGxc0FSatUh+iL0FiI/6W8LO32V+u7xxqPc4K8cEcx8lyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB5771.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 14:14:09 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%4]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 14:14:09 +0000
Date: Sat, 11 May 2024 15:14:03 +0100
From: Aaron Tomlin <atomlin@atomlin.com>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, neelx@redhat.com
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Message-ID: <qww6bjezmlxic5j2k5hpgjml2266evixfmsrvdkwmypvuzureg@rnuc66f3vskm>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <00b43845-c990-481f-be0a-4bf15ada8b3c@huawei.com>
 <5s3id43tqtwywggry7zmefl3jsaim3oxgofuhkeq3kmadtxpoz@srrrlrf5si5n>
 <96888d51-1abb-4a96-ba6d-f84dd1f7245e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96888d51-1abb-4a96-ba6d-f84dd1f7245e@gmail.com>
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d4afa3-8522-4490-55a0-08dc71c49ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVh2d3VTc3hPN1dPQVV2SFVYUk9FalBkYjFGbzJvWFBNR1FDdTBvbzJKNHNk?=
 =?utf-8?B?MjhYMVE1bG1BeGtIZStZYVVBMk9ObHJlYkF6dTNJK1BVbjMvU1lDTHQrM0R2?=
 =?utf-8?B?WnE3YmtMcFNGQWJVbG41d0I4MjluNi9qV1RhN3V2L3VOc1dWU2xKQ2V3Yy9Q?=
 =?utf-8?B?aU9vczZHdUFiRzJSaklkaVg5QVl6bkk3Wnl1d3NGckpPbGYzSHg5L080cHk4?=
 =?utf-8?B?a3R6dGI5RWpXekROWjI2VlF2WUlzeGR3Uitjd01IRWtTTnNtdThtUlRnR1pK?=
 =?utf-8?B?MFIvTHN1dHV3QmhZOFFyTGEwOWpaWVlQRWZmemVyN2dGbFBSWTgweUM4Ty9k?=
 =?utf-8?B?MEdPOXh3SDNsS3RBU3BMeVV0SHA0WUt3d1QwclkyZStpaHE1MndDcTBJdzIy?=
 =?utf-8?B?UnFLVjZENVo1OUVEbVE3cEs4b2JzclpCRVU5N1VXSDlIWXlSd3FjQUlkU1dk?=
 =?utf-8?B?dGZBaHRsOW9ocUFRY1VSSEdWcktucmZmNi9yT2pSZVUzNzZ2YWtpS2FZdXM2?=
 =?utf-8?B?U0tUdEFZdmNkWUtGMmJ5cWdaZTZoUi84TWZIZWl6YStVcnBpTXlDUzlqR0ps?=
 =?utf-8?B?aG5nclFkcThmQUN0S2tmWkFiV2JFU3FwS2E0ZmFPT25ZUWROL2tOWUYrNFQ1?=
 =?utf-8?B?Z3VRcm16UjNHVmVyci95SUZxSkk3Sjl1UHdQV1Ntd3VEZk16T0tHdEJTK0hU?=
 =?utf-8?B?aGZ0bkJTcjl5b3F1by9GWTRKSnZEa2hHL0FtZ1lLLzB6RU9GVkdxWHVxUDJu?=
 =?utf-8?B?bFhsbGZIV1pSMXpCckwrVGR0SFhJVWRkd1BUcEtPZHArdVRvNXk3TjRRbFNK?=
 =?utf-8?B?T2JlVlRxelk0T1NHdVo3YlpUVjFNNTI2Z3RXcGFhSDJGTEdWejA5a1BJWUQ1?=
 =?utf-8?B?anR6M2d4Sy8vdkRHZlpMcmNCOXIvSTRKWXc5VTB2WlFvdk1QSjhKUFBoaHlh?=
 =?utf-8?B?ZnNMam5STnJNNU9IS013VjhhQUE3QmFySW56b3VEc3JLTVFVTmR4bDRwNEcv?=
 =?utf-8?B?MjZ3RFI5VnMyMEJML3dQak01QUhyakFSQWxkNktVbGpDc0xZdmFlL0dKeU9P?=
 =?utf-8?B?NEkvTlFTUnJrN2lxWFZzcTJheGFldUptMkVXeW5NTUI3RFdZQW95SkZheWNw?=
 =?utf-8?B?ZDVQWlczT0txNnR5bzRSYzRCb28xLzNjWFdVMDZxdW1BK3ZxUXgyVkZxMmRV?=
 =?utf-8?B?ZmNWeE5jSkRicGpPNnFjZUp6bnhKVUVKSmZTbkNPbUJGU0RtNTZjeUl3ZzNu?=
 =?utf-8?B?bGN4QzErREtwSzZtVkVscVlxMWRwWExVVCt5U3psRStGSkVjWnpLemhUalVr?=
 =?utf-8?B?anBucTdIWmRFVWNVOHJ4ZSs3V1dlOVBxb3BmSVc3YkE5U1VLSTJVQ3FQYXFa?=
 =?utf-8?B?NXNHT0ZFYzQwcnpJSEZFQTdOdURyZVBiWjA5cWpZRFlsVVhUeXIzY2M3Q0VM?=
 =?utf-8?B?RFFsYWxNZ0FlcGRldWljSjhwRHMvajExdnJGSGhsOXlXWWVFVll3ZUFnMmNK?=
 =?utf-8?B?elh3N3lFNDJrMERZblM0ZGY2NmVzWnJQb3pOdnhpYTdCRVErWE5jZ2tYL2V6?=
 =?utf-8?B?TlB1L2Fzc3Y0RnFkTno2OVAySUZEQUxvbHhic2RPbDhhSXNDdTlvbFBIbndq?=
 =?utf-8?B?WGFQVTJXR0dFWHJBRjZvYkZHNGdPc3czT3lmRGMvckpEaWUvelJQNkx0eDk2?=
 =?utf-8?B?b0p3Rmt3QVAwUnlwc29XaWhIenRtbGQ0cEhyV0RyVGNyd1l5UldkMzlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDVZYVF0YW9IWmpiR0hwREo5UFo3R0lHeFNaSnZvUG5OWkVCWnJxdStxZ2FV?=
 =?utf-8?B?ODBlQkpGWk5aeUFDUFlnYkh2NldsaUNFOXgzeWhtc25aVVEwcnZiVWF4bmVh?=
 =?utf-8?B?RGFvcFE0UTNaZjNHbThzZlE5R0YyRks4TE4xRSs1Mm51cHNaOHdROG5WcUE3?=
 =?utf-8?B?RmtPZFRwdGg0UyswT1Q5enJqbjZGVmRLd1NDRkJyUnVMd25WRERkaWt2Q2px?=
 =?utf-8?B?eWlpWWgzNW0zT0I1RXVFR1ZWS29xZWJ1U3gxTHNEc1pwMStOWXJzUGVBbVZ4?=
 =?utf-8?B?ejdVakxtL054bXFOU3BORjIxYUdCaVNzWFE3T2tXbVFqa2YxbEMyM0lja1h3?=
 =?utf-8?B?R0p4U21zS0hPZXFoRGxTNHlON2FkS091TUZIUFJycmtQTjliVzVUeURzZ1c2?=
 =?utf-8?B?ZU9iQktwRjAxZWpJaHFPRkZFQldSZGIvOXZBdkdyRXhNT244bjY3dUZrL1pR?=
 =?utf-8?B?OGczeUdqemh3U1NCQWpCVmc4MTcwY3NNUnljNmRrYmROeisxUHltYXQ0THNv?=
 =?utf-8?B?Zk15cllieUk1cnlJYS9CYU1kNmo3dDJLMjkyd2lkUGd4NWFvbyt1azY4Q1A1?=
 =?utf-8?B?MVNjOEpjMzVMakhNdjVnd3BhU2dma0doaWxCUFUyaXR0OVpweXJRd1FYQmFF?=
 =?utf-8?B?YWFxWVcxVXVQRURNdWRJWXcyRmhmOFhJZ3BuNVVqT3lkVUNZMjF3dXIrMTU4?=
 =?utf-8?B?d3FWR3hkSERueEVSOVlkYmxvalpzdGF3NjJOR3l2NU91QmNGbm1mU0ZUcFox?=
 =?utf-8?B?TDdvUDk1L09qS0lxRDFEQzlXNW9QWkVYTXYrRHN0Z0pSRTBMK29FdGZjbkZl?=
 =?utf-8?B?NVhTeUpNVGpIc2lMUEdpYXVvMHp3T1Nhcm9LR2hwVDlmMkIyVEllczdOWDkv?=
 =?utf-8?B?SUZLYWgvY2NuUUp0WWE1L0xTc0pwNlBJY2hha2pVM3JwRmdaK0ZSbmpOT0I2?=
 =?utf-8?B?NkNPSFRxd1BNZHU1YWlCTUx3anVscGdxa2R2M1FHK0MvK3NyYnlDb2dvcnds?=
 =?utf-8?B?ejdrZnd4V0Iwa0NNenpyaUVmYjhPZnlRM1dCSVZNWHdaL2cwRkc4QzVQVHc3?=
 =?utf-8?B?b2dDZUFhRHl6UjFGajNrQUs5VXpCaWxYQlFQVVdVK1NtcFdlbzJsUjlTT1hh?=
 =?utf-8?B?R240c2p2dDZVcTc2c0gyQkp1VWhmY2M0SENubDRUVms5ZUlzQ2QzdzA5VkMy?=
 =?utf-8?B?UDk4eU10cW5lWEk2dWRoRVVqcU9jUFlESzR0YXZ3eXRQOTRidmsrKzRvRkY3?=
 =?utf-8?B?eWs0KzdOZGZ1VmJxRnQ1dnlad1VDYVlOdUNiNGhGMXg0WS9UbWlmeGZ6VDFO?=
 =?utf-8?B?dm5uSWNwaUtNcEtnL3FTV3NKOFlBUUlUYi9MRGpEclhLbzdrbTVLQ1hNdzdG?=
 =?utf-8?B?Q1dNdkxmSWM2Mk5GUk5KbUNvV0duVEFETTNpOUhZZEJXNUFac28rZ0NLMmtL?=
 =?utf-8?B?bWgvYm9EYnpjSmdzN1Z3a1ZsS2NNTEFGbVBjYVVqMCs5NTJLbjZnYXZCYUYv?=
 =?utf-8?B?K1FJVE5NS0orMlFFaFhWTDhPTU5LSlR0aHBmMldIdTFjSklyM012ekNnTHF4?=
 =?utf-8?B?MVRyTVdGTEEvUGlPVDI2L1pLcDJEMzBRLytKaENPMkFXMVMwUUcrRHFrRkww?=
 =?utf-8?B?djRzaUY2azN1THZQdGwweHVYaVVNRkZSUFU2aHRoaHI0bGJ5OFFTRkx4ZWc4?=
 =?utf-8?B?dzhEam5NM3dvNGg0UkZHNkdaU1N6UytzK3FTZHl2SEZaWDd4MkJ3TGNxUEZ0?=
 =?utf-8?B?VGZQMkc2L2JoUlpmOUJ6ODhzRlY3NWp5SjlzZldXa0tLbWVNbWtCanB3dGJy?=
 =?utf-8?B?Y0JnVFV3VVdOTTBhblVWaGRpbld0UXdKSjFGTWs3Wkd3MmwzTDVVbkh1ODhh?=
 =?utf-8?B?dCs2TExJc3h3TGpoZTBnZmIxSjgrbFpvTDM0RERoUmNlQ1FVbnR4RzU5RjVE?=
 =?utf-8?B?VEZjL3BQY0s0MStQMHdKYzl0SmJaalV2OG9EYmxBbVlmTmF2R0w4SzlwYTRU?=
 =?utf-8?B?eG9henUyaDVuZ0VMM2dkOURrV3lSOGFYV3JBMk1TL08xUXY3SDFSWm1zRkpl?=
 =?utf-8?B?b3NDMm42aFZuMlYrNlFYTEJzTEJXUnVZVFJWZkFLOXJBQjdoZUpKdDlQNGxP?=
 =?utf-8?Q?b0xRzWixIK5wv1aFpUEQ83Qqb?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d4afa3-8522-4490-55a0-08dc71c49ff1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 14:14:09.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtBrw/qheBRYM7evUJJm/wRnceqipDwAJSXklDvyFOQOYZRZ0PlF2gfa3DBKeVnrb2GNaz1e8RZswt2ncwVk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5771

On Wed, Apr 24, 2024 at 11:12:24PM GMT, Wenchao Hao wrote:
> Hi Aaron, thanks a lot for your reply.

No problem.

> I think destroy_workqueue() may not race with wq_worker_comm(),
> wq_pool_attach_mutex is used to avoid race, below is my analysis.
> (Welcome to point out if my understand is incorrect)
> 
> t1 which call destroy_workqueue()     rescuer->task
> 
> destroy_workqueue()
>   kthread_stop(rescuer->task)
>                                       rescuer_thread()
> 	                                if (should_stop) {
> 	                                  __set_current_state(TASK_RUNNING);
> 	                                  set_pf_worker(false);
>                                             mutex_lock(&wq_pool_attach_mutex);
> 				            current->flags &= ~PF_WQ_WORKER;
> 				            mutex_unlock(&wq_pool_attach_mutex);
> 	                                  return 0;
> 	                                }
> 
>   kfree(rescuer)
> 
> wq_worker_comm() would acquire wq_pool_attach_mutex then check if task->flags
> is set PF_WQ_WORKER.
> If PF_WQ_WORKER is not set, wq_worker_comm() would not access this task's worker
> any more;
> If PF_WQ_WORKER is set, the wq_pool_attach_mutex is held durning access of task's
> worker.

Indeed. If I understand correctly then a use-after-free is theoretically
impossible due to the use of the 'wq_pool_attach_mutex' in the context of
rescuer_thread() and wq_pool_attach_mutex(), respectively.

> What confuse me mostly is why the origin logic only append worker's desc when
> worker is attached to a work pool.

I can only assume there was no intention to use the rescuer kworker's
description information for this purpose. Your patch looks fine to me now.




-- 
Aaron Tomlin

