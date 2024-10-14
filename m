Return-Path: <linux-kernel+bounces-363081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1A99BDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62812280C76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E025757;
	Mon, 14 Oct 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWBwuEQW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="STfBWDMA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D97F9DA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871964; cv=fail; b=jVfWOzEox+hrekhMazdvkq4H3DRHyICNdGS0LM0XYSw6KARP5fN09oxFVctwEJcAaWq6Gk5e3jO1CjxZodGHcUgegg8Ri0kKDupU0Vu86mj1z5si30uhniJaSKwHQqzXf6iktRLebaXEx4jbedTg3R1B4EvFzVf2dIuPsYhHV2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871964; c=relaxed/simple;
	bh=zwi0I5FkmfgJBn8yAgXvoPnUWQoEYEuwxsTvUz8ZqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qF6SyetAoTVYBnm+yMVQOCrZzsj8bZz4qfocmeoM+9Gnvo7kUSAMXqGUEJYFq4tQgdN+46a5DClFd6UNi1gpGoTAhwFIl8LAJ6jYmtoS+1g+NcF5A+MhwJDHRDgybvw8bs1JnBR4OUimbvjV4wDIIwsZpx7YSa7rTRiRagWp0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWBwuEQW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=STfBWDMA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E0cIfD024096;
	Mon, 14 Oct 2024 02:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3R9TbIasABN4TJZ65h
	8n4Yvo67WseLGMiqRSObdu4E4=; b=RWBwuEQWhz1M+FrXpSjvQWz8UL/iZSea8a
	u7nyjqmUD5/R7ex+yPenOM3QPu+gg1ThxmYOJSYKRlVdb0YZYru6JjuAroZwtR3n
	agqj64mDf4oTZNlNp3FgtmNYNpzRipKAeGXs6eLTLMw8fwyjEISkzUdwJQga80Xp
	Grf1hiVHv0wvO0vU6TI8bazbXThPX/tWaPPrD2SWctFfXD82nKwWEjOEcPiECcTM
	f3AyTQyvKXRmLbGtUsFTsRFl0oCaTC8NKutHtZPaWYFhezrNcfYj9OmebnOngwR7
	+xLph5Q6vLPlqDUBxa6cNguGsYOTg3NtwgTv3h8bZDI/YrMloQbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7dcup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 02:12:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E0IlGU026388;
	Mon, 14 Oct 2024 02:12:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj5her9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 02:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyATVx37phSSYgMhC3Gd21XKBHAN3dutm55v0WovXZJKVVIryviLx/odGXndu34Ipgxl9DQpivf3RHc9P8u0lc8k59SNMPHS/cGa64EUS9iysGF1YrIvB9UZxd0fhUjO7S0Y5FCKhmELEsk+Dp59DsinXRb/u4AhPqUc7MloRbFoIu1TS32qZYusFP9wzVa9Hv53rLFfqGD4VUWVyc+3wYOjA10OIzu7dpii9H0W86R+8D2A+en79fl0fJwDm0nKH5QuvtO/zSjTUscZdyR5/cRc/AA6aK/06/8Krf9JE/NK4NhPhycl4o3ON0Ns4UzPOBt+ZCibvab/sZpPTnWmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R9TbIasABN4TJZ65h8n4Yvo67WseLGMiqRSObdu4E4=;
 b=Vl5DzZhl4KtFNO6V0R79iQJKStP/QNVcTu5oce5u7CIaU7tQl6sSSP3p1QrKnaYcpd717i538Na/IsZwMR1lCUjqz4NrhSqvnyVmkrMc6sC+IG6e7gX4hBmw81pwy9zEmxvaz8n2NAIDnznVd+U6p9G2MnErA+Q3peuRZKNfdwvRxdomO4yyNkN/5PJfX+vep9FSwOkYoz+LKP2TpNeaJRN0R9ZuRRwvK4O0trxqzKwN4pvUI8WeDlZUOxehmeXIqTzYqzxbGxaFLeMI67N4SRliXMfFdEajoh6KUw0Xthp4YxgF2KjxG+YczJSNZxTrSSnq/wdtroxdqSWbWXcxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R9TbIasABN4TJZ65h8n4Yvo67WseLGMiqRSObdu4E4=;
 b=STfBWDMA1o16e7zzNzQihV9ARxd5ZzBxreLDTIIgESFPu1yVek6LlY1/0R1qY+IjGIeGOpE6PIuKaff3JdQsJ9RDxx/92qSnSvLq74HBuLvPWnu5cH3mvLSiegng34rIw+AZb/sKt6Rsz/AyL+ULP6a55sswqOkxQ5PgH8fPkS0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 02:12:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:12:21 +0000
Date: Sun, 13 Oct 2024 22:12:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] possible deadlock in vma_prepare
Message-ID: <mu3yintvkonpbac66mkxx3tqgwv2brbta5asmviysufeta6d5g@olfbdlegbp6w>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <670c0f2c.050a0220.3e960.0042.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670c0f2c.050a0220.3e960.0042.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0343.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 37578cf8-2f3e-4e6b-f9e7-08dcebf5a2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIrvppkdQz4dU+3UNyNQUZeQ3osiRq1la4Kw5ulV3rYxWBWaRVc30AFRaVFF?=
 =?us-ascii?Q?vRcO2rT65KYtmXFzSE5/ACEfL+W5fZ163yBULP7lbvCzjXvMM8XK5Owpyik+?=
 =?us-ascii?Q?n9ibAHs52eQbbovyT8PwyPX3KVz0REMKptX0RSDKOJlCNu1YgyvGEelZaxHg?=
 =?us-ascii?Q?ajHgjDNw40Sd5I4l+tjAgk5mwSMc4ROhmMKFWBKdJ6ob5lQvk5OBcLd6ir+W?=
 =?us-ascii?Q?L2K9r+irK2hWFszUar/UcFZjQJ+JmLrvm+QD1ph5X2kO4OY6avlYN7c164sa?=
 =?us-ascii?Q?94xSLOSgF06bKQfUxYFgjUT+L4K42OWw67qPV/yMCQQzdEVZCoNayN7Dn3+4?=
 =?us-ascii?Q?JpU1Xf9UtxQWe+rf3fg1yYYRPwR339FB3B2t4/+Anc/o4ePRrkk2eVhlpL9X?=
 =?us-ascii?Q?XQC7GI5KRiXMON3pmpOGHlg7SPqE8oLz/lkIzgKn03oQ5EzgWLIj63xn4cJZ?=
 =?us-ascii?Q?Cmv/0PQQ7u+ms1FQPP08g0bYV3oSokCdt5SKExX0wpOhXtU9Wn1Ruc9XvCA8?=
 =?us-ascii?Q?9XODzptoHM+V90cZpxPA14KDWz5Lt9VzTcvDI7LIIwGQGkuDCSjtNEU7X1YG?=
 =?us-ascii?Q?Jhvto7jy0BjotfFl5ZWZ086stcxZsTX17iuhsBZ2rfloR0vM6A7ryUMvYNmw?=
 =?us-ascii?Q?GBJB1uyJppSNN3fFow49uLIJgMV1FHrpl6OLzaJ+pt0TUOe0n8E7dByGpBpI?=
 =?us-ascii?Q?AmmdAr3PC8qxPn6gW1wkFJ91OtRoyCN7decvN5ihMKlIW+xx6yZ3F93HbWP1?=
 =?us-ascii?Q?7+oF4ekjXopaLr8++sQhsqHPMk1bTyKEyv0U7yJo66lL8lgdIssQKfCcgL36?=
 =?us-ascii?Q?mnIVweVarGbaaPBQF94kRWD4FHYUX4SORnVIFY77D0SPoFlEcGbl8h9w1P9S?=
 =?us-ascii?Q?jid1rsEqEbVCLnGpO7d5ttgVmWTdhctH5Lwk081fNoPJ7d0CIXvdcAhYLbEK?=
 =?us-ascii?Q?bQlN6Y6z3d6E0Mh31jr+BYiiCKE+TGICTXoToVYBrr6LJ2gSOe8/PEhbdAXw?=
 =?us-ascii?Q?eIoQB8Z1RUn4COuuGkrsZA+aIM5xkkWKH0FKbp50lF/tfjVbpCBnujKlDTju?=
 =?us-ascii?Q?hX7YzmSvJZYtan/NCz9/iGBuZaGhSti11moZFSUftjO63ktzKaHr5kr8w62X?=
 =?us-ascii?Q?D9tMIEFXqVlZGHlhTUth18o17xV9E364xD6/UDrfMkQu6yjIBCGWbauMsQwW?=
 =?us-ascii?Q?M9jI/rgYg5mS6dG7QeQFV4oY/v1aHkDd5Mld4j7Mts0OFbH+qqpbwqJoL/4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JiNzLBWK50lTiJbl7qZmM+XSHm6LBo6HaWCLjPKRlLX+wKC5JQdpPD4nTmcQ?=
 =?us-ascii?Q?YGd67W7jPLu9IBnzzW5lW0NcrdNAcjfGJWBCUFWxZ35lvK0brBtchLBuOpnF?=
 =?us-ascii?Q?5/BQcMj89p90dzTMbYL//t2go7dfW/jSWORwYXD5nX6i1XD+/TMIFRPaOzWD?=
 =?us-ascii?Q?BJRZMZ/GqpkDpt8nBpnf+S+IEzI70p6v0OYlGaC8POMFsj0bqHMcoY6tTeBn?=
 =?us-ascii?Q?W4fAIVzm8j5+5d0Ml7NjfCTDFlzqTHz78GXS3fWlkvQTT/34WMBx4SDvzuFG?=
 =?us-ascii?Q?kfiRD2xUbtV3FYNXsPtCJl3Jh71AfSsUfDnEOdwxHQ9SFj2PhR83Pv5yxSsk?=
 =?us-ascii?Q?VIw+j9jiL6L6BLF8nU5xXMfDx5cftv58YaqpBIMEsy/vEem44zFdduUrO7FB?=
 =?us-ascii?Q?WSGdT4f9NoO8aEX8+XZKg+ooN/MR1Q9peyGJbAEIKT2Dw/wORAtA/z4SfNVW?=
 =?us-ascii?Q?vz0vqbgTY3F+wu0pVtGlfcm1CAZUC5q5gPd+4jx34k1IFTea3+l0c+A5EBA0?=
 =?us-ascii?Q?8/EON091Bvfas2yffpT9xYoCKN83cze3emXy3dkPr0kj917d2DyhCn8sJj8E?=
 =?us-ascii?Q?gjnUgt6ywdrLn1RpOZv8kfvsD/koOoIMB1ZaxZTMyCYjXDwxBPV1F14W5qu/?=
 =?us-ascii?Q?Zoer+6aaokHLPdk5XGUyTPxoDz9PkLLDSRs5tPzZoBR+gsIN5bfxha+dG24i?=
 =?us-ascii?Q?vKwpYF18eguc71PiJWDNevP/+5yourFmdNnCR0Au4MG/TRyn7XF69UPuYvVS?=
 =?us-ascii?Q?zYiscOqUJ0llBj8MmDnLtQP8offqx9PJCbX7ate00iliv2L1f5jNoWMErwNq?=
 =?us-ascii?Q?fWeDRqVgkgXihiAJKe426Ihpr+XhXZMK2DgX2qXHzDntccVLRCfc1weK+553?=
 =?us-ascii?Q?AsyEA+pA+Io/NwxJjJQwl2NoYtLyh1YpWi6bR6eVI0gUGnrJBqI8yZKTphbT?=
 =?us-ascii?Q?+HyzoWAJEuIaRtK38ATdXbfxvbG/2z3eZQSGi9OnG1wUXOo6sxyQOOqrXrGr?=
 =?us-ascii?Q?jaIPm4dtcDrhbJrVkw1455bXCUry5NMdg2fIbxdYdeVakOGVKaRpP1+cED5F?=
 =?us-ascii?Q?4KE8M2g6FK8WckO/ZsX1j3PUzA5EHOuyYthGJp1qtVEAghU2QLzighxvz+t8?=
 =?us-ascii?Q?44criKOFRD1I40Tu4mjYJv0kbjWtya1BOSiwoBDkJgiHWWQNNmCObKT866+J?=
 =?us-ascii?Q?2xykJonaKWQEodbc7wTMFVTjJUUP47TKQwC305xjYEYmh98h1aTYZupCr8V8?=
 =?us-ascii?Q?G1DVMtMLH17NNDS6xPdfexrFForGYosIy/Tj7MDBNJr4nR6dpBk1En4SxeOG?=
 =?us-ascii?Q?gtK52EnKF+5OEiTBPFh1zVa+ZAXePvBc3MwIXcb0IFWlxV+Fv0f8uJVFhDJa?=
 =?us-ascii?Q?3So+Cem/BbPHc8LXClsErZY2fvAIJl5P8aNOBspDFAExMTKGh5get3ui3NlN?=
 =?us-ascii?Q?t+Jdc1AnqIxLWLAlOJfhGFYwgy1bmhX7FvaT1CyJgfboUrMPWtGparJyiOy/?=
 =?us-ascii?Q?sUKt2dEM21e7ZHHYOuapJAgSsLqyPGNjoFGo9fFJ9tk+sXn5vU88zqm+vJWx?=
 =?us-ascii?Q?Px9anLGIFiIdH2Z0CnTdH0SMbd5VIM4ccUEjZ1nQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XUMMLy5ay0DCKTK9SeZQCORXxVbxC3HtD5MZ399/ckaBVcKBCS3lYhlXBGJ7eI3kevc1L4fn80UX08cnE6pfQl0IKXC5ttQIJYqecvza5E4kkADE/JDo5gXv6mgQDITrC//zTJJfXxY8T2eWbeXxfCL2IGkbg49qoIuEtd1x1Y5Tzqy+VCCDzJnA0oHWuB1Mm4KBC9cBSY7BOVFbQFjU0yp2XqrKdTjNoZsYQeJrVVeBpe2lFqTkTRuuysrxb8M8qMGf1K8yNnEze17sPljDTbvjQ9r9Jfme8qbIr+3iuwM+zUHtwnCYQU9KAP5GC4/zdu33l+lhJiiPCx6WAFOPdVUciB1oi8o6CHylQ+mAGVvO3c8LmkzTyl0tIbzeifK4wwJwOkfggAduYa7R6y8vRtkkqK37qo3mszfJuIbSsmRfqW/bc6CPGkax1WJX1tbxydapJa0KX3LNEkWawgClGcSqOtW9JuSZ+R26gI66yy7zIyA5/D0VsV876QzinTAxMlfZaTXesCxa6VdJSEBtQbhsxzhzfnUoS5sS17wroTpr/amE1mYb3qv1k2RwZs2wPFtXvUENIeZ4Ah15rfk0op6mIM4IlTrJZVhBnYasTTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37578cf8-2f3e-4e6b-f9e7-08dcebf5a2a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:12:20.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRT9T/skmNjV9igvdFaASjLcGZuCiw9oOr3uWYsTNBOCQea1Vr6tAPNMie7CT5Dj/QMb3rcfSXvFyYaAFnO+4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140014
X-Proofpoint-ORIG-GUID: tVeItaMjoW5q88Ltrw3Xrrc9ELpy9vMo
X-Proofpoint-GUID: tVeItaMjoW5q88Ltrw3Xrrc9ELpy9vMo

* syzbot <syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com> [241013 14:19]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17670f07980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
> dashboard link: https://syzkaller.appspot.com/bug?extid=f25246115d09ea7e956b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/disk-33ce2423.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlinux-33ce2423.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/bzImage-33ce2423.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com
> 
> ima: No TPM chip found, activating TPM-bypass!
> Loading compiled-in module X.509 certificates
> Loaded X.509 cert 'Build time autogenerated kernel key: 5a5c91671060ad0cbe3fbddde7d37e27f262e8ee'
> ima: Allocated hash algorithm: sha256
> ima: No architecture policies found
> evm: Initialising EVM extended attributes:
> evm: security.selinux (disabled)
> evm: security.SMACK64 (disabled)
> evm: security.SMACK64EXEC (disabled)
> evm: security.SMACK64TRANSMUTE (disabled)
> evm: security.SMACK64MMAP (disabled)
> evm: security.apparmor
> evm: security.ima
> evm: security.capability
> evm: HMAC attrs: 0x1
> PM:   Magic number: 12:674:139
> video4linux video39: hash matches
> nfc nfc1: hash matches
> block ram4: hash matches
> acpi device:10: hash matches
> printk: legacy console [netcon0] enabled
> netconsole: network logging started
> gtp: GTP module loaded (pdp ctx size 128 bytes)
> rdma_rxe: loaded
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> clk: Disabling unused clocks
> ALSA device list:
>   #0: Dummy 1
>   #1: Loopback 1
>   #2: Virtual MIDI Card 1
> md: Waiting for all devices to be available before autodetect
> md: If you don't use raid, use raid=noautodetect
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> EXT4-fs (sda1): mounted filesystem b4773fba-1738-4da0-8a90-0fe043d0a496 ro with ordered data mode. Quota mode: none.
> VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
> devtmpfs: mounted
> Freeing unused kernel image (initmem) memory: 26724K
> Write protecting the kernel read-only data: 219136k
> Freeing unused kernel image (rodata/data gap) memory: 1100K
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> x86/mm: Checking user space page tables
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
> Run /sbin/init as init process
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc2-next-20241008-syzkaller #0 Not tainted
> ------------------------------------------------------
> init/1 is trying to acquire lock:
> ffff88802fece5c8 (&anon_vma->rwsem){++++}-{3:3}, at: anon_vma_lock_write include/linux/rmap.h:121 [inline]
> ffff88802fece5c8 (&anon_vma->rwsem){++++}-{3:3}, at: vma_prepare+0x26c/0x4c0 mm/vma.c:181
> 
> but task is already holding lock:
> ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:507 [inline]
> ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: vma_prepare+0x13e/0x4c0 mm/vma.c:167
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&mapping->i_mmap_rwsem){+.+.}-{3:3}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>        down_write+0x99/0x220 kernel/locking/rwsem.c:1577
>        i_mmap_lock_write include/linux/fs.h:507 [inline]
>        dma_resv_lockdep+0x4ec/0x8e0 drivers/dma-buf/dma-resv.c:794
>        do_one_initcall+0x248/0x880 init/main.c:1266
>        do_initcall_level+0x157/0x210 init/main.c:1328
>        do_initcalls+0x3f/0x80 init/main.c:1344
>        kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>        kernel_init+0x1d/0x2b0 init/main.c:1466
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>        __fs_reclaim_acquire mm/page_alloc.c:3870 [inline]
>        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3884
>        might_alloc include/linux/sched/mm.h:327 [inline]
>        prepare_alloc_pages+0x147/0x5d0 mm/page_alloc.c:4529
>        __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4758
>        alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>        pagetable_alloc_noprof include/linux/mm.h:2898 [inline]
>        pmd_alloc_one_noprof include/asm-generic/pgalloc.h:138 [inline]
>        __pmd_alloc+0x91/0x620 mm/memory.c:6342
>        pmd_alloc include/linux/mm.h:2861 [inline]
>        alloc_new_pmd mm/mremap.c:96 [inline]
>        move_page_tables+0x1c37/0x1f80 mm/mremap.c:610
>        relocate_vma_down+0x3ff/0x630 mm/mmap.c:2308
>        setup_arg_pages+0x668/0xc10 fs/exec.c:810
>        load_elf_binary+0xb7d/0x2710 fs/binfmt_elf.c:1014
>        search_binary_handler fs/exec.c:1752 [inline]
>        exec_binprm fs/exec.c:1794 [inline]
>        bprm_execve+0xaf8/0x1770 fs/exec.c:1845
>        kernel_execve+0x931/0xa50 fs/exec.c:2012
>        try_to_run_init_process init/main.c:1394 [inline]
>        kernel_init+0xed/0x2b0 init/main.c:1522
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #0 (&anon_vma->rwsem){++++}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>        down_write+0x99/0x220 kernel/locking/rwsem.c:1577
>        anon_vma_lock_write include/linux/rmap.h:121 [inline]
>        vma_prepare+0x26c/0x4c0 mm/vma.c:181
>        __split_vma+0x9b7/0xc50 mm/vma.c:419
>        split_vma mm/vma.c:460 [inline]
>        vma_modify+0x153a/0x1a80 mm/vma.c:1433
>        vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
>        mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
>        do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
>        __do_sys_mprotect mm/mprotect.c:859 [inline]
>        __se_sys_mprotect mm/mprotect.c:856 [inline]
>        __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &anon_vma->rwsem --> fs_reclaim --> &mapping->i_mmap_rwsem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&mapping->i_mmap_rwsem);
>                                lock(fs_reclaim);
>                                lock(&mapping->i_mmap_rwsem);
>   lock(&anon_vma->rwsem);
> 
>  *** DEADLOCK ***

Interesting, fs_reclaim was giving me issues with the ordering of locks
in my other work for vma locks & i_mmap_rwsem and the mmap fixed
changes.

> 
> 2 locks held by init/1:
>  #0: ffff88802e138198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
>  #0: ffff88802e138198 (&mm->mmap_lock){++++}-{3:3}, at: do_mprotect_pkey+0x21b/0xd80 mm/mprotect.c:740
>  #1: ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:507 [inline]
>  #1: ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: vma_prepare+0x13e/0x4c0 mm/vma.c:167
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>  down_write+0x99/0x220 kernel/locking/rwsem.c:1577
>  anon_vma_lock_write include/linux/rmap.h:121 [inline]
>  vma_prepare+0x26c/0x4c0 mm/vma.c:181
>  __split_vma+0x9b7/0xc50 mm/vma.c:419
>  split_vma mm/vma.c:460 [inline]
>  vma_modify+0x153a/0x1a80 mm/vma.c:1433
>  vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
>  mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
>  do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
>  __do_sys_mprotect mm/mprotect.c:859 [inline]
>  __se_sys_mprotect mm/mprotect.c:856 [inline]
>  __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7347f7dbb7
> Code: 00 00 00 b8 0b 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d b9 46 01 00 f7 d8 89 01 48 83 c8 ff c3 b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 99 46 01 00 f7 d8 89 01 48 83
> RSP: 002b:00007ffde248d688 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
> RAX: ffffffffffffffda RBX: 00007f7347f5a5c0 RCX: 00007f7347f7dbb7
> RDX: 0000000000000001 RSI: 0000000000004000 RDI: 00007f7347e84000
> RBP: 00007ffde248d7a0 R08: 00007ffde2480000 R09: 00007f7347f91ab0
> R10: 00007f7347ceaab8 R11: 0000000000000206 R12: 00007f7347f5a5c0
> R13: 00007f7347f85eda R14: 00007f7347e87bf8 R15: 00007f7347e87b70
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

