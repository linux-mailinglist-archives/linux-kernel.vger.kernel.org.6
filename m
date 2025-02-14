Return-Path: <linux-kernel+bounces-515289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AECA362F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E41895BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A17267B6D;
	Fri, 14 Feb 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkvhoYzN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F7267F43
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550031; cv=fail; b=SPapYL9n6BSp16xgz6bmDIq5/K4PPeLdE4b1WJPY/EEBk5C6I6XH8gZnANo3T29C5yMqepKo9sWkKDbqhQLRWrGG+BuQ6Bimb6CwM7nx21WUoEXNbcCH+/N5YQCnGf817ussD3gV1iekiDzPDWaObwHSGXQN4lh2gvk2xqUQ5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550031; c=relaxed/simple;
	bh=otcb2QFdDouzonegvVwTeUYyJsRpcmghRkbZ96Q8A6Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQUtPcEvxhrYRy/ZWFAOaQ8dJlTCRq+E+pc2Ajo7cErnXkvpg/Oajrf8adQlagJGw4SSUxhrPPTXL47NSLSqUcPXkoWB5uzSj3Is0Q9aBPax9Vt0YSrtjbrVdBlw8YK00e7w/3xx036qzBpYqgrTQmXgv9wdTUavGZFoki2x2mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkvhoYzN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550029; x=1771086029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=otcb2QFdDouzonegvVwTeUYyJsRpcmghRkbZ96Q8A6Q=;
  b=NkvhoYzNel88w4n9VWhR6KlL2GEYZJVrX1jdPxQzJ/mjmxSGOPYXB7g9
   rAM3CzmqQZBnyO1qM58tpSkeN7ayyS14miBmYOCxoCJc1pPiwa6ZDn2Dv
   XgmuyFK6p8Mn32g7ntTWRGzUbWPia6P2Q9rlVIzf/h4EaIUWA3N70IuJf
   s8xAeqJfJFyAYYvB4Av37dBoiX0ISP4tbC1cZA22GKWK2Bs7ltfahakiZ
   UMtnl2ZLJumYRzETdKHJB8ksbML9QCggWKXwqw4ySJogPqXP8GHY72g6Q
   +F6M2Op9PPQjDtPYaCsqJJGVJd1rUeuDNqNk4CNgUBykSIiwuLnNACOf4
   g==;
X-CSE-ConnectionGUID: 9ZIUcGoZQkGld5Vb+4KdLA==
X-CSE-MsgGUID: tCdLil3kSl6Cy6pCv+OKsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50933445"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50933445"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:20:12 -0800
X-CSE-ConnectionGUID: XtjGeHN1RtGLCIfuEZJfPA==
X-CSE-MsgGUID: F6McQCGBRkaKyjx80toFig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113451375"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 08:20:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 08:20:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 08:20:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 08:20:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHkVcjMGKZjcnvbfDz33Wbe2TVtK+X5H6/DEz983jS5OsH8KN+fNRn34wK8RV2ym+7twXxYMtgy9PlQnhkus7rGJ23r6etYwqgZb8tOw05paYOpG6SlUBoHlBqisBsoz0x7Lr/waI8OrcoiqWilEDuvTSgFCjufnFfczK48In0QkR6j0Dl3Dk0mWN5EEINNnxlZkwIbIbI1kxxyNZ/MeBdG27e242Oo2xBmVip1XEb93q5D5/QbWu4JyUzQ6zg3kxk9e9UvjxBIMCwcJI7ZjCbiGX80PbEoeuPlYNhAHXJoHgKQAFlwaDAuSTC7Klxf7mceod5GBqb9mJzHReDIl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/IddgDvxjUxGpVPMgM2Q1TWXlpW10VPJ2XFWDtYMgc=;
 b=C5xzsnf1dI2mbR9xSJSZ5h2WoTfFoHJ17kBx+1duUzQkS6ryblfJ44g+DBz3TMMXTt1u8XJD1bYrwKk3oOc1sxsYyuC5w/TjzT4IlUMmCVZO4otCogHAXCUH54gotWCC7cozr57JSdBwXZFYFBO0idU8q2Q0X/9srf48T5uotYvIUY5Eln7KTvD9EYm5JTFfo8B5bRTBOo/D1BSUKn5VKeSH39a+d6frvX6M3kmDUf8MBPunlC01JoDaUyODnTs4iA/ihyWpxxT8abP/6rgvC20KSsAjBjF4CGAWWCinGSddGpMiWToEWZNdsSxbX+FhuMO0LGP+LbXj12HPkL1p7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.15; Fri, 14 Feb 2025 16:19:54 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 16:19:54 +0000
Message-ID: <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
Date: Fri, 14 Feb 2025 10:19:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: b2746d10-f7d5-4969-b267-08dd4d136a21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHNrc05sa3hxTno4UHZrNnlkUVZZd3VuWjRIb1Q2WnBBN2tSbGU4cnF2Umxs?=
 =?utf-8?B?bmx1MStWRTlMc25CZjZ5MHJZNjQvL3pORVBPQ3RJSTRMZWt0WWhTNjhYWWwz?=
 =?utf-8?B?NDhaa1p1L2RydENrVW40dmIvQXlnK1ZsMit0cjZXemZkUGFDYmx5ME05VllN?=
 =?utf-8?B?U0xzMUJ5VjZpS3ZNMHJmTys2czlTV0p3dkhGMTFqMTdtTDZSSWVnS0JIQy9T?=
 =?utf-8?B?dEhYN0RlSVN4QmduS2VzaDk2d2plRko0dTBkdngwMWN3RDhOR3k5cDd3Rncw?=
 =?utf-8?B?OTFNbjZwbXNNR2RENVZLdFBvMEI0eHhvekkvWS9oLzgrNnNHdDF0OWZ2blRW?=
 =?utf-8?B?eU9jTmZyY2xzNTdVdTlXblQydzgwL0hxSzRrdFRCczlOVlQ4ZldaRzFVM09u?=
 =?utf-8?B?VzNvQnUwcnRteEU1SGJXT1JnZ3Z6WmVLRVdvSW5hZ0VmUVM3blowNGg2RjM2?=
 =?utf-8?B?WjF5Vk9iWVl5TW1IWmwxTHY4NmpRMEVhaXZoam5BYWR1TGgwZWVvbmFFaHBl?=
 =?utf-8?B?V1YrNUNJOFNDK1dQL0t3TEFkclFhUUhSYkJaU0tBcFEweGNPdmxZYjNVdEZ5?=
 =?utf-8?B?Z2NJTGlTTVlTWGdRbXZWZnAyY3F4RkM0M3QrY3NEMjFGQTJqMXA0a1ErWUNJ?=
 =?utf-8?B?ODJVVDN0aWFtMlFkcXBMd2N2azVVZ3Bqb3NtNHhXbTh2c2dTZldpMEFGWmxH?=
 =?utf-8?B?dDg1amcreGtWMVRRL0pDcmowQTVJOHg0c0xVaWFnd3pxOXhEdkJpNFpjWXBD?=
 =?utf-8?B?Qkx2Ti9qVFhESlZnMmlZWUZKN3RxUmNkWFhMODdMSkhRUjg3M1YxOUlOMEJ2?=
 =?utf-8?B?ZGtaUUN0eERoanZlRlFDTGpicDZEMzloaWp5QnZLTzI0eEpQWG9iZTFtcmNZ?=
 =?utf-8?B?THJqTmtIOHBHemJySWpiTVJoMTBIRlpVOUFQLzU2bHh6SkcxTHU5RjVndFpU?=
 =?utf-8?B?L0VDSkM4SzFnbnJVMWVORGtKNVJRay9iVE5oSTNFekRBQXhxcG11TXRVeW5y?=
 =?utf-8?B?OVRVc0FjNUx1Nm51WTMzMS9XN1FkZ2p4TDI3MkRYOTJJZWh1d2x0TE1BQTU5?=
 =?utf-8?B?Y3JYTWx2Zlh4UDBzS2M1WWdpMmVUMThzRVNxaHArRW9OZVR4Vkl6a1FTY2xp?=
 =?utf-8?B?UWhTM2ZWWDBqcldsLy9WMkFxMCt5czZPOUtRTWhFZHJCRXB0MlM3VWtrSXF4?=
 =?utf-8?B?S3ZibUJOaE9UbXEvT3FraEMzWS9EVTF1S0kyU1VmejRFSkcreFJycDFKYzMx?=
 =?utf-8?B?R1FxTys1S2VTSUd1UW0xNjgvL1M5MS9wdXVkVU4rRUhtQm1wSFM2ZjRJOXlM?=
 =?utf-8?B?MTFXTXFoWDJaR0tHNEw4bXhjMW5jSWRjU3VKM3B2QVprL0Z2dm1UVUZRZWxC?=
 =?utf-8?B?ZDI0T3hFWm9oaHEwVERzekVmUU1ORk5uSlhoWjFQdFp1Q0xwNTAwRDRia2Fk?=
 =?utf-8?B?RDFwakJ3VllKTEl3ZllnQ29iRHF2YmtuaTBaTi9uMjNJampvN1NuYWJ1NVN6?=
 =?utf-8?B?Mkw5ZDBjSDVLRHFVa3RTQkQ0Ym1WU0Zud0hQYWQ4Wng3THg4WWlFUUZ6cEN0?=
 =?utf-8?B?enhYYTg4SUdoN2F3cndFQ25ONnQyVVZiSWRnMFV2OVlzbUxkaEtHZG9TOGhj?=
 =?utf-8?B?REwyQnFGaFdaL0xJdXhFTHBodUtHeUpXTDZ6M0Y0aDJLRnBFOU1GdGoxNlNH?=
 =?utf-8?B?UVBuZGQ1bnhMMWVxQ1kyd2w1NHlnb1JtdGVaSlRhL3hlWmhVSnhLOW1Jek1t?=
 =?utf-8?B?NFgxRXJ2eGNhRVFEZncyYk5mUUpESnVlK2RTcm9QQW81d0RtM0tnZEdkMFRG?=
 =?utf-8?B?Y29JbjNFb2N1Y2NZUEVMbzdJYzVyRHVtZ2xKUnE4ak9sMWdBQnM2bThIWUx2?=
 =?utf-8?Q?0x4q584qtrKMR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlOMEFGZG52SS9HSHV6MUY2Q04xYm5vWVRqaC9BQnNSUHEyMCtZenJsQTZL?=
 =?utf-8?B?M2ZQbU83YnNjNU0rSHpla2VDUWlwWnN2eXFzSzBIeWczK1YvMk1UemtyTDlY?=
 =?utf-8?B?bkJsQmd6U3dPbG1MR2NZcUxyblFtZVJIbGlhdkk0SGcwNndCd1RJbE1FRFhJ?=
 =?utf-8?B?RlB1K1JSV08rc24wZm8zdzRLZVVSM0VlSndGbGU2NUVNakdPRDZoemYxTS9l?=
 =?utf-8?B?TElrUEZjMVBUcEJ4dWUzME9VY2h3TjMwMEZDOUJ6S1JqbjZJRURFT29TZHY1?=
 =?utf-8?B?SGVGYTlucFNrdTI0Z3I4M0luSUFOYXBIaWtkMExzSTBkYVVEeUJFc00vK2du?=
 =?utf-8?B?SUhYcnRaSkhycDhWNVZlSWVhalRBYVdDd1hLek5TcTNhZXYzbXc0cEdBNXJn?=
 =?utf-8?B?cnhKQm52ODVJL3dlMHNYaG14NC9iZHlwM0dCS09kTmxTS1FvNDJiT2I5VnBv?=
 =?utf-8?B?bWxkeVVqeVh6TXltZjZGdmlIUkJqdHJWbExRMVBEeUZvSjBTZGNaRktac3Vq?=
 =?utf-8?B?bUszQmJ5eTBQME5qZktFM0M4ekM5R3Noc1N0U2dRQjd0NHRzRGd0RHZaditj?=
 =?utf-8?B?ZGI4cVJxK1J4NWtGR004R3BPOVUvYkJmZkkyd1J2Z0syWWFhU1dGZ3RuUlJu?=
 =?utf-8?B?WTZuY3J1MDZvMmQyWGhVelRubUZvRGF5NkFGSFRUa3hVaStKQlFuMG5NR0hO?=
 =?utf-8?B?b2lDOWg3bG9wcExTRkQxaG5KNFdMZDlId3p1bURqRFpML2RzQkI3MEpTTUhr?=
 =?utf-8?B?bDVEbHNERm1yNHgzclRqYVFubWhTZ1U3Q3BzM08rTGRqNjc5WHJmNFpIZlRp?=
 =?utf-8?B?UzRwVjZzdklUSStHQmw1RDhVcHQrSUZtalJhWmNwakFKYzFSbjBmZUg1MEM2?=
 =?utf-8?B?bjJnbU1Vc0pKaktWYnRLS2FFMnYzUFN3SGFmcHErL1ZiODB6YitrWmFDYWlJ?=
 =?utf-8?B?OEJ3OWd2b2NocUI2bVQwT1Z4eUxjZnNhTUdrVnVFdFYwUkRLL2NLZVAwVlNv?=
 =?utf-8?B?NTY1UGZkekJqZWZjQWhaV25JRk9qRUJRNUk1cTcyMXdIckp5ZkNsZk1qSDRa?=
 =?utf-8?B?dWkzZnRjcnhPc2x3QW5Xcm5hQ2l0dUZKcW9KU3JidjhwU3RIYzhwbjNPYXl2?=
 =?utf-8?B?elRSdjZCdjhjK0k4ODVSQ0hwRGx3SStCb09NQ1FJVUlXUW9aaVJ0a2g1QnND?=
 =?utf-8?B?TGhEdVVjWWdWMUtWK253a09tNytUbUdhVEdvZGt6c1JXK3l2T1dyM3dtQTB1?=
 =?utf-8?B?OHphZVF0NHU4RDg3YklubTlxbWlRTXVad21pazB0LzZCTE9yTVcyamRpdWdQ?=
 =?utf-8?B?bHdOTTBQRlpiQk1wQjZiMUhPc25NakVRZWJvQ2REYWlUQmFFSThxWVFnR3NE?=
 =?utf-8?B?N1lHcGw2SWdTdW1rZGUwclV5d29pR1JmL1pkdkJ6d1g5R3RRaUdnZFgyK2gx?=
 =?utf-8?B?NkVMdDVDVzBIRGdlNGwxSnhtZEdCNk52ZDNmN3pWbmRtWFNpcnJ4RFltTWE0?=
 =?utf-8?B?R3ZJOThmVVpHM1VZblMvWXdQa3lJYkhaYmNvaExhbkxTTHFFSU1PdlZTTUFy?=
 =?utf-8?B?Y2p1MGtaWFZyWG5MbEhxcUxhZmMwUDhWSUMzaFhtRm9oRWw2ZEpWb2k3aWxr?=
 =?utf-8?B?SnlUMHlrZHhPcVRkVHhPdXFaa3pjQVNPL1hZYWc3MUJ6QjhZR0pqcm9hS3lQ?=
 =?utf-8?B?aVdVdWNBVU1DS0JRWkpMcERnSDBKUWlEV2dYK0RxTnQvL0dsODBIUVNpYS9p?=
 =?utf-8?B?QTFJVGNGampUSGJadnFtRkQyeVE1MzdXejcyK3RVc1ljaHM3R1ptM1FLYlhz?=
 =?utf-8?B?UzNKMXQ0dW0xZTdoNldTWmxkNXNzZVFmZHRETm9Zd1NVNm93Z2VzaUwyZWxY?=
 =?utf-8?B?bHUySVVKUXpzRWdtdmsxbTJSbGZWOXdJZXpneGpURzhtbTRYQnprSGdiVElk?=
 =?utf-8?B?WVBwVmpOMDZqRE52WVpmRy9KTkZRaVBNaTIvczNaZWVFZFArdlNCcWJJYzlr?=
 =?utf-8?B?YVh0NEYvZHIwNHlXaDZJMnFYbS9lUXJJUG5RYS9zdUdYNjZUUUUyNjRVOWpn?=
 =?utf-8?B?Tmpvd20reEk5V0hGc1BCb1JuRjRiVjBwZ1VwZkt2VTQzRGtUbkpTbGtSem5B?=
 =?utf-8?Q?KIxTJe2Amm3DvoIht0lOs71Wm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2746d10-f7d5-4969-b267-08dd4d136a21
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:53.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKV0XsypVT9mrnjcH8lF2ZYZO2J7p3nG//g0yQx1cD7A7n2qNCKikJrfsY7KpV2oNkOSaEm/l3OuMMlmhJFmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com

On 2/13/2025 5:19 PM, Dave Hansen wrote:
> On 2/13/25 13:50, Xing, Cedric wrote:
>> On 2/13/2025 10:58 AM, Dave Hansen wrote:
> ...
>>> Wait a sec, so there's already ABI for manipulating these? This just
>>> adds a parallel sysfs interface to the existing ABI?
>>>
>> No, this is new. There's no existing ABI for accessing measurement
>> registers from within a TVM (TEE VM). Currently, on TDX for example,
>> reading TDX measurement registers (MRs) must be done by getting a TD
>> quote. And there's no way to extend any RTMRs. Therefore, it would be
>> much easier end users to debug/diagnose measurement related issues
>> (which would almost always require reading MRs) with this patch.
> 
> Ok, that makes sense.
> 
> But if this is for debug, wouldn't these belong better in debugfs? Do we
> really want to maintain this interface forever? There's no shame in debugfs.
> 
There are many other (more important/significant) uses besides debugging.

For example, any applications that make use of runtime measurements must 
extend RTMRs, and this interface provides that exact functionality.

Another example, a policy may be associated with a TD (e.g., CoCo) by 
storing its digest in MRCONFIGID, so that the policy could be verified 
against its digest at runtime. This interface allows applications to 
read MRCONFIGID.


