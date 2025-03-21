Return-Path: <linux-kernel+bounces-571521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3641A6BE51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5991898E84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF501DE4C2;
	Fri, 21 Mar 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KIpq/jnC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vLxskYSl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20B8F6B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570887; cv=fail; b=ljoFzEV/XO3LceKVycxCLQSvwEBGzwhbLxkCnIeo3S0ieh1+XJm1kXOQ90VIq+Nnf4KSPtXW7khPRsUMzFFpMoE9BYNEzKL7jiQRLv5BzLhX708Wp+A6zeq4p9iWjOVeTixxMT9N6OZf0FxBPcVdgN/8qZkrG6JR8QLLeaL7ReQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570887; c=relaxed/simple;
	bh=+TJ2ii8bv5TDMXm9QYje3FeP2CGfO46StgvSPQDxf84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxbb4Hrlf6P3k2mdd51gCPG8XSRuDBxiszOuXaJJaFRFTEDjsrwCI2imGheCsEbwT+8fPcQDt1BDYCZCeMgWANgrOWonbSllR/I34SS2eWO610lzgn5ZQ/geABn7q+6kGS09gWMXUxsGgk3Gkkty47hBIwyMnAq/BHyOCY5G+Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KIpq/jnC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vLxskYSl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBv0f024214;
	Fri, 21 Mar 2025 15:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FdHIxwBBUubyNwmixM
	AuJMij2NgfL9g+kRNH3aQOjEY=; b=KIpq/jnCZyjUgCfxzjzCfe0IpwEw4QclZv
	V7NXBlhAYfirf7H4L03tjr7LumwVLb6xNAeZ/IOI5efBvlhO2sajGPSnnPVoGX+d
	UeWpMjBen6iP8wUVqTwt6pwijuUBL573rmsElu85MDwkMv+gZj9FS7WkOWRZ+/Nb
	Sq8lSNSEIMw2TXD3ZGQowmn3hZzPokazSkMTQ659/kSY1f0CkgcC34hee1iy7YXm
	dFj+sxLsw5uqZilS75O4tQtBUx1FJJgsx8vLRysQclmU+pO9qbb6anvpxtu9tEFR
	+Dl9lBXXU/yFKvVXk/QBY52ZcGFmi0R83R1hzUr/ZoTAfqcR/Fwg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s8xhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:27:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LESTKh025237;
	Fri, 21 Mar 2025 15:27:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbnye2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdvSCEpG12WlXUxw9DXJp7MfonMzFi/p/ksu8QcYdzFPyRg+5WINwrpZ//B1o6pvFm7kDgxLtHkgL1JKFqqD3EAUyN0+kaEn0ExYJc+cuSf8Y3i4EfbYQwtUIdXzEqEoSavb5rtj09Uoeumy4x18g8BRn342jN4PbkTHGGjwMdVcr4s/6SGjonPNvoBsUMo1QdLqW7ard5E87Uf3nTm7QKuWZDL9DAt530hucyrUDIV9BVMFv5gV5qFQ286xkGLdTFVLw4Kc2JaV5WGQMW9jekiEcqDuryWIEpI8CjuTJgBnoO6gl6fysyfNhXswv185wAlZ6WIvGhZd1rbIbP9rwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdHIxwBBUubyNwmixMAuJMij2NgfL9g+kRNH3aQOjEY=;
 b=UAA/4pVaK+bLMQ/HQD9UkYXvdl7lATMdsdi/EThvjxAN2kObXIIdZaLOh+xX6h2DF7S/kkrhrGmAnIp94dLyQV9QM3rqYn2tAPWThV5mJfnamUHkbTE5/ziPg7RxgqCsn7OKCrAqkXZJObt+74kTyw99pBPl7ADmcWtAl+Ih9ci+1Z0DuIsJapjB42keF9C6IBkXe76C1GnF3/LM+8Hoocn8qY/3yuCXUTrg/hQK+PWw49utwz1jyMQoEUbeUVHOFFRtFoKtLJROZJacYNZmO2zaa+rij2g3NzKVsuaaBVXtSH28rdoV3Cr+unoUAK9KNOf8EyMIbqJ7cZq24F1WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdHIxwBBUubyNwmixMAuJMij2NgfL9g+kRNH3aQOjEY=;
 b=vLxskYSlBygxFPahydJ+UVOw0lF2CvY3gctXvhTTJdGTwgQ8mIPmJR/Ag+2fiMxzLXUaeX1roFYRVm98/3PY8sMazCru5VWAWPJjau2zzFltwGmhtMVE5Wp+tcUyf6E6XP7tWSFtaZkl+9Yj8utYF9z2NTws1GHNUl3Epe6iz8Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7246.namprd10.prod.outlook.com (2603:10b6:8:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 15:27:37 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 15:27:37 +0000
Date: Fri, 21 Mar 2025 11:27:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: e45f7fe5-0f2e-4bf1-2a33-08dd688ce92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//pAjEg7lajkgIBtJlK9r7fGsF9vLdz+JZLRZg+pMdUdi/xcmtawDtUilgII?=
 =?us-ascii?Q?a3C9lipkQLruXNGixxwFqRQvvFAIiIx21fINuEOUiQEUSwkJsIUyRCtH2/by?=
 =?us-ascii?Q?aIkHhwzZ++Qj2zzR0ncHx4CCmddjjwYcsmzsP9mRhIbAjaRu9sNM5enij+QW?=
 =?us-ascii?Q?dSDsTYBPfOA7unK/0FgdxE1Up9tmlbLI1PoFti+Yti+RG2X+g9ZmP8sxSXK5?=
 =?us-ascii?Q?yZUvBXxGtJ3WMM1tavHcaL29xHO6xpCSNSoQ4jkHYI3rdoSxeouXUQs1cdM8?=
 =?us-ascii?Q?le9J3t38uNZ2cd1/VStVtz4U0IzhG6QEoCHhp92EqyeLhXLuOkloXh4dsdWj?=
 =?us-ascii?Q?CGV2M8F4EpSqSlHzvOqjd5NanQjaGgq5KaAnZ+KPNbX7rYl6da987Ttt9o4g?=
 =?us-ascii?Q?e71nPYa5BOPgfrDUhixe2R0YMXQqZrVccnECqpL6wmzSmUKVTwzbiOiqu87t?=
 =?us-ascii?Q?9TQLBXJytkwT7vwL8326rf1/exTa/SucHqjCH7uPotr2tlldjcZP3pCEKPPY?=
 =?us-ascii?Q?9aHJ70heZnluK/CTyunxV2L08lIVCCYyPhKymKHEdgvWs/PvYn3p6augx91H?=
 =?us-ascii?Q?c1619+We2GsBPDke6FJVbrUxPEaX0JyepRGhmG0obr57ANlFDwV3xXyGBO9Z?=
 =?us-ascii?Q?00Dqs3hedojpq0VsIPYC/D9CLccmoHAduLyVS/ki/ZVtNr+BeveJg98VhPJR?=
 =?us-ascii?Q?fi1gfaI2gusO3EvPhxZbcjUcFxCpHlc2zMs+4aTqJZR1W+aU+nDOKdvBKuoB?=
 =?us-ascii?Q?CwTRbXDXK5YgOvOFQ5+Q9TxCDmWLYoFacVsYTNSULjr9r+uoCq3jS5v/uvex?=
 =?us-ascii?Q?X41kiQewZ1e+DTCHXOThgkgqkbUticcsa+9f36mAh4nW+1HLIWNKABcEasDP?=
 =?us-ascii?Q?IswErgqLBmiEzC2hmS7102G5GKMaczgcizAJO4M4dPB7dYAvfKsAPJaXiCpa?=
 =?us-ascii?Q?RITNGCAe60wWbcnnAZV3j8inJgGIijJSepOBGG9asbN4ZoQ17q2qve+HdKQX?=
 =?us-ascii?Q?d+TvcbaPMrDNTBjgaCgRCDeMKV4rKx6A/cH0vZaiH9MX81lISB+c31BX9D8A?=
 =?us-ascii?Q?XynxGVW0tdYUnT+7kaTwPmhmjvfE6KTaUl/BCUmHjNaE545fWJGfF8AbhqDw?=
 =?us-ascii?Q?u5NJ5O57o8aUoEszbt9wCkoAEIS46oM9xqgLHyKGP6uh9AabHD+eaD3nxVfo?=
 =?us-ascii?Q?P0zLixP1G/AoXRymq8eniMCqpJv0uTR43amFtlnv6XJrtIKZGCAsvk/ThT34?=
 =?us-ascii?Q?bOJ806oFh79Try8Sshog4PNDmJSidygwy8rEXOZIJ/ypgdfcdItw41C1wkRk?=
 =?us-ascii?Q?7+LCPpOZ/VyGnPfeisjb+Q8OWt1zNSRfDltQQPJa4wt8HcvsHNKixMiT68te?=
 =?us-ascii?Q?jKJE7dUfc8KR8UfeE1qimSMRdycQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWgPnbA2RPdh3JWUqdnMpLPVXylmM260WIDtgNEoCrm5jDqTewBls6PzscM6?=
 =?us-ascii?Q?0NAAZtIMklHNj9APqRbn0nINR0Tuy6vW3lGssiw22uBHpjDf44LGWvaZXEmB?=
 =?us-ascii?Q?dhPVDDSEgtFqgGtmMtMH+aaU50e5QXEYkl53kINWrKoKAmk+zB3uYc2JeLe2?=
 =?us-ascii?Q?5Tm+H/Wp7YzI9nBEbM3JynpdovqjpkB4nbZoetqUmen3+ZHDG7dRuWkWX9F+?=
 =?us-ascii?Q?vgShC6jP5LIwQrBiowOzeni4ULt/Qp2ZpTuKRzOBn4V53nxxgXE4BEzh1CBl?=
 =?us-ascii?Q?bIxlwPj+nHyOOIoqgxjGgzXxCZ4oZnOw8hVfD8sAxZXG0ls/gU7YjYHwdEYN?=
 =?us-ascii?Q?rL+AuOjFEUumMVFpdlvpPpaFFoUosvKmW1UC61VQdD41WI1kJUPof3hef3p+?=
 =?us-ascii?Q?Q8/+KjYjHEBA+Nj/kKVeXbhy71K3rGqGxfz5LmGKCpqwJtQy6K8JfY4tWtMZ?=
 =?us-ascii?Q?dTUNsu8sF2naGC2Yhu/9z0y49A3Z/xveMzSCr8sgZPFnG+1jbgjhuos5HIly?=
 =?us-ascii?Q?DNsYhx1OGdUTfb4uZRTKuD9tj7safoo9H/oNvAGpPUsLl5ZvNElIoLE0ZSYV?=
 =?us-ascii?Q?uWQxpG5yge6ObjOdTX43MTQi5rfD69y0SULYiTtyjDS4qDN1M/IRumg0Qd9G?=
 =?us-ascii?Q?fQpFA53McotbLweDyvIJ7NT+HlyUKE+dQnCEpgAnYJgCPDj5QWFhpwJL+xTS?=
 =?us-ascii?Q?KIV34kxvx9C/oCboOIEgwqilg5iQBXnH7Ttv7KyPKU1e+6ES5DUwaSj81GUD?=
 =?us-ascii?Q?bbT+MJ7d7X0wb1IT/NcFg++pRlJOU/VuZDR2gIbUBIawkLeh6rxUkoGRosay?=
 =?us-ascii?Q?k0PTAEvcFv12PM67yhPtoSRFvZxesjU3ra6gpCvD2vbW0j+bcW0E/G4k2rpl?=
 =?us-ascii?Q?kwhUF2Mhu8GUyGDDvs1WGM2w0CEJtsrC+ZxbDzStpqJyC2mNl4ySZ7O08fDi?=
 =?us-ascii?Q?KCQGHun4LsQtB+WcOD9pRWEdSSplOKs2xrvnLnbkol3Ttf7jRQ0YQZR9gzie?=
 =?us-ascii?Q?KTC1G76XW4YzmbXVyDOBXwEqHFQkKrrOtEbZsfaUDXchgl9LgLrT9moMkMLo?=
 =?us-ascii?Q?WF/9QqOoo1BwNvMD5RVLbJ6rGFti2Kb+J1HdIg8rTpheLewWDPyf2IdIbXUp?=
 =?us-ascii?Q?P6Kaf37nuFDJO6yDAfFQJIiaCrBT5uVBJT6zdLkgn8z4AAHj+RjJ3Q+meboS?=
 =?us-ascii?Q?ewFrgQBZ8VMJl8HmfRegWpf39m2J8pP24zVr5mNrigEEmzhh6lstceFr3wfk?=
 =?us-ascii?Q?EQnw8Hei//EkDw1JivjnOB9xL34XRlvHSDjYLu2AvQzt3jYNhfh+p/vg0UJs?=
 =?us-ascii?Q?XlJqf3ct4Tkhji2A8H6W6wnGIbNes3khGx/krBNWibWyZdAQG/iDoVG8emae?=
 =?us-ascii?Q?5CTxRNtLM4CnTu6++KUKHlW95ksNaQtO0Xrppeaq3scwZW09tjLuQSH23BKy?=
 =?us-ascii?Q?zCyh6+Qcs0R3bqSov/SE8YC7x2pTfDwyegK2V9R1hATBXZhuFFY050Wac5/u?=
 =?us-ascii?Q?hgfB7ZLjTEBaixS5WUD/X56wgEbgKxZxTzhVGMdwXxu0cqXaeFw15fc1SRZF?=
 =?us-ascii?Q?OX3x2b5BY2Zo1fdlh41o9SDXZYqwKBFBZ0URezOn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f7c60bhdp4A8xybEUQbsGjopmeUdQoHT/vMHv6P1aUi9iBVieAemfBGGg3la7lqrE1L4AtaNM6Buy1djjzvBrAnKKbOxoe6p4LoMTIR4hMSI01ukUen3eifj8qa265Nzt5/vf8tOgbrETzH8Hye56h0jM3kkk4yCBXP/t31Hy2P+s5U1s76X+66SnXbAT3jEwIwTyMFcT0atY/y0t1GAZxdPq/b+T6KPdT+aoDE7g1NZnl1OVxXRtnEqRHChdxlmp9DhtXCUjwpZnYV9Dgb6xCv5Agx3D3nbdBEtJxFCiTM2CCFTh8DqcUB4jHL6ixJKItU8Fj+clc9jz/3bozO3gHaJUtR944mB9Ki+ux350vMm3VTOeIdGSSx8bTTMTQvkanuv+RzHl/Ly0WPNgzpknC5ojYWIRi9Fsf0aNz0fl/Fwtlbrcb0OcNPIQQojZFFoege49bjv0O81g42wViV7vKpnlGVeCUaKzngj7nbt/UCXlL8mryQ4985LN97ErXVnwY364pCOWJ0jYfzsD6y4LiF6bffPC6/y4DQvh30x2ez7cJdOKvbktrCc/5VCMjzV2sYfPOJszRO7LjQhTBlHzNKeGdndMB6DIuafig8eOhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45f7fe5-0f2e-4bf1-2a33-08dd688ce92a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:27:37.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg4Bf/TrGrZ3bWmcfV30ju/Ccw9aGeMYrZXIdDTTO1DnInWHauuSs/q5HGtGXEjSv4n6t4P5VYkjjqdnqQQSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210113
X-Proofpoint-GUID: T8AM8B7QANea3QjfYWIYE1dVn8EoIxN5
X-Proofpoint-ORIG-GUID: T8AM8B7QANea3QjfYWIYE1dVn8EoIxN5

+cc Peter due to uffd interests

* Pedro Falcato <pfalcato@suse.de> [250321 07:26]:
> On Fri, Mar 21, 2025 at 10:09:37AM +0000, Lorenzo Stoakes wrote:
> > Currently, if a VMA merge fails due to an OOM condition arising on commit
> > merge or a failure to duplicate anon_vma's, we report this so the caller
> > can handle it.
> > 
> > However there are cases where the caller is only ostensibly trying a
> > merge, and doesn't mind if it fails due to this condition.
> >
> 
> Ok, so here's my problem with your idea: I don't think merge should be exposed
> to vma_modify() callers. Right now (at least AIUI), you want to modify a given
> VMA, you call vma_modify(), and it gives you a vma you can straight up modify
> without any problems. Essentially breaks down any VMAs necessary. This feels
> contractually simple and easy to use, and I don't think leaking details about
> merging is the correct approach here.
> 
> > Since we do not want to introduce an implicit assumption that we only
> > actually modify VMAs after OOM conditions might arise, add a 'give up on
> > oom' option and make an explicit contract that, should this flag be set, we
> > absolutely will not modify any VMAs should OOM arise and just bail out.
> >
> 
> Thus, to me the most natural solution is still mine. Do you think it places too
> many constraints on vma_modify()? vma_modify() on a single VMA, without
> splitting, Just Working(tm) is a sensible expectation (and vma_merge being fully
> best-effort). Things like mprotect() failing due to OOM are also pretty disastrous,
> so if we could limit that it'd be great.
> 
> In any case, your solution looks palatable to me, but I want to make
> sure we're not making this excessively complicated.

Either solution is fine with me, but...

I hate both of them, and I (mostly) blame uffd.  Some blame is on syzbot
for exposing me to this unreachable failure. ;-)

I think Lorenzo's patch points out that we should have a better way to
deal with a return and a vma pointer and we basically have that a lot of
other places with the structures that we thread through to deal with
mostly unreachable errors that syzbot injects.  I dislike flags passed
in to treat things differently.  We are adding an 8th argument to the
function (of type boolean) to work around this..

I think Pedro's patch is working around the same issue of return value
vs return pointers.  Other places we pass in &prev and just do what we
need to in the caller and just check the return value - which I also
hate, especially when you look at the assembly generated to deal with a
"non-problem" problem.

I have no better solution and need to spend more time looking into it,
but the number of times we have syzbot failing a random allocation and
finding issues.. well, it's basically a class of bugs we handle very
poorly throughout our stack.

Realistically, I *hope* that Lorenzo's additional argument will make
code authors think twice about the failure scenario when calling the
function.

Pedro's code fixes this caller, but leaves the possibility of someone
missing this again in the future, I think?  This could be made more
obvious with some clever naming of functions, perhaps try_<something>?

We are essentially avoiding the compiler from catching the error for us
by returning that ERR_PTR(), which (keeping with the theme of my email)
I hate.  It's fine for little functions but we've made a mess of it too
often.

Reality will probably not align with the realistic view and people will
just copy/paste from wherever they saw it called... so we should think
twice about the failure scenarios on code review and I think a flag
(or a function name change?) might make this more obvious.

Thanks,
Liam

