Return-Path: <linux-kernel+bounces-555089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5745A5A551
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6957A7621
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D61E0E0D;
	Mon, 10 Mar 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpGtxxZ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BDmPASFT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286951DEFE6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639910; cv=fail; b=EncdgnVtJe4OJb7IgwK6D7AG6XCC+KC6rLGQzORfY8yb4UYkd1BpOqTDiZ0BtLgGdfGs9ot1+zt8uTrtQyn3QtYDDzx9skQlF92gdbkMnsQVoJL9fzJ0COnjLXMZ6tIu0DRP7OrCSbdY/yhfsoV1AWlLyyeyHUEqxfPino5ttgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639910; c=relaxed/simple;
	bh=vvDcpfezcXmPpONkEMmmQIGa+usFnEC26Xw8ahvEMRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DBeGQzrvOGCiqp4Y0Py3wbXG2T7sTN4ztkWvcB0ppFPEIkdud5jAQf/yzOI4FD5gvvqrMNMji3Wn7SFa7uOxw10qxiT5nwbg58Vo7UL/hKKVU8+uH8wD2B+2buC33zF3+KAJm7JZgiyZTXF4RRkdzwdthkR0rOmV8SN/p4ANxK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpGtxxZ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BDmPASFT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtlHi009243;
	Mon, 10 Mar 2025 20:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=; b=
	QpGtxxZ12lVLIZZK0/eMrkJt961Al4m7KEJVr3CKx3VlV1KmkEn+KnX7OL/zoP1K
	Elpq7Ye/m6kxqT+/HE14oTHJllKVyhWC1osvtR2INQLnYQNUvSiWsuXcPnL5CWMR
	wFo7cgs7NtYqD0yF4nTrBejfZ0CGKpU50iKlotLDawqeNRH8Ws0qmpuy0zLmCivz
	3itC7QyjI4yrfkImxZjyYJI9DWZOe5YvHo8LMDFKyF1Ew38i/XneR1uNZ6snK8VK
	FCV6IOmx/rkPsQPEXTW2GJyr8sfWoR1Nxi+OmnVw9IcpXkJpMqvEWBNJpdibWUMf
	nXQlRh7Q8wjxsN2L5+Gbrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu3heb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKevlH030605;
	Mon, 10 Mar 2025 20:51:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmgckn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u60nV8Zp8DY7OVBClDglr1RRbJOBNMBmSNJVDUXUT1WRLRjAa2ypTNteb54NQ/UShB+U4Nb5dkyhXC0zLtw8U8B4dLxEiKodlxM0KveFEYarjA+mtf8e4904I4q1d/wjShstJPYOolEGNHGEPhflhokuI0+D1fNKh//wGWBpCbtmEdPMW1JJOUyL13q8CUR8rNrnKJL54E0TXh3NChbWgjlJUFWCpnbFsJXiMCLa3DBoaGaKcmO8n9DevLxxNT0fniBT4y0+K+JkX15DKmJAvhv4u1LoIwcuulpBz435uuF5zhl73siE97YMsZIA7zBp4xAr+Z23cM8E3g2t8SOk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=;
 b=rrwsGnUo7ftyvXk9J/GFiDEIcRUQEL0Gkpqr5O8qJ+LwTEowPMtHuBbyQ7ymnWMDAcwxz24xobS7Z6gf7hYhF2Z39h60/mWvKShAm9SUuyIve2UArZwN8KiK9TtAW+8h8MNXNzM12FfI9B6Fb5y6ADaA8wR49KZFXUNUTh8lSExJE4pjRP/+O5QVZ3gZqrjRIXYMqL14QkLSViH1y+u8yNr2wBdcc3+/2OvXja0rxn9ax/qaUFd5CUgCHnXkinetwWHQPlZOV3kkZE7YGI8Q0Q2GU/Mmhr9tntCiDKX/0SyPhCXiw04cjco20bGgo6yaXlPkgdt74kEOGF7dRg4rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=;
 b=BDmPASFTQujORWFCPLhYz2j7lebB7062dqlx0nBsuFKjw+6kJf+Y1VZshgd91HgQg8hR8YHqwAWVVIZzOnEMiboUqb6seLC2QJ66sP0Wo3ap5d2iI3dlAq2/nOmwSRhfzGal8Vlbg3IspaVTRBZ0cuTJWE6cdwFHusmqDsobE/w=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:23 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 1/7] mm/mremap: correctly handle partial mremap() of VMA starting at 0
Date: Mon, 10 Mar 2025 20:50:34 +0000
Message-ID: <dc55cb6db25d97c3d9e460de4986a323fa959676.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 69477146-e43c-4a7c-e9c5-08dd6015510d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yIpksKWmPhv5kdwrNeq6DJDW426bOIMSQ+krx3hWhs8j0xe7UE04YbyT4TS?=
 =?us-ascii?Q?LB94fWb0It14hlNdBiHHgxphVllONeFspDNCmw33HpHao1k/j2bkCjqmPZkY?=
 =?us-ascii?Q?GAA2U7jT4cJGHY+ttDKan+8DiZx/eA9sGEeEz9Zy7CAYHJs2AhtTyEkm/Um8?=
 =?us-ascii?Q?OIz14uRXNFhhenDumqGPNH417G4b+3q/QwXnJEAdtTFeZZ44arjvD6VUzjg/?=
 =?us-ascii?Q?NCVh3NXaT7PE4zPle0LTDuBhNY7ApcmWDZEzFmy9gMVAwuoQGNv140IkvTDm?=
 =?us-ascii?Q?gAKh1kHWM3mHEWztxc1Y86++o5/CQjX4ySoIFiJjpMDnmuibWOnUzSmlaSKr?=
 =?us-ascii?Q?kBZX7znAJwxptmQNkJMgBA6ab8TymiELOVn8rgkvMdRf/8qoIg2ywEtXKZUY?=
 =?us-ascii?Q?AVCp7HCKW5K5RxEVzuMTrWwXZhROemdbMrmrDbmMSd/MxK6xOwtUEim4zaJ6?=
 =?us-ascii?Q?pxtPQsCShsR+e99LV1eYVmRaQ3BES0nQUETs/Th8PO9iOOdcNcOTPF2/IEY9?=
 =?us-ascii?Q?OvF9EfmoSxMtgToFc3B4TknUjUgPngtRLE5g62GisC/i67JshsJMbWoHLaYy?=
 =?us-ascii?Q?f8k9vIoTDkocEPKxrFwz1oOo4Zlx/h5rPxnh4eG6P8VhfJMoK8XX3J0pbK1y?=
 =?us-ascii?Q?xaz2RGFa/jDsYDRbpiQ9vB/9DjVgg2ibFlgL5zNjLFObRuPO98XwsbD+KsA9?=
 =?us-ascii?Q?FPJOCWosQ3qMLxnC+WWn3IhuRkIy0QVXwp9j4SIdPt1rbIc8VLHc6DjH1opX?=
 =?us-ascii?Q?dLK3eucUF6oIIWGkoy0s1iBhxc3JSfnBYPNFIwhqrLeZGh2HARSrANJ+XFlK?=
 =?us-ascii?Q?gj15b6J9wSsOTESc89DndQAsGR+hsyEUa/RkKFMPdnMKLRvR1kwxo6lbXc8o?=
 =?us-ascii?Q?Wv/X7FPQfEfRSPfJw0tFgfp1nzqZwAyVg2tEVq/EwsGbTC+47vHRCe99KyPc?=
 =?us-ascii?Q?3IzbUSTpKRTWTOWeUXvZpocFajf4t7c06woWAC0G0ViN87obS3Tei4rkeJJR?=
 =?us-ascii?Q?K+MFBLsYC9p+qPvFCnankfgG2TWqmHKbjavRLptqHQ21xcbhbEK9vQr9gHYd?=
 =?us-ascii?Q?tpuCh4cWylzLTs+COkf0CSdytG33P5RcZj8c6fOiyOEU31EdBAchd3pPz3qd?=
 =?us-ascii?Q?a31XY56FIzhvzl9WEryOmTB0Fjcti0hta6T/Sgp7ZmDQhVERdLOtnZQbJo3C?=
 =?us-ascii?Q?Nwfh8Q57mltTJnIWRbMhuZgSkKtEZ/IWyxvH/fALfdc2Z2n45diEQ2ps2a2U?=
 =?us-ascii?Q?zprzf9eawa7uxyqKfSLq4pq0WrQn+eDOWZOH3dO61pKuPqEa4x4xU18E4rD5?=
 =?us-ascii?Q?1JU8B/4YY1afuSX28iQ7gstQYiwbP+d2mD+A0pdFfTD+tWWSydp5p2WOD2Mk?=
 =?us-ascii?Q?6jjiSyt7MWBiCJNlbtStmRgTYmBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tyJs+nvG7r6u3M2gybJSuegz6kJvmsZYDyaNW/5h1t+i6lNaCBASHlKEebxb?=
 =?us-ascii?Q?eWPXSochY35OC7zCFpRJlYxBb9fC2LpKhu9f5okco27j5oWVN/pEDizzwlkr?=
 =?us-ascii?Q?8EUR7+/IquBcoq/051DXh3kNacheRaqity9NhZeVLToaMPJsx/XfcsS2mdOg?=
 =?us-ascii?Q?tKyE/T6A/+7XMHZgxuaSDA6EcFIsEpm0iqybhSlUAvbPG47c9GY71ZOpEhtt?=
 =?us-ascii?Q?xUt8KQTcugsfWBolSU1WLqBiNI+AIRQfckY9UPLQsTh8STbGOG7sZ74YlD6j?=
 =?us-ascii?Q?Ym3mYJYtCHWLMoN5aDhtSzp39Hdpxagzy2e2LLHRhyhV8TiRA7gPS5wNAwJt?=
 =?us-ascii?Q?SSq25sm0rqaNflbQ3ykcpIGlJNP01L8XEMXcm6GIQu1+HzPKpDKMnIWhU5st?=
 =?us-ascii?Q?zQjHnDlnkVu82JIrk/1NWAjWSBzf1DWSzqi0Zs/HRPaI7jVxlh3VEM+9WXxA?=
 =?us-ascii?Q?+0grZOwKYVhIIkcs/3Q8aKjMCx+rwdy4S3s8TjrPhljmNX3i2UA+HNL+7bJo?=
 =?us-ascii?Q?KvfjIXbpEN8LhTcgO/v5KyycQnHOTSbtBzgHjbxMI6Qoge/r5rzbODMaPK9o?=
 =?us-ascii?Q?lgQXsmZUGAtaAuwa+J3pJ/NkcoKEECeqYl9qCElnzTkLEJfpUw0ELee2HsAr?=
 =?us-ascii?Q?2C7zexqaMPmjHQpg6lpRCHagQU/NznPEUc1KHf8tIzOqCC/iZ/esFb9L/c/G?=
 =?us-ascii?Q?x9B5T8McA1tXeZbJAAV8QGdFZC+4f3ykpP5ORIdoa4kSTvYGi1dHtKdm/h0A?=
 =?us-ascii?Q?lN2l6MegMrHK4Zgk1l/zTxGhs6y1HQjoqMOJueMkdM1UQ+Zlje3RvwJ5noVW?=
 =?us-ascii?Q?7QcWIe/HlrlAEps0JTaJ3yGSZMMUwtPkpHAEZuPA41MSu1nfUQ2OWMIqzSOD?=
 =?us-ascii?Q?JlAqmgdCKhQM3AYBCcmawq31Ti4NFUatP8lbnLv+vMfJBUmTmC61FNO/IEn/?=
 =?us-ascii?Q?bPDKGlUgMEMy2IXPvc66diiyaKcX2WQFfFRXm3hdR5kOwqo/QO4fN7fRpfW8?=
 =?us-ascii?Q?QnSLxU6dVkRaNkLbkNeFqIXI76p+jk08wGCRoG8JQLbdnSiTimuTDGUgSz5H?=
 =?us-ascii?Q?OUVI7IUSCsa5u+agFyS91AeP5T2tAQwmJzUJtbjbv4n0XaobTrqa4TGzrh3y?=
 =?us-ascii?Q?kaYAlMp1BSsmXF+1MJ3oIXVp4rgD6sX5HUi+RFK8NEUwcHVjtS3M0UsrDOEp?=
 =?us-ascii?Q?dydkUsC48Rq2wZzUwejn8HMpZwgjd75bxBlkrtQC4LvI8oHL8QkkfLUyv0pz?=
 =?us-ascii?Q?mqmX2OtzJhB0hHkaAs/9WydH7KXZQm2iiyJ+ghDJexrs2OHUIA5cIIJtIYke?=
 =?us-ascii?Q?IBdq5wm7DWSJqGdDpqkZu537+8dgax5dmguznaX2gPBM+N7Hpp+899Vf2yyo?=
 =?us-ascii?Q?+9GwJ+FXNR5cBnkfCmiq0RxW9MJjrSPv349l5WV1iUeEuxNS+jjrwuG50IFj?=
 =?us-ascii?Q?gi2Ig0fcEQk+RJIoFDkOm7Z9UwLn7wH43zYiadFKyLxzmCE25i9u7348YQw9?=
 =?us-ascii?Q?iDAgw7lTWz1DHhfHKKjgUFCS7r3wqgAIwTZ21q+YgxP62C7iDHJM0FDpuvjy?=
 =?us-ascii?Q?AqNR1WvAXkGj5mQykauVcX9UqNNGPrEgupfkkaqaDMSePPAqn2wdJIPjhSst?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SeLEvfwD+noyLNnqeDDgwErCMPQaUIhuL2tRQLLJgmXNFCJAvUMcmmdKGSwPQPSD3Gf5rXPwKY9XBSXRvAUfhMljc3QT7UfCJ3dNRzgryd//fheBF8C02BHm2A/f4J2tAJvm89x2dYGrzpIliwshMGNKOJqwBFPp6981/iru/7VkuY6+IC1CtYjlhC7OqdYzTn7jfdz2cVg63QlAnje5mqoSpBZlOhjThlMoyWB3oRhZDPJVSS7Vw/6Ec7DPLi1n3ia3ltCN3bygEHj8v9gXOhJoWevvm1zO8pVSTX+kkkxgmXVrTtJeuXtVmc6yHcC7YrqCZTaNK3RJFRV/9kvVTh7TaNya3nHMCqZUAemGxOtCd66Crze6HJJ+HIyUxQ0wH8pQpcaHoBkTfrjsR3WC0h/Ga8il2wPXGIl1JK58WZt1G6QDeOsw8ijz7RNoscqbVr1McZymvLeSbKvolJwF9p6L8lwlljyXVc+dKTqm0XCqagpZBGQ6ZHaDWhDR4Jwwu3H3CB1at9+Yqi/cAofvd2n9Qe2L+CD79QmRimru0nsefI2Vz4aVNpM7JG67Doh9DNaIZxIxaMu2GQs2xZ3cNQa/A6MYRz05S0SHzGsccjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69477146-e43c-4a7c-e9c5-08dd6015510d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:22.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEHuDuXh7dbf0L1DTKgcahM3ONfReC4hrwV6CAEA9+kjjAs4TXwiybfwAIAAVGEZjM/7mMSfpO67nBO1KZBVLypHAbXP96N1QlQGt3VWNqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-ORIG-GUID: JBVTBqzWGJ9MClGzfueuEnXDKZHYZi5c
X-Proofpoint-GUID: JBVTBqzWGJ9MClGzfueuEnXDKZHYZi5c

Consider the case of a partial mremap() (that results in a VMA split) of
an accountable VMA (i.e.  which has the VM_ACCOUNT flag set) whose start
address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
where a move does in fact occur:

       addr  end
        |     |
        v     v
    |-------------|
    |     vma     |
    |-------------|
    0

This move is affected by unmapping the range [addr, end).  In order to
prevent an incorrect decrement of accounted memory which has already been
determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
prior to doing so, before reestablishing it in each of the VMAs
post-split:

    addr  end
     |     |
     v     v
 |---|     |---|
 | A |     | B |
 |---|     |---|

Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
changed this logic such as to determine whether there is a need to do so
by establishing account_start and account_end and, in the instance where
such an operation is required, assigning them to vma->vm_start and
vma->vm_end.

Later the code checks if the operation is required for 'A' referenced
above thusly:

	if (account_start) {
		...
	}

However, if the VMA described above has vma->vm_start == 0, which is now
assigned to account_start, this branch will not be executed.

As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT
flag, incorrectly.

The fix is to simply convert these variables to booleans and set them as
required.

Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
---
 mm/mremap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index cff7f552f909..c3e4c86d0b8d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -705,8 +705,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long account_start = 0;
-	unsigned long account_end = 0;
+	bool account_start = false;
+	bool account_end = false;
 	unsigned long hiwater_vm;
 	int err = 0;
 	bool need_rmap_locks;
@@ -790,9 +790,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
-			account_start = vma->vm_start;
+			account_start = true;
 		if (vma->vm_end > old_addr + old_len)
-			account_end = vma->vm_end;
+			account_end = true;
 	}
 
 	/*
@@ -832,7 +832,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = 0;
+		account_start = account_end = false;
 	}
 
 	if (vm_flags & VM_LOCKED) {
-- 
2.48.1


