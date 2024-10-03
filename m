Return-Path: <linux-kernel+bounces-349723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085298FA7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B511F2253E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095191CEE95;
	Thu,  3 Oct 2024 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtpY2PJ6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BB14883C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998364; cv=fail; b=attpcEwniqUdJBokuuc1SLcFAjHYoOUeolCB1FK+a2krsNSecX/Obw6qVrV+3AOZFkQD296Ez9z6UNsnKFLa1p3R7qUq910eRU7nhmFwXz9iA2qngp+eQB1WtW8o7dUPI3XID0QNLT9s80QjXxNOwVeFqMM1Dp8DKX3++Bo/wZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998364; c=relaxed/simple;
	bh=NXPY6VM54uLM3Vaj+4PFWuX/xYmrdL43RiO1H07qMZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DuSvmwnwX19Ri7Uw5Nkjtd2Mj8BQZHhfpgxxyIVuqSnkXT0DKdMNqSxbbNfAfHay9Di919V9BiWv81QehdyDEKf12fY74+Qjbunt67K+qmyav90qHUP4r/CRmWmievCCDGdWU2w7NI8BZBxto+oFntzyumpAWS/uRG5/TiC+R60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtpY2PJ6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727998362; x=1759534362;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NXPY6VM54uLM3Vaj+4PFWuX/xYmrdL43RiO1H07qMZQ=;
  b=FtpY2PJ6bwmWYFZ23s2Q6tGbNfC4WmsuxoRrfTWf+w5FdsPKmyGIMQz3
   pgSoIRFfsn2Je48p0hpKfAVhDDlmofAyNj9NPtzQzrGYj2bOme1jbRCCX
   I8++5e2NcFESk3cQRxJ0zW3+oTfSu/QFLJ3AMjzAvkrXAGj2twluVoWrZ
   usSwqmi7M7ZyeVaEqhxot7u1noFZxFHCuRCZO1AJrVqKffTtcZzc/oA8W
   LspmYrifReBEGYnufLJmgBoND2YPayokupoMdV7X5eoggZU8qaLGsf7ht
   unh0TqXWy3pmPbWWegNBoeBvNm1Y1PL8PVKQIQzpO9DT8o6Do+gSB6j6E
   A==;
X-CSE-ConnectionGUID: KikzQ8lFSTWNJeVkomx5fA==
X-CSE-MsgGUID: KR5CktgoQL+Gr5ZjTiERZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27364187"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="27364187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:32:42 -0700
X-CSE-ConnectionGUID: /UqPlSpgSuOTqYjzLBchXQ==
X-CSE-MsgGUID: FH8plIiXRV6PWo6b2VxE2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="79362414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 16:32:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 16:32:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 16:32:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 16:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psZeuCEtO/bAB/6RsQWngL3JIZUk4xmPIoq+izADJoO1fOQ0ISPWl7PUEdZ4YHhRaUxVrJ4mml60FXGPrpo38RPhrUz5VCNgR/6teUZ59cdsJjB3OrLVTs5875zkvUh+Bfi+IEwTLqGkUy+6gBCAKzl6gKNa79tJknHEPlRiZgzbWAOBcivx/rOjh6JrAb0Ui6KsDiWK6FwR3olrLSWYdzclvDPFg60cX9Hbef6FFr4x/QvEZ9aYN6yTNGN9jWY5Yq32sENDLJC22meGMc9jSUIWEGfFBqMvhoCE/lxXHgkNGUsuB8RcohuO8x/dvHO/SfX724Vts4J1MwGsOFLGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6RghFaKQE/PmzNCJx2vYMRlahPi2acUkkQ0jZ3UL2E=;
 b=nyrgtDnLfQVNiu81t5mVfA9XNYnqKlFB+k5l9a24pop7vndFkJIMcjKIGYW4hb7CU601c9i8OV0StdY2KcawfJplSANqy52tR2pxpfsPBi79PCbWPmOiWZbkUQBKVCj3i33ex0FIM0zxSw3nD19Ur9AaL2ApLpUXDK+tHpTwANSTKDGoBdjL8UlTF3BFb6rbqzGOR7LhQf2GihxLqNL8znViLUR6lWVKjeAmDeXDR/F17xaPhzyh1X2nlkuLgqyhhAJFsvh0CyE2M2qo1ts84T3j779cQpfcz5CbtS21frnaev++gY8zzwtF4eoYZhE3uSLIGl5p7EiOLWvMYZXCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:32:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 23:32:04 +0000
Date: Thu, 3 Oct 2024 16:32:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yang Shi <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>
CC: David Hildenbrand <david@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, <x86@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
	<linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Message-ID: <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: cf514b64-cd32-4b62-9e6a-08dce4039672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aERaMUpWQmcwL0NuK3B2Z3hoZkhpckVkV2hHZ3hpNk5vT1JRK1k5bGlPQ1Nl?=
 =?utf-8?B?VmZYdElJV2N5dW9jQ1FtZlltNVVnbE0zNXFoVmpZMkhYaTBDR0pJTFg2WlpY?=
 =?utf-8?B?ZHk3bDVWeHRsUWQzbzV4cloySVZvMVJGeXA5Qm5KM2JPd09Zc0Q1SFZLN3E0?=
 =?utf-8?B?Y0plSlhhTFR4Z0huMUJVNlRHcFdsUmtsVGZIUy9ZajJPSlRrTzlDUkZoa0c0?=
 =?utf-8?B?dzhrZjJtQkxCcXhoWTU4LzA2Y3ZXa0xQWklGZE8xMUZaNXlBREZXUzl0VFFX?=
 =?utf-8?B?Y1Y4UnczU2FlRU5RL0kwM2lERStWaDBWV0FlUWFKbHZIaU1jMnRMQXNiS2lM?=
 =?utf-8?B?TzdJblc1MTgwUnhHelRHNUJWNW5NczBzbEJJZ0E1TE1sMk9weTR3NEc1ZGMv?=
 =?utf-8?B?MkQycG1vVWdiaEo4QUh3VCtqSVJhUzBlRC9kMEN4QjlZZWNEaTd6eWk2cVVZ?=
 =?utf-8?B?cXBsRW9oaEd2U0RlT0oxMmg5OVJ6cktRVVFqb1l5ak1xclA3eWpXYktNZklT?=
 =?utf-8?B?bW1uMlZkRE5sWWhsMUZrQ0lEcVFoV2FqNktlTkEzc3lINnZRYVBEYnlrUk1F?=
 =?utf-8?B?U0QwYytQRER2UCt6Wnl1RS9VNWZkQjR6Znd3c3JBeFdlOXpzUWVVSU11U2xN?=
 =?utf-8?B?VXRYeGh1M1VTQnJnMWtOVE1Mb2ZrZWtnR215OHhJeUJTd3hYUFM1RWl4VEZs?=
 =?utf-8?B?aElFNGM0Q3RMdnNvZDVBK2NZY1krZytYcnMxK2tpS2krK0VOT2ptc0tkdDU4?=
 =?utf-8?B?YkdnQmtPeUtHZHZ0c090RmlTcVJnYlV1ZXl3RW1zZW9rc2p6TjVYcVlHN2pZ?=
 =?utf-8?B?d3Q3aERVR2pESkNzRWZCWGZnaU9OOXhVM2xRM2ZYV2lQd29ab0NWU0k4NU5Q?=
 =?utf-8?B?bkZMYnVqd0xyRjh2MnlXdjNkVFB6cGhoV3lCakhhOFVmNHRYSjA4NkZrdkdP?=
 =?utf-8?B?TDMvOTVTZ0tNR2cwWnRER3BnWlM4bVp3TjAzYm92NWczV3NZeXJPWDRESlBF?=
 =?utf-8?B?QUJrTTgvZTlNejhvdEZIWWhIOVB0TjJRM29HV3JZTjNLdXY0YTc2M0ZOZ1gx?=
 =?utf-8?B?Q0pZTTJFKzNud0NZUDNsNVVwR1ljcXdzUkpwcHVLcVN6SlJUaVk0bWxmN2E0?=
 =?utf-8?B?SHV2dFlHellUL1VIUXJoMFhNWXVHckJNMG5uVFFMaERJZmR0dWxMaVY3U01t?=
 =?utf-8?B?b0t0aWhqZnRZRUh5cGNReEg4Sk5tSjlCS2Z3SXBIVnJ0NnNtY25hNS9wbDY3?=
 =?utf-8?B?YzZiMEZPUzA0OU8xOWRLMTJHTXJicTZ3Y3pWZWw3UkNYUDBZeEQxM2NKR1d3?=
 =?utf-8?B?RHJoYUFFZExqaVFRZzNEVjBYU3BJVW9Ha1RSVkYrYTArdElZbVNXZnY1K0RX?=
 =?utf-8?B?Y2cyZ0dBZVdJVVZEaDczdEhLdHZ4bGJUaDNkekFIcmpmZW5VcVkzb1pvc0V2?=
 =?utf-8?B?UmN4UWVuK01FTXBabWUvcDlLNm1DSnRoT3lZOHZDdXVoMmZiaUU5K0h6bllN?=
 =?utf-8?B?cWNxRkcwUFBnaXJodnhDQ1A5N1NWR2pRakRpRFNZdlZyQzVUVW9iRDJCSGtE?=
 =?utf-8?B?WFBlcUt5a0NaZjVZNURmKy8zSVVGNTVxcXU5Mzc3RzhDOCs2d04xNUREaitw?=
 =?utf-8?B?Qlk1dEVabEhUdDV2eno2Q0FjRTFyN01wMUVLMzV0Q2F1dmNKdnRQbVNzOVpZ?=
 =?utf-8?B?L2VlRURrUk9jZ3lUYzVsbkhwZHVhZnZ1ZGhHUkV1Qm0zeks4dlFiOFlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVJRE1lK1MyWHc0bVFJTVN2cm44ZStjZ2NpODVvUGVJaXJXV3VoT2ZWd0do?=
 =?utf-8?B?WlJTVnhoZHV1Umx4dC9DcEFlY1c1ZFR5YzJucmwrK1o2dXIwaCtxdEFRQkZx?=
 =?utf-8?B?a2lUdXc5T24yZTQvOHZaVnNIUG1qMjNocmw5Y1ZMeXR6ZDF2MndBN1pZL3VW?=
 =?utf-8?B?Wkl2eThSUmhUYTdCWFlCRHI1bHo4cW5ZNEFtOUJnUE80N1FZU3BHbHhPUjUx?=
 =?utf-8?B?ZkQxVjh3Yk1MQ1lwemZpVXpxaXVSaStNL0pmdlpqYkZjbnNwaXdhekhIZzNq?=
 =?utf-8?B?R1crdkpkb1J2WisvYkRYcDM1ME1oMVJLSzRkZjVDbGpvejlWZnE3OStIc1BK?=
 =?utf-8?B?ZE5VQ0srM1FGd2o1d3hLZDEzMmIzcGFyRytMNE1oaXM2bzdtc1ZzVzVPRm5p?=
 =?utf-8?B?QlZGUEE1WUNvanBVS0lOV3V6aDY0cTJHZGZKTmwyaUhyWENlOW91V0kvSzA3?=
 =?utf-8?B?K2QwMWprd0N4QjU2OFZyZWM2b3FzWis3SVFkRUFEYlltZzlkZXVTMVUrZkt4?=
 =?utf-8?B?d0h5NUpDdWZMVGt2N0tFYW5mb1BZamkyZVAvcWkraC9TUngwYXRDemxjK3FC?=
 =?utf-8?B?U2dWYXpIcFFKU0k4OVV0bmFmaDRPZVBNemQvc1RYY1U0TjMzaXN1TGcyRWNn?=
 =?utf-8?B?S21DUGJ0eVRVZmkzcUFJL0tlcjlIT2FvbXNCdlFRYWFaQi9hb0p2ZjVNVWR4?=
 =?utf-8?B?MVZialhXUFFadW5ybHNjWGxKT1dEa21MNFo4bFF4ZUFYYXltTnFhbHcvb2Nj?=
 =?utf-8?B?OEp3clQ5Z0xpa2xXU2cva3JsMTRoSWF1aVNLVEI3TjUvUUZleTdNWVBUOE9i?=
 =?utf-8?B?RmY0ajgzc0wvZU9BRHdBU29JNitoWEFYQlM0YUhadmp4SndUTDA1NkM1TTV1?=
 =?utf-8?B?cXEwQm54NjlhQkdma0lBYXdjZk1jNHNEU1VoZGladUdhT2dYRnNWSXh4bmVI?=
 =?utf-8?B?ekNnY2YyQlFoK0htMTIrNS9oS2ZDMTNFNWpoMnpOWXUrWXpTYWx3aVdZZFFj?=
 =?utf-8?B?d1laTlhpcGNrZzNxZlFGR1VlUjRQNFV5UlZ3clM0R3JJbnRvYXhDV0xxRmVT?=
 =?utf-8?B?TW9mTk5DKzh4bERmUWR3R0RZd2pJNG12Sms2UmkwN1FndjY4YmZ2NThGVk5z?=
 =?utf-8?B?VXArM1BkMzRNek1abjdzNEpSak11amErby9aM1VIVFI2dUF4VFBERUNTdmJ4?=
 =?utf-8?B?bi9yQzZ2blNlZzdQV0xtalFFZmlqcG9OVjBTTXVDdzhCN3prZTltRjVjUC9W?=
 =?utf-8?B?OENjK3l5WU9UZUZTcGJKMno3SFV1REZrL2RjcEpzR0FIOWdnMlZrZk1ObEVJ?=
 =?utf-8?B?VHpJVXZRSkFEbHZITDY2OFZEbWFDSW51aFI5RXhvTWpFajRaWUNJaHFwdk81?=
 =?utf-8?B?ZnppTWZKYVdMd0R3cE5qN2FreSt4SW9leTRHc0I5WkxRUE5neGg4WkEwTEpM?=
 =?utf-8?B?UjY5b2VTa2tyeWpXSitleGRQaUJaYTdPbityYisxajlBcldFYnZqNnRxSTFC?=
 =?utf-8?B?RjVHR2UvUy9kaFpMVm1Cc3NpSGJ4N1ZPdHRkQTJPUUp1SVRsVnlUeG9WL1RT?=
 =?utf-8?B?YUIreGF0a1dBVU53ZkdwbHVjYnYxT2xISGgzUmtGMnc0VytlTUh0Wkp5WUpY?=
 =?utf-8?B?V21NVERmem9PTEV3bmU2MldUOU1RWlFRaVBRRHZ6NVNOK01ZOVkzQ2FUWk1p?=
 =?utf-8?B?VFRTQ1NCeHVrNEFEN3hUQVJNWmJvMktOVWVMNzhOSEpUL1BKZTQ5R1pRSnRB?=
 =?utf-8?B?UGpkTWUySHpFL3NUcHFhbHhtTnFvSmRJa1BNQ05PUWdWRWpRNmZPL3pPUWRi?=
 =?utf-8?B?VDJxcElPbWc5OHhaQVYrWGtXMk14VG5KWE5vQ2toMis0SkN3bll0ZWZLWkJj?=
 =?utf-8?B?OVpxYXN3bEJDL2ZOTFlLd1RMYzNFTGkxbmtVbEFpQndaOUc4a2dNU2FCSVRG?=
 =?utf-8?B?bzVBOHFqWHJXS0ZTZmNxMGEzQXNIRkpITUJSQVlaUkdtM2k0U2Q4NnlDYXAy?=
 =?utf-8?B?Kzh6L3VoaXFCbi9uRXE1Z2dqSVlxYTFOeDBudEZGOVoyZW15M0JhNjY3OHJZ?=
 =?utf-8?B?STF2QzdWYXVwcGhFQi82WEYvVWk1SUdYcFNVMGpBelBHaGxiNGVOVjcyWVM1?=
 =?utf-8?B?S3hJdG96bVR3T25vZCtSR2lIRUJaT1BwMmVhWWxjdTFtOGlEaGVGZkNJeXRx?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf514b64-cd32-4b62-9e6a-08dce4039672
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:32:04.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOigjKCRhVPYNwu+Mmo1vBTgByMIFk6Sk8YZs5aU7sa/KA+XzDvh1Sl0z27gmL0H9oiCerQZYE+su1N0FqPS+5LrzN0MA+z+hItQ4Q3Mdl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

Yang Shi wrote:
> On Mon, Sep 30, 2024 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > Hi, David,
> >
> > Thanks a lot for comments!
> >
> > David Hildenbrand <david@redhat.com> writes:
> >
> > > On 30.09.24 07:51, Huang Ying wrote:
> > >> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> > >> hot-added must be checked for compatibility by TDX.  This is currently
> > >> implemented through memory hotplug notifiers for each memory_block.
> > >> If a memory range which isn't TDX compatible is hot-added, for
> > >> example, some CXL memory, the command line as follows,
> > >>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> > >> will report something like,
> > >>    bash: echo: write error: Operation not permitted
> > >> If pr_debug() is enabled, the error message like below will be shown
> > >> in the kernel log,
> > >>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> > >> Both are too general to root cause the problem.  This will confuse
> > >> users.  One solution is to print some error messages in the TDX memory
> > >> hotplug notifier.  However, memory hotplug notifiers are called for
> > >> each memory block, so this may lead to a large volume of messages in
> > >> the kernel log if a large number of memory blocks are onlined with a
> > >> script or automatically.  For example, the typical size of memory
> > >> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> > >> will be logged.
> > >
> > > ratelimiting would likely help here a lot, but I agree that it is
> > > suboptimal.
> > >
> > >> Therefore, in this patch, the whole hot-adding memory range is
> > >> checked
> > >> for TDX compatibility through a newly added architecture specific
> > >> function (arch_check_hotplug_memory_range()).  If rejected, the memory
> > >> hot-adding will be aborted with a proper kernel log message.  Which
> > >> looks like something as below,
> > >>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
> > >> for TDX compatibility.
> > >> > The target use case is to support CXL memory on TDX enabled systems.
> > >> If the CXL memory isn't compatible with TDX, the whole CXL memory
> > >> range hot-adding will be rejected.  While the CXL memory can still be
> > >> used via devdax interface.
> > >
> > > I'm curious, why can that memory be used through devdax but not
> > > through the buddy? I'm probably missing something important :)
> >
> > Because only TDX compatible memory can be used for TDX guest.  The buddy
> > is used to allocate memory for TDX guest.  While devdax will not be used
> > for that.
> 
> Sorry for chiming in late. I think CXL also faces the similar problem
> on the platform with MTE (memory tagging extension on ARM64). AFAIK,
> we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
> enabled.
> 
> We should need a similar mechanism to prevent users from hot-adding
> CXL memory if MTE is on. But not like TDX I don't think we have a
> simple way to tell whether the pfn belongs to CXL or not. Please
> correct me if I'm wrong. I'm wondering whether we can find a more
> common way to tell memory hotplug to not hot-add some region. For
> example, a special flag in struct resource. off the top of my head.
> 
> No solid idea yet, I'm definitely seeking some advice.

Could the ARM version of arch_check_hotplug_memory_range() check if MTE
is enabled in the CPU and then ask the CXL subsystem if the address range is
backed by a topology that supports MTE?

However, why would it be ok to access CXL memory without MTE via devdax,
but not as online page allocator memory?

If the goal is to simply deny any and all non-MTE supported CXL region
from attaching then that could probably be handled as a modification to
the "cxl_acpi" driver to deny region creation unless it supports
everything the CPU expects from "memory".

