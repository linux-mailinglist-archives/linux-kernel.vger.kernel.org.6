Return-Path: <linux-kernel+bounces-512854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F90A33E75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366FB3A53C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613B21D3CF;
	Thu, 13 Feb 2025 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bq5EmyXT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z1Fmc5jc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DC214A62;
	Thu, 13 Feb 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447460; cv=fail; b=V0pKJPUp9RJw+MKvfYbx4SXMudM8WobdajxefMfw4TkLVw0hVRmCkMh1XRH2h1nLG1FasxTQUYfn2JxmrsStguxABYGMVXA5E1oQoJVo+Rx0RJ02JZgiJsZU+eXwR/+Pmu5uF9B9Aqc/iqqMCMliChEx3MJpnfF9Zz+5sy/Dk9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447460; c=relaxed/simple;
	bh=6nDIHb0W9AoOyHw8uW+yCDKtZDkulnGGpnCbYiKxYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZav5S4J/eSoIwmegDu5JmzYx/ydIbdV1SR2yT6E7y3iJKu79txgGZHAzrdg09Y9gMEnCtYEdfjU4oiz7L41MX/cR5Dvq7mov7anMbxJjX5fYe4NHyu2mltHUCId49fbcxJofR+0oABR+ZYDTYbPzgvId9CZtYmx1s9V4DqA6jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bq5EmyXT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z1Fmc5jc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fbt5000577;
	Thu, 13 Feb 2025 11:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RSfnvYK3Z7fz2G1nPdkqB8ErsZN4qodmjwwtDk3Tq4o=; b=
	Bq5EmyXT7Vw8hinY6d+P/tQukqa8chS8uouXqDqfv2eOS5LhGH/SEJOOSwqRkjTe
	ZB4tixZY4cLKBngTSTif9c1KgBMq4AAo/hpGDWxo+Z3rqZS3x0+u923YMtadsh69
	5LirM+GqIxYpUbSrlQIUyDpkFxNn/sxPjKdW5tJxjWfdaJKHI+AstHm/WYcBTmzz
	Qp4s2KSGfHCmuGq3r4gz+hL9TDxgh/E4m380aOa0RYa2ecy3ABATNLeN1mvZUpgF
	TW8zL1nyUrFR8VsoAoWvp3DfBjR36YH1pR3BMvgLnY5DaZ5dy96o4uy8uULh1W1K
	8ue26f+VP2T0TXsQclUwsQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn9cdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:50:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DAC2Zl026948;
	Thu, 13 Feb 2025 11:50:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbjnk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ils4QG1arJKJiaCnbXrLtShw95EU7Y5CCd4MfP1jXg93iTtFXRSY6s404raQStKouua3Kd9WGqa2j1uYkOkRwH0zHzHwC03TTkX6LP52dJwRqnYRaf0t08LCb4KfnOnbKI1fpLeXMilzzDBPXaQ0q4LBWULhpYPogED12hBWeRfdPIdfmmrEK0/NJ2fZyo7py2YTZf7jUQcgITJheqayIF92snjAFHbLEtofEon4435uMoLTf5N3/gy7jRY3Qdllm/uL6ZoVjVGciKUKNev1hKWuHOl+No8P5OXXuD4FEOQraYpryKH50HXaJ3nkohf8diyas/sbX607HBwHa1jBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSfnvYK3Z7fz2G1nPdkqB8ErsZN4qodmjwwtDk3Tq4o=;
 b=qhDujAi0OOOUhQcnFDp8X+Bc2eu5AUQBeBk8J8rYeIT8yJnGSIvu4p2Tdo0hppfhamfK4rDnIcSNIVANlFOSuSTOhl54PzHSlThm6u9SxxgNKaePSz/HmpYYPWQpCcPv4K01rAGXGNLUU4M4KNvNJZO1nyTQ9+pzTNJQu8oPUzQ5HfcmOK93QcYuwngEguoMmJNrCRAQaZPu1yuJ5F1N4I8bMfdaB7Y6ftJrw7GiNfiegUFtCLSbqEe03Yv9qRwepuLy+glT/hWcWhZk8kSicZ4X1qkWNrVV1uc0vmcFTm6SziXt0v18BNvcuDS+xaMKseAee98i1yoTn5Kb4LdCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSfnvYK3Z7fz2G1nPdkqB8ErsZN4qodmjwwtDk3Tq4o=;
 b=Z1Fmc5jcedm+Mp6y4cuWFCAxSoMTBbKvhvWOszNkpLz6zwG0/8xE64JOVf4DCSNZACV006G6mRdgyeup++LA1jM5bCGiTkTUiuPUF5ycAeqJXI3FYntQH9XWbbphDJnr+8u3skOWK7auCmhFcDObEPtGIcIpYz1r5zOVTD9Jq/Q=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 11:50:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 11:50:20 +0000
Date: Thu, 13 Feb 2025 11:50:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: aa209d63-69da-4428-ef72-08dd4c2497a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eldzckdzbmxDNDcyVGVuNVJoaHBEL1U3cWtJVUgxWGUxUThURzg3NllVNU9u?=
 =?utf-8?B?aDFoWmhrRVhWZHdIUXJkS3RYM2pUeEhQbEMwc2RNVU1kRjdPQ0xhei9OaUVP?=
 =?utf-8?B?azNOOHJzSE1BWmlGNGF2UEk1cWVrbHNRTk9Vd1BDUm5MSVVYdzd6SngzZWFX?=
 =?utf-8?B?S08vTWJ4TVRVZ21zMUFOTC9BMmdTWmJIOWROMVlmdE5kc2dEWSsrTWJBQzVS?=
 =?utf-8?B?dExxa1puNm5zOUlKY1dPV25yYmFIckVyOW1ONTNWYTY3UG1QSkhwQW1FOGJL?=
 =?utf-8?B?UUhvV3dyQjJhVHRyUlZ1dmNYU2ZvaVZYVmxZMVQzWE5yNEZuUkdHUTBoNXJw?=
 =?utf-8?B?TnpqUDVtaHY3bVVHMnd5ZHpOb1VXTFYrWFptaDBKSFRDZWU0cHBPc2MzRm1N?=
 =?utf-8?B?OCtuRk5oaVBlTlpNZFhFbUpuUlRxMHVQQ09VcXJMbjdndi9OeERuTXZDVEVT?=
 =?utf-8?B?SHc5SExnYWNwZklLWllCVzhiVnR1NXAwSGtUYlpyb1dEai83VnpDOHEyU0N5?=
 =?utf-8?B?bnNtZTdUVXd5ZExmZjRpT2QyQjBFNWFHSFhDNW1OQTJqeDlzUmllSGYxRVg4?=
 =?utf-8?B?T3FlYW5NbytkMGRKQys3anM4QUNHbGcxTnFreUNuTEsyWE1uZnd2Ykxra0Zu?=
 =?utf-8?B?ck4wYzgwYmVDNm1vRGpkc0s0UkNkYjlRakY4RnY3ZXVhZzZLakRTTVVsbWRK?=
 =?utf-8?B?cjJqSzNNSW9ydDhXQTZxdmxDdW02WVNMS1p0b0dzZUE1YTFPT2JhMGRJcjBq?=
 =?utf-8?B?MnExRUJsOE4yUVRGaG05d2R3TUIwMWYyTjlBMlVZbzdMTCtKQWN0Z2UxcmZ0?=
 =?utf-8?B?d1dFTmpBZklSWDVhVXRzZENSTEJ4eDlaWUFXaElPVktmVkt6Sjk3aTQyOHVr?=
 =?utf-8?B?cmdlNDVOOE01a2RCbHgxS25kNFVvVitNYmNhQzF6ZS85V2lXREkzLzVZNHRG?=
 =?utf-8?B?ZFNRL1h0N3Y5cUxFSTdBWHpWVldId2RkVDVNNXMxOWErdllLdExmM2xENHZG?=
 =?utf-8?B?WWdHQytkNVVhOHRpUUtLRXhCVkJwL2V4ZHlRb1FHdEtXVUhSVlpCU09VNWFJ?=
 =?utf-8?B?TGN3NkdsQUpKMy90MnhPVThhOUk4M3VUY1lEOHFYeW5xSUNRcVdCbXVqdXFW?=
 =?utf-8?B?OEgweGxwT2lzSi9ZZGI4bUZNdlRaVERtZFdTUUo4d05naURZcnAwSjFBSnJ5?=
 =?utf-8?B?V3BVR1hQNCtJYTlnVll1TzdPMi9hUEMvK0R6Vno2WmpQNjBnQlB1dzJFZFFn?=
 =?utf-8?B?Zmx3UTAwUlVEbXNhcTd5Z3VEVlFiaHpROE9qbW9MTGlFWWxQTmtBZkZmQ2d2?=
 =?utf-8?B?c0E3S05iVFM3UDRGUUNNYmhvZERyaWE4RlV3MmUyUTJXR0VJNGxmME1LVkYz?=
 =?utf-8?B?M05TREtnNGpSSEpXcE1RSkZwc1pmaXA3SHY3bk1Dd1h6bXR0WGFwa0lXVUVI?=
 =?utf-8?B?MWg2VVFRRnJrRTRNa2FBQVhZSHN1VC9ZeEVHMm9uQUwvU3h5NWRYQ1VpZWpO?=
 =?utf-8?B?d05zWWRqbXQvRm9uemlkYXhWQm9wZWNCMmVNZUJld3QyRTJUK3JrbVp0d3RU?=
 =?utf-8?B?UmVyYmU0Vyt4ZnV5NGZDSXYyQnpLdWV0MWtSamI4RHRwUVdEdkM4dm51dmp5?=
 =?utf-8?B?dTlBcVlFd1BDSUlyWkxCMHNxellFQjduVWYxU04yL25ldVduZVNyNm81T3Fl?=
 =?utf-8?B?dUwvV2Y2eVhVVnZ4Uzk0cVFDekxZU3J1MFZ3ZFRhYXh3MDI4SVhnbW9TZmFC?=
 =?utf-8?Q?/SZJMTivGLRzwdYJoLte+q527CXQo8H9Z9+tN20?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU40UkJiSk5wNUsyYmJCOXFiSVFHVHdLQTFGUmpMT2l6b3NDMjNPNWhkSmYx?=
 =?utf-8?B?VW5hRVhTNGtaOHlIbFVDL1hQNWlxUjNkS2tkdkNsZU54UUpVVi9MekRGbzRk?=
 =?utf-8?B?Qm9xeWI0UmQ5UmVSNTBsdU8rc0VrbWRPckFyUmdIUzdNRmdwSjd1WkZUNWtt?=
 =?utf-8?B?SW9BQlIxRDZ4MFd1djk2Q2tPcmdkRG9MOEdOSW00d3JMWEVXbkpoUVpRZ2Rs?=
 =?utf-8?B?T21nWFRhbWUrSTh2dUNGN1VMaXhpMWZxZWdIcnZxdGdTaWdpbm11MkNGMFpL?=
 =?utf-8?B?REFwQU96QTdzTFIwMU1BMmF3Q1BER2dQQUF3eW9qSkZNQ0crN21qeDUrTkM4?=
 =?utf-8?B?MWVOallpalNQdzR1a256TG5hVW9vZUdYalZNeTNyUmdsWG5kOUl2ZEx6V0xj?=
 =?utf-8?B?d0x4Tk5ac3N4MWg1KzJidTVNWXJJcUhUZ0F3ajM4YW1VV1FVeFpTVVVvVGw5?=
 =?utf-8?B?ZzFJUFNhV1RPTDdnQmJLaEJHazc2TytHaDJqR1lNTkZ5VG1GU3YyYU50djR1?=
 =?utf-8?B?bHI0dmgvblIvQU5oaXVlL0ZReEg0Ums4c3FSdTNsRkNrb0VTa3h0WmhaME4w?=
 =?utf-8?B?TWV0cmozOGxyaVAvR3FvQTVPUm9yRTJFQW9zaGVvRUtSVTRPaVpETU9wNjFW?=
 =?utf-8?B?QXFyNzRvVXl1M1J3dEh0blB2Nmo1am5uMFRVYVRUMDBBa1M1UXZZeCs0bnBM?=
 =?utf-8?B?MzhYOGFVQ0p6MDdTeWtNS2ZuQXBtc1BPVVdCaUs4WUY2Q3d5VkhkVE5COHp0?=
 =?utf-8?B?NS9HcUo2QnR2OGVaV2FBSW9FR2l2Mk0xYzdGdTErU2I0MlhGVExaT0F1eTEy?=
 =?utf-8?B?dFB5cGsrWGdYUkxOa2hzdDB3ckphV1NmVEYwZ3JBVU5uMEdBWDV5OGRVeHNL?=
 =?utf-8?B?UUlxMjVZYk5rdUxWZ3ArY2orenA0TXU1UFkrTGhRaUJQcE1wVmF2bmRSS1do?=
 =?utf-8?B?TFc3MlJpeS9hWldjaDFucVByeDQyZlJtL01RUmJwNEFrdVlMbDlsQnlUdkNr?=
 =?utf-8?B?SXQ4TDM5anU3aytyU0diamxxOWZFRENpOFZlVnFxSndLVHY0a0hKODAwbzdp?=
 =?utf-8?B?dTRKOXl4RFp5VUszc0tGQXNlczdzdmpwNm1xMnJMaldiTlhOZHo1SmRLcWRL?=
 =?utf-8?B?cGx3dktscndHSmk2SnVodVcxeHluTFZETmFHN1lwQWI2WS9ubld6c0NxYlpC?=
 =?utf-8?B?RE5MZ2RVamdKUjczU002TE41TTQ3WlorMUVrVlplNFAwV1V0NzMrY2VrTXBD?=
 =?utf-8?B?TkVleEFodTh4KzdJdVZmbzRzVVVoa01CTVhPYTFNRXV3TVRBT1lidFEzUlVk?=
 =?utf-8?B?ckVEQTYvMlZkYUFkNHJvS1ZKemhuUUFvRHdvQzlLQTRnNFhIdFFGU3FkbUZE?=
 =?utf-8?B?dEV0K2ZZbGFKd29XZktEVmtxTTFGa2tFaStnYVRoZUpLNmdBWEVvdHYzb3hN?=
 =?utf-8?B?WEx6d3Rna2VUWE9qSCs4R0VzNXhPVStiOEpQa0VQNlFQelVhOXlvU1pobkl6?=
 =?utf-8?B?a3JuM3BmZDZ4Q01Qa2lpMUdhVFJ3TUNyKzV4aWZJWlhxVmF2Z29qV3lOT1Br?=
 =?utf-8?B?Y2ZuUVlGc0ticVBFUjZWNEM0MDVtVmp4N1hVN3FickNUSUtpNFJQT2tNV0dx?=
 =?utf-8?B?Z3VQT0JQQlVrTmZuVldwNEk0a1R2ZEZFclB5TWV5NFViQTVlOGhJM3MwN3BH?=
 =?utf-8?B?QXErRkdlaDdzajJwczRySm9mNTYzbFgxNnBIWDZNamFsVjZrRWM3WFdrRmJj?=
 =?utf-8?B?MGdjV001UU5IcTJhQVZTajd2bkRxbjMxRVVSOVlRWCtWc294dlVxQW9zUEkz?=
 =?utf-8?B?Z09qaHlXQnRjVDJuTmIxSDl5WTZDcmVjY1RvRFg2bUZTa285WTFBb1hoRDZO?=
 =?utf-8?B?RGtBUm5VdHVlOEd1UzlyUHAzb2oyL0FObC9ncXpPcHNEODdRUXFncVVpelRV?=
 =?utf-8?B?TmxFVzVydWFJUjlBOXNlWmlPMGhFUklxM3NXb05malRDUnRSUE9TSmFrWlZQ?=
 =?utf-8?B?OU9jRzhya0VqbTlWMmIvV2FMMWhHTEVVc04vYkxNbEdZT0JpWVFzbWM1OWVi?=
 =?utf-8?B?Zk5mY1pGb2ZBN2hqMU9NaFU0cWJCbGVWNGFQVCtBMFdVTSs4K1RQd05kWnpE?=
 =?utf-8?B?YytUK1BwRlJMd3JKa2xic1cybkh3ZlNaK01nL2haeUs2Yi9DNjh3TGJuQW0y?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QOzOUWZKhwwkzzKLpidWkR6Ra1Z6AzePB6dWu4Syr9Sw3Cxenv1qJvkrTK1CpA+gzk9u5RhGxhKcb3gBmyEMP4M3CQ+OXYNeSW3299PjqdK3iJGGVKr7aWJpFu+H56oOYC3yGY+d4ddnXGiLWFIzPsckLy77JMbuyXczTdjS8crYk70cGpU3si+svAoGmvI+dsjKcwltc7yWdGWFdVhcnvbPJ49mvOg1j3IWCZC3lH2aYgUxb11BLG8EmKA6ckvEgpTQ7t5mFXVrgOgHXqEkMEVDc3sD0GdbNjp6FZ5KVv9ja9ExuMirmvY3LyeW9/LaHry8Xjf5VVqnSThotDxngfDUO5DRbRZKWi+9nwpyVhQjpCVZkA54LsA+rykVnbolJ+q6y0uaWRzz6xPplybo4CQQ74bEkZFxt84+Px1JB5tNW7SghQcSUf1mh7pcherCPpopOuQc58Ckg49iT1G/R/7VmblG7kNspRDCPtfDd0FfRiUHNQtjQTRt4lP0uYM74Kwl86YkPeSurCwt/t2ERWdmQXewlbyBdr7GykeXPpZbbzzp/UGoiBKtuRGiPNq15NqymBLYvPBGD999yINx+1GYcUXdjkMHkN0iHKdLdWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa209d63-69da-4428-ef72-08dd4c2497a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:50:20.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN9BQllzRHbvafleBGoG/1gLrStyJd4/tpqH4g/nxzvOpYEPwG0GdE3WtJ5C1D/2c1JkAmxAnnqyFkBNWcYNLxGBPkGs2owmZzSifhnuZ6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130091
X-Proofpoint-GUID: dwQPBw-ofXZXYFtxZk0gK_EoEnFpwgz-
X-Proofpoint-ORIG-GUID: dwQPBw-ofXZXYFtxZk0gK_EoEnFpwgz-

On Thu, Feb 13, 2025 at 12:32:27PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 13, 2025 at 12:14 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > the maintainers for the subsystem generally take series (though of course,
> > it is entirely maintained and managed by rust people).
>
> Just in case: I am not sure what "rust people" means here, but if you
> meant the Rust subsystem, then it is not the case. Maintenance depends
> on what the subsystem wants to do (including how to handle patches,
> but also the actual maintenance), who steps up to maintain it, whether
> the subsystem wants new co-maintainers or sub-maintainers, etc.
>
>     https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
>     https://rust-for-linux.com/rust-kernel-policy#who-maintains-rust-code-in-the-kernel
>
> That is why the cover letter asks about the `MAINTAINERS` file.

Right, I don't mean the rust subsystem, I mean designated rust
maintainers. The point being that this won't add workload to Andrew, nor
require him nor other mm C people to understand rust.

As stated, I agree we need to add an entry to MAINTAINERS for this, which
is why I explicitly chased this up.

>
> I hope that clarifies.
>
> Cheers,
> Miguel

