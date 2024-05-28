Return-Path: <linux-kernel+bounces-191576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE78D1108
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6BB22304
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748B13C9CA;
	Tue, 28 May 2024 00:37:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1FD13C82D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856638; cv=fail; b=qqB8ffJjb36pFb3ypSXGBwMfWxg7L5PKE155QUruuQK7MH+rtS8Z75NO9wjx7Xw8bPOjsD6AchzGEAghopar/4YFw5UwLx6EIaZyFQvO2pUcxM29RBf/nYmnNcyH76VIuXDihkGcr3IjhuMmckDpCYaYO8AJRSW5Jg3VfoeuYo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856638; c=relaxed/simple;
	bh=CzD0C5NDej4M2l4uIwFyLE4WN1zfmfT2PXt9PNXNBJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyTY6xj27gzKTVHYMCrd0DmPeN1iXoChlMjpka44I581HY6mIsU2olNEFxoHiVybHuUWtMzeZciHNThmNXE17eiLpijZG49P6zM94qkhaFzIdwJyOGg7VNL5mk3u2Is/r3AmYMR8S0smsjAZF3hgIZtasQtUdKd7vKMeTi2V9Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDINsK009429;
	Tue, 28 May 2024 00:37:00 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DUJUu463f23ohZqqHp/D5EAwaqO09+223Nf4SOKut8Gc=3D;_b?=
 =?UTF-8?Q?=3DV1eF07/zACuboF3rSRVxVJU8t970kN02xOTlhH+JW40umVcuGMs4CQTeDPfD?=
 =?UTF-8?Q?cO3f6/4F_A61/OS/a8WdIoqBh5Fzc+YJqdjuv1B/F4lafa1ILYv4HfSo3aSBTQB?=
 =?UTF-8?Q?EaydrktNTHzx6y_Z4VOf52tOspCiwHVKbrqJP1msqczs6prrObgDTCyCL59I4l/?=
 =?UTF-8?Q?nCdMQVPWGH+P8OHeBSHy_DguGHvQ7+seqSlIkbybXTnNS3aEV/Mq5SXZYYUm+s/?=
 =?UTF-8?Q?pBn8ii/AnAj3fQEv29DmOiA3AJ_7kl6iE/4LlbvgKCidLIt3X8eGW44cf2OBLVW?=
 =?UTF-8?Q?s8G5w/dkdO71W4ipw4Iv0vJCWRSJc9dC_yA=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKdPcv037607;
	Tue, 28 May 2024 00:36:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057yh0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi7fMTDKdciNZiOLYbqBvEm+zZ8shQPlV6rOY64vLgeqjF/dytSPPYMKirCC5c9JCxVACV79yQcsqoVKPUgFlS/wetKTmuBR7OQ95caEhck10IKaNSPKWdVDQTNw258TYkZ7sQnojV3oyWswqHX+7d5qof/54ijOSCxzxa2jXEtL1svmCsuYSbrinMYWmnMLBMFTo/InG2dNmAnX/2kYLLACJXHmeuypWJgdYsfxrpFV5K4EvEzz0Jk+Z3YwPRs5ZUePkl2pkeGMawa6cSLmpUMT1E0FEWff37V0DKooYUfm3oavT0VGVuueDnWIN6Ny7xXV6DEK31f0nBSQgAKk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJUu463f23ohZqqHp/D5EAwaqO09+223Nf4SOKut8Gc=;
 b=BlFjaZcD/BRT5pi7mWc6KruNmanUqxQbpSCIguwmlCzWZcmeiel5yl3W/Ea2AJ9+3lv6Un5sb4LEFXCz2Q+cU88t4hlj342Ph3RTB5oRO/Tf4ZFhRnOk8jCL/QAZnnhlixWUDMj0fbrL13mIwmZf14FGMWZ1B6NPLJHJQEkJ5xSD6KH22IDuI3VX+r3xTcYLIu1/O9hTyYQnXzVxK8W0Yhz2xI+uMio709LNQrUXyj/tmmaPEhqJNJ4I0wwrrOx7U3LMSs/NSJNdxG9MOB6Wphypee0rP8eUgfE4Lh+3p2SBWlxE271m7S4VhTWjCuXsp+s35aR7lj8yGDzBWdG3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJUu463f23ohZqqHp/D5EAwaqO09+223Nf4SOKut8Gc=;
 b=RxGehzo78OA3wOGte3cVGytNL8HnSlSG06q8mZbePJNfJHE/de4mveUO1jsgk5G/AQe0f2TUgHlfp8tkOKwkpX64/FpjL+gqeQTw10Uzrp7AJmVzQCj5Z1bC92059R5zh1y8XM3d4w5+dH18emIqpT+LnpRXbEj9KT1OksKQWLM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:57 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 31/35] tracing: support lazy resched
Date: Mon, 27 May 2024 17:35:17 -0700
Message-Id: <20240528003521.979836-32-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6834cd4f-13b5-4913-7c69-08dc7eae47cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GprEolY5ushbyt7nIjpFV0556VH32aTL2sy/ww6JesV92BCUff54j0vbGxP4?=
 =?us-ascii?Q?4fhCrnCEAA0dDoiKY1JPlLJDB7VcvciafsDvmgvffTViYG8eYBvdl1KaJHV0?=
 =?us-ascii?Q?ENnoYzlmM0YRkGUMbo+BkMOr2hhJRsoRapTqxCOLqXtqh68vujBXng5E+z4l?=
 =?us-ascii?Q?0q0v6dn5/tFueKgs9S+GhUMe54Q6M/SkH6hIV1OZ0MnZrtzxygpj7tzGp3GY?=
 =?us-ascii?Q?F2AY/FJ7SETLNYsQFzCt2cHjn80M5vXygI/0DQrcjgqh9ke95ewg1qBXRJOE?=
 =?us-ascii?Q?Br/XY87viPEnX8cVbync+WHRZ+9CYFztKD5GxbY0xQOpeRe9RqzeyFwLwv5+?=
 =?us-ascii?Q?CQ639cpQfI+Y2rrfQNiDrlSI52pee2RnOcaYXzQwOLset6psbllnr6YgG99I?=
 =?us-ascii?Q?szCxLH2vf9yod6IDwrPSq3490XkEiVs+hoP2EHZMvi29nbMYDf6X8y5KuPI8?=
 =?us-ascii?Q?3OrDufN8tKmkhoJrt/5HcSoH1dRJ72s3DmyhUW2xRaAi3B3SxoD8I15VNLmg?=
 =?us-ascii?Q?tgupzWVAAI2iY9wv8tu79/TQhDVkPfzKFWOhufqve76gUNCO6gXrk/VqZvpS?=
 =?us-ascii?Q?57dwnz0uh14OvVrA46MSe+N6kANnf9Ap7dhPDK19JtMqqT1L62eq48IOSRq8?=
 =?us-ascii?Q?HEj5RgYsW2gYOkU5jKbNtoBnuxqD4YlHtoczTDPu7K7X9wDRJbZMeXrikwN7?=
 =?us-ascii?Q?+gpUOcZh2Jbsz6lzFhwwavQjZ2RLhlP2x4RUm7JIaLPDptJPUQBNURYspolA?=
 =?us-ascii?Q?WfsM+jh8Uy1zuvBUbUaBBm9imompPS33YYafeGQ+XYdx4yXSk0fGvdukD3zJ?=
 =?us-ascii?Q?7PG33IKkKodliP9VjBvuhSYhg0nL17bOo4l9fbOqOc5Y51b+KGpjfVw1Plvb?=
 =?us-ascii?Q?nVwPY6WD+MEMbLkfScy/9hp+EGU/nWCjC/8+Grj7BuytQU+fEwqK8H5dCSnc?=
 =?us-ascii?Q?m7leTv8e1gDkIXb1fiDflKLHLfBRHAjcQHiXiOYuKotKeCRe4G7fSnijzxat?=
 =?us-ascii?Q?9cmw4zA6rzCXXDmSeprXgrTpDXlMXM/R75GMnPv9hDejFjnu+sZ37LVz6oaM?=
 =?us-ascii?Q?HIQUVpIKJvbb+L67qSJ9Oy5CMxdBA9VXmYLH8lybky8RzaDh1+JM20WNOrn7?=
 =?us-ascii?Q?dm+ETNgkZVtm1U6qk+ASaN6Kbge0YdtnlLcBZz1wCfM7myic1zHa1bHuvdp3?=
 =?us-ascii?Q?OtJNjceIEZQiBnx9Y9E0d9d7aV2iVx/mdUbjkElJ68ziqzA0pRKx1axbKnQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?taBzYBcKW1jcV55NTYudUFlUW3fO/TIqm0Ih1GKiQadlTL4U6eaiXY5fGJCN?=
 =?us-ascii?Q?oDYZ9cR0PURlxTENyq8kzXqUCaJnVc/c5ra6ZTJ1SE6Ev5CGjGJrd1vhDyrP?=
 =?us-ascii?Q?2MOedb8IYVi5eq3KksoT5a96hEa7aEUEwblff/6esAqfsENwaBACswxWX8UQ?=
 =?us-ascii?Q?QlCj4x5qAw+VR0UhIBuwfmFgs7czPnFelQATPdQwJcrzpMk9d6cnryQmGjDl?=
 =?us-ascii?Q?eQ7MW+shNb07kNIxQ0ljraUlJdk7DxEpv/29zeLGCeJhw5tPlnqG+o2JPrrx?=
 =?us-ascii?Q?MSaWUbE+hcDNqwNZ6XZqeOVzNJJNG1zUGzm0F7yqp/8YYbdCJdb4UFWFKNBV?=
 =?us-ascii?Q?vCmJ5uOFrsgm6m9I7VXhRXNatjss/mRWLGpO0yUgtraStCQHmKKR1sUzo4/g?=
 =?us-ascii?Q?WqzV0hwA9EeGmeZ4k9t09UWdfrh9m0a8G6HaRFyGgFPVUOUqFuG3bM7WICLS?=
 =?us-ascii?Q?TCcMgeZyYpiXEQpQpouj9RAGA00TmsPOSBz8lSAcfdu1ngkc+eesTp+boFwF?=
 =?us-ascii?Q?CbVvP+I+emrZZeDp4kACGtZ1LnzhofQQo+kXoU3qGkyZKU9oOJk5L4LahYwH?=
 =?us-ascii?Q?6dilouZwoXSN8lakMZNFtNWXoA3a3FRn2ZoH1Htvc30jIV/xv4cY9diNU7Ae?=
 =?us-ascii?Q?Vy1XPvP6/MI0xgEoLjhlXzKQg8cQ7eGenIAMfOJ5CWGUEMQS+xb1w2wEzRcq?=
 =?us-ascii?Q?/aLHyEvwiEFG7JtxbRtY4YcQJsmkoy1uOwEdXoj0dR2zDPTumDrpna6YJtE5?=
 =?us-ascii?Q?OKztTulGmxD+QJqv/deKUL2TvdhgSWuWfkVmGO5DJrKbDRRRcl/Kc4Kqi1u2?=
 =?us-ascii?Q?HXXQvyC4CWwrf3yqLpCDgOlMDMwa+fZTyEbSyfoL5fHfNK+Lt+FdRQMraqel?=
 =?us-ascii?Q?UMFUJSuSUiwuiomutmkNr/VbYbqwdvzuqVgk3BOvfHSbrWYBXqrjj0mpapmD?=
 =?us-ascii?Q?zJlq0UMiXn3282PJqfVpQjnoGJb37TF1prpypUMok9IG/jFP/UFTB3tQKpmH?=
 =?us-ascii?Q?Ps4TU79hVQ342wVvEbBw/BMu8fZVO9CY3/aljF2dzk4YmyV6s6UlunvEjDmg?=
 =?us-ascii?Q?pSS++PRD8SAaHMWCVLNfn2tjDhqlyLmxRxkewfz7Cm1koT27MPL2TsAp+/yi?=
 =?us-ascii?Q?+FiBShPueRHxaNEyp0mB7kPs2r8wLiZm6MC2P1bmZLrxuFyEzYPCBuuwDxyr?=
 =?us-ascii?Q?Jy5A6ev11+SNInjHqHhZsR/GjxxE1VZDEu9XQ4sypdTnHC+G0bWN/F5ygMkj?=
 =?us-ascii?Q?FsV3ZIztrqbP/nq+oEwuLyld8x/9BAWGahzDsHI9cjlW4yLlwZH5kclBHqkT?=
 =?us-ascii?Q?r4PstlSoB29cThYIVFd4ZIx7KXdSx+ffjoF1DPUFYQMNpwSnsPPuqJSjOa2U?=
 =?us-ascii?Q?WFxYrspOKidG/C+sK6loWRHnhp0eW4jk/wduxenn4ZBciZUnd9zBq+cMHFc+?=
 =?us-ascii?Q?iZ+BSwdI+NSrFAt+sQZ9DO3JyFW8Ok4Wf6wTyWUP9woSa+FZdArgKCwgM/MZ?=
 =?us-ascii?Q?MMrgG4LqsmhopgSNdnJm5zUWZuta5yrHIpraJ4c7tiDZBeCLtEwrny4RBAGg?=
 =?us-ascii?Q?VTbxMRk0KeHTFMHRrxqEV5S3ndP9Sxtp6Cmo7WySL3PkuTzb8c6WX6MDUJcn?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q2+Dqck73u57lG2xDieVLhCz+RYQ2fy2DeXlfyXBVPs96Y/uKqXpAvTwjN7oB9s3DwP3Ds/w17ewET9z2MmX38+zOmgjaN4fNT0aImbWbvMJvqc5l6x6QMavLzNPiimS0zbwu8dyDkC2495ji4CDqRSog0CwXQ42CKV1LMVdwLlbAA7a6/k7i+dozwJIiigyXgwSBQeAAmXJyxDSWIqqYnEbDONaiDss0/Frlqi9zmN36hr4XQV912riwti9DQOxjFk178OdJn2zL9dodNMuSZFG3lKv26WIrRyFcXGISjRGEYpnHdGb5Octb1lAXRvqbZTzuWJe0Quo4wmWfWIwrukHLwPpoWpqAcEO3IhLsU6Ba5SC9s8Vo6S676BA+MtNc1nanab8yusDpCsE46uh3psU8/Jgk+B9s739usLywI6yD2p1KnMv3Peb+gGIfA46Mjjmh/KnG1uNdhj2Qm6YCH8fz9I0HxAJqP8rWggrdHTmetvCBqhzj6FSvcaB0aMoaa/+I7mUoSpLSbjILskB022btLO9pMljeA1HIB7xKxrsZN+LBVYdlDeUGsFbePc/UdtCMi6pbjH2PaS24HUXgrqQTirNR1PthlnDlaBkWh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6834cd4f-13b5-4913-7c69-08dc7eae47cd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:57.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tctMxPcMx2p3iZPLwE9eBwGDDTxjMs9VDb/S4837oqaxB7ORh3BeQ/FZC0LQoEiCjFEdswoJu/d6Wh2V17dUIXnCGnzoHf0ILEB3oixzzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: ImPh37L3gM42hIsA3r3nIuZMnMNuw8mg
X-Proofpoint-ORIG-GUID: ImPh37L3gM42hIsA3r3nIuZMnMNuw8mg

trace_entry::flags is full, so reuse the TRACE_FLAG_IRQS_NOSUPPORT
bit for this. The flag is safe to reuse since it is only used in
old archs that don't support lockdep irq tracing.

Also, now that we have a variety of need-resched combinations, document
these in the tracing headers.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/trace_events.h |  6 +++---
 kernel/trace/trace.c         | 28 ++++++++++++++++++----------
 kernel/trace/trace_output.c  | 16 ++++++++++++++--
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 6f9bdfb09d1d..329002785b4d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,7 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY    = 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
@@ -211,11 +211,11 @@ static inline unsigned int tracing_gen_ctx(void)
 
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 static inline unsigned int tracing_gen_ctx(void)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ed229527be05..7941e9ec979a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2513,6 +2513,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 
 	if (__tif_need_resched(RESCHED_NOW))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
+	if (__tif_need_resched(RESCHED_LAZY))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
@@ -4096,17 +4098,23 @@ unsigned long trace_total_entries(struct trace_array *tr)
 	return entries;
 }
 
+#ifdef CONFIG_PREEMPT_AUTO
+#define NR_LEGEND "l: lazy, n: now, p: preempt, b: l|n, L: l|p, N: n|p, B: l|n|p"
+#else
+#define NR_LEGEND "n: now, p: preempt, N: n|p"
+#endif
+
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                    _------=> CPU#            \n"
-		    "#                   / _-----=> irqs-off/BH-disabled\n"
-		    "#                  | / _----=> need-resched    \n"
-		    "#                  || / _---=> hardirq/softirq \n"
-		    "#                  ||| / _--=> preempt-depth   \n"
-		    "#                  |||| / _-=> migrate-disable \n"
-		    "#                  ||||| /     delay           \n"
-		    "#  cmd     pid     |||||| time  |   caller     \n"
-		    "#     \\   /        ||||||  \\    |    /       \n");
+	seq_printf(m, "#                    _------=> CPU#            \n"
+		      "#                   / _-----=> irqs-off/BH-disabled\n"
+		      "#                  | / _----=> need-resched ( %s ) \n"
+		      "#                  || / _---=> hardirq/softirq \n"
+		      "#                  ||| / _--=> preempt-depth   \n"
+		      "#                  |||| / _-=> migrate-disable \n"
+		      "#                  ||||| /     delay           \n"
+		      "#  cmd     pid     |||||| time  |   caller     \n"
+		      "#     \\   /        ||||||  \\    |    /       \n", NR_LEGEND);
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -4141,7 +4149,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 	print_event_info(buf, m);
 
 	seq_printf(m, "#                            %.*s  _-----=> irqs-off/BH-disabled\n", prec, space);
-	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s / _----=> need-resched ( %s )\n", prec, space, NR_LEGEND);
 	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
 	seq_printf(m, "#                            %.*s||| / _-=> migrate-disable\n", prec, space);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..4f58a196e14c 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
-- 
2.31.1


