Return-Path: <linux-kernel+bounces-525351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C134A3EEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D8019C23ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B120102C;
	Fri, 21 Feb 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elCl7wGK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A741FE470;
	Fri, 21 Feb 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127296; cv=fail; b=lthXSo7j9rYv0i30HYUZNPhpTIR8hdtGGk7CFh7YY4ly0955tfzfcM6d3JLVeatWjueki/xkI7UCWKR3aszk7Zeh65JEWcWMJUX/al6bdeOFK4b4MWal2KLst5f4wEt3PLX0VxPZIbJMbVc0cFJgBuxBurXtA6viwmOC6+3IsB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127296; c=relaxed/simple;
	bh=Eg2EmkQwvujiwA/p8sarERw3r1DQ2YVENVDswzGqcLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MeoPyOMosFCb494xJUh4XfOOkrOtI6r6WFOWcLVrQPAMKe0yGFJ7+QVUGyfmSgSjiehVBGJGv5tHuSiHiTAXcHuXVql44rPq6woV8CR2jvOzm3wxqzI52gDfTxMs4ZknSDc5+oOqVGN0JJ4ouVQbf08VeUB9OYqmbd0mSYI7pr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elCl7wGK; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740127292; x=1771663292;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Eg2EmkQwvujiwA/p8sarERw3r1DQ2YVENVDswzGqcLk=;
  b=elCl7wGK+sDinpDdl1jsCExIVwua3xNQZz6KsTiR6wVb5O37IO4IfvyJ
   qV+xNPFwseVjPV/e03n/3rqScD9FP5Ot0nkP/wMLii94MeoChum5mWXpD
   S0hDCvlXvrlo/Pxx1RO6K2YGjlxzdTqpdgIzAjAukf/dbJYO8epIyR4VT
   PsJM+2jD5HMStG0jTeRQJast2H7qdl3L7Usbv7CHRtjZ+iu0nJ0wSnezf
   JRIUxXK+/hEPPNB6h0x1kuKaPlHSV0tIF29NPBZNybkjPtgF9fSGDDk0a
   TLTDHmqYR/ywek7WRVVyf7Z8a64tf0NaGprr+jpfSyVXPoxs5sfH1FVsv
   A==;
X-CSE-ConnectionGUID: YtzSklxWRMu3vCf4jxlfAQ==
X-CSE-MsgGUID: mXgJ5SW3SxSspyExB/5woQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41058694"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="41058694"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:41:31 -0800
X-CSE-ConnectionGUID: CrZVuj1aTmy08bISIerFXw==
X-CSE-MsgGUID: Ez9kEhu3S1W0Xnu41sldwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115256207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:41:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 00:41:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 00:41:30 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 00:41:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7JdgfnpTM1Ia/8pdRGEZoPEUx+wM1CQor4ZIAK6IVK2c7m1XncoPEAVofNrbtiDpVg1g2w4e543CX+hom8qL8/cl+psKp4U/LZbwFNoI+31n2tLmCx52fLbmky14WO5U6GZWX3L0m6mpDSCONpNiTEkTPH7olL8Qp+YLDo4kSSsnCbWs04/gURv8p3+HwY7tBEuPqQXitPEnvTiPpyxyv79J+FEKskhC8phDq4wFfCpd9XcdW1THtFTTtSx6vd2F4XQ28LFUH0y8hWfKGwsK24V40QQV5BHtGCwEGeusudrWj34rqKntFxdkrYT80vIwRz7JtVrRGeO3BlhKrSdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaf+z8I34+Y6qw2DXHwH1sM42kZW3BJhFLZH4h31hMA=;
 b=Y6BqIz4S4rDXymlD4R57kdINeiyTsePxxKMeq6Pxeru3wf8pCZGVrGpXpq+S6KfA5LJc7yQj2gmaFELbF9NDuPMmjET3moE7v8cb/wi+oiK9Q09s74mLCP23D/NcbVKWTGo+PyeLWnuXhjAAgsTbTKvmJB2vZx6H0RBK1iLwCijt8ijsCEgiQ88e17aQQ2BpuP/PUXSkyq++w8eJq8S0VquipTjE2/EgHYwFj0n9prJ6krYY3QQOSfT7dAP5j9WQcfST3riEwYKsaUDaZFFiPCYVrqbYw5GTlM2nwxT3LjLfzCTqhgbVHusZQYXTad33iRBZcnC/S7qxo8p5DcAMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 08:40:53 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 08:40:53 +0000
Date: Fri, 21 Feb 2025 09:40:18 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <guoweikang.kernel@gmail.com>,
	<dwmw@amazon.co.uk>, <mark.rutland@arm.com>, <broonie@kernel.org>,
	<apopple@nvidia.com>, <bp@alien8.de>, <rppt@kernel.org>,
	<kaleshsingh@google.com>, <richard.weiyang@gmail.com>, <luto@kernel.org>,
	<glider@google.com>, <pankaj.gupta@amd.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<ziy@nvidia.com>, <xin@zytor.com>, <rafael.j.wysocki@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <cl@linux.com>, <jhubbard@nvidia.com>,
	<hpa@zytor.com>, <scott@os.amperecomputing.com>, <david@redhat.com>,
	<jan.kiszka@siemens.com>, <vincenzo.frascino@arm.com>, <corbet@lwn.net>,
	<maz@kernel.org>, <mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>,
	<xur@google.com>, <morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 06/14] x86: Add arch specific kasan functions
Message-ID: <3z7vokly7x3rhpbd44dhe4tkcv5bc3lnimthgrfjon6exp2udi@wuyryzq4j26l>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <7099fb189737db12ab5ace5794080458d7a14638.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZf16dzSjOLSeWXMaJLUR-b9x9_CY0JunaRaet_O_XNcsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZf16dzSjOLSeWXMaJLUR-b9x9_CY0JunaRaet_O_XNcsQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 92429e9c-5b6c-40c3-066e-08dd5253737f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlZneDcvalg2VEE3elZJbEtTSTN4NVBkQll2V2pEelhxVXVBaUNxMGtyMlFS?=
 =?utf-8?B?YnBIWFlRL2I3bEhEYTFSRTBhVE5UUG03VEJiRDdNVnVkTjFoVkxiL3dUR1kx?=
 =?utf-8?B?NlNjYUJWSXhQN1NMV0VFOXVOVXJ0c2NqV1AvS1oyWFNKajh5WUFBQ0VMMWY1?=
 =?utf-8?B?NzF3ZERxSFU3UEVCSXFieGlrMU1Jbzc4RUNBNWdNSjQvSTZIdHU4dlU2ckZl?=
 =?utf-8?B?Y3BMQURTY1R3am9VcVY2RHFDWnpzbk1mMTdEdWw3VjBOb3RoSWc2TUtOU3BG?=
 =?utf-8?B?d1hKelFFdGFtanVXMU83WEJhTHhpUThRb0lpN1l5Z0grOWlIVE5zTFZBSGVB?=
 =?utf-8?B?VUlZdkMycmNGOUZuZ1BJcGxuVEdId3pldDZpUlk2cXpxWTUzcUtEQTI2bVJu?=
 =?utf-8?B?K3Z1NnJaSTB3Q1A3OGE2MktLaWVaV2FpazlmcVR6VG40aEdFRStLODRGZXk1?=
 =?utf-8?B?bHAvTWVacnhMQllBY0lKeGROQW5yVEd5M0hvUmcyZ1JRNlQxVmNGclNlbDlI?=
 =?utf-8?B?OTFVVjZqNGd2L3JQMnJ5Sjk3VnVCZWZXQ3hCaDJlblFwbE5YdDI1QVdML0RG?=
 =?utf-8?B?aWROZFJ6eUEzOTRSZkxMMnlwNXU1TThnbEE5cVM3ZVlTZGE0cWFYT2cybzBI?=
 =?utf-8?B?dmswelo1em9GQ2FsMnpJSGRFd01WUThHcVlsV1FZOGJjcm1BNklrRVZhcldD?=
 =?utf-8?B?VGFTc1dldTNHeUdMVXJmVTBCcXBJMzMxSDl6WS83SzNhN0VacW9wK2RQZXRK?=
 =?utf-8?B?MTJydEZJc0pRZXJpU0pQTFNZa2RkenQwMmJYeFRkL1I4eng4dTR1RjdpT1pw?=
 =?utf-8?B?OUVOQnlKRnhwQW8ySGNsQjJ2SkhITXpESVJvbWIzSEJKU29CN05BWE9mRU1Z?=
 =?utf-8?B?RzkreDZoMzdJNTVydTlGTzU1cHFBNlhIU3JWYjFYaStkQURoRDJUdFROMTdD?=
 =?utf-8?B?aCtXU2RpQlNORmI0ek1QclZhY2RycWJMOUwzVUhjUmhYSjRyNFpkZjdLbzFy?=
 =?utf-8?B?cU1lQTloNU5DamViMnZWVmIxVUhnYk1LTnRrNVRGbDd5NjlIdkVZZ2kvMnVn?=
 =?utf-8?B?R3ZXRmRLSFNEaS9MaEk4ekZEM3RMZDFhOGVMbjg3Zmxzb0N2Rk5Qb1A2ZjZi?=
 =?utf-8?B?WStXQU1FSUY1VjcvTnhiVjE0Vi9meEdkbDRsT1NNejFTSXF3WXhwYWJFV0p4?=
 =?utf-8?B?U2dEQUU3czA3Ump4UFZydE8rMzJDMXU3cnFzWFgxbWt2dDBGbWdoY3MxME4v?=
 =?utf-8?B?cFFPUHI4UEQrRnZXZi9xYVpIM2F0Y3Y3K3FrQjBGMTlWQ2svT1JuYklMeldZ?=
 =?utf-8?B?cDhNYnB6ZHFLREJuR0QzUW1IWWxJcHlnRDVpOXZvd2dqaC9OZ0dnVVRjUlJC?=
 =?utf-8?B?dFJseEs5d0tNYzl0WlFINVlQRUJjMkFWUTVUT05ORzh3LzZJOE5hMzlYVTFz?=
 =?utf-8?B?d3gvR0JaUXpxbHNvRmwrTTBVZnF5Mkl4OTYzNFhZQUM5akY4NE9nN2hmNEMr?=
 =?utf-8?B?NjRJNC9HNEpZaHNzU3ZDMVRJWDErN3hQZi9ybmlsSHFJdmQ1akdtZmhMR3B6?=
 =?utf-8?B?Y29kNDZ1eXBiazl2T1V6VHVyVW15MTl2NVpsVklXZVM5KzVVbS9ZYjlEdUZ6?=
 =?utf-8?B?ZEZvZEhDMjdRVEE5QWExZ1NUTlczM0xraUNxUmE1UDd3bzFsdERwUlBCRnFP?=
 =?utf-8?B?Vlp3R1dybHNZTWoxY0VXeHZkcnZDR0ZOMXNCU2dveXNqQXpucGRCaGNXeElT?=
 =?utf-8?B?Q0ZPdkJqaDdIU3BzQ2hIbEszSm96elZqMkcrdFNKYWdScTg3amt6aW9hdGZr?=
 =?utf-8?B?TGxnZ3NJWlk2ckZCazFJK2k0Tmo0eDJXcU1JeUhsTUpyMWx5NG1ndFBuZE10?=
 =?utf-8?Q?G1WsKk7xi6IxG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFwVGRlRCsya2ROdDlaMXNLQnR1MUUza3U5OTBYOVM2cS9wSERwdTc2OWcw?=
 =?utf-8?B?Ykg2aFFqMmFyR1JjMXIrWThza2w3aEsrMjlpd3NGVko2bUprRTNLdzMzbURW?=
 =?utf-8?B?a1BVMVhiaWlsWkd5NG5wWEFqU3hnRjQxUU1KZGQ3ejJKbDVOSWJlc1d0MkVi?=
 =?utf-8?B?djZkOFpObFJEb0FweWRTT3dUVzFPRVJCT3VEdGVYUllUcmFRQjcyWXhuZnNM?=
 =?utf-8?B?S2NKbml1Y001bmFJRiszYjVjZWZQeWFQKzRSVWY4YzdQZzR4cS9UVnhWMDQy?=
 =?utf-8?B?QWlLbGEzWnpadW8xajhja0FaRnRhRDJMZ0FNQ0w2QW5veGxCNm5pb240czR1?=
 =?utf-8?B?WEtjRjVvbzR5VUtaaWVqblFwK2NBTGN1d2x0UWkrbzhHVTl2TXRQQUI4aTNh?=
 =?utf-8?B?em4xeHhRKy9qdWxTamxXYldBNGFtcFY1REU2SkdVVGdxdSt3bml0QkRvQTdj?=
 =?utf-8?B?M29TRXJ2U3hvYUhyL1p6UE1DTmFJNFNPdlF0L3duQnhZV25zWWtMTHNLSTdi?=
 =?utf-8?B?T21aUEszRmVySE55UkxsTE45UzlHMlRmbnpmY3FTU2pqWFIzSXJ5enNhMUFB?=
 =?utf-8?B?VFlod2RNQVorRzNHY3p1WVZ1RGxxZHNUbFZNUnhacjJuU2IvSEhCNGd4aEFj?=
 =?utf-8?B?aGsrTk1Mc296WENUVmRaL0lzZllNdDFnc1Z1WExKcTJTUVhWUFdGaEpYRXI0?=
 =?utf-8?B?UXFzZWtnYkxSZzd0dkpGK0RHM1VDVTQ2UmJEZ0VrM05mU1VhZnM4MUxUVG1s?=
 =?utf-8?B?QUVEcm00bWpMaE5qdW9jNEI2TWlxN3J2VE5nL1VDQXZMMWtHaUhEZjQ2NGpH?=
 =?utf-8?B?NjFDNVNseDBsK1VMcWV4Vk5QS0xscG9IbXdzNVJGNGtSVUJnWDZFeWhjRkJu?=
 =?utf-8?B?aEVWOFBXUmZSdXhzNjF3VkR6RmJwR2thUzhUc2wyemVsZnkwRkwwL1lqSHhT?=
 =?utf-8?B?eU5RYlhoTVpzOGZ0SnJ3VUxIV2dtT2Zpa3lURFVyZWtHc2JQMFhOTkI5R1g4?=
 =?utf-8?B?VnoxZ09BUUhMbzlWTkpLb2VOSHhKL08ycjNicUpvWVI1c2dmQ3VrYVo0c0Ur?=
 =?utf-8?B?Z3RsM2dWYjZFeWUyVjJOcm8rUmg4TkFySnhDb3NzZmx3Vks5TFVMdnJ0Szh2?=
 =?utf-8?B?YUI2OGljbkttdVp6Z3YrRURYdmJBUUZ2dFlkbnlmS2FiNGZnVVBuWHNTa0xw?=
 =?utf-8?B?U1hzY01pRFl4eGFUMDBZT0FWWE9IYWt2enlLMSsyalVXcnRJSUd5NzgvRWRK?=
 =?utf-8?B?TFM3aUNIWXU0aVA3Mi92MTdTODdraWtLZzZsWk1KUmhJVXZFNVhaSDNydVRk?=
 =?utf-8?B?bDF4SzRuTFRjaGxDWWF0dlBnUitzMGhSSEZGWUVHdmR5bHF2dTdVb3daVHd5?=
 =?utf-8?B?SGRJNklWcHBZM2JOVWhseENkYUtWcFRrVWF1cmM0TVk3WGVCN29vM2Y1V3di?=
 =?utf-8?B?RmZPc2V0M2dGNTNmai9qZVpFUDdPaWNQb1NtTEc4cVRUNkFIS1B3RWM1cExj?=
 =?utf-8?B?Mnl1TFBzT3ZCK1ZyTUFXWVZrQ2g5UXhzc0dJditRdVNpRlJSQys3ZVVNT2hV?=
 =?utf-8?B?TWdYMXo4QWMxSkU1R1d3NzFUTTA1aTRVTHpEQmovTmR2VFovZkpmN1ovakt3?=
 =?utf-8?B?Z1oyTlhwRlpoeno5WVhQYzdDT1ZwQkFkVms0am1lbWlpU1VBMVhWR1N1YVdx?=
 =?utf-8?B?WXdwbVZzckRVRENWTnVNMTk4b0M2ZkR4cGRyWTJSYlA3dTU0ZFRxTmxYWTJY?=
 =?utf-8?B?QVNaK0FpdjJSbzBOQjBsRmVoYlp5STk0WWU5Uk91bWhYWUl2ZXZTc1Rnb1FV?=
 =?utf-8?B?QkFFalVCdlZqSEJTT3Vqa05nZFZ4M1F5bDVNdUhZaXZYYWJjQWs1U1NiNGk4?=
 =?utf-8?B?NktXeEk3aDMxTS9QS05yTFliYXBsb25uWXhxSDdHYzdLaW9iQ2dMSWViOGZG?=
 =?utf-8?B?cExFTkVWd29wdHE2WnhYUFNiendISDZjRWhWTnBZQkpTRllBVFExK1VPRFp5?=
 =?utf-8?B?aFVjQzhsdldNRnlPendPZ0FXL3lBVjNmazZMTE9nYnkzR1hxMTVHdnlFOTRp?=
 =?utf-8?B?SjZ6VXZDRjQ3RDIxbWVhL1A0cWZIZDRIRUhYR0dISkp1UlNNQnNwaWZpU3Zm?=
 =?utf-8?B?THlyZWg2U1JVUHUydlVIN0ZyNWJrMHhLQVRqbTZlQStIbExVdGpNSWF5TDMw?=
 =?utf-8?Q?O8DshT4JO/U5ScWsI5Zl7Vc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92429e9c-5b6c-40c3-066e-08dd5253737f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 08:40:53.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkwiG0Qv+gIXZW/A7GM8vhL6qN20v/2FnRFWqsQMFF3VeLJejcY6nT/P0F3ZxUSzLpR/AtDIyKVhDPjIoi9Flmkij0TWX0750mtNVRUwVlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com

On 2025-02-20 at 00:30:34 +0100, Andrey Konovalov wrote:
>On Tue, Feb 18, 2025 at 9:18 AM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> KASAN's software tag-based mode needs multiple macros/functions to
>> handle tag and pointer interactions - mainly to set and retrieve tags
>> from the top bits of a pointer.
>>
>> Mimic functions currently used by arm64 but change the tag's position to
>> bits [60:57] in the pointer.
>>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>>  arch/x86/include/asm/kasan.h | 32 ++++++++++++++++++++++++++++++--
>>  1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
>> index de75306b932e..8829337a75fa 100644
>> --- a/arch/x86/include/asm/kasan.h
>> +++ b/arch/x86/include/asm/kasan.h
>> @@ -3,6 +3,8 @@
>>  #define _ASM_X86_KASAN_H
>>
>>  #include <linux/const.h>
>> +#include <linux/kasan-tags.h>
>> +#include <linux/types.h>
>>  #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>>  #define KASAN_SHADOW_SCALE_SHIFT 3
>>
>> @@ -24,8 +26,33 @@
>>                                                   KASAN_SHADOW_SCALE_SHIFT)))
>>
>>  #ifndef __ASSEMBLY__
>> +#include <linux/bitops.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +
>> +#define arch_kasan_set_tag(addr, tag)  __tag_set(addr, tag)
>
>But __tag_set is defined below. I think these need to be reordered.

Oh, right. I'll fix it.

>
>> +#define arch_kasan_reset_tag(addr)     __tag_reset(addr)
>> +#define arch_kasan_get_tag(addr)       __tag_get(addr)
>> +
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +
>> +#define __tag_shifted(tag)             FIELD_PREP(GENMASK_ULL(60, 57), tag)
>> +#define __tag_reset(addr)              (sign_extend64((u64)(addr), 56))
>> +#define __tag_get(addr)                        ((u8)FIELD_GET(GENMASK_ULL(60, 57), (u64)addr))
>> +#else
>> +#define __tag_shifted(tag)             0UL
>> +#define __tag_reset(addr)              (addr)
>> +#define __tag_get(addr)                        0
>> +#endif /* CONFIG_KASAN_SW_TAGS */
>>
>>  #ifdef CONFIG_KASAN
>> +
>> +static inline const void *__tag_set(const void *addr, u8 tag)
>
>A bit weird that __tag_set is defined under CONFIG_KASAN:
>CONFIG_KASAN_SW_TAGS (or no condition, like on arm64) would make more
>sense.

Ah sorry, I misread the arm code. I'll try doing a no condition.

>
>> +{
>> +       u64 __addr = (u64)addr & ~__tag_shifted(KASAN_TAG_KERNEL);
>> +       return (const void *)(__addr | __tag_shifted(tag));
>> +}
>> +
>>  void __init kasan_early_init(void);
>>  void __init kasan_init(void);
>>  void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid);
>> @@ -34,8 +61,9 @@ static inline void kasan_early_init(void) { }
>>  static inline void kasan_init(void) { }
>>  static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size,
>>                                                    int nid) { }
>> -#endif
>>
>> -#endif
>> +#endif /* CONFIG_KASAN */
>> +
>> +#endif /* __ASSEMBLY__ */
>>
>>  #endif
>> --
>> 2.47.1
>>

-- 
Kind regards
Maciej Wieczór-Retman

