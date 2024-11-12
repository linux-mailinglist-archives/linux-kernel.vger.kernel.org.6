Return-Path: <linux-kernel+bounces-406169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33F9C5BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82E8BA0D59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B12003A0;
	Tue, 12 Nov 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EODsUSv7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s/ADpEKU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45871FF046;
	Tue, 12 Nov 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424600; cv=fail; b=EDGQKpIXcepP+xi2VjRAY4H7BFupGiLKHeFxbvNN6a6Zv1BfvdHRyMyDI2kx3QoU3LcLpXgOtDRjpkv08hRx3zKJ1XOyu3Q+zPYqzwhoC5+BUm7frWudQUv+4A/pXMhPVHmuLE+flmjEX1fLYfl2bHG1gHpE+vrrTR26mym+H/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424600; c=relaxed/simple;
	bh=UNczo7Z1bQrk2bu4hdahmgYUAdZp/CV6SY5Z0p7esdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3zx2Y69+12vNs04uUwMeVv9/oYJI5SFPlX0O2LiMcmhlyEp9tGXfYiVoxgADZgWEaYQOjQfRXbVQ3XbueIgxGI+KGKzq6jssGrSv3q9RqmD8G2t0xNxsl9Y6EYI3qbZNDFSy/iVUrdSH/wxoXtiEwHvKhSEhO9yNynxmijsYNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EODsUSv7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s/ADpEKU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBYq5017063;
	Tue, 12 Nov 2024 15:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ASY7GICo/AKBRCgAAGIcANFUS+FAgJ1tIfADqWIhEak=; b=
	EODsUSv7fWL9RPqToWID+3F6Q2HcF+81R0qVobUF2dWGkJL/PsApN5ledZ2DZwBq
	CzYXQ6vC46sFSSvBaI6MCuLgG/eOL15VoLzWz+mdb/et0fd/aBbz67glT0su1mwQ
	zlqV7aykMFd0ua0NOLCnKGLpVXyhS65g4/jmhVNt2cB3pR5QcAmS+Cq3yWJMnrRZ
	qsHRR9wQ7XbOW0XGCAg7cUZL1dhlK4G93UEG0uLh8O1mQXqf7ViqV28VoL4xsMNS
	lt6xhcHXN3VSflq5jYuy7OydBIwUqfx49dhyZdpA7V2lPxWHHlXNGTrgCOE/d6ZL
	mj237tEzp4I8RNb9bPAyHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k24kq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:15:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEGT0o001217;
	Tue, 12 Nov 2024 15:15:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx689r8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlJqsDe8TD9VEivZ7cl1Exxyzeui07IIEE1nR/Mt/w2Uam2ccrIbsO83Nl5WQ53ZkfLxPbTeh7HUpe8Y2QBMSpcUyZg3QN4v6dbupuNxcI3J4aQdPL8hwK+SgvjbIMHBJJKKHx2Vzq0QzD/OQYgcCwVx0NDeZTF+iXxh8jm8cmA+8wPpHgjADUCkWqlTyMmBjLV4zf6ToBVx4HU+Gfq0Yc4FnJE/QNnYB8DeQN5Qo6ZwO7N+s7JTGBsB8hiwOoyo/OdmNKPwNCfJhh0ha6r5WspayTQkMH4xgg2G2mN7vuX5FetjNz06uFSm+j87JejZU8nn1CxI7e7NHwBkGwtP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASY7GICo/AKBRCgAAGIcANFUS+FAgJ1tIfADqWIhEak=;
 b=l2kChyEFIjUQ1+AjoOQX3KCpccyZKu6tQp2Wly8xQhpLkb8g4cqoTeqj7Qht/lx1bLKlTnN5jrcGCeRrcd0Vk2THGRBs/sCdUOotNs4D+2IMg7Xat8GDh2qEpT95CPqL/FbEv90ZHjMhMN21RiCWdbdxmkat6/B1rXGKoN2O3js87QAyhDfZkWZe57EvCPLqt3Xla1U7Yb685KaaGjcToOK7qegkNhZps+hqC20LvJs0wqkWN5NDqcgV9YbIjH5nbdBV26mz9bOwQrPp1Ot5DNEY7Wdl3LdJzoKMUecUW522d+MHBr0QfEKBWOEoG8/Oc7fOfGHzL+YM0an5FOka/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASY7GICo/AKBRCgAAGIcANFUS+FAgJ1tIfADqWIhEak=;
 b=s/ADpEKUwQxkLjEc9bUTurASdp0HRR4gc6mZBu1yeVjR7Z0k+3rnxKP0yZZFbVStifN64W11TG4qx5YrH3YsptuthFlNiVuRpqDggIrS6JDQAxIn1Iw8ZrK/SDMP3CVA7aFsNFDtBHz1VdYJb8AF39HinsQ+Re6hGqU2hQgWww4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6151.namprd10.prod.outlook.com (2603:10b6:8:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:15:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:15:48 +0000
Date: Tue, 12 Nov 2024 10:15:44 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, SeongJae Park <sj@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0421.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2b8be8-7511-42df-ef15-08dd032ce361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFhSenk4TjIvNUFHb2FLeXB3U0xwMmpWenJKVVZxMjZYUWJBVk9qQVNlQ0Uv?=
 =?utf-8?B?L2U3a2NlMEhrRDIrV3B6Znc5NjE5MU9nMzE1ZGFPWTJoclREQ0lsZWgwQmts?=
 =?utf-8?B?ZHNiSEJ2cEZ3dE14THRyZS9EWUczd0l6dzBvQ2gxQnFlVHAvdHgzNndVczNv?=
 =?utf-8?B?VlVxSHY2SG50bS83eitKWUlKdExWaVFnSTFzWTJhVnNySERXT0o2T3NrUW5S?=
 =?utf-8?B?bHd2VDdidVV6KzBxY3QxbkcrWEI1V2t6RXRnUWFpdmVaaW9lSnZ2cVV3dVlx?=
 =?utf-8?B?ZHovMFdJUko5WTBLaCsrb1lnYnNFdmlhSkFKRjB4Tm5LVVpIS3BVazRlYmRv?=
 =?utf-8?B?TGJGcFlyN1ZjcmVlazNFd1dCRSszOUt3YkM0Q1U3enJzZnVkeU94cmNKbWND?=
 =?utf-8?B?cUg0TEEwSzdXUlhXcWl6NXZNcmQ4SVcxUHN4ZjJ2akpnT0Fxa3BtbE0xMTJT?=
 =?utf-8?B?OHRDUUJ3RGVKUmw2cUVPUXpGV0dPcE9aZEg3SkhGOHJNUmdKTFRqNHZVb0Rv?=
 =?utf-8?B?SlU2b1BmTm9rd0ZDMXBqVmFwVmI0N01jZGlNc0dIYU53M2FkdDhwRkN1SVk2?=
 =?utf-8?B?WWk3OGpYdWZlcHpHcUVuZ3BRUDVpempqYWxPcytUMEdwSzhpZ25DaHZqT09l?=
 =?utf-8?B?bXBZTGp1UzBpTjJ6dCtRVkRVVHNHb3dRdURHRU9Nc2tuVTJvZlVKQ1JFMk1N?=
 =?utf-8?B?d3VScHhLdkxaOXJ1U040bG9uVXQ1TUFEQnI3T3B2SEZ4QitqaWZpQVA1ODFm?=
 =?utf-8?B?Q0RDMHBDR3cxQXVnVVcvS1l6dXJjaVNOWDJpak81cGpjTVdTdFlrTmN1RGtM?=
 =?utf-8?B?MDZOZmtuSklTL2J1eDUwN0hkQWN2dVhUY21qUnF6K3RRODhVWU9YcXg2VGhv?=
 =?utf-8?B?cEVIZzVraTRYWHlDM1VDOWVrbmhXWlY5SmIycXR4ZTJ1MGVIYnlCMlBnekNN?=
 =?utf-8?B?OEYrWmN2bjRhYTc3eTVyRE92a3Y5YXFGQ1pQYURKc2RZT2JLMmNBMUFzZ2hn?=
 =?utf-8?B?T2M2VnlUelB1T0d5a0xCdTQ4Y3Y5TXpFQURiWWlLOVpLMWtDczUzNExpYTd1?=
 =?utf-8?B?UUh0SzdIMzJ2d213NXlqSitobXBERlVPakhnTW0rLzZ3OXU5R2RiNWt2aHFF?=
 =?utf-8?B?bmxGejNFZzI5NDh0dUdXdWhJaW0rZXlvUGVQSXcvZ2lMVTM4MHE1R3NmS04y?=
 =?utf-8?B?d0VKeTVVNFJLeFk2bHhHMXB5VXo5Si9xMEhxOGJxWlE2elpJTFVHU25RY0tu?=
 =?utf-8?B?NU1nTEFsSTRaN0phd3V4Uk9vamQra1dzbXhCU25INDAwUGFGM285QjkvZjlB?=
 =?utf-8?B?TnV5dGl6MmYrcG43bTZMV0ZhYlFyaUNkdG0wS21rZ29TaTFWRUt3bG9KR1Rh?=
 =?utf-8?B?UFUrdmNRRHdOTTd2QUJ2TlpMZVNIa3prSkxUSEZweUh3aXF2SzMyZGxMOGZB?=
 =?utf-8?B?UnNZcUp1dXlkcGdaTU9qYUF0TFBwR1pPaUFVNENlRDduVE9oblpKOVUzblE0?=
 =?utf-8?B?elEwUXNLMS8rM3ZialBrdzZWd2JiYi9vUFBRSEhEUDFlcVhoQmxCWEdpSVcw?=
 =?utf-8?B?anZaVXNyems0bDRHdkZhSndTSkpoakkrVDgwdWFaQmw2bjEwWVpIbit6NUZO?=
 =?utf-8?B?ME84NDJJZ3E0ZUpNdjdyM09qQTR2TmlVb1J5am9jOUF6TUNtUjVYdkhHSFZ2?=
 =?utf-8?B?NVdyVEs2QXFvUzM0ZVdhQVFwSEh3VjFxUzhVR3hZTlh3bFhXK0Z2TWV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGMyZStERmNHZlFNTHc4ZXhSeDZDSVdOMndNMXh6ajFRTmNSZ1FZK29xdzRI?=
 =?utf-8?B?M28rYVVTeEhiblVaVGRDeXM3OTZMUWtNVnRjaG5VOTZ0bGJ3dHZsbGpWM1ZB?=
 =?utf-8?B?cDltTzIzdmdXTmc3SXNQUHNNVTZWanZiRTJlcjlQYWZYdjVrS2swR2FUL1Vl?=
 =?utf-8?B?aFdKTEx4Qm85VVlvWE9ITmRlNGNtamxuWWEwNS9CN0k4cE8rMStFd1pMTXo5?=
 =?utf-8?B?OHVtZjM4TFoxeVprNWNJMmtuNktvdXlEYkRhWnp1SWd1WWptbGh2SFYzZ0E4?=
 =?utf-8?B?ZEo0N1RMc1ZVNGt3ZDVJQUVZM29icTZDOXFybUYvTFIrM2hIZjY2OU1pMXIv?=
 =?utf-8?B?ellibjlMemxOSkJkVVRKSytSTWlCaVRVM1M5TU5xZEd1bzU0RnZ5dkxvcHFT?=
 =?utf-8?B?dUFOdXdaUFhUczhQR1pjb21EYlA3MUJVazNmMVZWOUdIYjZqaFhITU9FTU4x?=
 =?utf-8?B?RmovUUZKSk0vdlFueFVjU1ZRT082UFVNY1N4d21SR09OMk9iQmlOUi8wRkJ0?=
 =?utf-8?B?bkNjYlh1d3dRY0c2dU1WdEwrMURmLzVRTVVRc2RFSUpRN0VtZS8xaG9ka1Y2?=
 =?utf-8?B?elROaU5UNnlvNnBaNE1xRW9XK2RPVDhCNE4ydDFiTW5wOFBNblNTd2o2S2Rz?=
 =?utf-8?B?L3YrVlZlYWVMVTB2QjJiMXZMMFR3UWpGVS9vSlRQWjJFeDlrT2lEanRLajl4?=
 =?utf-8?B?NzlST3dOS1FmZC9DK0VIL2JDeWhTT0k4UnZUZS9rZkU1dVlmTzRvNU42eFVl?=
 =?utf-8?B?SEtRbXVhUXR5Ny8yT0NBZzRQMDRER0VsTC80blNnZUF2d01laEQ5SS92bzBQ?=
 =?utf-8?B?b0IzdFVMaW9ud25ZQlFjaXBRSlBaTDk3UlM3Tk84akswS25SQ09lR3dFSlhP?=
 =?utf-8?B?WnRVOTh6S01IL0FhVVBnMzlvdnU3dm9WbnVZUTJmNDJNZXlBTm1qandDUUVJ?=
 =?utf-8?B?T0tPWWpSVHhFUVdodGE1K2lHUHhOMkt1TjhWK21QQVRha3daNnh6U0NQSVc1?=
 =?utf-8?B?OGJQL2JlQzZSSVp2ZVR0TExDR2VWSitvb0FEUkZFVEhhZ3ZrOUJLY1RLbXFJ?=
 =?utf-8?B?UktEMVZjNFJWaUNVc0d2YWh2cEhLQUlMSTZ1NEZTWHlEQjNlck8vcm54TzRD?=
 =?utf-8?B?d3JJZnFrOUpkN0FpMHBxbnEwMmlDM3hPL2laU3k4TWtqOVQ0dFlMUUwwc0FB?=
 =?utf-8?B?VVFuOTJhSGQvK3Bvd3RkMHBzS1BveGgxajFZZU5vTlI2b3JhbGFDSmdnM2FR?=
 =?utf-8?B?dXJUNUw4bmlTam5iZ2hGdCtmWUdqQ3JJVzdOcUVaMm5wemdad0NiLzZoRTdB?=
 =?utf-8?B?cW9tQVlGdXk4dS9PVWtOcnBxRW9DaTFiQ0w4TWg2TWRmS0VCWVduSHdRbnNy?=
 =?utf-8?B?MWpFRGRITXRjUDgybm0yL3QxQjU4QjJ4QlE2ZFRVTC9OZEgxZnErQVlJQytW?=
 =?utf-8?B?M256a0hCVEpSY1JOd0xDRVNpTlMxSUM0TVEvcDY0RFVIWElUemtFRk43UXJJ?=
 =?utf-8?B?UmsvWXRRU2pWWmZnb3dkYkVTZDAwL2k5c0RIVXFSWXovaG96VC8vUEFYUlBO?=
 =?utf-8?B?dHNDbjQ5RWVUZFpzTVMyZDVmODZuV3pzTVlNVDYwTXhuUWM3U201dmg2VWlz?=
 =?utf-8?B?SGRRL0xYeWkzb2FEYmRBa2tLRWFJSFRPRmVLWmlTOUlxU3hyTE5CeTZmRkJv?=
 =?utf-8?B?dUlxZmxmY3NnVzZrYUZaWCtTU0ZaL0ZmYjhJQW1VL0hYallaYkFyZDZjN1M2?=
 =?utf-8?B?UGtVd2lXQ1lLVFRqaVhlZXYraFJJd0RkV3h4TEF2TGU4akErYitkS2p3OTUv?=
 =?utf-8?B?M09XVXp0TXh2bEliRVpwRkZPMUZ5T0FhNGJMeVMxeVhJbDNFNHV0ZnplSmdR?=
 =?utf-8?B?SzNST1g0dkozR2FrWmhrK0dCdkNBcklHSlNWMXJzR3IvNm9MamhROGVCTmxk?=
 =?utf-8?B?emRuaW1rSDlyVnppZnIzMnVpR01ocFJuZFVaUEpSNGppUG9EcXVwaHpLU0Fw?=
 =?utf-8?B?MFJZeWtGRnMvb3N3citUNURJeUVIb2RDeGJCQVBzUWdGTCt5bGJMSVlrd042?=
 =?utf-8?B?c25obzRzK2Rtemdua01wWWFUY0VtUXAxdGNVcjNiRU9vK3dKR3J2TzM0eUho?=
 =?utf-8?Q?wHeTunyqv2xx9FKeaNU0D0tiR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hbYOeljnvzK2/UnWuLnnUjSuEG79vsqad4i14VACIoG3dqxLlCO4kAC5R7pHOhR32WAS4odVmqbDVnPXrreAG4sWUFnYbToKdoL+B2fmGpmL2aNHFHNlanyQ2+oRIbEZSwcxgF5ad9j/lCsyp0Cc6eUeJhfMJaezuvdNHOO6UrAORFusLb4mN0LUognY9XY8VI4QbZ0m1cJL2Cgv1lu7DH/5wlci42AhROdgTWnj/VnWYu8QGR/VNhmxbps78UMD5OoLigl/JOEsy5XNT8InU6BlCLoifl01Nqgw8yRcGzC/olE+KB+2IyLVCc0lS8e4REcSa97XjE1YFcETT0VzljzctOQ+GzluY46Nk3D8n7o61oMyyCWcoVlVJk+VDV48ax/vAGrAFColp4a5b2yqYukoQtiPgfH3JKkyIMxLjzYyMWtqeLBMiAO2zIl6Y6HUBSdwc3ttsbminA3qd9hDvSHj8UUzhX7BGnUt5i84mh1Q+09OuUUmse/OjOV7XEbJvPYWGQU7lqGQqLunFxnHRKRM0M47GSUiJzBmRy+hbtKr/hZkyS6jUKX68mvypA3XP8GGRRiytq/VT+2MKWFF3NFgEajAFHldEZ8WqjndWrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2b8be8-7511-42df-ef15-08dd032ce361
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:15:48.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRWJVDzvY5jJXtJTcnC2TMTKlTylSDfQ7LzI7raJ5SPOiC/SnIzChmtXqQpxO0paCQf/Wu9RiCIzeRqMfbyfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120122
X-Proofpoint-ORIG-GUID: d2ZCYGpY5SUDbkKMl07vt7zpKIeCZipw
X-Proofpoint-GUID: d2ZCYGpY5SUDbkKMl07vt7zpKIeCZipw

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241108 08:57]:
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documentin=
g
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.
>=20
> This is especially pertinent as regards the efforts to find sensible
> abstractions for these fundamental objects in kernel rust code whose
> compiler strictly requires some means of expressing these rules (and
> through this expression, self-document these requirements as well as
> enforce them).
>=20
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and reli=
es
> upon us handling these correctly).
>=20
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardow=
n.
>=20
> The document is split between generally useful information for users of m=
m
> interfaces, and separately a section intended for mm kernel developers
> providing a discussion around internal implementation details.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>=20
> REVIEWERS NOTES:
> * As before, for convenience, I've uploaded a render of this document to =
my
>   website at https://ljs.io/v2/mm/process_addrs
> * You can speed up doc builds by running `make SPHINXDIRS=3Dmm htmldocs`.
>=20
> v2:
> * Fixed grammar and silly typos in various places.
> * Further sharpening up of prose.
> * Updated remark about empty -> populated requiring mmap lock not rmap -
>   this goes for populating _anything_, as we don't want to race the gap
>   between zap and freeing of page tables which _assumes_ you can't do thi=
s.
> * Clarified point on installing page table entries with rmap locks only.
> * Updated swap_readahead_info and numab state entries to mention other
>   locks/atomicity as per Kirill.
> * Improved description of vma->anon_vma and vma->anon_vma_chain as per
>   Jann.
> * Expanded vma->anon-vma to add more details.
> * Various typos/small tweaks via Jann.
> * Clarified mremap() higher page table lock requirements as per Jann.
> * Clarified that lock_vma_under_rcu() _looks up_ the VMA under RCU as per
>   Jann.
> * Clarified RCU requirement for VMA read lock in VMA lock implementation
>   detail section as per Jann.
> * Removed reference to seqnumber increment on mmap write lock as out of
>   scope at the moment, and incorrect explanation on this (is intended for
>   speculation going forward) as per Jann.
> * Added filemap.c lock ordering also as per Kirill.
> * Made the reference to anon/file-backed interval tree root nodes more
>   explicit in implementation detail section.
> * Added note about `MAP_PRIVATE` being in both anon_vma and i_mmap trees.
> * Expanded description of page table folding as per Bagas.
> * Added missing details about _traversing_ page tables.
> * Added the caveat that we can just go ahead and read higher page table
>   levels if we are simply _traversing_, but if we are to install page tab=
le
>   locks must be acquired and the read double-checked.
> * Corrected the comments about gup-fast - we are simply traversing in
>   gup-fast, which like other page table traversal logic does not acquire
>   page table locks, but _also_ does not keep the VMA stable.
> * Added more details about PMD/PTE lock acquisition in
>   __pte__offset_map_lock().
>=20
> v1:
> * Removed RFC tag as I think we are iterating towards something workable
>   and there is interest.
> * Cleaned up and sharpened the language, structure and layout. Separated
>   into top-level details and implementation sections as per Alice.
> * Replaced links with rather more readable formatting.
> * Improved valid mmap/VMA lock state table.
> * Put VMA locks section into the process addresses document as per SJ and
>   Mike.
> * Made clear as to read/write operations against VMA object rather than
>   userland memory, as per Mike's suggestion, also that it does not refer =
to
>   page tables as per Jann.
> * Moved note into main section as per Mike's suggestion.
> * Fixed grammar mistake as per Mike.
> * Converted list-table to table as per Mike.
> * Corrected various typos as per Jann, Suren.
> * Updated reference to page fault arches as per Jann.
> * Corrected mistaken write lock criteria for vm_lock_seq as per Jann.
> * Updated vm_pgoff description to reference CONFIG_ARCH_HAS_PTE_SPECIAL a=
s
>   per Jann.
> * Updated write lock to mmap read for vma->numab_state as per Jann.
> * Clarified that the write lock is on the mmap and VMA lock at VMA
>   granularity earlier in description as per Suren.
> * Added explicit note at top of VMA lock section to explicitly highlight
>   VMA lock semantics as per Suren.
> * Updated required locking for vma lock fields to N/A to avoid confusion =
as
>   per Suren.
> * Corrected description of mmap_downgrade() as per Suren.
> * Added a note on gate VMAs as per Jann.
> * Explained that taking mmap read lock under VMA lock is a bad idea due t=
o
>   deadlock as per Jann.
> * Discussed atomicity in page table operations as per Jann.
> * Adapted the well thought out page table locking rules as provided by Ja=
nn.
> * Added a comment about pte mapping maintaining an RCU read lock.
> * Added clarification on moving page tables as informed by Jann's comment=
s
>   (though it turns out mremap() doesn't necessarily hold all locks if it
>   can resolve races other ways :)
> * Added Jann's diagram showing lock exclusivity characteristics.
> https://lore.kernel.org/all/20241107190137.58000-1-lorenzo.stoakes@oracle=
.com/
>=20
> RFC:
> https://lore.kernel.org/all/20241101185033.131880-1-lorenzo.stoakes@oracl=
e.com/
>=20
>  Documentation/mm/process_addrs.rst | 813 +++++++++++++++++++++++++++++
>  1 file changed, 813 insertions(+)
>=20
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/proces=
s_addrs.rst
> index e8618fbc62c9..5aef4fd0e0e9 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -3,3 +3,816 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Process Addresses
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 3
> +
> +
> +Userland memory ranges are tracked by the kernel via Virtual Memory Area=
s or
> +'VMA's of type :c:struct:`!struct vm_area_struct`.
> +
> +Each VMA describes a virtually contiguous memory range with identical
> +attributes, each described by a :c:struct:`!struct vm_area_struct`
> +object. Userland access outside of VMAs is invalid except in the case wh=
ere an
> +adjacent stack VMA could be extended to contain the accessed address.
> +
> +All VMAs are contained within one and only one virtual address space, de=
scribed
> +by a :c:struct:`!struct mm_struct` object which is referenced by all tas=
ks (that is,
> +threads) which share the virtual address space. We refer to this as the
> +:c:struct:`!mm`.
> +
> +Each mm object contains a maple tree data structure which describes all =
VMAs
> +within the virtual address space.
> +
> +.. note:: An exception to this is the 'gate' VMA which is provided by
> +          architectures which use :c:struct:`!vsyscall` and is a global =
static
> +          object which does not belong to any specific mm.

vvars too?

> +
> +-------
> +Locking
> +-------
> +
> +The kernel is designed to be highly scalable against concurrent read ope=
rations
> +on VMA **metadata** so a complicated set of locks are required to ensure=
 memory
> +corruption does not occur.
> +
> +.. note:: Locking VMAs for their metadata does not have any impact on th=
e memory
> +          they describe nor the page tables that map them.
> +
> +Terminology
> +-----------
> +
> +* **mmap locks** - Each MM has a read/write semaphore :c:member:`!mmap_l=
ock`
> +  which locks at a process address space granularity which can be acquir=
ed via
> +  :c:func:`!mmap_read_lock`, :c:func:`!mmap_write_lock` and variants.
> +* **VMA locks** - The VMA lock is at VMA granularity (of course) which b=
ehaves
> +  as a read/write semaphore in practice. A VMA read lock is obtained via
> +  :c:func:`!lock_vma_under_rcu` (and unlocked via :c:func:`!vma_end_read=
`) and a
> +  write lock via :c:func:`!vma_start_write` (all VMA write locks are unl=
ocked
> +  automatically when the mmap write lock is released). To take a VMA wri=
te lock
> +  you **must** have already acquired an :c:func:`!mmap_write_lock`.
> +* **rmap locks** - When trying to access VMAs through the reverse mappin=
g via a
> +  :c:struct:`!struct address_space` or :c:struct:`!struct anon_vma` obje=
ct
> +  (reachable from a folio via :c:member:`!folio->mapping`) VMAs must be =
stabilised via
> +  :c:func:`!anon_vma_[try]lock_read` or :c:func:`!anon_vma_[try]lock_wri=
te` for
> +  anonymous memory and :c:func:`!i_mmap_[try]lock_read` or
> +  :c:func:`!i_mmap_[try]lock_write` for file-backed memory. We refer to =
these
> +  locks as the reverse mapping locks, or 'rmap locks' for brevity.
> +
> +We discuss page table locks separately in the dedicated section below.
> +
> +The first thing **any** of these locks achieve is to **stabilise** the V=
MA
> +within the MM tree. That is, guaranteeing that the VMA object will not b=
e
> +deleted from under you nor modified (except for some specific fields
> +described below).
> +
> +Stabilising a VMA also keeps the address space described by it around.
> +
> +Using address space locks
> +-------------------------
> +
> +If you want to **read** VMA metadata fields or just keep the VMA stable,=
 you
> +must do one of the following:
> +
> +* Obtain an mmap read lock at the MM granularity via :c:func:`!mmap_read=
_lock` (or a
> +  suitable variant), unlocking it with a matching :c:func:`!mmap_read_un=
lock` when
> +  you're done with the VMA, *or*
> +* Try to obtain a VMA read lock via :c:func:`!lock_vma_under_rcu`. This =
tries to
> +  acquire the lock atomically so might fail, in which case fall-back log=
ic is
> +  required to instead obtain an mmap read lock if this returns :c:macro:=
`!NULL`,
> +  *or*
> +* Acquire an rmap lock before traversing the locked interval tree (wheth=
er
> +  anonymous or file-backed) to obtain the required VMA.
> +
> +If you want to **write** VMA metadata fields, then things vary depending=
 on the
> +field (we explore each VMA field in detail below). For the majority you =
must:
> +
> +* Obtain an mmap write lock at the MM granularity via :c:func:`!mmap_wri=
te_lock` (or a
> +  suitable variant), unlocking it with a matching :c:func:`!mmap_write_u=
nlock` when
> +  you're done with the VMA, *and*
> +* Obtain a VMA write lock via :c:func:`!vma_start_write` for each VMA yo=
u wish to
> +  modify, which will be released automatically when :c:func:`!mmap_write=
_unlock` is
> +  called.
> +* If you want to be able to write to **any** field, you must also hide t=
he VMA
> +  from the reverse mapping by obtaining an **rmap write lock**.
> +
> +VMA locks are special in that you must obtain an mmap **write** lock **f=
irst**
> +in order to obtain a VMA **write** lock. A VMA **read** lock however can=
 be
> +obtained without any other lock (:c:func:`!lock_vma_under_rcu` will acqu=
ire then
> +release an RCU lock to lookup the VMA for you).

This reduces the impact of a writer on readers by only impacting
conflicting areas of the vma tree.

> +
> +.. note:: The primary users of VMA read locks are page fault handlers, w=
hich
> +          means that without a VMA write lock, page faults will run conc=
urrent with
> +          whatever you are doing.

This is the primary user in that it's the most frequent, but as we
unwind other lock messes it is becoming a pattern.

Maybe "the most frequent users" ?


> +
> +Examining all valid lock states:
> +
> +.. table::
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   mmap lock VMA lock rmap lock Stable? Read? Write most? Write all?
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   \-        \-       \-        N       N     N           N
> +   \-        R        \-        Y       Y     N           N
> +   \-        \-       R/W       Y       Y     N           N
> +   R/W       \-/R     \-/R/W    Y       Y     N           N
> +   W         W        \-/R      Y       Y     Y           N
> +   W         W        W         Y       Y     Y           Y
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. warning:: While it's possible to obtain a VMA lock while holding an m=
map read lock,
> +             attempting to do the reverse is invalid as it can result in=
 deadlock - if
> +             another task already holds an mmap write lock and attempts =
to acquire a VMA
> +             write lock that will deadlock on the VMA read lock.
> +
> +All of these locks behave as read/write semaphores in practice, so you c=
an
> +obtain either a read or a write lock for each of these.
> +
> +.. note:: Generally speaking, a read/write semaphore is a class of lock =
which
> +          permits concurrent readers. However a write lock can only be o=
btained
> +          once all readers have left the critical region (and pending re=
aders
> +          made to wait).
> +
> +          This renders read locks on a read/write semaphore concurrent w=
ith other
> +          readers and write locks exclusive against all others holding t=
he semaphore.
> +
> +VMA fields
> +^^^^^^^^^^
> +
> +We can subdivide :c:struct:`!struct vm_area_struct` fields by their purp=
ose, which makes it
> +easier to explore their locking characteristics:
> +
> +.. note:: We exclude VMA lock-specific fields here to avoid confusion, a=
s these
> +          are in effect an internal implementation detail.
> +
> +.. table:: Virtual layout fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +   Field                 Description                              Write =
lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +   :c:member:`!vm_start` Inclusive start virtual address of range mmap w=
rite,
> +                         VMA describes.                           VMA wr=
ite,
> +                                                                  rmap w=
rite.
> +   :c:member:`!vm_end`   Exclusive end virtual address of range   mmap w=
rite,
> +                         VMA describes.                           VMA wr=
ite,
> +                                                                  rmap w=
rite.
> +   :c:member:`!vm_pgoff` Describes the page offset into the file, mmap w=
rite,
> +                         the original page offset within the      VMA wr=
ite,
> +                         virtual address space (prior to any      rmap w=
rite.
> +                         :c:func:`!mremap`), or PFN if a PFN map
> +                         and the architecture does not support
> +                         :c:macro:`!CONFIG_ARCH_HAS_PTE_SPECIAL`.
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +These fields describes the size, start and end of the VMA, and as such c=
annot be
> +modified without first being hidden from the reverse mapping since these=
 fields
> +are used to locate VMAs within the reverse mapping interval trees.
> +
> +.. table:: Core fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   Field                        Description                             =
 Write lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   :c:member:`!vm_mm`           Containing mm_struct.                   =
 None - written once on
> +                                                                        =
 initial map.
> +   :c:member:`!vm_page_prot`    Architecture-specific page table        =
 mmap write, VMA write.
> +                                protection bits determined from VMA
> +                                flags.
> +   :c:member:`!vm_flags`        Read-only access to VMA flags describing=
 N/A
> +                                attributes of the VMA, in union with
> +                                private writable
> +                                :c:member:`!__vm_flags`.
> +   :c:member:`!__vm_flags`      Private, writable access to VMA flags   =
 mmap write, VMA write.
> +                                field, updated by
> +                                :c:func:`!vm_flags_*` functions.
> +   :c:member:`!vm_file`         If the VMA is file-backed, points to a  =
 None - written once on
> +                                struct file object describing the       =
 initial map.
> +                                underlying file, if anonymous then
> +                                :c:macro:`!NULL`.
> +   :c:member:`!vm_ops`          If the VMA is file-backed, then either  =
 None - Written once on
> +                                the driver or file-system provides a    =
 initial map by
> +                                :c:struct:`!struct vm_operations_struct`=
 :c:func:`!f_ops->mmap()`.
> +                                object describing callbacks to be
> +                                invoked on VMA lifetime events.
> +   :c:member:`!vm_private_data` A :c:member:`!void *` field for         =
 Handled by driver.
> +                                driver-specific metadata.
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These are the core fields which describe the MM the VMA belongs to and i=
ts attributes.
> +
> +.. table:: Config-specific fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   Field                             Configuration option  Description  =
                            Write lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for s=
toring a                    mmap write,
> +                                                           :c:struct:`!s=
truct anon_vma_name`        VMA write.
> +                                                           object provid=
ing a name for anonymous
> +                                                           mappings, or =
:c:macro:`!NULL` if none
> +                                                           is set or the=
 VMA is file-backed.

These are ref counted and can be shared by more than one vma for
scalability.

> +   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used=
 by the swap mechanism      mmap read,
> +                                                           to perform re=
adahead. This field is      swap-specific
> +                                                           accessed atom=
ically.                     lock.
> +   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mem=
policy` object which        mmap write,
> +                                                           describes the=
 NUMA behaviour of the      VMA write.
> +                                                           VMA.

These are also ref counted for scalability.

> +   :c:member:`!numab_state`          CONFIG_NUMA_BALANCING :c:type:`!vma=
_numab_state` object which  mmap read,
> +                                                           describes the=
 current state of           numab-specific
> +                                                           NUMA balancin=
g in relation to this VMA.  lock.
> +                                                           Updated under=
 mmap read lock by
> +                                                           :c:func:`!tas=
k_numa_work`.
> +   :c:member:`!vm_userfaultfd_ctx`   CONFIG_USERFAULTFD    Userfaultfd c=
ontext wrapper object of    mmap write,
> +                                                           type :c:type:=
`!vm_userfaultfd_ctx`,      VMA write.
> +                                                           either of zer=
o size if userfaultfd is
> +                                                           disabled, or =
containing a pointer
> +                                                           to an underly=
ing
> +                                                           :c:type:`!use=
rfaultfd_ctx` object which
> +                                                           describes use=
rfaultfd metadata.
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These fields are present or not depending on whether the relevant kernel
> +configuration option is set.
> +
> +.. table:: Reverse mapping fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +   Field                               Description                      =
         Write lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +   :c:member:`!shared.rb`              A red/black tree node used, if th=
e        mmap write, VMA write,
> +                                       mapping is file-backed, to place =
the VMA  i_mmap write.
> +                                       in the
> +                                       :c:member:`!struct address_space-=
>i_mmap`
> +                                       red/black interval tree.
> +   :c:member:`!shared.rb_subtree_last` Metadata used for management of t=
he       mmap write, VMA write,
> +                                       interval tree if the VMA is file-=
backed.  i_mmap write.
> +   :c:member:`!anon_vma_chain`         List of pointers to both forked/C=
oW=E2=80=99d     mmap read, anon_vma write.
> +                                       :c:type:`!anon_vma` objects and
> +                                       :c:member:`!vma->anon_vma` if it =
is
> +                                       non-:c:macro:`!NULL`.
> +   :c:member:`!anon_vma`               :c:type:`!anon_vma` object used b=
y        When :c:macro:`NULL` and
> +                                       anonymous folios mapped exclusive=
ly to    setting non-:c:macro:`NULL`:
> +                                       this VMA. Initially set by       =
         mmap read, page_table_lock.
> +                                       :c:func:`!anon_vma_prepare` seria=
lised
> +                                       by the :c:macro:`!page_table_lock=
`. This  When non-:c:macro:`NULL` and
> +                                       is set as soon as any page is fau=
lted in. setting :c:macro:`NULL`:
> +                                                                        =
         mmap write, VMA write,
> +                                                                        =
         anon_vma write.
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These fields are used to both place the VMA within the reverse mapping, =
and for
> +anonymous mappings, to be able to access both related :c:struct:`!struct=
 anon_vma` objects
> +and the :c:struct:`!struct anon_vma` in which folios mapped exclusively =
to this VMA should
> +reside.
> +
> +.. note:: If a file-backed mapping is mapped with :c:macro:`!MAP_PRIVATE=
` set
> +          then it can be in both the :c:type:`!anon_vma` and :c:type:`!i=
_mmap`
> +          trees at the same time, so all of these fields might be utilis=
ed at
> +          once.
> +
> +Page tables
> +-----------
> +
> +We won't speak exhaustively on the subject but broadly speaking, page ta=
bles map
> +virtual addresses to physical ones through a series of page tables, each=
 of
> +which contain entries with physical addresses for the next page table le=
vel
> +(along with flags), and at the leaf level the physical addresses of the
> +underlying physical data pages or a special entry such as a swap entry,
> +migration entry or other special marker. Offsets into these pages are pr=
ovided
> +by the virtual address itself.
> +
> +In Linux these are divided into five levels - PGD, P4D, PUD, PMD and PTE=
. Huge
> +pages might eliminate one or two of these levels, but when this is the c=
ase we
> +typically refer to the leaf level as the PTE level regardless.
> +
> +.. note:: In instances where the architecture supports fewer page tables=
 than
> +	  five the kernel cleverly 'folds' page table levels, that is stubbing
> +	  out functions related to the skipped levels. This allows us to
> +	  conceptually act is if there were always five levels, even if the
> +	  compiler might, in practice, eliminate any code relating to missing
> +	  ones.
> +
> +There are free key operations typically performed on page tables:
> +
> +1. **Traversing** page tables - Simply reading page tables in order to t=
raverse
> +   them. This only requires that the VMA is kept stable, so a lock which
> +   establishes this suffices for traversal (there are also lockless vari=
ants
> +   which eliminate even this requirement, such as :c:func:`!gup_fast`).
> +2. **Installing** page table mappings - Whether creating a new mapping o=
r
> +   modifying an existing one. This requires that the VMA is kept stable =
via an
> +   mmap or VMA lock (explicitly not rmap locks).
> +3. **Zapping/unmapping** page table entries - This is what the kernel ca=
lls
> +   clearing page table mappings at the leaf level only, whilst leaving a=
ll page
> +   tables in place. This is a very common operation in the kernel perfor=
med on
> +   file truncation, the :c:macro:`!MADV_DONTNEED` operation via
> +   :c:func:`!madvise`, and others. This is performed by a number of func=
tions
> +   including :c:func:`!unmap_mapping_range` and :c:func:`!unmap_mapping_=
pages`
> +   among others. The VMA need only be kept stable for this operation.
> +4. **Freeing** page tables - When finally the kernel removes page tables=
 from a
> +   userland process (typically via :c:func:`!free_pgtables`) extreme car=
e must
> +   be taken to ensure this is done safely, as this logic finally frees a=
ll page
> +   tables in the specified range, ignoring existing leaf entries (it ass=
umes the
> +   caller has both zapped the range and prevented any further faults or
> +   modifications within it).
> +
> +**Traversing** and **zapping** ranges can be performed holding any one o=
f the
> +locks described in the terminology section above - that is the mmap lock=
, the
> +VMA lock or either of the reverse mapping locks.
> +
> +That is - as long as you keep the relevant VMA **stable** - you are good=
 to go
> +ahead and perform these operations on page tables (though internally, ke=
rnel
> +operations that perform writes also acquire internal page table locks to
> +serialise - see the page table implementation detail section for more de=
tails).
> +
> +When **installing** page table entries, the mmap or VMA lock mut be held=
 to keep
> +the VMA stable. We explore why this is in the page table locking details=
 section
> +below.
> +
> +**Freeing** page tables is an entirely internal memory management operat=
ion and
> +has special requirements (see the page freeing section below for more de=
tails).
> +
> +.. warning:: When **freeing** page tables, it must not be possible for V=
MAs
> +             containing the ranges those page tables map to be accessibl=
e via
> +             the reverse mapping.
> +
> +             The :c:func:`!free_pgtables` function removes the relevant =
VMAs
> +             from the reverse mappings, but no other VMAs can be permitt=
ed to be
> +             accessible and span the specified range.
> +
> +Lock ordering
> +-------------
> +
> +As we have multiple locks across the kernel which may or may not be take=
n at the
> +same time as explicit mm or VMA locks, we have to be wary of lock invers=
ion, and
> +the **order** in which locks are acquired and released becomes very impo=
rtant.
> +
> +.. note:: Lock inversion occurs when two threads need to acquire multipl=
e locks,
> +   but in doing so inadvertently cause a mutual deadlock.
> +
> +   For example, consider thread 1 which holds lock A and tries to acquir=
e lock B,
> +   while thread 2 holds lock B and tries to acquire lock A.
> +
> +   Both threads are now deadlocked on each other. However, had they atte=
mpted to
> +   acquire locks in the same order, one would have waited for the other =
to
> +   complete its work and no deadlock would have occurred.
> +
> +The opening comment in :c:macro:`!mm/rmap.c` describes in detail the req=
uired
> +ordering of locks within memory management code:
> +
> +.. code-block::
> +
> +  inode->i_rwsem        (while writing or truncating, not reading or fau=
lting)
> +    mm->mmap_lock
> +      mapping->invalidate_lock (in filemap_fault)
> +        folio_lock
> +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs b=
elow)
> +            vma_start_write
> +              mapping->i_mmap_rwsem
> +                anon_vma->rwsem
> +                  mm->page_table_lock or pte_lock
> +                    swap_lock (in swap_duplicate, swap_info_get)
> +                      mmlist_lock (in mmput, drain_mmlist and others)
> +                      mapping->private_lock (in block_dirty_folio)
> +                          i_pages lock (widely used)
> +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> +                      inode->i_lock (in set_page_dirty's __mark_inode_di=
rty)
> +                      bdi.wb->list_lock (in set_page_dirty's __mark_inod=
e_dirty)
> +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> +                        i_pages lock (widely used, in set_page_dirty,
> +                                  in arch-dependent flush_dcache_mmap_lo=
ck,
> +                                  within bdi.wb->list_lock in __sync_sin=
gle_inode)
> +
> +There is also a file-system specific lock ordering comment located at th=
e top of
> +:c:macro:`!mm/filemap.c`:
> +
> +.. code-block::
> +
> +  ->i_mmap_rwsem                (truncate_pagecache)
> +    ->private_lock              (__free_pte->block_dirty_folio)
> +      ->swap_lock               (exclusive_swap_page, others)
> +        ->i_pages lock
> +
> +  ->i_rwsem
> +    ->invalidate_lock           (acquired by fs in truncate path)
> +      ->i_mmap_rwsem            (truncate->unmap_mapping_range)
> +
> +  ->mmap_lock
> +    ->i_mmap_rwsem
> +      ->page_table_lock or pte_lock     (various, mainly in memory.c)
> +        ->i_pages lock  (arch-dependent flush_dcache_mmap_lock)
> +
> +  ->mmap_lock
> +    ->invalidate_lock           (filemap_fault)
> +      ->lock_page               (filemap_fault, access_process_vm)
> +
> +  ->i_rwsem                     (generic_perform_write)
> +    ->mmap_lock         (fault_in_readable->do_page_fault)
> +
> +  bdi->wb.list_lock
> +    sb_lock                     (fs/fs-writeback.c)
> +    ->i_pages lock              (__sync_single_inode)
> +
> +  ->i_mmap_rwsem
> +    ->anon_vma.lock             (vma_merge)
> +
> +  ->anon_vma.lock
> +    ->page_table_lock or pte_lock       (anon_vma_prepare and various)
> +
> +  ->page_table_lock or pte_lock
> +    ->swap_lock         (try_to_unmap_one)
> +    ->private_lock              (try_to_unmap_one)
> +    ->i_pages lock              (try_to_unmap_one)
> +    ->lruvec->lru_lock  (follow_page_mask->mark_page_accessed)
> +    ->lruvec->lru_lock  (check_pte_range->folio_isolate_lru)
> +    ->private_lock              (folio_remove_rmap_pte->set_page_dirty)
> +    ->i_pages lock              (folio_remove_rmap_pte->set_page_dirty)
> +    bdi.wb->list_lock           (folio_remove_rmap_pte->set_page_dirty)
> +    ->inode->i_lock             (folio_remove_rmap_pte->set_page_dirty)
> +    bdi.wb->list_lock           (zap_pte_range->set_page_dirty)
> +    ->inode->i_lock             (zap_pte_range->set_page_dirty)
> +    ->private_lock              (zap_pte_range->block_dirty_folio)
> +
> +Please check the current state of these comments which may have changed =
since
> +the time of writing of this document.

hugetlbfs has its own locking and is out of scope.

> +
> +------------------------------
> +Locking Implementation Details
> +------------------------------
> +
> +Page table locking details
> +--------------------------
> +
> +In addition to the locks described in the terminology section above, we =
have
> +additional locks dedicated to page tables:
> +
> +* **Higher level page table locks** - Higher level page tables, that is =
PGD, P4D
> +  and PUD each make use of the process address space granularity
> +  :c:member:`!mm->page_table_lock` lock when modified.
> +
> +* **Fine-grained page table locks** - PMDs and PTEs each have fine-grain=
ed locks
> +  either kept within the folios describing the page tables or allocated
> +  separated and pointed at by the folios if :c:macro:`!ALLOC_SPLIT_PTLOC=
KS` is
> +  set. The PMD spin lock is obtained via :c:func:`!pmd_lock`, however PT=
Es are
> +  mapped into higher memory (if a 32-bit system) and carefully locked vi=
a
> +  :c:func:`!pte_offset_map_lock`.
> +
> +These locks represent the minimum required to interact with each page ta=
ble
> +level, but there are further requirements.
> +
> +Importantly, note that on a **traversal** of page tables, no such locks =
are
> +taken. Whether care is taken on reading the page table entries depends o=
n the
> +architecture, see the section on atomicity below.
> +
> +Locking rules
> +^^^^^^^^^^^^^
> +
> +We establish basic locking rules when interacting with page tables:
> +
> +* When changing a page table entry the page table lock for that page tab=
le
> +  **must** be held, except if you can safely assume nobody can access th=
e page
> +  tables concurrently (such as on invocation of :c:func:`!free_pgtables`=
).
> +* Reads from and writes to page table entries must be *appropriately*
> +  atomic. See the section on atomicity below for details.
> +* Populating previously empty entries requires that the mmap or VMA lock=
s are
> +  held (read or write), doing so with only rmap locks would be dangerous=
 (see
> +  the warning below).

Which is the rmap lock?  It's not listed as rmap lock in the rmap file.

> +* As mentioned previously, zapping can be performed while simply keeping=
 the VMA
> +  stable, that is holding any one of the mmap, VMA or rmap locks.
> +* Special care is required for PTEs, as on 32-bit architectures these mu=
st be
> +  mapped into high memory and additionally, careful consideration must b=
e
> +  applied to racing with THP, migration or other concurrent kernel opera=
tions
> +  that might steal the entire PTE table from under us. All this is handl=
ed by
> +  :c:func:`!pte_offset_map_lock` (see the section on page table installa=
tion
> +  below for more details).
> +
> +.. warning:: Populating previously empty entries is dangerous as, when u=
nmapping
> +             VMAs, :c:func:`!vms_clear_ptes` has a window of time betwee=
n
> +             zapping (via :c:func:`!unmap_vmas`) and freeing page tables=
 (via
> +             :c:func:`!free_pgtables`), where the VMA is still visible i=
n the
> +             rmap tree. :c:func:`!free_pgtables` assumes that the zap ha=
s
> +             already been performed and removes PTEs unconditionally (al=
ong with
> +             all other page tables in the freed range), so installing ne=
w PTE
> +             entries could leak memory and also cause other unexpected a=
nd
> +             dangerous behaviour.
> +
> +There are additional rules applicable when moving page tables, which we =
discuss
> +in the section on this topic below.
> +
> +.. note:: Interestingly, :c:func:`!pte_offset_map_lock` holds an RCU rea=
d lock
> +          while the PTE page table lock is held.
> +
> +Atomicity
> +^^^^^^^^^
> +
> +Regardless of page table locks, the MMU hardware concurrently updates ac=
cessed
> +and dirty bits (perhaps more, depending on architecture). Additionally, =
page
> +table traversal operations in parallel (though holding the VMA stable) a=
nd
> +functionality like GUP-fast locklessly traverses (that is reads) page ta=
bles,
> +without even keeping the VMA stable at all.
> +
> +When performing a page table traversal and keeping the VMA stable, wheth=
er a
> +read must be performed once and only once or not depends on the architec=
ture
> +(for instance x86-64 does not require any special precautions).
> +
> +It is on the write side, or if a read informs whether a write takes plac=
e (on an
> +installation of a page table entry say, for instance in
> +:c:func:`!__pud_install`), where special care must always be taken. In t=
hese
> +cases we can never assume that page table locks give us entirely exclusi=
ve
> +access, and must retrieve page table entries once and only once.
> +
> +If we are reading page table entries, then we need only ensure that the =
compiler
> +does not rearrange our loads. This is achieved via :c:func:`!pXXp_get`
> +functions - :c:func:`!pgdp_get`, :c:func:`!p4dp_get`, :c:func:`!pudp_get=
`,
> +:c:func:`!pmdp_get`, and :c:func:`!ptep_get`.
> +
> +Each of these uses :c:func:`!READ_ONCE` to guarantee that the compiler r=
eads
> +the page table entry only once.
> +
> +However, if we wish to manipulate an existing page table entry and care =
about
> +the previously stored data, we must go further and use an hardware atomi=
c
> +operation as, for example, in :c:func:`!ptep_get_and_clear`.
> +
> +Equally, operations that do not rely on the VMA being held stable, such =
as
> +GUP-fast (see :c:func:`!gup_fast` and its various page table level handl=
ers like
> +:c:func:`!gup_fast_pte_range`), must very carefully interact with page t=
able
> +entries, using functions such as :c:func:`!ptep_get_lockless` and equiva=
lent for
> +higher level page table levels.
> +
> +Writes to page table entries must also be appropriately atomic, as estab=
lished
> +by :c:func:`!set_pXX` functions - :c:func:`!set_pgd`, :c:func:`!set_p4d`=
,
> +:c:func:`!set_pud`, :c:func:`!set_pmd`, and :c:func:`!set_pte`.
> +
> +Equally functions which clear page table entries must be appropriately a=
tomic,
> +as in :c:func:`!pXX_clear` functions - :c:func:`!pgd_clear`,
> +:c:func:`!p4d_clear`, :c:func:`!pud_clear`, :c:func:`!pmd_clear`, and
> +:c:func:`!pte_clear`.
> +
> +Page table installation
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Page table installation is performed with the VMA held stable explicitly=
 by an
> +mmap or VMA lock in read or write mode (see the warning in the locking r=
ules
> +section for details as to why).
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the =
above
> +PGD, P4D or PUD, the :c:member:`!mm->page_table_lock` must be held. This=
 is
> +acquired in :c:func:`!__p4d_alloc`, :c:func:`!__pud_alloc` and
> +:c:func:`!__pmd_alloc` respectively.
> +
> +.. note:: :c:func:`!__pmd_alloc` actually invokes :c:func:`!pud_lock` an=
d
> +   :c:func:`!pud_lockptr` in turn, however at the time of writing it ult=
imately
> +   references the :c:member:`!mm->page_table_lock`.
> +
> +Allocating a PTE will either use the :c:member:`!mm->page_table_lock` or=
, if
> +:c:macro:`!USE_SPLIT_PMD_PTLOCKS` is defined, a lock embedded in the PMD
> +physical page metadata in the form of a :c:struct:`!struct ptdesc`, acqu=
ired by
> +:c:func:`!pmd_ptdesc` called from :c:func:`!pmd_lock` and ultimately
> +:c:func:`!__pte_alloc`.
> +
> +Finally, modifying the contents of the PTE requires special treatment, a=
s the
> +PTE page table lock must be acquired whenever we want stable and exclusi=
ve
> +access to entries contained within a PTE, especially when we wish to mod=
ify
> +them.
> +
> +This is performed via :c:func:`!pte_offset_map_lock` which carefully che=
cks to
> +ensure that the PTE hasn't changed from under us, ultimately invoking
> +:c:func:`!pte_lockptr` to obtain a spin lock at PTE granularity containe=
d within
> +the :c:struct:`!struct ptdesc` associated with the physical PTE page. Th=
e lock
> +must be released via :c:func:`!pte_unmap_unlock`.
> +
> +.. note:: There are some variants on this, such as
> +   :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stab=
le but
> +   for brevity we do not explore this.  See the comment for
> +   :c:func:`!__pte_offset_map_lock` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher =
page
> +tables as necessary, using these locks to avoid races or overwriting any=
thing,
> +and set/clear data at the PTE level as required (for instance when page =
faulting
> +or zapping).
> +
> +A typical pattern taken when traversing page table entries to install a =
new
> +mapping is to optimistically determine whether the page table entry in t=
he table
> +above is empty, if so, only then acquiring the page table lock and check=
ing
> +again to see if it was allocated underneath is.
> +
> +This allows for a traversal with page table locks only being taken when
> +required. An example of this is :c:func:`!__pud_alloc`.
> +
> +At the leaf page table, that is the PTE, we can't entirely rely on this =
pattern
> +as we have separate PMD and PTE locks and a THP collapse for instance mi=
ght have
> +eliminated the PMD entry as well as the PTE from under us.
> +
> +This is why :c:func:`!__pte_offset_map_lock` locklessly retrieves the PM=
D entry
> +for the PTE, carefully checking it is as expected, before acquiring the
> +PTE-specific lock, and then *again* checking that the PMD lock is as exp=
ected.
> +
> +If a THP collapse (or similar) were to occur then the lock on both pages=
 would
> +be acquired, so we can ensure this is prevented while the PTE lock is he=
ld.
> +
> +Installing entries this way ensures mutual exclusion on write.
> +

I stopped here, but missed the v1 comment time so I'm sending this now.
...

