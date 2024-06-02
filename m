Return-Path: <linux-kernel+bounces-198074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED08D732B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 04:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D37D1C20BBC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20056138;
	Sun,  2 Jun 2024 02:42:15 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E229AB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717296135; cv=fail; b=C9FmynpD2JoIcWYnFybXHtGQ2l0bxE5bd/K3OQxhGYscAu6krnrHUaBgGN47zdbkcubqVqbgrp+1m/3QhoyfM7Z7MpVpFSLYz0Tx6Alxftj/aT/tIN7Uq5LhP4K4uxQQ3P2WSAB2Bu+bH1pgCQS2k39GTRkFceDCL8yl0vY4sHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717296135; c=relaxed/simple;
	bh=8IegvfPG1/B0M0ruq/DA+25Lu08rPTEOIjTnWUD5mbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBNO79epWJZNFLmdhT3c9VHf/RFBIH1gzTLus0MkF0mA2t9CGlcegZG7Jfp1EaJC+J5JbI6s07NzLWI2TGsginjlN/L9EPFQO+sNwH7ohYuv4Cet0ahJjbnSZIFrPOiRQR/NWF23my0qj/dGHumSqSRev2tQqTLGDUGKlP8KCso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4522f7SX031116;
	Sun, 2 Jun 2024 02:41:55 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DgmauuCVf28Mz?=
 =?UTF-8?Q?d9xpb+dT7mgbPCk2lnBk15VRsRGeG0c=3D;_b=3DngtapjFBEy+KlvIkZQsPXoU?=
 =?UTF-8?Q?1X2wR/QxnH5u9Ya3QZvV0qLGTtyIG6wppIm7EobZ7c7aN_G7MoEpQqxQgkeXAXB?=
 =?UTF-8?Q?HmsgQ4AIUw+MVOnybUCHaDlWFwRaqiewFI8VxJPygbTCXuGX9zy_lvPoiXfp+oo?=
 =?UTF-8?Q?tdf56INDP4CPtPp33+F88RgUSKX8LU0FscKtZZjEaI5p7Q3V17FW3JV2u_iqLNj?=
 =?UTF-8?Q?pUZypuvIsIlJIH6Lc/4wFpHP01undhFmNZjIuLFqR3IW7MugBff+FCKXgMt7I1m?=
 =?UTF-8?Q?_3FaRhWBaK38B+lsAtFQZQKNVtEE6WOXrZgDjU48pMkymwtKqcqYlxNNsmB5jLz?=
 =?UTF-8?Q?9TCo4H_wA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm0tby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 02:41:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 451NLtfY007173;
	Sun, 2 Jun 2024 02:41:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yft355t1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 02:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsqSilNcWvNjRpRyQc0QE+NHkUI91A0kTDRJVbuJ0I6jX4Jw7hKgjssio2p2Ko7D7YnQXapnbhtl0cSbHmfIwQoUr0Z+gWW6LMAkoyRjGrWIY5mSA4R1q5YVgyr4EGQOv00bsuXsfvr0DdtaOBATjvxLD22F66PMdeaJQf39OYCHdoxCYEYfn9CgWa08IZaffPWJlHxyaVEenDTlvhq4Q8t9aPCwm7D054kFW0B2N3G2ONLVwwkXQ71Mpm2NrxlqrdcrerVKrZZIeiKuIyS9kUq5y9O8lrJALxPMmFeokJ6C6gEEHIEQBc3+G84BrKlnfWzUQta1cYPDwDoH0bTSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmauuCVf28Mzd9xpb+dT7mgbPCk2lnBk15VRsRGeG0c=;
 b=fVmPMTnBOTbz0ExeueEXjReUF354ieFXiTwZsfulb3AKQQAS9gZK/d9hSsDT05ypdnnE7WH+YSCge2v7W2AlGGxvcGbtvtpTgtwcGuud7LTO5wF+wa6LGoskLjEGMn9AQoOV7ftxgUbKKwXZuGaBq1R4LvF8RBNU+pUU9Mjoq3c/1E++b4lDshGDYfGvf9rwM8mVx64CY3SUZkgnr474UGuDq52qGOhp6kJw/3Y8Df/WJcGpezp0tAxZhwZ2m3lAvsJ/ntigJVAg9LM01Avjc5UPAaeHtKPZXv7XV+Q8qFhp0Tt1pD0EQXg58botgYqs4Ektw8cto0DYjaJHex2GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmauuCVf28Mzd9xpb+dT7mgbPCk2lnBk15VRsRGeG0c=;
 b=J8Kxtx3GVM4omAlqdgO8fbArXrGbrboWodfhTgZTR/97W2gyhid44/J+YDkDhVrHfVpehyoi03EP5Ei8+uq6GvCeAJd8Xo3F9HqIy2304VmM6zx8ATdAQdzxRCNfaGGvKTwQgRNr7zQK19rW8hpNdEUb1dtO7XxXHtatSejBMR8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sun, 2 Jun
 2024 02:41:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 02:41:52 +0000
Date: Sat, 1 Jun 2024 22:41:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jung-JaeJoon <rgbi3307@gmail.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: add mas_node_count() before going to
 slow_path in mas_wr_modify()
Message-ID: <ntycfywrhmt2beba7pgyxmahwhncufgnpjxjobl33f2tyrhzpb@cckdgisyqlra>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jung-JaeJoon <rgbi3307@gmail.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240601025536.25682-1-rgbi3307@naver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601025536.25682-1-rgbi3307@naver.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: b774fb74-7406-4b11-47e2-08dc82ad8f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|27256008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4sMw5h/TfJPbVL98FAH9AcIz+V9oyjkJHHZVV0Bm0br1E7wioInL4NEvvWxE?=
 =?us-ascii?Q?fmTFO2nzIsN+aWPFONEyKB+qO9UBR/SoQXsfGNrSDA9yzubvtpir86GFb4h3?=
 =?us-ascii?Q?U1HIar0PNtKJzePeVlRxr+q4V/mu4IQ5qDT1dVScQaqX2fDptlnl2h4GTLRE?=
 =?us-ascii?Q?u6MSaf8fN0Y3fK8Fx198Qsh1EWxw3QBMTCpqd1GvZWJxk3/EBpJomLKdeJl8?=
 =?us-ascii?Q?tMB8XkGzTo65YkXF6RPQyVp89ebDGoOMWYpwazruJ9ghV6VjYwivJsFUGPZ7?=
 =?us-ascii?Q?z1Y7Ev9X0STzm1NpB61nvacDQZjmsehf8EuYZNrKbvEyj/MD9oe5reREsV4s?=
 =?us-ascii?Q?YNBb0uwWa7yygPP9NZHkO50hJtEnrSFDdsDK6QcP3GtaQeXxLhHUTkLzBQmQ?=
 =?us-ascii?Q?cZFW22GyFO5VIbdPBlNniBNwiNyj2NTpSqW80zuLaQNP+zCgj4H2z6D4UCks?=
 =?us-ascii?Q?QzA39TfR1BKtdSpJH6ezb4BFZnsFbt3GkQkDuzlFfPhsdIyixOR5kKAfpMP+?=
 =?us-ascii?Q?0Q79HSdH75PPGGQx2ExqhYhGBN9UUNBwDqEFW1y0LOJItqg3tzTJqOJRG7LN?=
 =?us-ascii?Q?2Ddk0X7F/au1niTZHhw+XcfNu7BAxV3KOJyjvfF3xLSoWmlitWD8Hc9+PolZ?=
 =?us-ascii?Q?4/E1VuQ5xn3Juy0QlXNEb4eUFB0PPgt3+g90M5vCYpQ3BenfPvv/ZLACcKS+?=
 =?us-ascii?Q?xo/1MWC+RRsW/mFJ18nAnVtO0hU36I9EEsVYvbkdb4taZxEqBpQsRcEkfLdW?=
 =?us-ascii?Q?BSSfs5ojqHQwmez+MWFTq7X5ca8uX2JWrnMSuYxA/9d+y8g8Mtg2n8zE/LMP?=
 =?us-ascii?Q?sTnKLgvTKSc5s7sIzTseFWNyqoamSUZwXao2v5kJcuBABIrVZm8ksMuo0b4X?=
 =?us-ascii?Q?HCld2/HyQLGd9WSC8vBRioWFffpSSVBlFTVMWy+CxA6LwH3mJlSw/zrLoS/6?=
 =?us-ascii?Q?F99fl85NB+0cYTW8HipgW261Y9SRPJ8K2qbRP6c405ESIMulFhbUzzBZiNNx?=
 =?us-ascii?Q?AD6oFSOoXEom2Lq9FG1B/J3ulKHs3xzPMcAiWAmMztEz6uOVAUBKypQtInHX?=
 =?us-ascii?Q?7kEBg6dz2aO/cYNgZKw5AuGKvJCrZoO/42Dsf55sOAZ0drKrriGH+CTj0C0i?=
 =?us-ascii?Q?aGov/J3Kfb2Hu0J2KcpvdXVmyVmXjZ73xfTQ/s7vQsrHZcZ1Ra8hNVHnGYRu?=
 =?us-ascii?Q?/HyP4WyF1Rzlz7oTZiWikdEMZnC7lPLvMMo6mwK9KbJOsl904+i8bl8m74bJ?=
 =?us-ascii?Q?EYS9JDXQm7pBoerxIq2onSJ1vwEbrkr0cQMvgGNzCQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v4Bqc3qkH+v8yfbASO1mtjSCdkJGO+RBprW1zt2XfnraDDQJZByeUVYRNT0h?=
 =?us-ascii?Q?LrnDQK5YPFr8UW7xQ1TpWMsT77G7KEFTROgGqPmu4GHZoOwV+Z/D1qpCnwsk?=
 =?us-ascii?Q?Ep5kkysSmZo6ef33kF1rC4QHc6G897KSpaGcbAfK/9s4IGlXxm02RD/v3zA0?=
 =?us-ascii?Q?GJF8HcyCnZ7Hz3nX6i4Ne+WH1JZfc1ATcqDKAQhg7qiuhOsU6zbNiLwf9icJ?=
 =?us-ascii?Q?6dTXqvtgqNBoVDx0fWgUatZE3ZwNkh6ClJKtHZWewLf60iqwJOn7N+lNzUJD?=
 =?us-ascii?Q?VC8MNcQAMb8KH668dl1jH4TMWayP29ntaHSgVkzFyndAaw7BqzUrK8A1rf8U?=
 =?us-ascii?Q?Ri4zE8i62zgp56HVUowFkdLfX3oY/p3yOnVoxMt72lvf1GGlaDy8gR6V/sww?=
 =?us-ascii?Q?9HspTrKZNOwVJUlp7sYgYCM2fqdputB/56wH6NEh0q8OchVCsu+cg0qULvBV?=
 =?us-ascii?Q?lLqL4vZzz719A6GMxDbe/6qF77tsK0ZfS/HfQI3LwrbBP9OBGF+NTsHrjdvg?=
 =?us-ascii?Q?dkkPpLE3oMff2yvE9rEdNs2vckQuF/m9xqo9sgZQSbWG1xoXtg7l/avEnzrf?=
 =?us-ascii?Q?feNpwq/Oi6x0CP02Po1UydeQ4r+Kq2s59Tq9pnMnihZnAXdO8/8pCShFYgmL?=
 =?us-ascii?Q?eT5s0iuc9nnjoHH9tmbR3aVJ77kI7TYEdhxwZ9G/hjQGgNyUl1i5/+v6KAFQ?=
 =?us-ascii?Q?IHEmaN0QjfQRXgvddfjLRn+TbWE0CBM0xsQ9NiHP0kzLka/gxnUn5Pg2pjV4?=
 =?us-ascii?Q?azp2qq4WQBvcV07xhBNFn2rVtD3vfCBp16T+lV5QBhqUODk/DiRSh/DJpgI/?=
 =?us-ascii?Q?kTU9H+17xgvzhzja6s7tz6pzFkXOuZBdJHJHS3FZit6Kl6WuUmIRQWPsYr2O?=
 =?us-ascii?Q?dQr+b3xtWV255QQOObuOCt6Dn5w8eY8hctKXU8Y5AcgBeSMoEh1lycofhQCF?=
 =?us-ascii?Q?Nf7uv+KnggaWMxorOG0U6xaeOuUc58O6pkJGLQYRf1sRCP/oZNtfUWFiiflg?=
 =?us-ascii?Q?+idaPGQBlr+YQ5fCG3UOXkuKKMO74ifJlXAAsFkH7QFh6uJV7BpcvmPYyCMG?=
 =?us-ascii?Q?dqT9gcaoUS0cEBcBSM5+PMF8BYKkxwQgdCQkOznRiY0//ibs11yxZbyUZBf3?=
 =?us-ascii?Q?l4+wXH5ixeaRms1A+O8uaNUOgTJimXlGszvzazh1pT3PVPHKgrkxX1fpnGa2?=
 =?us-ascii?Q?LZsLcM01UkgYOv/B8CWIFnhcQ0ucv6IIcKRSgn94BsJvoNDeW7bEe+yMRYib?=
 =?us-ascii?Q?KwSeEn/3XQ4SsuZXOBoz4vLVe4nTpJsxB+gXcmmoPyfux0vYipFwRodAxOWn?=
 =?us-ascii?Q?yLpQqdrgdJI+1CO2lxL1acVpviU8dVV0HiPhBIIjVfDrsIpCgyM/58eKMb0t?=
 =?us-ascii?Q?aGyEmhr7MXt8A1jLFlcP6w8UoyQa0AoC9PEAZJneA27nuttvWyxhAgNwv0eM?=
 =?us-ascii?Q?kpw2Ft0eEIXy/T4bm7L9VhAKzjIiEbtH8YK0DNcVcI6WOOgloReHhucer5YE?=
 =?us-ascii?Q?kMSB/5lMXc+cecZ5XedVKa/NPPZEpUuozLkcrOGBIpwoP+rnHAHEPXLV5CqQ?=
 =?us-ascii?Q?0Hw1fI2ODNCFLfdvIvwEADKDXkPvF+Nbjf9sLYsa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9A6z6+lmaAy1GkskrShTT/+9fRnz/vEY+QKZZ4xY6AZx3zHh8dEiDyuqdy7LpvimtZ2oKgWUE99KBSU+OE4DWTKQEnmTu67FJfTBK0W1UtK0Pz7FmmC3IiMRjIJywP0kA747FbJUoDD6V6WpXAkEpTD6SFzvT9MmicLobt0MZZjSHA1q+R3vEXSz06wVdgjJy28CwzGoFNHFFaDBNi8Hm9eEJ7oZ//MJkkgh1bRYjng7X1yLAKbj1RcXy70gkHuYYF6/MienSNLZoJPKwQEzJmI8/a9E3qQ6oTvSmGD0EXH6pgS/M2wa3yjWsdvOpY4jLvJ6d5CujDYSxzmJ9TYAp1mxt92TocK7C+wBlde58m+xvxDfBCSWCs4ndGOf73WlPbT6/d6GU3BN/OtICgCPhhNtleaWVLh+AMsqKct4f/Jsjv4fKH7ziQhUJAza72SOZZOZN0ixo7zw8znN1jtIbF1HCVRy9nJ0zGB6epB41Y/tvw8p8wFv6qqq9xP18zi+FD0oMB5XUsmBXsJtybUnnXBPhidzLyYfsm/zd+2iw+aqWjiV3qvJNTawr0WhbjWauWMOC6KvwePRGmpNXhQGjhnw1wmls06Gvc1ep8P8G34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b774fb74-7406-4b11-47e2-08dc82ad8f0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 02:41:52.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9tHVsQ42ideqvPArA1FhYRXGN5B32udKY0CMnd7HRvfxg57CuXcwNG93btic2h6vfrcNjsD8XQmRonZX2rbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406020021
X-Proofpoint-GUID: IgwxNoDg3hMFv4hot3c3LIWrhAgDVVpS
X-Proofpoint-ORIG-GUID: IgwxNoDg3hMFv4hot3c3LIWrhAgDVVpS

* Jung-JaeJoon <rgbi3307@gmail.com> [240531 22:55]:
> From: Jung-JaeJoon <rgbi3307@gmail.com>
> 
> If there are not enough nodes, mas_node_count() set an error state via mas_set_err()
> and return control flow to the beginning.
> 
> In the return flow, mas_nomem() checks the error status, allocates new nodes,
> and resumes execution again.
> 
> In particular,
> if this happens in mas_split() in the slow_path section executed in mas_wr_modify(),
> unnecessary work is repeated, causing a slowdown in speed as below flow:
> 
> _begin:
> mas_wr_modify() --> if (new_end >= mt_slots[wr_mas->type]) --> goto slow_path
> slow_path:
>     --> mas_wr_bnode() --> mas_store_b_node() --> mas_commit_b_node() --> mas_split()
>     --> mas_node_count() return to _begin
> 
> But, in the above flow, if mas_node_count() is executed before entering slow_path,
> execution efficiency is improved by allocating nodes without entering slow_path repeatedly.

Thank you for your patch, but I have to NACK this change.

You are trying to optimise the work done when we are out of memory,
which is a very rare state.  How did you check this works?

If we run out of memory, the code will kick back to mas_nomem() and
may start running in reclaim to free enough memory for the allocations.
There is nothing we can do to make a meaningful change in the speed of
execution at this point. IOW, the duplicate work is the least of our
problems.

This change has also separated the allocations from why we are
allocating - which isn't really apparent in this change.  We could put
in a comment about why we are doing this, but the difference in
execution speed when we are in a low memory, probably reclaim retry
situation is not worth this complication.

We also have a feature on the mailing list called "Store type" around
changing how this works to make preallocations avoid duplicate work and
it is actively being worked on (as noted in the email to the list). [1]
The key difference being that the store type feature will allow us to
avoid unnecessary work that happens all the time for preallocations.

[1] http://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html

Thanks,
Liam

> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  lib/maple_tree.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2d7d27e6ae3c..8ffabd73619f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4176,8 +4176,13 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	 * path.
>  	 */
>  	new_end = mas_wr_new_end(wr_mas);
> -	if (new_end >= mt_slots[wr_mas->type])
> +	if (new_end >= mt_slots[wr_mas->type]) {
> +                mas->depth = mas_mt_height(mas);
> +                mas_node_count(mas, 1 + mas->depth * 2);
> +                if (mas_is_err(mas))
> +                        return;
>  		goto slow_path;
> +        }
>  
>  	/* Attempt to append */
>  	if (mas_wr_append(wr_mas, new_end))
> -- 
> 2.17.1
> 

