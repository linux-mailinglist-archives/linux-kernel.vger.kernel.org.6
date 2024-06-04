Return-Path: <linux-kernel+bounces-201193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83278FBAC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E4286607
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F314D458;
	Tue,  4 Jun 2024 17:42:43 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C714A4CC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522962; cv=fail; b=IlBqsrm3C/8xbET+arI0nBGfY3QrRHEfyQNV5CVBZ3AmR4RRMoRfnWXer+98YvL2X3GP3nHNjzfsoZC2dx/eor0fncBHg6+xvS6lGusPT+NMmhkHqXAYNeU5mDn9v977yNXztHi3G62RDcLgBqx/GpxfAKbfxMq+Yc3VUXFEULU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522962; c=relaxed/simple;
	bh=5JP921fyINXM7JJlV4W18vvviXFq4RxHYMFXKKLHgtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXWpJ66/OVpZuInxxGaqFhuey7upI8gIL7Eu6hBFN5Es5j2JdmHMHixOvnzHAZfl6HRWrspMVk0Zwh1Fy0RivooM57MwrGZH/oxxTK3FvkUDga40lsrMaGir2lIt44DoLDSU8r2xYcjs0YbuElNRKtUB0F/A3wvpciHFWe86768=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnW2b032115;
	Tue, 4 Jun 2024 17:42:24 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DubIaSEckWfJUp+wkuVmhNaKmXVwwu71VQEcFJ3DDB9Q=3D;_b?=
 =?UTF-8?Q?=3DSTvYyx7S19v+AcJ+wSAd6/eC6r+b6AqJbjblr/wQJPxJ6qnEMmdz0iZiNYFp?=
 =?UTF-8?Q?Nbezjral_GxriVPs83VO6Xb2uvhEQtICg1SqBwKm6jW4Fu2f4y+ibKaeAM/jfSb?=
 =?UTF-8?Q?DB9LFc9vYyUPMq_/vnLvs7kmptcDOfkfHVV5XuZPoLBdsDoEw3QaHLL9rzND3oe?=
 =?UTF-8?Q?l7K8Os5Ci3M56Tef6Lsw_OWoLx05rlWuvYRCawWpnGzD+gPAjlp57JDs3jvKCLe?=
 =?UTF-8?Q?bNK0vu/+8GbHSx28/JiLPT4Z2A_3VUucqivzkBeJjOVUUPbyyi2GfhnTdH4VFWG?=
 =?UTF-8?Q?B6HI0vwmvOyX0dZn4AxuWrZ6SlXUuGye_lg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u5jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HN68q016121;
	Tue, 4 Jun 2024 17:42:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf37v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzw/truBpbgZ6g0jbfuY9frHFcXHeQfrJGC9zm5lE37TEtOjWClU7K03wL0yV+BalLeeNR1K4q4pXNcAWK5z2xc+/ds1qXhVW5jDLHbznKTQriZAMl4a456BDtkwMp9UAS+nsqhPY3s31mjoYpBAGienkwINI97a299rNrPXX3IKqpUQEV2V3E+2E3gZxgtO3ftAF/5wqOYTVkBjetVVxi4tCkbFpFU9UcenLFW68zLx5osVfiEYEtyRAh0Vqb0iIDQBpT1Rq6RmpF4RHURwhshMoTCuDsufJn/Rbsmu0BlcKqzmeRDbdA5Oibroy7sH6IvTl+ZKUiRBU4X3AEvYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubIaSEckWfJUp+wkuVmhNaKmXVwwu71VQEcFJ3DDB9Q=;
 b=Zv4QX9HeLm5+b7oIORRXaIzyEq/QGXbA5x6SjRhfJcdaQYljJ6HPhNkJSWDZ2Cr/0nf8LynQZbF2iXV5zYmUa1ontorlabH3rOF2McY1VAs9yunTwGTpmrsSS/FCtfF58Fb1eimCmFUAVItGtnkDvPNLu63HtjLTEnpcElQQyi4BMcmIQeltXTH+tIsd/IdM0LzTFB0CqFa0mEEwZsbee8gX2+SoTmJc99OGv3xEVWcr0DDwUjsNqzj9rn6lawDSTquQok8/HaPwg7OQ55sUbN5eVFtSrQa27OYMRHpckPX9ObizCA+QnGPbLfpGaZ7nZiWhRRxvbvjI8V4J02UnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubIaSEckWfJUp+wkuVmhNaKmXVwwu71VQEcFJ3DDB9Q=;
 b=hUrSkAFOedraG8um4FDdjpo09CTufqcioahyK3YOTxvGDhJaroU1tTU4gG1Wo8LUpJfW6RqhfqBCf5AjGQ5u6ouICa4HgLZlq5zLSQG1R+AmrEXD8QUnioWhcHjhl4PJYqN01QT/cF8CxSkeyOTtTsWgZWW1JRufKxzrezTckQs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:19 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:19 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 13/18] maple_tree: simplify mas_commit_b_node()
Date: Tue,  4 Jun 2024 10:41:40 -0700
Message-ID: <20240604174145.563900-14-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe7c6a7-65c6-40bf-e3c5-08dc84bdaea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+kK2KGzddLPySy2B4Atki29wKkhpiO1IgdUVEGE2Sq/TP6xkBIdl3qisuNiz?=
 =?us-ascii?Q?3xH/SHoqn62+WME3vx0wJ9AqPK3wz1DBIMBuBKQw4VEu+lhxhR16tKVbsSgo?=
 =?us-ascii?Q?WJPqc0Ux3mpAXP4O4IeeXKnhOVRWbvISBINk26QT4WvQep3NPJdEsCQ8ZrcO?=
 =?us-ascii?Q?xj7XrzHQkkXGYqdp9k61tlA3lat6HkSqMvTc+A+cM7wT4Eb4U8UGunh3kgU5?=
 =?us-ascii?Q?RxnuvDwFVPGueb6xerByPULEF3/Ry35SCQa1ZegNyFdMR4ODj7VCkVKhtL4K?=
 =?us-ascii?Q?zh5kz74SnwVKgne786kbZwHzT5XrE/FOx3v7hO1+2mxxa2Xv8JCx91j4Un7B?=
 =?us-ascii?Q?+k21IgXA9pC4IMDH5hQ4cVZv9OlbT10B6TJimT+FhwHQHjgPt7KGlxvCXI+N?=
 =?us-ascii?Q?dNm+/w3MtU1GCMMFUPtEKMob4EMlJkgWxxE0DXMiyMUbzZFn+Ri+BaD9crMF?=
 =?us-ascii?Q?kqn+S8aNr0CuXohdIMadEuGCXV7iuFLDxsBYSVP4P5Lij7EyanagzbqhY/OH?=
 =?us-ascii?Q?iNELOquZPjDxpGZxRKc61VnbzKiK2LVuGSjnMD9cUton/p93w8x/CD1ts7kP?=
 =?us-ascii?Q?CF8CRI8IFd3pAQUzJ+9vzoE1zz20dES0zviNfXq9uSXj51haSKyz7knfBsyy?=
 =?us-ascii?Q?VXnGy69D7sqS4hyrUPJSacQWY1kKlucU4Tmw5YgZ0rbD2kJzWf01+fHCw9nM?=
 =?us-ascii?Q?Qw8NMaOSp2ivN2GEgPLSUlqQTQq+IVj1OwPSB3DXEHboXYkDcZG7ovaHDWTq?=
 =?us-ascii?Q?k+fzfAwBCdHlDTDqwcvdh+SGEApCS/9B2L/88+HTKFZWqbeV3jNErtOSzS3n?=
 =?us-ascii?Q?W3KCsOUGBd1iys8MHxqENPv8eVswaJ4BISGGNQTXDx6kLRr6gvZX7OicooPW?=
 =?us-ascii?Q?44Qcwtn/IVEZhEL4Jc4KPL7VSOCwgi+dTrAXiYRaiRRZTSpxYWp3MXiSyEzs?=
 =?us-ascii?Q?AO1PO4RSf72z5SCQU0j6kFxl0eC+kvVnJZb8+XbjsnR1q4v0Cr86x9gY5rYz?=
 =?us-ascii?Q?q19xYMaVqu+4cgAe/7HHeJfZTGcVBAsMogOPzmNWtys4q5HLqQFutT9VlETu?=
 =?us-ascii?Q?R3jYxRSAuoEW8suIzZ2shyEAIq2CdJRe4/juwaF8moe/bxf009Yf9prX85MK?=
 =?us-ascii?Q?FG5n5jLiFfND3BG+i6POJy783oUuSbOVlGz6WIkbd9+ilAF1dddVJY71cWIt?=
 =?us-ascii?Q?ZLlqiG12Ja6BTR211nQTU12eUB/2lbTDFD50Mb8rIkGoEZI2ZJYGi3BDVHFI?=
 =?us-ascii?Q?EwBo8fcrdxCbXUYbx1Jb1uSizuICZK7QKT/rhGFdHqevk5J1wxIds1jwCtxe?=
 =?us-ascii?Q?OJk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3OttyyjxZ5HHPCYFYASpfXl22+oZA7jFjJx1SK5C4ogKvW6Q2bDKyF2ga6Zs?=
 =?us-ascii?Q?rGXrFdZPxa/XtQUxsJ+PDo4Va5gwefyKYgfnpzlw7CXEL055lyKCrTBnowji?=
 =?us-ascii?Q?JCo2wCQnchMSR2fC1xaA5NTN1zzB/52vr9sCaJGH30lUwhJ+ODsSaU665JNe?=
 =?us-ascii?Q?vhI7XXeIXp74l3elKeG61HUR/wD63hCoI+RtAW7n+Nmqm9mvy3NapVchQ2R5?=
 =?us-ascii?Q?TWAFAA8VQvKw5eRQRwBLE6PQLcj/MuAaqfVfcp5JG4Dcgf0hNGVYGGoHCb4d?=
 =?us-ascii?Q?uUL3nkhshfCWqzg5g6mQzVi7ZaLqRC95XKeGwbiIfh8JvC58Ox8n0OEkp2PC?=
 =?us-ascii?Q?C/b9uKiHC11F37PMLj+qWQjR/4tekVr01XPfB87KRN676XIQR/Dimj3yLnZi?=
 =?us-ascii?Q?Gqq/ENVewySZ6gZSKnANdBnnDTyDWj3ickdy//ctuGt6pchzAxMjqWHBISIU?=
 =?us-ascii?Q?bPIHECT3wcnR5Fb1+SqiAc+SanzsJAxbLHMo+Ck7Yx3mLnbgVc9/jIFq1/P7?=
 =?us-ascii?Q?8AjmxKGOF++IqsxpsuLMxs8E2vxUdI0aLnvHqNsN4CVl+c7uDyaod0Co6o5T?=
 =?us-ascii?Q?MWh01Je0hMYKJcJ7TATUwbTu6YkdfNFsvyyEMleV04UFBKyF93aCbgVNBF+g?=
 =?us-ascii?Q?gtebjooVg6fFa9d3iPQlbn+D4eazyG7W/JO/0fTN59jrdj40WqERVYgEghJ7?=
 =?us-ascii?Q?yJcT7qBPJPtmB4HeLI3XE4VYw1wzb0A4aey8cXU+cDY9pAQ6c1kx9rDxZ3RL?=
 =?us-ascii?Q?C46kLPSXKOqhuiboma4fXqHLlW6GwStIryem/ExdYUt8YaWLaGJsXpB/BIxx?=
 =?us-ascii?Q?mTk/7Xl+2rUb63kHQaJdc8SDmqG4C0008oWDIzqWhEd5yXklRtv0c3pK2mlj?=
 =?us-ascii?Q?g64zFSVU0L7fPRK28gANKAFg+P/TOQ50RJWAB5hMgFcsITgL4RgDvmRMXBhb?=
 =?us-ascii?Q?qEEny3eGpCrZ+dCMtNXO/2nNaXQF8PbVn1IyIl4uji2sxXPue13EYwd8FVA7?=
 =?us-ascii?Q?BHP1fnx9rjYm7ZLj1lWl0gYZnWSWDJmWUoDDTxcSiyiTNW13z3wFL5s9kV3y?=
 =?us-ascii?Q?RGvnqdkYGzZ8Ma667FQRwkRmG4lOiJUJPuiRl4u/PDYL5PWC8TIclOF3666X?=
 =?us-ascii?Q?Vm/Pf1UrSfRiIbO2sAhtm68igmh8lpziuUe0xvmfASWzAw3pvm4VtiPEOZId?=
 =?us-ascii?Q?2LNmZLl2R5SPmbLEMge6UIieLCtAHyEWI8L95ayeOSQkuNpe1/cz7OBmqcKH?=
 =?us-ascii?Q?2ij7TTOuoKtGSk8KjfJFn1OYMQJ4WaSJ21WSS1HTTYbPLHFRaw/JDEYhaSmB?=
 =?us-ascii?Q?WzLMmSVPjUOAQnQNFEmVzn50VT+MhqwFi96zrAUqPXiX5ayb/STZckgU2hml?=
 =?us-ascii?Q?7AWTvTofIOqRW5jjWDrGq5nCOniy2Y/F1UVVqtGnq8UNVipIyRnjJNgw0/7X?=
 =?us-ascii?Q?V0hjU1PADSkxSIr1riORlfFLuZXRFsN+NUBxlD7yWkC6Q4E4D4vIPFXTpfxI?=
 =?us-ascii?Q?uzNWmxOJr5ewZ1qKEkdU0eIrB1mL+3kLPsDgi4Bf8/9zaAMHlrhRrQd7F6Tj?=
 =?us-ascii?Q?1bk8zjJvxH8umI2rb05tu5Sn5yJ/5oiLQwEfBoooqiqYyT3JuOsCm9Ay9xAG?=
 =?us-ascii?Q?hQbzCDwmDN048eGygJdnSq8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DIZtzwqlC6x3HJjjpAGjxI1faSAIjls1EHwzuaAH0c8aPwmaXnE32fTbiomUF/8d/3dDEZ8iYgxrsPtrnMvsHOF9Aj9HEOYlY8SWWDwF1GBe9w6ZHkoJxCG45UIkht3HpoGO1bgCXRRWyfMGBTBxbXCpPSyvNNLpAjz5RuaFK8TWJTUY01VkQ3X8BFKPYg8xnXUnaJ2PFKxPqd8o01f1nIXGikFlhil5pafPkXKPEA6e5zNMXqtJsO+nL7O7nfFOimSMvD1ejLUoTJWyAqKUMarLbnHzuWJRy831OAtUYcVpl16IXNQ47gOx4hL68Nv1W/CiYVPHNCQ7XYB7cSYbB5XPnXnzyzqbOSAriK89k+MjGBhUAL+4iERxQGkuxxWPd8C1z85z8KOqVA+FiktMcvKlaFSS4903QN8fD3xfzHX+hrL8T+2Zy3lohRCzi0a11iD2XOdN+oSjGbv+WU/kZu3mDa0DJlZfg/Y4/uCx7xjOLGQNQETlKQjsbDvTcYwaiP0Nha27895qpI9zOojKX+RDjjF6OyZsHEyJwCMFYbZTCtNmJxeSBY0T1XDGwU/syZNDleb/ti/2mt9lq2VioDEK3EAZuSpy8QX+tKkKtbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7c6a7-65c6-40bf-e3c5-08dc84bdaea1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:19.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9yW4mv9qAxhUDproKoOHz8CFRqa0K0As926vzCUlWj5EZuuyCBOXxIs/t7RF3lcvqF9JV457bmabGLfJzzsivVs75jrEZCGdWESxsK01EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: cB5MMEMfwgSWjE-ewRZnY6Cz5dzYmA7v
X-Proofpoint-GUID: cB5MMEMfwgSWjE-ewRZnY6Cz5dzYmA7v

Use mas->store_type to simplify the logic of identifying the type of
write.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 314691fd1c67..faadddbe2086 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3437,12 +3437,10 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	enum maple_type b_type = b_node->type;
 
 	old_enode = wr_mas->mas->node;
-	if ((b_end < mt_min_slots[b_type]) &&
-	    (!mte_is_root(old_enode)) &&
-	    (mas_mt_height(wr_mas->mas) > 1))
+	if (wr_mas->mas->store_type == wr_rebalance)
 		return mas_rebalance(wr_mas->mas, b_node);
 
-	if (b_end >= mt_slots[b_type])
+	if (wr_mas->mas->store_type == wr_split_store)
 		return mas_split(wr_mas->mas, b_node);
 
 	if (mas_reuse_node(wr_mas, b_node, end))
-- 
2.45.1


