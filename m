Return-Path: <linux-kernel+bounces-265867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684793F6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980621C21DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2C14C5B0;
	Mon, 29 Jul 2024 13:49:20 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0C1E515
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260960; cv=none; b=fOY0MflvE2tozlFYQSJYamxZQ0gnxuhF/9nfaBzdZxiYpdjdxy4WwuURlba2jVV8zbfbrdy7uUNt4VSSVV5p+poOZhZbuGSPkKbrJeYootVKJOf+sBQcAfin4fVeKw+H4CcTi5VX+HO2uvfYLMI3H8duEBMRx1HhX+vZhcDN9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260960; c=relaxed/simple;
	bh=ic8XRQiAlqkQrB7MWDOfDz6qDcJBANBuGQ4l/VlFBQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mhz6wghANsgeZgdnynbFkQIDeNLvJryUWWFyB5kupmyQ/iAm4t+bZEuKwD6aOwzOEJg2NZABSA6BkzjgMU8diC9/ofhDtIJcpKQCjo5VDxxyNhlW+CVb3ykpwEd7/gj9MtUPpUiXga0VlnGhoCPwfKKVolcuhkTFtvEFhN4j6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4WXf0Q4b3Qz9v7Hk
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:12:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E465E140877
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:30:51 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwAXToiAmadmLA0jAA--.48820S2;
	Mon, 29 Jul 2024 14:30:51 +0100 (CET)
Message-ID: <eb9548de-e66e-3dcd-9136-8702a5bc2934@huaweicloud.com>
Date: Mon, 29 Jul 2024 15:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
To: Alan Stern <stern@rowland.harvard.edu>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
 <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
 <4792c9e7-2594-3600-5d82-4cb1443fe670@huaweicloud.com>
 <d6a76968-d10b-c60b-245a-f58116eca6af@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d6a76968-d10b-c60b-245a-f58116eca6af@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXToiAmadmLA0jAA--.48820S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryDZr4UWw17CFWxAFWfuFg_yoWxGw15p3
	yDXFZ8Jrs8Zw48C3ykKa1UXwn5KrWqy345XrWrt34YvFnxKrWrWay0yw4q9F1UAw1Ivw1k
	ZF17JF98CFsrJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8eH
	q7UUUUU==
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 7/12/2024 10:06 AM, Hernan Ponce de Leon wrote:
> On 6/10/2024 10:38 AM, Hernan Ponce de Leon wrote:
>> On 6/8/2024 3:00 AM, Alan Stern wrote:
>>> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>>>
>>>>
>>>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>>>> Just to clarify: Your first step encompasses patches 1 - 3, and the
>>>>> second step is patch 4.  The first three patches can be applied 
>>>>> now, but
>>>>> the last one needs to wait until herd7 has been updated.  Is this all
>>>>> correct?
>>>>
>>>> Exactly.
>>>
>>> With regard to patch 4, how much thought have you and Hernan given to
>>> backward compatibility?  Once herd7 is changed, old memory model files
>>> will no longer work correctly.
>>>
>>
>> Honestly, I did not think much about this (at least until Akira 
>> mentioned in my PR). My hope was that changes to the model could be 
>> back-ported to previous kernel versions. However that would not work 
>> for existing out-of-tree files.
>>
>> My question is: is compatibility with out-of-tree files really a 
>> requirement? I would argue that if people are using outdated models, 
>> they may get wrong results anyway. This is because some of the changes 
>> done to lkmm during the last few years change the expected result for 
>> some litmus tests.
>>
>> Hernan
> 
> I pushed some new changes to the code for backward compatibility [1]. 
> The series also needs the patch at the bottom to properly deal with the 
> ordering of failing CAses and non-returning operations. With it, all 
> litmus tests return the correct result (the script needs to pass option 
> -lkmm-legacy false to herd).

I have been playing around with an alternative to this.

Rather than implementing this as an "option", I can implemented it as a 
"model variant (*)" and add this to the model

flag ~empty (if "lkmmlatest" then 0 else _)
   as new-lkmm-models-require-variant-lkmmlatest

If the user forgets to set the variant for the new model, herd7 will 
flag the executions showing that something is off.

To be fully backward compatible, we would need to backport this to old 
models

flag ~empty (if "lkmmlatest" then 1 else _)
   as new-lkmm-models-require-variant-lkmmlatest

If the user (wrongly) sets the variant for an old model, the the 
executions will be flagged.

Any thoughts?

Hernan

(*) This trick seems to be used for some arm models

https://github.com/herd/herdtools7/blob/master/herd/libdir/arm-models/mixed/ec.cat#L66C1-L67C67

> 
> Implementation-wise, there are two things that I would like to have:
> 
> - atomic_add_unless implementation is treated different than the rest 
> and it is one of the few remaining cases where memory orderings are 
> hardcoded [2]. I would like to define it in the .def file as
> 
>      atomic_add_unless(X,V,U) __atomic_add_unless{ONCE}(X,V,U)
> 
> - "deref" and "lderef" instructions seems to add a "rb_dep" fence. None 
> of the model files (.cat, .def, .bell) refers to "rb_dep" so this looks 
> useless to me. However, I never checked the details of these 
> dereferencing instruction so I might be missing something. Maybe Paul 
> can clarify.
> 
> Hernan
> 
> [1] https://github.com/herd/herdtools7/pull/865
> [2] https://github.com/herd/herdtools7/issues/868
> 
> 
> diff --git a/tools/memory-model/linux-kernel.def 
> b/tools/memory-model/linux-kernel.def
> index 001366ff3fb4..5a40c2cad39b 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -32,10 +32,10 @@ xchg(X,V)  __xchg{MB}(X,V)
>   xchg_relaxed(X,V) __xchg{ONCE}(X,V)
>   xchg_release(X,V) __xchg{RELEASE}(X,V)
>   xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
> -cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
> -cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
> -cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
> -cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
> +cmpxchg(X,V,W) __cmpxchg{MB,ONCE}(X,V,W)
> +cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE,ONCE}(X,V,W)
> +cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE,ONCE}(X,V,W)
> +cmpxchg_release(X,V,W) __cmpxchg{RELEASE,ONCE}(X,V,W)
> 
>   // Spinlocks
>   spin_lock(X) { __lock(X); }
> @@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
>   atomic_read_acquire(X) smp_load_acquire(X)
>   atomic_set_release(X,V) { smp_store_release(X,V); }
> 
> -atomic_add(V,X) { __atomic_op(X,+,V); }
> -atomic_sub(V,X) { __atomic_op(X,-,V); }
> -atomic_and(V,X) { __atomic_op(X,&,V); }
> -atomic_or(V,X)  { __atomic_op(X,|,V); }
> -atomic_xor(V,X) { __atomic_op(X,^,V); }
> -atomic_inc(X)   { __atomic_op(X,+,1); }
> -atomic_dec(X)   { __atomic_op(X,-,1); }
> -atomic_andnot(V,X) { __atomic_op(X,&~,V); }
> +atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
> +atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
> +atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
> +atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
> +atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
> +atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
> +atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
> +atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }
> 
>   atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
>   atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
> @@ -127,10 +127,10 @@ atomic_xchg(X,V) __xchg{MB}(X,V)
>   atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
>   atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
>   atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
> -atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
> -atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
> -atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
> -atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
> +atomic_cmpxchg(X,V,W) __cmpxchg{MB,ONCE}(X,V,W)
> +atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE,ONCE}(X,V,W)
> +atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE,ONCE}(X,V,W)
> +atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE,ONCE}(X,V,W)
> 
>   atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
>   atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0


