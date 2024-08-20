Return-Path: <linux-kernel+bounces-294711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F8959181
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39905B23E58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEC1D1F4C;
	Tue, 20 Aug 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iKKYPDuV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LmA1o+xd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E91D173F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198318; cv=fail; b=q5xariB03rxmZa1fWJt5xwAj/L9vD4DO1QDbkRMRcr+tABLSX2p3T6vniBCY7931iKHnBR9NY3N9MIMpREhk0NMnoLnrIuuUpGaSI03lcK7spdu9EW55p3H6L3JuxincYgMIZcDlrRiLjxrXuavos7WP7kt0kl6p1hB7m/N+o4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198318; c=relaxed/simple;
	bh=wsvsiR+akTTmnRCa586U/yaZ8vGhp0Ze4uez5eq/q/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuBOhKJACJCL0Eiry5IcWhaFiaDVFqX0pMNXBlhIJcjkjFACBvkTuzMwbhzjBg0yLbPIKmKB3hqdNKvqQFQnJ2+WMjK4GD1UWkS8STOY7wI08weLN2C8c2vyKUyD5iuMbfKUlAsK6hKlZOw2pphrIAXCCTNSIzOf9kS3A2+7EvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iKKYPDuV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LmA1o+xd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBa8x017785;
	Tue, 20 Aug 2024 23:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mYzjgcT0Ns/K/MAg9MEWqBBmmk3U8iiO2h1IDlSxUIc=; b=
	iKKYPDuVUh/iY5ThywtPK9elkPNQ7oyKpg2ni8+6i0uvR4g8YD6hPg2bfSTO5Cop
	EeXgNMu3U4/U36AjlEfUkyo8OZDESOa7QgaIrzKaS7mSLOqCP/3ubQL+d6pzpafH
	yjYH8GCLcOXMN++gFsTQEOJCC0FAuOQ0xT00ej0WJALbRSggr3TxtcysbMXbzycc
	WxeTr9/q1iS9gbd+zldVW/qfgJiIlfKQTn//j5tTvO8a2fjPe4OMlwHN12flq42b
	hCF7cvjeKdco0flqQNDuAsjC2klD3FiZXw6lfYCYXn3zFp1qS3HnZa2VcqoualFq
	i8ASFdJrW71OiR8b7YiNUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsxagv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY1IL023382;
	Tue, 20 Aug 2024 23:58:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78g2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9oFZESBAcTYwvBCqdW/klrXpPA46IM5jSm6LdtIFVOGTAGX7FBJFksbbdXTrUBbsJOFhoZjxSAML9S3uHLQ3GECv8QYGE42NDNLJD31bY7lDNvhFRkthZJVtshPtWJuYeRPYqEmbhIZ1OZZc9orNjybEHFtgrKdClQPv+hMrGkfGN9yhFJkjt9JgS+6FGXOKgVTfkbAhFyZbNia978uGvWxDnJtWykWcBwe6OTASxDpMa2vEjwX7ELEZNfMUg2Y4KtNxHoUOSzaPiP1KeNQ1kk1nQSHP8egUeLNTvyVwB3K9tYHeI7QmGueZrC93tUxlcX/VXSPbuP5VVjqIaXI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYzjgcT0Ns/K/MAg9MEWqBBmmk3U8iiO2h1IDlSxUIc=;
 b=AbPLGEi7Sp3ha9QiBJ/SX3vIVhq1pwrS6y1z/dD2ER3/GM1ci9y3zxg6QgID6IDtaA/VfJyYjZY2F3B+HLSrAL4BztfckuK/IX1j+dSxoRE1Vf6BROmrq6AM3CNeMLEXlNdyUSaJ4XKjD3SLMR04x3AmpXW2igJP3TVmRbDvrd/OTzm11ePGVWVfR1sEKbRXvXSjIuVUInh3QBzydAF5Fz5y/sJ3fyRn6lqg+9Cu0h63vhQwrGfH42xr0ZvQsRGRqgcOxUpTXTUW49hqLR/g0hQjkZFoU+xibXP+aAmob9OyWu55a1W2XO4yC+iCB+2CTnWid/lFehqqc/vzMwgBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYzjgcT0Ns/K/MAg9MEWqBBmmk3U8iiO2h1IDlSxUIc=;
 b=LmA1o+xdRRBQSOapHA91momzxQgrJLUZtN5a0VaSc9OfBrs9MB9XcIX4ldyZKBmvMJaKIic0C9A4kyPbVot3i71/GECykuhyVMOOLyLJno+526hYgUjoLWeBb+dJgt+X9JBSzrpDMRZMH9Z8koJwLAhQNfy6+jUIhZsxCEegdCU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:13 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:13 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 14/20] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Tue, 20 Aug 2024 19:57:23 -0400
Message-ID: <20240820235730.2852400-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: b38d223f-c1c6-4ae6-184a-08dcc173f397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itD2Fxz7dhWw0R7hN6ixg6zot71s570PBZ8upV329AeIhHSMmRM5uCkB+rLJ?=
 =?us-ascii?Q?w6xiIIx0WgxXTA/lFiiBT6sZutnvVigvvPP/veGlHNJ+28vgNJEAGU2vEZgY?=
 =?us-ascii?Q?tV9uP1EQL1KuaWDR2v8qQ3QroIWkFG33xLugzIuNN8sS8QxdC9R0evlF1uvA?=
 =?us-ascii?Q?EC8OlZA6yf4R1LFaIVjzEeXSOd+yxvEIAyO/45/41ohOM7Wbt3hwr9PcfIJz?=
 =?us-ascii?Q?+ilbX7s706SkZ89WreiuqUFY5w+QnQeOdgiio4xKq45QUsbmZxYjFq9OYY20?=
 =?us-ascii?Q?9AvKfldf9OUotZMo4HSMLyzs6gkpUz+UwUCOpoEk6Y9KZmCUMepNBrkTX5mN?=
 =?us-ascii?Q?ZPfoG1G17fJsnbi9x50Mwe2lMPPU3Px78R3JvnraGJOWHykl1L7ykzEaKded?=
 =?us-ascii?Q?g03m7KKOyGkuNyR8bLqrpGIwIjjc26oFHZd0Od+1m/0MbQF15HUID58OFhU8?=
 =?us-ascii?Q?OfCQngBVvVcyHu6oHAhU4FPB3HIuRFukEwWFi9GaPz7NlGFCDEUY34AVCNwO?=
 =?us-ascii?Q?1lBK6j2jZoo/GLffiGb/ipGazDN3jRCAZ3afERJQ6Nidj24D8uJyXvRLjicl?=
 =?us-ascii?Q?dQvapaUtMaeo0UTyhMJRACeIawWhvo8QmocXzDiqH3qN2bhiwyuOeOcdK5QH?=
 =?us-ascii?Q?bFBgGqgwwr+CsSji8EzVQzI+FNtD7lK3Q0jJgEQJWQSuqW8FDxakUgVNV+PU?=
 =?us-ascii?Q?201P1rHWo1mC1qHTvc5jKf0Xc49L2mdtCYXcgC909MEh5Ma+tgnAr4w8MB8n?=
 =?us-ascii?Q?y04H9n7ItSKY7qJHrhPUwomSDG/Kct6a4w+TbJCrDyDaXupEVAt37bk98HOG?=
 =?us-ascii?Q?QQlyxwBmfLV+WKn+N3ZeH270tvpiIEU5T6ldZnUCsTyBTDabmfg8rwBxnj4F?=
 =?us-ascii?Q?JKSqvP7dcIP8YvwAXdIKs2hJmMvX/i5EU/ib385dftHbpDFo1aH+88+46P5x?=
 =?us-ascii?Q?SmWGU94tarZP7NCO8YgZqzizfnAPkrHrknQSb/hmNcRvWF2Oi8FFqkYSWC2A?=
 =?us-ascii?Q?gGuMglHIYOfoJ4m3Bq3ybVgms3hDFdDxhMPfTz5FJyJl5zAkncoG2ATFj+Y6?=
 =?us-ascii?Q?zstmlzm2GB+M0dHGkEVkUwwoSKgDWDtrscBIMSu0IK0xxlN80rhBkXztDxak?=
 =?us-ascii?Q?2Ly4gc2xs9l2rLDl/1B1NtRBgTNYWFEer9ovjTubkZT6W9DMjLP5MYRxj+MF?=
 =?us-ascii?Q?chNXavOLyjE2+Wy2f421/BzHVQu8nMgdZVg2DUPOarFohjtI4WodXgWY3uOL?=
 =?us-ascii?Q?aCfjEtBGO7v61akJLMXvEaUJeALmm8kK+qniYttH5dIxnVvPavOxoD9Cj6kA?=
 =?us-ascii?Q?R5hbeHR2nJ3eLaAkpC+FuuAvsgdqMzRejlmVhefIozeSsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PPDcHmKgNVZFyYNzLTKquB+82ZQll0PHa0P1hwvNz61t7WlT7nybh46SJSo?=
 =?us-ascii?Q?KJW/hUU+AWFv6Nn+YZSmg75bs/yEJCkZph2eBZEy4G7StILAoQUyETp7dM+Z?=
 =?us-ascii?Q?aZEe2J3m0mVGeF+EfG7f02n4BkABm7q6nXnkJS5+O6fxjWr9yrFM0zssp4Kj?=
 =?us-ascii?Q?IwgVNWGoe/g9KQWmHWhOLO4yZ8kRvn/j1bSK4YPjBM82pM5TCV7wUzMJXfWS?=
 =?us-ascii?Q?9fGxC3tdf2ouYd5sZC16q8LpjgEC4OOZH09KlR36n1iPIICWOa0pCzWUrzT9?=
 =?us-ascii?Q?EjLb26UwkgBAgF6JXQ3qVEKIb2mE5gGWg2hpdlMBnrsHdHRrR3+4/gdlEwTN?=
 =?us-ascii?Q?xlOQdBo64S9Q6x7Hw/EZt3VEFtrjJxO5aAVuvkznz7UVo7G8TxKdYxhNoK/6?=
 =?us-ascii?Q?EcE7ExNWYgGN9ahkjJa2DvOl2ocgjbAxAKT2G5NfCI41Gave3Ch2+UosGp5q?=
 =?us-ascii?Q?z3VXvEGqMX2NUF6Udnl0fb2HNlSHt6gI+aZkPJMZZqMpbuGfBV/bgmANNV4P?=
 =?us-ascii?Q?x5OA2Nj4ltzJ7lD91Ew2rhLR1Lx+RgF0+ugyYcOMjDQupB6wTBLCRCTWEPYM?=
 =?us-ascii?Q?sY3Rr/AfyMsGeTDtVqqE1tjrU4Thvd2BPCFuWrvGPodfWwoaHaxO2HMq65l7?=
 =?us-ascii?Q?FbgCqc7ASD9CcOhHYZc7zl07b7ZEXQ2tZl3JEiAxmqZmDXI1hg19Vt1hw0tF?=
 =?us-ascii?Q?W6a77TuK/mUaAykWHNX+djPq533JsWcuQ5ulQSFBgoj8D1rYFO5kkEkdA5jY?=
 =?us-ascii?Q?7Fu9sRJ21N8eKRl81yIrcsCYJMXgqytaK6EU19VKD57Z7VFRybh5b3kllD/g?=
 =?us-ascii?Q?gr2WJm+5ccDzZbRdj2T5zLxqEiRyY6wr9vPE9bslO/8BeluvM/SnAdGIja5M?=
 =?us-ascii?Q?Ez1RI6hsk9YrxxMlq41yJrBvgaMJeHybNsgC5c/nnxd7V6AMw2myxXuqj+U1?=
 =?us-ascii?Q?D+D8HIyC08QJYPUl1PXeg4lftxvr9FEwFxITfwfbUrJe039zNmCmbjeWyxh2?=
 =?us-ascii?Q?/PImyI6LY2+u0Nu7fOtgK9/wFq9DsoOpEasjLQD9ar/rX50CMlOlXpGoJ/pj?=
 =?us-ascii?Q?HnnGRloDSDPrPJzV0pKJ90Ahv8Iu75g3dpzVWyXO5RzbCuLTlyM3D+vluVyS?=
 =?us-ascii?Q?JII1A+CBVOrvkDKKYBO1DZog7S3wUK/Shbt0ULqeHr88eBbKXDPI7AXkcOAw?=
 =?us-ascii?Q?hdSvx3LTekLQReCg0S8Uqon4R3320pSXGjHXjbnRq4qa7zJboMTiec9sG8Wk?=
 =?us-ascii?Q?aaRN3nSBQYU/CLECqRtbJJE0jpEtHoX1oMLo/Nm0iZdkqZ2B9uWgDUl/1jIS?=
 =?us-ascii?Q?84zfzV52uhWg3aEC+Kh6g1xZJpMtHVlfwCaki3b1wZMdv7pj21fQk48ISJNC?=
 =?us-ascii?Q?/UjU1VnDJUBN3q4Jxs9bOm6fhUyCfavvBXse/8Zo4xp7icROA1+LakATBsYR?=
 =?us-ascii?Q?KVwEHYbeHT1kGM4trLPVwTOzcPNorBeB90TujfJCNlODpuct+2xXroC8/D0O?=
 =?us-ascii?Q?OALz4soPUceaSDp5Bs+FuaHeTFj7ZVWZTH9X51Cc7n3zd9TDdoQP/trDGqj6?=
 =?us-ascii?Q?s4KQuTv4PLcK4fb8h3Un8MKNeEBiKYM/4KpaCb3oAaAq+zVtNK4diwgPYzMT?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TEPx/nrij0zhHYSrJyu3IGt/Jl8JJqvl1H55MYRd5ENcaFGSU8e9b1cKm4pz2TZw/FsC3Rh3OUBZ4JpXk5wUXgoGKZ5kHY8IKMI3qqBCAJx4N+TgSJj+X/DPBS3HTljkT+DottlTwtMaBCuHKUhirKhvVltTr+vNAXBzELJcG3crLGyYOrR28QQzTfUwnIT99oZigEVep9HamekjbKDCJNOg6QTLxLJKFIXx3GVqMLW0BS7y7x+Dp/8kZ3BOi1BmRKlRkFZbXV9QpKYPtbt0JHf337OmkhvEkasbEsttaIT7luiNwCsgpcM/K+rQWK11i9ukeISH2mzKEuYv2IU5wjWo1numy41lZsEM7aNyBrljlJXw3r+8ez1B/EoHNdbb9DqpCBMokc6BFQreydjXTlX6Eex4qFxA2DVidm1XL5GHmqzyf39cLb4ozxWPiMUmzejb6YHLlX6Rs6sVnLEbXx1UKqimzZ/62iQHQxl/omMKeodCf3JjAj/ShxpXwTWdRoqkmsb1xqA396E2/trbbTbBK5j9d0girQZ8pPOgSVW3SOKnRbqLDJc3sELu/bu/YJlMlfjtB3w8Iy2K1ZXTYGFXh7l+YI1QPv0GsELAZhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d223f-c1c6-4ae6-184a-08dcc173f397
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:13.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bWYXsm/64qDvXDyjwyHso2qS8Sr7AOqu31lRV1Yx0Ynk+ge4rJ6GWo3VL7tDraGanp3RLULN943Nx5ZPSVVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: 3nXwtLY0qE24pLf4hlDMjb2XR-FAZO3m
X-Proofpoint-GUID: 3nXwtLY0qE24pLf4hlDMjb2XR-FAZO3m

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

To ensure locking is downgraded correctly, the mm is set regardless of
MAP_FIXED or not (NULL vma).

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  This is done using the vms_clean_up_area()
helper.  If there is a close vm_ops, that must also be called to ensure
any cleanup is done before mapping over the area.  This also means that
calling open has been added to the abort of an unmap operation, for now.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 62 ++++++++++++++++++++++++++-----------------------------
 mm/vma.c  | 54 +++++++++++++++++++++++++++++++++++++-----------
 mm/vma.h  | 22 ++++++++++++++------
 3 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 71b2bad717b6..6550d9470d3a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1400,14 +1396,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			goto gather_failed;
-
-		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			goto clear_tree_failed;
+			return -ENOMEM;
 
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
@@ -1423,8 +1413,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -1473,10 +1465,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1485,6 +1475,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/*
+		 * call_mmap() may map PTE, so ensure there are no existing PTEs
+		 * call the vm_ops close function if one exists.
+		 */
+		vms_clean_up_area(&vms, &mas_detach, true);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1575,6 +1570,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -1603,7 +1601,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
+	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 
 	if (file || vma->vm_file) {
@@ -1622,14 +1620,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
 
-clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
 	validate_mm(mm);
-	return -ENOMEM;
+	return error;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
@@ -1959,7 +1955,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 7104c2c080bb..5b33f7460ab7 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable)
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (!closed && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
@@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
 
+	if (!vms->clear_ptes) /* Nothing to do */
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, vms->mm);
 	update_hiwater_rss(vms->mm);
-	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+
 	mas_set(mas_detach, 1);
 	/* start and end may be different if there is no prev or next vma. */
-	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes = false;
+}
+
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+	vms->closed_vm_ops = true;
 }
 
 /*
@@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -697,7 +722,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -849,13 +874,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);
 
+	vms->clear_ptes = true;
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed = */ false);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -900,7 +926,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
+	abort_munmap_vmas(&mas_detach, /* closed = */ false);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1618,17 +1644,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 }
 
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
diff --git a/mm/vma.h b/mm/vma.h
index 6028fdf79257..756dd42a6ec4 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -48,6 +48,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 };
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -95,14 +97,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
+	vms->mm = current->mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
-		vms->mm = vma->vm_mm;
 		vms->start = start;
 		vms->end = end;
 	} else {
-		vms->mm = NULL;
 		vms->start = vms->end = 0;
 	}
 	vms->unlock = unlock;
@@ -112,6 +113,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+	vms->closed_vm_ops = false;
 }
 
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
@@ -120,18 +123,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked);
+
 /*
  * abort_munmap_vmas - Undo any munmap work and free resources
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
 		vma_mark_detached(vma, false);
+		if (closed && vma->vm_ops && vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+	}
 
 	__mt_destroy(mas_detach->tree);
 }
@@ -145,7 +154,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);
 
-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
@@ -259,7 +268,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end);
+				    unsigned long addr, unsigned long end,
+				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


