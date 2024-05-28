Return-Path: <linux-kernel+bounces-191556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06F8D10F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AF11F218D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2138DE4;
	Tue, 28 May 2024 00:36:23 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF4D272
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856582; cv=fail; b=La8Iwh+dUiciRcx6aAhG111qQAvcZUut+8uBXmqDXdM12jNY5W5RN3Tq65DvGXMiuBDY6+y5ZyLko1zD+Z3aowQrpHp2iF3Sv2Nf2xQQfwOhg2BxuiG8IOPhznNKRiGB2PI8ZROCJrT8d/iXa3XNJG4UOvGHYXyjYRi1BkODR/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856582; c=relaxed/simple;
	bh=XW4i8uTn8Fv2Z6JTq/pSf6/wJE1eoyRWuPRdMPf1aw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YC5Atty4XDuPpb0/dtAiNmKlyUgLmNSgMrsLRbb38sgazzapJGhOrXMJ2LL29Y32mWTVAbQnpd1+mxSztTG77poEge+oNKuY+3dGmOCUwe7hKHSNmcvPO+8JJ+M1bkMwuOd1GCiUclHrWqKCyLE7YGJF6lDVgStBiR7hzFaMIuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDIL7Y009387;
	Tue, 28 May 2024 00:36:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DxHZ/le4D50uzqj/o/QG1JATYD1j1rn+0MhLkCMycTHQ=3D;_b?=
 =?UTF-8?Q?=3DPb8sEEsd2hcRo5tlodMLmr0P1PidiYL9GvCQRoqPtFxwi/O3td/roo/jhgu7?=
 =?UTF-8?Q?5bXL7sZi_fTfK/Rm2Yw1efxgW1UwFz8NMLK7VjQamul5UPhJGGbICx7u8tLtoiu?=
 =?UTF-8?Q?I/ekHFgzNh0wvZ_S5aUdqc6+w7BGnUJRFTRQ8+yAIiogWxUugbXSq4acx9i/bpk?=
 =?UTF-8?Q?xTVX/Xe4EwrBwyPV+og0_D6bHf4a9qRMohljvzSRFihqx8kjMPjSdOQ5pckcTSK?=
 =?UTF-8?Q?P8RM0hnC3UKAtkGWYH1JygJcqg_w9QPk03HWWE2D8mH1IXSGbK7KPzwtQyHu+/R?=
 =?UTF-8?Q?m0XXjdvY4T8NFYcOj4qK0/+j7BOjL6HN_Sg=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLZ3SN025791;
	Tue, 28 May 2024 00:36:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKJwBf6eWIc5V8OVO5dWFA9YmwCl9brgB/ooSrN0ZRbaFU69kpIpq8lPR97nok30SHidf8a91gybTf7wjTHHWmJZRWnYkzmTwo802Ks+2jAy4GGBEmnEW4u9EXMZCBqCR3ATjrk7ZAWDrG13QaO8zTTywHvdH88N1xiwZHhgJu6nSRzvJqHwJZFsQAJ0bU/kEM4G0hpSopcx1j5LrW+DXe8DLhyOJMMJlcrLOc76bYW6Gjpa2rE6HRKtoDDMSjl7U+VBFI+RfycRrX2Oswbr356YqQ51DrtxMKGNJfeUBfUisOAvj85kj/gjKxDKneY8Tv/YmH/acDC72cjVlRlVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHZ/le4D50uzqj/o/QG1JATYD1j1rn+0MhLkCMycTHQ=;
 b=bcF4cFODAqly5Qu8vWC/7PV4EFGU+1Hx+tfiElonsdbJxXsp6Jj+MDHI387P4SYjqzVqReXU+MUXraA/e2Yf/v8hmH2ofUm96UyHEaTH2Yj/dJngmAR7WDhCSfvcMdPqRSl+zQyNsQrURgRUSSMHSfI+bMkKWaPIDi4RcTpU0zZAGFZYHqm81t5LzFJYjNTAVNkgcdAwYdbObBui2E2aZFVRHk47VT613dKUvSA8/e+wohpuNI35AVwAzkBJ8p20A3JwL5aTQapBjMHAEYVMoeQAM0Id8fUPosGxZ4tLFlmqOABjJjxVFpwg2PfWO5rwwv32Wbct+goTA74iwHhUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHZ/le4D50uzqj/o/QG1JATYD1j1rn+0MhLkCMycTHQ=;
 b=ETo/iqF/TDLASX74Ch85wepHyIKEzfYE/uyCoXzaytvh0huQUna9D9yE/A0yD+4GEVmIK47rx8itw4PSaeQYbSfedreF92/vD/5185MelnrAfJ5S+XgHxex7v7eIZc9suD4xkCxatWfeIplo30CdZnN7mrbVrufLHqixZvwdRsQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:01 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 11/35] sched: __schedule_loop() doesn't need to check for need_resched_lazy()
Date: Mon, 27 May 2024 17:34:57 -0700
Message-Id: <20240528003521.979836-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e8db62-4a52-43de-699a-08dc7eae2625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UFJlEGWDqK5Fy1Htzu/Q1Tvya5G2Cq/rkFVKsHl3/wBe2x6NHydoz01CdAAc?=
 =?us-ascii?Q?xd7a3X0WxJqRwwlgY491LMiQkdTGiQpAzXDScxUJTlfBc1R34rUc/gVYqVXL?=
 =?us-ascii?Q?LwnGj+aNExec0kYnExpJEcdTofSyNqjEysMwNlQqPnejQvIvV4ZhWkWL0JOa?=
 =?us-ascii?Q?cNCEQGq4S7l59zuzs92gemVaXKmP49VYVgV15WkJV5+VReEJZq6tin+QcE05?=
 =?us-ascii?Q?nmg2nYdVi0BKIU4h16i7EQ5NEwdj0U/lOvqLxvXbEQx35IWG0hci3Nb18G47?=
 =?us-ascii?Q?6Cd7ZILDmdRs21g+Cl3rFNs6qAGm6eqxPvIzobd+orzNxDeoKdM8D3OL7J4G?=
 =?us-ascii?Q?668zrfl6OVkwkt13xT/84g6p0T/2ST/B2NmWJkQbzrLIXBtz+eXNh0/gN2E+?=
 =?us-ascii?Q?xB+h2S2+gkoe6JIXUs4tGHyPLLWF3Dx/5sEyirh3i8p8DUiIQ2aELfLqLCLO?=
 =?us-ascii?Q?kIHYg5Hodpvql9YKtDsA++vwEgku5qnTHbIUBedkuUDmGFO8f/vFt/kLmiZt?=
 =?us-ascii?Q?YK9+o1dNM8Pijus0xGEjOeZWMIWsMg3lPUvRN9Efy3NZSm7aNSWRTZ7SYx0T?=
 =?us-ascii?Q?Rm9Pxct1KQ+flr48EdZ5RY2jZn7XzAQC4gogdxeTywbsd6+iPYw5pslAH+Z4?=
 =?us-ascii?Q?QWkfiu84r4d56F9kqm4hQToEQMA+zzxX8uxV5IYcQ1P5/8OspPbZZE3iBpQK?=
 =?us-ascii?Q?tGa2wHmCEmzBt7iv2/Wzwbz/s1zsfIPTF6d9zvIBgbnO7CKT1sasbJeTYiHe?=
 =?us-ascii?Q?DSgeW2hgiesAYqSJgfleODxSnhVTbyoJt04efcty9WHHb0HjnfjYR7B0M5Ju?=
 =?us-ascii?Q?w5ZQ4Hw3CZ3sMYsPShTYp6fVZbZTw/rDJtaoIKKehdMb5/RhNivh7zi40W80?=
 =?us-ascii?Q?REfUh8UApNaPAg7bkiaFsJophnndQvo1XGZiLAznWAiDyMroW4B8T3bMUsqt?=
 =?us-ascii?Q?V1mRTpoZno/V1InYQqPcrD+6oMakvDCPTT7wIm8Cq2o6qfNKYatk9OS+vG9Y?=
 =?us-ascii?Q?/ei9QOW5fSliXRxKvhw2b19WPrHORZBcnusErR62mDKKWkTSwyaYlzolvYeN?=
 =?us-ascii?Q?0JabZue2UY/Ls/+qfkHTQt52Ne8ET4UE0I1+7Sy6VWeUWTEY1C12aVyHSmZJ?=
 =?us-ascii?Q?UtZdst81P2c8HLKTajzV4PHOslHJ6+CI56XnEfOA3XnQvZU6C5pP0wXO1PBa?=
 =?us-ascii?Q?s5Q0nQ/weSoOkCyPpjANQwvVpRQk2+896IjZRg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sZ7fQCiXxofVeHOfvWqrD1f5eRcFXDTULkJ3iU3kICISD6RcuZtxDp3wk4st?=
 =?us-ascii?Q?mB5t8cbKT2YjR8owhS4Dts66qWKqpSv4oX5W3Op936hkhoZFpbPZObKj/46w?=
 =?us-ascii?Q?4Buxi6bEMTGl05DvodZGYfM4f4ZzyiDfRJFib4TUnfCHVAaHomH/llk6Jv2q?=
 =?us-ascii?Q?YNtg/nTOjMjiXr7fIe/Visr7mRyLplCXfadEmOkEzeCMeP3/LgWMcjjcNSDP?=
 =?us-ascii?Q?03cftltud920Cv1JwtOBGcfiWLTKQ4Ho4GKGOEvu1bemdzmInLgOw4bU6Wp8?=
 =?us-ascii?Q?gdLpFHxPUaMCZBTvp1/oh2WKnN6T88e3dr0uhnTrfjFzWu6pm2mTP7sgjtPN?=
 =?us-ascii?Q?pJB2kKYFTA6B72TUiiPg3tBCGwRIprS/oECu8Gf69XeQhMTxbluKr8nso6EB?=
 =?us-ascii?Q?IMf0guJFxME3CN9g3reovIIrS8/8So/NyysdhEq/hhK6vcekqdF3KRF/fYO0?=
 =?us-ascii?Q?VWQBfQS5RcHD/9ByzoC+snhUK0AaoWhhUw2uN0v5M36vkE7HZ7qiUWPrlc8Y?=
 =?us-ascii?Q?Ks51lyV40j6H4z8IjIv0QVUS3OQi/E2lNcnGnwquzAcIZPzIf9msZoNpFYeq?=
 =?us-ascii?Q?ENWUaGjxN4g6152uVCuw048MeWoWqKgu2oYAoJC8gVGJ0oQqDrqWW7GKCvGx?=
 =?us-ascii?Q?uP9GjklSbbGdnQAu80jTk0VbfaOMV0CuQa6W0c2Kz8rcNT8K5Z1hNyl9gd2u?=
 =?us-ascii?Q?+RxErZh5rkw983jLA+DUfMue/Y9ew+aU+S8E8EuoPoxdyMAyGxtfjZIIUfZi?=
 =?us-ascii?Q?sBIn1wCdXfHesO9ZT9b2vPJCnybU23ED5xMJOkiz2ikwtUca3NEBaA7akUos?=
 =?us-ascii?Q?xjTnrg+dr8eEIJ/SRrxIn2GwqzOvwE7ahqmbSEbHNTAAGbZDD0SOBJFsHTX6?=
 =?us-ascii?Q?qt9CSYRxJtuYcHlVx57n9MWsfcRX1Cv8g3AmaS4SrkcX3Rmj2gQyXWxGF3XS?=
 =?us-ascii?Q?obMYLVBwIolRl65V3lfbgAogPpqCbNK+GKH0vkgvMTHosDP9pb0D60HEqptf?=
 =?us-ascii?Q?9zGvktUF3p/8qKn6tpUJh6CtNZtkriBSLNEX9R+Nb0kIV897RJSwfHEYZS7T?=
 =?us-ascii?Q?KYTK1aT5Tc1hhJPNCSrCdJzXA/swI1ntg6W4FweR5dGpHceMmDHhXq4oSogy?=
 =?us-ascii?Q?g05I2JHcUidVHM4zYvF+PHpX8d55Nen+HfYmgcEuj+bxMqGYwJO8b3gP5bga?=
 =?us-ascii?Q?JQE7RkG8kOsfDWyw0b5/Kd666yMp3Z0zwUWtofxDY1E3Yyiy8hKVIorxJH9a?=
 =?us-ascii?Q?ul7B3zefoDBmYYXgBjRhhQbkR3O0WpzzsSFwQQTJaXBdqJ7vDLbkcnyhVMUs?=
 =?us-ascii?Q?FMJ0dvZmPERcdavZGe3Ha4WWJHLAGTICMTEOmWdyBjET/YkkoCuVd8ABdIVk?=
 =?us-ascii?Q?jWgxVPf31ut8W9qAFxNmKuzJepiGMQ6zkttfpyqjUm8xYyBQ6WONIvWiqIdL?=
 =?us-ascii?Q?zxiMxTn7TSO2B9rYYQ05Ib94cA4zzIVSTtKgKBSxpCJs5++giErzWdc3ujj5?=
 =?us-ascii?Q?Rh+MNTLVL1WyEztKBCqqSBTraz2Is8Jn4GFh7eaowpUm2CXtL8gkj5QIeLBu?=
 =?us-ascii?Q?peqesSdh7S+IGJoIr3j1M9v63R7siGyKhNNMhzvsj8tus0lUGkhr6qsGNBrH?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uK7c5mXdgnHx29WeblvBArUVjU+ZYGNelTnvz+Lu2/bTJOn1Cw5GAeKE+JYFLw/RcsQiW5F+oXrIggQoGz8B0KkZxNkPHuXjt7ngzmj27xHe3nVQRB+p3eq/niB2RtrjbgIGgESNUtkRLnzNICGlFaZUHwYGl+4vVyfuDP0gX6efVu9BfGcfneqeac662SOZ2DLXGE0hDJOEgke7Y+nBpLpB0y0EVWFt16w2SGn94bgkl2m9N4VNmkiEVT7uFUivVbaK4qAUwyLcp2xDmfakNreR/Sf1CvXaQop6CUF55kYKRYSPQ/KQtWLJxuiLYIUYXK5wQgIJaKqgCTpllouzvuR4KdqOo7C/w3FLjn03nyFp8/UMGSYs0MtKNu9s19q50nbCKi9ouZ55MzKdg7ZSBiT7rjZAMGmk9hNAoVObBNMRaKbzGUyenDWOpJSkSuLksJhPqO3mBU+348M11FSPhHwbVEZcn52hdJ0AW3Oje24h2Lm2a+DMmwk0mBPU4Cdy+jWW5rDDtpjWLN6kUkCw05riWSBUfnYuu0VjOw356dNlPE2gWBNOdrtHrflshM+xDpGqLq3omKS+gX09A4OcquAvW9dl9rEsJ40XDZ2Lme8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e8db62-4a52-43de-699a-08dc7eae2625
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:01.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWhMFlOQTmWSdg1YrOO9NQtRUlH/ekPhaTutWho1oAnkqcGDjldbbhY3vXqc2XNJliJSYBAmCRIRJSaJgnjDy9Hk4VQaWW5cqilB8wduVwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=690 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: x4FTu6GFzsKXML3cIjG-gtRpTD9OXSQG
X-Proofpoint-ORIG-GUID: x4FTu6GFzsKXML3cIjG-gtRpTD9OXSQG

Various scheduling loops recheck need_resched() to avoid a missed
scheduling opportunity.

Explicitly note that we don't need to check for need_resched_lazy()
since that only needs to be handled at exit-to-user.

Also update the comment above __schedule() to describe
TIF_NEED_RESCHED_LAZY semantics.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d00d7b45303e..0c26b60c1101 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6582,20 +6582,23 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
- *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *   2. TIF_NEED_RESCHED flag is checked on interrupt and TIF_NEED_RESCHED[_LAZY]
+ *      flags on userspace return paths. For example, see kernel/entry/common.c
  *
- *      To drive preemption between tasks, the scheduler sets the flag in timer
- *      interrupt handler scheduler_tick().
+ *      To drive preemption between tasks, the scheduler sets one of the need-
+ *      resched flags in the timer interrupt handler scheduler_tick():
+ *        - !CONFIG_PREEMPT_AUTO: TIF_NEED_RESCHED.
+ *        -  CONFIG_PREEMPT_AUTO: TIF_NEED_RESCHED or TIF_NEED_RESCHED_LAZY
+ *           depending on the preemption model.
  *
  *   3. Wakeups don't really cause entry into schedule(). They add a
  *      task to the run-queue and that's it.
  *
  *      Now, if the new task added to the run-queue preempts the current
- *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
- *      called on the nearest possible occasion:
+ *      task, then the wakeup sets TIF_NEED_RESCHED[_LAZY] and schedule()
+ *      gets called on the nearest possible occasion:
  *
- *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
+ *       - If the kernel is running under preempt_model_preemptible():
  *
  *         - in syscall or exception context, at the next outmost
  *           preempt_enable(). (this might be as soon as the wake_up()'s
@@ -6604,8 +6607,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *         - in IRQ context, return from interrupt-handler to
  *           preemptible context
  *
- *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
- *         then at the next:
+ *       - If the kernel is running under preempt_model_none(), or
+ *         preempt_model_voluntary(), then at the next:
  *
  *          - cond_resched() call
  *          - explicit schedule() call
@@ -6823,6 +6826,11 @@ static __always_inline void __schedule_loop(unsigned int sched_mode)
 		preempt_disable();
 		__schedule(sched_mode);
 		sched_preempt_enable_no_resched();
+
+		/*
+		 * We don't check for need_resched_lazy() here, since it is
+		 * always handled at exit-to-user.
+		 */
 	} while (need_resched());
 }
 
@@ -6928,7 +6936,7 @@ static void __sched notrace preempt_schedule_common(void)
 		preempt_enable_no_resched_notrace();
 
 		/*
-		 * Check again in case we missed a preemption opportunity
+		 * Check again in case we missed an eager preemption opportunity
 		 * between schedule and now.
 		 */
 	} while (need_resched());
-- 
2.31.1


