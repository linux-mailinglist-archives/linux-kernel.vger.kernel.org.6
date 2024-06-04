Return-Path: <linux-kernel+bounces-201279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5D8FBC74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AA51C22FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429FD1494C2;
	Tue,  4 Jun 2024 19:22:29 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D814036E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528948; cv=fail; b=HS4xIujsyGsaiSaKeASHH1rPSRtwOJG7wbFCDhnC1VTrxs/Q+0Ut53nRnPasUYNsOLwXG0TGbycgwMl4ER6RClhzj5uw3iZkgGIvPOrAwxC2MPiernOikVPhCm6DoHLC7SflvUoqBhzS9W9vFEsgNAmhw2RzDgDvUHQEDEL6DD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528948; c=relaxed/simple;
	bh=4ET55HC+Hwv3tdSN9uZi53oFt13Hkis+wvmubfGq8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QLNRXs7E0v/76rtrJMPQcBv++LSFQRVCRYX9S/DSY++CngoIDlX3zITSyC7Uw2mX+4lrkxGNVzPgv72UIixamk0F0KUUku5bNR4rSzT01y095inmlTMj2kxlVDYsWG/8Mc1FB1ojQOUn8QQVBqtZTMdFs6Ek7QMuYgtIhAAOM8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454J2wpj004599;
	Tue, 4 Jun 2024 19:22:05 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DcTy+pgCeuYjh?=
 =?UTF-8?Q?8JHDtoklkkFKbqvXMMrW0UtYpFX7ZFE=3D;_b=3DRo3GTpYVZCJMG9nJ3vOyuEg?=
 =?UTF-8?Q?n2dgLTX7oJPaWxWyl7Se7jmk51NkabHZZchs3NH+xU997_5+oXZS9tiLvE8vxbX?=
 =?UTF-8?Q?U0bAXgWURRJ/qCEweMPZlrxPitYv3zh6NBKgqAmJgV6ZQzhhscf_VBU+nfGNNR3?=
 =?UTF-8?Q?GmMlBTxhA9qVDk7hBztQl1+cQ6tb5dQyr4buEsYZj18o3K0rRqb8jhfVr_tzTfs?=
 =?UTF-8?Q?sHczWOQg82ulWQirUUqfc3EU0YaHDt20vcAQn/bfPEFR2aLzUDYR1IRB3JdHmkA?=
 =?UTF-8?Q?_Xjqju3hWlvpus3eDBPBlXvy4LyMudVufi7qLQjMv/e8WnNUucyxC9/KgFjV9m1?=
 =?UTF-8?Q?v3eYfF_Ew=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05dt58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:22:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JL8Pp020627;
	Tue, 4 Jun 2024 19:22:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2fac5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhHT3O+53mlOYNrd392ESN2AU68QW4To+9Cf6cyWExJPIgb/oXFumvxkywJqD1NpGTVPj6wmjyxFJk4qz/CsI1Y6hPQ7dZ3wkZquoC8VtJrsaJbKl9p0sHku6VNxF+pqC/lkiD9SCrFeOe+tRXsgzNPJeMJB2ggssklWKZdenr+Q3w0SFsLRoYsrFinnW37+tvEw5mQN1HQeph37ej3OyJreXfzeRA9Tzn+MlCUJHExfHnAanqH5oxdmMNLJJ0YKiTJUJs6L1vL9hQUvD1/zfqREC8E7ccURKOG3Vu8uYo3oMT/ilhPR+JO0BGkpABe060e6jfg0ClKiRQlA8OUwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTy+pgCeuYjh8JHDtoklkkFKbqvXMMrW0UtYpFX7ZFE=;
 b=Ki+ycRVNvvOJM5/g3c2XfbGxsL4yUPiDOV0XxfXPPVbK+QQIyqlULckJwRPEpcIv9haTNMxqn1eRJbiIoUE25Z5qNGay4fdJnFOicqaX0xyJssyTvAz7kSndkItxcaXk+HXzQI4TqvOgsnwxVarPsafrMw8FasT7XI6o6EZoa3cEqv2sThQav/+AFfgC3buoKaH+yS6t9c/qJ5EHRko1FbFNB6xLzT0HVOywA5o2BLjiTfm6X5C2ELL3WH00LYdFc1oO3/HKtFS3RU1rjVIXsqxmoJRbe84Eckv9wAW1lRWRFCoMjgge4GBd86N5dvTyFsDwu8axN4DAmelJ0koLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTy+pgCeuYjh8JHDtoklkkFKbqvXMMrW0UtYpFX7ZFE=;
 b=lMarsoCFLbJJx6U1klmnFRnJVsNf83TXuOcD7+U9sCdkcq1J3YzXGLRFE4BeMGkdifitsBwwdHnYPQzTN5uqz2q61MMv5gOcW63aEt4mLk6iKUzOZQ5U4Xg5LxePpPEGb7+yUn3QYa2XwtJSUbgmH7uu3ycf4FIGAFgt3DXYKeE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 19:22:01 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:22:01 +0000
Date: Tue, 4 Jun 2024 15:21:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, willy@infradead.org
Subject: Re: [PATCH 06/18] maple_tree: remove mas_destroy() from mas_nomem()
Message-ID: <nwy2dqzviquqxsqjkcihsuhtz7vfzszow2kxamjgdk2s52jyzl@xesgos2ltjen>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, zhangpeng.00@bytedance.com, 
	willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-7-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e6f776-d9f8-4a88-5a52-08dc84cb9c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HSHf8xzAzmudjPZgdxGbMEMVIM1j/tmq3wfh5nmyYY41MKijZe9ywV0bTkpV?=
 =?us-ascii?Q?nv9LwSvqTCeCJ+ysAkr9gJemsGLWfomxWSXXRRRdUaeO89aPOAYLZW0G6er1?=
 =?us-ascii?Q?OfZpvhqTrcs7SjwAe+0OfCeFvn4LKgXQeHrV+YbPZLC6G9QKMNSOp7JOPHDL?=
 =?us-ascii?Q?cijwG+c1aM15EHySWTDx3LsfbP0I59NJtvJJw+c8HwE/PiZxgevRX/6WxCvg?=
 =?us-ascii?Q?ReT5KDL7BpaKnqmf5T7PL0OwMxW6CjCPrk1Z5ki9mvEUeEqQOZDAy/+0dd1X?=
 =?us-ascii?Q?ij+pMaBCu4GLZMRI5rXDwk7phcCVmcp998GZ7yrNAhc0rjpr1mdH7ZObR7Vw?=
 =?us-ascii?Q?Y1M7R1Aawfvit+fpXl7j0Lx5Dm4G0gu4oA3GovsT46E0ICOUgFrGw+TlEYpe?=
 =?us-ascii?Q?kGEQo7YVbBauNtwOG/NJE/0uWsU8JVfHd81xidkXsgk5rjWkNqZejntTYvmy?=
 =?us-ascii?Q?oQwey4lFDwAZf154tZb8ldxgWDVewWlsy28N0KJFQEOR2Q2bMdUXpki/4SBn?=
 =?us-ascii?Q?EncO0/mwnmCdrnizeHBGiKjTZkzOwBfbVmLSi1SVSUzVunjtN5eM8nnWW9qX?=
 =?us-ascii?Q?luHuBMnm5t58B/aIWc8A2eYaZiO/dlJgP7cmerrdQHhrUoPGCCgutaH1Ft0p?=
 =?us-ascii?Q?v8Y3Prf9YK1aCidDVRi9Dv+ei41isffjBdK/pg38Iz/0NUzVwEPCBkj6/RTU?=
 =?us-ascii?Q?7fzb3wu+6x2wPienLWZJu19cG7yIMzz8OYcPgiOTJFVtvOxcUE3gobTuEQIJ?=
 =?us-ascii?Q?TZPbVkrkPCqpSVF6GJqsmat5DPaeSdh8IlA6S9N0f6T3j3Olc8l59910tH0O?=
 =?us-ascii?Q?oYrD1tvt5AFdGqhp9nMzbu7iZPWc0ZR+r4qxhGARPrLYt6LkXUvQnwddGxb5?=
 =?us-ascii?Q?z8XmanzmuVRtsrCVnp+kKCFoNjq0YY3J/x9ll6BISfz/z4H2qgrztHUN4w12?=
 =?us-ascii?Q?DUOlZWq5gWMtu3mL+C9cK4eBxw5gNBcWkW2h+1ntR7wpqLWuEke7nEUB3Dac?=
 =?us-ascii?Q?0+QNFZJ38vnENvChQ0vgnRb7XkdkaosDtTF7LM2UZqltgSrXRu41v0VgC6HG?=
 =?us-ascii?Q?0bLcpF5IoCvyEkSXhPHaM3C0xXhbNvmWa1CpWnPmUZU0S9ii1R2pPad1UDFT?=
 =?us-ascii?Q?A/AQKPXc4KbaigTtO9gKinae4qF/Tol9syDiLp/q6fWEgY2rGLslSiChTBXF?=
 =?us-ascii?Q?QZP5oi07aS1PhnxAEgGBjnViOuvWfy3emngVd98CV08898wtz3vuwEBuxzOP?=
 =?us-ascii?Q?ThB4ZUODox0CqQRqd5SASABGN3mW3FlvZU11Upvyjw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xz6WAQZul7Gg2H8rTywkhDuERhKqB5MtO4FpNMeC1MnxoZ8ixgUp85tv9KPb?=
 =?us-ascii?Q?n/+9oa3KtzPws2jvTCDk6Q0J9PwgXkAKBjVVK5W1kE8j7NBZ0TdnJYYWj5EP?=
 =?us-ascii?Q?kHxgmL2Qq2h9jerWxHcalylD/qYFEiw9Ksc/noqf03slkLpat0MZLw+6DbSS?=
 =?us-ascii?Q?ybAKs7HU04HlBkVFx2HvTpgsLgYSM6UIGUEXmIiLRZ2/Wu4af34Pa2whDb02?=
 =?us-ascii?Q?XnUHsk/awfXzAOAzNlzFYKdSNkalu4E+0zugGOAVH0QhelkOdwQEtBwlAnAW?=
 =?us-ascii?Q?B2FBQ27HVxhAPjFtyl3BVa7CLtXtu45p29tzLL7PqgoTpl6c7N2mue83JKEO?=
 =?us-ascii?Q?v0ZLE/31KA7KjOQb7h/Kuq6r8aMHKXHLFPcK2ad/lPUFYQtTqUoIcfx4SeiY?=
 =?us-ascii?Q?kc1DFhBpaGQVXu4EokjPAn2Zyh8wVDLGRT9X6yueP6crHbFjS1MIKFHl2p1J?=
 =?us-ascii?Q?vr3691Oz6UwlbGssWWPxjQnkL1QsMlXZ6efO6SJWMaTGaWJf2DPahmutO2dT?=
 =?us-ascii?Q?nVJCGmF2a4LhPtFOJVgewf/FuCosOkpqe6kfrrw0dS513bMDoX0c71kwHQB2?=
 =?us-ascii?Q?4TVsp/HM/N+2dasgVU9WonWZS+4awT3xD/yDjhjMQLWhgju/20C+VZrBZ7oX?=
 =?us-ascii?Q?O2MerzYpAb34+nLS0sObEUSAH0hFqV2hAuhlNd0ghTl1tuyCoVsGD+10Sj1x?=
 =?us-ascii?Q?UWCs2lcg5TIb57l85ziKmwsTYnStqJGMqsFfcfquq/93IcSlAEsg+Ogg2bB7?=
 =?us-ascii?Q?8NeShl1lAyGfYUvRn/lKT48moppiveS1MEx1+nykd8gB35hJ3fdDydRxCzkn?=
 =?us-ascii?Q?D8ySKvf4D/bKsbsnskzWMNtF0O+qMRzdYENce+mbKrDvNh5Wlj3HOIREgSnV?=
 =?us-ascii?Q?IeHovtCNitGDPGULwxaSoGuKUchSO0ZFPqxbwjh8Yf1efQI9UbSoiASjf1iS?=
 =?us-ascii?Q?ZPBfkS58qaYakUX0mfT1672tSSbUjT5rpAiEAEA35B3x+5LAis3hjzPBtWX7?=
 =?us-ascii?Q?s1R0u/LSLsOztMBIYBtCPrnS+9hIsd7SjUF3hMindl0dl2dhEM3lh3qSoJdH?=
 =?us-ascii?Q?xnd86PR9n4E/g6zg5B8AxYHjST0GA7SX6ApELnvkJ8gykK2iRrQuhbGtJJ22?=
 =?us-ascii?Q?j5+c1SkQPSlZyNtDraDLL9SPcHpsZ907MxnaToXliGJGKEq+QMXpkfzuDCSj?=
 =?us-ascii?Q?mMcE1Q1EN0DURNjseugj8fepeZvwVqZKkQV9kPs2Hd00hGdDFvEU9PAEMGGA?=
 =?us-ascii?Q?4bJd/1cYYVtOhvo1G7uCRiFzHQuxaPptl7Oxc/3LrsSosScJyHSuTeBvBqR2?=
 =?us-ascii?Q?meNbqTpWWk40FLJ5aPev9A+4pcSJDtU/0Zf9RGamG3bzLRFjQVbkt4mLPNj9?=
 =?us-ascii?Q?ayRmBu89E+iITJrcMJzVgECfTVvu9eqld2/aBxjv26Zwo7PB2SAcT42nI6dY?=
 =?us-ascii?Q?Y6TZbz3czc0gFQet9ib/lEedYo28AAJ4K1womiorryFT4Uwz5EnOZ4ehqV64?=
 =?us-ascii?Q?jHpQCg4PMnFwJqR7kPVmIR8xv3+6/Hks5yYJ4CHHdU61Bfc29gM08V45tEBb?=
 =?us-ascii?Q?M79ut1TfSQQWHeiGjRiCd53tBQuQcmuOJjm+woKR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CA0OqWoR4OViJTyGTD/5HdpfskvVkHBYENvn8RrZ5tBB8ElP70MkoSHNBdz5MHS7HlQXSVUWzGU4gQFMHl1oDAq16sTuoluWm8ZOqjAZmvBvBwM3lts2Wvg6vkgqIkEEtkETP/2vxfECupJUEqapAef59N/rctP3epWxQ3zhefq32+0AsZkYoh15QvkTGy39Kl6mqhH/G2HhzDoJ+SJRV/43/MMCa4zIWmo3JqLpgbi5koDsqPEG7oFLAoTDiwDAuCrVJOLG+D/p3oVTsJ3zJeD4gTj3Sd/y4Z5L5MjDDemd21S96Bjy3pxHWatrSQ4Oo6+vYkE9w6gPxA7ng/PDGlk+hxsVi4GCOXSrDcB9sWZlEFIYYfnV8Iu9vSjsNIC8XtzQe1ip0XetOva5xkz5hB14U85ZtsxiIQht2ptiquVncFIlXqf0PfHZ2J+EDP8/zOwB024y7pLve2YO2m6zj8brphIAXm+WM8naZ0q3CM0c7t3LV2TQ4Q1AWOsctPNMxeR7ZeokRSzCWwBxNhAwmIUOAaIdp5dd3UHCW7nxcL1vU8TGZfCdPfyiq4j5VIOGhALjPKCyzl0PmfZ8M5wb44yOJ0K9xxfEdhmcakibsU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6f776-d9f8-4a88-5a52-08dc84cb9c2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:22:01.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8j/6sGWGk5c3JZ2k77Vup8GhR+2uH9uKkrjzl5F2NrvoR65Rq8aJqZah6jJBUC5EduqFiWbVZ6az5HvSXZX2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040155
X-Proofpoint-GUID: 6K0clSlF8s1v-B2NvW6dlEbAYvuirXtv
X-Proofpoint-ORIG-GUID: 6K0clSlF8s1v-B2NvW6dlEbAYvuirXtv

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
> Separate call to mas_destroy() from mas_nomem() so we can check for no
> memory errors without destroying the current maple state in
> mas_store_gfp(). We then add calls to mas_destroy() to callers of
> mas_nomem().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c                 | 39 ++++++++++++++++++++------------
>  tools/testing/radix-tree/maple.c | 11 +++++----
>  2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3780d4bb0415..f1496817e52a 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4526,6 +4526,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
>  	if (*next == 0)
>  		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
>  
> +	mas_destroy(mas);
>  	return ret;
>  }
>  EXPORT_SYMBOL(mas_alloc_cyclic);
> @@ -5606,18 +5607,22 @@ EXPORT_SYMBOL_GPL(mas_store);
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
> +	int ret;
>  
> -	mas_wr_store_setup(&wr_mas);
> -	trace_ma_write(__func__, mas, 0, entry);
>  retry:
> -	mas_wr_store_entry(&wr_mas);
> +	mas_wr_preallocate(&wr_mas, entry, gfp);
> +	WARN_ON_ONCE(mas->store_type == wr_invalid);
> +
>  	if (unlikely(mas_nomem(mas, gfp)))
>  		goto retry;

Nit: missing new line

> +	if (mas_is_err(mas))
> +		goto out;
>  
> -	if (unlikely(mas_is_err(mas)))
> -		return xa_err(mas->node);
> -
> -	return 0;
> +	mas_wr_store_entry(&wr_mas);
> +out:
> +	ret = xa_err(mas->node);

Looking at what xa_err() does, it would probably be wise to only assign
the ret to xa_err() on mas_is_err(), which you do elsewhere so I'm not
sure why this is special.

> +	mas_destroy(mas);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mas_store_gfp);
>  
> @@ -6365,6 +6370,7 @@ void *mas_erase(struct ma_state *mas)
>  	if (mas_nomem(mas, GFP_KERNEL))
>  		goto write_retry;
>  
> +	mas_destroy(mas);
>  	return entry;
>  }
>  EXPORT_SYMBOL_GPL(mas_erase);
> @@ -6379,10 +6385,8 @@ EXPORT_SYMBOL_GPL(mas_erase);
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>  	__must_hold(mas->tree->ma_lock)
>  {
> -	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
> -		mas_destroy(mas);
> +	if (likely(mas->node != MA_ERROR(-ENOMEM)))
>  		return false;
> -	}
>  
>  	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
>  		mtree_unlock(mas->tree);
> @@ -6460,6 +6464,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
>  {
>  	MA_STATE(mas, mt, index, last);
>  	MA_WR_STATE(wr_mas, &mas, entry);
> +	int ret = 0;
>  
>  	trace_ma_write(__func__, &mas, 0, entry);
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
> @@ -6475,10 +6480,12 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
>  		goto retry;
>  
>  	mtree_unlock(mt);
> +
>  	if (mas_is_err(&mas))
> -		return xa_err(mas.node);
> +		ret = xa_err(mas.node);
>  
> -	return 0;
> +	mas_destroy(&mas);
> +	return ret;
>  }
>  EXPORT_SYMBOL(mtree_store_range);
>  
> @@ -6514,6 +6521,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  		unsigned long last, void *entry, gfp_t gfp)
>  {
>  	MA_STATE(ms, mt, first, last);
> +	int ret = 0;
>  
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
>  		return -EINVAL;
> @@ -6529,9 +6537,10 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  
>  	mtree_unlock(mt);
>  	if (mas_is_err(&ms))
> -		return xa_err(ms.node);
> +		ret = xa_err(ms.node);
>  
> -	return 0;
> +	mas_destroy(&ms);
> +	return ret;
>  }
>  EXPORT_SYMBOL(mtree_insert_range);
>  
> @@ -6586,6 +6595,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>  
>  unlock:
>  	mtree_unlock(mt);
> +	mas_destroy(&mas);
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_range);
> @@ -6667,6 +6677,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>  
>  unlock:
>  	mtree_unlock(mt);
> +	mas_destroy(&mas);
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_rrange);
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index c57979de1576..c834e91e6810 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -119,7 +119,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
>  	mas_push_node(&mas, mn);
>  	mas_reset(&mas);
> -	mas_nomem(&mas, GFP_KERNEL); /* free */
> +	mas_destroy(&mas);
>  	mtree_unlock(mt);
>  
>  
> @@ -143,7 +143,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>  	mn->parent = ma_parent_ptr(mn);
>  	ma_free_rcu(mn);
>  	mas.status = ma_start;
> -	mas_nomem(&mas, GFP_KERNEL);
> +	mas_destroy(&mas);
>  	/* Allocate 3 nodes, will fail. */
>  	mas_node_count(&mas, 3);
>  	/* Drop the lock and allocate 3 nodes. */
> @@ -160,7 +160,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
>  	/* Free. */
>  	mas_reset(&mas);
> -	mas_nomem(&mas, GFP_KERNEL);
> +	mas_destroy(&mas);
>  
>  	/* Set allocation request to 1. */
>  	mas_set_alloc_req(&mas, 1);
> @@ -275,7 +275,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>  			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
>  		}
>  		mas_reset(&mas);
> -		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
> +		mas_destroy(&mas);

This was checking something with an MT_BUG_ON() that was dropped.  Can
we check it another way?

>  
>  	}
>  
> @@ -298,7 +298,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>  	}
>  	MT_BUG_ON(mt, mas_allocated(&mas) != total);
>  	mas_reset(&mas);
> -	mas_nomem(&mas, GFP_KERNEL); /* Free. */
> +	mas_destroy(&mas); /* Free. */
>  
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  	for (i = 1; i < 128; i++) {
> @@ -35846,6 +35846,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
>  	mas_store(&ms, &ms); /* insert 1 -> &ms */
>  	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
>  	mtree_unlock(mt);
> +	mas_destroy(&ms);
>  	mtree_destroy(mt);
>  }
>  
> -- 
> 2.45.1
> 

