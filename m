Return-Path: <linux-kernel+bounces-262083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9593C090
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58684B20BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFE1991C2;
	Thu, 25 Jul 2024 11:07:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F48196DB1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905628; cv=none; b=otEFcIItAHgDjTXA0fRp8p44EvQ0qf9291/RSxczkS184HBfA7ioC+8oLv/jgG2op6fKPuiUlwvBbceD3DutwCTt8sNH+p5p4ZwYKIgoxOHcjKUuNST3MJzWtBBzd58c9KXa7CFK71+ET/ClO/r14rRYO3SJ54AeUx4dQmd3NlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905628; c=relaxed/simple;
	bh=U7pxbW2h20/9fkw1j/mWBTICRqPVomUeLj2belKEmDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbDnJTy9ahCfRxjz2wdh380E/2kY8mFKWj4w7/o1mmJVXFvpoDDbScH5YzX1wD7lBP32Kt3/jFxAICgffVMVTa7yWZQ7rSr9qU+pu28oRPnuzFi6Kvx4tZG6kjJ8D6SayCHL01K/VrOYQGYnoYlThedfDWnIr3LvysZLAx8uivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46PB6uQp032304;
	Thu, 25 Jul 2024 20:06:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Thu, 25 Jul 2024 20:06:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46PB6t93032300
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jul 2024 20:06:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <28a0f793-b0d6-4abb-b83c-f54e5a588994@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jul 2024 20:06:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] orphaned patches for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
 <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com>
 <5ad7dffa-204e-4d37-acf6-0206d7a87f37@I-love.SAKURA.ne.jp>
 <CAHk-=wjYB_aeCxtBW2+-GqcF2PxwJ5061BFrAMp3mJgBy3GGvQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjYB_aeCxtBW2+-GqcF2PxwJ5061BFrAMp3mJgBy3GGvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/25 14:11, Linus Torvalds wrote:
> So no. This is not happening, and you just showed exactly why nobody
> wants to take your patch set. Because you make things more complicated
> than they need to be for no reason.

I'm sending you as a patch set. But that is a result of nobody taking care
on individual patch (even fine-and-simple the other patch). People fixing
unpopular bugs are having difficulty with finding maintainers or getting
responses from maintainers (regardless of whether individual patch is
complicated). For example,
https://lkml.kernel.org/r/20230423012744.24320-1-chenzhongjin@huawei.com was
a result of several comments but still not accepted. I appreciate if you can
help such people with persuading appropriate maintainers to review/accept.

> And yes, apparently we should just also move the 'prof_buffer' test
> earlier, and do it in profile_tick() too, so that we don't need to
> even worry about the cpumask_available thing.

Do you mean

 void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();

-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
+	if (!user_mode(regs) && prof_buffer &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

because prof_cpu_mask != NULL is guaranteed if prof_buffer != NULL
because prof_cpu_mask is assigned before prof_buffer is assigned and
prof_buffer is never reassigned? That resembles
https://lkml.kernel.org/r/20230410022226.181812-3-chenzhongjin@huawei.com
but Chen Zhongjin did not remove the cpumask_available() test.

Can that change survive memory fetch reordering like

	if (!user_mode(regs) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) &&
	    prof_buffer)
 		profile_hit(type, (void *)profile_pc(regs));

if cpumask_available() test is removed? We after all cannot forget about
the cpumask_available thing?

If we can forget about the cpumask_available thing, can we tolerate discarding
CONFIG_CPUMASK_OFFSTACK=n optimization because we can't remove duplicated
prof_buffer != NULL test in profile_hits() because do_profile_hits() assumes
that prof_buffer != NULL?

Conditions/preferences are too much complicated...


