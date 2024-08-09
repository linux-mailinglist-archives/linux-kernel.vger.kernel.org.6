Return-Path: <linux-kernel+bounces-281190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6694D429
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E971F22A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA01990A3;
	Fri,  9 Aug 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4mTBTwZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xelygY7w"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F51870
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219594; cv=fail; b=E1SJyA6c5ZYF2bQB0joig39vz5WjQlksawmx7HrbzIg6rgwsvDzG1APKXZKxFq3SnLn+gKmwlDAifGCX/q+AMsEGuxm9FIUD9XEpgAFzpUA+/nSAK+3EZj57DHnDfJca1+eQlsTKQ7quNc80BDV2FV1AFeXVwrHR3T+8463FsR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219594; c=relaxed/simple;
	bh=GT7tlDr04bzTHMLfDmWqlx1frlFKw36+9/1JPfZ7Z+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l+11wjm7sLPl/dJOskEd1Hv41F914WWGpjAvyog4fiCwyq8jjIcP6ojmBCJAsrKSDCaHX4g0vwWUA6BHYktHWSs0O+5W4nGLZogZCghpbrsUlm4oSVZsLFG6I4AqqnRhNkhPRy6AHjZomnPtkYJKM1zPaZ1eoHfI/zk8eRBDMrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z4mTBTwZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xelygY7w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMUNO005514;
	Fri, 9 Aug 2024 16:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=S79VaiLxdX1bWXb
	aVqyMo3hSQxb13kbSsJNSZh3kR7g=; b=Z4mTBTwZs6EwNWXid98gviZ6Wf3IT8e
	DBmSTh7aI/vE3IPwsjtJAJ7Xtx+O0x+FGLmeaXC9dcO4C31Aru0F9wkslJNQJ38c
	qlKWpUbye9HfnBEJwHUqLuR14qFDT6+Ck7iG8/r3Rgg+EhpAknZh+rrY2O/P+LT2
	aAZQoBQaKUuQRM5xdolDJ7V3/dsqBfi01K7cTYmwI6r4j8SghfvjIBrC+QCn6puM
	f6Geq9gxKc/ACv9AzbW8yN5hX7Pd8iD+WnCvb/zylrqmrakSsJAXTi/8X/c3c0Rj
	5yttuXMME2naCbOIQeKRUV4PMTDWfASj+1AlMrzvQKv6Tp4+WFT8Seg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcm903-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:06:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479E9Xnj021837;
	Fri, 9 Aug 2024 16:06:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0k2j2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXmUo/trum5y/uUESykEKX/+kvXGfIzxrZU+57pkvikHAxAjGUl6sZOd6zVU2DHUoKN1fK8awFJV/+iY8osAI/CRGARM1sWPOyLivq1ItrAAa1vcbmQWYju/QJ+vmqverHqzd+Un/K5eOIRDX1hbRHgcK4e+rvZ4YrlecShXr7UYNh1I07gVSbHr4PetPGXwCDMBtL0TNOvNHvsQnwi4R8pl3v/WbQ8csgCgEZB+huo/Exs/lMkd2oHxkgwDBgbU57rU+klDlkPj99F1zidSRMST62zfqdHmxkIfl+V48tSF4JPDdZO613L+ypQfMZGjEwb5N0prxaBtJslOKgOVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S79VaiLxdX1bWXbaVqyMo3hSQxb13kbSsJNSZh3kR7g=;
 b=R58m997vGgBwZX+nH++vPl8wfvE3WGDmoCqpgSHqMmXpflKB/fHSAxoCLYifgu2Qt4GqgJ6bs/hS/seDEPcyM5S+SCjZxV5srsicf9zhlfQejYoyeXVJ97w/Xf0hDkq3dDoiJ2tbT7fOFUlUgyA86u9ssxBZNSMzlFytLGtinpNgsGTMZ45qJS02v9WA7DcKG3uDcfy3lmACCeVLiLp9CfCX+jb8CkrsEdZF6PzbGgS6INoi//lGxX1Y7/r30zC+bTSC3zsTsCOWXziSs/5jv4Ix9pBbN6kCzgG4IUhFStOa/eBFt631je4396/7s9Q2glYcuZWp+edPAqf7OudTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S79VaiLxdX1bWXbaVqyMo3hSQxb13kbSsJNSZh3kR7g=;
 b=xelygY7wH3cOdAl2jKXO4DOD3YQI3mGKBWfgaf/1HwMrpszSc7m0d2569v5MOpkQG8OA4rWvRyOAmjK7V3o8phuA9IP0JCKWppaMvX45VeGrm4KTG8yGsNJYsq2cUyDPpaZQkB5DT7sGLS5Pg7gLNrsprHPnI33hMBYNDGPWfxk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 16:05:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 16:05:57 +0000
Date: Fri, 9 Aug 2024 12:05:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/6] mm/mremap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <52wapi4gdnh3i2oiyk44utrco4ck5zph5mikoejfjrlfz2pwhe@eyiaozi4q23x>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-5-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211309.2729719-5-pedro.falcato@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: c46e9428-d685-4c87-968e-08dcb88d27d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJvTdLfVK4SSgcbIUb30dRs580i+KawBhmsHRXURRWppc+f/1gihL6U+LemZ?=
 =?us-ascii?Q?pHU/JG4YQgSAVtsEFm/kIu8dHOpRjnMP2BIBKUKSUG6JkKwqA8nzXs73QapH?=
 =?us-ascii?Q?XA5BlcDF5JgQ9L7L6vwIogRnVczBJv21gHtAGLQh6ez2ImIdzqJ3xej6TJ1P?=
 =?us-ascii?Q?/HT8SvQW/SMxkrTkzHgOqBGaQpsU8226f3Mz6ol5S8NW+ylhlSrN2o2/Y7NZ?=
 =?us-ascii?Q?mZA6KesOdwsmdiJOaijxlTxEgxtmg9e6sCGDi6w6QYB7YUmMkDUcJc+M+W2A?=
 =?us-ascii?Q?diHcLnElL6LxnaxQ7pHDKBHvMmpsNtwyud1Ne21x1sH8+G1ZfZZDtFTjKECH?=
 =?us-ascii?Q?EmfyZ2qW0e5JSaRlVwBwb8BBgfgghcnvXn3APLjCQufbxczfo2rXWwThrvD4?=
 =?us-ascii?Q?n00655YJM/HSjbj0tbBXQYowBzQUDUSgyCGkg/YJ+y3UM2H5gxIsmF1IeWQ3?=
 =?us-ascii?Q?jqhUxc8ncm5pABEr3fI0iTvMX0nPOLKVRj8WPb7+XsDamLs3LlP/KErahBGB?=
 =?us-ascii?Q?6MsQNn9UyNlnZ7nPI+mjLUVH/gqZJYOXQtoyUplZEZJ37HwbYcw/bl3K8t4/?=
 =?us-ascii?Q?t9pdP8I+D7Z9SQG/A/F6/RrZp+M1RXjrsjBqsYXPcYSvcTcG3uMfJ+JZWKRA?=
 =?us-ascii?Q?ZXyY5fZR8dWUpX2pwm2I/JOSNXNZ/pgpq5ZmruQ0RSB5H2xIyUZ/Tc2NId3F?=
 =?us-ascii?Q?oeR0wPWtWDxNNAO4SUjqopWgx0lix/D0aQ0Ne4GEkkNf9nYYenK2cGFj/7Zk?=
 =?us-ascii?Q?WVOVVCwtu1hUVXHtqOaa4A8tvXPCqU7SPcVoMH39xRtHtpoMIMiEvVjW23c1?=
 =?us-ascii?Q?pf8YDHWjxX6MrlcBQqiYfFoJmBULk+lUNCMDjRZYhOxESflKXtuMriA8amZF?=
 =?us-ascii?Q?3OH0bKsKVS402ra8jutVK97Rv7K3bxxhI3GHAr78nikVEIBcrTFgxkkwOQqf?=
 =?us-ascii?Q?MGQCKylOkY7q77xMkiV/aaw7z2jLOyvx2bLBp+Klwo7XaQ5KNb8YORTBDwvu?=
 =?us-ascii?Q?TaFcV4AM3FEBXDzjEaUsk6wnzqhg9nmyWeqE5JoIw8M2/hXQCkEPjRfoTYmr?=
 =?us-ascii?Q?uHkXUwE94QhUxPYzelkG6hPpeow/TtI2SjZ36J/1LqodWJmBTeoKo66iGuHn?=
 =?us-ascii?Q?uZxdmy8baWeXTNK+ASgWxpW8kj10IdRI1J5EuN65PVFLfv/Y/TFvpQaH/hWE?=
 =?us-ascii?Q?kAPib+I2XzmiHjpIATWEzCVSkWDLHscjpsAI72Uzd4+H/Q291E49aHXbB3bn?=
 =?us-ascii?Q?fZkQLFntPgADfLJ/A7dWdz6ys8DXy5q88Fyl5c5sDZ7DpncTpjgwz1LaaYJw?=
 =?us-ascii?Q?WX6uVW5/mzOHD9fb+H4LEEK2kPLS5PiEXWek/FC+lr0tFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wEz6f6gkEzvazebAFUwIZ+W0t3JJTmP0I3wtlx2JVR92vLbwW+sAJIzPqoN?=
 =?us-ascii?Q?nSfCZnC6nLty+erIDG/BXfFLT5dBFCfEs1KjqLvWuJcXF0a/xg/9dP5CiWPx?=
 =?us-ascii?Q?wW3Zm8kbOrkMV6NxqfCMPRQOa4aPnz4i7PizBXVOrELU6v4gpl3yqFeR6YP8?=
 =?us-ascii?Q?ZZ8jJeHUhkN0WbqeXW6UiWnqwJxRlGu5W/2XPd+2otDtbRvJ4bzezx8PTncY?=
 =?us-ascii?Q?GWFyKrpsq+X3sCeD+qb8pYApoKAqjVR/iXc0YFj30MWY07rItu7jf8VIL16p?=
 =?us-ascii?Q?6oCj5y87HO3VvSPh07pu2ccj/elfL0nZrAyR9vJaGm/p8EsMhCVl9mBwjJFA?=
 =?us-ascii?Q?o2MmfuxOV19i9pfS5wnD+VzKnBNr4JiXb0viJr6hmV0s1E+p7Q1HQ35iPMAC?=
 =?us-ascii?Q?3EazTl04lrqmfgKp516pky0BtoRKj9VzpYkHwAaEDNgUeBSRJKXZEQOmPYlS?=
 =?us-ascii?Q?/bxiW50G9Pyq/mH1kQyWDMD5ExTWh9dLNzN90d9krxxJD2hhlEBmi2BhqG2f?=
 =?us-ascii?Q?SrbsFkhiRA5pa9N/DgVlrzsLkduzhvO7IVbrmG8fR+EPzEmTy+ga9/L33TRv?=
 =?us-ascii?Q?dwBmr/iIcbM+R2IlJzJAxGh1sxfwcqf3cO+zSio0G5wnVMplPifd80wLcOjw?=
 =?us-ascii?Q?ZRCqbvNHvFbtPtZfyklk1Zfz83Pd/JtJ4eJyhtm+YI36xcAq5c5hqTia2M0w?=
 =?us-ascii?Q?5YIIgEwDFJwpOt7yggB8DU7CRF12h5l7VQCVpRz5JQCspyDvcFczs9kR3K0j?=
 =?us-ascii?Q?6iV7T1m2xlyRn0pqYDNENpxMwuwYBaiWM3nH2Gd9r7ILvbux+4RD/CVp7an7?=
 =?us-ascii?Q?sARvcLl37TS4XWjkiS9Tj4qcgFw6j/iy8x4tM8FbTUD9ItV0ErccA0OgB5Qr?=
 =?us-ascii?Q?ZV23jYOiIzGct1R4j9mSDf2V4RqlVJnvIjZtbkwjdpnoPqfxmaEtBKYVV9bB?=
 =?us-ascii?Q?Tg+/byWVx3834agjFOjYbjO9ylXX7DSWE4hIC39e+pMnJIKSP9irbzy9qNBo?=
 =?us-ascii?Q?TLduGuoFtlzgRAY74SWAhvEaT2bC+YhLJsNUD3UJpYj44RV4WP6OIK8fznKL?=
 =?us-ascii?Q?VmTqBegyXnadT1rv/XkXxPlLRGmDwi75egQd8NobvMXSzztkU+MgGJhM+778?=
 =?us-ascii?Q?VpHqNoHrnixxwrhZZGA3LABSG9ky5nxx5DdaL0e2NeYTyuDTKoTGYUqDUAxH?=
 =?us-ascii?Q?a5c9tGBr5OJtP2EuvTP9KT8azg3634lzyVf5OSsUZMPDnqtg7l5iefm9fMEM?=
 =?us-ascii?Q?rKy+QobS9AjTEF8DfehsSbIXbR2mYIodclV0RcHMqAyRPG82iT+0Hei0f4lT?=
 =?us-ascii?Q?/C8PrmOFL/ALYdeMvfJTwfN58WYGdXi/dUmPHaGWqISkrAdeo6XynjgazkNp?=
 =?us-ascii?Q?iK9tkj5NOmFs2IRZ+Mdm6gbaxjn6IvERpCW/+u2lhUNmit/tI1a1X0JXaTUT?=
 =?us-ascii?Q?nR7KN3Lb1AOHst99lUmoJzAsOE4lO3D8mDlIaElfME/CZP1An00/MNHWWpcg?=
 =?us-ascii?Q?hcYRfq6G1C4UtIvkpwsgJRdqNyEC7BOznP0uCBtXX9sK3xMCD7gRPNQ3abxc?=
 =?us-ascii?Q?61zJ75YnHsA8MsavWuS6PX4WNCdZ29c/h89ghAEZCVxnjk1ab6+XqsjF2nDk?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	INE+QZFJwQHhA/K6OXLDXoBspS2QqCF4IWlMTuhKGbW6hH9GPkFnon3Tt9vH80S9QnNsI6kkH5N5+ETzB4IqJFPndRKTRJdNHesiQexDNP7OVs1uMjGDnVWpyfE7/6JSXzd+OOxS4BzAkXt3+N07lNLmMYIlAKR3wrkoa0HEo3XNnW5uI7iBwHpIZgX5sTxVWSROCkU7CE5vo1IooQ2T5qjAMmM+dLmXkXUbEGOa0yLVDM7wlJIgMP+e6DKiwnVSPPK/qNtOvIMB25vCpZsX0XwXiukdKAB01isIF65PSPxf0PHAT2dDKajKH+fyAkhWWsmuYM3gP14N2Jfv/KFrKUBE5LsZKO8xaV7iQvSth+ot7IvwxASAjiqkyLN3kj+EPrac/mNU7s5mOAsu7vWAu1uLPincIT7N2fv9Gs0/twm2LYI6g1yfU0saeIspZeHgECd3J/EPgMIil8EE2l2SxMd5QBYR6Uq4HeKqTB1+y/2I6Kd15uN31avaJVsImVNZcnIKrZWu+A5QPiBOiwcVG4iSugAvc0lb+Zzftt7b3YpVzu5yvIxNBiPXSFMshdR5cHLCxBLihnr3MJJTsEfZFFDoFEQifLAKSLisueqV1xQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46e9428-d685-4c87-968e-08dcb88d27d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:05:57.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq9a71eht7oLpr2YlC3hWr/w5iV/FqMFgLWh33/r2nAL12hH27NTVnq3fzLzB3mMrHViYaXkYXc75Om7/IPApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=884
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090116
X-Proofpoint-GUID: keXPNcn5nreFcS4AnnxQaT1EBiz3RFPM
X-Proofpoint-ORIG-GUID: keXPNcn5nreFcS4AnnxQaT1EBiz3RFPM

* Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> Delegate all can_modify checks to the proper places. Unmap checks are
> done in do_unmap (et al).
> 
> This patch allows for mremap partial failure in certain cases (for
> instance, when destination VMAs aren't sealed, but the source VMA is).
> It shouldn't be too troublesome, as you'd need to go out of your way to
> do illegal operations on a VMA.

As mseal() is supposed to be a security thing, is the illegal operation
not a concern?

> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
> v2:
> 	- Removed a superfluous check in mremap (Jeff Xu)
> 
>  mm/mremap.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e7ae140fc64..35afb3e38a8 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -821,6 +821,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  	if (!vma)
>  		return ERR_PTR(-EFAULT);
>  
> +	/* Don't allow vma expansion when it has already been sealed */
> +	if (!can_modify_vma(vma))
> +		return ERR_PTR(-EPERM);
> +
>  	/*
>  	 * !old_len is a special case where an attempt is made to 'duplicate'
>  	 * a mapping.  This makes no sense for private mappings as it will
> @@ -902,19 +906,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> -	/*
> -	 * In mremap_to().
> -	 * Move a VMA to another location, check if src addr is sealed.
> -	 *
> -	 * Place can_modify_mm here because mremap_to()
> -	 * does its own checking for address range, and we only
> -	 * check the sealing after passing those checks.
> -	 *
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
> -		return -EPERM;
> -
>  	if (flags & MREMAP_FIXED) {
>  		/*
>  		 * In mremap_to().
> @@ -1079,19 +1070,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>  
> -	/*
> -	 * Below is shrink/expand case (not mremap_to())
> -	 * Check if src address is sealed, if so, reject.
> -	 * In other words, prevent shrinking or expanding a sealed VMA.
> -	 *
> -	 * Place can_modify_mm here so we can keep the logic related to
> -	 * shrink/expand together.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..
> -- 
> 2.46.0
> 

