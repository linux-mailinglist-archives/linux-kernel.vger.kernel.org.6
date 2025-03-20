Return-Path: <linux-kernel+bounces-570526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D4A6B1BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26887A990F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5222B8C2;
	Thu, 20 Mar 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS0oJQKY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96322B59C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514192; cv=fail; b=Of/q/bCbr4xuO/ezGe9wj17LGbwuzXsgwmnJGHqRxBIDsdCl0mMfEBJ1jKRuFLqGFaEnE94a9idintfShCAHcle4ccpGnMpUTT57FXZYgJHKDNvK/1sdRTNr4vqGmubQo6o/aSPMOZtGXpGf7+Ro0zgdgHPRzRRSXeGOsEsdc9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514192; c=relaxed/simple;
	bh=NxzRfW2zVX0amIAvvy0X/yYMvLneQv3YqmYluknLgIk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfMkqdW3iBOa4AFlH1yp/0SvisXqwgaYJcxegEAlk0Iaqp2RNn8G7w90vaVUDHGn02BZVYN3R+4xD3kimiVsq7NrPJWmev8iHgoPzy7YvzjyCT6MWouypOIn7BBkWU+Ssq9TpJvQVoT5j7aMSNMpcIGWAGR6ZTUEoApXqx/tFoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS0oJQKY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514190; x=1774050190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NxzRfW2zVX0amIAvvy0X/yYMvLneQv3YqmYluknLgIk=;
  b=fS0oJQKYN3CAABQAkvj64wscMQdw5whP95iwKQFfizCY2s5CZKVCnOKp
   9G1MIgkBnhq8qLPz26RIm+C8r0xZe8tye7ZYOBkmXpC2mkLvjS0eUSJW+
   N1kcvl1URDIO05AaAuxbxwSn5qilgOtIvJ8BmpmbMXxIE/CCR3c4N5dGK
   qVdYE+tq9wQVA0Ksg9TY9uflWgiYJpvJL5KnUywEklF2A54qxXnQ3pUt8
   FIcIlBtT/UX96JK5WihjqIymHtJhGNy72JPodDRpchj2WEo3J6hg2zzlJ
   36EPouxuykVh8rxCrezfuwMkaFSB85umO9ehhxRH8M9X1y3BzbuI7UZqY
   w==;
X-CSE-ConnectionGUID: lKLpYtv9RlCmR4oQD9CxQA==
X-CSE-MsgGUID: f3D3act/SSuPZ8EdmvweZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55154442"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55154442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:10 -0700
X-CSE-ConnectionGUID: owDcERVeSOCMuF9d0cvAJQ==
X-CSE-MsgGUID: 4//3CXCxS6yu2tDwwqQeSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128355354"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 16:43:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 16:43:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 16:43:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/8YWkrkwtBhwuWcu7LxEEk40LqCYakVT/vyEdgwqvImOhz5cO/gNi9t8biKxRh5dp3gyXgcLAVme5HX6347iFEX0D8PC9pr+gaK6OkHsrNgC8SAggom25nR+SRwzmlzcvDvjmFXAAd/5O0S87z0d/mP+uuZfRvuxLJKcwCOkd4uRtYjmZj/8dL4DpT6MTBuaMvSOzSjm+LACHeTE1KqM1Ld83mKmzrNlf1ZQGc7qALjJgfXPGh2KnGSKhvWYSxhCGu+LIZu5df917eSnzyTf2LyZbGDGrHM1EzWKoT39NaKsZvGhz/Y/9766jPxSOhKnNDgCxx6Buy/VoDfhn1ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l7Jo/QSiNkejuT+3HnOBkxt0iAwZn8Pn+pJcp4qYgQ=;
 b=xlbRu8fOQZwOs51RF3Nx6yAOMlq1CMClNNCIHdvau9jA6jCO/ASoC58VskmJy6IYbmJQsASnFFeRShIZz8GRB1+jnpEPz6HBReq4xNy1v7McOg6Cmxb2hOUI/1xtFL59fWcafb8CLtRVco3uJV7Ix8yAG0+O2I3RJeumsn9ZuxyuYZ+6q5LvBTO4DEupfLhIbuHiDUu7rrBLwcnUGZ6gJ9kjCwUpxo/APRAvlyqqshlTadeGeTtbbTAgbFAjtX9HE1FJC0ibmOSCCjV9oX5FdzJvKB7cFpUTllOqRny+9cbd/+HLF+4juhHQg/nWxnjNSzGyoAumGoo5E07I7Xp3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:42:39 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 23:42:39 +0000
Message-ID: <99fe30bc-47cf-4910-bd80-3eb743ef0548@intel.com>
Date: Thu, 20 Mar 2025 16:42:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/microcode/intel_staging: Support mailbox data
 transfer
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-6-chang.seok.bae@intel.com>
 <fac46937-e0a5-42c1-96ee-65fec4e17551@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <fac46937-e0a5-42c1-96ee-65fec4e17551@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::45) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 643b0bef-7e6c-45b9-faba-08dd6808e647
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHA4L0tXenV4bWc1eDFXUkw5QVpCU3c5UmtZWjhwOE4yai9BVEJ5VnE4N1c0?=
 =?utf-8?B?cEx0UlRWNU5HNE1HWi9wQUFVVnJMallLN0RMOVBhUUdSUWZ3QTR0NkJZbW5y?=
 =?utf-8?B?SW9vUlhhMG9EbDU5MXltR3pKcTZkVjF4Zmw4VTgwTm9NOWYrUDVQbVZDcWVO?=
 =?utf-8?B?SHdhZGJyMnM5RXBVM2ltbW9TZ2xFS0MvV1VRT2d4blBqQVdsd2FtcWNsc2hD?=
 =?utf-8?B?a3l2U1hNd2QzNWdtcWk0M1VyZVhGNS9pd210dDlGYnFrNXVmcGFJQXZibnBw?=
 =?utf-8?B?QWxSYlN5M1plKzh0ZWdjRFF3WTFHaGZNMDJqTGlPSWR2Z01rdnBEL3hDNWE0?=
 =?utf-8?B?SGFQdXBLU3EzNVBmQUpycjVRNDA2NlE5aUFoa1J3UGtzdUJCQmhwUGw0bVZt?=
 =?utf-8?B?QmljTWtxcWJrV2RPQ1BtQmRDVzhsTUlhTStMUWZHWTRlVGZVTytyZ0JwNS9l?=
 =?utf-8?B?ZkY4YWlkMHQ1Qm5ZR3BOZ1VMcGdESnRqbFF6dktzRFFHNHhwTlJzRHA0clp5?=
 =?utf-8?B?aGlKZStBa1lrME9yc1kxaHo1TWpaWi8ydWpqNE9xeFRtUGIwYVhEZFRWRG03?=
 =?utf-8?B?d3F0OGpiVVNHdEZBS2ZLSzZUL2w5d2RoK0dsQ3Q3QXlTekhZai9CNWErMHAv?=
 =?utf-8?B?ZmxzVGtSU1dYazFJN2lkSVNCY0NhR3dxQkRTbmhydTZlaUJaWVBQTkhuM0hU?=
 =?utf-8?B?dnlEMXdySDNKM1A0RHZURzNwL0JHcWZSNkdiOWEzdHZHWXl1WGxVMjlyMTNM?=
 =?utf-8?B?ZUE0MTlkdmFsbDdvMjh4MFgva3FJOWNtR2VoalFhUXc2UXBkZFhPU0pxeU9B?=
 =?utf-8?B?RTB6QlJPNEllM3lUajNIckp5aFBFalFud1dXZ0xHUjZWTXl0ZFJNNUQ5K1NE?=
 =?utf-8?B?SHZxYXJKWW00TEtUNHpBdjllSjR4SEdtdGZObjdQNjBWL0lBRisrSnhHdEhu?=
 =?utf-8?B?OThEV0hLdm0zK3lOK0pvN3NVb0grK0dMamdHV0gwaTAyc2VwZnBBMCthQVFj?=
 =?utf-8?B?R1l0NXRXRWxPQzRLRjRjdlRTeHkrOU0vUkxTbGc3S3liV3RKSldIZFlqY1NG?=
 =?utf-8?B?YmZONWl5Zkw2SW9FbWg5NktBMFh5Z1U3TnU0SVUyNGw3d2dxak91bTNsTnJX?=
 =?utf-8?B?RnZyTUhZQmpTRWVSQ3grTkE2MmxmR0dmMXRzSGJwZTZmSXk5TkpqbFZGeGcw?=
 =?utf-8?B?Q1ZJOTluWTcrYjJ0aWwraldZOG9yQXlXRUF1M3l6RHZKOUlQWkp3NFlETERS?=
 =?utf-8?B?SlpDSTJ1WUdBVlM1c1U3LzFubXlKV3l5WmhRbUZLUzNLeGdIcnY0MHFnMWI5?=
 =?utf-8?B?RFVJZlpGOTZGZ2hUSXFqTWpMalNudGNYbm04d3FLUFBwdk9EVTdoSGsxbWVh?=
 =?utf-8?B?bzNkT1dSbnh5ZnhkZ3lQNG1zUlU4L1JrQTg0ckNkcU42aUFDWDVJY3lvZUw0?=
 =?utf-8?B?TFVFaWE3U29tbVdqeHVqdit3QzRVUytLOWJoU3Z2RmdZeWRBMDBTYkowWTls?=
 =?utf-8?B?TzRWSGhuQUNGSHo5SXAvaGJBOWNrcXpEVVJIcFcvMUwyQUtJMWFQVjlDNzRE?=
 =?utf-8?B?V2JuNEZYZG5jbzl5akEzSWxZMXhCUWp6RFZpQTYrZG5ldmJsbjk5SkZGY3Rs?=
 =?utf-8?B?VUVYYmVEUWtRZkFwWXNIREpLZGdFaDY3a2hOOGNZbk84TDVTMWYzeFpYSWVl?=
 =?utf-8?B?UURqcFpiLzJFeGg4VWN5ckZpSzdmR3ZoRTJuS1lPamhZVXk3TDRxZTRzTko4?=
 =?utf-8?B?N25yb0luMjNnNXJkNERtaVJpRnhmMk1tb2E5WHpmWXppNHUvUGpuWHl0Qzh3?=
 =?utf-8?B?Yk42VVlUczVCZmExQ2ZpUnY1YzllRDdkQVFnU1BleVJMbUxab1RSVWNOYk5Z?=
 =?utf-8?Q?J5lGylZDUcgZB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTI2VDE0dXgrbnl5M1J2THdhWXBkUGNHeTNPN1AzQ09RNVpYZTdjdHZqVWNa?=
 =?utf-8?B?b0pWL0xGZE5UL1pHVmU4eU5EczlqQzJyL2dVWUxZMkprcXJBWjBSdXNURHA5?=
 =?utf-8?B?amRacERDZzUwM0NYY0NEYXMraG8vVHJHRnZmMTE5SzFKRGhZT1pqbE1ZSGZ5?=
 =?utf-8?B?L2p0RVl5Y2pDNkJQakdXUW5ydDU5WWp1TG8yS3AvS0h6Y2dCYnkvKzVrOGFS?=
 =?utf-8?B?ZzA3Yko5RWEvd0w1MlZvdjZHcVV6SjdERWZBcXZhVHBlcDhoR29MZ1pHRTIz?=
 =?utf-8?B?L3RFWjNiSWdIOWUzQnFMSXJTc3o1OG9KdVNqZDJ4ell6VVpLUDUyMXlGSUJl?=
 =?utf-8?B?T3RFWUVJa3ZjZXVDN1dnQlRkMURLVlJmckJ1WCtJTVhRMUNWRm1DM0QwWWhO?=
 =?utf-8?B?bFl3UE1ncFpwb0FYSHNjYjlvRFJnRnBZRmNVNFJnbnJYM1k0UEhOWHMvOUkr?=
 =?utf-8?B?cUo5ckE2SFlvUEZkNC8xWFprMHVERnJwZTdkb3VDZE4xS3JNU2lWdE5vUHI2?=
 =?utf-8?B?MDBkT1p0NkRVUXliYSswajZKRnQ3cHRHUENOTHljd0taMEtSb2tzRlY1VTls?=
 =?utf-8?B?MzhJMVRNdC9vTmR5Tm83bHdZcHJnYnhkVzVEYytxRWVWZGxZSVhDVCtzZldl?=
 =?utf-8?B?Z2V5QlRjak5KdUdpa0pRY05kT3N2S2NIemM0ZVorcGhJb1g2Skp1Z0RoaEV0?=
 =?utf-8?B?dzlOMTN5eWMvNW8rSE9LWS82YTBFNTVaai93K2RJU01nR3BsUHM5dmh6Nm1t?=
 =?utf-8?B?Y0J6MThFekUyWThUWmwvWXRCOGxNRVcxQ244cVlvTFBSblJyblhidzRuWmVw?=
 =?utf-8?B?ZGxDTkR6alFFQWd4Z0RSb2FaTkZQc2h2QnE1TGh0c0JtNUVxWWVNMXZLV3Mw?=
 =?utf-8?B?ZGFwRzJpZnU4dUZUcVFqT2QyYUVBVEpyVW9zellPdndiZW12ZGZ3TnBJYWNM?=
 =?utf-8?B?T0dpUlBSYnJZb3Q0VHlldlFwcXFRQXRna2RPNWlmbVJHSm9jQUFmN1NDUnBM?=
 =?utf-8?B?VENRTUpGOEliWjNUbHNmMHR5ODFLYmgrS1BGZ2UyMnAyWUc2aXhOczJNNWNQ?=
 =?utf-8?B?UG1kaXl3UGdRZ0tUQ3drSnBZZU1kNmFHOTBZMEtaZFF1YTNycmlwQUUzeVdj?=
 =?utf-8?B?Y2wwVlVTdkhqaEQ0YWdTbnZwNkMyTXlQdy91WWRqYzRsYWVCVmFkVXNQcmxx?=
 =?utf-8?B?cnVWbUV4THVuN3cydllIbGY1ZmhxYnZGc042SkdyeXduVUFKQ0hvNk9DVlBT?=
 =?utf-8?B?U0llaU00Y09lMWh4SHRNYkh0Zm1ydDJCQWlNQnl0a1BxNXFUbWFSdVZWNmtr?=
 =?utf-8?B?QXdrbDFRbzNxcThZaGdsMlUvWTJjbmNqRUUwdUFwRk9HZExXSTUwMHZxYWpT?=
 =?utf-8?B?VFpjQnpURlc2enlvd3pacVh0UlVxQ1JxWTZzajg4MGc1SUF1TFB5SGViNkRY?=
 =?utf-8?B?dGtnSXJ0RStnbkVlZnpzb0xPdk1CdUhaZlVLQlRLMUN0SzNEZ1J2SDQzcU10?=
 =?utf-8?B?aVRTa3NNQlhuLzZJMnNkT0E4NmVGOWx6aHpubVltSzZpUkdqZ044dXJwS2lM?=
 =?utf-8?B?cG9WRVNteEJwSEFQeXlkajZKYkVKUkJOYVdiWDlaMUU3UFF2UjI1Tk9qeGFp?=
 =?utf-8?B?Q0FKU1dxRzZKemxlZnkvUnQ2MzduZ1hpVVk2OTRsTi9XYU4xeThOcVBxbUJK?=
 =?utf-8?B?RXkxdU94N3VrdGdETXMvbUNDR1dzYzlWUkRPcmxxQ0dHNkp0b2RnVU8vVGZz?=
 =?utf-8?B?dDJ4dDlhWWwzQXg2emNLN3l3TXZPVTkyTGMvRWNRVDNNNUhxNG8wTlFja1I2?=
 =?utf-8?B?cm05N2EzakVrM0pDNThmNGFlcFk1SnowMnZlTFdoYkRBc2VGY3hGOTVhSzFs?=
 =?utf-8?B?OG5EcUtLZjJKUWZWa0tmMERsSnNOemMwTlN3QVBSclNmcllXOVozSDZycng4?=
 =?utf-8?B?Lzh3K3FPbTl3dGx2bWZjYmNCQUZ1S0ZrY0UvMlJ0UjJ1VmJaNWhJcWE1OGhn?=
 =?utf-8?B?RTdmNXVoSEFYVTdwT1N6Rm5XbFlLdzlqdVJCdXB6UXZjeVUwcmJTeVNnckxP?=
 =?utf-8?B?N2doODhIaXJpa3E3WU12MmJXRFVKVDhtaGhDN01UbUU3NkwwYk9sK0JwR0l1?=
 =?utf-8?B?U0RUUUlFNjM0QUFGS2EwRzJBVVV2d0NSWldSV1hiUWduRWNhSzhYclJWaktN?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b0bef-7e6c-45b9-faba-08dd6808e647
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:42:39.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtD9+CdgCil++DazzFSkptg0okIi4hDJKQQbleFgfXHqtMUofzQOELYOH9hQT3rkBa4rO+rhqjJrudOpD1V5QPeQNxF2NH4cTyrQ6l0xej0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

On 2/18/2025 12:54 PM, Dave Hansen wrote:
> 
> BTW, is this kind of read/write normal for MMIO reads? It looks really
> goofy to me, but I don't deal with devices much.

Yeah, looking at some device code, functions like memcpy_toio() and 
__iowrite*_copy() seem to assume sufficient MMIO space to copy data from 
kernel memory. I also noticed that some other mailbox code calls back 
one of these functions.

So, I think your assessment is correct:

   > To me, it's much more akin to talking over a serial port than how I
   > think of devices attached via MMIO.

Certainly, this staging mailbox looks somewhat similar to a serial port. 
I suspect the staging portion is quite resource-limited. That appears to 
be one of key characteristics of this interface, which I should 
highlight more comprehensively.

Thanks,
Chang

