Return-Path: <linux-kernel+bounces-191580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F38D110C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9926CB229D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9E8828;
	Tue, 28 May 2024 00:37:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B261E534
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856678; cv=fail; b=Lx7mJqyhEJo4ZX+wa7SodJaqclA3uPqkYPl9YUhmO2vJERS40vW6aYU+euRmEO91BG4oO1eYGNxQUUcDmbB7pjP23W+ICis/vmFAiGaqQggbIR2wo7x1xv/eZSOm4roZf9XEpdNa60ADbHSyGXt4q7Q38rNm9ZfgE2bsqAcXj4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856678; c=relaxed/simple;
	bh=+A8dsZ8/YL1u7HSGOOSfeX1jpJCgiU8gb29iSFQsjvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJAuAGECHd0wrGjqrSE5lbU84T7VYXTdeT+3iiuen+9HVDbuL5WYs/bdicg4U6dON3YrE3k8zr/aqqFI8x4tX+q23LQUdetcu8lUnts4imI1tQxodykRu4UMjaI0/zQflZQLF5ajfKpc50ygvNdEJPEt+SN/4KFpYtPm6odggoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RMdRVb011554;
	Tue, 28 May 2024 00:37:11 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DJqL0WZc5cs7URpKDSChaxrXh6Z0whnjCbNwbt1TPFbI=3D;_b?=
 =?UTF-8?Q?=3DdiErdKHM2xcIwWg3oUfbmzcglMhvYd7TU6v70QDvMXvi6IkakAHPca9Zh1WR?=
 =?UTF-8?Q?jyJXJkoy_Rr1XuHE90HaCA1kGEUgRGGFFKtvMNC/A8RLGY4wmwwrmnaZeKDDJGm?=
 =?UTF-8?Q?uCeMAqrk1Bcmar_LrqXhC5SWFmefi9lOnLSs1A9R3FPqDGGmkG3hdwPUOSXI6aH?=
 =?UTF-8?Q?pwLYVPI47XZlnIh2WK91_cZYvb+UFAY7T2zQYmcOfXTmLI+lxKytAq6PZB+mP6E?=
 =?UTF-8?Q?mof/Sf8gGO6p4pYBrPznuozDKs_nfowwNGwVyTSIjEnfQVKcN98InIJmKePVxot?=
 =?UTF-8?Q?F2421aLAcKEVWCxxPVYHjCPfn9RUOogt_1w=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7k5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNUSE3037587;
	Tue, 28 May 2024 00:37:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057yky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1ipE1swX1E/MxwmugqmeDpI5Ra2pGjYlYodh3tWCVc4At4lQhLMQWy6VyeeEfE6ud5UTUDfi+G5FA+Cgtz38f1+vipPWCM/MssD9rkQIz2CV1ycVj6IPOB8xtk/HiWpiXnY8nf0azLnV64i6t+hc6myRPARxfzcYJO9zK6z7md4RYYhlogom1PQLjgbUUpzAADIzWnJ773qRlBuPqa3N3a9d+QVSZg6GJnQiIXTLCmrrnYLh74YlWNBailERkk0AvyN8igq+urx9nGdJliIv+Jk4WB8PjibIHeImV6GwHEe7OXnuUMFa0l0ysjENV4oLjM03i0YMuvxAAMWwbb65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqL0WZc5cs7URpKDSChaxrXh6Z0whnjCbNwbt1TPFbI=;
 b=IcDwta1/hSgFDRIVJ2ON0N5g5qJd4Q9SOhBXu4btomWk/ViJU5b7z6U1k1YqDf02JBuDzuks7S2BhfCWIZWgrekH95lpr38Zx5AacLJE3Gc4naDRoP048dy08h/ub12G4qDuj/GquAPdgikqRpbP04dWyUDl2Q81NnKAn/NLHmt07ZJHGNJWCSqv2UGL8FNXUOnR/7jcdfUTwemgGjVInZ92ABSGYW44sksihye8LTwDNbiY8KzOCWtV2uA5vDGyPv7iJMf4dVAcggQjl3LE/Qb0o6A0f+1mjux4J8jO/5AYSLmat5oIaHcHb/qG7ndQsCzoKd46dzTfxCFiVP4MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqL0WZc5cs7URpKDSChaxrXh6Z0whnjCbNwbt1TPFbI=;
 b=FWAnTHodPpHmTaJjfFry6V2QP/Pvy6QGkKCYPFIjNo72cZVTZX4a2skCeL/e6Yen8+dcWD7EKXm0WlaJzJSzyNFx9/twOf8ABGVdGHHpIgjVcTar+i4CG6s7oLm64knolDvkuuweKnw6OC9RAPaTZZvgWdLNl6472Z5AdYCWD/g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:37:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:37:08 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 35/35] arch: decompose ARCH_NO_PREEMPT
Date: Mon, 27 May 2024 17:35:21 -0700
Message-Id: <20240528003521.979836-36-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: c8435718-8ace-4fb4-3196-08dc7eae4e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WJoAwurexoH/kRTruqBPw/y8ydzlkcIpX3n/4SMCOy5mGvgPA6ezKyCp+UgI?=
 =?us-ascii?Q?YBnqar6ffxtIOicv9y+PCqtQybsdDjxpDf5D/u+EXYMh8Q5+JQ0Twt7ffAKr?=
 =?us-ascii?Q?VNIgMR/NA8EJr0wynPtJgA0IskGTsaPYtrTbhu+Bueh7rGeXKJNA+UGk5KpS?=
 =?us-ascii?Q?+3vByYZalRVn8GfjDswXenyJablM9gM9/Fry4evMdRSLvqELl1Dkp9TpzYWH?=
 =?us-ascii?Q?pVWfExtD3W62EdCIEJUR3KwQ39S/mgSHPhFUTcTcBrr1G7f9O3al6/mLZ1Li?=
 =?us-ascii?Q?LZgLJQH/skGLipTctczQ2ygm3w6pcGXs+9qMriQxc0RdwH6tigqGyQE2ZK9D?=
 =?us-ascii?Q?9kbLYGNYFc2i3q8/8HLDIfUUllT+kNDwhcQc5zrH6b+Lmq8g0ETQj51HxaS/?=
 =?us-ascii?Q?XukDHkSkSnClD6234cJVTGujlMY50bzcauyp7wsHGI3etBv0yGdkQlDqPbpJ?=
 =?us-ascii?Q?r1BLFV9u7WUbVHpy2AODk5XBB8I7YHOgBTRmq2+mkpu+UfxoI2j4T7eWHbvE?=
 =?us-ascii?Q?a+tn70O8wfuICQ79p8XhCi9v8X8+6eFaJ2sOmouRtP1FErnDsSmDmm1XO8Bz?=
 =?us-ascii?Q?AWuFnSgGdIHLWfvzsJrKMFB7agDivRzs4T1XBnyTRWxDIg9Qu5a69yyzH5ao?=
 =?us-ascii?Q?yo3mQQlXewmlvkI5+q+JR+O5MsBut+IS4rFu55ZU8tai+0advodslOMR4iQQ?=
 =?us-ascii?Q?T6X+uCfm/YueSk/XS/UmfaokKY5I7y259eU9Cmi1ENExupeqA+W1bsz485OY?=
 =?us-ascii?Q?nCz9pCcZBcdpYJwD8DqsLIpH59AY2x6jTXrT3g6Eq4yTVGDYdoQa3bTMlLBm?=
 =?us-ascii?Q?BF/PKBcMlwRlOV2kNV8F9JUxW6Je+DRxpauQyKtLo1DNA4Kv7mkiNkEVq/pK?=
 =?us-ascii?Q?rcPmIuNvlqKx3dgEvfZwr6wuSTeLn1p89vJP8r1FuM3oSwFPiinHzYZaqzQ2?=
 =?us-ascii?Q?76A/q3TH1YT0hL7rXsxK30BqJoR+PMm+dyMnnbKgelKE46pZ4SoV2s7AFb9N?=
 =?us-ascii?Q?wltmlDauXDQn0U9AB3JUlqzyA/mk7CJD3vLkXQ00NrSIRAAjABlnFjzkx0jt?=
 =?us-ascii?Q?heOMkSZHaHWxFpELrHF4NBsRVDDmPepi5xwq8vLNoxP4edc375SpM4Yam5fy?=
 =?us-ascii?Q?u3pErlgdu5rau10Pt15x9IbcXuvrgJxViDxfqoiQ1FxsFACzk/eOISDklHJJ?=
 =?us-ascii?Q?gY7Jb/mcHjbMFh88E95XzJjjomukCHPV+S6RIa8gH4uAeAdabRL0a+C2O5iK?=
 =?us-ascii?Q?TqmRnbEmn439QMbPM65544d+8d141i8M2IQxDJMPFQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FVfjIYZkhSvdVCQ6xoRpAnNIQVxHaEUW+cWWUDAKJQg09QvN1aZ3WX4uxCDk?=
 =?us-ascii?Q?94vX2EiyGLifeDxF/o/90Pl9tNZPt2YH5GZ07KvOAQoQumo9+tn/zhTgq57m?=
 =?us-ascii?Q?TReYKokHYuzzbTLLtvn0bEfHGbWuOxtOY5Pw5Hn6xTWnEUwkjrSqUANtMpph?=
 =?us-ascii?Q?TEDaCuliJ1zKuyikky9YWSiYaBt2jYvVjNeMBvY3MPFa/eDBL+VWz5YX1p+W?=
 =?us-ascii?Q?HRYl+ydo/uOfFL33XvKXmqmR0ZktRkLoOtJoUYcvkak3LEBv72yGGCJZJcdS?=
 =?us-ascii?Q?Yo0vg2i411HfigtcasxSWkf8hlFCCnn2vaYU3sP4xR4r+/wQdzWsPGhj3la/?=
 =?us-ascii?Q?dHvjxIapSwZjmWI6IcEWg34QLPtNsJVtMWurJZKjPwY1S5pTvajGQB3ZFrxe?=
 =?us-ascii?Q?EaPq08COCIluFpgwF0DOnCHxk1k3LethY/IdVOsmmrFyCC0ThbICmRI327AU?=
 =?us-ascii?Q?2eFMR3ZRsk5ZSoOA19ujAs6HhlTtFBc3tpsoiqTKVkAmcIg92U3SewLFpUXm?=
 =?us-ascii?Q?b7UUOc9trZTwXXxz/hutOeFh7erDbiinyFgcljDeoP6oAQe25DJ4fdZyiu04?=
 =?us-ascii?Q?cBHso2md87SiDn9937jZMndhnOWMzDyhxTldqpe49BmxLnz89wyS07Rgp8oD?=
 =?us-ascii?Q?Hk6MwVVVSuBdhCarOnoRu59BlbxqilRaKM6pTtDAhlpVii83TqfZBKxVvwUk?=
 =?us-ascii?Q?sNxYT2V9yMp7Bu3zqvNhe3ZGBMLa+93/JgtSqd1WNYNvhtf50pL/aYFdiNkw?=
 =?us-ascii?Q?zzRiZmsDE2498qPzWovQH+cgZ9rh/CHA6MXmYcbtR40+VNl4uRLVTjDjYrp7?=
 =?us-ascii?Q?5iYgpcPindz5PRBNLuHDlsnBpq/U4mi2+LMxSVQgx0akKHfaq6IVXdY/kP3c?=
 =?us-ascii?Q?K6E5fcKvhRgVwJknCIpqiNDmXEJebX4Mmn/snmJ3hXHqD11v0wsvrntPM4CH?=
 =?us-ascii?Q?SXNuyjwZqEA1Xs2XS31K7t6K6SHHI1Vm9voZCRfnjszjJiC4RY3yXJFuBOPr?=
 =?us-ascii?Q?3kT2iHBgNXryz52ktWK4f3OC7+pClT5Dw4UrjBA7hzOOnk8HPXv1YEHZoXkq?=
 =?us-ascii?Q?maGYu7CFWXlXC61HIWFTYI6xVjcDGwB2USfuhXyGnIIlVperp5qjeJyJFeGq?=
 =?us-ascii?Q?K2MFI7lkP+8NB9OUdQsCi1xdBxd1vnjBJa3DVkiMhKlyPlFjl65nbnJbJRfn?=
 =?us-ascii?Q?grkFhyEVL9sHtK/O69fDA0EtB+leXP+WGAVNsUUgPH8EBdWsL8XImgh9y2sN?=
 =?us-ascii?Q?ntFjFiJdR8JWSwlnvMc9Siq5NdVFgL3rzzF8b1JqkhTVStodYGfNaRzMTelr?=
 =?us-ascii?Q?zN/S+8xeIKWqYgl7srD1h+0FBbGd5DqEGoaJYbTeOW4VgRCSo+QpBp8kZ/Xr?=
 =?us-ascii?Q?OSx/3s1CnyeKYvu0QnSkMQnkk6hH/umUpbFtaLVsLVIjocPXcIGXG9jc+MZI?=
 =?us-ascii?Q?yQLv18lO341Tgw7wE+T1wG3cHjKhbWVX0WahjFMQO0NkYOdW168qggFazvPQ?=
 =?us-ascii?Q?+DsMrc2iXoVz10yS9ILRjHYa/7/hvGDb7lMqrC1pzqnH5fmbQNR5gQ+40UGc?=
 =?us-ascii?Q?Zphmg06kkrlG5ttv7kDlZRLmvo1tfb2V6i7xqvQ3JXKkYMMw3Xs1q8NTQCZ1?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cG+l7fLYSkCwdzCMEjuDm0a8GC0XB2ZRDGRDvLsJNxlEVxMW52Dpi/n/N4CsCSESmrtcWSqn79ybSLhuqfDJFkfjQxmmhBcycuEIYDW9ImhQAurQcsmjeeT1sau+ADT+hsbs0y1ATNCPP70hV+Du4wyR+1z2dwza8fJf4fvmMrS5LMs2IogPaL+nwL+3QrgrbMdWRZxgsa+7VSHsK2OYPz2VIv/AFJ27ByVJ/8euxrVh4aje5NuJNRAvq3Vy7iaQ89Vtzbh3XmlVLh8nMCEQEJwO1msJWjTKpf03iGuJDUvxKTyj32kJ1hQvRn/855e93RqLhmDimJX2tan+MaLJDl0rMHzS+aj3IAdCIg21RKg61PKU3l6txqXqP74uvD6/szO+xZyWOkYZIdmsAcEy+/wIs92iqqZzxgAnsASBTHayF7vbyeZLvQ76cfMelFaN1gbCT31/L1zLqJHc5J4k98rHaEQsUCjUOwJa3OrCvOrwbLMzRy8UNRy9GJspWQHovXPhwfco80cCB5kMJXnrur+OEj3v20jKyBUJyWrzqDMUlJbC3bfHp6WcWv1DlQQDy7lB3nFY75xE1VPzH2iMtYaGui/37PpYK3iwzXT56wE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8435718-8ace-4fb4-3196-08dc7eae4e33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:37:08.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+2ntiXKDSRgAdCSwKVNGVY+JQwOtW9J+PXkLQGIe9EFzYxAX3rlNeSuPeZOGiu9G9XzaYb2pgEhO5AB2ozA2ppEFLkDzduMv2p9/NDc4Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: A9b0kBmM5VZ5LIWngHKIubAQqWVN1DZT
X-Proofpoint-GUID: A9b0kBmM5VZ5LIWngHKIubAQqWVN1DZT

Now that ARCH_NO_PREEMPT is conditioned only on ARCH_NO_PREEMPT_TOGGLE,
decompose ARCH_NO_PREEMPT into ARCH_NO_PREEMPT_IRQ and
ARCH_NO_PREEMPT_TOGGLE. This allows architecture code to selectively
enable one or the other.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/alpha/Kconfig   | 3 ++-
 arch/hexagon/Kconfig | 3 ++-
 arch/m68k/Kconfig    | 3 ++-
 arch/um/Kconfig      | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3afd042150f8..7fd1d9dcad8d 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -6,7 +6,8 @@ config ALPHA
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select ARCH_NO_PREEMPT
+	select ARCH_NO_PREEMPT_TOGGLE
+	select ARCH_NO_PREEMPT_IRQ
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select DMA_OPS if PCI
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e233b5efa276..3a33a26e1b81 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -6,7 +6,8 @@ config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_NO_PREEMPT
+	select ARCH_NO_PREEMPT_TOGGLE
+	select ARCH_NO_PREEMPT_IRQ
 	select ARCH_WANT_FRAME_POINTERS
 	select DMA_GLOBAL_POOL
 	select HAVE_PAGE_SIZE_4KB
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ffa29585194..3f7d675849ed 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,7 +11,8 @@ config M68K
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
-	select ARCH_NO_PREEMPT if !COLDFIRE
+	select ARCH_NO_PREEMPT_TOGGLE if !COLDFIRE
+	select ARCH_NO_PREEMPT_IRQ if !COLDFIRE
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07..390328e97261 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,8 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT
+	select ARCH_NO_PREEMPT_TOGGLE
+	select ARCH_NO_PREEMPT_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
-- 
2.31.1


