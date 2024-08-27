Return-Path: <linux-kernel+bounces-303366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E014A960B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E57E1C22A30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD01BC083;
	Tue, 27 Aug 2024 13:04:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327C19CCED
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763842; cv=none; b=VaSz1wZYTPLLBQna7/Kj+zh+w+CXvQr7RK7VPiTycIfoYigGmloapo1KkElb5vsQhhAwAksiB7zKxHDSt3X8hh5KnHJFg2z0amdMfzx80xN8qT7nrpQTomD73DprFhit/c+HU8TaJt7ITFQ65dqPMgGRXIM5GHSVtZJBeSHXP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763842; c=relaxed/simple;
	bh=vAaaZtMp9WuQ5mW3vfQRnnthO9IqPaBGhvatGQ4RRjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LXRQdCejFH0KnnHfh/kBBHGeNVSHvYuW3wZITU5PeYg95W2c5ZA8yV37qxL9TmlymH6GpzJ5JKfqOh9G3f1AjiBQZ6cWa8V9xAV11l5T/8NVd4v91iYRjtH3nW6N6o4OJXEBDa4DfrxUTtfiIMDUMlPL+YuKNcrQv74pQ+qsFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtSR63PmCz2CnX0;
	Tue, 27 Aug 2024 21:03:46 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E205140136;
	Tue, 27 Aug 2024 21:03:56 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 21:03:56 +0800
Message-ID: <643df4d5-ad44-f84a-6b15-614876d3cd2d@hisilicon.com>
Date: Tue, 27 Aug 2024 21:03:56 +0800
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
To: Beata Michalska <beata.michalska@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ionela.voinescu@arm.com>,
	<sudeep.holla@arm.com>, <will@kernel.org>, <vincent.guittot@linaro.org>,
	<vanshikonda@os.amperecomputing.com>, <sumitg@nvidia.com>,
	<yang@os.amperecomputing.com>, <lihuisong@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <ZowdalL3DfkHtaCg@arm.com> <Zo_lN8jdgADwqvor@arm.com>
 <8500d58c-e6c5-04c7-73a0-38d3f77f2cb7@hisilicon.com>
 <ZswtkBBieOgA9p-0@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ZswtkBBieOgA9p-0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 26/08/2024 15:24, Beata Michalska wrote:
> ...
>> Hi Beata,
> Hi Jie,
>> I've recently tested this patchset on a Kunpeng system.
>> It works as expected when reading scaling_cur_freq.
>> The frequency samples are much stabler than what cppc_cpufreq returns.
> Thank you for giving it a spin.
> (and apologies for late reply)
>> A few minor things.
>>
>> 1. I observed larger errors on idle cpus than busy cpus, though it's just up
>> to 1%.
>> Not sure if this comes from the uncertain time interval between the last
>> tick and entering idle.
>> The shorter averaging interval, the larger error, I supposed.
> All right - will look into it.
> Just for my benefit: that diff is strictly between arch_freq_avg_get_on_cpu
> and cpufreq_driver->get(policy->cpu) ?
I can't say whether it's "strictly" between them or not because 
driver->get()
shows a fluctuating value.
On my platform, cppc_cpufreq's driver->get() sometimes shows large errors on
busy cpus (as reported by recent emails), but quite accurate on idle 
cpus (<1%).

With this patch, the "error" on idle cpus as mentioned above is 
typically <1%,
hence better in general.
>> 2. In the current implementation, the resolution of frequency would be:
>> max_freq_khz / SCHED_CAPACITY_SCALE
>> This looks a bit unnecessary to me.
>>
>> It's supposed to get a better resolution if we can do this in
>> arch_freq_get_on_cpu():
>>
>> freq = delta_cycle_cnt * max_freq_khz / delta_const_cnt
>>
>> which may require caching both current and previous sets of counts in the
>> per-cpu struct amu_cntr_sample.
>>
> arch_freq_get_on_cpu relies on the frequency scale factor to derive the average
> frequency. The scale factor is being calculated based on the deltas you have
> mentioned and arch_max_freq_scale which uses SCHED_CAPACITY_SCALE*2 factor to
> accommodate for rather low reference frequencies. arch_freq_get_on_cpu just does
> somewhat reverse computation to that.
Yeah I understood this.

arch_freq_get_on_cpu() now returns:
freq = (arch_scale_freq_capacity() * arch_scale_freq_ref()) >> 
SCHED_CAPACITY_SHIFT

The frequency resolution is (arch_scale_freq_ref() >> 
SCHED_CAPACITY_SHIFT), which
is equivalent to max_freq_khz / SCHED_CAPACITY_SCALE.

If we can directly do
freq = delta_cycle_cnt * ref_freq_khz / delta_const_cnt
in arch_freq_get_on_cpu(), it's supposed to have a 1KHz resolution.
(sorry for the wrong multiplier in the last reply)

Just similar to what's done in [1].

It could be more worthwhile to have a good resolution than utilising the
arch_topology framework?

[1] 
https://lore.kernel.org/all/20240229162520.970986-2-vanshikonda@os.amperecomputing.com/
> ---
> BR
> Beata
>> Kind regards,
>> Jie
>>



