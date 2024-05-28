Return-Path: <linux-kernel+bounces-191564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FB8D10FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9201F21E09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03578175B1;
	Tue, 28 May 2024 00:36:51 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2547535C8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856610; cv=fail; b=sleAFo6Ebzy/we1gIkJohnpDZvqU7HasVVfa65KeE4h1DQ3vGiImv6wOHzmLCT+YPmW7dLTnqNsx7fJ/alX69UaqIdl2ATPyReBk940tyOC55Kl0/azxdxzDpdYCurbD32u+CZQVRPxYrS34NzXttndFnhIX7RR96SeL/F3ruow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856610; c=relaxed/simple;
	bh=pFFEtNF29QjVSmV3juAnLq8xxpb3ZcqB3rksPbjPdSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1vFUtOj1is+X5inGT59rqb1CwNbiukq4pkKjRryK9uv1F2u2LSWK5KVLB2CCiuRiFNkGwdWeIt6DEYGKW+iQ5la++gYkhh8CssTcMA39pPtRREAHiKtNNvBrVwmrL6YA+JNHIFGF21Pj93Oy7P4vtxQ9zY/I5pVB1//6jZhk0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDJ0dx009949;
	Tue, 28 May 2024 00:36:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DKZQI1pM8qBdXbTW5LTlM/+np2rpT/vwfpcvHevKNdnI=3D;_b?=
 =?UTF-8?Q?=3DXHJrh8wO3nSfaY8aNdRHp2p3ZpF9toCKo2n6eRohWG16+yKSCYWrycLfU8pc?=
 =?UTF-8?Q?GjQZ0yEU_snoNOdNuYPBSwSKyzcB+sTtmL0UaSxTl4X4RkoSVqWzIHcXbjzXalb?=
 =?UTF-8?Q?YqeZkfzJZxFbXi_m+AzkXX3S5MCuf+2WoVKo1+9zCwJqINgyDE7lCCvjo5elIKL?=
 =?UTF-8?Q?hvWRE1SrQXDRPIkujT8N_/L4pU5ZrjCWPqrZN7/cYIZbqJUV77S4sfjOFVze0Hg?=
 =?UTF-8?Q?Mqf1Uk+hLcR75WF+pFGQJLHvvF_wKBwRf3B4v4xI0GIoAcfixxF5Y1YPXbGGDaE?=
 =?UTF-8?Q?wfTIZHt0oN1cM4ULKt0zb9ehYFhxx3uz_ow=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKf1Rt025740;
	Tue, 28 May 2024 00:36:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xsy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0FeXPeXkCOHMHJ4Z91BM8nCQogucZLal3SVpCNPts8xlcbBsfq8vrX0dThym38nYAKEdhb5k9WP48ZtLmzYNiOuwwwEC5SSe5ywn1Jg5lWFzYM2LM36mz0J4rsme2oZIZOh/V+wvESaHiTdugQmicF0iR/s2sMqYgxWoMSX7cTJI4l0FPuHC1bvZ4e6AZefk6vm/3dmCxCd8FWvTOrJIb2x8xUtv4y6Ah2CKLZExxkTxrQT7MZi0jv393rCGOY1z5NrZcASCzwBaCbbznUuOrMJ0rSwoqW01rjB2QOrVwGtoUdaKhTn57Itfa6PoO7OX4mlC7w5AKOUwNF89HMWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZQI1pM8qBdXbTW5LTlM/+np2rpT/vwfpcvHevKNdnI=;
 b=bBmgEuCKPcoFVeDGUxMoTjJANU+MqN8G1LZyXDLQpPZtmiQ8GD2h3amhTsl84NshOL5SIXt0aFLDkhONZqsOzOW4d53Si8F1CvyG2QPNCjd5OrwnxuYvkGWnErwdf6pqtOlL9ddkFrkLir4lGgaBJ/1w0sxwLO5pWdOZJDVl2PUVPFc/9qSGrsneaAR+qiGKAGV4ihwUpvJZj8z2KZGiEx6DhHeoIyqO1LujZjxQggOTyza2DgQ72p1XnjVaNj0i6AWtUvFXgnwaEKm4WsWqRhntLdsJJNw91BM/dolLyxazeiLObuVkZN0+qBTJpqlCLD2skmN3kfbhGVykjVKXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZQI1pM8qBdXbTW5LTlM/+np2rpT/vwfpcvHevKNdnI=;
 b=buvxr1ghNiVE/2nFmmBB3u6O65fBO+B+Fj+voz4fNCQ7wbpHUjwbqLX1K0OslqIk4ANJ4By+PUsJPP5xsllg2gvTvMoYdNfa5JRD4TAzW4zeR5U8lqjVINxOWjaOeWMBDOQw1wKV9UNtY2b/7drBm8bmS2Rx5Sd4mnxE0GYJCNQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:26 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 20/35] powerpc: add support for PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:06 -0700
Message-Id: <20240528003521.979836-21-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: fab33e33-70ab-499f-ca80-08dc7eae357d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HiVi0u8uxGsmPHpEpNAOZBl6M5GwAT7kKNlGDUO1UTH0Q0o9GfosoxYflnJe?=
 =?us-ascii?Q?ZjTPKfAqlDO35GrZuhPs7Nf3BHUna6RISlW/09p6GGZ5vkksQ7U58rvzaagr?=
 =?us-ascii?Q?n/Qk0vRYEnHKqGE72t2EhQZWims+/d5NgKqLSQ0+VpE4ARDZlUoASxv/HpoY?=
 =?us-ascii?Q?q12IWxOGTPdLUslBnhWy4nBZcn5yjT36hGJdradFvx+b0GU/1LufYQgEgJyj?=
 =?us-ascii?Q?1kFYpHTfIE4Y+yUpBnSxgAGH2CW8lxovYHMt6xEwiNX8ylJ3ik08etgp1Iud?=
 =?us-ascii?Q?dMPbiPgOdFhXVxtpFD9DPltEQeugLY4ulYJJyBGZ2rmXuyjE48C7Yd92frAD?=
 =?us-ascii?Q?0cDu9mJcJtB11nZY3oYrXIVNpHtaXsd3XVGpQOnUZ9FXok+0jpVyF0y8pGsv?=
 =?us-ascii?Q?2Eo9NF21mFYEjBTing5+/pY2QTmdvPI48+07MMoQOt8nMFTrbscMRAFEp2zU?=
 =?us-ascii?Q?J0N21tW8IjPpDg9cBvYd9eDNI+aEgUZGHCtc09GR9Epy5a1l5bwM7hXHjrCH?=
 =?us-ascii?Q?gmAfxeqTpFh3/KepNsAPayi/Sp5cgTp6K38vEUDTTMAqvPUIEfRczWkhJgjb?=
 =?us-ascii?Q?L3YSy38/ONefZS6lnk8kn3L0vBRS1ksplMsGOo7kRGHLLAUr/MWdMG3FZRzD?=
 =?us-ascii?Q?s0M9lybrrLkK8gKwXkrisgZv4C/PGxq2jqb3ICZmYXWMF++2rc5vKrJ1Wl/A?=
 =?us-ascii?Q?Rp9z2LGmlAocEppvrv/GSibm5odQpWkjQ3w9mX64fZILN8WHxdjO88OXcYax?=
 =?us-ascii?Q?IWh3nrSUAYKN2TmC+rs5A9w8Vk4tezt6luIJmvVsDz/rE/HxFqw+rAWkd6oE?=
 =?us-ascii?Q?F9GOloQ83N7Di6mQFecj+USBFBfRYRE0qE7a553d5TCGVnKsczv6bywkbtna?=
 =?us-ascii?Q?MELPsP7540os6ky944oE9+rAKZ2D4bgbMy7+fyWc0lurQvncGqiTWdlAJ1SR?=
 =?us-ascii?Q?Y65lovV9SLZigEJcLqPtMfJ6/SmSXDEdS2AYH/fujTF1CByjHU23vUvcz5KS?=
 =?us-ascii?Q?OHtIezdpewfJzRUX+N2fgl2E8jv+/NFNXah6Nwbdk8wQsO+8Ru4pB86PZKwf?=
 =?us-ascii?Q?2glrp8KudcZC9OPwALWJUgqYexl6vla5EIPza/+BszMd44loqEvP8rpUmL+g?=
 =?us-ascii?Q?eggRFL7xax0mhN7ksJ+N+pgYLIy7kLNND36dOsM87JDzpuQPyEhFke+GnPnY?=
 =?us-ascii?Q?NQ+QAH5xso4p8R2PIimG985Nb7fOtqDHt9X6zTBLTWa7R69ND5/yuwPPFxYF?=
 =?us-ascii?Q?OLGnKtKMf5/l0tjAp/1nCTM1zv+48f3VMnMdvqSdIw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tDn/Ra+yDCPOeTn4CbwB73pyamj3QMo1kMAzLSxCPGZEG8f114DwjX3WvYla?=
 =?us-ascii?Q?2HoNbm65yvwXul2deKVB8J171RkLrmF4E8KGRQ9WKuXQGDG/CXF47HTd4PoP?=
 =?us-ascii?Q?meUxEISCrWcjgtbexhwB9TML41aeoLL7cBDPOrXYxU7bTQsDdRZvyR8Tvxc3?=
 =?us-ascii?Q?+lsTrwBOea3s9Uetr4T9+rsUrfDND4rb6i87M5FIzSU0oHWeJCbHDpk9lxTq?=
 =?us-ascii?Q?ML/weuvcBgL29TAyA02BEuNB0teK32kei8IjvH2Mu5QRHaNqxxqo8DOdeejm?=
 =?us-ascii?Q?ft1V8+WcAw83f+TWaqP9luJWPMM/kegudJVqNKs7J/D+8lzcdgnVDlQH8zKB?=
 =?us-ascii?Q?gkTHUucGLuUK+KUbvbx+ZhSsc3Q8gPxNNfIr4d5BGQtz5lqleOUIB2gzNLS5?=
 =?us-ascii?Q?GiRecHMQCePg/0v3A1Ww1D7kBaNfpFjWfVZDiM1pXRW6RroV4aHTkCQpqedt?=
 =?us-ascii?Q?0/KXVOL2XMTfCm2nJ3BzNKp1Iy3J/riMXniPY4QTAuIgGnggwUFW+Gt+PVNT?=
 =?us-ascii?Q?Rt4Do0csS9zFE6JIExQYabe1Blj4ViS0Mk1zNGnY+ZyDM1E5gUH776ijttIy?=
 =?us-ascii?Q?8O7fXI6z7/zZOWHIdjzBUFzzKPm0AjFTcYZGwYhC/xkR+3F+lXw9uxHDrmv4?=
 =?us-ascii?Q?BH3hxQ+pwzHMkxMGcth5Cl2D/DXsUKXKPkeLTuCKVdq0SVdV3RV4ZZx2EMvX?=
 =?us-ascii?Q?I42cP2OH2TUsKhTe/39rORF12Dr0+8gG+dVs+c0bEQtQGftN18z4X4epVHoN?=
 =?us-ascii?Q?E7Y0rJ8VIKkiwRzytl474UpRtl/3s5WKywZ1Ie17W9X9E4VNf+FljDUbvvK3?=
 =?us-ascii?Q?LKLIZHdcbJNVnNzlzuqGdtr8GoNHdbqv/2QCemwxClIsQRuFjy7mDITPyCm0?=
 =?us-ascii?Q?gWYrUd920fcwHUEWhEyX6QqTyWSBMEPr6TYcV2X+E3uCpXAcBIGUFljQb9CU?=
 =?us-ascii?Q?m1edpCE92P4hY0HVJhUQhDrtYJWDJw76nWEufEfZfwGsxTntZWVZFANdtiDt?=
 =?us-ascii?Q?iSaeA1yPV+UqwZ21y+LnqujtvCJdaNl6hmGgPx8c5SaQHXgvJlU6M/+JLNDg?=
 =?us-ascii?Q?wQ1ZE4N0/f4RDIAUG+GW81pGLNfYI6plJBi3pWQd6Uu8GV/gNaDj577IuPba?=
 =?us-ascii?Q?48K9n5lwuqT6bVo8GAZXVxb6+r4KkJVQa/NopB9xNemEsaBOvbTtJ/3JxPND?=
 =?us-ascii?Q?FeGv3Il2xzmMlj4bHWaDDd4aUrA5U+0x+pZQUKPNa8M57gSBbK5r3VOq2kF+?=
 =?us-ascii?Q?xjp0e9iFXeiAC4KpzCgC0uJaqfeRDEQH3jPs7GrIOOQWF/SPbK3yPbiiUm7J?=
 =?us-ascii?Q?bVor8vmlzPHiDxIm1zFIPI5vPAFOIcULbhhdlpRJrtz9h+0iREL4PWik95RO?=
 =?us-ascii?Q?7FuPbrGPYnDXniMPg1POw2Synd2sAD5rMmPImzNNkPYhahLs7lmwj5H6TeRW?=
 =?us-ascii?Q?11WLyY8alQh1FXZKqX/eE7Mh0wFMNjDmf1SsCilKNSRZOwEvmX41IqJh9Y5o?=
 =?us-ascii?Q?0/QkCrFt12yCiFgGxiSByCZ/UbQ0FBIDVC+ga7PXg8L9+bhOk1c84yx61IBS?=
 =?us-ascii?Q?nNGbDzdFO9nhStpUo7hGYkf/BgMY8MhJX3Qe2djSnjfbTvhNfp7wisP8XXl9?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UcthZTYbaHGU9E3tFu4DIe5SHRO8lNVc+cJHa/e2Is8NQkxtwsEf21l/bW6FKCQho54s878QPxSWy7od49Lzevyen0uIXstmqhl5XLBEAj4UGPcQaodafvabeGqAUJhX/qhw4aUBU+vDCvAOSU0S7diQNIZfoLlTiYQr34TuqIM6lpBMFq/bJms0eGp7iGyeYhrCCXb6qe7Df0AR7cArJUe1rIOxBnb1QGuySl6iQn5pRCU8INDNu3VY44/4zaC1okfiV5RGeGRIi9RFuQVtUKlGAWE6HKKQTmu/t0wWQY3URTc9O0zEqEbdGwgb774pOsFe5NO0PxUDhCwErPRvqy4XPj+WV+q3GokBEDak5Z/fQT72sbF/8qntcS2U2XdjjIrycDKZUai9OkjPAVv2/wNWdVXIbHKFnevsr3F9FQsrktob9LKWkuPDlDnSh7CVH8w18k3khTaNDyCmgGMlzpeMTk+QA9KuOz5WrLG2mMYHgPIokLtd0DLHw6gpXPKlyq9T0HBSTi5S9VNFSrr2iEYbIUMPDUzQqw2ZWTKMt6s6UhqjJX0cJ2CvzUcQsMXz5TLiYBm+N39vsbTzzQ2GyhiBzjk27jCbOiCC4EfKGso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab33e33-70ab-499f-ca80-08dc7eae357d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:26.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3RPEY1XP/Viy7AKOJdLVTEDezCmqN4gWiooHxhzSkMQapd557z0dL6zgsVPmVFLqUeWgGFWAXVd1WpV+evfLNhwa+X0e3rS89gFLey8TVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=791 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: VC4V3R1mLwPgrxbdvPxijdEHMQ4OaAEx
X-Proofpoint-ORIG-GUID: VC4V3R1mLwPgrxbdvPxijdEHMQ4OaAEx

From: Shrikanth Hegde <sshegde@linux.ibm.com>

Add PowerPC arch support for PREEMPT_AUTO by defining LAZY bits.

Since PowerPC doesn't use generic exit to functions, Add
NR_LAZY check in exit to user and exit to kernel from interrupt
routines.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
[ Changed TIF_NEED_RESCHED_LAZY to now be defined unconditionally. ]
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/thread_info.h | 5 ++++-
 arch/powerpc/kernel/interrupt.c        | 5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..11e7008f5dd3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -268,6 +268,7 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_AUTO
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 15c5691dd218..0d170e2be2b6 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
+
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -144,7 +147,7 @@ void arch_setup_new_exec(void);
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_NEED_RESCHED_LAZY)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e..0b97cdd4b94e 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED) {
+		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
 			schedule();
 		} else {
 			/*
@@ -396,7 +396,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
-- 
2.31.1


