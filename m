Return-Path: <linux-kernel+bounces-286058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1D5951619
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F628B22144
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C85213CFAD;
	Wed, 14 Aug 2024 08:05:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE78381D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622753; cv=none; b=SDOsomlD8PRAX+yaPvOeCqHCgkwbgLt9qQMptuR0lpeu/RztJ6qJaFdLTtwnzluJ67PvyZld74GHTDCiYzG/S/7KMrVCEMGuV1h05sliZjO25bwnU0lR6RQy+eSEGGyytdWmx9vSzVIekPW/cjkWF80kCYUesvDv1NkMoivXhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622753; c=relaxed/simple;
	bh=p6yV2FvIY9V9sh/OTwkf3vAtBJ/P7E8L1QuQh75FOAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QM12Ll0ZxVCTqf5vOF1xn1At9CqOiaNOd6I+yhh+Yh2ETmVbh2mVvqyqgJrFtWotu+/2ZKbU0kVDLxd07RmavExDIRYtaKfLaby2f6dxSZH4SzDVC+yL8zDcXaNKVXxXzHWInAoiKyebr1cVXFNLZ3BnjuvVhntm6oxGnQ+6Eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkLKD5zdtz2CmfY;
	Wed, 14 Aug 2024 16:00:32 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id AE6F31A016C;
	Wed, 14 Aug 2024 16:05:24 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 16:05:24 +0800
Message-ID: <8500d58c-e6c5-04c7-73a0-38d3f77f2cb7@hisilicon.com>
Date: Wed, 14 Aug 2024 16:05:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
To: Beata Michalska <beata.michalska@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<vincent.guittot@linaro.org>, <vanshikonda@os.amperecomputing.com>,
	<sumitg@nvidia.com>, <yang@os.amperecomputing.com>, <lihuisong@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <ZowdalL3DfkHtaCg@arm.com> <Zo_lN8jdgADwqvor@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <Zo_lN8jdgADwqvor@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)


On 11/07/2024 21:59, Beata Michalska wrote:
> Hi Catalin,
>
> On Mon, Jul 08, 2024 at 06:10:02PM +0100, Catalin Marinas wrote:
>> Hi Beata,
>>
>> On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
>>> Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
>>> existing implementation for FIE and AMUv1 support: the frequency scale
>>> factor, updated on each sched tick, serves as a base for retrieving
>>> the frequency for a given CPU, representing an average frequency
>>> reported between the ticks - thus its accuracy is limited.
>>>
>>> The changes have been rather lightly (due to some limitations) tested on
>>> an FVP model. Note that some small discrepancies have been observed while
>>> testing (on the model) and this is currently being investigated, though it
>>> should not have any significant impact on the overall results.
>> What's the plan with this series? Are you still investigating those
>> discrepancies or is it good to go?
>>
> Overall it should be good to go with small caveat:
> as per discussion [1] we might need to provide new sysfs attribute exposing an
> average frequency instead of plugging new code under existing cpuinfo_cur_freq.
> This is to avoid messing up with other archs and make a clean distinction on
> which attribute provides what information.
> As such, the arch_freq_get_on_cpu implementation provided within this series
> [PATCH v6 3/4] will most probably be shifted to a new function.
>
> Hopefully will be able to send those changes soon.
>
> ---
> [1] https://lore.kernel.org/all/ZmrB_DqtmVpvG30l@arm.com/
> ---
> BR
> Beata
>
>> -- 
>> Catalin
>>
Hi Beata,

I've recently tested this patchset on a Kunpeng system.
It works as expected when reading scaling_cur_freq.
The frequency samples are much stabler than what cppc_cpufreq returns.

A few minor things.

1. I observed larger errors on idle cpus than busy cpus, though it's 
just up to 1%.
Not sure if this comes from the uncertain time interval between the last 
tick and entering idle.
The shorter averaging interval, the larger error, I supposed.

2. In the current implementation, the resolution of frequency would be:
max_freq_khz / SCHED_CAPACITY_SCALE
This looks a bit unnecessary to me.

It's supposed to get a better resolution if we can do this in 
arch_freq_get_on_cpu():

freq = delta_cycle_cnt * max_freq_khz / delta_const_cnt

which may require caching both current and previous sets of counts in 
the per-cpu struct amu_cntr_sample.

Kind regards,
Jie


