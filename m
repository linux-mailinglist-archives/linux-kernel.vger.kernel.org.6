Return-Path: <linux-kernel+bounces-191551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E538D10EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7281F21C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E61CA94;
	Tue, 28 May 2024 00:36:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F5748F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856575; cv=fail; b=caFXRN7EvmrQIt+z4gXYvASeG9kYuY9dAtB3OQVKaqg60WMsUdylp9gv2BK9JlKx+AGFW0VW6sI95klMw2XcgmABxX0tYsggIoRokndDOnXeTB2JGV5O8bReebL06TYy7gR83XxXtH41DzrJkbL8y9MyYH5X2ALXUabvfSQ73g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856575; c=relaxed/simple;
	bh=/RJPxtwoyxtnWixJcP118eBcWSwitJPQMlq1/0kt8s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vqf+rLH/gS9/UylBk6I652k9pZhgVxT+GWXg0GfMsSzkte+Mtsk6wKamNvlE/HSqeeqgTIVfL7JeJuNeyT6b6ORYuN5JX0LMOXQXcDxfyCJ146MMqDRCmyl3xxmKFp5DFF6BslwN/HmFyvVoqRWNbFLw9DAH+JwRYJUiJrLHCLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI41d025151;
	Tue, 28 May 2024 00:35:54 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DeOGnwlYC+yrJb/pHNsMdrGIJ7B/rgryKQODlnMirqbQ=3D;_b?=
 =?UTF-8?Q?=3DhzavMgtt1BsQ+HA0xZBkKyCRSVBIiwstj2MjV8/+CVJQCwyq26LUQok3l0ps?=
 =?UTF-8?Q?3pQnIOM/_94rpnkMD8LfbQXMmkaLMePJRzpxMVIq0lSvFgcnZKBEAQpTxru1ife?=
 =?UTF-8?Q?hbecb+YpmfOb2i_eH1nLiiXyClYd/gSLbB+gWH2cb/96H49/LGRpSo/b0TcLxF1?=
 =?UTF-8?Q?Nykpq2oy6YdGiLfc9+Xn_FBOnSiC8MTPz8Lb77ANu3ZrB1zF77YaeWkeLYmih5/?=
 =?UTF-8?Q?3WMW4Go+NfFfuama0fFzCfRm1Q_5htKjwb3wvHu8f3pcppp+1Wkzc7qk+qn/oWf?=
 =?UTF-8?Q?ZHcuS4XfPP9gSa80BWNoDaNNMK7hyO6C_4g=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RL6qBq036572;
	Tue, 28 May 2024 00:35:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc534rd6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/HNFBKjrxc6nP46EovIytvTbe/RNyML7XFeGR9hRRFs/q6jGseWRITNVbipXE3buKPoZWT7Our8IDkEWMwgs5khVPc8Cn3DEUxWhmrgTfRMtdmPQECQPaKwho3m1qt9towPxa/IHPL0OXGo+meDQ01LSbdS0Z1OQV1o/S7Wkr3mEobCvZSKfrptqlgqlQfCN9EKIekzbFqiVuqaDvS4HS7wuSXyTJ5KRd3vmGP/vMGZQ9QDjMW83qH5O4+Wtr151Z54QPcV9peIO1ok7ZRP0XTA+YqVpEtWZKANpSvRKxxmh83JL6WukgNfuygtRmsUEH/GAnaNqdvy8ixYuPIIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOGnwlYC+yrJb/pHNsMdrGIJ7B/rgryKQODlnMirqbQ=;
 b=kcfNQyjs1AEEDcoacGQflzcdxZVaOFaGxYoSTCBrNVgJyVuWRY8yvvTZioP1MJzU8OwWPgm9c1LDK1p+pFwN5jMKCBC/NhpBznMRKhSjKs5aDe/ZHDdZpTEAoYmU+MmMQtaZzqHPmjSFqTFZm7SuaNJGB5EAZa0rQSrFFgRV5eUMemDy3M9zvw0b29MQQIA3Z5CL06vB6AlfF23sT97GkLWmpWrTMS2X4iUlfeuwfB51MISY/lu4/SD10+xuAbO9vwWkTdO7G0pNRQ1q6JsOXLEovvHslXsOeN6zObgU0igTaQ9lyk8zphI3/b9IjWmoXTELsmfnFtBkMXkG8Y8eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOGnwlYC+yrJb/pHNsMdrGIJ7B/rgryKQODlnMirqbQ=;
 b=jwU9I7EDaBHEEQ9VEoc3vTQxrJDsbQGJGyA6Ir6c3fzLWJjfLJ9DeCHm8M65sFvvWZrA7jSa65PJBNw+rfWt3+5kV51SuOoyfMNxuKL8LO5gftpww1iWHli0WFo0xQX2qiNBIyb3BLilciz5Ox4m+qw2n4rPxVjid0T48MQ7tbs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:51 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 07/35] sched: define *_tsk_need_resched_lazy() helpers
Date: Mon, 27 May 2024 17:34:53 -0700
Message-Id: <20240528003521.979836-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4d117c-af21-4e3c-731a-08dc7eae202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xgjGaZ+bmZ11LMgOTxH/B7cnod4vN6QctBxAnJd4JwdBzI21RFbB6fAJG9rV?=
 =?us-ascii?Q?nUGjmXevF+1DJF4rmvk7Y8eyuPl3HlaAGl3V3shn4IMsGTJuDdhDcSG0tjxE?=
 =?us-ascii?Q?6r5Ij4TdHCyCr33MEi3wF35GYcqNqzvfxQV3jfAJYjikpxKiXXiGRl+NNdsh?=
 =?us-ascii?Q?5A+VS/BdDzMzZ9gomds/n8pxmpeg1QskDlYL8OZ5F1a1DWYLzPBTAt70rCJl?=
 =?us-ascii?Q?TwCZkoZrG2oJp1VIZKKdQjcxO2bCr33dwiQmJDcWjXORC4ximaLJytNusOFV?=
 =?us-ascii?Q?Snxl+mShpK5OaqcwcjC6AOpu98nECRgHRj3F3HmfT0VbsG74C4q95PwRSjDC?=
 =?us-ascii?Q?TkqqJaunQomYke5inmMw7B4zkxK4z4M5YLPS3NtyvOdATCfvCYJmJSp6QwL3?=
 =?us-ascii?Q?dQK8sExfVTUkkVrEcG3xAkxRaAwtxdGUORLbBZF/Dm4Xt2dJeoxf7YVBD0SG?=
 =?us-ascii?Q?2hEE3AMxXWO4zGIk87BDc83C6sZAoCqPpCd/E87xGamijlv4EhzzaycAQdDG?=
 =?us-ascii?Q?VS7eUmcpPYRNOwR5VlobyMjxB+9pb24mY5DpsT/fl3sJfn622TzS63bb9pPD?=
 =?us-ascii?Q?6BffgI5o0koUpuq/WIEPuJTt3xDbjEjuQoQ7nlsogcO7kHPPjO/QIA2vlS9s?=
 =?us-ascii?Q?CtD9jge1aUxsd9cUvzY9J2GIzM34Ms/0x+DvtI9ZsvqUSxlgxjtO5HzSUMev?=
 =?us-ascii?Q?QyYUOzL9zPG7IM1p+3cPQcyixm2RMLkN4XLmsh97UFPFB52uyxtYtDm12kRt?=
 =?us-ascii?Q?L91Ce4vm0JSvDNU4kQk0WJVwVOgYTrPHfioJrYbNQO3mwoOgRV4U+9IY0YM/?=
 =?us-ascii?Q?7r1TeI3gSaHpNietb/4Kjr1xSFRK7U/LMaYoDmKk0l5KSkV/dI9MtA2pvViR?=
 =?us-ascii?Q?H/J1JiDuT0xjLI00hC3W4VaQG1w+M2J3jTRtlLf5V9UOq0efT/749ZehHEAn?=
 =?us-ascii?Q?SUzKg1MO793MGWoV+Hr+G83Rhc9VvP7EdN7YJ7CEbuNqTF3krk894Azj27dc?=
 =?us-ascii?Q?tY2M/uugCdnY+RsRKCnGeyiNfongEMjqXmUtpwOFT0FJb2ZxxqzzPnaDmbnI?=
 =?us-ascii?Q?WLJHS4MhHZJ5sKltrGltAli5VUIL2+kKXRmOEQvpAyPUDpzX+qjLSpjAt7J6?=
 =?us-ascii?Q?azHfnTmt4czf8Nucgy+mbkjkJR/O48uDEJeT58VfKeSkXJbAh70HXb4Y1+Ou?=
 =?us-ascii?Q?zO7VUGRnX9VZFsiwltchzJ13X7XrysCtokvvS2u86crPptUGvz/77jfMXD8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iUPuVOCsFQy1EPmUzd9nGQCKNu8FKDgdCSvb4QihonZk3+ZFJ0R8BNZmJb0g?=
 =?us-ascii?Q?qEHUUwZLZ5LnQYPgsuFV7MSZbYLIgRfgDqBBHlTsI0craJzvV8MtJQ+zzQRa?=
 =?us-ascii?Q?3j9d6vGA1sP5D8XLyWJ7yhha111pkmYDGxlDZgLOUvZzxHUTuMlGEP7KK7Wa?=
 =?us-ascii?Q?v7Csr4I9R+shwWUSJKTw811CUKw2/YJt6KZC202uI6otMGyfsyk4gpDvQA0K?=
 =?us-ascii?Q?RdgxuYLt48OwCmtcjsjjhMc7bU4gYdBJBBWen+6XcO/nLQTY7cTUJByfqEgY?=
 =?us-ascii?Q?7gkCGDYCWJl5zrFdRZYh7K3iFUPcW56XzI9svG8ugCMBZmxXQGhXbdFf8Ici?=
 =?us-ascii?Q?9amRDfstsjr+3kxSQjrQhsnfEOdfZNsB8GKPYEcJ+45+imtsOQqxM6hBpWTg?=
 =?us-ascii?Q?NHv4X0zkc3FovBDLzdzTI4jUMOeM6LQ72oVuJwLZY4KGhBZCGPlwC6UE7f/0?=
 =?us-ascii?Q?Yc6RVlTAjF3yhBSVu6H1kZ1UJGZg7X+BFVpsPngTVwwUdq5h34gNFBcXaUJB?=
 =?us-ascii?Q?i5Yi408slguTr9ncBB3se8T+PLEij27iJPx7ArB3rnFAnGiyg862MzzjHqId?=
 =?us-ascii?Q?yjw5/pfsRmitTZVdIgQB1H8n4xhC79lGPAS/fLZLUJglWwXCr/dpWzWwUqAs?=
 =?us-ascii?Q?QUqO+/GWBD88OG9SwgZlcJluFDBB33hSafx+soFQ9VeW/zKn+NOLebkIxqsS?=
 =?us-ascii?Q?0iKbl0WYMpGZvX46H8k9G2iWBG1rGdtEGBSKjVXvb9MYeMjxJfIw/+6BZN2b?=
 =?us-ascii?Q?n50PykqdwdaTRmARxaxSuSMyiWd6KOUAeswKDJlsTJJpIT7kwKpQizXglrf7?=
 =?us-ascii?Q?aEREThjpIn+oXr3m5pu2FoLloN2kbfvgUwAWEBOUJIx9Jl/z1zilISD9XVeo?=
 =?us-ascii?Q?L5pESVB0Er3ylKy/xIpTOm8IhR96Av5MEB8cD5RaJkb1gUfjH46gdYAgruqQ?=
 =?us-ascii?Q?2w6lkZjGhRZ9mnz2LZSNNg2sqiIV0j+4/rvmUdZwu3Ijz8NxXmSfUyT7oKZD?=
 =?us-ascii?Q?knryPKeCIjEP0JbIxr6gur9ehRhH36HqdlFGAKxbev+97kUaDWhnPgw79FFv?=
 =?us-ascii?Q?JhDj7ulWiREvEZL+e8/yWB094k5MYaZaarYHTU+SfMyhZElLF2jKytUYASSv?=
 =?us-ascii?Q?Ffvnedvbju1joN7w6yVMXrSrzebYr3mAvhUx9UKzrQoklZqPApcPjJ0M8pjo?=
 =?us-ascii?Q?4uNqXpypWip+XFELWV+2Zr+G+Vl4rNAqf/jtNqdoRDjIROzekSdBB+kM/2wL?=
 =?us-ascii?Q?ingKdfIw/4aq1M6WTLBdTjW3NbeVhRqCVyp1nxOYlEsOcFwv+PVaocF2H+E6?=
 =?us-ascii?Q?0qcBrV+s6XzDyN7ej5nMl9R+Y7ulzQUWQw08EtQuLGURaKiVj3kt5I6NoeJB?=
 =?us-ascii?Q?radgJjKdB7c91RzSI2iwD+Mj2d5pRRPl/anMMFvfeRqqan6jHShx9z5xjmhh?=
 =?us-ascii?Q?InluwB15U5kvX4g+ZSjn3srEuqn8EieJ1iHOhatP2OSkPKojKJzITaEAS7v1?=
 =?us-ascii?Q?vO3JddbWVbdNUopD/x94gn2G+czc1JhzyRmyA2ouOo3Iugo59/jOMPfpXZRd?=
 =?us-ascii?Q?ZscDhf+eEKn9tpnkiNAo1x9L7GzaLnGYPWQCFMLY7LTfD8CQoVVe+gPDNKL3?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9/xctthfBGJQousXFOL6OErNYAEZH/Wd9LkNnxkdJHdgFNCBbY4dBqCFCStBCDsC/VTMMw+iiwlcEFnPe47mOXVRk1Rj3peTS/eOs6NH4nsq9xGbtPbtED49br8TNdAP1jT/b99ZRL6x0H4nimC/59fktI20T6ABC/ufO0RuN77/gvi3ymIitYROmRESqCsVCyBjLCBmOMuy5KexcLPOxnmR+1g5KvbzqpwNtE1rgu36F+T88NIibOJ2Dx79O/qCAfMtERiHNmjo9o9fOZmQvSSx9uut1QnMfguiYQr/0z354xFnbOtj1aCUFqEpSA9yffe1igeh7HcR5HGSfq14BxFYWsAcssUeUnJObbvfjms2Fxs29qVTH3lALe6juetBFfCQFranceb+ZeC0jv634bT6B7ANMI8QhC5m1+XhO8NIFYiQWLYgXT6kulabJ/E++FNJAFJGz3SriZOW9fpYH+v2YEmhjg6Aot+wPkO3T5nDW2c76BitNck1eeo0JzGee3GuMK9ATm6AEXoDo9z3CHcepwKeVtlq8Wea0Cc7sJtS8ud3C/3HuVl+t4keJsVFMWwackWMqLzcPzKouvVsk7eoGtCQF9LAx7s2DNkVZ3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4d117c-af21-4e3c-731a-08dc7eae202f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:51.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUe3fD33RGCnVA8CSFCFTu6MWOTsfW8UlCBcwyRpUnkGyXgfI/E6N7LLJua0wcM1EpIOhXOhhbQooURmG+OgRTNDDXFKYr9MG3P3DPeVIIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: 2gKGDlEYFA2fXHTNV5Vq5t9Wl8hfDJkS
X-Proofpoint-ORIG-GUID: 2gKGDlEYFA2fXHTNV5Vq5t9Wl8hfDJkS

Define __{set,test}_tsk_need_resched() to test for the immediacy of the
need-resched.

The current helpers, {set,test}_tsk_need_resched(...) stay the same.

In scheduler code, switch to the more explicit variants,
__set_tsk_need_resched(...), __test_tsk_need_resched(...).

Note that clear_tsk_need_resched() is only used from __schedule()
to clear the flags before switching context. Now it clears all the
need-resched flags.

Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h   | 45 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c     |  9 +++++----
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  2 +-
 kernel/sched/rt.c       |  4 ++--
 5 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 37a51115b691..804a76e6f3c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1952,19 +1952,56 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline void set_tsk_need_resched(struct task_struct *tsk)
+/*
+ * With !CONFIG_PREEMPT_AUTO, tif_resched(RESCHED_LAZY) reduces to
+ * tif_resched(RESCHED_NOW). Add a check in the helpers below to ensure
+ * we don't touch the tif_reshed(RESCHED_NOW) bit unnecessarily.
+ */
+static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 {
-	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
+		set_tsk_thread_flag(tsk, tif_resched(rs));
+	else
+		/*
+		 * RESCHED_LAZY is only touched under CONFIG_PREEMPT_AUTO.
+		 */
+		BUG();
 }
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_NOW));
+
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		clear_tsk_thread_flag(tsk, tif_resched(RESCHED_LAZY));
+}
+
+static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
+		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
+	else
+		return false;
 }
 
 static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
-	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
+	return __test_tsk_need_resched(tsk, RESCHED_NOW);
+}
+
+static inline bool test_tsk_need_resched_lazy(struct task_struct *tsk)
+{
+	return __test_tsk_need_resched(tsk, RESCHED_LAZY);
+}
+
+static inline void set_tsk_need_resched(struct task_struct *tsk)
+{
+	return __set_tsk_need_resched(tsk, RESCHED_NOW);
+}
+
+static inline void set_tsk_need_resched_lazy(struct task_struct *tsk)
+{
+	return __set_tsk_need_resched(tsk, RESCHED_LAZY);
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..d00d7b45303e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -933,7 +933,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 #else
 static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
-	set_tsk_need_resched(p);
+	__set_tsk_need_resched(p, RESCHED_NOW);
 	return true;
 }
 
@@ -1045,13 +1045,13 @@ void resched_curr(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (__test_tsk_need_resched(curr, RESCHED_NOW))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
+		__set_tsk_need_resched(curr, RESCHED_NOW);
 		set_preempt_need_resched();
 		return;
 	}
@@ -2245,7 +2245,8 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(rq->curr) &&
+	    __test_tsk_need_resched(rq->curr, RESCHED_NOW))
 		rq_clock_skip_update(rq);
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..d24d6bfee293 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2035,7 +2035,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * let us try to decide what's the best thing to do...
 	 */
 	if ((p->dl.deadline == rq->curr->dl.deadline) &&
-	    !test_tsk_need_resched(rq->curr))
+	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
 }
@@ -2564,7 +2564,7 @@ static void pull_dl_task(struct rq *this_rq)
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
 	if (!task_on_cpu(rq, p) &&
-	    !test_tsk_need_resched(rq->curr) &&
+	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c62805dbd608..c5171c247466 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8316,7 +8316,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (__test_tsk_need_resched(curr, RESCHED_NOW))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..f0a6c9bb890b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1680,7 +1680,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == rq->curr->prio && !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -2415,7 +2415,7 @@ static void pull_rt_task(struct rq *this_rq)
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
 	bool need_to_push = !task_on_cpu(rq, p) &&
-			    !test_tsk_need_resched(rq->curr) &&
+			    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-- 
2.31.1


