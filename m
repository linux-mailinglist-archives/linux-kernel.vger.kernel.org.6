Return-Path: <linux-kernel+bounces-191567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C049B8D10FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED28B21992
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391D182C3;
	Tue, 28 May 2024 00:36:58 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84604C61B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856617; cv=fail; b=qlf7bkNaIOjWOWCliTlsWySlEsgjWhXXg47VMF6wvGfTABJ8YW/bHmKEOdde+7fYDFly/bALwdNZEbyG8PC402ngz+kYB+tf0pzsPeGZG2KtmvwligUH0AyfB3hX1TAEfBVeTvMwKzdvdTPGSaM19mehskRQXai8ScSpDDs/QPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856617; c=relaxed/simple;
	bh=DfU8l3qzeAcpsStugG3HXjWtnmfNPAonofnve0Q9pLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/x4+IEPbveJk9LxtgG0EHq6wAFLp0VjsobZ5y5smlblbbPwxSs+hJkxHQyJNrnC25tMik+t/qaY9ak2kj32CTVovUzJ3TjGTPedxbwnDOGHXy02tp8PcZleDIlrxE3JSeKu5cTZpslzMcpI4XCQgnaQHLXJe0FFgdrxLiVryXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLSQWx029961;
	Tue, 28 May 2024 00:36:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D31eRpvPTrJ0uEESz/GHnuCI/ISHK6lF6C7gx2MkcnFA=3D;_b?=
 =?UTF-8?Q?=3DQ62e7bXB1qrTEi7m7rEWlDmU6dwMyA/ZSSjcHS9hSaTOBUnYHZXvGMnSL7Lr?=
 =?UTF-8?Q?tPrBL3P9_ANAbrHOv6Pz+BqydVH1KSqKZo7N7e1wRIqfuEPRQNr2N5jwsxBPqmd?=
 =?UTF-8?Q?gPvJIQl2/KBCHw_cPGgJBfiVIGHXKpus8J+UrApz2AROZRz/JGFkpiJdSwvAaZZ?=
 =?UTF-8?Q?midKgMf6hbEYNTQtpOoK_wV37CA0mElW7SUAgC6Y7gGBzaZEqSdY1EeFMnSCLKP?=
 =?UTF-8?Q?uiw46XydDPFUOOynbBU5/lhyF6_iCh8H/h/H7weRvevl8AM99P/5nZ1xIraastU?=
 =?UTF-8?Q?snt4bCfU/VP20Z/GFWHu3qDojrzD5t2s_pg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKcSXE037625;
	Tue, 28 May 2024 00:36:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057yax-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idPA71I6ZwU+YimrNParLkquEFrseMkQDM0fiBYUn/8nYgeGXlL9vtqrGDBiV25ai8uxQX8GYMxxir4LxHWknk8TKh/ukn9Q9hw9suVv6knB9DyyTQvD72o55ksBwN0u7HBItlsj3b3ArjP2FClh2vkRzXFbtmH733sYfoR6XL1Qi656am5XBQ/UC4cAlbIAp4wueU8prOcD+OQ3GxKWATb4oeILe+GWv+Txrb6PWtN3rpm66kDElVSNeVp+74XnAO7AO6ZrhcdZ4VkB6ps4z4EwZKSbgtPdeNHLaXKQASnZSuoKj8hioCFPuWCdm2bITk+4UmSvYoYdk+YJ5kR+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31eRpvPTrJ0uEESz/GHnuCI/ISHK6lF6C7gx2MkcnFA=;
 b=du1FooKxTyXTb1lOG5jVZerxIIzPlrf3QyBebFWoSnyCeGarPv+dKxsOXYBiGYBbSJi7cP2l3+7orCBxXQPjZ64Y4MgS7nzWx6g8C5Suh4MJHlfhc1eJnnun18X0WzbOxc3Gv1KfgXMzhsGSZ+Idpuj9UNHMLroOmqQsHEYgFmOFAh3THX7fvSPiJsWh/+sUhlG7d8eVpl3Mm/FlcYMxLewfMhalRhn4I8kdg7KS0ufmbUAUpFhedQhuzTyocB076Unkp+O7Hh9Ob3rHMxpGeuHPqcotJdQ2E9HCEJL80oz6hjdtQCGni+SWTrhpr+xi9Cyr2DWTUax76SlsN37Tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31eRpvPTrJ0uEESz/GHnuCI/ISHK6lF6C7gx2MkcnFA=;
 b=FSbzclPyKPgg/r55VQucxYuvtIj/MIsOX3StrCyBkpMPkX9PDt35uJVim71xi2m99jlbBa5+nsIqPdFGP3d6KtuAsFXFMZMrEsOBdtfWxApFLXvqvu7+h4O2MwLSfMKX5QrFk7tyvKTD8fQsOTrmitYc3lDpS3Itnas5JBH8lqg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:33 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 23/35] sched: handle idle preemption for PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:09 -0700
Message-Id: <20240528003521.979836-24-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: f6acfcbd-1e76-4a18-4896-08dc7eae39ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vzUVzKyXQ/5cyaDgQ59lFXMGmAH1H2il7mVZS3ZFRZHB5c4fsgNbweX7bCo6?=
 =?us-ascii?Q?OhiHt1gRrZyf7LYq5GgwtJb529tw4VPjY2q6PvS/8TY8ZXsFqQ6u6LWuS2I5?=
 =?us-ascii?Q?C+hM35kH+527VGX4GZCHsBsyfBstFxoQEI9eebbnuM0okDE0EPUybZDZgLdt?=
 =?us-ascii?Q?DQIWWDQz3EI38t6QYXP9HQvvfhXKtiElAUp0yhpQ46IjsutPX89Qb0pY83lL?=
 =?us-ascii?Q?j9zCZf8vJ+rx2f+NGJCvP9S51XIqlTPwOWBPxS3ypBshbIxTqqdmdDaeCV0X?=
 =?us-ascii?Q?a4WuWMBR2T/UvcdmliSCD9T/TAD85Hnh3nm6FaBNoW8AsphG68fe8Xedq2zw?=
 =?us-ascii?Q?kD0Gz/ehELQxqjHFXjjprdubf+qwbNh8Gx4U1b8ZfX5iPvg00LVLX2ps3prY?=
 =?us-ascii?Q?D20yp2s+AgDZCwp3uDDB8ZubMc9tCoNASuZt6QKr+/3gGtVO53sJ79C6BaHa?=
 =?us-ascii?Q?CAIX27sfw90ofZSkZnG/KDlflRNrJoDNsXj4+0fDwFVv9rM4cuT5aeXVacGm?=
 =?us-ascii?Q?tSELzRfv7eqhy+v5c90ERaowz41Lh8EDTx3jnu9ZysFi/D5nn2H00/f4Q6/U?=
 =?us-ascii?Q?n2SlD8D8p/OF/pNPeGOilBiBn4ovpKQxAbidFTfShZM9BDyi5cBgMY3wO5lj?=
 =?us-ascii?Q?NLx+wbR+AmtkagbMlGMCitdkjlkEf4Yzsx5coWB5bI6TEHHewXFvjSlyTOG7?=
 =?us-ascii?Q?ZFyutn+iwodkZMgYjKm2Hr7PaO21D39M0JR0C72gR2QhQ4e0Et/QW+hlg8Ni?=
 =?us-ascii?Q?bZiPZmAFI/Dth9ugCpTrH3lSfJps+2O5Ro6zhN09suVBMmj8QO5LJGGUVSUr?=
 =?us-ascii?Q?T+AM+ExSXDeRKjbYaigVbg3MBESb+FeEtSmNIOH2tvMCHoHPtEktpOR1GyzD?=
 =?us-ascii?Q?TtyvXFNDn+mWp1rdR43i1kbgmUEPDEBFZWe5NDoY/ynavajSnT3vFOF1iG7e?=
 =?us-ascii?Q?nZ4n+MTAIbUT1s+LkO3k9ERhYxSzytBbWlc9y7KPDBDHre7N/R0s9HHgakYA?=
 =?us-ascii?Q?5hNDfgNVHoFWPd7uDdUoYOBDdbLYeKHdXbrPwvVR+GsUBaz8rH+UOfweH7N4?=
 =?us-ascii?Q?vvx2NSQXf/rXLR3E8DKIfpMMAx+WmaQyvGQcpAy3eBG61UrwUKMGJfmJAq5V?=
 =?us-ascii?Q?snPZ6NFz90il09fpiJxeLTJ8TPf2+sOuUbxLkgTz7RuK3vgJFdbyFw9CVHFU?=
 =?us-ascii?Q?XKsPKwuSkRZprx9hxR+MwnRSHLWAj6P6kYQgvQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CREglcY2eiVBn02TEON8YU52D9sxmvuPOgkiibMC9mAcxaq3SisettEVlXNS?=
 =?us-ascii?Q?QcnlEk0HTfQXZvE6LWAICK5mA3nus4k8o7apO8b97hIVmljUwJNiuU3N8PE1?=
 =?us-ascii?Q?+uCndyGi4gXZhf/gS+71pnP4dSWzMkYiIgOqJVtOXP93TWSRd7J5mfvpObBR?=
 =?us-ascii?Q?zPG7gSr1EEp2rDpV3lS/zt8nuyhdSBz01GBFIhjbmlH36ULr7b3a+EmesdNM?=
 =?us-ascii?Q?B2ReBdiOKRGq/gma9i76KgDS4dHHuW+/WTNuQzcnCfXMRNihhOMPQghsV/y0?=
 =?us-ascii?Q?LZ5CfV273wQY/dS5NoICvP2bc0eT9z2aLeRVLxDqNH1n0B9pZIOUipOPUpMR?=
 =?us-ascii?Q?MViQ8MfzSCwQFUcOE6vG75vMaiMv6F04QZp69/4Rf8IIGW5o4fpv2FvoSGJP?=
 =?us-ascii?Q?3ufCNNjWza0UUR0wLSx5UCZVTNvU2mTAIi2xEiih3ZRyb1fjxQbTnb18qKzE?=
 =?us-ascii?Q?xQH6f1ei0aAIP0pA8NDjuG/jXZ+m6zACmm+QMGVS4TQV4uFv1coH4/Xe4ZY8?=
 =?us-ascii?Q?JyQE/MpkvC5xS5flnSKaG2Huyu6KmP51bJvmbQDawhFMiCNSssBqwBOFeMNo?=
 =?us-ascii?Q?4IAiJhLzjLScDLiB0BJrNUXMVQJ21r06nIb2CDa5e682q5OrQs3AptW/WyZ1?=
 =?us-ascii?Q?poL+GMjY9QU4gO5ua1TnmEhhtso36GUxU0nTrrg15yUH1aV2FNy29G7XVg4i?=
 =?us-ascii?Q?zYEB4dm1IUzYLhgfdCzY/8SB9BprujlDi9Qqk2WAi6K3+USDbN+1Igo8oDsV?=
 =?us-ascii?Q?XKiAR8TiACmIcpO3AGr29GyfZnkNDg9mZpqmXyFGbeoGYrCaKi3/3afAxDaA?=
 =?us-ascii?Q?UiKNtOCMuhH1nFUyA3q8S6nWewhKfsWauz/IdoqA/NuC36ydOj/+bt6yt+q2?=
 =?us-ascii?Q?+qLoVhZPpUPBdm8qD13NCkzOUMpH1FNyPQK406nHAcMpaFrstxcwAXgd6xNv?=
 =?us-ascii?Q?N1eO5aMClbv4kjwFzedXHu7Ah6p209jQDvlGAtnyQ6VbUIZydvrxILy7NmIb?=
 =?us-ascii?Q?xHMeBtxxivgtT9Jyj6ovlYrGb+70nTm0uIKIb5bL/GxZ3P4i99NiJvtJBrOO?=
 =?us-ascii?Q?ZnMn6C3yd8aPvPWWHkUulv1a3lQBDdsbxtiy96PogSHLshWBdGM0qJyTQ1NG?=
 =?us-ascii?Q?X75/x8IM5yOpKCBewx9/R4MdWHggR+9IdeOZ4sQAyze6DXx9fpzd+oXXy4JI?=
 =?us-ascii?Q?Iq0WT1oKcP8UTtU+57to4iKDw82ZZ/VUwVvlJXj+IZvgqvI2jQw2gSMmdKQg?=
 =?us-ascii?Q?+33mzPeX6XMtwnH7FKPLNyJx6tJAi5qnFzl91fcCTHbPxTEPFJGSemSTJ92Q?=
 =?us-ascii?Q?hHWAIAOmjmaIjOiaRr4Mz4pCehZoiUvylxfh5uMXFbNWZWVGZzitqwuxXumi?=
 =?us-ascii?Q?CFTF5rJo+7Y+b71A49mPerq71N58pdrLsfcBe+tdFcGWxFgEh6nO21ti3gRR?=
 =?us-ascii?Q?oz823kawoE1yLFs9DNN4QMQceJRZMF1db0uEzcTvqr9+Aot9XIM4hx1bIxxO?=
 =?us-ascii?Q?Jv1j587LvfI6PFRkfmKP2dfRvbhhkF2sbamRay3Rl+9sIYGafzebrRWuP5Z7?=
 =?us-ascii?Q?Am/l/bbqYbsjk3ULMyxzd2/Jy/J8cNCjzgtCBN7NwfE97Pbp+WQcO8T6Y7XF?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6+TjMPGpaX/+3hu7Gfzkba1EkJCTflba0Uiw4ICzpioHhqKqcZkGMfl89fBhh5qvcul8obvTBS1cGIT0SPuqxvDvV3ye1ETHmAV/ISHdW/fOMBaHgYosR9XvlQYXdcloxstDdTG5W+EGBgL7/xyEavjs5CEmQf63gA7cuXPkFwHB9AQleKQYwL6SimwxwIuFMDpB8owsPhig9jllNJt/9GcDuVXqBEVQO1Hmgi02OX25QNxuEYTxAVrO0CTFXoVPcu/1pgHvYA05kJc7vMeWD15KgkXkdgSiHdAEMVqko5JEkmbFoVBV95BIPcuZ9RsWA0Gkyd60V8HMWxIBRB0wP34aMSeaRwW5WolgPubVKZAlnrmSH8kXR+vpq7C29JSoPlhNIMQmx6UESKpUXJTxaH2lVPhisqLKQgKa9TgMDy158dG564lbmsiLeiCU/5QoZAGQ72TTbcRLC0hCt5OACNa+EKDRevZ3T9uJqZOcYpX4v/IT/UcTOdUT920bATbM3cjDu8jZrYOuNgPKGp+ytMaAxws8jr2RpvF9sqldVQR77Z4KJvCOj3YOkuGPlA2HQfUKleNieIo3fD+JKCdX4FTeMRPXZhbZrAm9Tp86FKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6acfcbd-1e76-4a18-4896-08dc7eae39ab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:33.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH9VSXpvSegLI9VpidBmiaIIGJzwbwcQ9PVASnumDUNynShKsmactHCzDbkx0xTkHwNqNh6pnUSozmFGy2SLtR1a0l1js70zkHAdLN5n1vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: VKKGx6_IXeRg_TGPgnvbB7m-JRXGUy4z
X-Proofpoint-ORIG-GUID: VKKGx6_IXeRg_TGPgnvbB7m-JRXGUy4z

When running the idle task, we always want to schedule out immediately.
Use tif_resched(RESCHED_NOW) to do that.

This path should be identical across preemption models which is borne
out by comparing latency via perf bench sched pipe (5 runs):

PREEMPT_AUTO:	  4.430 usecs/op +-    0.080  ( +- 1.800% )
PREEMPT_DYNAMIC:  4.400 usecs/op +-    0.100  ( +- 2.270% )

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee846dc9133b..1b930b84eb59 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1044,6 +1044,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
 		return RESCHED_NOW;
 
+	if (is_idle_task(curr))
+		return RESCHED_NOW;
+
 	return RESCHED_LAZY;
 }
 
-- 
2.31.1


