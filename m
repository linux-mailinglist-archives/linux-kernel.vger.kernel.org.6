Return-Path: <linux-kernel+bounces-249284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F26092E971
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B6F1C221EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A815FA68;
	Thu, 11 Jul 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bRkI51fk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ygIn3Hqr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621715ECE6;
	Thu, 11 Jul 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704294; cv=fail; b=V9uBcr3cBa6Wg5QnjxP1BCy+5xMXoqwWZp0YCTu0sIsrcKdIk1YTlA4QXXAOXJRghlzFVxFGj2DtRYuy6PKGs1I8jTjDmPJFieFbJZmH7S1a87kUk3v9oieu3phcCZFfd/8g4aUhAv5CI4Q99vTicjQ9vPeHN50akRDrcozPeY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704294; c=relaxed/simple;
	bh=+Ia0a3mtb+wrtYOYzWsKxUPvmzEO4hs7q30AP7Syo0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZnNHJLXQiApg2ES9hbJUC2btLJ2GDBVgKjnM+HDf+uS13NkSH4GnKibmBQSaNW1M+XkDipkGwN/2Jc/hrZToR2PoUPvqWI1UFHjrUBrpmm8mOqGlid6k8TqcrjqmKPgGIlsz/oOtvy8exl/Sxw4P8qzImFoDFTRP2rZSWnzBR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bRkI51fk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ygIn3Hqr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tcpV012756;
	Thu, 11 Jul 2024 13:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+Ia0a3mtb+wrtYOYzWsKxUPvmzEO4hs7q30AP7Syo0w=; b=
	bRkI51fkuYXAvJOcI22H0IlM9Q3kjm76ibtkJKRa4HSb3O640B4A9vE1FjWvfKng
	HtAQkylhGW4mLzuPg45BNI+mMD9I2HOlY5xRYoqpWTkOUlSh4Sv4C5McfowiMZa7
	b3i/bzczcbtGQcxenM2PN+my8cug0DzJoy+ocm+bj71bhy7c3bZ2Tq9CeZyMlsY7
	8SYTGYobBI6jgY/tmG6dxfCYrYP91PWAmOlZE2UboAnjcoFjWexzJVCAIWMIx05J
	LUTi9bJe4KsRIikeGkUpxPu6dJxvyBQBFX7IxgG9fEQ+Y0mB7m7LnUTN0+hQv8+k
	WlTBzRPpDxFk3QYg9r4uVA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky9pwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:24:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BC3OAw008924;
	Thu, 11 Jul 2024 13:24:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4hyvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3jlgHxnwk9MzEVtw2g66GqKOfY/MyR+LJNirf0CXm/QGxyXFBNo+qiYgewUsv2zZ4XiCSOzpyHvYP7DSHCWfcXkxhmng5Xmc2SURF8qcJzUG1ag08hlVJdk/k7Ltbf7t9SiXIvlBFz+4unmpA0r+uAEwVKy8MsDLqb2HNFoadFWw6QfzHDl9RIc4h2KK9Haiqz50SNEO+7P20djmh9Emv8EjhIODom7wME+ngVePY1+thms+Ilra3Fb5MEYOr48enz0s9O4XaxYtnBcl3hVzF/+tUBrw4ned8mOz8h/gB8tvjMVRObkwhk3Kjo6R2LsHqQ16rjYNgc0GYMd0MUvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ia0a3mtb+wrtYOYzWsKxUPvmzEO4hs7q30AP7Syo0w=;
 b=rLOu5tCXbd12huqgHi4r3DuH2PDJxuuuLlD7UHFFL6plgWTEHlVUocwyP85ihOhXAw7f5ztBds0a13p75NGGUBrZZ2i+52t8G9A+eHkhZ8BPNQKOqw+c0gfERdyz8eXvZOSllL51enk5utRdj+/2fdNt4gnFBab8QhQMqDYw1SyFDqKUgYL5FY4lm1uT74jFZvJej9fXnVV5zkYBPgHCFEdXgdvlBraA7sp2cvPeT0XqwxIhnnSNoJdANhF3xF+DYVpzOV/oySggRCB0aufxHxsRwyZtqagMT3fQNcAUOoh9ynB3Zi8K0jCTr6xh+XCmOhNIidsahjniKMQJBs4itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ia0a3mtb+wrtYOYzWsKxUPvmzEO4hs7q30AP7Syo0w=;
 b=ygIn3Hqrk0TsSEO6DjRt+M1pqIT4iPQMN6wR1cgwu1CF5gz4bNt5gTTHKVz9OXSaF5Kt5NZSeu1rDin8z5oVpN6/RLlZ426t9WER81jCqJ5pZa4xm0gnhqFolAsehmIyAcF36MeDRBd5aUYDYbkDrxzSn6eqUZM9iuJUuX5IB4c=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 13:24:13 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:24:13 +0000
Message-ID: <4930431a-8dc8-47ac-8d4b-75b64c5110e0@oracle.com>
Date: Thu, 11 Jul 2024 09:24:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen: make multicall debug boot time selectable
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20240710092749.13595-1-jgross@suse.com>
Content-Language: en-US
From: boris.ostrovsky@oracle.com
In-Reply-To: <20240710092749.13595-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bf0a03-1b5c-4628-9874-08dca1acc1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjlpM3ZiNE9JdFlrZ25zT3BETXBTSlRhMVAvUlh0bVNNY2FGQmI1Ykg5aWF3?=
 =?utf-8?B?OTdDdTJ4MnI3R3ErMFlJcEVLQmxqZFdjTFNiWHFHMTdFR3d3OVdYUWx6Y2tK?=
 =?utf-8?B?bUtPUm1ZR2tQYnZLK09Yemg3dGtBVkFDZEE1ZHE0dzBqTkc5Q2pXL2JFcUtX?=
 =?utf-8?B?UDBYdkNmclFucW05T0ZlLzRGRTE3by82aStGLzlrOGZvUlFqUkQrZWdaclRZ?=
 =?utf-8?B?aGVHRzJZTGVZSmFPc0ZnK2ZpemhibkJTV1hOYnh0R01BdXZVbjhhWkEvQ2Zr?=
 =?utf-8?B?Wm9QaUkyRmhxMHlRVGxnRkwrZzNWOUVZSE1ueFRJd243dHZiYWk2OFNubkRt?=
 =?utf-8?B?WGxnbWdzNEtMb2tkU0ZoQmVQSnFBWFc2KzFvOFdlWGpON1lzaUdCbTdPeVNI?=
 =?utf-8?B?d3gvNndKbzVpM0lLWDFLd3U0WjJRUm1MbzZhNTU3WkVhelJncWZiT2tuVm1z?=
 =?utf-8?B?aS9mdkRSTHdXaE56WlhhLy9aR1RITjJDYnFVdU9XZzhITFFQeWdOTDVNdVB1?=
 =?utf-8?B?dnBNR0JGUHNrV3dFQXh4TCtkOFhGbWJvNUM5bDlIbXFES2FLZnNXT25vYzNj?=
 =?utf-8?B?SDU1ZmxYWUQrcHRqMU4yMW5jZVFMamJQbVhKNGU0N25xcTdGYXJFVHlSZkh4?=
 =?utf-8?B?a3RyMlFYYWtsUHFod2ZZQ0NqVDZuRkgyVmkrL1JpL09zZ0xONnJyeXMrcnFx?=
 =?utf-8?B?b2FUWTJSRU5JMVpOV2VFUTUxZVE1WlFFUTdzSDVJNDA0Ny9BQXY3UFM4WFhi?=
 =?utf-8?B?dzN3NXpUTGllOWI1UU5teVZZQWdFTzJ0VDVwNm9NN2VHME1DU2dXcU9WUTlU?=
 =?utf-8?B?bmN4Q0R3MzMvbUxqYUJBcFEwcVpYS1UvZTRpb3RGWjg1WW9LWXRIZXlhSHFG?=
 =?utf-8?B?ODl1QmpqMDlmWUVlOFE1V1pQcHF1NDZObkY5Wld0NUoraHMxYU9mWXg3Zmdy?=
 =?utf-8?B?blpyWHRtbzk1K3c5SThlMG15TjFuUDQvb3UvSE1qVTJxVkF0SWhXbTBEWEti?=
 =?utf-8?B?Zi9rV3U5U3ZZY2FOdnBVcHJrSHBxeWtDbGdNMEQ3QW9ITTF1OXRTbVRPNDFh?=
 =?utf-8?B?YzFFN0IzTDJ6MEdDOE5HSDNaZFhZMFFyVHZNWEE5WnplSHRGK3UxK1pxMG1N?=
 =?utf-8?B?bW5saE9YSVM5THRWKzdVRGJJbGNDRkpEc1hrNkM5OGtrRkNUMkFoOGxYYlVz?=
 =?utf-8?B?ZTFlSXZiTEF3aFllOWorWjRwNjZCUDNuMDF6Y0kyeXppZXNqV3RUMWhnMkRk?=
 =?utf-8?B?OFlnRTZuUlB2SGFSWm1UTmlEVmpzVkxVeUtNWTVrcXMvbG5qRnlLY2R3bmR3?=
 =?utf-8?B?OVh5L0xQQno5ZVNITk9NOTZJbDhDRFYyRXUxcUNTMnZFdU9BcHVNT3FWeTBs?=
 =?utf-8?B?cVh1YXd6TzhtWEdRQ0N1WlNUUnlrWlk3ekt1Z3I3b013aVBmN3g5c0JNL1Vm?=
 =?utf-8?B?S0RHa1JvTlZuby95R0NUcWF6Z2hQV0tCWlpwNENDTHUrM1J5ZzAwVjBHUlpC?=
 =?utf-8?B?eXJvOEdRSGVHblhUV2w4MURYWHRNeVdBZDE5NEdwVFpPcnJlY3pqdEYyUU91?=
 =?utf-8?B?Y0h5anE2R1orbGlDV25yVkYyNkNOS0QwZWJJZ2RKRTJtUGMwajg1eGNFM2o5?=
 =?utf-8?B?anI1dzdPcmR3L29XZkxPRExwelpCcHR1d2tKK0lTVEVaakRZeXpPK3o3bDdq?=
 =?utf-8?B?R1ZMUHIydTZNM3FqTUJlYndlR1ZNTlIxZWZTVkFNbjhCRk9mdUJVa2ZOamQ2?=
 =?utf-8?B?alQ5dGZtb0N6ZHErSnVtMks0b2ZHK08yU2VBK2w5UkltSEVSeUJjTXplaGM5?=
 =?utf-8?B?RjZmbkRqQ2p1S1pzSUtzUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M25kcTMwRkhEalhHMUxlVWpsaFJrY2wrUU5BWkZYTDVsemNMNkpzNCtFK1RP?=
 =?utf-8?B?YjBmR2RKb05Nd0FGMEliMkJqNVdvMzgza2NzbitCQlh5Yzc5YzJMdGR3T3RI?=
 =?utf-8?B?cTBIbUx3SXFteThoMjk5RmtMQWtzMDJ0V0JIQTJHejcxR1AwM0dDWUJOU2hT?=
 =?utf-8?B?b1dhVmN4ZlN0blhITkRUQlpxeWI4WncyY0dBamo2by9IRTFVQW94cmV6Z2tv?=
 =?utf-8?B?TU93WmVRUE5KQ3NobjY0SUxNU0k2ZGFUL09RRm9KYjIzb3lyMGg4azVDamR4?=
 =?utf-8?B?UjMvZmRnSTZRSW1MRTl3eWx5YVgycGZXaTRyQVl5U1lSVW9vTGxWRWZJc0wv?=
 =?utf-8?B?bUpTZVZwbzlkRzJLZE5PQVZjdlZwd0VvMGtsVFo0a2xoQUNTRjFBOFFvMExU?=
 =?utf-8?B?bTdUdHFkUllFVCtiZVM2OGRjS3FOMUxHdHVYdFV2TUlRZkU0U0diQVZFcEo2?=
 =?utf-8?B?ZjUrR1dVOXc0SVZtVlpiQkptSm4yb0UwVmRaM3U4aFB4eFZSZ0dQTjhPN3Zy?=
 =?utf-8?B?MUZjVDJraU1GbzZiMWlvVGQ4amU4N1NlaVRsVzNha1JROElVVkpMRkdUOGRp?=
 =?utf-8?B?L1ZRNXZaUDlxUjhxT2tNcnpnUDNIdUpnTWJhUVdXM2NvdGQ5S2xLc0VLcXdy?=
 =?utf-8?B?amhVUmd0NHIrb1JsNmZRc3NBR2hrajZEb1hjcHN5dS9sSXA1ZGN5eHR2VHFa?=
 =?utf-8?B?TEE1MmY2Vi9zcHpxQXpGc2xyOEhPYVFQSFRET1RNK0hUSFhkNy9jZDB3MktT?=
 =?utf-8?B?bitSRHhvZzVyR0xBMndvZmVqM09hRzErWVVjZnAxZ0xhVVF6cU4wWVlnWm5l?=
 =?utf-8?B?dVkweFZwKzdmN09ncmVJbkZXK3B1dU1oQXlJS3dnM0Y3VnluTWNiMWVZQitN?=
 =?utf-8?B?THpERUFhVnl5eTRxazFJcy9MeHl1ZzBCcnU2TmJiOHQyNDIxeGc1cVF5bUox?=
 =?utf-8?B?UkNrTWd4V2x1VEtIUUdHSnh4Wm9oc1BQdTIrNlNyWjl0MkhDOXpqVjZNZ2Zz?=
 =?utf-8?B?c3NGaGhibzN4NlRTL0pOSm5meklPZ3RrN1V4QzF1Qmhyc1dHNGhSRTdJa0M2?=
 =?utf-8?B?UCt4MGNTTWViUkFNZnBQcU5Jazl5VW9tS0RkWmt0cEVLWExsc2JsUll1aEdW?=
 =?utf-8?B?RU5kRFVBS2N0RWMwRVJ3T0Roc01YTWpJeUZkUHpoYWpRZ1FhQmhydFdkSnVm?=
 =?utf-8?B?TkhYb2RMcFBLMEJVczQ2R1NMdmd4YzFTTmdENitldmVPM2ZOdllNMytxWkJh?=
 =?utf-8?B?YUw3S2NxMUllYWpvVzFMWWJNcG1vWHIrYXAvV2FOZURuS1lib0RxQ1pEazdr?=
 =?utf-8?B?a0ZvczdlV2gxaFd0UzRhQUNLTW9VMG4wcXVoZDN2bGNZOWZhdm9xVThqa0J1?=
 =?utf-8?B?WXNLeHYzNk5kWnViTUFGbldqMnJmR2pxcFFsbm4rTjBpTUpZZ054NS90ODN1?=
 =?utf-8?B?VEZiRi9hSm0rOXd4Z2ttZG8vclhTa0xkYzlJWHg2aGhuNTMySkFmOTdwa2ti?=
 =?utf-8?B?TDJ4TUxoTjRZREFKWkhsWFJUNmlkU3hKUXhRQWxVVFN6M01XdFpXZFhQM29F?=
 =?utf-8?B?bEVjall6Qk1jNTIrTkxXd2FNV0Q1MHRDcmFNNjByRWNJaWtpR1BSeEhtV1Z5?=
 =?utf-8?B?K0N6RTdEaGgwTGluS3Y5a2Z6N2FjR2ZES25BNWo4Q21ZRXlXdzN4R292d3lH?=
 =?utf-8?B?MWtEaEFHWXFhNk1qN09LN2o3d1M2M2tXVVhwUUVpaWFJVVpXSkVhWDVPL3h4?=
 =?utf-8?B?N0pERXN2OU9jalZYcmdUWDBjTVNRVjQ2UjQ1ZUFhRC9nYnhTQlYzZFFkbzYx?=
 =?utf-8?B?UHBQMG5DemZhNzlWMW5qd1ZhSmFERVd3a2lLM0ZTZGdSVU1FWFVkbzBmNFhp?=
 =?utf-8?B?eExWR2I5SlRnSlc0NFAxTk5VRWJ4L0hTbEhrenNxRUVXNHlCU1FhWDZJalJH?=
 =?utf-8?B?MzFSMXo0NlF5VG1odmZkQzNWTHRpUnFOOWt4MTdrcXhnODRKSlRiV05kdmhh?=
 =?utf-8?B?UXhaUWtMNW1IWlBkZWhMTUUwVHE1VFE4TmQycXBzM25md0lkWkhxYVlhUjhL?=
 =?utf-8?B?ZkEvN2VvQ0tpL2U1SVJlWUVWdXVNeXI4UktPSzNqM25wemh2QWVYN3RIbU9a?=
 =?utf-8?B?ZXNJOUR5dWhqcGNnN0tTdzFHZnFTNCtWZEtTaDNXOWJwR2N2bjhheC9WZ1oy?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1USn+2Gae6PbJ2nRjC5odCVPSQ6CDx8COHV6RPNMnnxoOWYsHNbMnL7Eqf9+3BNpIr68fVRisMumaRJI4Qq0MOzhj+kAK9ZpcTGizMGXN2kNijc9z6fbJ4QQbdIBwKxxVHDE2oyZASkaucFVhP3HM/4mSRz6j3BKFsObFf0Vf53oVRxwVgYqu2Z/D0yKS1FkdQXc46hGMB664ppLVMyd/5uiF0/sNiEzs40abNjqCZivuj8/EsTPT/DxdU7ZCq/XW8gK2Wzy0re0JuPzZYN+4C8YcGGLk6kDJm/wfwSU2OrSEfF342hGh3noqYteXzbLhctqAiY6Kx78+K8gmVQUGZfz6rrzCM2wRB8DaunjcgNjgYzLWUiPBMxL0msFIq+eByHxbCpbXoNpFOYutCEhkS/zYR2LTfyQcRls0sdpE7FqGpJRy4jmIn9QbyrbWsyFl32Mz05N3JL4Er2r6rs5b6tzFzhXT6ihem2EBWx/zSnB2vj8N7uHU2eguVgOjBhgMpfRbsaHHARnhD1YY7KlWzuVJmuEk751/PMxIb73U05dmfUWwkmlDhwOUi+4a2B5222KeKFB7xve3cP/2fAMILfX3qW66YXYVd2eQCAkO78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bf0a03-1b5c-4628-9874-08dca1acc1ad
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:24:13.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GFVL/Wlj4buJj1bELvXx+v8MJ/s1twWD2+vWycARTDgepvvYnQ09mk7yvmApFdLlTKzkSs0UwQzLHF1o0WCpOiNYlffVk/CKGsg/XPwVDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110096
X-Proofpoint-ORIG-GUID: 97cW-wtBgkdF_gab4ssIWg2zGwABCyn9
X-Proofpoint-GUID: 97cW-wtBgkdF_gab4ssIWg2zGwABCyn9


On 7/10/24 5:27 AM, Juergen Gross wrote:
> Today Xen multicall debugging needs to be enabled via modifying a
> define in a source file for getting debug data of multicall errors
> encountered by users.
>
> Switch multicall debugging to depend on a boot parameter "xen_mc_debug"
> instead, enabling affected users to boot with the new parameter set in
> order to get better diagnostics.
>
> With debugging enabled print the following information in case at least
> one of the batched calls failed:
> - all calls of the batch with operation, result and caller
> - all parameters of each call
> - all parameters stored in the multicall data for each call
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



