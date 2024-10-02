Return-Path: <linux-kernel+bounces-348031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485F98E1B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2321C22E94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229E1D174A;
	Wed,  2 Oct 2024 17:35:01 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66211D173A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890501; cv=none; b=akBMA7nQUw8K46pYldmkV/Ai44KYGO08vKwR6LbbZKEQFQbL50xkqWTe3eGm1uj4UmPCR3V0TO/UrwlRL4qU1GoscC6BObF+VE9qASiGt9/Dk7C0gNZ4pMH8ES5GYYimjgkcrmtyCRvpFArWfyRZvTawspYIQ1lkIAaHAF/NX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890501; c=relaxed/simple;
	bh=HRBybnWMcqrqYqTMIuFAK4Fhl7228D+6vVrp4wOx3Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0Qup7g76IrmPm6yCDIiyVZHP9CZXpgt6pY9gSukB+uQ5gL/4/oBDqA8R2f+crCEHMeSOoduMsZzLyzx1iYHpwqnoJn09tS9p6iTNxqElluJ9eftBjVDlioH/OLtrqoULNhHBciBcxgXE/tjBd/c1AuJl96x+BhdNKf/95xCg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XJhJJ11lWz9v7NR
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C969D140934
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:34:41 +0800 (CST)
Received: from [10.48.222.239] (unknown [10.48.222.239])
	by APP2 (Coremail) with SMTP id GxC2BwBH9sYlhP1mo_UXAg--.23081S2;
	Wed, 02 Oct 2024 18:34:41 +0100 (CET)
Message-ID: <63236ee7-916a-ef6e-bc6e-051acb3caf95@huaweicloud.com>
Date: Wed, 2 Oct 2024 19:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/5] tools/memory-model: Switch to softcoded herd7 tags
Content-Language: en-US
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, paulmck@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-5-jonas.oberhauser@huaweicloud.com>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <20240930105710.383284-5-jonas.oberhauser@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBH9sYlhP1mo_UXAg--.23081S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7WFy8JF43Zr45uw17ZFb_yoW3ZF48pr
	s3XrZrKr4UXryUC3ykGr4UC3WrWw40y3yUGr1kJ34rZr12krs8A3W8Gr1vqryUJ34Utw48
	Xr12gFyqkr4UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 9/30/2024 12:57 PM, Jonas Oberhauser wrote:
> A new version of herd7 provides a -lkmmv2 switch which overrides the old herd7
> behavior of simply ignoring any softcoded tags in the .def and .bell files. We
> port LKMM to this version of herd7 by providing the switch in linux-kernel.cfg
> and reporting an error if the LKMM is used without this switch.

The changes required for this patch were already merged to herd7.

> 
> To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
> RMW which do not return a value and define atomic_add_unless with an Mb tag in
> linux-kernel.def.
> 
> We update the herd-representation.txt accordingly and clarify some of the
> resulting combinations.
> 
> (To be) Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>

Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>

> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>   .../Documentation/herd-representation.txt     | 27 ++++++++++---------
>   tools/memory-model/README                     |  2 +-
>   tools/memory-model/linux-kernel.bell          |  3 +++
>   tools/memory-model/linux-kernel.cfg           |  1 +
>   tools/memory-model/linux-kernel.def           | 18 +++++++------
>   5 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> index ed988906f2b7..7ae1ff3d3769 100644
> --- a/tools/memory-model/Documentation/herd-representation.txt
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -18,6 +18,11 @@
>   #
>   # By convention, a blank line in a cell means "same as the preceding line".
>   #
> +# Note that the syntactic representation does not always match the sets and
> +# relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
> +# lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
> +# link, and W[acquire] are not included in the Acquire set.
> +#
>   # Disclaimer.  The table includes representations of "add" and "and" operations;
>   # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
>   # "andnot" operations are omitted.
> @@ -60,14 +65,13 @@
>       ------------------------------------------------------------------------------
>       |       RMW ops w/o return value |                                           |
>       ------------------------------------------------------------------------------
> -    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
> +    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
>       |                     atomic_and |                                           |
>       |                      spin_lock | LKR ->po LKW                              |
>       ------------------------------------------------------------------------------
>       |        RMW ops w/ return value |                                           |
>       ------------------------------------------------------------------------------
> -    |              atomic_add_return | F[mb] ->po R*[once]                       |
> -    |                                |     ->rmw W*[once] ->po F[mb]             |
> +    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
>       |               atomic_fetch_add |                                           |
>       |               atomic_fetch_and |                                           |
>       |                    atomic_xchg |                                           |
> @@ -79,13 +83,13 @@
>       |            atomic_xchg_relaxed |                                           |
>       |                   xchg_relaxed |                                           |
>       |    atomic_add_negative_relaxed |                                           |
> -    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
> +    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
>       |       atomic_fetch_add_acquire |                                           |
>       |       atomic_fetch_and_acquire |                                           |
>       |            atomic_xchg_acquire |                                           |
>       |                   xchg_acquire |                                           |
>       |    atomic_add_negative_acquire |                                           |
> -    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
> +    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
>       |       atomic_fetch_add_release |                                           |
>       |       atomic_fetch_and_release |                                           |
>       |            atomic_xchg_release |                                           |
> @@ -94,17 +98,16 @@
>       ------------------------------------------------------------------------------
>       |            Conditional RMW ops |                                           |
>       ------------------------------------------------------------------------------
> -    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
> -    |                                |                 ->rmw W*[once] ->po F[mb] |
> -    |                                | On failure: R*[once]                      |
> +    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
> +    |                                | On failure: R*[mb]                        |
>       |                        cmpxchg |                                           |
>       |              atomic_add_unless |                                           |
>       |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
>       |                                | On failure: R*[once]                      |
> -    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
> -    |                                | On failure: R*[once]                      |
> -    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
> -    |                                | On failure: R*[once]                      |
> +    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
> +    |                                | On failure: R*[acquire]                   |
> +    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
> +    |                                | On failure: R*[release]                   |
>       |                   spin_trylock | On success: LKR ->po LKW                  |
>       |                                | On failure: LF                            |
>       ------------------------------------------------------------------------------
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index dab38904206a..59bc15edeb8a 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -20,7 +20,7 @@ that litmus test to be exercised within the Linux kernel.
>   REQUIREMENTS
>   ============
>   
> -Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> +Version 7.58 or higher of the "herd7" and "klitmus7" tools must be
>   downloaded separately:
>   
>     https://github.com/herd/herdtools7
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 7c9ae48b9437..8ae47545df97 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -94,3 +94,6 @@ let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
>   let addr = carry-dep ; addr
>   let ctrl = carry-dep ; ctrl
>   let data = carry-dep ; data
> +
> +flag ~empty (if "lkmmv2" then 0 else _)
> +  as this-model-requires-variant-higher-than-lkmmv1
> diff --git a/tools/memory-model/linux-kernel.cfg b/tools/memory-model/linux-kernel.cfg
> index 3c8098e99f41..69b04f3aad73 100644
> --- a/tools/memory-model/linux-kernel.cfg
> +++ b/tools/memory-model/linux-kernel.cfg
> @@ -1,6 +1,7 @@
>   macros linux-kernel.def
>   bell linux-kernel.bell
>   model linux-kernel.cat
> +variant lkmmv2
>   graph columns
>   squished true
>   showevents noregs
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index a12b96c547b7..d7279a357cba 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
>   atomic_read_acquire(X) smp_load_acquire(X)
>   atomic_set_release(X,V) { smp_store_release(X,V); }
>   
> -atomic_add(V,X) { __atomic_op(X,+,V); }
> -atomic_sub(V,X) { __atomic_op(X,-,V); }
> -atomic_and(V,X) { __atomic_op(X,&,V); }
> -atomic_or(V,X)  { __atomic_op(X,|,V); }
> -atomic_xor(V,X) { __atomic_op(X,^,V); }
> -atomic_inc(X)   { __atomic_op(X,+,1); }
> -atomic_dec(X)   { __atomic_op(X,-,1); }
> -atomic_andnot(V,X) { __atomic_op(X,&~,V); }
> +atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
> +atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
> +atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
> +atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
> +atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
> +atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
> +atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
> +atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
>   
>   atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
>   atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
> @@ -144,3 +144,5 @@ atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
>   atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
>   atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
>   atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
> +
> +atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)


