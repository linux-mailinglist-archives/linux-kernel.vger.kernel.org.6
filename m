Return-Path: <linux-kernel+bounces-560383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7BA6035C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1954E19C40A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E57C126C1E;
	Thu, 13 Mar 2025 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJQkpaZ4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952531E8326;
	Thu, 13 Mar 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900936; cv=fail; b=PKCuiuMbBhoU85B8b19AmMcOO7SGAZU2Eh1kR2A6YI8iVxa6iuz9/JMWd5KST4VGkUL5NnZH3O7S/TiMNTk0VjM+1/QrM+2drA27IxkicaxBfCvtqen7ra6iUyBJM9N1jhWvpk07XkO/3egQDuVxC4pXr+1U8g/mm7ZD7MEvsOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900936; c=relaxed/simple;
	bh=Eu9ilEYDcrC7aYpJKzTf+x4NPBKu4rz2xHRPkoynSaQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHIExU7OyXz5c2U2DJZQMa2WrP4my2bePVj0w1k+vVK7MmzFvoCKV3KdHUQMLBkZkvx0s8KyklDQO2nsdmGvGxth3JkMrB6mv9gGRbQUJ0HEXNhnOYagjebYqVx96uJgASO+Amwx9dcdzcl5TOmGhJ3eLoyMHly0QO76h4w6ovg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJQkpaZ4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741900935; x=1773436935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eu9ilEYDcrC7aYpJKzTf+x4NPBKu4rz2xHRPkoynSaQ=;
  b=LJQkpaZ4vud+Vog4Y1m9qzeX0iMxBmigFEbcEzPzZfXKmL7YCa7PJl9+
   AgnA2VQDrr3EKDYKNo4m1yuN0XJi2t3hPvhXNVoDx3/ZAVpG5xzjIN8oI
   OvB/pVcyW3L3Qoc8OiQKoSRt0MEkP1IVTpOmPbt1zrz17QHO79JLW4pCA
   YjZgSRyztt8QXrQNuGiEm04mCE4PWWR98Hc0oqs5Lbzej7dKnSRH2vVob
   M912DmyRK9JhpR+GaXrptIAW7QWVCEwlgUB6S0/lMC8wjhVvPFV6QAFFw
   it4DSYdz3Brszs+Ih8UULiuCF/yipJNLHkNQDZ+hDiL8ZEGrnMMFUiwn2
   A==;
X-CSE-ConnectionGUID: 4t7RDsZfQPyzuP03o/nLeA==
X-CSE-MsgGUID: 4S6EjvH8QlqYIQOA5mEHTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54417379"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="54417379"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 14:22:14 -0700
X-CSE-ConnectionGUID: wdmNI13aSP+E02qzIYadRQ==
X-CSE-MsgGUID: qa/7RGvBRWWPhWMrrSJhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="126261416"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 14:22:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 14:22:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 14:22:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 14:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmkUo0mjSvzxtarqxszOk4YhZDVTxbc2AWXCECVfiAGpdwSeNXPzEurbAKmJB5hMHTJayD0XmIXqnz6pMLQ0oXwxHsKCHmXFl4Mr4idsceS9TuzOPOJ6ilgywJqulZM1cOvRH7ckcUNnW/sAI0mMC1OXZFo2LQaOOwjHVSAx7ltSw5mKm9sLTNcnbrCf5W+o2Slb/O0/WcVONT1rrvaGSKfSQ6mxUikKb7WyXVHADzibYWzC0rnFoqkL1fWUIpUM1JenSUg7QPPA13QXMXrcAUYZvJhkpXsAbalhu1vfAnJNFzkK4otVPfCsRON1gNLkWguSW+0pJifY50MYEjFFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGzMC+YRRC/3g8Oe/QF6fPbhdnHauyUZlodwAYjbSzM=;
 b=deBz/fR5cTYGwYls1zbxHfcdlDkxEK+X3Bx14oDz//EBvkEK5Qxgj/us7mzU+hhQrt5LwhXuArWNbnJqCrjrDoAaP1VxpptSNoAVrhw7j+x1XBb09h5Sm2mK1oi7xs5EJMimlG5SnGpm0mVoUTCjUI5jDcX4BUkxJ9m3OPMTqVXxGy/A9NI0cz1QbCUn6gLVmIkmBM9IDX6TUy6bOy5zRZH855Zol1v9+q2yILQ0NT3MNkvacM7hejXscxf81egKs+T2n3C1jTGqwSjwrh0282stzTkRW75+1EK3YV4FTb9ti1OKXsUNSw3Sg0EHXaaYV6iK7T5rZ6xH7CIpxhhEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 21:21:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 21:21:55 +0000
Message-ID: <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
Date: Thu, 13 Mar 2025 14:21:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>, "Luck, Tony"
	<tony.luck@intel.com>
CC: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8300fc-73f9-4d68-5ed4-08dd62751475
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzBEdVltVHpJZG5NUEFDcUZWRmt0blRVRTM1TGY3WS9odlNMc2prNlNpejZV?=
 =?utf-8?B?VTVwaGdqMm0xaGp6QWEwcjRLSU9PcC9ZSTE2YVBBcU9DVFl5RFdTM1pHYjFI?=
 =?utf-8?B?eVJBZkZnZkt0bGxKTzhKUjRMY2ZoUHVlZml4Ny9mWHgwQ1JQaTcxUXB4ZEV4?=
 =?utf-8?B?TFg4dE1JWGp2M3lDdFR6NkZJQ0Y1WklOZ3FUMW1nL0szTmhOY3BtTEdzYk1S?=
 =?utf-8?B?SjBoakRxd0xYZUdBYWs2TUJkK1RidGhqTTIxSWwrdmhZTm01VjM3dlFTa09H?=
 =?utf-8?B?cThadHBsSVZCclM0eWpQbFhZbDRob0lVNU0xMVVJQ2ptZTgwbXg2M0V0Rytz?=
 =?utf-8?B?b2ZrQ0thNWxVZ1ViMzdKQUF1eXNqbTBxUXgvWEFXTVcvQU96T0d2ekR1UVFH?=
 =?utf-8?B?SWFHMi9yNDE2YUl2RGJUM2hTK3poYm1kQ3B4U0NWVnNWbFp2K2tlUkMzWXl6?=
 =?utf-8?B?TzFvRTMvNGdaRHVFcll3UDRRNEZFN3k0ZTJWNjhyZ1puT0xZbWtRMGlBL3Vk?=
 =?utf-8?B?VlY3dGhXZmFSSituQlVYTWh4cWZ3NHJ1Mno1Vm1IZEhVTTMxRFJXRHI5UTky?=
 =?utf-8?B?YkEyTWVqL01JVEYvdzhnZ0ZUbWlnWlhRTWU4WEtNM3J4dE5rWHhveVFjK0lO?=
 =?utf-8?B?azVzdWtxTzdpMUVlcGhYVFpaaHRuZUEwd0Z5b0toR1VRTzFKUlpHZjcwZjhB?=
 =?utf-8?B?QVNJUTZNcWhMWmhvWE9RcGRHTVo5M3JudXNXRlBWa3IxWjhhUzN5aEtzc2d1?=
 =?utf-8?B?bTRVcHYvb2FnRWtMVnpVTVZCemFGTkxvdVRSZTVqanpXVk9lcHFDLzhJUEx5?=
 =?utf-8?B?TTNvalo4QXpJNjNzK3UwWTQrVCs5dTh5elhUazBFRmQwTHpKWlJoNGxKNVFU?=
 =?utf-8?B?dUp4ODVzcFVSSmIvV3ExRkZ5ejZRVGdqd0oyQkVtb2ltYVlBZnViTEtJQTBm?=
 =?utf-8?B?bnFmLzMvN0xoQmtuekM0WEdoSEVzVmJoSVRqdHRKY2FkZ3k4Ti9JT3N4emRo?=
 =?utf-8?B?dU1qNHFVaE52QlFvRHFWQXVmcEVrbG0yT2JoZHRuUUFQbDNJeG1ScnZ3ZWVC?=
 =?utf-8?B?K3ZJVDVBVVprRXRRemR1SU12S1RlQUxPbVpZYW0vbzBFR0NTRjd0V0N2NjRi?=
 =?utf-8?B?cDRTNDhuYUllLzJUOTNtRXFUWUc1Q2puRjFrRll0cEw5UVhTcW50SG12QXJK?=
 =?utf-8?B?eUE2VFVEbldQV1FRbWNwU1BRZFRIb2dBL2pGSTRtUHBLYUU1cDNlT1NtK3Zt?=
 =?utf-8?B?T3RHV0R2Y3RybFhoVnp6ODU5UnBrc1FXaEV3RWJ5bjJlWUg1WmNML1NFNVVX?=
 =?utf-8?B?eUoxV3hQSHlWUVYyNFBDcGhyUkZpdW05MGlmWXRtYmw4ZTRFaW9QUjlZd3lD?=
 =?utf-8?B?bm1JSzZmYVNqQ3hZSDRwQy82a1QwUmg4OVNKUHNnVDJqNUp0Z2lzQkI0NkVX?=
 =?utf-8?B?dGFYK3VoTlpmZTI5Q3N0dFNhODRxM1FVWnk5aW1yR2h2T2w4VXNOOXp2UDdM?=
 =?utf-8?B?djZNRmxOS2dPLy9DLzZoR2JydDNkSXJBNlV1K0xLakhOMjJjWDZCSG9wQUl6?=
 =?utf-8?B?aWQ4MGV1K0xaZFV5NThnS2R3NCtLVGVGbVBwby9paFlvU25lN1hQM2FhS2Fo?=
 =?utf-8?B?UWg1cUpjOTc0UHJkMGI3OTNQTVVVN2FkZTI4WVRHQ1h6V204NUxZMTVpL3VT?=
 =?utf-8?B?S2dEczhvOHRNaUZFdmgzV0dod09mMm9FTFZ6emdjdTdwSEpxWDlIT2RrZUdS?=
 =?utf-8?B?NTBES3RNSHVGWjhGS1FXMWZLMVdwSEV0ZTNSSU02bk8yUjA0c3Z2M3gxaEI1?=
 =?utf-8?B?ZWEvb0xSZUpFS2loZkhuck9GaVJSUlRwZzUyQ0xVejh2eWt4VXJ6L1RobG9P?=
 =?utf-8?B?UjlRTTlWV0VyMHVMbWxXNXhTUmVhbTA1N3FVOURKN0ZnNGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVmejdwZDNudUFnb1AwNHJKV0VHSDFPL005bU5hcXJXcHg1MjJNSTAxbXlI?=
 =?utf-8?B?MTF1ZGVkQW02U2pCeDZicXVQWUZwbDUzY1c0dkQ5ajJBMGczRDcwT2RvZnQ0?=
 =?utf-8?B?d1B1aWo4OEhCMU4xV2oyMHdxWmduSXFJekRlc3AyU2RYN3VMR1d5Z29kWDRQ?=
 =?utf-8?B?dlpVUGxpZUd5TG0xL0ZweDlKekJ1VGowalB3ZHhJWEtFYUsvb0QzY3RxQkdO?=
 =?utf-8?B?Si8rRVFNMkwraWlQVzRWNGlHeTcxbU5waC9vMzRMU3RXSnRCY1oydnpPT1l0?=
 =?utf-8?B?eWM0TlN6SGw1aG5NNVZia29ybzF3MS82UHpPc3hQQUttbytjZm9raWkyeDFF?=
 =?utf-8?B?bDJXTDNvYVV1cm1PbkVBc1NrVHdoSEpCMWY2TVd1aEJMVEpObWwvOE12a3ND?=
 =?utf-8?B?M2dCYUhWRkJjTFg0NXVxWDhaQU1XSFBhMHIvWFVCVDFMVVRucEo4NG5NZDVN?=
 =?utf-8?B?UkJ1Qm14N1g1bUlXNHozNitUTTVwWUpZM09jRXJYbjRVTnJDancxemVhY2k0?=
 =?utf-8?B?SlFMT3FpaXBtdUJhVVRsbmxWaHRNUzh2czNEMDgzUFYzNFRjeVFFQ1ZWT2E1?=
 =?utf-8?B?MkxuN1lBYjFKLzhiNEg5cDNicWEvc3A0bE1EeDBKWFZFdzZyYjgvcWZkajE1?=
 =?utf-8?B?WTFhRXJCUXd3VjkrR01tRTVXMkFzeXAxVkNuZFF1QnNCb1FUeXlXNnMzMXNP?=
 =?utf-8?B?WWFnZk1DM2dXYU02ZG85SHZrejRSQXd2aHlQc21KQlYyMGh5NWhxWlFIMml0?=
 =?utf-8?B?bEFrU0t5N3FQNHBEVkVJMFQ0dnZ0cE5FT091TUlSY3gvai9ZcVpZM1JiUDRJ?=
 =?utf-8?B?dWJRRG5DL0U3b3NuYUgrOHNNVXZJTU9sQzRkVDZLRDhhUlozSnRsZExWL0ta?=
 =?utf-8?B?M0lSRDJucFFjaHJyOHArcGdlbk54Njc4KzlPRUdzSlJJdFRMOTVSQWxoelpy?=
 =?utf-8?B?VnJpenB1TFRWaC8zYlQ5ZHFua1U0RG5mTVpEZnJvZXg5SEJsb0cvM0g1RlRF?=
 =?utf-8?B?OXNFUE14Q051dnlqTlhQajE0d29FM1BZMy9XMkZtM1VIVmtZNFBjUzdHc28r?=
 =?utf-8?B?cnRuQzBnT0ozUncrK2RkRm10OFM1V0hJYktWQzRLZkt0LzU4L202MndIL2Rv?=
 =?utf-8?B?d2NWYXJDM0dMcVRzZ2QvUHZaYmlVbnJWd2h2VlBuTm0wNEl2Y2E1YzgzMm54?=
 =?utf-8?B?UjVKSUVheGcyNzZpTkw1OGwrOFFLNFZjS1N2b2hxMmcrRlVaY2Flbm4weXU5?=
 =?utf-8?B?N3FqaUhEZ3lIOVNVN2ZYdUhzc3dKYk1ZMEMybUcwUTR0OU4zcHNOSXJ4czVC?=
 =?utf-8?B?bDU4eHIrem4zNW9yQlNrWncyaGxjNVppMHRzU0JETVZWZmlNT1NabzkwUXRS?=
 =?utf-8?B?R3V4Q2RrL2FOQ2J1ZmMxTWNGNXdxOXNiTTJvcFY5VVpSMTRqZzFxbmo1bHhQ?=
 =?utf-8?B?OEVLNzF0NndlMEZkWFBlUEo4c2VMR2JVRlQxWWxwNk5FRURZRFhITXkybE1i?=
 =?utf-8?B?YlFldEh3WE0raDgxaEFxMU5KTGZyYjZ3cThMdjYrWkdkbUhBRkdFYzU3OTNK?=
 =?utf-8?B?Qi9Ed1dMbzZyWDlHQ1VsMk9Jald6T2xMcWdqM2sxRFNEcFJEVjV2WWZhdllL?=
 =?utf-8?B?NWErczJ2YnJqSjJVd1Z4VkF3WXY0cGdKN21iK0FKbVRLWU04dzZtVmVPRlZK?=
 =?utf-8?B?ZHVna2l2NFNQNjNrQi9aeVVVVGNVUzhPem5FdS9VaXVtU2V2SkZZNFByUVM2?=
 =?utf-8?B?U0ZiWEx5OTZrMkZuK2l5VnVMTW9WcWwrQWZEbEY0RSt3UGE3a3JUUWpuQkZz?=
 =?utf-8?B?OWRGdlhlb2JhaTBLbXlsUlpYSmZ2UXFCRzlZSnRvbVZxVXFpSWlhZ3JZelJO?=
 =?utf-8?B?OWY1NjduTERhKzdlaVhnSnN2YmJjQzROOUlldmNlNGZDTmtFaGhXYmpXQ0Yx?=
 =?utf-8?B?TEk0Vm5iVCsvNVY5UFR3c2gxWFZTY2ZodnNpazB4bi9HWTVZM0pJYWdwdkFq?=
 =?utf-8?B?b1FPbmk5KzJ6YjJYNXhLK2w0a1cvWkxEaHNwYVhzZURDbGVMZzl6MXhiRW8v?=
 =?utf-8?B?c1B0enFSZXY2Tk9mQ1FkYyt2YXVxRGV2ZE5DZ29qS0V4Uk5CZzhISmk3bTdF?=
 =?utf-8?B?UTBXSHdtZzE0N0lvTi9VUGc5MVNqVThJMGtHRlVJSmNMb0NMSkJuQmhlM0lh?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8300fc-73f9-4d68-5ed4-08dd62751475
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:21:55.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqAgYxZ55mZH9YrQKxRf3+7544oLsiY3a2ggcOoWFrKqdyvS1tDEfjelCI+LgvFSa+5T3cFGUA/HtT6hNXiWbs3j2Kh5K8SFK0p05uAb2lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

Hi Babu,

On 3/13/25 1:13 PM, Moger, Babu wrote:
> On 3/13/25 11:08, Reinette Chatre wrote:
>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>> On 3/12/25 10:07, Reinette Chatre wrote:


> Here are the steps. Just copying steps from Peters proposal.
> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/

Thank you very much for detailing the steps. It is starting the fall into place
for me.

> 
> 
> 1. Mount the resctrl
>    mount -t resctrl resctrl /sys/fs/resctrl

I assume that on ABMC system the plan remains to have ABMC enabled by default, which
will continue to depend on BMEC.

How would the existing BMEC implementation be impacted in this case?

Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
files will remain and user space may continue to use them to change the event
configurations with confusing expecations/results on an ABMC system.

One possibility may be that a user may see below on ABMC system even if BMEC is supported:
# cat /sys/fs/resctrl/info/L3_MON/mon_features
llc_occupancy
mbm_total_bytes
mbm_local_bytes

With the above a user cannot be expected to want to interact with mbm_total_bytes_config
and mbm_local_bytes_config, which may be the simplest to do.

To follow that, we should also consider how "mon_features" will change with this
implementation.

> 
> 2. When ABMC is supported two default configurations will be created.
> 
>   a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>   b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
>   These files will be populated with default total and local events
>   # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>     VictimBW
>     RmtSlowFill
>     RmtNTWr
>     RmtFill
>     LclFill
>     LclNTWr
>     LclSlowFill

Looks good. Here we could perhaps start nitpicking about naming and line separation.
I think it may be easier if the fields are separated by comma, but more on that
below ...

> 
>   # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>    LclFill,
>    LclNTWr
>    LclSlowFill
> 
> 3. Users will have options to update the event configuration.
>    echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

We need to be clear on how user space interacts with this file. For example,
can user space "append" configurations? Specifically, if the file has
contents like your earlier example:
# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 LclFill
 LclNTWr
 LclSlowFill

Should above be created with (note "append" needed for second and third):
echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter

Is it possible to set multiple configurations in one write like below?
echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

(note above where it may be easier for user space to use comma (or some other field separator)
when providing multiple configurations at a time, with this, to match, having output in
commas may be easier since it makes user interface copy&paste easier)

If file has content like:
# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 LclNTWr
 LclSlowFill

What is impact of the following:
echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

Is it (append):
# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 LclFill
 LclNTWr
 LclSlowFill

or (overwrite):
# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 LclFill

I do think the interface will be more intuitive it if follows regular file
operations wrt "append" and such. I have not looked into how kernfs supports
"append".

As alternative, we can try to work the previous mbm_assign_control syntax in here (use + and -).

For example:

# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
LclNTWr
# echo "+LclFill,-LclNTWr,+LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
LclFill,LclSlowFill

With something like above resctrl just deals with file writes as before.


> 
> 4. As usual the events can be read from the mon_data directories.
>    #mkdir /sys/fs/resctrl/test
>    #cd   /sys/fs/resctr/test
>    #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>    101010
>    #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>    32323
> 
> 5. There will be 3 files created in each group's mon_data directory when
> ABMC is supported.
> 
>    a. test/mon_data/mon_L3_00/assign_exclusive
>    b. test/mon_data/mon_L3_00/assign_shared
>    c. test/mon_data/mon_L3_00/unassign
> 
> 
> 6. Events can be assigned/unassigned by these commands
> 
>  # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
> 
> 
> Note:
> I feel 3 files are excessive here. We can probably achieve everything in
> just one file.

Could you please elaborate what your concern is? You mention that it is
excessive but it is not clear to me what issues may arise by
having three files instead of one.

I do think, and Peter also mentioned [1] this, that it may be useful,
to "put a group/resource-scoped assign_* file higher in the hierarchy
to make it easier for users who want to configure all domains the
same for a group."

Placing *additional* files higher in hierarchy (used to manage counters in all
domains) may be more useful that trying to provide the shared/exclusive/unassign
in one file per domain.

> 
> Not sure about mbm_assign_control interface as there are concerns with
> group listing holding the lock for long.
> 
> -----------------------------------------------------------------------
> Second phase, we can add support for "mkdir"
> 
> 1. mkdir info/L3_MON/counter_configs/mbm_read_only
> 
> 2. mkdir option will create "event_filter" file.
>    info/L3_MON/counter_configs/mbm_read_only/event_filter
> 

Got it!

> 3. Users can modify event configuration.
>    echo LclFill > info/L3_MON/counter_configs/mbm_read_only/event_filter
> 
> 4. Users can assign the events
> 
>   echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
> 
> 5. Events can be read in
> 
>    test/mon_data/mon_data/mon_L3_00/mbm_read_only
> 

Related to comment from Tony [2] about rmdir, please also consider that
original mbm_local_bytes/mbm_total_bytes could also be removed because at this
point they should not appear different from other counter configurations ... apart
from being pre-populated for backward compatibility.

Thank you.

Reinette


[1] https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/Z9NB0wd8ZewLjNAd@agluck-desk3/

