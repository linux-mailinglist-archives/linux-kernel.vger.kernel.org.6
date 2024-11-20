Return-Path: <linux-kernel+bounces-416198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43FC9D41F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2991F214E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395A1BC9E5;
	Wed, 20 Nov 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dW2NvuvS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ewD8xL0q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712B1AB6F7;
	Wed, 20 Nov 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126483; cv=fail; b=inJbGsHYz5c0jFrPu+fsNWBXdfQjiY+pHSXbCQSH4Xb5F9gxOhaKPv2ENXQVnwCC057nqeAQondWN4XvQ54IiTn85jL6e2EVKhE3LA5GcPBV+PA6ckufGYjXvR0rhS4ZoLKox+z+enVwk7qAVEB8Tmu97fUPmqBRtDxNnwsQpyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126483; c=relaxed/simple;
	bh=9hAu+6CfL4nei7qrgE4n5HhogAyeI+h8AGjtya1QmmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WtindXc6h7ejlWX+J4B/ETvN9pSMCuRmfRO1pHufGW030sDMn4vHazxIWS5sVzwcaMw72o30+1K0bF+kDnoLnle4sNcjoY76L/VVjVjZYivIC7kZO2uM7so8+skNGBL9KmQzx/R5CzaHQ32pREDqkcqEtQ76qWLK+Xy0ZjmzDQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dW2NvuvS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ewD8xL0q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtglk012693;
	Wed, 20 Nov 2024 18:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4yF+rJsaFM+1mqWrp9
	x/1wVYJPgotqzS9+yiILXzjfI=; b=dW2NvuvSu0fmhMiPyKr2OIT2Vir81LXs50
	NTNDiygcxcyqe6uml+HbQw/sVZhc5bljN1YVAgBE+7zMaER1pv0oDvcduXd+oTkP
	o7GtcpxDs5QQgTk2NcnTq7tJE8GFY7hsaX3tRoOBgQkzuTV3g07Da0sz3fHVTwAR
	KsOSL1HwIKHJaT2QeoXu9+n1kfU5xuKjfshpqJ1tQwkPAgdVILS6q6s9+ZhKiMCB
	7ImHM+yhMmHpiUSfd+HnSEuBXSdejULGwFfWS14FxyHdBvLz6oly0UqmlB0uypXH
	doWjS6T/MY8/wcFoLKa2mw45DpPKOqv44wtro8a59x1Yu3zQSODw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sr0ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 18:13:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKGZP3E039235;
	Wed, 20 Nov 2024 18:13:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuademq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 18:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIjKFtz3ksV1irJfsAzdBXwT2XDXiN9zkxvlkSLRdR8KSS52YqPPc7ffIq55SdZYkflAolK8vXe3pz5jD2ivdlVXq1z75iob0mGfz5dU0C6kLWI4Kg6SBbLpkLegQgIQjhWPoozNDvu4hv7Bt0zHgbobLneyzX5rgt9cwIykbt7lVjaE8wV6mLGr1OoVD1mUqlPU0KrRB+oP/5QCrRrtOMOLul0/LGECWFVtg1JLEEpwwk2ukqGlyjVXIQOSgVqS5pjHKyRPd5H0zk7L1hqZDwjxnly881LxDRnF+fm6hBs5Cdm4IXDX/8Vtwhe+4LY1gSbvnWBZdWLXzoaXPHH+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yF+rJsaFM+1mqWrp9x/1wVYJPgotqzS9+yiILXzjfI=;
 b=kKN2Va+HVD2bt5HMrqp+R8aYpyB+66kzXaoRllUmP1lw5ceLBgFf6bLP4RnjagLAWLeMUlQ7toMllbHEu+wgFaW3+6l1o0La5Dz+5AMcwIX4oBApnt5EGDZwBwzNoCUxqgwbh6Sl6URs63uwd7xjuFx2PMvsHYVdHGhCGE1FOwwWgd9K1ZpuOykPTj+HEKb1CvKuMqM5M9IJDVsu3XtjVsIUeQ3/YXhjg3f+6Z9WmETZ8CEx9NH10nhU6CZldWQkqndDevZDgEEag30qHrA3PPjHQ2qz/s9y7vvkcrPZpYRrDAAL9VvbA//W/f4BHSSAKR1iP/bkkMNTNuwHI9TKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yF+rJsaFM+1mqWrp9x/1wVYJPgotqzS9+yiILXzjfI=;
 b=ewD8xL0q6nWMgsCZgSJt19gGRDjazMTCmJ374dCIKPasvDHioKoya1v8rP9Pqku1XMJuh9jCUM8R4mn41N1brBvjGbcMLNoV2NU3t4PzCAzGanAzJhfMVCm25cCn7RTjU/prQJ6ca/6xeC07TZlRlyZz+rLgcr9JE8NaP7oDkpM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 18:13:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 18:13:36 +0000
Date: Wed, 20 Nov 2024 18:13:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
Message-ID: <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-1-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-1-eb31425da66b@google.com>
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b30a91-b14d-4c13-f4ca-08dd098f0d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FW/XTANpY65rFlHr8hrwmWThW1+lcD9DKLkZgZvuX6PRtMsg3DdF6N2McaP/?=
 =?us-ascii?Q?VxNjy2tMPvOvP56cHuhojuzR6ibu6lTLTIlyGgcLI0geob1bzq0JTE7d2qK8?=
 =?us-ascii?Q?tKAUzwc2usSwPOwNOlq80eIHmsQNQ5P0SwWhz1odj0O6sBapuGbFUsigjDtU?=
 =?us-ascii?Q?LpcWcjQmnK6JPjnc744CYVUf2L/cCPIkP7wctDlsIFyhgn8nsxK3xQVqZSE8?=
 =?us-ascii?Q?u0QDrypHMoZz7Yn2o8jr4i1pJR/6zXdf/tEfwmJLmF5zBFhaaRyTheAgfQB9?=
 =?us-ascii?Q?Sne7NIxxNqTY6VsNDjmwOyJd0WXm8Wro2TNx1Ec23iQw1B6BXgxDWZ8vNHxS?=
 =?us-ascii?Q?LYiT2dg5D5mu6QTJMVNr9z8LGueo1/S4JEiGowagLmstyYHf1u4z5fqLtf5Z?=
 =?us-ascii?Q?flW6k6pBxIZ/keHoLwwI6GTmZ+z/Ps/r/S8kNG/uLKQ4lg0N83tkWy4+cO0B?=
 =?us-ascii?Q?tz+V+gKfD8zfULEKIIZRRHjVGQnjySH3a4G3gLHMjRQK8ojGrFus8MJdDTG0?=
 =?us-ascii?Q?SBACVh3XhIF+aiAajLSsM0LmVcxXP+Zo4v1PoFsdMeaNK+tBZJAHzkPwy01e?=
 =?us-ascii?Q?1eZX31LHNVlj4LjA8c+MA9+jgQnHnEsZjc2PwCR9QiijjRXwBMBBHC1kTuSR?=
 =?us-ascii?Q?EVkX2QjOoXy9ZOr5ir8H2KF++Ctr9fNFXIiIFAaRZwFu1W9nOZv8kQOUZ775?=
 =?us-ascii?Q?UJ5WzndVvmj7Oi+XOC8tMjbUCzzo2lgREi/OV6hIzPUY1UIlin5uljwA7+4x?=
 =?us-ascii?Q?LG2FkqRgzKDZcbXjr/Bouo9XMTKT+ksItb4i/O+0+aBOMTWzvbMZPYXmQROw?=
 =?us-ascii?Q?/dZcLybDZF5APDb+QfLid9k9F+sXrsm0P+AIV3daCR988XiPzYyZo/QlDMby?=
 =?us-ascii?Q?+KGgvAuCadC325wMFcApt7WWc3EOECvijcRI87kCW5qLsUVrPgfG6Ud55wrt?=
 =?us-ascii?Q?ygjV8qMjfnSGY5NsxqZWoHtiZXxKjJe0D7pKGP330q6gNZLT2Ziz95oNEZVy?=
 =?us-ascii?Q?JNAXHe/ceT/nMOCt/GPOqJY4NNhHOkhD0EIkIFqpV3pJRf4+DcM93DAWamZ7?=
 =?us-ascii?Q?7Du0NdMzL4tv9rYROdFrbWZf+g1AHmN7TfFxnjGkGfYenC1hxMxIYjOHCys6?=
 =?us-ascii?Q?91tRghAbMgzjvzQs7Ptjr9rGJplGHat52G975ZVtw6BTmck4z1xOqzfFZcMy?=
 =?us-ascii?Q?9PdA8jIYxNvS3FdkY5tCAbs6OJci1u4x+8430D1QR0EYDntpwLYIbHXUl7PN?=
 =?us-ascii?Q?RFrT3L8GCUpb9Ytj/lkyweEEFu+c0swwyGCfA9NCp/7r36jXAflwxVBSblIl?=
 =?us-ascii?Q?VOVmBfrUlXQlXpBTMnb9URv1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCUhhI7+aOuoVtRpoRKijOk6cdCRNdIrSKOVaHlqQP5KD2LZaPkUnuag+rEV?=
 =?us-ascii?Q?vVo68t6Ek1v+mccmjQTfJfz1fjUiN9r8+Y5WKlD/XQnF/RWBZk61p/t+gNuw?=
 =?us-ascii?Q?9i9HA6CdlVYeMPKetSeMdaLAQPQQc8+EF5l3rjU0oEwXrQFqlcUkscMjJAAN?=
 =?us-ascii?Q?OyxYkhrlAqtI/epaJ6aL+uB3ZbTx/zG9H7eqNX+FbvVqkGp3fnRJtbcWoQj1?=
 =?us-ascii?Q?cWNkX4sqBrxUgC40p6VZBFksmrz7n9ZGbUAx/6zZPAnWboha+lfs+chQNZPf?=
 =?us-ascii?Q?ps3IpgoLbyRh5LBfypIM2Z92uehLIgFir9KWn7RMjOJp8cyOIeNSb+OO4JfI?=
 =?us-ascii?Q?uallStgvJdeyj6NK0Zjat57Lo3IWjdHXnZpFtOo/91Q0ayU224fPhJpEunH1?=
 =?us-ascii?Q?9sOgKBP/yCf1ZdwLIQfPWtrzIEWkxU4itXjOEhCeWTMuPz57NZmNg8aaTqZn?=
 =?us-ascii?Q?KOICwdSrhOHBhcFmqY0zuZtMnFTUxoxB4FRHHgwDgDTeZR1QAtB2i+GVS61k?=
 =?us-ascii?Q?DdVADtMXU683FD/ZmgyVDuj+JGmGAUFoLOEva9qA0RfIRTXLOWsLI5yAFxpX?=
 =?us-ascii?Q?GBnJsa65K7uw3ImXS1iB9X6rYTMq0Zykr2ZS1zm+D9iqdAdwUvQ2SVlt4rdP?=
 =?us-ascii?Q?jVMHYApbzlk5km07DqIR2HkQmzSNUykwhpeSkdtqneuK+X3tqpRhk2WEqxeH?=
 =?us-ascii?Q?O7T58CslHrBudpXr5VclGycgF1CFaPAE1FYJQEoVA/k8ZM8gdtGa/fB0jao6?=
 =?us-ascii?Q?Bcv+n7zQ6OC97ftsQyycZ2Sdj7SFvtPu5/+92x3a/DXchhC29CPoWI4rfzcl?=
 =?us-ascii?Q?r7fo8ockfXLK4MWbEtmDyXCFvtN6vsRCoAtLFUZZPYbbBdwhachE+vhdgS/g?=
 =?us-ascii?Q?eAYlA/HtNP12ymIMAMF5FTjMR1m1AQUlooJzg7vhbTFkoP/nfpNhq3cgMn5R?=
 =?us-ascii?Q?YSLiYFRXkxjAv3KP6jEInEqnXjif5xDLyDBha5pv/UoWwOY7HrL3PeqzIhAu?=
 =?us-ascii?Q?APnkt+ZW23xIn0uY/H9h/4bSImvS0nz4rEKHerqIGbm18+Iav3cC5RbhRxYC?=
 =?us-ascii?Q?pRQaH6NUFeZVtoqMRZrWDa46lidbobq9P9ztI7YsuVFlIVeYRM08ubbfNXnI?=
 =?us-ascii?Q?rqO/QKcWIeZFaOGiFTGJNj18FOW0Fj0Te0RkYElWuNgqYReIRWqRy97oassg?=
 =?us-ascii?Q?ATwH949yNE1RWt5JMW8FniArbTA4TlFMiemEe+BmPTHCoqXrF/OA7/uRqhTZ?=
 =?us-ascii?Q?ZLQLEYWn3uuyfq0D5NMdWKiGuQyLXYo1iyQqTGDZksdnunNkisJh/gvwPsBB?=
 =?us-ascii?Q?3MtdqKLsky6h5/GAqw7wFuPABJ8IUcLHtwGa4TjlJ6MRzQIlC/JsCuJqfnVP?=
 =?us-ascii?Q?fe+ZC3rupxtBuE+pX2Hcv4ASs4/rzMk6HlbMNeE2OyQ2vEwgM8OQRjovwRGe?=
 =?us-ascii?Q?EsNxRgzRsjLkT8HZ0Q61z3gswhG2bRBB9s61UzCAqtY/QDtvnzJqwqmlcUGE?=
 =?us-ascii?Q?mXzfdj7D9KOFzbTvNhlobsOvN4dbwhCMCyN6BIn+ZwFihiB6TPKwyN3AwTwO?=
 =?us-ascii?Q?QqX4uD1eisG+zJgkGDiHtwBZ9MOxfyNKsPGkKmfompj4SdTAbng3WrDp5m/P?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+js85m6v63FlUnhk7ZwcNyYywHH3ofKLKw8js/F1ctOipN9Sl3y1PMSJcruPLgTRqqHFRfs1NEbLHNNQPtG7NorETp9bfh/HB7/eOFqMXLbkdwlBKegD/Qe2VgRgHZj0/VtTvXV7zUPYI4zFJ9rLpA0h/ZmU77PaX8BtK/lxEH0PqCsRdvz/L8qOdzGfmmynRxDWBA1i/T9/OFdLQYir7lC5Ae/Nmc+UiRrl9Yxi7MlQVMfMMHvby/5hR5lDyEnhq+Zt+t4yiSyPxO+LDWI9hFxqrVFrg9Q6N4tdAHym6CK+18Mqm6YK7/7IY6f6LZSeizhfUJ8emNsZvb+JJ+4jGoOGqD7Sw9DRvoi+ePisblsu7+jEskIMRls2hQQOm6KHyBenfibQFqymXWG7Ti4Di+rSPxaFJZGS0SyAnHY/tn00/iI97nQOBgcAviC6AhyqisyJyCRaxbefSRsqsRANGkjwGWCGIIUuqlRWo/oe7bgEBIa74oyvlR2RYbTE2aYDRHaOOKNx4XvsDHPFa/RS3PK7X4DMDfISlicr2F7UNtHk28qQQvEZdiO9UCLyfnoNiGlUF9bQWjuvj5XPbYWJ1dMiM0i95D42oVheObv+cB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b30a91-b14d-4c13-f4ca-08dd098f0d1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:13:36.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTopZm6BxY2oH/AcTQcs5656wYLnQcqQ3LPNSAWJIDoiP4UNjgFlg4NpQhFn2c+x5e0rRZUhVhMuRfw64pILZ8u60GhgOHhmI+z8y0aJ8H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_14,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200125
X-Proofpoint-ORIG-GUID: braZbWMt33oMHKfZoTUVHFOPrHPU9j76
X-Proofpoint-GUID: braZbWMt33oMHKfZoTUVHFOPrHPU9j76

On Wed, Nov 20, 2024 at 02:49:55PM +0000, Alice Ryhl wrote:
> These abstractions allow you to reference a `struct mm_struct` using
> both mmgrab and mmget refcounts. This is done using two Rust types:
>
> * Mm - represents an mm_struct where you don't know anything about the
>   value of mm_users.
> * MmWithUser - represents an mm_struct where you know at compile time
>   that mm_users is non-zero.
>
> This allows us to encode in the type system whether a method requires
> that mm_users is non-zero or not. For instance, you can always call
> `mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
> non-zero.

It's kind of interesting to represent these things this way, I like the
self-documenting element of that.

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

So obviously I'm not a rust person (yet... yet :) so from my side I can
only look at things from an mm perspective conceptually. To avoid boring
everyone I won't repeat this and instead you can take it as read.

I will obviously inevitably ask a TON of questions as a result of not being
a rust person so, bear with me...

> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/mm.c      |  39 +++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 260 insertions(+)
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 20a0c69d5cc7..60a488eb4efe 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "err.c"
>  #include "kunit.c"
> +#include "mm.c"
>  #include "mutex.c"
>  #include "page.c"
>  #include "rbtree.c"
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> new file mode 100644
> index 000000000000..7201747a5d31
> --- /dev/null
> +++ b/rust/helpers/mm.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +
> +void rust_helper_mmgrab(struct mm_struct *mm)
> +{
> +	mmgrab(mm);
> +}
> +
> +void rust_helper_mmdrop(struct mm_struct *mm)
> +{
> +	mmdrop(mm);
> +}
> +
> +void rust_helper_mmget(struct mm_struct *mm)
> +{
> +	mmget(mm);
> +}
> +
> +bool rust_helper_mmget_not_zero(struct mm_struct *mm)
> +{
> +	return mmget_not_zero(mm);
> +}
> +
> +void rust_helper_mmap_read_lock(struct mm_struct *mm)
> +{
> +	mmap_read_lock(mm);
> +}
> +
> +bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
> +{
> +	return mmap_read_trylock(mm);
> +}
> +
> +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> +{
> +	mmap_read_unlock(mm);
> +}

I guess at this point we're only interested in reading?

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 66f5cde7f322..cc1963510cdf 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@
>  pub mod kunit;
>  pub mod list;
>  pub mod miscdevice;
> +pub mod mm;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..84cba581edaa
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +};
> +use core::{ops::Deref, ptr::NonNull};
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> +/// [`mmget_not_zero`] to be able to access the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmgrab`.
> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +#[repr(transparent)]
> +pub struct Mm {
> +    mm: Opaque<bindings::mm_struct>,
> +}

Does this tie this type to the C struct mm_struct type?

Does 'Opaque' mean it is a pointer to a type which is 'opaque' in the sense
that rust can't see into its internals?

> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
> +unsafe impl Send for Mm {}
> +// SAFETY: All methods on `Mm` can be called in parallel from several threads.
> +unsafe impl Sync for Mm {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Mm {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmgrab(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> +    }
> +}

Under what circumstances would these be taken? Same question for MmWthUser.

> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> +/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
> +/// refcount. It can be used to access the associated address space.
> +///
> +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUser {
> +    mm: Mm,
> +}

Why does Mm have this as a Opaque<bindings::mm_struct> and this sort of
nests it?

Does this somehow amount to the same thing, or would you probably never
actually reference this mm field?

> +
> +// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUser {}
> +// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUser {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUser {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> +    }

Hm, why is it we mmget(self.as_raw()) but mmput(obj.cast().as_ptr())?

Also I guess relatedly, why does one refer to &self and the other as a
NonNull<Self>?

I'm guessing as a non-rust person a 'reference' is like a C++ reference in
the sense that (well it is _assumed_ in C++ anyway) it acts like a pointer
for the type which should never not be there, but we need .as_raw() to get
the raw C pointer?

And I guess in the dec_ref() case we need the .cast().as_ptr() because obj
'boxes' around self (I guess equivalent to 'this' in C++ kinda)
guaranteeing that it can provide non-null pointer to the current object?

> +}
> +
> +// Make all `Mm` methods available on `MmWithUser`.
> +impl Deref for MmWithUser {
> +    type Target = Mm;
> +
> +    #[inline]
> +    fn deref(&self) -> &Mm {
> +        &self.mm
> +    }
> +}

I rubber ducked myself a bit on this, so I guess this makes it possible to
dereference the object, and it

> +
> +// These methods are safe to call even if `mm_users` is zero.
> +impl Mm {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> +        // SAFETY: It's safe to get the `mm` field from current.
> +        let mm = unsafe {
> +            let current = bindings::get_current();
> +            (*current).mm
> +        };

I don't see an equivalent means of obtaining mm from current for
MmWithUser, is that intentional, would there be another means of obtaining
an mm? (perhaps via vma->vm_mm I guess?)

An aside -->

If we're grabbing from current, and this is non-NULL (i.e. not a kernel
thread), this is kinda MmWithUser to _start out_ with, but I guess if
you're grabbing the current one you might not expect it.

I guess one thing I want to point out (maybe here is wrong place) is that
the usual way of interacting with current->mm is that we do _not_ increment
mm->mm_count, mm->mm_users or any refernce count, as while we are in the
kernel portion of the task, we are guaranteed the mm and the backing
virtual address space will stick around.

With reference to MmWithUser, in fact, if you look up users of
mmget()/mmput() it is pretty rare to do that.

So ideally we'd avoid doing this if we could (though having the semantics
of grabbing a reference if we were to copy the object somehow again or hold
its state or something would be nice).

I guess this might actually be tricky in rust, because we'd probably need
to somehow express the current task's lifetime and tie this to that
and... yeah.

<-- aside


> +
> +        if mm.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> +        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> +        // duration of this function, and `current->mm` will stay valid for that long.
> +        let mm = unsafe { Mm::from_raw(mm) };

Hm does mm now reference something with a different type, as in before it
was a 'raw' pointer or such, and now it's a reference to an Mm right?

Also I guess the 'duration of this function' is because we put this in the
'Aref' smart pointer which kinda takes over the lifetime of the reference
by wrapping it right?

I mean I'm not a rust person so actually I have no business _commenting_ on
this :P as this may very well be idiomatic rust, but I'm just curious about
this.

It's nitty but I feel like maybe we're somewhat overloading 'mm's here a
bit though? As we have our wrapped Mm type and then an internal raw mm
type. On the other hand, it's hard to now have horribly awkward and
confusing naming here I guess, and perhaps this is fine.

Not a big deal though!

> +
> +        // This increments the refcount using `mmgrab`.
> +        Some(ARef::from(mm))

So I get that Some() means this is like a discriminated union or such,
where we can return None (as above) or Some, which contains the value is of
type ARef<Mm>. And I guess this moves the 'lifetime' of mm which was
previously with the function into that of the ARef<>?

Does the ARef<> 'just know' to use the AlwaysRefCounted methods?

> +    }
> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }

I guess this .get() method is on the Opaque<> object and returns a raw ptr?

> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {

I'm guessing this funny 'a syntax, based on the comment, refers to the
lifetime of the object?

> +        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
> +        // repr(transparent).

God I love these SAFETY comments (I mean actually, sorry I realise it's
almost impossible to convey 'not sarcastically, actually' in text form
:). Is that something that gets parsed somewhere, or a convention or?

I like that there is a discipline of expressing under what circumstances we
are permitted to reference things.

> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> +    #[inline]
> +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {

I actually kinda love that this takes an mm and guarantees that you get an
MmWithUser out of it which is implied by the fact this succeeds.

However as to the point above, I'm concerned that this might be seen as
'the way' to access an mm, i.e. mm.mmgrab_current().mmget_not_zero() or
something.

Whereas, the usual way of referencing current->mm is to not increment any
reference counts at all (assuming what you are doing resides in the same
lifetime as the task).

Obviously if you step outside of that lifetime, then you _do_ have to pin
the mm (nearly always you want to grab rather than get though in that
circumstance).

> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
> +
> +        if success {
> +            // SAFETY: We just created an `mmget` refcount.
> +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })

When you do this, does it cause the reference count to increment, or does
it assume it's already at 1?

> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +// These methods require `mm_users` to be non-zero.
> +impl MmWithUser {
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that `mm_users` remains
> +    /// non-zero for the duration of the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
> +        // to repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }

I guess this is another means by which you can get the mm. I'd say an
equivalent for getting from current is highly relevant.

> +
> +    /// Lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the read lock.
> +        MmapReadGuard {
> +            mm: self,
> +            _nts: NotThreadSafe,

I'm sure this is a rusty thing, but curious as to why this is like that?
What is '_nts', etc.?

> +        }
> +    }
> +
> +    /// Try to lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
> +
> +        if success {
> +            // INVARIANT: We just acquired the read lock.
> +            Some(MmapReadGuard {
> +                mm: self,
> +                _nts: NotThreadSafe,
> +            })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A guard for the mmap read lock.
> +///
> +/// # Invariants
> +///
> +/// This `MmapReadGuard` guard owns the mmap read lock.
> +pub struct MmapReadGuard<'a> {
> +    mm: &'a MmWithUser,
> +    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
> +    _nts: NotThreadSafe,
> +}
> +
> +impl Drop for MmapReadGuard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the read lock by the type invariants.
> +        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
> +    }
> +}

Ah that's nice, an actual guard for it :) I'm guessing the fact this
implements the guard implies that you _must_ hold the lock first right?

>
> --
> 2.47.0.371.ga323438b13-goog
>

Sorry for the numerous questions, I'm afraid there'll be a lot of this for
rust stuff for the time being. Perhaps advent of code will help improve
things on the rust front for me ;)

