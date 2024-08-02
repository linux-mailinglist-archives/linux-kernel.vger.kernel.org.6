Return-Path: <linux-kernel+bounces-272169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176A945812
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329531C22279
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F793BBE1;
	Fri,  2 Aug 2024 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nmheYamj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fj4Y+b8f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F29134B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722580424; cv=fail; b=In0NhbwI5Ji5Lwq/ZghxZ0U6BF9AK8axCE0SAqWq4chuLhzHheSyn34GCHbPFo1vHWSM52/AQpbEOy5/FPgYDZqw6K9Ictk2d2F3qBsT8R8BRdrjjHBl2IRjsAzTR9iRTyRj3ql7SNbCwiTBfotG0+GfOtJFP1YxHG+3hhfmrtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722580424; c=relaxed/simple;
	bh=tRJeEzBbN/nzzYE53eUJ0anR4b68fVzLW4VbiHML9kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcQNO4yjjTJ9KLezqYy3rnt9bQNtYYva+znnM5lnHP4QfmSxnzzmfv93fYn4TiN0LBu97ik93c6NQWH+Lxb0Vjk5/Nttdz83n6C/Ffelyr8V28fFTyE7BBAZ0HnFaTSVXfy8KguOXMcEMgBuJWMGr2TKfLHTODYPcqHWcUeNzZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nmheYamj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fj4Y+b8f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723gGMf015698;
	Fri, 2 Aug 2024 06:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=VvRRxul4n/Ee6Y8
	rTn5cxEe8OsPT6iIw8VHVlZiukgI=; b=nmheYamjQTgjODwW3WSj8Apu7TEXqdd
	8BkCGZDCsUu9d5wIizC3SOjx2wANY+OLJzc1WtL1q4tdAKHQI7MZPkdTIjCD9fAL
	up33wOQNIX8sycChmNdH5p7VcWwMeGD4nSfu9PajPHP69b6+Ir+cHyYDzV+MG1YI
	RSgOpwrmYww65LgOPrltncaWjVmpBUJCZkAq+JpoHmuzxA2hACrcaT/3cBHd1siS
	M6HU9AJ7kfPEliLHsEw8/5sl1o+1LGRJIsFJhKgs5RadA/fhNvJEM81e3eJgzXCL
	C9vmX+riCaCCfcTgjhlK3XpCm1ZOSyu7WNO4GscmBFWcERuvANw3gdw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjg30gsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:33:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472610Fe019062;
	Fri, 2 Aug 2024 06:33:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qjmum5y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMyOYYc7KwXtpfnMFEvsU3WJ86MJHrRvseXetaqOhjWe/btEsuP+GK31KgDAe5mRssQneEzOZE+2PmvM4Yr6YoMyV0S4KFXdusgx87lvXwSAy7ituu18cSDXiHEGxYhnPO3YyND1MTCP7NSCWAQNMNT44N25oLvN5AZ/VbhpJcj02ZEqbRyLmAUam9TtJW/wSvtt/4xgK8hhLU5021tx2ftg005ogQCG8IQ6QNiH0oocMLwk1BS7HWHNex5rH9eh+Q1DiuGP7/UYrdCAmeLF6J5DhTspSMEO6YSCfzRJPrUbEstwfDya/fuDF6JVE8AZkFuOICC2aoEOdcP/x/+9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvRRxul4n/Ee6Y8rTn5cxEe8OsPT6iIw8VHVlZiukgI=;
 b=i0dETXot+nW13uXwrhSW/beOvJ3ufm6JAChGQEPMrHhdMELUr6cO89Z/F2jRskw5pReuFKvfGYaisueOV8WKHJyr3PqLphlK2gLdF7HjEgwD/ksElcicSu7wtqoggjb0zB9mCl3SoOCRITKUBwuRa1BAPMFWNeGhLPWIfBlHVcn+qDsOyPUIxH1g4zj90PDxtQSkxIbE37IaDaFCpCRke+eWG0D2GlwP7H0wLKsXR9/Yqd4vSNyFPXEhIaFfhiG9LrIASPycZhCL8/CDaE/LLwzIDpaU1Pbqf8EHHE4NKfcnBtsaEfye4KyE/x6Is+s3R5eKRINVS1oiRNOg1bAZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvRRxul4n/Ee6Y8rTn5cxEe8OsPT6iIw8VHVlZiukgI=;
 b=fj4Y+b8fb7xLSHaErtDDQOSyN2fz5iB9C6WuY9jeZ9+17AvOse4raAN/PHdXw33AKMgCgr6LyJLutuONB5UNOkyv5NxARRw90C8jx6v5jfwM/6xQrGLLS2IA1uAFDF9epNBZVf2qK7tyXRBHy5oS+e34D/hFV5Tnr16O+iz/lec=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB6350.namprd10.prod.outlook.com (2603:10b6:a03:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 06:33:28 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 06:33:28 +0000
Date: Fri, 2 Aug 2024 07:33:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] mm: Remove duplicated include in vma_internal.h
Message-ID: <7e38b7d0-cde3-4767-8775-52808abbdaa8@lucifer.local>
References: <20240802060216.24591-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802060216.24591-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: LO4P123CA0141.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cbf8ae-00f7-4112-2536-08dcb2bd0523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6jZ9KwrJzQKFUC3IBpZ1GxQFnDI+DrIo/9YElbFw8As3yuobNYAzS/GJ8h/o?=
 =?us-ascii?Q?if6INO/BQaL7pR93Gx35xNZ3tHiA4xSlyQ2mRGUe+zH9t+aM7QMz8ntjZVR+?=
 =?us-ascii?Q?UiXgN+2hY86aXu+EW3xVu6CBXblf0iAjq6iDqsS8JC1vc8+YbnRbJbdkMa38?=
 =?us-ascii?Q?ISN9/5oePvaYqVtrLjQ7mdeVQ3+YFGJ5iIPDa5VSSGl2mT71NsVnm7AGJdoL?=
 =?us-ascii?Q?ZZ9RdNvtL6OHcGobtaS/CjVb0/nMLLMSLiuRd6PwwpI6ElU1gCud7s8nyVVz?=
 =?us-ascii?Q?s4uEcRzgq70Kux0+LUxEPiQapx1+sHRe8HnukMbLKWltinzOVcOin+bcTkWi?=
 =?us-ascii?Q?GSdKTwNftcbAIMIHBWW2cnbLEmVeckA8y0rb7gDeQQNbo0qx0MFCuZJRLdIf?=
 =?us-ascii?Q?4zjxEdPc/OuMFPwQ6BRt+i5aNhKXXj8tJn5Qalp0lxM0no/em5Uygh8AKFji?=
 =?us-ascii?Q?AJjQmhqZ7wDw7kNySRxoOWYaFznDA2zqtUGW9qhOx+VpRpN1jkM6U5Jwg0Y2?=
 =?us-ascii?Q?GRIBr9+wbPQoDz8Y7XVCIQyraKOZqDQty760E1crxtnBH6aVni6//8vIiuSD?=
 =?us-ascii?Q?JZTfOb9PNytZ5gr5gz+2qiReeRVqmMpGyFbeDYDbebyauyKk4LL8deHimHxx?=
 =?us-ascii?Q?zquZXd9Xr1T9iWDRd4IVsF77sw1vnFAPXtzlJROn71LNwEi5O8GXWqlWIOm1?=
 =?us-ascii?Q?XCYsLgTTRi70uj6X9xrys3ybJk6hdJavT6QCqboYWQQ4l+oUU7LKkchgl5P4?=
 =?us-ascii?Q?g4/Se8bexHbz36//Nby6isIUM8Y62No6MSvvjxx35sp2RREDr4ITlSsmj2Ge?=
 =?us-ascii?Q?YGHEMyEIHrJMOcwlRVXfT0BLU65D5TdWzAA8YR+RFIr1DAFb671vtGlnfrDH?=
 =?us-ascii?Q?hRKEzT49pq57z/finoLxMAVupvHwAIl6tTG/u09ZdIRPTuSKBI54GqzqzLKd?=
 =?us-ascii?Q?kxEpYq2tPqJdIfEWUTNCSapD9/O4DZe/26/b4lwTZRRiQs7y4zGL5Rk2FW89?=
 =?us-ascii?Q?ogJkfaNeNiSJnP+BP9Cj2FpZNcgG5FNuQA6OhBydC8KubrdOmrO3r1eAy6KN?=
 =?us-ascii?Q?USp6MSU9aAMx0VmxyE3l7Gi7LepI1H1cAHsyj4L5NKyscxs5taxCb1hWH9rC?=
 =?us-ascii?Q?F2laFcMqwOFhVMUgwqBVOK8OnrprpIhwqNZvyLk2Xbvl95Eindq1HvnZvw2T?=
 =?us-ascii?Q?ccRM+V9eZoRvdfhUu7JlIF1BOsETDC7NoWlQJI/qMYwQAe+eN6SfVW/iGTaK?=
 =?us-ascii?Q?pQuI+rhq7Esx48hx9JoU4SOrf3OI/HBCjj/HAf2EGC1j6YBESchoT00+MsLl?=
 =?us-ascii?Q?xjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HP93KXzldZMa3HWoSupGbRtFFhoMHBNZnNrwpFNO+Bc4c8wL5zT46csBet4X?=
 =?us-ascii?Q?MNAPciFeJ/+r4p8IDnasb/AHdJjvV/CTL3BQ5yaunk2/zAfcuPCYx/Exr6Om?=
 =?us-ascii?Q?SHgkXNhKTtnJWGtLCqUmwn4PNCHkYFnddJcVoU35a6iMWYTKAkMJqFM/Rvx/?=
 =?us-ascii?Q?MJCyabAPlGOrt0SiW9YbCzui0JHMj2N7nUNV2LEbP1l8NdnSVFDI0wnyVhB3?=
 =?us-ascii?Q?fmHYnGnlcwhCDZjtpIja+eXs2d/YzDZ97WdIKY14G5LE7DDJfwAR1BQi0jqU?=
 =?us-ascii?Q?7YecDX82le4w+hETxfOtvTWb9gCQlaoLivbQg124gUgzX4G2NY0bkSDxHsXT?=
 =?us-ascii?Q?MkL89Tm5hJVDEy/i1RFvDgut9UQkeIWgBFlSBnvnUyI/TEuZd9HnlQNdVsrt?=
 =?us-ascii?Q?XbalOG3KC9lguHg/fIE1TztFQf351Bz1M5QQEvDisy0wFb5yPTNvuEohjbwZ?=
 =?us-ascii?Q?j+0CJjIAGObZ0lmvC26PW6jhAlOF1531tiThAfbsVgdhtv8mIutnlsHzPA5y?=
 =?us-ascii?Q?TcXI4lDZXC1urTaB76m4HcYAfPyZdDPmvNCsDIw7RQ3CG7W4Tx+ob/NW92XM?=
 =?us-ascii?Q?mzf9S2r1XqpvUNQ6tG4gmKAsXUVi/Of5HV2B0G4evyjD1nLbz3+giftmUiRV?=
 =?us-ascii?Q?l5uJt1x0AOhK6Y1FgGt51H0TqSwEnudLIyKgJ+74mfDd8qHT08y68oZtWQ3+?=
 =?us-ascii?Q?DZVkI/Ov6xcoKkSW0h+ptlLLb/SofNIaSyh13m6lbqZSWTJGstlQerIg+4dN?=
 =?us-ascii?Q?N4eEMBK0XyDkW5NiYfu7DsD1BCi6G5sXDtgdU11C3t1TnJ5JL3JjC4WOHoQ+?=
 =?us-ascii?Q?yHrXnPnEXrDhO5HhrVzZE037T45I6oel6ZD98K+ep5rWetZ3XphuuhwEk0u5?=
 =?us-ascii?Q?hYpnnViYnwqXSY/I3GhIiA29Uq8MXi2qs4O0dtQYc7yYuox2d6v/727Lwe6i?=
 =?us-ascii?Q?QGTz79/5ZIkBQRVPOqayJAxNnhboxIToJT6W5i07GMTZ3xQBOtMpzJNZY/ad?=
 =?us-ascii?Q?C4jgrSN9m1fK7P79EriYxu2zmbelIeFxBHe+y8ufVje2n9diKjffzpkBlgki?=
 =?us-ascii?Q?Ihq3+/Ou7E51PlmUdTuDkRtrFUD+bUNi9MMyP3KoJChz9KUBPbl1oCr2Hi4q?=
 =?us-ascii?Q?6uB5Cu6fbe4HZ8Mlxmg7xu1S3J2PzwWo8PD7ts2jlQ93rj7E09N2A+ZjgbWQ?=
 =?us-ascii?Q?8AJzeryVAOR8cA3uX4B9hf4w695BMzVvylxN109/nC9VkKUMru9Kak1GlACc?=
 =?us-ascii?Q?uf7fT4dSrnJoaTNbvk4cVQLzFNnCVDPbFusPU51PTNJr/lmPmTE7XvPlQIj2?=
 =?us-ascii?Q?zYwKQf3YYVVdNLm/EyfpGUalybYErSOpps2G6mSejUT8/c49XnMpe/pMv07C?=
 =?us-ascii?Q?+jm8CacpU2unYLJp/0Fl9v3SaFw66TDTI7PNqPwEd65RlUswX7urapgzrL4J?=
 =?us-ascii?Q?1wGnAk3OJ2iDiezh+c2+7DHzT4rdKo5b19rhF6VzJSnyqKT15MaUkXHAzsWG?=
 =?us-ascii?Q?CpHvBAEW9/lo9vMsF0/vpk2nFeVuFaqefmFt9X+ViTqU2KMmZETzHfO9Kxis?=
 =?us-ascii?Q?IxqkQQacJHK8qQnjTJfk58DPH2PwAUWaa9zVM/8/pHD8NlRFqt5DkNgoWsQT?=
 =?us-ascii?Q?pSB10dOeGyBdgfF+HzsBjjdkNiB4C9tTmlJc4NWKBENr1Ygx++rqUY3zCnrU?=
 =?us-ascii?Q?UPk61Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WvZw1g4/j1Hm111CABNX1usZCLo0SHI1bln339dLCV8Vuzn4wLGZdmscVxTHowITO+kFzWvYeXQeg5VnBfh++dR+52XHXO1KRTdAplFWkvfnucPyyGJmZF9BlZba0H5EAsKkVHaOFdmoHraxQ/Nz0sSlP2XfpW3/+TaL3JkXH/rdHvZIX6QIqRdzvZZEHVjD5nHyrRRvSv//TEXIaTjNDxqrp3KaXZ6qU2w09OrQTpdIy4wO51ux7R4tV9YI/7DXbEDjPPHR4b3zvq5k44Tl0dNhKyhky5ihtAhPVUiG8XI2KWKN9vEO5TXJfHO5fc410hKnQ199hYHK2APKyYsiGtMlhcLmUL/T3dcDVIK6+CyRsc1Lh1rGGGwiQe1z/lk5meewE2hvNvA6UG/pi1sVtYSEDEn20HGH/5HCEwf/C3x4SsbsspNSJhJs/1CMgro78fF1aSB0cJXwpftMgey48MLEUQCe3FDYM5hslhNqXP39o/lHyOJSqh7/o+dPYitS9JD05su0Z5Oc9+TufNwObzuIhpBUYBP1bCyyFDzq8FXeQ3fNeW1pakSuFhIYflxP+yim98fNmEHMwwNeFzgvpQywrsMJqtjAg6N2b1eNSt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cbf8ae-00f7-4112-2536-08dcb2bd0523
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 06:33:28.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP1M7wjflHXzFrrnXGZmkIU07dZQlbgBq+HLMEdIaXbVKnm9rK/+KhvFJ5I+T3K2iMlUlViIYE2goROhNjezcjWbwgYodb+rQuQQj0OJQW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_03,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=774 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020044
X-Proofpoint-GUID: aQfCObpYRabobP5mhAehHHfnELVBixDC
X-Proofpoint-ORIG-GUID: aQfCObpYRabobP5mhAehHHfnELVBixDC

On Fri, Aug 02, 2024 at 02:02:16PM GMT, Yang Li wrote:
> The header files linux/bug.h is included twice in vma_internal.h,
> so one inclusion of each can be removed.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9636
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  mm/vma_internal.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> index 14c24d5cb582..b930ab12a587 100644
> --- a/mm/vma_internal.h
> +++ b/mm/vma_internal.h
> @@ -12,7 +12,6 @@
>  #include <linux/backing-dev.h>
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
> -#include <linux/bug.h>
>  #include <linux/cacheflush.h>
>  #include <linux/err.h>
>  #include <linux/file.h>
> --
> 2.32.0.3.g01195cf9f
>

Well that's embarrassing, oops :) let's take this in the -mm tree and
pretend it never happened ;)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

