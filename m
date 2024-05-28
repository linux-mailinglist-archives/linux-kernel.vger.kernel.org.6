Return-Path: <linux-kernel+bounces-191578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38958D110A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A1F283CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF1313D63B;
	Tue, 28 May 2024 00:37:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9713D28C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856643; cv=fail; b=b6RmWV3UQHoD9RAyhQ488MP8Ja7FACJnj5+jXPpL24DEqlVKe2BOsnQ0s7XbFEYpu/Nxd4YChVgh99gl6Z0cqqlDDXy0pzi9HTwbDbCpMN91cUHOTwrJR552zjVS+XHxYmYW46u6PRc3oMa/3LZS6g1jmG33iCmrR297uaT1A1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856643; c=relaxed/simple;
	bh=UQymQ3FHMrHCr8qq/KlDPzCh7jtkWPnYrp3mrnGibxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UieOcgnfpwC0SJ5aeMd5Hj3+qr4OSyN6QDaTogwjrnp8BlSDMClisGutL4rMG4jSCGzPSmG3aM92wul8TPTqPXoSD5Z7DRRP6YCn9CO5kUEp51C6V4onYvdjSECpf1LvL1nN8WyitUw/0ghdiM5ZgzclrcgHcUyTqWbnn8m5Dqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RG3wfm028624;
	Tue, 28 May 2024 00:37:06 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DeQd+GEynBdf6moMxtrpSIuj2hqoqf+5UWwE/kux4hv8=3D;_b?=
 =?UTF-8?Q?=3DeUOWuGroGOQlz1dDeed/PmIAhzI3xYHdavwLlhK+g+7R+Vt54ctcfCQH9eYl?=
 =?UTF-8?Q?gIHdf6bd_pOBGyIBdsQvrgY4zSXA8xHckcEdNoy21DRhEjn1PL0mDkwZd0LC9An?=
 =?UTF-8?Q?LB1ZR2X/zOPDBF_mfPCLVwjLG3sl/O7PuTWLDXFc1e6FVr4twX85L9PDpNiOL0b?=
 =?UTF-8?Q?VSNxuQdawNlF4ZrkRL1t_UCmpq/r0Mg7nDxBzLfZcwxmujU/6YFZzInU9nfkG+n?=
 =?UTF-8?Q?/ZTtNOhslsXyC3qlNTbMS4QZ67_GKrf4iKrWhdjhP8mr7J5ZjuaKlwyIZ0aNJKh?=
 =?UTF-8?Q?WnrTvVhzWHreMFkV+5nYzntn3cBfTXaP_iw=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j835rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLXrYi009442;
	Tue, 28 May 2024 00:37:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52agcxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPeyHyBtSrAh91KCGWsFR3G4aRU/Ycae2YJ/p+96Flpi50CTssw2lAyZiUYJPDTf7Tlh1BkmlgmCOSUIvHm/acVb43YeYnqa59Deb8rX0n2N9LTgpaly6bnIPSo8+iqQutAXJFksL74DqCTTivOxr3BpMIswaQPK2ava7cclEg8zf540UOeeDBfwajGU7KWX/d68PqA4zn1k+9PWum/uGknwtdJPSkgBE4Qs7XUPz3Bp6+d/EH8czTiYTDdLjYtpuyhipaR1hPs3k0PvxQQEJ+9LmgmdZVQb1i/o5hKvEQ03hvOtEwVLXbcqjlslM8gNF+dHelUYUa8giYntDINdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQd+GEynBdf6moMxtrpSIuj2hqoqf+5UWwE/kux4hv8=;
 b=XLTnc8iFdqg0Q7UkNDzK4nm6TnqBtJM7dl5F+gNkVrZ1SS647aoEtWs9/GCZfAKdFEK3MHncZJAgjnh4DD14Z4uKdvcYmKnpXzeIsp6EE5FuQTEliz2BgPJhMaEFiz426w8kInZk32H1RAZnJ98ZNQdXC+X3gHx3NFG4Su38bfSwXpcAd89Bkg/YtABrFM0SVdijviBYAsDSF3JETECDYSYQM/L6UtydS9YR3He1kFYTmlOLnMSaPlUYy+F5/+QK85YaByFjtriIE/qNQQaKfLa5Po+ciCRFlImO4hEs8toBKDGjWFXjwWnvBa+xNKwa2L6hATKRxTmn8ou99qI3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQd+GEynBdf6moMxtrpSIuj2hqoqf+5UWwE/kux4hv8=;
 b=ZV6PUqmjlD9e9k86FyV0QVfxt6Z+Lyc+NaYe19EHQfwswEVO9YvGiNA5AokoISvS9jLLw4vLm1+RMzSfI2rnVTtIn2IHsalZUGtwAHgwvE2SkWkkMoFwOf7ycTkkUUZJ5Fd18AW9RYV+Y/EjS+MOk4LO833xKG6okz1iWL5W+oQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:37:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:37:04 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH v2 33/35] osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
Date: Mon, 27 May 2024 17:35:19 -0700
Message-Id: <20240528003521.979836-34-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f91236e-ae1a-40ec-3b14-08dc7eae4baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pJjkNDlf68XDA89G6ULzJ6EGiHXdnG7QGQ3rU1gX8nxcsbG9L2mi6noux3JB?=
 =?us-ascii?Q?NWP+VGtOlkYz7bVTbmppgfjkVtk8D0fNuhuQAWBxkDWsX6FJBwtpQpdSe/dV?=
 =?us-ascii?Q?BEJvcs6KC8zQD8nh5C8mjRGbUOkAyWavGvZTOHwzxNfILD/Au7VnvxueAz2I?=
 =?us-ascii?Q?5K3fL3g5Pj7e1vtFPOOuuTGhrzDURPy0IFQMvuJOtZYEdzCX/Q+aqxT05ZrZ?=
 =?us-ascii?Q?r2JdCCBd55hLbXh3ZELq2ShsCDTVpmxX6vq7xjIe1Et6jqgPDtD/Bf7LX0WF?=
 =?us-ascii?Q?VF+7swRvgwERexOuoAHGLtreli0wA530kcO2MQLtW1L0mCaC60HCUSkKQH//?=
 =?us-ascii?Q?2lqnZXL/EvFkg0hxgF05q7XCKJKu0WyMsOfWTtogcBMeeHp9Wy8q5nFL2l65?=
 =?us-ascii?Q?DLwewyL0ZmzEp+tLYoa2kazZNPRL5D1l9YgFHAEIjXDhOqbKKi/B1Y+dHs34?=
 =?us-ascii?Q?DOnTNqWNlzcxSzqqGz1+Dqa8tOhNRF3iV7PQ57QovQCzmacCn1yoIqs7PGCy?=
 =?us-ascii?Q?QyQ+3eTUMumoBIXkcutJUepr3oj7+Ud8E051yUcyv4ViyaDxjM+lLwoL+1la?=
 =?us-ascii?Q?Hvkg4p7KiTz5siwMklURbUJzsRg+rIw9rZ2IXYvjrNznkGnC2P6v3IKj4PJ9?=
 =?us-ascii?Q?T5jRhf5S1YHWb+7ZvsDOHC4OTSpAxSIvmRt9abc0qi65UdVsJZ8aHczx9VJq?=
 =?us-ascii?Q?K0LBnXSK2XhuYZsI9+7HeUx+7L1pjjUBZARMg6XfeoLxCBc3DL2/GIp/IysC?=
 =?us-ascii?Q?J2aXTA1gfKsn/rQGkZDPH+EPQPuyNV3XfP4j4Q42jJAMFGFuiYA/ZXSsh5Yd?=
 =?us-ascii?Q?s88HLeBjH6PeONraIixwnG6F9sjxKpruleSZBmam/GoZ6xRV9aAA6kALCUti?=
 =?us-ascii?Q?JezU8p6/TuIPxesBoYUrYsGzaMUW8OVDi1P4JRxu6N9DW2u51o5VTNqaMPA5?=
 =?us-ascii?Q?Te0te01K1FmJwF/wKVUal1wpLfB7fNPK8NWYw+CeSiTQxOePaRcL1/v+y/U5?=
 =?us-ascii?Q?Ky9ZvCb6iTTQ14+MHHGjxFPtolh/B0xVUp//WINQ+ROsHLTZd6ZhCEu+A70k?=
 =?us-ascii?Q?B/jVw6nNxfFTq4D8rEtXiX1vfEPJY8x30CX5pCz8XbbIs6Rn3DGf/QoWlVUD?=
 =?us-ascii?Q?SN1EeL9oJqNwsPcfmgbMj8wEVW+sY/tX5nWH5Ec+/WEknIPQBQXedCzTze7N?=
 =?us-ascii?Q?nVgkamQYeXSW28f7ZEpPbX/fQXlC4zEZplCtY0CX5gT87IbOwPBg+JmpX5Kg?=
 =?us-ascii?Q?45orJZ9uAF0NsoxiQmDVvpweJegUmaOWL1Wz8NKZ4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+a086Osm1ae12R0HP/F5Wv1tfnEY2L0+zKa9mOBdtWVY/vJF/ZBDX1nArCA5?=
 =?us-ascii?Q?pv2++hfSjhGjsWKozC0axk5ERkqy8GnEv8kO/ZWM5O6yzC+zIJuUQ81+2pFl?=
 =?us-ascii?Q?Bq5yEjbiwDn2mOonsOcUZ/cINzDkSBNBrBsXsu85twK5A8USZhQSI7XNA4kt?=
 =?us-ascii?Q?5u96CJYLTaxGZnxQDmwCnzbvkRidpEgw6xRXmbauGWhvrD/UMY0JysCAe4kN?=
 =?us-ascii?Q?9ABb7mZAy4RmSjQdLEya8ZDPtMUI5X95NEFFfsmcBoyuBmo9IJaLw4FtXRn3?=
 =?us-ascii?Q?Di8UfR0eGX5HbWDEHx6gsvE/R2UrZqw35YKzC+Bk4ckQp4IUma1IjbqUGlgB?=
 =?us-ascii?Q?II6tRHDjWWpFV5ZKQS/XJ4r2+QCH/Q4103nbY+L3N5xdZTHMotAYVwJXwOh9?=
 =?us-ascii?Q?owPc8X1WQxXawuxSdC7pFzsy9TVLgqEm7HXgySFBMKHwQwLIyqoF+z3o8B6P?=
 =?us-ascii?Q?zwZymdb9LrP+NdS/Y8vzq5+h6bo0NS7CxCHwNpgVTRLWnG2capYMqtO13pxv?=
 =?us-ascii?Q?v78BQtDZz10vrVYilHH0gCF6sdEGDZew43VcBR63hOubTstlvOC/AYGKNzmn?=
 =?us-ascii?Q?UAfcEc7QWMcZWVcZI75pVOTeai0OZ20ycz6wAPpPl2AZcktQUF4/F+b+9u6F?=
 =?us-ascii?Q?qxyiUjEkWDJ8VtpbfhczHZxy6N7x9j2z7Wdd9LFQVYwrp8eKl5Vjr2xzq0pe?=
 =?us-ascii?Q?ak+o3tIj2cvDARjuoOwfF6r0M2OV4AmWUuIvu4CWcyy/C9/ePDU3vEdE9w+E?=
 =?us-ascii?Q?W1WDFep3PnNEK/sZ+tSgIVZg7KC1tBNHMFN0wJWg7bJ97mPLXqGyohSiKmUV?=
 =?us-ascii?Q?E2nbzIoRbRrMPiPr8h/d3j8LMBI31mIlYybwLdtA9Yvn9ZKJw3E+wDgMUvSD?=
 =?us-ascii?Q?IIHofvXiTiJbt70XY65PLB3QYylXinI6g952Bhgnri4nHUXqufrXOhSRy4GC?=
 =?us-ascii?Q?DuzdsIBOaj/vat7nrHbwZbcGLC0OR73U1HQsrS7GI3s55/8AWjB7EbCEJjjQ?=
 =?us-ascii?Q?UMkD9EEQIBq9eCGYEDU7oJT7g6PyZHLY6Hejq4LqkuXNu9T5vtzbms6GPo2Y?=
 =?us-ascii?Q?8NOmOjHId1JvSYlIsWQ2YsgOzJIHXZwH2VRm4g+two61o/aDH0JRocQ5KyOL?=
 =?us-ascii?Q?dFbEBRPApgUMTQKvUjXt5pCsX5Vfj5Frl5iFN0xbpswD8SPozv18Py4f/2SC?=
 =?us-ascii?Q?iKZSqj6weV/Nh46jsS5bSZK6ZxWZcpczNuJ7XmXdGU0xrADLa80I6uhkC0wX?=
 =?us-ascii?Q?dFNBj+jP0ZUiqWpdP0h8U6VHcuR9x+ZoTVdOnwi9GBqVjwo5U3AjRlNGAyuv?=
 =?us-ascii?Q?33Cqng/hBUBRxfGEfGwT/4dvH/m2/QQaXmqWqD9wZmV5bitrOuR5B9nsOtN9?=
 =?us-ascii?Q?p3bozQuFJ8XsSkcv+a71bohDOHyKZQGjrUst/HML1iPYMipNQz2K8LSxaJWm?=
 =?us-ascii?Q?T6HiZ2OOitYEpeRbhuk7PZz55GSV75KpI4QtpgOsKmUVxMbM6mW33tpMMTyu?=
 =?us-ascii?Q?rsh/gTU6qon5OcO2kt92PnTfr6NSgmdIm/t61ecyekhbeg4zUzuakqqZwe7w?=
 =?us-ascii?Q?m1Ea3bqZPO16WGG7Bww2NXF2dp05rUhHPk0EK97fqC6EDSJRsQYE5DyhOkI8?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fAa/MlAo8J/QMKl2HABX96609OE963M0+QlYqnc78ZnWa27wXp/gvhGxe2Bqh7CXtU2ETFjJruqsHSZ47B8LnUfMEZKsVz4X/gsOQfgD1VekURcjngjQED4YTXj5nNYhJckgFwysI28Bb0IzatzVCFfFP8YI9i6j08YdDqjkNCdPs6eoCSvi+UyuN3StRTpg/qz1RxPW0efajh3P17SCVoxf/iI6YiISPqmyW+tn28k9V0KJOTkYHq2PLpf9zxhvQjJR2A0c2YGivCttnZwjQs4+ARCa0qQne5Ie4OYg5rF3KjUX7tAGncIa2BH/GFTiT9bKbHYMpXWAxfffx51EwIb2Fdz88PNqb4g21S6OWna7j5I2iS2JS7Wf13qDYSuPPAABailcXlkS7aTatK6C4VANEke+0VgobwzmyuSzm3s4NQV03xl2rGsRVxhNNrNh01CLciellw0UrTOEfJeMtY9pqNZSu9hGGKHKMKVw2FDFemcWR5KaOxWnHJXzsXRHhUpp6+rn8DeVV43TvwPzBVVUiQtQ/h5z010uxR7rjPiyBZbwHPkdrGWJEjbSHN+0Zcs+mGal4MqOHVKLWHhTdzB2FQnK+pKcvIcJIzT43OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f91236e-ae1a-40ec-3b14-08dc7eae4baf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:37:04.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsqwZ4EJaVZHsDlFcEBA8qdYvo9Dh/dpBgN7lWuXR+W0SqwmUu0zBdR1uMHwjMcp9Uh1HcRcSY2E8sokM4ZPEiNWR2Obm5PV+qVbcYS5Lvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: sLXRKT8sgn5yfogNLaS4xwIllEpBRT57
X-Proofpoint-GUID: sLXRKT8sgn5yfogNLaS4xwIllEpBRT57

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. And, for PREEMPT_RCU=y configurations does this
by directly calling rcu_momentary_dyntick_idle().

With PREEMPT_AUTO=y, however, we can have configurations with
(PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above can
help.

Handle that by fallback to the explicit quiescent states via
rcu_momentary_dyntick_idle().

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271..88d2cd2593c4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1532,18 +1532,20 @@ static int run_osnoise(void)
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
 		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * This will eventually cause unwarranted noise as RCU forces
+		 * preemption as the means of ending the current grace period.
+		 * We avoid this by calling rcu_momentary_dyntick_idle(),
+		 * which performs a zero duration EQS allowing RCU to end the
+		 * current grace period. This call shouldn't be wrapped inside
+		 * an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
+		 * PREEMPT_AUTO configurations), QSs are handled through
+		 * cond_resched(). For PREEMPT_AUTO kernels, we fallback to the
+		 * zero duration QS via rcu_momentary_dyntick_idle().
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
+		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
 			if (!disable_irq)
 				local_irq_disable();
 
-- 
2.31.1


