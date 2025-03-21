Return-Path: <linux-kernel+bounces-571860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E0A6C34B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB81A7A88F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307D22FDEE;
	Fri, 21 Mar 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQM3N+pj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B418FC75;
	Fri, 21 Mar 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584907; cv=fail; b=HaV+qEVTjn4armyWfDHktmH6mllxUm3yqkdY/Ws5kOIpEWK7MULs3wWOhmC5gcQHUQ9UixNxDMQ6yiWCp/y9YgnO0qu/h416SsWuWmghGIuAPJu0RaCfp/WCQt78bva8oR1RChqIyzIlwzIeT6o9Cq1ePAXDX4+MkVagluoOoLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584907; c=relaxed/simple;
	bh=/CccAeYtypUagzegRtN4DNS089KV6EIuZRGS9U24P1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOYilbjwk/cg++Ix8uqSVkyLbaJsIqP+Ltv2oVjDorFfyMqQY3F/tE1pfWkWreYDp+vKy/0MLIp1Kdakj3NJPwCqKAPvoE6Axd0C0/Ro0JLd7jysjnowp2vP9KOW55F3IvRj7HcJO1GIb1U5+a8bvbRwnwsBgjkxdedsKJHX1Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQM3N+pj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742584905; x=1774120905;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/CccAeYtypUagzegRtN4DNS089KV6EIuZRGS9U24P1w=;
  b=TQM3N+pjCs9qS7po6Zupi0aFz9sYGQowZJ3rawmI0RSw2WdEHbLz6BT2
   m2vQf1yArbTMkY7duPKT5v4lfhQKCtiYvUiTDzZ951aNmMwG4wd3eYjQB
   l/KMKk6Li6khRlPhup49MPEmcImZXWM3vWYY65SLFmN6ugDesyhYMWWxf
   19scR4iAYZ4pQ7d95QeRMcesWl2Aq6Rl9tqXr6sY2wfkgo1XFniW4m74s
   YZnsvVhovQoVyz8Gas0p6n+h8hZU7NliB6TgGynp6jZCOnJDqqxVVQRcJ
   JwPhzH6mL8bKV+pQ7q3ivHx7BPs/A31Tisi34HLiH2xc0BwjDDqjt0BRS
   Q==;
X-CSE-ConnectionGUID: HRDxiJRXRVu5/sFWM+Bpsg==
X-CSE-MsgGUID: HUgQLGoXRvOb2UXOBMDjmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43027291"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43027291"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:21:44 -0700
X-CSE-ConnectionGUID: 0Mv5jk+bSGCFW7MyVJUK4Q==
X-CSE-MsgGUID: k8tzk4bASouzZmRTW2RLRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128707246"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:21:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 12:21:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 12:21:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 12:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZplJhzmenNRKp3KMxDgHiAe0V03Adt66iTJcG4CsAYlbSD72VUwh2I6QMKEW+rkDBhvAzCSj3jykjCnZMURcQD0XXC17uWk6ynm8hMVaaJayjiAOhhEW6zdhfjvyDkl5By0D6L6mWZ95J1uAJ+MFbFdV5RBgWS6IUH69iBqnlBWrhHZbCLZwS2luswnIJ+lSPFyc6TKRHNM0hvM8+zAUVvvuQnf1lJO8su/FqCnzcuOHaLy75zvTWRcdOnpX00fvAPwN0d2q7uYRcvThP2aLf554ce4q5eYdQmX7dotyOx6d6Ll5/4AP6w4M82JbQrffsBRbrClZBKi1qFCIGWci7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IdvR9dmFg2NgNNfai0tjWD/N+wQKGeqh7xtFKh8dfo=;
 b=yYYP3Z0itaZkBwB0Pjw9sc3yCLEHIqrVK2BkZFYGrWZz4SaezaoCSpHN0jzD/xMSnrPxsAbzLZG/BulQEEoSw2Z6pRTsnzcZm2xR7U66SMAHtBZxZr5F8py8zNXAKOzaY3/EcOk92KrVxHzIVHZ0hIk8sCS/Pb61ncPKXbMK65Ls9tUfCQJReMihRqjeuZh+/H7Ph7HOWGp7Cd/15VlvA52cSMgigJgxPSCiOVfrlHF8vXTuTqhPc4OrDEgGJoE8deXpsoTYecqAB4UgCT10H5e6svNacVqH/5XLOBWiB3b/4RwIkWNSPTOAFH3zL8S9AA0qPQlE3NOzN4MHopEC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 19:21:39 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 19:21:39 +0000
Date: Fri, 21 Mar 2025 20:20:51 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Florian Mayer <fmayer@google.com>, Vitaly Buka <vitalybuka@google.com>,
	<kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
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
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
Message-ID: <t5bgb7eiyfc2ufsljsrdcinaqtzsnpyyorh2tqww2x35mg6tbt@sexrvo55uxfi>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
 <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
 <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
X-ClientProxiedBy: DB7PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:10:36::39) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6239:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6ee51b-b671-4386-152f-08dd68ad9a99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJiVXRQRkJrQWV3MEdPV2VNczRBcENZalE2K1NqSWpORlVrMzIzZzIzaU81?=
 =?utf-8?B?aVpsM25UckdyY3ZqYllIdlhkdm4wRGFPWm1kVGlWZlNySzFnVGRrV3ltbU0x?=
 =?utf-8?B?bVYrdGF4bDdTd2RVV2JNMFBtYlhCQkdDeFhSaG43K1lIWXpmM0FVWjhtYUtI?=
 =?utf-8?B?eWZteDN3KzBzNys1ckR1UGJHR2NDcE5kcUlvUG0yUm1hRzU4RHVET0FvTWxZ?=
 =?utf-8?B?SkJnOUFMQjN4TVNFTzJkTURSbEM5NlJKZTNMdTFVQUV1WUJsV0hNY3hHd2V0?=
 =?utf-8?B?NVhEaGVRa1ZnM05FZmhCTGNlZ3JMVHJNUmgzWEtvUStCTWtKTWhqYkNNTzht?=
 =?utf-8?B?NkN4U08wQ3k3VGUwdFdwdE5JeFord3Z4aDRBQzNqVGxUWlExTGJsTnFab1hz?=
 =?utf-8?B?T0xPUXU2a2Y0R3BSc3ppN3NvU0NjTWNUdllWamMwZXM0dDNwWWFhVmR6R2Ux?=
 =?utf-8?B?ZUs4d0ZkeFQ2NTB6eWpwQmRHSE5QZnFwMUw1T1lLSUxpc3RzU3QxdTNzOWRM?=
 =?utf-8?B?N29URk1CN1VNZzR5SmJnemlGdkwrU3ZKdnRnRTdpaElEMFdWMU9PVWlHTUhH?=
 =?utf-8?B?WlJjMUlpN0N1V3c0dlRkdFlMK291ODdKd293dGdYd3gyVk14KzZTRlAzekZn?=
 =?utf-8?B?aDJjTEhZYzJuNWZkemVKOUZyc2xMQytsUEkyYzF1Y2Y5VkMzQ2krVTNaeFI1?=
 =?utf-8?B?NGFNclRKcCsveFJJaFRFWVdqMGlaN0NoUG0rYXcrUTZTS1QxSkxVOTk5U0JB?=
 =?utf-8?B?ZFJBR29LaGRKRi9TNVQwa2VBamJ3LzZvWkx0VTF0MzJ0Nk9mcVhwSnNlRnVT?=
 =?utf-8?B?UG9SK01XSUErcXgrTzRGNTV6RFJNUFVKZkRyZUNuaTd4UVdacm1yZkdDZS9I?=
 =?utf-8?B?UFJoTFE3TXRRbkpSUW1Ub1gzSTFaZGJvVDFtQlJyWG1FTWpndHZKdUNCdzBh?=
 =?utf-8?B?TG1QMTlHcVFzc29MMjJaem52Qys4MW1rSFlMQVpLQWtNQ0doNkVyL2o1MjE3?=
 =?utf-8?B?ajJ6MktLV1ZNbnBnVTBWM2F6SWJyRWVkT0o1WnJFNm4yb3RQa3RScDdHS2Jm?=
 =?utf-8?B?Q3Nxa3hZQkpTUFYzSHdSNDNsTWZFcTBQZnRTcmVDT2N2MFoySCt6WWoyU2c5?=
 =?utf-8?B?T1d0SlFoWG4wdEROSmRiNGd2RjdWWWRPQ3JYT1ZlOGFzN1V3c3V2UjgwYytE?=
 =?utf-8?B?Z3BuUXR3Zk14Zi9WaE1vRnNTS2o0dTE4WnZsR2g4NGhzejdmN2tNT01XK0N5?=
 =?utf-8?B?L0RmQkxreHlwZWhScnd3Q3prQnpCYWlmbkZPR2RTMDVwYjJGeUJzcU5MNGI0?=
 =?utf-8?B?RHBsZ0txYnVPOElqR25zN3BjQm1PMVp6bVp4SFpNSXJCRWRIZWNRdExrbk9v?=
 =?utf-8?B?dm12RmxJVGZ5cDFGMUk5NDRydVk4emQ0dU5ieXB1VVFSelBIY0crcGNhV2hS?=
 =?utf-8?B?TkNVeDJ1OTBRWjAyeGducG8zbWFqRGZFZ1FpZFhrZ1N0SVc1MDQ3K2l1WkJH?=
 =?utf-8?B?RlgyM1gycnUzNTJyRzlLZUhmcGM3eThFZmhNVVNYc3lUbVFMeVhsV3c5UlBH?=
 =?utf-8?B?SWVLNnJjWGtFTTVNbnYyYUU4Ylc1SFVDU0NzdEk3YzJ6dTR0MXhLZnJ2QUJW?=
 =?utf-8?B?aHR6N0VwUlVXK3h5MDNqZityWDdMTmcwQlVrcjdPaU80QkVBelR4TXZZcDNt?=
 =?utf-8?B?RXFtLzg5ZXJLVVZhNmJQeTMybDFLVFFtVG9pNUZNK1UxUG1mZ1hCRmpVNytl?=
 =?utf-8?B?VFJuYTVFTmRTd3NmYzdvVndaSE0rdXBxYVAxZzIybDNoaGtyTm81MVhXSUVV?=
 =?utf-8?B?bXU3dllVd1kxbHdTd0tMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1OMjR0Y3hKQVo0QTRKcncxdHlSYmdyRTkwWGsxenRUZUR5WG12WkNoRG52?=
 =?utf-8?B?cVY5djJIR0o0cGFTZmRlT1dyZEpnNVBiQXphaFAzL2hDNUtnS21TcnluWXhX?=
 =?utf-8?B?clNrMU1sTDBZN3pWYXJpQ3Q3WXV6STQvZzB1YjlNdlBGb3d4RS9aaGJ4Smg3?=
 =?utf-8?B?VGZURjk2b1hmVUcwcUJqTlBlVG9aZlBpL295TkdUR3Yzb1VTZy9WTVZSVTZE?=
 =?utf-8?B?cXV6YmdnY1FSUnp1Z3pNOXlxSk1PSksxRlcvNVlFaFVqQWQ3d2tRVkNjUWVK?=
 =?utf-8?B?Q2FqNjJMbk95ZGJRVWN6RDZDejl3NUlGWnAySjNXYXNLb21aZk9nTWZEMnV0?=
 =?utf-8?B?THpmVGZORXh6dXVybm1TMmZjaFkybVNiaG5WUTdNTWRaN1JvSUxzTTZRYmd1?=
 =?utf-8?B?RjRDa1VZR29IYXlYUnFRcEMrRktRMHlkeFBPZWlkQXRwV3M1WVlkN09PS1k3?=
 =?utf-8?B?dGJYRmwwcCtJMSs0WjZwbkdONkZNNjdRSVBlc3Y5bjc3WXRJSkkxOWtzZmtM?=
 =?utf-8?B?eTNwU3VOOE1ObmpINXcwQXF5OVBENEZXYko2RDd5R3RjdUJoQmtVcmFVWE0r?=
 =?utf-8?B?T0xvbEdqdlRVT2hvc2FiUG0yU1BXQUpZa0ttc0hPK01FUVg3Wm9oNWE1T08z?=
 =?utf-8?B?UWhpYk5vYnd3NnlhNVVnc2UvMy80a3JSeCtUNUJOYnFHZGFKTytkMmxycjNB?=
 =?utf-8?B?TDVqU3JWYWhsRUcwcG1qQTcyZnEzL2tzbW9hak1QYy9UVUpMa0NvdUxLcWM5?=
 =?utf-8?B?UzhtK2k3T1o5TFh0Z3NHZ1pzcklFbnRWcUVjMkxZcCszdnNWUXJRTldyaXVT?=
 =?utf-8?B?Vmpld2VtbXI3QXZjbHRxd2NQWHBFZ0xTT0lTV2xTcXdZNVJzd0ttOEp1c2pM?=
 =?utf-8?B?R2RjOWJKN3VjN08va3dpamdDVU1VRW1HakVLdWJqV3BBYVJJQUtDM3VYVGJC?=
 =?utf-8?B?cnY1Z0JCVGxmSllZSkdhTWI5WDJwRmRtNFJySmFHUXBxcmxIVEpkcHhHek9n?=
 =?utf-8?B?a2JKZ3BXWWh5YVFQeFpYYVp6a2NleEdYZGpoT2dTcUxjdDNCbzM3RG9lYWNG?=
 =?utf-8?B?MXFZNjk1RGlFL2pvUzZMZVhPUVlodjF6T2JEZ2Mva1MwTWwwTUhERnJINUNw?=
 =?utf-8?B?SmtOejNrck51YkdZTmswTzlrMWpMRkNBZElJV0ZWcForZjJqK1VzNEpTaGRZ?=
 =?utf-8?B?ZzczTUIrNDB1TmJyNk1tUTBNV0F0YlNTMVQrQTRzT3ZzRy9wcktHNStaSUx6?=
 =?utf-8?B?Y1pVd1AyK2lmNzQ0Vm1Va2UybmpvNkliUWdRY1lBbDlwUWdwWFhzMnZsVnJ3?=
 =?utf-8?B?U1NUV0x2OGpNWUZGNndXbEVtY1lIM0lnemtLbkhEWjV4bWNJb2JHTEwvcnR5?=
 =?utf-8?B?dHZ6TUZNVkY3bEI3b0kvUCt6ZnhWV2VFZklXNnVjS0k5THk0SWxVU09oTU9L?=
 =?utf-8?B?akk5RXI0UmlsY1hmV0xWRjNpS0RGWmhmc0Q1OFN2bGVVVFRXblpBbWJwS0Mx?=
 =?utf-8?B?ejlKYWNsS2FPSWdoa2dNZ1o3cXhKeW5sMDdtdnFmSUFxYWxJSGVDeXRBTm1I?=
 =?utf-8?B?andEVU9GMDVVaHhMbmhjT3NZN3dpdXpXYzVZRzJwYWF4R05ZMitKaDI5bXR0?=
 =?utf-8?B?KzBmdVI2RDkyL1pjR1h1MlRWcXZlRVVkRktIOTNLcWs5VTdveFM4YWV4ZnFz?=
 =?utf-8?B?M3g3ME05RWVEMDkwazlJaHpJSDdaMEdOWjdaaU8xUy9kcFpCWVNWMm96VEpN?=
 =?utf-8?B?bWh2dHBYYjZNcC9rekhyWmpBNXE4czN4SWFjRFNFdUF1a2RSd1hWOEdlM3Jy?=
 =?utf-8?B?MnJiREphR1MwZDdhMGY5OTh6REpKbGN5ZkExaFhJY0hydzdSSUZPMS9KOE03?=
 =?utf-8?B?WUkvRU9lcmpyaGp4NlB3a0hXb1BSYzVRSTFlU2RnZ1pSdHNneFc2SGcvWlFq?=
 =?utf-8?B?MzFTVXZzdzE5RWt2bU5Id1NrWEJQVklPM1N1TTFpYm5MY0swOHNaUEhvZ0Nl?=
 =?utf-8?B?ZXRTYks2SWVxUEpIczJiSDI3NUtmcEZFZERnaTRTTGgwd2dxMFBvbEJ1T0RR?=
 =?utf-8?B?S0pLS3BscTB4VGtuWXVIalAwWFhXMGdQY2dXVFRuQ2RrVmp0Qis3V1FyOVJa?=
 =?utf-8?B?TVNNem8wVTZJWm9xeFhzSUV2SXRVMmRPc2trdkxTS0FDaDUxZ0hjVkhiTEVX?=
 =?utf-8?Q?fVq1OB1X5txiIaDwyycE8s0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6ee51b-b671-4386-152f-08dd68ad9a99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 19:21:39.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPGaikMLTHlQaEz1OREOq7rqlwe9PQDJ5cBdY0r7XGXzm7T8OfvffucktJA+hMewZsTUZJ5ES+Iig9W4tAqjQY94MfPmOWA9OIVlizAoli8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

On 2025-02-26 at 16:24:28 +0100, Andrey Konovalov wrote:
>On Wed, Feb 26, 2025 at 12:53 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> After adding
>>         kasan_params += hwasan-instrument-with-calls=0
>> to Makefile.kasan just under
>>         kasan_params += hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
>> inline works properly in x86. I looked into assembly and before there were just
>> calls to __hwasan_load/store. After adding the the
>> hwasan-instrument-with-calls=0 I can see no calls and the KASAN offset is now
>> inlined, plus all functions that were previously instrumented now have the
>> kasan_check_range inlined in them.
>>
>> My LLVM investigation lead me to
>>         bool shouldInstrumentWithCalls(const Triple &TargetTriple) {
>>           return optOr(ClInstrumentWithCalls, TargetTriple.getArch() == Triple::x86_64);
>>         }
>> which I assume defaults to "1" on x86? So even with inline mode it doesn't care
>> and still does an outline version.
>
>Ah, indeed. Weird discrepancy between x86 and arm.
>
>Florian, Vitaly, do you recall why this was implemented like this?
>
>To account for this, let's then set hwasan-instrument-with-calls=0
>when CONFIG_KASAN_INLINE is enabled. And also please add a comment
>explaining why this is done.

After adding this option the kernel doesn't want to boot past uncompressing :b

I went into Samuel's clang PR [1] and found there might be one more LShr that
needs changing into AShr [2]? But I'm not very good at clang code. Do you maybe
know if anything else in the clang code could be messing things up?

After changing that LShr to AShr it moves a little further and hangs on some
initmem setup code. Then I thought my KASAN_SHADOW_OFFSET is an issue so I
changed to 4-level paging and the offset to 0xfffffc0000000000 and it moves a
little further and panics on kmem_cache_init. I'll be debugging that further but
just thought I'd ask if you know about something missing from the compiler side?

[1] https://github.com/llvm/llvm-project/pull/103727
[2] https://github.com/SiFiveHolland/llvm-project/blob/up/hwasan-opt/llvm/lib/Transforms/Instrumentation/HWAddressSanitizer.cpp#L995

-- 
Kind regards
Maciej Wieczór-Retman

