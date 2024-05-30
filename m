Return-Path: <linux-kernel+bounces-195133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4B8D4806
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8927F1F24C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BD183984;
	Thu, 30 May 2024 09:04:28 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2D183973
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059867; cv=fail; b=NUHctZsp6P3GplXJMRSEQsAn42P+Brc3ps/PyYM1bUFELR2AFQOxDmST8ZH3YOpMa3uCrVptRG29+PDXGEOF2nljprl1KAPcZFOaqULwVOYt/E1RXV33rm+m0580teY04t64EYnILIFlxtLtbd3MMggz95k0zaGZv8VUVv2No7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059867; c=relaxed/simple;
	bh=1e7j1PTA0RvINNTYC52QmBIIE7hPf3gb0MJP0Yl3dCU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=C4uoal1wYwqJHGX/XrbCI7Nr8Wv+4lSOiTT/hOdZVRpGD7GSQco/1xU1VsEDD5UXWsLr0wItPglN8Zwms5sSqOld433AqAmI9t6DBcXSYVt2eK7v5oyjhDMl9kHukgmJ9sTMZKJwggE0Rb0maq2wQPCORVv9rnHxFW+7XDXg+uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nVGl005709;
	Thu, 30 May 2024 09:03:32 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dc2tqEETObmjv?=
 =?UTF-8?Q?f4t+Z8WPvXpuaZ+rJfgj3cQNEILHyAE=3D;_b=3DcbbA5GTYQt+225pN2W0I4S/?=
 =?UTF-8?Q?4MHsv9EdNWQp6mdziwKvgQvpqzmFV6cbbNryTdP0MG3z8_087ixILWa9czaoeeC?=
 =?UTF-8?Q?qy3Dl2VVcqDTRYLd64LS73wRojOv3bb76bZceICZI+GszkbmTVf_qLKyMdDjwoB?=
 =?UTF-8?Q?QdchtiHfl5S7TYpihN4uRYHpkgnwiYk9ZwHviTNuCiEVTTca6HjEr2Ez/_4RNVY?=
 =?UTF-8?Q?7dF9TUknoMLiIO+JIpWXaHTV3Sqjv0nex0uWvXWV45B9iELo2+wDQB5ygvumBq0?=
 =?UTF-8?Q?_ueV+b8b5aXGTyhwctlpv2rkXXbznDGaps0dl5RRVXuK5LbqNwqixhhJ9OmOdwZ?=
 =?UTF-8?Q?DK1xGf_WQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g48hub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:03:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7AKWS010817;
	Thu, 30 May 2024 09:03:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc510b9sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD2r0nxnTDDJdISGPHAGIP5WPWuBHbezyPjui+8MfvRVQXQ5QUKD4VhrlT95Bnlx9wz3OS8u35EHDl86IYYpEBIVGk2I+V1x3FbOiRPOzoi5JART9oQIE/EkNaLj5JxKAwFhvXol4/p4m7V16WCkfN52Pr5OejukLaqSzLTjib8GL1hmW2VJ33A6cppLjMWnC/Sq/GZm0EFYf7LmbrsrPX1IvOdNuWyejeFKsbSriCjQCw+47W8Wdbrojh5WmWx676CVqhlePXsdIyHrn0f+a4nbgIEfJ4fRFvpKfKLzU0JTPl+ybDKbFdAH1HFoINQbA2iMtCzIzELhw1SLcQ4sAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2tqEETObmjvf4t+Z8WPvXpuaZ+rJfgj3cQNEILHyAE=;
 b=ZrBZnOYRiaWLngVJgg10JfN6vELdmSrFohOmnp4XHec+fP8LrYs49sxgUkY2pShKu9VBeRBFG6h/SzGxH5HRCJo53cQFNamg5lz8nh5b5I0zch6MS+ZXaBW8GxpSGFsmblxFYYlUd9ZxGsl18CEmOzcs/65HtdUzSnViMRZQpp+28Ti3tzT0S7RKLjAJsnJFRpj/VqkXz4aFj+f/u0vvseCunjTUNc+kowxeq2Rwdy6BWKdCnS+uP+DOW2uFAobWDQGDkvByv7CINsQ4ZijcfE+qHkaLrXa66IkMOemgn7id4et5IEpa6C3jLtxCJp6BeFN8EcARr7nSumr1oqDkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2tqEETObmjvf4t+Z8WPvXpuaZ+rJfgj3cQNEILHyAE=;
 b=GU9KTnZmEonEXJSERqCuBupIfXOuzYzq2SN6tDKCnhAJLY0u5oiYSZKf85XzMvDntZObLHa5ZGV/ALPwLafSnIuEDfyTr22WVTsKcNEqwV6udilgbWzg6ECpn/7/4nXVNM1zZdVxi6olwDf3lYAYkDMNI24Vbik6tZW3vevLmqU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:03:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:03:28 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-11-ankur.a.arora@oracle.com>
 <20240528161816.GF26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Andy Lutomirski
 <luto@kernel.org>
Subject: Re: [PATCH v2 10/35] entry: irqentry_exit only preempts for
 TIF_NEED_RESCHED
In-reply-to: <20240528161816.GF26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:03:20 -0700
Message-ID: <87mso77jtz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3317f06c-a7dd-422a-baae-08dc80875eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OV+C/3twTYkrAyyy8fFJrVUnc0DmYunGOHkM5y8tCqT79diALKOIC8v8heFe?=
 =?us-ascii?Q?YPHQ19qVjYu1lW9uHyDGXxKSC+7PrLmGVZ5l1pD83vf4h2W71Xj4mVGk/RS1?=
 =?us-ascii?Q?xgE0bIdVfSrE55t6GIQZ/HZX95hlQ5hMZ7OARf3OtBFZPwMdDMPFH9zv2WOO?=
 =?us-ascii?Q?GIRc0El5LAngha1ytjWMBbP9ScuDjTTsNhnxwbvKjl5392r61SU+F8JheJQ7?=
 =?us-ascii?Q?QpTtkBhbWRIrioDm9uhqPcjLQb/NN3VzeXTTTDR/B3Uz/5YkCL5yiHWDu7X/?=
 =?us-ascii?Q?qEZKk5ltNJf1Ne++4D3+Cy3Nq8c+sIP3H8DH4J2hgfdpCpyUns821lihVdy9?=
 =?us-ascii?Q?0fraeCrUZvrCR76r03cseHWpF/eAV9HjbNzAAj7+57UcYt+awW3AQZOm0JSX?=
 =?us-ascii?Q?WYPVajTlNKbsDH40qcG/5pNDC9RNHKAlEoU83Qb9HD/Ve2XITbll5vkOCgD6?=
 =?us-ascii?Q?c+slOOMWnBsjsf1W40RkM9qJ+AlNuXZjB+qY5SPewnO20SNz4L9M4p8f0SAM?=
 =?us-ascii?Q?VCXAOc2o+zprehJ4yU8blewDnrPZ+NJHvT/XISB3I1sQ1cf/mE7tRhiweJXX?=
 =?us-ascii?Q?A77eWR1rIqW9uMVFjv9FWRaGWzNLKP1s9ek838NlStqqFA9rVJdMPbzEDQPC?=
 =?us-ascii?Q?CJt0cBP3V3ly6F3X0cQj58uBYeF+Hfa/xdDmLcTz4YXtFoGkLIFZhUnN9hSX?=
 =?us-ascii?Q?ClndURz6Ms3ttk4RhshszsJs2idAihbu+PGYtVlj7P08Y+apRUnFA2PJcUpX?=
 =?us-ascii?Q?tEV7sHfsjWUSN1oCYVtH531kIy0slB+1xi7mf45W2Otw0ojlxLojNGHMF7Fw?=
 =?us-ascii?Q?8DMG4vtR5ED9Zz8kRTtaZbfcCBaav2jf/KG8zvnUAlpC+/dn12eB2duId2HL?=
 =?us-ascii?Q?295V3BEf3qY0Rq0opWj8WqjFQd+YQKTVGhFvgc0m355VMtqolMKJkOyrS8tO?=
 =?us-ascii?Q?nBBWKeX48j9wHIh33SiCfxeksrUsuHd+R66u4umIXyyzbp0Rh2AS0xQk7JYT?=
 =?us-ascii?Q?tPZF8UTOJ5o4tAFurwh3wgw441izdOF/ZIIbPATHBs6Ne++o1sxZXgo1pCr1?=
 =?us-ascii?Q?r2TPvU2O7WTA/t8qO8dMrekZ9Cnl5cFWUAQduGmy7+BsB6hmw29hTDU7mAfb?=
 =?us-ascii?Q?MOZUouibsQ2wecnhyXfbsNdJIegKyxf3efNWgqgonQvWG/ADXPWSW/56JWvq?=
 =?us-ascii?Q?q7h+iWgUBHi+V2Q16+EFE9mfaI/CCG5FTHDCvriZkXNHSn32FGC5sssJlyY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/1BhR3qKgF4HOUV4BCR2aqe5j4uDYbiBx60nCsIw4kx+lrZXg4Bo458wOWrs?=
 =?us-ascii?Q?WBodkb9w01KV8s6arq7ExODxrn/0+3cPUVTGEITB4c06UOdQHW36QDwfK+LX?=
 =?us-ascii?Q?cEqzeiiBW9122nirCe613TgiGVvZMDJ9tGdxvJdw9XDgbvj66nTTAe87Mixn?=
 =?us-ascii?Q?4AnCTQJbIusGdVRgfkupxbkA1KBuegNbcmeP/PaOCDj2IQz5IhDGkmFOO2J5?=
 =?us-ascii?Q?YxrcaCHBhnUoB0nKEB+zp5ASiZKhTZM5zVtOb3mcFzP+EO7I5foWaqLHLU1d?=
 =?us-ascii?Q?Ec4U47qP+oXgL9GTCuB/VH3uGiqruzjx6xgLKvdXhRacgBLQmFIJ0G83/d+F?=
 =?us-ascii?Q?PneFsUS603MIG15CEBRjVgThdxyKEuIEKzR6xvvuR7fjVZ6klZnxpVDXJcpa?=
 =?us-ascii?Q?J1U8/a7km+54zPNhpHRR/WVzZ/QVsgliHVLh2C/oOzSHm1n/yCgVa+miT7cJ?=
 =?us-ascii?Q?h4QpZXoUA9b4gngqH22sZwK5pJ0oURd35bGtFMwaw/pziCM1/DyrD8Itb/WL?=
 =?us-ascii?Q?Pxf0DwvqrJCVY2oksV4MQZ/nK7tVLD/1H/NoJzD9UOF73vRJ0mEv+7oDvLHm?=
 =?us-ascii?Q?atMk31bNpL47hX782l4NNXs0MdP074XyDb3HGeNyBS5qdcIcqUxtOUOSDY+v?=
 =?us-ascii?Q?W2VSZX57zC+DUCgzcyw51Y2NsNONXgYVxEcfRI3HkPhl8tJkjyddir9DN4XM?=
 =?us-ascii?Q?NCGIJoyIrV6r5g19a1WfdzwsH8olzsjGoBuAjaQMX30qZ+WQYflJA0Fnaxcz?=
 =?us-ascii?Q?evyU84NGBa7lv8BNEk2M8kqBOu1yf2mZku1htJixFTz2Y7BsnopjbMD5+BSW?=
 =?us-ascii?Q?KvAc1F+gt937tob8d41XuymGq9kxOqvEgIE1CdWPUnA2/TZF7M8OQEo17soI?=
 =?us-ascii?Q?NQu5MzmzFglZjsuzd8zfpRvprAh6Nwzt8cymWBm92HSdheGdSLhYdDlYLRsp?=
 =?us-ascii?Q?Ty05/LtyQ3bk+gEHmrFQWrKa3S8Yfu1/JeCzYUv8Qfh42khbN0524whmW73E?=
 =?us-ascii?Q?osyDZb2Il8LjEymdi0Qv2Xnri6AK/bLiVVE1tuNBcmB3dPK2qVDaEkB6q/48?=
 =?us-ascii?Q?VwN8i2OvhNdiZTSAWuTSeNv2/rAf3Z/7TqtcpLS7A6mpdLDtI00yvTU50KM3?=
 =?us-ascii?Q?woVFO+/K7jW0r3+uJ5MR0ttxMkcNZOzt21C6LlKPge303x7GgVSWubDoFAV9?=
 =?us-ascii?Q?ezx0ZdXhtTO/kSRpaIPfSUAN0gNUredKVNmEnapOFkG1Eo8HtdQHV0q6eNo8?=
 =?us-ascii?Q?Gxqsur7GLJRP5viFry2JPGCGMQA24Qdfp42tghS6DzODx4rfOXWm2k9Mphpd?=
 =?us-ascii?Q?lO6SyKdnuqZ6izmPGKy0vDScDG3wJuh9FAp6C8DuRLhpjm0y20LSqGih6oNG?=
 =?us-ascii?Q?6HPA0/qM466tjV18d9GqnaG7uKLV5iWFptge7sCAvCqHxxgiG5sPmGRuk3oA?=
 =?us-ascii?Q?Q05UG0kWvIBP1jElvIgh+OsuhsYC7dPWAf3VoMnf5z0tj/+NSLUt39bq9afY?=
 =?us-ascii?Q?XpLHgTXzUK3CAuQlTsyBh6J4KWb2H4wWKEAEuIyAXPQJ+vVruXtwfvLqrAcD?=
 =?us-ascii?Q?9JIJPKOXBRgX5RgEtQ4Ovx9jISqCU7f0Cy7OlHz68mxs0xNhr8dCPYIEEJpG?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XxMs9IsY3TLPnDLo+6wdCD20TYMGaJtsCK06vCUKfKTSSlf3HVURfb0gxsJ7RYIo+cz5jprmAq5qAl1beAKuOGiElYJ1GTlejTW552ndJXaz3bArS2Ayhr1o+VDxuBPBknIdSMk3Yoe7slqupQTDnAcHxDiK4U0Olg/FKGnCqeWNghT446NxtBox5EfbJevFWhlaQT/KdgNqbWtQR3j95jxOp3YiCmPsPfQMY3OLxmtqW/xxJLCDiTB32ziSE9iXff+g8pXTM3gO+eLYSpwSvjB8cBBWrR2IdtqDbJcc9ZNk1CBttFjCDzf8CiOuZte9nikukYyG5ilB/qktuv9HaYeYEeQJaJd1lg4KK59/sMbowjXtV7xP9/uVkS1p7Zxv1CtmPCucDNscHkTqFMCgRavqoMwYwS3CSTo0CHQzyFlHP6uxUq7er8zFx20aCRWz59HhdsP89V2zEuwoQYIyJaY7y6bmY3F8x7disxht7PqxxdCrqUMzExRcDiGV5KTcjgxRZAKyafOWS6+KF7KdHL9JKB7QWPij8WUJcS/ymBfNyswaPlcvJ7OGjZThFtiBCg6p5sN1oiJ7UKQ/kgLdO+v7g1CTER5UNfqw8yfuDA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3317f06c-a7dd-422a-baae-08dc80875eba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:03:28.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nGpQsG6kIk7rTAbNuwCcpVP1qYrlY62JV9KLQBHsaUEGsGEthh/5UDCcGKBplW4Ei3sQ4U7Z0zn7ANzkbUJVNGNN9BWgDciGudOt+f0BfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300067
X-Proofpoint-GUID: mDtSSoaSZ_u6nLD2UaY-u6KB61QnQ50A
X-Proofpoint-ORIG-GUID: mDtSSoaSZ_u6nLD2UaY-u6KB61QnQ50A


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:56PM -0700, Ankur Arora wrote:
>> Use __tif_need_resched(RESCHED_NOW) instead of need_resched() to be
>> explicit that this path only reschedules if it is needed imminently.
>>
>> Also, add a comment about why we need a need-resched check here at
>> all, given that the top level conditional has already checked the
>> preempt_count().
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/entry/common.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index bcb23c866425..c684385921de 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -307,7 +307,16 @@ void raw_irqentry_exit_cond_resched(void)
>>  		rcu_irq_exit_check_preempt();
>>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>>  			WARN_ON_ONCE(!on_thread_stack());
>> -		if (need_resched())
>> +
>> +		/*
>> +		 * Check if we need to preempt eagerly.
>> +		 *
>> +		 * Note: we need an explicit check here because some
>> +		 * architectures don't fold TIF_NEED_RESCHED in the
>> +		 * preempt_count. For archs that do, this is already covered
>> +		 * in the conditional above.
>> +		 */
>> +		if (__tif_need_resched(RESCHED_NOW))
>>  			preempt_schedule_irq();
>
> Seeing how you introduced need_resched_lazy() and kept need_resched() to
> be the NOW thing, I really don't see the point of using the long form
> here?

So, the reason I used the lower level interface here (and the scheduler)
was to spell out exactly was happening here.

Basically keep need_resched()/need_resched_lazy() for the none-core code.

--
ankur

