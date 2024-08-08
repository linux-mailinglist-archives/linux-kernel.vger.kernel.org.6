Return-Path: <linux-kernel+bounces-279925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAA94C37D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871C7B2482B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7E191493;
	Thu,  8 Aug 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTuqerYp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OgmDFV+6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B663190484
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137518; cv=fail; b=WSn88dDlSQuugo8+ZOeeXtEOpTtN09QRM3yQN10rvUFK2IKCrYmMsQq66lStDKvamV/Z4Rga8Qh5IKj/4Zfp26OeoHAJ0tPFM31tk8hKzj9cUNxvae5FIAhG4JJFLErxpdhJLNs0tZJ8ENSCFYeeCxm7pC34NdBA+bPsSycAKro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137518; c=relaxed/simple;
	bh=mL7e+Gr22HtiQmA+3wd0CSdxKqDp7BCxEjuTFUws3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gu4scqnnRtc6YjjCgAMBI9hmWK91AvGgL0Tsrf8VMU8f59DOLyCTl2GUi/gYvgLNbPE/PTVt3PL/QvqO93EIZYuPdJoOkGjByMHvRYhaI7zOja60TfVVDO4tpL0pjr9+TUhrWLUQZT57OH0Iz2r3++aFzn2rx1nfi/GYWvOTa9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DTuqerYp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OgmDFV+6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMYwr024560;
	Thu, 8 Aug 2024 17:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=esD2YP32oUgZG8j
	+UluFiefmOGiA3J4pV/Xijqcz48c=; b=DTuqerYpZQwVBYAWKdYU281H+Ze3UPR
	k+1WkmsriykQqkwJNN8TgbtV1vMxm7abBXXD4Me2g5bqOKlFzAkUoktA2+fNQFn1
	lukjfmlF2AD7OfMazxQN9r8BtNLYS4JqWIug85jdJba76ZF4wDQVWLQ8Un5vuDil
	qVktBFMe08BkGqk3/HpQPB2OE69IrZn5zaZKGdDqezIB8CuQDDJnLLRW2kC7vaY6
	ixwVQnaGP5GZHXML5Si7mAI/P7I984wjB4qkleR9AyOr3wQNWXsFxgefnPQwSC7u
	f4SUTetL0H2WnADB9ub3GpwOORDpO6Ar4Aa0I7WkJSQoN74e5y8mmkw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayea87g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478H9kfo027932;
	Thu, 8 Aug 2024 17:18:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bk0eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW0BFArm12KkBpxG6zXq9feuCmOQz1OVWbm8JD9N9rl3Jxbd17HiZ1rkZojBmJD6BE0Pq4kuHBvg9Jaq7Qso9L9G2KQZo8scUuraRLpRQ3T1wYb85DeuSIT2iCv0/R+wqoTN9UwDBORu0ENfHaEn2+tcXic9LCxi07OfNODak1DTXkcVR8Y/fAFyeQAheK8U2Yz4rvE5hKApzKpGWJGCNQXyER30GiYSBORZ1GD1kffU12ZFoOQh/Y5OoWUBMVul+3TwwE7byTh1pswHrtFJnAjWNGMpZHz4R9iRRIBOLsBWSLwf6KXM4yZ+iD/5iHANHpb+GAu2bW5daXOHeK+ECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esD2YP32oUgZG8j+UluFiefmOGiA3J4pV/Xijqcz48c=;
 b=B79egVYeiwja2du3gcLygUcKom9R9dyfwvJxR1kmXYrQ1SPNtOq/hwqXq0H+XMErbsPhuce/tLaKhx+S6ygVr24/Dk9jzL5ySjDLeIlO06VO+NCS+fZ2e9vrTTwur96Y9tuKUXj9RzVLQWtibAueApeC20ANRwOpML3clFU7x4qgRAujooHvd8Dr9rbNZqDWhTAS1iHDE0upMR1pUGRAu6ByLIDXNRfTPzdnamjDfHbzVVQjFBZy03/bPIs9a/PrjZVSC3j5dehdN2MeIYJCGp+YPP1/3YSCnXiu+b2FkO6Z42v2TljHTe3Cxd9aeFB3p11yfGOmWMxcLIvglYwcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esD2YP32oUgZG8j+UluFiefmOGiA3J4pV/Xijqcz48c=;
 b=OgmDFV+6oA7g5rGQwAUKyww+8mIbJEg/33Q1Ql/G+/AE1dBw80ITrUpCxbQuzqP2qcrOcO9Yoekl9CLZnUzlJLpw3hgRUim+z+7C0bI0IUeCTuerwxuloNfh2KI5waLuYXvgSnfmgvNnMIBuoFeEtUCCrz5KlQNmXYyAFhzcupU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 17:18:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 17:18:23 +0000
Date: Thu, 8 Aug 2024 18:18:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <74581ff2-2763-4133-af16-061dd569daa7@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
 <a5b259f6-2ebe-4081-8b17-2eaf4d8eced3@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b259f6-2ebe-4081-8b17-2eaf4d8eced3@suse.cz>
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6c575f-0ad9-4fcc-cff1-08dcb7ce1bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kfPscm8BB6txTZkswMjL0QxELvle9WrpTV5RJ5LwZzwt1ybADVDANxYy3aYl?=
 =?us-ascii?Q?BZuQ8wcmS7EEEN29WYMuNSAiMTy5RUwMxENQGh/b7adAC4Okr/QImj1bWsCb?=
 =?us-ascii?Q?9PiVTI7gBGZmR0aKJMZgw57kvoY3tGjEwpzuZsF466/RfiRztIp61VuHcVQD?=
 =?us-ascii?Q?yGgawjeITiA8GfQSErsGfffkkCWNgcUFWU8917XOGSkRZO/+UfRkn4YVqWFt?=
 =?us-ascii?Q?djBLSxXMOLnMyiAr8PQVERsy+UFqsMy15RNftoPOF387Zzj/7Pe64NaV5uG3?=
 =?us-ascii?Q?kLYXFgcuzRbOtHQvDUzg55nDqDO9/q1LuKUlH6/s0FWz7jOnw8xqrkqXMr13?=
 =?us-ascii?Q?bEibIxjL9IV+AyEVVLdHuAvs0VYg6Dj1FtYaHhMYBStR2pvhU4xMCjoMOVvP?=
 =?us-ascii?Q?VaLFkDUJIHhOmCQ5vPWP0X/VZyQbvjCyiPvQ7od9PbOOzcQv06tlKe1AIOcE?=
 =?us-ascii?Q?FY5cntqUETjUxDyC7y0jWphzIGUhToA7RWHD6VxINksBGkWXzeTYrPnsNI66?=
 =?us-ascii?Q?mIoCW9Ofp13VgQwMUeOTK4dE+mcs6VH1SHI8vS4skxhsJLnZl2BmkeDC0Jdc?=
 =?us-ascii?Q?gau9IOwou8JupyIjkNDJo0uSYzuwIHHGv6nxHepMRsEcK6GW0gMny+oIqUiT?=
 =?us-ascii?Q?najyBm+Jm8OmfwqgYnKU+zzU9qKlEQFw4HmKNPBV51Es+7MPn1OeHEAXAns3?=
 =?us-ascii?Q?zPhHwrA1fXrELnv2akcfzLtVqrwtJyXgNVO1l+qfwBnQ9y2846lBlEA7zjlR?=
 =?us-ascii?Q?1HMMw8kTVl+5nRKSTgi3O8JXDKLEG/cWC5FKlCqZmOozXvNsZa2Tw4H3fJan?=
 =?us-ascii?Q?VEbY7QcPR9ao4FfwfYjwcelWr0wsR/gz6Vm88Sk/1RUOl1wDHuUmQgJI+Jtw?=
 =?us-ascii?Q?go3Pqmm9BQFZkxy330toCkPGhLpRFkXO4/U7AMhSIDiIMf/fnPvph/mhbSD7?=
 =?us-ascii?Q?0/Hu+SvaCfl1/8zgdOf00VdYtxhR4cR+rY5iat5YxGPYi9hTrrzqwamwzR9h?=
 =?us-ascii?Q?+lGRD3E4B1Ik1YXtg1jWkTUWYKf37Z0B/ZA8rlfQAacTFAUKAQmr5TUpIyoJ?=
 =?us-ascii?Q?zncscENtrD4KtXRy8DZ1++c9K7+xBP/gtqZhb7bWG+acAWqLG+HzBdtGKfWN?=
 =?us-ascii?Q?FtotL6wmVX7PNw7vhIOisEzqI5xfDsrzBAOX4Fi68G+DzJGTJZc9gxFutMDR?=
 =?us-ascii?Q?GALllWHCOyXhKWlKEbROCIwiZGEg5XglKEAtGlYcFdgHpmcSNYlwjeZLrC5M?=
 =?us-ascii?Q?s6XzAU6XXE2Cx8+FjtrITbFchiVA9BdGChFT/Ih+qw4uGp7TFMRplvXgjxlB?=
 =?us-ascii?Q?+Ljb5APv7lBialGCtY6SrlwxsfOsfCjtPuoBt7QuZVA0aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4lkDjNeut/BA74OG53JHC1tFE7yjmHNWRdBIEKdpu2HFzc5yFNjHQ4qC1jP?=
 =?us-ascii?Q?pGFdcK9WTyl80USfZytQH9dqksA95QBehw52ZO8MPlXXaWheEBMLkOkuVaeg?=
 =?us-ascii?Q?LvuO7JwC+I4DxnlAd3a2kUr1h7rYdTDPRKo7F597jBHzkcOu3KyaEAqF8T6b?=
 =?us-ascii?Q?hdR7gprkG5B8MXEbIBqKJfTk7h6qHqhAWoHGJ9t+Hx+c2dXrspI81jQHiGQw?=
 =?us-ascii?Q?cTQs9RpJu/qMzUo7GMRLBJ1AN2vb+ZgfafdnIVNabYb7NqUzQrGeKCiM8JVE?=
 =?us-ascii?Q?2fPrCwQT207stXV7ck/kVSO4dO6fT63HYTWunMI+jN8fmaM2RbTibXpLELis?=
 =?us-ascii?Q?cX8GaPjFskHYe+blrH9kjOp44Im6OGkB7afSsKCaXtO2iGRuMy7O71nmavVk?=
 =?us-ascii?Q?vNPWMp/+NeufigAEdYIoYZnNvHHqoE7kUxLWZy98nru3GUYWFlQ5Apo1DNHX?=
 =?us-ascii?Q?GZQCtkHVZvCxpzO49ZMR58+oQSAkojOpk0a0tyguyCFDLtpBZX058ddw8VIS?=
 =?us-ascii?Q?3anV3tBhLB9ia7t8byI9r1v+IUaqXP5LEz1kT0KpZt6URQ8gIB04BrbaPVQl?=
 =?us-ascii?Q?zvplHOHUjl/4rn+ch7CAczOkh3nnCFpjCxNdMmv4hN3Dh6+80eGMnorYReS4?=
 =?us-ascii?Q?1q6F5Xjyrac3roZBP59hJL21CcdG+C8pGkPec6A3tDkusVoJvfq7IFSsJyDx?=
 =?us-ascii?Q?alpEA4+swJ7XbQhi12L9wD16Eeif4MzK48KlJwr+h7WrQNrTfjgu8M9FiJ+f?=
 =?us-ascii?Q?e27bIDKvBzydBGlE8sIZVY4OE8vmtHUPkld8cxvcpLTQShj1MPHrJXQsMUqB?=
 =?us-ascii?Q?5E/2w9FkMrwXZUHZ/uRwxOQeaQDJ8LVXyF/T787b4ApD6fc2e5o9aUseZsoP?=
 =?us-ascii?Q?cAk+VmTsY+ZEz0ncMfse8XUr7DII8XNjbaKjPL8wdNwinzmtpmFmAFWjuSTu?=
 =?us-ascii?Q?CP7VGI1MsgTqjP15WjGprzD2ckZvbE13bsQ9YrKSq6WgaujlJTBAou5VuPFI?=
 =?us-ascii?Q?7tRFN3hKBjgCVOUCjPu4ByV/vbivdpo8k4jWFh5q2v5A6TZu8mI3EaretkxC?=
 =?us-ascii?Q?XDHwR72BPvA9w/Uf/9ygOVkYoSBxo4VJgEJg3zTWNNXRv2T3P0sZBAHXD9Z+?=
 =?us-ascii?Q?58vPxr7X4bvLoqOsnpoXwBFSXXcBeJ/9oV5IxXMHz9nHDv1Ocl+WRhnF+vEF?=
 =?us-ascii?Q?yDGSQ0mSw7+V7WFl0oRPt3cyOgZ1u65DMFhPD0DysEm0xYzmDMwuWfRhPInf?=
 =?us-ascii?Q?WY4vWkfH+2p9tsbA9BtvZyJP3C7VYn+x+1bqD55+MJPPwbc6oOq3YulxvgMU?=
 =?us-ascii?Q?9iAcMDwoukIk12dlGBNjjQA7Xel5QNoLCPHnvTi8MK/K6sF58Mj9Qj++KEcz?=
 =?us-ascii?Q?+VhGWbsXFzu5VkhkOQXXxoQytxx94bUnI1SjQyhWz85m0NcoMp3UoQsDtjb+?=
 =?us-ascii?Q?v/2EwdXJdmxENznV0ruc4n3nqbkR3GwGk2oxS7ajVd0Hquuj1Kz8rHLKv5XZ?=
 =?us-ascii?Q?SP3QiMekrGtVelI+I6OTUbUkJ/LGvKtbT2USmxyfBv17v2sukRfMujHpKY9B?=
 =?us-ascii?Q?TVxCKwLBCvoTg5BsqyJoBSb2oFS4AVDDZJ4ws/wSv06FiIwAF/u1Jroj5Jst?=
 =?us-ascii?Q?a5JN1Yl3MUOIaWhQX0af5qbE8HFLCYO0gLRlVM/dtPvuHjhRukXeeM86XEP9?=
 =?us-ascii?Q?VxtGzA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pqi28i2k7RelQ20OrWfXTS43FmdBQq40Z5/GpGYe70x7NLtvsrroFl7MpXpTmda2jDrGeWNmtY4f+VEhGkAkqSnlx1IMEHaQcFgzC4W5jnq36LRK0kPn6FZY1/rsE/OH60Mh6Ayqq8NRuf8L+LEUx/l7/4PnjWCaAwLgl/2YrN9MHEIj4r8yyWHt34uKNzlvxisYB8WXDa4tWVEgN2EqJIPt5sVKnOZQWw4LYDTVjA0Ffk1CMuonGbdaxKl7r/cA7ojMPmh+IXQtwTwlkVarhGLi90mQA7SPU6+fcvZavHO/S3jAQNtfsNW3bohxE5Lo5dsCl2j2wuwySh720gk5DxWSyHyqn24CjBaKQgr7n3asBumrGstX4If/5jSwJ6djqp7qN8ltGtgVlBlNNxLggoiqJ5zCj5erm6Hk9d8ao1D/rHIb4f7+5LNoutlyURzLphODFRv+DZqgAsK3P98e1hhGaxfQL3iLQjOEu0HZXLB1rBdHYt9XUSogwYTZiEsXwX5cvTQtT553uGq9ge1tOCEIe9HoIm+aAg2/mxFpNTVCqmU9iunNaWUXgWxEc8j2Z7H3Ln5IKmgsMMxinNDok1k7Tws/t7DnIOJEiZdcR1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6c575f-0ad9-4fcc-cff1-08dcb7ce1bb9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:18:23.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsFsYonDgj/V39YFzi8BvYQqwHA5vx9UNTJrhpoApDCykuDfrTbwHpSKBQzP7sLHhPF6dm8WBZXNrHuD2cnRArFAEMVlyXyvaevCOrnvAZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408080123
X-Proofpoint-ORIG-GUID: -ASGwlsyqllr4uNfpcW5i_TbQKb-H9eo
X-Proofpoint-GUID: -ASGwlsyqllr4uNfpcW5i_TbQKb-H9eo

On Thu, Aug 08, 2024 at 02:49:03PM GMT, Vlastimil Babka wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > Rather than passing around huge numbers of parameters to numerous helper
> > functions, abstract them into a single struct that we thread through the
> > operation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> In general,
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> It would be great to have the tests already at this point but I understand
> they depend on this. At least the result can be tested later in the series...

Yeah it felt like too much churn (even for me ;) to do a before vmg/after
vmg version, but I could also still do this. At that point it might be
worth adding benchmarks too to assess impact...

>
> I haven't seen the final form yet, so some suggestions may become moot.

Umm...

>
> > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> >  {
> > -	struct mm_struct *mm = src->vm_mm;
> > -	struct anon_vma *anon_vma = src->anon_vma;
> > -	struct file *file = src->vm_file;
> > +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
>
> This feels weird, but I'll leave it to Liam. Can't we just pass the mm? Hope
> it's one of the things that will disappear in later patch :)

Yeah it is weird, I felt dirty and ashamed writing this so fully understand
if Liam wouldn't like.

Previously we'd actually dictate the need for a vma here, but that made it
trickier to write the tests I think.

Anyway we maybe just want to thread an mm?

>
> > +	struct vm_area_struct *prev = vmg->prev;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> >  	struct vm_area_struct *anon_dup = NULL;
>
> <snip>
>
> > +/* Assumes addr >= vma->vm_start. */
> > +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> > +}
> > +
> > +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> > +					struct vm_area_struct *prev,
> > +					struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end,
> > +					unsigned long new_flags)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_name(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start,
> > +		       unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct anon_vma_name *new_name)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = new_name,
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_policy(struct vma_iterator *vmi,
> > +		   struct vm_area_struct *prev,
> > +		   struct vm_area_struct *vma,
> > +		   unsigned long start, unsigned long end,
> > +		   struct mempolicy *new_pol)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = new_pol,
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> > +}
> > +
> > +struct vm_area_struct
> > +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> > +		       struct vm_area_struct *prev,
> > +		       struct vm_area_struct *vma,
> > +		       unsigned long start, unsigned long end,
> > +		       unsigned long new_flags,
> > +		       struct vm_userfaultfd_ctx new_ctx)
> > +{
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = new_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = vma_pgoff_offset(vma, start),
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = new_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_modify(&vmg);
> >  }
> >
> >  /*
> > @@ -1180,8 +1274,22 @@ struct vm_area_struct
> >  		   struct vm_area_struct *vma, unsigned long start,
> >  		   unsigned long end, pgoff_t pgoff)
> >  {
> > -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> > -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = prev,
> > +		.vma = vma,
> > +		.start = start,
> > +		.end = end,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> > +
> > +	return vma_merge(&vmg);
> >  }
> >
> >  /*
> > @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  					unsigned long delta)
> >  {
> >  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = vmi,
> > +		.prev = vma,
> > +		.vma = vma,
> > +		.start = vma->vm_end,
> > +		.end = vma->vm_end + delta,
> > +		.flags = vma->vm_flags,
> > +		.file = vma->vm_file,
> > +		.pgoff = pgoff,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
>
> Wonder if there's a way to initialize a "standard" vmg and then apply the
> usage-specific differences on top, instead of needing many repeated but
> subtly different blocks like above.

Yes that'd be nice, I had the same thought but just hadn't got round to
doing it yet.

Will look at it on next respin.

>
> >
> >  	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> > -			 vma->vm_flags, pgoff, vma_policy(vma),
> > -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	return vma_merge(&vmg);
> >  }
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 6efdf1768a0a..c31684cc1da6 100644
>

