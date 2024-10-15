Return-Path: <linux-kernel+bounces-366307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5299F380
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000D7B217EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE41F76AF;
	Tue, 15 Oct 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kM0LQb9z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCE1CB9E2;
	Tue, 15 Oct 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011451; cv=fail; b=sXIURlYuXIRkmo92u+YC5Ej6Y0xymsBoe6121f7HeFB+HrwxM/uK9N7cDrdS3AbXj2jv81vtGUHVMXghL5L6d2V3ZNx/Jw1b8CmcfeduH34r/TkgpG+ZAqNSg2V3xLm4u+s+Om7j0o61DjDlUOy94hg+TK89+4PelmcmYFxtrpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011451; c=relaxed/simple;
	bh=oumOdkFxfHvRhKx2GoB0tVA8vTDKUoUPJbfopTv+fSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlCQXL6u/EqwvG31xidgyGC+tdWFsrK49H/49lTiF9XlM9iY6PF0+m3c9UqZBjbJiFAP3mEY7sJsS/zZY/21eMImW13g+RITr5S089rno46KivFhx6tBhFiLX8382I4qx94DSd7lIQS6VD5vzhw9liaf1fZW9T7FOP7RM4Jq8KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kM0LQb9z; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729011450; x=1760547450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oumOdkFxfHvRhKx2GoB0tVA8vTDKUoUPJbfopTv+fSA=;
  b=kM0LQb9zNOqmp379grjYDJXKLL79dw/tzgp/VPUSLMt2Xv2vdO8ZCWVO
   ERSY3AlrmTmWPZcrgbADPtGr6/VfbZ93XOU6Mec1+WKH2Mv/lL+zbPiXW
   dO3fuF7aYU5sLC7Q3SDIeOo32K4wi50Bp8BUasl3i/j0/iipifkoiIxgj
   ImyRdXReoIlylGem5Wr6E2Wgy+Lu5+cBzZP0PCaXRoeNdgK09dNvGxBBT
   uPUTXhUlH9uZqpQEfZqFSG3TTAuUqpgYiqMm8S3kgmA6nULP8N61AAi+c
   Y6bbpILmzjwLBfeXGjD1Kla8l2DCIi002dczwhIiJucDBVUnJVM56i1JY
   Q==;
X-CSE-ConnectionGUID: sH9imFgpRnqbHF27RzDq9w==
X-CSE-MsgGUID: YNH2M65XTY++TvGXRIf+PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27898325"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="27898325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 09:57:28 -0700
X-CSE-ConnectionGUID: yptz4oioSUSubnJQMnqBfw==
X-CSE-MsgGUID: yDkEx9MdT+m4/IrPM1L00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="108727864"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 09:57:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:57:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:57:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 09:57:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 09:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqmaXyD97qwmA+Z+vfE0l3eS2OICFAKeJRKORzlv9jnIswVzTeGcu9uuXH1oK0hAZgyHBpcomSftj8cSN7oUQCFA8Jtq79u8CkQZ2Q5VtazJApt22s7cn7Mu0prqewLc/kFxaEA9Ul80z77ljC49+Yrp/Xvhmbl8fYa8qj1RBW5FW3Ag6cLw0hVO9iYxckDyACdX5aPfZRoDJM5Z7uPh6z1eLNrzmtof4UOMJTraLHkear/iNFm7Xx4/iJ1K6I1aWdN9bXRNwf4y4yP1BgxD41kO0yiqSRSx/lEIE7Qvyth0+umkzF+NvSWWiZFFhpcpPkeg34RWeuun3YLE+99Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oumOdkFxfHvRhKx2GoB0tVA8vTDKUoUPJbfopTv+fSA=;
 b=LEgpmuVTmn7FVQVbyhBDCME6yPNE5Bt4ouOHyscsDfflsudnIAhtJWkk1FzCXgIj8SBjXuFSuBJsTQuYOaLC6HFfsuM9G385oRVIE9MlFswWRUTMNfYM5CGCfJ6Qih/5Xq6q5uvqHvbxcx1CjrFKC5Bi9SPRkYVusOB6vaAOHzm0JHjYa6l9hlMgay3/KZCrYZoKP4ZlZ2YlgvguIYjRq2ihXmf6Qfs2pVErg374xvUQU1LABpZqX6fXdIgR9YNG0JSfuUE650DoXuuBAKPLJP4JTPD2CIAav/4pfQgoCn0QD42kJy5xqlsjHOry+O35Dltx1p63xPLVwt5i+uLwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 16:57:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:57:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
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
Subject: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Thread-Topic: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Thread-Index: AQHbHqtr9SJd8KI8iEKHtgES9x1Qj7KH9KuAgAAUK0A=
Date: Tue, 15 Oct 2024 16:57:15 +0000
Message-ID: <SJ1PR11MB6083E3A18606D3D788A588F1FC452@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
 <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
 <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
In-Reply-To: <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7566:EE_
x-ms-office365-filtering-correlation-id: 6651005a-339b-4321-a76b-08dced3a6c16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1JUWENTZzRYajI4aEZjUFRjTXJjd0pWRnZob3VQOEoyTTN6VG5ML3AwMm9Z?=
 =?utf-8?B?eFE2WTBQMGhqcEgraW1QYSt5U1AzMFpKdXJMSndtV0d4czdQTk0rY05YRkZv?=
 =?utf-8?B?RjVPUFVCYXRQYko2cGFzTUNmZHYrTjc4L0JPZm1QNDBvWXNDZUlhWmg4MFVi?=
 =?utf-8?B?ck8wTzlOWmNHN3V4Y1FCNE1HMkJCVEhRcDJlUVZaN2IvQkl5TXBQVUJ2ZENk?=
 =?utf-8?B?SjhubkNSS1BvVldvYlVTOFN4TXRSUjdJVGNBVmJaWkJQQjRBZWd0YzRHL0pa?=
 =?utf-8?B?OU1ESittSldHWFBoa2szdVpwZzNpNlBwWDZCaTRUZ2Z6UjBEM3ZZNGl1SzRB?=
 =?utf-8?B?MHM2OGg0dDIwcEVEbmpoeWdMY1pSbFBYSVkyUDRubkRWUU9DMFdyVWJqN0dJ?=
 =?utf-8?B?bjNodHBJWkRLbUdZQUhyeklpa21ESDdVMVlGNW4zUkN4S0pDd0l5eFFHeUJH?=
 =?utf-8?B?RUFxck8wS3VLTFJTMlZDOXhCbVJPampYQ21zTE12cklOTzYvT0JDZUpvMlRS?=
 =?utf-8?B?WTFINnlxMGN5UjVxb0xpYzZ0MVRxSldXMXorUUV1Z0VTb08zd1VaN2ZzVXYv?=
 =?utf-8?B?OWJrZjc5c0RTSXRDYXlla2RiOTk0TjVzbElGdktZYmZRazJ0anBFcnJlaGlL?=
 =?utf-8?B?VS9yNDk0a0FQR0dCS3JpNUNnMlpFZk9oQm9zTzk2elpXVkpYV2YrT0MvMzd4?=
 =?utf-8?B?UmNJTDBramlFUHZOZE1mNGxXcWs4ZXJSKzBxY0RQMlJKNDFlWHY3Rnk3S1BG?=
 =?utf-8?B?WmZYQ1VRclE3UFlhVDlNOHFmamcrY1U5cWF6VHJrM1lXWUZGemxSeTg5UkNY?=
 =?utf-8?B?OVJRTHhDbUZNUk9QQlB1ZTZLSFMzcDVwUTE4R29ac1VMaG5Xa00zTEw4WFg1?=
 =?utf-8?B?K0xzOERHcFpRM0dycEUyS1RES2JIQ0IrVnRRZzllMmdjR3Mxd0ZUNWFiQzUx?=
 =?utf-8?B?dkhURDg3bmc0TGxnQjJUektlYmJYS3doclc1MEl6WDRQR2RUMm1JNUNHMEdo?=
 =?utf-8?B?VVdvbkNVS3crTjlGN2dJNlM4dkNIUGsySXluWW9tRmcwalY5ZXBVMTJiNTJO?=
 =?utf-8?B?K0w3WXNjL0FybTlZQ1Q1dHM2UWx4a05jeXgvWEpJZFQ3ZkoybE1hdEt3bHVs?=
 =?utf-8?B?SCsybW5rQUowdmVpVk1JRjUvY0FmM3pHK0JuamNuOElnNmUvQ2diZjQrd0d1?=
 =?utf-8?B?ekRLbExhMFVLNSt1R0hEdVNLYkljbU1sL0pqdlVqT2RLaU5VL09YWldsR3ZQ?=
 =?utf-8?B?eFJTMnNyako2WDlFN09MWWdPNWVrRkFHUWNqNGh5VXRCSVdwb1FRWVNtcUdq?=
 =?utf-8?B?dkUzR1pRMUxtMEV1c2lMdUlRMUFpaFVLRndQOThPaUJDbWxEQ0ljQ1RQNjNp?=
 =?utf-8?B?VW1RdUFQZzJtZHB5OHRxM1U1T2FZZFhlbXk2K2VIYnBlRFdoaUtJT0VSbS9O?=
 =?utf-8?B?Mmw1Nm5hQ1dueFdBallwY0o2YUdVMVlKY3NjQTZCbkF2OE1mUWgrVW12THhv?=
 =?utf-8?B?aEFGNjBWYTNZeHJjQUFDcG1hdDh6bXhBZGcxc283UzVMQTV3WFVOYmtvK0Rl?=
 =?utf-8?B?dHZSUkZLSk4zQlMrZUlmYWl1Y2QzNXlpVkVFdGx2Sjk2ajZsWUVFdWNpUndV?=
 =?utf-8?B?RXVIOVBrblRsZzM3S0loQytTK1JUV01FdU13UkkvQmpyRWsrZXRIaXJjWXo4?=
 =?utf-8?B?OWNZcXNYbUxVNE90ZFQ2eFFEQ0JuWXJ0Vlh3V1BjcGw0ME5qUUxXQStwUExO?=
 =?utf-8?B?RWhnOCtnM2FiNVVmMGFxekVkYldyL1lFS3BlMEthSlUwSlJjaDR0MzErdjM1?=
 =?utf-8?B?Wlg0TTdEQzdDdllUSllZdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3hTZ1lzSkVKRmFlVmlVQW85TWdKckNMTWI3alR2TFMxR1Y0N1hyQkpiUXVL?=
 =?utf-8?B?Vlo2azdkNWF6UmxDMHp3Rzg4dk9WLzllcHBhOWwvNTVPZW5tQW5RQnpEQmVk?=
 =?utf-8?B?ZHY0Rk9CT1BhWnVXaWdnMThVeXduSnllRklOYmJRLzZFRXlsOVNQVjJqUnl5?=
 =?utf-8?B?dXNuVVhIcmphUGI4WjFudktSZTBVLy9EN0p6R3pFS3BJczJoNmNxeDM1dUNX?=
 =?utf-8?B?ckN1YUJRU2NDVitadHhoSUJBWTRLV0l1RHB2eCtqQXUwYUp1ZklNbi9oQzR3?=
 =?utf-8?B?eG5zWmlwUURhRzREUjhqRTB1bTdnSHphOElTb2NJczI3Q094Z3lMUC83RkFi?=
 =?utf-8?B?VmdpcktYM3FvdkwwdXFrVGlLYWJMNno2enJUdGMydVZUSEt3YjdVQmJSU01n?=
 =?utf-8?B?cC9MMkIxRmJqYnExZGErbWNXdzgrbzdhajVBSmxoMk1oT1NRYzhIUTBDVHVW?=
 =?utf-8?B?ZHU2cG1rTURRY2NZbU1VR2ZqZllmb205bm5mdmhuNTAvOWRJTTdPTXJCUVZY?=
 =?utf-8?B?LzJ6eUhiTjJXVEZtaWRibWRUVWlhVjlsNlEzRkgvaVJLTTE1Szk5MHMxTnN4?=
 =?utf-8?B?M21PL0gzak5kUVBuTVN6QWgzR3FYOGlwY2JrM0k2Qm51blZwcGV2OC9GVFFP?=
 =?utf-8?B?blZXL3U5MHlQRk0rV0JzclF5NXBQWlR6cE9YYkxLS3FpKy9FUjhnRk9SUzhY?=
 =?utf-8?B?dXB6MjltYU1PVkxxR1ZsTWNXVDl3VEg4eWJUakJlMk1zRWNjTVNOL05ybEd3?=
 =?utf-8?B?NXR4dk13K0c2c0ZTYjJMektteWF6YkV6dmE0SFRBR1FWdE9TL1ArbXUrcjNC?=
 =?utf-8?B?dmdFUUU3MnJHaUZIUEdEV0VoQWJFcEtCb2pheDhIMFU4WUZ5QXkxM0F2YUVy?=
 =?utf-8?B?eUY1YzB3V2t0VUd6THVpK1VidUFRdjZaVk8rNmgzcjU3MTRYaUVrcEpJNWZS?=
 =?utf-8?B?K3ZPZldUNVhqQmF5R1JzbGdacm5FRmFhb0diL0lyeHBnVUI1RElWRnVaTjFY?=
 =?utf-8?B?RGF2NndHWTlIRDFSbHBFa3ZPQVdQT1R4VTdQWTVjQzBLbUdsWEs1eTdJcG56?=
 =?utf-8?B?ZHJLTEtNWTNpM2J3Tk40TkhkRnVFb2hkdktTb0VYcGZOOXBVd2JjSng5VlhS?=
 =?utf-8?B?Q3NxVmh4U0Y1VHlkYy9YYkFKL2JZRUdvcFFaRlMycW9EUmhPWldMTnIra3pq?=
 =?utf-8?B?aGVObG0zY1pqVURkbHdLSGZaV1IwRUJwcWRyOWdoMnRTbDZSdE9xMmpNN3F0?=
 =?utf-8?B?Qy9yWDBIZDVnY2hNSnNiQXQvQ2FXamJMWWorYTB4eWpXcEZZQW9xM1U5OWNx?=
 =?utf-8?B?dXhzbmdud2VES2JIZjFQTGwrU2hzVU1GYU0vby9qYTRsMXQyS0RhNG4wUDJC?=
 =?utf-8?B?NXAxUzB1ZVdlK2pjNTcxbUpMcVkyYnplb2x6OW50SDdqN2ducFkvdGJENjIx?=
 =?utf-8?B?b0VpdVBrcTJLQmh3TWFlM0FiSFVjOXhKQ1VPUHR3Y3U1U1MwaDJ3QWVqdFNu?=
 =?utf-8?B?N054ZVBwZ1dORFBSekRBaFMvWC8yUnNSdVVvbEo3a3FaOHRzZ2VFUWorbGxx?=
 =?utf-8?B?RjR1QVpFNkZTNTJNMnViQ21RQ0VFNkhoTS9odnB2VUI2SG1YMnVRVnZBTjFk?=
 =?utf-8?B?TTVFbG1FR3luTk1FSkQvMVFnZ0hHNnJ2ZVNMSnpkZzN5RklFT1dOaTFkM01X?=
 =?utf-8?B?YjBvUForWHU3cWM5MnpPNDNtU1ZDZUxsOERDekNkcExDQ1FUR2JSWmcrVVB3?=
 =?utf-8?B?d3ltR1hVeXJLcXoybVNhYnV2WFo0dlVPMmNCYm5CbDJManI2UHorendLQXhD?=
 =?utf-8?B?OVNHbkRRVHFpcnZTd09BRXB0KzZmZDJWS3l3bWliNzRqMlNUMy94a2IxVnp3?=
 =?utf-8?B?VUhsQnRseHg4S3g0Y3RyZHBVc0ZMZjJZQU4wVUVJK0tGbHVWU1dLV29pV2dj?=
 =?utf-8?B?UU9WdjMrdExQT0daK0VUaHhNR2FMdk5tWGF5MTRCY1IyQnptK05GY0kraW5j?=
 =?utf-8?B?L3Ewc2hoalE2VWVnaWVNRlhGSTNGcFFWZ1pJUWdZMjdoM1h4VVVYWk45YnFa?=
 =?utf-8?B?WGRrZ2Z6cHFyWFRiQ3NVb3Zhb08rUUhyRGFkUDB4S052YklMUkNFdG04Kzd6?=
 =?utf-8?Q?wpb5v3kK5PZv1gHJUcB6+3pSO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651005a-339b-4321-a76b-08dced3a6c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:57:15.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEA5eE2UAr53rbBYbNCfIaRNRHUJcC+jgvcjaNCuxS9fXBwVDlYe/bK1xvt/hLErSqcQyyd0tCNEuqSsC33ypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com

PiBTb3VuZHMgZmluZSB3aXRoIG1lLiBOb3cgaXQgd2lsbCBsb29rIGxpa2UgdGhpcyBiZWxvdy4N
Cj4NCj4NCj4gc3RhdGljIHZvaWQgcmR0Z3JvdXBfYXNzaWduX2NudHJzKHN0cnVjdCByZHRncm91
cCAqcmR0Z3JwKQ0KPiB7DQo+ICAgc3RydWN0IHJkdF9yZXNvdXJjZSAqciA9ICZyZHRfcmVzb3Vy
Y2VzX2FsbFtSRFRfUkVTT1VSQ0VfTDNdLnJfcmVzY3RybDsNCj4NCj4gIGlmICghcmVzY3RybF9h
cmNoX21ibV9jbnRyX2Fzc2lnbl9lbmFibGVkKHIpKQ0KPiAgICAgICByZXR1cm47DQo+DQo+ICBp
ZiAoaXNfbWJtX3RvdGFsX2VuYWJsZWQoKSkNCj4gICAgcmR0Z3JvdXBfYXNzaWduX2NudHJfZXZl
bnQociwgcmR0Z3JwLCBOVUxMLCBRT1NfTDNfTUJNX1RPVEFMX0VWRU5UX0lEKTsNCj4NCj4gIGlm
IChpc19tYm1fbG9jYWxfZW5hYmxlZCgpKQ0KPiAgICByZHRncm91cF9hc3NpZ25fY250cl9ldmVu
dChyLCByZHRncnAsIE5VTEwsIFFPU19MM19NQk1fTE9DQUxfRVZFTlRfSUQpOw0KPg0KPiB9DQo+
DQo+IC8qDQo+ICAqIENhbGxlZCB3aGVuIGEgZ3JvdXAgaXMgZGVsZXRlZC4gQ291bnRlcnMgYXJl
IHVuYXNzaWduZWQgaWYgaXQgd2FzIGluDQo+ICAqIGFzc2lnbmVkIHN0YXRlLg0KPiAgKi8NCj4g
c3RhdGljIHZvaWQgcmR0Z3JvdXBfdW5hc3NpZ25fY250cnMoc3RydWN0IHJkdGdyb3VwICpyZHRn
cnApDQo+IHsNCj4gICBzdHJ1Y3QgcmR0X3Jlc291cmNlICpyID0gJnJkdF9yZXNvdXJjZXNfYWxs
W1JEVF9SRVNPVVJDRV9MM10ucl9yZXNjdHJsOw0KPg0KPiAgIGlmICghcmVzY3RybF9hcmNoX21i
bV9jbnRyX2Fzc2lnbl9lbmFibGVkKHIpKQ0KPiAgICAgICAgcmV0dXJuOw0KPg0KPiAgaWYgKGlz
X21ibV90b3RhbF9lbmFibGVkKCkpDQo+ICByZHRncm91cF91bmFzc2lnbl9jbnRyX2V2ZW50KHIs
IHJkdGdycCwgTlVMTCwgUU9TX0wzX01CTV9UT1RBTF9FVkVOVF9JRCk7DQo+DQo+ICBpZiAoaXNf
bWJtX2xvY2FsX2VuYWJsZWQoKSkNCj4gIHJkdGdyb3VwX3VuYXNzaWduX2NudHJfZXZlbnQociwg
cmR0Z3JwLCBOVUxMLCBRT1NfTDNfTUJNX0xPQ0FMX0VWRU5UX0lEKTsNCj4NCj4gfQ0KDQpNdWNo
IGNsZWFuZXIuIFRoYW5rcy4NCg0KLVRvbnkNCg==

