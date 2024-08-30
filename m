Return-Path: <linux-kernel+bounces-308004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A3A965614
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B5B2885D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888B14A4DF;
	Fri, 30 Aug 2024 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQjmBPQX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gfJWNYqg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79B13777E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990489; cv=fail; b=S0TkpMCGxF+SEyNdk0+TaHz5j7iw3fp+voY6XeCMfgqZNt5bEqBfqfT7LlRv0UBvC5Di+TdAF+Y1079FvyGe48iqlTL3k2YKRSzLBSxXNCAPesvp0W2h7YDsHyCpl7KK5DCfAtrtauqOCimh7zprxV7OVWkGllAo0BwjUetTLDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990489; c=relaxed/simple;
	bh=4BoDbH+8BYl2x5PGXsKrkv0NY/DVKc5EY8nphVnMq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7VfuCpGklKCR2WCDp9QzMU7I2blIm1psGPqn9upOQkY6cKZYobSy5dKcz+G99aAxDg1+76Ozjfe3RR7bmnl5GbxigfyEQ+9F6h14dNGkbbR/f0epQyekZ0pMhpSKqvOzu8VgrLq+pdKJE8hEEIG4BVnw3VM/POmHRUqdDyUF78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQjmBPQX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gfJWNYqg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2uL9G019681;
	Fri, 30 Aug 2024 04:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=; b=
	AQjmBPQXpnbQBV8qZSKKb0F5gMq3c3RqIDjJuUwJtY9Jc8zWSqzrzmgq60sFkqUv
	DQTiyZoKTdg0tFsxWKxKG1jeWB6PKxAqtLxyvJmn8JGrG83S84WHEKtug+ogL0e5
	CiCck/4YSwP7LiSU7eTiSiSv85xTB4309rkWQnp+IOmvV7HFArKACEpPldO9biol
	SVoqpv/dEDdtirhJRKTBFhzpBqk2ixUz/hf2DiRL4pimvBa4T8JPU4QB7QUJuAjU
	/TnvdfRC220S9zFeFxR2P+99ID23aE+A/c7RCM3aTFDtkZqqAtRQJ6StC5bhjGBk
	VdoIfsx50c2Om0JRBt4pTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugwrf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U1ZDJw031876;
	Fri, 30 Aug 2024 04:01:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0xj8bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIRIU8OIhCVS0o0GBPg60MfNCgmHafjhradbjClNoYTajyHVMTBz6vBgNtUzwroEDIuTPwrQ0jqvIdMlYwz2OifX4wbBhb8M0e05Isipm3cewdhhq7rU2q+5RIlpYS0bEKxx98FGrLWpJ+bawea1oVhKYNS+yxQYzgnHtPLRQafT/3A4StBR26Bjd6s7oI0wMMIcUPKP4DnIcd3bYT20AGZEqWIeqTP40LM+NIw+HGRx+m/NeBkyIpHGL4aju+CN00K8gClzfZ7/kG2hGRAQhRvmcACvm8Uc/34zz2VQvrrUh1vQh1wnpcgLmFABz8nA3KA7QJUSzs7OOomcnhXQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=Kh+2W91I2zNTpdZeBi1cLszIzjGh9TEA83LWPtzDEbBlxWZBPb2vkDYNAOiF3cl6x3RUgr+fn58ZmZ2DeDkVa10loKQrEkKlkvhi3ok8gcqG/G9e6h2hzj4aKnaS9yJ7M8xnXc1xLWCcDedbu0FD9sAoJBhPRjCNVIRDv3oM3tfJnAZkur2+Q28Q8r5RGNfL2YnybC3TxgEdcmrJ3gqtluS0AYTk+kssz/6Q0C70vA85qLChbmYzbX2Zdx2zjyMrGo3SY5jTQntZ0WbvxXUVElKSAJc5Ez/cdox7cPu21junPPeF4NwgigM7xalqvMmMIpmGj8f2mjkPrnETK5CCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INR2A1cBDUV4GAxtVOjXNUJPR3TPHjuX5sIyohpW8AI=;
 b=gfJWNYqgpZwI0YzjigOrS2fW1nelLWVbRxvSTeZKsQDpB1P+jelRsjswo1/WOeCEpUpR80ay50z/ClXrWcMLOkGu5S08BR9O0Z0yi/PXHe2t7AnyDQnozbGCGZ9KeM1q2OU3yC7y/JuqhXiM0oZeXyz/WYp2mQWr2slYfHmZemw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:12 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 03/21] mm/vma: Introduce vmi_complete_munmap_vmas()
Date: Fri, 30 Aug 2024 00:00:43 -0400
Message-ID: <20240830040101.822209-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: e0359c68-95c1-4b87-fd1a-08dcc8a86333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?spA5QsMnlwpTykoQjiU/HcKXFsVOPTNJLbVJgYBBIRrhLO9aqi0Xl6h/Iwr1?=
 =?us-ascii?Q?E7TRbFDwxr+Wks7cMxTQz6oegCqS8Ejcvnsty8cBvgrEZLWZaMlviHrFrE6I?=
 =?us-ascii?Q?s+7bNsxeKBiNIxzTH/ndehBkHZok2K+6egWeSffkVaSi9PNzt5Kl498Dk98q?=
 =?us-ascii?Q?4Wr9TUlFotUrK5JqxwbuXPD9mi9N6GcFz/gp1SsnE+xusyEEL7703dLzvT+U?=
 =?us-ascii?Q?AayL879aUe8JhNf6hJO2SUizON3X1s4AQUu3ngnZew3eK1DOZLGhMQUf+KuU?=
 =?us-ascii?Q?T/Yi0dX1Mew9Z8HxYE6Mpg7mR26g5SCkSdbJ5zsueRn5pxtaNTjMAEwi8DDe?=
 =?us-ascii?Q?TTW/BtT2OxaVDCe00Sh3B73sp8rkH9EgJZSh+N5lyJ7Lets57XHGrrUalXRW?=
 =?us-ascii?Q?lVz05NBrs59m8o0D9ePvQh+mZbsdP5ZxBr0NqwA3u9lm7f+f406KGU43b6P2?=
 =?us-ascii?Q?A/aMkg2YFhRIJWpkJTG4CxkMTXI0yoEsnAIL/hZ1BNTWJP1FqZvJGQC7ORmO?=
 =?us-ascii?Q?ZUfOB9opsk9oZZbAbV9WNTSAVNjagvluI7JpEG7Ek+9JErnV/eelYWfOfvgU?=
 =?us-ascii?Q?1KqbSNHh106e4kXssUy7S9MSROe6epNChLqlC8nWnMMzsTlFlBblDk45Lkf6?=
 =?us-ascii?Q?X16ovOXjzBzepZOpRERs/z7VN2lFD/8Ls/tJPbyH4reumwfL1PsfQlxscH0h?=
 =?us-ascii?Q?zuDfvFMKjOys3OEc2qYzkEVGKBjjZNndF+E87HVHOPyTTrRjLZaMaf5bBPgV?=
 =?us-ascii?Q?SF+BNDQFy/zuzpYm1IRE2gjSYm24dYB2jdpU+/j2jucfbmAMNyWjem38ZWDP?=
 =?us-ascii?Q?0kAlMBy6OONS+J94KQow2kWS7pojG5ZoxiIqiMPj1g81jWzHlsk4SP1agFUm?=
 =?us-ascii?Q?6fBw1CJEfnimhTUEcXo3+bUw6xcXHLUrNz8Iy6GdVVNLqLKrsRKDVvtDakRf?=
 =?us-ascii?Q?wDiVJEZOyGOkSVDqUM+LRjN65o7nJBkOxA2fjpImdzBtKkQ6IC4ARtDon2FF?=
 =?us-ascii?Q?npnL/h2vG+qYUI/XAedFE4dpqZr2FwXDCso4xzB4Ebe4aVrS6tjkgK8ATKO6?=
 =?us-ascii?Q?m66uslnQ5nUN1FhZR2FbanV0yKEUrRQKlrFUPYN0MHsQWG5wqWLpYJt4oflq?=
 =?us-ascii?Q?nGyb9Z6CrdnGhntKbTbwemaVHGcIPBGuzHK7jGVOfe55WIYgS4EZRN2eHfxk?=
 =?us-ascii?Q?M4ck63bGEvlcBjkuT0rzddELxi1qfeBr5lBc4lwL+Vluc6OKgaD2xodXX5N0?=
 =?us-ascii?Q?II4IIId4ECJ/eNjnOjFRb8M00K0Ndt60luS1QU3d18lTZeN/96EAWLYVJwv8?=
 =?us-ascii?Q?sPYe3js/7KdgniAlW7dDRhBC9KjohWuiKtYAd6P/rrB0Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIxW3ewT2VNYrK8RKE0IVO/cXRQd3H95VQ+jyhgNpsqUUkQFIwgfn7HEpE7q?=
 =?us-ascii?Q?UpR002GjBtyMjnWvAd3E4lPJEJb+/Epv81uSJ0XVDGiLqaAcrky+DbO8bwvs?=
 =?us-ascii?Q?yX3vtSVm+g6FzsT5OsUs803e0e5ibS57by4D2hpioKcE/phRbYlEDgEC7TNa?=
 =?us-ascii?Q?b6cFbUNfsgyjh2F1PjZl1hOIkN/XTebQQ+SQUL0Q6q8F3i7tdtWEmP0PUuDl?=
 =?us-ascii?Q?9jPAM6Gwwkc2q7E0uPFZjAIYXlggk8IsNxna5t+9dxsPvZu7Naqo0OVX0752?=
 =?us-ascii?Q?xntOK5bPBb7WPk1/Dem3ripl9+4Zokop6DMR+1RBF4atqoR5WSCfZ0f6x774?=
 =?us-ascii?Q?2f3m5KJZ2VqPp8vy3edTR0q+PD5/khPzxl2iDS5q0fu7o+mCUhunuP8TVmMz?=
 =?us-ascii?Q?+WmRfaLIq9c9ANCW4YR+keRj1ebyz8whYowTh4ysQLjccuNb2Xgl09UiXIv9?=
 =?us-ascii?Q?hRN4E+QKhmsM1AJiuRKNrnvqnPcbHwQVmhVrKO4PzicJ5q/dbuYQ2hW/W4KQ?=
 =?us-ascii?Q?SuiihdLRI6gYvAS4YF37AUqgPOODupdKfm7qWulVFSEnr6z/ZY4jnMeuGEJV?=
 =?us-ascii?Q?etcYtjeCBwwhRtAmRUabr2HvAlAskd4hNVMZ0F86GQ0pOEY91qgXMV/lXadZ?=
 =?us-ascii?Q?vCF1J3vHIA2wVVS58DLLrVF5g7TBpcHkqgeMYv7Pyl9mMHRnadDcLanLGLnW?=
 =?us-ascii?Q?7CU2XZpNaxtAFrRVZ9duw5YXzIFSgvBw/03k7fx2Y2fRDNaRtNfx5P8lp5pX?=
 =?us-ascii?Q?akNVeKwmG7hOk8K6VfBD0JotEKoEBzmUqwgDaxI73Fgg8g/U38y2lbYeaflB?=
 =?us-ascii?Q?hh6xREiJJQbqQ7P0b3+jlaGYRyR8Nhkwpntr7GzRcBRngf3kELpFHFVFKCnq?=
 =?us-ascii?Q?rBOs1NANL3os5M8F2RbP8kJJGY+thEoit66CpBxs2W2/0Oeex2LByyav8BVN?=
 =?us-ascii?Q?+XwsuzDIHb4+5UdJw51upA/NTn5OB9rJ+dFliSHo2mXkYlJ1yAIU0FZ4AY+A?=
 =?us-ascii?Q?jO7ryGhimpXgu3sVHkqHUtp2t6aQCZeRK5rRVyPojZJhg8A93Cc+HNAWdAQd?=
 =?us-ascii?Q?2DRDAZBFF6uO7gOrFdTJHQGluFEvZrpSxa4MsS60WQs8Rytrc/uU+S23okpc?=
 =?us-ascii?Q?lOF1xRNYUn1uiAI4cj5QVce4x/ffDFzC/tsPoTxEOAV1mxZABFoxaTF3BWCM?=
 =?us-ascii?Q?1iWkILMMwc5oCQX5ZJxHFXCxeZfD5qEH2PcrMxcc1PKVSj1GnNc0PNl/XQ1c?=
 =?us-ascii?Q?ETYazOr8Ab2gXWtR1lznSZHRV/s3hb+/bI0HVKlr1CKENsd644zxwL/vn10V?=
 =?us-ascii?Q?rNZZW+OIxmTYVqSThwKaO7anG2yF/qY7ckF504/TxGyCGtzOTaURoV+5Ojj2?=
 =?us-ascii?Q?TsFsZysCRGfpUfuyBY1acNJekUNy5GYw6utzSzdPZ7uBNpSmoWdaf+4MhVQa?=
 =?us-ascii?Q?807hG8sd3f7bvECrEYSR6HTsana7l5KkDdggRCa7WH6I7alilg1W7eQbXwaM?=
 =?us-ascii?Q?w+o2+nK5BPCod+qlHVRN5xoX9Gz7KtUzgJFD9nc03Sb4fZdFQQsjzFdx4aFp?=
 =?us-ascii?Q?Q5enBZVoy1T1d4CcX15lP4Vuqk6G8I9/S3kik+H6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a3LGdxkTbUhk1emIywXOVp1QlCdaBB8sL3iW4gAjS25VWF/5aybL9H1wFc0cMh1O/5Le6ZemXE5vR9IXWj7CwKwb1MO3OUz1+svD03IFUo2WSxlAbhx0tQrNFU1TTxP3tJ3m1iakvRI+xjDOSSAnlCtWOsSmaayHGqgLjgNr7u4HrokSbLFLkjFginVOkGfoIkm8rCqC98H2b0uC/cmcNbX3RBz/+lbWahxCpGHgRmyeRmV4kRgjCpgEVAygbNfLPlrc3TOZctwZyrOHeaMgOe1gGf663d8fFFPJtOtfKzhxlgjIvp2KZYhdcUgyrJW+xI0nS7QS/2uZ7Bvh4rfZSvgF+iyFf1L0S9JOKNv3FuPJ1dTXRku5q+VG9KnXtKZj8kCfsG+hwX5/daKIzx6HFwZvpzpvFB8/tOlUyD+n0RVjHUU7tukuzZp++hXxX0/c+h6E2DOdPZ9AvEWlS6tGFkPs0PF3IaNOgB98tfTPtSVxXQgO0mU0WY2iN3uFyaXDTLkE48nGcYG3WGCnwhFZOFpkep46sBFTiKw8m8aCBP5p0yasydX2UTSARBRzGx4vD+gr7E9n4aQELfiAkI18ZU/zwtVJbseO8fSYQgQ/Wo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0359c68-95c1-4b87-fd1a-08dcc8a86333
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:12.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzZ3R1P9HMI3La9JRZCLl0AUhfJrDGwsDCVlLMiznT7yfdwGOsc7HJ5e09mhJSbru6/vCM9rTnb7QltLcL+bjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: DtnEtIF7t-cLM6Qf9quFrHcgnz4hQKEE
X-Proofpoint-ORIG-GUID: DtnEtIF7t-cLM6Qf9quFrHcgnz4hQKEE

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 80 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 58ecd447670d..3a2098464b8f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -684,6 +684,58 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -703,7 +755,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -818,31 +870,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 
-	__mt_destroy(&mt_detach);
 	return 0;
 
 modify_vma_failed:
-- 
2.43.0


