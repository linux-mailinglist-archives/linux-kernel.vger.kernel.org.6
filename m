Return-Path: <linux-kernel+bounces-392928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF239B99BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B100C1F229CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B01E2605;
	Fri,  1 Nov 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZapVCLfz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xJ4RBHzz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF8168DA;
	Fri,  1 Nov 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494751; cv=fail; b=Fm7DWJOfzhIlQCNan90ki2E3JqA9NMd3n0bYC/eO7X3HhHNwZ68liIoA6PmFER3YDgcQ0TrR/4tUXMLOMojcEhMoV5PeUdSwhLby8Q9E53QUp06xuOiMDxP0Lu6jR7F/sszY28dJtAk+VezkGCV5sQU+ue9WhDzys1EbWruBjFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494751; c=relaxed/simple;
	bh=TySGK6FUXazM1sGGWsWLtl2EY+czgB/uzaFbtW6eLiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8MEkSItVH1WANtRIDHcLkxKZMTNs7y3gZkyw5/w/t6K9B8LRggSGbNz1gncOy/b9CNiLHvzspRct+q4TM+4AGKruEcKxxiE3NZpSXcYbpIIjs2CdG3os1ftNhCTddQHUoO2T8RnbsvhjtmMyikRWprW4it9ivVIeWw7ROk2iWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZapVCLfz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xJ4RBHzz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBXxd019234;
	Fri, 1 Nov 2024 20:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mqpMKwrCa75LYfNIPu
	r5a0Yc+osNPLDwqK0fA9BeHfk=; b=ZapVCLfzBb7ufAb/RBBrjhNqtm41mdUToR
	yMM8RUBLo0S+7bHXiOrYs1dYAS5j+7y17W6tG96YYt1RRwMH52C2PHkIHdn2rv5j
	0oHTYkBksIQgy2koug3/xb8mXOK7AHhSxKfhGDjKPsf5r9V1OLNMPl5O348/PSbR
	v5SlGrpHhWnzKGdqW/2AeUTyihvlfQ2ZXdiPeK3BB40dxYjGvp1Mcx075fDZkgFH
	WINXhCj2V+pqhpKArY5vnCgmfddtP0+hF3F7a0tYuZZGGOJ2o4fo1flJg5+TVNvE
	1OIXzO7jHeeqDwHWor1gLur7j9MNKOCPrvnZeRExNwJPGCcNlvyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpd39g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:58:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1K0ovS011868;
	Fri, 1 Nov 2024 20:58:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnah0tpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKwU/Cq0KzxUO3RSpO+LUNF4eTXGvgdYNxYHXzEjMdne5Wd+XMNHk3XT2NseWTNvmeSWWIuagh9PGbCAfIklF/vlCmH/I7vnd4/xPxq1D/F01o1UqFMDPsvfY4l5rh8CE0jvEyPpjv4T4ysAdsWb2c4gRGUnijGNdM2bVAspuhWDCh4abCOe8WLwM140SKbot7fS3qnUXiyIh/0e/fJPt5Et0AGimrXZA69f2tBkzV+lNMCR6Jd0aXAucZelkg/ZmaJSPv9RfUrMoMsPIk3PMyhHbNP9fhonqFFkCjkugGVgj4+JEg6YRqPH05cosw1UOvvahcKGXoSVr6TykuT5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqpMKwrCa75LYfNIPur5a0Yc+osNPLDwqK0fA9BeHfk=;
 b=YOdBKoZ2qTNjAQvcqxKAv0Km9PdbxzGzDVYOrVfvHMBrZ6lzfig8X8zUKCrADTBTwITv6JV/k4XmrKYH4QgchZliHQCW4G94/JEqGeExdrxAfcohQqNBWKZA5jX7EApuTXOuh8QPINC+vUb+oru/J8JBFEXp/EVUuCqzi/aRozNBgwAjb2+XIYAfQy27HID9itZtOW6DtFnHqMWsqrtTvG4r5zizYGXnOU5Al6omID6GdvhXVjknuBjfJAzJj/2jwAsDytGxwNmSmud2e0yQyVXsZFEeMWCWLVMwA81vsJyfrZvhFhk4T076LWMm0XwxQTfL7SHrJqasqX/tdN/OuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqpMKwrCa75LYfNIPur5a0Yc+osNPLDwqK0fA9BeHfk=;
 b=xJ4RBHzzjKcm8NHax62iGuyxoKU5lHalPP4dPSuZJGFtsNV81eps+5KQGoJsBggSAVxu3WZjN85WMvVoQw/4cuKy5C7+YPThqvT7OiPUx/YkEwxWfUTgBl3Dfq1vaNrF/UZjpBkh24rUjCcNynx32TMmIzfmoWS61kPV53eXbT4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22; Fri, 1 Nov
 2024 20:58:45 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 20:58:45 +0000
Date: Fri, 1 Nov 2024 20:58:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <8e02f3a4-d498-401d-aaba-e53ed2ac6a3a@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0332.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7b30d4-e8c1-48e5-8186-08dcfab7f93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rn1nGsV7QJRzTT9cJ2N1Lparn6zKYyFXS3th1j1HbZj4IVE+e8Q2lp6N2TRm?=
 =?us-ascii?Q?5KoSrVP7u0gavUhLFb78N0tFgSxQeSZKmCl6MSyZL43opwMd/IYZ1HWnTCZd?=
 =?us-ascii?Q?3WDXdsfihcGT/8R59bdq/8cr+fnzprpcRR2Z1Yg7VuETFjYCNyvU8uB6bgGd?=
 =?us-ascii?Q?RZHhuyolh0jOtpJt9PKJtqi0K3Rd1gymctEWnFUthaowci+v5w6mW3ugSZ17?=
 =?us-ascii?Q?QiBcUMPX0xI+2R/MbXtC2pR4z6xD40x6cF7t931nEzKF35mUwSfFjbVpH7B/?=
 =?us-ascii?Q?EkaHAZOY0rzrwW5ziNsfdYl/2vGYXkwyIaaU56NoRZBeg0f/7TRcOGxsEiCT?=
 =?us-ascii?Q?jk14YpA/u16NF4fvDH2NGHtetowD+r6An9NknIKm6UUP+/jBQKqKNd726Poo?=
 =?us-ascii?Q?9bSPpj6nUJUIxxGNaOJ0bBZid6GWgpsypYpPPaRJJ9cOLZA1AFPKtJe5XpkY?=
 =?us-ascii?Q?Y1UaVsJKmyWsE6s0n/VqtDSSmVbb94PpAcP9IrhVk2XFDpaFWI023GDpReAF?=
 =?us-ascii?Q?hnnZatmimIbAOrKy4f57ARDiV8xLV+M8DTlz+Oq818mu/fQrJfXYjSlRwQLm?=
 =?us-ascii?Q?BobPdiDAmxGd0uNdSeXWkIbtziax/omrp+FDg5Xj0IRhFS3rf8JHyCptKQNA?=
 =?us-ascii?Q?PLp2s9Fl36JW2n/60TLA7pFUnH60hBG+XO9hUOyXOWJVSbFX2+sYy3XCnApx?=
 =?us-ascii?Q?VboP5NDemcFWYeT6FDWs9l80mufGY2u5GNykFGVjLSw6ntBzVbNb1dg1+ruC?=
 =?us-ascii?Q?YfiVYM8hbIIjdddas7iVI41FCILAw6o5wjt7AiAoQyIhXFOoxGFsYE7HrJom?=
 =?us-ascii?Q?eWPde4Em5WAIJmus17bkrY/9UZyP8B/lbAB/gUVMwPslVSihuQGxTbsibSgo?=
 =?us-ascii?Q?OhAHurs+MsSJL8QVvmpTNZDgkSUPclkNr9BcpvwJqqct+7s2YpABgjDPfbbg?=
 =?us-ascii?Q?01nt1cmnhVWMTGugUUshnI0dP1VHulR/+/T4/Fdd8qic8Ny1M5yIsUmx4Axa?=
 =?us-ascii?Q?ow4gma7xO81WLN6znXX7uL1p6AAX+PKKPGfBp+T2IlnryR3xIR/9Ksgg4YfZ?=
 =?us-ascii?Q?ABtdFUey7bV0knst3Pof4sy91PSOtDHKbFuW9+Nd0zbsMvNFMAhbbKytr05p?=
 =?us-ascii?Q?nkwxvJHHQgZaVlVL/U9LnsXhWEYH75xw+bQjNB9M7mdgqF/v8kWeaRDc9t7D?=
 =?us-ascii?Q?1hxFJB9+9dSMdxK+BWdf9RsnpDsF0ztMfk0oVbb9rhOMnxxOZU3Tnw6c1OSZ?=
 =?us-ascii?Q?oy7LPEHldCcXOhyfBCH3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrL3IdZ3IgWsfq7daBeAgl2/VozSdbWzzCyRkOUCOl9vd8n85f7hbX/ZOdbD?=
 =?us-ascii?Q?l/HvEHlaoxj91f20Suse1zXxe3/6QMZBatHhy2AZthyjJ7XdoejTn9RAfB40?=
 =?us-ascii?Q?7k1vsUwTolwYyV6wlDcIkaQGDcgm4KQz5wJcePr8hSlx4Pay3/5IYvo0ssTb?=
 =?us-ascii?Q?aGiXlOhXoHxuSNGq/1c28DB6d7tFCwV6KJyU3qBim8daM1r9z1UMq2xBclGa?=
 =?us-ascii?Q?nVqIGP1z3ypdoa8p801k+U6e2+22zlA6CJUK/9p8koyKek2XEy4fHQ9+ruN9?=
 =?us-ascii?Q?gC7SxDrKEBp2Ap9OX70IqwUP1q4sW66WXm7NFEukOtK1s1m6v/EFU2IoSb32?=
 =?us-ascii?Q?HPp19bl+IfIhAiQpp0CyIroTU9q9Bkh13at8uD4A3qhTkQ9eXMwLdG0ZOJ4T?=
 =?us-ascii?Q?MFKhZtKhWVouEB1GF6QpsitK2qg8PyV2PL4joG1CU1nB8rkTK72V9/hCBAVV?=
 =?us-ascii?Q?semTl1tfhrSGraDbDLJD8y8ii3+dMUEaDuMa81g4a7K4sMnwY/tXuaXbf3l1?=
 =?us-ascii?Q?39JazTItjA/zqiF5dJxhN4FHDiJyXaGl0ZEaPxUS2MMT75cBmGwSTKc6dafM?=
 =?us-ascii?Q?rwFsN4N7TeNYH9PwRaATO90cmzCJivf2LpB1LtNt4212S3mRmfe3tFT7BJXJ?=
 =?us-ascii?Q?q4NkCytp+jX2IANrAkBRJMA3eWaYWcwtvfIBljdbMp8/wbYOruESTCo8G4q3?=
 =?us-ascii?Q?iql59YSgo2f5g5Ilr6YfPMwjOW8T1sZIKdzFCMev89OquulvhA4rh7761JzP?=
 =?us-ascii?Q?QVgYzcd4YSzpRWMnKWMH7G5rHa02mcBzrll2rtBhcb9i0melWRnZvGmu1yZU?=
 =?us-ascii?Q?EtWfmr7i+IZtd4I3Yt/7T8Y6ZhEAaQLchmjkWjpeRq4piVUiZisI2BdO+7kY?=
 =?us-ascii?Q?d7Umr/IAjg0ZZcu/2ATGVod/RoRIHidDEvZ6lxauKzcQffB6mmpz0Zl2e+zc?=
 =?us-ascii?Q?D0S/s4T0MwP3EKXu0GfMQ5Y0qGq0qg8+KS0i/d1CNZ8N7V8t/04Gi+B5BV0m?=
 =?us-ascii?Q?nI0WYIP46xyEYtob19+27ZVG78O/6S1pKMwwFLlJu6X81o2KcGcpng4i3qr2?=
 =?us-ascii?Q?GFsWQTCxqKHVaIVSD0GIWc7lg3sN74dYKvM1HX+9dvcfjPam8SkwQhpFUrRh?=
 =?us-ascii?Q?4REmu6WARt5tdflep9JjoK/xmVvxYlW2DFCkNuy6iAu2TO7u1NmqVf2kfd56?=
 =?us-ascii?Q?cHR3ADKJorXKcd+JvOMfKE4Y8w505h2b41y2ZAb/SSJgjvyXOQo8Y+QXknOR?=
 =?us-ascii?Q?X6dgbfRtPTnD6S4f5ify+fltbbCzB0CamljDYGB3qi7J1JkR6jXEFzhxVUC3?=
 =?us-ascii?Q?RmXocTqk0qcQE9c3/jzwphGlrabQPvCYEHbiqJbKwVjOsJValmCiQoMqamDQ?=
 =?us-ascii?Q?SzTe3TEJ7a0enwtgEWYC/6L7GRfobvJ0KaQ88EclHGkHow3NdGUxSeg0bCkU?=
 =?us-ascii?Q?F6hxRyoulLdFOW5KD1hO1SM/BcRBQNCSubmgM7P1jRvstYlg1qlR+pMe35WB?=
 =?us-ascii?Q?c7w93crsApfBehPT4K6i8fk7atFu104jMnwWCEhyyBEeKxph8othPJ3MPdIe?=
 =?us-ascii?Q?3JmoHY1f0YQtJ+8/n87gQFfrySvmn7iUvWjLSSIJw2NdKS3gRjdAzUNXUHGg?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cwTl2s/xEefnOjS+3Zn3ryVxIfo1gUbiM8N7q88NIBPlh5r7jp6OS4Y6DBLeOEbdi4unMVCGRaF7MFtnsyRM9lBuMyu4N6w04KBzqTJntJKDsLwbC76FEnbDfRQW4nIKBYJM4hbtuKo+m4beUaQ40T5+dwxCqRmjOutFgO8QBbDJ33jo+k+KpOfLSRZCsM0G/1WnlEVY3DfG9LxBfSlMac4Gj3IZGF2Qqsx6x9XOJSEteBBDo3LIWVVUpbobcPRnykQJHffPSSGP0DgXUqJ38RdPhrT3Eu7wjru5sOEGZN+F5PnKwWWbNyHaZO8tb2IOxCJS7IEHiDg5jGcV+w3clT56vzVO+1DzPwNcSNzjOe+pKwMvu+pl+2qJJ7SEsqButR3w/IwFQ2YCjme9s/WZzgagFgbkehEsnf1Ok7gKgfEgPaq+Du8uPOL469YU6Gzugw+KfJbO8vir1wJipEbPYbGTkEG1cBBCLyF8MRFridSgk5O4RGsxizomMopV7sWtLsqUQd0TEaPqUlJTCCCR26FtUS1kY0OqDoqctF3ICH4xFNhXDbZhxz/tYSo/t/btdF9K9f9BdebI6yNUKVUCbzqEmD2rCPJUNpjeYDc4iuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7b30d4-e8c1-48e5-8186-08dcfab7f93a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 20:58:45.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkjKlNhy1hnaXbSkoCp/EyjzSZQYK3M7rvUGAkcTFwyYyrMA39E/xYienW7ppzv2fqnSbISSK+TFSDOfcW5hUnbjEQgZ9RXL5luptyoSHzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_15,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010150
X-Proofpoint-ORIG-GUID: 8JfmOjygZMvSWIWJ0PIUuntxo7kc0w36
X-Proofpoint-GUID: 8JfmOjygZMvSWIWJ0PIUuntxo7kc0w36

+cc Suren, linux-doc sorry, forgetting cc's all over this evening... (Friday
etc. :)

Suren - could you take a look at the VMA lock stuff + check it's
sane/correct any mistakes? I generated output from this change and uploaded
to my website for review convenience [0].

Thanks!

[0] https://ljs.io/output/mm/vma_locks

On Fri, Nov 01, 2024 at 06:50:33PM +0000, Lorenzo Stoakes wrote:
> Locking around VMAs is complicated and confusing. While we have a number of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be interacted with when it comes to interacting
> with mm_struct and vm_area_struct objects.
>
> This is especially pertinent as regards efforts to find sensible
> abstractions for these fundamental objects within the kernel rust
> abstraction whose compiler strictly requires some means of expressing these
> rules (and through this expression can help self-document these
> requirements as well as enforce them which is an exciting concept).
>
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and relies
> upon us handling these correctly).
>
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardown.
>
> The document also provides some VMA lock internals, which are up to date
> and inclusive of recent changes to recent sequence number changes.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>
> REVIEWERS NOTES:
>    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
>    also uploaded a copy of this to my website at
>    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
>    read through. Thanks!
>
>
>  Documentation/mm/index.rst     |   1 +
>  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
>  2 files changed, 528 insertions(+)
>  create mode 100644 Documentation/mm/vma_locks.rst
>
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 0be1c7503a01..da5f30acaca5 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
>     vmemmap_dedup
>     z3fold
>     zsmalloc
> +   vma_locks
> diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.rst
> new file mode 100644
> index 000000000000..52b9d484376a
> --- /dev/null
> +++ b/Documentation/mm/vma_locks.rst
> @@ -0,0 +1,527 @@
> +VMA Locking
> +===========
> +
> +Overview
> +--------
> +
> +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> +'VMA's of type `struct vm_area_struct`.
> +
> +Each VMA describes a virtually contiguous memory range with identical
> +attributes, each of which described by a `struct vm_area_struct`
> +object. Userland access outside of VMAs is invalid except in the case where an
> +adjacent stack VMA could be extended to contain the accessed address.
> +
> +All VMAs are contained within one and only one virtual address space, described
> +by a `struct mm_struct` object which is referenced by all tasks (that is,
> +threads) which share the virtual address space. We refer to this as the `mm`.
> +
> +Each mm object contains a maple tree data structure which describes all VMAs
> +within the virtual address space.
> +
> +The kernel is designed to be highly scalable against concurrent access to
> +userland memory, so a complicated set of locks are required to ensure no data
> +races or memory corruption occurs.
> +
> +This document explores this locking in detail.
> +
> +.. note::
> +
> +   There are three different things that a user might want to achieve via
> +   locks - the first of which is **stability**. That is - ensuring that the VMA
> +   won't be freed or modified in any way from underneath us.
> +
> +   All MM and VMA locks ensure stability.
> +
> +   Secondly we have locks which allow **reads** but not writes (and which might
> +   be held concurrent with other CPUs who also hold the read lock).
> +
> +   Finally, we have locks which permit exclusive access to the VMA to allow for
> +   **writes** to the VMA.
> +
> +MM and VMA locks
> +----------------
> +
> +There are two key classes of lock utilised when reading and manipulating VMAs -
> +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> +VMA level of granularity.
> +
> +.. note::
> +
> +   Generally speaking, a read/write semaphore is a class of lock which permits
> +   concurrent readers. However a write lock can only be obtained once all
> +   readers have left the critical region (and pending readers made to wait).
> +
> +   This renders read locks on a read/write semaphore concurrent with other
> +   readers and write locks exclusive against all others holding the semaphore.
> +
> +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> +concurrent read-only access.
> +
> +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> +complicated. In this instance, a write semaphore is no longer enough to gain
> +exclusive access to a VMA, a VMA write lock is also required.
> +
> +The VMA lock is implemented via the use of both a read/write semaphore and
> +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> +internals section below, so for the time being it is important only to note that
> +we can obtain either a VMA read or write lock.
> +
> +.. note::
> +
> +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> +   function, and **no** existing mmap or VMA lock must be held, This function
> +   either returns a read-locked VMA, or NULL if the lock could not be
> +   acquired. As the name suggests, the VMA will be acquired under RCU, though
> +   once obtained, remains stable.
> +
> +   This kind of locking is entirely optimistic - if the lock is contended or a
> +   competing write has started, then we do not obtain a read lock.
> +
> +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to ensure
> +   that the VMA is acquired in an RCU critical section, then attempts to VMA
> +   lock it via `vma_start_read()`, before releasing the RCU lock via
> +   `rcu_read_unlock()`.
> +
> +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore for their
> +   duration and the caller of `lock_vma_under_rcu()` must release it via
> +   `vma_end_read()`.
> +
> +   VMA **write** locks are acquired via `vma_start_write()` in instances where a
> +   VMA is about to be modified, unlike `vma_start_read()` the lock is always
> +   acquired. An mmap write lock **must** be held for the duration of the VMA
> +   write lock, releasing or downgrading the mmap write lock also releases the
> +   VMA write lock so there is no `vma_end_write()` function.
> +
> +   Note that a semaphore write lock is not held across a VMA lock. Rather, a
> +   sequence number is used for serialisation, and the write semaphore is only
> +   acquired at the point of write lock to update this (we explore this in detail
> +   in the VMA lock internals section below).
> +
> +   This ensures the semantics we require - VMA write locks provide exclusive
> +   write access to the VMA.
> +
> +Examining all valid lock state and what each implies:
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - mmap lock
> +     - VMA lock
> +     - Stable?
> +     - Can read safely?
> +     - Can write safely?
> +   * - \-
> +     - \-
> +     - N
> +     - N
> +     - N
> +   * - R
> +     - \-
> +     - Y
> +     - Y
> +     - N
> +   * - \-
> +     - R
> +     - Y
> +     - Y
> +     - N
> +   * - W
> +     - \-
> +     - Y
> +     - Y
> +     - N
> +   * - W
> +     - W
> +     - Y
> +     - Y
> +     - Y
> +
> +Note that there are some exceptions to this - the `anon_vma` field is permitted
> +to be written to under mmap read lock and is instead serialised by the `struct
> +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> +lock-specific fields are permitted to be read under RCU alone  (though stability cannot
> +be expected in this instance).
> +
> +.. note::
> +   The most notable place to use the VMA read lock is on page table faults on
> +   the x86-64 architecture, which importantly means that without a VMA write
> +   lock, page faults can race against you even if you hold an mmap write lock.
> +
> +VMA Fields
> +----------
> +
> +We examine each field of the `struct vm_area_struct` type in detail in the table
> +below.
> +
> +Reading of each field requires either an mmap read lock or a VMA read lock to be
> +held, except where 'unstable RCU read' is specified, in which case unstable
> +access to the field is permitted under RCU alone.
> +
> +The table specifies which write locks must be held to write to the field.
> +
> +.. list-table::
> +   :widths: 20 10 22 5 20
> +   :header-rows: 1
> +
> +   * - Field
> +     - Config
> +     - Description
> +     - Unstable RCU read?
> +     - Write Lock
> +   * - vm_start
> +     -
> +     - Inclusive start virtual address of range VMA describes.
> +     -
> +     - mmap write, VMA write
> +   * - vm_end
> +     -
> +     - Exclusive end virtual address of range VMA describes.
> +     -
> +     - mmap write, VMA write
> +   * - vm_rcu
> +     - vma lock
> +     - RCU list head, in union with vma_start, vma_end. RCU implementation detail.
> +     - N/A
> +     - N/A
> +   * - vm_mm
> +     -
> +     - Containing mm_struct.
> +     - Y
> +     - (Static)
> +   * - vm_page_prot
> +     -
> +     - Architecture-specific page table protection bits determined from VMA
> +       flags
> +     -
> +     - mmap write, VMA write
> +   * - vm_flags
> +     -
> +     - Read-only access to VMA flags describing attributes of VMA, in union with
> +       private writable `__vm_flags`.
> +     -
> +     - N/A
> +   * - __vm_flags
> +     -
> +     - Private, writable access to VMA flags field, updated by vm_flags_*()
> +       functions.
> +     -
> +     - mmap write, VMA write
> +   * - detached
> +     - vma lock
> +     - VMA lock implementation detail - indicates whether the VMA has been
> +       detached from the tree.
> +     - Y
> +     - mmap write, VMA write
> +   * - vm_lock_seq
> +     - vma lock
> +     - VMA lock implementation detail - A sequence number used to serialise the
> +       VMA lock, see the VMA lock section below.
> +     - Y
> +     - mmap write, VMA write
> +   * - vm_lock
> +     - vma lock
> +     - VMA lock implementation detail - A pointer to the VMA lock read/write
> +       semaphore.
> +     - Y
> +     - None required
> +   * - shared.rb
> +     -
> +     - A red/black tree node used, if the mapping is file-backed, to place the
> +       VMA in the `struct address_space->i_mmap` red/black interval tree.
> +     -
> +     - mmap write, VMA write, i_mmap write
> +   * - shared.rb_subtree_last
> +     -
> +     - Metadata used for management of the interval tree if the VMA is
> +       file-backed.
> +     -
> +     - mmap write, VMA write, i_mmap write
> +   * - anon_vma_chain
> +     -
> +     - List of links to forked/CoW'd `anon_vma` objects.
> +     -
> +     - mmap read or above, anon_vma write lock
> +   * - anon_vma
> +     -
> +     - `anon_vma` object used by anonymous folios mapped exclusively to this VMA.
> +     -
> +     - mmap read or above, page_table_lock
> +   * - vm_ops
> +     -
> +     - If the VMA is file-backed, then either the driver or file-system provides
> +       a `struct vm_operations_struct` object describing callbacks to be invoked
> +       on specific VMA lifetime events.
> +     -
> +     - (Static)
> +   * - vm_pgoff
> +     -
> +     - Describes the page offset into the file, the original page offset within
> +       the virtual address space (prior to any `mremap()`), or PFN if a PFN map.
> +     -
> +     - mmap write, VMA write
> +   * - vm_file
> +     -
> +     - If the VMA is file-backed, points to a `struct file` object describing
> +       the underlying file, if anonymous then `NULL`.
> +     -
> +     - (Static)
> +   * - vm_private_data
> +     -
> +     - A `void *` field for driver-specific metadata.
> +     -
> +     - Driver-mandated.
> +   * - anon_name
> +     - anon name
> +     - A field for storing a `struct anon_vma_name` object providing a name for
> +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
> +     -
> +     - mmap write, VMA write
> +   * - swap_readahead_info
> +     - swap
> +     - Metadata used by the swap mechanism to perform readahead.
> +     -
> +     - mmap read
> +   * - vm_region
> +     - nommu
> +     - The containing region for the VMA for architectures which do not
> +       possess an MMU.
> +     - N/A
> +     - N/A
> +   * - vm_policy
> +     - numa
> +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> +     -
> +     - mmap write, VMA write
> +   * - numab_state
> +     - numab
> +     - `vma_numab_state` object which describes the current state of NUMA
> +       balancing in relation to this VMA.
> +     -
> +     - mmap write, VMA write
> +   * - vm_userfaultfd_ctx
> +     -
> +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> +       of zero size if userfaultfd is disabled, or containing a pointer to an
> +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> +     -
> +     - mmap write, VMA write
> +
> +.. note::
> +
> +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> +   CONFIG_NUMA_BALANCING'.
> +
> +   In the write lock column '(Static)' means that the field is set only once
> +   upon initialisation of the VMA and not changed after this, the VMA would
> +   either have been under an mmap write and VMA write lock at the time or not
> +   yet inserted into any tree.
> +
> +Page table locks
> +----------------
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> +
> +.. note::
> +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> +   however at the time of writing it ultimately references the
> +   `mm->page_table_lock`.
> +
> +Allocating a PTE will either use the `mm->page_table_lock` or, if
> +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> +
> +Finally, modifying the contents of the PTE has special treatment, as this is a
> +lock that we must acquire whenever we want stable and exclusive access to
> +entries pointing to data pages within a PTE, especially when we wish to modify
> +them.
> +
> +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> +associated with the physical PTE page. The lock must be released via
> +`pte_unmap_unlock()`.
> +
> +.. note::
> +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> +   know we hold the PTE stable but for brevity we do not explore this.
> +   See the comment for `__pte_offset_map_lock()` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher page
> +tables as necessary, using these locks to avoid races or overwriting anything,
> +and set/clear data at the PTE level as required (for instance when page faulting
> +or zapping).
> +
> +Page table teardown
> +-------------------
> +
> +Tearing down page tables themselves is something that requires significant
> +care. There must be no way that page tables designated for removal can be
> +traversed or referenced by concurrent tasks.
> +
> +It is insufficient to simply hold an mmap write lock and VMA lock (which will
> +prevent racing faults, and rmap operations), as a file-backed mapping can be
> +truncated under the `struct address_space` i_mmap_lock alone.
> +
> +As a result, no VMA which can be accessed via the reverse mapping (either
> +anon_vma or the `struct address_space->i_mmap` interval tree) can have its page
> +tables torn down.
> +
> +The operation is typically performed via `free_pgtables()`, which assumes either
> +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> +parameter), or that it the VMA is fully detached.
> +
> +It carefully removes the VMA from all reverse mappings, however it's important
> +that no new ones overlap these or any route remain to permit access to addresses
> +within the range whose page tables are being torn down.
> +
> +As a result of these careful conditions, note that page table entries are
> +cleared without page table locks, as it is assumed that all of these precautions
> +have already been taken.
> +
> +mmap write lock downgrading
> +---------------------------
> +
> +While it is possible to obtain an mmap write or read lock using the
> +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade** from
> +a write lock to a read lock via `mmap_write_downgrade()`.
> +
> +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA write locks
> +via `vma_end_write_all()` (more or this behaviour in the VMA lock internals
> +section below), but importantly does not relinquish the mmap lock while
> +downgrading, therefore keeping the locked virtual address space stable.
> +
> +A subtlety here is that callers can assume, if they invoke an
> +mmap_write_downgrade() operation, that they still have exclusive access to the
> +virtual address space (excluding VMA read lock holders), as for another task to
> +have downgraded they would have had to have exclusive access to the semaphore
> +which can't be the case until the current task completes what it is doing.
> +
> +Stack expansion
> +---------------
> +
> +Stack expansion throws up additional complexities in that we cannot permit there
> +to be racing page faults, as a result we invoke `vma_start_write()` to prevent
> +this in `expand_downwards()` or `expand_upwards()`.
> +
> +Lock ordering
> +-------------
> +
> +As we have multiple locks across the kernel which may or may not be taken at the
> +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> +the **order** in which locks are acquired and released becomes very important.
> +
> +.. note::
> +
> +   Lock inversion occurs when two threads need to acquire multiple locks,
> +   but in doing so inadvertently cause a mutual deadlock.
> +
> +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> +   while thread 2 holds lock B and tries to acquire lock A.
> +
> +   Both threads are now deadlocked on each other. However, had they attempted to
> +   acquire locks in the same order, one would have waited for the other to
> +   complete its work and no deadlock would have occurred.
> +
> +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> +locks within memory management code:
> +
> +.. code-block::
> +
> +  inode->i_rwsem	(while writing or truncating, not reading or faulting)
> +    mm->mmap_lock
> +      mapping->invalidate_lock (in filemap_fault)
> +        folio_lock
> +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> +            vma_start_write
> +              mapping->i_mmap_rwsem
> +                anon_vma->rwsem
> +                  mm->page_table_lock or pte_lock
> +                    swap_lock (in swap_duplicate, swap_info_get)
> +                      mmlist_lock (in mmput, drain_mmlist and others)
> +                      mapping->private_lock (in block_dirty_folio)
> +                          i_pages lock (widely used)
> +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> +                        i_pages lock (widely used, in set_page_dirty,
> +                                  in arch-dependent flush_dcache_mmap_lock,
> +                                  within bdi.wb->list_lock in __sync_single_inode)
> +
> +Please check the current state of this comment which may have changed since the
> +time of writing of this document.
> +
> +VMA lock internals
> +------------------
> +
> +The VMA lock mechanism is designed to be a lightweight means of avoiding the use
> +of the heavily contended mmap lock. It is implemented using a combination of a
> +read/write semaphore and sequence numbers belonging to the containing `struct
> +mm_struct` and the VMA.
> +
> +Read locks are acquired via `vma_start_read()`, which is an optimistic
> +operation, i.e. it tries to acquire a read lock but returns false if it is
> +unable to do so. At the end of the read operation, `vma_end_read()` is called to
> +release the VMA read lock. This can be done under RCU alone.
> +
> +Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> +`vma_start_write()`, however the write lock is released by the termination or
> +downgrade of the mmap write lock so no `vma_end_write()` is required.
> +
> +All this is achieved by the use of per-mm and per-VMA sequence counts. This is
> +used to reduce complexity, and potential especially around operations which
> +write-lock multiple VMAs at once.
> +
> +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequence count
> +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, then they are
> +not.
> +
> +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->mm_lock_seq`
> +sequence number is incremented via `mm_lock_seqcount_begin()`.
> +
> +Each time the mmap write lock is released in `mmap_write_unlock()` or
> +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which also increments
> +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> +
> +This way, we ensure regardless of the VMA's sequence number count, that a write
> +lock is not incorrectly indicated (since we increment the sequence counter on
> +acquiring the mmap write lock, which is required in order to obtain a VMA write
> +lock), and that when we release an mmap write lock, we efficiently release
> +**all** VMA write locks contained within the mmap at the same time.
> +
> +The exclusivity of the mmap write lock ensures this is what we want, as there
> +would never be a reason to persist per-VMA write locks across multiple mmap
> +write lock acquisitions.
> +
> +Each time a VMA read lock is acquired, we acquire a read lock on the
> +`vma->vm_lock` read/write semaphore and hold it, while checking that the
> +sequence count of the VMA does not match that of the mm.
> +
> +If it does, the read lock fails. If it does not, we hold the lock, excluding
> +writers, but permitting other readers, who will also obtain this lock under RCU.
> +
> +Importantly, maple tree operations performed in `lock_vma_under_rcu()` are also
> +RCU safe, so the whole read lock operation is guaranteed to function correctly.
> +
> +On the write side, we acquire a write lock on the `vma->vm_lock` read/write
> +semaphore, before setting the VMA's sequence number under this lock, also
> +simultaneously holding the mmap write lock.
> +
> +This way, if any read locks are in effect, `vma_start_write()` will sleep until
> +these are finished and mutual exclusion is achieved.
> +
> +After setting the VMA's sequence number, the lock is released, avoiding
> +complexity with a long-term held write lock.
> +
> +This clever combination of a read/write semaphore and sequence count allows for
> +fast RCU-based per-VMA lock acquisition (especially on x86-64 page fault, though
> +utilised elsewhere) with minimal complexity around lock ordering.
> --
> 2.47.0

