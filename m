Return-Path: <linux-kernel+bounces-305944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9509636B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B79A1C2137B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817F8836;
	Thu, 29 Aug 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UCsrNzPG";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="b8PrrVY5"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3BC79E5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890590; cv=none; b=anPiToj3QSJSzGKyfUK2M1rvxI/JaK2YdmB/wIWyZSiFMPcz+VQFGnG1o5cqiJsW2D9ups/vOkTkYl5yGw+iiVIrLXA3kcV1uPOPlMwbg1W2SE+tKRWZ/EhfPYOwuVmb9ylGQQmvf+OwUz2Epjef54EeEDY8YzWqXZFukxQYm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890590; c=relaxed/simple;
	bh=OUzrB4wdzsb7e8T4hQM+txmGQuVL1jZKM0y4/kLLZ9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DvwZU1J30xd/2jnFkyzNtyBJ1uds5MdFXwbOf36h6MDUNmoVrdQCVC+Cf3QLPweTAL7gs/fu53bQoN2jxOi6/YWNIpldKv+OFn3IY7ponH2Du4m/TJw3fzB/UL7KUOyLQ+cx61or6SllqDCkfBR/MD0H9vdF5SSX4PAtqhOr7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UCsrNzPG; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=b8PrrVY5; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724890588; x=1756426588;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=OUzrB4wdzsb7e8T4hQM+txmGQuVL1jZKM0y4/kLLZ9k=;
  b=UCsrNzPGS4fL1Sei506ODneeUfuDu064sFhUV+crJXsaSKNCy1zuMJJD
   uNy575tl2GuqnmprQ6RPCser77JJZsK2t+djJnOnn+dVMNjvFYoj3Oixo
   hV9pHY+WrN0eU+f8kNpENPeZbkno0SU2I2/Dgqe0vHra/UvSMOPhQC9c+
   qrCXusb5BVkCDA0QuhPqkC4U0YUeHhQK1IuX6fDmAFahlYilN6cUopmkq
   xs/VOgd33AP8m6HgAnqoXckFh7B6Erye9plDmXHichsTkIcNnt1fBZimx
   i+pBszLrwBo1fOLxxqBXD4F6JpaURMvMLBtyJcV5B00lfHEQ889KXpYwR
   w==;
X-CSE-ConnectionGUID: WhN9x5JuQ2KsumUT3INfpg==
X-CSE-MsgGUID: AfA6T1gtRhSj44VdruHp0g==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 17:16:28 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5101012eso409135ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724890587; x=1725495387; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvuhh9jzoKfqpD725Y+YjYj8SSy2gfOGPebe33fdpzc=;
        b=b8PrrVY5aLdobvzw/xH8suqzu+qQANhsOf3dulhiZYF7z2RTpTVkNu9fPqMSrH/eEr
         VYY4aD4DjK/KhV6zBfw5kq1utoVCzfM8KLLDRTpOv7SWtWTjCwQvm8ysPLA0Yd2HWPpk
         hU0m87oIuM1Zjd7rM8CCx84DhlLm3AQGpTREA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724890587; x=1725495387;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvuhh9jzoKfqpD725Y+YjYj8SSy2gfOGPebe33fdpzc=;
        b=JX6wlAk2ANAMC6O98e+y/ydgcktLglf9S8NEMs0kwqSoOxhVJ2+TlamUthwfBwAQgf
         6XEicDugyzmx04i183dlkeokUrrEzlrp4sYloNrS32uINkGvVSK2wN+HBzgerTu133ZG
         c1kFgd3S4FeMYuZWR8JafvZgA97iTgeM9A8nnYBjqVmVm/IO7I7c72ZI7rKkc86BrbuC
         lPJVfLXkbp/UyoZxT/E/2rCIeMx0rYjstMQWJrYORDz7Bd2SpQyA+SV3J3ow94JTC1GF
         ppbfgvDKTHbGb+S5vyDtM+eNDuUCPWsaKA5XY411sgdUv7/I7TX5WMxfoO2VocnXegY4
         2E6w==
X-Forwarded-Encrypted: i=1; AJvYcCUDmNDPzJykMcHXmbkVt6ja3Md4aV7+gqpffBlbUrjLQjVnUeL0YWdPdKQyeE7d5IstDf3w7LFhltpYZKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdhs5wNttpcf5x7ojC/AUmngConQdYrmaEUyjEq5MumczcJCCm
	99PjQRrCBH0tDcbm62EQKQ8go0KeDO5iolC9d+kun3A0RdEiB/8f7XQfBHlH3hYXqndQBPhpp0b
	naEz2bWcQjFp2UrE+cEePl8tHIq8WS6ffi8lYB46BreqfsSRBL1VST7PkB9gtBVV1fTlUcF+TLe
	VRe/+oqtIBo1bjYCI17eVgB2+heYQDC/AGyJLCiA==
X-Received: by 2002:a05:6e02:194a:b0:396:f026:b0ac with SMTP id e9e14a558f8ab-39f3781de65mr19253695ab.14.1724890587071;
        Wed, 28 Aug 2024 17:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJEd9eOH0ExnTd5XtJScaqYMQv1oYyFp5bfGJf8/LQ38acuF6+XcCR5GI+HyFbFB5H3U+trJOxuJCOPvX/ziU=
X-Received: by 2002:a05:6e02:194a:b0:396:f026:b0ac with SMTP id
 e9e14a558f8ab-39f3781de65mr19253445ab.14.1724890586720; Wed, 28 Aug 2024
 17:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 17:16:16 -0700
Message-ID: <CALAgD-5cKJnWRsS_2rjL1P9pC0dbNX66b8x09p=DUx1kD+p6PQ@mail.gmail.com>
Subject: BUG: INFO: trying to register non-static key in call_timer_fn
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list  bug.
The reproducer is
https://gist.github.com/freexxxyyy/4c465c7d81957779d8bdea44f6cb8977

The bug report is:

Syzkaller hit 'INFO: trying to register non-static key in call_timer_fn' bug.

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 assign_lock_key+0x22f/0x260 kernel/locking/lockdep.c:976
 register_lock_class+0x285/0x9a0 kernel/locking/lockdep.c:1289
 __lock_acquire+0x186/0x8050 kernel/locking/lockdep.c:5014
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x6d3/0xce0
 queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
 call_timer_fn+0xff/0x240 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x734/0x9a0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb3/0x160 kernel/time/timer.c:2447
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: 9a67d687bb84bf00 RBX: ffffffff816928eb RCX: 0000000000028339
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
list_add corruption. prev is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__list_add_valid_or_report+0xa8/0xe0 lib/list_debug.c:25
Code: 41 5d 41 5e 41 5f c3 48 c7 c7 00 5a a9 8b 4c 89 fe 4c 89 e2 4c
89 f1 e8 e6 00 97 06 0f 0b 48 c7 c7 00 58 a9 8b e8 d8 00 97 06 <0f> 0b
48 c7 c7 a0 58 a9 8b e8 ca 00 97 06 0f 0b 48 c7 c7 00 59 a9
RSP: 0018:ffffc900000079c0 EFLAGS: 00010046
RAX: 0000000000000022 RBX: 0000000000000000 RCX: 9a67d687bb84bf00
RDX: 0000000080000102 RSI: 0000000080000102 RDI: 0000000000000000
RBP: 1ffff11002b6b60d R08: ffffffff8172e30c R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffff8880253b64c8
R13: ffff8880253b64c0 R14: ffff888015b5b068 R15: ffff888015b5b060
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558a4a77a8 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 insert_work+0x114/0x320 kernel/workqueue.c:2212
 __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
 queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
 call_timer_fn+0xff/0x240 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x734/0x9a0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb3/0x160 kernel/time/timer.c:2447
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: 9a67d687bb84bf00 RBX: ffffffff816928eb RCX: 0000000000028339
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xa8/0xe0 lib/list_debug.c:25
Code: 41 5d 41 5e 41 5f c3 48 c7 c7 00 5a a9 8b 4c 89 fe 4c 89 e2 4c
89 f1 e8 e6 00 97 06 0f 0b 48 c7 c7 00 58 a9 8b e8 d8 00 97 06 <0f> 0b
48 c7 c7 a0 58 a9 8b e8 ca 00 97 06 0f 0b 48 c7 c7 00 59 a9
RSP: 0018:ffffc900000079c0 EFLAGS: 00010046
RAX: 0000000000000022 RBX: 0000000000000000 RCX: 9a67d687bb84bf00
RDX: 0000000080000102 RSI: 0000000080000102 RDI: 0000000000000000
RBP: 1ffff11002b6b60d R08: ffffffff8172e30c R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffff8880253b64c8
R13: ffff8880253b64c0 R14: ffff888015b5b068 R15: ffff888015b5b060
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558a4a77a8 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 76 e7                 jbe    0xffffffe9
   2: 48 89 07             mov    %rax,(%rdi)
   5: 49 c7 c0 08 00 00 00 mov    $0x8,%r8
   c: 4d 29 c8             sub    %r9,%r8
   f: 4c 01 c7             add    %r8,%rdi
  12: 4c 29 c2             sub    %r8,%rdx
  15: e9 72 ff ff ff       jmp    0xffffff8c
  1a: cc                   int3
  1b: cc                   int3
  1c: cc                   int3
  1d: cc                   int3
  1e: 66 90                 xchg   %ax,%ax
  20: 0f 00 2d c7 a4 4e 00 verw   0x4ea4c7(%rip)        # 0x4ea4ee
  27: fb                   sti
  28: f4                   hlt
* 29: fa                   cli <-- trapping instruction
  2a: c3                   ret
  2b: 0f 1f 00             nopl   (%rax)
  2e: e9 eb ff ff ff       jmp    0x1e
  33: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
  3a: 00 00 00
  3d: 90                   nop
  3e: 65                   gs


-- 
Yours sincerely,
Xingyu

