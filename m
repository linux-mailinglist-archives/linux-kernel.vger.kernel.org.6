Return-Path: <linux-kernel+bounces-346464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B398C4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9E61F24578
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194C1CC882;
	Tue,  1 Oct 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9PEKPDg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uti908vc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8A321D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805718; cv=fail; b=UCjBaJJ7IyjFVmiyqDQKJWQ304lNRSwE63XkJTGKs3yq9rp2WvmKZOOjV5ClXARz825Lyy7Quwj/BHdkDbEPatGckNOsNEQGlHYVQUdWJKVO0uO82wC8tmwJxlgpfVoynleQKGJJpnmh64i7SyQLjMtWECRmBZvZ3Vdre3RAQs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805718; c=relaxed/simple;
	bh=wx+hBBQYMd0+Smromb5a5OgJQzMkSTxM7WVyn/SXf1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gCozc1GvI+Vl+WLEQ1BlWpp4tfUUw54nsUJEQdDYe3vH3URUmIOKIrogOUvbdQt/DwRMefK5/uodyYXs5bogKgD80HO2u4eZ3CgiQKF/CMqqmsEDHT7RI9JAcDkO+IiA8m0hQKGEJW0eccZlvd8J2bcG2ku/bBFQ0c9774GUW/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9PEKPDg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uti908vc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491HMYKG016810;
	Tue, 1 Oct 2024 18:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NXSF5Wl9RSATbAY
	hUTwTBBIemWHet56pkK1RxKLdOWE=; b=g9PEKPDggMBWSrHODfC/KjqODpX18qI
	Sswq+xJ5ks8RvMkL+m0W0P2dQ/mV50C+pqZT/hvJmSTZOp/CwJS/iK63rKJPx5iD
	7Gg7XIMD63IOvubC68ZN0HmPBo9RNC6H3vqTOIHdZtW262Yyej2k5SlKL6QqItln
	LkMK9lRt4bGsZB9bm7ijZakpRm4FQjqh92lM/iHagDvoHwiaCD7C0ajqOCj0uSVD
	lQ+eeLQ+akVi5OvwJPn0IgsOwVtY6/nGMz9izREFMdisiFdANs2aGcr+TAP3N9mE
	HRlVRBPq8Vy38FbvAOp+UcA6jNgawHIoa953yUb3IOmx0BYbEMgs/aA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1eyvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 18:01:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491H3gOc028430;
	Tue, 1 Oct 2024 18:01:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8884jje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 18:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA6e1wr1kv6oMDCmNlHcUs+wrIp51+fF2UnEakLbzHCzMGlDT1P+S1grDw2hjWH/pCG7wtYonbF74SuGMw4oHCRAF3QwviBJTwWsrCpIodghFsU9gVXjWNyzSOsn53YRu87+0ryWs8AUN3W0J/dtDx4VBjr4DmgOwNHmlS57Y6E4l31P4NcorBaEN9i/ZuOP7+duSizjMcH/QoRNcoA3dGiuOAUlCpXP1w2XPceSW8au6uLuU+Ca/7gLtmAAhIba90nVovgteupMg/p9ie8KNWfmEUb9EgDU4DHStOVCzZEMkpP9RZms8w3sB8LB63GM8ATyW1o5zZqxrcHLULbbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXSF5Wl9RSATbAYhUTwTBBIemWHet56pkK1RxKLdOWE=;
 b=soSUpcbKRzgo7MHeQu4K67A2WDXLF2EJ4mtbQldplVZTV2+GzDYjfo1w96nYB4284uU/ipG2VRZor7YqvOMTW8OsiWR/lNEtO29spugwmFILEYzGis2CItM7BiQvz8C5DugxhkE3w+APhMbmgDlyVBYJ7t+4USEoVeTaI704wnLax4q+w4l7zjPQ+ABaq1gFUijSp48Yh3//H8yAMWkg+ct39sOqVCSz9/fh4JfRFwu2h/Unm/6sSIxBxWepLcDafHBQUho81p3cetpdj+CB6pq9ZGJZ3/IyS9bw1LE5aAP5Yx3cySIwY8xxmeGyXr1y2ifuoB8QJwv4KBDS9Pm1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXSF5Wl9RSATbAYhUTwTBBIemWHet56pkK1RxKLdOWE=;
 b=Uti908vcspqlRUCjJY4NfgzUokHCzQC8E2/JgXw1/e8LiNmyaf7lXAylcUNSrm3vVq/i39AZoKMcrg9iTDlBaV7ZAe18RGKcHJeutL/UTUfDQZ64/smxe7yIUoOswenZrFt6/+HHHHoZ6U+Z66VLT5paYQ5edavHutqWkQjwIRI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO6PR10MB5619.namprd10.prod.outlook.com (2603:10b6:303:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:01:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:01:46 +0000
Date: Tue, 1 Oct 2024 19:01:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <aa6c26da-f1f4-4bc2-9b5c-0f682f8bc7f4@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <44271477-0789-4fac-a649-75420d0c403a@lucifer.local>
 <76adbfac2a0cd1f500c5cc481b6e0068d11d37ca.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76adbfac2a0cd1f500c5cc481b6e0068d11d37ca.camel@web.de>
X-ClientProxiedBy: LO4P123CA0373.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO6PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4ae2ca-f482-44b0-82e2-08dce2431d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xo3RS3q2k7qZOQAqjQcFdk1fSyl0mbIbGB9auwMKFJ3NbCg0ZavxIZGaYPaK?=
 =?us-ascii?Q?uhCx1M5WKHJ+j08GYb8MikKgDiYTy2qEzZV+aFlQniV5+hHN6wZx1q7ri7B7?=
 =?us-ascii?Q?bXOrBCH9b+ALSsEtGEi5RCv9ADGC/2l71lVC1FdkN3hrzBl6cD0XWTFfYK+V?=
 =?us-ascii?Q?PkirbVLuYCJmKNCwbZbzqX/jZzwa0cy5j0lv3wEwf5Hncygv434zmZWBCD7M?=
 =?us-ascii?Q?Kz+HgAemi8HqUA7E7TuO3ih0F7CBNGz8lEepvCNr6UR4OPmMgIrKMxhKQJp4?=
 =?us-ascii?Q?xFIVc89I0axGE2JHqvbeCcu1dP9acviiFfBeaZnqRRNX8pSfI9M9TLSthGjt?=
 =?us-ascii?Q?Xkyl2QPjczgkxhTBVlZDP9hBNJWB2BYI9BW7KEWM8mmIeMS810Z6U4O8k+OW?=
 =?us-ascii?Q?lAbrWKnEX+XvB5fDwR3q12Ce7aBtFHLmn8ULD6XuoKAH/+Jkjz+EiTcfdKx/?=
 =?us-ascii?Q?Kgwpf0WL5tB9NXly8c7nhkk4mPS39VQNWg3YGO3exkwBxIvTDM/5J9Fe6Njy?=
 =?us-ascii?Q?/eqGj79EgDW0fSJBowjdEGMAnx7OJDOhhnu9Vv0Y8X47YJmwCh/IgWPWd0za?=
 =?us-ascii?Q?qwk8x9IY7Kw8Hk7Jg5JCA8dt3b9Onu03IqP470j9nGGKmqFeeFBkwkow9qg0?=
 =?us-ascii?Q?maEZVGOOmFys0XDI2webw+Ew6wdnSLMx+3Gvgq8K7t2zFHsGXthES34bNCZ3?=
 =?us-ascii?Q?UgJ9jt3408nnxozRyivYmFt/046M2Cg33KSQETLthsPuHG/Aze7VvjB8LKvn?=
 =?us-ascii?Q?wp3UIdo6EGlfliJrmtfQER35ilZ2ciH7Mfje9VM596xgKr/j5LT23+XRyacp?=
 =?us-ascii?Q?qeTEwlTbiQPdaKZjAKnfyDfay3FPKIvBNzc0yTX7jEXBuWmg9z7BW/FUugOR?=
 =?us-ascii?Q?/Hjf+4w9fVQUVTf0yo/P6xdRXmd2wsIp71dwrqJLmWvXvf1iYK31Hc1LKM3H?=
 =?us-ascii?Q?0DsuP04QucoDzTSSLnwkIdVZnZ3iCLn70ajxtA/SEhdQfGRQlYgUcljWsNWx?=
 =?us-ascii?Q?r/rrmTeyWunnMuk1P026yQ/PujK3SmJbo4iceorCQ27D0yW5XxkqQ7uvSyf2?=
 =?us-ascii?Q?QhlDalECiz9L3RacP9QmBbAYkicPnYHIpvojyYXgv/Sg1X7rxmUtS5cuh5qH?=
 =?us-ascii?Q?A1L1oG90VmfCmOmzQfa8x5QfUpJ1AF5A8/l97nhyIDnkpQpiYHK+NJidyhkD?=
 =?us-ascii?Q?D19RrLxFKaFye6GkMndZcM92n8NbEzUYt5wE1IwfoR4jccggkjVKPa01DMAY?=
 =?us-ascii?Q?bMRgGZfpol6suSJREohoV2jUzF5ZdznNmwo+rGI5PQ2Gpaxby+YwnMPn5xJW?=
 =?us-ascii?Q?PCqI4ZUs8D/nc0aCpVdhYBWMtMo98nL9aqu2FHWUkH9SBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjnnZEjODtMchdQ3I41XW4fTlIkLYY+au+lNa9/jaIv5rJjosVWKvyusNB0Y?=
 =?us-ascii?Q?h+lKyj1NO49kZL9zyZs9eQCgYHxOJLpi8/Tl8QzJd4LtzA37azpAN5DIS9Nx?=
 =?us-ascii?Q?1LAqC2l1E/zUd6eMu0dr9HyyUvJWHWh1fG0StjHs17UgcPEX+9iqXiFOX88Z?=
 =?us-ascii?Q?8lmxELdrspduetYfoM2gwx+zZQZjvXflZASz3Nu1bWj2U5EHvZ6KIX8UlUQf?=
 =?us-ascii?Q?PxRK0s1kX1IzNQB+9pgZur2DXGwMg2FWyXHtDrSkdy8+S/EyDhRyfWkBNyrA?=
 =?us-ascii?Q?aVQRuJGmnt5X4r5dnNsbZAFq0lW6H8C7iEcY87TwpOjqRcVH4vEb6aCwPvfN?=
 =?us-ascii?Q?lOWhG3e0XO7WYgDWjCx1C7uwD7EA5bRMhBS3IYeoovofxI7AcqalcZOPvRmP?=
 =?us-ascii?Q?kqspSX+KcsBpn7gmLG8mfMcZCALUftD/R6scMT7uROq9fDmcAOFfBzuujqtO?=
 =?us-ascii?Q?dSJPoI2b0LHCVcE0kod29mzOxwQ5ijIXW8HJaLUKANog0E9Fw5xDv3SHaVAc?=
 =?us-ascii?Q?CLYBeu5cp/RFGe413cQo5UueguD2a3ZkQ1YfwZUycgo9fpN8bAMFOQmIza4e?=
 =?us-ascii?Q?OzTf4ai3Xu9sHTxuyWTGMkJLOcJ2BKK0iyu9oplW4C+/enxiFfKot76eA9wT?=
 =?us-ascii?Q?hWXNou38VT2XPqncwFmGqrEFl78cpi5BniHnsIYcmzeTZogkhjW8CKupgrr3?=
 =?us-ascii?Q?EfwxbFr94nF3cb9WoZarluiyR4PaNasFEZRBmCNu9kN0hfxB8jLnDuVKJrCf?=
 =?us-ascii?Q?YkxTVAtvDg9VMM6B522R5yvwvdgD4pj3WzaGDQcNqu220HixTUavF364Xb0O?=
 =?us-ascii?Q?+yfG6nYfY1yo55D0K8wPA60ZoAsOPcF3vn/uvloZDt8FB8h/gZjoNgEAqSd6?=
 =?us-ascii?Q?JrQ6/APOvfivS9ckHmJRnBN2c3Dqnaa0GN0iZavSIS0h2QLYbG9x1iHHVsWo?=
 =?us-ascii?Q?irqaXvGzAdrAZ986wAEPPGFKUyo/gq/u1ge+NR/ueLh6DgOR6BPbApY8XYxh?=
 =?us-ascii?Q?1vyVCYa7mfNDJntmuRcNaiIA8oce//X3B0lmCqEc5SSfS1ZH5F1JVHZU5sNy?=
 =?us-ascii?Q?RWHhCUk4GJbRg/hrTh9yiJNnw4hH6UXG/Ed0bWzS1K04ttE9HxSSXXNfUWYi?=
 =?us-ascii?Q?fzFJCVI621vFSKXFIba4hqP+go3MQJpj8udScMTFdmklAQtJBVbjH8XBrMM7?=
 =?us-ascii?Q?B4YUULQwLAqgHqSaiILJH6lB0KodYknBHlZXge6bnDo/4tV9lm3C0+5TveID?=
 =?us-ascii?Q?RNAZq2OLwjlqX7R7FbSA3iDJ/0dykdSEHtMadeMWzTfImsywBBoh3hICAmI8?=
 =?us-ascii?Q?AYrogus8Nz+/l3YAJCxplivI7+1GMyTxl/pgruUCrQgHJxjNTXiDtCVbe7Gh?=
 =?us-ascii?Q?ACXOKCUOUW3tBSVssHeYUM90UKT0laXFnZV7Att0Tkhv8RSfKWL4VO0UWggf?=
 =?us-ascii?Q?Kh4tv7gqRjVpvV2rqi+YWBEyq78PX3XLO/WUMwC93Qfc/0GTwrIyevkTb454?=
 =?us-ascii?Q?IqFCzRz3FVlAI3EYuf8j0ID9+/tHxZIvgBwQX9/VbGcMM8DERTj5RtkyyQvk?=
 =?us-ascii?Q?YYd47to9QmOaT6aWbLZmeO1DZ5EEZXX0+nFlo1Lwfn7y7cQSIgGqFKGpwNWH?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3VVIjzdOVqgTZl7SLKkZVhahImelupur67wCrKKQHn4jexGox8J0JCH8XaLr6H0iW8+SMWUQuIen4Hv2Iul2iZpxuTUwSXql+FF+MdCMD+Ourx8CvcogOeyADSLqK8iTpWSzR1RO2xaBscpR/wbD03DdRfQDjfE9SWZrKzVCzSQ8w0wpJjI+wE085P/lq2gwMB/1g672W7Dz6PuZ7cnyFwhMpDCTpBxxph/L2wcBh1yb0O4YhVQgBPcDK5UjGM97aD9RhCiNnRqgZzQ+xi3qyX/7ok5Do/JiHSE7etRCrSTXeRCL9B68HtaD5AQkj6EZkQcpYbsF5vgR/FTUvNn46vCHiEOwlzfEByYTLIgx7WrMi4GhBsnHwy8xSugMFC67/oimoy4acDHrZr7C2GENDGdgpracZF4IZmyXyzG8TTBlYGDlerQnbI6p2psy6l48A3loRM3lZ/1NX1eyLltP4pNWfmchuyzaQq16EsKmSH3PRC3bUqo1Uyyex4ongDLWhrUc7ve/qOQ9F9SPKAF7dQRlpRuCUhX7/3sAuZfhjAQ+VHhKX7/pliDuVhTN3W5DHqJhJtEAzXrgLFmBfFeojxPY8l5tSq+wrwfjTfUFt4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4ae2ca-f482-44b0-82e2-08dce2431d4f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:01:46.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFXVBIKzKGzfiLtAdVFJA1uD6tv7641QW5UtX2+ch9FaZerdvkrDwzGQB+VhZZU9IPriCqNaLNtizR4HqYDWKYuOUOGCmdxBPMfjbtiGCcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010116
X-Proofpoint-ORIG-GUID: 8lsLPuzTfT7XlQes-jXWSvIlAM8Qo1TD
X-Proofpoint-GUID: 8lsLPuzTfT7XlQes-jXWSvIlAM8Qo1TD

On Tue, Oct 01, 2024 at 06:43:35PM GMT, Bert Karwatzki wrote:
[snip]
> I applied this patch to linux-next-20240110 (it applied cleany) and got the same
> error again (Andrew Morton asked on bugzilla me to put the logs into mails):

OK, just thought the chunky old mega logs might be a problem for lore but
obviously good to have it all stored for everyone to see also :) If
Andrew's asking then definitely the way to go.

And ugh sigh yeah maybe a long shot that patch, but was a good thing to fix
anyway!

Right time for me to roll up my sleeves and dig into the maple tree state
and figure out what the hell is going on here.

Will dig in further and get back to you.

Thanks again for all your help!

Some basic first notes on the report:

[snip]

> [ T4555] node00000000cba76266: data_end 9 != the last slot offset 8

Same exact bug, same exact data_end and slot indexes which is actually
pretty handy...

Anyway we're off-by-one here clearly.

> [ T4555] BUG at mas_validate_limits:7509 (1)
> [ T4555] maple_tree(00000000cda835e1) flags 313, height 4 root 000000001ff0b07a

[snip]

> [ T4555]       1740000-67ffffff: node 00000000cba76266 depth 3 type 1 parent

same exact mapping range too. Again handy for debugging.

Type 1 so maple_leaf_64. No parent node.

> 00000000c9eae6e1 contents: 000000006be89277 17BFFFF 00000000bb01c9f7 1B3FFFF
> 00000000fd36058b 1B4FFFF 00000000891e81bb 1B55FFF 000000007f0c8f3f 1B5FFFF
> 0000000043f46074 1B6FFFF 00000000bf6f5946 1B7FFFF 0000000084faee8c 1B85FFF
> 0000000087868a7c 67FFFFFF 00000000af00822b 67FFFFFF 0000000000000000 0

Hm duplicate entries at slots 8 and 9, which aligns with the other errors...

> 0000000000000000 0 0000000000000000 0 0000000000000000 0 0000000000000000 0
> 00000000686521f0

> [ T4555] Pass: 786885051 Run:786885052
> [ T4555] CPU: 7 UID: 1000 PID: 4555 Comm: rundll32.exe Not tainted 6.12.0-rc1-
> next-20241001-mapletreedebug-00001-g7e3bb072761a #542
> [ T4555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-
> 158L, BIOS E158LAMS.107 11/10/2021
> [ T4555] Call Trace:
> [ T4555]  <TASK>
> [ T4555]  dump_stack_lvl+0x58/0x90
> [ T4555]  mt_validate+0xc64/0xc80
> [ T4555]  validate_mm+0x49/0x150
> [ T4555]  vms_complete_munmap_vmas+0x143/0x200

...but needed to unmap some stuff first, so it's MAP_FIXED over some
existing VMA.

Clearly something goes wrong (insightful I know). It's possible something
went wrong before, but unlikely as we should trigger a validate_mm() at any
point at which we fiddle with the maple tree.

> [ T4555]  mmap_region+0x2ec/0xc30

Started to mmap()...

> [ T4555]  ? sched_balance_newidle.isra.0+0x251/0x3f0
> [ T4555]  do_mmap+0x463/0x640
> [ T4555]  vm_mmap_pgoff+0xd4/0x150
> [ T4555]  do_int80_emulation+0x88/0x140
> [ T4555]  asm_int80_emulation+0x1a/0x20

32-bit :)))

> [ T4555] RIP: 0023:0xf7fb9bc2
> [ T4555] Code: 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 66
> 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 2e 8d b4 26 00
> 00 00 00 2e 8d 74 26 00 8b 1c 24 c3 2e 8d b4 26
> [ T4555] RSP: 002b:000000000050fa9c EFLAGS: 00000256 ORIG_RAX: 00000000000000c0
> [ T4555] RAX: ffffffffffffffda RBX: 0000000001b90000 RCX: 000000000001e000
> [ T4555] RDX: 0000000000000000 RSI: 0000000000004032 RDI: 00000000ffffffff
> [ T4555] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ T4555] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ T4555] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ T4555]  </TASK>
> [ T4555] 00000000cba76266[9] should not have entry 00000000af00822b
> [ T4555] BUG at mas_validate_limits:7518 (1)

Off-by one so we're probably looking at something that we really shouldn't
be here.

It should still be within the slots range though, as on 32-bit we have 63
MAPLE_NODE_SLOTS, so we're not buffer overflowing anywhere, just got a bad
index.

[snip]

> [ T4555] 00000000cba76266[9] should not have piv 1744830463
> [ T4555] WARN at mas_validate_limits:7529 (1)

Same deal here I think.

[snip]

> [ T4555] MAS: tree=00000000cda835e1 enode=000000002cb71521
> [ T4555] (ma_active)
> [ T4555] Store Type:
> [ T4555] invalid store type
> [ T4555] [5/9] index=0 last=0

Again more indications of off-by-one...

[snip]

Investigation continues...

