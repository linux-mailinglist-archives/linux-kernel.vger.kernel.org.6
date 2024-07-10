Return-Path: <linux-kernel+bounces-248158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5F92D906
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8AF281A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006519885B;
	Wed, 10 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AisKz+wq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vvf6Djwf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C4197A99
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639428; cv=fail; b=hXkf0jTy5OdUd9DFzBmFBySmx0Au1feTqmxS03hdzCkhWbai8Gilrwv2hDrT/5heAz8c9V9ayeK0H3nT0K2fk0jNbP7WSTJRSvikPWlMyLJwbF6rTKoF7/PptQ3efevEpC0P1SGDjdG2QiahxNFNPH7BlnyGrQjhNTAxOI6Ez/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639428; c=relaxed/simple;
	bh=ZPESTzeh8XvfaDK583IP69YPpytuZWpRLgai7JM9aKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArmiC87AToIGP3XKHkdIVsA6+Y2sX/ugIuR5WWV2SQN6NkEo2OnKx8fHC92e4jcetSceXv7kqqZzOjRj90/HdWuR1TP0F0DXK3IcN+xSVFfbz9TMJ3isF2v0Y5TSm7s+5xGjVvhhOAFRUflkuM40Ry+7hnXxkPw/P1KkQZOH6Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AisKz+wq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vvf6Djwf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFg0oQ013740;
	Wed, 10 Jul 2024 19:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=; b=
	AisKz+wq9Ng64Y2javiEQDQz2wpmTS6WjtK/hTSmmKe1OsM1xvm3BkqnxtwdvzBy
	glMDJR4bZ/LC3PqAaHk0fCHHKEgJkFBgfbrLWPfKLnsf14xk4wLHlJU1MeAcwH3H
	B+/u/iYfSy33tRF1HfKpVO7BypMoD8OiI5tC1xF1ZQTrdlwX+bwdST0VOwZmKZuM
	XlpJu/QV0np1ND0QYyUilQQMeV/Io0JOAO0gyE2z9hC34iInt1DEwrRQHsiZngPh
	D+bREp9C1JWTuae9UvQdUsBCeF03+rlYT5gO8Kxjxye8V26rFN103RqDmCqKAeyE
	2NSfXLzLgFDyGvurEDEXrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8fy0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIihM8033699;
	Wed, 10 Jul 2024 19:23:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1948k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUqw7ahr7P9MgzcaXRpmPVSR9GTHTbR/mST/88ziAko1T8BqYqB+yrzM/nnnhfBb21C5R5vpfj7eOsIa4IpruIdaDOVyIVotqXmnYE4cWBjrFlKW87wuteUHuxeH/9zpAyKNwyrzS9wTUFitLCTcz77KJCln39z63+FgoWnAwYj/a0dK89gIyDPIXk1A/9rM+9pdbbE9SElC4WDY+2KgmNx+LGF/1aV+6upAsqthdap4eM0nETBplfQ7wX7dW8DhUc4dXAl2L/f+/MNkr48mQqIqUeYYyXMPSsZVfSmI6Lscz2XGMfXM4EpcBca+LolRtjZH+ZLTE9gT3wKPgXBDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=K/muuysjbYIYkVDFiqb44OWFVVN9dAlShBHoOZtsl8QnmUQeYqdB+H5sJxG7RLdJft6dgOaKZZbRQPB6sepjchh4G6lUIBcyatcVGJqyfaoHp0a8Y4z+FsNUYA26zXY2fAQJi/nXQa/IPTkrTxy5VKTgt4IJGbmXg1iK3N2OJAQfx66wTw5yHXKAZePYHNF+zCYKocsk3Fbfh7NOQkoEyLke/GOfBJtf8Z7b4s7D7ysW8PrIVG65mdaKoC0FjB91cspgE7lgfL9mTEErQarAtVE5FIhwJOHPd9IDcu22+FTDV0j0ZodpH+Jk3XN8HW/IxlJ+8APnhM/dt5yUl4AKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=Vvf6DjwfAliZDYc9m7aL1ZLHKlFGeQwwXXTIHtd+GJ/a0sPtm4FI3wNAinN4+wY5hARulj9q4cx0ek+nyqD63C9YwuDa8ZZ7q5ip/L19szMtQ9zonhjb+pp3aLk7YhfptLlQtdweqGQKck+8eBg19L7qqXgY4U8ZxJbWITt7G94=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:00 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 01/21] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Wed, 10 Jul 2024 15:22:30 -0400
Message-ID: <20240710192250.4114783-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d66c9d6-3a79-4840-780c-08dca115b66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NyG7XVwGg4K0zz3f0sgcJjBA3QvA6haV/QmejHWgex0sXiHrGcYhy7K4XyOB?=
 =?us-ascii?Q?xqfQ9SnTyZVsuCs0r5ODuZ4hneQsCNNIOIzSOLEJHW9lt5fLEbGWD/I9nQy4?=
 =?us-ascii?Q?E+Bg90x5fW//QnrHVE7ASzMzKSNJghO756ora64HtTGsxLotkFyYy1EjhX2X?=
 =?us-ascii?Q?f7ylyaaaGKdb/mZSoDFpLkHe4D0neWTYvIZvE5j86KPgqekMun6rBKyYkwcC?=
 =?us-ascii?Q?N9tmkBzRBqKpGBby6VZ0tyG4zqwfeMlOvkOy7te/o5GbobtGhfg9fW8scJ8q?=
 =?us-ascii?Q?FsvMdBjGY/mlsVX+3RGVpMFioDO7scT/jXxK3VHNvoSEWQmEDVCrbx4s5Dbk?=
 =?us-ascii?Q?ufCkf0AY23mSvoigIsDpYTtjw1hqAzHN8mO/awgYtdyT4BEvYqmNOgGUG6DJ?=
 =?us-ascii?Q?+0fEdGe7UJp9qRbEGEK1DHc38UbQEqzJu9xEYGOf0iGbjQDULVEQTDoACXfD?=
 =?us-ascii?Q?HqTjth1/sJL9/bj8+3wVsZB3Yivi9A3PeMCR0tnSaVn5/RWbpvV+L7DaU1Yt?=
 =?us-ascii?Q?u3stB6JiuI5VHDL+ZdWDad8+Fx3ta9GXT6MMlVbaBAZvR/58jAoMaDBnNJik?=
 =?us-ascii?Q?yd5TLzT/ty+1vVtHobx3OwjDwktG0DJnjLnaU4Db+9HDodi/Wqc0rxBvXDs6?=
 =?us-ascii?Q?0ZDrJKn9ON04s5iz4pQvC2jeqZBjtMlJ8bJyRzKmElxsoVXsxJYg4knPRy1W?=
 =?us-ascii?Q?0WwCO4a9xo5iFLg/BotaL/YwOgvSI55cwfLd01QfNLugBUEVfQOJkd7sNO/+?=
 =?us-ascii?Q?+RWYKv0o8pzkkeOCUXw9cFd65rIrfk423LWQdXsCDST/0IZdvkviuCKjrCEK?=
 =?us-ascii?Q?2jqQbY0/YRLRYJKMuBjvVPipEsmY/lGf9YVYBtSPrL311x3eSg2rUVzZOnH+?=
 =?us-ascii?Q?0shMPjZeABHDaYCIXATcqRzOXvvF96Z6IZ4YIEZ578z8pHEtb2gv+3mb513r?=
 =?us-ascii?Q?bVyceYkRlH+esMXicZiujGKgd8p3Rn90IeVi9EKsyQtl6CyZaTvHcZEDF9qn?=
 =?us-ascii?Q?Mx5DVh+aAVnnuI/+qCMHPwD3rgEC46ns0GHYLu0pc2Xn23LZHuCZ4hBcTHQA?=
 =?us-ascii?Q?I2Kq43qnhG0x8s2LYmFq1qHALSuaAe+ZNnGJJGZtq0z77csU3R0WVSBrqfri?=
 =?us-ascii?Q?yt7akYexRzhGQeEsVQcCT3wUQeEXh5o7MI7ScqJwu89tpR/nu4YvgtTM67M+?=
 =?us-ascii?Q?Jnr/sKIo3MtT5EQquSHa7yM6zjNTa7uT4MR83kiHXfvi3LcnBV9m+jcE2sks?=
 =?us-ascii?Q?K5aoze4mbvOeG5Psmju+mJSA3/HylkqMWmZjx0RuPYnOuf1hdO55urJyaBfa?=
 =?us-ascii?Q?jMQQiFkiZ4dlBwwyZmx5lxEErb5xvs6gpoBsArbDuzfktQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JTTfaMiqjVhFXO4sSfpxG3o66WsH3Q313zyBqcfzu3e4B+2FqaWmqtm4Z7Ns?=
 =?us-ascii?Q?6UHMevMNJVlCxt24N8aE7M6KTCdatRYYtuFRGUWd17ZeI3E1ZR/ORWC+kcHh?=
 =?us-ascii?Q?lhwZYKQjrbjD2t1FLCxpR6mL1qVSfCd4dN1ilSXtWQtyZCOF4TMLT8KRhs2M?=
 =?us-ascii?Q?eLokVXRYbooU5VSd9Y9cvZZ2T+FNVX5KvV0S6V/sAmt2mvavhv9GB6V6KBIK?=
 =?us-ascii?Q?brWRoD+SYiuSdbqkhkqb31MDJ/O5fqAXDgR1dM+l14aid+5EGDfexTGtxVI9?=
 =?us-ascii?Q?jtxRfjIFVeozJwbAQzSqCSX+BtCAAlWb5YhAmHlEn5kUVopt1kZ0Eb1OTBqb?=
 =?us-ascii?Q?Gv0+kOzvb2FY3WVqsBzR37kULL05Y994MIECV4Yyv3Kc9K2riSYq3nlMMOKy?=
 =?us-ascii?Q?W58F9SbZ5QGYPbKKoJ74E/Xdz2wLLVuskURTcX4ULDkBQY4hsNa/+d6hTzts?=
 =?us-ascii?Q?HuOeJ6BkkH9J6zCHPJidnsIm9i/z0zoycfRAA5HPO1dmTZO1QSpSffOjTaNY?=
 =?us-ascii?Q?d9hSfIVJ+6oS4P76Uh0hCf9Z07xTjUZ35oy2F0qMekYCNfHeq53zp0OFEMIj?=
 =?us-ascii?Q?ZeM3ZSUBmYvywKpPMJkBOJa1SoH7pGUNROQeebb2mYQQ8fa+S+6PJXibCtbm?=
 =?us-ascii?Q?La9wDp8EVev0j/cJ0FtwvV3cHlqjIoSc6Wdjz8QYQHzGHx2f64zGQREmdWkg?=
 =?us-ascii?Q?uKzC8YB9x1f8eNJeHI9tfT5tZeXtyKAStvVXMBYkC8x7dPtoM5QXhYRtCr1x?=
 =?us-ascii?Q?M0op6oINKizR5b9/JUMK/g+OeSSM6DvACmYRCrAHjX0TT8CTtXWbkf1xG5he?=
 =?us-ascii?Q?xW4hXNdzIThM1U89bmyu1CieZwtzSH8R7iEHsYUaqD9sEtaPYF/zYz8S0mYL?=
 =?us-ascii?Q?qIeVjOLp/46v+B2wWlTuusvTZJ5z4xa2WI0s93RmDRQwWbx6+1xnYl07ikcy?=
 =?us-ascii?Q?+gOCMNM4wiNFOFWlFPPeuNmC13sSEgjqiVPQjnD0ldMEzrL4IlGqx4mYZ0l+?=
 =?us-ascii?Q?cmf5unLunQR6Kuhx5VEOlaosWB+rkpzCxQxhNmFEn5FSS2mdh29+9lR5gXX8?=
 =?us-ascii?Q?tLjDpNDXV95cdgbMxXJ0DNDMNxhzL/obguQK67DcovwDlYy1MFjJFtmiLulm?=
 =?us-ascii?Q?zqu543XoBWXihA6IrC9LlTaRqyB2iIGDJcAtFqYQ7TH+d/xpsYye4kJuVxgR?=
 =?us-ascii?Q?wlPkM46SbPswICvjLit1gcckIBaX2bEjEjWt8NScHh7+rgm3/FusHtGak1ox?=
 =?us-ascii?Q?/l3V1Mt1+WzcdhTt5r+MOu5Y4WHA7syA7sakKqJOerkG25A7p0Yi19+tD3ht?=
 =?us-ascii?Q?xu3a+qsIR3tqQQPFzMzljye0LIA2FnVGlb7L9RYaEABw8ijKH/FMvq+pYqlC?=
 =?us-ascii?Q?Xrn5Gud1IcYbxxZP0NO0tBr4BKQzqJ9SerQcB8H7SJks2tpXOzANvP+P4J+0?=
 =?us-ascii?Q?GFejdBVZH+ASFKq30kQUEKF1xhQCEfpgr9rQpQWHcYnGAaT57/bG7Yj3gJg6?=
 =?us-ascii?Q?Sr0zSusVC2Mlffmxodu2JAKCM2h3EDtElPLx9hmWQkJTaitmSlGbRXlipft3?=
 =?us-ascii?Q?iscAc25MmvXYeee3IyTp9n/ab1z9Q1KWSv+eirWtPbR4EXBKcShZRBBtkDhf?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CUrOojd6DvH+oDAUHYka1kPdw8Djn8W1cW1c25uVolGB2DFgPcpBEWxbGbfLyrvAXqZF/z+bGm3YKTPH/bEaX69IJ++87vI5I33LRSQ4crB5zVga6agCCCvFMF4VBEI5hZIo9WdARF8h+WZ3BFOfkKw85fayDItNhcn/fY8stT9in0RhiZ1W4SwzgaJsAPavIdOB+ttK164mZHsHR0IArag0sfSKtkCy9xZwtbJ8zUAu5S2ovCDlJxk99BFvmF9L1Z5DMZljgDGnQiPb62gfYo1FYKAxaCsRc1Kn/uhJJx5mw0xUgufXvI909VqmdU83BswiB2mtmuYcjtkX3BBjxVH8vole7169koJp7Vkloi6yuLJrRQR6A5ZOm16lgj6osPJ0psd9nyRZRt+A3HX/i+wRnImkNCgZRJSM0kufaTCSpsCfYd/3V91rIUoVHsO8SQxr2lnq2lUSb23h/TuYT1GmGGI4jq6J1Lq7VTwGOhv+kbC3pJvdjW4O++C1IrbIqIOZSfyBW2P2GFBhcth/NRFxdS1XlAOug+w5uCmCypuLuppdJp8KUN02D0beFTwQZK1tA0ApTxMacNnbfFOUovTSp2ZAnPzKjf0l1D6nF14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d66c9d6-3a79-4840-780c-08dca115b66f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:00.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f544kQS7ZjVqtGYrprWRTIh7OXSz7pHBm67OgMS3cYRsQ4CdoWIO4RdFTgxIpXB0uXEYqHvMzf1Ka3ksSoiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: 98Av-8JnF7c0EWe__8ABiz7w6p8sP37-
X-Proofpoint-ORIG-GUID: 98Av-8JnF7c0EWe__8ABiz7w6p8sP37-

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..28a46d9ddde0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2414,7 +2414,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original vma.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -2483,6 +2483,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


