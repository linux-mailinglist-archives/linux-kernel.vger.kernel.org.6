Return-Path: <linux-kernel+bounces-313995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244396AD74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D81C23545
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE1A59;
	Wed,  4 Sep 2024 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bowVj6zp"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1665C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410853; cv=none; b=ERwmPVwRKI2ZnapJkapXj3hVpEMMsH2HiOA2JW1oR9KvxHSvbEG7uT0FVEiDCUKjh3WYv420EOE2M5umGFOW9xu24VAmBImb2oL73Rp+T92lCTOR4aFPHWfJpdH/6O0RZGw+jGb5enV8641BrMZVUcs+fd3Y2M4SR+NKJdQbAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410853; c=relaxed/simple;
	bh=G5uYVegBGlnRLzocZx51C5DL/ZatcBlUnRRF70TPF3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyBc7TGn+6agLcp8yytm/PuuxSVqPESAflnWIDadIQX6yovtaOGDhuPKsFVHp2Pda/WO/3Z7ck5ZmAg4sCBSi3blDuIEF8AVF5JDwjLGq1newgtxa3r0bxwvFMvZUI4C6uSGzDyjiU4rFce049RYGU3Y59679dM426SuTUu1tPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bowVj6zp; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725410849;
	bh=G5uYVegBGlnRLzocZx51C5DL/ZatcBlUnRRF70TPF3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bowVj6zpCCFv2zw/Dys3wJexcwgZgAy3+l+MWmp+CK9KSp4zVvjgjdAv6F3tGyB7b
	 MqNDlFwXjgOWeFTGUdzQEEi+GIgZr7E3mfeqUfNmQ4xupxBMJDxGwfiAj10Uk61Ltq
	 FyqFp6fPs5i7bYAlRXUOfoSUynki6wMufUmYTdj+Xmu90xxquKGJkaeIGGGPgYl6YV
	 peVj1CZ3SWaTPKKJiLZKL2n8kPQtA6O1EEUelQqRHkwW4etXldZO0Q1g8JW2L5MZPe
	 lvq6yh6c10JV50cNwSNpO4ey8zebxNE44ZA23df/vMwbffDoz8dr8KWilW1PrOxqmc
	 KZJu8vs+s9ZJg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wz3js2TNKz1JbL;
	Tue,  3 Sep 2024 20:47:29 -0400 (EDT)
Message-ID: <48ffca41-da1a-4ee6-b0aa-5ad0be035c7d@efficios.com>
Date: Tue, 3 Sep 2024 20:47:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] cpumask: Implement cpumask_next_andnot
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-2-mathieu.desnoyers@efficios.com>
 <Ztdjd9s-eLKrTU9g@yury-ThinkPad>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Ztdjd9s-eLKrTU9g@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-03 15:28, Yury Norov wrote:
> On Tue, Sep 03, 2024 at 03:06:49PM -0400, Mathieu Desnoyers wrote:
>> Allow finding the next bit within two input cpumasks which is
>> respectively one and zero.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>

Thanks for the ack. However based on our discussion in the other
leg of this thread, I can simply use

+       for_each_cpu_andnot(cpu, cpumask, mm_allowed)
+               nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);

which is already present in the API. I will drop this patch from
my series.

Thanks,

Mathieu

> 
>> ---
>>   include/linux/cpumask.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index 23686bed441d..5da1c66cfa65 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -246,6 +246,23 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>>   	return find_next_zero_bit(cpumask_bits(srcp), small_cpumask_bits, n+1);
>>   }
>>   
>> +/**
>> + * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
>> + * @n: the cpu prior to the place to search (ie. return will be > @n)
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static __always_inline
>> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	/* -1 is a legal arg here. */
>> +	if (n != -1)
>> +		cpumask_check(n);
>> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits, n+1);
>> +}
>> +
>>   #if NR_CPUS == 1
>>   /* Uniprocessor: there is only one valid CPU */
>>   static inline unsigned int cpumask_local_spread(unsigned int i, int node)
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


