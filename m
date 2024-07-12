Return-Path: <linux-kernel+bounces-251200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A9930202
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1006228242D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9151C21;
	Fri, 12 Jul 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coWyCm1W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D25A0FE;
	Fri, 12 Jul 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822397; cv=fail; b=bFgWGi1vJ7h072AekXTEwp5Y6wrInv10wjIKgQpBFwkD0XYjS/fCxr9iJC5KMTn3BrByPvUMbfpoq1mkbq/E76USkNoz3EgAFxst47eTh8fltj0k7iBFmQ8gNO67sCaOqIN3Ug1BQHJO5EObkYPS7xiUDyYe+FKIVhcauZA2rhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822397; c=relaxed/simple;
	bh=lzUZwqkJn7oHw4l6mB7Sz8SrVWyQsLVHNLiP+YkzALE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEw58ZsbsVtodaF2LiecrRdEHo2HQMiK/HpXJUkd/oKWS1TZcdbQ7JxhwqVqBUmqi52wrmgs6Mj7EWNlYYYoL6t8UKoY7dd2gKNeJz9NmkPpB2NZBHiFcdAifUquEXrOAnO1aIVohScUftJDXDdJTIG9BJ7ffKlu+TD0zdNJGpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coWyCm1W; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822396; x=1752358396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lzUZwqkJn7oHw4l6mB7Sz8SrVWyQsLVHNLiP+YkzALE=;
  b=coWyCm1W25gKYFXWOE3x1s7B8e/MIwvmandQyi09KnueRDr6ldZZJRkK
   P0dcRd3XVoePhQ3Bvwovjr94ho6jpNQDLthskcqv48r7K3Jz6wwwVZRlq
   /HrKoZhRwZBVtBPBQvrlhzSZA6Wf4pYw0wxotxEihddVXWb0PqQz0A/tl
   4x4iUULY9/mEZvsE6M3rtAYSQleLDKeOE03iiMdDMiikDwTK+wPsFde5U
   JYtSI5JoacFmG5uxBRgacO59+PNrxu/yBNTsnD59Q9zIPJAEXz4p1tB8q
   Mux62S4nExAaW/cTBHcDeDdm4ixj/OmObrHvFQsuLeoaX+e8ad6gl8DPI
   A==;
X-CSE-ConnectionGUID: sRbYJji8TxaeNNBR21ZrHA==
X-CSE-MsgGUID: Tgo4xQLPQX6H3kbSFqqs1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="22097807"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="22097807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:13:15 -0700
X-CSE-ConnectionGUID: RDdgwW0yRoiT6zPVMmrDvA==
X-CSE-MsgGUID: fORP+6V+Romu/SyzeCd3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49144286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:13:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:13:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5ynTxSKoNGHUFSrWWMMjnd4NnlPmBNlPvpj46zPs9TiPqa2CQq+3CKaThA9UlMhH5Rpf1uUF4H10QXEAsobJEx4BVtaKKRi0GfwOIPtBArNJclxw+rzxfPDw3OfmJgsttSKL+4MJpsS9jZC0J3Ct+M+6pEjqygt1yrgdXYYR1rl6tR9ZksHtrNlf2iU7NE59+MwFC0cxa7XVdt8Cu6q+FwZzRdQqq89crZdfYCSh2eSq15BKigPYtGauJCVReoHrZJWDGKCdA+rUHPpAZ8rtTWZAfTMZ0pMHQYhJT2xgQSx6yXHfgwhvYFq3JWhuYcBD6bXdifjYc6lrse8Z3/PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUwIUMF61wsnEdC0QvK5Qo1xWs0kkCDYGm5ryedHFVc=;
 b=rSewhVG2NOJaWhB7uFmPYqtTC0u1iekpPYByfm8OjwLmv6hQTqN6hK2RiDj09SijD+LcReEsqbxCD5mlmSGrMXAL8SCvYJ9kOjrvUG++eNYDewGJLDaKtbNgQEBkc22fOaEtV3QoDmPi7X5WBX9hZqsCbyCNbgGPiTCWaQnedjFFu7CxlMg+55nbFdC23ht2410q6vAvj4+gZqPKfhZR6i4hiXmZXI+0+XHIPl4Fe7udUrbctwSFtPbm71wNSgsZm6jrHA+0VMlbk8jkumeNR9B8k8xex+s12M6Fhi/4Xg7y3wt/UR/jgPbouMsA2c0t41NG6qr2FEUH4YXqUg6V+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 22:13:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:13:11 +0000
Message-ID: <9d0bf9fc-f100-45f4-b266-47786f1b8aa3@intel.com>
Date: Fri, 12 Jul 2024 15:13:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/20] x86/resctrl: Add data structures and definitions
 for ABMC assignment
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <236652202801ad8760d6828ee4d4c6f91d009884.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <236652202801ad8760d6828ee4d4c6f91d009884.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3e605c-1c04-463c-a072-08dca2bfd0fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE9ITUpLOEdLaEc2UUdwdVlNRGFmcmZlQ21wNHQ1Z3NxaEFydWlxc3NoWm1Q?=
 =?utf-8?B?TFM4MmJuOXV4WjJlakZuSXdINWY0a3NrQ0tNdFhJTlkwSXJIQWZXeUxiSDFv?=
 =?utf-8?B?V0h0Ukc3ZTNDdllLUDYvb252V3VpUUtheEphYUdIcU1oVTBuSkcyZm5seUk2?=
 =?utf-8?B?UFdESkpUbk1vc1B0Y2lzd3JpblZiZyt1T0tuejhEZUJOdlVpVkMyM2F5WUtY?=
 =?utf-8?B?MHk4RG95OGhmZVQza3Z2ZGpqenZZQjhzL09uMExFM2l2aUhsWlg2RWkzbC9l?=
 =?utf-8?B?SXl5N3hFcjIvQTlCWTd2d2N3eWNuVTVtQmFqTnQvWk5iQjkrcmh5eVdJOUkr?=
 =?utf-8?B?V2Mwb1c5ODVYcG5MTG94K3oramJYS242QWFoLzU4bmNuK1djZG5QWWhRbUU4?=
 =?utf-8?B?M2FlVzVLU250R2lwVFl6TDMrWkVQUi9xT25nYysrR2RCWUx6UThGN2NNUXpt?=
 =?utf-8?B?QVBEL1AyUHlPelFLeGE4RGNPYWR0VHE5ZEdBWVoxQk1FNDdERm5vUURtU1d2?=
 =?utf-8?B?ZU1BVjYwU2x6S09PSDJGUzRMaWFZcjRoVUlMWWYrVWpmV1pBUmp1TmpaYTFa?=
 =?utf-8?B?cFEyR3NEVk9CMW9DT0lDTmlDMXh3QS9oczNWOE45d0plYm40eUpkT08xaVdn?=
 =?utf-8?B?UEtxUlBncVc1djlkWmhhMkczZ0Z3Y3haamVqWTZmTERwQ1l6MlY1a1M2MFN2?=
 =?utf-8?B?RHJZU1RJRUpZcks1c3hWQVloVEt0ak9EaFhwdCtNMWx5djF4U2l1MktXd21W?=
 =?utf-8?B?S29wbWR6elMwdzdPQ0t3ZXRGN3lsWlhlWEk4STBUU3BzTFdtSURGZVp4M3FF?=
 =?utf-8?B?MVBaNVdYa2NlekVtaHhScTVTVGVCbE0wUHZHcFUwektwODdMbTlpdEVVVXJN?=
 =?utf-8?B?dldXb0tQWXZPWG40SWtESmRkOXJnTzMvTlh0c1FKMUtYd2VMczVTQ1dSSzRE?=
 =?utf-8?B?RVVGamZESE1ZYzBDWDRQcFo1TGpXRWd5SjJxTzVxdE5iNTRFZ3BobGl3SXRr?=
 =?utf-8?B?aXhFR1Y4MXd6YVZsa0V6MGZkNm9ZR1FiN2xySTFObUwvZTNSanFBbEhjZ3ln?=
 =?utf-8?B?bEpvTW1uNTZwTitZQ3pCeFdIclpmWmxRZzFXVjV3bHA5elZ2VnRhSUp5S1My?=
 =?utf-8?B?Zy9jYVprL2YvZnE1Szk3TTc5WnBVa1Rzb0dPaHJHa2RuNlFxUzNqMUNWK21u?=
 =?utf-8?B?UmxZQmZqKzdwUVdMdktIYVJmRkZXYjdSendTeG9IZklYbWowOE92L1V2dHFp?=
 =?utf-8?B?b2xTM0toYmI2Njl1b25td1kyb3NWaUIrbStLNWo1TUYrZnNxaEwrZzh4YUFH?=
 =?utf-8?B?ZG1raDl4MXk2dVJSSFM3MkgwVk82eUFOWWFGd3NWcXlyMFo2dXZuN283RElX?=
 =?utf-8?B?QVhBQzZuMjY5cXdka0pHSzhVekFaTlIvZzBHQ21KTG1wVEZQa2owTWFadXh4?=
 =?utf-8?B?dXl4SXRxb3I2MDFLWjN1dW10aFdnbmhuNThaaHMzUW0xbVRWY1FIVmVYSGJH?=
 =?utf-8?B?Q05KaDExNk52UFNvSUlOMkFpcTNiRVR0K0pVUjAwQzdCT0tiRkJBNmpvVEp5?=
 =?utf-8?B?ZjVZak9GSFJVQTJsUHdHRjBaRGE0eXR0RjAvYVJteVRYYVdoVG1EbnUyWTRC?=
 =?utf-8?B?NGs1a253WS9oRVlMS3NDenI5ZTkxWDRyQXJiOFJkb1UvcE9tNnFMR0M2bllD?=
 =?utf-8?B?NXpkd1ZtcXQzL09CSFo0OG04MWVMcklLZzRCd1Bxei9lcDNHV1BHRHFlOUR2?=
 =?utf-8?Q?xQG7gRpSGJJz5EtAcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RlR3FiZS9Vc3Y0TTFOdy8wL1IvUmJBY05XT0R3RmFWUmJadDhxTjZ3Si9s?=
 =?utf-8?B?UjQ5ZHVNanR0K051Vy9TN0VuYkNyeis3eWI2NlFYa2Rmbi9kM1Z5UUNkMnRD?=
 =?utf-8?B?QXZrM1NBRE1aclFJQi9sUW0zNThkaEN1TzdFdzh2NFpxYzE5QVhFM3lINlp3?=
 =?utf-8?B?YnlRcXJpT3QyMTEzVmVEQ3M1Qk1KNkJzd3pBRFJPYUVsN1BPbVRUenRVMmd5?=
 =?utf-8?B?ZlJiR21tR21JQVZ1U2pmNVI1a0dZMFVBV3JPU1JxaXlaR25JUVlJU090KzBp?=
 =?utf-8?B?dVMxeWJWeVpFTW05bjhDbWUyYThTUHJQUVRnbEMrWFkxL0I1NGlLdjZaOERF?=
 =?utf-8?B?MGM5M0gzdCtCbExmd053N1U5dzF5SFIzNlZ3czM2QzJKUTJXU0s5cHBSb1VH?=
 =?utf-8?B?VU5xZ1RMOGI0NnRjTHZncm1CczZVTWRNQXZzbnIwc2Jwb2I0aGdUQ1ltcGV6?=
 =?utf-8?B?YkZySEFSZWM0U3JxSi9laWkrL0hGSDN4dmhvc2NDSUNmM09EaGtuVTZWekVi?=
 =?utf-8?B?Y010NUkwNmpDd05iNFcyb0JKaVdwZktpZ1RLaVVHeGdoUU1pWm1UdUhmVzA2?=
 =?utf-8?B?TXBXTW5Rb0R6T3hUZVNzbVFselhmclFNMU0vK3d0UFNiSUIydFBueUpJbnNo?=
 =?utf-8?B?NlZ1RG1CeEJsSHJMNkxiS0R2ZG91UmtHeHdzSzdZV2p2a0kvcnJhdzFhZFRD?=
 =?utf-8?B?R3Rzd0dxNjlsUjM2RUVod1MvZktqR2hrcmJGMklwWFVHQlRpaGMwYVhXV2U1?=
 =?utf-8?B?RUNla3lES2F3RUhhaWN3My8ySUhMUVVvdnJnYThrYVV5RHh4VnFvTCtWSW1s?=
 =?utf-8?B?d2JZS041KzVUTHkxYURid09jdWZwdTRNeUMwdW42NjBYTmowQ0l1WU1OQW9Z?=
 =?utf-8?B?RHNDeU9lcVlnYUVtTDNXYVMxOVVsWlJTelpqRTNpS2UzVTUyK2VUUjBEY0dn?=
 =?utf-8?B?VmQ0djlUVXJFYUExcGp1VXZWWGtRVGQ5Z3VCZnZVWk5hRGZoaFhNYkgxUFNw?=
 =?utf-8?B?YzNQOTE3dmIzSGxIM3h6cE9OaVJ2dG9wRGd6Zi9QMldEWTdmTlhVVUIwTEo4?=
 =?utf-8?B?VVRsLzB5TmRoaVg0ZFozN2NEaVNsb3F5OURXOTEvSHNRZ1NybzBnVUUxdjFu?=
 =?utf-8?B?eFN2elpDY0ZIc2xRMUNwRjB4Wnh1Q0ptWUlmdlNmU0daZmNId2dNY2tvSkJC?=
 =?utf-8?B?Q0h2KzVrMlFqSEFGbWVZcnB4eWYrSVMrYm9WRVY2QkxWSWNkTzdWMktNa01M?=
 =?utf-8?B?UzVsWkkrTzRzdzhNc2lacG80Yi81c25WRG50N21rOC84UmZYU2RNVzI3OFd1?=
 =?utf-8?B?N3Yzb1NaYVc1R1IrVUtIRzNHdEV6WStWMWFLZnFQWFF2aXNMKzQ1dFpVbDNi?=
 =?utf-8?B?Qnk2ODZ4eDBoM1QrWW1WVmRJYURWUlY2UjEyUTI3REM4UUlua3htQ3FqeU9m?=
 =?utf-8?B?QnhIRzB5VjJOMGNBWDdCOFFJZ0VHc0VXZlpxbTVRc2xoYzVKY01LSks3Unlr?=
 =?utf-8?B?eERqSnBqOXB1cTZkQURURnNKQ2I2OGs3RVEyV2J4enhRdTlNMFgyeHZvQk4y?=
 =?utf-8?B?cWRMeS9CLzhzOWlVOS8zanZlT3JFK0Q2Q1pxOXNzWE12dVpCM2ZuMGJzZFE2?=
 =?utf-8?B?VHJXSG1qOFkvTEdWNjNhcnJyUjYvd3FKRUlDSll4SlIvNUw4cFBrV2ZnK3VP?=
 =?utf-8?B?cFo1Z1R6RmNxQ1lqb3ZOdG0zdFMzVWxDeE45Q3o4VkxHeWJicWRocGc5RUh6?=
 =?utf-8?B?OGcwdjhqVENlbjltYU5zR2xTYjRMN2FtUFdRQlF0ajhuOVByNnVwb3FKQW92?=
 =?utf-8?B?dVlLQlNGdEQ2WlBTNVBuMUdJMlJobkZOa2RCTC9UckFtNlRpVnRia2RSWWVC?=
 =?utf-8?B?RUY3TkhtV2ZjRzJ2T1Nxb0U1WU1rK0xNdWg4Zzl0SGQwZkdLRnY0UWtvdmFv?=
 =?utf-8?B?MnRneVAxVjR2V2ZLdlNuMHJZQjZtdEJtTFdkbXJiV2lCQ1Q2aUd2Zjh4SWds?=
 =?utf-8?B?T2dxMlRFMnlQUHJsK1djSWoxbmJCYWJxWWhBb2lMSzlROXBxOFY4ZW9sTGJt?=
 =?utf-8?B?dTFmRUY0ZkF4TSt6ZmJOcUptVWNvUVZYWkhqYTJnUktlblFob2FJb2t1RWhz?=
 =?utf-8?B?b0pSbnE1V0psMEFjQVN3RVIxcjRFRmdjMDV3cGhjRk5wTjV0WEcxMGVDS25K?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e605c-1c04-463c-a072-08dca2bfd0fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:13:10.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nbZUH155u1iW0FyE/UkB7Xh1Mee8jRaAFCUWkiNlA2YK3j0TThXjQCRuwAE9wkoYTBSKm1MqKyRXd/ymNvSuBc3Mn5H2F/q94tKg8KrOHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as the counter
> is assigned. The bandwidth events will be tracked by the hardware until
> the user changes the configuration. Each resctrl group can configure
> maximum two counters, one for total event and one for local event.
> 
> The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
> Configuration is done by setting the counter id, bandwidth source (RMID)
> and bandwidth configuration supported by BMEC(Bandwidth Monitoring Event
> Configuration). Reading L3_QOS_ABMC_DSC returns the configuration of the
> counter id specified in L3_QOS_ABMC_CFG.
> 
> Attempts to read or write these MSRs when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> Introduce data structures and definitions for ABMC assignments.
> 
> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
> details.
> =========================================================================
> Bits 	Mnemonic	Description			Access Reset
> 							Type   Value
> =========================================================================
> 63 	CfgEn 		Configuration Enable 		R/W 	0
> 
> 62 	CtrEn 		Enable/disable Tracking		R/W 	0
> 
> 61:53 	– 		Reserved 			MBZ 	0
> 
> 52:48 	CtrID 		Counter Identifier		R/W	0
> 
> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
> 			(not an RMID)
> 
> 46:44 	–		Reserved			MBZ	0
> 
> 43:32	BwSrc		Bandwidth Source		R/W	0
> 			(RMID or CLOSID)
> 
> 31:0	BwType		Bandwidth configuration		R/W	0
> 			to track for this counter
> ==========================================================================
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).

The changelog only describes the hardware interface yet the patch contains
part hardware interface part new driver support for hardware interface.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v5: Moved assignment flags here (path 10/19 of v4).
>      Added MON_CNTR_UNSET definition to initialize cntr_id's.
>      More details in commit log.
>      Renamed few fields in l3_qos_abmc_cfg for readability.
> 
> v4: Added more descriptions.
>      Changed the name abmc_ctr_id to ctr_id.
>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
> 
> v3: No changes.
> 
> v2: No changes.
> ---
>   arch/x86/include/asm/msr-index.h       |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h | 40 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++
>   3 files changed, 60 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 263b2d9d00ed..5e44ff91f459 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1175,6 +1175,8 @@
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>   #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
> +#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 4cb1a5d014a3..6925c947682d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -100,6 +100,18 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>   /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
>   #define ABMC_ENABLE			BIT(0)
>   
> +/*
> + * Assignment flags for ABMC feature
> + */
> +#define ASSIGN_NONE	0
> +#define ASSIGN_TOTAL	BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
> +#define ASSIGN_LOCAL	BIT(QOS_L3_MBM_LOCAL_EVENT_ID)

These flags do not appear to be part of hardware interface and there
is no explanation for what they mean or how they will be used. They are
also not used in this patch. It is thus not possible to understand if
they belong in this patch or is appropriate in this work.

> +
> +#define MON_CNTR_UNSET	U32_MAX
> +
> +/* Maximum assignable counters per resctrl group */
> +#define MAX_CNTRS	2
> +
>   struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;
> @@ -228,12 +240,14 @@ enum rdtgrp_mode {
>    * @parent:			parent rdtgrp
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
> + * @cntr_id:			ABMC counter ids assigned to this group

struct mongroup is private to resctrl fs so it cannot contain an
architecture specific feature. Having it contain a generic "cntr_id"
may be ok at this point, but it should not be termed "ABMC counter".

>    */
>   struct mongroup {
>   	struct kernfs_node	*mon_data_kn;
>   	struct rdtgroup		*parent;
>   	struct list_head	crdtgrp_list;
>   	u32			rmid;
> +	u32			cntr_id[MAX_CNTRS];

This is a significant addition yet is silently included as part of a patch
that just introduces hardware interface. This is how resctrl will manage
the hardware counters. It is significant since this is what dictates that it
is resctrl fs that will manage the counters, which makes it important which
interfaces are made available and from where it is called. Through
this series I have also not come across a description of this architecture.
With this introduction counters are maintained per monitor group, yet
the new interface supports assigining counters per domain. There
is no high level explanation of this architecture and the reader is forced
to decipher it from the implementation making this work harder to review
that necessary.

Would it be possible to present the fs and architecture code
separately? I think doing so will make it easier to understand.

>   };
>   
>   /**
> @@ -607,6 +621,32 @@ union cpuid_0x10_x_edx {
>   	unsigned int full;
>   };
>   
> +/*
> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
> + * @bw_type		: Bandwidth configuration(supported by BMEC)
> + *			  to track this counter id.

Does "to track this counter id" mean "tracked by @cntr_id"?

> + * @bw_src		: Bandwidth Source (RMID or CLOSID).

Please do not capitalize words mid sentence, like "Source"
above, "Identifier", and "Enable" in two instances below.

> + * @reserved1		: Reserved.
> + * @is_clos		: BwSrc field is a CLOSID (not an RMID).

Just stick to @bw_src.

> + * @cntr_id		: Counter Identifier.
> + * @reserved		: Reserved.
> + * @cntr_en		: Tracking Enable bit.

Can this be more detailed about what happens when this bit is set/clear?

> + * @cfg_en		: Configuration Enable bit.

What is difference between "configuration enable" and "tracking enable"?
What is relationship, if any, to @bw_type that is the bandwidth configuration?

> + */
> +union l3_qos_abmc_cfg {
> +	struct {
> +		unsigned long	bw_type	:32,
> +				bw_src	:12,
> +				reserved1: 3,
> +				is_clos	: 1,
> +				cntr_id	: 5,
> +				reserved : 9,
> +				cntr_en	: 1,
> +				cfg_en	: 1;
> +	} split;

Please check the spacing in this data structure. Tabs are used inconsistently
and the members are not lining up either.

> +	unsigned long full;
> +};
> +
>   void rdt_last_cmd_clear(void);
>   void rdt_last_cmd_puts(const char *s);
>   __printf(1, 2)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 91c5d45ac367..d2663f1345b7 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2505,6 +2505,7 @@ static void resctrl_abmc_set_one_amd(void *arg)
>   
>   static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>   {
> +	struct rdtgroup *prgrp, *crgrp;
>   	struct rdt_mon_domain *d;
>   
>   	/*
> @@ -2513,6 +2514,17 @@ static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>   	 */
>   	mbm_cntrs_init();
>   
> +	/* Reset the cntr_id's for all the monitor groups */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		}
> +	}
> +

No. The counters are in the monitor group that is a structure that is private
to the fs. The architecture code should not be accessing it. This should only be
done by fs code.

>   	/*
>   	 * Hardware counters will reset after switching the monitor mode.
>   	 * Reset the architectural state so that reading of hardware
> @@ -3573,6 +3585,8 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>   		return ret;
>   	}
>   	rdtgrp->mon.rmid = ret;
> +	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>   
>   	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
>   	if (ret) {
> @@ -4128,6 +4142,10 @@ static void __init rdtgroup_setup_default(void)
>   	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
>   	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
>   	rdtgroup_default.type = RDTCTRL_GROUP;
> +
> +	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
> +	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
> +
>   	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>   
>   	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);

Reinette

