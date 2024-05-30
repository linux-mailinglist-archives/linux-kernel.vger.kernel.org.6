Return-Path: <linux-kernel+bounces-195178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799B8D4890
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881121C237A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE44154BEC;
	Thu, 30 May 2024 09:31:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EA6F315
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061460; cv=fail; b=i1FNjyjdc1hdzSBQFgdYdhfAsUkzqOX5SD9GyAL3iuutsarAeS8BJdT1m4d3NNGvES28qlaKekgWGjbzDUQaDW09eIPt45eWeK4j9sqcuDFRTrbIh4eJ/dwEbXapQHfY6HQ3NEktDZaIu2CinrqCLz+eaGoIQGpkq0NJTmUEoPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061460; c=relaxed/simple;
	bh=09WDVtuYNGo8QDcPacHQ85mbv1hIGefPG/PayfkSdAo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=OonT0exUdePQdKbSUlK+k4sBGZD+trnuOx+o29FEDZ4fazQvSSB8TITIbByN4biIaoOoOfRzMC90X0MCI3yOVCQgv2TJfUQWyZ1JHYQEmkOcoiAAFJ7NFtTwjtmjhoGevr4q5lfiNztPBNksLCSrD6+9x2hzhPmTKzFd8/sTbrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nZqo004484;
	Thu, 30 May 2024 09:30:38 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DzS4jWTan8ZeO?=
 =?UTF-8?Q?auSwcLJbjrujg4a1t5fhlhxo89qVYFY=3D;_b=3DiDGYxwzBWIROGo1I5LJ084r?=
 =?UTF-8?Q?B/Ow7Rl692ZNeb7IQg+q7Nk+8qpWs+RvaTMQcXZ5AjoG9_E7Edpi9q9xSXFG1wN?=
 =?UTF-8?Q?hNCVcJpgunyT5+MYQcob+8O4oQ7P8s2zmHidk6S+ehNzuKVVK3+_LZaT64+IQui?=
 =?UTF-8?Q?CF/j8aAAVtFlVMeZEUx9GczWmNcUIiyo02V2dYamFIzCpQAg6UYBJ7pjv_7sv3M?=
 =?UTF-8?Q?Qz2IBvxwmkAN4eD8s6ggJuLMYdcOb9ZpQW0YeO5CX30MiEh2gJmUFqpAxSawwjI?=
 =?UTF-8?Q?_Tre3gHpZ2rF4ehmOfoEt7Sc9jK5YvfOPFNfaN/74/BkmFQA8xG1PBxV91rDuN8?=
 =?UTF-8?Q?cmst4b_PQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg8jsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:30:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7WdDr015090;
	Thu, 30 May 2024 09:30:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc537vkpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOEkOvCM6B1ifPmO5BuCAtvAmSsiWD/UTNr+xei0FlHTiuK+Syw5iXki7QhD+bix7VjYCvtwg1iqOU/pCT5XsaOOOM+B2NjHYsXrQUG44dFAdQCUBcgEOUjPt8yb983ZZzUf8Ph+fA+VK2AejIV8Qz7Htf1S+CLmZxwceHTrS4k3VQl3XjNwZ/j9MZ/CLtOUasnkAbrvpTtz4CLs0VO5P695/FNqXRINOg8CHzCZ1CjnBlU6IbduNDwLIetVOe3jVB64fsDV4HQVPDE6tVvuEPRLbO2VPn7NF+6om9nzcm34tKx24JfpIK7UMdtb/LMx9aZ9mAnLvseHIBgcxDqvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS4jWTan8ZeOauSwcLJbjrujg4a1t5fhlhxo89qVYFY=;
 b=N37URCJPt8wA3q/G/mIzOX4xtz2j71S3Y/KIVfKi0kfSBY4cmmy9IHquybGzLDwsUFcwt+wAdeC38Hr8alFZ8xvcD6zzfDcJejhXVikv1WeKjy/EapWjpL3XvhATb07q7CenEkqQzmNjeVTNRgwH5BhMZs6bItm/KXeEt/eHpR5ZLK1ZcQSWzYUGDDUnt30lHv1mwIIKrgsQFQc4pc34Fdhf/MP4O+euRhu/kLmAZtt7VO3jk5KrRdDZ3j3DBkbh91anYmV8U6s6/mh/SeunEEpuyMC4xrH1hTY0KFNXWvglkzRAf8gOPDiuw6jEn9hx29lU7+Y9iFpxEShRlewOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS4jWTan8ZeOauSwcLJbjrujg4a1t5fhlhxo89qVYFY=;
 b=QwQemJN/JtUr5IJfvK4jMu9OvrHUPsjHVzSK1ggWDkrBdDS+C4e85xJt+UPXHvSAn04P0KRzCgM7C0sslNUXyEeONeV3LbvGLtdpJpwyPamsrFNfvfmeSSDiS4J7A44uOafG5tMDxFkINCDW9A0Jddf9F3m8lyIlZ8KgyYoLYPY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6823.namprd10.prod.outlook.com (2603:10b6:8:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 09:30:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:30:33 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-13-ankur.a.arora@oracle.com>
 <20240528162534.GG26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 12/35] sched: separate PREEMPT_DYNAMIC config logic
In-reply-to: <20240528162534.GG26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:30:25 -0700
Message-ID: <87r0dj640e.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b5899c-ba13-48b1-da41-08dc808b276b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iF+GPRDb41XC7GomFmg7P0OKwxzfceiJ3w4FkPDmMHBWkeNQ73GJlBLhEPOs?=
 =?us-ascii?Q?yPQs9wpA3xtlA1kWtTaBYDCjsYe1TTUcsWwAXu5xmTpKEome+97rTA+EL4fb?=
 =?us-ascii?Q?AUh4rF5dQxbZ/7lMHJhAEPjgGnodqnzqkx/FLWxWsFlgkDXA91TnV1aT8eUT?=
 =?us-ascii?Q?T0N+pXQAyrxyjTr+lG1hyX+A55dWDJPzemLBj8f4/sp/vN8ZSIVNfGY3iaeW?=
 =?us-ascii?Q?R/6S1klbLs69zcJa9nLU7fySMuoGF0dahJGUjHSysf/OZpPtEmV57UTw7d2z?=
 =?us-ascii?Q?pC5VZVoSzUIjIbb2XrOaGL+/rKd6X0ySz/hFScZ1BalQX2xTH0FQO1c632fu?=
 =?us-ascii?Q?4oMMfwA8At+3rwtP612RScjfd7Zm9na7XECl1hz8ZzfWAWG2/QXeT2k5f9tZ?=
 =?us-ascii?Q?Wzcd8OEJBG+jy/5bidUtHzdt8sSVO0L4IWFiyZDM+SJrjCT9NjBMPk2Agjrh?=
 =?us-ascii?Q?f9lBxbrtMd6I54/3VEFquhIHHabA/aEl9NRhbwPrH5kepVGH6nuUma9yjcpA?=
 =?us-ascii?Q?5TuZ4O/4QHl0topADoryw1Rb6119GecxznSOhv5uEDFsU4g1HBohTt1T+vVn?=
 =?us-ascii?Q?acJeL7jeP3dMkzqqUorLz8LeZ0xUHS9JONEGp1yhD6oqtY299zwH6a3jScP9?=
 =?us-ascii?Q?+8+iuTT5v6nciz4ajN9q6d0nxtKTyqYOGNiodt7AXLi+IvAFstrxjB1dv6Mf?=
 =?us-ascii?Q?MBOg6hhw7K41PV7L7gNtCpnfX9KCsmD4tG+rZQpwM+JGxk4xEznPv2M1PPw6?=
 =?us-ascii?Q?GxKBq6VVY507wym94NfF5Qjm+3TEM4GZXp4suCuCZX0M3zRnCE075uqrDf56?=
 =?us-ascii?Q?roJOnfKwS6SoIhOoQJXk3hGGQyjiW9NmFEQ6DYLrley3nOjlrYggtj4qzUg4?=
 =?us-ascii?Q?fsnVplON4HOjfhrAiBdLystXfRRexSf46luQ45+KHdpFEF1PgrI6rieNNtoW?=
 =?us-ascii?Q?U1j9I475Ew7zXfS1+21jPpDv+khk0IP4dZIWneYe50QOspb2RATg54ouSQCQ?=
 =?us-ascii?Q?LbKtHajWHnUPAnsMrQrfqRO80ydXAuJ0EiekK0XxuZweaciLU3AOaJBbdy2S?=
 =?us-ascii?Q?FszKv9FcN9C1v1F3RCJUYg0dCBNYaOLClFH6Xs+5TT24ztSTcb3Tgv3W9tYU?=
 =?us-ascii?Q?nfBG8EYzEpNw1ya/CN+I0G9QJMBiiavKMXeStzE42lIJf/cMhXzA1vYEsuCB?=
 =?us-ascii?Q?lAj8owZHTb7+VuxccSK7zH24Cp6MZRQktLp2autwj2FPlfNS1+o35zpDxtcK?=
 =?us-ascii?Q?viRYJG0Y7s+F9UjePFC5GrgwXLL1Or3Gno/uZIXG0g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7BMy4FmQBRXeqqTACrdPbVWNngckZ46459PpoYbNMKjLuI0fUq2nDcbByyvE?=
 =?us-ascii?Q?qi2jvqMCW1/1AZvimjrpyFkmAJ1tN1GGK4zGuePIX0ARz/X3ZbkIaJKzCs1l?=
 =?us-ascii?Q?lZweT/M0XG23+hfjx0O4dMehiLHSTfPniiZgwsGcRwkBcDnzO/CIbauQP0SX?=
 =?us-ascii?Q?8u/xIiJKw6AfwZsXDaZe5yiO+mCpvpUNf6Bhkj9bJkIGP0pe2kIlp6jLPaOa?=
 =?us-ascii?Q?XuzWmE2xjk5qzc4InybMf8qMoQ8hjVADcXEyHxsdgCpIAAttNcWoqLDzDIyy?=
 =?us-ascii?Q?jN81wqShfUoO/v5KurqZP4+IQFW8zCZ42z9RiYQb9sl6FgSZhVzUQrTutGxD?=
 =?us-ascii?Q?TO8ecXeCuya03wCITclij7J6/4LMTRFbjuPAB74EffYd4ua2TWCZXycvC8/P?=
 =?us-ascii?Q?fYhE1dZWOSCER0Yxp+buv73cf9a34y/tG5VKkaEya68hXWiJz+ixwgj1NxSL?=
 =?us-ascii?Q?iN070t//4BDKamNJ8NmNW5mi4ofHxLDEtDg+FuEp8b3K7Y2EcCqHO5BWB6k0?=
 =?us-ascii?Q?L3eyIzBjLV6jcsLsvhDGK8Xyy5gDGUnrGtXuKUi5LdshWIYIzgBShslQoqgw?=
 =?us-ascii?Q?UgjfcPTHl8phwbtBBzO7wNiGzEf2mahxgGupJzSRB9zHlxqX4fOEwBANWdRE?=
 =?us-ascii?Q?ChRcODk/qzvwohfrGMhsTngndnNoCUFOoY+TT+GDFgL7EKDHi4UAXgeLLtYn?=
 =?us-ascii?Q?1lfhR5OCX5tWZ0VBWjEvrG3SJCEeHXM7CPLg0dAxW3murKxZj+FPRyCF1Vqo?=
 =?us-ascii?Q?l1FjQqQYItuSNeEQm2o6vpVWot169smrwHlyqWsd7FxkwwkvLd4vs6MCf/jJ?=
 =?us-ascii?Q?eQul5quE6wSbhEoRpKdmW3khvVQ0kUac/OG+JgwDUNvcN6vnSZazmXDA0X4F?=
 =?us-ascii?Q?ESgm0suvTaFhhLvMLquYF4lYMtlXJ08/DCuQXmP2HI28j6EI/1Mv0sKhcYf+?=
 =?us-ascii?Q?sRxgAJ+/VMKvDz12Z6xa/EdYLJpgAI/WXam9nQ1pJtv0K9vsqFQfLdR7AT4Z?=
 =?us-ascii?Q?xHA4VWQs39SR1Bee63mjyNN7wJWqIdCcVNlIG+eA24GeGTMoHAewWOJR7aTh?=
 =?us-ascii?Q?5o3VNcXc+E3g4bmABgt/KOllVuCWmHyOUu2b2+mZGbu532fByqfjTulfdfzC?=
 =?us-ascii?Q?ZioMIs6SFJU5615jtKJ0gdnHHOFBWvUi+B/EF07F0n9AkbZQqH2pbJZh5xjV?=
 =?us-ascii?Q?9nBhWzb30hE6Wu0jJJ+R7uTFLyHkFnwbboHbC0t4T6h3Ea7i5Ps1Ir9Or8zl?=
 =?us-ascii?Q?m5rb4dZ6Ak4gHqGoBYIR1BCldRCIoO/gaq7+astXwcnRik7DjhrMm48HZ/xX?=
 =?us-ascii?Q?q0E8YOmbPULIwO6AulDMG19jnHJvSGpAw9ar/zJhMEo+TsE0JDLJO840hGqh?=
 =?us-ascii?Q?qFTKUMGeYLWBufDyZbcxfDlNLtrviUFqnctwuMdq4LJCnkeq+9413fk+JW/M?=
 =?us-ascii?Q?QhAinMTULcNbcA6zTeX/k9hVvSTC1lYqFVsGm2mhy8eiPIraOBghfJVUwgdw?=
 =?us-ascii?Q?24ZTpX7ZkUF2vPVRIy5SNEnNvhax75RrhJpsHluT9EesOa7sVFCE70RUlqJ/?=
 =?us-ascii?Q?bULlnbcCWkDJIrhWrs8dZKM+H2Jl1WJFdWP1B8uL8J5vaIrVJoXjUHRgFzVl?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pq5QFdfVgH2AaC4p4ern+g8qZ52eoP8+pporgwUurgNe+eu9h6znI8a5ZHfwUDCJWHkpmPZOPeP6shtYK9WQW5dcx7UFkktp4I4/GEM0X7JiGIOLgSiaK9dfiRsnVVQfcgiLT7M8AgoFH6rOE8eurAydMB05ehjL+uT3UwM6szMPQ36ico8gIJOb9ERfLMgMP41XgMT7Dtxx1bos+koj7Y9bpOfWYuPFpR0vv+7MTGRrUkxFeLkjP9li39TEg1MhiWrONDbMBKUjSCLx6VP7fRpuiPBeT2+9bluFRVaDfz30d7umGHtxtjgN4UIzGHv+EE9xwO4XY0RpMLWfPC6MbRh4E4jlvzXXlANUSVY748/LypMl5mhfTuwzrOGcz6SOeQ/M+9sQG8C3LTGU6LknhEfzVJXIQxaT2J/DoZdDZsq0HePE7WRUmYKYdGr1/hfE7UgQDm9X60dqGGN1pSTCYnrawieYVeYfKqDAnT8CsOKfN75kmNmgHTRjaQpBuHRHyMxxypJVpzJa9MLraHtjWc+60humLl6ufrvDxk7X7PPlpSqbwQRcZaNVggN/NOWIyRktsi5X344oYb/VoTcu84Ci9QbANU5ZJC5HSFoJkyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b5899c-ba13-48b1-da41-08dc808b276b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:30:33.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP/NEsZwTwfVd9FKK6mOzQLB03JRO21pKzDi0WYAubXxzWmCr6kyJdRBky4rat3kYZ84txtgs6RVwL0RDJWKyLA7g+vkoWxC2Gv4lt5Lzi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300071
X-Proofpoint-GUID: DEa15Z2qrgI14iZl-z367oWCFVNQ5oz_
X-Proofpoint-ORIG-GUID: DEa15Z2qrgI14iZl-z367oWCFVNQ5oz_


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:58PM -0700, Ankur Arora wrote:
>> Pull out the PREEMPT_DYNAMIC setup logic to allow other preemption
>> models to dynamically configure preemption.
>
> Uh what ?!? What's the point of creating back-to-back #ifdef sections ?

Now that you mention it, it does seem quite odd.

Assuming I keep the separation maybe it makes sense to make the runtime
configuration it's own configuration option, say CONFIG_PREEMPT_RUNTIME.

And, PREEMPT_AUTO and PREEMPT_DYNAMIC could select it?


>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/sched/core.c | 165 +++++++++++++++++++++++---------------------
>>  1 file changed, 86 insertions(+), 79 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0c26b60c1101..349f6257fdcd 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8713,6 +8713,89 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
>>  }
>>  EXPORT_SYMBOL(__cond_resched_rwlock_write);
>>
>> +#if defined(CONFIG_PREEMPT_DYNAMIC)
>> +
>> +#define PREEMPT_MODE "Dynamic Preempt"
>> +
>> +enum {
>> +	preempt_dynamic_undefined = -1,
>> +	preempt_dynamic_none,
>> +	preempt_dynamic_voluntary,
>> +	preempt_dynamic_full,
>> +};
>> +
>> +int preempt_dynamic_mode = preempt_dynamic_undefined;
>> +static DEFINE_MUTEX(sched_dynamic_mutex);
>> +
>> +int sched_dynamic_mode(const char *str)
>> +{
>> +	if (!strcmp(str, "none"))
>> +		return preempt_dynamic_none;
>> +
>> +	if (!strcmp(str, "voluntary"))
>> +		return preempt_dynamic_voluntary;
>> +
>> +	if (!strcmp(str, "full"))
>> +		return preempt_dynamic_full;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static void __sched_dynamic_update(int mode);
>> +void sched_dynamic_update(int mode)
>> +{
>> +	mutex_lock(&sched_dynamic_mutex);
>> +	__sched_dynamic_update(mode);
>> +	mutex_unlock(&sched_dynamic_mutex);
>> +}
>> +
>> +static void __init preempt_dynamic_init(void)
>> +{
>> +	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
>> +		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
>> +			sched_dynamic_update(preempt_dynamic_none);
>> +		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
>> +			sched_dynamic_update(preempt_dynamic_voluntary);
>> +		} else {
>> +			/* Default static call setting, nothing to do */
>> +			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
>> +			preempt_dynamic_mode = preempt_dynamic_full;
>> +			pr_info("%s: full\n", PREEMPT_MODE);
>> +		}
>> +	}
>> +}
>> +
>> +static int __init setup_preempt_mode(char *str)
>> +{
>> +	int mode = sched_dynamic_mode(str);
>> +	if (mode < 0) {
>> +		pr_warn("%s: unsupported mode: %s\n", PREEMPT_MODE, str);
>> +		return 0;
>> +	}
>> +
>> +	sched_dynamic_update(mode);
>> +	return 1;
>> +}
>> +__setup("preempt=", setup_preempt_mode);
>> +
>> +#define PREEMPT_MODEL_ACCESSOR(mode) \
>> +	bool preempt_model_##mode(void)						 \
>> +	{									 \
>> +		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
>> +		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
>> +	}									 \
>> +	EXPORT_SYMBOL_GPL(preempt_model_##mode)
>> +
>> +PREEMPT_MODEL_ACCESSOR(none);
>> +PREEMPT_MODEL_ACCESSOR(voluntary);
>> +PREEMPT_MODEL_ACCESSOR(full);
>> +
>> +#else /* !CONFIG_PREEMPT_DYNAMIC */
>> +
>> +static inline void preempt_dynamic_init(void) { }
>> +
>> +#endif /* !CONFIG_PREEMPT_DYNAMIC */
>> +
>>  #ifdef CONFIG_PREEMPT_DYNAMIC
>>
>>  #ifdef CONFIG_GENERIC_ENTRY
>> @@ -8749,29 +8832,6 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>>   *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>>   */
>>
>> -enum {
>> -	preempt_dynamic_undefined = -1,
>> -	preempt_dynamic_none,
>> -	preempt_dynamic_voluntary,
>> -	preempt_dynamic_full,
>> -};
>> -
>> -int preempt_dynamic_mode = preempt_dynamic_undefined;
>> -
>> -int sched_dynamic_mode(const char *str)
>> -{
>> -	if (!strcmp(str, "none"))
>> -		return preempt_dynamic_none;
>> -
>> -	if (!strcmp(str, "voluntary"))
>> -		return preempt_dynamic_voluntary;
>> -
>> -	if (!strcmp(str, "full"))
>> -		return preempt_dynamic_full;
>> -
>> -	return -EINVAL;
>> -}
>> -
>>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>>  #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
>>  #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
>> @@ -8782,7 +8842,6 @@ int sched_dynamic_mode(const char *str)
>>  #error "Unsupported PREEMPT_DYNAMIC mechanism"
>>  #endif
>>
>> -static DEFINE_MUTEX(sched_dynamic_mutex);
>>  static bool klp_override;
>>
>>  static void __sched_dynamic_update(int mode)
>> @@ -8807,7 +8866,7 @@ static void __sched_dynamic_update(int mode)
>>  		preempt_dynamic_disable(preempt_schedule_notrace);
>>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>>  		if (mode != preempt_dynamic_mode)
>> -			pr_info("Dynamic Preempt: none\n");
>> +			pr_info("%s: none\n", PREEMPT_MODE);
>>  		break;
>>
>>  	case preempt_dynamic_voluntary:
>> @@ -8818,7 +8877,7 @@ static void __sched_dynamic_update(int mode)
>>  		preempt_dynamic_disable(preempt_schedule_notrace);
>>  		preempt_dynamic_disable(irqentry_exit_cond_resched);
>>  		if (mode != preempt_dynamic_mode)
>> -			pr_info("Dynamic Preempt: voluntary\n");
>> +			pr_info("%s: voluntary\n", PREEMPT_MODE);
>>  		break;
>>
>>  	case preempt_dynamic_full:
>> @@ -8829,20 +8888,13 @@ static void __sched_dynamic_update(int mode)
>>  		preempt_dynamic_enable(preempt_schedule_notrace);
>>  		preempt_dynamic_enable(irqentry_exit_cond_resched);
>>  		if (mode != preempt_dynamic_mode)
>> -			pr_info("Dynamic Preempt: full\n");
>> +			pr_info("%s: full\n", PREEMPT_MODE);
>>  		break;
>>  	}
>>
>>  	preempt_dynamic_mode = mode;
>>  }
>>
>> -void sched_dynamic_update(int mode)
>> -{
>> -	mutex_lock(&sched_dynamic_mutex);
>> -	__sched_dynamic_update(mode);
>> -	mutex_unlock(&sched_dynamic_mutex);
>> -}
>> -
>>  #ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
>>
>>  static int klp_cond_resched(void)
>> @@ -8873,51 +8925,6 @@ void sched_dynamic_klp_disable(void)
>>
>>  #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
>>
>> -static int __init setup_preempt_mode(char *str)
>> -{
>> -	int mode = sched_dynamic_mode(str);
>> -	if (mode < 0) {
>> -		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
>> -		return 0;
>> -	}
>> -
>> -	sched_dynamic_update(mode);
>> -	return 1;
>> -}
>> -__setup("preempt=", setup_preempt_mode);
>> -
>> -static void __init preempt_dynamic_init(void)
>> -{
>> -	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
>> -		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
>> -			sched_dynamic_update(preempt_dynamic_none);
>> -		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
>> -			sched_dynamic_update(preempt_dynamic_voluntary);
>> -		} else {
>> -			/* Default static call setting, nothing to do */
>> -			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
>> -			preempt_dynamic_mode = preempt_dynamic_full;
>> -			pr_info("Dynamic Preempt: full\n");
>> -		}
>> -	}
>> -}
>> -
>> -#define PREEMPT_MODEL_ACCESSOR(mode) \
>> -	bool preempt_model_##mode(void)						 \
>> -	{									 \
>> -		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
>> -		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
>> -	}									 \
>> -	EXPORT_SYMBOL_GPL(preempt_model_##mode)
>> -
>> -PREEMPT_MODEL_ACCESSOR(none);
>> -PREEMPT_MODEL_ACCESSOR(voluntary);
>> -PREEMPT_MODEL_ACCESSOR(full);
>> -
>> -#else /* !CONFIG_PREEMPT_DYNAMIC */
>> -
>> -static inline void preempt_dynamic_init(void) { }
>> -
>>  #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
>>
>>  /**
>> --
>> 2.31.1
>>


--
ankur

