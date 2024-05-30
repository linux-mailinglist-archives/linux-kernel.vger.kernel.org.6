Return-Path: <linux-kernel+bounces-195721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4F8D50BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B786B224E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4D45BEF;
	Thu, 30 May 2024 17:15:04 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04244C8F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089303; cv=fail; b=Di8jt/g6g9fRoq+L4yHdWUPo809wegzlkx+F1vP5lX1DXE/MWN8wbey3yUGnUjtMshJ1sn8lAeYy0AFRzHFoijxUuLnp91gwALB8cxLQRKTExzEHqDtlpDEK39AYuxwc0Pyzio46PDLKWiOCJD28sAwLiLM9FfALlzLEgqhm2wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089303; c=relaxed/simple;
	bh=I1sXafrd82Plv3ZkkJeu1J3nSXKeHlo3WFTDA3VWChQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NwEBdHjMoGcujevXzd3cQ9KazsQhLQabsMzaFdDxDTFyYJfwdjGx2g4j+7Ewegbq8SIx96EWvLaKuk1crYpcMnPwiWXr74rcNZpKsJRSg0xMz+90QDLrBI5/d+em37TGlaWLWBx6BdhYwzBtXI3XTVQeVaHllk5Yzxx0LRF05bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFRlBX003255;
	Thu, 30 May 2024 17:14:38 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DWm4QLbAXZ?=
 =?UTF-8?Q?lG9kdh2STD6pfP95yLX1fGvL/bq/SvpDsc=3D;_b=3DP6S1AHPhhEMfz8+rHwtK?=
 =?UTF-8?Q?0Wos2juemUgMiI/OcVLtC58nbhFfD7IPdISnEnbt+icuB8F3_k0u4IzqKrUKgZk?=
 =?UTF-8?Q?4e8yMOLjZ2gT04JHLC/4ajVewE4HPSgAVJu0xSWUvC1XMmQn+Bb8hF_jIc1UFX3?=
 =?UTF-8?Q?OYfiCXBDBILZhw0UnnwJzkCE3eGdKD5cIzxzYqJMPFyYN+rABZORIkggXW46_av?=
 =?UTF-8?Q?/es9f30rHl1QBKiqVQr1OEAdS52q1dXZbRTl8+zk57dILZ4osZ1Z57PirI2ZckT?=
 =?UTF-8?Q?5Fa_En/qGzkdW+CjROh6K3cQbnVwUfrEffCuLv6DZDG6twVsZMWYP/4f7J6W7jz?=
 =?UTF-8?Q?6Xradxahj_WQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu9kf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 17:14:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UGvlDn016210;
	Thu, 30 May 2024 17:14:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50su17v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 17:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfuSm6nPJMG9s1BCnHgZ7xCN18JyrYRyFLfakpI/LIQToHxXTC0W2FW5wKgaXf1j2zzPl+PYuBWkWGK8X5VbohXbcyKglxEYMd1rkSBKDRTI2fLjeA6ZPZB6vviUXubR0KwwQaX2UX5YUQh0J69gdThhp1erZgUnqYQuGOC+kSUoJqbBfsafBK+AsZlTaAlBMfn2DfuOZgfuKylvZBcdJfItKojhT6BGOFZeQpZKsNX1xpY9EM+CIinUvx1Ee25jLjZPcmhfDzQMhodHun3rLAJW+nSQfrn6+ZtJOd0ennKYjn4cIVDKwxA4TJ72wsDODDMqaCJlstLz/A3B1tgcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm4QLbAXZlG9kdh2STD6pfP95yLX1fGvL/bq/SvpDsc=;
 b=gfqpHZwS5xvPziKeo5PE+X9cbtTAQl+5ygXJSa/lTLp4YBeVShdIO2T+li6bStRttoA/HA8BXyyxT9IP3jf2CmOF0VZ2xXWBgCVZQ5XXlGXv7btNLfC5s64fzWv8TEq95aBYf/K0VR+vjGMdK2tXW6qw8AVFoRGs1AG08OApONm9QIbiw8msS+Rgy58xAvlqJi4UTB6OdpQwW01RA31CNy18fomO3lGSH22HRyfGOwerAIZ53yMpdjZAeFci9a4QXcKlB1RcLwPAwo21Wy6f2shxGdUgEA4hgZ5xxYjtBf86MgRPeCsonJ4yZCQdwppHSI+HkioIraokDQInO6TuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm4QLbAXZlG9kdh2STD6pfP95yLX1fGvL/bq/SvpDsc=;
 b=xl6z5gf6Bd75B9ntFHchlMzAoyqKJFHaa9EdUAN6B1bXjZAUBWeJSfNOTilHPgN04fwnwSE/qsXzy79qo7BNL2vHj5NWnWnx40eVtUi+vBj6UJ8jVazBj3Cio5WwAXvwNa+UyxVhSvfZ0lLmMKboNeNwWM9CFaFEH3haNUebVkI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 17:14:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 17:14:31 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, vishal.moola@oracle.com, muchun.song@linux.dev,
        david@redhat.com, osalvador@suse.de, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2] mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()
Date: Thu, 30 May 2024 10:14:27 -0700
Message-ID: <20240530171427.242018-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: c14a6e3b-cf1a-4d06-338d-08dc80cbf867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gfbsZDjy8kaYutIIVFZhRyU+YD+ZSZTu/YmthQgazqlvCOi6D92mXWF7gT8p?=
 =?us-ascii?Q?uIazcgADZPS4pti4VGQLqpoCWN5sRkt4cV7UGgkMM+RRXRH4kJjJEIkL0J7b?=
 =?us-ascii?Q?XsZnh/B5L5+SUPRLjG9W5Jd8b/lvhW0HLM0VneyctUElLV8OSDLVkOWN/K8G?=
 =?us-ascii?Q?Tdq7v+Wt9wFn+r71c8h4hUKMcjvZxcOsVe6lI7e9EQuMbEPCVXGvEBtX8pGG?=
 =?us-ascii?Q?gOoZB83Cs3OWhkAdz0yp5vgngcxdROQuTfhTEMvnML1TE5j7A5crtYEeXs21?=
 =?us-ascii?Q?An4vvQswFL//kqUgomCGZbMGLk5Nkcz3+/xdgNdBGBWjIivLHizSlQi8BZCL?=
 =?us-ascii?Q?Y8RLiWi3QEg+I8vrlihb6MvBh4axO4QG7yiLwMhbPZYApHcgqDu7SfAY/7B5?=
 =?us-ascii?Q?fJTmS3DY40Bsc8BeRWdNN9rj4MevnybMOCRc2h1k0Mf88UIPVGmZfumrcVld?=
 =?us-ascii?Q?AJ2e+EDZLz9ixHyy1yAy5h+098bKmuW3rTvKYavnWYF33YNpxqApveSVu9Vi?=
 =?us-ascii?Q?Zp8SERtt8g0eOwNfRzWYYacQhUqItpeKdGXLBq6SokRKArKlIP09EkUeR96e?=
 =?us-ascii?Q?W0yFkkSxh2+SM8hDTfvHFDS+cQzdM98fzDnLnc13eoUCIWMw+9ucUVFJfvr2?=
 =?us-ascii?Q?p7/5u/EeNCtRgcM8YcmapsdXOpEwUMNjjndyEO3Aya2CAZEtVKaIa6MzmWAV?=
 =?us-ascii?Q?W/Q6gqILTeVM9k+spf0Arjp6BvvfxWgRcAnR7Hvt3zi1TIv52KJlf3SvyRg8?=
 =?us-ascii?Q?KGdgoYNw4D4Off4UWgLlRfzMYr36d5HwZt86WQZK2EIeGdETZA8+++ZYrSMZ?=
 =?us-ascii?Q?c9lQARVssXKGVPrsiVSun3KvudqqWNUoNbp14wrG4bz6cbvKTUFpRC/EEUTQ?=
 =?us-ascii?Q?sxMGB6gK8EdUwxL7jWGpMY3f5rYA3ufIXO5UPx5Osd/ZGTWzTfoYtAbedefU?=
 =?us-ascii?Q?rfzfK4TQG02Mf8nAGZiMEBXKKOZMF02Pw1+B4JOP6z4/pt+NrUobg+9SeJJQ?=
 =?us-ascii?Q?N7a2tv8Ldt1+QZpXaNg46+v/b3L3NFA4KCP2YhOmAbBWYS90RAdNvtNLFVtu?=
 =?us-ascii?Q?5/yjVV1t/n7AIhD1CNgwUKlSwXGcD7smZvWzwJibZi9F4CzG7YdVZAC0LwV3?=
 =?us-ascii?Q?NkPEuIoZkojIRfUu1ef3BurSYNMsvYrT0Ai5ehCdhiy/baQ8CMdpIIUi8Aeo?=
 =?us-ascii?Q?B3NeyZw9Biprm3FekZmh94LEmj2uJsCVpXZrdiFcuZfWKKX4pqU64YChc4rZ?=
 =?us-ascii?Q?8GpTdH/pNEMbjyg7AfgYeSg+aXwNrHyMYsQbY/PUJA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VIBbf4Y97vykk6MyZR0rh+HT39LmS/ZxXbZfoq9kS2pfl6Oyv1wyHvhvlOpC?=
 =?us-ascii?Q?v0fH5HuCnWWaTbA329jGVpU1SxnkwFUwOCRuF4ze6Y0zSP0MK6TqkM2Winwo?=
 =?us-ascii?Q?paTADTmY5sS5xHCscUQSe1qRHgbCGRd4WoPXyjjuCHJkAQvJLxjoVhNTQLrb?=
 =?us-ascii?Q?4vRbwlEJsUbQ+YVrItB3JxOanY5sSjgp8LFSlq4ci3Oi3vlGjqqhkToiXcOW?=
 =?us-ascii?Q?Rqn926vZnVMWhBww2C3DfuOtf696dd3sG7jmEUmwzOW/fxl78hk2EthPYPCP?=
 =?us-ascii?Q?HirbTmeyPVxEs6B2EjeAr/lFnBFi1s17m7dgwayopWEMEUyHaljRuGW+NllT?=
 =?us-ascii?Q?B/X4Achrjmy9DI31P2gAq0fkP1DwbyvmZyjrz8MKRMj8cprt/u8XHSQ3r6Zs?=
 =?us-ascii?Q?YiB9+4SqRzs0fX8FQ314ni+ZRLQqm8tP3MNlIm8uqHbqsrSKS54vfsRLZ92k?=
 =?us-ascii?Q?qG9G+xRAnZqZiT13GltCB00j2OXtzCO8OTrKBQLMtjHRsORbRvkIEbLTttdA?=
 =?us-ascii?Q?yf17iVo4BFvmu67TtBsm0Xi1YWqfrjEKNPJSEvIQ/Wkd8FDhDMUhUeH5LEqT?=
 =?us-ascii?Q?nnJRczbcBfOt/G6hEicfYXpaLJmq7kBqslznm4OhQnv+60w/zt0L5Ayyh6MQ?=
 =?us-ascii?Q?35nvYlx2S3C7V82qLyhsCZouBp2WZWPTtri3sCGz+JsK7nGUYeqqnHS4rZg+?=
 =?us-ascii?Q?mM6qt5ZHFUjc7jL13DTrkQWqIRLcjzY+LMZQInw9tAi3x0H8AGxMBzdr7xWZ?=
 =?us-ascii?Q?pwhTA5fyJNlB082fQMvYk6LxqDgon/5+liKBHJMgY1PhRJ1tQZU30rNEfK4G?=
 =?us-ascii?Q?uE4gRhucfhnOTVwuXZLJNxClUgbMcmugSwDOsuUhQTBwt2ADgKTXpm7pFHGO?=
 =?us-ascii?Q?MoixZEJvRLoREUD29dtS4KAeZNFWk5TyU//Lquvu7XEvninUnexZv3HkJ9UY?=
 =?us-ascii?Q?MdFNjXBksD0iHpfV5atkXtgwA+kZis37a25dCQGtzOE49fB1m8MHwGXs8Gi2?=
 =?us-ascii?Q?rPL/8i9lH0RXGFk8xdTmPWuSXcfI2mmSbpp9bLzO7v/BK69zpHXTfJWYemvy?=
 =?us-ascii?Q?H+A5YXEbSP4MDJIL5MOkfBgi0YeZu+f1FDXWjNXJeywCKzVFT8WZROJKTyKJ?=
 =?us-ascii?Q?QGoBSxseBiAnymIMbWkggNE5eMobYscHGyltyh8RwasUkPgl1V/BB6s4lbo+?=
 =?us-ascii?Q?US61/R4hIOezecAlJ+LO1k48mdzF28h1VpLhGPWcjZ7vUV9nK9ytlY/qCZcg?=
 =?us-ascii?Q?7M+n4wuo1WoIfmvAhFDz00YCIi0Ha1jyUdoOmlw9bHnHd+sKzeBj6I1tLip4?=
 =?us-ascii?Q?DCwMAYwINnhAtii0BmdtFBV6QTyRq16l9hd/nwDw0EnFJzh+EIMeATSGG57z?=
 =?us-ascii?Q?ma4QmDg7mz/dPduLfRN3pIW7uR6xBO2Ma3PBRruNyV9Z+EHjMxX2cZY11fx1?=
 =?us-ascii?Q?JVehZvVhwDJ5qvHU9vSnXvmVkdTCjJ3FV0p9wlLYs9uCM8FmWiaxy6E++PlU?=
 =?us-ascii?Q?ZzEirYyelll3l8ysYfGNm6a25oECl68gMGb4wZuz8hCInIMxo/9cKa7U5MZV?=
 =?us-ascii?Q?QT0tlLAJmzGtt+yFSXrXeJCv6+cJwatF6KNWlxjCS5HtMAMxZ6f10fzK4pTT?=
 =?us-ascii?Q?NSlJHIMKVndQXcsRrvdG02I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	r6D8sjaMBPQsH1J0wH6KIaABzRcAM/56kQOfVWPqxLj5ISIztFhNtGcCKgaMQ8UpBWBxFWZYaQLBl0oSDStxlzp/nN0t4LGXu8UDHrVoroyxiF6XF7WuCvoKyBp5KbV4XgJ5fceDZDEpYFi3Chmto3Wq5Av3awQHQTgkjXzFuZosUZHoYRxOZlMolRwSc7+c4KnOTZYAChnFsKUeYVzq/ZxvD6N7iQiPdnB1ZvAey3etqSAmZLTs8Nmj/tSsr90D1OmqjgI8N57W93OSFkjZWKqzjITvlCTrQbtHx4atuVwoHCkO3m/O1be6ThteVxg4yK4mSSU1OcYTBnadfGp06pvo/Y3CYuVsAhjiCstlb9GKk23iiMBpmLS9yIV9qRfp7dnrvcJhdlfmeQXYUOd5XMPhzSnrbPvlgxZvHY54MRg/HcHUWDFmFedjPRYoMMUbNMiEGnAoX1kzJ3EDZwPSqTzA55iFPXu0GWqffEKuTIN9/tUDF1LrNwO7991cK+Mbnt4U6hGKXETZGKPngrTazuHdOmRS1ge/wJA45mX1GVhOHptDbnvQIyWEgCwu6PWt66kQRMOglllZxVRzmSunfHXWUSdxsyGLSHC0cZUlDjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14a6e3b-cf1a-4d06-338d-08dc80cbf867
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:14:31.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03J0WzpPt9KRChn3IJV47s/zohRH8JCojhfl2V5BAVE+OUit2y+v6knQ0BblRXXDiVVMjtmTmuHdcKONY7sS0sINdvqigAN4grvjgnk19FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300127
X-Proofpoint-ORIG-GUID: 5aIngS1k0Gs4WVWGAHgbGe_FnU8F0uBR
X-Proofpoint-GUID: 5aIngS1k0Gs4WVWGAHgbGe_FnU8F0uBR

By using a folio in scan_movable_pages() we convert the last user of the
page-based hugetlb information macro functions to the folio version.
After this conversion, we can safely remove the page-based definitions
from include/linux/hugetlb.h.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

v1 -> v2:
	simplify pfn skipping logic with pfn |= folio_nr_pages(folio) - 1
	per Matthew 

 include/linux/hugetlb.h |  6 +-----
 mm/memory_hotplug.c     | 11 +++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

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
index 431b1f6753c0..9c36eb3bbd3b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1731,8 +1731,8 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	unsigned long pfn;
 
 	for (pfn = start; pfn < end; pfn++) {
-		struct page *page, *head;
-		unsigned long skip;
+		struct page *page;
+		struct folio *folio;
 
 		if (!pfn_valid(pfn))
 			continue;
@@ -1753,7 +1753,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 
 		if (!PageHuge(page))
 			continue;
-		head = compound_head(page);
+		folio = page_folio(page);
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1761,10 +1761,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 * cases false positives and negatives are possible.  Calling
 		 * code must deal with these scenarios.
 		 */
-		if (HPageMigratable(head))
+		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		skip = compound_nr(head) - (pfn - page_to_pfn(head));
-		pfn += skip - 1;
+		pfn |= folio_nr_pages(folio) - 1;
 	}
 	return -ENOENT;
 found:
-- 
2.45.1


