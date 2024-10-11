Return-Path: <linux-kernel+bounces-361899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD799AE9F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA628284126
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B31D220E;
	Fri, 11 Oct 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nozYCtem"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B81CFEAD;
	Fri, 11 Oct 2024 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685509; cv=fail; b=Wl/PT2WEkcatIUJXb7Le8ZkGhqpnWblO2wcRW9JjJpVDYVzpbBsNVNYzciQK6iNBK9kjuq0ZOHW7Lgu8kqEbqRt0UKmpDDhTJcxWCYGiFTjASWd/5/OPslUqOMEUubvKJgngirTBiGIqyryp3j0FA+FBhegOIw01AkD9u9YHFz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685509; c=relaxed/simple;
	bh=OZUaY8N8H0dJAUP59xisAULociI0btSI6Px2wGXGN20=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7vJ0cF8RhcfXUanfZtUtc6+BZQD2uf/bhUY7a7+9jSG7Bw/mAByHtfBsuANGYhRWAtHw0FlSsEK68c2HfzUmwXVEHHAgGTK/ppcA75xACDpGjYXrjnBvcFvEsSonRBrw+dVGC58ECacGiiav5i8TBBbQMVAHGLj29BcBRFTOYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nozYCtem; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728685508; x=1760221508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OZUaY8N8H0dJAUP59xisAULociI0btSI6Px2wGXGN20=;
  b=nozYCtemffGzGODHUgrm57E7G3aEnAKCDZ1FLczr8GT6ACFTRWhFYis1
   VQ+xXCI8R9A3OpC4HYFwCMfaC0yrOJeOZamf3TcbhGEeLKTq+KHiU91yR
   DSSdwQ/HBv+yRbgOEwBTVHPjhh2xNT8AdxyNMDp7FoGkIUWyYwK8cx2HI
   6uC939oIgtxIiOFwUFzuFDL5i4IjUJ2J6Jc3SKJNZZaOK/c6XmWJM7/Ka
   HM9dYlBS2RM8nVlZAH/2oB4+Yy+hlzfSXRE3DfcIBl+bYWTEIrNB4bKYL
   ZjhtTIQ/rLZ809RrIp/wIQsnc2tzymPmf/xG7Hpw0CwE7n2ghBemc91SZ
   g==;
X-CSE-ConnectionGUID: I6egwu58R+qWY+kfx5pDTg==
X-CSE-MsgGUID: zNBdpKAuS92oc5k0NzZuhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27545907"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27545907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 15:25:07 -0700
X-CSE-ConnectionGUID: 8hpe5S2mQjybG/IDdebW9A==
X-CSE-MsgGUID: 2cwAAyl2Tr263qeKhs6THw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76911628"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 15:25:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 15:25:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 15:25:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 15:25:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 15:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWUQfVVtf88ArMCkEEAh37HMRv4pOxcq9RfarYxAR7+l1sj4WP4+52iHZJTJ0KrVWkhpvKT2PPOCkfo0ioCu7EXpIvHjI7cQmI41kn6cPTJscL9atImVFyBgiHNaQQNkOme+/RaNpOtGmXaU611z//KFHS6MRXErtTtKggNq+shKGlMiUSDvBo3bim94wvlx8TGtqbG0+z7wGeuX3nhJtYFW9UQcUlZr2qPO7aC9RHET0y4IHod/Uzrr8n8cP9qtJ18UdyFqYjwFELE0V7PdJbFAvlX3WvVFNsAqIcQmo8HI02Ayoinc5Iv0QPE14GkEYHe6Pnzq/Xewt1vw5g3xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ35ICW7o971xbr7TpolXuoDQficBBv/9LAEDnaRqkw=;
 b=w0K2zcAQmOpcYNDELjavqgxFOPDwgVXg0q5O8egZjbewfmQz97vqagUJtuiacXPx5+RaE1qwgOM6lAw6ljLMAdPm5NGQFVp/h6rqEtMGB271jDXbZYGHbneF7JfiPtJD1SAH6XkhmHIkE4UfD07wQ4eVmUJcVH9xZcuj0iJot7qZvMxsdphhjw6jSGH7m56JDrCOB7Rwf2rVMwYzT4OrlOacPPIVhTGrlE7KRYpDvphqPvUTQSyNHN7dc0RNp5b3nUTawGNGPmBE0cJFSbhQFPi/IErCQhxSPKAMWF2MmF/ZWI5BXEYFuKXGY/ll67Ta1fc4C547KB7sRKG0CCIiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 22:25:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 22:25:01 +0000
Message-ID: <87d9bf3c-4916-46fa-b07f-c44d5295ba35@intel.com>
Date: Fri, 11 Oct 2024 15:24:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
 <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
 <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: c67f687d-3381-4d0f-a6a4-08dcea438bcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hhRjE3bUxjSXYxaGJQNUtSdDZ4UHVoOTFvQURvUFNoTWZ0cFluOGdFOHkr?=
 =?utf-8?B?SE9BZlFxamUxS1Z0UitZNHREMzNHTE1VV0FvenYvYldNTEhSR2Z3bjhyb0NM?=
 =?utf-8?B?bG5WNzF6QVBXSWVjckRZNHNKV0tKY3MwdW1pQlpqSlE4QzdTZ0tXcUZaN1Zk?=
 =?utf-8?B?T202QUtmaGJ1cXlJc1FUM1lYZElUOXN0OHUvODliSkhMSHZCbEMwdlBmK0s1?=
 =?utf-8?B?Mm5ScnFSSm9TdlBaUktVUkR3Y3VEc2VCMXdaVVBxblBEYXNjbTcxM01odDFS?=
 =?utf-8?B?cHZWVXRlcTNWbVJkU0xyVVpxN3FpbW95UDQ5Y1R1aFczTFNOZzk4SnN3WVRz?=
 =?utf-8?B?dmVNQnhwTjRUUDhFSmZUUVhFQ0VzYU40ZWFZM0VheFFyWXd4dVBmWE5IUUZv?=
 =?utf-8?B?ZTB2ZS9sY0hseHdtMXA3VDJwMnpPY215UmJIajZJVVJrRGZZZmJ4cGttdnpK?=
 =?utf-8?B?QlJnZ1lzSStPWVFSWWJrRmlQbFdHOXR3QmdYL1NLMjRncUhhb2ZhRUVESTZz?=
 =?utf-8?B?OGNqclFKcUtXam1ENmhFcG8xT0NQUXlUaUVmRGd5b0VUcEVXRVNuN25hTlZH?=
 =?utf-8?B?eXZqcVJoRTA0d21mV2l1ZXdwRzJzeUpIdlpoVS9xbWlWNk1CZmhmSTJmdG5u?=
 =?utf-8?B?TTcxRkhSaWZ0TDcwL0s3aXFUTlFoTzN1OUZYK3gzaUpwMmt2MFM5cGtvTk42?=
 =?utf-8?B?NzlxM3FJOUpLVTVkU1k2R3hpU01mNW5BV2syTVdNQ3hnd2FqQVNTU3lsWkd4?=
 =?utf-8?B?dEtoWFVndXg4U1dDZ2U4cnpaSXNzSGZVcWtmMFVQVXpyZnArUWp5NVBzOGZs?=
 =?utf-8?B?SkpHTE1SOWgrVGdmMGxSWEFJMnJKbGRobHIwNXVaWGVFRERCcWhuSjQyVWI1?=
 =?utf-8?B?MG5GRWNxczEwOFlVZEFleG1QVldIVW9LUFZaT2dGb0dTY1B4SzAwSXdUeHNq?=
 =?utf-8?B?YUJTY0I5aUluaGtwSDRkTStzdTBPSnliQzZaN0U3bnNENkJXalJlQmxLUFN5?=
 =?utf-8?B?UDk5dWlNVVZuNStPVDBwQmhlMkdpbXZidnBvVjAvUHMyTjVVZDNzYzZaZ0ZU?=
 =?utf-8?B?OGI0TzZUcVhSaWl1OE9PZThRdHNRM0p4c0RzWTB0STV2alpGVEI4QzR6elpK?=
 =?utf-8?B?UkhENjcyYVo0eEdaaWQ0SjdadGt4S3Iza3JPemVSOGt6Zk0zWmxBRkRDZUcv?=
 =?utf-8?B?QUdQTW1PanRHdGNlRmVSd0NWYk1pK0czbjM1ZzFya0hvclhxWGc0QkVDcmV6?=
 =?utf-8?B?ajlZdXU1SnMwL0VGcFh1ZFZ0SU1GYWlCYmV4YWl0ZnhyWEl0akszdExFKzZ2?=
 =?utf-8?B?NXdZcS9GVUhMT2ZvUC9wNHF6eWhOY3Q0SldyYXZHYkI5bjlTS25hU215Q2Jn?=
 =?utf-8?B?M1FEUUVSeUx4emszUmFDbWRrRWMyeXlEUWZzNDY2alByZ0dBYnd2SmlDYXF6?=
 =?utf-8?B?cFppb0xHQmhlbDVoZWxDNFZhQ2s5NFdnVEJ1T2J0RWd3eWJFUWNXZmFWWUxJ?=
 =?utf-8?B?THFuNmFIMDVZejV2ZUVVVG16UjJJT0NxS2JQV093NnF2QkhpRW9RUFlvbE1B?=
 =?utf-8?B?aG5jV1gvMnIvQ0c3RmJpd3pHeXRLbXVqbnpiOTBNL3ZQV0dMdzFDT1NCaUtV?=
 =?utf-8?B?QS84VnErL2pJNHJqQkhRamtJS211QXlVTlUyQ1lPUHBPVUpjTFVyTklleGpF?=
 =?utf-8?B?NGN3U3ZQdnl5akRiWDg3USs0cUg0YlZibndVWWZlVUkzRlE5RDd3TEV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhjb3FYdDgzYnovbFJvcEI1WVhTRDJiREg2K0I5amJZNi82ZnlLWGxsaGhm?=
 =?utf-8?B?YjVKQ2ppZjMvSHFJMFc2bXJmWG1aNWR6dEJ6WmNDTFh6SDd6UHNoQUVSWGxn?=
 =?utf-8?B?L1JsKzZzUWVNZERZb3hJaWM4aklGWXpRNm9hV1BLeWdOU1dQNVJTMVNGQy81?=
 =?utf-8?B?OTM2QVowSEptZXlNamVPZWQ1YkJXK2hnYktuUzJkY0drZXJuclJESE5yRGVK?=
 =?utf-8?B?RVRKRUlrZmdxeFNISC9mVjEzT3ViSzRrU2Yza3pUblEraGlELy9qYU15elpL?=
 =?utf-8?B?WWQ0VHFHZ1BRNHEzamYvWVR1TDMxa2t3WmhQK1hIdDZCN05pTjd6bHJGbnda?=
 =?utf-8?B?Sm5hdWtOc1NrTlhkeFd6d0pwcGZiTzMvN1V0NUltbk5hcGY0NWVxUXV1RkIr?=
 =?utf-8?B?bk9xLzBwd2JXVW9VNG52WEpoVkU0RnBmaHkvYzcrbkVJQjhoY29kcmwyNkNv?=
 =?utf-8?B?SVliZklnU2cybHpCYnBYcnFYMnVhZi9VY25CS1FjQlU1Z3cvVy8zZGJEMU9r?=
 =?utf-8?B?UDZEcUtsME1KTnlqV0VlbGVEbXdOR0Npa2hadmZhL3BWendvdjBZaFRCMmJk?=
 =?utf-8?B?VEdySVFrUG1udUZSRVNpR3hPQzlvNFZZOUlqWkU4aXBDL3QraFp0Sjg1WlhJ?=
 =?utf-8?B?dTQyN1VKRVRhVFlLQUROci9CTzdTMzRCS1ZaNTZPMnJBOEZOM2RBdmIzbjVY?=
 =?utf-8?B?WW5scUp1N2JzS3BMNDkwd0UzRHQ0MnkxVnRvdyt5N1VrRVNqWlhhZzdGQTNx?=
 =?utf-8?B?Yy9yZWJNTGdyaUtoaWF5ZWtwQ29FejdwUlVkbXpBSFNkLzhnenVVZnU3ZHNl?=
 =?utf-8?B?SENaM0JHZjNNekJsM3lkT2dEc2RFYzg4ajBPUzRnRjZMRHh5UXhCM1dQcmtU?=
 =?utf-8?B?WW8wazdxK0NpaXk3L3NJQU5RbkVtN0VZYUpmdjRCVmpzazRnT0hjNW5rRnRy?=
 =?utf-8?B?aFZibXJ5UW1ZZjBEL25UdHhmV0JJL0ZRaGYzOWpMM3RFTDZyZWhLd3NWajBn?=
 =?utf-8?B?VEF6emtnQlpLem1JS2d4UFAyWHZDZFZ4Q2xkOWNNMU5oQWNBY2prMDRwc1FE?=
 =?utf-8?B?d3c2K090dlhGeWc0TERld0Y0VlhLenZDcEZNMVVwblB4dkhKV0txTXYvdDlB?=
 =?utf-8?B?ZTZvdHpvZkJtTmM1VFdtUGNZemNoZTQyMmwyRFBldFFpNzVveUo5QStDcWYz?=
 =?utf-8?B?VFNPckhQVkROKy9SamhBZDNDOVVDUjhlQ0F5RStzaWI1UnpsKzdxWmJWTkNk?=
 =?utf-8?B?UjBkdXkxSnR2Y2dOazFEdUN6SXAybnhKblFDZC83ZlVsS1VsWSthYmxTVTVC?=
 =?utf-8?B?UVM0blFrSUo4RFZCZ1ZXMzRWQ0dSVVFNS0I2YTVUdWtqRWcyNGdxYTBEYkpj?=
 =?utf-8?B?Uk44dTdDOWpOeVpxalpFVndBdVBrRENQWDNvSkVxdmNBZmZuSkJnUHlhWWIw?=
 =?utf-8?B?VDZhcmFYTGlpZjBlWWNjMm5FemxhNXVsUVdTQi9Bc05WMWhZeEJucjlkb3V1?=
 =?utf-8?B?d0x3dHJBb0xjQkNZS0p1MWZPZWNmY0UzYTd6bDB1cU1zZC9yd3UxcG9sdUxP?=
 =?utf-8?B?bGtSMno1ekFVTHMzSFBEellhWUN4K1A1bEM1QTJ0aDNZVFBhbzZxYk9ETFNR?=
 =?utf-8?B?TDhRTEovRkJUMnJxOUhUSTZEbGNrbFlpUzF2NE5wNDJiRzNheCtDWUFlWnVl?=
 =?utf-8?B?Smp0WEFmWjZvakFjUmpvRmdyczlFV0hYR2hqL05pYmNpc2ZYYmRHU0ppbTFp?=
 =?utf-8?B?VW1YdW9UUkFkdGtnN0llKzFvbVR6OWdrTHk4ZmhNdE5mRmpFQjAwK01mOW15?=
 =?utf-8?B?bHNHd1E1WE1EWHI1QzB2UVdxSkMzamtmM0Z4aGZZcjI5eUdFNGdaTUt5cmh3?=
 =?utf-8?B?TzZpeVc3MGpOb1VqZDlOcU9TZVE1L2N5ZUVoNlNESkw3ZzVoQVRrbzJ1OVgr?=
 =?utf-8?B?ZW9BM2JDMTRxR0dEQVk1cldCSHFJMTZXNmNIbGpCbFhNemtaSXZHT29RYnkz?=
 =?utf-8?B?ZGF3RUxYZWhVVklGL09QYW96OFpxTkFSdFVxbVVPS1o0S0xqS1J2MlNzOHFy?=
 =?utf-8?B?V0ZlR282NnpZcnBTQktPZkFNRGxPZzVISGsrMkNSWjRUcUpWSno3NTRFREJU?=
 =?utf-8?B?Z21NTThEY2gwRlZUaUFVRlZqK2oyT1BpS0NBMDhYdmFZU2R6aU1zVUd3Q3gv?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c67f687d-3381-4d0f-a6a4-08dcea438bcf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 22:25:01.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZ+Wdy7MU5+AHC9KF/6CMszoIxy9lNkXgpQJVIAlWhMhXI2Hugl1ieqVSkW6jf/pqErOqGZAAA2G+KwNc8ZAEOjEdIvv1lEFd76b5vmyE/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com



On 10/10/24 8:30 AM, Moger, Babu wrote:
> On 10/10/24 10:07, Luck, Tony wrote:
>>>>> +  By default resctrl assumes each control and monitor group has a hardware
>>>>> +  counter. Hardware that does not support 'mbm_cntr_assign' mode will still
>>>>> +  allow more control or monitor groups than 'num_rmids' to be created. In
>>>>
>>>> Should that be s/num_rmids/num_mbm_cntrs/ ?
>>>
>>> It is actually num_rmids here as in default mode, num_rmid_cntrs are not
>>> available.
>>
>> Babu,
>>
>> The code isn't working that way for me. I built & booted. Since I'm on
>> an Intel machine without ABMC I'm in "default" mode. But I can't make
>> more monitor groups that num_rmids.
>>
> 
> That is correct. We will have to change the text. How about?
> 
> "default":
> By default resctrl assumes each control and monitor group has a hardware
> counter. Hardware that does not support 'mbm_cntr_assign' mode will still

I think this is independent from whether hardware supports 'mbm_cntr_assign'
mode since a user could enable 'default' mode on hardware that supports 
'mbm_cntr_assign'. This snippet is thus more about what is meant by 'default'
mode than what is supported by hardware.

The docs already contain:
	"num_rmids":
		...
		This is the upper bound for how many "CTRL_MON" + "MON"
		groups can be created.


Neither of the 'mbm_assign_mode' options change this meaning of 'num_rmids' (i.e.
no change in how many monitor groups can be created) so mentioning it in the
'default' portion but not in the 'mbm_cntr_assign' portion may create confusion.


Perhaps it can be simplified to:
	In default mode resctrl assumes each CTRL_MON and MON group has a
	hardware counter. Reading mbm_total_bytes or mbm_local_bytes may
	report 'Unavailable' if there is no counter associated with that
	group.


> allow to create control or monitor groups up to num_rmids supported. In
> that case reading the mbm_total_bytes and mbm_local_bytes may report
> 'Unavailable' if there is no counter associated with that group.
> 

Reinette

