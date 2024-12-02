Return-Path: <linux-kernel+bounces-428322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96CA9E0CDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D7E282161
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545441DED4E;
	Mon,  2 Dec 2024 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7z4q86M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E166F3D;
	Mon,  2 Dec 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170546; cv=fail; b=J/2L4IAOD7lb2cjX1fNeHCyUy0Poy7WcXsCcPEav9QGV98w5LNG48FARc2nS/lSNjVqZxg6Lxpfgwo066G3H5Z/pAqt8L4N2qJy+oPk/5KtU7zD3hivPyfuWZIcmcBfocNh7NAWezwEV7LyADSyTLBmUx8C2J86+yEthezTOurA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170546; c=relaxed/simple;
	bh=QSAWq35Z5/+QIV162WcAtg++lB2oMGDIbCjb1KLrcBY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BaYiUX2ggp7tY726lh9/bM0qrYIO0IfwUdWOaUA89VBVEgXllaJukV2nV0OnWTeEQAYkMQn40PJ9SJMjwRXjJVWDzd2An3NYpxt1CToegPLEV8Gjc/GbchZPDFt7aKAXahAYA6Qo4e2llWoXtk6sv5tUJmdwVRQE2xThOEaEh9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7z4q86M; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733170544; x=1764706544;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QSAWq35Z5/+QIV162WcAtg++lB2oMGDIbCjb1KLrcBY=;
  b=h7z4q86MMYnihuJgsmjHyETGI6YpgEJ32+upLRkZRFiX2aG0fDuc+UUD
   Ws3+pMAdNYiTrA3h9F3MzqoeB9QuMGE1yKeFF/mEPOz8imL3JVq0zWJKe
   jvlBUUtb/3Bfnyn0M4lqaiHHCBnI65GCMrq5Xa18cmXFmaJgfXuQLtlQF
   1pqejqP6s0xJO9p5afroKezkYQuwPPCKoFM7zlEdPAD1cmuKPx6hyatzt
   V8oa64OsbkvWOBvHXqxSIppRhZJu+D99vw9z9GBnaRbgsVW2ILIgcnjge
   +VdezCffFS7OqsZE7oa2KZrYzyJfRRtn82vdpoDMFh6JP158WXNYHGQTa
   g==;
X-CSE-ConnectionGUID: q7v3WyOTSiyFosB1aRU9lA==
X-CSE-MsgGUID: Z2D8fiYpRYSsC8WPF4u6Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36215763"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="36215763"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 12:15:42 -0800
X-CSE-ConnectionGUID: /sdNAo4NRQ2aEqbUhP5ImQ==
X-CSE-MsgGUID: G8rFoOeISMWwCHwqzwFbbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="94039404"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 12:15:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 12:15:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 12:15:41 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 12:15:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9Y29KjTlgWkQTWUHWYLWx/vw/zP/uPcO2Ylz9uOyaj35BZLITZCkiOEx8BZxs+Uzfx2FQUSmKlvlgDJ0oBL7w9TpDjVWTiLbaph+rPZcQQLSXGZ8KOD+Gp5RJAroaHkxcUUomoM6JgS5uUlwX/Fi83G2GcWohEcNLQFtQMe++zhIEVJKC+ExAtDRmAK4iXK0TaJzPWzM2AvpCc+RP+axFZmELrYelwpFrDFqplc+MaqGt2Euy8OB/TFtkoSfd270Y2mLzWMkCNABLgv+o/sgWZgbSTQ+UwRhFBNKhEnrOX+jnppvbyJUdgVdwJjmSSXWc0BhGveZ4QG39P0A52wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwRoI7ua6e+DqyHv+/u+/g1Tv00Vxjvn5A6GUfgmnjU=;
 b=rJbnEVAv8f+SfYkfCKdUtb8MS+DZRy8m9mmZC9wnClwVu3MaE96wcW91qakLplshzFZ9HFa3fX2IRkC+bOJxbZj3WKUiHdlMlsXA9cL3xuJBQlKSHGA6I0UVJEwHQURNsyqbR9Iqx6AGiUYGb4Jx5mTGvccWqsigL+CZLNyqnocE6zGZz/FN2S1AtL6r00U4nk/IEh8KJkHKFFvlgjViBvnnPDM0hjEbpCQ4l4MiJkhlAM5b/6lzrjiGHTmUxWmnqMQ5zW9DXl83/BwQwAf5/pyBh2BuyfuZJlpS1CUfayNTqiEPOIcOlzk6cpTWQX87DDGTRqpDHz1iBIDNE+evaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:15:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:15:35 +0000
Message-ID: <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
Date: Mon, 2 Dec 2024 12:15:31 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>, <paulmck@kernel.org>,
	<rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
 <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
Content-Language: en-US
In-Reply-To: <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: a93bbc27-92d8-4ec3-d12d-08dd130e1468
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnRvbUVMTXdFbkpnR2F4czhYU29WOHBZNUR4Z2V6WUtncVJNaHduSndPNWxN?=
 =?utf-8?B?b1VGV3A2V21RdDhvbmJEYlNLYkErU2UyRnhSNlpTVUxBRjdNQW9zcjNlcUNk?=
 =?utf-8?B?NXlPNUZWWmxEa0RQdTNqVGRBK2V2c3d2eTdYU0k5RVBGemorRDZYV24wR1Aw?=
 =?utf-8?B?NzZWeis2U0Z0Umg1QnRiOGxtOFk0dThXQzY4NFZDcTJPRDdvQStUYnNhcnZn?=
 =?utf-8?B?WUxTTDRjTlVlRGdPQXl2YWNhMnVTRW11cnBxanpseE5ESVJRYjFOajVUcnFh?=
 =?utf-8?B?UXlWVGpaZnZ6Zi92NXdub1krNmRnYjg5QjhEelhwdXp6VldjbmZ3TWpPQWda?=
 =?utf-8?B?Q3hsTWxmNUJRS2lpWFpWdk9GSFZnMWVCNEdEUVVBVkFrc0FUaUYwOEdSSWFR?=
 =?utf-8?B?TkJ2aTd3RUFxN3RVcHVybjdtSnVIUmdkb2N2UHR5aGF5cElleXJRV2Uvd0lP?=
 =?utf-8?B?YlZwKy9KNHg5WWNHMW9Ub2ZZaHRjZzZoQ0Vmd3JSNzdXbzlrT2VIKzhmbTBS?=
 =?utf-8?B?bk5MbVhCR1BTZStyenh5TG9MK1FYUWpad1ZmUjlybXhZbkVvendxRHVQQ0lh?=
 =?utf-8?B?ODA1eW1hT293N2VRTVllUnJKc1V1M1pRa3QyWWYyaGpEWVZnVVVIY0szVXQr?=
 =?utf-8?B?SUxHeFB1aFlQT1BzekhTOCtYMmdxUnNJaEVpZDN6bXZjSkt6eEZCNUYzWmlt?=
 =?utf-8?B?Uk1aNVRaeFEySWRZQ3l5QndPcGl5aWw3NmxHdzM4LzI0d3BSeG5lREZzUndE?=
 =?utf-8?B?eXZFNEovNjB1OVdmaUhmcXYxZDlJUjk3YjdzLzFCdTNHS3RTdDRoZ0ZPNE1q?=
 =?utf-8?B?N2N3YTIwOGdqQ0paUm5YeVNFTStBbDg4YkE0MGZaYzdHRDVCVHhBQXlTSlVl?=
 =?utf-8?B?UEJMSnFmd0tCTEdqL2VBcURTZG5WSGhUd1h5M1BwQUpSNDBNYWNBTjZySkNK?=
 =?utf-8?B?WGFId1hld2FoUGowMlRTQmJvZ0FmZi9nOVcvSjNvZUEwSFdwditaN0QvckQr?=
 =?utf-8?B?dFp1VlhzWjlmYWRib1J1UjlPQkZneUN0RWhIK1A5a3hBblFPQk4yTGlJZW0w?=
 =?utf-8?B?eWdzL3BGSWYyRkhUZHhQSTBwRERjUVdkY0lreVhhalNmTWdaTFJDWmhTMDZD?=
 =?utf-8?B?NkkxbW5wNEQzWlB5V3BxaWx4cDFwYXY4b2ZGYlp4RmIwU0k5NjZaSkVacWYv?=
 =?utf-8?B?bUxHTnIxNnVyam5sOXJ0NXlXNDB2STEyOHBHb1VOczNZMS9pb2MxS3M0REt2?=
 =?utf-8?B?TkdGRC9WcUpOT291YVRrWno3VDhBT0FkeUg3cEJzcTJiZUV0Q2Y0ZGJpaFp1?=
 =?utf-8?B?dlNRM0J0V25lUklDd3pjdzdvOW1hNFJnZjRRenRPdkszZkV6c0FkaWhhclNV?=
 =?utf-8?B?b0xXTFNEeFZITHd4VG9CZTMxbEx1NVlrZEIwWjBSMU5iQ01ESGtrc0NNTmps?=
 =?utf-8?B?OG54UTBrWitoOVV3SzlHRlJpUmMwNXV3Z01pVVp0RVB1RjlHUmJOMDNQOHFW?=
 =?utf-8?B?b21PMXpKTzRYSk5TTDB1V0cvSGhSYnJKSllsQVJmQUh1NEdlMFkrTTVsTzNU?=
 =?utf-8?B?SnhiaWRCVVErUmtwRVJ2WGozMGJrVVd5VUZlQkpnRzVibTJHQndCSkJwcHZp?=
 =?utf-8?B?ZC9JbUVucFRVUFZBayt2VkRpdmw3cktSV0VlUm4rSXdrMHZ5cW9XR3JxRXo4?=
 =?utf-8?B?NEpMdDNZcTNuUnMyT2NFeU5YZHBGTnZ4THlxOGhUWDhrR3BodlUrMzJGcW4z?=
 =?utf-8?B?TGhrS3dCRVduSlZhd3hCU2lRbUFQVzRwZWsvMnpoV1c4OHpqVTd4MHAyU0x3?=
 =?utf-8?B?SGYrcDI2bWdDaUpZMXdsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1HTXVidXBWNUhEMVRlT3ZEZEpROWtubFp5Q3lhZmxJSWRzbXphUnVvOVFT?=
 =?utf-8?B?dGFhWXQ0MEZoMlEyU0wvR2pwdGR5czVUa3U5eFBVUlpNQzl2SW5OamQ2Z0hC?=
 =?utf-8?B?cVZLeUp2eSs1dEhJMXRLTDhwZzB3ci9JN1lHdVZKSGw3am5JZUJoS3NlVDRv?=
 =?utf-8?B?cUVLbVE1RFR2eTA2aEhMdndsNVdVNXZvR1ZrRG1XSC8wVGhNOW5RaThvUXRY?=
 =?utf-8?B?cm43TEJGcCtLYUJNbk9pdnpQTFFxYXB4Rk5ZVXVwbzE3aW1YNklLMENKNHVZ?=
 =?utf-8?B?d0ROc2d2bzR3WmtQc2lHT0dLWWxPM0pHSHgxVkttY3pPZFdwRmNkNHBPV0pR?=
 =?utf-8?B?blJaZXN5MEhVTzdRWlJEYWFYUFJiSXV1QjBVQllyWlNuNDNxTE1FMVB1Rmcx?=
 =?utf-8?B?emhzWFFCcXIyTStxTGR6MUJZU0cySVB1NU54UFBWY21haUh3WFpNcGNQY3Ja?=
 =?utf-8?B?TkxYMkhDaDJvL0JNbDdVWHR5elFvblM1WTV0OTJJckl2T3ZlNzFrM1Z2Nkcx?=
 =?utf-8?B?aTdoWDdERmMwRDhISEtteVFTYS9YTGR1aTRoaXNtMlI0T1VTdGs2RTE4eTI3?=
 =?utf-8?B?NzhNTmVzVEtwMjhXUElLRjhHQzMvMEVGZ2VCK05SVjdJY0JuWDBKK2tkWWJR?=
 =?utf-8?B?SHF3RzlxWTVNZkJualNGdG1WN3lxRlBDMW9NbkRjR1pqYk5wZmJoYUdyWUY5?=
 =?utf-8?B?cldWQnRJMXR4YmlpQ3F0dEVoeVF2ZE5Ra3YxenAvWDlPRFJPaHFuc0gwNmI2?=
 =?utf-8?B?UlRIR2V0WE5kL3VYclhzMWFRYTJzUkVGWWpNNTZoQmlZa3dSZnBhbnlwUk9E?=
 =?utf-8?B?L0doSmkvelk2UTl1cEZrY1YyS2M2L1pKdDVZVSsvbjkyakJ3SDRDalE5QUdn?=
 =?utf-8?B?OSt3UHJLQld6WjJxNUp4dVdoUFdTMUZYVmNPWWp1d2V6K3RxdUZjdzVBMzFX?=
 =?utf-8?B?dm9UemJoUlRtS0RqVlVzVCtvUW5LRkRXWjZDaElVaVptSWNubG80bU1XeFZP?=
 =?utf-8?B?RVAvWlRlMG1PMThEWmxoa0tzcVErZjEvanJNWk8xaWhaeUswTGFmb05SWHNM?=
 =?utf-8?B?VTFGQSsraXlYMHFNbFRBK1c3eWlGOWZ5RHpreThxTURrK3RTZmVlejJFTTR2?=
 =?utf-8?B?RnRKSE43bkVsY3BrUEJjaG5DWmxISFZJQW9BZTJzZWZSa1pMbldlTjZ5cmtl?=
 =?utf-8?B?NmpiaWljUVgvWjJFeWh2QlZhR3BaVGVFVmF0ZzNTekRIcC9zUUY1SG5LSFhj?=
 =?utf-8?B?QW15OXJYUktWWC80R1NPVjgzWTdKWnNiTGF0Nk04Z1FwSTUzZmR2cXo0ZTJX?=
 =?utf-8?B?K20wVm5yanAxVmlNbFhPTDBWejdRTHRwdmNlTEJnVkNpWHAxRkx2aXJEMFJZ?=
 =?utf-8?B?dllXdGRnZmZ1NC83RExYcFh5VjZvdzJvQytoWnliQ3F3MXRFN2s0dS9SR1R0?=
 =?utf-8?B?OEQyWHJybVlvUmdNcVJhaGFRdE03MnZKbU5JVlVRcXRaVFJEbUpWNXllOElu?=
 =?utf-8?B?Ui8wdUUxT01obitFRGVBTnFVekJlVXBpd1dRSFRBRmlwZk1mWWRwLzFFRUpQ?=
 =?utf-8?B?UzcxK0NPcDlaTmxLZURUNHZoUnl4VHVFNnZJOS9pK0lxTG5JMkVkekoxNTFP?=
 =?utf-8?B?N3lXY3Jnd0Z3Z2MrQ2lxcTgxMng4YmxDT2FTRlpnMTlDOFM1M0lDR0dYWkI3?=
 =?utf-8?B?RVBMNVRtdmpRMVpuV05xbWhybnpsT3RWRThuNS82b1JzZnppYTVoQVpmMk0r?=
 =?utf-8?B?c0lDN1ViRm9zcGlVMVFhRWpyZHExUEZKT3NXcWp3dWJwUVdWbC8ybUVQbzF2?=
 =?utf-8?B?UFIrckRRdkE5L250OHpGdFFadTRxemRYTVAzb1ZmSTlJV2RsaVFNaFRFQ1JO?=
 =?utf-8?B?c3JJRDBPaWVaRGhiMFBYdHpSR0l6U2hFTWxhcVd2TVZnYzBSaGRKOUV4cTNR?=
 =?utf-8?B?MDk3aEFiQkJWWFpEZ0ZOcFc2OHhnQ21oR0lNWERSTnJZVEdVMThXbG0rNmx6?=
 =?utf-8?B?UXd3Yktha3FpMldyTnZvbk5mcHpxOUtsaFl4dk5CdWhBcktqcDE3WFlYWVp5?=
 =?utf-8?B?b3JjU3MvYWVLY0FzNk1VTU1SRUUyN1lKODFKTFY1TVRPVHMwQzlBSFVEZW44?=
 =?utf-8?B?RW1UQ0FuUHBpY2t0cXU0L3VTam9KOEprQ01Sc1g5VzlBL0d6NDVEd3NiTmpp?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a93bbc27-92d8-4ec3-d12d-08dd130e1468
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:15:35.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Owl+L2Mx4KNu2H/S4ha4sQ4MxJDPyxkobDdN2pdFOI9AJhEmEHSRWOjvy+njb/d80T5dQs7sCKS2GOXMFxf52OryhpgMHjh+jZG3nksmX34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Hi Babu,

On 12/2/24 11:48 AM, Moger, Babu wrote:
> On 12/2/24 12:33, Reinette Chatre wrote:
>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>
>>>>>>> Hi Babu,
>>>>>>>
>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>
>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>      For example:
>>>>>>>>      Resctrl group mon1
>>>>>>>>       Total event
>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>
>>>>>>>>      Local event
>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>       dom 2 cntr_id 10
>>>>>>>
>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>> group:
>>>>>>>           struct cntr_id {
>>>>>>>                   u32     mbm_total;
>>>>>>>                   u32     mbm_local;
>>>>>>>           }
>>>>>>>
>>>>>>>
>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>> not configured to the newly online domain.
>>>>>
>>>>> I am trying to understand the details of your approach here.
>>>>>>
>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>> tracking data goes away when the hardware does.
>>>>>>
>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>> something like this:
>>>>>
>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>
>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>
>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>> domain.
>>>>>
>>>>> Are you doing something different?
>>>>
>>>> I said "all pending counter updates to a domain", whereby I meant
>>>> targeting a single domain.
>>>>
>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>
>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>
>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>> for readability)
>>>>
>>>> echo $'//0=t;1=t\n
>>>> /g1/0=t;1=t\n
>>>> /g2/0=t;1=t\n
>>>> /g3/0=t;1=t\n
>>>> /g4/0=t;1=t\n
>>>> /g5/0=t;1=t\n
>>>> /g6/0=t;1=t\n
>>>> /g7/0=t;1=t\n
>>>> /g8/0=t;1=t\n
>>>> /g9/0=t;1=t\n
>>>> /g10/0=t;1=t\n
>>>> /g11/0=t;1=t\n
>>>> /g12/0=t;1=t\n
>>>> /g13/0=t;1=t\n
>>>> /g14/0=t;1=t\n
>>>> /g15/0=t;1=t\n
>>>> /g16/0=t;1=t\n
>>>> /g17/0=t;1=t\n
>>>> /g18/0=t;1=t\n
>>>> /g19/0=t;1=t\n
>>>> /g20/0=t;1=t\n
>>>> /g21/0=t;1=t\n
>>>> /g22/0=t;1=t\n
>>>> /g23/0=t;1=t\n
>>>> /g24/0=t;1=t\n
>>>> /g25/0=t;1=t\n
>>>> /g26/0=t;1=t\n
>>>> /g27/0=t;1=t\n
>>>> /g28/0=t;1=t\n
>>>> /g29/0=t;1=t\n
>>>> /g30/0=t;1=t\n
>>>> /g31/0=t;1=t\n'
>>>>
>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>> able to unassign and reassign the local domain's 32 counters in a
>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>> no more than one per domain, regardless of the number of groups
>>>> updated.
>>>>
>>>
>>> Yes. I think I got the idea. Thanks.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> struct resctrl_monitor_cfg {
>>>>>>       int closid;
>>>>>>       int rmid;
>>>>>>       int evtid;
>>>>>>       bool dirty;
>>>>>> };
>>>>>>
>>>>>> This mirrors the info needed in whatever register configures the
>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>> updated.
>>>>>
>>>>> This is what my understanding of your implementation.
>>>>>
>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>> --- a/include/linux/resctrl.h
>>>>> +++ b/include/linux/resctrl.h
>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>           u32                             *mbps_val;
>>>>>    };
>>>>>
>>>>> +struct resctrl_monitor_cfg {
>>>>> +    int closid;
>>>>> +    int rmid;
>>>>> +    int evtid;
>>>>> +    bool dirty;
>>>>> +};
>>>>> +
>>>>>    /**
>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>> resource
>>>>>     * @hdr:               common header for different domain types
>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>           struct delayed_work             cqm_limbo;
>>>>>           int                             mbm_work_cpu;
>>>>>           int                             cqm_work_cpu;
>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>    };
>>>>>
>>>>>
>>>>> When a user requests an assignment for total event to the default group
>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>> entry.
>>>>>
>>>>> If there is an empty entry, then use that entry for assignment and
>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>> information from default group here.
>>>>>
>>>>> Does this make sense?
>>>>
>>>> Yes, sounds correct.
>>>
>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>> initialize during the allocation. And rename the field 'dirty' to
>>> 'active'(or something similar) to hold the assign state for that
>>> entry. That way we have all the information required for assignment
>>> at one place. We don't need to update the rdtgroup structure.
>>>
>>> Reinette, What do you think about this approach?
>>
>> I think this approach is in the right direction. Thanks to Peter for
>> the guidance here.
>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>> though, I think the cntr_id would be the index to the array instead?
> 
> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
> 
> 
>>
>> It may also be worthwhile to consider using a pointer to the resource
>> group instead of storing closid and rmid directly. If used to indicate
>> initialization then an initialized pointer is easier to distinguish than
>> the closid/rmid that may have zero as valid values.
> 
> Sure. Sounds good.
> 
>>
>> I expect evtid will be enum resctrl_event_id and that raises the question
>> of whether "0" can indeed be used as an "uninitialized" value since doing
>> so would change the meaning of the enum. It may indeed keep things
>> separated by maintaining evtid as an enum resctrl_event_id and note the
>> initialization differently ... either via a pointer to a resource group
>> or entirely separately as Babu indicates later.
> 
> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
> indicate assign/unassign/dirty status.

Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
to the resource group to which the counter has been assigned then I expect NULL
means unassigned and a value means assigned?

Reinette

