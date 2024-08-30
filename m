Return-Path: <linux-kernel+bounces-308476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31BA965D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB04286C47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3416EBFC;
	Fri, 30 Aug 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHDe1q+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53813A261
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011579; cv=none; b=FjckuM8WoPVXH7BlYaDP7gJ+KfeLDgdCZgxP6ReSLD4mHk2zW7C+1JsXLFf/KzPEICM+mlSDxEfg/u407FW+FbydMCZJGed6X97K+IMZBmlp/0jrIHpyhemnjnUxclBRAL3VTdCUFASAFe5Kfy1Od7l7H1FHnJ5OHVZSOkWFhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011579; c=relaxed/simple;
	bh=uEdtAmc02zf8K/kC/H0kNtQPwfgD9V1CqxF8y1Kd7Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtshWj6Vnc5MAMcoYj6OMMd1b+WMSVSZL/+yiDjBkcARiOphbcKuQ2Ki5tWD/fgZR67XqQOkTpLSri8Vtz1KKekN0VQZnEGk0tK4lo+KquBcIe2Npv9JI7TKIWYIGFRj8VXAkKT1iCkr3nT6GpE55yRRxr6tDQfQeuy9e9L3gQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHDe1q+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D9FC4CEC2;
	Fri, 30 Aug 2024 09:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725011579;
	bh=uEdtAmc02zf8K/kC/H0kNtQPwfgD9V1CqxF8y1Kd7Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHDe1q+1zvL/T1y3pHhXPhFTQTPFUQQG1jZ7B1w1LaA8RlmOkh5OBCTzy2JuWs7Ua
	 RuBIArZVo2Q7D6lc3JVT7Kp1TapBr0FYnvEswwtW6TyGHbl8StdhNRyltWit+fUfrN
	 fuQ1FzTBCqWGQh32Z2iRL2NeYvzGnlLYg+0VU6mqDwE814GSo44jwJGrk359mqRWQk
	 mO1gg2ITxMtLc7LF1LQxxwsuBGMP9l1AkLj5vEQOjIJIkZFyd4EXL8mn/RhTH04bvI
	 RM7GPtowh6FduLEdwMCPHKpOn/CNmDEy6JnR1D5kNEC7yMAssxnt/yZS5Cj5NjTisP
	 dGIatUOnbkjpQ==
Date: Fri, 30 Aug 2024 10:52:54 +0100
From: Will Deacon <will@kernel.org>
To: syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	maz@kernel.org
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
Message-ID: <20240830095254.GA7769@willie-the-truck>
References: <000000000000f362e80620e27859@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f362e80620e27859@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme

+Marc, as this is his branch.

> console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/vmlinux-33faa93b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b1f599907931/Image-33faa93b.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> 
> Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkaller) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
> random: crng init done
> Machine model: linux,dummy-virt
> efi: UEFI not found.
> NUMA: No NUMA configuration found
> NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
> NUMA: NODE_DATA [mem 0xbfc1d340-0xbfc20fff]
> Zone ranges:
>   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
>   DMA32    empty
>   Normal   empty
>   Device   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> cma: Reserved 32 MiB at 0x00000000bba00000 on node -1
> psci: probing for conduit method from DT.
> psci: PSCIv1.1 detected in firmware.
> psci: Using standard PSCI v0.2 function IDs
> psci: Trusted OS migration not required
> psci: SMC Calling Convention v1.0
> ==================================================================
> BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> Write of size 4 at addr 03ff800086867e00 by task swapper/0
> Pointer tag: [03], memory tag: [fe]
> 
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller-g33faa93bc856 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x118/0x5ac mm/kasan/report.c:488
>  kasan_report+0xc8/0x108 mm/kasan/report.c:601
>  kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
>  __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
>  smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>  setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>  start_kernel+0xe0/0xff0 init/main.c:926
>  __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
> 
> The buggy address belongs to stack of task swapper/0
> 
> Memory state around the buggy address:
>  ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
> >ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                    ^
>  ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> ==================================================================

I can't spot the issue here. We have a couple of fixed-length
(4 element) arrays on the stack and they're indexed by a simple loop
counter that runs from 0-3.

Will

