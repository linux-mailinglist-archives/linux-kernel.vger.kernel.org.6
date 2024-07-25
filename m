Return-Path: <linux-kernel+bounces-261752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527B93BBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F8D1F22326
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8EA1865B;
	Thu, 25 Jul 2024 04:24:26 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747011B7FD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881466; cv=none; b=dUm0zD+2+Nw4gSkr6My5TondNZioYHgBXxxOx4/KifxjO+vlaXSfhKAGyNT63pyU4RimelbORrCGtOMBU5W/bcve/M/CasseHCxoKdunQBB+Ks+W+FfL+ytnTA83PGzozOwIIPn/K7SNFS9p+B2trLaeQcfLyG4EfEo86oqEu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881466; c=relaxed/simple;
	bh=/MOHHmhHAYmKQ41MEenDctDm/d1IDl/vkf0I316SJ90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWtdTZsMh5vOXFedPv7zNKQauHCsv2MU8NZb5rSVharQLKEQzUgBH9m85jpPIzH1BY2kxiJAcb/7hbNa12IVXk+uPooFtjegcuIVRA4wXS2kLzfWfCp1aX3vLe0BydyT7bNM37S0x0PdlZ3XEfhsawyq0pG4msNbhqRez5r0jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46P4OJ2C059232;
	Thu, 25 Jul 2024 13:24:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Thu, 25 Jul 2024 13:24:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46P4OJE5059229
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jul 2024 13:24:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5ad7dffa-204e-4d37-acf6-0206d7a87f37@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jul 2024 13:24:18 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/25 4:34, Linus Torvalds wrote:
> But honestly, the minimal fix would seem to be this two-liner:
> 
>   --- a/kernel/ksysfs.c
>   +++ b/kernel/ksysfs.c
>   @@ -92,7 +92,9 @@ static ssize_t profiling_store(struct kobject *kobj,
>                                    const char *buf, size_t count)
>    {
>         int ret;
>   +     static DEFINE_MUTEX(prof_store_mutex);
> 
>   +     guard(mutex)(&prof_store_mutex);
>         if (prof_on)
>                 return -EEXIST;
>         /*
> 
> which I have admittedly not tested at all, but seems trivial.

If guard() is already backported to older kernels, that would work for
the kernel/ksysfs.c part. But I prefer killable version, for a large
memory allocation which may cause current thread waiting on this lock
might be chosen as an OOM victim is performed from profile_init().
I wish if we had a macro that only does unlock upon function exit.
Then, we can use explicit killable lock and automatic unlock (which is
something like golang's "defer" statement).



> And once that "no more multiple concurrent profile initialization" bug
> is fixed, everything else is fine. The assignment to "prof_buffer"
> will now be the last thing that is done, and when it's done the
> profiling should all be good.

Unfortunately, there is a race where KMSAN would complain even if
profile initialization is serialized.



profile_init() {
  (...snipped...)
                                     profile_tick(int type) {
                                       struct pt_regs *regs = get_irq_regs();
  if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
    return -ENOMEM;
                                       if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
					 // cpumask_available(prof_cpu_mask) returns true after
					 // alloc_cpumask_var(&prof_cpu_mask) completes, but
					 cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
                                         // KMSAN complains about uninit-value here, for
					   profile_hit(type, (void *)profile_pc(regs));
                                     }
					 // due to use of GFP_KERNEL, prof_cpu_mask remains
					 // uninitialzed until cpumask_copy() completes.
  cpumask_copy(prof_cpu_mask, cpu_possible_mask);
  prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
  (...snipped...)
}



Edward Adam Davis and I did s/alloc_cpumask_var/zalloc_cpumask_var/ .
But I also removed cpumask_copy() unless CONFIG_SMP=n, for
cpuhp_setup_state(CPUHP_AP_ONLINE_DYN) in create_proc_profile() calls
cpumask_set_cpu() as needed. That is, currently cpumask_copy() is called
needlessly and inappropriately.


