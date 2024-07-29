Return-Path: <linux-kernel+bounces-266169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117093FBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B160A1F22496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B315F3EA;
	Mon, 29 Jul 2024 16:56:00 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2A15EFC0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272159; cv=none; b=IS2b/LG9naxbvx+zRyTY1Bk3E6PDOJevmG9nbsYqQk+JqoQ0JUMvJY9u0I6vTiKn1xkOLLiKsaYHFQYr+omq5mSkFOCkqQowu3KslM7oZmnDmK2DMhFnIFConfLJWMsYJ3tI5dlI/Jw1xHSiazSze4uJP9/Cs2KcxcY+ZOhXUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272159; c=relaxed/simple;
	bh=GBcQxEcm76aRw5bm5m7TK9aRH3OcNZY833zuwx7b+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srT7iqhhytrzcgnsgm7VVdSret5u9Gn0renuuV+uWFAdqwKMo43OXvUR5KVUv92MrcusoMBQI9WSY4kAxiiCwNhGTrXbFFpWhTEEseSP6XLCkAlQaFkqAHMf7AVe9+vd9NpkOux4UxSog/aixq07mbFIkuN2N2irShImIwnxJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso5572015a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272156; x=1722876956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pInQiHS1SIzp/gP7f63T6ThFWloDP+HBPBas+N8DhlI=;
        b=rBtFIMLWHEqUQO3bKUDBWhJWjPhaCp88v4XUdLsGESUc8N/o/2ZCkXHGJBVTsk5bKl
         bprvHMtlqS2k4vDs+Xlb2CVBSGaQXKzgpdNgshZzCC+rN3ldmyWwZUtngVpVmWwME1s8
         D71V1/bUzzsauUUmO53MlVt4Xr5RyJzu9+9KDSgPB5Kmm1MTO+S/hGR/Js4PiaUh+WEN
         Bx8Yn8KTKL7PruSd18wpSMB+/pfhWG6adl9Z5OePrEA9yzuUADbH36jPs+eQxAWaIeVX
         aHX7RbaPHRQ3jX6KnIGkO7ExROP1qxgSDbc5WtgcQ6vz0cjwysKp4wAFUGkpk2K0VTqE
         tROQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBYAEYSQeUYbOM2xjh47dIZiWA3HnSbINRc8DwMwOZPViVmLRFVjxKGpQDMc536ooDoKdt8AEhLzjA/jz+edGBDcg/a77toZm8GHN1
X-Gm-Message-State: AOJu0YzuFErNjrBpNkPxUmWFzcNGlRoAr6srijbSLLn2EjDmbYwGw0I9
	MYNXH/3/QYCodi0gHySkxMQ7QZeygxfCYPnBIZmSYVa1aM9fhbqf
X-Google-Smtp-Source: AGHT+IF9nMyWswyCHwij8Zvuwt8VRzAnVK4GY2dn8OzlZ3itNwyWmyv8AqHsXb/XQ+UlJW8H6JM8lw==
X-Received: by 2002:a05:6402:3546:b0:5a2:2b56:e08e with SMTP id 4fb4d7f45d1cf-5b020cbe0a3mr6143374a12.18.1722272156078;
        Mon, 29 Jul 2024 09:55:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3cb8sm5929111a12.77.2024.07.29.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:55:55 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:55:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Wei Liu <wei.liu@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Adrian Huang <ahuang12@lenovo.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Add retry mechanism to add_pin_to_irq_node()
Message-ID: <ZqfJmUF8sXIyuSHN@gmail.com>
References: <20240729140604.2814597-1-leitao@debian.org>
 <874j8889ch.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j8889ch.ffs@tglx>

Hello Thomas,

On Mon, Jul 29, 2024 at 06:13:34PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 29 2024 at 07:06, Breno Leitao wrote:
> > I've been running some experiments with failslab fault injector running
> > to detect a different problem, and the machine always crash with the
> > following stack:
> >
> > 	can not alloc irq_pin_list (-1,0,20)
> > 	Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed
> >
> > 	Call Trace:
> > 	 panic
> > 	   _printk
> > 	   panic_smp_self_stop
> > 	   rcu_is_watching
> > 	   intel_irq_remapping_free
> 
> This completely lacks context. When does this happen? What's the system
> state? What has intel_irq_remapping_free() to do with the allocation path?

Sorry, let me clarify it a bit better:

1) This happens when the machine is booted up, and being under stress
2) This happens when I have failslab fault injection enabled.
3) The machine crashes after hitting this error.
4) This is reproducible with `stress-ng` using the `--aggressive` parameter
5) This is the full stack (sorry for not decoding the stack, but if you
   need it, I am more than happy to give you a decoded stack)


 04:12:34  can not alloc irq_pin_list (-1,0,20)
           Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed
           CPU: 11 UID: 0 PID: 335023 Comm: stress-ng-dev Kdump: loaded Tainted: G S          E    N 6.10.0-12563-gdb0610128a16 #48

           Call Trace:
            <TASK>
            panic+0x4e9/0x590
            ? _printk+0xb3/0xe0
            ? panic_smp_self_stop+0x70/0x70
            ? rcu_is_watching+0xe/0xb0
            ? intel_irq_remapping_free+0x30/0x30
            ? __add_pin_to_irq_node+0xf4/0x2d0
            ? rcu_is_watching+0xe/0xb0
            mp_irqdomain_alloc+0x9ab/0xa80
            ? IO_APIC_get_PCI_irq_vector+0x850/0x850
            ? __kmalloc_cache_node_noprof+0x1e0/0x360
            ? mutex_lock_io_nested+0x1420/0x1420
            irq_domain_alloc_irqs_locked+0x25d/0x8d0
            __irq_domain_alloc_irqs+0x80/0x110
            mp_map_pin_to_irq+0x645/0x890
            ? __acpi_get_override_irq+0x350/0x350
            ? mutex_lock_io_nested+0x1420/0x1420
            ? lockdep_hardirqs_on_prepare+0x400/0x400
            ? mp_map_gsi_to_irq+0xe6/0x1b0
            acpi_register_gsi_ioapic+0xe6/0x150
            ? acpi_unregister_gsi_ioapic+0x40/0x40
            ? mark_held_locks+0x9f/0xe0
            ? _raw_spin_unlock_irq+0x24/0x50
            hpet_open+0x313/0x480
            misc_open+0x306/0x420
            chrdev_open+0x218/0x660
            ? __unregister_chrdev+0xe0/0xe0
            ? security_file_open+0x3d4/0x740
            do_dentry_open+0x4a1/0x1300
            ? __unregister_chrdev+0xe0/0xe0
            vfs_open+0x7e/0x350
            path_openat+0xb46/0x2740
            ? kernel_tmpfile_open+0x60/0x60
            ? lock_acquire+0x1e4/0x650
            do_filp_open+0x1af/0x3e0
            ? path_openat+0x2740/0x2740
            ? do_raw_spin_lock+0x12d/0x270
            ? spin_bug+0x1d0/0x1d0
            ? _raw_spin_unlock+0x29/0x40
            ? alloc_fd+0x1e6/0x640
            do_sys_openat2+0x117/0x150
            ? build_open_flags+0x450/0x450
            ? lock_downgrade+0x690/0x690
            __x64_sys_openat+0x11f/0x1d0
            ? __x64_sys_open+0x1a0/0x1a0
            ? do_syscall_64+0x36/0x190
            do_syscall_64+0x6e/0x190
            entry_SYSCALL_64_after_hwframe+0x4b/0x53
           RIP: 0033:0x7f6c406fd784
           Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 d6 88 f8 ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 28 89 f8 ff 8b 44
           RSP: 002b:00007fff72413a70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
           RAX: ffffffffffffffda RBX: 00007f6c408c43a8 RCX: 00007f6c406fd784
           RDX: 0000000000000800 RSI: 000055759a5fc910 RDI: 00000000ffffff9c
           RBP: 000055759a5fc910 R08: 0000000000000000 R09: 0000000000000001
           R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000800
           R13: 00007fff72413c90 R14: 000055759a5fc910 R15: 00007f6c408c43a8
            </TASK>

> > This happens because add_pin_to_irq_node() function would panic if
> > adding a pin to an IRQ failed due to -ENOMEM (which was injected by
> > failslab fault injector).  I've been running with this patch in my test
> > cases in order to be able to pick real bugs, and I thought it might be a
> > good idea to have it upstream also, so, other people trying to find real
> > bugs don't stumble upon this one. Also, this makes sense in a real
> > world(?), when retrying a few times might be better than just
> > panicking.
> 
> While it seems to make sense, the reality is that this is mostly early
> boot code. If there is a real world memory allocation failure during
> early boot then retries will not help at all.

This is not happening at early boot, this is reproducible when running
stress-ng in this aggressive mode.

Since I have failslab injecting a kmalloc fault,
__add_pin_to_irq_noder() returns -ENOMEM, which causes the undesired
panic().

> > Introduce a retry mechanism that attempts to add the pin up to 3 times
> > before giving up and panicking. This should improve the robustness of
> > the IO-APIC code in the face of transient errors.
> 
> I'm absolutely not convinced by this loop heuristic. That's just a bad
> hack.

I will not disagree with you here, but I need to use this patch in order
to be able t keep the system not panicking and stable while fault
injecting slab errors and trying to reproduce a real bug in the network
stack.

Thanks for the review,
--breno

