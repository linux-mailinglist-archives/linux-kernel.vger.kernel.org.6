Return-Path: <linux-kernel+bounces-335969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73797ED49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD721F22057
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7F19CC27;
	Mon, 23 Sep 2024 14:43:19 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4B77107
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102599; cv=none; b=tZ5n5gdpFkzWwh4dwNDff5rsCwVrasNg8GyDWycWqP8Vr1LX8fcc8ey0d6Vu9Yamqdfvq9iaD0rKr8d9o6Umcorx4ycPDOTpi3p92U7drtAmGzQOW9dATRDQDSyMZcV/x0DI7SmMvCjYYj79mq8qRoPgjxOsAABalE7L8jLQ1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102599; c=relaxed/simple;
	bh=2r+9Ph0h8QyGaWpmiLnx39JEHmMrZZCMp/7HlW94K1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=L7//tWUAb0ZAVLDVUbCPPHgKVOtgIzwr63Hw/WPQj+a07uAZcjSzm9Tw1q+UX3dr6Wl5uhKXb68xD91pLJMR46+5p8zuCvV0GH9OEy6385txqXTZwTZ3vTgugld0CMyCBMe3rxMCeepcDyQl+Q7VPcsOuVwrcZoQSwLwwbSGhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48NE4PvW030278;
	Mon, 23 Sep 2024 23:04:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 23 Sep 2024 23:04:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48NE4PR0030275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Sep 2024 23:04:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <70b5789b-7d77-4389-b2de-6c4219f28d32@I-love.SAKURA.ne.jp>
Date: Mon, 23 Sep 2024 23:04:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] upstream test error: BUG: stack guard page was hit in
 corrupted
To: syzbot <syzbot+d5db198a0f40411f24c3@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
References: <66eb52dc.050a0220.92ef1.0006.GAE@google.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <66eb52dc.050a0220.92ef1.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This bug suggests code added by commit 6cd0dd934b03 ("kcov: Add interrupt handling self test").

The location that triggers page fault looks like

  pos = READ_ONCE(area[0]) + 1;

in __sanitizer_cov_trace_pc().
When is t->kcov_area initialized with appropriate buffer
after selftest() does current->kcov_mode = KCOV_MODE_TRACE_PC ?

At commit de5cb0dcb74c ("Merge branch 'address-masking'"):
$ ./scripts/faddr2line vmlinux-de5cb0dc asm_exc_page_fault+0x26/0x30 sched_clock+0xb/0x60 __sanitizer_cov_trace_pc+0x53/0x70 sched_clock+0xb/0x60 lock_pin_lock+0x1a9/0x2d0 preempt_schedule_irq+0x51/0x90 __schedule+0x2f2/0x5920 lockdep_hardirqs_on+0x7c/0x110 preempt_schedule_thunk+0x1a/0x30 preempt_schedule_common+0x44/0xc0 preempt_schedule_thunk+0x1a/0x30 __pfx___schedule+0x10/0x10 vprintk_emit+0x39e/0x6f0 __pfx_vprintk_emit+0x10/0x10 __debugfs_create_file+0x40e/0x660 __pfx_lock_release+0x10/0x10 preempt_schedule_irq+0x51/0x90 irqentry_exit+0x36/0x90 asm_sysvec_apic_timer_interrupt+0x1a/0x20 __wake_up_klogd.part.0+0x99/0xf0 vprintk+0x86/0xa0 kcov_init+0xcc/0x120 kcov_init+0xb3/0x120
asm_exc_page_fault+0x26/0x30:
asm_exc_page_fault at arch/x86/include/asm/idtentry.h:623

sched_clock+0xb/0x60:
__preempt_count_add at arch/x86/include/asm/preempt.h:79
(inlined by) sched_clock at arch/x86/kernel/tsc.c:283

__sanitizer_cov_trace_pc+0x53/0x70:
__sanitizer_cov_trace_pc at kernel/kcov.c:222

sched_clock+0xb/0x60:
__preempt_count_add at arch/x86/include/asm/preempt.h:79
(inlined by) sched_clock at arch/x86/kernel/tsc.c:283

lock_pin_lock+0x1a9/0x2d0:
__lock_pin_lock at kernel/locking/lockdep.c:5593
(inlined by) lock_pin_lock at kernel/locking/lockdep.c:5915

preempt_schedule_irq+0x51/0x90:
native_save_fl at arch/x86/include/asm/irqflags.h:26
(inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:87
(inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
(inlined by) preempt_schedule_irq at kernel/sched/core.c:6997

__schedule+0x2f2/0x5920:
__schedule at kernel/sched/core.c:6579

lockdep_hardirqs_on+0x7c/0x110:
lockdep_hardirqs_on at kernel/locking/lockdep.c:4465

preempt_schedule_thunk+0x1a/0x30:
preempt_schedule_thunk at arch/x86/entry/thunk.S:12

preempt_schedule_common+0x44/0xc0:
__preempt_count_sub at arch/x86/include/asm/preempt.h:84
(inlined by) preempt_schedule_common at kernel/sched/core.c:6855

preempt_schedule_thunk+0x1a/0x30:
preempt_schedule_thunk at arch/x86/entry/thunk.S:12

__pfx___schedule+0x10/0x10:
__schedule at kernel/sched/core.c:6533

vprintk_emit+0x39e/0x6f0:
vprintk_emit at kernel/printk/printk.c:2356

__pfx_vprintk_emit+0x10/0x10:
vprintk_emit at kernel/printk/printk.c:2356

__debugfs_create_file+0x40e/0x660:
end_creating at fs/debugfs/inode.c:409
(inlined by) __debugfs_create_file at fs/debugfs/inode.c:450

__pfx_lock_release+0x10/0x10:
lock_release at kernel/locking/lockdep.c:5830

preempt_schedule_irq+0x51/0x90:
native_save_fl at arch/x86/include/asm/irqflags.h:26
(inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:87
(inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
(inlined by) preempt_schedule_irq at kernel/sched/core.c:6997

irqentry_exit+0x36/0x90:
irqentry_exit at kernel/entry/common.c:357

asm_sysvec_apic_timer_interrupt+0x1a/0x20:
asm_sysvec_apic_timer_interrupt at arch/x86/include/asm/idtentry.h:702

__wake_up_klogd.part.0+0x99/0xf0:
__wake_up_klogd at kernel/printk/printk.c:4495

vprintk+0x86/0xa0:
vprintk at kernel/printk/printk_safe.c:69

kcov_init+0xcc/0x120:
selftest at kernel/kcov.c:1090
(inlined by) kcov_init at kernel/kcov.c:1117

kcov_init+0xb3/0x120:
selftest at kernel/kcov.c:1088
(inlined by) kcov_init at kernel/kcov.c:1117

On 2024/09/19 7:23, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=153e7fc7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c78e7c8f41d443e6
> dashboard link: https://syzkaller.appspot.com/bug?extid=d5db198a0f40411f24c3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

