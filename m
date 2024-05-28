Return-Path: <linux-kernel+bounces-191552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D58D10F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E9328234E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20F1CFB6;
	Tue, 28 May 2024 00:36:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601F79F6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856575; cv=fail; b=mn/73EBWV0qf6cUB0L7b2PC0chLG1tuay8OlkEpOjjgSh5i3gZNfPexyYCCeo4YKFLHdLiAh/h6FNiDQ5qijzXMBT8LZGeFxcHsD+MqJDezC33C87ScgA62TsrGNxDWvAR9qQ0ESBE+32SjPr3Gz5Hw5TFV/KDdU8Nmv4YDWsOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856575; c=relaxed/simple;
	bh=9sT6hlOPeLqoYUCGS2ZHf/CceLjb4J+1LTvqsg3LV/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAHYWy0TBzRz+v3eM3YM9tVZrxGHbaxwU3w1v5f4UK8HN765lryafkVae5cUnS9UqR2FPyi0ftf5zPaLoqJQ48T/1DB238ZFDj++ysKxeeRBGZulSMnoVV/SJWBsygkyB/eATSe3wj4PNmm5jTTjc/zODYGeKXZijDx6XWMMxVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RMdRVT011554;
	Tue, 28 May 2024 00:35:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DvLLA5TnVKvAlh0eTpK/3/0e4DuFBLYs4luBwnS2T3po=3D;_b?=
 =?UTF-8?Q?=3Dfvf+/zchnCJOf6zqZdTCzpjO5mILXFtx/PzjC48t9EHxkDBiESrvxNRZNp1T?=
 =?UTF-8?Q?T5z2ody3_NwMCl7at+IKJt7MH7af772pYQ32qLggkYn8A89APbfrba3JMQvS8Wn?=
 =?UTF-8?Q?fKZZ89jmLvjKNd_usX9/sXdobNbzxUc8bsvyDJtvnI9+vbI0Yjj2EIhp8Hl3k2j?=
 =?UTF-8?Q?Q2uS51HRKvLTVOYbZZlS_mFQoz6gy7ZzRurUhCGTggl9RJbkKDb1FLslBXAPe8n?=
 =?UTF-8?Q?OEp/iMt3OIIt697Qv+YLBhL0/e_FhqsTwbzcDrxnvygIJvfSo0J9FZCsIXqAFe6?=
 =?UTF-8?Q?j7o3F981MjsevuNXCNOJd5PgN7BIxh/k_xw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7k5rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RME2Oj016172;
	Tue, 28 May 2024 00:35:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtf67-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvZ7r3NjLM7yAWnYam1NKRyIm3vIAUd3fy2lnZCPTQaxb7HQCbH+jhiOC5Zf0h349asa5AWfZIB4Lp/wOhIwd54pEbs8PKhSsmz3u/pdnwziM9gR4ycViEC2sk2a9q0y+7PxC1dvL2ra1ZL9Nn6DYlwNh+q9w7s+AbdaAzV13ymkylqd8xl5ZoksiMOMC/uzWl4QqOfc6vAzPDgIwJoyV/zNGIJxdRjIK132AC//RQ78ST3VZ+C7lL82mwI8UOQnKeXpkQ65jleM87iw0ERtSGCqT/eKkMAurxaZ2n4Z4TA6eFKaPvdjObNFZP6JSVEnc2wooD5cJsSj+1i6lrLIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLLA5TnVKvAlh0eTpK/3/0e4DuFBLYs4luBwnS2T3po=;
 b=l2yEv4hszuRLZvn8QzTdZX5y6YlOD7ScMsL3aT3VTUFenuQJ16R1jKIeNyLrey0EjOQ558+ZQSXbe9FTdfPE0yLnw4IvsdFVwAaAERIum++KI1hS99p8Da4DX4lz8x2WxO8bgVHjd2YS/37v6YJEo8fRO1OBPRv0+2IiVb12mVd/vGxY9nAjePeXxXKUO2jYqmNlRA8FS1qfRmTMMxsjIr+MPhcAIzFQ50R/dqwiz3jeRKKkDWp+T3AWTkepOyHDqKf3AVhMRzch/vfF5kgYFrCJ7+e4kTIywvlf4VAtQUqIwEQoEte5lt/n7Jo0x2UtJP50l4YR/O5vs6Z4OafxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLLA5TnVKvAlh0eTpK/3/0e4DuFBLYs4luBwnS2T3po=;
 b=wbhWayrCfRIsU6sNvF6B7FntO02MnxcyOuwZcLS53RbLA8W2vV+21YiRzfMWEsBfUr+huVggt5yZ4uhpLJn893ERH5L8CBlDnrqGgMolqp7Kg4PgmD3xa7EtgAz6fPRd+KYwLcDDZjTesLFZr9PVaoylta1Fh8Tn6pHIOKOKa/c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:27 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Sean Christopherson <seanjc@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Friedrich Weber <f.weber@proxmox.com>,
        Ankur Arora <ankur.a.arora@oracle.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 02/35] sched/core: Drop spinlocks on contention iff kernel is preemptible
Date: Mon, 27 May 2024 17:34:48 -0700
Message-Id: <20240528003521.979836-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abee5c5-d978-44a3-0f7e-08dc7eae11d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jPfxrluc8nQWQpzSBWHIQs+XyaaKVXpIuDLyhs4bjMDE+V9uewq8TZW6dh7l?=
 =?us-ascii?Q?M3/fSh3Z1NdeyjQkJRLc1Oznyu45A7EodkDjbj7AgvIWyA0jfr3sF4fWoV+D?=
 =?us-ascii?Q?SMs3OdtG4JIAauqmrLdQgzekASvWaefmaE/I/7i3hdRcjV7N4ti6nkYzKza1?=
 =?us-ascii?Q?RY5UNi0wBwbF74p/9zpv7tD6dHn5Ufg9tpzKZfpTsl7g9nlob7AyCL3qRcSd?=
 =?us-ascii?Q?2m/foiLcIpCnT2ZEiou5703YkaYh5vIv75Gb2K/q+p6LimFFIQ8vWFfC81NM?=
 =?us-ascii?Q?ZU9VXFDGNO+MNbg/TcqmdSc9K7n6+aUR2y2AhmlBqc/8PaR1uNiXB1mL8TWI?=
 =?us-ascii?Q?aiSUf6pN32QNuISW03qocEtRpZU6wmsIAS0Un3iP5Ja8nC898CyjrecmjWoo?=
 =?us-ascii?Q?+TTOX9nHwiZsE7WCz7TdKUC57yev6b5BeAE5Ks0ymyKzC257jApEVr8Obhod?=
 =?us-ascii?Q?HzFnM/hHhq/uSAp7FMQKLZ0zlDLilK5vdRUMPNWXzWK5spUKpP8J1e3SB70c?=
 =?us-ascii?Q?BNJ0cA+5bhy0CLpc4wjS1vX2CK//oKRXxMSZN3n5OqyI9Xj1Cx0wwdweAMfp?=
 =?us-ascii?Q?gPZ7kWhJQ2pNYDgmtloEvEOPi1LjFyOlu4jhviJg7705kA+4GBPQcyitrMkd?=
 =?us-ascii?Q?2BRPpjN46EG5Tu/QkDRqAzWz8cdfepnYekh6iAYxTco0EaQmTVypOujCVe46?=
 =?us-ascii?Q?iESKuf0gtyetEyziTYHOK6ixMOCehUwMbk8v4nlwOy/96qHqV4uAGwULisgA?=
 =?us-ascii?Q?21vqkKZnj8Paf8HBwiCpuJ8d8AyonJ9puC/glivRdiJQVIbtuzfIhLrB7DfJ?=
 =?us-ascii?Q?N9kXDLoByiRMNhzOy/M6lVhnsYAeGtJTsHApRc44SSdZrvUAqnpDwDwedZ0E?=
 =?us-ascii?Q?hiB3l2iA4sfbpBzy54QOlikqN277KzEee1f70iMHKqCWypqPc2caRpi3LbT2?=
 =?us-ascii?Q?F22B5yX6gUSQBSGOcyr3f7KeTZFbbmQJWxfXqdxuJzDFBMKfq55kvvBA7raQ?=
 =?us-ascii?Q?O4LMdtZRBSBU7lY9mK0JB81U5RGwK/b1W4bf9U8Udp0Qq57vWJc00/hm1pjX?=
 =?us-ascii?Q?LTj3bmBKkJVkB2+5rDiJjJfP6FMllZBSx4R5Khy9ARbCsr/pIU0Zj1YcMGd4?=
 =?us-ascii?Q?27FCP0KLRQGxc9FAJ79dZlrbJpee5ZYxfCqf61OwRi/7/yAP//eqB2DMqwEo?=
 =?us-ascii?Q?N0FipenD7/8qzJR2+A5Essy2Dj1tLM8QflDZIRi74LDpQYGeDwugH0JB7mo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5Ao4JeuVZSr1MxF15q1Ol3quj/oh4wOtYJwAaPDtGjduLifPfckPX6YYJcnA?=
 =?us-ascii?Q?ZqX9vNqeofZKFFCnvGqB0Ziost8HRPxnWHehlru3LvVlN0DK5yGTL3y7JJXX?=
 =?us-ascii?Q?ohHNfbhrj3l0E/aaiYgH7Xe5r0Oartg/+KnlS0tnjqkA4xw6aJY/l4+knrcY?=
 =?us-ascii?Q?a6fwi1Le0pl5KLBvzjPea5SX1LPnkxeEkcOLAVGW/wk90yC5EKey79x0sUhz?=
 =?us-ascii?Q?4HqCMJKl1c7jBZJb3c9pKNp4Ga6sNP2BvWI6wsT8IAG6Ag4YVoKn0x+SQzzo?=
 =?us-ascii?Q?K30KzBqzsO58y+lKOfn6eghbELZb38MOT5RLdoiXxwZ0MUBCSxO8vqDHjNIT?=
 =?us-ascii?Q?FMU7NLhR43bpyYKxj0ag0tpjjge1Im0m4A67ONFOyj+kgqMfsBNKs83z6T3a?=
 =?us-ascii?Q?Dr9QDYb7zTKBL8sy0aTFQ18UBKqXqsWHXMqfjJCjo0Ybwjt0m4zA+Q4xQBAs?=
 =?us-ascii?Q?rS0UKoNpCyPMlH8dpV4OzsCVBNvQJcp3NoQ8o1lWX8V/A02G5/UxCbEzqTSQ?=
 =?us-ascii?Q?7y0S9IlNOnJs5td9CsyNmaIWjDRfS6yJxYj72nUZxtP2e+0VFZj5d5Y+IVt9?=
 =?us-ascii?Q?j2nq0pr6+hjyzq8g5pxVuIwyVPqWd35cxV2xp0oBchFGa5kPElTqarZ+owoi?=
 =?us-ascii?Q?JAjGp72CWtgBCV9SDVPIM20T+HJ82jBC6eZI/llXnMBoqYwNgVFdMme1C5DP?=
 =?us-ascii?Q?qe2z6lNmMbE8/rssTf0ko7MRsZE/I2v2Qu7gUMAZV10CRUYfaj7Zk+dQ1yTs?=
 =?us-ascii?Q?C6zA0xPWMGepk/WPL5AXi7fAbE/L0D6o627fyyAxC8CsJKmJe7qgdB3ivhn5?=
 =?us-ascii?Q?kTxdABSujVDaed3J4mt2lJpRABBP9yiLdPDZu5t9eju1XCQiZgmoGL8GpbeJ?=
 =?us-ascii?Q?ovm9ZDYHJ84CjmhCsBMU32E+Y+6aC7J7eauVqOxCfUhW9JC/ZHf2uSy0yHsW?=
 =?us-ascii?Q?2fnZk+wCpnx169XJE9qTjXR8rCh8mo9fTJ4EApcYo6k6tjwpDCHMYPbqIVkg?=
 =?us-ascii?Q?QRrsxVUirW8Gc2TmZTatw4laqSdAI5ItODEBeV4xgm7Fa7MRJ40ELoYXudvV?=
 =?us-ascii?Q?PrydSms/IAuoZpeZfjaza5mhX5sYWg6VQbjaZ8Xo5tdc5WSJByMyTBvCDOqv?=
 =?us-ascii?Q?VuAl6F5gAGWHa2DbZYVyjy3PqjGO8ZbrL44fDoiyX87qZteMw1MuU8MTh+U8?=
 =?us-ascii?Q?Pw06urc9sC1+yfpbAVYkg2ECMJX55dPCg4+AHH9soJgt5vjKumW0cVLkA8R7?=
 =?us-ascii?Q?3yZ9A3YLSvFGKtMmVxT2m7baGGFM9sh/UDfITrrXVTE4SvEzF1eO0wvqP6qX?=
 =?us-ascii?Q?BPoU9pNkR4mS48mT+jBCN0bC66cvfBJYXCbP3CGMnxla+1l/sv3hO0h5Fvpb?=
 =?us-ascii?Q?oWHTsJbYpvhZu4N/sdTWmUUiZ1lz54knW4Feqe3YGamBN1wBmQgckykE9SIt?=
 =?us-ascii?Q?WtRWqgZiEbJ35AVKYiDRAYP8bAIxM0r55VJob1abnb0GCTMJE3qnT1eztCRS?=
 =?us-ascii?Q?AX1RXMm2SdvjeLrIOGQ/c/pHuYCanALOvaNabZ73FqUMmBGu8RcYjoPP7ImI?=
 =?us-ascii?Q?DwPcf7dIf28PheqJ/s06EXWiKo3bV6sHH8BXDFKmJg4g2ndkiXyBOHkN/dPG?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qo0ZvKPTdVIvbtmuZY893lnQPS5KCBBjykVY4TYIAX1rPje0wAybnEKrYToB/2E0PlL6E3sq9vdAvszlmXkmLX/n+vVGdbFpbNwkbWfNNpwJDPyzMCvvatErGM/jJAXQUK6LPAydzIPW3HnaGL49NYuShU4FFhDLcgb2U88R07F+tJI25LX2nVusrt4z5JwgP9R82W/KXvl4OvGhyZ3efx0D1Tri9/jh44JK6CUrZAbwrKJGQl9ncL3u/HXba2UOWpiWICVtxZsWvQtSAzQE9m9hUUpCHEa/zZLSfAk6oP1P7PCn7uJzUkE13HRknV6FAOgR1NLqqFZb0cq/Hp11NYpr2ohiqMO40xPmYhOMgdWT8oq0EggVHCf9K0UJ/OGtY01vS6qnQ8yrFrLwLFjGS2jn0gAVPhejKbulqqrnk9EGinHyByhrLpQ5R7YCZdMvEI70NUq9VbYqByxYwukjqbN6a7cXMuIh+Z2syaSwJ5GQEf4+nXZaaKb6mE8YyI51IF186IuaZOfzxV8+0+50opKNbfTS+p0jMLedgs6Va2SIU4ge0yULTPL8rD0ZBARRBur3NzKTren0kUCd4A+xotRHCObPp96ZwSWcwFQ+iCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abee5c5-d978-44a3-0f7e-08dc7eae11d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:27.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRohRK8BnUrPloW9+dQBv0KC0HDz/cX246B3omJ37Co7AxiB2ZsoF5uLCGbFJ/kYDDWRoN1hDvXtjWQqP3St/sdoRDWzol2zbX/DyB2Z9OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: 6rVpZOB8Yv1Q1Xth72GpDGMfuBcFBY7d
X-Proofpoint-GUID: 6rVpZOB8Yv1Q1Xth72GpDGMfuBcFBY7d

From: Sean Christopherson <seanjc@google.com>

Use preempt_model_preemptible() to detect a preemptible kernel when
deciding whether or not to reschedule in order to drop a contended
spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
preemption model is "none" or "voluntary".  In short, make kernels with
dynamically selected models behave the same as kernels with statically
selected models.

Somewhat counter-intuitively, NOT yielding a lock can provide better
latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
rwlock, is often contended between an invalidation event (takes mmu_lock
for write) and a vCPU servicing a guest page fault (takes mmu_lock for
read).  For _some_ setups, letting the invalidation task complete even
if there is mmu_lock contention provides lower latency for *all* tasks,
i.e. the invalidation completes sooner *and* the vCPU services the guest
page fault sooner.

But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
can vary depending on the host VMM, the guest workload, the number of
vCPUs, the number of pCPUs in the host, why there is lock contention, etc.

In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
opposite and removing contention yielding entirely) needs to come with a
big pile of data proving that changing the status quo is a net positive.

Opportunistically document this side effect of preempt=full, as yielding
contended spinlocks can have significant, user-visible impact.

Fixes: c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic preempt mode")
Link: https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Friedrich Weber <f.weber@proxmox.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 include/linux/spinlock.h                        | 14 ++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 396137ee018d..2d693300ab57 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4722,7 +4722,9 @@
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
-			       can be preempted anytime.
+			       can be preempted anytime.  Tasks will also yield
+			       contended spinlocks (if the critical section isn't
+			       explicitly preempt disabled beyond the lock itself).
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3fcd20de6ca8..63dd8cf3c3c2 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
@@ -479,11 +478,10 @@ static inline int spin_needbreak(spinlock_t *lock)
  */
 static inline int rwlock_needbreak(rwlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
-- 
2.31.1


