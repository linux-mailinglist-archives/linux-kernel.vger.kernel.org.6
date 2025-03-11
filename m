Return-Path: <linux-kernel+bounces-556329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91FA5C41E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B875F189AC86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0D25D1E5;
	Tue, 11 Mar 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZasFBq+c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cBYuXJOh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E425CC9F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704062; cv=fail; b=KegLdAtkTdGR1pgjicPLyO4/33Md7fZLyBgx5qV4sVS+o5IOClwHJRcIphenfYo+LHde57woDapMmrvrkN8nOOxMsJ9Jt3pPCmr9poijcESPDsc2mSZqLbJFRZhL2mrQ5+48r6y9fJyfnE2milpzaOkF/AudxCIojXZKTIzmZew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704062; c=relaxed/simple;
	bh=nJ422glW5r81Y/V5DDR9gDrVYv3lFKLRKTj0rfM9wYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kp4xm2n9bJ8TVMUKFK26tPgexZU+mGZGgdZwX6fiMqHtIsrnsF6ME8tieX8J8VVWNh6DVoEcKRaKr8u1eGEMeoyjQqTh+QwPyktA3nq22MANCtiY65A8Pv0xsoE85emCE3Y8EEJlFGGCQW5tQQTB7KirpJnPYQPAJ+M2SdZmttI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZasFBq+c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cBYuXJOh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMvkv006181;
	Tue, 11 Mar 2025 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1DTW5cONCGn7u2B3HsTfc0Y7pPb012NVfaf0LgcYDkU=; b=
	ZasFBq+ckRg23h/ZmS31QKqVkNvME3FS2vlR652KHa7zuY7vuY2IVXaRgJc2LYdc
	SIzktGwWlWaQUWgrUQQxAxuI1NL15sUFMix8yI/gdVXuKrdjNLILpsgj5IL+4z7t
	JgNvzUbk8PUlRtmFGhpA0bb1U/b8vIx2BH7bbcy0PUH/42S3ABNNE7E/l1DFuWk1
	Pu6yGVgPoQmp5kR/qdkeBroPNoagKwmrEpiBfXzLWNKPHhWjD5F/jrFR3KanwUqj
	/4ffr5qOfXD43KMdu/AJ2qvnnpsW7cBxmNsyoxMaEwAa3AnH1m6JaVK/je9hI0GX
	M+IaKH2DmY3BQbd5vfazvQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9mxgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:40:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BE5vWi019356;
	Tue, 11 Mar 2025 14:40:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbfnj00-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePgxGnFyqy+DdeIb/5JiqJPo58L7a/7wYh5zDOJWDTdYrAx8pJqlBj9IABcl00D3aODzDGcnJFClbY2FZRClgwRGsOODKr4ZL1+Wkxao3BYZWFtGP11M/3m911TBjG66XM0O0WrDqTiglfsVV+7BaBLxTwoqER6b1bl6GgrC3yZ9Jhr0o3NgONjqf/3efBm8UxtagXV1TV22/6T0CR6IHQaZDRVRfAlfQJDThV2YtKEh46xKnsF9J5LNwOZkGIRTYPXwQHAsVDMIf7d2VDMMirzKnYconCizi1CepmLtR48PwcmhxJfCuAc0i1uXud1T2QAL/p9mnC9bRZa35I19/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DTW5cONCGn7u2B3HsTfc0Y7pPb012NVfaf0LgcYDkU=;
 b=QA6VCUj8Bxw9AGJZ1ENaWAAJzhaccRW05kZl84nwEaey7nko3fqgBHHS0K4aaM33Wy8rEHYJQEzPWUQDtJf4Ktg7kN4+PbmZj9lMS6l9Af9QRw0YsWPLDKP7FY+9tenzUJPAm1Pc198ZICjA+GRdHyPsGD7Neqm5t+C3fm9EIe3lWcJdgctkA8SyLD+jCEyzJ89kWV0g430SwwwWM4VR4V61QNL42WbSE2rVRZQCtpiBTh0kHCn+tQlZd+jf29813q2k2Nok9eOmIEqc1cEygQLL6MRNWw1ThUUAhxCK/YOC3wHcBceQiND1TDs7T5p9ZS9uuz6U08gwLdUgLhEPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DTW5cONCGn7u2B3HsTfc0Y7pPb012NVfaf0LgcYDkU=;
 b=cBYuXJOh1fbaQcnfdSVlpz296wF0Cp5yJCK1+Oo2FlJ0NsyxBaCrl/w3mKt7gT85hymoyR/Hlhm5DNioHTTuF6CGNj7IGkhD4q7Hns1+RGxtJGJUSj0a6o8SGfZw4SqynrQe4wDNhRtijzUMLx7jaHn9yeM0Vq9tz7ivO2LuDiw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB5832.namprd10.prod.outlook.com (2603:10b6:510:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:40:20 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:40:19 +0000
Message-ID: <04bd1284-ff3b-4b3d-899d-9a1e3705df28@oracle.com>
Date: Tue, 11 Mar 2025 10:40:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] maple_tree: add sufficient height
To: Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, liam.howlett@oracle.com, richard.weiyang@gmail.com
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
 <20250227204823.758784-6-sidhartha.kumar@oracle.com>
 <your-ad-here.call-01741630424-ext-7048@work.hours>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <your-ad-here.call-01741630424-ext-7048@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0575.namprd03.prod.outlook.com
 (2603:10b6:408:10d::10) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdeb373-af80-4418-f5a2-08dd60aaa590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1JCUThrdm9DV2VldDBnRGttRWpaY2g3RnZ1SWpVczNCbDhHRkMyUVozTGJV?=
 =?utf-8?B?a2VYbEhaSGVhUGN6S1l5eERhdVRjSkpramZ1ZVdyU0duZTQrQmErVThMMmxs?=
 =?utf-8?B?Sk9MQ1Bka1ZndnVCdGZBUkNQd0RyZUlGbkplOW1ieEtaamhlTkFmZGNEVjZ3?=
 =?utf-8?B?aDVVcmx3ZzJadDhocGhndVo0b2t6OU9NWjRXYkx0ZzJpY292V1BuOVppaXVM?=
 =?utf-8?B?eWVqVmlFc0N5eFpiVW54MnRxQkIwS01tUkpISDEvemVaUmdHNzBJWWRsM1Vj?=
 =?utf-8?B?bEg4WU5pcG55MUwwZk1nVjhkVlpaN0doSGI4UVZJRGRSNkpLS2k0bDZrUFZw?=
 =?utf-8?B?US8ydk9ML2N1ZFc2TThEanZIRm9pYlhXeTU3akFCbFMwRSs2Y01ZRkFLaGtH?=
 =?utf-8?B?dGVlaklCb09DK2p3YnR5RmdBMU11SldORFIrSGtJaDY1MWdxOGpDc1F1SVRp?=
 =?utf-8?B?Um1kbDlWTWdPWGY1cEwxbUVXMVJad1YyNmNiR21TWThVdmJXODZURWRWVDRN?=
 =?utf-8?B?SEFOcjB1NXYzWGhETHJKSk1vRi9KUjlkSVF2ZHhJbGMzcmIrY0k0S2ZkdDQ1?=
 =?utf-8?B?Qy9NSW9UQ2FvRWZMdGc1L05velJQR01mUWp3dmxnUzFWUnZmcFpieHowTm1D?=
 =?utf-8?B?V2ZXVUFVaE5oZkZ5dUVnTlk5TlJqS2g4bkpIejQ3SW5HNHh6WFJwV1ovVTJp?=
 =?utf-8?B?QXpUcUVwekg3OHI1UUtScG9ITFZmVWFnbllmRXpVMVlwMVBRYm5kUjlTV3lv?=
 =?utf-8?B?OFVwZlUzMnF0Tm5wZDEwd2p0L3FmOTdKTjVQZkpTc3ZEVVhrVEMzSUx3eEQy?=
 =?utf-8?B?eHNnSVFoZmZKeWZHU2Fuci9OeDF0dHJ4Zkx1K3M3VksrcTZ4UVRDZlB2MmFv?=
 =?utf-8?B?ekd1RkFGY3BjOWZ3L3F1MHc4ZUlXbUdPUmdoWGZxd3BtcEF3b1krR2pPSTZh?=
 =?utf-8?B?ckF0MkVuUm5Lc2xEUi9mbUtKZ3dkOWMrNnk5Z0R2L3FNR3cwOEordmZuSi94?=
 =?utf-8?B?OXhvRkJ4bXdXVytWZnA5UHBZS3ZaeW55elJzREg3eEtxSjh4RVdwUDVNcUYz?=
 =?utf-8?B?bHRoMTdES2t4YTVEY3BsMmg5SWFzN0IzeU0zUEEva2RJdkhiRjRoZ043bEtJ?=
 =?utf-8?B?OUtCd0RaOUJ6NmRBeDkzN1piOXBjV2NzN0hQOFJaUHFoVHM3YWhRdFVQMXBB?=
 =?utf-8?B?Y2VBbjhwVU1mTkIvUDdyWkJMcDRtU1JWMUZUMmdIcHVXc3NqMytYMUdLMURJ?=
 =?utf-8?B?eGd4LzcwTXNWUTJOb1FnUWlXMyt6azRxUGUzUzc3dkdLN2ZvRDJDODFVV0Vm?=
 =?utf-8?B?bkNzV0wvNy9KK1RKSk0vTm0xWW0xZGljbURpSHhyU1Bqa240LzY3OTNlSWZH?=
 =?utf-8?B?ZDV1NXZGbXZIdklRaDcwc1lnSCtrQ3V1NWVFVzdVVE5mK2llRGxaOGJnUUd4?=
 =?utf-8?B?eVk1QUhMTGJDaGRRR1pCZE5LdVVjWlJHenFkSFVpaVFYa0VsS3QyY0JwSURq?=
 =?utf-8?B?eE9DYUlFZ0ZUOEdkMjI3QmZENHNhRG54Z0xnNkUvVHRkdmNHTW5WNXVLSGg2?=
 =?utf-8?B?S1E2L1VPNkd0eFlzSnVIYnR0Kytjc1ZvOTE4Rm9ydUZ3VXAzZkwwQmJoRlJj?=
 =?utf-8?B?RHpzRllmK2lCdGlYRTE2S1JMS0NrWG9QUmRXcm1NZlExT3Vub0syaWI3NG9o?=
 =?utf-8?B?dldiRGNCSk1rcDlTOVd0YXZkQTgxTFpOcVExUzNGK290Y0wwWGZEcDhxOU1N?=
 =?utf-8?B?Z2tEZXV5dkoralR3bzNQM2xYR3BBZ3Buem5Ub3FhTGl1bjliZkFobU0wYWZO?=
 =?utf-8?B?SHJ1cnpiZXN0NzJhSXFyUlMrZFZXSTdaVmdKa2c5TzNxOGkxNkQ5dXlEYzFJ?=
 =?utf-8?Q?RzED8icnHIlBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9KRVh0Z00raWZhR3ZtVk5XaFJDWktoNWRxckdlaUlvd1pnVnBURk10b2lj?=
 =?utf-8?B?ZjQvclZ6RW83NTBNWTJyOFdXVHlOWURZY29KYzZaOEJhRTVpSEloU0ZtbkNC?=
 =?utf-8?B?b2hrZUk4ZEZXNDY2bDE5dlpsbTVmVU56aGcxbEJKZXNQS3Q0Rm9rc1NueExT?=
 =?utf-8?B?MDlYZklzUUZUUXpMdk4xV1FOc0NkVWwvdjZRT1NNNlpzSGFkUnBnbHVZeW84?=
 =?utf-8?B?TlBJeEFENlBIREdZOS9GbWljanFOb3I1MnRrWHd3WGlTRFZpNTNHeHNJVHJ3?=
 =?utf-8?B?Zy9va0N2QkpyWHhFRy9EdGVRTTBVZUd6SGE1TUVNbHk3RmlBb2JPRnAzbWtI?=
 =?utf-8?B?cTh3SEljL1Z1d2VzeHpBdFJaZXZ2ckh1SWlUb2I1REwycUZBVDMwdE1sbTNT?=
 =?utf-8?B?dXA4bDF6WGpIQ3psSEpwYVpUQUp4anZ0cXlJcGhydlMya1ZVL09hcFgySE9E?=
 =?utf-8?B?L1VjVFFmb1JCTExYRm90bTloU2xWSm5vVzNJWlcrKzdjN0FqeUNkbjUyS2d3?=
 =?utf-8?B?VVBFRVdLbGs3c1ZQRVJxRzFHVmFsNG9yY25JQ1h6ejlsaDV1dlRmTnhYaGQ3?=
 =?utf-8?B?UWVMclRNQ0hDZmdSNWFka09OUXZvRTNUcjNZcnNBcW5RUG5kNGpRaUI0endX?=
 =?utf-8?B?THBzdE0zck9VNTk1WU5SazlodHhKTzQ0SHZKNlYxTW8yRmxxUktIYTlZTnM5?=
 =?utf-8?B?WjFVczVEeUx1VGdRRjVKRVZBd3kzOWRRMENRUmVVUC9ENW5yRVBZc1poeEpj?=
 =?utf-8?B?SFFkY0lNeGtvQmdPUWd5UndCZHVnMTgvODVuemczMU5BSWNiUnJ1UWdlT012?=
 =?utf-8?B?MWRsaFZ0SC90VFJZQXh2akhyb0tmSGpraDlmYnNyUWlDaGRGQUYvOW0xaWtu?=
 =?utf-8?B?N1Rqay8wcmFHMnFVV3UzUlZZV3loTTNvazhCandBenZmeEtGaDlDUmdYZDRs?=
 =?utf-8?B?VUlTYnBnKzR6eGErWlJxUC9UZVcwVXF3Um8yVVA3OWVUWTBYdld6MXVUM0o3?=
 =?utf-8?B?bzg4bDZyRXNSNkJydzRoK2lhdi93cktTNHBCS1FaQmtFakRMUnMydXlKRFRF?=
 =?utf-8?B?d2thVUdkTWVLRmVjeGcra3pYbzlXdFVkeVlFdjd0TkdqbFRKaHM0UlRGZkNQ?=
 =?utf-8?B?RXEralFBMnp3SW16Z204elQwQUdBZ1p4SUJmN0pIVmdUQVZUcFVtSkp5Vk1x?=
 =?utf-8?B?TWdKUnhJN1RRbnZ0VzNpRTZndWdBenFhZjFrQ2ZKLys1Q0Q0aXV5cExhdUR1?=
 =?utf-8?B?RE1Wa050WmtZMk01SG5XbTBoK1FJazZLUGl5WDhib2kwVjZnZldhN213S1ZH?=
 =?utf-8?B?S3F4emN3UVIxOHA1SG9QSUtBOVM5Qko1WTgreWxTVWNoNHRzMG5NcGJEMzhX?=
 =?utf-8?B?bHJlbE9hbUlmTkpTTWxvKzJzeDNXWU1TMUFIY3p4N01PYWJ5dzZUeklpbXd3?=
 =?utf-8?B?anVKQlExbjBrcGhmbW85UlJIbEtIS0cxUGNSaUdaSU0yRlh5RTh3OGhUTmN3?=
 =?utf-8?B?aVpocTEzZWdtcW02Qy95ODdCYXVFbkE4MzN3ck5xZmdzNkl4ZEU4M0I3Z0Z6?=
 =?utf-8?B?NzNiYzhPZ0JGVWR1SEpxY3A0bnBERmozbU5ISGZaTlN1MHpzMjV0eFNuMSs3?=
 =?utf-8?B?RVkzbTFEcVIzeDUxL3dXVnlYaHdIcUdKMURiMHgwWnUrM2lNUWMwOE5jaTVV?=
 =?utf-8?B?MmM3eU1uYjhqajFaaUVmMm9ncFpPWmJhc0xwdk5HczBwMUluT3JBUk82NkZI?=
 =?utf-8?B?STJYVm1Lb0VRL1VtYkFFUkcwT0FVdUVWbkJHR09OQ2hiOSs3OStQcVVzNVRy?=
 =?utf-8?B?bTd6RWJlN1hsc0RYa29xTlpXbWorZm9ZVGhwOFFZOVpVUDBDYUdpMkJMWXpB?=
 =?utf-8?B?TWFEa0cxZm1NUWhLYjE2a3UrUFZBL2RvbzR5bFc0SWpFbjlhMC8yRU4ycjVZ?=
 =?utf-8?B?L0tTRkZzWCtLMEZuV3Y4TDhKdmVtb2YrY2o0dHFJYS8xK3lMSmhXcGhoWUVy?=
 =?utf-8?B?dTBXRml1aHFkbWNmaTV5OUhpWmd5SEhMQmFRR3JBVjBGdnZna3BhWndhWGJT?=
 =?utf-8?B?NElGN1JobllwT2J6M2ZrUEVkK2IzRGF1aUtCVHkxdnhsTmlBYnBUdEJPaWNZ?=
 =?utf-8?B?dGZON3kzemg4S0VBaEUrSFNNMWVmK203L20wL2dIeW81SU5zdWxZZ1B5cW1Z?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wHRG1Mb2GhI3g3Fz1I3SEdvkyjPqjcO5ee3kssnTG0FjYCWcNdjpMMkyQU1mTMkNm3Q0wzKvH9/EAnUVI9zbibSgnhNIGhn1OUPpegmzb3Dset8V+GZR7xXhKWkLXIWJ5aCJzdpirPORTvrUDxaHHMapim9WRZH2j58lu7xJh8a5LwdPt0PwqjrozxPwQnORh6d53psMwgyPyKM6ZP73eC4hV6Bt1e/pEoJ5iGCViT6OdYGSR5CDtdL49ZwVWFqoZxqgW+BX/9roAc/FvzMWrtCqtaaQ6UkVK6IPqqgAZjW1V27CSr23nmQI3+I8xwVH2utZKJLIid+ttV2+HzWGlZCqD7mr9KVH93hixc9GFob8edTjoVimxrwj/MlDAzdrZVnPuO6rT0Z9a2XWIPugxeaz20REmD0DVsZ27Ku5us0hf3Dgol/I7FwsV0lO5VMPjE5PRSnubl7ZwTbLm+Hycf45DgSs/eFGqiU3Kpwjd6qPSIGkhU/jF1TyuV1mKONJOdPInBqAxjJFSzE0rw2iytgMZA2oUGQ+Okl47RCHuMfS9EY1dbr5hqqfcIWsM0s713AnTlYiIYwKL87h4l4WKEorxeR/Z21sdb7o+LHvqYU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdeb373-af80-4418-f5a2-08dd60aaa590
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:40:19.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88f+B9UDBtY5V0fdqzK+SnmCCsv3uOE3oo5zAIOzK3jNTQ0//argPRwk1IJGY4cGRfQhsmX6JzCt/AtgR33s1k20vFXlW/IoyuPCapX30Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110092
X-Proofpoint-GUID: PC4HGezOtbVUPibrC43YEMOVrJG2k0N2
X-Proofpoint-ORIG-GUID: PC4HGezOtbVUPibrC43YEMOVrJG2k0N2

On 3/10/25 2:13 PM, Vasily Gorbik wrote:
> On Thu, Feb 27, 2025 at 08:48:22PM +0000, Sidhartha Kumar wrote:
>> In order to support rebalancing and spanning stores using less than the
>> worst case number of nodes, we need to track more than just the vacant
>> height. Using only vacant height to reduce the worst case maple node
>> allocation count can lead to a shortcoming of nodes in the following
>> scenarios.
> ...
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/maple_tree.h       |  4 +++-
>>   lib/maple_tree.c                 | 17 +++++++++++++++--
>>   tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+), 3 deletions(-)
> 
> Hi Sidhartha,
> 
> Starting from this commit, the LTP test "linkat02" consistently triggers
> a kernel WARNING followed by a crash, at least on s390 (and probably on
> other big-endian architectures as well). The maple tree selftest passes
> successfully.
> 

Would you be able to rerun this test with the following diff applied and 
CONFIG_DEBUG_MAPLE_TREE=y so I can check the state of the tree to easier 
reproduce the error?

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ea1f0acac118..74a4b1924a55 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1153,8 +1153,11 @@ static inline struct maple_node 
*mas_pop_node(struct ma_state *mas)
         unsigned int req = mas_alloc_req(mas);

         /* nothing or a request pending. */
-       if (WARN_ON(!total))
+       if (WARN_ON(!total)) {
+               mas_dump(mas);
+               mt_dump(mas->tree, mt_dump_hex);
                 return NULL;
+       }

         if (total == 1) {
                 /* single allocation in this ma_state */


> [  233.489583] LTP: starting linkat02
> linkat02    0  TINFO  :  Using /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N as tmpdir (tmpfs filesystem)
> linkat02    0  TINFO  :  Found free device 0 '/dev/loop0'
> [  234.187957] loop0: detected capacity change from 0 to 614400
> linkat02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.1 (20-May-2024)
> [  234.571157] operation not supported error, dev loop0, sector 614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
> linkat02    0  TINFO  :  Mounting /dev/loop0 to /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N/mntpoint fstyp=ext2 flags=0
> [  234.690816] EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
> [  234.696090] EXT4-fs (loop0): mounted filesystem 29120d07-e10b-43b8-bfb0-6156683a2769 r/w without journal. Quota mode: none.
> linkat02    0  TINFO  :  Failed reach the hardlinks limit
> [  239.616047] ------------[ cut here ]------------
> [  239.616231] WARNING: CPU: 0 PID: 669 at lib/maple_tree.c:1156 mas_pop_node+0x220/0x290
> [  239.616252] Modules linked in:
> [  239.616292] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Not tainted 6.14.0-rc5-next-20250307 #29
> [  239.616305] Hardware name: IBM 3931 A01 704 (KVM/Linux)
> [  239.616315] Krnl PSW : 0704c00180000000 00007fffe2b6c314 (mas_pop_node+0x224/0x290)
> [  239.616334]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  239.616349] Krnl GPRS: 0000000000000005 001c0feffc355f67 00007f7fe1aafb38 001c000000000000
> [  239.616360]            001c000000000000 001c0fef00007f05 0000000000000000 ffffffffffffffff
> [  239.616371]            00007f7fe1aaf3e0 00007f7fe1aafb08 001c000000000000 0000000000000000
> [  239.616381]            0000000001026838 0000000000000005 00007f7fe1aaf020 00007f7fe1aaefc8
> [  239.616399] Krnl Code: 00007fffe2b6c306: e370a0000024        stg     %r7,0(%r10)
> [  239.616399]            00007fffe2b6c30c: a7f4ff83            brc     15,00007fffe2b6c212
> [  239.616399]           #00007fffe2b6c310: af000000            mc      0,0
> [  239.616399]           >00007fffe2b6c314: a7b90000            lghi    %r11,0
> [  239.616399]            00007fffe2b6c318: a7f4ff89            brc     15,00007fffe2b6c22a
> [  239.616399]            00007fffe2b6c31c: c0e5fefc1f8a        brasl   %r14,00007fffe0af0230
> [  239.616399]            00007fffe2b6c322: a7f4ff4b            brc     15,00007fffe2b6c1b8
> [  239.616399]            00007fffe2b6c326: c0e5fefc1fa5        brasl   %r14,00007fffe0af0270
> [  239.616454] Call Trace:
> [  239.616463]  [<00007fffe2b6c314>] mas_pop_node+0x224/0x290
> [  239.616475]  [<00007fffe2b85ab6>] mas_spanning_rebalance+0x3006/0x4e90
> [  239.616487]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
> [  239.616627]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
> [  239.616639]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
> [  239.616650]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
> [  239.616661]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
> [  239.616674]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
> [  239.616686]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
> [  239.616698]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
> [  239.616709]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
> [  239.616720]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
> [  239.616733]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
> [  239.616746]  [<00007fffe2bf70d4>] system_call+0x74/0x98
> [  239.616758] 4 locks held by linkat02/669:
> [  239.616769]  #0: 0000780097e89450 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x4c/0xc0
> [  239.616799]  #1: 00007800a7de6cd0 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: do_unlinkat+0x1f8/0x5c0
> [  239.616831]  #2: 00007800a7de7ac0 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: vfs_unlink+0xc6/0x760
> [  239.616860]  #3: 00007800a7de6a58 (&simple_offset_lock_class){+.+.}-{2:2}, at: mtree_erase+0xb4/0xf0
> [  239.616886] Last Breaking-Event-Address:
> [  239.616895]  [<00007fffe2b6c12a>] mas_pop_node+0x3a/0x290
> [  239.616909] irq event stamp: 5205821
> [  239.616918] hardirqs last  enabled at (5205831): [<00007fffe03d2be8>] __up_console_sem+0xe8/0x130
> [  239.616931] hardirqs last disabled at (5205840): [<00007fffe03d2bc6>] __up_console_sem+0xc6/0x130
> [  239.616943] softirqs last  enabled at (5200824): [<00007fffe0246b6c>] handle_softirqs+0x6dc/0xe30
> [  239.616955] softirqs last disabled at (5200687): [<00007fffe024508a>] __irq_exit_rcu+0x34a/0x3f0
> [  239.616994] ---[ end trace 0000000000000000 ]---
> [  239.617009] Unable to handle kernel pointer dereference in virtual kernel address space
> [  239.617019] Failing address: 0000000000000000 TEID: 0000000000000483
> [  239.617029] Fault in home space mode while using kernel ASCE.
> [  239.617049] AS:0000000005dac00b R2:00000001ffffc00b R3:00000001ffff8007 S:00000001ffff7801 P:000000000000013d
> [  239.617150] Oops: 0004 ilc:3 [#1] PREEMPT SMP
> [  239.617162] Modules linked in:
> [  239.617170] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Tainted: G        W           6.14.0-rc5-next-20250307 #29
> [  239.617243] Tainted: [W]=WARN
> [  239.617248] Hardware name: IBM 3931 A01 704 (KVM/Linux)
> [  239.617253] Krnl PSW : 0704c00180000000 00007fffe2b6a988 (mab_mas_cp+0x168/0x640)
> [  239.617264]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  239.617272] Krnl GPRS: 0000000000000008 0000000000000000 00007fff00000008 00007f7f00000009
> [  239.617279]            0000000000000008 001c000000000000 0000000000000008 0000000000000048
> [  239.617285]            001c0ffffc638e09 001c000000000009 0000000000000098 001c000000000000
> [  239.617292]            0000000001026838 00007f7fe1aaf608 001c000000000013 00007f7fe1aaef68
> [  239.617302] Krnl Code: 00007fffe2b6a97c: b90800e5            agr     %r14,%r5
> [  239.617302]            00007fffe2b6a980: 9500e000            cli     0(%r14),0
> [  239.617302]           #00007fffe2b6a984: a7740262            brc     7,00007fffe2b6ae48
> [  239.617302]           >00007fffe2b6a988: e548a0000000        mvghi   0(%r10),0
> [  239.617302]            00007fffe2b6a98e: e3a0f0c00004        lg      %r10,192(%r15)
> [  239.617302]            00007fffe2b6a994: a7b80000            lhi     %r11,0
> [  239.617302]            00007fffe2b6a998: eb2a0003000d        sllg    %r2,%r10,3
> [  239.617302]            00007fffe2b6a99e: e320f0f00024        stg     %r2,240(%r15)
> [  239.617350] Call Trace:
> [  239.617354]  [<00007fffe2b6a988>] mab_mas_cp+0x168/0x640
> [  239.617362]  [<00007fffe2b85bcc>] mas_spanning_rebalance+0x311c/0x4e90
> [  239.617369]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
> [  239.617376]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
> [  239.617383]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
> [  239.617389]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
> [  239.617396]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
> [  239.617403]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
> [  239.617410]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
> [  239.617416]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
> [  239.617422]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
> [  239.617429]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
> [  239.617436]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
> [  239.617443]  [<00007fffe2bf70d4>] system_call+0x74/0x98
> [  239.617450] INFO: lockdep is turned off.
> [  239.617454] Last Breaking-Event-Address:
> [  239.617458]  [<00007fffe2b6a8f4>] mab_mas_cp+0xd4/0x640
> [  239.617468] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 


