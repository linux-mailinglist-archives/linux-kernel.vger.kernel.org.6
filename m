Return-Path: <linux-kernel+bounces-290338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8595526D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FB51F243B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7D1422D8;
	Fri, 16 Aug 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsS+oCP9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F74315D;
	Fri, 16 Aug 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843909; cv=fail; b=c+LSJ8JXvc6Gp8a9JhHVF4JIWmHg2Fug5W1gV8JyCa3qv6jX2mPZmk7HlD5h2ING4OBVpkeebP9wddDH/MUtnl9fm2KqdJnCqcHOb10epyk1RrgveCoMpJxqQVJC6t2MtGfuCk3CCTrbb0jK+8jD8lMHuHOpX4N2BpZlqP31lvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843909; c=relaxed/simple;
	bh=ICFdXO8/YVujphF/lCzHlQ0pYce53hBffYHVZhNeUGc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZENNi2xEZ6wl6zN3OMvkr1dy2+rf6QrJN0NlNc3kjgpnQAHQOnCrb0u4xbxQOJulTre/TwRt65caP9WkR3ML/fV5xbFknzPBu7saYzH8Kk9aL+IOSLcaDPvEz/INI2RXoBACa6hlJ/+0tf8f9lTXY5ep7y9xvNXcrNPkqCcxq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsS+oCP9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843908; x=1755379908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ICFdXO8/YVujphF/lCzHlQ0pYce53hBffYHVZhNeUGc=;
  b=TsS+oCP9NX6dovRfR2SRNlW2xkjaGjAqs99vx+Ju7p++B9Az5b2J+kah
   cIuR5s6stxmmHheQsD3F1YXRxKuIEoPtUYehLK5dMhfOCZo3vMw9sORxV
   l34gCdujZ5MyaJBY5jOpWbvL6f7pl6wcqKAQXyNb/lhlRr5RvGZXe7qmM
   M3bqluzR0iBSVfR4i/1jppom2A6bvYwjdqJcj1n5ECa/vLOZMVkra49Ha
   V3dL51DOISsXIk23MSj+32rPIRzkR4bpVjKOfVMUHxldF7ThN7tRAGdFA
   8ig5WauWYtf5QwpHyBi1zCB8IGDtWY4QPbN4dsSHS1rv15ePJX2vuBZYB
   Q==;
X-CSE-ConnectionGUID: Unc7KAbBSgm5RVmhGsC4CQ==
X-CSE-MsgGUID: GEKjVLWPR+SwbkEw0wOFrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="26020971"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="26020971"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:31:47 -0700
X-CSE-ConnectionGUID: jgx2Jk+zRhWXFPcaE4utDw==
X-CSE-MsgGUID: PbNtX8M5QJ6J6OuDi2UYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64454627"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:31:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:31:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:31:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:31:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k78EFfPwMjltDoiLJWmBU20npWVjeCFpBwOMA7FfkwzYoQsGwjnW9ypdUgp4JKWCmnPsB0nJeih4CJSob1+z0aovLuQ2LwEcbWuVfuRahTz0kobKyiUxbTofcRZ1FbLveBe296TYYAk+u9JO1jlhYEB2S/XgCmmaahdfNFmOGHmUnbpU7YvsbnghIh1DyExyuflUI8tCfOMEJJIK6RfLEbc/oN2As7MxBcipHDen49qDrcPfJ3kksIMRvHvZNmXMoeUKQR4e211XXcLnM9ASwduFYhPgKx8njGynGIi8cQ7QH2GcQtKVca0KbEhow/UYoK+hWGQQWGUIuOB1Oz7TUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9cboqV5OhWvnmS0VYv4aMLfxwpqJk4Euk46653ayWU=;
 b=SSTq8Lgi/1NBBjrgCW1FFa7ms+ee6/jph8JdswJeVhUOKJLpcTHaJemidkemnKmupB36UGYmDiGkNnAGvXImavFxFcSMzYj4V59txaXcrWbWNGWWbZ8k6uq7I8dEm/C4QB2Lwq/FVsuuiu78YN6gtu400XSq+uF48khVsWXuF0G90yPRFqIcw6so4EDNQtii4P53Qn8B9aSwkj8h4JwqYs2Hsvn5AnmiQ4JcjYPIwdE/oLo24FsPkxEOMQS14oQqShQxOxW9iQY7PP38ZBUJ98GQJm4azu4IFc4gQesHqx0az8fif+Xz/4AsKTwLfM3kz6Ywg1AUVLhV/7zfDXJrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 21:31:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:31:32 +0000
Message-ID: <272538ff-0608-4bec-be22-3cb32d3a5ae3@intel.com>
Date: Fri, 16 Aug 2024 14:31:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1722981659.git.babu.moger@amd.com>
 <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QR0P297CA0020.MEXP297.PROD.OUTLOOK.COM
 (2603:10b6:3d0:16::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 67618a70-a7c5-430b-2aa3-08dcbe3acc43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUNKYWJXdjNuQjAyTDRKbkV1Vk5uU3BBYWFlTVdGNjhJWWYxMTFDOGtXS1FV?=
 =?utf-8?B?ZFZnR1ZIeCtscDVMblZhdE1sYVc0T2lxeGRQdzdDRE1LWXZmQjRZOWxJQ1Rt?=
 =?utf-8?B?TGdJMjVuNUt1cFVSY2JuY1FrVWNYeGlzRnRTNUwzSHM3VEVwMUtVZnRldm1E?=
 =?utf-8?B?Qk4rZXRLMmJ0Yk1EVEl1K1VZYXZQbitDMzdMMkthb1FLOFB6Wk0vYkFQR0l6?=
 =?utf-8?B?R3duNGk5dzFXRlhnSmwwdEp1cXFZRlU1anNZcVpMZjREUkxSSUpNSnluekZk?=
 =?utf-8?B?aTY5bXdETWhCUDcvZXRQc0t3MGFQcTBYZjM3UldObGxkNXZvTW5pN1A2T0Fp?=
 =?utf-8?B?Mmd1bjFkWjJ4WkVoWGtkS3lFc0RDMXAzc0pEalA3YkFKYWsrUlBXL2E1WEhE?=
 =?utf-8?B?WTgzQXpqNmpvcmZncTBaRVJjRkVMZit1NUZ6dkY5WlJJMXVlQ2xEN1k3SElY?=
 =?utf-8?B?cncyZFhlYjVkK3R3bHpYcWJUVzZCWS9BejRlSkZGaytTZ2RIMDZwNklnZS9R?=
 =?utf-8?B?eEE3U1pCdWxpMzlrKzNFNEltWCswTDBTZlhpTW9rOWIxSHZ0d3U3YlZKdFlx?=
 =?utf-8?B?UWFkM1g3ZnZFa3FHRkJTNUd1NTI1S0lvRmVZZFNnTzhQMXRkbVZmeTZaMUdV?=
 =?utf-8?B?UVpuV04xL1JpVWRPTGg4MGoyYy9JaE5pK0RyYzQvVEVXZ2pQMkNQTUllSDN4?=
 =?utf-8?B?VVNyUjZUZUJqZVMxd0xqS2pLSjlQbnFnS3RiMTgrK1dIeW5pczN0RXgyb2Ez?=
 =?utf-8?B?eGIwb2t2Yit3L1RTZ2pwcXEzbVl1WTBiOXBRSzUrWVJTNnFzUmYyOENTeVFl?=
 =?utf-8?B?RGUwYis0cEZ2K01WNUlXTmxPS3BaMWZlSXdLY3FzNzNGZ2dFcE12dG1HVHIy?=
 =?utf-8?B?ZUhiRjJtRVRNM3NhZHI0dGprZTJGSFFRZ1Z0N0swdEpaakVYZzdjdU1ibjNH?=
 =?utf-8?B?RUF0c05VUUpxZlV6eVVJcFRjMVFVcEo1UGwrNkFQbjBtQnI1bWVXcUU5ZmJo?=
 =?utf-8?B?T1hZakFSeTErU2IwZWZaWGJBeEFnTlQ0WGNyM3BHa0EySUZ4RUVEV3owTUFO?=
 =?utf-8?B?aTV1U3VIc0ZYK2VTVFJNMk0wYlg1Qks1bkZmQ1gvcTFMN2xXNlVETFFmT2lP?=
 =?utf-8?B?QVpNcTVzZWRiUU44eHUwSjdiQWRTLzloYmIrS0JFUWMzY251K0d0dk80ZjJQ?=
 =?utf-8?B?aTVyTTE4UFhGQSs0c1BOVUM3bUMvdCtnWnlTSGF1aVI5VnIzL3BzRmlRQ0FH?=
 =?utf-8?B?aFl1YlUxWUZDOWk5QXA3NlRRM2QvMzRaUWdNUGZTZFU5SDhRRXc4WSt3YW14?=
 =?utf-8?B?bHhvS0dLRnIxMWFHYWdXUTNvS0t4V0RNYzNuS3B4bGxVR2FZWGVqc2dkV29v?=
 =?utf-8?B?QXp0RTNOSW9Ecm0xcU9lR1FkRFVONHZsT3ZpdmlUWHVvVnRGK2ZTNzV2TkFN?=
 =?utf-8?B?SXB1bHg0cHkrVGFqWmhOclNsbGM3anZXTWtlYUZQMFNnWkZvSnJxT244Tkg3?=
 =?utf-8?B?c2Q0ZE1FcXVvOTJaSThya25nUWFDd2xWd1ZMUHp5aEd1WEpLWU5TZE9ScVJ5?=
 =?utf-8?B?UFRXUGZpcGZjVHh3Y09KSnZXOXdCanRBQTQrU3hoYVhDdXVDend4ckROVm96?=
 =?utf-8?B?RjNzVGc2WG5sUnp2d0Exd3h2Uk0yd0dDQW50MUZtQ0RmYmNpQzVLRXdiMy9s?=
 =?utf-8?B?ZzRnSllTbWhKRjliRWRHWnhpdGRySnF1M1lqREJHRG1wV2tsOUY4Z3M3NXlJ?=
 =?utf-8?B?TEJZckQ0WlNVWTlkRWR0cFpiK2R0bkhyenluR3U4eTVoSFZTZEhvZStJRHph?=
 =?utf-8?Q?7HR6QvpPgJnrpvVeHhIL82slGnzWzJnihQZpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpzMmJkT0xyTWVRQjVBQ3N1aXo1U1FtSXJOMmhXWFZZSHArT3pnVE1leDYx?=
 =?utf-8?B?NGF0MXRpTGpnK1QrYTlRY09QWHo5YytBRjRGc2lMZkVWZytDcG1DbExBZWRt?=
 =?utf-8?B?WlBzZGpmQ3lwVmpESWdoMmw5UFBpam8weHZSSzFBQVhtT0ZVdlZvdDlTazI2?=
 =?utf-8?B?SU1scEdMdWxHYmRuOXdkZ3V2aUpaVmVkdm9XVlpEektvVC9SNG54UUhPbTVm?=
 =?utf-8?B?djF6ekJpRy9oc0t2c2xsdnhXUFZOOVFnNXhkRm5saTFOQk1tbHhsekJrcElk?=
 =?utf-8?B?bzJOK1BjdUtabDRLV2dIV3dnN04vWVJYZXV1V3c1bnNRdWxQREpRNnNNMnh3?=
 =?utf-8?B?QmRSRGNzRHJCbHRRbWFlaTAxenJXRVZPdlp3eDNBZElZL2Y1ME8zR0xlSStp?=
 =?utf-8?B?c0k1RFRoSDJtWDVaaThsSVFuM01rK25XQlNTVjRxd2FtdUlpMkxjZFZKVVBK?=
 =?utf-8?B?RXJEa0ROaVFONjZGYTgvRTJkdTRHaWhwMXlqcXVVU3o0RGVmb1dvUjYxTktN?=
 =?utf-8?B?WUlva0ozcmViclBVcjB6SVR3Tm9IVzgzMlBRd1dpRG10d2Fabkg5SUJJSS9K?=
 =?utf-8?B?bzk3OERIenp4Y291VE43RDFNQllnZUd5NDFrRUNBZXdXNlJNdDRsM2dRYWFJ?=
 =?utf-8?B?Q1VQSlNoMnMzY0gxd25tc0owanVmMEE4bXptU3RlajZ2VDVKWURwbGo0QWg4?=
 =?utf-8?B?eThFMkU5RGRQSFFBZE9IL0gvTCtyOUpLWGRmbmdnWWVmRW5KamdmeGJJYzIx?=
 =?utf-8?B?cXBuVy9WZlQ3aVFmMy9UZERsUnIyRGRmMVVoTUZpNlczOE5sSmxMQlQrQTBl?=
 =?utf-8?B?dWVuUnRmVFo3NkVKTHNqQUhXck5jZmdEMDJmN3FKQUk2dEs2ZWg3NFg5LzM2?=
 =?utf-8?B?d3FvOFhoRTg2NzRYb1RMOEh6QWhkRWsrWDVtLzhvSDJwSGpHZStmRVBaeUlo?=
 =?utf-8?B?elF4NzJLK1gyajlTU2h1S3FWZlQ5a3BlT3NUMFlER0VvdEtHeGx3YzN4Z0JZ?=
 =?utf-8?B?dVZJM3U2YitwSXE5SXB6M0hJTzM1ajJ2S2VCemM1VDFYMENLb0pEUVE3UVVY?=
 =?utf-8?B?V2c2bzlUM1FzMnZIdGtjNFlkRk5QQnJ4dE95Rm1iWkF0VU1hdG5lZ1NWQjFK?=
 =?utf-8?B?UEM2M3ljc2FKb1B5aW8rNkRleGk0WTBuL2dtQnRyNkswcHJmMmR5S0tuQ2FK?=
 =?utf-8?B?cThxbmZ2bVMxK0p3Y3NWdEREWUtvQ0RNZ2Rpb3N1NmlGbHMrVXorOFNNa3ky?=
 =?utf-8?B?N050NlYxWjhLUzM1V01lSm5NQVlMdU5pQTZsZ1ZmdlRod0V6TzJzTHZPOGVX?=
 =?utf-8?B?eWQ2dFlWTzhuWGYzQ2s2QnBza2VjSE9ZcGptOXgzZ2NzSnVmM0lWUTVVblVU?=
 =?utf-8?B?cUtJUFQ4Q1RuSHFzTzFpanlTWFp0UTRMU1piWjlKTGNUQUlhM1Q5Zy9pZWt3?=
 =?utf-8?B?cHVWRk5vVVNiODhPQlZoNEdkWnp4QkZaMEV3b2UraitlQ1BFM1RraUpJVTFk?=
 =?utf-8?B?c0VLdkZKZnpVb0pQWVEzeXhpVDNhS0p3dHdHbHJZYUFjbzA3RGdMQ2lnZ001?=
 =?utf-8?B?SWJXWjQ3eWV2dVBqbm5aNXNLUC9Jbm44MFFhTXZTYUg3VmF5WE1GTDlWM3Vn?=
 =?utf-8?B?T3VBbDBOS2grNlZGS1FyQmRGbVlrVmFGUHZ3YnowdE5HQ0lrOWZmekpKQjZx?=
 =?utf-8?B?TlJTemlUSVFQR3hyT2pTNngyaTVoZ0t5VzA3V241UjhIK2hDZ2tMNnVXNStx?=
 =?utf-8?B?ei9mNFJwUFppL0FETndPd1JvRGEwTzBUMU5Ja1hrc0VHMkNlNXUxZGdxT1JE?=
 =?utf-8?B?dnhkT3drSzcrOHJ1bDc2QzFpRnBKMFRvQXI1NmJJTUFsUGFkVWlMeFBienRz?=
 =?utf-8?B?c2gxYk8vV1UwcUxQUmdkR0ZkaEk3Wm9IWFljNlQyWXdnOFZHdVpaTERXWFp6?=
 =?utf-8?B?bXdQQ2J3dGMxSFZTK2EzYisxd09aY21qVE5KbDJCMDdDNE1vN3pabTNFK1A1?=
 =?utf-8?B?R1RMZXFTRFBYc1orQ3dBUVBCaDM3eFhEYlZzMVlaeHRQU0ZUUExQc0xiZXFG?=
 =?utf-8?B?cWxaUlovRWZtV0lXK3MrSXVGSk1uL1pCaFVJaEtrdXcvMnFTSG03UmVTeVpm?=
 =?utf-8?B?SklkOEFhTHlVRnU4RklFR1VZU1dCR2ZWdzRGNXFuNXBGMEgxUStkZTBueVRw?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67618a70-a7c5-430b-2aa3-08dcbe3acc43
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:31:32.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diwes07pgQUv826+NHMREpGrFwDUAwTdqi7vVhfghau6flIVpfuxIr0mnWddB12d0VUOti8MmCRZc4UWa1S2abEoo+USopkr4auTMlqkFIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed. Reset the

Could you please clarify how this works when ABMC state is changed on
one CPU in a domain vs all (as done in this patch) CPUs of a domain? In this
patch it is clear that all hardware counters are reset and consequently
the architectural state maintained by resctrl is reset also. Later, when
the code is added to handle CPU online I see that ABMC state is changed
on a new online CPU but I do not see matching reset of architectural state.
(more in that patch later)

> architectural state so that reading of hardware counter is not considered

"architectural state" -> "architectural state maintained by resctrl"

> as an overflow in next update.

"so that reading of hardware counter" -> "so that reading of the/a(?)
hardware counter"

> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Renamed abmc_enabled to mbm_cntr_assign_enabled.
>      Used msr_set_bit and msr_clear_bit for msr updates.
>      Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
>      Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().
>      Made _resctrl_abmc_enable to return void.
> 
> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>      Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>      Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>      non-arch code.
>      Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>      Modified commit log to make it clear about AMD ABMC feature.
> 
> v3: No changes.
> 
> v2: Few text changes in commit message.
> ---
>   arch/x86/include/asm/msr-index.h       |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 57 ++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 82c6a4d350e0..d86469bf5d41 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1182,6 +1182,7 @@
>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2bd207624eec..154983a67646 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -56,6 +56,9 @@
>   /* Max event bits supported */
>   #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>   
> +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
> +#define ABMC_ENABLE_BIT			0
> +
>   /**
>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>    *			        aren't marked nohz_full
> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>    * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>    *			Monitoring Event Configuration (BMEC) is supported.
>    * @cdp_enabled:	CDP state of this resource
> + * @mbm_cntr_assign_enabled:	ABMC feature is enabled
>    *
>    * Members of this structure are either private to the architecture
>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>   	unsigned int		mbm_width;
>   	unsigned int		mbm_cfg_mask;
>   	bool			cdp_enabled;
> +	bool			mbm_cntr_assign_enabled;
>   };
>   
>   static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>   
>   void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>   
> +static inline bool resctrl_arch_get_abmc_enabled(void)

This function will be called by resctrl fs code. Please contain the "abmc" naming to the
x86 architecture code and let resctrl fs just refer to it as "mbm_assign"/"mbm_cntr_assign".

> +{
> +	return rdt_resources_all[RDT_RESOURCE_L3].mbm_cntr_assign_enabled;
> +}
> +
> +int resctrl_arch_mbm_cntr_assign_enable(void);
> +void resctrl_arch_mbm_cntr_assign_disable(void);
> +
>   /*
>    * To return the common struct rdt_resource, which is contained in struct
>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.

Reinette

