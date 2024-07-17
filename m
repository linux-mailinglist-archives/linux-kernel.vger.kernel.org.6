Return-Path: <linux-kernel+bounces-255615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D99342EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF9D282CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51933185E62;
	Wed, 17 Jul 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZIA1iP/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i4pW+gnO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB1186294
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246863; cv=fail; b=h2YVlgfwfMsP9bMRXM5QPaJ6RMDdF06elkoXT8l/vGWKtN0o6okX4WvtdC78D3iSTwAQ7SuFOq8S/P2Tneo7uMZpQUJ/q1njdrIxKrzSFTstKQRiyGS0zauD4Whx/91uk0zlKhfrsi1IBK63jr8imxn8CKOWIVOhTX32uvcYsSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246863; c=relaxed/simple;
	bh=HxBHxkKm3AhqwDr6kUdVgq6UsZzfrODotR8onovNq+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPqpwEO0rV9w7BmmFPzUqp9A5Ef+l4YmqgRlzZuCftZdQIEW10A0O2N0VGzR82EkqWbMnZOxKNB+/JxWdvT6Kb3qAy9uD2JYEw0+gRjfgSzbNYrzDijVlX2awAIZ9FZ1dsd8PYF0qYpjXQmIll7ugJmYNNEIvnrx8dD9JyK0jGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZIA1iP/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i4pW+gnO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJtlDm031584;
	Wed, 17 Jul 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=; b=
	ZIA1iP/GGVdIiWFx7zHprxM6H79jnoNvqLFAdnXXJwcNikN47hdhnizNe3mEm/0o
	dCyYmfSSy1SqjAxqG5DL4TFcoqEE/UwfJ2Z0AtnoVNCXPI/dfcSljl4w0P2mbeer
	VYWJiaxTXStGpAcymAe0cbbkl3JIlRq3fKrXShghKndt/rnG8pVf2XJKffHrvyYN
	J4g8QONGr0vNoggT5U0JDJRg+TzpMWtbtKowUd++c59EOC/z6S0uuEgy9UoCPOlr
	i3aCJWS/Uv8yVJN4j/XcMuNE1K7ee6xRKpaZwVUIqdkoP9Ux4t0mOZpzSRY6LjCU
	USotMqNbNdgLiNtQwIl3oQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXk006940;
	Wed, 17 Jul 2024 20:07:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8nJvMHJBbDc4gPv0yTVQSd1pgBxNo2fvb0Mj1JOa34/PCKMIsgjYijjAveYEddgNc9WT21QzeAmZYWmwjr7q0rKcDn8MS/oscC5aiJUmDZSkHkEfcap/rkSfDXpxCHvg7eOA2t3ccSCXTBcaATGQmTRxIZZfok8q31Tyu7fWUbpa7voB5u8TqJV8EvmDjcl+XZSWabw0gSTphC5XCB+GId7c1j5lp84J7FLU8KLQyQLQvJ+IkNag8OZylxEseUhzxt/215f0NVS2Zxqvg7XIMHtdLbYvcFBOGeLXg/Ixxe88Q6iCvUmyCBfDjT/kkGerzohrFEdtgjRG/mVnxk0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=;
 b=Bd98euYxD7WOZZaqpN29GWFXFKHDO0iDWWBXnc60ERQQ37/EE02cp/xI7+ljiPdbNhBwILuoHnwKf7wUWmaU1TJPjECqT2edyUpEAZ//PVEg5Zo/DMNYkv4aIPoPiixfT82180P4kaI1sgzo+W//VjCVajQKXG6SLtoC8k5WFhiOcqivuFvBrEpSmWU9PL1Ne0oN5/CVZoUtBtN4z3RCerXQPlgFr83V/NuSkSHgLawwZBvI/PFUQl0kTxHIvJJo//eL2fN9eaSNwl9Q3Avxwdryf1v9mqd3aBbCmjUmvyep5IeqAN+TCJF/yDGyLjcCQkGjmarM8WXqglKGcsoZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wem2AJBoTGHtBckyqvpen9uiSUKgs9mhKNjHQHA0o5E=;
 b=i4pW+gnOSVnA3s7/ntzREOViaBZMNHjlfQNnO29A4x52ADTrbHbMKUxi6u9yvPmPuYIRlO4QcvchTjTxZ/x1gcCi/QZjwbAVK9o+Ln0x+U49VwDJ+5hZCVtSjGnccZSlUmRM9cQSk04duA4dPoiublgUGnIWYFb6m0Hu7Hiw6jc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:18 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 02/21] mm/mmap: Introduce abort_munmap_vmas()
Date: Wed, 17 Jul 2024 16:06:50 -0400
Message-ID: <20240717200709.1552558-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0459.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f43bfb-d2fb-4ba5-16b8-08dca69c0f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x3mJTI5lRr8oOddF8b9f6nxCpq2Eh1YDmnQe0rVsLtv3mTUuGysIQHZPfnc9?=
 =?us-ascii?Q?z5GgoWUog4j93aBdb71fXOZIyZz3rRe7JWLaOHmVA5qQF1jDyiyhaPy0VI0L?=
 =?us-ascii?Q?C3XnIh03BYZpvMfD2NVPP/nUFs/JvPuMqWu5LwIl496bDHexzcuOkuUAenmE?=
 =?us-ascii?Q?XlIbAIRFvUFqL6ozEpxHMOMbhrOXmhcEb8UFfknlY+I2QLOBX6mkNa7BYZwR?=
 =?us-ascii?Q?jLKCijP7jQuXfrXatEznBx7mUPbVwuy/MZxzYLauldfPNCJjlw0aUTpIpxrF?=
 =?us-ascii?Q?XEgvuOC66NfTiQMJBNr2+KtpdFAA/ogKNU2MBsQVBaGXBJ+XXVWlxAgXPE/Q?=
 =?us-ascii?Q?FzizUQBRs6lWsuSt0rckZysqHKoZIrcVqFoJqY48742VjU6P84fDd8xiEJNt?=
 =?us-ascii?Q?Ik3MccAAnu6cG2mEu4BuCM0Ta8t4ihiQQsLRgTB5O250pTtlysUnoJxCLPiJ?=
 =?us-ascii?Q?UN4qVFcWe3bYJ1hUB0gmN2UGKRTx30R/9YkjbN+F7BiylpTYBl9EkQPKf4gE?=
 =?us-ascii?Q?ps43Tvhnz0Ro0jpMf8JL/vKwV0xXPWKgUsXgf33DvC3Es+3M/5h0KWalmHLm?=
 =?us-ascii?Q?LyRmGEYZxM6nloGWxgVBuwE/t59nJG7t/V11BP8JaTB7z/alY5jiUwzbf0Xs?=
 =?us-ascii?Q?WYpeRmbfWRMtqh6BQpkMfH0EM4FJAtivbat3PtdakxAIFtfn+w5gYMoAgYfJ?=
 =?us-ascii?Q?GYNG+QOYnC7PEQTmGav+ds5IKEy+iDBOgasZX83y2YotHcYIw6nL0cp2mrSM?=
 =?us-ascii?Q?v8iW6lHFJifbJSk9s10O33vQbITvRYv8PS9I29FpAQFm0/lFik2PtyB/kgz0?=
 =?us-ascii?Q?peIfx76bCQ/shIdRHrXh00Mn47iF7+z1uTqncjCLEj6St+rswc2lbcDGrhwg?=
 =?us-ascii?Q?V3A/MlpZsNeADoo8RcqXbccCfv3GBY94rzH7pq6Ndiw4GmIw59RGevXFOrtf?=
 =?us-ascii?Q?65d0W77E6sI3jhzunK/JcUU41pqYbYt2f9extmqfnumELiiTG2M4XXj2SEO5?=
 =?us-ascii?Q?flTGcP6mLT7ICkRXIXwdx+/3+iR6Pgfycr9SEK75Sl3xpGztrgjP4nBjj2cH?=
 =?us-ascii?Q?lGvQACrcSO76MvdDNFqcrHRO9NioW0c8K29+CvRGZ9uUUSzLb65v4ZSv8Tly?=
 =?us-ascii?Q?2WId2BECvxRrDRQWstv3/uYxH1Pydy+xf8VSyJFeZTIsFLo1f5+fN/KWrGBj?=
 =?us-ascii?Q?yvGgteOXzH7LbdeoeKwMXfw8e8Y1QAq0uHus8F7LYay8CIhxRq1FolCymSOa?=
 =?us-ascii?Q?XhqF8Tp6u6nnexdJSp1XAmN7JLBcdWDklBn+LhmDNOK05PuYvtdaOF5MJh8Z?=
 =?us-ascii?Q?Adiw8n3u8hggrKDrgkAjGPL2dHO1rG3H53xHIkXqcRdiRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SOX94kEo2GhU2l52u6K2vsmOnJQ/Zamm8yn1LD0xrwoQ4IdqgrnJzMGqb38I?=
 =?us-ascii?Q?RU/8Xce5gwd/Z4dQrn9Byd01+JIPvLBYnq/WI2Qlju5F93tlpkCMI9knAtCz?=
 =?us-ascii?Q?+nX3iIjZmb/4J5sG/MKLKmcE84t7aOQc93ZXb0qSV0qKuyp2eByjKhBHCnZn?=
 =?us-ascii?Q?F9mjsdkuzoHuzzdsY9qKZjhF1QnQft+dyciIum7PwW655rhGvG6XI6/UJwaY?=
 =?us-ascii?Q?VG20Rojz5WAGcuN8351+A0pAXnNi2xHVqA2eUTxK6l+6cNB7Epx0JZdu7Avw?=
 =?us-ascii?Q?KYc1rKUZTZo4tSadxnInU/YI74nntvTF1f6CQdYuBZ87twapvrqbSOTa8EWC?=
 =?us-ascii?Q?R0CsTPxHE1u2jV/RKuABGVvUF6zu0KPDhTrVJMBwL/BcVUvClJw05UkvvT6g?=
 =?us-ascii?Q?pQc2C466OL4rvorUO3u7JYqAAuN+Q4jtQZqY3nlcL+RHpJSJ8RhQqfasNW67?=
 =?us-ascii?Q?KBC44HmX84sxq8y2OxLk/5W8JTBBGOgEECj9mtf4e7+wfN/l32RDP6Au0hrR?=
 =?us-ascii?Q?Ii80XiwYV7o1rAJ0Iy1GzODRhfL7FQWSXkBOypAX0m1ZXw98Xt5grpQdFd8/?=
 =?us-ascii?Q?HBEmGcLER7bbvnIOYfz61Fulb7gyW1uIY+VcVeR5ITPMF5FvE6NLkYe/sPzN?=
 =?us-ascii?Q?KGpaxjaZtuc8DsS3mUAPkxVmZe8zlajk8NRM7jKYXDTXQiwso1g8wHtblmO0?=
 =?us-ascii?Q?bOHs2I4oMfVwBqqhjQmkpMq+Awp7xgDJVkDXUd+mFnoWALIRLGdtrTepDEx0?=
 =?us-ascii?Q?Ixtu1mmALWnAEtsJOo2QElJlT2GU73CK0GIt6hN73prFB+a9sz0Ex4J6/oBQ?=
 =?us-ascii?Q?dAgyfRY38NZNupQit6z9pMDdRors8h/6HK/f5EOUGjXEcwjXQN7ViDH7ieFW?=
 =?us-ascii?Q?goDXTvwSKcCNDNWNUfL0i9tiRKvPyODSejk+3I3a3FUq7BprmO8exL0tQu28?=
 =?us-ascii?Q?EqtO89TxsLsYbzWRSCPULXLmBfNz+wZrSBq2EIQaG2mESwKR2bu7Ptv3GQdH?=
 =?us-ascii?Q?TQuOAgBseKc3REWAkBuYMhGQXOs8MOOc7aTqhjRngsiHcmogLCJxpzOhKwSJ?=
 =?us-ascii?Q?5UOHNRVJsmIl+IoU+C78cqraDmxrIEalM5oC/YsFat45chyDm98vMTWRajZ3?=
 =?us-ascii?Q?INFNDr8/FZ3qwVvPoINJF01o+gYxB/ZQcf1b/Vfnbf0HlpfvDwvp0sHRj2p4?=
 =?us-ascii?Q?tNWL/sw1XQ6pSGacIIVYE+K+YSOKRtKnwOa/kKLvfdi1V3MxQ4rnTx03P27p?=
 =?us-ascii?Q?2Mq+DZmTSfzntM1jWaFndmMVIgkh1Uu4cALqlFLCRSvHZx/S2CBBTTD3YBWO?=
 =?us-ascii?Q?WZeQd0AGl/YjPv02fciFvAn2BJr2OHao0CYxHIRETNZMRdSi7tSAMse1NekO?=
 =?us-ascii?Q?08BDR66mfC4Kc9thu0IQ8eZOvtppGis2yjyiVJWYWSNBTSysW6igiacojplC?=
 =?us-ascii?Q?OdiuaqRraiop0DlovD516BLEBhmfG3/evrTk5Y0NPHYJvbuk3qk0spfLv7Yo?=
 =?us-ascii?Q?ecamn70MtEQ624qha29GNK40ulEws5kLudWjH1B1kaHSi4p4eYT/t/EDdoxO?=
 =?us-ascii?Q?ZaR1orpxYWh/cP743cWW7vw23mbLVnwDeQFR1pjO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cMuIu1Z7h9LrSz3cEydnUdk1zofbu0MPZZJ9Xguy//0aCLXqyUPxL+VZYnykhVy/FmtdxtEmkRGC/IsTBx3DY+xc2KBqRuc7aoPVZCU17fL5r5T9f27Kr3h16B+CfXVAkiOzdStskcgfUt53n9lWSyHSM6nBae3CTtUjs32uHhQm99m5T/YiN5q3aZtpdt9kS5/b9A8KY+Gwls7wqHgFyl5bfspvYoCi190/NnURTEAVoZ7dmkOOYXm1AcwROY79f+gBfIcfQFGIsWE/LdcS/fu2b5OGIBQFY+DuoEFuNb3bvF3z23Kpiruqrxnv9/LP/Fq1ACegWkQXzq+T//J2rl4WypDsqLSbz9xl1EYBq6C4lsdixFjLhuXuG8P86RqLndYtZxNn8H96vXDQRwIYf4Q0y16xGr5nqSj4fLIkWWFYyTHBMohbVCBwyvIbxeIImsn807ql2Ca9/O7U+HekCfDlqD55pnmlWftx+jpqzv/m+4WLyB0wMgeeex2LvQaacCERV4BC2/4BSiaNRbADQgyqak9lgr6VqMzJ24ErSToROQgaap41Sr55jX9e0aJQh72lQRvQNY3omU7rdeNongtmdh2mhY2cY3zdf/rwbeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f43bfb-d2fb-4ba5-16b8-08dca69c0f2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:18.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjUkB1chtJUogZV/hlklPwq2AXKFvgRhO3qQUuQPLhhzf0sxqHGoCjR0C/+hHegkX1649nLga6tyteBXUeWsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: 659WKp4VXWsHkCKUMiFhSCsM0zMKIQwV
X-Proofpoint-ORIG-GUID: 659WKp4VXWsHkCKUMiFhSCsM0zMKIQwV

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 28a46d9ddde0..babfa50f1411 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2586,6 +2586,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2740,11 +2756,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


