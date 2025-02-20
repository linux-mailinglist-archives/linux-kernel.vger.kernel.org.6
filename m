Return-Path: <linux-kernel+bounces-524506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C3A3E3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8062B19C2CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DAA2135CE;
	Thu, 20 Feb 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYxMaDGd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970691B6CE0;
	Thu, 20 Feb 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076273; cv=fail; b=jVWlZpBf/1urq2LzgFhPYbgmclOK2le2nHpnpUJ/cSdNJ6gSeRso1q5FORJ/TvLFG4t0rew+d6b3T1s5OSSsV1i3ppyNc6n/AN5deqB1Ql/8DibOFBvIj02Qk9bcOuKh8gDw0fKGbg3Sp4IEOZ3IWxImNsa7Wyjl/bObRESNbLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076273; c=relaxed/simple;
	bh=LECe3S1IaCggzaacJbLWITXPuc8RKNpruyUkgL/8FMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWJ9x/7rTWUyeqmMkYv6Y0kr6tjXV4PiOEzYL0hJeFuNBeCKy4og2W09TtuGylsNu6ZQ+3seoKuJrx08YFb1R9JY52SHLDKpX3Ea4qHFhtlyAZ/0fuPf6iTkALct47d2i1Tjodn+wJo43N/vowHwxGthU6GlUcUYz5kq+kYolfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYxMaDGd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740076272; x=1771612272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LECe3S1IaCggzaacJbLWITXPuc8RKNpruyUkgL/8FMQ=;
  b=SYxMaDGd2NfIcrzVM+nTCjr36FlroTu8p+pmHJxqlN/IOz9TTA/qpzX4
   KUW6Ta7HaL2yv6FLgw5eYCU+iPuz4K0y30WfThXKArENiDKUfuhLJQ0Uy
   LAYobjKw2r2Uqb6F1SbknIzUbR71NFHeNqfs7SFYIhq4l2y7Azm4Hs3/j
   iwVQqCtGIfZ4cwqjZ45LeXbDvQYRTP2/EdZd9YTGk6Pk3ru8DrE/Jlq5R
   ZkD4MCMLfbuMr8vNsM1k/EIhc0hyn9EaxZXQfKXCbu7yuW7U/S8Tv4Hjk
   v8HeGcebxTlQxmBrFWKpSJLECRHp6OBQ4SxSxqZpN+ocJ/dSyFw65F11C
   w==;
X-CSE-ConnectionGUID: i+rTUYErSIGcvn9GmgZabQ==
X-CSE-MsgGUID: f19XEsjcT0aT2x/P934WCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40884090"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40884090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:31:11 -0800
X-CSE-ConnectionGUID: DM/am8tyQyGztKZACwpGJA==
X-CSE-MsgGUID: lexDC3X8QICyvfWPkz8s9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115331390"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 10:31:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 10:31:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 10:31:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 10:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUCs5ZgoURCNDTMnI7lfJA+dgi7dpTnaw9Alc13mpOonfpKP0alp8qlO9Hb3f4YxFJRT1OSh++YWN6OvuluzOHo5DIvO4n9T3mF51foVjNZ/9P2BzHT+7/v9AqMQwXX7mn7k8e7mtLxpsMn0O0/5L3uISDep3HxBByGItKADIfmFL2gNMFlGW2/zreJyS28XRUYPv2gBxiPgkXzj3tKYPbqyzQ0OY1GB01vjDifd2dtwhI0KrlRHn2WYIxS+7ukZeaL0/nU7Xb+FHe+hQSMot7eOL59e2SOx/yOhLldVAup5AY8ZVCno9/w4HL6WcQzElVTzgcDDEyPIm+GMz5yskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po3P2mCaAXDWHwH35O4CU3pDKYpKBrElqbzaHNkhTKs=;
 b=q/84km3eqBTEYusl78MaIf6tF3oO5BIJfqFXA37tDqdIhxF5H9bMy5SKjw79ZJaSOeIlC+NmFs5X8Wqo0PzRWn49tXfqjkKmsdLTOebAyS9ureNQsPhzCeghcwwDevKra1XHlGK/DTPsOh5SccIx2swGTMowqaSges1Uu6iNTDcO2AEW5R1GPRY8R3iUqHxojBfECnp1lV4bGHD6Tkd2y/hR031wmxIf7U23HreU0WLzZxVvBY7htXKcOoIYqlD1PE9M1XSkwk9aY1XZzMTNd71YWrSPI9PUeln0l5bt111q5y839BM6Oh5fyLoDrjetmLVbtUyFvbXrtBbXJfVu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:31:00 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 18:31:00 +0000
Date: Thu, 20 Feb 2025 12:30:56 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>, Zhang Rui
	<rui.zhang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Ulisses Furquim <ulisses.furquim@intel.com>,
	<intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] perf/x86/rapl: Fix PP1 event for Intel Meteor/Lunar Lake
Message-ID: <5d3plvwvpej6eccdv2325p5r3nawcjr5jv6wsghcyjw4aujwml@4yh5mdu5szda>
References: <20250220153857.2593704-6-lucas.demarchi@intel.com>
 <7de719b4-1e5c-42ee-80fc-0563b68299ef@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <7de719b4-1e5c-42ee-80fc-0563b68299ef@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e40516-10c6-4c08-d338-08dd51dcb923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hYEe7T8zA83lxCzeuMQBDlPnXCyuP7sKryhwo0HqkYjZo+Qlvrqw13XD+Fli?=
 =?us-ascii?Q?XT1umSZ2Bl28PTJ2QfMJMXWQtvFouEan6yHjeapRaN2g0lUGyE95h0dBuJRN?=
 =?us-ascii?Q?9rxxhbLH0C7OeaCEx2ROkwrwlOqHhsts2dlMPi02zBMGYKRUrkETm1VxD6Ok?=
 =?us-ascii?Q?TflteBn3DEoiQYBB5TH1QIHaT3eZEx9GA+FgBl3sVBmp9ivxUJZXaDJqjmvb?=
 =?us-ascii?Q?hQbGbb9vjPEuF0oYvy7dHXnhFpAdhQsoZP73+aFa2eOsfHU3R1B5ANWyG8qm?=
 =?us-ascii?Q?SBJNMsWzCjlLcKPOT+Q2ZG7fvL+5ZTpF636XclASVS4DG/KvK1l90VSPSZuF?=
 =?us-ascii?Q?dmDFb/h0AXSJxJloDZMtnOFK40nT51q6MQ19TNiooeJLAWlJjW3XyTzLNDW7?=
 =?us-ascii?Q?B0xIuGFA2Jc65qtO/Uvm60Q0eMMaB/frOO+XVbARytmr9GO3gZfyg5kn7SuQ?=
 =?us-ascii?Q?+AEwJ+2UFRzUPHE8E+krmNcMciZbw1w+y2VYM711CbaP4fB8OEIHZwAycOfk?=
 =?us-ascii?Q?0bldQGxNs1wNHbNe94onqmoUqAfhVtGqKCuseeVmSyORsvZUdmq7c+g03frP?=
 =?us-ascii?Q?Vs6rB2jxpF9iec2bEUOziFOJCF9XUycKtlgVyEnEvnL4TzaMCkNq2UrqA+Ff?=
 =?us-ascii?Q?Nk9JIfb/BAWKB4Qw6O4U6ZSLgalJxR2tPqBhavjj1KknvhOiua0KOkuCIuRh?=
 =?us-ascii?Q?CHxvE4c6emtqN+xyttcFsZQBUSimPAlAzBMyq4l6n4d0Qknm+7hxW1Qu7u3l?=
 =?us-ascii?Q?hg+YFXzm0Hdp94Q2qMdVFF96Qj8ZL471ledhcOibzX4Y10pn02flksfroiWp?=
 =?us-ascii?Q?kQSn9SY5rRPwrE3cWx95rfVB8dfBlb1guZn2q8F+ctQ4Gm+YIyvy3QJ64/cx?=
 =?us-ascii?Q?GNno4pPAhFDJD4ef+vA5kPxIY+rJ9djJWm8rhG7LilAyG5/7882mmvTNcLcJ?=
 =?us-ascii?Q?pX1UTp9AaL32GJRnicw2HBsVc4kBWYYx3ahc8RpV9e25Y4t1JPfCBzRVAnfF?=
 =?us-ascii?Q?/JNewdcPR7kJVlF31qH/ysKc7jZIhxr3K122/d1FOMqO/AEIEagGan1VDd7y?=
 =?us-ascii?Q?VQeumpNsSM0dQGLcREkDRRReoTB7d0K8OAISovezkpKUXXPA0biT2stjq2dI?=
 =?us-ascii?Q?yIRrnkbdZWxVMtgC0XL6++Z3RvumXXfJZtkjLtUGqcXh4eQMQXxxjKkABb/d?=
 =?us-ascii?Q?8kJ7sXHuS1GFukUqrnRL2pdXBErmkAReuBzXISjaD2SO3qsRQ7lZU0hZJ9gS?=
 =?us-ascii?Q?NFwdJipubCmZu1gZUkk9JGb1J5aOv5vr6wOTtxBo4DHbzSFgm/4Wq1N4QS9c?=
 =?us-ascii?Q?xPiz0jCj55DmYOC/W+LqF+4x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j122zo8S+RkPyKNJh8SX3+ngfu1Pg3ZWJEUY9HOK8do3g3d6VWI7a7wdcgBx?=
 =?us-ascii?Q?6xSaZXlYmts8AuKTlo6ew7cem9PME3q+t7Pk/t5Ke15hHwbdcnPgt1eo54CC?=
 =?us-ascii?Q?Fb8sMjgbc1+TXDGX9eifdvffhNn4e40TljSaIx540d2zwxK4tt3ADzLKt0ob?=
 =?us-ascii?Q?6sIHMz4zHT0om3sUT9Blg04AN35LUe3K2Rrm8YdYsqZ2hOJXvj3KpywMQUIK?=
 =?us-ascii?Q?KzDyaM5MglZe5PRMKZL9MJlbIgFISRRNaoa2OlFUoXFjEpUuZZBNhrJiSeVQ?=
 =?us-ascii?Q?+JFIz+Bf+LV1ukXaJ1kvBAXsu4YjZdrYDtHfqaQSOZjy+FlXz+WAdCGcm351?=
 =?us-ascii?Q?Jo3QW7q/Iy+LTnfYpHLiRKO2rRYzhFUkuvJuS3DAgzMrTsEcVdryxhCN6FAA?=
 =?us-ascii?Q?RdCbD7vIfoPUfZT/pWHDL3ikWuMRlTCv01qabwAf1dSgh4um1XmOrZ5AOvN/?=
 =?us-ascii?Q?hT4uCQ/5+3qdzNU7GUhsbrS07ki/Z8WOlTH9vsYsAIYO9VFEUEsexBhPnqUW?=
 =?us-ascii?Q?dNvq5+7DN05YFUIqzmc/72EkY++sprMuWRQihGERIl5J6Hxy7kc0JSzOxFkD?=
 =?us-ascii?Q?jOtJN+TKIp5XU3U/DX1K44SFWCmMDx0Gm0iSrKmihQC9dfABCo6uL+PcMXLJ?=
 =?us-ascii?Q?8VZ1rXYmiGQBUWOQi/29ioHOGh7pgcQzP8W2HCV51r2UUnw0TOm/EutVQI4t?=
 =?us-ascii?Q?vORNyG8RcKpWMDF+kR2ohJ9VR5PW88c9Z0t48mwzdj4E7KaHoIo6yt79copc?=
 =?us-ascii?Q?MgraBXEj4vh82iAwG1Suv0aTojohz+PBx3YFzY70yOfpTEoU4E1CnCYSTPEG?=
 =?us-ascii?Q?6CPe5TC4rz5vA5Ugm5jcSDU7o1AiSrnm8P1bDtQ03Dp/5lQ/QZpCwJNrp3mG?=
 =?us-ascii?Q?XorzqRMt+Hy5Tm1vbHawIfs0b91JsDz+Gl3K7yaVESSv9BZAo1sY/9VijkV0?=
 =?us-ascii?Q?gciKmKFbFbLbICMANe+3wHjO26EnrqB3JD0abypBxUX1n0FOavzCUx33NFFV?=
 =?us-ascii?Q?vwBDWoQJ4tZFBssc3wYXIEN0efLR/EtwZxMSiaTgfkw1gFKJxA6ulXwj5JqN?=
 =?us-ascii?Q?v/qL5NMwPcO92KzAL8cY0GJVryDrgIm3JryK2mj67D/VXYY+4RtPtwAAdE2L?=
 =?us-ascii?Q?aeXZJKXrCdKofTf59U8Z/W+uC+qDNN4IgB6YuptGeAh+mPdqMOBum7mCUYAa?=
 =?us-ascii?Q?bc1MpQPnEPh06kYOBY8Z+7KHZ+wpoNyxuVQpEs0gaQko1tsQ8ZMAanQHyVWr?=
 =?us-ascii?Q?9BPYULprWoMcjFh+Y4AVY1ANvzzfFDAh0ULLInJ2eScVJ4Pmzf9GZT4Qf1/7?=
 =?us-ascii?Q?QTCq3bfHzZ6g80mscXjz6iLRhue4AP17iH5ZPqz8mRJAKdv3UBes6j1fh4k7?=
 =?us-ascii?Q?Js5DWajeFPOr1nHWi3cN7q+DriaUOaEdHz1NilGrvbeiESNy1/PFe5Ir188R?=
 =?us-ascii?Q?T6oHsV13jrCJcALqVoIUhSZatDXN8c8Evfv3sIUs+EFSdu7o/o/9g6LunuP/?=
 =?us-ascii?Q?lF+aiX3gVL6eWwATa1jn2nYI/hhHUPN/NFVNnWOBfH89cZK5IPAp2hsAWT+P?=
 =?us-ascii?Q?v/Mmf+TMa0yd/6HYHDV1l66lyBhf4QNL3hHM0AVmJyi5N9e6bokqBwf9ZBqr?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e40516-10c6-4c08-d338-08dd51dcb923
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:31:00.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toDRe5DRm2L/KM7gyaSA5S9t9hf5WQeuAS7ruHo/mUXAKt8DR+HiET64GAK3YbbaFlvHTVjtsKu9zuPchzs25IkTG9rjU92/tRo+PqQiXRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

On Thu, Feb 20, 2025 at 11:47:21AM -0500, Liang, Kan wrote:
>
>
>On 2025-02-20 10:36 a.m., Lucas De Marchi wrote:
>> On some boots the read of MSR_PP1_ENERGY_STATUS msr returns 0, causing
>> perf_msr_probe() to make the power/events/energy-gpu event non-visible.
>> When that happens, the msr always read 0 until the graphics module (i915
>> for Meteor Lake, xe for Lunar Lake) is loaded. Then it starts returning
>> something different and re-loading the rapl module "fixes" it.
>>
>> This is tested on the following platforms with the fail rates before
>> this patch:
>>
>> 	Alder Lake S	0/20
>> 	Arrow Lake H	0/20
>> 	Lunar Lake M	8/20
>> 	Meteor Lake U	6/20
>> 	Raptor Lake P	4/20
>> 	Raptor Lake S	0/20
>>
>> For those platforms failing, use a separate msr list with .no_check
>> set so it doesn't check the runtime value to create the event - it will
>> just return 0 until the i915/xe module initializes the GPU.
>>
>> The issue https://github.com/ulissesf/qmassa/issues/4 is workarounded by
>> reading the MSR directly since it works after xe is loaded, but the
>> issue with not having the perf event is still there.
>>
>> Closes: https://github.com/ulissesf/qmassa/issues/4
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4241
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com
>> ---
>>
>> Maybe a clearer alternative is to just move all the platforms after
>> RAPTORLAKE with a gpu to use the new msr list.
>>
>>  arch/x86/events/rapl.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 4952faf03e82d..18e324b8fa82c 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -588,6 +588,14 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>>  	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
>>  };
>>
>> +static struct perf_msr intel_rapl_mtl_msrs[] = {
>> +	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
>> +	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
>> +	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
>> +	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, true,  RAPL_MSR_MASK },
>> +	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
>> +};
>> +
>>  /*
>>   * Force to PERF_RAPL_PKG_EVENTS_MAX size due to:
>>   * - perf_msr_probe(PERF_RAPL_PKG_EVENTS_MAX)
>> @@ -826,6 +834,16 @@ static struct rapl_model model_spr = {
>>  	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
>>  };
>>
>> +static struct rapl_model model_rpl = {
>> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>> +			  BIT(PERF_RAPL_PKG) |
>> +			  BIT(PERF_RAPL_RAM) |
>> +			  BIT(PERF_RAPL_PP1) |
>> +			  BIT(PERF_RAPL_PSYS),
>> +	.msr_power_unit = MSR_RAPL_POWER_UNIT,
>> +	.rapl_pkg_msrs  = intel_rapl_mtl_msrs,
>
>It's better to make the name consistent, e.g., intel_rapl_rpl_msrs.

that's what happens when you decide to test on RPL just before sending
and forget to rename all the variables. Thanks for noticing.

I will rename it on next version if we decide to keep this approach.
Also please let me know what you think about moving arl and other rpl to
model_rpl, too.

thanks
Lucas De Marchi

>
>Thanks,
>Kan
>> +};
>> +
>>  static struct rapl_model model_amd_hygon = {
>>  	.pkg_events	= BIT(PERF_RAPL_PKG),
>>  	.core_events	= BIT(PERF_RAPL_CORE),
>> @@ -873,13 +891,13 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
>>  	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&model_spr),
>>  	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&model_spr),
>>  	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&model_skl),
>> -	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&model_skl),
>> +	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&model_rpl),
>>  	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&model_skl),
>> -	X86_MATCH_VFM(INTEL_METEORLAKE,		&model_skl),
>> -	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
>> +	X86_MATCH_VFM(INTEL_METEORLAKE,		&model_rpl),
>> +	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_rpl),
>>  	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
>>  	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
>> -	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
>> +	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_rpl),
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
>

