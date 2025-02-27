Return-Path: <linux-kernel+bounces-536286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D58A47DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971DC16813C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4921B9D2;
	Thu, 27 Feb 2025 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRWANeIG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1014B5AE;
	Thu, 27 Feb 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659300; cv=fail; b=Q3M+SftNMyWyddLoZTYRTJDgX6Sc2UsBT31Iwq2nsthr9VWMKXHO8BhNRf8naiMC4nPL6g7ThBtSF0+3Ps4yXN7uT/xAWn8t53S3X5sPwKOMstGI3jjSW1NrZRo+gY5+OCh0SuAUOyVeVzcmkXFhQUABdkzs6sfhhc1l3QCj+rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659300; c=relaxed/simple;
	bh=X9RYHSMZy1Idz3rf2WgoYR5TZZTodynlM2zEa8T6mOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HpALVGHJwUtvrznUanz+O9haioz40lk5ZRGz5aw5S1gaWF+rqnQM7q+Six/LOt56FlzVb6OiIohI5nEidGxJVCwRLpdnsty+ZiC0RnjtfPguBqgHMqdLcfgeJd3XE4V7kFKU9ukKr8VMU3uEmIYDjwOK+HYHxtiKceNGCRv9wGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRWANeIG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740659298; x=1772195298;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=X9RYHSMZy1Idz3rf2WgoYR5TZZTodynlM2zEa8T6mOk=;
  b=dRWANeIGAUKmhYoO2kozXYLksN+Iz9bKvX5n0ZX8j9mn7TsnPGkuzz6D
   ypEEg/ieUhA0Nif3U5t0Wv3bPfmDDf7GVR1RFn0jCTcTWrwQ4YcgxBsvx
   kgAzzFa961tuE7SbxgE22RdjiZod9JfQxB5WhIzdXKxiWBdn7vub5MzcP
   AEhbix314yHsCI/WhoR+HPPytGSccMn9TV6ZTAkQDqnq6+3JlZG/YFBFk
   rB/j1VoEEZahQQqUgv9NyFAl7SxX9sAEQT+YyXv0usYrGrqcnwJl+HLQO
   TdZMi86V8SCZHrGSEfKJY0mLpXdqonIbH3FUz7p33R4nU0SiW4mxqplO7
   A==;
X-CSE-ConnectionGUID: 4EL3KEQjTS6oXGSKadmp5A==
X-CSE-MsgGUID: fCwY3czCS2+AT9yaTkEArg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41798987"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41798987"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:28:17 -0800
X-CSE-ConnectionGUID: J4x86Q82Tbei4qYeUkn+0g==
X-CSE-MsgGUID: geJEHdd2SFiLr6KApCGudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147930528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 04:28:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 04:28:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 04:28:14 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 04:28:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+lQlF7vizZfhtwbkO9mzB84NRCLhEReryCw/GHRD0GYaFXJxJ92PJgFtUEK9Dk8dfhNWxj2ps0V4iusn4EjpZMON9pn444aiYhDjh9Bchbjw+cmoo+gqXHgy4lRWtmXWP4OWJH2/3IcWRiZShkGMEJaxfF1VtcB1qhRn75iaJY/zLdmp4rg1audBv8VkSo4HEUwO18LNLkyRNdnbxsZOzmvC6GcnmGGUPfZ58ptFyrPWgGt+owZWek8Gio/xFkTkGwRPLSVGf4/42A925Wvp7DW2cEimcQZsSKBgTeD8RWe75yjEOGwqArWEElp4tAhqZKH5g2qiZt7zKFg4+fc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmOtvO92HoSLW9ObHdGLPiMy2VPSNBV0fjGnVVkX6oA=;
 b=yNVNDuUpiXANjpZNRdFFs/CbOOv5Azn49M+xPfq5jSernrruoiQL4/1fSSGoaCwTAfjqjJt9xw6OfnqncyYwO82mt72mg06WfrfCWabiT07oNk9r98mmrf9YuG8LvQPIGZSQJla0QnWqL7xzsy24Y5ikBoZxhekYzyLsMJCCZ/kJWsq1OaTZHv97BtjZuJf60qkgKMlr89JfSo7OZVTXAWj+5p7wAFSCjjuTy1LK/EnPGYtb3ceURIb6yRvdZYCtwV5aiBM6QrKqNqRzHavCnK5C+9RANqNBYlBEuGTCru9WKLZgJi22n8f93cq355+JfbOdiQqOtk2/9mkd2Wj4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 12:28:10 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 12:28:09 +0000
Date: Thu, 27 Feb 2025 13:27:32 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Vitaly Buka <vitalybuka@google.com>, <kees@kernel.org>,
	<julian.stecklina@cyberus-technology.de>, <kevinloughlin@google.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <justinstitt@google.com>,
	<catalin.marinas@arm.com>, <wangkefeng.wang@huawei.com>, <bhe@redhat.com>,
	<ryabinin.a.a@gmail.com>, <kirill.shutemov@linux.intel.com>,
	<will@kernel.org>, <ardb@kernel.org>, <jason.andryuk@amd.com>,
	<dave.hansen@linux.intel.com>, <pasha.tatashin@soleen.com>,
	<guoweikang.kernel@gmail.com>, <dwmw@amazon.co.uk>, <mark.rutland@arm.com>,
	<broonie@kernel.org>, <apopple@nvidia.com>, <bp@alien8.de>,
	<rppt@kernel.org>, <kaleshsingh@google.com>, <richard.weiyang@gmail.com>,
	<luto@kernel.org>, <glider@google.com>, <pankaj.gupta@amd.com>,
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
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow
 computation
Message-ID: <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
References: <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
X-ClientProxiedBy: DBBPR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::28) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW5PR11MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6c6504-721c-457d-8535-08dd572a31be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9EdUFuUHdVcTlvdHh1N3dJU0JxRk9ITTdBYlk3RTF5OFdublo0WmVWM0dm?=
 =?utf-8?B?N05NZU54N1M1aW5sMmZ2bGtSaVloL1o0UEttQTMvN0xtNDZQKzdpc05GM0h2?=
 =?utf-8?B?YjJCcGFzUzBoWlRsRU41YTV0WWovZ3h3eHB2WSs1RFdvRDdWNUZPbnNiL0pK?=
 =?utf-8?B?Sk0yUFlac0xsVDUxeU9TejdseStRMkJ2T2NBb1FDMi91dE1IOGZueEFhUmpI?=
 =?utf-8?B?L2Y2Q2hhVUE5Yi9DUzhWc0xzV0crN3RsOVU4cW9uWkVnd1NPL2VmdXN1dGUv?=
 =?utf-8?B?UmJLRVBsUnZyRngxczR0WWlhaDNoQkdBNHY4Vko3YkdrcjFKU0JNYWFFSjJN?=
 =?utf-8?B?K2wxbWt2bXhCNFVTRC9hZjBCbHdtQ2pVSFc5WTFpcjJwRGwxY0dtNk8xQm5N?=
 =?utf-8?B?dlRhRm41YkpwSDRWV0EwRFBKWWUvRHlYbjZKcG9vU2tyaE5PK1NTdzZWRUU4?=
 =?utf-8?B?S1ZMZmRzaXZNNURXT1dZVjRUU3FDMjZvaVhIaUdHTjNGeDgrM3JTZFFLQ3RW?=
 =?utf-8?B?UWovdmdMakE3KzdWYTYydXJxNGxyVmQzSWw4SnI4WnAzeFBhM3Z5RTduWE9X?=
 =?utf-8?B?ZExTZDU1Q1M0YTVRcVlMZm9YbXhnSnM2RzJhNER2eDhtbndmdXgzNU80TUF1?=
 =?utf-8?B?S2J4U095dW5SYzNHMWhFNEdnWTIzVWpITVcybUVxQWllMUpQa3NEczhqeTNE?=
 =?utf-8?B?K0lTNGIwKzZyb25LcTl0THBUaUdkaXBBZGFyeFM3NzVPWU01cUxLbk5DOE14?=
 =?utf-8?B?VjNDOFFrMUtrVUNNSWU2NHdsQjlpWEs4OHkxbVRoTnhLOWxhOVVIZEdmL3FL?=
 =?utf-8?B?ZUFLRk43eTJ6L3RHRVZzOVZUZ1VsZFdJbW9QV2hxQ1V5NmpScUdHekprY1Y1?=
 =?utf-8?B?RDRVREVrR3FoWWRROFU3VGZGSGVHK2VESGM2a01qRHpQdU9RajFoeE1iaWtG?=
 =?utf-8?B?ZjhiVmkvUDMwZ3pHUlFZRHRKRmV6TTZvYmZhWUhPUjBEMFcwSDJvQ1NCOHRI?=
 =?utf-8?B?dWc5QXhQNlFIRGJDVkhFLzZ0UHZRN1RjYTh0RWdLZkIyWVhEUzNhTm1QT3Zx?=
 =?utf-8?B?Z3hqZU4remJUYlloUUNGWmpUYyt2T3hGem5LVjZWU3c1ckQ5Vm1jOUhIekJq?=
 =?utf-8?B?Q1FMWlBTNndZaEtmSXJJdFNLSGJSVnlRWWZmVlFxbDZKOHhHSXFzQXpMV3Uw?=
 =?utf-8?B?L3JaandLUS9hMHNhWHdWUWxvdVQ5WWFBcFhzU1VTSmZ1UzFKK0RMWjM5bmFy?=
 =?utf-8?B?b1VLVk03clo3WVpkemUyU3hNTHRPUEQyN3NRTnBGaXZ4MDFXbURXb3NCWUZY?=
 =?utf-8?B?TTJBQkRQYm1LSFdTUndmNEhDS2FZVytWeTdQV0xJWEs2UTJuc3kwbHBrZGFt?=
 =?utf-8?B?NDBGQ1hFVUxtcU52SW5KMmJRL1MybTZxenVFcjVpYXg2ZGg2dGlPdGtHRC9E?=
 =?utf-8?B?TnBrS0dFNHpLT0NIZVRmUFNWSlZyaUd0L2ZvSEg1RnRsZU5oWW51ZDFMa2ZV?=
 =?utf-8?B?dGYwdk13cjNweHhKNVNZS3RjWGx1blZsak96am1DQkdEK3JOS0VyTXhDdW5N?=
 =?utf-8?B?clpISWJ6NmxIMThwbnRJbFFGbzZVODRINmVDK3hNT29zSGxiS01tQVZyRkl2?=
 =?utf-8?B?VDJwRmVJMGxqWnNRRzhETm1NQmN0YmhDNGVoMGY2c0VGMVd6dnFPVFE2K0wz?=
 =?utf-8?B?ZjJVdm5rOVYzUERDZ3lYcnhKT1hhM2RMeHBSZW5NMStGLzZiN0JQcE1wQzVj?=
 =?utf-8?B?Ry94R1hQVlE4cHF1U3MwNGFZOHhVV1d5S3ZuUzB2dEdYbUcvUi9oeWM2WWpm?=
 =?utf-8?B?THVCVHZuYjI5aGhmSWNjYUJyYWFBdTAvRWJpUjcybGg1QWZMTXkwVVdjazFj?=
 =?utf-8?Q?Q8jSDSWlfL0wt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRKNnpZMlZNM1pucHZCc3hhODBoSldzVHJTcEpsaExmOVViUGkrc0pGNDVZ?=
 =?utf-8?B?Um1hWnhsV0QyVnBoRXBDaU5VQWs5aVROVEdudk1kS1IxQ05oeDZ3bkM3ZERO?=
 =?utf-8?B?aCtLNUVxNUQrb0Voc3lCUFN1amdlSm5NcFRqUjI2TUFxNWRrR3hRc2loS0lx?=
 =?utf-8?B?djdyL1B4MnBOV0ZYdkU4d1RBMHRyM2RWU0tmTU9PUTFaZFpBMTJjYzh1a3lT?=
 =?utf-8?B?elZENXdsL0xWS2dnekJCRnhZelNacGZDZThZTWFnTzUwNjhpZEY4SktxeFN1?=
 =?utf-8?B?WDVJT3BmeWRlcUdIOWN3WUlrVkV2T0U2QzVNYzZpMkRoU1pEYUFscEpGVmtt?=
 =?utf-8?B?Ly9pUFF2a2t2WTJKeERSK3B4aG1qNnY2V0lOZ0RiR0RodFdySjkvVFByZG9p?=
 =?utf-8?B?MlhjejdmTXU0RFREcDRETHRvais3WTFPU3hxZ0UwWmRKUWljQzZ4Kyt3Y2Uy?=
 =?utf-8?B?b3RuNFlQNnM2Q1VPYkFkWWEzRjE4MExPUTdnTGk1WGlzbEJwbkF2Ti9YRWo0?=
 =?utf-8?B?RTlFWmRFeFloMitycG5yUHlqZm9MYkhac3cxZis3MmpPbG8rUFgzWk80YnZu?=
 =?utf-8?B?M1N2VGNsL1hJL1pTVVdsTDJ6eVY2WVdEMU9tQjJXcWYxSmxTU1R2bmdGbDZK?=
 =?utf-8?B?QlNGL2IzbzA1MUxFdDVaZk5yckNPdmtNWkRUemRuTnI2Q0pJVDlMdHY4em5a?=
 =?utf-8?B?dStHSnU5S3F2blZqR0N6RFJWQkZ6b3d2MUgxRy9wV3JPQkFXNFF0QUxXLzBZ?=
 =?utf-8?B?eW11ZGd3STZhRnMwcjZ1eE1pSks5UW5pMGVoYzk5Zk42NWdXdzcyZ0RBbWpK?=
 =?utf-8?B?ZDJiQXBvY2RCVFpPY0NuTSs1NzlHd0cwRGlsRjg3cXN1ZjJVNW01WDI5SWVE?=
 =?utf-8?B?dTJlQXFQcEY2YXFUZ0lWYXNrMWwyZ24rb1NPV3MyUm5vUHRFdFVBbW1xT21X?=
 =?utf-8?B?YzJ6WUlydS90OTJFcEhMcFVDZTg3U2M2bGxuUlVjdDlXTFkxN3JSd3ZuQlM0?=
 =?utf-8?B?WEdaOE4xa2FUeUR3U1I1WElVUmRwSGM2QkpQTDdUSDd3L00wZmNEeTJ5QWpB?=
 =?utf-8?B?NjVRYW83aHVjZ1owK2FjR2UwV1ArWUR0d1N4MzZrV21yTitkM3NIWkZ3NFZp?=
 =?utf-8?B?MkliVzczaExnaXZ6ZFdUL1dvdU1QOHdULy9MTDBNL3BFSTlZODJ4S3k4UDF1?=
 =?utf-8?B?TFQ0blA5bnJTZWh2QnBVM1NscUNjQ2MxNUlHNjRpT29YcGNEL3NLRWJXVGtF?=
 =?utf-8?B?dUIwZDdscC9zU1FqcjRpaE53aEhPYWZtMnVkSlh2a0FZeWpna0hwaXZWR2hK?=
 =?utf-8?B?ZzE5bWhhOUh2TWF2L3g5M0RsZzd2aXh1eTNDQVNON2JOd2JHQ3lreU9nQ091?=
 =?utf-8?B?cCsrNmJTSFRjaHBvcUpKaExBdFZGZitqbmpkVys5VHdVTWdyUXlYL1Frdkky?=
 =?utf-8?B?N3VYTXVaQjkzazZlSGt6Q1lEYk01L1ROWGNqNmFWR09RUkJEd29sM3RTamVv?=
 =?utf-8?B?UW53enNtZXlONWlVSHpsVnpkQmdGc0xUMFUxcjBKSGphT2VyN0V6eGlYSDZU?=
 =?utf-8?B?aVQ0ZG1WVFl4YWVuYURFYmk1MDJZdmU5clBpWmRaVjhkWjFkV3NXRkdmTitM?=
 =?utf-8?B?YVFQMHN1Q3IvZjdpOWhGd1FIQXZSK08zYWticzM3aWZCSTMreXhmaTJMbW9u?=
 =?utf-8?B?QUltTE1Lb0Z3UU95UzZNYnlFNS9ZTGE1SVF0ZUlhekt0ZVBMSURQWWtkZy9X?=
 =?utf-8?B?bUhNc0VoeUEzelZLS0s0ajczUWMzbmdjSmhOSU9RMElJenhSQmtWNndzSlBh?=
 =?utf-8?B?VUpBak9wQmZibFZuYWpnVkxrcnVDY2phNUMySGI5VzFIVmYwS2tDUmtTK0ZM?=
 =?utf-8?B?NWRvekpFei82aVNLcnZQQURnNnRkSDVyYkM0Tk94V0hlbW5SU3VMU1JwRTZl?=
 =?utf-8?B?QnJJK09lNG5xWUU3NHlTRVowR3VhZXowdUZFTS9rSXRhWFhBM2k0V2dwSWhz?=
 =?utf-8?B?RjV5NEQ5Si9aRW5XbWNaMUYzdU5SQk9ib3BVL2EzSTU4OFF0TmRsOTV0ZVpY?=
 =?utf-8?B?Wmxrdm82V3Jib2sxOUhPUHZzblE1RG4wZzZNQ3VuSjNWYkhjREVIdmJiRGFO?=
 =?utf-8?B?WlpJUFVIczNQelBwVkg4VDFUTU1sejZ1OFF3Qnc2RElDcU5NcW9IOHd0V0lQ?=
 =?utf-8?Q?+NCr+39R9CAL+Zw2mMI1alI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c6504-721c-457d-8535-08dd572a31be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:28:09.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4ZXI0Ec0xKODwFQGjroFzjrUAyJ1L/wReirYosMs4CcBtBlIK+dkUHluC43sgixU/qejtiZdVQSY+QgCRfJ3FOaHAZNHGgkwo/YGztQJAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com

On 2025-02-26 at 20:44:35 +0100, Andrey Konovalov wrote:
>On Wed, Feb 26, 2025 at 5:43 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> >What value can bit 63 and take for _valid kernel_ pointers (on which
>> >KASAN is intended to operate)? If it is always 1, we could arguably
>> >change the compiler to do | 0xFE for CompileKernel. Which would leave
>> >us with only one region to check: [0xfe00000000000000,
>> >0xffffffffffffffff]. But I don't know whether changing the compiler
>> >makes sense: it technically does as instructed by the LAM spec.
>> >(Vitaly, any thoughts? For context: we are discussing how to check
>> >whether a pointer can be a result of a memory-to-shadow mapping
>> >applied to a potentially invalid pointer in kernel HWASAN.)
>>
>> With LAM, valid pointers need to have bits 63 and 56 equal for 5 level paging
>> and bits 63 and 47 equal for 4 level paging. Both set for kernel addresses and
>> both clear for user addresses.
>
>Ah, OK. Then I guess we could even change to compiler to do | 0xFF,
>same as arm. But I don't know if this makes sense.

I guess it wouldn't be resetting the tag anymore, just some agreed upon set of
bits. If this argument is just for the non_canonical_hook() purposes I suppose
we can leave it as is and check the two ranges in the kernel.

>
>> >With the way the compiler works right now, for the perfectly precise
>> >check, I think we need to check 2 ranges: [0xfe00000000000000,
>> >0xffffffffffffffff] for when bit 63 is set (of a potentially-invalid
>> >pointer to which memory-to-shadow mapping is to be applied) and
>> >[0x7e00000000000000, 0x7fffffffffffffff] for when bit 63 is reset. Bit
>> >56 ranges through [0, 1] in both cases.
>> >
>> >However, in these patches, you use only bits [60:57]. The compiler is
>> >not aware of this, so it still sets bits [62:57], and we end up with
>> >the same two ranges. But in the KASAN code, you only set bits [60:57],
>> >and thus we can end up with 8 potential ranges (2 possible values for
>> >each of the top 3 bits), which gets complicated. So checking only one
>> >range that covers all of them seems to be reasonable for simplicity
>> >even though not entirely precise. And yes, [0x1e00000000000000,
>> >0xffffffffffffffff] looks like the what we need.
>>
>> Aren't the 2 ranges you mentioned in the previous paragraph still valid, no
>> matter what bits the __tag_set() function uses? I mean bits 62:57 are still
>> reset by the compiler so bits 62:61 still won't matter. For example addresses
>> 0x1e00000000000000 and 0x3e00000000000000 will resolve to the same thing after
>> the compiler is done with them right?
>
>Ah, yes, you're right, it's the same 2 ranges.
>
>I was thinking about the outline instrumentation mode, where the
>shadow address would be calculated based on resetting only bits
>[60:57]. But then there we have a addr_has_metadata() check in
>kasan_check_range(), so KASAN should not try to deference a bad shadow
>address and thus should not reach kasan_non_canonical_hook() anyway.

Okay, so I guess we should do the same check for both arm64 and x86 right? (and
risc-v in the future). Just use the wider range - in this case the 2 ranges that
x86 needs. Then it could look something like:

			// 0xffffffffffffffff maps just below the shadow offset
	if (addr > KASAN_SHADOW_OFFSET ||
			// and check below the most negative address
		(addr < kasan_mem_to_shadow(0xFE << 56) &&
			// biggest positive address that overflows so check both above it
		addr > kasan_mem_to_shadow(~0UL >> 1)) ||
			// smallest positive address but will overflow so check addresses below it
		addr < kasan_mem_to_shadow(0x7E << 56))
		return

so first two lines deal with the first range, and the next two lines deal with
the second one.

Or do you want me to make this part of non_canonical_hook() arch specific for
maximum accuracy?

-- 
Kind regards
Maciej Wieczór-Retman

