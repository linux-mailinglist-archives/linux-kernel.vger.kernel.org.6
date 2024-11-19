Return-Path: <linux-kernel+bounces-414363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7769D271D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86E7B2CAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A01C1F2A;
	Tue, 19 Nov 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="R8HuG8WC"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191F4C3D0;
	Tue, 19 Nov 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023253; cv=fail; b=iz0Ax0HB6PZ1ps0hHQFJVaNy4+iziAkCr9jvK2plF0fcOyfMYAwLAVxC1gvZ/+LIs1E/TTPke/48pQYD2KuoZN6WY3uXhb1Qd+7etnOmdftPFu3DiuYIQsIeDva3UxLY0OIESqKWC+M1HW+gL9bcdRv0m3ncXgLl+iWuQ71P1Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023253; c=relaxed/simple;
	bh=+AAXerAzDQgDFl9ReD2gX8W42zyPkfXBvxU4Wnq6ae4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQSFzw4eutZpV/erFBhUjA04GWqrza+DgpqOXn4+SqsHoIwjRFEL521J50beOheTT8WSiCBiy/CUrxtg1WxdAVpGrTUf0q0/jXc1vh94nKsxr6qy/4I32l5pbJXc8Hfgvz9GmNkltS+LI4KkVHw6uq4oX+IgvxJpTV5UTxSdrz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=R8HuG8WC; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDI3IR025195;
	Tue, 19 Nov 2024 13:33:43 GMT
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011028.outbound.protection.outlook.com [40.93.131.28])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42xhh31m07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 13:33:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQjLOwT/mx2WStTy+VGJYk4k6Q4Wqeh6eFu+MAzkghkkNdBkYrlVvD/RRz9iEGmJWQOOMLh1j9LavbXkPHUFjWN6//jzFIEWxtO0cvrn67DMqj5sWgIXBneLYO2AI/vKjm/2/7xwZMG4HBKHDsbiA5IdOZyHlEaF0tBSxyTJ5C07kXFiykhoSDWoMa1A6pyBvpP0qVh0kP4iWRjQT5nFrZvUAtm6im965OP6kxsZSzhT924cFuWKW+S8h4yH8sYPVqevvRkikbqhP94TyA3t/WC50fsDfZCui3V7ZjbHeFIEfFTjOI3H5LsycB9Ye95GRV7ROEjGkT2w7K3//uPZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AAXerAzDQgDFl9ReD2gX8W42zyPkfXBvxU4Wnq6ae4=;
 b=TBIMK3G1HatsJnVTL0NeCppCBScSHPQjzyvTfX0+e6r1N1S73ggT5EAuQEQr3dtgPr/GWAPOMSduykDr5Qze4d/V1A/JIeg7XAMv07t/f3WigZGkvoYeusPdyegDTLs4WKrOVIPj59wg9XGwRO/WyHZpTTyU0KdD3Bi4tYIyG7pvTLnshpPNdWZbq7rb4/sK+h+ay3MNlBBoUGI7akL4bdgriEebtyvtjjMEINA6LJnhOa5pCI1IWytik4zchgszuI0qOJs2QOlnA/+VjnKq0GgiLm/YlgiyvFz/MvlBfUebQdMuyjfcIH3kORcMkKd5YCOp/IlfiALhR1+ixquG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AAXerAzDQgDFl9ReD2gX8W42zyPkfXBvxU4Wnq6ae4=;
 b=R8HuG8WCHQhrBgjtZrKIxFnKaxkW0Zdxhrk8fyQFJ+sxsSRlKzLq53JdbrN4EyFTkHeKMQXh9CAkoJoo8q+3/OJOy41rKFvmkOPvA38PZMCqvyNSrdEKsDYHet7fyrbga14ThyHuy7AKJJDl1AQ89UocioHF7aSvkRCJyQlEHKE=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MAXPR01MB4469.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 13:33:35 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 13:33:34 +0000
Message-ID: <bc471aeb-e9fd-4aa9-9bcc-a59d3c2e47b8@blaize.com>
Date: Tue, 19 Nov 2024 13:33:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: Add Blaize vendor prefix
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
 <20241115-blaize-blzp1600_init_board_support-v5-1-c09094e63dc5@blaize.com>
 <c1885e24-8051-4c91-9870-18eb4218a2ff@kernel.org>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <c1885e24-8051-4c91-9870-18eb4218a2ff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0304.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::21) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|MAXPR01MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 77094ad2-0c99-4aab-b40f-08dd089ec423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTJWVk9hZnFPTEQ2UU1yN2dmN0MyUFJwMUNwZXl2TkU0d1Y5Q0hiTTNoaFNQ?=
 =?utf-8?B?Y2JmUWFWa2t4K2NVVi9qMEgrZVBkRGxWY1phWmV6Wno4QjN1QmNmM2JhSmdZ?=
 =?utf-8?B?Q0lubkxlTUF6ZWt2ZVZJWlQ5c0JZLzczbWtNTytpTzBwU3J2emRrYzU3Ykdv?=
 =?utf-8?B?Q1d5MHJEV2MxQVJVTUpJWExEMjJIR3ArSnFtTTByR2QzZnJXWm1UdU91eFY3?=
 =?utf-8?B?b3cvbTRYNlNqYWRJN2hLbmh2WTRBdzVrUXZrU2o2SEFuT0ZSQUlKNDlQRnlL?=
 =?utf-8?B?SjNnZ0dzb2VOajJYZC9PVDQrVnlPd3gzVU9CdG11T2gwWXdFL3JITG1zV3Bj?=
 =?utf-8?B?QndSYUNMeFBENnNXTkpIb3VocXZNQlRpcFhYbTArcG5wb2tnL1d4R205dnB3?=
 =?utf-8?B?Vm1SR2pXQ3NxZXF4akVyYlI3MEFNNTdWZU9FZnFMYWxBQjlLc1M3ZTdyU2ZS?=
 =?utf-8?B?RnlVY3RqSTVlNE5VeVpQOGtlU01yRVR0aHFyZDVhWkZzcURscitLMlltOVd6?=
 =?utf-8?B?elFZQmJHZnNqWWRWY3RvNTJKeERqaXVVN0hkRm5tN2V0Y21rbXZZdGh0UHBW?=
 =?utf-8?B?MDQvanVzSmxUdUM3bEpMQmlDQmtKQnF5b3BlSnI0TU9EUElzQjlhanloYlha?=
 =?utf-8?B?cWg5MmVwWStERVFIVE4zTXBVS1ZWeWJidFdqWWhwZjg3YUZVSXFYWm8raWp0?=
 =?utf-8?B?T0RKbXZTUTdVcHJBRmZwcmJmMVAzR0ZERzIzYURsMHFLYjgvTndET0NuSWEr?=
 =?utf-8?B?WnBIOW9seDhyYktwWENpOXV2eEhSbEJZNzU1RGRUb2Nrd2YwN1A0Y2lGY0Zr?=
 =?utf-8?B?NUU4YkRtcXVia050NTNvdGh2NUI1cUxMVGNuL1FrRDRKL2V2NFQ4ajNVQWpK?=
 =?utf-8?B?MkZ5S1MrdDRiN3R4dEE4RDRGL2NVc2NBYk81M01yZi80N1haNXdUNVJ0Z0pz?=
 =?utf-8?B?eit6WkM4VnpZYlQ5cFFYR0p4TWkydjMxSW9WNklDaWlhR1QweFRtQzdSWDgy?=
 =?utf-8?B?ZkZkVzRxTkRsckg2c0RDMmN3Q3p6TmpXenhjeTlXQ0Y2a3JCUnB6Y3NEQ2xv?=
 =?utf-8?B?UDdMZWlmVjBCSXNGdTM1czdaS3FkbE9Fd3FsZk1FeGZvMXVHSjdVWENnYmY4?=
 =?utf-8?B?eFFFTjRLbEFIalZlSlNhaUhWbVE1bVd2cm9RaXpYNjBNNDdKRjVacXZvS1Q5?=
 =?utf-8?B?UGRMSk9NYzFhMXZvZXRVVFZvRlJkL0Y0RTlRekJiaGRVSEFGdEh5dnd1d1dX?=
 =?utf-8?B?UnBEUVMxdUxSNjdHbUFHQldHMEs2WEU5ZGFzdkhPSGcvRksvbjJZbTVXS2VJ?=
 =?utf-8?B?dmw5R093a3JWY3B4WUNXS3dOREY1emNFVEZxN0hadGJ5UHJ1eHJ6WHJlalVZ?=
 =?utf-8?B?YTRDV1hHb0NISW1hcDlhT3ZoYVJmL09LQ2QwMTR5WjBBWjh5SEZKb0FkRHQ4?=
 =?utf-8?B?ckllUTdzRjJQZ1grdmFtOEVlaWZMSEh6TWE4M09mWjZwM1JnNXJuK3hLMHVa?=
 =?utf-8?B?N2RZdml1VFdJWnlLbTRlbHRxeVlXZkVON3lPU0toeWN3Sitmejh6VE1QQW85?=
 =?utf-8?B?bXozVjBhWkJPekhPQ3BKL1ZEbUJwZWxPdHVvSWg1Z2g2SEZpMTYxTXlTcU80?=
 =?utf-8?B?VjRJTDhSSll4NjFLNVNwQldvT0JUZEpFOStEVUF1T01PQlVPZ0t4bGh6QUVR?=
 =?utf-8?B?M3VEWm5sa2RyY0djNDZid3c0RklIdDd0M3FvUTY0NGJnajU3VVlSK1lLZWJr?=
 =?utf-8?Q?K6teegCk9ryerrdUPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RLYWdNT0U5MTBPSFhMeSs3U2hRbnBZRDQ0QkFzMWZzM3VlL3N5djFFT29X?=
 =?utf-8?B?N2dtckY1ZzEvVFRRb0FhRVJtT0NjaEhyd3JKVmErN21ianNFY3FPNEwxZFd2?=
 =?utf-8?B?dlhTc0RQTm03cUd6bmU1Q2hIalNNZE5FOVBjVVVlakdQMHg2Nkxic1p4Rk9V?=
 =?utf-8?B?SGs1WW1kWng3U1VOWDhCNUQ4cUYxREZ0OTdrUERCckoxdHZMUWhqUUY3Y2oz?=
 =?utf-8?B?UVRlMksvL0QwTFB2MWxWcEJENnh6VXM0QXlkZmtON2NTT1h6bTUvMGI3WWhr?=
 =?utf-8?B?cUE2S05MVXo5UmFqeFRQSEZKOU1uRktwQ1pWYjJ1Rkc3UFNERnZoTmJLb0tv?=
 =?utf-8?B?N0pTSWdvRmtVSlJsTFVDK0Q3eW9ueXdlZ2xZS29mSE5sTGFRWHZ5SXo0dWVL?=
 =?utf-8?B?VXVvYy9nc29icVA0WUVnK0pOUUlCdWZFZGZNZ1RGaVNLQ3lxM3dlT1hLdXBv?=
 =?utf-8?B?cWZwRFRHTGdDNndNTzFSS3FWWDdnbXZ4bzhlVVA3bTNGR0lVRGFqUkNmWk83?=
 =?utf-8?B?dUZCcCtEYUpETmJMaXV1NFh2ZWdwQ2lFdzYyZ0tpRUZZeGhmZ0pYQVc1dS9U?=
 =?utf-8?B?RkhiaUcyYWorb3B6L040Qm5nSWdHay81OTZZeHo2SXFWVVFnR0ZKbXBzZUxN?=
 =?utf-8?B?cFkrbE0yNUo0MHhzNUNUQXVSNFZQT3BoeXE2bGNCU2tDUytuQWZsM3c1L2JD?=
 =?utf-8?B?ODVMcklreVBCbEVDQXp2SHAzbDFqaHJrNWpkN2V2bFZWSFo1NUpPWFllQ0dk?=
 =?utf-8?B?c1JocldRUFRLOXJPRjZrNjdiZGkyY3NnbGFtUkhqZXdsSGpGOFMvSWpyanhq?=
 =?utf-8?B?Z1RvckJrcUtRbTRId1d4UjRpYkVlZEsyNTd3RXNYMW81bTd6d0JOTTJPT3p5?=
 =?utf-8?B?cld1bCtyTk01NW94dDh4ZWZCWS8xQmlJd2NsQXBsTU90Q0tMSkVlQXdicW5a?=
 =?utf-8?B?U0FvZWNxbWhKYk9aNUhjRm1WbC95YWFOdEw1ZGsvMDRhVkVPZ0duc2ZhYUta?=
 =?utf-8?B?ei9kY2gvK3pydmVsSHV5VEdJNmtVWmZ2WFRuOHFPNmdXMVZ0NGVWREZGZWpJ?=
 =?utf-8?B?NU5OKzB4MzdCdkJEeTRBMERBTnBKekdxbzRuRWxPWHNWRnNSZDR6RlBZZmRF?=
 =?utf-8?B?b1crbXNjbXV5RnFEanhkd2xuTmxOUjd6WWZNaXRuMUtUTDZhV2lkNmVLekMz?=
 =?utf-8?B?ZmdjbGhZdTZXYjdGZGR6SklrdS92M2Faa3pwZElTWkhQZGs1dGcvWUw4RmZw?=
 =?utf-8?B?aGNVREhhbFdxeEVXYTEvZnRHYjRsRnJ1bjRLdGwvMkFwdnduMU9RVEo0MjNF?=
 =?utf-8?B?TU4zWmRreUxJc2JTaERqeThjWWRxZm1xbDBEY1cxRGYvTkFKMDBpVDJwZVVs?=
 =?utf-8?B?ZG5aZWt4RVM0WDBmYkh6WXdwWE9GNXNvdk5xaEFwcnlFTUVvTWpkc0hCMnBr?=
 =?utf-8?B?WEtoSWJIeSs1cGN6TkNNZVhMZkZaOEFGZCsxb2t5UXBCdDF5UUh2amV3ZytG?=
 =?utf-8?B?QVdwd1R4NFJrbTlFUFFHa1BxSTBlL0lpZTlLVENwMXJCSW83SXkwUjYwZnQx?=
 =?utf-8?B?b2lZdkRqSEx4RU1rOVNBN0dWTFBTY3FNUXFHWVQyaDlHR0g2QkMvWUloMDJK?=
 =?utf-8?B?TjM3cnpyMlVmZDhCMGNrTW54cU9ubkFvbDJ5ckxBN084T3lzVnpFbzJxaFgv?=
 =?utf-8?B?WjF6OVdtakpHbTBJVktsb2p5T0NwbUJ3WStOZVRZclBFZXFyWC9GYkFzallw?=
 =?utf-8?B?UkIxN3o5dk5zSjF1K3hXd2R0RHI2K0VVdWcwd1ZxcDgycDRSTDk0SkEwUWt0?=
 =?utf-8?B?WWZxUmkyU2h1djg1Ym4vQ1c1a3kzSzFNaHhram9BaURIRjVWbFM0RWxOa0NE?=
 =?utf-8?B?ZWRNSUMvNkNrR0dlR0JQTTZuejF3eDFTZVFBTjJ5T2VoSi9OZ2FSZ1V6U0po?=
 =?utf-8?B?bWR4VndNRXVNMkY0SlB3STg1Sm01WE9VYUpXRVJyMmRDK2QrSGpZUEd6WFVJ?=
 =?utf-8?B?allMZXQ1V25NR3NBck5XR2hCalhkcTdLTERwb0RVODhjNW5Sb0d1dkZjR3ZZ?=
 =?utf-8?B?QVBEdnNGcFRLMW5CdGhLM2hpUXpEMnYrcExUL2duMFF1dlovUmR2RnpDenVs?=
 =?utf-8?B?N0lZdGlFTnJ0UXFGYlJHeFVJcUpQNDlNRUM0aE0zeE9ldXNsOXRmOTZjT3dj?=
 =?utf-8?Q?/tikrcmLzVDJpyWWRmrc8bg=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77094ad2-0c99-4aab-b40f-08dd089ec423
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:33:34.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6kbvE/FmBjNRMCzsh9FEcHkZub7nSUhm6nfVmV9+B+4pVIhAQzvBPqB7S+P1QdLVvnKvZEjzBlBoMfZCB4PEjYHBxxIkSK2PWxPLm3ul4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4469
X-Authority-Analysis: v=2.4 cv=RPThHJi+ c=1 sm=1 tr=0 ts=673c93b7 cx=c_pps a=g6sBawl8R0naeIbhPH00Eg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=VwQbUJbxAAAA:8 a=VSt9yKUrDmGmnA9fhqMA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-GUID: 87sWYVPv-czs5zeEbzhsCZaPm_6fIHlV
X-Proofpoint-ORIG-GUID: 87sWYVPv-czs5zeEbzhsCZaPm_6fIHlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_05,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

On 19/11/2024 13:05, Krzysztof Kozlowski wrote:
> On 15/11/2024 15:58, Niko Pasaloukos wrote:
>> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
>> programmable Graph-Streaming-Processors for AI and ML.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> Here and in all other patches - you still have the same checkpatch
> warning I asked to fix.
>
>
> git format-patch -6 -v5
> scripts/checkpatch.pl v5*
>
> Your SoB does not match From. This MUST be fixed.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Just to be certain and fix it properly, do you mean that the issue that you
are talking about is that the 'From' appears as 'Niko Pasaloukos' and I am
signing with SoB as 'Nikolaos Pasaloukos'?
I'm really sorry, if that's the case, I will fix it and yes, there must be
a misconfiguration on my system. Would I need to prepare a v6 for this?
If it is not that, then I am really sorry but I will need more information.

Best regards,
Nikolaos Pasaloukos


