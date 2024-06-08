Return-Path: <linux-kernel+bounces-207011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC829901148
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084521F21BEE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53B1779BB;
	Sat,  8 Jun 2024 10:54:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99526225AE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844048; cv=none; b=drsAG6I5DZwc4ekDZ4Qexy5ria7x8e99hlNXbX7I99SCH3x8HmiMmZFGaGNl+Hp3cUCu7ZcEKcloRqSBdVnHKCFprVBKSILndkmW1nl0uyZRDKqIhmZy0aslX9Q0Gh5f5JjfhW+QXD5tPLrAgFPaFTkD+Fda58BJGzU1OXxJn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844048; c=relaxed/simple;
	bh=44DTloEeKsBg4dBlBuyizCM9byVD9CJayt2Jk0ig1Lc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Xbnq+DFlK1ZeIqicJVmWz0KCQ/DrW0FH3AEINu4AR/qgUYcBdenfEMi2HBNx80dxwiJZbDn9GCdOi4dQKttwH3Dm81CiSsMEjTp74P878NcGKBfPt2AV5+xzfi3IYBoO4+ypoMQtfzmdPOoJ8s0onKblM5FChno2vbIw9ovgwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 458ArvJ4026841;
	Sat, 8 Jun 2024 19:53:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 08 Jun 2024 19:53:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 458Arvca026836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Jun 2024 19:53:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
Date: Sat, 8 Jun 2024 19:53:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting that the same local lock is held when trying to
hold mmap sem from both IRQ enabled context and IRQ context.

Since all callers use bpf_mmap_unlock_get_irq_work() before calling
mmap_read_trylock(), test in_hardirq() at bpf_mmap_unlock_get_irq_work()
in order to make sure that mmap_read_trylock() won't be called from IRQ
context.

  asm_exc_page_fault() => exc_page_fault() => handle_page_fault()
  => do_user_addr_fault() => handle_mm_fault() => __handle_mm_fault()
  => handle_pte_fault() => do_pte_missing() => do_anonymous_page()
  => vmf_anon_prepare() => mmap_read_trylock()
  => __mmap_lock_trace_start_locking()
  => __mmap_lock_do_trace_start_locking() => local_lock_acquire()
  => lock_acquire()

  sysvec_irq_work() => instr_sysvec_irq_work() => __sysvec_irq_work()
  => irq_work_run() => irq_work_run_list() => irq_work_single()
  => do_bpf_send_signal() => group_send_sig_info() => rcu_read_unlock()
  => rcu_lock_release() => lock_release() => trace_lock_release()
  => perf_trace_lock() => perf_trace_run_bpf_submit() => trace_call_bpf()
  => bpf_prog_run_array() => bpf_prog_run() => __bpf_prog_run()
  => bpf_dispatcher_nop_func() => bpf_prog_e6cf5f9c69743609()
  => __bpf_get_stack() => stack_map_get_build_id_offset()
  => mmap_read_trylock() => __mmap_lock_trace_acquire_returned()
  => __mmap_lock_do_trace_acquire_returned() => local_lock_acquire()
  => lock_acquire()

WARNING: inconsistent lock state
6.10.0-rc2-syzkaller-00222-gd30d0e49da71 #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor.2/10910 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff8880b9538828 (lock#10){?.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538828 (lock#10){?.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#10);
  <Interrupt>
    lock(lock#10);

 *** DEADLOCK ***

Reported-by: syzbot <syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=a225ee3df7e7f9372dbe
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Example is https://syzkaller.appspot.com/text?tag=CrashReport&x=1649a2e2980000 .
But not using this example, for this link will disappear eventually.

 kernel/bpf/mmap_unlock_work.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef..337eb314d918 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -26,7 +26,13 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = false;
 
-	if (irqs_disabled()) {
+	if (in_hardirq()) {
+		/*
+		 * IRQ context does not allow to trylock mmap sem.
+		 * Force the fallback code.
+		 */
+		irq_work_busy = true;
+	} else if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&mmap_unlock_work);
 			if (irq_work_is_busy(&work->irq_work)) {
-- 
2.34.1

