Return-Path: <linux-kernel+bounces-193146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C268D27B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C42886A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FA13DBBC;
	Tue, 28 May 2024 22:03:50 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3513DBA8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933830; cv=fail; b=j7bUbTOEpvPsxi3BQD7Vw/yKT0lXhsqs4BPC9z3It5sfkfQbO4L+w9b9l/mhAIZ2IZO+1/zGMO5oKwH6owuElGiThb4K9DtHQjRTqAv8RBKTcNTbV1TwqDXxITuqpFUGJX4zBcovWoqfjokq3D2VHMFykvh9K2C7QzFXyufzUYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933830; c=relaxed/simple;
	bh=8yMosvbKW15r8bgL77M3Zd6QGrdoLPnUK1NeDcBeBRU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QXudsLirLRFa8mKgvTRJyBS7JZddATkVVD1haEkMQhF26gugFKXhSu3IfNLLKf4UUNnYfeJbAKDwe33B9Qqsbr16CUyorlSLm2j1bbzzzJmK1eATnZoihrtw4m8GEMk1qaiBlDYXHNdj8T2JaPdUjQcr6XTNCn+hzzQJn3rzQYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SI64ts031973;
	Tue, 28 May 2024 22:03:32 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dvat+AQg2o?=
 =?UTF-8?Q?2wqvOzioontAUo0eKsRhYMxy2ROS9yKV4M=3D;_b=3DRpKVB79Gtl8hMvY/zmkq?=
 =?UTF-8?Q?NtrW4FhX4zq4aQnn7pMiHdCe6FAczASzOeQybD6OZ7A2Md7B_gwdPChYlnBItyY?=
 =?UTF-8?Q?ClC0h7zoDAzbzvNynvnTk+1k+xQ7bUXsyWxhq8prlovoHOxqIfTW7H_8uOoiNAT?=
 =?UTF-8?Q?uh+O81a6I8FWLj1kUqAwtX8UARnyo9IfNImHn1YWQ3qO5q9vzrQJ34anIrn2_kW?=
 =?UTF-8?Q?W66xGmDaBtdpU0C2Rhia5AIesNdDd8y14NK8Vhl5zufhIAWZhq4qouzlLfrZla8?=
 =?UTF-8?Q?nVQ_IBWjb9z5gLpnLMctYl/5WcL81J3NWeFLK5P3yhC8RWowsU2fP/wSAUrAp64?=
 =?UTF-8?Q?Sxp8jERum_3w=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9nhj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 22:03:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SKIi5U024001;
	Tue, 28 May 2024 22:03:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52br2r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 22:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOSiTibU/LGHCna6q9HitcjA2la6sCTFhCv+7TW231oZqMwudN8vMsb634nLnv67aVq0hRSeew1ZQf2vi9yaTvCixw+fTRmARP1W6p1yJzYZXFOBkLMhT5PRYZkvxBjnpXvVhrHt/i774iRvICNu7bavOwwtlw3oKUfmr3H3+x0gLg5LGkaFVG1jUBwzsTetmyqr1nVW/BDb2cip+9m4UbgHEk5keaP1sZXWt7XZVLZ2WJnkukt68+fa3SN0xzUMvVBGy8BrnaBZS30A1uOW7frPNd6vCx15ONHmh+kUyQS6OitoYqfFKn57cE98gq/M+VSe1KPYyBleHm9d1iVRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vat+AQg2o2wqvOzioontAUo0eKsRhYMxy2ROS9yKV4M=;
 b=cu6Hq89vu/0Mc7xo8n0JtRD2/wPH67sY+OdwXogrfp11PRGJdAkgWgHp83PK2I8sz9VIFq6OeGe6R8nXUCjuHDKgkDZVwy+5yEV7ZCDZG7GWkPlBrRfEOjGA9J3/JXkJotDLrr79SrN4EfIkyXo1d8MLqcYQ2R13VgddO6Bu1z48DxFry2LjF8A7sAr2468K/MsJqjWaQ0+ZG/tKgluTPLgRbwNcKeY29t0sdH7Yslt0LvuZxc0iUIwCbdulaAHfboIfTMuU7tVjuvAJihlo8T8eHXq/NY/6H9v1wKMrfCN+DrJq6mEopevspLtOXSCXzlPWm5aWbFnDitbwvS6FsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vat+AQg2o2wqvOzioontAUo0eKsRhYMxy2ROS9yKV4M=;
 b=zg6VnJc5BN6JxBOYB5hyZVsSBSG12tW8tOJbS/Su2OtWWPFZKd0j47Z6FCvD+hgN2eOHPyxFCZ7+4ImWuVB7aOETGFBgkfBPOTtYTaY/yi3mPBObmXXUsEfEy7JC4Ax+P/z6uDVa1DUaSAdlvQ+hSspULHCp25wOzej1a+hd6+M=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6508.namprd10.prod.outlook.com (2603:10b6:510:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:03:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 22:03:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, vishal.moola@oracle.com, muchun.song@linux.dev,
        david@redhat.com, osalvador@suse.de, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()
Date: Tue, 28 May 2024 15:03:21 -0700
Message-ID: <20240528220321.144535-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: dcac5adb-14f4-45d8-66f3-08dc7f62012c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RAgS+0kzRTSh2MYXyeAa2JKWZysKyXWSdFLl0GYrdPgeLhSaaoS6VpfhvjYK?=
 =?us-ascii?Q?XetsK7pubMZCUiFhpEGFo2E+jVItl1PcuUrADVnzZL+xJcM1DG3YOA/vq5yO?=
 =?us-ascii?Q?7KknjahkV9IsFn3SxdTSdaD6s7Zl8caVPyk2GggYOG+KVtgxqXp2DitYrQum?=
 =?us-ascii?Q?ozYVaeRsBpj4FlgKYJVw/Sb/UGeWYZCxnwq1E8x8Bjs6eD0zO7hj+v8cOVUw?=
 =?us-ascii?Q?d8kitCT6D8A41lhI8VmtiahoayweC5+95SDg+bmoy09ongMMsxvePbJAlqnn?=
 =?us-ascii?Q?QZlGg5S6S19hJlNLka9Z/N6PiLOIO+0MIivuoStO+czCubaRG7Cqu7WbWamx?=
 =?us-ascii?Q?+aciX4s7yJfGBxxOWsNgMFP+SieWeIPBcT2CVp8lx8CbiZ/GP2dlEobUXPna?=
 =?us-ascii?Q?+cxdWP8ZKbd5CvtW7NwqSMZ5DP9ayE5NjgZOCvKbji5Vz9jgNRnwTuz977TT?=
 =?us-ascii?Q?qsRQaY5iSEKAXKQTUGKZgXNovrDRZabpxrejh7vHUmtDwjjg7MkAvMjvvfqc?=
 =?us-ascii?Q?W5jQ5vTJ19ejpN0k4yVVPU3U39GaRGpJIrNPpIEylq9XVhFjeeeuK5YNS8FL?=
 =?us-ascii?Q?yRm4LmEp5g3lyTKsnDFz8IFeg9NAH67FntEPiXwMpxOgiyPL1In1yjmYVtZ9?=
 =?us-ascii?Q?ii/8LKGQ8s0vGYT9lMrCESDSsxbeC5WmeeKcADLElDBSTkmc8zPevTGEZGdZ?=
 =?us-ascii?Q?H1d/tmnu1ZmovyArXLBpGQux58UDDujH0kXTIz1k+blJkFxPR08UhVPDRYfc?=
 =?us-ascii?Q?oXAah0oXdbyW6f9j3sHJvFhoUHVFgNX0687TwZSspdcnym9YwOQVviXDAYsU?=
 =?us-ascii?Q?MPim2R1BHbXNK7qxR6mHzdul9o3nCI2AUUk+BOHGMH+m5bfPwjzHHw0N4Drf?=
 =?us-ascii?Q?RzT75jchfbhJsuhhl6zR9eVaBk6IKaNh20Mox8uCn4bKWQGF30vIfiXNCmlU?=
 =?us-ascii?Q?BiMW8EiEN70UswDXvt13We/zP533uyP5EvewwQ67lVxlBwRE4r7GopmTjJWr?=
 =?us-ascii?Q?es0gCgl2c4b5ITmcr1qMXb2jlkoKETHWdlbjaTTBVaVXyV9M3DPWoLCDbqQn?=
 =?us-ascii?Q?qEh6comknJqY7zHlISdCt5P0h7hl0lhJcp3DqhwrWY1lamDJWyQAzva1r+Is?=
 =?us-ascii?Q?lAqDOVdsz8wM0seYAkA39aq117HpzlwJ0XoH9iMuyjFnKazltOAdxxMCudvy?=
 =?us-ascii?Q?liwwCZRQbLjyDGlJsV4D7QXPF1t378KXfki0lq5lXMldmAjiiX+yxZ6o0w4T?=
 =?us-ascii?Q?6MaHTqfPbJcC9m7nRppJ4j1jNlnFHpg0bokr3RXhYA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KcH+0J8GTPxPIPV8+B5rydcvCwCwsAb45KB1klaB/6FwmPeJhZiJo5whe6Dh?=
 =?us-ascii?Q?wfZ+9M0uIqGt4eh+6QEayaLIG6clDC7nSJ8M1LvJxzDnbm4VyXjHA0Be9R3D?=
 =?us-ascii?Q?Br9BgRtC3FV35zbSjYjouamDBrFIg/7/nj94aqPskf3O8pzzdGDPpxo4uYZ/?=
 =?us-ascii?Q?CJ4ijXgKs/EkbnnAsq3Nb8TZfk3LZF+Z7UqSR11Ztehk4ETYM/4grx1/XpdC?=
 =?us-ascii?Q?/BAX/zUjOJzqL7B9ezDjSnOBzELvtY9DR+98n6a16KGe2jrRFW0Z4Zk2dWtE?=
 =?us-ascii?Q?xhC6Cd/rKNU4dgJZBEpoBzadD1zNnfH926hTWIRHBUvMOqB+7bxTb9MSrgJf?=
 =?us-ascii?Q?PcnVBt+YE1lRbn8w8XoS6ZuHp4UaX6nqWLRsCm6yadeJx+OVGwKIH9125exA?=
 =?us-ascii?Q?Fd5xXVkFPj++07AoXEvAjHGtBVwhCPuIesIvEVXHmZEBMo4gvtLe4r40qgfh?=
 =?us-ascii?Q?d342ZeQOh+ZOkLYZA51F7SfgakymZsXFdlWjzwzH+vPwgk5ndgH9niTsxU3E?=
 =?us-ascii?Q?NeP45d1MHOeafDrRJY+xRV+0OS2JN2eDgg5XdJ+qqXKWifcR7uLGuXTBbqdT?=
 =?us-ascii?Q?jseSRAD4EJkcGmMgbD5tkoSDOFMCXm/fCKKUIPyIujaUd5WjAgqxL4aqf5xY?=
 =?us-ascii?Q?q1jvVxrSJOROBUfJZH7iDJ/VqGk2XUV76inxNaXSIJxRi601BUh+7M6L7/tf?=
 =?us-ascii?Q?GBkSoa5S5dWrr+bDYhtgpHMF2rGGz/59JddnLN8F+ZgH5LNM+HDZUkpcJWsh?=
 =?us-ascii?Q?Mcl0lL0p1b9gPgCJvvcrAkCVsusPVY12YWys7fhqOtyoSnDp5kSJISkHxLuJ?=
 =?us-ascii?Q?ZMqjIbWYwV1Yn1gVyhjssj5yY80ZOyubB/MVhb9vZpy9Lu95QlLT1FZr13nJ?=
 =?us-ascii?Q?+MKmSWKL2Hf6LGWM9EEb0aCshFJiBB3N/sAyD54TA7WSsyRa1cQOaxp1ciDG?=
 =?us-ascii?Q?yHwIg1pBOznYfofE4AxK+Yswxl9FB+JkqonzcWMT1B+akBccc/X9CY7hZ1iY?=
 =?us-ascii?Q?qgOKsIn2ODtzGhN4jn1qtZ8s6M8FARTAEhEP5G+u0rYNgctPvWJ0l4wH/q4s?=
 =?us-ascii?Q?4Fhb7S3TkY7GrQCiD7gI7idcFoOyXM32najRYuf4bZ9JSBFTZ8WSSvuZy61I?=
 =?us-ascii?Q?5oTKi+flS//t1FJoGdGzIgDGeKsY39xhnZeiqJeKuJ7S0IKLXmM8dvcqc5l4?=
 =?us-ascii?Q?4sCvlmBMJijRw+nZM+gH8pUN5OyhE+SA+teVT7KXKtqsLaR7v69Guw3Q6sCt?=
 =?us-ascii?Q?rp6TGSWeZjFcurmDAZioaLjAuHxXd50RxPDmkRJqpDCsF3T24p6D5cWB/u01?=
 =?us-ascii?Q?2WpImLzs21kq3E6zm5p/7qKoUrvZa5T/TnL49KNJlvvfeXdg1K5LjVi9fc1x?=
 =?us-ascii?Q?5ODFZYau4frOQlBU6aJCmfl5HjvOtAd+pMqX3/xOJNgCSysBTPdk78iXAnbC?=
 =?us-ascii?Q?CcnYHQk9US0SaTBD/vDYXSXyJIe11GWC0fOIMs/0nI0WEwLwPuOqB39daWz6?=
 =?us-ascii?Q?wv+d5xrk/A+ztNlbz9/vIR/NTnihFrDTjHwFbjGFQOX4fTCTpl7ckgTt3bPz?=
 =?us-ascii?Q?oAiNbydLUHTLNKeClrMVSpBu1XgA56HI5xlSUX/ScwHXHm7EpGtdrHNauvkm?=
 =?us-ascii?Q?MEI7a0KaGNVAbz9fuj89BN8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pk13FeVkZU9aXHG6I2sxr1EFkzcvCPXVncye4Y5OJxd/d0pvrUViuw2UzEXJkjO/1B8pcZYmYMBMRn0cK84F+zHQd708wE9c58/p2tnIvu4/sfnYP3Oc2/USqt8byQrX4hr5I8mJifcC8skJXLxSBNL8np16xt4n+A7c+Pi07Urk57sJf8sF/00pqi8aaeRFNVIJmMU97cM1/oNbic3cuVKHG0XlGus3fWZ0KF1vCVpsiuS7SJgL17uVUfiU445mPgUZh0yb57cBA+E2ZUgPfs3ckgzt64X1/u4d6ze+w9POvilFRJBhooxbI65AOQNA1xsOcMtNY1Zkdw7mqG5PIx4soFTboEy4T55nDLGuiXVzX10ow6Wf7GO8eUoIVtxCSx+Wu2I8IVRbh0glTvbM8+pgOXnNWP0zqLFMc5/GrgZ+dXB3B2XZO/3sTOdm0qhzKqzpEv6EdgOPML9M0ZdAiJ9FMH26qvDuc0hvjq9spj+hqg4uN1QJ8T5q8UjmMeRCrJD0aOe4tncqcQZwuOxFCyYGHyFBRx76D279P22l6Q0ZAXHfCoftVljod7k5L1P7ohaO7Nq9RFI+NCLiGHqKkUbaoyzcCbS3njXcFI2dL3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcac5adb-14f4-45d8-66f3-08dc7f62012c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:03:28.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +glOkavfj4R1It8rtTCCptOKvNt/fPRm0iHW/KBQNUVHkwj+QGuNjbidEwkMQhqn4kjLmPlm2BRH9m9XdipMvBbr0Wdbi3BiACHVzp11JS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280164
X-Proofpoint-GUID: E81Nk0iIyi89IwbtpdVjo63RbboL_uU7
X-Proofpoint-ORIG-GUID: E81Nk0iIyi89IwbtpdVjo63RbboL_uU7

By using a folio in scan_movable_pages(), we convert the last user of the
page-based hugetlb meta-data macro functions to the folio version.
After this conversion, we can safely remove the page-based definitions
from include/linux/hugetlb.h.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 6 +-----
 mm/memory_hotplug.c     | 9 +++++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 15a58f69782c..279aca379b95 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -616,9 +616,7 @@ static __always_inline						\
 bool folio_test_hugetlb_##flname(struct folio *folio)		\
 	{	void *private = &folio->private;		\
 		return test_bit(HPG_##flname, private);		\
-	}							\
-static inline int HPage##uname(struct page *page)		\
-	{ return test_bit(HPG_##flname, &(page->private)); }
+	}
 
 #define SETHPAGEFLAG(uname, flname)				\
 static __always_inline						\
@@ -637,8 +635,6 @@ void folio_clear_hugetlb_##flname(struct folio *folio)		\
 #define TESTHPAGEFLAG(uname, flname)				\
 static inline bool						\
 folio_test_hugetlb_##flname(struct folio *folio)		\
-	{ return 0; }						\
-static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..3573f39fbaa6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1731,7 +1731,8 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	unsigned long pfn;
 
 	for (pfn = start; pfn < end; pfn++) {
-		struct page *page, *head;
+		struct page *page;
+		struct folio *folio;
 		unsigned long skip;
 
 		if (!pfn_valid(pfn))
@@ -1753,7 +1754,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 
 		if (!PageHuge(page))
 			continue;
-		head = compound_head(page);
+		folio = page_folio(page);
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1761,9 +1762,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 * cases false positives and negatives are possible.  Calling
 		 * code must deal with these scenarios.
 		 */
-		if (HPageMigratable(head))
+		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		skip = compound_nr(head) - (pfn - page_to_pfn(head));
+		skip = folio_nr_pages(folio) - folio_page_idx(folio, page);
 		pfn += skip - 1;
 	}
 	return -ENOENT;
-- 
2.45.1


