Return-Path: <linux-kernel+bounces-310452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3410967D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D82820A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19A15E8B;
	Mon,  2 Sep 2024 01:12:12 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C21388
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239531; cv=none; b=R70vTJlv2vDew1xNVVsIyRp1gKrEHr3zOOdfmO1pE3cEmmfHoj71kUymAL02JAea1vCZdJyTbGVFtKkexmbftU7oHEgIAiuhgOQsYxIxUfQ8a9jiK6FoQibegF9ItXijirHTaP5ai8VGvvKgdcK+ucarudiq/B4C+uGZz1uWGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239531; c=relaxed/simple;
	bh=oovSLh9q96vpKtw4eca1UznpbBSR26ECWo+IY11AjCY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lLPu9i23Lv1cVPhvsjc/4v4DjN7NMrz5CgyiC8jtyWJuspY0Se2mTuZkVWDq8xUTEsM7vK626dxbe54hy6CdxbIVNVB9cH8hjiRMDxMllJaVnrsFrB8AwGpoSdN1grTQckpYN++xTQ+T5m92gse92dnKva+/rgmwdnCaWEGTY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WxrLk3lQkz1S9dp;
	Mon,  2 Sep 2024 09:11:42 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 58CEA1A0188;
	Mon,  2 Sep 2024 09:12:00 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 09:11:59 +0800
Message-ID: <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
Date: Mon, 2 Sep 2024 09:11:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
	<mgorman@techsingularity.net>, <mhocko@suse.com>, <dmaluka@chromium.org>,
	<liushixin2@huawei.com>, <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Content-Language: en-US
To: <ying.huang@intel.com>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/8/30 15:53, Huang, Ying wrote:
> Hi, Wupeng,
> 
> Wupeng Ma <mawupeng1@huawei.com> writes:
> 
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> The introduction of Per-CPU-Pageset (PCP) per zone aims to enhance the
>> performance of the page allocator by enabling page allocation without
>> requiring the zone lock. This kind of memory is free memory however is
>> not included in Memfree or MemAvailable.
>>
>> With the support of higt-order pcp and pcp auto-tuning, the size of the
>> pages in this list has become a matter of concern due to the following
>> patches:
>>
>>   1. Introduction of Order 1~3 and PMD level PCP in commit 44042b449872
>>   ("mm/page_alloc: allow high-order pages to be stored on the per-cpu
>>   lists").
>>   2. Introduction of PCP auto-tuning in commit 90b41691b988 ("mm: add
>>   framework for PCP high auto-tuning").
> 
> With PCP auto-tuning, the idle pages in PCP will be freed to buddy after
> some time (may be as long as tens seconds in some cases).

Thank you for the detailed explanation regarding PCP auto-tuning. If the
PCP pages are freed to the buddy after a certain period due to auto-tuning,
it's possible that there is no direct association between PCP auto-tuning
and the increase in the PCP count as indicated below, especially if no
actual tasks have commenced after booting. The primary reason for the
increase might be more orders and a surplus of CPUs.

> 
>> Which lead to the total amount of the pcp can not be ignored just after
>> booting without any real tasks for as the result show below:
>>
>> 		   w/o patch	  with patch	      diff	diff/total
>> MemTotal:	525424652 kB	525424652 kB	      0 kB	        0%
>> MemFree:	517030396 kB	520134136 kB	3103740 kB	      0.6%
>> MemAvailable:	515837152 kB	518941080 kB	3103928 kB	      0.6%

We do the following experiments which make the pcp amount even bigger:
1. alloc 8G of memory in all of the 600+ cpus
2. kill all the above user tasks 
3. waiting for 36h

the pcp amount 6161097(24644M) which 4.6% of the total 512G memory.


>>
>> On a machine with 16 zones and 600+ CPUs, prior to these commits, the PCP
>> list contained 274368 pages (1097M) immediately after booting. In the
>> mainline, this number has increased to 3003M, marking a 173% increase.
>>
>> Since available memory is used by numerous services to determine memory
>> pressure. A substantial PCP memory volume leads to an inaccurate estimation
>> of available memory size, significantly impacting the service logic.
>>
>> Remove the useless CONFIG_HIGMEM in si_meminfo_node since it will always
>> false in is_highmem_idx if config is not enabled.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> 
> This has been discussed before in the thread of the previous version,
> better to refer to it and summarize it.
> 
> [1] https://lore.kernel.org/linux-mm/YwSGqtEICW5AlhWr@dhcp22.suse.cz/

As Michal Hocko mentioned in previous discussion:
 1. If it is a real problem?
 2. MemAvailable is documented as available without swapping, however
    pcp need to drain reclaim.

1. Since available memory is used by numerous services to determine memory
pressure. A substantial PCP memory volume leads to an inaccurate estimation
of available memory size, significantly impacting the service logic.
2. MemAvailable here do seems wired. There is no reason to drain pcp to
drop clean page cache As Michal Hocko already pointed in this post, drain
clean page cache is much cheaper than drain remote pcp.Any idea on this?

[1] https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/
> 
> --
> Best Regards,
> Huang, Ying
> 

