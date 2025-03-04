Return-Path: <linux-kernel+bounces-544519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AAA4E216
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBCE18863B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C6277020;
	Tue,  4 Mar 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wr3CQisI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WF4zOK3s"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29A27CCFB;
	Tue,  4 Mar 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099895; cv=fail; b=jtCdJXTOEKI6BFTa2vS8utDslosUycs9OVeQFAvAt/JTvnGQEJbEYRC0c73/FuWQ41jINHSk6w6XSDwqFAlg8k8Qzzdumc98nUvRf5TN/boZtpcVKJ9s8F8GvLcwbW5GRziAop2FkwvlbXLuKCMFTewJQdVncG4g6W6dHnHGRhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099895; c=relaxed/simple;
	bh=h8AjR1ETJ0eAGhFpVgpeasZMoSxSEfJ32ahQzF8cyJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7PZsXF9VH4BNSU5rcMFmLFW+Hy4W83k2b6J3j57E6N0KICQv8tVZ/jVtA9F/CazkBqw2ZQyOlqY5g66j31aJEYeyalpmjdhH4SsydVw8Of1vN/ZOs9QDeCQXDgmxl4oQTSA5Wv6nyhdZJJbUk3duHU0C16gngQOrsZkDa60/+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wr3CQisI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WF4zOK3s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Cam6S015997;
	Tue, 4 Mar 2025 14:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=j/K6MxaBxlnewRij/k
	NrOoyPBMi53JCR8eORK86KBWU=; b=Wr3CQisI/l5mIwxwc2gTwvzefjb4uZ0h7m
	YM12osi9V0cGIrLbSvVkBdN4AZbRjMOHjVli0qorgBFFjKPlH0N4xduOvEn3MrFr
	VN9CdJSrXiahnhNoa9AHHlQSG0lUZWgKChaENlZYrqaEnCeag056Niwv282t6MxV
	BQgKn4JNjgzqypVyuyj6Ny3UCh+NyLuG/rPRV+ZzJaPmlDHnVDKWF0zCTYuzMy5m
	n2390xDrqhryS0fuZhbSohPvoBNpZi7CYaXSwHe2+S3Yfo2xv0/0P35mazC0AU52
	yKaJdRsSGPFv8HIpfDPeCoUL/xHNn2jZn6Kvq7p0Lf3yZEH9M2eg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavw9yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:51:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524EUEDN003169;
	Tue, 4 Mar 2025 14:50:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp92crk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfCKLcu0aFwtdzCZK9jia3oObx5awP6OAuU6XZ6boL62EqdHfV52RJ4G9vEeCwZGsKwmXgpte/chdvJG/xyFdJ/EbAKH0JEzZNkX81aqWVNvCkA0pPZAA06Makcck4QXzTOjQ6o7ghI9nTbHdtQozr0T4YXp15CslMQtbWTHrzK/rYPhv+OHzAMj9XmrkOMtYJae+zA91PmaX51yauiV3gIY0JTJ6OA+HHIuz1ft5D6gx1lNoGfUB04Reoduad5iMsjVFIWzS8MTY1zp/nrpfEie4bzrRwGz0HCavAUXDG7dUmNAu8rmlejhoPQ83E/EgGro34+dcg5vpywI5yZOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/K6MxaBxlnewRij/kNrOoyPBMi53JCR8eORK86KBWU=;
 b=ZVOJ4k4pefHdO2+nj9DNNKmteIMVCWWkVT3tK9qyBlm4vt4fyW858bjKhtVJLPtQi7hh9CnTNj496pmWUAar4/khaAADb3uveCKSMq59yZZKQ+D6y8dcCPHJiffLFalHkH0Ygm4nSzagD+pLUxb/axcrockk1pWRP631uy2yEJ3SZOS3sDTSidSibYYovL5QzYD5gi0rxsQDhIG2XPrf0cuRE434Zu63CNfJMQbDfcbttBo58Q136DAFspVwZ0B/7i0wxKareQKpReth+UGnDdLO957Wqj+Sc8hcUUYjxLeoxlUbVNyIXcZxUg0Kb/KWD4T1pCrHL7KQ8MgA9oVE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/K6MxaBxlnewRij/kNrOoyPBMi53JCR8eORK86KBWU=;
 b=WF4zOK3szS8+Toz7knZ99P9vQTr2qzXOQcrjxH4ArnyOYa0svbcnzgQKLORExS5+qCQDmr0v9WtnhvZTbqQQZj1rWh0ofQp622GBkBCrDbHHh0bAO7IcB6YzzWdV9uVkCUca6jtd9Xdc6zqO1QrrOL9T2H7x7yB1ovNpQzrKtPg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 14:50:56 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:50:56 +0000
Date: Tue, 4 Mar 2025 09:50:51 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v15 9/9] mm: rust: add MEMORY MANAGEMENT [RUST]
Message-ID: <7ivv6irvtm7rkzq5wo3coewnx4shfrfmc5lxolcnysx2gi7ssk@hympw7nnnxla>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
References: <20250304-vma-v15-0-5c641b31980a@google.com>
 <20250304-vma-v15-9-5c641b31980a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-vma-v15-9-5c641b31980a@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: ec624514-aa1a-4087-19bd-08dd5b2bf83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXiv7Do4ATZ0X2oqU6hh3q6Npmf6Mpxz+JSNg6sjc8HzlrHxice/CH0yJNt9?=
 =?us-ascii?Q?fM17FyqrwAOFHhQwH5FelF0zWz1eXQSD3azzBs+lSH1ugpjbiKPsbuMrB3nO?=
 =?us-ascii?Q?TtNAoAOPWvlCvy089juYWpSe02AzE6vq5LmQITkHp1Jfuh+d6KXtJePwVxC5?=
 =?us-ascii?Q?nC+wX0l+0PvofKooYnGnOCr+fTOa7T9yhDAimlWp7zgB1jKJ25fI5Xz4xkdO?=
 =?us-ascii?Q?XtG0CJ36AKdFYsfGQJdTDo+BM0TQyJDgGJoGaCMKK5DJinohi67ocd+7SjIV?=
 =?us-ascii?Q?3bU6Y9DiCulcpsPva/qvV+S5GIhr5ohrbH4ZFWoWDES3uNOXe35dNbl5c99k?=
 =?us-ascii?Q?g18cBp4yyn6YiDQaJD26StJ/ZfE6KSsDLQadzaru4DIvTFepPDnqgAovTbom?=
 =?us-ascii?Q?L1N4a1JKL/4vgNxxKWngulywP9KiFaPHFb9pBEs0Onwuti76I61SxKiMQqp0?=
 =?us-ascii?Q?5nPjctVpbBp8ymXlvD8V5CXPWzLLj9R1Pz1ZSNqS5F89BZfsyZ2TgGVFxEpT?=
 =?us-ascii?Q?xMtul7I73iqQvdYja/BnFXitJ2nEkf/HxBuIboBb5ioieMQUUWTBdSH5oUMN?=
 =?us-ascii?Q?UTe+20Rb7Vtvr8OXdhq1kBHKQiRvILaSyewKtVrIDzagVA9ace1+1GCsIF6A?=
 =?us-ascii?Q?BFVRVd5wc9j/bVPxrsMHZs+0p8aT0+iUIdYi7rDcozoAXxNyMDvVibqAykVP?=
 =?us-ascii?Q?QEuHUF/zzjJZ+lGXMhl1AYUw2JwvOppLRVtn3lCGKFcDnzjtzKSIi6CPA1Cs?=
 =?us-ascii?Q?x7Wu82YlRmAo4xLQjebPObu7f8gG8O2F2RjUn4JoOEmp5LNJd02vCg1eklH0?=
 =?us-ascii?Q?Re2L4xwYGeULqKd6XozrQFwcTS0GmUxXeVudY2+w48xYf6lzkbNBLDfmvtHq?=
 =?us-ascii?Q?5lNbIVSr4JM8ATw9XxN/tpUAvykiSzIqMricYTE6n2Xr0z9bWLTGZej36NsQ?=
 =?us-ascii?Q?GqMrx1YVmel1pVlVGP+Y3J+rssOOcNDONNPsn3SDkQ1CcLCHKGqTn3Zr6T3y?=
 =?us-ascii?Q?Pxb6u6rPTfMZfPUSTFOr9OsoOs/gYsJEjRHYGqcxqczOwsXFx2fGdZD8bkju?=
 =?us-ascii?Q?UFKvizmoS3O192NmjeRxdKYVtSIrnsDeR3/Dk7DP+0eyZ/Q159hHCA4WibfZ?=
 =?us-ascii?Q?ALkUTqSgTn3+W5OPJMC2/XUcV0hmeiMDaBfCIgDOwn74OBZnooud46V2hSB6?=
 =?us-ascii?Q?DEoID4inul2oCVWsG1k661CQ/f0hquPtHMXzeIEIGiiFYJALZpD5A1S2xJti?=
 =?us-ascii?Q?sv5jZXDbv87zx0kJeCm+1DFitvgiEV+mWbVo/Dz/FFLXvF173IlMKvHEJFNT?=
 =?us-ascii?Q?metj/NfbBOo4Lq7lVoGO9L+ottRr6KU/bAZYxbFJyJZBNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZurDgAUEEz9KMgUHLgVl25nUieX88oKbf2TlLQhzmkXtnPNGp+ety4PGnI9l?=
 =?us-ascii?Q?cGlztnkKNj1kJn2OZ/2D3FmJJRi/EFTHbpyiI6bvTLE4FpoNSDXaEOuOg3u7?=
 =?us-ascii?Q?Vq3+89quictJVBF1tGkZb9JgbrgjU+Rj/ZaGwKmFyYSqwPN5yNkbf65dE8oY?=
 =?us-ascii?Q?bg4rU9++VhzME7X0iPxxRRtzC1hxs1V8yU/pvM90TG+tZNfVw+YsdllQ6LYz?=
 =?us-ascii?Q?7tCAc3x710UvTFkeDDLYdl+TABCZG8xB73m8x0mGuJCjLPbe53z1LxrNnZfL?=
 =?us-ascii?Q?0Pej7HM4dEwLvY98l7qZAsnAiTPs40W6FsUDqm/NkDdcgoSADqN0HMtJ2TwO?=
 =?us-ascii?Q?Pt93PLUQ9+NX4YnNKCFuELFMsPOPWsUHVb/zZ3kI7fpjrTx1A1t59RZZdR60?=
 =?us-ascii?Q?d+1OeleOXOBedvGOIiOTs2AoEvwC2cMRS6Chn63GZyqVM4oMLSDFafoj2BEN?=
 =?us-ascii?Q?HeUaa0OoA9lcKTYDaysPs2YZeUgP5Iu/kXUmr2JAliXkv4T2afjTlknAcf5q?=
 =?us-ascii?Q?2GIdE2iCo7ObjmFd9yMCdLmhRy48kGdmzdw8hoh8RPweL7QBhCWATRj36Wdd?=
 =?us-ascii?Q?TUY1asU8KxQHaMgf50MFifDwq7H3OztTjNaGWGla7KrS8yj4F18CAdRNhcer?=
 =?us-ascii?Q?5WZMqyZSxnXvA9Wgg/gjeZYGa2NMrwFww99R3MH2jOd2bwLfxuzaTFj2DTdX?=
 =?us-ascii?Q?W6kFQ3qUDzED8HrnAqQH0T1ycFDbinouUJAAKw1SDzTj84wXEhJkwctJAozY?=
 =?us-ascii?Q?iFHoZ782LdRnFhIW8N/4b7trcA91aRTDAamSCkxNt4Z8I9QpuC8/0EEuKlbe?=
 =?us-ascii?Q?oeKNHRi+t1g1TOZE9qHJfiayUMLh4Qwwu3d0SGwgBeMqLab+jBgyO/ljQYlv?=
 =?us-ascii?Q?pgd8cF5+jZtXl+Bp7RT8LZPp5zgLTSuRMmzhw449jlo39NWHjn/olIYsyPXY?=
 =?us-ascii?Q?5aSIRXPVfpiVO7ESlsEYtV7N69BAQYI26H5asf31aO/+ViwySDsTz5yK8iyf?=
 =?us-ascii?Q?muJecNWgjJvB3/0wU/LWGTehJCu7xKgDBM01ktGKSdPDnvat9gWWoVob8+kW?=
 =?us-ascii?Q?CdPNkQw71iMt8nNtNxiadG2d9b8D7rEhcOMi9zLBMlPoRWeu5DvnNXbij4Ba?=
 =?us-ascii?Q?V/LhFtQ2j/Jh+R6vOMhqnuhiSzubJORL7j12yIcdJ5d+qCf+H9+rDjihIsHM?=
 =?us-ascii?Q?qQp+ulBOovskAllLvi5HDGAy81SKqlwe92Wt4hLuWdupW4HpkeEa7BnNzUcZ?=
 =?us-ascii?Q?pfVJiE0HkIeltR2vhieiMObXm6nV4STGdsDAUHvbVlDDtv/2SIFSsgdrsOWY?=
 =?us-ascii?Q?RqhURNg9btZUeIsX1Uw1jJvybsh7zdqBeU74zaG8b8ZHT6xa/LonQjoNXz82?=
 =?us-ascii?Q?dRzHwAAUxJWDFnuN+S5Id6q9/lTnHIJKYA1Y0gKN8cSJhT3wfhs3iCpdZXKx?=
 =?us-ascii?Q?VPLHBGzGixZAYga6FDAaM3QuJuz/l1BKGAVM/BiJSRko9rdUR+WXBq2EivVa?=
 =?us-ascii?Q?EDF5CZs8jMWriqRKurB0V3dBuxZiLWkRtNvUTjXykiV4N30DeVEKFtPBnpth?=
 =?us-ascii?Q?jLwxLp9BmgxG0YcM5OUdGToZVev1HtavajQizLN4/YvBEYNwK5OCuxti48I+?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bfZ4q3iRzc86yLcJAtw4/slXZgv1Hb3wCFqKIgrvutB2S3I5v7gh2jFcVcZBX7nl7PPbwj4uCRoF1el5WMvuEmxl8F6r/ZF79ZsRdASI331pG1X9V15AZN+czqvNct0AF4vX5swCDYGT7m3Nkqsu2KJdCFyfnzUah9R0+5NOJeqefruOdjrI/sFa7wUowzL7Do756D4x8uo/pbgZ0T10/vCYmrjCnSxFsGF6hKebDeVCItlhL5Gv1LaparhnvEak+xL/S91/2qBT4A8K5JNkBKAEClT3lFq4yh8YyKdgSuASTCoJYcrT9pgiLAp0kdmZt94aVo/TWSFG99jmBnn5rU6iJwNqdGnTeorSVGf1+CSPPu+pV7Y7z0XRXnZxWdh7Rz211tSfyCeWlbE5V0mLRc0p7NGD5PpbFp/2crffbQhliJehQcl+UEWYCNYnchqgqJgD0u6QJ0dlrJtSKQJlGV8RbUA6oAkqL50YwEKP9164CpzF8evZCICxLqqZwcGbnB/eEukIU0XtCAwciaKRXCrySIHrpTlNuYU1BzGcRYlBnflNfwQSAqrmrJ4yt2eFjBgPaYNOjsJNdXX+0eHOcXra02DRa/22IyN9YjST9yU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec624514-aa1a-4087-19bd-08dd5b2bf83c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:50:56.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NnJRGLUZu2ARnftQY4pPRce/sycn888NydQ3C5yfVGxQFTbH8uj+S60057zpnePZRGSGBmu1s+3FIxBw9PCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040121
X-Proofpoint-GUID: mbP1wMPf4s7z12UCEwn_-lWv37O6G5qw
X-Proofpoint-ORIG-GUID: mbP1wMPf4s7z12UCEwn_-lWv37O6G5qw

* Alice Ryhl <aliceryhl@google.com> [250304 06:52]:
> We have introduced Rust bindings for core mm abstractions as part of
> this series, so add an entry in MAINTAINERS to be explicit about who
> maintains this.
> 
> Patches are anticipated to be taken through the mm tree as usual with
> other mm code.
> 
> Link: https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
> Link: https://lore.kernel.org/all/33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local/
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353de25c88291cc7fd6c4e9bfb12d5c4..3f610b3ab66ed5e502261deb867099fec6e4ab17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15196,6 +15196,19 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
>  
> +MEMORY MANAGEMENT [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +L:	linux-mm@kvack.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	rust/helpers/mm.c
> +F:	rust/kernel/mm.rs
> +F:	rust/kernel/mm/
> +
>  MEMORY MAPPING
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

