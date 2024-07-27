Return-Path: <linux-kernel+bounces-264070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA72793DEB6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EFA1F21ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FFB487BF;
	Sat, 27 Jul 2024 10:24:38 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312BA4411
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075878; cv=none; b=HPjMhtYkUg6o+8Xk5vY3G6SGL7zpRnWMT+Zyu0i5g31QWNNrtahFC0nmkYtwJvyjH+oID1NC26ypBap7bDaq/54BosKOCvDiMlGdP6B/Tr7aUJf030bOKajoo5E4PVwDzUQ9lyKjtDEhmGBMZxb0YufPvRFo/YWZJr4pcFjJjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075878; c=relaxed/simple;
	bh=5XXVRvDPL7/NMa6MEEFoIrE1ffn6RKWpcsALTpJGuhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JEK8vUorGrsUlAGOtZKk4JosL1OijgRY5kDukbLR0tm3GOhyuWKAEwVZ2U0DGgEhJGLDjn0uWU/hQvJTnFQrGR5I6Vo4kzuGqPw9Nk3QvT5eu+MNOfpuHdHaN7IcXH5kskLeuVyTE2WwclZcu2RkbkQATiCMspV8pHBpDVK72j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46RAORB1077888;
	Sat, 27 Jul 2024 19:24:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sat, 27 Jul 2024 19:24:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46RAOQmY077884
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jul 2024 19:24:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7490ae81-f90c-4d24-9d84-120dc7c30046@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jul 2024 19:24:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
To: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000d6b55e060d6bc390@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d6b55e060d6bc390@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

[PATCH] profiling: remove prof_cpu_mask

syzbot is reporting uninit-value at profile_hits(), for there is a race
window between

  if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
    return -ENOMEM;
  cpumask_copy(prof_cpu_mask, cpu_possible_mask);

in profile_init() and

  cpumask_available(prof_cpu_mask) &&
  cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))

in profile_tick(); prof_cpu_mask remains uninitialzed until cpumask_copy()
completes while cpumask_available(prof_cpu_mask) returns true as soon as
alloc_cpumask_var(&prof_cpu_mask) completes.

We could replace alloc_cpumask_var() with zalloc_cpumask_var() and
call cpumask_copy() from create_proc_profile() on only UP kernels, for
profile_online_cpu() calls cpumask_set_cpu() as needed via
cpuhp_setup_state(CPUHP_AP_ONLINE_DYN) on SMP kernels. But this patch
removes prof_cpu_mask because it seems unnecessary.

The cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) test
in profile_tick() is likely always true due to

  a CPU cannot call profile_tick() if that CPU is offline

and

  cpumask_set_cpu(cpu, prof_cpu_mask) is called when that CPU becomes
  online and cpumask_clear_cpu(cpu, prof_cpu_mask) is called when that
  CPU becomes offline

. This test could be false during transition between online and offline.

But according to include/linux/cpuhotplug.h , CPUHP_PROFILE_PREPARE
belongs to PREPARE section, which means that the CPU subjected to
profile_dead_cpu() cannot be inside profile_tick() (i.e. no risk of
use-after-free bug) because interrupt for that CPU is disabled during
PREPARE section. Therefore, this test is guaranteed to be true, and
can be removed. (Since profile_hits() checks prof_buffer != NULL, we
don't need to check prof_buffer != NULL here unless get_irq_regs() or
user_mode() is such slow that we want to avoid when prof_buffer == NULL).

do_profile_hits() is called from profile_tick() from timer interrupt
only if cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) is true and
prof_buffer is not NULL. But syzbot is also reporting that sometimes
do_profile_hits() is called while current thread is still doing vzalloc(),
where prof_buffer must be NULL at this moment. This indicates that multiple
threads concurrently tried to write to /sys/kernel/profiling interface,
which caused that somebody else try to re-allocate prof_buffer despite
somebody has already allocated prof_buffer. Fix this by using
serialization.

Reported-by: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/ksysfs.c  |  7 +++++++
 kernel/profile.c | 46 ++++++----------------------------------------
 2 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 07fb5987b42b..1bab21b4718f 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -92,7 +92,14 @@ static ssize_t profiling_store(struct kobject *kobj,
 				   const char *buf, size_t count)
 {
 	int ret;
+	static DEFINE_MUTEX(lock);
 
+	/*
+	 * We need serialization, for profile_setup() initializes prof_on
+	 * value and profile_init() must not reallocate prof_buffer after
+	 * once allocated.
+	 */
+	guard(mutex)(&lock);
 	if (prof_on)
 		return -EEXIST;
 	/*
diff --git a/kernel/profile.c b/kernel/profile.c
index 2b775cc5c28f..4654c6cd984e 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -47,7 +47,6 @@ static unsigned short int prof_shift;
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
 
-static cpumask_var_t prof_cpu_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
@@ -114,11 +113,6 @@ int __ref profile_init(void)
 
 	buffer_bytes = prof_len*sizeof(atomic_t);
 
-	if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
-
 	prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
 	if (prof_buffer)
 		return 0;
@@ -132,7 +126,6 @@ int __ref profile_init(void)
 	if (prof_buffer)
 		return 0;
 
-	free_cpumask_var(prof_cpu_mask);
 	return -ENOMEM;
 }
 
@@ -267,9 +260,6 @@ static int profile_dead_cpu(unsigned int cpu)
 	struct page *page;
 	int i;
 
-	if (cpumask_available(prof_cpu_mask))
-		cpumask_clear_cpu(cpu, prof_cpu_mask);
-
 	for (i = 0; i < 2; i++) {
 		if (per_cpu(cpu_profile_hits, cpu)[i]) {
 			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[i]);
@@ -302,14 +292,6 @@ static int profile_prepare_cpu(unsigned int cpu)
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
@@ -334,8 +316,8 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
-	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
+	/* This is the old kernel-only legacy profiling */
+	if (!user_mode(regs))
 		profile_hit(type, (void *)profile_pc(regs));
 }
 
@@ -418,10 +400,6 @@ static const struct proc_ops profile_proc_ops = {
 int __ref create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
-#ifdef CONFIG_SMP
-	enum cpuhp_state online_state;
-#endif
-
 	int err = 0;
 
 	if (!prof_on)
@@ -431,26 +409,14 @@ int __ref create_proc_profile(void)
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
-- 
2.43.5


