Return-Path: <linux-kernel+bounces-191568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241658D1100
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0195283006
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1918654;
	Tue, 28 May 2024 00:36:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A086EB5C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856618; cv=fail; b=ZEdwqTk76zQxyqeDQe0nxcD+1ZWzO7ZJJHFLelEvc9FkVZ9ageGOfO2UdpNKSw+DLtU6tBjAvKFywUiioiNNuCQAVfLUeJePETJUDWgXoBvm9/UU/DwnABDpnQFev6l/oJplGZiYPhhcORCxZYte5zsLDhEvctRqzcpgK7QhVDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856618; c=relaxed/simple;
	bh=Mwx4/heLmV+vteJUfAIUuCWtJTvrqjr3/1RxBE8qbOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3px3SYuG5GQPuBuMECdTTb+t3pchjtDsoqYqo8YDrNOLRyfmSv/Fi5G8rimBz9bo3oYCGqa+fIk5mpsyqWRQAl8ogxlphv1sfiIqVUvuOjnCWO3XFFoUkZFimhWpphjpVYC5PaiuDxrJyW5/VKTelV74xXUVKj6dFSV/WWQpaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDJ0e0009949;
	Tue, 28 May 2024 00:36:41 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DaNS8C4RWWXI/OiqvVg7PrPyxFuCF4ok/0PNMpoYWqVs=3D;_b?=
 =?UTF-8?Q?=3DeSmZh2SlJIrZh7JtKMSdOIyvuC6P2ib3md824AkM50EuFQ40SdfjmTgTOLcZ?=
 =?UTF-8?Q?KXUmsNq7_KEogGA2HhyCCrCEnaZkx+mBwlhvxtrzgBAI9zrY+HyE41tMRvBdLXn?=
 =?UTF-8?Q?QrUewYQwoLDz3d_PMwsF91fKNjO/7IUz0q0L9VFJmpGdcfOjgNNv+XfBy0udiBA?=
 =?UTF-8?Q?b3JWiG0UTtgKu96iCTrE_DZ5Xqm/O5XvA/ffB6FyHdRZxkNwP8iR0L3Jcxe9+ke?=
 =?UTF-8?Q?T3i/QEdNwNiPv2Himjo7B/lzbz_9BTKa9KxJuyIDLa4gnRrtao7gFN7y+xuYSle?=
 =?UTF-8?Q?d41S35pPLdrYXKzgTqPQ+SBvFc5XctPt_ew=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RMfYqq016188;
	Tue, 28 May 2024 00:36:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtg7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROquyrN0vQOaUXhXNcZCXyeOxRIyUpjVMpA3cMnwASeJqNO4VArkmFSMtBmrJDnIBXp8p/pSdF4RJBiuC+g3sTGCSPteilB4k2rBQsStJ8SSzoJPz9pLD/4XR5sQLFWEsVc43gphF0VeLuGD5ZgLVVfi0CG6rS8k1Lu+qf3IVwqojbHNGlu/fUxQXZm6RxQ3XRDqE4/CDr2VqCZzMwSJoJE1DYYXAr2lKmpb/PpCNnpMaZ9Uh8bplrmiYjZ5r1XETDfLPycdeBVMLeqYaBqimFEbvI0yo8+1Yn8H0qhc7G0w6yi9r3TgDoFipPuGpIDMaWUch4kdDX/lIj/SiXnLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNS8C4RWWXI/OiqvVg7PrPyxFuCF4ok/0PNMpoYWqVs=;
 b=VrDkaHSlk0a+3qe5BqleEXR84VFF+KMPdCdPgB2VpqmZ9RDvZtyuOjwKm1/zJ69XxHmI6wLdw6s7BQvURORdCnHawCCK5XKXrGZVmahJc3kclutOnKLoux/e1PoVDxjPzzyRuxG8y2V82XX8ZrMyXUCtsYi44duWt6aS0WJmZ75rD9y6Fu2/7yi1wVAsPiePZQ9qxZ45NHibLIMQ9CiyWznlZeZoPWFj37vrefRjYkj1eJB1Y8JWX38j2NFDrS9i0fBtOrGXTzWy0cUDs0pLMMZxIzQ1T89JBeBRkcRC/sZY+5q/rqvot64q/NBGeN6T/4q/tHUal6e8ELuZkhal2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNS8C4RWWXI/OiqvVg7PrPyxFuCF4ok/0PNMpoYWqVs=;
 b=czMv6f1uourMvRUhDFX1GtVs/E/Of9bakpDeyMX/dRBWskDXP9g4R8cH8tz9AR3zHi02rvIgUWePFn3mI5LAVce2MzDVGo8p++CppLb6ypisrSCaMqPgfN10VDj2ApaxPK72xEmajXGIsMKXSHtsMxRHtFaTYHr3T8UqAMcFzm0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 24/35] sched: schedule eagerly in resched_cpu()
Date: Mon, 27 May 2024 17:35:10 -0700
Message-Id: <20240528003521.979836-25-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 394699c1-72a7-4fc0-a39e-08dc7eae3c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dxdWLjW4Fj9+XB4w7sVl5LMg35qIIrUn4UonAnJbyv46w8g+8H1/GD0rv8w2?=
 =?us-ascii?Q?2jVGj57NSlB7fAE27W08k2fFGYARYneCG+3TAp28rBEL/QuxS+fwJVm9aYjg?=
 =?us-ascii?Q?VZSZBelMpR+KLVgIFXuU2UN7FWPWTBg/FnmadKTWhvsjzbAx+nsEcKvM5C0U?=
 =?us-ascii?Q?TCDp7URSg+gi/fNDWdgee9dCiQEzhXk7cQy6yiGOAnm/SSN8Da1yWFJ5Wmib?=
 =?us-ascii?Q?/CfkQ5miKzpQam1HMPC3Dejp2vGXc8VbE88rFh2lN72W5BT5naPMYPBx1Y3I?=
 =?us-ascii?Q?neLXrJ7W7AZDYknoD8IuZVtbSklnWXBRSXCmnogPTJa9avc+zeKgYGZzWidc?=
 =?us-ascii?Q?R8GWwzcR8XTKCSqW3zRZ5B/CXHYVT4zlpNjpkQCKw0geDUygtEO6m3BkrTRz?=
 =?us-ascii?Q?KIC/1iSsF9b2QRsP1V8hAgZpO64UW+/Nn0fSxL57OogcdvfbxI3th9QyU87z?=
 =?us-ascii?Q?YxILPZTseXCQGJliJJ0PvO82z05o7tsMn7RGadbI4GZAcaR5OKm2yzgmrzOM?=
 =?us-ascii?Q?muQt7JG1YrSOCCdO4lg0uWaFdbUsIa1HpM8dgkOHmyvIzVeYGM7FYNjJpvCQ?=
 =?us-ascii?Q?QVdmtFXfA2/c1297PvulIs1vgq72oTDbLQZlOiinaQuyEa9Gh1sfmlqCNojH?=
 =?us-ascii?Q?8n1clqxrlwZwvB9z6JkU/3Bj7MpWvAp3sEHIIJCwbzyDbL3RdWmKiSi7iGxr?=
 =?us-ascii?Q?IdWHxLtwfQCRShp7EHlJwi1dxXy/3YT3DikXWexR/jlgCGnmIwdU5yLICHky?=
 =?us-ascii?Q?7HttKvE83NEoycwfJWPGZnEiS0ukrQBma0x+7vqyPrBKZa9tTU7IA2JUXLkW?=
 =?us-ascii?Q?Pi7XAvm1elm3U1mNLSpMSdHURDSzYJaeEFUMpaQb15+xCCHia/Ms5TqWIZg+?=
 =?us-ascii?Q?Cet3Ln4HGwkmcYxNIgsvOEF4PDYqm47CwtXBl27AYCK2zaYUp97egmGFFsYX?=
 =?us-ascii?Q?czSmpigQhBavUVO53I/gKtR1qxIMxypSpyQsGSo5QhctLbWyJ39Q3+UOvMZg?=
 =?us-ascii?Q?blSPDucr4qyLZSB1OjVRvscu4mUR1KbDIo7YGUYG5JF+nVo2gI1X2rRXBL0M?=
 =?us-ascii?Q?Flb4rBgEpU0iGybbqQzI+zYGQLywj9GguuPzfn11RajSh/LOdYxwkhwYwWpD?=
 =?us-ascii?Q?CduLS4FVdhH/jFFsAsrLb36U8jBFP/lnJxg9hFMHFpjwVMLURvPJgGr/F0bU?=
 =?us-ascii?Q?YzSwiv/IIFavctXS+04jecvxzn8YRyC7oveWsmVzKlCetKhlauUtDpk7ITGO?=
 =?us-ascii?Q?C60wpIIb4XiIltR3rI2TGtISVmuC2owRxzaYGnHT9A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bd1H57JzNthpUKErw1ageFiimshHjEhOBYqKKY0gvTXS2S8Wn8Va/WJEa4o3?=
 =?us-ascii?Q?tZRd+BWsiiXKNs5EbJPS5RWNwQn3JdVp3BqFEA8dWgXD6H8Xr7CeyE7roGN5?=
 =?us-ascii?Q?yVLBbpm1wXsoZt9r36ean5n5svmYnjDbBE8EwfT1kMlp4pef2Lc/OkXsu7UD?=
 =?us-ascii?Q?menZLnaQxB1LKfSwaGvG776w0xiYl7qqIVklKSHeIHxjrRii8MM2nxVBrmbl?=
 =?us-ascii?Q?zTS2f9H6MHbftLmS5k5L6Y4qesEatkJCR7X4CKYpXyjg/jRjt7XWYxmPF4Na?=
 =?us-ascii?Q?OnkIGEKkt49ucXMxahHKL0K5nrHerj9CdQ5xun/+1TvpDqsl1Hz96qhUVL9n?=
 =?us-ascii?Q?5Z8fx1kdd0D4bE5IIaghyGLdP2J0wIQ+IovSLs/7BFx7jsViaNEwvAgKKTTw?=
 =?us-ascii?Q?wwkdKin5h31Xy8BZo0zwbjaJGnOw0cxnNBJwdbWsa49LKuajKHDkncMYzm7R?=
 =?us-ascii?Q?YM6mlHAdaj2JhrYts62qFyOkCX3ETNl+hMmLI3GQAVJsn02NpF+Dkk8uqgzn?=
 =?us-ascii?Q?GgEDajja2aoXUa7FL654QmwmusO3X6b35yHXO+HtdtK61kb9f7e0zlbMLVgz?=
 =?us-ascii?Q?Q/smxI4G49f35glgBA2G/2BGI6a5xtZQBOCWqVtonlmwLXFfrG7ol8K2lbH1?=
 =?us-ascii?Q?X3ItrjEU4P/RmjDyCQv4vntpIcQbCfL43HAHvpa8lbYT28+DITiaf/8xMqQq?=
 =?us-ascii?Q?j/35z4WtVHGST7bFgg++UszimfxT9NiMk04S3o0L1maqH9pvAImYE/sgFdH8?=
 =?us-ascii?Q?t4WT5SzOWmc/RuZSLBVfnWN4NW1ve1sorGgYtD6N4NI4QKfOroWaw0a9BCqf?=
 =?us-ascii?Q?YVG47cwxB2/tjZFstyFRCeMnuqX6SVk9jwwpJVeXdkzRHrGrqy4mRrFtg8T7?=
 =?us-ascii?Q?1ugo11xZ0E3tix+2g0E6AP2J2PsihskEKoKDCfehMLQ5h2XFiP1A3NQDDXgw?=
 =?us-ascii?Q?uKIf3DmLeD6YIJwUlbKapOYue/KCya3D/+0e5cGRfrJyCc1AxtYPs1dBkcQj?=
 =?us-ascii?Q?KRqf2A7OfrHdmtu1HvSuU7O163DSrWfViWoGurx53+YpzFR+L/UtGm/wGGGN?=
 =?us-ascii?Q?ISVqVLan/X7niuXAu+/JXalSWqJe9REe3H78NSIE9NZgu3QmHPtSQ+eTmDES?=
 =?us-ascii?Q?3PTuHK3WwMRzNm20DEkJcHeyfo2Txx8XI2QHeX1J4FW9sMCsfODKvGvuR7dd?=
 =?us-ascii?Q?8hLMLrxpuGMzvGuskCBSdS8VhqC2dd5rGbi2CkOpG/41npzMlhtAdxlMVJfn?=
 =?us-ascii?Q?gtiW25clSqDWfRp4+MJHY9nTmFdyOtxBh4p6y3EiZJ8TY0mCedF5wt9fNCty?=
 =?us-ascii?Q?Eq7aFikhBUDE7QJXg6PVOJRUMrOZagbLG8pGfRoMmBWxtoEkhk0cmOrkUm8b?=
 =?us-ascii?Q?iM9z6ZvwVovzPZJ8mI6uH1BP3NcsBZzLLL6Roz9/KoHWI9N2YxYfV2txT9dQ?=
 =?us-ascii?Q?O1WfmBQ4PtAl+lyxzfEP3sWtRIHnD3rDYZRYk8ZVa7xPt4Lo4El8PJn1QVOY?=
 =?us-ascii?Q?0Hqm22CVoK9NDWo+BdBkb7zRca7H7c/1G4147oaZ8o4cbXyCbKr1yLFSzSdO?=
 =?us-ascii?Q?2zAV2sGjz60RhFYRWC+n+u0paXrPftiAwHOErwMvEabSCIKdF/mzEEg8VnEa?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EHd+Rs0AXcDpo1SHi572eeB5yfsQPT15YHlqxPE4QIV2KZ4vdn+eaKUsQqhYHwEhd/wCM4iC3z2f+80Tk8hF/7mswNBwBS70/FH8/fPGM+9EYhH0R9Zg1tPe5VBWWm8G4EyV9/eC01DOy4mYiVNfn9MOAZvMgE4YpqNX6HvcImCO/h8G7OOjvNLxXNEotua0Jh7SWdszbDXapq1TwDcaswL2w9qwKhb8xX/+t8AdN8fSiBqpWn7R3VPxDVbTLpvSxVDhAuT2nsPJGqANj1qa1nJD38nbyJzbc3MxDjRzXuPpcC7rPt7KQXVfQGuQtEPY5LTrMzEomvEqfIdXloqqTMgD4v+mXH6WWiwpKn16Zhog4/UnAjiiJcJVJE3zFqVBpClUdPC+gMAaiR2bIDpSMIbw1rR/mdMo78509kCJHao68iQTfZi0Kc4TFZ15ZXxR0FnJLxzSedQ/FXPhEsqgaowKhrXEqyAxwieEwgJERBaw+SAG+/LPsritcbPQPytmKNh6tAJp6yiXMST9r2P5Apu4Hm3JSMFAHTuL/9A+EiJHZx4iI+twEvTfIL7VxlODuVUcM5uL2VWFs2H83Ol3ROC0bRteLl43niqjDiOQorU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394699c1-72a7-4fc0-a39e-08dc7eae3c5b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:38.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rewdJq3kCSrrxeGeS6GW+hvD50L0rOcITgJBYs8GY0jyoBdAy2GbKLRmCtflGOjtbumymrq2p8NBHUM/I+j7HYq1i5PkxpMogdLaFPxQVcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: xHIHnNaJOPstmuQBwrSB2x1HL4rzGM6d
X-Proofpoint-ORIG-GUID: xHIHnNaJOPstmuQBwrSB2x1HL4rzGM6d

resched_cpu() is used as an RCU hammer of last resort. Force
rescheduling eagerly with tif_resched(RESCHED_NOW).

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 14 +++++++++++---
 kernel/sched/sched.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1b930b84eb59..e838328d93d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1035,8 +1035,9 @@ void wake_up_q(struct wake_q_head *head)
  * For preemption models other than PREEMPT_AUTO: always schedule
  * eagerly.
  *
- * For PREEMPT_AUTO: allow everything else to finish its time quanta, and
- * mark for rescheduling at the next exit to user.
+ * For PREEMPT_AUTO: schedule idle threads eagerly, allow everything else
+ * to finish its time quanta, and mark for rescheduling at the next exit
+ * to user.
  */
 static resched_t resched_opt_translate(struct task_struct *curr,
 				       enum resched_opt opt)
@@ -1044,6 +1045,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
 		return RESCHED_NOW;
 
+	if (opt == RESCHED_FORCE)
+		return RESCHED_NOW;
+
 	if (is_idle_task(curr))
 		return RESCHED_NOW;
 
@@ -1099,7 +1103,11 @@ void resched_cpu(int cpu)
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
-		resched_curr(rq);
+		/*
+		 * resched_cpu() is typically used as an RCU hammer.
+		 * Mark for imminent resched.
+		 */
+		__resched_curr(rq, RESCHED_FORCE);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7013bd054a2f..e5e4747fbef2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2466,6 +2466,7 @@ extern void reweight_task(struct task_struct *p, int prio);
 
 enum resched_opt {
 	RESCHED_DEFAULT,
+	RESCHED_FORCE,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
-- 
2.31.1


