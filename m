Return-Path: <linux-kernel+bounces-311903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1AB968F33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB41280D52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA18205E32;
	Mon,  2 Sep 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jmr49rwt"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88F1865F0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313394; cv=none; b=onLVJ+Iw0Z/wC4iYc7wURQ6+N0bH0PUYm7mJQA2DdePrMbq/EGRJNJnXF3WJHYBy8hqyQCrz5+XUsnqeIwHYHo4/JB3GvtRCzudUE56g9f6dX2R+QWT6tweQZM1+q1kPekGsXrj6I0RmcvmsSbdRQG6bScIaH+6cGdoEtwUvGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313394; c=relaxed/simple;
	bh=/LmvAI0nw6QPoke1J8AIDm/FiQqGZUXx/VmMhF64N0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4FhXCJ8kitdIN3GNEjY6sN3dP/+bt9ONjPDAq9ALVBBsmJBnm2eCOELS6hecYe/S7gNX4dIvgEILY6jT543tkAmAixBQqTy8ELmK0O/L4+lRD9Z3fr5419ESPZbch2P5pmFGfPw7Qd86zE3CWQ/YnjqvAWuZAaTaBwwOaeLBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jmr49rwt; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725313390;
	bh=/LmvAI0nw6QPoke1J8AIDm/FiQqGZUXx/VmMhF64N0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jmr49rwtoFOgngKyrc/3ISBxYMVDiXUaOuyRGBg/SSh9wVEuaDbqMviT0g80sazso
	 E+MSRTA2lxPfHwLshOuczLpZnedVHkdCcITLokJ3HjeNpjnR8bP5k1fRPgDXvI/xiH
	 R4efastQu2JOk6DbWq6FJ1jhc8wS+Ts85BfdHeZzF5oFXb/ClZw9w5LlOXAMA2tcjE
	 kLQGdQ3diWd9QP6HFFrfj4NhVrWVHqKg+KuzHNoZrpUoCOYj62rUzWXGOqt6z3k6G5
	 gLYsOsZF6fNdYSY3ppZJR6b7wu0bMv7xuyvuDr/1yiGUQSERT0lDhkmKV4WOJspaMZ
	 +J3+gS+E/iiNw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WyMgf0vdKz1JmD;
	Mon,  2 Sep 2024 17:43:10 -0400 (EDT)
Message-ID: <f0dbd190-df68-4b0e-963c-d6f7ada5dc77@efficios.com>
Date: Mon, 2 Sep 2024 17:42:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] lib: Extend bitmap find binary operations
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
 <ZtJPis2WKGgk9hvz@yury-ThinkPad>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZtJPis2WKGgk9hvz@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-30 19:02, Yury Norov wrote:
> On Fri, Aug 30, 2024 at 03:10:37PM -0400, Mathieu Desnoyers wrote:
>> Extend bitmap find.h and cpumask.h with additional binary operations
>> such as "nor".
>>
>> Also extend the testing and benchmark coverage of those bitmap find with
>> binary operations.
>>
>> This is useful for NUMA-aware rseq concurrency IDs which depend on this
>> series. The series can be found at:
>>
>> https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
>>
> 
> Added in bitmap-for-next for testing.

Hi Yuri,

FYI, after a lot of performance results analysis on variations over
the NUMA-aware rseq patch, I figured I need to take a drastically
different (and much simpler) approach to solve this in order to improve
cache locality as well, and it turns out I likely won't need the new
bitwise ops added by this series.

So feel free to keep it as a general improvement, or to drop it for
now.

Thanks,

Mathieu

> 
> Thanks,
> Yury
> 
>>
>> Mathieu Desnoyers (6):
>>    lib: Clarify comment on top of find_next_andnot_bit
>>    lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
>>      find_first_andnot_bit
>>    lib: test bitmap sets binary operation iterators
>>    lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
>>    lib: benchmark bitmap sets binary operation find
>>    cpumask: Implement cpumask_{first,next}_{nor,andnot}
>>
>>   include/linux/cpumask.h  |  60 ++++++++++++++++
>>   include/linux/find.h     | 124 +++++++++++++++++++++++++++++++--
>>   lib/find_bit.c           |  36 ++++++++++
>>   lib/find_bit_benchmark.c | 143 +++++++++++++++++++++++++++++++++------
>>   lib/test_bitmap.c        |  81 ++++++++++++++++++++++
>>   5 files changed, 418 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


