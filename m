Return-Path: <linux-kernel+bounces-300313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC195E23F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197A9B2121B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5DC41C6A;
	Sun, 25 Aug 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2qX4x0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iJVba8rm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37428F1;
	Sun, 25 Aug 2024 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724568147; cv=fail; b=pjfG9LFwCiJvx7ypzMmLVeA9b500ufk3Jlvo2NxcHSsITDMvVPKrRO0iz5IKSaAzY32W1NGeJMywvaLRHvMGqrknwNEdh0AC8i8vZ5jc1+2+R6sVDQ6mdPwgP+GAvk0Z8nJrGCDxy9/gU7YDYfmKa1aMy2BOaH93cXACZUD7e84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724568147; c=relaxed/simple;
	bh=hMMHXoVklacpMkSum0eagT5awNH4BsDyoyoE7o96IQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVMAe25X6bT2oUt0zP84dMbRah9aJFCUv1ZuKWKiLNe5I2sZPprfVzavYxvcKS1CCHuqEJ0e7m6fx9ot+4Q5/dSe451DX/3XeryyDRrdEXG43oiTSo9MvOO1NTiwAlG4+2mtC5ITI+pxJyXB5CKcArfquvFVsSnm+NRdXoW95Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2qX4x0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iJVba8rm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P4qx1d001586;
	Sun, 25 Aug 2024 06:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Pxn/PMLdU/i9VGCaIrzPUyPIFPlZccGcgjDX+R5mYfE=; b=
	k2qX4x0VBzF2pX+u2uHDP7D/t0X56y/oDWFwe7O7OpTfcJjr52OvcmYlZ46iHIZV
	F0K+3xqgZd9nEBQcaDeF5ajeJBUciv+Qv4hldt1jfI/i0MjVsOThY52Fi+85Ztcj
	83I2GSmPCdIMKRl12KieMgWU3gn0bW2aem+q3riJT4xhRG/8v7cpD2H+CN0c126D
	DklIjObcg3kSGuTVoOh3qKbz6MvuOhY4cAQGT0dt+Hfgs+BhUMOX3qvUc2lkNfEc
	Gr/c9PJTVRKi2B86aXotT/AW9Tc3tArGVzvBypLc+Eqe1MdAicPQOZQXxk1Zp4VR
	YkmtqhMP76Cp08J/QIXgTA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwh1s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 06:42:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47P5WIlw021512;
	Sun, 25 Aug 2024 06:42:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417xj712pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 06:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/ILtrnMlX/nCdQI/k2FLn2wxMWGHl+mEG43e3NbUcijRJe9kyx0RmXCDmezW4luTp7YVnU4VDB7pP8Wwe/nebABrBhOeP9vLMPmHRuwRiCeSHyzHiKXcPqhGeMTBsFXOdy+LHm8h9U/2Je8FyqMRsmg15/XXB4giWhj94Bjku56o40zT+UYAAiIkqi/4Aw1mOYzXpURVaHsg31wpxaaId46SxHNefrP9eWKiNiT9uggvm2UfHXiyJS1A7gYx14Eal+32C/xHcjBQPfTrBbLBydBCG9jfJxAgunwlPrlPYew9SNeN3zHr4FrC49WX/iDG+0WGQfg3beTHXlXx7njXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pxn/PMLdU/i9VGCaIrzPUyPIFPlZccGcgjDX+R5mYfE=;
 b=x6neS5JlMvezgdkeaVasghF4B9GAVwbXMuiD4B3eqSdPZUNqhDSeDdgIH/qR2iU50UeKF95ImNeaDnEYkuQ3f97R9LRmJ7914n74JyJMmknAxrC6iMzXH+Y4xW1bzM6tbCqEiAxI++BwyWjkedxwMlPxQRLN2iRVEJcPqgR4jgwiUwX1vbRpGsb4HmO8BS55UJvfauTe6rTFJbp/s8YoM/kcQ8ho2lKP747EG8kmVPyqkpCaA6ytCOgPSXeQx3NeKz+GPV0GUqj7RH6AFmhQ0oDPhtXvuier/rIyPeg47TI2KR8KcbWDnm1+tkbktjWJr2/ou9K0Q9uxpWSUzweW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pxn/PMLdU/i9VGCaIrzPUyPIFPlZccGcgjDX+R5mYfE=;
 b=iJVba8rmaQd3Cv2Jg2/B8VXNWCDCOshJyVFONaB3gU03g0pr/dhjrSRDf2gawCKXlTxvnoOCrkFHsPYUYPwG8/IfzoV77g3VI1t4z6sXGc0lD/56s2akreKHj6p73Qe47XgkUx0mmO86SUiUAYThyizgKH9GbACxpkQ8IqJVPAI=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Sun, 25 Aug
 2024 06:42:13 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%6]) with mapi id 15.20.7918.006; Sun, 25 Aug 2024
 06:42:13 +0000
Date: Sun, 25 Aug 2024 07:42:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Message-ID: <1109aeab-fd4a-4c83-a110-04d01177d72d@lucifer.local>
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: eac8ad0c-5467-4f88-8552-08dcc4d10da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3g3aTJ4ays4NXN1Z1Y0cjFBWENPcnJPOEJBaFFtZ1lhQUNOQm1OZlFFZVI1?=
 =?utf-8?B?TmdPay9JSFdVMUxLQU9BekJwZVRUNmZ6Mk52Uk93T0xjelJPdFlBNlVtaDVF?=
 =?utf-8?B?am92TWszeFQxc1I4U1F1aXdsdGY4R3BiWWlpanorbFZwRzBhYVdXQjBRdktm?=
 =?utf-8?B?M25pdzZIUmFxbThVV1BSZFI4Z0crcFM4MDc0b2d1YnFKTUU2cGpqMkpNUEhX?=
 =?utf-8?B?VkdCUDh1WEtBSzE1eHZJMEZ6ak0ycjJpZU1Tb2xkb2VocDhOb0I5bSs3aGdC?=
 =?utf-8?B?WXRPa1lLRzVTaGg1UmZVTXVoSzhyUFYzbWM1Slg5UHlVM0ljRm5DL0VaYWtH?=
 =?utf-8?B?NFlPQUlWcDYxaHZPZXY4Q2FUZlFLSjFBTzRSVzZRSmhJS3RkVzZWSEFIRG01?=
 =?utf-8?B?bzRFV3p4dHlRQlp4MXQ1VzN5VFcwWkVTaWpzem1uUnhUVVhPbHI3R09rdmQ0?=
 =?utf-8?B?OEZ2VDUzcUUveXVaZXJlSzhYMzVhcWJ0ckFBQTRuRW1jTDBaVWwvNFZMT2tp?=
 =?utf-8?B?dTVwaFJycGs0R3F0UlNKZzgwM3MrQjB5dFJNQTVkRVcvUjR4L1BLYlNrRzFp?=
 =?utf-8?B?SjQvZUhacHFFaXVEdThCTlhzd0NsM245amhPRjEweDZTWUZDd2h1QXhPQWsz?=
 =?utf-8?B?R0JiaVZOQm5qVXl3aXYraFpMelJTMVJTQzlONVorVktaeWYzb0Y2WDkybERz?=
 =?utf-8?B?WTB3RW5NWUdhRTF5WWt0Z0VnRHR6ZVlqajZwaWR5NE5wWGZXWE9jQmVZbk1r?=
 =?utf-8?B?K001K2x3MHZkc3VKamk0dDJZUVpRSXVQcmZnZE9yVXBWMU0rSGNWczVVRFlX?=
 =?utf-8?B?RTV6UTU4bnBqZ0Z0dHZ5OFprSU5CQ3kvbnJlTDQyZ2tGcUticXIxb0hNR3d6?=
 =?utf-8?B?TGEvekIyRkxXdnl4Z3R1YXZBdHdFaElvbjRsOGZrMmFPd295djBCNklUbFUy?=
 =?utf-8?B?Yy9wZS93YVpZM2RPM1k2ZmZUUGt1c0ZpM1ZjTmtudHJLTnJwSEtNOVNoNDIy?=
 =?utf-8?B?dG1vdGo2RnlSU04rTm4xdXdxSmFzWE5FNjhwOFRxTjMwaENJNkpUdEkyV0dE?=
 =?utf-8?B?UFlwYlZVSXhnMWJuSmpNRU8veW4yZXRNMFhyMm5ubjZoTStwY094QnVkSlBl?=
 =?utf-8?B?QzNsYzlQdll2SzJmSEhhVjdLY2lVYTZZYy9sVnpMOHVEcTdCK2xUQWwwZFJG?=
 =?utf-8?B?L3pwNXVqNVRYZXBXYzV3Zkk2VTA0YitGclRDbFRzUUFIV25OTlJyc0N4SHEv?=
 =?utf-8?B?dTltRGoybTZXQTRNbjhTNUxkVjZQS1hRZlNJWVdtWk5TZjdQNytxSnlpWmJ5?=
 =?utf-8?B?OW5LblhiM3BKZVVRQXZwNkZCZWpuaDkvVUt1cEFudUFINlNnN2RVWjVibEVx?=
 =?utf-8?B?TG5GTUpSVmVPMUhkbWtFNTNQYVc0eEhvd040d3VhNkVJOS9RMGN2TW9ZTjM4?=
 =?utf-8?B?VC9qOFVXY0dRR1FocXhOR2ZQVlB5RGF2S0todVVLMmFUYjVCUThHZWwyM2Fr?=
 =?utf-8?B?ald3d25qQS8xenpsK3FHVjdEajU0S1o3czNUVFFjY0VtU3d5MytpWC9wLzF3?=
 =?utf-8?B?WW0xVFFIN2VhSjBLTUw4eXdGRkhReHg4OElJVEVvSkNlMDFRK0h6V0Rtd1Ro?=
 =?utf-8?B?UW83S09kaFd3UGZPeXluWXBVL01vSVJrMlo2d1JIMVdXQVhkQjQrQktCN0pP?=
 =?utf-8?B?VVVwcHF3WllyMENJdFpDL2JwMVhUN29ZeFlONG8rNlpBMTlhbHptckpCLy8x?=
 =?utf-8?B?aG1nZDVZZk1UN2Z6MkJISHoxTWxqcmQxUmFORnJ4ZDAvYVVyZXdwRVY2TjA3?=
 =?utf-8?B?dnVDU1JTMFMrSWJDMXRxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJNRUlZemlhMDBQRGR1R2lqNHJPazBSWWpaK0V1Y3dlV1B6Rmg2MWpJcXN2?=
 =?utf-8?B?T24yaHlNYnJCdzg1VVNtUnBIVmIzYURvRWduMVowM21jMTltakE4a1NmOEJi?=
 =?utf-8?B?OFVWdUh6M1JROXFlZmV6ODN4TEg1bG9lS3h2eWtuaXh6S2tmUTFjSWpNcUhq?=
 =?utf-8?B?cG94Z0pwdWZ5d2hoMVFjM0JxRnR1a1dNZjJwcVR4ZTNXc2kxeGRYNFQrQWVJ?=
 =?utf-8?B?d0s2cFY5VDVmamRPUkFmVHY3S1d0MUdqcUVSRW1xazJZdTBYZ25WeUErWmNj?=
 =?utf-8?B?RkQvVkx3MkVMZmlpR3hsMHJWYlBFTjBGdXZ0K0pZclVhL0RsS3U4VXUybk5H?=
 =?utf-8?B?R3ZuV2dwTjZJYTFQVUg2ZWFZcE4vN3lxWFZJVVYzWVdUaXZxQUw5VFpXQjhi?=
 =?utf-8?B?MFVMYzc1b01oVkJ5REl4V2c3a2FsYWthRFp0eTJSUGlWZllsZ3l4OElRMFBO?=
 =?utf-8?B?Q1dCM1BJaE5TSEZmalY3V0dhc1M3alRrSEZrVG4xMTJQdW41QkFTa25JU2I1?=
 =?utf-8?B?VHhiQnIrTnJibDMwSm1VVWhsQzZzUGJBVGtGMk8zSm1HdUFqeVdkVVp1Tnc0?=
 =?utf-8?B?NkxXby9XM1JkSU1adWxJanZDMjJ0OFFkbGNCeGxMWGF4WFcxS1FGWWpPWkJo?=
 =?utf-8?B?d3J3QnpLYTFYRVJYRXkzSkNLRnkybHFYQ09pSFo2cXZHU0t3V1FqR0U5Q1I1?=
 =?utf-8?B?Qzh6dmo1NHk1S0hNVzJJdGIwbnZMM2I0OVdwazBKQmRnSnlJUzRFQzVwcUx2?=
 =?utf-8?B?cUlvWElmRmR5WG5WeXZLYU0zQzIxem1tcWtpa1lKMWFHcnA2ajJiS3NhSHhy?=
 =?utf-8?B?MUtlZ2hUL3pVTEpTbHc2V3JBLzB1bmdLdURVRUN2ejBCYnNIV3h3ekZWOXc4?=
 =?utf-8?B?V1BhMUNIaFI2MXI4T3BjUkNrd3ptOU5CLzBQMmdNNDdHY2VvTFV6QW05ekRX?=
 =?utf-8?B?M0Z1MWlXQ2lpWTRCeWpIT0pPWWhQTGFHN01PWmgvVzJIOHk3ZElMTFVFZ3hj?=
 =?utf-8?B?U0JQSWV2azNTTzdZS2UxWWFmSDduUXFCNThidTBmSTI2S05jSjhOT05kMStN?=
 =?utf-8?B?QUdwR2NZT2ZDRWtVWGdNVXFLYTc1VWpOcjlBdE5KOVBtRWhGNnJjdTMvQ1VK?=
 =?utf-8?B?d1l2V2c4clNtL1ZUL3JCUXNwZEVXNGU1ZDAvTkJESC8vcEJSTGRFcW5sSnNV?=
 =?utf-8?B?ZVY5d1V6dG5PZXJHSjRXKy94TFZrYnBHQThYa3JIZ1p0blBaQVMybUo5dGFT?=
 =?utf-8?B?S2dScjJIYUdhZVJDTS9XVHAvYmdBb1FiaHloSkNFaWJVdDRKM1RENk9BbTVQ?=
 =?utf-8?B?dm5sdUNrZkVVS01zMzFZTE1Db1AvT3NGcVYrUTZEbnd0UTNxNVF3WEJxNG9K?=
 =?utf-8?B?MVY1OFRISUVXbnphWkhxaGRMS1RKSlZkZ3JCWFRsQlRnc0ZyaXFHU0hZbUNj?=
 =?utf-8?B?MGVwNCtUVFVUMHFtQ3J4aWZ1UUgrbGhNVUpEek5saHFqc1B1Y2VHODdvTmZW?=
 =?utf-8?B?N1A0cGQ2Nlk5aHQrdUQ4U1RaQXE3ZU45dDRSN0RNWXA3Vk4zMDNkY2VLcDA4?=
 =?utf-8?B?M3BJS3NSbXM4WGxjdGU5cHdJOEJaL2dVMU5PdElLSXlIcGsxT1BGbzdYTE1T?=
 =?utf-8?B?ZWdPQjdkV0lPcm54L3ZoTWsxS0FWSGFsUXU5V091bTRZQmdrYjNwQXdXM0pB?=
 =?utf-8?B?RXZEUW81ZlFaSXFNQ09HTklQcmJiY3NHNXgydy9hb1pkY1ZtNkRtV3R1bDAx?=
 =?utf-8?B?L3VWUW5uekN3UjZVcmFVamxLZTRTOS90TWdhZStPK3NOQ2JDa2JJeUpxYVE4?=
 =?utf-8?B?Q2szN1QvUG9KVDFnc3lzdEVJMkpyQVdzRjJ1bkUvWnBWdUV5N3YyZHcxSVdo?=
 =?utf-8?B?U000TDM4eEI4RUkyQlJ1V2ZLdHA4dWNiVmZNNi9XZXlIakJpSnF4S3VQM3Az?=
 =?utf-8?B?cUk3V0FoMXpqYmM0dHJkOS9KRWU3ZnVzN0d6UFhWaE9neEdPSytBM1FDcnVE?=
 =?utf-8?B?d0ZGUmFqZlBlUWtsczR1WEdEVWtyd3pPbitvWkNQTmJxRENhSlUwZXRrVDhz?=
 =?utf-8?B?ZVArTFRadnZmcFVjVUdWOTZoR0xWczd1ZkMwMXZvOXpGQ2ZXQzZtTWZqcSsx?=
 =?utf-8?B?SUlrUGUzTkVoZ2M3b2FhMzF3Mi9ucjZyaU1EVkUwc2FzUld3aHAyVmc3eU8w?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S416get0kH6bxTCg7PaDCs4UOjQouY6TDhJHVym5MmomRQYLwLuTEis3JkpUqI9vVcE0M6HHoXd0ooTDkQG/O5TOThhfzBi8q8CvLkJXgJbhQNnekas5j11jbRccNpBA910aV3/Xw5dKtVHOtWAe+UEgZxVDbKCDjTmHJ5O0myXleI0YIgY9xuYGtftmVssDhQFdH6zxYvR1xyptCA0PGhVm8Dw8st8GWLcswXz/XBXCs1+xJk22A3XGlnwJRT5N9v/F77UWLdlkIZKtPJM4KcZ+MIL+mPn6SYXk7khH0hd29EUYPPSJkHPkEHy0ySp4Xo3YVxao1qXvGDug32uA8Tmc6tKE5qCVgV1xSpmeLHUWdl/cmIHamyMDBwbq3XaYUWi8PiC3jscVlMHl5bZopIKom0Eot5aFEo75gj4BKQwNgnqytHT4BAweRMjKrpbZYJTNiSSlSO4xoG2p+5JFXuBxhI8LVafCY52e7FlMFvNCs9zFk5zC7zZPHwPI4T3qoFo/VWmvIq2p4m+Z30E9DWrGEK09mUrb+Z55ccuKfsKSb8wo5WdC+06VgNHvlU3JiKSBZK/rjAUz2+OK9ZLfD6Hbrlbj6Z8NRfsJK3KK3Wo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8ad0c-5467-4f88-8552-08dcc4d10da5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 06:42:13.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yzla+CHDM7qjL1qzSV/eKrB/1PBrUkgRZizubBcFcjg+Y30a7BFuPK+ic5OGG7mooNV6mvEXn6bdCrP/njSCbAcxrk6nK02KS0eTnVkBr3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_03,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250048
X-Proofpoint-GUID: hzNQV3afMRO2NTJcWUyG0uMmzqU6gdRu
X-Proofpoint-ORIG-GUID: hzNQV3afMRO2NTJcWUyG0uMmzqU6gdRu

On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>
>
> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
> > [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
> > > After CoWed by do_wp_page, the vma established a new mapping relationship
> > > with the CoWed folio instead of the non-CoWed folio. However, regarding
> > > the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
> > > not same, the avc binding relationship between them will no longer be
> > > needed, so it is issue for the avc binding relationship still existing
> > > between them.
> > >
> > > This patch will remove the avc binding relationship between vma and the
> > > non-CoWed folio's anon_vma, which each has their own independent
> > > anon_vma. It can also alleviates rmap overhead simultaneously.
> > >
> > > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >
> > NACK (until fixed). This is broken (see below).
> >
> Hi Lorenzo Stoakes,
>
> Thank you for your comments.
> > I'm not seeing any numbers to back anything up here as to why we want to
> > make changes to this incredibly sensitive code?
> I added a debug trace log (as follows) in wp_page_copy() and observed
> that a large number of these orphan avc-objects still exist. I believe
> this will have a certain redundant overhead impact on anonymous folios'
> rmap avcs, so I want to remove it, which is also the most essential
> value of this patch.

Sorry nack to that idea unless you can provide actual _data_ to demonstrate
an overhead.

And even if you did, given the original patch was so completely broken, and
in such a sensitive area, I'm going to need to be VERY confident you didn't
break anything, so we're going to need tests.

>
> -- the vital part of debug trace patch:

Thanks for providing! Will snip for sake of making it easier to reply.

[snip]

> >
> > Also anon_vma logic is very complicated and confusing, this commit message
> > feels about 3 paragraphs too light.
> >
> > Under what circumstances will vma->anon_vma be different from
> > folio_anon_vma(non_cowed_folio)? etc.
> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
> vma's anon_vma firstly.
>     /*
>      * First, attach the new VMA to the parent VMA's anon_vmas,
>      * so rmap can find non-COWed pages in child processes.
>      */
>     error = anon_vma_clone(vma, pvma);
>
> When child vma->anon_vma is NULL in anon_vma_fork(),
>     /* An existing anon_vma has been reused, all done then. */
>     if (vma->anon_vma)
>         return 0;
>
>     /* Then add our own anon_vma. */
>     anon_vma = anon_vma_alloc();
>
> new anon_vma will be alloced and filled in this child vma->anon_vma.
> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
> new anon_vma will be different from folio_anon_vma(non_cowed_folio).

Thanks for the explanation, but I was suggesting you have to put this in
the commit message rather than in repy to me :)

> > Confusing topics strongly require explanations that help (somewhat)
> > compensate. This is one of them.

[snip]

> > > index 93c0c25433d0..4c89cb1cb73e
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> > >                         * old page will be flushed before it can be reused.
> > >                         */
> > >                        folio_remove_rmap_pte(old_folio, vmf->page, vma);
> > > +
> > > +                     /*
> > > +                      * If the new_folio's anon_vma is different from the
> > > +                      * old_folio's anon_vma, the avc binding relationship
> > > +                      * between vma and the old_folio's anon_vma is removed,
> > > +                      * avoiding rmap redundant overhead.
> > What overhead? Worth spelling out for instance if it's unnecessary to
> > traverse avc's.
> I think this will have a certain redundant overhead impact on anonymous
> folios rmap traverse avcs process.

This is again nowhere near detailed enough, and again I'm asking you to
write this _IN THE COMMENT_ not in review.

I already understand what you're trying to do (I think the fact I provided
a _working_ version of your patch as an attachment in this thread should
give a clue ;), this is for the benefit of people coming to read this code.

[snip]

> > Again I question the value of this change. Are we REALLY seeing a big
> > problem due to unneeded avc's hanging around? This is very sensitive,
> > fiddly, confusing code, do we REALLY want to be playing with it?
> Thank you for helping to identify mang issues with this patch. However,
> I think this will have a certain benefits for anonymous folio rmap
> traverse avc overhead.
> >
> > It'd be good to get some tests though unless you move this to vma.c with
> > its userland testing (probably a good idea actually as Andrew suggested)
> > this might be tricky.
> This patch belongs to anon_vma rmap's content, and it seems more
> appropriate in mm/rmap.c?
> >
> > NACK until the issues are fixed and the approach at least seems more
> > correct.
> Thanks
> Zhiguo
>

Please see the attachment in thread for an example of a working version of
this, this is sadly fundamentally broken.

But you're going to really need to sell this a lot better, provide some
numbers, and provide extensive testing and a much, much better test for
this to stand any chance.

I appreciate what you're trying to do here, and it's not totally crazy, but
we have to be so, so careful around this code.

anon_vma code is horrendously subtle and confusing (I actually had to
reference my unpublished book to remind myself how this stuff works :)), so
we have to tread very carefully.

I definitely think we need ASCII diagrams if we were to go ahead with a new
version of this. But then again I'm a bit of a fan of ASCII diagrams...

Please cc- me on future revisions of this series, thanks :)

