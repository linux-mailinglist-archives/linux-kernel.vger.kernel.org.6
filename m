Return-Path: <linux-kernel+bounces-191555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E528D10F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A572823B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F472D627;
	Tue, 28 May 2024 00:36:21 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F085262A3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856580; cv=fail; b=pqD6fV7YY1pwJDCVxq7sk/WHOYU0o3c3bnUgQLw00v3Bteirsrx+nQjR7ZTcrwpiAAIUgY65PrZLgADAwkEClo+2LXtExjkToRCVewMR20rZznEN7CJ61I8/SELcqaBSBzWUN30v5wwss/Dm5a7vnTgCaTEiy9dmLu9Fo/Jmr2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856580; c=relaxed/simple;
	bh=VmkLbzlWA/qTIXCG14/pcRkneOQKGWF6KF7BWv+wyI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gxu2iSHJQHkBUz38rYjEJ4eU6IWj6awQZOt7Q/mEFr8ltYnHxGCsDR6zq4MgWtIRZY08NsvPqDMj4ZShCIb4/8lXm6agsomqReAWoBKhG85jrvn/WcOwWCtEQJy0bJRxitwhPDcF+tLN7CvwGbadh6+DLnGV51zUtR30L2x0qtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RH4hwk001304;
	Tue, 28 May 2024 00:36:01 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D+V+7fdimB17QSblw4cjr+lj0G1ZOiwMo/hnJnWcIzqU=3D;_b?=
 =?UTF-8?Q?=3DLhdO8RCGY357PvrtZIAJ+/qUxeMiozt3ZaPJZnvNCQJQBAQ7Vc5pz1ZPAwNZ?=
 =?UTF-8?Q?8UkShcZt_1LyoJbv8eXNjnuH3yJI3wFuYWkg+i36YWjFQkc7KPJXZRiseUyifXZ?=
 =?UTF-8?Q?JmWO6EKL2C/PWs_xH42OFo2F9jrdk9dJyQO4VHYnUPDK+cES8Petv8IEMLVrc8v?=
 =?UTF-8?Q?B28NP32GqAKk6fLZNOLn_4rZa1fX8vzp1z1gUvTGksQEBKzxJoQ8Q+JTNOExq6p?=
 =?UTF-8?Q?QKYeChRxDoD8aLLEjQ/Fwic8lU_JKhOvb151yGYhA6f+OZhA13r0jcX9ArBc+je?=
 =?UTF-8?Q?dy0l/WEGy30j6azHxP42YvzV8t8bHOYX_kg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9k8w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNjdAM037233;
	Tue, 28 May 2024 00:36:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc534rdbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSkdMWcHJUIETE5JzRvGCeJXAP8zefokncmxqoOpXZg31OQy39/Hgf/EufbJQ/9QKf9c/M4c2tpEyIU2wqLNuH6j49Tf4lFIfbbjPNl0Lw2+ipYKbMVtuc2GTwLBckHTLGkUdLVNrF55OgSeZDIF/LPFq+VQo3S7HIaALQpMYdgX63N4PJqKamgUmjgWro6l730cxThIDIVvvT/lBL0OF9Zj2o/7aRQLCs4nC9gFmjEHPZFqQkGwL7Vbbc0A5qSuTyeLD04lqvfR6TUj9BRwJB5JVt+XI+REYE79VWoKVzlymm9SUHWn2WxiLzw4tC7ww08nxfg0AfyZB4/JkYKO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V+7fdimB17QSblw4cjr+lj0G1ZOiwMo/hnJnWcIzqU=;
 b=BzgrOEL+MyFv5khz5H9udUU/YprvHiHALzFdKkPNTWrt/m6J04ubjTNrX/vsiIL3Dy8o9ufviPuQZOE704z4/6nftBRvisImAuIVvJas+SvdiyJqy1lEl2shrvCDe4dOl/1g/Xn+MFBTqbU1zvsAnvEdhbCKtCmuQSnBydYBrxmtmiblLOIE3kDGftod+DuEHcM81NhWiK+UUNOfkfEGNbdeZ6C8XBuNyCq/mn6vMTxNTmyJjesJtXvzRnosCje8GV+Ecn5hlLdJgbbE7uyyaxl3ensA3A0mYfbQ/uJ39g+U/aNnLmvn+M9uA98NmHGUHS8kkFnASgdjmQk4cdsBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V+7fdimB17QSblw4cjr+lj0G1ZOiwMo/hnJnWcIzqU=;
 b=J+MnYnt35e/fhYrTk1x5J6i/X0gYNIrBw5iSN1lwWV59vqXiRPfGul6hvEF98AN2dEYXxtZnljaTfAkigtcS6G1XiLhM0B21SNTheO3Tf1afFjl1e9JqjqJxiGa+1tvGKri7TCiD36Iv0VAMlKTi5TRbi8ETrWqhh2yZlkn0n+s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:59 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 10/35] entry: irqentry_exit only preempts for TIF_NEED_RESCHED
Date: Mon, 27 May 2024 17:34:56 -0700
Message-Id: <20240528003521.979836-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4b4bf4-b1da-4235-8bce-08dc7eae2523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A0yzyydtlhmHYDT/HRsQJ2aepE+gYAZ2+mwkY+1HoN4S74KxMjvj0DPZmaSP?=
 =?us-ascii?Q?y6s+R91aDFxfEFeIbWz/WMa5WKov4K1RS9l4KC37TEe17zOHhvFLsh+Wwqb9?=
 =?us-ascii?Q?cMRQr3UBeIUgB4ji87BMgPtNyUN3BT0i5QY53J4OeUX12Htb/IDUCIlIlPaW?=
 =?us-ascii?Q?hwKx98ALtANTTQeF3SZdW9yJKvFChlJvhJjEziysNHG/qbZXIvSic7xkiaBq?=
 =?us-ascii?Q?kXSMuxEZYCJzAOx/FTI54eUdLhGU6iWatUqLASm+b71WABzIzJqtXEDPZJKP?=
 =?us-ascii?Q?ULbHR3Lw4Lc/jzRUP5TwYYAhYuQx4t3E4bVRe3ICsuzPKXYLBNPqpGiVnjCT?=
 =?us-ascii?Q?PfftBj7pwTh/bVcJztodtSph2hVLZNfwPhu07AzYA9CnMIKYTrYvsTEA6QLj?=
 =?us-ascii?Q?mMVQ6cVouCNvVn8vVzhMkhmAnEtAnIXGQsORLth3bODpNMsaq0O21PBWUbvL?=
 =?us-ascii?Q?+/J3lU6hOcy2BdeEiafSjw1pyT5+O3FUj/Vkx+uDlaYx3f2JAMUo9CACR8bY?=
 =?us-ascii?Q?MwNi4VsCxiRkPcJoB/c2Zi1Jm7whKu6CwVak8gxlsvWsj3NAKaIkv3TMbDg4?=
 =?us-ascii?Q?bt1yV04JR1n2HOmw4y53myfUjKuNgKQSkhewscx6/ahoadJ4s/siqSGr0RUu?=
 =?us-ascii?Q?6r6bbX+noDgHunSUcwZVmkvkZFhLeuF1Ip5p9R1e4ch6p8QOBZW+2cX1n22w?=
 =?us-ascii?Q?LGVy9XZDLCr3Nchqth2f9SL7Nmtv7GwrghAESz+6v0f2tUFXTPlaD1Vqn6Ed?=
 =?us-ascii?Q?SZMULefr+sDc7QRD+IvIsyOe2nG4cFcpxdK6t0Rd2RbSr2hv/aqdr9pRK+w2?=
 =?us-ascii?Q?6RqNxhWCUb+REaUh9Im8Iuk94RcH75VsWkB5pqAM1+RWoDouLrW0yQMkMGP0?=
 =?us-ascii?Q?lZA2gpqEdkPrKx6Ic5FnNQi12p527RUYKYOhIbFxEEJb54muCBGmWkCjMEub?=
 =?us-ascii?Q?O9WF2ylXQmO4S1sgFqmswW0xUkk8CDbvBwqS7wVqKAVjcyoD6s7L8rXUuQnp?=
 =?us-ascii?Q?AhpUvG6vveFDCt4S6cEBu+IklavuGyEoNK0kDV8QiJqdws+ahjzQLFFHgrjj?=
 =?us-ascii?Q?4TiqUPl8cw7j8dnMiWEWBRF2zfNObS7lNsyG7i2mLoQm+O9lB32jyWgWa/zR?=
 =?us-ascii?Q?nb95WToWVdZfYFCLjCUokuDd8G+nQc1ciulvI5RdzTZrkF6FTfOK5Ek4Pc9W?=
 =?us-ascii?Q?j8HYJwdpsV41Zyr8s2uVJNINgBL0ZfvGXBzw/TxM1EpG9aEs4S3TJkwt0MY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HnmjtQeK88C6TOMg/QPP22BBZEJWJE0pNGcVO5SW2BTgm43d2RR82MLFXS5Z?=
 =?us-ascii?Q?VFr2vSOZKOD7BrdAFIrAH3IHRwNAMqE/50IJ1gNt0Gn7+SS2Cm7bpUE9Eugy?=
 =?us-ascii?Q?MG1jmaJBo2RH+vDEUqPl7O/Kz9yOjKG3OrNCfVpo5DvBKgV+lSZp6Cme9XtJ?=
 =?us-ascii?Q?80k1vMx045U7z9eHdprae0OZWiySuOvB2YRqbx1tdNwIDS2HxL5eaab+jEgD?=
 =?us-ascii?Q?FQMSe7crautMmZcEAiT7HhNfa7LdD64b8cchGruG5k/ySYjwj3uAerK5wcaP?=
 =?us-ascii?Q?Tk0FSjPx8q44TFnLI1jfFVfgRmL0HusZjA9wJUOKCnLAPs2gXgNk3mlpsEU6?=
 =?us-ascii?Q?JTpO4gUzId4HpCTsdCO29wYVCS9FLKwecTfG5mC5fIHTWsxyXh01cqEqSewb?=
 =?us-ascii?Q?LxljnY1Nk1B1Zk+G66JoX0SvVXtSOs8YBRpQQ7wZnQeDIuL/qzE92/yY3jgV?=
 =?us-ascii?Q?2AinuB7NfNlmrGWVintwCu3gDhcwmJINQUaVN5MqAVo3TFL2Eqek/98iYmQZ?=
 =?us-ascii?Q?xAQ2O0FA1tqZO/etTsbuwsZvQGGo6QUK+9LzS4u9dcnb+gga3lhj7uYg3wjr?=
 =?us-ascii?Q?4j4PhhLECIYaTO4kS5GjolFDnfif7WO/8fvm1KLvxO6uVoBWE7TX5WVHfe7y?=
 =?us-ascii?Q?KW9PaPSwbGGE/kH5DC3JVcl0SuzDf6rl9knLYyjydwB3M7OXVTqCTiAfYT2P?=
 =?us-ascii?Q?rpgJySy7YYgFnsCW5lgmSP4t8GMHpx6amMr4NnixBeCtDtx5DUXnkWxsf1+1?=
 =?us-ascii?Q?cDyzs/ReiecS9UYx7tNRO/smNShr+JFPmqj5++EFNuWUeX3RosGJV+h805Ce?=
 =?us-ascii?Q?bIoMv4FIFasnp6fJQOlI+EawaGQ6p7djV8sOqbE4B+klB96yjt8qilpfNRSV?=
 =?us-ascii?Q?4Lp1eTSWVPF5qqjh3bzJTEpiuD6PIK3+9KemJA1x9/9vTjBeWE7VNgaede8F?=
 =?us-ascii?Q?I8TY2df1HOQGAuK4x5hdhri+8MwukYgYLRiQ62rLqhFswKfXZKyRzQaZcGth?=
 =?us-ascii?Q?XlYM+4zfpMhs66ZHVJ+U+BTDg9t1uB/CVzOjfnK8xhRdQs4nBhkCvAsxsRvs?=
 =?us-ascii?Q?9QsLkLWBPYwyw2cf1MFXH5+mqTmNCQr3FtjRzYTRsOiY8Lf/mZRC23rBO7zL?=
 =?us-ascii?Q?f8PR3GaEBD+Q68mx3ir4OWLvUid+Y7hKag3gOnRQHBfjh1xi2TYGho2eOa+Q?=
 =?us-ascii?Q?CaXJ1QJpmwBF8WhLpmt/Kdoc4EuE5mciL2+ZpxUW+60zfnb6IVOrxNuZ0Xc9?=
 =?us-ascii?Q?O7RjtV4NUm6J3rapodyUWJebQjhBALcK3ku/RG2IcnWCOiLnRdlxvb9dLdNX?=
 =?us-ascii?Q?sauUadQTCO8afN6YSzZBrACMjHoNlNjc6dVBbm3wS93SkSSO5LtyVRV95db1?=
 =?us-ascii?Q?1TGepJcJCN6xMF7/cuNHo5kZboEZHcocHmK/kAq62iJmLw7A4g5diGu0ZR+C?=
 =?us-ascii?Q?AFq8/dXhQBrM45vSw/lwILY2lGQtAGfUeutzGflO0Z6TDN6d6cUCl8MFph1w?=
 =?us-ascii?Q?qPHRCG2P8hGdR5NJQcYHnlLORjZtL9k4LGwfKPgBfjKple6WuNz4vEEkszuM?=
 =?us-ascii?Q?PaHqDJGHL/jbfKjt4bY1uiuULeGB54+VAuE79pTMtP0OyWV7mF9ZohBLhlVq?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KSuxbTL5pG2AcH0aftIiw301v9mmnD/eYlGmHvmaiizT3XjCImLCEczuzkYYiM93qAeuqlNwrgB7E7S/3HWPJ+JGD2NLAiwoo6qcwwKV1wAFlzflC2b3QiGTq4roICBcwhyRqh+g/bkJBVFhu6WHpkShoNNX/U+IuyHCMyeb7XtKvVBqPASZ1KNYgwWTqNVHAUzkZe4f4Fs//fJCMqcl5+G1AEHFw+etzytK3zqfQQ6W/mpyk4oD9lEyFa1uSJdq+1LmiphwGo54FCKeWL+hA9ZPz7jD7NbtSg44+c2ztkOEgWenwak25MyRfFw6NNjdAAHoC0pcwqFGVcQjn5+qoMWykFVz0HfzTAmHtfzbiouPi2NUsztcJr+/BIvlbEg2R0F8XXwACT5gLeeZtl6rHwh/dBaStH6+cCq7+ULS2X87baDNbt6Kx7wbUPYi5NB16xt6+f4cvN+wEF1OvItrmD+1KIuDfHvZKyRiXq+qegkxQ/9JEEPefR9aUkGjrL9wm/U8z+fKF7hnNZjo38oNpgsbsNmMzbhR34BWWrM5ro/6AGNUjnFd9NbK23JExyFFoWFvyoraM2l8vuZuUH9Zta5knmr+pcrtuSfFr9wcOfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4b4bf4-b1da-4235-8bce-08dc7eae2523
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:59.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQbUrd4HuaP5uUfz2noagYkczhQHcHSvjEkmaj27457vsSUHsQu9jOOgCWywMBheUMRYvad6SXisJa1sxl6XzfvX00cqRXB0KOPQQRrMcMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: OKVxMMImb3nTxP1BJEIXQmRk5XHcL1-A
X-Proofpoint-ORIG-GUID: OKVxMMImb3nTxP1BJEIXQmRk5XHcL1-A

Use __tif_need_resched(RESCHED_NOW) instead of need_resched() to be
explicit that this path only reschedules if it is needed imminently.

Also, add a comment about why we need a need-resched check here at
all, given that the top level conditional has already checked the
preempt_count().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bcb23c866425..c684385921de 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -307,7 +307,16 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+
+		/*
+		 * Check if we need to preempt eagerly.
+		 *
+		 * Note: we need an explicit check here because some
+		 * architectures don't fold TIF_NEED_RESCHED in the
+		 * preempt_count. For archs that do, this is already covered
+		 * in the conditional above.
+		 */
+		if (__tif_need_resched(RESCHED_NOW))
 			preempt_schedule_irq();
 	}
 }
-- 
2.31.1


