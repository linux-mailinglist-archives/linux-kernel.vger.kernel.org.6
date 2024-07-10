Return-Path: <linux-kernel+bounces-248171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1C92D913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B52E1C20AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB508199258;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hi0nUBWW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zS2JARnp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FC1990BD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639434; cv=fail; b=uO1TQqlDm5l7cEH0p36ZG+M/eEnCmrwAnX7zfLAqi+++H9UOC8XGEkxNb2LGZJenslxw5YzTCERfCm6/toirT/GPRK1B3fZdXYak9LE/VYvQrp0Rm69RM5/QiFEGGpBLV3F8IpbFR64eGUphYf7kK/qWBb8pJA9NKLbXJCFvG4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639434; c=relaxed/simple;
	bh=4F3JNR0+m5aVDQOZT5NOWHm83XQ5Sr227ZujMVj4Gn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nw2VaZf42jHUojESb3SUz9eZyLI4BOBf3XkiMLrm0s3RZF2LpGsIHgHrgtEGn0XxL0jiuzcNXa0fku/SC9yP7vLG8vnliYBmWzbGCYdi48yIZ2AfoAQ2NGhP3fZxsZX9g17Kj5SlFO3lZPuEnilQPUMa99YNjC8Vj8nx5+6c33U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hi0nUBWW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zS2JARnp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFqbUj019840;
	Wed, 10 Jul 2024 19:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=hg3aFPLWINSO4oMDTznqetTX5TxBmdh5A/x7jDixEvM=; b=
	Hi0nUBWWrDJ3BflUfOKE+R9MwI/Gt47JGLZPciVNkA2yl7FkjvXfJltFUSk6gt4B
	SrHxYIit2dz96tgbt3ozwI3SFlhXQNa8W+gMsFDUaACojscFDghlrS/sr71j+cCF
	fG6ba7bEcjvjsxrmkiZ81UdC9NLMy5prKoDx0auHi5k9Q3v8CU9uDYbtldSDnkV9
	SuHTPijLrMCvuHPr36Z3T8mK6yWV6TI1x0N77KT7eyPzL1Q/pxlIY/fRC2pAxGPQ
	1M6zafIPNqwdAvt1fNb9r2Oe+c3t2Zm3pB/k2joxWA7sfAfpItxvuNsIB+wfz66R
	OJ57pLPg+PfOzGuFCTA+/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky83qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIs3bj022604;
	Wed, 10 Jul 2024 19:23:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1gwv5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtAOjk0fZQYQWgqAeT86tAOdD6HKU7GEBn3NouG7FQPuaS1/H7lIICj/8u+gzql31UCuW2Wi6Vmd6lvOB1v89CSo5+Pb6pFxlLS7ysPaJ9xCOm43vLg1SGuU0go1UCSbX6A1swSgRGFJSJVeX5m0Zwb+1UOVlExPVBVdkUXXTRxoaOH286JcaloGW2FyvIshlL4O8cl2tIYJIk+O8iEoH1CfRkjBqhntLwgw8PdHzdetqCi+SV/ovkNcZqo2PrJ9yXsWNJEHkHEkw8SUw0lnyF0swusroShI4OnYcCa+tqT8wWgjPOZHBKJPkKw3fffjH5t3palUEpX2LSpLA550+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg3aFPLWINSO4oMDTznqetTX5TxBmdh5A/x7jDixEvM=;
 b=lp8/csz21We9cB7hckyYG2IzWzI7YcLJqNk6uTmRQXwpA7yR3D70l9uMHEK9XEPhzH4sJLDtf2DS4PfX/5X1VflCcPAz1cwFPspBpjnwVVl6TqGnrzyShiWz3Ge9ZCmxu+6q/j2j1wLfoCw75oPB0oOSo9czddDogW0UVwJgRYL+AgpHxn0rxZWtT+pGTQ2TiT7bcYYvkOLs2G2y3MZ4fJQ7rYzN7W4NhvwjxBUeD3C4wxlnNkYYcGr3woj366bJ424yizyhkvux3+VIw1EKGj+mXdZ2uJHcJ1orIFUm9rQeYrv/Cj7KSRS5myFjq8LyhsoZB3Mr8PJvN0MQlv8nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg3aFPLWINSO4oMDTznqetTX5TxBmdh5A/x7jDixEvM=;
 b=zS2JARnpyjU+77PGuH5245D7xyRmzDM92UIpS+Y9T1r9X/L9EJ72sRBudUE3Fcl+mtIblig+sOQIT5TLXco8R3saHUGZrCdRzGNNgWjaKVPROzpMvS+SpzTDHin94IHm+XnrGC8yj4HgXESLOujKHZ1Et/OrUqKpgqIAKgig3I8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:20 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 11/21] mm/mmap: Reposition vma iterator in mmap_region()
Date: Wed, 10 Jul 2024 15:22:40 -0400
Message-ID: <20240710192250.4114783-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 801165c0-6f47-4972-809e-08dca115c235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nKNaiMhJLz/6l2vbGpn9LqD3MIv6W12Q7WMzAG1p8HNfJl9fObYxnqlNXxzK?=
 =?us-ascii?Q?09aHuTsuDdpNcB89DmWi5Y4mEg4IWy2rKiyxkGQM6DkfQu+3ffKRxtk+MmUh?=
 =?us-ascii?Q?s5nqBr+CA7DFisEdqZku5iiq07aBVpsfutvybppYzy9ouAfTLVvvzDh5kFNX?=
 =?us-ascii?Q?0dCe+oLPP+TFxj3+jh5RL4rDn73elH5XAiBoRqQAmWaS4iL85YP8ZIzP3aa+?=
 =?us-ascii?Q?OxBUd0zHaW7HYVkIpGI3tiRo3XR/+McD9mEq5mnm+5TIcfsKMdG2N7Akjs2j?=
 =?us-ascii?Q?0nZoq3dfZOZ196xIoKFXQiPkI8V501jpXtk/wKTK3YVO2Y3NR8s6iXDJJBtp?=
 =?us-ascii?Q?CNsFLMjDouPFGwOMdQXmT7JYoSu4fAe/iJdygjrv+ve0cpsxlGbHgwdNTEgK?=
 =?us-ascii?Q?h3XtRG2BnYGscNgxKgKmdIPVfU6yOPCPP0WpcrMGly/Pbo2trl922U5jAdCi?=
 =?us-ascii?Q?FwM1lvTHw44HwrjXlyrHlIw0g2kc6JK8YBWZE9DLZVwkMo580XL20O7kLmYo?=
 =?us-ascii?Q?yhW1m8CAKoiSvzrvm7SC+aQ8IsYD7A9abIW6TfhJsMMlNEty+5rzZPyJOThj?=
 =?us-ascii?Q?0gzT+QBU3Dzb2t+vQr2wfQg+WP/BJCxOu12tkCd2ymxeRR30dUjMevtoHXzU?=
 =?us-ascii?Q?5OnS32CX97TDFE5tmekLFn2JtYuEpXPJiMJoDKcvTTuE+mOPMOWUlr4bMymK?=
 =?us-ascii?Q?EO5sd96kxcMDjciqPG6yblFZSE4fe/CNq9TbtMoLZltzE3w5TNikUYTzWcR9?=
 =?us-ascii?Q?bo+sYNyeyrZrSQzAFh0wND34tDxfUTWZwaOkmemFJoVHYVV/IapkWYcsYj/p?=
 =?us-ascii?Q?CoidYo644NjM2S4gz8lHf44BqkF58AkYH7q0CZNtgalcmSn7JRhO/2i9RLSN?=
 =?us-ascii?Q?C/Gg1XEHmOcjjUPY2klPN3h8zQobPHp3CChyuloi4nWw5DmnhvV9yy4Cs/m6?=
 =?us-ascii?Q?5XW/nVM5HKrMBfSV5qnohbSAIZWAlIF0LrcA0j76YjlZ2ssmZkrO9m383A8o?=
 =?us-ascii?Q?Mb14ysFOOzH4J3zun4Xfu8kjwDdIkAAGaKkPg8aBNyCqv5uks8Z/8apaA29y?=
 =?us-ascii?Q?xNfeQQ+zq693uy29Am1Fabo28bxq/O310R32vqOUotLzcy+baDGFYwJFkAF0?=
 =?us-ascii?Q?b3qeWm3+Lx/SZDxfQGCJ4fBCNYs9tozdH8A9TTPOHdRx6fCGcWllq0rFaLVu?=
 =?us-ascii?Q?2MTwKTC1pdvkDWQOb+0YYcWQcJXadhl+B/R+9ENsecb1ZoOUsT535r7ieu4+?=
 =?us-ascii?Q?aGIofkQNcOIIuZIr70fME71KHO5GNEVi7Vpf6dbB1GHMeFBGOQx9pptqrwzF?=
 =?us-ascii?Q?vRccyM2Ns30h3M4sCGmNq7o4/tafNBZcqQxL02K3q7AztA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PSJxlsyQeavdBmQon+b5+4V7sXqLCOiQVobj3liUHun6Fjwt/h4PKChUomnu?=
 =?us-ascii?Q?pDUvb/H3MrzY80jI4eAqrdW9bfKeyQunkgXwiQ9JzrSlvRtPtKHMnKkAeexC?=
 =?us-ascii?Q?JV5Tzl2TR8Av5nvsJtfgsvAwxi+WbftZHKCIVPP3VAho4jzDV7C+uz2RhIgh?=
 =?us-ascii?Q?vcyl17CTVhIBWJ0ApTvbcgry2jOvTcAUHH25jav8g+4IYPQM1i44Xx3UZvYd?=
 =?us-ascii?Q?HxE6d5p78iCUV9XbGa4Pr8qaZu4m0MGN/J6aVSLoP9W8LSNq3PMYkNSOVQ6J?=
 =?us-ascii?Q?WPEpkjAIN4mTcnbIG24XoGBvZBpS1dcLxk0+xZjQh9g6C3aCR5UjYjgAb/pm?=
 =?us-ascii?Q?zOV/p67H5yYhH0M+UHvcghgd4ULngcTkfIe8/EiUtZmqaT3yzqy//Jin8V6U?=
 =?us-ascii?Q?LsVqVKMroO/1IR4viUidA9buXXSvKmtb+mztBlElu4KmYWDx13o2lj5WC5PG?=
 =?us-ascii?Q?79V0WvOK3+wVb4AErmUBjANsxJTRU/JJiwbv1xSI7d41dX65PtQ0szDiHgMn?=
 =?us-ascii?Q?ey+sqqmaT+Qp2N8nEmyu2szOt1EYA3mhtMUl5Uuzz4s0D3ufrHLG3Ah0C6y3?=
 =?us-ascii?Q?1UN0DY+YCM9P1zDxgiuWwRQllo2IbLO+Q9crUSvpU9v4xmGQeljtZBG+NtW0?=
 =?us-ascii?Q?fLb/ZO/9Oe8/M8BkXx4VkRsB+Cik6gwvb8gYzJ+7bprlOAMhZUWXFIS9X0zc?=
 =?us-ascii?Q?o38zljgyLu4CUL9ibQ5ntcrj/CGZquNBsWPTft+rZ/I71bWoIFAoUTwtI756?=
 =?us-ascii?Q?qQqESP+O6E5F0vDCtChTVMwPT9Q1EsHYiGJLwjBffXKgAUpHN8H7HmLmZU5o?=
 =?us-ascii?Q?d3RYyAJcwXuWDzagZn16OSJkSW2kENDmBrOP/9+wqFZaChTpn7/rvXaSxIqA?=
 =?us-ascii?Q?XLIMSJJXTYhCdKJB3ujV9dH8IXhvgmNg6m+amwD59mH7sVJ40Y9/Lh5/ADdv?=
 =?us-ascii?Q?Hib/boM2bEna7+cj1ENDQ3Ijckz0sfbmCX076k/pAxiX+FOh3GNYJG/F5lLx?=
 =?us-ascii?Q?pDFFlv4BfJmknFe1K1u205h3lwfaRtBrNWk+RPxKLFvPg+NCgKO4dK5RtJO1?=
 =?us-ascii?Q?N9h5e89GMpYwfaLKaq0wEl+jgAP+L9dBoniJQoTkEw43XHGslbkN8UJjEqcN?=
 =?us-ascii?Q?JTemyCVVHNlQoIZkNqOJp6nT9Ao2GHLyQ+cPPfXkymAQYWq8w1J7ze8ENg5G?=
 =?us-ascii?Q?oqw2e3eWP5qTOWp/B2hsuYPkIYjYfr1U1EKRlSY2q388GxkqDopICoQN1cWF?=
 =?us-ascii?Q?+bFAvDB6zXQXj9pNR6GuIpJS3S9JN1P2h1m0xbZPz3UEf4d46sWYmnFeqUlp?=
 =?us-ascii?Q?1GYiX07iBFZIQZJ7/LjpxzPH1vsdE6ITcS9lOdv5oiCVWtEqrn9cxI6nO1VE?=
 =?us-ascii?Q?0g8KMmNIuBQCG+SeiTLoJ7nxAtGA4az1EjpssV9dXfAoaLNRMutBXcdWJ1f7?=
 =?us-ascii?Q?KpQ5447u+Ht6JqFlaKk+qkjk/q6k2JzVh09pfYyvZj2JICly2Md7WP3c7VDU?=
 =?us-ascii?Q?wj554a6wOwSHKVzBYytmjAfmTzaUlZNR1sKA16jqaamRGvMW+Qi6Wo0KqF41?=
 =?us-ascii?Q?n84/ZSv6Xyt411BgMF2JlGxefy/A/LpPmybzHXOoJO8HJebq5NxTIraOJxFZ?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W2O9+4n5nhIBTtmxbUMx4RLxWgAULGHp9e2pKeF1XVmVfouqwOYMZTTWgPfPzKJYUbLR1K+o4Jp1U9lnZR56tzisdGi+VMQrgCBR33SqOqGnmZKI3Mi10hRYI3bTgfQDguVKNyHAcEmZPDiT1u+VL53E6ewGdA8e/R2Ikfcs4p9nUmkQpXM7orKOcQp6bWpgg8+2Tam9tQd6X+9M5ctEY8h5Vz5XO9oG0Zd2Fd5uZWb21CUTZlZXWy7dlnCS/kx5A5Mt/eN3asFkAuJ759Gy9sqh/IlFd9A6ZtPdKkTbdI8na8CzXAaeUbEUwQI/y7PDpomtw4V9wc7J5KBKPBO5WlEMVCMr3eU7I+gi+dgOTXNQO+OTk9qjssxWyz61OrcIbICf/GYQNSpvMt+jG+HqrsDct7EVV/+eCRpyD+1naB7RPH4v3Hd0yfFOguXoFwUQ/PZpq0oNTSC2bsdKU74b08bhre+8Rozy5i8fCnaQHCDcEy6MrigBBcgJ37N4ApDsvguU4FIubngOk9oC4Ao/OzuppBR0RzZV3CYCVtizI5BX0XalRSEO1SYm+kCBUhBEWZ7B3x9TgFf+IxVP7OCAGVG4OhodiBQokhXCMGEKzAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801165c0-6f47-4972-809e-08dca115c235
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:20.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCNkXRnF+C4TXEACPx/hYvdUCX/h4woq+xTzVWyKyXMiBUdyUjx0ZnH5Dip5EdBi+LjBXqWPLYVVdgacozBZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: v4G7A5CXxBOJnuJZDHpxDaL9wuC8DnUk
X-Proofpoint-GUID: v4G7A5CXxBOJnuJZDHpxDaL9wuC8DnUk

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e2e6b3202c25..83cfe575c114 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2959,21 +2959,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+			goto gather_failed;
 
 		/* Remove any existing mappings from the vma tree */
 		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+			goto clear_tree_failed;
 
 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -2986,11 +2987,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -3011,19 +3009,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
@@ -3184,6 +3184,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 	validate_mm(mm);
 	return error;
+
+clear_tree_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
+	validate_mm(mm);
+	return -ENOMEM;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
-- 
2.43.0


