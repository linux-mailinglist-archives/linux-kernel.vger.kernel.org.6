Return-Path: <linux-kernel+bounces-428179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831E9E0B14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C40281D34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5A1DDC39;
	Mon,  2 Dec 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjYywQkH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8270805;
	Mon,  2 Dec 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164438; cv=fail; b=tb0BoJMgXEzDC7RH9lkJF/T745J6+tR8TM5jjCWjKgoaTerLYHt8JcZz+WfY7VqaPDkGsqrgKrR8uWUluv7+MxcBfjb7mkZzeE1mDf6LZ38yk+ih9UKX/qzQSu4MYRhoLpnRcxSm+KG8pDJ74MdMixSiv6Uf+nbsYFpQeXLnO0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164438; c=relaxed/simple;
	bh=CkWvINzFukI5yI5KYY5VMOMpYT9XbRJiOjtsMyzxTrQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adPAB1ZNmO0JiEOf74NSqBQ3kboD/tDy5QmA5iN0gv1M4b1eiQXb/PikPIcGZZ6EPXKKxPvU/CknOwNhoDFvXIZhtqzDpJ+t0KaXM7Bh0WOzJEa6KfVnnAjAu2wNap5hnX9DKTAv+kUcTDZAATZm49TcVxmyvZv+79hL6HVn5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjYywQkH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733164436; x=1764700436;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CkWvINzFukI5yI5KYY5VMOMpYT9XbRJiOjtsMyzxTrQ=;
  b=AjYywQkH9QQLsfldytWdR6SR5U8DqnPIFQJduwxpPVr87eie4UUkfnHS
   iGqKPMAeaXNDxTMVwDDjTvYf33/oAB6OzBHP65OlmovU0Rc2fcVW2tHhV
   BVR7uqx6eOUyjDOydH8p8Pfmt76MuevvKpg44iUhrBKz1Lx5BXkwOqAZc
   QnYer3iOXOIIn7m3p3RwdDw5fby7E9MOqHPpfpMjLmjq3kBBI3tcOC0gw
   7+LdLjq3yu1jOIPouKpOlYi2V8Oo+E/2kSDnMeTS2EgxV4vOn8PhOTu8/
   cGyLn0q/+v5LDgDX28LeuNAvQ6Me30nD3tzvEQ9i5CWB5BM3IsrL406Hs
   w==;
X-CSE-ConnectionGUID: LDzwnfA1QDGFkIQuihPGOA==
X-CSE-MsgGUID: cqi0l++xQ6amHklxaz3HXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20939365"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="20939365"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:33:55 -0800
X-CSE-ConnectionGUID: OmqnK/X+RZupteI1UFnXMw==
X-CSE-MsgGUID: vwtqQlnzTRuWvGlg5Hm6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93657629"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:33:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:33:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:33:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:33:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S91RInim+r6RzxmILZeMnkzbbBQgguOdBNQse9cgnX5unjx/4I7jh3WtenghTCAxoZcj+eHNu2AW63hhbbIPT3e/EqpLqhV1p44HWka3yUrxo0PfoSUiLaBQtKzuZ2aMSfs4HvXEsDz8xmvWt3G1IKmfOk4nkojAOXO7w/T2PoOot/tbVp+Uw0elA87JlD9xmxVIUZj0ZG7MB/BthwuBZqHlTyya5LUhJ8zuKfid6IaF3J7hTSEFq/wTpAurT/LKtDX5fkZf7slxc4VGcngfTwXLkFGxfq8IY5gVTHY1ke3v+SEldajG0/O40UBKKLdtOIdPqX9VJtW/MmXorQkmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F91rLrgAaIPM6f7/xKwX+fSe56YK68BkArWhGVDjWw=;
 b=Fha/ZE+ZwgsyQ+BV2tbN04KHiSewTN039jnYXEmSO+SH81FgDkAZYOat0t+CCDSzk8E5il2UW54ECC4+uvP4FfhY/j/ZbQ9A4SEJ871DaZc8JBGNRlMrLXqIMufOxW52Ggo9gops/Ji2ZmLRpOfTp00q/thcqlcQce45eWUHIjhlI15grJmKUkkws1kGNf9KY8IsRoGQHvKst1Fbf6edai8FB3j6dPjrtVAdv46PWze1P6WYnPrK1/3gPCjbghaerFPGc9DN13l58RhvOJHIBAbfOQphDQBKgzXhq3YeNPLLylRIA1tG4RxMikN6cNrHwvTLZXolFR27kCRPQsroag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:33:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:33:50 +0000
Message-ID: <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
Date: Mon, 2 Dec 2024 10:33:47 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>, <paulmck@kernel.org>,
	<rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
Content-Language: en-US
In-Reply-To: <18adb251-b340-4820-a808-e1583b44480a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bed6c3-e82a-4fed-1235-08dd12ffddc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0t2M21WK3VRdVIzazFJZzdGOGFvcHdKcG9XSkR0ai9VUW1SbHVITDFqbkQ0?=
 =?utf-8?B?SVB0ZjNmM0FFUldOTVZ2VG1YNDVWRFovUnZmNDdhMWk0NzdmNDk2TTlTT0J1?=
 =?utf-8?B?eGN3SC9VQWI1aThwbkZEcDRrdmJOUGZRZGU3Uk90a0UyeXVxdysvSGtzL0lC?=
 =?utf-8?B?R3U2cVp0NTU0SXFkSlNuTkM4K2RtNnRYYXRzSlovNE5iVzh1aDFFblF2dkIz?=
 =?utf-8?B?TjFzK2R1V1FFN2FzQkFlN0JhZGh0NW9YOEhLSDNOSkxzT3JyczRTRjZ2NnBK?=
 =?utf-8?B?UHRpdjFpc09tVExBeHpwRGgzbWt6L1ZHbXAyUUJDS1pUbHlDOUM4a0gzeEtL?=
 =?utf-8?B?cEJtb0NkUTNKOGtkQTNzR21TcTZmUllWVEFkVVJXejdHd0xud09TOVM4TEt3?=
 =?utf-8?B?a3RYK0ZlVkgva3BoNGhtT0VIak5KWUl1MVJBZGVLWXBGaXJXY1RGMkxBcDJm?=
 =?utf-8?B?T2hNM1BaZklSY2NJdHliRGdwcU1DdEE3TGFjVDNTSkRGTjBNOVg3TUI5ZW5u?=
 =?utf-8?B?bFMrdngvZDNubElSb0Z0Zkp5dGMvdHVMZ29mZyt6RG83cWRnYmZ4bWs3VTE4?=
 =?utf-8?B?MG9XTmVQdk9yandtcnp6SkFqQUJHL0VIbEJDRG91aE9sMEZ4T2diQkV4ZnM3?=
 =?utf-8?B?Y0M0V29hVjZkWnl4YjJrK2dQOG1sS3c3WDQ1cFhQYUY5R1pSMGZrakFWVlRw?=
 =?utf-8?B?SExoT2IvOUpUSzZsaHlISDM4Mjc4alVFM0NJWkh5UURuYUdFN29CSVp5dnQr?=
 =?utf-8?B?VC8yU3Q5NGdYRm9nT3NNKzlhOXNmMTlKQkczaFpxbUZOTVJQS2tuUkdsby9j?=
 =?utf-8?B?WVpEVW5PR1JWUlhJbHZwVVlKR3U5WHllZXlJT1N4T0F3bTYxWjdZdEhHOFJG?=
 =?utf-8?B?dWpaRUQzdUlzTmJGQ1NCREZkdkl0THNiUDNaVUkyZjlsMFYwTHZUNndoaTlP?=
 =?utf-8?B?VUY3K1hId0ZCZGhLQm5xd29tbEN1VGQyblFwUElyRXo2MlRLWUtOOEdKRTBR?=
 =?utf-8?B?elM0cE1kRTZlVW9ERnJOaU9OUTgwRnJXYkZucTBMWSszcGhHR2pZYTc1ME0w?=
 =?utf-8?B?YVFncHFXcE41ZWE5WGhSU3B1N1ZQUEpoYkoyRWJrd3owV0laOEM5dWozYUFi?=
 =?utf-8?B?ZTdVM25aeWMzdkhNRC9qVnlEY3E4VlpOMm9PeXFwZjNaNXhYTS9ORW1VNFlR?=
 =?utf-8?B?S1duR2hPcC9LTThWV0JVS01tNkRrTmZhUTcwY3hSSFV2RnZ4cEJhRlg3UVp5?=
 =?utf-8?B?UjlZbTVud3hzOG9TdjgvVWRXaVJGdmowbmxEUTVuMXA2eVQ4OCtCNnU3VEF5?=
 =?utf-8?B?dWdBNVgya2R2c204RDdJSkxxRnJNb2xhT2pBRUNMR0RVNjkyZ1Vmdi8xbUpT?=
 =?utf-8?B?bExKbmIrMUlQMVZBZjAySThUcmNJS0lZVkx2SG5OWXNQNE93ZldwMEJPeXhT?=
 =?utf-8?B?TDlFZHlSRXBhbUMvb3A0clcvLzFHUS9UbzVzK1FXMzZGcFhGajVwOGVwcDBY?=
 =?utf-8?B?aXA2MEhOZnNQcHhCSkx0ZFVwdld4V1ZVVGk4YmExM091RjJOSEhPVUNpQ0hK?=
 =?utf-8?B?RU1wMDB2V0RoK0pwSEt3bUJnUGN1bEp6MW1kaXdrMFQ3VFcvcExlUndTVXpv?=
 =?utf-8?B?YVo4TTF0c3JxeHJkVUFpdGVaZ3NYeDliSFFIc1NIZEh0cncyS0l1NS9EeTRU?=
 =?utf-8?B?OWowb1B0OGVmcldxdWRMNWtTQ01RWjNYeVhsYlhUekdXcE9pSklwNXJVbWxD?=
 =?utf-8?B?SURYMzlCT2hOUGoyT2ZaNlp1M24zeVM3UUxPc2VkOTg5TUNhM2FFUUFPRmw1?=
 =?utf-8?B?QmNIajRBbmo2MktVK3JQdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGE5WnZpcGNOV1dPTkluNVpHQlBLS1NSOTdPdEZ0TkhtSyt4MFUvdDNUaDFa?=
 =?utf-8?B?RHA5K2lZdlBGYnNZelJVeTdBSzU4OEdFTk9CMDJRQ0U0S1hzZFpXWEE2bmhz?=
 =?utf-8?B?RHB0bUVTOXhNalp4cTd0Nlk4MTJDMDJuMVEzTjRRL3Z6M2EzdURVUlNuWmpC?=
 =?utf-8?B?TGg3K0NxN3ZCM2szRzgwalA4WVI4Rlo1VGxLWUVqVnFSaFI1VzB0ZVBZRW9V?=
 =?utf-8?B?RDh3Nm5TVkphT2dnUFMrdHRVREMwd3hjeDk4bGR5OERiSWRwMVZWakVWbjJI?=
 =?utf-8?B?R2FrcDZweTVkVm42WVFEM0hQa1JxZ0N3aUdHWVlKZ2RNNjVmR1ZoWDRjMHpJ?=
 =?utf-8?B?bHFBZ1VNa2RaS05KNS9ZOVlpeE9VdEhTWXBXdFpORkVrV21sdmNuZkpBZUpK?=
 =?utf-8?B?SWFKUElXQitEdkYvSkEwUkpEU3E3eUg5bGhJMVY0UEd0bXd6bnVHNWtPZTUv?=
 =?utf-8?B?TVQ3OGxBVnJzVUozWGNvaUY4bFFCdXBha2IrYjhFdThXV3JabGpLMnFZZGx4?=
 =?utf-8?B?UWFPaWVmWHhMSW1qcHhLWTFHK3poYUpqRDEyUlo1OGtkOTJYeVkzN045b21K?=
 =?utf-8?B?MVBhWlN2MTE4ZVBFanBlZmVpUU0wdXB4Q1N2aUErbzBaQ1dKNkVUcUJENXIy?=
 =?utf-8?B?VnFTVCtRbnZ4TWg2VXVGV3kwTHJWVllNd2xLdzZqS1hjZVZ5QktWWTI3b3A3?=
 =?utf-8?B?Nm5kNnJJMEw2NU9BM040NXNwWFpGZkJZbzMyR0tIQlJhTkRWdTVwQmlBRGpI?=
 =?utf-8?B?U2lNbUh6YThaaW52WDlKbHBzYURvZC9iVXp6aExodXhMOHp1OTNXTWprb0RZ?=
 =?utf-8?B?UnA4eEpsT2RwclM4aU1TRGRpc2RoY0RWOGxJTmRCaVVLTy8wdnRTeFh5VmJR?=
 =?utf-8?B?aytMVG1lRG5KS0xxeHBkbTVDN09CNDF4QWpkRVFqTEtJVm53MVdZMW9aZjU0?=
 =?utf-8?B?N1d2ZmZ3bExUUG5USlFrenZtci8ySnRsNUp0aU1CTTBoMlZFcHRqNXRvTXlG?=
 =?utf-8?B?cVdwVlVnSXM1YnpGTFk4bTdPbDRQMTRWbnI2c24wQ3hlV05iUGJGSk5saHRl?=
 =?utf-8?B?bTVtZ09UV1AzUW5ZSjA5a3g2QngyV2N3aUdtSG1rMC9oMGI4ZlBLU3pXalpy?=
 =?utf-8?B?K0xEOU5BWTk3d2dZRHE2OFp4L3loQVpkM3FBTktKNjd2RWlJbjJ1bWFVb29R?=
 =?utf-8?B?QTJmdGVBK1lJd0NhM2IzUGMySm5LOVRWUnJkL3N6dUF5S3k4dW9IakdsbTM3?=
 =?utf-8?B?ZlhZUExPb0EzV0lvMzBBejFSUUhWRjlOc1FIbUdaRTZKakRSdlA2anVhZkZv?=
 =?utf-8?B?cUdZYXhGeFBIdFpSOEUycUl4RE5XTXR2MnJoMFJjblEyb0hEWUVBUU1qNUZP?=
 =?utf-8?B?Y29oaGRRcE80QzRHb01xeU13OGxuT3lSTnJLMFZMSmRhSlpIYU9HclRIc01K?=
 =?utf-8?B?RmZmWUVvaGJ6WnB1Y3NjY0pSbUhYU2pDUDZRdnI3eVZCTWROdW10RWFUUGo0?=
 =?utf-8?B?S3NYVE12ZTkyRFBEbW9pS0xPN2ZsMFlTOWNzM3Y2RXEzRGFFbitLR002ZkVW?=
 =?utf-8?B?OEx4L3BiSGs0NjdLL2thckRHVEpNdEdxLzVENFJTWkdSNnF6ZWNDUjNZYVZ6?=
 =?utf-8?B?UEhpTzBxOUFwUTIwaTJxeGZERC8wSi9GT3JqckZMclJ5YXhFdHZWc01laGFX?=
 =?utf-8?B?c0IzSE1Ma3EwNi9DbllMNSt1c0h4N0hGeHd1ZmxEa1dMSThzbmVmWVZtNjRU?=
 =?utf-8?B?NmRDYnIwa2N6dzg4NUlVS0dSb2N1VGViZDlxNHMyRHhxZ0NFVUF5NlZKbmNU?=
 =?utf-8?B?T0pab0lBd2Y0WE1wTTZSQUt4RjdpbGNBZ3c2YU9kQVZwLzZwMjdOdjl0b0Rh?=
 =?utf-8?B?aEhES2VhRW1ybTBOVm1vSkU0VGEwMzBmQys2ZnBlbWl3THJPbmc1YUtUeXl6?=
 =?utf-8?B?WHpTbzRsSjMvQ3J1MlRZMGU1QkFRa1IzUjBhNHFaSHYzV2VmdlpyZTUrZjdt?=
 =?utf-8?B?ZWEzVVYvUHgvUGx1RWtlZjREK3Z5b2xQQUtPTzBVekhUQmxBek9Oc0xCVjl2?=
 =?utf-8?B?WFk5N3d4eUVydlpGVkNEakVtQUNYd1pBWUxiNjRGK1kyejBrWGJoUEIzYUIw?=
 =?utf-8?B?K1N1bVd1TW5QdWNNTmM2bjlwN3hJSmp2UDVSNUJrOGpRUWhJTnVpbFRCVlQ3?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bed6c3-e82a-4fed-1235-08dd12ffddc9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:33:50.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bDOFvRcFrbhSeCuYIlc4qEeGjFkA74HHStKFu6+XGGdO2bzMpEfdpz+5CAefPdd17roXRpoGtAZS7vI24uogRjQrNMjXX9XY2y2CTJYgow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com

Hi Babu and Peter,

On 11/29/24 9:06 AM, Moger, Babu wrote:
> Hi Peter, Reinette,
> 
> On 11/29/2024 3:59 AM, Peter Newman wrote:
>> Hi Babu,
>>
>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>> Hi Babu, Reinette,
>>>>
>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
>>>>>
>>>>> Hi Babu,
>>>>>
>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>
>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>      For example:
>>>>>>      Resctrl group mon1
>>>>>>       Total event
>>>>>>       dom 0 cntr_id 1,
>>>>>>       dom 1 cntr_id 10
>>>>>>       dom 2 cntr_id 11
>>>>>>
>>>>>>      Local event
>>>>>>       dom 0 cntr_id 2,
>>>>>>       dom 1 cntr_id 15
>>>>>>       dom 2 cntr_id 10
>>>>>
>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>> group:
>>>>>           struct cntr_id {
>>>>>                   u32     mbm_total;
>>>>>                   u32     mbm_local;
>>>>>           }
>>>>>
>>>>>
>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>> current implementation deals with domains that come and go. I do not think
>>>>> this is currently handled. For example, if a new domain comes online and
>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>> not configured to the newly online domain.
>>>
>>> I am trying to understand the details of your approach here.
>>>>
>>>> In my prototype, I allocated a counter id-indexed array to each
>>>> monitoring domain structure for tracking the counter allocations,
>>>> because the hardware counters are all domain-scoped. That way the
>>>> tracking data goes away when the hardware does.
>>>>
>>>> I was focused on allowing all pending counter updates to a domain
>>>> resulting from a single mbm_assign_control write to be batched and
>>>> processed in a single IPI, so I structured the counter tracker
>>>> something like this:
>>>
>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>
>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>
>>> This is still a single write. Two IPIs are sent separately, one for each
>>> domain.
>>>
>>> Are you doing something different?
>>
>> I said "all pending counter updates to a domain", whereby I meant
>> targeting a single domain.
>>
>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>
>> What is important is that the following write also requires 1 or 2 IPIs:
>>
>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>> for readability)
>>
>> echo $'//0=t;1=t\n
>> /g1/0=t;1=t\n
>> /g2/0=t;1=t\n
>> /g3/0=t;1=t\n
>> /g4/0=t;1=t\n
>> /g5/0=t;1=t\n
>> /g6/0=t;1=t\n
>> /g7/0=t;1=t\n
>> /g8/0=t;1=t\n
>> /g9/0=t;1=t\n
>> /g10/0=t;1=t\n
>> /g11/0=t;1=t\n
>> /g12/0=t;1=t\n
>> /g13/0=t;1=t\n
>> /g14/0=t;1=t\n
>> /g15/0=t;1=t\n
>> /g16/0=t;1=t\n
>> /g17/0=t;1=t\n
>> /g18/0=t;1=t\n
>> /g19/0=t;1=t\n
>> /g20/0=t;1=t\n
>> /g21/0=t;1=t\n
>> /g22/0=t;1=t\n
>> /g23/0=t;1=t\n
>> /g24/0=t;1=t\n
>> /g25/0=t;1=t\n
>> /g26/0=t;1=t\n
>> /g27/0=t;1=t\n
>> /g28/0=t;1=t\n
>> /g29/0=t;1=t\n
>> /g30/0=t;1=t\n
>> /g31/0=t;1=t\n'
>>
>> My ultimate goal is for a thread bound to a particular domain to be
>> able to unassign and reassign the local domain's 32 counters in a
>> single write() with no IPIs at all. And when IPIs are required, then
>> no more than one per domain, regardless of the number of groups
>> updated.
>>
> 
> Yes. I think I got the idea. Thanks.
> 
>>
>>>
>>>>
>>>> struct resctrl_monitor_cfg {
>>>>       int closid;
>>>>       int rmid;
>>>>       int evtid;
>>>>       bool dirty;
>>>> };
>>>>
>>>> This mirrors the info needed in whatever register configures the
>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>> updated.
>>>
>>> This is what my understanding of your implementation.
>>>
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index d94abba1c716..9cebf065cc97 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>           u32                             *mbps_val;
>>>    };
>>>
>>> +struct resctrl_monitor_cfg {
>>> +    int closid;
>>> +    int rmid;
>>> +    int evtid;
>>> +    bool dirty;
>>> +};
>>> +
>>>    /**
>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>> resource
>>>     * @hdr:               common header for different domain types
>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>           struct delayed_work             cqm_limbo;
>>>           int                             mbm_work_cpu;
>>>           int                             cqm_work_cpu;
>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>    };
>>>
>>>
>>> When a user requests an assignment for total event to the default group
>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>> entry.
>>>
>>> If there is an empty entry, then use that entry for assignment and
>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>> information from default group here.
>>>
>>> Does this make sense?
>>
>> Yes, sounds correct.
> 
> I will probably add cntr_id in resctrl_monitor_cfg structure and
> initialize during the allocation. And rename the field 'dirty' to
> 'active'(or something similar) to hold the assign state for that
> entry. That way we have all the information required for assignment
> at one place. We don't need to update the rdtgroup structure.
> 
> Reinette, What do you think about this approach?

I think this approach is in the right direction. Thanks to Peter for
the guidance here.
I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
though, I think the cntr_id would be the index to the array instead?

It may also be worthwhile to consider using a pointer to the resource
group instead of storing closid and rmid directly. If used to indicate
initialization then an initialized pointer is easier to distinguish than
the closid/rmid that may have zero as valid values.

I expect evtid will be enum resctrl_event_id and that raises the question
of whether "0" can indeed be used as an "uninitialized" value since doing
so would change the meaning of the enum. It may indeed keep things
separated by maintaining evtid as an enum resctrl_event_id and note the
initialization differently ... either via a pointer to a resource group
or entirely separately as Babu indicates later.

>>>> For the benefit of displaying mbm_assign_control, I put a pointer back
>>>> to any counter array entry allocated in the mbm_state struct only
>>>> because it's an existing structure that exists for every rmid-domain
>>>> combination.
>>>
>>> Pointer in mbm_state may not be required here.
>>>
>>> We are going to loop over resctrl groups. We can search the
>>> rdt_mon_domain to see if specific closid, rmid, evtid is already
>>> assigned or not in that domain.
>>
>> No, not required I guess. High-performance CPUs can probably search a
>> 32-entry array very quickly.
> 
> Ok.
> 

This is not so clear to me. I am wondering about the scenario when a resource
group is removed and its counters need to be freed. Searching which counters
need to be freed would then require a search of the array within every domain,
of which I understand there can be many? Having a pointer from the mbm_state
may help here.

Reinette


