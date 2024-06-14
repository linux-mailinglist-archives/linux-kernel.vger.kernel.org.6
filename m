Return-Path: <linux-kernel+bounces-215530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0090942F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E230F285D43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFB1862AE;
	Fri, 14 Jun 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfxjKfn7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EEAA954
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718404711; cv=fail; b=Dl8mKoSm+kA3IB931ZarslvbRPcpBs/NowEuFn54Og1iMfM2EG7qU48Sjs8EF9oRl4xzsK4UEELdEVvgRW7UoptyHEdaAfsb8NqZBTyWzXmFP++dkJprRffpTtR+8U+r350dFZnLn+wgAzpu9gnMYN2r9Gc8qKaPAEKkuLWh7CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718404711; c=relaxed/simple;
	bh=EqaJss3mbK9O/6Vx69/svEapt44rLbxE4PhuqGe9ZF0=;
	h=Date:From:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hDah7R+4+F+7me1q6czxQrZR5oyKK6GXc/f5VCWE3n9ZDgtnI/FiEasC5Yy4kX7ZJpJ0EUneCKKl09Umb7pGAq6f8RjL5PJa/Myfp0H/w+iMcgnOE+XpYSD60dqUCQRTLRfKyijef5rUmJXq4bA1hsbzTpMYs2htCGK2OtyrghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfxjKfn7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718404710; x=1749940710;
  h=date:from:cc:subject:message-id:references:in-reply-to:
   mime-version;
  bh=EqaJss3mbK9O/6Vx69/svEapt44rLbxE4PhuqGe9ZF0=;
  b=dfxjKfn7o8q074To1knObvTUjJn9L2ORqNIklZDnEeYnLi8st6ukV7xO
   22bL/8VVqdF9Ts8NRbNyFKgvXL9YQZLbz++c1/aV2WAfhqlM8u/Q6+l62
   QBlhZrRCKh/jNi77v1DbJGlrr9XlID+Rdv2GiumQHv0S9fmZMR04BMEzO
   O8s+xg9FTGTul4CYGKekHygM+bULRnCqGuDHb8LjBm6C2+oiqNU/BJEJW
   230POvq9/WzfYZoOa2CVOKrM4+vmljTswjiQDvcOSFM/mt+kknDcMD31R
   unhIO1Mx5TxQgo84Rt9wbvB6e24NLBC/KPThVcJImbiPOoFTwgAOb8G4D
   w==;
X-CSE-ConnectionGUID: G2ggLYdeQY2DnHRM60sq2A==
X-CSE-MsgGUID: 83OdsY2yTsOzEiijHp7VKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19168328"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="19168328"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 15:38:29 -0700
X-CSE-ConnectionGUID: vQCAOfpqRA68ULamkgXa+w==
X-CSE-MsgGUID: 7QV5aZ0xR2OcFOuxboe+YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="71843710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 15:38:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 15:38:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 15:38:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 15:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQXII+xor4khaIYqXPCidi1Js9hHJEqk+pq+Ka0QVrnnSfg5ZCqbAjxiuJNvEWmAF87nhAsE56yrcg5INluLVCzdlUajKmn4eWgNcjfkOptt0ZkrgFQtVZSNp8SlA2iQhubBg2oC/hKkQVNBMSi75fQMYAVJXBdtW2wvnJ3lPerh8mKj6JDEgoWUZV890LH5OaB19k9U5pmSxrPRiwqQce/k9DIldU6B+Svo4ZMa8K9rtFUgY/d+ZrRl17McjH/6a64HjlCCC9lp3RWYvPLp+rOXf5yTrvAnD5LDs6QGZD33q3eSj23gSzmN3Zy9xU1Iq9OktenAMlVFwog2BpZvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGWKuUuBqRb8tEHEBEikQsrPcS+caqZzA9IkiNRVpCw=;
 b=X/WpvYh/rafIeL6HpQFzK2wchQeGU67mPJpFr/BtTrLcYWtOa6Cg9VDjb9a+lIazo6TNIsHDuEvD4smkkhAI/2xYuCeSH3Z4swGpq+5QN1UVByZDEJLE4/vkn6O1Jv8me6YOoMZf0WKPONs4Lg9+S93BquhFBxr3e29odvwZTWT7vZUJfBHgEL0ou4WNcl2V6aDa7QDFNHY9Pe2tKytnOqzEmsCXt1+n6PDJZAD973DxFQ0HkgGQlvArllOticTzqQrnowu1HTieAiUjLVX3HP/1eC6tggMM4cW+0an878VU+dGo+HHQJh7eCrTH8/Y9OBAr3b6wBdHWtXvQiiSISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB7006.namprd11.prod.outlook.com (2603:10b6:303:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 22:38:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 22:38:25 +0000
Date: Fri, 14 Jun 2024 17:38:20 -0500
From: Ira Weiny <ira.weiny@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: Fix devs leaks in scan_labels()
Message-ID: <666cc65c76781_262728294ae@iweiny-mobl.notmuch>
References: <20240604031658.951493-1-lizhijian@fujitsu.com>
 <6661e897cfd4c_16ff40294f@iweiny-mobl.notmuch>
 <5a5c91a4-9b0c-47d7-a9e9-43d15a28c0d4@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a5c91a4-9b0c-47d7-a9e9-43d15a28c0d4@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 410517cb-f86b-44e6-0411-08dc8cc2b414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VNjRJIIhy41EgKN4LTK0WToGEUprDL7R13la+0iWC6b4PYh55jnOaRcYiOzg?=
 =?us-ascii?Q?nS4me1KbYF8UPqUupGrp79vjkj3xUGlDHwlrF9yNQzczcxMsxFcry3L2p49F?=
 =?us-ascii?Q?tjZ/Ky0tHIKAKTu2D0mvBaP9YiOeLvPZ0Vx8qYqEzbopSral+cv5OcTFpivy?=
 =?us-ascii?Q?hpmcluXr91dsUOi3qHy9VjEwA3TZKzKy2ffdDJt+DFjO5CN6gBYg301SwQ83?=
 =?us-ascii?Q?tMcRT04iVaL8N57hx9NikIhKDXj5ey/3wYXsBXp2cFkY6ehp9DEVJfrqq9VD?=
 =?us-ascii?Q?f3hu4j7lNdlce/JSQyzYxC/ptaSecxYrtdtvkEHAvkavGI85dGjHlc1ht6VC?=
 =?us-ascii?Q?0DnGJ/yf+SWD6ZZRAm5Sk36KwMXT01Hlv9M9PhGAfj/2jANz3PuOdHc8an9P?=
 =?us-ascii?Q?jnrBZuwXUCNHAXxS2L9OB5FSEX1w3x7Fzl37xZQ0tBsTf0dDZH+LJq07haC6?=
 =?us-ascii?Q?dyUa5lxAowTLSrhncLfZcYUeG9etXcwHxwKkJYwoNeNtDPiBQVK0lZFgxbZN?=
 =?us-ascii?Q?XPIL9dq3gb7WUmsa7pp1KBhB5EuNOHQktLBP5fELjgDYhLtrartVF/2CHy58?=
 =?us-ascii?Q?qpuh72BOrfCH2IjTZGZ/ytEaLtxNr1WuAD6I0E6V9gTyWPOSAy40u2D8tFMM?=
 =?us-ascii?Q?xJXBoYUNXEGpGzqwvVM70AVOovu6pcSJoLrUoyqoanfqa3gNcRododser8xK?=
 =?us-ascii?Q?9/mMcMjS8Isb+OMMukifI7H0h2UZEsE5BTa3b9vyGzdP2iUxdiRZ+veSO4aA?=
 =?us-ascii?Q?8Bz8LZhMz2KznIEq0qapmCD6EcfliK3MZj8vpl/SAeeCyn0i1KOqdyS7lFsf?=
 =?us-ascii?Q?pWtnT5oKKc1/tl9+FVQjZR8s3+rUlInEQhfBoOPnUdc0rp9cqnPTvoZbh12y?=
 =?us-ascii?Q?KEmo9HKhvai61SPlxldwEhRVlLIaouA2fEhImHEAu/MvIkZW+uKzDiNl4W2Z?=
 =?us-ascii?Q?fY4zF/m0BnV3DlJ2OZ+QA1xC5yK/lgPZ6W80qR7D4FlOSyi2mYvcETKzUMje?=
 =?us-ascii?Q?UHqU1myzZZWeUhIB1CizqhjhMSQLS133TNjAAwsnQVftaKf+uUlXa7Bdh8nf?=
 =?us-ascii?Q?c4/D07MGBmB7WZWEL8eoLajkdFQTl9s2P2ttjtadPZqy/le2XDa4gqwLunmX?=
 =?us-ascii?Q?LZV7tJ6Mb7ivIDnWvui2YEqi0iSkOPuUyftSw/F3HN0Izd0HKUnvn0rpqa7S?=
 =?us-ascii?Q?IIQQ8SHaSDow/2fntkI5wSQ0KlkcKcGCZ+HECBy02xNU3SA4D5SDQjxaj51B?=
 =?us-ascii?Q?pThSFYX3kugQjCOau5kn4NgfyjdqhZm6La5ThFeFK4yIIDVt60K4fKMOehur?=
 =?us-ascii?Q?QEuz9HIken0wjmXcuW+NfRlL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJbx71Hm/znPsFEScIDMniQx4hQHzFl4cDerpYKmv2V7ykRzV0z7pznSE1SZ?=
 =?us-ascii?Q?0rmICPkUmSMj0Q2JQNO+Pte/+W/8MVoW5F4hJ031+R+AvVvly8+oj5+KCRyN?=
 =?us-ascii?Q?tG/law02feegbGSLi12GIGHiiobenVkDjPDh2fk6NUzL2SJEJVRm8hD4b6l9?=
 =?us-ascii?Q?OgP9b5otHAc/Smwen33MTCIZNkoalZf6Pm52Ad/X7adrIwpas0KT9vIbWKRF?=
 =?us-ascii?Q?UP4I362KfGW/vJ8H7pAIuOxrFrAW1E8W1ndaq87Dt4ocqdWbLLm5V6CHhg7t?=
 =?us-ascii?Q?NpvBHnBSQOcxpRA9mFQ3G2lSc5bOWEv3gJy/l2m5Pvm4u+pAnkN9CvOweIau?=
 =?us-ascii?Q?WF7sg7YJ99J0BpY9oZ8J/lfSUKl9RIQb4mvRiT/PV+w7AXqyEdlfV3S74Jvl?=
 =?us-ascii?Q?SyqJWmeSew9HkZvn6CIVuRL4Z5KJX4SWVgvMQskvoycpaj3USHsB9bHxcKDJ?=
 =?us-ascii?Q?bE0zJ72peGu3Yoyvsd4Krv1Gq2rzRMOlnGKM3Z9/luO+Yey8JH39ooTrUCJK?=
 =?us-ascii?Q?ZFRQ0q7/n6BM+Ixwn5ras7pPo0E1R413g8CRbtDPQJ1HNxHmcH3hwImIa8bU?=
 =?us-ascii?Q?P8Jik8sEKds+wV5GQxyVS+MAX/uvcJagebPQMDX9XGvnja+TBpSdH5DJwRnC?=
 =?us-ascii?Q?6PJJDRGWwLNWyhiXMAuwi2MpBa5w+BcFHe+HR6YmtnL6LiihYXgbffpLwk9x?=
 =?us-ascii?Q?Xok8orzWM6+BkMuIO704kRothUl2TFEStv0qoYxgCnFmtVe4HNWE0wwDIgQc?=
 =?us-ascii?Q?42zOmfKyXYJhq12Otoqih0rEqoQB1h0BfGdO4PLpYkPCepeELsB6d+VPhoir?=
 =?us-ascii?Q?FTIEPL6bwbyKFke8t5K5+yiCNlsx59BLn8VIZBywGeowQBVjlGL78/ODhze/?=
 =?us-ascii?Q?gv8eZ9uiOQSh6AsSwXs7xJlW7X7bVu9zcH/GbK0x5LcKJKDPZzsPLLxpxua5?=
 =?us-ascii?Q?j2oft7m4JwekvIYICwsiOkfKh58aSkrM0frHPeDmvmLzyOwn3YfUp42KzlZ7?=
 =?us-ascii?Q?ucdN9gTuoqGrRanL+xD2aBUyvHCU7m7LLeSCtv8vHFnIebPEYwcPi+Qxbfv+?=
 =?us-ascii?Q?F4KP4KCsJi8UZh2zo2qhpoSg0qilfdD17u1pvB9Bl8dF9okoQeQEYMoktzTD?=
 =?us-ascii?Q?7pW4/Nqx7hAvTVfrKNcyy8nfZl/L+US1jbUJfGEtt5Zbqb7jdC32lpHoBOqZ?=
 =?us-ascii?Q?plpT1ClMhuEMB3QUkEzmJHIDIa905JWF2bRZeiWF/8Rnwz6Z2KBQ3mnITChW?=
 =?us-ascii?Q?/ItJ/VB4Kfu6Uc7s+V5hzQrn55j61PysuDNgUGiNvWQ1ZYKao8C96R14HlZ6?=
 =?us-ascii?Q?tWT/zt7AF9pSeDaSKQiW/TwYULbSb8HnjvkuGF9GMLOlJQyp3h2MBVrhcRrZ?=
 =?us-ascii?Q?qu8IPGXHI8iTtnNTYuPcvPSSUIP7PobBlFoRQjZTVDOBLeQsPEc2kJ1MYDLh?=
 =?us-ascii?Q?Eo4Zzp5Mib59ge+OLVrgzJbPrkO69ePcARaZBlC6lpDowiOznUm577CFm9Q1?=
 =?us-ascii?Q?qhRHrkizSyQhTsIAi1y5WVFkpg6PChfiL5Ur4Xlwok681VXZQCdTFXKjaUh5?=
 =?us-ascii?Q?aAHIapmdjiL0Az5EQCaZ9PP9ZfIvsB/C+ZYHj7Wa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 410517cb-f86b-44e6-0411-08dc8cc2b414
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:38:25.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT/YNvMc8L+lIXQNx15smDyYrJ0SFdVvXplrrmhZFIOlhl7CseCXg5+JYujlZkltWtf8uFAXUfwpTUIs44LVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7006
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 07/06/2024 00:49, Ira Weiny wrote:
> > Li Zhijian wrote:
> >> Don't allocate devs again when it's valid pointer which has pionted to
> >> the memory allocated above with size (count + 2 * sizeof(dev)).
> >>
> >> A kmemleak reports:
> >> unreferenced object 0xffff88800dda1980 (size 16):
> >>    comm "kworker/u10:5", pid 69, jiffies 4294671781
> >>    hex dump (first 16 bytes):
> >>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>    backtrace (crc 0):
> >>      [<00000000c5dea560>] __kmalloc+0x32c/0x470
> >>      [<000000009ed43c83>] nd_region_register_namespaces+0x6fb/0x1120 [libnvdimm]
> >>      [<000000000e07a65c>] nd_region_probe+0xfe/0x210 [libnvdimm]
> >>      [<000000007b79ce5f>] nvdimm_bus_probe+0x7a/0x1e0 [libnvdimm]
> >>      [<00000000a5f3da2e>] really_probe+0xc6/0x390
> >>      [<00000000129e2a69>] __driver_probe_device+0x78/0x150
> >>      [<000000002dfed28b>] driver_probe_device+0x1e/0x90
> >>      [<00000000e7048de2>] __device_attach_driver+0x85/0x110
> >>      [<0000000032dca295>] bus_for_each_drv+0x85/0xe0
> >>      [<00000000391c5a7d>] __device_attach+0xbe/0x1e0
> >>      [<0000000026dabec0>] bus_probe_device+0x94/0xb0
> >>      [<00000000c590d936>] device_add+0x656/0x870
> >>      [<000000003d69bfaa>] nd_async_device_register+0xe/0x50 [libnvdimm]
> >>      [<000000003f4c52a4>] async_run_entry_fn+0x2e/0x110
> >>      [<00000000e201f4b0>] process_one_work+0x1ee/0x600
> >>      [<000000006d90d5a9>] worker_thread+0x183/0x350
> >>
> >> Fixes: 1b40e09a1232 ("libnvdimm: blk labels and namespace instantiation")
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   drivers/nvdimm/namespace_devs.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> >> index d6d558f94d6b..56b016dbe307 100644
> >> --- a/drivers/nvdimm/namespace_devs.c
> >> +++ b/drivers/nvdimm/namespace_devs.c
> >> @@ -1994,7 +1994,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
> >>   		/* Publish a zero-sized namespace for userspace to configure. */
> >>   		nd_mapping_free_labels(nd_mapping);
> >>   
> >> -		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
> >> +		/* devs probably has been allocated */
> > 
> > I don't think this is where the bug is.  The loop above is processing the
> > known labels and should exit with a count > 0 if devs is not NULL.
> > 
> >  From what I can tell create_namespace_pmem() must be returning EAGAIN
> > which leaves devs allocated but fails to increment count.  Thus there are
> > no valid labels but devs was not free'ed.
> 
> Per the piece of the code, return EAGAIN and ENODEV could cause this issue in theory.
> 
> 1980                 dev = create_namespace_pmem(nd_region, nd_mapping, nd_label);
> 1981                 if (IS_ERR(dev)) {
> 1982                         switch (PTR_ERR(dev)) {
> 1983                         case -EAGAIN:
> 1984                                 /* skip invalid labels */
> 1985                                 continue;
> 1986                         case -ENODEV:
> 1987                                 /* fallthrough to seed creation */
> 1988                                 break;
> 1989                         default:
> 1990                                 goto err;
> 1991                         }
> 1992                 } else
> 1993                         devs[count++] = dev;
> 
> 
> > 
> > Can you trace the error you are seeing a bit more to see if this is the
> > case?
> 
> 
> I just tried, but I cannot reproduce this leaking again.
> When it happened(100% reproduce at that time), I probably had a corrupted LSA(I see empty
> output with command 'ndctl list'). It seemed the QEMU emulated Nvdimm device was broken
> for some reasons.

I agree that it was probably a corrupted LSA.  But that is where we need to fix
the bug.

The ENODEV will no longer be returned from create_namespace_pmem() AFAICS.
Which is why I pointed to the EAGAIN case.  This could also be another
cleanup as shown in[1].

But to clean this up completely one must account for the case that some labels
may be ok with a final label being found corrupted.  So the allocation of the
array should only occur when at least 1 valid label is found.

So combining these ideas I think the fix is as show in [2].  Could this case be
added as a test?  And then the patch checked out as a fix?

Ira


[1] because select_pmem_id() is always called with a valid pmem_id the ENODEV
case can never happen.  So From what I can see removing that error case thusly
is ok.

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..7069e7267a7d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1612,9 +1612,6 @@ static int select_pmem_id(struct nd_region *nd_region, const uuid_t *pmem_id)
 {
        int i;
 
-       if (!pmem_id)
-               return -ENODEV;
-
        for (i = 0; i < nd_region->ndr_mappings; i++) {
                struct nd_mapping *nd_mapping = &nd_region->mapping[i];
                struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -1790,9 +1787,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
        case -EINVAL:
                dev_dbg(&nd_region->dev, "invalid label(s)\n");
                break;
-       case -ENODEV:
-               dev_dbg(&nd_region->dev, "label not found\n");
-               break;
        default:
                dev_dbg(&nd_region->dev, "unexpected err: %d\n", rc);
                break;
@@ -1974,9 +1968,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
                        case -EAGAIN:
                                /* skip invalid labels */
                                continue;
-                       case -ENODEV:
-                               /* fallthrough to seed creation */
-                               break;
                        default:
                                goto err;
                        }


[2] Fix, compile tested only.

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..6401ebee3db2 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1612,9 +1612,6 @@ static int select_pmem_id(struct nd_region *nd_region, const uuid_t *pmem_id)
 {
        int i;
 
-       if (!pmem_id)
-               return -ENODEV;
-
        for (i = 0; i < nd_region->ndr_mappings; i++) {
                struct nd_mapping *nd_mapping = &nd_region->mapping[i];
                struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -1790,9 +1787,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
        case -EINVAL:
                dev_dbg(&nd_region->dev, "invalid label(s)\n");
                break;
-       case -ENODEV:
-               dev_dbg(&nd_region->dev, "label not found\n");
-               break;
        default:
                dev_dbg(&nd_region->dev, "unexpected err: %d\n", rc);
                break;
@@ -1961,12 +1955,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
                        goto err;
                if (i < count)
                        continue;
-               __devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
-               if (!__devs)
-                       goto err;
-               memcpy(__devs, devs, sizeof(dev) * count);
-               kfree(devs);
-               devs = __devs;
 
                dev = create_namespace_pmem(nd_region, nd_mapping, nd_label);
                if (IS_ERR(dev)) {
@@ -1974,15 +1962,18 @@ static struct device **scan_labels(struct nd_region *nd_region)
                        case -EAGAIN:
                                /* skip invalid labels */
                                continue;
-                       case -ENODEV:
-                               /* fallthrough to seed creation */
-                               break;
                        default: 
                                goto err;
                        }
-               } else
-                       devs[count++] = dev;
+               }
 
+               __devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
+               if (!__devs)
+                       goto err;
+               memcpy(__devs, devs, sizeof(dev) * count);
+               kfree(devs);
+               devs = __devs;
+               devs[count++] = dev;
        }
 
        dev_dbg(&nd_region->dev, "discovered %d namespace%s\n", count,

