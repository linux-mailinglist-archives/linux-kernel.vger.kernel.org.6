Return-Path: <linux-kernel+bounces-514439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A187A3570F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA963A4621
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FA1FFC6D;
	Fri, 14 Feb 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fukcmRaZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE022071;
	Fri, 14 Feb 2025 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514387; cv=fail; b=lPK9PWFQk4dmE6iQniTlyyLclxiihxQ5p/Oajf0kKIxOfOI3eUuu9KEvOhgrUV07DOHdRelRChAsmFx8adO4GWaojc1k1EsoCpIqIYprF96d5D9PStxEP4/EbmdD2S5Mj9j1m5XYCrdcuUTLazsd2tmobHeyiYA9odCvUqbyT6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514387; c=relaxed/simple;
	bh=88UrI+CeDov0RCFVDCcmMwHz716I7sztHTQJjBdSorM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G+O0ZYMU0tzxFS6+FPllJP2tyI8GOQbvOkOH6lyKGS9gsIZ3kgRGywV6h0NWA7kPUPI65Xos2ZouN9PyJwvLx2rxjo5QDkUqsIIJfJayVLpvoIvpIjJJEl0j/gO8sU0ybxxsN229ewBnQYipdMpC0DvquBIUQ1IxU8gX27g1hVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fukcmRaZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739514385; x=1771050385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88UrI+CeDov0RCFVDCcmMwHz716I7sztHTQJjBdSorM=;
  b=fukcmRaZsh5rvwVCC7L510e1ruEEZ4CJCwdWW+Wg4Ikw/xfPMBdnTUQw
   TUOCMcNdthutnNWNngTdj/9kuzUGgtwgl1DiSTP5ezFp8QTSGa6e9+Bmx
   J7VyyrFZe9w6b/BrZcfgccVFZYeZb5Pz4+ztw6ACfX3hiWAsmA87AC77R
   IVs33+VA7XVBnMJ5soUTHdAy4cR4kIhglDGJUmQeVx6WzSKkb4UjFsyHO
   Y4ssWFh/kMMaWWcouu0V/gCosH6FGzbiy2WEAZObvSfqrrCgsMFoapNlB
   Wu9IKP9JepuPVfvjC4olQ0YIDaMFrI+N/Sdrok1p83UxpBNV+zOLSk7Mj
   w==;
X-CSE-ConnectionGUID: iisbHPBsTpq5TmYAzcK7fg==
X-CSE-MsgGUID: O4t16BxdTPGudkAQNZ155Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="62717179"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="62717179"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:26:24 -0800
X-CSE-ConnectionGUID: AYePD0f2Rv6pCbMiPNO2tw==
X-CSE-MsgGUID: xk4Y2ODURsmJVDM+d5+leA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="118475813"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 22:26:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 22:26:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 22:26:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 22:26:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BePa64w4tZuxuZAXu4SeaejKpPerZjyA0MRC2qkxc4wimazH71EGhnuagNYBCHAvxEgtnGKOy8mZG+3OoZ0jt2EenemUykvfxpzhrwh4cy+LDTrN1kjt5fMIytKB/aIYFLW4FKo+qITv9wFD0fZ1BNU1lcsu8kEp7kcOiHPcdliBNkDxguFVzA8gvfqyAXRF0HwFs7M604MWMiZFlMxHRyGxT09w1CR/lF2jQbC4HkctIr/kEykke+0lYhRpF6x6gOAHPbC1u0b/Jbf2PPjvxJ6I2mEe9sMvbPz/mC1NcaToBV7GMX5bsfDNCFcVQkik1wy6DrDdyqEwF93VzxIewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2D6GK1TIxrj+Qshdekp+DVWC1lZWqTHaCZg0pW+BMs=;
 b=y/U+Fo6CT2j6P+scBX/duroVCfWnSJc9bKnNeNQJYKrGLo+GLNyubta2jxcSCQcxm28XQpg4+YNoxYaPy7W5yNvqczWLRiApE7qT3h7uYB/5TN6xHcgi9yIL722aWv3v51b6cgt8uFcu5yjfFBKqHV/0YrEpnKwO0Qrzs8WQfeAcSDRmvYeS5aGSBQVkLPgMZUGEvJw0PD2akYLhutOVtsE+17b3elAnZQbr1AXKpSIn9rlKi7x5r2YJsyWLTTJ9Fdb1lvxYqa3rAlzsXvzne9UpAo7/eV7P1RzKIVHLawRSy53LVk5tncc8gXWGaBUunxPrBjjmusu7iHA9w5fO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 06:26:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 06:26:11 +0000
Message-ID: <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
Date: Thu, 13 Feb 2025 22:26:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>
CC: Babu Moger <babu.moger@amd.com>, <peternewman@google.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, <fenghua.yu@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z64tw2NbJXbKpLrH@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8cbcdf-78df-4868-c6ae-08dd4cc07981
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUxRQ3Z1aVhia0ZBbG5zaGdSUnl4Wk4rdjlVNEpadG9lV3piT0ZjeFZWbFVq?=
 =?utf-8?B?MHZLSDdTV1RIdndYK2NXUjBWSTY5cVNQbG5SRXREbEhuTllRb2ExVjlpMXFM?=
 =?utf-8?B?QkhBV0JtSDd0MDdUSFpZckgrOFg4MTVHczN2aEdsekY4ZUxiNVE2SGlsL3FT?=
 =?utf-8?B?amtJVVFoU0IzcXJNZ2xSNVlxRVhpbTdianRCbVpmcG4zVGdkdm95ajhsMllr?=
 =?utf-8?B?Sm5aUk1US3BmUlJjYWZJUWNRVmZiT1JQZ01YQ09oVDdNSGxTaXBRRU8raG10?=
 =?utf-8?B?UXp4NW9Eb1Z5WERrMTM4YUQ4MFB3QjlseHNXYjF2MWRFMFUyZEFibC9nTlAz?=
 =?utf-8?B?M2lrTk43ZC9SZENaVHBWYVJzTTF1R1VFUzRxbWRSMHNmcng3WitMc1QzL0w5?=
 =?utf-8?B?Qk5yRDhBaDU2RXJiUHBQQUdFMVR4S0t1THlCZ1UwVEgySDVackwyV1RNNkxZ?=
 =?utf-8?B?UDZBV2kyMy9PeW1jZW1sam8rYWFNZnFBSmx5TDNNVkhyUlc1UXZtOEc1VU0y?=
 =?utf-8?B?ZU00aUw5L3hvTUhJcVprdVJodzh3UUhCb1BpMWhxMnV5b1V6S25HdDM2dytZ?=
 =?utf-8?B?VnMzdmYzcmloS0grMVZoa21Db0ZHRFVVRmRSS2dIR1N5MXNCdFN3SHJZRUsy?=
 =?utf-8?B?UDJqM25YbkdNUkcyRU45ZFkwcWpvaHY4SzYyR1loc0JkNjBpdHBZaDJIMmpP?=
 =?utf-8?B?REpIS2ttbVRFd05DQWRId25PenVBUUkxSUh0dXZ0UCtaeUE0UG9EeHJKREhX?=
 =?utf-8?B?UFJwczFveVMvWmJic1VSNjZTMDQzNEw4NkI4c0RFbC82VkR1SEMvM2hudTJK?=
 =?utf-8?B?Qm1VOXRhc01qK2krWWJrcm16ckhCMUdKdUVUdEUrMjRlWHBQSnNJaEZ0eHhu?=
 =?utf-8?B?YTRKUDRNS1RZRFdvMFNBT3UzcktPcUZXSlNHNGtEb2xhcjYrTlN0T3RXY3lF?=
 =?utf-8?B?UnRyYURwUEdLOGVXSnY5TW0zZEVtUU5FV2RrL1YvZkNmK0JIaVh1MlBuSkdh?=
 =?utf-8?B?Z0tNamJtYzNTMWRCNmcwbHptdUIwWGdhM2hwc2t5a3B6TXBFK0RvL3Y1T25H?=
 =?utf-8?B?ZEJRU1BzV1k0QTVaZVlyWDVLelpHOWNIY216Yko0Q3pSK1puanZucDcxSGpn?=
 =?utf-8?B?OGQxZkg3cUdSa1dOeHU1YlFyTGc0K24rTjlTZzVnaktaV3k5elJjUVFvNTVl?=
 =?utf-8?B?UG52R2hEdjdBOWJVNHYyWEh4ZkRwWHp6WDJ3azhUTC9nZ0VmRXBJbW9teVpl?=
 =?utf-8?B?ZHZ2SnZJVndkLzZLajV5dzViSDlqOE1VcVRBTGh6MlB5VDEvTXo5eFVoemdj?=
 =?utf-8?B?UVM5NzFqWVk2b0NaTW9YUDVXRGd4Y25BUlRUUGhOd3VBK2NBZ2NIdGtSc2RF?=
 =?utf-8?B?TDk2SDBFRzBmUTYyMU9ibHFtVVh3V25ZNkk5U2l6Zkl3MHpvcnhVNWtJb1pS?=
 =?utf-8?B?Y0hzN2dmY085ZkZZdzBYQ09PdzJ3VzdSMzFLYVBoSjFoUW82ekIydXdsbUVx?=
 =?utf-8?B?cGh3UDhKN1pjanpxbHExQ2RIWCtGeFZBZ0V0NE82cnZHeDErMnlTbzdQN2ov?=
 =?utf-8?B?SDQ0UmptYWdoRDdqMmg2VjBLRnh6TWVtVWM3enplVFpjcS9vRzhOUXBqWS9i?=
 =?utf-8?B?MVExM25wdlNQNU9xUGxmaXpiWVVLeURPdjV4R1MvNzRoaU5zMDU3S0U2c2V6?=
 =?utf-8?B?Mm50d0MzcG5pUDlBUnBJMHhVM3pFQ3YwYjJmYlE0UVYxTWhYaFlkTTVTY1BB?=
 =?utf-8?B?SGVGK3JNVGFWNTJYQU9NVDlzKys5WFUzbHZUdTdUWFBybTJybXYvUVBEaWFH?=
 =?utf-8?B?Ky9WQTBuaGY0WlZZN1lXUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFyeWNCM1hJdGg4ek1XZVZVQUdJYVhLWmdRNWhYM0hKVWhtOGRaNWRGc1Zk?=
 =?utf-8?B?UE95aWhFVjMrMGcxcGZldEttSVB6NloxM0RPV3orZnVGZXdyVmg1b3lHRnRN?=
 =?utf-8?B?NDZCdWhjZTFxT2N1RndSdVBsQ3pDdUswbkdzck1VVWlGbVAvU3hBZHdod2hJ?=
 =?utf-8?B?b0FoSGZnWjN5am1obEc2T0lZRllXZ0FSY1VJU0UvV1FTYTI1WUQyS0dhY05S?=
 =?utf-8?B?SnNPS0pzd1U5UzAreDJJS29za2VQSy81TEhEc0pzN1ZjVE5DZDV5OUdZbm44?=
 =?utf-8?B?dHIrSXVMM2RkcU0vQ3lyN1NiejFJSDFEaERqN3I5TDIrZktObjdlK3lNcVJ1?=
 =?utf-8?B?aDZ0UTBNNy9xcEV5ektQejlNcFl5QS92VXlSOERlWERlelNzUjBGSWI3bk1C?=
 =?utf-8?B?QndDeFpidHoyejJhQlc3Q3E0c2J6dUFnRHRlMHdncjVLcDhRYnZtOGNxbkJw?=
 =?utf-8?B?Qll4UmtlYzdhaHZGaVE5T0hhZFJmazEzNjlkL1M4WXgxd3U3VGZ3VGlzQkRM?=
 =?utf-8?B?c2I0alU3enZsYmxFVVJGNDhLSlh5eUFQOUJWWHMvSlQyVG5LT3RnM045amhM?=
 =?utf-8?B?TzJlaWhUVUtRa1NsM2NKUGNYdHlyaDduQWpnNEgxSjNhKzhRckRpVUhtVHRm?=
 =?utf-8?B?TVZQeVJNTmhpQmt5cEtvQ3pYVlNUN2RBWXdHM0MyT1JSZ04vM2hrUUNKM3ow?=
 =?utf-8?B?dXVTNEZQbUpDVnh0blZtRVN2R3NOL3hROXZ0ME8xREpuZVNiaHdOQVJoRjF1?=
 =?utf-8?B?anU3RmRUSVhQalJPZzJFWkZQUFBObFBGQWEyYURjZlVOSXozWDRCbXRKeVNJ?=
 =?utf-8?B?dWp4aklRQWZscnFNYlovYVJWVzAzaHQzcWxPNnVnazJwUUhrb1ZvV1k1R1Fo?=
 =?utf-8?B?Nmp2R2krOHVRNmhwVnF2dkRhOHptVkd6SUQ1RXJyRGF5bzkzdGZ4UDdZK0Ns?=
 =?utf-8?B?c0tjOWZNd2wyV3RRUkpyQ1hZKzkyZUxiQklPdzVhUCtnWCtwWkpWbVFxMHp2?=
 =?utf-8?B?RWVlWFQyMURhemJNNjB1akxiUXJMRkZVU1FpZWR6elM2WG1yUnFFZzBLWmU3?=
 =?utf-8?B?Z092V09mOVlqWktrM0FiUmZpK0RTUlJPeFh5emxmUUNvc1lNSDdUSVFJSkVD?=
 =?utf-8?B?eUNseHYyTmoxR2JhMWQvZ0hQSk96U01ienFoRVhybm5Ha3NBMURMZ2Q3SVJo?=
 =?utf-8?B?eVNQWDh0d0F6c1VwaG16MG41TjRkRUx3VXlXYzBWaVExVGpPSVkwaHk3Z1N0?=
 =?utf-8?B?TWhCNWhyUjBtN1R3Z0NHbUR6WHF0Mys4dkNVUEVMNC9yTG9ZNkxGVnF3Q1d5?=
 =?utf-8?B?VkR3c2ZBcXQ2Q0QrNHVhRWp3K0dMbXE1d3lFSlN5Z2o2Q1JUQ1I5cEF2WVY5?=
 =?utf-8?B?SFpRQ2xaKzFjdEVLTW5NOUdkblI1bmdycVdIQ1U0bmwyZWsxNGFjUXI0U2Vv?=
 =?utf-8?B?dVVtTUFkTS8zeW9xRVhoM2p5dHRKOE5ocHZOcHdkUmRHc3RkMlAxTlFyYmZT?=
 =?utf-8?B?b3NzNFJpSXlyZ0ZXNUoyK0hJZUJzak1NdEc3OW1rdkZQSW9QSnBYSzlqbVhp?=
 =?utf-8?B?aWpuUk84cEszdzc3U2ZjempOeFFJTG5IOFBoRXl4UWJJazhMY043YUZXTDNL?=
 =?utf-8?B?RFM3V0dCU3JQcVRpcjF0TUFad2ZUdGozUU1ubFlyODFXWE9ubGdKZFV6QWpG?=
 =?utf-8?B?bTZTQmxGbkNOYnRaMFpKUkROR2l5UEdlUk1kdCt3aEJZMlRsRmduOVlneWpr?=
 =?utf-8?B?cEt6bUFEZHAzNVBHNUwxWUgraGkzbEFHeTU4M2dlTTFpRnFVRnJEeks4SHlM?=
 =?utf-8?B?NGpqaWFkZW5lRklTQjJaMjdzT2JncFFoWGRKK0ViYVNhNEhWZlA1SWNicUox?=
 =?utf-8?B?YmFWVURwVnlldzBmMFhYMzUvMDYrV1FVMnZFL0s1WlJtRytxcDZrWlBybWdJ?=
 =?utf-8?B?K0JBM1N0ZnZ0MWEwRlhNNDdIcXlYNjB4aWZRd01IRGU4MGd3ZnN4RkRxVFZy?=
 =?utf-8?B?TWlKSGxWV1NVSzRCSGdGT1UybUlUaWxSR1lDTEZoem1QWW9XSm9melBrendO?=
 =?utf-8?B?ajR2WUNvcE5TKy94elczc01QQ1d5RkU2M2ViNDEwNUFEczgrbHUwSnNOZzFx?=
 =?utf-8?B?b2RIc0tpYjdUMDB3eHc1R1ZXVFZVazJLV3lnSVczdnZ2VHJQLzBtdnJYVzhj?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8cbcdf-78df-4868-c6ae-08dd4cc07981
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 06:26:11.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd791ZoiMvp6RLmkfiZuyD+WfhGC9r2kfsB8CXeDokpKL6m7qHZLbl5uMW25C5toQetWUnl41w2PGg5KaJdLc+eX4kKPIyO7sg7b7of2luo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com

Hi Dave,

On 2/13/25 9:37 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>> Hi there,
>>>
>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>
>>>> This series adds the support for Assignable Bandwidth Monitoring Counters
>>>> (ABMC). It is also called QoS RMID Pinning feature
>>>>
>>>> Series is written such that it is easier to support other assignable
>>>> features supported from different vendors.
>>>>
>>>> The feature details are documented in the  APM listed below [1].
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>>> Monitoring (ABMC). The documentation is available at
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>>
>>>> The patches are based on top of commit
>>>> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'
> 
> [...]
> 
>>>> b. Check how many ABMC counters are available. 
>>>>
>>>> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
>>>> 	32
>>>
>>> Is this file needed?
>>>
>>> With MPAM, it is more difficult to promise that the same number of
>>> counters will be available everywhere.
>>>
>>> Rather than lie, or report a "safe" value here that may waste some
>>> counters, can we just allow the number of counters to be be discovered
>>> per domain via available_mbm_cntrs?
>>
>> This sounds reasonable to me. I think us having trouble with the
>> user documentation of this file so late in development should also have been
>> a sign to rethink its value.
>>
>> For a user to discover the number of counters supported via available_mbm_cntrs
>> would require the file's contents to be captured right after mount. Since we've
>> had scenarios where new userspace needs to discover an up-and-running system's
>> configuration this may not be possible. I thus wonder instead of removing
>> num_mbm_cntrs, it could be modified to return the per-domain supported counters
>> instead of a single value? 
> 
> Is it actually useful to be able to discover the number of counters
> that exist?  A counter that exists but is not available cannot be used,
> so perhaps it is not useful to know about it in the first place.

An alternative perspective of what "available" means is "how many counters
could I possibly get to do this new monitoring task". A user may be willing
to re-assign counters if the new monitoring task is important. Knowing
how many counters are already free and available for assignment would be
easy from available_mbm_cntrs but to get an idea of how many counters
could be re-assigned to help out with the new task would require
some intricate parsing of mbm_assign_control.


> But if we keep this file but make it report the number of counters for
> each domain (similarly to mbm_available_cntrs), then I think the MPAM
> driver should be able to work with that.
> 
>>> num_closids and num_rmids are already problematic for MPAM, so it would
>>> be good to avoid any more parameters of this sort from being reported
>>> to userspace unless there is a clear understanding of why they are
>>> needed.
>>
>> Yes. Appreciate your help in identifying what could be problematic for MPAM.
> 
> For clarity: this is a background issue, mostly orthogonal to this
> series.
> 
> If this series is merged as-is, with a global per-resource
> num_mbm_cntrs property, then this not really worse than the current
> situation -- it's just a bit annoying from the MPAM perspective.
> 
> 
> In a nutshell, the num_closids / num_rmids parameters seem to expose
> RDT-specific hardware semantics to userspace, implying a specific
> allocation model for control group and monitoring group identifiers.
> 
> The guarantees that userspace is entitled to asssume when resctrl
> reports particular values do not seem to be well described and are hard
> to map onto the nearest-equivalent MPAM implementation.  A combination
> of control and monitoring groups that can be created on x86 may not be
> creatable on MPAM, even when the number of supportable control and
> monitoring partitions is the same.

I understand. This interface was created almost a decade ago. It would have been
wonderful if the user interface could have been created with a clear vision
of all the use cases it would end up needing to support. I am trying to be
very careful with this new user interface as I try to consider all the things I
learned while working on resctrl. All help get this new interface right is
greatly appreciated.

Since your specifically mention issues that MPAM has with num_rmids, please
note that we have been trying (see [1], but maybe start reading thread at [2])
to find ways to make this work with MPAM but no word from MPAM side. 
I see that you were not cc'd on the discussion so this is not a criticism of
you personally but I would like to highlight that we do try to make things
work well for MPAM but so far this work seems ignored, yet critisized
for not being done. I expect the more use cases are thrown at an interface
as it is developed the better it would get and I would gladly work with MPAM
folks to improve things.

> Even with the ABMC series, we may still be constrained on what we can
> report for num_rmids: we can't know in advance whether or not the user
> is going to use mbm_cntr_assign mode -- if not, we can't promise to
> create more monitoring groups than the number of counters in the
> hardware.

It is the architecture that decides which modes are supported and
which is default.

> It seems natural for the counts reported by "available_mbm_cntrs" to
> change dynamically when the ABMC assignment mode is changed, but I
> think userspace are likely to expect the global "num_rmids" parameters
> to be fixed for the lifetime of the resctrl mount (and possibly fixed
> for all time on a given hardware platform -- at least, modulo CDP).
> 
> 
> I think it might be possible to tighten up the docmentation of
> num_closids in particular in a way that doesn't conflict with x86 and
> may make it easier for MPAM to fit in with, but that feels like a
> separate conversation.
> 
> None of this should be considered a blocker for this series, either way.
> 
>>>
>>> Reporting number of counters per monitoring domain is a more natural
>>> fit for MPAM, as below:
>>>
>>>> c. Check how many ABMC counters are available in each domain.
>>>>
>>>> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
>>>> 	0=30;1=30
>>>
>>> For MPAM, this seems supportable.  Each monitoring domain will have
>>> some counters, and a well-defined number of them will be available for
>>> allocation at any one time.
> 
> [...]
> 
>>>> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> [...]
> 
>>>>        Flags can be one of the following:
>>>>
>>>>         t  MBM total event is enabled.
>>>>         l  MBM local event is enabled.
>>>>         tl Both total and local MBM events are enabled.
>>>>         _  None of the MBM events are enabled
>>>>
>>>> 	Examples:
>>>
>>> [...]
>>>
>>> I think that this basically works for MPAM.
>>>
>>> The local/total distinction doesn't map in a consistent way onto MPAM,
>>> but this problem is not specific to ABMC.  It feels sensible for ABMC
>>> to be built around the same concepts that resctrl already has elsewhere
>>> in the interface.  MPAM will do its best to fit (as already).
>>>
>>> Regarding Peter's use case of assiging multiple counters to a
>>> monitoring group [1], I feel that it's probably good enough to make
>>> sure that the ABMC interface can be extended in future in a backwards
>>> compatible way so as to support this, without trying to support it
>>> immediately.
>>>
>>> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
>>>
>>
>> I do not think that resctrl's current support of the mbm_total_bytes and
>> mbm_local_bytes should be considered as the "only" two available "slots"
>> into which all possible events should be forced into. "mon_features" exists
>> to guide user space to which events are supported and as I see it new events
>> can be listed here to inform user space of their availability, with their
>> associated event files available in the resource groups.
> 
> That's fair.  I wasn't currently sure how (or if) the set of countable
> events was expected to grow / evolve via this route.
> 
> Either way, I think this confirms that there is at least one viable way
> to enable more counters for a single control group, on top of this
> series.
> 
> (If there is more than one way, that seems fine?)
> 
>>>
>>> For example, if we added new generic "letters" -- say, "0" to "9",
>>> combined with new counter files in resctrlfs, that feels like a
>>> possible approach.  ABMC (as in this series) should just reject such
>>> such assignments, and the new counter files wouldn't exist.
>>>
>>> Availability of this feature could also be reported as a distinct mode
>>> in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
>>>
>>>
>>> A _sketch_ of this follows.  This is NOT a proposal -- the key
>>> question is whether we are confident that we can extend the interface
>>> in this way in the future without breaking anything.
>>>
>>> If "yes", then the ABMC interface (as proposed by this series) works as
>>> a foundation to build on.
>>>
>>> --8<--
>>>
>>> [artists's impression]
>>>
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>  	mbm_cntr_generic
>>>  	[mbm_cntr_assign]
>>>  	default
>>>
>>> # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
>>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
>>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
>>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 
>>>
>>> ...
>>>
>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
>>>
>>> etc.
>>>
>>
>> It is not clear to me what additional features such an interface enables. It
>> also looks like user space will need to track and manage counter IDs?
> 
> My idea was that for these generic counters, new files could be exposed
> to configure what they actually count (the ..._type files shown above;
> or possibly via the ..._config files that already exist).
> 
> The "IDs" were inteded as abstract; the number only relates the
> assignments in mbm_assign_control to the files created elsewhere.  This
> wouldn't be related to IDs assigned by the hardware.

I see. Yes, this sounds related to and a generalization of the AMD
configurable event feature.

> 
> If there are multiple resctrl users then using numeric IDs might be
> problematic; though if we go eventually in the direction of making
> resctrlfs multi-mountable then each mount could have its own namespace.

I am not aware of "multi-mountable" direction.

> 
> Allowing counters to be named and configured with a mkdir()-style
> interface might be possible too; that might make it easier for users to
> coexist within a single resctrl mount (if we think that's important
> enough).
> 
>> It sounds to me as though the issue starts with your statement
>> "The local/total distinction doesn't map in a consistent way onto MPAM". To
>> address this I expect that an MPAM system will not support nor list
>> mbm_total_bytes and/or mbm_local_bytes in its mon_features file (*)? Instead,
>> it would list the events that are appropriate to the system? Trying to match
>> with what Peter said [1] in the message you refer to, this may be possible:
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> mbm_local_read_bytes
>> mbm_local_write_bytes
>> mbm_local_bytes
>>
>> (*) I am including mbm_local_bytes since it could be an event that can be software
>> defined as a sum of mbm_local_read_bytes and mbm_local_write_bytes when they are both
>> counted.
>>
>> I see the support for MPAM events distinct from the support of assignable counters.
>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>> Please help me understand if you see it differently.
>> 	
>> Doing so would need to come up with alphabetical letters for these events,
>> which seems to be needed for your proposal also? If we use possible flags of:
>>
>> mbm_local_read_bytes a
>> mbm_local_write_bytes b
>>
>> Then mbm_assign_control can be used as:
>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>> <value>
>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>
>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
> 
> That approach would also work, where an MPAM system has events are not
> a reasonable approximation of the generic "total" or "local".
> 
> For now we would probably stick with "total" and "local" anyway though,
> because the MPAM architecture doesn't natively allow the mapping onto
> the memory system topology to be discovered, and the information in
> ACPI / device tree is insufficient to tell us everything we'd need to
> know.  But I guess what counts as "local" in particular will be quite
> hardware and topology dependent even on x86, so perhaps we shouldn't
> worry about having the behaviour match exactly (?)
> 
> Regarding the code letters, my idea was that the event type might be
> configured by a separate file, instead of in mbm_assign_control
> directly, in which case running out of letters wouldn't be a problem.

This work started with individual files for counters but the issue was
raised that this will require a large number of filesystem calls when, for
example, a user wants to move a group of counters associated with the events
of one set of monitoring groups to another set of monitoring groups. This
is for the use case where there are a significant number of monitor groups
for which there are not sufficient counters. With mbm_assign_control this
can be done in a single write and such a monitoring transition can thus
be accomplished more efficiently.

> 
> Alternatively, if we want to be able to expand beyond single letters,
> could we reserve one or more characters for extension purposes?
> 
> If braces are forbidden by the syntax today, could we add support for
> something like the following later on, without breaking anything?
> 
> # echo '//0={foo}{bar};1={bar}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 

Thank you for the suggestion. I think we may need something like this.
Babu, what do you think?

> 
> For now, my main concern would be whether this series prevents that
> sort of thing being added in a backwards compatible way later.
> 
> I don't really see anything that is a blocker.
> 
> What do you think?

I do not fully understand the MPAM counter feature. It almost sounds like
every counter could be configured independently with the expectation to
configure and assign each counter independently to a domain. As I understand
these capabilities match AMD's ABMC feature, but the planned implementation
to support ABMC first configures events per-domain and then assign these
events to counters. hmmm ... but in your example a file like
"mbm_counter0_bytes_type" is global. Could you please elaborate how in
your example writing a single letter to that file will be interpreted?


Reinette

[1] https://lore.kernel.org/lkml/46767ca7-1f1b-48e8-8ce6-be4b00d129f9@intel.com/
[2] https://lore.kernel.org/lkml/CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com/

