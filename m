Return-Path: <linux-kernel+bounces-326881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A81976E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE271C23618
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541A1B9B24;
	Thu, 12 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0sPo2Bk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="leq9nbVs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB831B9B33;
	Thu, 12 Sep 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155820; cv=fail; b=MVZXx+k7fm/vyQIkldMDdX7/g1v3/M2sIWhzT13G8uPSMlLQYceaTUlfn5KZESq4WuRuRqYihtHEK5EtvbETW6DlrXrkvWlW3OrWiZldqI4It09hvXZBEk+yeiIKEHQSGOpYB39JIadJiHnfdiB3yvK5zXLxLunO7KA4EGkIikQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155820; c=relaxed/simple;
	bh=8PrwWCBepUmMZwkhgY+1Xn4EHI0iA+VtTwCVfJhuvPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFNHhMZ76+izjF1tFFoeXn1qdmHkAPqPKcandxOM9NJhKkjletzO1B140FFujvKhFTzXM1FEBAuJQsFDeibSP02rXNV2EqNYAH0sKEWFaM/Iwf4rduDk8scuGkexGUm36dBXDcEw1iDrxp9RH/nIJ9JKwAUjqjFnrdzQuuFJ7n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0sPo2Bk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=leq9nbVs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDtcH6019895;
	Thu, 12 Sep 2024 15:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=RTo2LhUtJ/Fvb8yLCgLm2g3fP88DpDRB5lKIAIgnskg=; b=
	I0sPo2BkmUE5UJ7LKBe1SNYG/WuaPTzdGol3zaLkBaQzRNSUWvwV8g+7buY31GTd
	Q7j54ZjTxw3iBQubiRo7CkDN8wQGyX2Djb8ETaE8vVH1oel/sAw7/0t6DINs56Ga
	ykvSX0In3Px9uHPN8dvKkbhZIDxQmtRnzeRJYFjG0+rz+ClnALmf0eXp8MSIDjXG
	n6p/MvachEqeX01IVzqdC+S6XM7PDQ2NJA979pM3sJv4hWcBQJcRtYRZKwL8wKhq
	jdxrQ6SkJvmTginCZZkIYNhMa0caXCnthvQnfh56QgPN6a48MfWTwyPZF49wTd/V
	zSpRBA/JpWQPPK0iGEVZlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0bae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 15:43:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CF4nfE033673;
	Thu, 12 Sep 2024 15:43:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bf7cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 15:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MijIaoTDrL/sOoO1UiQ73Mx9qLTgXFy5obg7E8Xy/9NB10v8ZZ9LpQKHRGKfnJi9xjkdoGvGaSO+EogtM8tOMvKCqzJ55tZmQC4aaUX1wY2AiyweUC81+3ThZOrYvUtFxkTUrt6TYxypx3fbz3B+IqUWCvT19rksigy+1hse5E0k+p0KXOYpT0eDVCJHQrxY/QTVjG2IMP3BBIircgjM6uybfV5/6ij4ifFkLgNHuiu+OS5gi/e70m7EULkFA1S0yxqY2eXBPFVQC+wspLzMxoTa/NOp/tFSEI/QRMMzmHd5ewR5bTrn4qWfhqrSg98aIaVocjmtRBV+hEcuhZPSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTo2LhUtJ/Fvb8yLCgLm2g3fP88DpDRB5lKIAIgnskg=;
 b=Wn2CMICf6963orZKdAF6I6E+cTkqyDXIkUIsJnN4EYzW+l+FvRkS+i1BoRNzb9BF2MdQWCN4Coa/EiINRdmVoEXW2jkSBBjjE61/mFkzL/BB6wvE6CIOdFYhKhv/T22cl5A1XJ8dvJ2mCaB3gc2zIRYh1FSRSlsJdH/UYjw0p8FmwvwjNwpHauvHgj7z4GZ0Cqe7hnKiHH5rFltAbqYtuO1dHMnuTRi2/DfzVYFJqdOPMOzjdu62wE4JBkPHthgQ7Es/1u9op5RpAK4d1oZchoI5V/SCyV6+t+gyoXtLR3EiD1/4iDntczBgta2cVDceedAODcjNOqOczJ9bNGFDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTo2LhUtJ/Fvb8yLCgLm2g3fP88DpDRB5lKIAIgnskg=;
 b=leq9nbVs29771xlDkHkxUdgQk7bPn7pp3b7FeTvC52Zo3WA1VWmvb/clLVzwh70RK+lzklkgrGrmPY3p0i3hA1vzbbUZ4FwLnVYVBFem0sRLAz9jNXTf67s39SRv5pM7EeGE7BdsEAucYK15NiB4wl7Lk3A0D9IoZaVnQZ7obnI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Thu, 12 Sep
 2024 15:43:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 15:43:21 +0000
Date: Thu, 12 Sep 2024 11:43:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Helge Deller <deller@gmx.de>
Cc: Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <bfkqcuayvrdt5xieqhv4lhx3ry6vurxzvvluxodrjzar7cyycl@id5377gr6cs4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Helge Deller <deller@gmx.de>, Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
 <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>
 <c226a38a-3612-4949-9da7-8d42f8636b47@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c226a38a-3612-4949-9da7-8d42f8636b47@gmx.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf595ab-6013-479b-6659-08dcd341a161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW9jVXFLZjRLU0d4Sy9iZ0Z6b2FkeC9yaUo3RHgxdDNKc1JBUnM1cFFXaldI?=
 =?utf-8?B?bTAzeGh5eldVWm9Ib1NIdjhLKzV5SVVUelJ5S3FYbUFSSTRyOVZMcUxNSTVM?=
 =?utf-8?B?KzE2NkZCWEh3alNyajdqMWU3MTVCamUySnMrYXd4L0hxSkFqeTRyVEN3WUZE?=
 =?utf-8?B?TCtVb3QxR1RVNHRSS2g1OU15VnJEZWxrMzNTeGhDdVYzTCs1bFVkZ2lVd2Nz?=
 =?utf-8?B?TklIeXZhMkw2QnRubHcvQlBycGxKY0FUdXRDWm1VeW5rTUgyV2RpUVFwYXBY?=
 =?utf-8?B?WkY4Z1pDZmY4SmpLUXZxZ1NHbFVNSjI4elpoYWhxNWhxYTg3Ykd3NXZXWCtU?=
 =?utf-8?B?Mzh5ZTE1KzJ3a041bE96WE5ndEVJSlpJWWt3bndqbW5USk9tYS9aQ2w5clpE?=
 =?utf-8?B?SmRrMFdWbGZ5NXc5U0RWMjZ0UTZSUVU3QW1xZ2w0aVFrN2FSQWJlU0NheWZP?=
 =?utf-8?B?bTVneWRPQ0M5S3FHSGJhM2J3UUpTeXY0TFNXSUlyZWJEWHkwRkFRa2NGRUJv?=
 =?utf-8?B?OEVmUjdGRW03VUdWUnlNRG1WdU5EZkZkVENxMWdhc2plNklscDVIYW5QOXVw?=
 =?utf-8?B?ZHgxcndjRjFsekJSd21lNUVFQ0kxV25pZEd1NXNOeEtCam5GM29OS1lVbW9z?=
 =?utf-8?B?czMxS0x5VUMxci9SR3lhQjhCcC9ydHZ5MHNOTWNqdVZtYzdrSWlBNmlzWDNU?=
 =?utf-8?B?aDRXNUJsTEFRKzlYUDRDU2h0TnhvR0EzM0gyMnQ4OEVzUWdaQW5XM29INFEv?=
 =?utf-8?B?WUFMSXJNWStmcTdHVU9VbStVRWZBbGVZQ0VUYTdVbTNFQU1pS3JXcHF4Qkd4?=
 =?utf-8?B?ek9xUmZKaXoyUzdDZ0J5NGxPb3VQaXNCREo1OENSdHBDcGd2cVV4ai9Mb2VC?=
 =?utf-8?B?Q1FGSjhJK3BvTHlEQlI2cENMRUs5UHAvcjhaY2FRTVdFcTQxRjdGWmJySjlt?=
 =?utf-8?B?cVRrUENsdGRDVmFGOUdKZXhCbjVXS0ZhODBKbGNkUzR4Rld2am9ZZ3pKWmpV?=
 =?utf-8?B?ckJJYU0wRWl4b1lramNleDkxVTlPY3gyS05FOGFIZk5ReXA5RWkreWVJUit1?=
 =?utf-8?B?YWJNSFBneW9kTzJOMUo3YTJRQVdLNmgydUNDK2U4M3JHVWJVdGdNSGp3czlv?=
 =?utf-8?B?SHo1c1lJRnhhY2dySmJreHoxNk9oZlIzeG4rNU1NdkFxWm82WWhhOE5kdXZl?=
 =?utf-8?B?VkJRYmJnK0hIVkxaWmVWQ1pHTndaN3hlODNYaFNXbnJtNzJZMkVnQWx1eGMw?=
 =?utf-8?B?TzhuYkNzQXJMUDQ5VGUrK0VyWHJiai9TdUpXSE1jR2JJSFJaQmhCRGpxZTNw?=
 =?utf-8?B?UERnVUR0TnMvZnJjL3RCMlVtMmNZYkZZU0VQNElZTko2aUpmanN5NC9kcmdj?=
 =?utf-8?B?UEZaNlUxaitEN1E0UUpaR1FIYjdLZlR4dWVIdzE4dVZQdmE2T3FEL3U2TlhL?=
 =?utf-8?B?TmROVTJFeVFnb2FMWEswMjZ1WFVjVHF1MG8rdlAwOHZTY081NjN3Z3crVUNy?=
 =?utf-8?B?U2llZjE3aHBtK205RnBBMDNhbDVIVGFBQWM2MDZIUXQwM1I3OGNGcDRlNjJ3?=
 =?utf-8?B?WHJ2OUROc1ZJSDF0QUxYV1dlcXovQzNYK1lVSW9sTlh4cDFTdWhIT2IzNlZ4?=
 =?utf-8?B?MkpNRFB4SnZmMGFhSFA2YVMyNktQazNCWnF6eSt3TzVNWVpwenFqVloyMFkz?=
 =?utf-8?B?R1JsaGFuQ2JmOWZTT2M2QzdKNzFnNHRDZXhJYW5rOUQ3M08xa0Nyd1V5TEs4?=
 =?utf-8?B?dmZCZ2x2bHd3em12NVZzNVc1OEF3VmVHZWt2b0NkeXkzckNLSFhtc0svVFh1?=
 =?utf-8?B?MlVqSHNIR3ByTUtidmJ2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NXUGpraG02dmJUdlVRR0JBSXRLQjU4TDljSUJjVGF5SitGamYwTG9FaWhV?=
 =?utf-8?B?aStZaGdwUTU2VlQrbGo3NVR2dWw3WUtkWlhMeUNkeXdSd0g1Y1JDTTI2bmJo?=
 =?utf-8?B?MXRvaU5PV3FMcXZySVJqekVjVDg5UXBrREVOdU9JUExHVThGdDBrNUxoc0Fo?=
 =?utf-8?B?ZzIraTIwOG9Da0N0ZTRWRERoZVN3R1RyUlMwQUZ2QjlwTjZEeUFOczViVSts?=
 =?utf-8?B?cVpiYXFCZ3R0NXdNMmVFT0J3NU1reW9JcmF1NDdEWWFUTkQrc2NFZUI3UVh5?=
 =?utf-8?B?cVhFUk5KSUtyRUg1MlkxSlE1R1lrNU1OL2plQ3lRL0NuK2NaWmtxTzlrTk5D?=
 =?utf-8?B?cU5Xd1IvMXhyYkM0THpxWG0zMnFVc2J4dDdOSndUbGNUZ2RLMHRSVE5NZWsv?=
 =?utf-8?B?ZDZGbXl1RS9qalhCNnVHdm02OS9PbStOdW5RcFZvRVRJYnhzOWVSNHd0eHhy?=
 =?utf-8?B?MU1BQ0NjNzR3c0VuU29Qckt4NGpzTzNhQmErMURuV3RuNUtLcENkVGU1TW5m?=
 =?utf-8?B?SVBHbG9yS05mMDFkbGIwRkN5QXVwUExUcHVlbXA2RGd1ckczanhMVUZhTUh3?=
 =?utf-8?B?VHhJZ2xXUFI2MHozQkpWU0pVbnpYTWpUVmU5Q2dhSEhyQ0NJRXltMGFndk9I?=
 =?utf-8?B?NjBZSUtNSXR0aENId2UvQ1lhNHNRRFJsRlFuVnNGUTlIcG96VnYwQXBsclk0?=
 =?utf-8?B?M2llVlg1SHI5K1BvR1dnSTlWL1hlTzBLRElhMnBrOElsc3NrNk54cm1lMEJF?=
 =?utf-8?B?MUpwUEZQWEx3UUhvRUlERXROZkpOeitHSmFvTERaZFJYYTM5d0JtVStkY1l0?=
 =?utf-8?B?cDE1R0JieCsxTTV5MVRYUjdlV3d6WDRic2hDZEg0bzF4YjZPZUZaUkRhN3pE?=
 =?utf-8?B?VWgvblpRUEN0bnlFYmN2czExU3h1TzNSM1ZQekMrSURzb3NvNzVxemEwbDMy?=
 =?utf-8?B?dk5yaTJ2TlVxMmpPY0w3cStXZlh5K2ZQRWdUbjUwdzZVUFAweW1Za1BtNml6?=
 =?utf-8?B?VjArK2xKdlNmb3plNW1yRVpDQTBXZ2xqTlAzcmFMZTlzc2pHay9JK1M5MEts?=
 =?utf-8?B?clRWeFVudU1nbXVRdzRlVGhZNXF6aEt3N2NRQ1ZxQjBJUTFOQnpuUjZOS0NO?=
 =?utf-8?B?bFV3RHB3NlAvTkt0OFRyd3VFeDU2dmxhZTVKR09nN1N5d2tOUm9DcFRHTXZs?=
 =?utf-8?B?UUhWYjMwb2V4VmdBR05DUXAzMmxNYzFzZ25HakRQaTROL25ZVlN5bExPeEUr?=
 =?utf-8?B?dnJFVkFvYTJJNmNKZm9iNnFQTWwzZUlHSDRWcnovKzJlYUhxZVhRRGNrMWVm?=
 =?utf-8?B?a0JTVmN6US9hQVB4bzJNbG1JV1ZQblVkRUl0N3NudHRHWHZ5bW0rMVMyNCtv?=
 =?utf-8?B?UHpiZHlBcDVFa0drV3h3K0t4VFA2ekx2MjBxdmtzUlhoSFdPSnlLcFltbTM0?=
 =?utf-8?B?NVhER0llNVJYT0tRYjhpWkhoWlpiOUdLcGVZZHdGNTFFKzN1Y1grcEVFUVc2?=
 =?utf-8?B?YzZTdTYzcmZyLzBqRk04RXdsMysyS082blBZcWRKV1ovNy9IdktKSGNpcFRI?=
 =?utf-8?B?SWJtNzJET2pFVkZuWGROYlREeEluYUtkNU9ZK1VFTmt1T2NDSFg4QnhRbnE3?=
 =?utf-8?B?SG5UeUtGRERGSTRTNVcrR1QreGJYaktiVU14RkNCbUJBT2VxK0JSUGlTQlY0?=
 =?utf-8?B?N1RoaXdXdDNvc1NzQ2ozcms0b2JySVdDNmg0L0VNV0NkUHNPb3lJMURaUDdT?=
 =?utf-8?B?MnR1NHVwYStBYm54Y294b2U1bUJnaXZremdreFE5cXorU2JHNHQ0eXVlem5S?=
 =?utf-8?B?UENidE5LVVM2YmI4Zm8wc0MwajNiVTVRY1dGNFU2TkQzcHg0K1oveVFOUi9R?=
 =?utf-8?B?ZTVKbWpGL2dWdEZLQU9XUi9HR3BuV0dwOUY5Q0t5T0RrOVc1dm9ESTNmODVU?=
 =?utf-8?B?VEZ5di8vMXRpYlZiK3hXVTBLdlpVSk5zS1E0SzRuSlJiYkt2UlVSQXVMTjZZ?=
 =?utf-8?B?WTFacUxTSVJzK3BSWFVkbXNmREViRGFSc1pmUVpLMncxTm5ZdlN1Tmp5aEFR?=
 =?utf-8?B?aDhoaU9SSG12aTRjOWNjazBlRThPeGZWMXlyWloxa0VrQngwVWhNaGhZeUlv?=
 =?utf-8?Q?VMhtvWvfBLYQMjtAbPYSi5Skl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aTEfTpFRwu+2/CHLcZ8I3ZTyQ8HzAvtTh+acMKXxOgF8ZqfbEAui05OLt0sw07WT/VWYuwErO7sN1LYjAWARG/QHdmCKkeb1AMJA/7lY7KdJhJAmK+/ZUvrfxggnofF+rcfHp2RtSTFYoTPl48BVJzp0PvwstoXj94pKZwaWqgIK8H1tg3wq4+JMsU7bDbi2zY2M2iWz+rwFOwGVyQNTQ6OC8HUUiMqiLHmWn8px2kqoU/urCVf4DTDIgl+Hfta/x8tx/ZM7I0xesZxaoXyK9I7RBAznNaxNtpX0sgfOPafdsCedb/mj/Grsb37UbMPuT3RjRAW+Lbxs9fs7G2PNH5cwt/eb/s+0Er4A3pJEg2QjqP1I2SjLuVpZqCWbP7filZduAtUCuWCgn5AfbsSw26TFm6qkDWR7PD829uwhyInssYCpjrhMZlZFz5hxJozX0rZc3JYv/AChkItfQqpwfRjkRBmx5/26LpyXxsQW34heqjwlay+1x/fLVGmZMSyVV2Pad5Hgigxe8WPjkVqfMxgOHJJHmnl+Q9AHF5CRbABQsygcFW+z7dakU52+BrE8t8JT6pi8DvmOPD+dehFQ1EIeR4CpQvv1jgkPIkzc3N0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf595ab-6013-479b-6659-08dcd341a161
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 15:43:21.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWzlaxcc8tpdEYsPt4hzOLXyx6ViGLsqbYEWEYrPD20SHKU6+mmk6Y1BonUZoA+KqpVa/c5BYchDhmX68kqQCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120115
X-Proofpoint-ORIG-GUID: yO5U10wgK38inzjvKjzHAs_L7oTBss-1
X-Proofpoint-GUID: yO5U10wgK38inzjvKjzHAs_L7oTBss-1

* Helge Deller <deller@gmx.de> [240911 22:10]:
> On 9/12/24 03:32, Liam R. Howlett wrote:
> > * Helge Deller <deller@gmx.de> [240911 20:51]:
> > > On 9/12/24 01:05, Liam R. Howlett wrote:
> > > > * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> > > > > On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> > > > > <Liam.Howlett@oracle.com> wrote:
> > > > > >=20
> > > > > > * Helge Deller <deller@kernel.org> [240911 15:20]:
> > > > > > > This is a RFC to change the behaviour of mmap(MAP_STACK) to b=
e
> > > > > > > sufficient to map memory for usage as stack on all architectu=
res.
> > > > > > > Currently MAP_STACK is a no-op on Linux, and instead MAP_GROW=
SDOWN
> > > > > > > has to be used.
> > > > > > > To clarify, here is the relevant info from the mmap() man pag=
e:
> > > > > > >=20
> > > > > > > MAP_GROWSDOWN
> > > > > > >      This flag is used for stacks. It indicates to the kernel=
 virtual
> > > > > > >      memory system that the mapping should extend downward in=
 memory.  The
> > > > > > >      return address is one page lower than the memory area th=
at is
> > > > > > >      actually created in the process's virtual address space.=
  Touching an
> > > > > > >      address in the "guard" page below the mapping will cause=
 the mapping
> > > > > > >      to grow by a page. This growth can be repeated until the=
 mapping
> > > > > > >      grows to within a page of the high end of the next lower=
 mapping,
> > > > > > >      at which point touching the "guard" page will result in =
a SIGSEGV
> > > > > > >      signal.
> > > > > > >=20
> > > > > > > MAP_STACK (since Linux 2.6.27)
> > > > > > >      Allocate the mapping at an address suitable for a proces=
s or thread
> > > > > > >      stack.
> > > > > > >=20
> > > > > > >      This flag is currently a no-op on Linux. However, by emp=
loying this
> > > > > > >      flag, applications can ensure that they transparently ob=
tain support
> > > > > > >      if the flag is implemented in the future. Thus, it is us=
ed in the
> > > > > > >      glibc threading implementation to allow for the fact tha=
t
> > > > > > >      some architectures may (later) require special treatment=
 for
> > > > > > >      stack allocations. A further reason to employ this flag =
is
> > > > > > >      portability: MAP_STACK exists (and has an effect) on som=
e
> > > > > > >      other systems (e.g., some of the BSDs).
> > > > > > >=20
> > > > > > > The reason to suggest this change is, that on the parisc arch=
itecture the
> > > > > > > stack grows upwards. As such, using solely the MAP_GROWSDOWN =
flag will not
> > > > > > > work. Note that there exists no MAP_GROWSUP flag.
> > > > > > > By changing the behaviour of MAP_STACK to mark the memory are=
a with the
> > > > > > > VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending o=
n the
> > > > > > > architecture) the MAP_STACK flag does exactly what people wou=
ld expect on
> > > > > > > all platforms.
> > > > > > >=20
> > > > > > > This change should have no negative side-effect, as all code =
which
> > > > > > > used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > > > > > >=20
> > > > > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > > > > >=20
> > > > > > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > > > > > index bcb201ab7a41..66bc72a0cb19 100644
> > > > > > > --- a/include/linux/mman.h
> > > > > > > +++ b/include/linux/mman.h
> > > > > > > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > > > > > >         return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWS=
DOWN ) |
> > > > > > >                _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKE=
D    ) |
> > > > > > >                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC =
     ) |
> > > > > > > +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK  =
   ) |
> > > > > >=20
> > > > > > Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this =
will
> > > > > > change the user interface to create a vma that will grow.  I'm =
not
> > > > > > entirely sure this is okay?
> > > > >=20
> > > > > AFAICT, I don't see this is a problem. Currently huge page also s=
kips
> > > > > the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> > > > > __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> > > > > stack.
> > > >=20
> > > > If someone is using MAP_STACK to avoid having a huge page, they wil=
l
> > > > also get a mapping that grows - which is different than what happen=
s
> > > > today.
> > > >=20
> > > > I'm not saying that's right, but someone could be abusing the exist=
ing
> > > > flag and this will change the behaviour.
> > >=20
> > > Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exact=
ly that?
> > > Why abusing MAP_STACK for that?
> >=20
> > I can think of two answers:
> > 1. An error that has worked without issues so far
> > 2. One less system call
> >=20
> > I'm not saying this really is a blocker, but the change is not without
> > risk as it does change behaviour the user could see.
> >=20
> > Interestingly enough, the man page is incorrect as it is written becaus=
e
> > the flag is not strictly a no-op; it ensures no huge pages.  So the
> > feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
> > documented today.
>=20
> Yes.
>=20
> > What happens to call that use the mmap(MAP_GROWSDOWN | MAP_STACK) on
> > parisc today?
>=20
> Today, without my patch, on parisc the area is then flagged VM_GROWSDOWN =
only.
> In that case, stack expansion will not work, as it checks for VM_GROWSUP.
>=20
> > How does this change with your VM_STACK change?  Wouldn't this result
> > in failed mappings?
> > VM_GROWSDOWN | VM_GROWSUP would fail in do_mmap(), and these would be> =
set if you map MAP_STACK to VM_STACK which is defined as VM_GROWSUP?
>=20
> Right, with my change, the area will be tagged VM_GROWSUP and VM_GROWSDOW=
N.
> Due to VM_GROWSUP stack expansion works.
> The mapping doesn't fail in do_mmap(), because stacks are not file-mapped
> or shared or droppable. They should be mapped with MAP_PRIVATE, right?

Oh my, yes.  So now you will have a stack that can expand in either
direction, but it's okay because one direction isn't checked.  I sure
hope the rest of the code is correctly #ifdef'ed for this.

>=20
>=20
> Another option is to introduce an alias, e.g.:
> #define MAP_STACK_EXPANDABLE	MAP_GROWSDOWN
> and then

I don't like either of these options.

I guess you could also detect the MAP_STACK and MAP_GROWSDOWN and change
the flags for parisc, which I also don't like, but since parisc is the
only arch using this it's hard to justify a change that may cause issues
in other archs.

A quick grep shows we set VM_STACK_DEFAULT_FLAGS in x86 and powerpc,
which could affect what happens here with your change.  I am concerned
about the bleeding of other flags through this change.


> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index bcb201ab7a41..6a7ec3e0078a 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -153,7 +153,7 @@ calc_vm_prot_bits(unsigned long prot, unsigned long p=
key)
>  static inline unsigned long
>  calc_vm_flag_bits(unsigned long flags)
>  {
> -       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> +       return _calc_vm_trans(flags, MAP_STACK_EXPANDABLE,  VM_STACK ) |
>                _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>=20
> This simply uses the existing MAP_GROWSDOWN flag to mark a stack,
> is independend on the stack growth direction and is fully backwards
> compatible to existing behaviour.
>=20
> I prefer my initial proposal to change MAP_STACK though, as it's
> simpler and clearer.
>=20
> Helge
>=20

