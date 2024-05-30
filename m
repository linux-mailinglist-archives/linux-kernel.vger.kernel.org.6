Return-Path: <linux-kernel+bounces-195788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14008D51D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B64284548
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACCE48788;
	Thu, 30 May 2024 18:33:48 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F24F1F9
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094027; cv=none; b=YuuImtD6UoKqGM/BAVPlBQfNDscvISm5K4rDhgMwIW2h4IiwJZzfjscfOzZeLHfkUf79jnQIZQnhgItLt1VYLSD0tuQX6QQG1KVgUUWO2hbUS8hc5KU/li9cZZ/LIM3kXIJi+4E2McWX6OyqM1zavrdvrNlSKwWs/SwzRNLbGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094027; c=relaxed/simple;
	bh=Aot609i/D+LsmVtGts+WP0sXbULZPSYF/7asm1U1WtE=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=iVDs3AJgp69+VhWbGN5HFQYHKzg0qK5GBzHOcPl1TNROUyrdQw1vnWwV9FJoB++/SF4zz2DUBhimdodquvMWACiycy/vVCGjrPMwxj5+Hgbiuwg72A4E9i/HSyFLip5C/Nzw40z7mjmyfyp7SYSYn0BIwlDGz5/w/0CFij9SmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VqvTD3wXWz9v7JY
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:11:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E16181404A6
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:33:34 +0800 (CST)
Received: from [10.48.223.126] (unknown [10.48.223.126])
	by APP2 (Coremail) with SMTP id GxC2BwAXTSFxxlhmY1w2CQ--.44919S2;
	Thu, 30 May 2024 19:33:34 +0100 (CET)
Message-ID: <905ec2b5-3fad-f3bc-4801-2186225145e1@huaweicloud.com>
Date: Thu, 30 May 2024 20:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH 0/4] tools/memory-model: Define more of LKMM in
 ,tools/memory-model
Content-Language: en-US
References: <12050799-e7e5-a7be-44c6-7b4832d56419@huaweicloud.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, jonas.oberhauser@huaweicloud.com
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <12050799-e7e5-a7be-44c6-7b4832d56419@huaweicloud.com>
X-Forwarded-Message-Id: <12050799-e7e5-a7be-44c6-7b4832d56419@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAXTSFxxlhmY1w2CQ--.44919S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF17tr4DZFWUWrW5CFykZrb_yoWrKFy5p3
	yUXFZ5ArW5Zw4kC395Ga1UZ34rKrWqy345XrWrt343ZF43KrW5Xa48CwsF9r17AryIqwn5
	ZF17XFy5CF9rAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

It seems I did something wrong when I imported to my email client the 
original email from Jonas and I removed most people form the recipient 
list. Thus, I am sending again my last email.

Sorry for the inconvenience.

	Hernan


-------- Forwarded Message --------
Subject: Re: [RFC][PATCH 0/4] tools/memory-model: Define more of LKMM in
Date: Thu, 30 May 2024 09:54:09 +0200
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, paulmck@kernel.org
CC: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org

On 5/29/2024 4:19 PM, Jonas Oberhauser wrote:
> Thanks for checking the results!
> 
>> The issue is probably that there are sill a few hardcoded tags in the 
>> code, like "noreturn" [3]. I am still not to sure what the best 
>> solution would be for those.
>>
>>      Hernan
> 
> IMHO the best thing to do with noreturn for the time being would be to 
> allow __atomic_op{NORETURN}(...), but that may require bigger changes in 
> herd (does it?).
>

I already added support for his.

I also removed the hardcoded memory orderings in the CAS events. Now we 
can specify both orderings as __cmpxchg{mo-pass,mo-fail}(X,V,W)

If I apply the patch below on top of the series, I get all correct results.

diff --git a/tools/memory-model/linux-kernel.def 
b/tools/memory-model/linux-kernel.def
index 001366ff3fb4..5a40c2cad39b 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -32,10 +32,10 @@ xchg(X,V)  __xchg{MB}(X,V)
  xchg_relaxed(X,V) __xchg{ONCE}(X,V)
  xchg_release(X,V) __xchg{RELEASE}(X,V)
  xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
-cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
-cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
-cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
-cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
+cmpxchg(X,V,W) __cmpxchg{MB,ONCE}(X,V,W)
+cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE,ONCE}(X,V,W)
+cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE,ONCE}(X,V,W)
+cmpxchg_release(X,V,W) __cmpxchg{RELEASE,ONCE}(X,V,W)

  // Spinlocks
  spin_lock(X) { __lock(X); }
@@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
  atomic_read_acquire(X) smp_load_acquire(X)
  atomic_set_release(X,V) { smp_store_release(X,V); }

-atomic_add(V,X) { __atomic_op(X,+,V); }
-atomic_sub(V,X) { __atomic_op(X,-,V); }
-atomic_and(V,X) { __atomic_op(X,&,V); }
-atomic_or(V,X)  { __atomic_op(X,|,V); }
-atomic_xor(V,X) { __atomic_op(X,^,V); }
-atomic_inc(X)   { __atomic_op(X,+,1); }
-atomic_dec(X)   { __atomic_op(X,-,1); }
-atomic_andnot(V,X) { __atomic_op(X,&~,V); }
+atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
+atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
+atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
+atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }

  atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
  atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
@@ -127,10 +127,10 @@ atomic_xchg(X,V) __xchg{MB}(X,V)
  atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
  atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
  atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
-atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
-atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
-atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
-atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
+atomic_cmpxchg(X,V,W) __cmpxchg{MB,ONCE}(X,V,W)
+atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE,ONCE}(X,V,W)
+atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE,ONCE}(X,V,W)
+atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE,ONCE}(X,V,W)

  atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
  atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0


> Do you have a more or less full list of the other hardcoded things?

I think this is what still remains hardcoded
- "srcu-lock" -> seems to be used to decide some value written by the 
memory events representing lock/unlock. Not yet sure what to do with this.
- a few "once" -> mostly related to AtomicAddUnless and return 
operations. I think we can replace those with macros. This is my next goal.
- "rb_dep" -> It seems "deref" and "lderef" are replaced by a load 
followed by a fence. The code doing the replacement states "Cannot do 
this with a macro, by lack of sequencing expression operator".

	Hernan


