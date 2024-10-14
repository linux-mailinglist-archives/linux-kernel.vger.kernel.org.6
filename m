Return-Path: <linux-kernel+bounces-364212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94A99CD1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220AE1F23300
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251E1547F3;
	Mon, 14 Oct 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKPliqPz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ms7drlIl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F431AAC4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916135; cv=fail; b=YTZEFMu2Vf1qb5+MoR0h1JtGvoDY7a+Ch9Boa3L+Y+62a4/IBgJ9zP2nEbmEavqfdSZhxaNmE/4pYEskQJ/LmFHm/wSJZWyUvsdQP72frX6WU9hquiAlgJHmZSCHjxFZUvE+B1tQCZc/Jo+kHh2Tp2RkTmkExgbUCxyv5C7dsCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916135; c=relaxed/simple;
	bh=/lLrf13XNH6CJ4GRcLJiJ7YkH5wbbvIRCOb8KA738EY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BapkEmrMBYaCLan3AjRkLgo5rd+Vyczw/+d9VBRQ34mUJvVDRn8bvGjYNNI8jivLbyFVJfeNgP5ePBQmtVvFLvA1ODtjZYf3a632wHtwxCEC7HGfQLguhrJ3TFW9gjCMrvaPRpU9MbzvvufSjL+9lfEPXdW05vdgp1hJHIzZRAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NKPliqPz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ms7drlIl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEMbn5025290;
	Mon, 14 Oct 2024 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OxJFYm2mCCS/D8dlD/RRdoowbW3eqQMd4AUKGuWGDgM=; b=
	NKPliqPzn+4fFh3iP7/cNXoph0w2r96P7Bh4h4EPOtnaXtLpkOsayvv1oHLQsCqI
	cewaDW+ZlQ02hf3UGOb3FaUJWvfLYCf/8NmHDfhgyZAq1Q2kZoFYKgMP/E1hpb2j
	JoE+hR6ViG58mYXs5s9fwZUHWYE+s6SDHDS58xq34u4AWwjZGrnBAtdHnde49B8r
	sz4KNlvjsEDTkzgDoHMTlYQ3yqqt9JiI3milgb5PkGZCCQkcmWtW7uNrYQNe3VOO
	/I/Rg5nRRIhaEek0dHiNHYbcdnNTkatXxUTb7v7x8QpWNYemeZJBpyk9xlG96gXZ
	hRAfyAvPFSN9u6CWkcs88g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqsxf02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 14:28:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EE3Nmq019919;
	Mon, 14 Oct 2024 14:28:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj65fk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 14:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWtFvDGv/AJ050Cp49QNnbk91liM/u2HG0J56N6WN5WFBu44nMLd4K6SndwnaUgyuuGbdqgcmoGKxaihe7tOxAykQw42LuQhvpH4CXjd14QiXFiOMer0E8Yump90jxIldmDK3moLBlSrLp1EKeWgwUb29KohY4P1b7TWnufAi1Sz+4tM+ESzKL+/Ah7i4VTZIPDA1fLv3btbEAxPChsC6zZ3LueUBpqpU2owXGkPRKsI5XOtHN4+CmHhtiMOjfVmmIm4CAy+ITo8viMUpGmm0FogQ/5XKS1DyZrmcg/FTgr/1ud424O32ey6TYtr2fno6oLvgqUwgoc5dJmVtgjYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxJFYm2mCCS/D8dlD/RRdoowbW3eqQMd4AUKGuWGDgM=;
 b=UWe9GVKGRywoDraYHXv2E8UFjRDogqgEcna25htPY8sfj/jI5+rDNc8OdEMUbdlcHntO2YeFP3TNQpSqD5LDZ0rAxP6MDZ99U06BzZPVMOVECMdjHHwmbemz2Gq56l6JvVjqPoVmJABEKDnCO9NCtI2/NmFLsrQND5q4N81oVVVUDb3a7jZyMN8sSik/ctcO6Zv8KxInxHpjXHgMckOJhHTBsMwX/9OwzOBQTH5aZyvy7obrfy+vqkLglSRqVGCT+t18QIC8RMQEfQwiSqidvRdKfQmKIMT6X0tmbdxgGivRhwzWZ3mdWlvL6eeJT2c7e6ccUuW8APdeiaWbupHoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxJFYm2mCCS/D8dlD/RRdoowbW3eqQMd4AUKGuWGDgM=;
 b=ms7drlIlMlndzLLRi8ffd2ERiOsZg07eDZ43HzeMHDo7wKfuLfL5aJDyfMo69GjdeBDrkGfPYcPBPWnYwqE0QVHbFLzAP3X+lt0l5fsklswE4E+fkBZLDm4bFrzDp1VwGMnC5FXjc+jD+gtjFg9CM2gcNk4xvSGbkj4JRUAXk1Y=
Received: from SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:28:13 +0000
Received: from SJ0PR10MB5742.namprd10.prod.outlook.com
 ([fe80::b770:584:ca29:5e30]) by SJ0PR10MB5742.namprd10.prod.outlook.com
 ([fe80::b770:584:ca29:5e30%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:28:13 +0000
Message-ID: <ccd995b8-128d-449d-98d3-8c0bba287bff@oracle.com>
Date: Mon, 14 Oct 2024 09:28:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 write_special_inodes
To: Jan Kara <jack@suse.cz>, Hui Guo <guohui.study@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Lizhi Xu <lizhi.xu@windriver.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
 <20241014142239.7h53tahoczkmaww2@quack3>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20241014142239.7h53tahoczkmaww2@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::19) To SJ0PR10MB5742.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5742:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 06957a77-3f95-4d15-9c63-08dcec5c6f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHZrTm5ZYkxYa0hFNElMcDd3a2hxc0IweUM5UExNb3JVbzgxaFNRelI4YWkz?=
 =?utf-8?B?MVBkRDFTVS9ma2JOM0FzZGM5My94VzhPSzlmNWc2QkhFVk50bGw5ZmxON0dG?=
 =?utf-8?B?b2RLa05QcTlSRnhKOVV3cDZ2OXpSS1JHK21zejJBMTNmallXT21DenZESTBz?=
 =?utf-8?B?eE1DR0FNM2ZYemlFS3RvTVhya1QvNVlzL09nL2R1am9DZHJwZktJemRKNFl4?=
 =?utf-8?B?MER4MytVVnJpSEI1akplSlRoVEllR2lQWS9ncUZ3MWplMzFvbitPUDhLRDhv?=
 =?utf-8?B?VUVhR0tKMm9POGdYaUdvN3RtdXU1OFlHb253Z0t4OHl5VytiS3BqblcxMUlH?=
 =?utf-8?B?NmNNMFJmL09vZHV5T21BeGtvSmFxcEc5RmNEa1lLRjdTOVpiL2RsRmRtUWZa?=
 =?utf-8?B?U1h1Z1B6eGlhYndNNE9lQktQK2xpOXZIOWpVaDYvemp6bm1JSE8wckZzVzJm?=
 =?utf-8?B?aUpNYkZ6c0FIRUlkcmttWml6WWlWSXVyQi9RTVdwdDdSQWlwWkIrZi94ME9i?=
 =?utf-8?B?ME8yOVEvMmRSd1hqY2RBTExtV1hibFJ1eW9tNXVzdHNHMWlhYUFaTkVvZmxC?=
 =?utf-8?B?aEp6bExzbWtGN3duWTlKOVFUUWZqZWhCM2pvdXFwTnJacTNsN0lJMWxMZUxm?=
 =?utf-8?B?OFVCUFJEM2N1TWo3Q3FJKzhhU3BGbGE0TDFIblBSaGN5Mll0UHViZFVGUURR?=
 =?utf-8?B?dENGb0VVM1ZGNWY3bzl2cmRRdnY0akJ0NFVSOFdZbzU1RksxS3M4eHhaZGkv?=
 =?utf-8?B?S3ptQm5aQVp1OGZGKzhPOXZycklyUUF1aE5Ra3BCalg4ZHc4S2syYk9haEYx?=
 =?utf-8?B?L3dLamFhQmhndm0rdWpuSi91WnFFeTMrRG44OXBGdnlqZzFxTHJVNUFwR2lG?=
 =?utf-8?B?aEpBajlHOFZ1TVk3SDZQRXhIdGREQlB5aUNzSlV0RDJhdGZuSUJLTGNkNnZG?=
 =?utf-8?B?ZFNjZ1VkNWt4THVzYVBETWYvRHkySDVpbTF0RUZ1QU5vNUFSVUFEa2pSK0o4?=
 =?utf-8?B?MVUxaW80eG8wbC9EbFdJT2NEZUhhb1JOL3FhL3cwNnhnNjJORTVtaVl6SWt2?=
 =?utf-8?B?WjlndHJaZ1ZPaEN5KzdqdUlUcndvZmUrcGNEaUs0L0pYbjBvc3lDR295VFJ0?=
 =?utf-8?B?RkN6NmFBcXl0Si9yVDVqQ3BzWHRGWERMM1lKMldzREYwWDdsZVBsbTdYaHl0?=
 =?utf-8?B?bUhnYlFadkFYYmpRTXR6QXBQaTY0MUtPRUxHUFBTTUFneEYvVTMxVzFmc2hh?=
 =?utf-8?B?KzY1M2JBcTRwNzFmdFZ6THlHNUtFeEdCbDRZL1l0YkpENW5PbGdBTkhFVW8v?=
 =?utf-8?B?QVZJbzR1Sm8vbk8rYnBiWFRvUkZyM0Z3aWw3YW1nRTF4MjVSc3NKRzA1NEgv?=
 =?utf-8?B?ZFBUZHRiYjhQZDNOZW9pMks3TlFFbDMvbThPU1Z6SjN1Z2R4b1U3eVFJN1k0?=
 =?utf-8?B?VlpDTEg2R3pjT2d1ZmdlaW9RR3V5WUY3eVA4ZVJhcWluSGtyVTdvQUY3N0Ji?=
 =?utf-8?B?ZlcwOCttS2FTR2J3dFhud29CWkFoemhkZVExNm9VbzhRMmJtMXQ2SjNXMzRK?=
 =?utf-8?B?QXNTRklPcktSbzBzRWk2TTRmVUM5QkFoNGtQcUVvSkxlZVlaTytzM0gvSUE0?=
 =?utf-8?Q?glWqbCv9rnY5uawJy21yUnN05a1xo3yhV/gF3VpZ6r3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5742.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWhEZm5KeGoxZTZNMWtxRkJzZUx4eGVZblR5QVdmMDZya1AzTGg0eCtiV2pJ?=
 =?utf-8?B?Z1ZwUW5kOXZyN3A0dzVqSUdpb25pOHlDQ21kTUcvOEhEZHlpdGZkUjA2WGs2?=
 =?utf-8?B?UmJMYUdHY1NvQ2dkM1lCekxvYUhqdWRXdGtnbTB1Q3Y3bkpSVGhLOEdZOCtY?=
 =?utf-8?B?UVR5UVloV0xoVUpxdjl5Z0R5cXZYM2l3MDA4bktyRmNBaEVHcjZWMUJGMUVU?=
 =?utf-8?B?UzBXSzdIY3JVVFJLaXRIeVhnWFdFOHpVU0VtNGwwRXBnQ2JzWW1lSk1FeWFq?=
 =?utf-8?B?SHZqU1RiUm54U2lOV3A4TDY4WjIwb2pKeGNKT296bHRjdm11STlEaXFpMng1?=
 =?utf-8?B?SDNDbUtjc050NzRwaTlLdjJRdHlOU21LMTBlNVVyWEJ5akZya3BMNStDbWI2?=
 =?utf-8?B?TXBuRU1RZVZnK1gyY0ZtbkhFbU82N3FLV0xEV2RYcnNuc2xoQ2NPQlVza2Rx?=
 =?utf-8?B?d1pGK01LM2RybWoxZUdTM3VpMHo5TGtQdm11eVlCN1lzV2xHOGdxKzRhRW9H?=
 =?utf-8?B?bGhzcFMrUzl2YXFLWVcvNUp0am5ET3FMOFkzYzd3MG0rN2Rmb1BmbkRCcmNw?=
 =?utf-8?B?a1huRk1jZkd4R1R3Z01lVGUvK1lFMmIrUWdVV3RxdFA3UFpkSGpDL09GdDhU?=
 =?utf-8?B?YmxWMmdRZUFvNzM0clhHU0V4bFFHc1A5M2pjRVBPbFRpeWQvM0pUazcxV3RL?=
 =?utf-8?B?cWNkaFlybjdvTFVYZGQrdHlTSGRta1c1OXplMWFwNlBPUHRvRW1Qa0ZhQUhD?=
 =?utf-8?B?cHF1aU02UGhXd2F2UXd4MUhmVitWVjJWQWFIVE84L2ovN3NQbHpHNkRXRzdV?=
 =?utf-8?B?dk5DMTFDME5oaTFwU2JBMTNmQS9uZnpqQ3k4VnREZnpiOWtvbVhtajNVZWN2?=
 =?utf-8?B?Q1dlQytMRnduZkdkVUVZclE3MjJtYStUSzdtTGpRMUloZWFOWjdxWWxSZi8r?=
 =?utf-8?B?TUxjR1NlZERrSHJKdXhnaHl6UTc2UzFtK2lIWjVxVFZTaFlNcTFtd1J3UVV6?=
 =?utf-8?B?Mlk2N2IvNjZ4dkpaRlpJT21yTnVxMjdTbHNDTjlWcEVzMU1sRjdqQ1llVlFa?=
 =?utf-8?B?YUNhUnBQY3Z6UHRhOFRTWi9DNk1CRXFkb2VKWXRrWFdXQTZyNi9xR1NLTkJj?=
 =?utf-8?B?enF3L25LVWswVEpZRDdka29tZXgwbk8rVHkyV0xHWXg3VzZQN250Nm5YdTgz?=
 =?utf-8?B?RGZMZXZnRGd4aDVucjZCWElLR0ZBbTIvS1ZmMXVVNFRQZFowdVBqWFRQZVQw?=
 =?utf-8?B?Skp5cy9tV3hVK3NHSlhiVDdsVGZKN25UU3RiRkh2c3BUVi9rTjh3TGlXQVYv?=
 =?utf-8?B?MlI1c1JVMnBDcmN1Ni9nNjI2aUhEelk2K3dqdEF1WUVCdlFGTVBQV2NXc1FC?=
 =?utf-8?B?ZXJadktTL0ZpVnJKclgyTVovV1pQbEJMaWVldXVQVVkreWpQaSsyam1vdmJy?=
 =?utf-8?B?SGxnOWpVZWpxTlFKaitsZ3g5c1VRcWJqaWpDek5KR3pKaURYWU5kOGNvQ3dk?=
 =?utf-8?B?RGJaUFk1U2FZdjdjNkM2VjZZMXlNMzNlcHFuWGlYTjlPcXdqcHFHNnc2L3BJ?=
 =?utf-8?B?R2xNNnp3QmN1VGFXbjVheFh2VjFJNGhwQWU4SVRieGhqcURIUlJxNG1vZHB1?=
 =?utf-8?B?d2ZQWlhYeVV5MDZlSWJQYjAxbHdhWi9YT0xJWDBMRmJWcU5NbDVNdmwxN3Jh?=
 =?utf-8?B?aDlPb0tzUTkvMi8zSWtjUlRLWmRmVGFuNWx2Tng3MkZQTTJ6eUpJUEw4WFRR?=
 =?utf-8?B?cHdnbWV3em94WlU0Y3pqckZWWlFCSzFENnUzcTdSVnlXeC9rdGd4Vlp5WW5z?=
 =?utf-8?B?ZDVXRFZQS3lzcUUvV04vTHo1RGRyU1UrRUpnbW4zWHVZVE10Kzg4R2ErMWFx?=
 =?utf-8?B?QS9GMytkM28vUEdkckRvZWo1MHNtMy9QeUkxaHN0ajB0WERMWDVrV2FLNzBa?=
 =?utf-8?B?L1pUN2dHeGVQcmxGRFBSUjBWanN5NFpMcGR5bjcvR2t4djcwVjl6RHZGMWVi?=
 =?utf-8?B?Zm1jZXZidUlRS3FZaWIxLy9GMTFRSk5kTDJxbkFVTXI4dzdrUzZJajc3UHJv?=
 =?utf-8?B?eHdTb1drOGNDTlFJK3lHekdBM0FPRXFpRTloZEdIOVZabi80RTNMaUFLV1Vv?=
 =?utf-8?B?L0dUMHYxbm9xN3E3ZytEQnA5QWhLZnZnZjdKNEVJV3ZEUzZ0UitsSlhYQU4v?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kKlzWEEFmyY3/P3y/3i1mqx6RpNM1wjpswUb9EhJCKzTqlMj8oW4cIsMaoZ0TgAjPF/jTXYeAK5z/eCB+0FZAE4ZMk/pfcg0RdVPSp9aTMxgyr2YTR/vcV5usZ2TUoz/eiWUBmzQFLfEFNUhbhYf6mD2m2m6myGvo/ZXpUYfpYDg073eSGpXiHNqbsRBcBlsYORVgMQdEwLVyOz5XTqYG41F8LlXh1KiVeejOcB2nAspvGniH9hVJWKgJIQgLbXLkXF0qpXavQYZMssf83qnD/zIliLN0TMMk06Mq+GccRZhSt0mZ9mglJ9ifvQ83DpG/UUkHTpDzIbERTqWkM8arizoLEoSgAGNUwHsTQjKisbthejXXi3zS1RON8CJeyVnibJdaQw1d1npyUotgGk0eUPSFLrCXFihrEQRzWPkI9WIPypvRS4+rNrVMqrhwuMWtBuIafGXBAwHfOJ/8uqPBTfkPXuGm115EpF97dD1PqiuNPqWqs9vQJcst3vCZeobHq0YTPM2OJgVEqPqLchsXHED/6FlG4+IGLE27Tn2lQD15zdDYm9hBmT1nfK3rwmapm9J6kmEvaraNS9BAJfz1PRd7eg76tMktPJQES/t/IQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06957a77-3f95-4d15-9c63-08dcec5c6f7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5742.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:28:13.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhmT4nyQEfn33v3tfL8A0GrtgrCRfFvfteBmJ+/OxjC7EXC3hDrykJhe4hZM/cJLeuI4QMk8bFuk0EJ1SsJWEYidez7oq9Jezodnfg2EHcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140105
X-Proofpoint-GUID: DclLJxG_m0WFo5O7XShonAUPXIRZvrlZ
X-Proofpoint-ORIG-GUID: DclLJxG_m0WFo5O7XShonAUPXIRZvrlZ

On 10/14/24 9:22AM, Jan Kara wrote:
> Hello,
> 
> On Sat 12-10-24 17:13:40, Hui Guo wrote:
>> we found a crash "BUG: unable to handle kernel NULL pointer
>> dereference in write_special_inodes" in upstream, and reproduced it
>> successfully.
> 
> The reproducer is just mounting corrupted JFS image. Unless Shaggy is
> willing to dive into this I don't think this will be acted upon because JFS
> is mostly dead.

I will try to find time to look at it, but I can't promise how soon. JFS 
is a bit low on my priority list right now.

Shaggy

> 
> 									Honza
> 
>>
>>
>> HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
>> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/6.12.config
>>
>> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.report
>> console output:
>> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.log
>> syz reproducer:
>> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.prog
>> c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.cprog
>>
>>
>> Please let me know if there is anything I can help.
>> Best,
>> Hui Guo
>>
>> This is the crash log I got by reproducing the bug based on the above
>> environment，
>> I have piped this log through decode_stacktrace.sh for better
>> understand the cause of the bug.
>> ================================================================================
>> executing program
>> syzkaller login: [ 43.704796][ T8242] loop3: detected capacity change
>> from 0 to 32768
>> [ 43.707859][ T8215] loop0: detected capacity change from 0 to 32768
>> [ 43.733656][ T8239] loop2: detected capacity change from 0 to 32768
>> [ 43.759686][ T8234] loop1: detected capacity change from 0 to 32768
>> [ 43.921958][ T8248] loop5: detected capacity change from 0 to 32768
>> [ 43.947086][ T8243] loop4: detected capacity change from 0 to 32768
>> [ 43.969139][ T8250] loop9: detected capacity change from 0 to 32768
>> [ 43.986996][ T8254] loop14: detected capacity change from 0 to 32768
>> [ 44.060631][ T8218] BUG: kernel NULL pointer dereference, address:
>> 0000000000000030
>> [ 44.061395][ T8218] #PF: supervisor read access in kernel mode
>> [ 44.061959][ T8218] #PF: error_code(0x0000) - not-present page
>> [ 44.062526][ T8218] PGD 0 P4D 0
>> [ 44.062898][ T8218] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [ 44.063564][ T8218] CPU: 1 UID: 0 PID: 8218 Comm: syz-executor368 Not
>> tainted 6.12.0-rc1 #5
>> [ 44.064885][ T8218] Hardware name: QEMU Standard PC (i440FX + PIIX,
>> 1996), BIOS 1.15.0-1 04/01/2014
>> [ 44.065764][ T8218] RIP: 0010:write_special_inodes
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
>> (discriminator 3))
>> [ 44.066375][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
>> 43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
>> 03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
>> 8b 78 30 2e
>> All code
>> ========
>> 0: 53 push %rbx
>> 1: e8 6c 30 68 ff call 0xffffffffff683072
>> 6: 49 8b 45 00 mov 0x0(%r13),%rax
>> a: 49 39 c5 cmp %rax,%r13
>> d: 74 43 je 0x52
>> f: 48 8d 58 c8 lea -0x38(%rax),%rbx
>> 13: e8 5a 30 68 ff call 0xffffffffff683072
>> 18: 48 8b 43 10 mov 0x10(%rbx),%rax
>> 1c: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 20: 2e e8 4c 0d 39 03 cs call 0x3390d72
>> 26: 48 8b 43 28 mov 0x28(%rbx),%rax
>> 2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
>> 2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
>> 34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
>> 3b: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 3f: 2e cs
>>
>> Code starting with the faulting instruction
>> ===========================================
>> 0: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 4: 2e e8 3e 0d 39 03 cs call 0x3390d48
>> a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
>> 11: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 15: 2e cs
>> [ 44.068207][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
>> [ 44.068812][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
>> ffffffff814acf4f
>> [ 44.069570][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
>> 0000000000000005
>> [ 44.070349][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
>> 0000000000000001
>> [ 44.071123][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
>> ffffffff814b2420
>> [ 44.071889][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
>> 0000000000000000
>> [ 44.072665][ T8218] FS: 00005555717b43c0(0000)
>> GS:ffff88807ee00000(0000) knlGS:0000000000000000
>> [ 44.073532][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 44.074184][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
>> 0000000000350ef0
>> [ 44.074962][ T8218] Call Trace:
>> [ 44.075300][ T8218] <TASK>
>> [ 44.075599][ T8218] ? show_regs
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:479)
>> [ 44.076065][ T8218] ? __die
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:421
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:434)
>> [ 44.076490][ T8218] ? page_fault_oops
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:711)
>> [ 44.077009][ T8218] ? srso_return_thunk
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
>> [ 44.077511][ T8218] ? __kvm_handle_async_pf
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/kvm.c:262)
>> [ 44.078096][ T8218] ? exc_page_fault
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1265
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1481
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1539)
>> [ 44.078637][ T8218] ? asm_exc_page_fault
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/include/asm/idtentry.h:623)
>> [ 44.079197][ T8218] ? __pfx_filemap_flush
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:463)
>> [ 44.079730][ T8218] ? filemap_fdatawrite_wbc
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:393)
>> [ 44.080314][ T8218] ? filemap_fdatawrite_wbc
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:401)
>> [ 44.080893][ T8218] ? write_special_inodes
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
>> (discriminator 3))
>> [ 44.081423][ T8218] ? write_special_inodes
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
>> (discriminator 3))
>> [ 44.081967][ T8218] lmLogSync
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:937)
>> [ 44.082412][ T8218] ? srso_return_thunk
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
>> [ 44.082917][ T8218] ? __sanitizer_cov_trace_const_cmp4
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316)
>> [ 44.083568][ T8218] ? srso_return_thunk
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
>> [ 44.083893][ T8253] loop11: detected capacity change from 0 to 32768
>> [ 44.084063][ T8218] ? jfs_flush_journal
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:1615)
>> [ 44.085204][ T8218] jfs_syncpt
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:1041)
>> [ 44.085640][ T8218] jfs_sync_fs
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:688)
>> [ 44.086107][ T8218] ? __pfx_jfs_sync_fs
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:674)
>> [ 44.086625][ T8218] sync_filesystem
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:57
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:30)
>> [ 44.087120][ T8218] generic_shutdown_super
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:624)
>> [ 44.087674][ T8218] kill_block_super
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1697)
>> [ 44.088178][ T8218] deactivate_locked_super
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:434
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:475)
>> [ 44.088742][ T8218] deactivate_super
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:508)
>> [ 44.089265][ T8218] cleanup_mnt
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:250
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:1374)
>> [ 44.089734][ T8218] __cleanup_mnt
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:1381)
>> [ 44.090212][ T8218] task_work_run
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/sched.h:2031
>> (discriminator 1)
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/task_work.c:230
>> (discriminator 1))
>> [ 44.090688][ T8218] syscall_exit_to_user_mode
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/resume_user_mode.h:50
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:114
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/entry-common.h:328
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:207
>> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:218)
>> [ 44.091087][ T8247] loop10: detected capacity change from 0 to 32768
>> [ 44.091253][ T8218] do_syscall_64
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:102)
>> [ 44.092312][ T8218] entry_SYSCALL_64_after_hwframe
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/entry_64.S:130)
>> [ 44.092931][ T8218] RIP: 0033:0x7f44ff534f8b
>> [ 44.093385][ T8218] Code: 08 00 48 83 c4 08 5b 5d c3 66 0f 1f 44 00
>> 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6
>> 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b8 ff
>> ff ff f7 d8
>> All code
>> ========
>> 0: 08 00 or %al,(%rax)
>> 2: 48 83 c4 08 add $0x8,%rsp
>> 6: 5b pop %rbx
>> 7: 5d pop %rbp
>> 8: c3 ret
>> 9: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
>> f: c3 ret
>> 10: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>> 17: 00 00 00
>> 1a: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>> 1f: f3 0f 1e fa endbr64
>> 23: b8 a6 00 00 00 mov $0xa6,%eax
>> 28: 0f 05 syscall
>> 2a:* 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax <-- trapping instruction
>> 30: 77 05 ja 0x37
>> 32: c3 ret
>> 33: 0f 1f 40 00 nopl 0x0(%rax)
>> 37: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
>> 3e: f7 d8 neg %eax
>>
>> Code starting with the faulting instruction
>> ===========================================
>> 0: 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax
>> 6: 77 05 ja 0xd
>> 8: c3 ret
>> 9: 0f 1f 40 00 nopl 0x0(%rax)
>> d: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
>> 14: f7 d8 neg %eax
>> [ 44.095191][ T8218] RSP: 002b:00007ffc50d9a3b8 EFLAGS: 00000202
>> ORIG_RAX: 00000000000000a6
>> [ 44.096010][ T8218] RAX: 0000000000000000 RBX: 000000000000a5ee RCX:
>> 00007f44ff534f8b
>> [ 44.096766][ T8218] RDX: 00007f44ff4e4e88 RSI: 0000000000000009 RDI:
>> 00007ffc50d9a470
>> [ 44.097530][ T8218] RBP: 00007ffc50d9a470 R08: 0000000000000000 R09:
>> 00007ffc50d9a240
>> [ 44.098292][ T8218] R10: 00005555717b57b3 R11: 0000000000000202 R12:
>> 00007ffc50d9b500
>> [ 44.099058][ T8218] R13: 00005555717b5770 R14: 00007ffc50d9a3d8 R15:
>> 00007ffc50d9b560
>> [ 44.099831][ T8218] </TASK>
>> [ 44.100138][ T8218] Modules linked in:
>> [ 44.100537][ T8218] CR2: 0000000000000030
>> [ 44.100952][ T8218] ---[ end trace 0000000000000000 ]---
>> [ 44.101472][ T8218] RIP: 0010:write_special_inodes
>> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
>> (discriminator 3))
>> [ 44.102070][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
>> 43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
>> 03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
>> 8b 78 30 2e
>> All code
>> ========
>> 0: 53 push %rbx
>> 1: e8 6c 30 68 ff call 0xffffffffff683072
>> 6: 49 8b 45 00 mov 0x0(%r13),%rax
>> a: 49 39 c5 cmp %rax,%r13
>> d: 74 43 je 0x52
>> f: 48 8d 58 c8 lea -0x38(%rax),%rbx
>> 13: e8 5a 30 68 ff call 0xffffffffff683072
>> 18: 48 8b 43 10 mov 0x10(%rbx),%rax
>> 1c: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 20: 2e e8 4c 0d 39 03 cs call 0x3390d72
>> 26: 48 8b 43 28 mov 0x28(%rbx),%rax
>> 2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
>> 2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
>> 34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
>> 3b: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 3f: 2e cs
>>
>> Code starting with the faulting instruction
>> ===========================================
>> 0: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 4: 2e e8 3e 0d 39 03 cs call 0x3390d48
>> a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
>> 11: 48 8b 78 30 mov 0x30(%rax),%rdi
>> 15: 2e cs
>> [ 44.103876][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
>> [ 44.104474][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
>> ffffffff814acf4f
>> [ 44.105248][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
>> 0000000000000005
>> [ 44.106014][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
>> 0000000000000001
>> [ 44.106771][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
>> ffffffff814b2420
>> [ 44.107538][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
>> 0000000000000000
>> [ 44.108300][ T8218] FS: 00005555717b43c0(0000)
>> GS:ffff88807ee00000(0000) knlGS:0000000000000000
>> [ 44.109164][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 44.109809][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
>> 0000000000350ef0
>> [ 44.110572][ T8218] Kernel panic - not syncing: Fatal exception
>> [ 44.111289][ T8218] Kernel Offset: disabled
>> [ 44.111722][ T8218] Rebooting in 86400 seconds..
>>
>> VM DIAGNOSIS:
>> 07:10:48 Registers:
>> info registers vcpu 0
>> RAX=0000000000000000 RBX=0000000000001000 RCX=ffffffff814aca55
>> RDX=ffff88800aa46600
>> RSI=0000000000000000 RDI=0000000000000001 RBP=ffff88800ee03cf8
>> RSP=ffff88800ee03ce0
>> R8 =0000000000001000 R9 =ffffea0000b68ac0 R10=0000000000000000
>> R11=0000000000000001
>> R12=ffffea0000b68ac0 R13=0000000000001000 R14=0000000000ed2000
>> R15=0000000000001000
>> RIP=ffffffff8134ec2f RFL=00000293 [--S-A-C] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0000 0000000000000000 00000000 00000000
>> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS [-WA]
>> DS =0000 0000000000000000 00000000 00000000
>> FS =0000 00005555717b43c0 00000000 00000000
>> GS =0000 ffff88803ea00000 00000000 00000000
>> LDT=0000 fffffe0000000000 00000000 00000000
>> TR =0040 fffffe0000003000 00004087 00008b00 DPL=0 TSS64-busy
>> GDT= fffffe0000001000 0000007f
>> IDT= fffffe0000000000 00000fff
>> CR0=80050033 CR2=00007ffc50d99bd8 CR3=000000000e6c8000 CR4=00350ef0
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000001d01
>> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
>> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
>> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
>> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
>> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
>> YMM00=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM01=0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
>> YMM02=0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
>> YMM03=0000000000000000 0000000000000000 00007ffc50d9b520 00007ffc50d9b520
>> YMM04=0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b55f
>> YMM05=0000000000000000 0000000000000000 cfff5ffebffcefff d7ffa23fffafff49
>> YMM06=0000000000000000 0000000000000000 1d3ff77236800000 07fec5b8a9ffbb91
>> YMM07=0000000000000000 0000000000000000 ffb2196e227feee7 ffd6adce7ffafff5
>> YMM08=0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
>> YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM10=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> info registers vcpu 1
>> RAX=0000000000000063 RBX=0000000000000000 RCX=0000000000000000
>> RDX=00000000000003f8
>> RSI=ffffffff82a1d59a RDI=ffffffff880cbfc0 RBP=ffff88800f2c3828
>> RSP=ffff88800f2c3810
>> R8 =302e34342020205b R9 =205b5d3436353336 R10=0000000000000063
>> R11=205d383132385420
>> R12=ffffffff880cbfc0 R13=0000000000000063 R14=ffffffff87fb4b3a
>> R15=0000000000000000
>> RIP=ffffffff82a1d5b1 RFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0000 0000000000000000 00000000 00000000
>> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS [-WA]
>> DS =0000 0000000000000000 00000000 00000000
>> FS =0000 00005555717b43c0 00000000 00000000
>> GS =0000 ffff88807ee00000 00000000 00000000
>> LDT=0000 fffffe0000000000 00000000 00000000
>> TR =0040 fffffe000003e000 00004087 00008b00 DPL=0 TSS64-busy
>> GDT= fffffe000003c000 0000007f
>> IDT= fffffe0000000000 00000fff
>> CR0=80050033 CR2=0000000000000030 CR3=000000000d8fa000 CR4=00350ef0
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000001d01
>> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
>> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
>> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
>> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
>> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
>> YMM00=0000000000000000 0000000000000000 0000000000989680 0000000000000000
>> YMM01=0000000000000000 0000000000000000 0000000000000000 0000000000989680
>> YMM02=0000000000000000 0000000000000000 00007f44ff5c3bc0 00007f44ff5c3bc0
>> YMM03=0000000000000000 0000000000000000 00007ffc50d9b560 00007ffc50d9b560
>> YMM04=0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b59f
>> YMM05=0000000000000000 0000000000000000 0000000000000000 00007f44ff5b84b0
>> YMM06=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM07=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM08=0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
>> YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM10=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000

