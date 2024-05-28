Return-Path: <linux-kernel+bounces-191574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D288D1106
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8171F21D03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4AF13C692;
	Tue, 28 May 2024 00:37:14 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406A13AD0D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856633; cv=fail; b=rPh9g5PhN+QpqCuhFQnvrDoxE86sQG3FkusHwAUtMdk90BXETkzqpOAHEIYUsMJBI8SOXtmPZhWRLSoD9SUb/isLsqWyrDX4SjeMX9mw/R/f/BGDYjVfKz3SVNwpSWJGe3g/iTKC6srCptgtQ1j7LKh8srfGmkBiyPi0YB/QVBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856633; c=relaxed/simple;
	bh=4f7Wrdvlqn1/8INX0XUMAND8jLsaOBACNIxviTcmgxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0EU7hZ1NxtVi2t1K4owxKfNgyCTj3XyEyO6ysQ07KDinhk2OY/abG4156bxtDZHogJ+Wvg6LB3lhc/D7/VbEhj6Qi92Drokck/XicJtOqSvMWm6fH7+//KZY1yKsjnjrU3pX1tEhM3l3U5UO5RKPBBYdazDQuOS6gv0/fDu5LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDIL7c009387;
	Tue, 28 May 2024 00:36:53 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Djmqja/RRDo3IDDXmUsLEFdPt0nJfRM38Y5LiAvc/Is8=3D;_b?=
 =?UTF-8?Q?=3DOKUszXKKuG3w9gqmHV0TcfVCa20PNJic8LIoSEx6mWulkEWwwck5YsvvHqa4?=
 =?UTF-8?Q?KFx0EXK4_zpq0gbRyYAKt+CpVRZjYkNulmLVyjD9Ofrp5zvoWmd7o2vHbYLz648?=
 =?UTF-8?Q?B+5z3UuhgLEZyf_CFtZGpMRETpgU3GQQ467ueIzZjXdzuXjI+0eiSM+EBVBqjgE?=
 =?UTF-8?Q?YQpGX0EqHuUDpdafdiP6_DTmGq83zVRNpz0Uqxcueky1Mi6F45qNFBcC/MXyzcJ?=
 =?UTF-8?Q?9+O4FLPOtp56jTQS+hq0gzdQi0_qu8jBAwUI/zyq5QPIZfyFZBRh5iOTWX9nJwk?=
 =?UTF-8?Q?ggxuxvIGhX7WYJL0c96++qe/9UqButQA_vA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g439km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RME2PC016172;
	Tue, 28 May 2024 00:36:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtgb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcWjoj7Nv/R4Nqym1/OBzGdpCFudBGIehEhG1V/6VcYut3xG8eiLBqX1vvbN+IBvVqY8xAmJn41d9Dd/7BJjkGmEH0gGXO0v1ptYjRo1s8BeP4HqsGvfg3koA/QXMP+87xRp9mHwLWiI90BwS8U0EbWLvZ6qzgW43PlA6ZIJTJW+o4C1j0BP/9iJEYFSajpN0tq0ZM7WE8t1avyzDbz2BImjHww1WHyMyqRR5tF1b5y0gI5e+1H2C7G9RjyRCmgwKACdIVemHZSIiuhWfEDh+CKDirn0cU544Hs+MhXgTDDrjEwVBheGaRkFmOl4kjPYBtZzzI3Gj+WflDZmnXm1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmqja/RRDo3IDDXmUsLEFdPt0nJfRM38Y5LiAvc/Is8=;
 b=ajsOxU43FK7VROeQpfpIyIQ4PnKNdhYPOTNZ9CDvWvpCpZVnYmHRn6n+4jTfYxUMQ8UCs5XFfNcnL0EtdplHA1pRGBfT0FloIy7Y+2nDXvrHs99NmHLJRRQ9LNrNxEzvVnGcf5GGfinyzWJWiGIsd8oHigp64omdyI0gVzX0QlCf/LbYqvpxnAeJNVekykfZaVGCND1LXumYS0RCF/Mkq45VTQBxdLwM/Mk7lEwup0SA0fhKODz+ZWoIG6Qp93J2/C5a1xOnFlUnu/2LmzH1hQUznOVcQ2MZsAPqD2s3XdeDwj2pQL9pGgDpGJPTeWAqrduvwPbp8cgOJI+ZeTsymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmqja/RRDo3IDDXmUsLEFdPt0nJfRM38Y5LiAvc/Is8=;
 b=Wofc0gZtFG+aXdMa19CmPszk0WRy3+E3HMquFr9vNZOsnmTvUerDV+zUoKpKIX3xrTGPXuiBTc5ggfpbI1Qd1U04OVfFh7x5HPh7t4XjetVXAE35dMIg/QYXiPjWlE1gsORwerTJ3sqAUAD77/pAB5KxRYI+JRu7Sk9SUClAqtQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:49 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 28/35] sched: support preempt=full under PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:14 -0700
Message-Id: <20240528003521.979836-29-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5ab480-b927-43c9-7954-08dc7eae4316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1jLC72R238iKdubFE/r9O+96ScAL1gC83WFU7/Q86dicVw74RT/HfZZ/opJq?=
 =?us-ascii?Q?x/HOKPOKctYAbBcgAmS88xoyaJ8wZlzt/PmbCIT6nuzaQixFwJOCA9YBVV/z?=
 =?us-ascii?Q?G2a8XkPAl3+5/NKnIMV1thiyEMoEjEUk67qFghCg1GA7bykey3c8flvOXq6S?=
 =?us-ascii?Q?ne5dNJjKc+ztqxbVPivWGQrt2mDeFyVGJf7h47X7JxRM2twraFAhRL/LxZWh?=
 =?us-ascii?Q?L1OZzagEegbO2aErQYSCN7LuGNsXH3YNJ9TvQT36LdaIaVrHzILLv4bRNOPJ?=
 =?us-ascii?Q?tMELIYQ+LadA/D6iBKbvdNSDGqIx5Qf551ThDQJMLW15iPV4JiUkQPLvR/ZB?=
 =?us-ascii?Q?zrB+eaq2AHD9RO1gvGlvYuc7rhUqarVv+HQFkK8JR+Q2WUwYGfRYnidT2vsZ?=
 =?us-ascii?Q?qe2/3riBe56AyTPiCY4jE9W8fE4+H0WS1S+aMUh7f42pVN0jl1SIceqhoSrL?=
 =?us-ascii?Q?WuojogVJoWcIH2DwwFYCbbTnu+EEvAM9KM+z+03PgzPl9YPYx7K5YkK0HS5W?=
 =?us-ascii?Q?Bzs705SnoqGJJc8Jk6eJU+nVLu4xCtul9tnJz1nt7K48hJxPqLNGlSeAvbvd?=
 =?us-ascii?Q?qI8GISfV2KIwWxouTW/bHKxH4uaN+3UNA7ZAgmST3aQ1eaExs2NG/in2+nLp?=
 =?us-ascii?Q?TSP8Fp8ASxPfZAiekTxr3i9B+Pogn97yJKroP08m1/AzuDE9oUlnBC76PHw1?=
 =?us-ascii?Q?+bBfWpnwgLygmPD2NHxzFvi9q2zN9yhCKb0bOazS5Lioadxr2F1rHrXkG5rz?=
 =?us-ascii?Q?JjQ6wnBGb5nTpDsyCTo5l5b7fZ87bLEMvpYuEYtdfsPpibUTmAcz1Qu7D51p?=
 =?us-ascii?Q?BK9S9bbdVz2//MgEMmltKzaq2sNvMo9D5fJBpiPzHfWkQeB1GP40xyuDMGA3?=
 =?us-ascii?Q?L+v2bymgZ6FhITQVmd3nWiBOiHfZmgB3ZUhqCSEw95Cuy2DhL1bD+AhTGzBv?=
 =?us-ascii?Q?aK4f9yUGJkJbdP6LZDnMnizBKgyzXQsQ6JlruNU7cnYBrJjbglXxxiaueFRb?=
 =?us-ascii?Q?ntYupFMaSCJBvoYG4SbJ12Bfuk/+TKBaeWnyUkvGNKUVGCh2zSEoLJzOWqF8?=
 =?us-ascii?Q?sAlbwENjopOqQ1+iZ0/vjPhYzhuGFcM+vw8aXUcCvh8I1Q/yzhEGbqZIcgSZ?=
 =?us-ascii?Q?jOOWuXaUCeW7U5nCF3omNguyAfcT3xmKE/nxaKBSCldaMhCKlH4lHcwpcoRK?=
 =?us-ascii?Q?vw2GHMq9VQc+ccySmT3A9Fyg9luXHXdtkPiCow=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GCnq7nuBMeYI/hsb3ErhsnQDXUZVOVq+7BwN18ClwXqO7UVrNl6W+xuUrZCT?=
 =?us-ascii?Q?PPTp92Axabv2IR5ISGA3A6QH8DK/FiDnqrOBHWtZTAk40yQNYhTJHzXUmFvH?=
 =?us-ascii?Q?bH6SRhc7L/4qfFXtQG1enYrKvXhbExVmF4LRAyTtUbzhRA5MQp1smS8y9dND?=
 =?us-ascii?Q?AydxrrJQvYMDfEvvD+MvpGs3po7uR6BTkIvzvkzhPHc1fewHYO4BnDaIPrky?=
 =?us-ascii?Q?4ogt7EUmOJJh98sfHrfPiEX5yreCmcvE0FCjbbtClnFJehU11BaXQI3wMFkK?=
 =?us-ascii?Q?Mx0HWMtLMibdn50Q0K0NguzoaDLypHcG8QjQG67W2u7bZQaP9iSg6lwtsS6H?=
 =?us-ascii?Q?XEzLZjJKyQZUT74sepQMPBn5Wgn6uSYpp0+AKx0D4uYqAjZYWH8A/b+XR94k?=
 =?us-ascii?Q?Go6x17YNzetnoIL75peamU5bIHZtxXoS03ohY/nTkSyfwvw+dUMtVia0xMlX?=
 =?us-ascii?Q?iJK0hNhJ/SoNRa2PsOLB76Nq9R7G6x3xoOwMaRUkIK3V/l5dorBe9aetBzgt?=
 =?us-ascii?Q?Noo9oqx9xnhLTem9mHjCOZEBUYvh2uHs8zzdnnMeYqJS4Z+INaymCZs9IZfY?=
 =?us-ascii?Q?AtKBEfwFdcf0BtwLHpoha4xiO1k+5SMKAtEq6Zg+9gtf0WM5YUOXizCcCTdo?=
 =?us-ascii?Q?GBkSA2KiboorwJNNelstbJ7MQifvdPuy+80o4FpVgTfnjgcSlu6a7FcwT4Wd?=
 =?us-ascii?Q?bePHeBRcCpZBV5w45kpXqcnGBS0OoSKeUHT35nAZtRm+zU6MfEMcOJK1ZeCG?=
 =?us-ascii?Q?qfoewcmEm6y8kIvewNIzTrAwjvZsITLUoueK3vHXhcZ0SWAVzsdoIg24E9AL?=
 =?us-ascii?Q?ElhweGqKZ3u2GVAuAUNAImI2Ie8ud0FlbAhCrdo5ob2ZxIFEJgeec4Pe4gfX?=
 =?us-ascii?Q?J9P8WmdQDQ/TJ1bb3RZ4nrkQ9W8g7FYlMJ9fp7hcRAQBC5R9iTf7K2C/A2x2?=
 =?us-ascii?Q?+qV4q++NTeCtE3LZSXoIvvvdFIDhjk67mtBbQXVcqkYRz76o9+F2cFqWd7F4?=
 =?us-ascii?Q?MKwJkAZptTXdineP4iOlridwgx4uHOmvDpWA48hbaHHkA39MjujHivAnt3VH?=
 =?us-ascii?Q?eMEbGd8aQBVZm39tJTGknJcSV40N4xDugM8f/9pc8nHZ1eva2TsiENMzUwNc?=
 =?us-ascii?Q?P8fId8FNhVnRJLbqCWPeZ2PGska03fbwzdiAos9cOn1kyl0pi7NtvhaVVKiw?=
 =?us-ascii?Q?skYLN3P9iML2xfpKDt7EaQtbFSGJrM5HAsXncOcLaUHVd6LAmRNc7Bbfxl45?=
 =?us-ascii?Q?A0D38yGr2jFcEEY9lDTtZnpCytrs3klNZBtH/fdaGVx2TRNu5RZ0w7B2uICT?=
 =?us-ascii?Q?ul+QWAS34gaGyKWE9bkANhs8sdUQohjoTPWxcEYIyfM9lFPbsWfIUugHwGXV?=
 =?us-ascii?Q?wIsIm//v9URprgLzzD1rA5t0GKUmk2B5jGPUMwl73rOw87E/uEoAmwU/nS7V?=
 =?us-ascii?Q?P8289jTk74bdMpy6za9KQrmlGAA08j0kR8iGOHcZi0hSNVkVNWCtbZlpNcO6?=
 =?us-ascii?Q?XVKT2jr8eRD8DA3qbz96jo/APZmWBY7qnqwmPCoxJ7B0PGdl7FxzQYVCvjbQ?=
 =?us-ascii?Q?AmU/GPaP825+mEDJmytSqdCXQAh9g2I27pVdSvuiHbyH/UO2MZKm0P69ic2y?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tPXEgSnYI3unCg5HBtURu94BvAnkPpx8YFraO4QpzNVonBJGUtW6KIMll4pzGyb7T3xMrebz7QO+x9ioMyIUdqAT/2de1tL6x/6C8GSoIIGbiMx068kHnTGnITRxRMSPCx2sE6Lbo3tJ2BleY+QihN2SKh71BNujQwkKYmWcvhApmVsWokibi+qAiWCh92IfiKHJJCH+QJhX2LFwjZyCjYYOLnzxGix0bFBlTPGQW2bBMlybceCUg9HmkYQqdQhdcijsCkzuIFHACnZ3FlpX1JKIgw3nhVQPyAqdbtD2waWv921hI6r8on5zHh8GbCR2Dit8iJ00eUs0FgHA/LmfeSd3CbvAroiH4ZcIWTz8Zp/kzJ23hH/ZNhH9fK6AeAOieKQYddgz/fiMl/2t2GXFVTadU3H3re8eUxV/BDQdyPcqKWsT0VH4rTcQVoGgSETdxW4lD+74sJ1LmPE8s6YHHJl6LcLgIh8cZ+qdYsXIiPTEopREOxaapOMZ9zwPiyKyxJr367tu7GT1SoKxrYtCcJGuZ7wb+Bq/3hEgQBeWL42UpJWASu9L/yuqJXxjoNhg1JL4NVbgn2vAJpvax7liDASMKUmjT/oJMaff+w3neQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5ab480-b927-43c9-7954-08dc7eae4316
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:49.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOBNyPjaSX5giM4b5o7R3sH+CN1a26LDmrSWTb9iBLn+xhiyekJEVkTBbFqTyF94p8wRX0rsAS4eVhtr66W1QwaW6xcmi1IlWUiy7oXMf/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: 0KFxodpnm3qf9ctrAqYtYsuRUXVX_EcN
X-Proofpoint-ORIG-GUID: 0KFxodpnm3qf9ctrAqYtYsuRUXVX_EcN

The default preemption policy for preempt-full under PREEMPT_AUTO is
to minimize latency, and thus to always schedule eagerly. This is
identical to CONFIG_PREEMPT, and so should result in similar
performance.

Comparing scheduling/IPC workload:

 # perf stat -a -e cs --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000

 PREEMPT_AUTO, preempt=full

         3,080,508            context-switches      ( +-  0.64% )
	   3.65171 +- 0.00654 seconds time elapsed  ( +-  0.18% )

 PREEMPT_DYNAMIC, preempt=full

	 3,087,527            context-switches      ( +-  0.33% )
	   3.60163 +- 0.00633 seconds time elapsed  ( +-  0.18% )

Looking at the breakup between voluntary and involuntary
context-switches, we see almost identical behaviour as well.

 PREEMPT_AUTO, preempt=full

           2087910.00 +- 34720.95 voluntary context-switches   ( +- 1.660% )
            784437.60 +- 19827.79 involuntary context-switches ( +- 2.520% )

 PREEMPT_DYNAMIC, preempt=full

           2102879.60 +- 22767.11 voluntary context-switches   ( +- 1.080% )
            801189.90 +- 21324.18 involuntary context-switches ( +- 2.660% )

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3ba33c77053..c25cccc09b65 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1035,9 +1035,10 @@ void wake_up_q(struct wake_q_head *head)
  * For preemption models other than PREEMPT_AUTO: always schedule
  * eagerly.
  *
- * For PREEMPT_AUTO: schedule idle threads eagerly, allow everything else
- * to finish its time quanta, and mark for rescheduling at the next exit
- * to user.
+ * For PREEMPT_AUTO: schedule idle threads eagerly, and under full
+ * preemption, all tasks eagerly. Otherwise, allow everything else
+ * to finish its time quanta, and mark for rescheduling at the next
+ * exit to user.
  */
 static resched_t resched_opt_translate(struct task_struct *curr,
 				       enum resched_opt opt)
@@ -1048,6 +1049,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (opt == RESCHED_FORCE)
 		return RESCHED_NOW;
 
+	if (preempt_model_preemptible())
+		return RESCHED_NOW;
+
 	if (is_idle_task(curr))
 		return RESCHED_NOW;
 
@@ -8997,7 +9001,9 @@ static void __sched_dynamic_update(int mode)
 			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
 				PREEMPT_MODE);
 
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: full\n", PREEMPT_MODE);
+		preempt_dynamic_mode = mode;
 		break;
 	}
 }
-- 
2.31.1


