Return-Path: <linux-kernel+bounces-557969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F6A5DFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E86189A91F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742924E00B;
	Wed, 12 Mar 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfJ8s18i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C315539A;
	Wed, 12 Mar 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792567; cv=fail; b=AVT0sg4HRLZTQupBl5tNLO3M45SifqVGLrD7uRUAr7ZkCep3typfKleQ9RCiy06fHonO5IgId38x2uauOPH5iV7S9e1JB/SBwWTgbHfzwwFwQWmxVjHKfu8NId9L4nzclgPXZ5rvgXFQD1Yqb7jRD/xWMBnKsAPMzABPfm8TJL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792567; c=relaxed/simple;
	bh=P3oTfu7wccpHtybZtxLNXsweZLFeVrd3S04LuKUwpiY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bp5FIs78bJAQUdDfX2GGKvI86LRv2nM+3TOa0A/7rtBYRGX/Gg6r0SBgh/xHRrQfnTifWhSpRSx6nb7Jg6ANjETsxTHlSwJ6dWCszqU2lM/8eKD/fN6jUVMOTOX/9eP+fQ/KsHrRYGEG/TIZ3LBPBF476Elk7KRqUp9G7GiGPuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfJ8s18i; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741792565; x=1773328565;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P3oTfu7wccpHtybZtxLNXsweZLFeVrd3S04LuKUwpiY=;
  b=TfJ8s18iVxErXkgqJRTYQwzuoX57RYehKB2nQQoprtwpXDU8ElXfa8or
   +U/SRXV9AN18mO6F7uGVjnZ3J0rTk3P1W9j8i8Ls9eGo0P3IdTLk68hRE
   QIPPmiJK70qJYRXQbRHc3G7bwXyW/i7nVvd1EhnAAKynDTN9z5mRojdTQ
   QbXCx3deKx1waaB9hoCSCzOTk+NpCFzHC/JgJwlTVV8Meis3aD+jHnLA5
   RfO1Nt9vWw+8Oq+XuhDSWUKSraU/jEhnIJ5VpJ71KeRqbUcmr+kB3YP37
   90HirJiYPLYPJMGxexBXea9gWdwb7gQmBzPrrihBnLsfMKAhufzKpUH6Z
   g==;
X-CSE-ConnectionGUID: ljr88QvTTEuXeJBJxWgftg==
X-CSE-MsgGUID: FjEhcTJgRrSojpeLZHTrcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43007872"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43007872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:16:03 -0700
X-CSE-ConnectionGUID: eyE23OTeTFe5QOHaigRWoQ==
X-CSE-MsgGUID: tFlrXY05StSaJ5LWfvdhXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121573611"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:16:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 08:16:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 08:16:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 08:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev5Fdgk2XHRQTPq/LuYoOp6Ideip7xDmAgwpAjdwPnhZaNosLY4SjUhr4+KkyNLgMqk5WY0lJ5rrSyWulX0kG66U45y1IvsVHZcuMxpnXopAGBEV0pwHgMzpVPdhfqw+5LMgiGru5eikM0hUrrM0Ec8KGYW+QwN1f9O/C0sL4jPNA8lI9jW2IdgQpQKDL/Evyy6NRArkbrE2Ml530NWRfJ17cPz4DLKjIoB0B/p+TGNY0/tSLf20r03E9WiuFcd3ZnJe6MqaVcOIU+cZqZ6+X5OicBnl1k9mx66IVTIVDz16RsNw6c56Yo5EgH30S/6kqL5RP9R8H4OE9b9yz2ggAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U1J2nsa2Hbv6ZVwWAwJXpx4WNB9g/PJ17KBlWycVJU=;
 b=AY243aMQ4hxkaLG0tNy1c2WHa7ZLK8w5zg7VnsaAl6ns9+r3xDDyR6nqXbRVhcRdCQbvQtJU9zE/jknNvWVFt39j2QeOARc+GjEWRFyhvscgPZb7PWcAYxzT6DaaNpHr/73rug2OoK7P92hsQnFrVFSbOitB2dSRJsqJEg8FnMwkCQ6y+cZmLhjZ5ca1R8JCTYAOib6TUn6GMhnkdJ6nNsc+Tr6fzh7VSfMzX6RdmyzkCuZQuJ/pdOdeVRrFZB+UfONiMmoM1ivOemS81CRbxSrda1kCmYarFOJ3Hwcb05xRdgzBO4z1OAcgf1asM+DO3m4e2gGjvXk4MzI+2goCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:15:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:15:10 +0000
Message-ID: <4846d553-1918-4f1e-baec-44babd3f0c82@intel.com>
Date: Wed, 12 Mar 2025 08:15:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Luck, Tony" <tony.luck@intel.com>, "Moger, Babu" <babu.moger@amd.com>
CC: "Moger, Babu" <bmoger@amd.com>, Peter Newman <peternewman@google.com>,
	Dave Martin <Dave.Martin@arm.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
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
References: <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <Z9CiwLrhuTODruCj@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z9CiwLrhuTODruCj@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8609fd8e-e49a-429b-c578-08dd6178ae05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG5GNFE2R0paaW8rRWVvK1Y2MTJocDU2eHA1WGMxdkNHZVBKejArYXVVeWNY?=
 =?utf-8?B?YjlhejAwcmNOdm1qczJFaHJjZ1dMQm9PYXJBek9wSXZ5aVdENXEycUZQSzMr?=
 =?utf-8?B?V0hLNGZWRUN4bnlPRllpQUErenk1Um1wREF2VHpXUm5pOWRKd3ZPeGRPZGpB?=
 =?utf-8?B?QWFuM3UrZ1pqTGtLeG96NmdDSEdaYlp1S3VmSlAxaURlZjd2TDZFSG5SaXB0?=
 =?utf-8?B?U3I2VE1oSUxxYWFvUW83M1JOUlNrWDhIZDA4UUlMWmNjQUhRRUErQVhub2FI?=
 =?utf-8?B?U3dUS0Fyd2Fyckx5ZTlDOEg2Q2pTenNkUi9RYUQ1Rk1XSEVrVVRPdmZPaUFX?=
 =?utf-8?B?Zkk5dS9BMEttb1paQWZoQU91eExmQ1JFTEVtMVBjaHRnOS8zN3pjTE5NTGpQ?=
 =?utf-8?B?VG45UDdWdTRrYTRSRFl3d0oxOTdRZEl5dlZZTzhLN3M4Sy95VFgrTlcydFgz?=
 =?utf-8?B?WXdoL0RnSGFLNnpTS0lQRG5jVy9NU3JpelJEWEdhdHBSeHhGMlVMNnhmUGtR?=
 =?utf-8?B?aS9RV0NTeEVQMzBuam9BL3lnSmFrcFhUY0RuMEd5bTQ5ampxVndNRDJrYnpT?=
 =?utf-8?B?OVJqbTJOQUZ6Q2VGK0hwTitWMEk5aXpqWHJ4eUk1MmUyMm14UmpPOFhEekhs?=
 =?utf-8?B?NXNucG1rTlFuRHNCQkpmRldEWEtRSzRFdzVwSXJKZ2F3YUFHZUJjYm9DYkxa?=
 =?utf-8?B?eVBCcVREa1JsUXJUUnp5dzRsWnZ3bWpnU3FScndBaVJxZlBZWWJ3amYvS2tW?=
 =?utf-8?B?TFRRMVdkSWRHZTJiRmJYTjNIeEFhS1dGN21PY2ZLdzlpRGc4SFhiMVlNcU9K?=
 =?utf-8?B?L3U5dFRmM2NWUllkTmo3VXhDWmowVHJxNGthcFJmMHV0cStINnNHZlo2RWkr?=
 =?utf-8?B?aStRUVlROFVNdmVaTURpcmZscGhkMndQTmFMRXZnbk9QYkdGYmVtNnZ2T2E4?=
 =?utf-8?B?QnY1Q3RJemxueE1EcjQ3cmFFQ253WHZTZEU4c2dyTEE2bmFKN0dNazlabjdQ?=
 =?utf-8?B?dE9xLzRGcW84T052RUx4bU9DNkozQ2c5M0hTREljemh6T3FWbTdOeXhVS0Zi?=
 =?utf-8?B?cnlFcTEyaVVZV3NlT3VTUFVhdGU0dXVyUStrRmZEVFZZYVczVnV1SlZzZ3BV?=
 =?utf-8?B?Mnpudi9jR2FGWFphMitRYlRGTlkyU0VnU3AvNmNILzhDYnIxMWhxWWVUZVlS?=
 =?utf-8?B?WXdNNnhMNkdXem56UndPREV6ZlVFRnRRUEl1cXlYT1dxT0pUZE9Kc1QzMitz?=
 =?utf-8?B?ZGJ4QjB6WXNoeWE0NXV1YWdiY0ZPdkhYbE0vYzk1alMvU3dYS2lOV0xiU0hw?=
 =?utf-8?B?cWUyOTd1elM3b3JZMWxKTXN3QllKUVZBSTBsWDBZUFRyWFV5Yk5JY01QelJw?=
 =?utf-8?B?am5GMHA0dkNOZi8xSTBqcnd0dHA5elNRdnJMajFPUy9PcUd1YlJLeUNNYkFi?=
 =?utf-8?B?ZXZEd3lrbnpkbnpUQTZWWEZmNlc4d2c0NEhFcWthaEt3STF2TXRxci9OK3dB?=
 =?utf-8?B?c2NEeFVpWGNNcHNoQTZQQjUzV0orRFV0TThuRkJnTzBhV0ZBMFd4SWp4bmtT?=
 =?utf-8?B?SHZjYWlNc3ZkcmxEb3l4blErTFlaU3ZQenVWQzM3bXduaE96eVdHK3B5WVo4?=
 =?utf-8?B?MnpNVFM0ZE5jMHIycmZZZ1dpRzQ5S0lhMVh5T2Roem4yck1sMzV2S0xYa2Mx?=
 =?utf-8?B?eEx5Q2oxNWlYQUM4anBlNy9KNWtKcWs4ZVJYeWhwSS9xOXZ5azh2b2dSNVh5?=
 =?utf-8?B?QmJjY0FZREx0c0lvMkJ0RmFIYUg4dG9NZzdHY005V05tMHVBUlBFY2JNak0x?=
 =?utf-8?B?RDVLSjY3alVML3Fyb2FBNzV5TW4rMFBzdm5oOU92NXQ0QU14U3R1WXFENVht?=
 =?utf-8?B?K1dBR2FiMU5sVElIWU9Vd3F5UFYxWVpYRlZrdi81em5Ra3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNnVnIzcFh6MTdVWTB1ZndGekUyQ2RtNFJBQU5FZjNDRzhjT1hSWTIzRjVX?=
 =?utf-8?B?UFplUVVUd1AwdTM0OFBaclg2elRjQmVvUUVwS3ZTMDZpUzBSZTVrRlQrS0Yv?=
 =?utf-8?B?UTV6OWNuTnVRb3Z6ZWZsUXNhOGRybnd4RkszZ1pxM2NhWXBYVVNhd0xyZXps?=
 =?utf-8?B?OFdHMXB0Y2g0RThpKzdNNVBMbjNqM2hrM3BQbit3aFErU1Q3UXkvdnBIRHNo?=
 =?utf-8?B?MkF2dk5mNUdYQWRmTFlnM2R0N2hHUVREbURqbkhNaS8yalVoME1rVlJFYVgr?=
 =?utf-8?B?elBRaGIwNTZrRTlzcWF0ckUzRGEzQUo5V051ejBhWnlYRkRBSDhDeDl5V0Rq?=
 =?utf-8?B?U055RHZ2WjY5TjNDbVBIUC8zRmJUdThYQTlSZGpTaHhLQ0N3R3ExN0NrbnM3?=
 =?utf-8?B?M1MvMVlualJIREI0UG5saW5TaHlTOFZ5VUtxY05yV0tPdUdZbHVveTVTWFZR?=
 =?utf-8?B?Yko1VGVMbHIxdWpMMVBFWlAraEs1MUlEQkZWRnoxMmxDZVBMZG1DRXFObkRC?=
 =?utf-8?B?UEx6cUNWNlh6cjBsb2pBeDJDWEhHSmhuZzg1ejZTTC91Q29EemVmMHJKN052?=
 =?utf-8?B?d1diZkpQTXRTeUdMeGh3N0RlM0Nvczg4OHF4aHR6amVqYUROem5IczJ2VFNi?=
 =?utf-8?B?NW1GWHljRmV6ZjFuZTQ4Yld4ZFVjZ3ZXRDYxdHlHVFFoYmx2OXU0OXgveGli?=
 =?utf-8?B?cWFzcHBHWnFjL1kxVWNXZnB1OWUyclMxTFUwWlVnVVRHZ0JESk1jc0VJVVls?=
 =?utf-8?B?TlhEekN0bFl5bE5kQW1ST0JRVk1HNjUxWVZFOWc3Wno0VW4yVzduUktDMTNH?=
 =?utf-8?B?SDNmbDZ4bExhRGwwOGhhQlFZUW1yMzlCNzVoNitGb1JtQ1JTSmlyNndMcmU5?=
 =?utf-8?B?QndVMEhIMmNYUHI5RDVwck13a3ZEQktuZWM2aER3NFA1MW1UU0hYaEpJYnFh?=
 =?utf-8?B?MW5sbms1RGZEQTkwTnYrRSswODgwbElGaFREeTNnTm9jdGs3M09kVEczVTh4?=
 =?utf-8?B?L1JOQVZKdWo3RmJ5U1dnc0hCUGtHZENIUTVVZk5GTlI3ZFdjeFF4ektwamRw?=
 =?utf-8?B?MVkyV0c1eTN6NXpOSHBpY01OTnNxNkU2STFldkd5MlVYbmcwaUZEb21CYTFZ?=
 =?utf-8?B?a2wyWDk0T2VtTk43eitmRDNnOTNBRTRpeU9iSU9zSXlIY3FJYnByZDgwdG9U?=
 =?utf-8?B?aktLdXlmNGxwMFM0OHJ2YWFjT2phRnM2UFl5Q3Q5ajVoZE9icnpLR1JmOXZH?=
 =?utf-8?B?QThvbzRrL1E5RGdUTm5oSjFDNVBaWnhPaktIbU0rVXlzUVpadXBLT3NxQWlC?=
 =?utf-8?B?M21uRmN2YlVycUg5SGNRdmFrajJVa3JuSEVLaXpKMzZTd255dE95R1k3Tjh1?=
 =?utf-8?B?U2d6Q2xXZ2ZVYjBlS21RemJoRTBwS0NPbVpNclhwOENNcEJ0cG9EVzJ1Z0pT?=
 =?utf-8?B?aGh5N2tqMjlxdnl0OUl1c2xxNXJ4UU9zaVhnMlhTWU5uSndyK3pxdWduMGxY?=
 =?utf-8?B?OExuN0RDY2VzUDZpTjFBQ1BoT2Fwb1J0UXNKWXlJYVBtRW9hdDhWOGk2YjEr?=
 =?utf-8?B?Q3h3L0dpODZCZ2IrdkVZNE5CbHE4YVRxMktlNFFrV0lvb1R1UjVXM2toaGFz?=
 =?utf-8?B?Smh0dmRYdTMvbE52d1pmR0JiTmhteHZuanBZcWdLaDJDY1huRkYrd09OQjRD?=
 =?utf-8?B?ME50UzQzOUowSzVJcGg4UVlkMExRVVhPOFdtTjZvVDRlVUszOTB2clB6Z0sr?=
 =?utf-8?B?SVJybnhkSk9WK1FyS2t2cGxEWFBPMnJvUjdqeUtrQWxGZ0hrQ3U5MTBXVjNz?=
 =?utf-8?B?eFpHZDZUaDBhR3V3M3QwK2Z6bit3d1ZyTlFQclYrcWRXbG1zUHF1Y0NaZ3V2?=
 =?utf-8?B?SEoxT0pRR1lQbURYV3ZPSkVzQWRFQTNQd2cvczMyM1JKTzZLaW4vb28xcEF3?=
 =?utf-8?B?dXdlL2V5VEN3M0llK1doR211OWpzSDlEUEVIK0pkK3R4SUk0ZmVxL2RHOXRM?=
 =?utf-8?B?UTFmbVovdG8xWkd4MDRYblpseGtPaXd1eCtXNXpaMmhKMnlUOTJ4ejk1M0xu?=
 =?utf-8?B?VUpwZ1RDalRoRDdTcXdkTzBxRUFQWXVMOUt2K2FENVFjZDh3NzdldGxOdFJN?=
 =?utf-8?B?N2xrb2NLeHpPWWhyMmJFKzhOSUZHR2VIQTd3bHZBOTFsdmpCVnJkWmdCR2RT?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8609fd8e-e49a-429b-c578-08dd6178ae05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:15:10.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnBUuzm/r3NtDLpKqwhR7BxYf7yMOpz1FoduRlhfaGJ9zOJQvVmr9wmha+QMlQPaw5/aLGO2VZU7hvwxzcxe9/SyEPWdD9IFCzYF426haDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com

Hi Tony,

On 3/11/25 1:53 PM, Luck, Tony wrote:
> On Tue, Mar 11, 2025 at 03:35:28PM -0500, Moger, Babu wrote:
>> Hi All,
>>
>> On 3/10/25 22:51, Reinette Chatre wrote:
>>>
>>>
>>> On 3/10/25 6:44 PM, Moger, Babu wrote:
>>>> Hi Tony,
>>>>
>>>> On 3/10/2025 6:22 PM, Luck, Tony wrote:
>>>>> On Mon, Mar 10, 2025 at 05:48:44PM -0500, Moger, Babu wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> On 3/5/2025 1:34 PM, Moger, Babu wrote:
>>>>>>> Hi Peter,
>>>>>>>
>>>>>>> On 3/5/25 04:40, Peter Newman wrote:
>>>>>>>> Hi Babu,
>>>>>>>>
>>>>>>>> On Tue, Mar 4, 2025 at 10:49 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Peter,
>>>>>>>>>
>>>>>>>>> On 3/4/25 10:44, Peter Newman wrote:
>>>>>>>>>> On Mon, Mar 3, 2025 at 8:16 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi Peter/Reinette,
>>>>>>>>>>>
>>>>>>>>>>> On 2/26/25 07:27, Peter Newman wrote:
>>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2/25/25 11:11, Peter Newman wrote:
>>>>>>>>>>>>>> Hi Reinette,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>>>>>>>>>>>> for.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>>>>>>>>>>>> customers.
>>>>>>>>>>>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>>>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>>>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>>>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>>>>>>>>>>>> event names.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thank you for clarifying.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>>>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>>>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>>>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>>>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>>>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>>>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>>>>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>>>>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>>>>>>>>>>>> configuration is a requirement?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>>>>>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>>>>>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>>>>>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>>>>>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>>>>>>>>>>>> there's less pressure on the counters.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>>>>>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>>>>>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>>>>>>>>>>>> many counters the group needs in each domain.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>>>>>>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>>>>>>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>>>>>>>>>>>> of the hardware.
>>>>>>>>>>>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>>>>>>>>>>>> earlier example copied below:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>>>>>>>>>>>> I understand it:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>>>>>>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>>>>>>>>>>>> in domain 1, resulting in:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>>>>>>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill
>>>>>>>>>>>>>>>>>     counter 1: LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>     counter 2: LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>     counter 3: VictimBW
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>>>>>>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>>>>>>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>>>>>>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>>>>>>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>>>>>>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>>>>>>>>>>>> system configuration, the user will settle on a handful of useful
>>>>>>>>>>>>>>>> groupings to count.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>    # define global configurations (in ABMC terms), not necessarily in this
>>>>>>>>>>>>>>>>    # syntax and probably not in the mbm_assign_control file.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>    r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>    w=VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>    # legacy "total" configuration, effectively r+w
>>>>>>>>>>>>>>>>    t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>    /group0/0=t;1=t
>>>>>>>>>>>>>>>>    /group1/0=t;1=t
>>>>>>>>>>>>>>>>    /group2/0=_;1=t
>>>>>>>>>>>>>>>>    /group3/0=rw;1=_
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> - group2 is restricted to domain 0
>>>>>>>>>>>>>>>> - group3 is restricted to domain 1
>>>>>>>>>>>>>>>> - the rest are unrestricted
>>>>>>>>>>>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I see. Thank you for the example.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> resctrl supports per-domain configurations with the following possible when
>>>>>>>>>>>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>      /group0/0=t;1=t
>>>>>>>>>>>>>>>      /group1/0=t;1=t
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>>>>>>>>>>>> be configured differently in each domain.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>>>>>>>>>>>> reasonable to carry this forward to what will be supported next.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The hardware supports both a per-domain mode, where all groups in a
>>>>>>>>>>>>>> domain use the same configurations and are limited to two events per
>>>>>>>>>>>>>> group and a per-group mode where every group can be configured and
>>>>>>>>>>>>>> assigned freely. This series is using the legacy counter access mode
>>>>>>>>>>>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>>>>>>>>>>>> in the domain can be read. If we chose to read the assigned counter
>>>>>>>>>>>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>>>>>>>>>>>> rather than asking the hardware to find the counter by RMID, we would
>>>>>>>>>>>>>> not be limited to 2 counters per group/domain and the hardware would
>>>>>>>>>>>>>> have the same flexibility as on MPAM.
>>>>>>>>>>>>>
>>>>>>>>>>>>> In extended mode, the contents of a specific counter can be read by
>>>>>>>>>>>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>>>>>>>>>>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>>>>>>>>>>>> QM_CTR will then return the contents of the specified counter.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It is documented below.
>>>>>>>>>>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>>>>>>>>>>>    Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>>>>>>>>>>>
>>>>>>>>>>>>> We previously discussed this with you (off the public list) and I
>>>>>>>>>>>>> initially proposed the extended assignment mode.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>>>>>>>>>>>> counters to be assigned to the same group, rather than being limited to
>>>>>>>>>>>>> just two.
>>>>>>>>>>>>>
>>>>>>>>>>>>> However, the challenge is that we currently lack the necessary interfaces
>>>>>>>>>>>>> to configure multiple events per group. Without these interfaces, the
>>>>>>>>>>>>> extended mode is not practical at this time.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>>>>>>>>>>>> require modifications to the existing interface, allowing us to continue
>>>>>>>>>>>>> using it as is.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> (I might have said something confusing in my last messages because I
>>>>>>>>>>>>>> had forgotten that I switched to the extended assignment mode when
>>>>>>>>>>>>>> prototyping with soft-ABMC and MPAM.)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Forcing all groups on a domain to share the same 2 counter
>>>>>>>>>>>>>> configurations would not be acceptable for us, as the example I gave
>>>>>>>>>>>>>> earlier is one I've already been asked about.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don’t see this as a blocker. It should be considered an extension to the
>>>>>>>>>>>>> current ABMC series. We can easily build on top of this series once we
>>>>>>>>>>>>> finalize how to configure the multiple event interface for each group.
>>>>>>>>>>>>
>>>>>>>>>>>> I don't think it is, either. Only being able to use ABMC to assign
>>>>>>>>>>>> counters is fine for our use as an incremental step. My longer-term
>>>>>>>>>>>> concern is the domain-scoped mbm_total_bytes_config and
>>>>>>>>>>>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>>>>>>>>>>>> there's already an expectation that the files are present when BMEC is
>>>>>>>>>>>> supported.
>>>>>>>>>>>>
>>>>>>>>>>>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>>>>>>>>>>>> ABMC when only the BMEC-style event configuration interface exists.
>>>>>>>>>>>> The scope of my issue is just whether enabling "full" ABMC support
>>>>>>>>>>>> will require an additional opt-in, since that could remove the BMEC
>>>>>>>>>>>> interface. If it does, it's something we can live with.
>>>>>>>>>>>
>>>>>>>>>>> As you know, this series is currently blocked without further feedback.
>>>>>>>>>>>
>>>>>>>>>>> I’d like to begin reworking these patches to incorporate Peter’s feedback.
>>>>>>>>>>> Any input or suggestions would be appreciated.
>>>>>>>>>>>
>>>>>>>>>>> Here’s what we’ve learned so far:
>>>>>>>>>>>
>>>>>>>>>>> 1. Assignments should be independent of BMEC.
>>>>>>>>>>> 2. We should be able to specify multiple event types to a counter (e.g.,
>>>>>>>>>>> read, write, victimBM, etc.). This is also called shared counter
>>>>>>>>>>> 3. There should be an option to assign events per domain.
>>>>>>>>>>> 4. Currently, only two counters can be assigned per group, but the design
>>>>>>>>>>> should allow flexibility to assign more in the future as the interface
>>>>>>>>>>> evolves.
>>>>>>>>>>> 5. Utilize the extended RMID read mode.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Here is my proposal using Peter's earlier example:
>>>>>>>>>>>
>>>>>>>>>>> # define event configurations
>>>>>>>>>>>
>>>>>>>>>>> ========================================================
>>>>>>>>>>> Bits    Mnemonics       Description
>>>>>>>>>>> ====   ========================================================
>>>>>>>>>>> 6       VictimBW        Dirty Victims from all types of memory
>>>>>>>>>>> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
>>>>>>>>>>> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
>>>>>>>>>>> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
>>>>>>>>>>> 2       LclNTWr         Non-temporal writes to local NUMA domain
>>>>>>>>>>> 1       mtFill          Reads to memory in the non-local NUMA domain
>>>>>>>>>>> 0       LclFill         Reads to memory in the local NUMA domain
>>>>>>>>>>> ====    ========================================================
>>>>>>>>>>>
>>>>>>>>>>> #Define flags based on combination of above event types.
>>>>>>>>>>>
>>>>>>>>>>> t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> l = LclFill, LclNTWr, LclSlowFill
>>>>>>>>>>> r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>> w = VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> v = VictimBW
>>>>>>>>>>>
>>>>>>>>>>> Peter suggested the following format earlier :
>>>>>>>>>>>
>>>>>>>>>>> /group0/0=t;1=t
>>>>>>>>>>> /group1/0=t;1=t
>>>>>>>>>>> /group2/0=_;1=t
>>>>>>>>>>> /group3/0=rw;1=_
>>>>>>>>>>
>>>>>>>>>> After some inquiries within Google, it sounds like nobody has invested
>>>>>>>>>> much into the current mbm_assign_control format yet, so it would be
>>>>>>>>>> best to drop it and distribute the configuration around the filesystem
>>>>>>>>>> hierarchy[1], which should allow us to produce something more flexible
>>>>>>>>>> and cleaner to implement.
>>>>>>>>>>
>>>>>>>>>> Roughly what I had in mind:
>>>>>>>>>>
>>>>>>>>>> Use mkdir in a info/<resource>_MON subdirectory to create free-form
>>>>>>>>>> names for the assignable configurations rather than being restricted
>>>>>>>>>> to single letters.  In the resulting directory, populate a file where
>>>>>>>>>> we can specify the set of events the config should represent. I think
>>>>>>>>>> we should use symbolic names for the events rather than raw BMEC field
>>>>>>>>>> values. Moving forward we could come up with portable names for common
>>>>>>>>>> events and only support the BMEC names on AMD machines for users who
>>>>>>>>>> want specific events and don't care about portability.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I’m still processing this. Let me start with some initial questions.
>>>>>>>>>
>>>>>>>>> So, we are creating event configurations here, which seems reasonable.
>>>>>>>>>
>>>>>>>>> Yes, we should use portable names and are not limited to BMEC names.
>>>>>>>>>
>>>>>>>>> How many configurations should we allow? Do we know?
>>>>>>>>
>>>>>>>> Do we need an upper limit?
>>>>>>>
>>>>>>> I think so. This needs to be maintained in some data structure. We can
>>>>>>> start with 2 default configurations for now.
>>>
>>> There is a big difference between no upper limit and 2. The hardware is
>>> capable of supporting per-domain configurations so more flexibility is
>>> certainly possible. Consider the example presented by Peter in:
>>> https://lore.kernel.org/lkml/CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com/
>>>
>>>>>>>>>> Next, put assignment-control file nodes in per-domain directories
>>>>>>>>>> (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
>>>>>>>>>> counter-configuration name into the file would then allocate a counter
>>>>>>>>>> in the domain, apply the named configuration, and monitor the parent
>>>>>>>>>> group-directory. We can also put a group/resource-scoped assign_* file
>>>>>>>>>> higher in the hierarchy to make it easier for users who want to
>>>>>>>>>> configure all domains the same for a group.
>>>>>>>>>
>>>>>>>>> What is the difference between shared and exclusive?
>>>>>>>>
>>>>>>>> Shared assignment[1] means that non-exclusively-assigned counters in
>>>>>>>> each domain will be scheduled round-robin to the groups requesting
>>>>>>>> shared access to a counter. In my tests, I assigned the counters long
>>>>>>>> enough to produce a single 1-second MB/s sample for the per-domain
>>>>>>>> aggregation files[2].
>>>>>>>>
>>>>>>>> These do not need to be implemented immediately, but knowing that they
>>>>>>>> work addresses the overhead and scalability concerns of reassigning
>>>>>>>> counters and reading their values.
>>>>>>>
>>>>>>> Ok. Lets focus on exclusive assignments for now.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Having three files—assign_shared, assign_exclusive, and unassign—for each
>>>>>>>>> domain seems excessive. In a system with 32 groups and 12 domains, this
>>>>>>>>> results in 32 × 12 × 3 files, which is quite large.
>>>>>>>>>
>>>>>>>>> There should be a more efficient way to handle this.
>>>>>>>>>
>>>>>>>>> Initially, we started with a group-level file for this interface, but it
>>>>>>>>> was rejected due to the high number of sysfs calls, making it inefficient.
>>>>>>>>
>>>>>>>> I had rejected it due to the high-frequency of access of a large
>>>>>>>> number of files, which has since been addressed by shared assignment
>>>>>>>> (or automatic reassignment) and aggregated mbps files.
>>>>>>>
>>>>>>> I think we should address this as well. Creating three extra files for
>>>>>>> each group isn’t ideal when there are more efficient alternatives.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Additionally, how can we list all assignments with a single sysfs call?
>>>>>>>>>
>>>>>>>>> That was another problem we need to address.
>>>>>>>>
>>>>>>>> This is not a requirement I was aware of. If the user forgot where
>>>>>>>> they assigned counters (or forgot to disable auto-assignment), they
>>>>>>>> can read multiple sysfs nodes to remind themselves.
>>>>>>>
>>>>>>> I suggest, we should provide users with an option to list the assignments
>>>>>>> of all groups in a single command. As the number of groups increases, it
>>>>>>> becomes cumbersome to query each group individually.
>>>>>>>
>>>>>>> To achieve this, we can reuse our existing mbm_assign_control interface
>>>>>>> for this purpose. More details on this below.
>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The configuration names listed in assign_* would result in files of
>>>>>>>>>> the same name in the appropriate mon_data domain directories from
>>>>>>>>>> which the count values can be read.
>>>>>>>>>>
>>>>>>>>>>    # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>    # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>    # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>    # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>> LclFill
>>>>>>>>>> LclNTWr
>>>>>>>>>> LclSlowFill
>>>>>>>>>
>>>>>>>>> I feel we can just have the configs. event_filter file is not required.
>>>>>>>>
>>>>>>>> That's right, I forgot that we can implement kernfs_ops::open(). I was
>>>>>>>> only looking at struct kernfs_syscall_ops
>>>>>>>>
>>>>>>>>>
>>>>>>>>> #cat info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>> LclFill <-rename these to generic names.
>>>>>>>>> LclNTWr
>>>>>>>>> LclSlowFill
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think portable and non-portable event names should both be available
>>>>>>>> as options. There are simple bandwidth measurement mechanisms that
>>>>>>>> will be applied in general, but when they turn up an issue, it can
>>>>>>>> often lead to a more focused investigation, requiring more precise
>>>>>>>> events.
>>>>>>>
>>>>>>> I aggree. We should provide both portable and non-portable event names.
>>>>>>>
>>>>>>> Here is my draft proposal based on the discussion so far and reusing some
>>>>>>> of the current interface. Idea here is to start with basic assigment
>>>>>>> feature with options to enhance it in the future. Feel free to
>>>>>>> comment/suggest.
>>>>>>>
>>>>>>> 1. Event configurations will be in
>>>>>>>      /sys/fs/resctrl/info/L3_MON/counter_configs/.
>>>>>>>
>>>>>>>      There will be two pre-defined configurations by default.
>>>>>>>
>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>>>>>>      LclFill, LclNTWr,LclSlowFill,VictimBM,RmtSlowFill,LclSlowFill,RmtFill
>>>>>>>
>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>      LclFill, LclNTWr, LclSlowFill
>>>>>>>
>>>>>>> 2. Users will have options to update these configurations.
>>>>>>>
>>>>>>>      #echo "LclFill, LclNTWr, RmtFill" >
>>>>>>>         /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>
>>>>> This part seems odd to me. Now the "mbm_local_bytes" files aren't
>>>>> reporting "local_bytes" any more. They report something different,
>>>>> and users only know if they come to check the options currently
>>>>> configured in this file. Changing the contents without changing
>>>>> the name seems confusing to me.
>>>>
>>>> It is the same behaviour right now with BMEC. It is configurable.
>>>> By default it is mbm_local_bytes, but users can configure whatever they want to monitor using /info/L3_MON/mbm_local_bytes_config.
>>>>
>>>> We can continue the same behaviour with ABMC, but the configuration will be in /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes.
>>>
>>> This could be supported by following Peter's original proposal where the name
>>> of the counter configuration is provided by the user via a mkdir:
>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>
>>> As he mentioned there could be pre-populated mbm_local_bytes/mbm_total_bytes.
>>
>> Sure. We can do that. I was thinking in the first phase, just provide the
>> default pre-defined configuration and option to update the configuration.
>>
>> We can add the mkdir support later. That way we can provide basic ABMC
>> support without too much code complexity with mkdir support.
>>
>>>
>>>>
>>>>>
>>>>>>>
>>>>>>>      # #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>      LclFill, LclNTWr, RmtFill
>>>>>>>
>>>>>>> 3. The default configurations will be used when user mounts the resctrl.
>>>>>>>
>>>>>>>      mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>      mkdir /sys/fs/resctrl/test/
>>>>>>>
>>>>>>> 4. The resctrl group/domains can be in one of these assingnment states.
>>>>>>>      e: Exclusive
>>>>>>>      s: Shared
>>>>>>>      u: Unassigned
>>>>>>>
>>>>>>>      Exclusive mode is supported now. Shared mode will be supported in the
>>>>>>> future.
>>>>>>>
>>>>>>> 5. We can use the current /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>> to list the assignment state of all the groups.
>>>>>>>
>>>>>>>      Format:
>>>>>>>      "<CTRL_MON group>/<MON group>/<confguration>:<domain_id>=<assign state>"
>>>>>>>
>>>>>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>      test//mbm_total_bytes:0=e;1=e
>>>>>>>      test//mbm_local_bytes:0=e;1=e
>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>
>>> This would make mbm_assign_control even more unwieldy and quicker to exceed a
>>> page of data (these examples never seem to reflect those AMD systems with the many
>>> L3 domains). How to handle resctrl files larger than 4KB needs to be well understood
>>> and solved when/if going this route.
>>
>> This problem is not specific this series. I feel it is a generic problem
>> to many of the semilar interfaces. I dont know how it is addressed. May
>> have to investigate on this. Any pointers would be helpful.
>>
>>
>>>
>>> There seems to be two opinions about this file at moment. Would it be possible to
>>> summarize the discussion with pros/cons raised to make an informed selection?
>>> I understand that Google as represented by Peter no longer requires/requests this
>>> file but the motivation for this change seems new and does not seem to reduce the
>>> original motivation for this file. We may also want to separate requirements for reading
>>> from and writing to this file.
>>
>> Yea. We can just use mbm_assign_control for reading the assignment states.
>>
>> Summary: We have two proposals.
>>
>> First one from Peter:
>>
>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>
>>
>> Pros
>> a.  Allows flexible creation of free-form names for assignable
>> configurations, stored in info/L3_MON/counter_configs/.
>>
>> b.  Events can be accessed using corresponding free-form names in the
>> mon_data directory, making it clear to users what each event represents.
>>
>>
>> Cons:
>> a. Requires three separate files for assignment in each group
>> (assign_exclusive, assign_shared, unassign), which might be excessive.
>>
>> b. No built-in listing support, meaning users must query each group
>> individually to check assignment states.
> 
> How big of a problem is this in reality? I'd assume that users of this
> feature would only reassign counter attributes at some slow rate (set
> up counters, measure for at least a few seconds, then set up for next
> measurement). Cost to open/read/close a few hundred kernfs files isn't
> very high. Biggest cost might be hogging the resctrl mutex which would
> cause jitter in the tasks reading data from resctrl monitors.

Good point. The length of holding the resctrl mutex should also be
considered when exploring the mbm_assign_control file. If a user attempts
to make many changes using a single file like that then holding the resctrl
mutex during entire configuration may also have a big impact. This may be
of more concern with the additional automation being added to resctrl, for
example the upcoming "shared assignment" that does automatic assignment of
counters.

> 
> Anyone doing this at scale should be able to keep track of what they set,
> so wouldn't need to read at all. I'm not a big believer in "multiple
> agents independently tweaking resctrl without knowledge of each other".
> 
>>
>> Second Proposal (Mine)
>>
>> https://lore.kernel.org/lkml/a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com/
>>
>> Pros:
>>
>> a. Maintains the flexibility of free-form names for assignable
>> configurations (info/L3_MON/counter_configs/).
>>
>> b. Events remain accessible via free-form names in mon_data, ensuring
>> clarity on their purpose.
>>
>> c. Adds the ability to list assignment states for all groups in a single
>> command.
>>
>> Cons:
>> a.  Potential buffer overflow issues when handling a large number of
>> groups and domains and code complexity to fix the issue.
>>
>>
>> Third Option: A Hybrid Approach
>>
>> We could combine elements from both proposals:
>>
>> a. Retain the free-form naming approach for assignable configurations in
>> info/L3_MON/counter_configs/.
>>
>> b. Use the assignment method from the first proposal:
>>    $mkdir test
>>    $echo mbm_local_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>
>> c. Introduce listing support via the info/L3_MON/mbm_assign_control
>> interface, enabling users to read assignment states for all groups in one
>> place. Only reading support.
>>
>>
>>>
>>>>>>>
>>>>>>> 6. Users can modify the assignment state by writing to mbm_assign_control.
>>>>>>>
>>>>>>>      Format:
>>>>>>>      “<CTRL_MON group>/<MON group>/<configuration>:<domain_id>=<assign state>”
>>>>>>>
>>>>>>>      #echo "test//mbm_local_bytes:0=e;1=e" >
>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>
>>>>>>>      #echo "test//mbm_local_bytes:0=u;1=u" >
>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>
>>>>>>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>      test//mbm_total_bytes:0=u;1=u
>>>>>>>      test//mbm_local_bytes:0=u;1=u
>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>>>>>
>>>>>>>      The corresponding events will be read in
>>>>>>>
>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>
>>>>>>> 7. In the first stage, only two configurations(mbm_total_bytes and
>>>>>>> mbm_local_bytes) will be supported.
>>>>>>>
>>>>>>> 8. In the future, there will be options to create multiple configurations
>>>>>>> and corresponding directory will be created in
>>>>>>> /sysf/fs/resctrl/test/mon_data/mon_L3_00/<configation name>.
>>>>>
>>>>> Would this be done by creating a new file in the /sys/fs/resctrl/info/L3_MON/counter_configs
>>>>> directory? Like this:
>>>>>
>>>>> # echo "LclFill, LclNTWr, RmtFill" >
>>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/cache_stuff
>>>>>
>>>>> This seems OK (dependent on the user picking meaningful names for
>>>>> the set of attributes picked ... but if they want to name this
>>>>> monitor file "brian" then they have to live with any confusion
>>>>> that they bring on themselves).
>>>>>
>>>>> Would this involve an extension to kernfs? I don't see a function
>>>>> pointer callback for file creation in kernfs_syscall_ops.
>>>>>
>>>>>>>
>>>>>>
>>>>>> I know you are all busy with multiple series going on parallel. I am still
>>>>>> waiting for the inputs on this. It will be great if you can spend some time
>>>>>> on this to see if we can find common ground on the interface.
>>>>>>
>>>>>> Thanks
>>>>>> Babu
>>>>>
>>>>> -Tony
>>>>>
>>>>
>>>>
>>>> thanks
>>>> Babu
>>>
>>> Reinette
>>>
>>>
>>
>> -- 
>> Thanks
>> Babu Moger
> 
> -Tony


