Return-Path: <linux-kernel+bounces-401465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F39C1ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF0FB252C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359B1E25EA;
	Fri,  8 Nov 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef/UGLKi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="di3W5dh2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAD29408;
	Fri,  8 Nov 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062175; cv=fail; b=STxRWD5laTiGs7uMam36wf3gxJ03h/K0NOsLz0Ypx3DjAJHbWSiQJT4Wbi9W2Izu3nHl8+otyrDOAOSnYh2pLRtgar50hz0A8j0GEAeFVKveT4XOlaRlJKez1Qkwn5QfmcxMhSnqBgx9Mm52qI/wmVpGKiHJIsdlby/Hb2kZyOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062175; c=relaxed/simple;
	bh=UUaTQvsBRkzQcgCEsXOMavrrRuJdHYVhJqLV8LmBtzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POcHovLiTkvGkbmdFbEps5RnEcilCy2DThU5ZL8xZD4G9RUPFf3s/6NoRJ2GdzGl9rOB3NrtChSCJr/jC5N+izBR22iM+Hwmlfdxvao20U6xKGxztwwf+vwMZJpDKQkWNIrq335VHkTsNdI+OlbzlaC2VVB5IM9AoYilGKf7coo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ef/UGLKi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=di3W5dh2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87tWB4007392;
	Fri, 8 Nov 2024 10:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QzExH+Cl8fm8bt3lOzTZrZMR8t1TFhyYK/JvadWLAC8=; b=
	Ef/UGLKiMihBYd1hB6RYRf02AvluPHexffnIpvAleMg/SgUuqh0mWwWBqw14Vm4X
	iGA1Hz+7HgKO7U9BzUa0aKaN4oHFupNdnGyYczIxM/POSetFQsLRXHR48mzCLbKI
	buX2xIgVDCz+FP+dU41nFvNwnsT6xUDL1kKUFKuOCCSCtvowRTSdB1oza4amBogq
	s1PRiYWlPC6XGFsMq4JSXYgUMxwUviM8zdGDjq6olp8Hn4dXdHh0tVB50fZGB8rO
	SoZ5rHfpo0o0CL4XFNiFd1W6Clmprjv2tRxd/NOInb3yXfE6uyzWmmB/QPisxiNQ
	H7kA7f9l+fWrJqL6zOWhSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjh65r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 10:35:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A88URE8035597;
	Fri, 8 Nov 2024 10:35:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahhm020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 10:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPHFkP9ykaw4vtRptBt8TvBAsjzQ1Yb7m194IMGJIzQz+W0REl1x38ymb/HyM9zE0ZChEOQzmOAkTw6DdtKnwSiiCAqXSn8ff1JS7xSP1MBhZ4Qlg8uybNc9vLxSxr/DjXBkFjj7XYAEBYjTqmaLbn6ZMny2IPIwCzw2swB5r1WdKmvTvU9qq3mPNvcRcZuKAqF0+Ka1uA2pQXu2FydhiKJ1Lop9nHDF7ycftITiwG8SvzkVCxT6ofZz7sYYNoNkjivCHoFJNID2kkVeYWrLP1PaMqKlJZjX8jYrr0Vn8X7043vuwynuctUAZbOd7LHzfaRhkKgeq+S7No/jMCS7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzExH+Cl8fm8bt3lOzTZrZMR8t1TFhyYK/JvadWLAC8=;
 b=Y9XrO/td6urNL5mNcfmGIh8Z/Mv68Vw3xcl7OACLx6G6M/0vLVnJlAcyFl+Tv6/apKgX7Vm0qWiZmwI1syVgTyi3MEp502y8+4s23kDf3wWzOzYEbqyDshb5HITbZulr3sN3fkdZJNgv8tscNVj4Kye7yEMUSpqdMcs+ksPm2KCezVkafUzHkb5qWxaThq9d9Xb0KL9euEHgnfeV1/wwEJtUmpluJkNKAubZDq465aC+7opeOA/2PqXEu+HJYGeVmbtV4xtLd0cqD8wBRm7lIlcGYz8tXj6eNJS+xRY8MHUmtyzPyHRcNXtSHuKJidFjiD15KJ21lPdqjHXj2PO5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzExH+Cl8fm8bt3lOzTZrZMR8t1TFhyYK/JvadWLAC8=;
 b=di3W5dh2mKpEbPzZjRCT33uuzPVBYeh+IsGx4M61Kx4Pl6hMH2th8/1RMLNniu6PLVz2P+jOkbPqnrfmRkFDTFuDGipAQhzQ9ZfMnYThQkq66BkXhIkWzMiJvDbHXzwdiGAl82RRvoznLVApw3QmpbdZ2hq1pczcvRQu7aDS2qY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO6PR10MB5636.namprd10.prod.outlook.com (2603:10b6:303:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 10:35:34 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:35:33 +0000
Date: Fri, 8 Nov 2024 10:35:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <510487c4-f82b-410f-ac89-b5ea3a597910@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <CAG48ez1=Be_kROw-+oh2TQ7ag=+=FRe82Umhq74UZMo2W=QBcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1=Be_kROw-+oh2TQ7ag=+=FRe82Umhq74UZMo2W=QBcQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO6PR10MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 970b7ce1-063f-4e21-1d69-08dcffe1135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3JPcHNSVys4MlBHU0xsR29XQldsWFNGT0prMkJ0dUY4YTNhdVhsNHNodkhm?=
 =?utf-8?B?YVljbTZCc0lSazdOSTVTb2FYODYxTXdVd3pzRDg5dCtzaVMvNm5MTTcwU3dJ?=
 =?utf-8?B?U2l0UjFyZXNINmZoKzA4VlpaVmFDSXoxVW5Ja1M0YnNlYXBtaHlMT3RNSHFm?=
 =?utf-8?B?TUoyTzZYWlNkZXJHZXRpOWVSZm8zc1prWWVKQnB0b2ZCWUVpMWdkNXVVQzhZ?=
 =?utf-8?B?eG1rNUw2dnBhV1I3SmhUVDZqOWVPNXZJaytQU3N4cnNlLzhSYjhWNGtzSTlC?=
 =?utf-8?B?SlZudjhIYWpzZlBjR25uN21IcDVCb0dpZ1B6bFpQWnhRK3BYL0E1UGJqNVlB?=
 =?utf-8?B?QktmdmhmUHZQS3ZNd1N0MFRrbXlrd0hINU1KK1hweVB3Z3F4Rm05Zk0wM21Q?=
 =?utf-8?B?Z3VqWmpzYXpmZE1Yai95ZjB5QXFMZTBwNThMWmRBRGVpSG1aN3doMmRpRUZy?=
 =?utf-8?B?RFhTNGt3d24zRFlGWnZicWNYL1VlL3grZDIvaW9pc0NPb2pzZ0FIVE15Y3l3?=
 =?utf-8?B?RXN2ZzhyVGttZTkyN2YwRUFON0lpcHh6cVJpT01TaVhXWERtUXBqQ1h2R1ZD?=
 =?utf-8?B?UXBPNFVObkhnZWQzQ1RsdjQ5R05ISjNYWEgxaUk2Rmd0eEo2WG9iWXRKQ2p5?=
 =?utf-8?B?bDkzK2s2bjhRZ2lQWnBqc3JOVlE5QXFKU0dHbFF4VnRZdzJ3ajM1cysyMkE3?=
 =?utf-8?B?SnhRZG53bW5OM3diajBKUEg4MDljQWN4NEhLSFpoNXRDU2tSVXYyK0FFSTg5?=
 =?utf-8?B?ZzhkbFlvTlpLaVVSb0R6ZExRWXNDQkVaVDFiMjVyNUJkL09RNnI1TFZlZkxI?=
 =?utf-8?B?NEpFdExncVNJVVR6Z2cwcW95VW5qUjcxMlVUWi9vakl1THRmYXlRWGVWL1Mw?=
 =?utf-8?B?ZnpwdmRHKy9zbjcwcUw3TW5ZUUltMFJtK2JLNFJ2dWVFdU5xZ2s4czdPN3RO?=
 =?utf-8?B?a21XaUdrSXQrK0NmMUpvbmVvRlpFSjVwcTFLR0ZxOHh3cUFuUWNIQ3dTNUV6?=
 =?utf-8?B?eHNObjA1cHFYRHJqNElSejN6cEozVjV2dEprbzRHOUVKYlhBUUY1THhHUzRY?=
 =?utf-8?B?ZktuaWNScFo4Z044WDh4eGR1Wmk4VW9GeTJrM2h4Unl1SnZSa0xEMXhBNEZF?=
 =?utf-8?B?SnE1Ynk0MXBvUzNOdXZ6UElLMGNPTDJna0xkcjNJN0ZhR1FJMlI0eXQxUzV6?=
 =?utf-8?B?QTQvbTBJOVE1R25jTjlvYmJTTFE5RG1hbmJRKy9OYXhpNmF2Zkc4Nk92Y1Nz?=
 =?utf-8?B?QUQrSFFNdmxENHRiZk5sVzU4NU1uT3QvVTBJMm5jUzliOVV2eTF0V0k2MXlw?=
 =?utf-8?B?VnRERW5KZGhJcGxRbTliYU01OHF5N3MxTGl5WWNkQkM1b3NVRUxzL3ZzWjFK?=
 =?utf-8?B?ZnE2Z3F2MHNnYmwyNFNFemhyMGsxNWxMU0ZSdVZQcW9uOW0wWEdSR1RmMW5Q?=
 =?utf-8?B?dU4vVE5EU3lxWHNFZHVSeUhDOXpucFFhb1hZa2xVZ09EOHNxenFxamtxSEx6?=
 =?utf-8?B?SjhHM05wdENzOUVGa2NYWksxWjlEa2VSY0JLV0hpUGNnRkZZbk5VczQwVEhS?=
 =?utf-8?B?dUFIZUpiVEowenJnZFRJaUY4Z3o1aUFod0F5RjNIdWdpZjY2cmZ4RmEzU2xk?=
 =?utf-8?B?RWU5ZUI5NFN1TjVmQ2J0THZUcnpuQ2hJaENjdUFoYkZHVXEvMlZSc0dQWWhj?=
 =?utf-8?B?MEtvYUllRXF4dFdLeVh5SGwwUFBVeUNvT1F2S2hXYWNPV0ROa284Y3U5U1c4?=
 =?utf-8?Q?GM3XPaD3GmgIQyWGjYKW4H14vn7NF2G89hFkowo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRUMHI5MzJybUFGcWgyMlluYlJsVk85dElIdlVzSE0yazBQYTd2Z245aHBJ?=
 =?utf-8?B?NWUwLy8ySnd0MDhtV0FSdzkvWjNZZGMyRmViVE5ueklFQjNBTGtpU1FySmtH?=
 =?utf-8?B?NXRMS0V5ZFRBR1ZDK1cwRWh1TkJrSHhEbnZ2Q0kvazUzWDJxTVVOWlBHZWda?=
 =?utf-8?B?NlljcEsvckR6Y2Vyc0ZWRng1RVhzaUFLYkZYMEVJeCtMMWRjc2VGbEUzbGxX?=
 =?utf-8?B?MWdGSXFXbFVid0dhSzNXdk54R1Vyc2I5VmxTMnBRcm94eEszQnZneTlUenJy?=
 =?utf-8?B?VEY4UUVRT2RWejh2dUJZSUQxcXU0TkpwcnNlOHptYnVFRnhPMWVyQU1waEtU?=
 =?utf-8?B?VUR3Yk5lOEV2dGdUVDZvUE0zdlhvUlJFd21XeHpMNlpJckFRcFI5d1ZPdkFY?=
 =?utf-8?B?ZzJYb00rY0R6enlrVEVwVHhDa2g0LzNlWVlSWlg4NnlaUkJ3TTZJa1V1VzdC?=
 =?utf-8?B?RXhYWFJsVUcwNGJFM3JVNGF1dkR0bkswYlUzdjhSUTB1cFBDM3BVWGFvSkRs?=
 =?utf-8?B?b1V5WnE2R1VjaXRMVzVBcWVjL0EyRllrZUE4djdXS0V6ZytZd2x4Vzdydi9G?=
 =?utf-8?B?YWJ3cUdSU3B1dzFTcE9vOFZVTU1DSktFZU90T1FjR1AxOFlRZjYwS2UyZUR1?=
 =?utf-8?B?TGw4SmJ5c0J4cDMwMmtsRUprL3FNYjlSUnc2RDYyamdDRzJzWDNsQXNoRnRs?=
 =?utf-8?B?ZzJCZXE3QVNtSlNmcWYrbm8wVjFkWUlRZGp2ZHltV1pVQjZtbUZ5ODBpMldr?=
 =?utf-8?B?S0xPR0FrWVRjbEdGODJKcGJ3TDYzdnY2aURweHBJclB4TjVTQzhscCtBSkRN?=
 =?utf-8?B?RmdwQkc3QVlCNUZqZW9qOEcvSE9KZi85QmpCeHdkSUU5UDAvNDlWVWRYa3BV?=
 =?utf-8?B?T0RvdXBmcjNnL1FMbm1UaWtsNFV1UGkxcjdGekhkK3pPakp5SFJrTlcxcVBB?=
 =?utf-8?B?Rm85Vm1VejlXcFpZUFpiaXJlbm1uTlJFQm1uaTg2Rk1hMzRrY2xJbk1NaTE4?=
 =?utf-8?B?U3o0M3Z6d0g0NlprN0x4ZjlFSmVackM1cTVDdjZTMkNLeWVTRFM4Mlg3bmFs?=
 =?utf-8?B?dWk4d0Eyc2k1UzZmT2RmT1BRWGNoM3dXZ1EzblVmaWNKR2tZOFd3RzVDK2ZX?=
 =?utf-8?B?ZDlTMjkyZ1NBcjJBYytvWkZxUW95ZndzT3l0VWZveG5iM2hWVjg0c1hiZUgv?=
 =?utf-8?B?VThYVWdmcXI4NEc2aEx6eTNmUFRIL3VtWXNyV2RNQm9NWUZlM2N6U0tmOGhZ?=
 =?utf-8?B?dzYxSlNHYVFxZktJUG5FRjgrZGxSNmYxTjNLNjQ2RFdhVmFqSEp3NEhuNTdr?=
 =?utf-8?B?MnN4bUYxNTN5VWFHWWxTRTR0UjBEcEhTcTJ0bHNXeitxUmVhRlhPdFZzR0Vu?=
 =?utf-8?B?UzNYNGc2UUNKMVBwZ2V2REIvWVRIeG9rNWZVNXZvMXI2UFlUS3RhZVJNQUJv?=
 =?utf-8?B?WmtpNEZUSE9xTUo3aTF5R3NvVFRTc1QrT0lBdk0zYjZWNk5sY3J3emViV1Ro?=
 =?utf-8?B?b3F1aGppcndjNEUxbmR3ZzFaQzhUcmxTc0p0M1RRVDNmQ3pnUjNacTlRVmlI?=
 =?utf-8?B?VXNPY1BOR214dXAyeVYzV3NFYTBNOUZPNzl6QjFsNVlYaTZUSEh5aEdGTXBY?=
 =?utf-8?B?cC92cm40Yjc2dkZGbmxBQ1JDL0d0S013cDhjLzcxcFhDV1FrTWVUSHAvQytH?=
 =?utf-8?B?eXRiVXJwVXE5bFhFZ3lmK3hrNU5OK0tQMTBHQ3R1SEtJMVpRY2RRZFNjLzN0?=
 =?utf-8?B?ckE5NTNIdk54UFZsODQ1eUh5T1hvbmoyNGYrL0JBQ2xUcUZ4dUJSK1RQd3lT?=
 =?utf-8?B?eFRzdFJxcUV1Q28xMkJTTDlMZ0NHdmFDZTRyQmJMMXU0VEk0SDIxOWZtTUZH?=
 =?utf-8?B?aG9lWlM4ZDhNcVEvMVZhUExuOVk4WmI5Z2xXeG9sMWFmOVhTOGFpL0FjcmQy?=
 =?utf-8?B?eW9rQWtmRDdkMDV0TitvRFoxWFo5VkNqNkM2dHFUTHBUeGxsMmRoeXNxOUlz?=
 =?utf-8?B?Q3JlNmQyU1ZLaDJ5S240bklxZk9RcW1PREYxTis5QXVzbWhIQ0orbnpwSzh5?=
 =?utf-8?B?UUNpUkZpdWhYTDdkaXN6T1g1c0hHQWFzSkdrWG1BdjA2SDYyV3MzNW4zKzkv?=
 =?utf-8?B?UDZoUTVrTEtrZzRlRlVoWnZ5UVpHc1cxWWd3N3Z1V0tkWGxRYkpraDZQVkZn?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TfXCy8Hc+i+o4WrBIZicSbowBu8qdH4+P/CtwMCM3JedhaQmIS6OjQrLNTsyw3msLFwm749mAr+CWUOhxBXF0DKMBBdbf+ntSEIVvpLOj9G9Znoj0lHWQuSuh52/l9faIuGSog0JdcL+U5axbrjySn/QECK76E4H6G5vWLNUQNhlNAhYMvftBti+fjE3IUoWaVZRHVB5OaBk4nJha5oYn8P2iwyicSuJVUGZ2Zqw4/1ZEAVv9BGijxcWuJO9Em7nEEkN6aEb5rl6pggqa/isTlmt5fLZssUdlZ1991hdUbK8/dSHpCOh/EClMlOlYqKa4MLI6p2GevOAInogjGfM4gWYI2uCtVTU5xnNG2GDE3ehgOMThQ8h4YGFe9Pxa7wnfHDMwUVsC0lJsjoigI1J8EIQObVa+tHgjb7vNopd8S+ceLuQTokjXCXDZ75BOWik3YAEVP32+5ihGCSnDv1ugQ/5OuWFlJKPokISLnpF2hI01VGR9TNkTC1hk1DyXLpYJv1/wTVoBLAjt26I1DNjWkpdU0LR5lqEUE598fMTL4HrhQGOxEelYTo+7HG78Kkgcmd3y2fsrcyJbqlzePPJ9e1/s1IaWJsE+DVImz/UthQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970b7ce1-063f-4e21-1d69-08dcffe1135a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:35:33.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBGSsKbFcwPcemWWODWWvnhA31OB6e6rnAXWmvpYWzC4oiqjUQnrZdmYUcCuJp9HSQDg/3gvuKLqrWo3bd0qV+cTJwJ6x+jRg1LnuQgshCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080086
X-Proofpoint-GUID: VjFmHZ-GIkP2kVr7RWUJOoD9bbI1_w2E
X-Proofpoint-ORIG-GUID: VjFmHZ-GIkP2kVr7RWUJOoD9bbI1_w2E

On Thu, Nov 07, 2024 at 10:15:31PM +0100, Jann Horn wrote:
> On Thu, Nov 7, 2024 at 8:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be used when it comes to interacting with
> > mm_struct and vm_area_struct objects.
>
> Thanks, I think this is looking pretty good now.

Thanks! I think we're iterating towards the final product bit by bit.

>
> > +VMA fields
> > +^^^^^^^^^^
> > +
> > +We can subdivide :c:struct:`!struct vm_area_struct` fields by their purpose, which makes it
> > +easier to explore their locking characteristics:
> > +
> > +.. note:: We exclude VMA lock-specific fields here to avoid confusion, as these
> > +         are in effect an internal implementation detail.
> > +
> > +.. table:: Virtual layout fields
> > +
> > +   ===================== ======================================== ===========
> > +   Field                 Description                              Write lock
> > +   ===================== ======================================== ===========
> [...]
> > +   :c:member:`!vm_pgoff` Describes the page offset into the file, rmap write.
> > +                         the original page offset within the      mmap write,
> > +                         virtual address space (prior to any      rmap write.
> > +                         :c:func:`!mremap`), or PFN if a PFN map
> > +                         and the architecture does not support
> > +                         :c:macro:`!CONFIG_ARCH_HAS_PTE_SPECIAL`.
>
> Is that a typo in the rightmost column? "rmap write. mmap write, rmap
> write." lists rmap twice

Yep, I noticed this very shortly after sending the patch, have fixed for v2.

>
> > +   ===================== ======================================== ===========
> > +
> > +These fields describes the size, start and end of the VMA, and as such cannot be
>
> s/describes/describe/
>
> > +modified without first being hidden from the reverse mapping since these fields
> > +are used to locate VMAs within the reverse mapping interval trees.
> [...]
> > +.. table:: Reverse mapping fields
> > +
> > +   =================================== ========================================= ================
> > +   Field                               Description                               Write lock
> > +   =================================== ========================================= ================
> > +   :c:member:`!shared.rb`              A red/black tree node used, if the        mmap write,
> > +                                       mapping is file-backed, to place the VMA  VMA write,
> > +                                       in the                                    i_mmap write.
> > +                                       :c:member:`!struct address_space->i_mmap`
> > +                                      red/black interval tree.
>
> This list of write locks is correct regarding what locks you need to
> make changes to the VMA's tree membership. Technically at a lower
> level, the contents of vma->shared.rb are written while holding only
> the file rmap lock when the surrounding rbtree nodes change, but
> that's because the rbtree basically takes ownership of the node once
> it's been inserted into the tree. But I don't know how to concisely
> express that here, and it's kind of a nitpicky detail, so I think the
> current version looks good.

Yeah, I think we have to limit how far we go to keep this readable :)

>
> Maybe you could add "For changing the VMA's association with the
> rbtree:" on top of the list of write locks for this one?
>
> > +   :c:member:`!shared.rb_subtree_last` Metadata used for management of the
> > +                                       interval tree if the VMA is file-backed.  mmap write,
> > +                                                                                 VMA write,
> > +                                                                                 i_mmap write.
>
> For this one, I think it would be more accurate to say that it is
> written under just the i_mmap write lock. Though maybe that looks
> kinda inconsistent with the previous one...

But I think you probably have to hold the others to make the change, I think we
are good to hand-wave a bit here.

There's an argument for not even listing these fields as an impl detail (as
I decided to do with the VMA lock fields), but to be consistent with
anon_vma which we really do _have_ to talk about.

>
> > +   :c:member:`!anon_vma_chain`         List of links to forked/CoW’d anon_vma    mmap read,
> > +                                       objects.                                  anon_vma write.
>
> Technically not just forked/CoW'd ones, but also the current one.
> Maybe something like "List of links to anon_vma objects (including
> inherited ones) that anonymous pages can be associated with"?

Yeah, true, I thought it was important to emphasise this as you have the
one you will use for exclusively mapped folios in ->anon_vma, but we should
mention this, will update to be more accurate.

I don't like the 'related anon_vma's or the vagueness of 'associated with'
so I think better to say 'forked/CoW'd anon_vma objects and vma->anon_vma
if non-NULL'.

The whole topic of anon_vma's is a fraught mess (hey I did some nice
diagrams describing it in the book though :P) so want to be as specific as
I can here.

>
> > +   :c:member:`!anon_vma`               :c:type:`!anon_vma` object used by        mmap_read,
> > +                                       anonymous folios mapped exclusively to    page_table_lock.
> > +                                      this VMA.
>
> move_vma() uses unlink_anon_vmas() to change ->anon_vma from non-NULL
> to NULL. There we hold:
>
>  - mmap lock (exclusive, from sys_mremap)
>  - VMA write lock (from move_vma)
>  - anon_vma lock (from unlink_anon_vmas)
>
> So it's not true that we always hold the page_table_lock for this.
>
> Should this maybe have two separate parts, one for "for changing NULL
> -> non-NULL" and one for "changing non-NULL to NULL"? Where the
> NULL->non-NULL scenario uses the locks you listed and non-NULL->NULL
> relies on write-locking the VMA and the anon_vma?

Yeah, there's some annoying inconsistencies, I sort of meant this as 'at
minimum' thinking the anon_vma lock might be implicit once set but that's
silly, you're right, I will be explicit here and update as you say.

Have added some more details on anon_vma_prepare() etc here too.

>
> > +   =================================== ========================================= ================
> > +
> > +These fields are used to both place the VMA within the reverse mapping, and for
> > +anonymous mappings, to be able to access both related :c:struct:`!struct anon_vma` objects
> > +and the :c:struct:`!struct anon_vma` which folios mapped exclusively to this VMA should
>
> typo: s/which folios/in which folios/

Ack, fixed.

>
> > +reside.
> > +
> > +Page tables
> > +-----------
> > +
> > +We won't speak exhaustively on the subject but broadly speaking, page tables map
> > +virtual addresses to physical ones through a series of page tables, each of
> > +which contain entries with physical addresses for the next page table level
> > +(along with flags), and at the leaf level the physical addresses of the
> > +underlying physical data pages (with offsets into these pages provided by the
> > +virtual address itself).
> > +
> > +In Linux these are divided into five levels - PGD, P4D, PUD, PMD and PTE. Huge
> > +pages might eliminate one or two of these levels, but when this is the case we
> > +typically refer to the leaf level as the PTE level regardless.
>
> (That last sentence doesn't match my headcanon but I also don't have
> any reference for what is common Linux kernel phrasing around this so
> this isn't really an actionable comment.)

Does it match your head directory/entry? ;)

>
> > +.. note:: In instances where the architecture supports fewer page tables than
> > +   five the kernel cleverly 'folds' page table levels, that is skips them within
> > +   the logic, regardless we can act as if there were always five.
> > +
> > +There are three key operations typically performed on page tables:
> > +
> > +1. **Installing** page table mappings - whether creating a new mapping or
> > +   modifying an existing one.
> > +2. **Zapping/unmapping** page tables - This is what the kernel calls clearing page
>
> bikeshedding, feel free to ignore:
> Maybe "Zapping/unmapping page table entries"? At least that's how I
> always read "zap_pte_range()" in my head - "zap page table entry
> range". Though I don't know if that's the canonical interpretation.

Yeah that's a good idea actually, will update.

>
> > +   table mappings at the leaf level only, whilst leaving all page tables in
> > +   place. This is a very common operation in the kernel performed on file
> > +   truncation, the :c:macro:`!MADV_DONTNEED` operation via :c:func:`!madvise`,
> > +   and others. This is performed by a number of functions including
> > +   :c:func:`!unmap_mapping_range`, :c:func:`!unmap_mapping_pages` and reverse
> > +   mapping logic.
> [...]
> > +Locking rules
> > +^^^^^^^^^^^^^
> > +
> > +We establish basic locking rules when interacting with page tables:
> > +
> > +* When changing a page table entry the page table lock for that page table
> > +  **must** be held.
>
> (except, as you described below, in free_pgtables() when changing page
> table entries pointing to lower-level page tables)

Ack will spell that out.

>
> > +* Reads from and writes to page table entries must be appropriately atomic. See
> > +  the section on atomicity below.
> [...]
> > +Page table installation
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > +PGD, P4D or PUD, the :c:member:`!mm->page_table_lock` must be held. This is
> > +acquired in :c:func:`!__p4d_alloc`, :c:func:`!__pud_alloc` and
> > +:c:func:`!__pmd_alloc` respectively.
> > +
> > +.. note:: :c:func:`!__pmd_alloc` actually invokes :c:func:`!pud_lock` and
> > +   :c:func:`!pud_lockptr` in turn, however at the time of writing it ultimately
> > +   references the :c:member:`!mm->page_table_lock`.
> > +
> > +Allocating a PTE will either use the :c:member:`!mm->page_table_lock` or, if
> > +:c:macro:`!USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD
>
> typo: s/used/use/

Ack but probably better as s/used// here I think :>) Fixed.

>
> > +physical page metadata in the form of a :c:struct:`!struct ptdesc`, acquired by
> > +:c:func:`!pmd_ptdesc` called from :c:func:`!pmd_lock` and ultimately
> > +:c:func:`!__pte_alloc`.
> > +
> > +Finally, modifying the contents of the PTE has special treatment, as this is a
>
> nit: unclear what "this" refers to here - it looks like it refers to
> "the PTE", but "the PTE is a lock" wouldn't make grammatical sense

The PTE lock, have fixed.

>
> > +lock that we must acquire whenever we want stable and exclusive access to
> > +entries pointing to data pages within a PTE, especially when we wish to modify
> > +them.
>
> I don't think "entries pointing to data pages" need any more locking
> than other entries, like swap entries or migration markers?

Ack updated.

>
> > +This is performed via :c:func:`!pte_offset_map_lock` which carefully checks to
> > +ensure that the PTE hasn't changed from under us, ultimately invoking
> > +:c:func:`!pte_lockptr` to obtain a spin lock at PTE granularity contained within
> > +the :c:struct:`!struct ptdesc` associated with the physical PTE page. The lock
> > +must be released via :c:func:`!pte_unmap_unlock`.
> > +
> > +.. note:: There are some variants on this, such as
> > +   :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stable but
> > +   for brevity we do not explore this.  See the comment for
> > +   :c:func:`!__pte_offset_map_lock` for more details.
> > +
> > +When modifying data in ranges we typically only wish to allocate higher page
> > +tables as necessary, using these locks to avoid races or overwriting anything,
> > +and set/clear data at the PTE level as required (for instance when page faulting
> > +or zapping).
> [...]
> > +Page table moving
> > +^^^^^^^^^^^^^^^^^
> > +
> > +Some functions manipulate page table levels above PMD (that is PUD, P4D and PGD
> > +page tables). Most notable of these is :c:func:`!mremap`, which is capable of
> > +moving higher level page tables.
> > +
> > +In these instances, it is either required that **all** locks are taken, that is
> > +the mmap lock, the VMA lock and the relevant rmap lock, or that the mmap lock
> > +and VMA locks are taken and some other measure is taken to avoid rmap races (see
> > +the comment in :c:func:`!move_ptes` in the :c:func:`!mremap` implementation for
> > +details of how this is handled in this instance).
>
> mremap() always takes the rmap locks when moving entire page tables,
> and AFAIK that is necessary to avoid races that lead to TLB flushes
> going to the wrong address. mremap() sometimes moves *leaf entries*
> without holding rmap locks, but never entire tables.
>
> move_pgt_entry() is confusingly written - need_rmap_locks is actually
> always true in the NORMAL_* cases that move non-leaf entries.

OK you're right, this NORMAL_ vs HPAGE_ thing... ugh mremap() needs a TOTAL
REFACTOR. Another bit of churn for Lorenzo churn king Stoakes to get to at
some point :P

Have updated.

I eventually want to put as much as I possibly can into mm/vma.c so we can
make as many things userland unit testable as possible. But that's in the
future :)

>
> > +You can observe that in the :c:func:`!mremap` implementation in the functions
> > +:c:func:`!take_rmap_locks` and :c:func:`!drop_rmap_locks` which perform the rmap
> > +side of lock acquisition, invoked ultimately by :c:func:`!move_page_tables`.
> > +
> > +VMA lock internals
> > +------------------
> > +
> > +This kind of locking is entirely optimistic - if the lock is contended or a
> > +competing write has started, then we do not obtain a read lock.
> > +
> > +The :c:func:`!lock_vma_under_rcu` function first calls :c:func:`!rcu_read_lock`
> > +to ensure that the VMA is acquired in an RCU critical section, then attempts to
>
> Maybe s/is acquired in/is looked up in/, to make it clearer that
> you're talking about a VMA lookup?

Ack, this is why the maple tree is so critical here as it's
'RCU-friendly'. Have updated.

>
> > +VMA lock it via :c:func:`!vma_start_read`, before releasing the RCU lock via
> > +:c:func:`!rcu_read_unlock`.
> > +
> > +VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
> > +their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
> > +via :c:func:`!vma_end_read`.
> > +
> > +VMA **write** locks are acquired via :c:func:`!vma_start_write` in instances where a
> > +VMA is about to be modified, unlike :c:func:`!vma_start_read` the lock is always
> > +acquired. An mmap write lock **must** be held for the duration of the VMA write
> > +lock, releasing or downgrading the mmap write lock also releases the VMA write
> > +lock so there is no :c:func:`!vma_end_write` function.
> > +
> > +Note that a semaphore write lock is not held across a VMA lock. Rather, a
> > +sequence number is used for serialisation, and the write semaphore is only
> > +acquired at the point of write lock to update this.
> > +
> > +This ensures the semantics we require - VMA write locks provide exclusive write
> > +access to the VMA.
> > +
> > +The VMA lock mechanism is designed to be a lightweight means of avoiding the use
> > +of the heavily contended mmap lock. It is implemented using a combination of a
> > +read/write semaphore and sequence numbers belonging to the containing
> > +:c:struct:`!struct mm_struct` and the VMA.
> > +
> > +Read locks are acquired via :c:func:`!vma_start_read`, which is an optimistic
> > +operation, i.e. it tries to acquire a read lock but returns false if it is
> > +unable to do so. At the end of the read operation, :c:func:`!vma_end_read` is
> > +called to release the VMA read lock. This can be done under RCU alone.
>
> Please clarify what "This" refers to, and whether the part about RCU
> is explaining an implementation detail or the API contract.

Ack have added a chonky comment on this.

>
> > +
> > +Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> > +:c:func:`!vma_start_write`, however the write lock is released by the termination or
> > +downgrade of the mmap write lock so no :c:func:`!vma_end_write` is required.
> > +
> > +All this is achieved by the use of per-mm and per-VMA sequence counts, which are
> > +used in order to reduce complexity, especially for operations which write-lock
> > +multiple VMAs at once.
> > +
> > +If the mm sequence count, :c:member:`!mm->mm_lock_seq` is equal to the VMA
> > +sequence count :c:member:`!vma->vm_lock_seq` then the VMA is write-locked. If
> > +they differ, then they are not.
>
> nit: "it is not"?

Ack, fixed.

>
> > +
> > +Each time an mmap write lock is acquired in :c:func:`!mmap_write_lock`,
> > +:c:func:`!mmap_write_lock_nested`, :c:func:`!mmap_write_lock_killable`, the
> > +:c:member:`!mm->mm_lock_seq` sequence number is incremented via
> > +:c:func:`!mm_lock_seqcount_begin`.
> > +
> > +Each time the mmap write lock is released in :c:func:`!mmap_write_unlock` or
> > +:c:func:`!mmap_write_downgrade`, :c:func:`!vma_end_write_all` is invoked which
> > +also increments :c:member:`!mm->mm_lock_seq` via
> > +:c:func:`!mm_lock_seqcount_end`.
> > +
> > +This way, we ensure regardless of the VMA's sequence number count, that a write
> > +lock is not incorrectly indicated (since we increment the sequence counter on
> > +acquiring the mmap write lock, which is required in order to obtain a VMA write
> > +lock), and that when we release an mmap write lock, we efficiently release
> > +**all** VMA write locks contained within the mmap at the same time.
>
> Incrementing on mmap_write_lock() is not necessary for VMA locks; that
> part is for future seqlock-style users of the MM sequence count that
> want to work without even taking the VMA lock, with the new
> mmap_lock_speculation_{begin,end} API. See commit db8f33d3b7698 and
> the thread https://lore.kernel.org/linux-mm/20241010205644.3831427-5-andrii@kernel.org/
> .

Right, was aware of that part but thought we'd want to increment anyway,
however I suppose given you increment on lock _release_ it isn't
necessary. We will be extending this section (or... Suren maybe will? ;)

