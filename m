Return-Path: <linux-kernel+bounces-201281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0B8FBC77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4701F223AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812014AD32;
	Tue,  4 Jun 2024 19:24:53 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74414036E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529092; cv=fail; b=qRHeblvnsKY72R0plc5b43CPkRuubRpwZDx2Jg4iD79KAHijBiuJRAaFQ+SdnUeed+SY0DRPsRH93P7dTsbdkqek0XGXwLRK+0WoqTn1BV72DxW0B0E2uyh5X+GGVAbKZe2Sb/9+msWvHY6PbdQJWe8muz27GMGxbmSw2wHXoqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529092; c=relaxed/simple;
	bh=U/6Bu9brVkiIO76SLaTPfyZamtIJxs9J/TUasabWEr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UOPHee6qo2S9c1whocXlwJwOznWz1it2b0QWYNmbk+gSkK6u1k+Jfp97uJeeYpc6woY+nhwJdRUoxV//jrnM2gOpzbdXZ5Cp2Kdjsp597dnoDhHLmV4QvMtm3txHfEE4gP3UtYOq40+tDOcyfgggb7rpOflxmf2aI9m5GSl5cN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BmsFC005875;
	Tue, 4 Jun 2024 19:24:32 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DnTO7MbMTmPQY?=
 =?UTF-8?Q?2hsAp96BQA0jAlhGA3YhFcf+o85x8Es=3D;_b=3DVXxwiLTgKy+7PgIG7ejZ9Xe?=
 =?UTF-8?Q?mig6/aLVSMjlFpx7zj+yiKbNgqpCXVMwDwccW/xMjSShC_B1me2LAHl5pBSyH/q?=
 =?UTF-8?Q?LP4T4D76EhiR0oxWKU+dsz61jA7S2QBfrkvKELcq+PKSNpZaP/E_HdHoZ1AdmmY?=
 =?UTF-8?Q?FrlWj+oJHaJHzTG/T2hZXbaGki5A+AuRHHCwX+uVrCj6y7hgveV91363E_j2lef?=
 =?UTF-8?Q?vu2uoI8KzxqhPwW18JVaYEXnJ9TzOKylAudgjL2jrGJRbswUExBHzma/GXn5mXu?=
 =?UTF-8?Q?_juZqlxV0MC0LY5QpBjw7ivSHQi5K65kgQlFockhkU6WN28ofB4iprFEz35NFJV?=
 =?UTF-8?Q?MzUV/E_gg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvwqbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:24:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454Hfrwk023968;
	Tue, 4 Jun 2024 19:24:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqx9vrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwdcJ1zjWQoFnUPklFcuTK/xxvjJHyBwyf4DZEdzINDwjDyg7KUOQK7PqPur2grTg5guHkCXoa2DzOp59leiUubJvViDWfFKIiQCklbnViNOhzArr/3LGA+xqLmgA3RabsLqwczWAhfmfH0WhrryEIPjEuAAnr7xbn5rxoMf3yGAM8CXA2AkCvp6rZmgEvmAFILMnog70xpC8cFhLBOZ9MP9FhhgZ6S/4LTsiOKYKdFMhDNLz8gwb+nWN2fLcnCJP7EjIRblNI1Qg7bwU7HD7mYdu1bfuwUWRR5nDQSHr+S393SsB9/Qnum28WQEfX0AGCUKrJfbdW4ezc9RJlufsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTO7MbMTmPQY2hsAp96BQA0jAlhGA3YhFcf+o85x8Es=;
 b=FfBTfdCFkOfxLAu3wVCsZNkRdVU8Ih1akR9X0UUTbH7M2HmPbb2jy0nwfJAGnN9Zl1MutHaZiBgZRYoAH9j3839sRas6Knmrp01Xxv45mNWfQdnnPxlHCu9nttzFXCasoVxUFpYbIZBO2wqQDNO061ujIqmQKxNqYFKf0VKxHWOOApOFhLlDVeZLoKCSIbyIOAn7+QNzRMGrBwEZEZQ4aL78CRXNViYh9U/xTFyznfr8NphdqFD1J3ULqGb5H5KdyfkMiC66E6SjjgFvoPouEK5A7jjeJC+3STLKmLVBr/MESvCPQ8uMOnMlBZXxVIUcBrIh0jzXcNGoCReS4GTxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTO7MbMTmPQY2hsAp96BQA0jAlhGA3YhFcf+o85x8Es=;
 b=K4q7JTPl89wqcFi5xvyy23CPOVH7YfUqFKhKMuHNqaRmtMUHevWHNXUuu7CtzXywWmBzkPZeYuxBuR0Q6LUcF0Rd2NG5J4PLRJbsaRejriObY6Px0V133yG61HBRrHoq05ZtKe8ElUpFO7D9aU03Rvn/V4FXCdifNtRDh1CnsfU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 19:24:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:24:28 +0000
Date: Tue, 4 Jun 2024 15:24:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, willy@infradead.org
Subject: Re: [PATCH 09/18] maple_tree: use mas_store_gfp() in
 mtree_store_range()
Message-ID: <mk46fjiuvfcmgic4wboa7ylgmag3upj4vcmo3344ulqmmjc4bc@mr27caxx2zq6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, zhangpeng.00@bytedance.com, 
	willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-10-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-10-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BL3PR10MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4ad638-21e4-4ade-8ed1-08dc84cbf3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XomeUMLILvxzzLB5WPSZDJpIuUpigrsleaB8xOABnms5Ui2sg47t+BRfdMyD?=
 =?us-ascii?Q?n/0wrmB0VX9zJOEEKbchev1XJhWTcfIUt+/Bami/+4vYbrS71cuxmWVakPBi?=
 =?us-ascii?Q?4DuWAFY04Nw/UfbvpDMOQcniDwrV6ESIUoLTZHnFq9cVFvuxqfXdv0uQHw8y?=
 =?us-ascii?Q?gP0HhLFB+8QiZDGzpqYSE9tKahjKZywcu2UQfNnUC8QXa1YmlM4Z27QEE+9N?=
 =?us-ascii?Q?t51fjRrN1JZocyxKeQpA1WdK8jN94kN8Z0FB4gGPIk4ZkHW5Y5jS5+hvzHkN?=
 =?us-ascii?Q?q0QVB36WOOIFCQXhSB2Wxlm48TlWdoeJ3l4vAnlU2hpI8yZPPHZIOxRZHvCP?=
 =?us-ascii?Q?PRcMzhOMKQppGFQpJHTNtVv9YESa11+y0hB2tpd7wNdMVku0PIbwrBx4ippN?=
 =?us-ascii?Q?V1YhNSm0AggFsqvXMLo7Q6jNOMx/FQcKCo/cf6dVHU9/qbkob7OIFxyoa4wy?=
 =?us-ascii?Q?aBF70JItmOQpUOSyklJDjwJljPu38ynNHGJwYhdSsqPwDse4tyIKsf079hQA?=
 =?us-ascii?Q?QxzlWztiGVELJXhMPwuqYea+4xePJToyCbnL8TjhjCzADgbuKXFV85coZr9q?=
 =?us-ascii?Q?44xLRqdutaHV+NjyLOok8TupfcECtHR8V0vUzE/OOjA8pcqnFq1+UE7cOwFI?=
 =?us-ascii?Q?AlUAus12gp5jvTCPtOAYjAf99s5TATgSGsJw+ht6ZkDUD5Wo2dJP82FMSHOz?=
 =?us-ascii?Q?IFEgVBXsaB4f7lY3pn2MbgPBZCPxNtr/V3L/pREb3Rf8p1/leT2mfVWW9Y76?=
 =?us-ascii?Q?MgXnnnrR6i/Y/lwGsByHtEre4d95aI0GJTxJ0mtXZE3ppsuoIHdL/G0YuflA?=
 =?us-ascii?Q?bqYht8wdZ6rgRNOO5eUrKrPnzheUq8DsCf6lkiyLA0BnnhHUg3bgKsdTMxRG?=
 =?us-ascii?Q?+HLSK5h1qZ0vIODQSZgkShNFG63iuF2nwhNZTdxbUogsL7NrPJw+kSDKmOIg?=
 =?us-ascii?Q?A+8hID3JXN1Wqo/EA7h6xgzlYTF2E1xXTH6HOafNyev9lYiwukwhBBNiL7xw?=
 =?us-ascii?Q?gDHrrL99KJ6Z4ulQYVR13i/a72pJQn3hp/o1Q26mG1CM58E/TFul5T77js3A?=
 =?us-ascii?Q?xr4M5bp8ZdsfqEMfyHceBbB+dRo9om2BIIXqExopWGyIQ1bX8HV38uuvup07?=
 =?us-ascii?Q?3pqzgwDxZBbXuvG6nP2cRsdO/aynJF0pvYA6B+17zbwIovO54It9ZJKQ2r40?=
 =?us-ascii?Q?Kx11cEF7EVQf6Vu0hxwKmKfzxjPAL0MjURp/qCliUJQJjgzUd8WfFVyha4bf?=
 =?us-ascii?Q?dxvbJQ6QfE6jr2xQh2nUv5zokd/qIC0imSkwkmGw0g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6nqfGn3Rid0nGJCqhni8mN2mkHEbdTW8VN7nVZQV0duj+1kyqmLrSFqZvgmk?=
 =?us-ascii?Q?W8y5R4YPtV/bf1YRMt22XZQfRMqZcT7J9Xcg0gyIOis7pYU5EWcvQQB7JIXf?=
 =?us-ascii?Q?CPJ4FKoZCRIZ4grJjnuOU98gXi8Uc4kNkoiV90pla+YzNNJ5OUTFr4caPdEK?=
 =?us-ascii?Q?UwbtGygsY59RE48MOUVbtSDtpilNl4KO6ntKP9nu3E7GoXsm5YNrz6Lbe1CO?=
 =?us-ascii?Q?wC6+OUwrORHGMg1M+0lNC2tiqwHpkQp5lvsBbBbBqhmldsjzshtrJkWlCQLX?=
 =?us-ascii?Q?fBgpvcOKkMELXqA/PIOclvqypo4/xYOezX+8+yqgNvA2O7U+Eaex22ZZBOXU?=
 =?us-ascii?Q?UBos/TA5wGUosW6rxhAIizky6GSqiMo2ZjnOWkyvW1wP/wYwiBf2GiNxhVg0?=
 =?us-ascii?Q?51EpqOOyaTUEZ4Jbd0IxnvFFJFoRlFpr6w0YynhOJUZD4/4M5XRpCoTckCMz?=
 =?us-ascii?Q?LPSbMmEssgTQlX+Akp+ZnmvBX2Rg+h0dlOPYqp0k3eYAPjmZr+nG2O56p0zS?=
 =?us-ascii?Q?qitnem8S7Jo0IKUW27hIStXdhOnra4bx78nmGFG/Rni3QBLJ3XFJUK/XZd8f?=
 =?us-ascii?Q?WV23SOKIVibiNHU/kTnf72/FkExNbA9fBmK1Ei80KxtkHsnQfCSRNjMKvmer?=
 =?us-ascii?Q?lrzcGfI4d7zrTqjP1N7xPiWkEaHVN9dKDCzWzbxu50OzyApDTRFEFthf2m1P?=
 =?us-ascii?Q?9YNog2TKFR6sWvu1SoZkasRZDua9vXLAzZWwino1XCo3lYNNcUjtjtKe7Nmq?=
 =?us-ascii?Q?z4ZUxK0unUaIsC8GPVfPe9ui1UCIc8+w61c4wrzqSsQzlrocXlQugDb4nUxI?=
 =?us-ascii?Q?arcwLlymsKl7Ndy735/lvqjZQ0XotxJODIbPcl7VeR+OAzxPYeD5pf5wIwg0?=
 =?us-ascii?Q?Nh6KfbdvORSxubBNvnwk2XVBmw2P2Aa8nxRhkOzq/js4UqOaRaa2NlQ6WKAS?=
 =?us-ascii?Q?5WlQ4KYC7I7V+5Kx17i/UyvpnUrbh8KspUHBx3RO//qJ99n/FDScYZ2oqniJ?=
 =?us-ascii?Q?mv+rOxUHn67RlMjrhHLr8zURNB8Zy2tq+9yccILnRCHFeTf0n/Djx3FCudFF?=
 =?us-ascii?Q?x+eb8+NFmgZm9RPNJHAUYE16sws+/RTk9zHX1PAgpgyy087oLSUTrIGSMVoF?=
 =?us-ascii?Q?jUXQ2v9NgwE7H7pBLsujFhPgJkpr3g+a4UezpSGy2LSOgGH5oiLEUDOnXv1m?=
 =?us-ascii?Q?tSMPZEfB9It0WltbwLj0Iu2Vxg/QfwPjZtzN4Yj15z16mKm7RecvA1Au189a?=
 =?us-ascii?Q?I6pe5aOvLSNusMl3/sRbBoqkDMBPE2BC/NzvAYxShRQUpEQfDTvYwJvilALB?=
 =?us-ascii?Q?EWOBuZFfzatjo1Q5X7dNbceX73TEN/UszHP7hNmcTaJM0qHvQUP8BKug5RvC?=
 =?us-ascii?Q?/WHVRj7JxITyaYinvSKT76X7Ki67D8AiwqIEKBORNHkGhesuaAn/cPGTETYx?=
 =?us-ascii?Q?Tyr0TzdTyTe4oRD+OwfFtjVHivPuGph+K1fuX5GXJ/Wrnutbuwo3sUyZ4fQ0?=
 =?us-ascii?Q?UOP7/rngWXldS2Cwm3TmdGqjm4HdJeReVBWoE9+EvpI6wMMAuHXoHrVj9fv2?=
 =?us-ascii?Q?PLebhS3DmZuQPdnpCezQYnSWCb1fMwJIfqyxELlX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	17886ymFWPmg5iYjfMWHjKfbdhr4M8VuFziH2TEj+5FdM3eJL9HECCgaEGkCDYl+ax8M0gm+vCmzbxX/zDvmJTSOPWsj0nLDGEp/dK4ZbAm7YrBHs6lqR1O1Pnqp/d2DHfAnaMXBOc0Y+OcqdwsW1VPuukuHSo+Kj9TMdaCUhwUcS/bP4LOdhl0SFsPlmOGw2L5KfLdenHdWFqp89XCLdUxAnH82nitnpInjrlgfzHe2yxTDfl9x58FptBdZahs0hAIb2doO8/str+wxQk+mzRtwVErrazA/yaSQs6m9eZeazQyAre35Hke57oXOFfG5K1zHZNWK4xSvfZEScKw2o3NkfEWxs1vI+v8JnaBVGAmIJiGidWt+uoMYsRSiLAl56sH55PgP/G/GrziwTddb+zoAIHCkbuVfP3thPNSDBTsNLZHRdE+5P8cgymaTup4YV3/avMdH+s0x4qbbQVpo71ZpnzbDoL081IY0ci8IOeDGB9WZKdkSqVPbVI0Ka6JmOyLigMDKsdtzYk+ocudY2lJI+Y88c0icuQodAS2XSm5AAkIbBOgjuWm9rBkeRCGbgKZX6omDyNmGuaw1p0i56xHQioV7kU6hs3a5/9kEAdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4ad638-21e4-4ade-8ed1-08dc84cbf3f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:24:28.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6xFxH57veNjGacH7hq+j0oZZUegbbaJe6KrYhFUsCBBZMfj+1ypE1ixFvADk2XtruRT4PvJqibHPA+eE4WlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040156
X-Proofpoint-GUID: gUwIvr8BZu5UzIDpMXQaW1hBMmYRoFTC
X-Proofpoint-ORIG-GUID: gUwIvr8BZu5UzIDpMXQaW1hBMmYRoFTC

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
> Refactor mtree_store_range() to use mas_store_gfp() which will abstract
> the store, memory allocation, and error handling.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 34ff1b3f729c..e3ec6649f7da 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6457,7 +6457,6 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
>  		unsigned long last, void *entry, gfp_t gfp)
>  {
>  	MA_STATE(mas, mt, index, last);
> -	MA_WR_STATE(wr_mas, &mas, entry);
>  	int ret = 0;
>  
>  	trace_ma_write(__func__, &mas, 0, entry);
> @@ -6468,17 +6467,10 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
>  		return -EINVAL;
>  
>  	mtree_lock(mt);
> -retry:
> -	mas_wr_store_entry(&wr_mas);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> +	ret = mas_store_gfp(&mas, entry, gfp);
>  	mtree_unlock(mt);
>  
> -	if (mas_is_err(&mas))
> -		ret = xa_err(mas.node);
> -
> -	mas_destroy(&mas);
> +	MT_BUG_ON(mas.tree, mas.store_type == wr_invalid);

This check should be inside the lock as it dumps the tree.

>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_store_range);
> -- 
> 2.45.1
> 

