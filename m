Return-Path: <linux-kernel+bounces-263326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0093D45B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EFF1C2465F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C117C222;
	Fri, 26 Jul 2024 13:40:03 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72317C214
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001202; cv=none; b=DjJvBEWRVGwZdqO8+v0meneWsVzoCwGT4Q0X2Z6RLb4q31Vx6gQ9DWRwi4/Army4ta+dFNF0EllGW742X5EHLuINTTopqQyMkCgh/lhTNQDf/FfOYstggpNaVmu6xrWDVYDgGPUdPZXJr+zPgQVmOQa8QPgsBNaR8OjYxHO9pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001202; c=relaxed/simple;
	bh=4XTRGwKwuQCsqUP4XNR63fe4p/KxBF9AQtsX4ouoWHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGlrztJLEofnilHiBWUwyx7ucneP8DPKqx+FxqnQWpKAZZl9PESLOySFcclrPRCctD2TN9nlBb9c+tC4iNqKWFU+Jjk7NQLj5K/kk9RTLhmghJB2Cn2wRHk3tc9U55RNwZSqP/1iSIR7hkMglSg6uj87h9sCfk0iWGJjln9KnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46QDdnMV038150;
	Fri, 26 Jul 2024 22:39:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Fri, 26 Jul 2024 22:39:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46QDdnWZ038145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 26 Jul 2024 22:39:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <59026394-b346-494c-91a3-5d3fd96bcd40@I-love.SAKURA.ne.jp>
Date: Fri, 26 Jul 2024 22:39:49 +0900
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
 <28a0f793-b0d6-4abb-b83c-f54e5a588994@I-love.SAKURA.ne.jp>
 <CAHk-=wg74E_1NXafYaemRT7R9dqU3DSOf+YGftD832BJqXBwoQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wg74E_1NXafYaemRT7R9dqU3DSOf+YGftD832BJqXBwoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/26 1:55, Linus Torvalds wrote:
> The code could do something like
> 
>         struct pt_regs *regs;
> 
>         /* Are we supposed to profile at all? */
>         if (!prof_buffer)
>                 return;
>         /* Are we profiling this CPU? */
>         if (cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
>                 return;

Then, a patch would look like:

 kernel/ksysfs.c  |  6 ++++++
 kernel/profile.c | 29 +++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 07fb5987b42b..7fc258774dee 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -92,7 +92,13 @@ static ssize_t profiling_store(struct kobject *kobj,
 				   const char *buf, size_t count)
 {
 	int ret;
+	static DEFINE_MUTEX(lock);
 
+	/*
+	 * We need serialization, for profile_setup() initializes prof_on
+	 * value and profile_init() allocates prof_buf for only once.
+	 */
+	guard(mutex)(&lock);
 	if (prof_on)
 		return -EEXIST;
 	/*
diff --git a/kernel/profile.c b/kernel/profile.c
index 2b775cc5c28f..70332a49e26e 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -119,6 +119,12 @@ int __ref profile_init(void)
 
 	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
 
+	/*
+	 * profile_tick() expects that prof_cpu_mask is allocated and
+	 * initialized before prof_buffer is allocated.
+	 */
+	wmb();
+
 	prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
 	if (prof_buffer)
 		return 0;
@@ -332,11 +338,26 @@ EXPORT_SYMBOL_GPL(profile_hits);
 
 void profile_tick(int type)
 {
-	struct pt_regs *regs = get_irq_regs();
+	struct pt_regs *regs;
 
-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
-	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
-		profile_hit(type, (void *)profile_pc(regs));
+	/* Are we supposed to profile at all? */
+	if (!prof_buffer)
+		return;
+	/*
+	 * cpumask_available(prof_cpu_mask) == true is guaranteed if prof_buffer != NULL,
+	 * for profile_init() allocates prof_cpu_mask before allocating prof_buffer, and
+	 * prof_buffer is never released if allocation of prof_buffer succeeded, and
+	 * prof_cpu_mask is released only when allocation of prof_buffer failed.
+	 */
+	rmb();
+	/* Are we profiling this CPU? */
+	if (!cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
+		return;
+	/* This is the old kernel-only legacy profiling */
+	regs = get_irq_regs();
+	if (user_mode(regs))
+		return;
+	profile_hit(type, (void *)profile_pc(regs));
 }
 
 #ifdef CONFIG_PROC_FS

But now, I'm inclined to remove prof_cpu_mask completely because
cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) is likely always
true due to

  a CPU cannot call profile_tick() if that CPU is offline

and

  cpumask_set_cpu(cpu, prof_cpu_mask) is called when that CPU becomes
  online and cpumask_clear_cpu(cpu, prof_cpu_mask) is called when
  that CPU becomes offline

. According to include/linux/cpuhotplug.h , CPUHP_PROFILE_PREPARE
belongs to PREPARE section. Therefore, if I understand correctly,
when profile_dead_cpu() is called due to a CPU getting offline or
memory allocation in profile_prepare_cpu() failed, that CPU can't be
inside profile_tick(). Then, cpumask_test_cpu() test inside
profile_tick() must be always true and can be removed. A patch that
can be folded into the patch shown above would look like:

 kernel/profile.c | 58 ++++--------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 70332a49e26e..837932f4ae4f 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -47,7 +47,6 @@ static unsigned short int prof_shift;
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
 
-static cpumask_var_t prof_cpu_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
@@ -114,17 +113,6 @@ int __ref profile_init(void)
 
 	buffer_bytes = prof_len*sizeof(atomic_t);
 
-	if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
-
-	/*
-	 * profile_tick() expects that prof_cpu_mask is allocated and
-	 * initialized before prof_buffer is allocated.
-	 */
-	wmb();
-
 	prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
 	if (prof_buffer)
 		return 0;
@@ -138,7 +126,6 @@ int __ref profile_init(void)
 	if (prof_buffer)
 		return 0;
 
-	free_cpumask_var(prof_cpu_mask);
 	return -ENOMEM;
 }
 
@@ -273,9 +260,6 @@ static int profile_dead_cpu(unsigned int cpu)
 	struct page *page;
 	int i;
 
-	if (cpumask_available(prof_cpu_mask))
-		cpumask_clear_cpu(cpu, prof_cpu_mask);
-
 	for (i = 0; i < 2; i++) {
 		if (per_cpu(cpu_profile_hits, cpu)[i]) {
 			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[i]);
@@ -308,14 +292,6 @@ static int profile_prepare_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int profile_online_cpu(unsigned int cpu)
-{
-	if (cpumask_available(prof_cpu_mask))
-		cpumask_set_cpu(cpu, prof_cpu_mask);
-
-	return 0;
-}
-
 #else /* !CONFIG_SMP */
 #define profile_flip_buffers()		do { } while (0)
 #define profile_discard_flip_buffers()	do { } while (0)
@@ -343,16 +319,6 @@ void profile_tick(int type)
 	/* Are we supposed to profile at all? */
 	if (!prof_buffer)
 		return;
-	/*
-	 * cpumask_available(prof_cpu_mask) == true is guaranteed if prof_buffer != NULL,
-	 * for profile_init() allocates prof_cpu_mask before allocating prof_buffer, and
-	 * prof_buffer is never released if allocation of prof_buffer succeeded, and
-	 * prof_cpu_mask is released only when allocation of prof_buffer failed.
-	 */
-	rmb();
-	/* Are we profiling this CPU? */
-	if (!cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
-		return;
 	/* This is the old kernel-only legacy profiling */
 	regs = get_irq_regs();
 	if (user_mode(regs))
@@ -439,10 +405,6 @@ static const struct proc_ops profile_proc_ops = {
 int __ref create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
-#ifdef CONFIG_SMP
-	enum cpuhp_state online_state;
-#endif
-
 	int err = 0;
 
 	if (!prof_on)
@@ -452,26 +414,14 @@ int __ref create_proc_profile(void)
 				profile_prepare_cpu, profile_dead_cpu);
 	if (err)
 		return err;
-
-	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "AP_PROFILE_ONLINE",
-				profile_online_cpu, NULL);
-	if (err < 0)
-		goto err_state_prep;
-	online_state = err;
-	err = 0;
 #endif
 	entry = proc_create("profile", S_IWUSR | S_IRUGO,
 			    NULL, &profile_proc_ops);
-	if (!entry)
-		goto err_state_onl;
-	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
-
-	return err;
-err_state_onl:
+	if (entry)
+		proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
 #ifdef CONFIG_SMP
-	cpuhp_remove_state(online_state);
-err_state_prep:
-	cpuhp_remove_state(CPUHP_PROFILE_PREPARE);
+	else
+		cpuhp_remove_state(CPUHP_PROFILE_PREPARE);
 #endif
 	return err;
 }

What do you think?

