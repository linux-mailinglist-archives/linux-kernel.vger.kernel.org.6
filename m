Return-Path: <linux-kernel+bounces-299643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C295D80D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1441C2218E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4C91C7B97;
	Fri, 23 Aug 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="STS8bVK4"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523941922E4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446317; cv=none; b=U+8efj6crCrVFpl3cfebYCHERYjfIhpwlMEr8Lgh/QVzSfB9ugDGKHRZD790dNZEQ2LCs+fU/tKCAkuAg4pJX84922GTVXoqoTZ05lzaMqhBWfXZhYOoTWbNm1RjYmBwLdr1QQx0ws6FOFgenWGHg7NIySwBb/y8fRexS4ryuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446317; c=relaxed/simple;
	bh=gQWnVtHzGUD5Eaocx7K6D34k/NCBwU4GS1eCmtQ1dOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe2QMHwc/ngZUjKiKAI4jm2K1Wum7ltwdJpC8+jBRG8GC6lRmJ0bargmfauzB5KKPa1fdLZmIcigVSlaORBVgleG6YOkrpz3Bw6JODB8UUJL0KUccSaqxGhz5LkSth2Kv5sGufAA+/a6LrfNDO5uUrm2xiqcAY2YmaT71BDiRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=STS8bVK4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724446314;
	bh=gQWnVtHzGUD5Eaocx7K6D34k/NCBwU4GS1eCmtQ1dOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STS8bVK4p0tgRs5uYG10QsWsHkhes9/aZZsq1kceRLu6944iCcV/79F5i7WJL9RDD
	 2QFrKHdPDSIYpa5JHFl36TpgoZxBedCJmFfyQC++e5VXjcoZe5tD5d3e1iqZiTGQfr
	 cDEtCy285OOHvtSU7XaGsEPrb60EyVLJsOP6GB7bFwm9MErjTJ3yNyLvkc7gmf7z06
	 uZcRQVPSkpJ5JvCjbM6Ww0v5OsBZYZbEmLnQ05rfWuvsBoqnJlOZxIM3jeZfo4zprU
	 KCeOjcgZQSBm2p3g7Po+NBilaqur7VK82fBIlACNYLlo7bQlbr/NRCz1nj26kVH0LI
	 rYUq/37SUowuA==
Received: from [IPV6:2606:6d00:100:4000:b243:804e:3bbd:91c9] (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WrC161XrRz1Hxl;
	Fri, 23 Aug 2024 16:51:54 -0400 (EDT)
Message-ID: <2c54b801-5f78-4f5a-bed0-a944ac5248e4@efficios.com>
Date: Fri, 23 Aug 2024 16:51:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/6] lib: Implement find_{first,next,nth}_nor_bit,
 find_first_andnot_bit
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-3-mathieu.desnoyers@efficios.com>
 <Zsjg1H_V8eq3-grK@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zsjg1H_V8eq3-grK@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-23 21:19, Yury Norov wrote:
> On Fri, Aug 23, 2024 at 02:59:42PM -0400, Mathieu Desnoyers wrote:
>> Allow finding the first, next, or nth bit within two input bitmasks
>> which is zero in both masks.
>>
>> Allow fiding the first bit within two input bitmasks which is set in
>> first mask and cleared in the second mask. find_next_andnot_bit and
>> find_nth_andnot_bit already exist, so find the first bit appears to be
>> missing.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>
> 
> If it comes to v2, can you also add some sanity tests for the new API?

I'm making a note to add those sanity tests before sending a v2.

Thanks,

Mathieu

> 
>> ---
>> Changes since v0:
>> - Rename "notandnot" to "nor", document equivalence.
>> - Move comment cleanups to a separate patch.
>> - Use __always_inline.
>> ---
>>   include/linux/find.h | 112 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/find_bit.c       |  36 ++++++++++++++
>>   2 files changed, 148 insertions(+)
>>
>> diff --git a/include/linux/find.h b/include/linux/find.h
>> index 8a170aa55634..b1394ba92654 100644
>> --- a/include/linux/find.h
>> +++ b/include/linux/find.h
>> @@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
>>   					unsigned long nbits, unsigned long start);
>>   unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   					unsigned long nbits, unsigned long start);
>> +unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
>> +					unsigned long nbits, unsigned long start);
>>   unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   					unsigned long nbits, unsigned long start);
>>   unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
>> @@ -24,11 +26,17 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
>>   				unsigned long size, unsigned long n);
>>   unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   					unsigned long size, unsigned long n);
>> +unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
>> +					unsigned long size, unsigned long n);
>>   unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   					const unsigned long *addr3, unsigned long size,
>>   					unsigned long n);
>>   extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>>   					 const unsigned long *addr2, unsigned long size);
>> +extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
>> +					 const unsigned long *addr2, unsigned long size);
>> +extern unsigned long _find_first_nor_bit(const unsigned long *addr1,
>> +					 const unsigned long *addr2, unsigned long size);
>>   unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   				      const unsigned long *addr3, unsigned long size);
>>   extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
>> @@ -130,6 +138,35 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>>   }
>>   #endif
>>   
>> +/**
>> + * find_next_nor_bit - find the next bit cleared in both *addr1 and *addr2
>> + * @addr1: The first address to base the search on
>> + * @addr2: The second address to base the search on
>> + * @size: The bitmap size in bits
>> + * @offset: The bitnumber to start searching at
>> + *
>> + * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
>> + * If no such bits are found, returns @size.
>> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
>> + */
>> +static __always_inline
>> +unsigned long find_next_nor_bit(const unsigned long *addr1,
>> +		const unsigned long *addr2, unsigned long size,
>> +		unsigned long offset)
>> +{
>> +	if (small_const_nbits(size)) {
>> +		unsigned long val;
>> +
>> +		if (unlikely(offset >= size))
>> +			return size;
>> +
>> +		val = ~(*addr1 | *addr2) & GENMASK(size - 1, offset);
>> +		return val ? __ffs(val) : size;
>> +	}
>> +
>> +	return _find_next_nor_bit(addr1, addr2, size, offset);
>> +}
>> +
>>   #ifndef find_next_or_bit
>>   /**
>>    * find_next_or_bit - find the next set bit in either memory regions
>> @@ -291,6 +328,33 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
>>   	return __find_nth_andnot_bit(addr1, addr2, size, n);
>>   }
>>   
>> +/**
>> + * find_nth_nor_bit - find N'th cleared bit in 2 memory regions.
>> + * @addr1: The 1st address to start the search at
>> + * @addr2: The 2nd address to start the search at
>> + * @size: The maximum number of bits to search
>> + * @n: The number of set bit, which position is needed, counting from 0
>> + *
>> + * Returns the bit number of the N'th bit cleared in the two regions.
>> + * If no such, returns @size.
>> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
>> + */
>> +static __always_inline
>> +unsigned long find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
>> +				unsigned long size, unsigned long n)
>> +{
>> +	if (n >= size)
>> +		return size;
>> +
>> +	if (small_const_nbits(size)) {
>> +		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
>> +
>> +		return val ? fns(val, n) : size;
>> +	}
>> +
>> +	return __find_nth_nor_bit(addr1, addr2, size, n);
>> +}
>> +
>>   /**
>>    * find_nth_and_andnot_bit - find N'th set bit in 2 memory regions,
>>    *			     excluding those set in 3rd region
>> @@ -346,6 +410,54 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>>   }
>>   #endif
>>   
>> +/**
>> + * find_first_andnot_bit - find the first set bit in 2 memory regions,
>> + *                         flipping bits in 2nd region.
>> + * @addr1: The first address to base the search on
>> + * @addr2: The second address to base the search on
>> + * @size: The bitmap size in bits
>> + *
>> + * Returns the bit number for the next set bit.
>> + * If no bits are set, returns @size.
>> + */
>> +static __always_inline
>> +unsigned long find_first_andnot_bit(const unsigned long *addr1,
>> +				 const unsigned long *addr2,
>> +				 unsigned long size)
>> +{
>> +	if (small_const_nbits(size)) {
>> +		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
>> +
>> +		return val ? __ffs(val) : size;
>> +	}
>> +
>> +	return _find_first_andnot_bit(addr1, addr2, size);
>> +}
>> +
>> +/**
>> + * find_first_nor_bit - find the first cleared bit in 2 memory regions
>> + * @addr1: The first address to base the search on
>> + * @addr2: The second address to base the search on
>> + * @size: The bitmap size in bits
>> + *
>> + * Returns the bit number for the next cleared bit.
>> + * If no bits are set, returns @size.
>> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
>> + */
>> +static __always_inline
>> +unsigned long find_first_nor_bit(const unsigned long *addr1,
>> +				 const unsigned long *addr2,
>> +				 unsigned long size)
>> +{
>> +	if (small_const_nbits(size)) {
>> +		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
>> +
>> +		return val ? __ffs(val) : size;
>> +	}
>> +
>> +	return _find_first_nor_bit(addr1, addr2, size);
>> +}
>> +
>>   /**
>>    * find_first_and_and_bit - find the first set bit in 3 memory regions
>>    * @addr1: The first address to base the search on
>> diff --git a/lib/find_bit.c b/lib/find_bit.c
>> index 0836bb3d76c5..8050bc7c7ede 100644
>> --- a/lib/find_bit.c
>> +++ b/lib/find_bit.c
>> @@ -116,6 +116,28 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>>   EXPORT_SYMBOL(_find_first_and_bit);
>>   #endif
>>   
>> +/*
>> + * Find the first set bit in two memory regions, flipping bits in 2nd region.
>> + */
>> +unsigned long _find_first_andnot_bit(const unsigned long *addr1,
>> +				  const unsigned long *addr2,
>> +				  unsigned long size)
>> +{
>> +	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
>> +}
>> +EXPORT_SYMBOL(_find_first_andnot_bit);
>> +
>> +/*
>> + * Find the first cleared bit in two memory regions.
>> + */
>> +unsigned long _find_first_nor_bit(const unsigned long *addr1,
>> +				  const unsigned long *addr2,
>> +				  unsigned long size)
>> +{
>> +	return FIND_FIRST_BIT(~(addr1[idx] | addr2[idx]), /* nop */, size);
>> +}
>> +EXPORT_SYMBOL(_find_first_nor_bit);
>> +
>>   /*
>>    * Find the first set bit in three memory regions.
>>    */
>> @@ -167,6 +189,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
>>   }
>>   EXPORT_SYMBOL(__find_nth_andnot_bit);
>>   
>> +unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
>> +				 unsigned long size, unsigned long n)
>> +{
>> +	return FIND_NTH_BIT(~(addr1[idx] | addr2[idx]), size, n);
>> +}
>> +EXPORT_SYMBOL(__find_nth_nor_bit);
>> +
>>   unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
>>   					const unsigned long *addr2,
>>   					const unsigned long *addr3,
>> @@ -194,6 +223,13 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
>>   EXPORT_SYMBOL(_find_next_andnot_bit);
>>   #endif
>>   
>> +unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
>> +					unsigned long nbits, unsigned long start)
>> +{
>> +	return FIND_NEXT_BIT(~(addr1[idx] | addr2[idx]), /* nop */, nbits, start);
>> +}
>> +EXPORT_SYMBOL(_find_next_nor_bit);
>> +
>>   #ifndef find_next_or_bit
>>   unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>>   					unsigned long nbits, unsigned long start)
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


