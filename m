Return-Path: <linux-kernel+bounces-200484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BE8FB0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C050828247E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96C144D22;
	Tue,  4 Jun 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWVh4Tjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25A13D243
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498885; cv=none; b=LR3UG5UU2lLLbURF50UibuN5te3MEBAi1OhmRwBtZGFjwo9kQCJb4LrtGGVCGOHSUcQflyLYXeJEVS3D2mvlfmnYpuWxffuahT7yPpVgubFIhLjn9N1PsoSQRdPos1U48Lwn/z3frhsa9yVpHWaFnNt9Em+gbVu78kroyx/eZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498885; c=relaxed/simple;
	bh=9k79GsPGzm2AvUEzs0+bU/ldhlkSEOwUuzkUE/Ejxj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxhrbdgfmIWLLPY6hobZbb/Uv0uvAcN7N1/v9K2dDjkgDuNnvd/s2iEm3HqjANIXjYFwUfFgzDveIFIsy977P3nhaqOBozDg/BtPDbKpE4xjqM0yqAv9gnZhZOScNZkajbQXONoJYcrM/kAyUouhcaRScRnMQbl0TRLsfL8hSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWVh4Tjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1830C2BBFC;
	Tue,  4 Jun 2024 11:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717498885;
	bh=9k79GsPGzm2AvUEzs0+bU/ldhlkSEOwUuzkUE/Ejxj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWVh4TjrrJEW1rAMjOkRgSCV7udDjWnb2anstavniGKlRUr9e0G/xsT+BMP0GQPgN
	 dothII+OwwG1o2VK5CwwVbn6O1ExgNkwnE7lj/71h/Q8qgC2MCNTmL0IR8qfVC0WOr
	 c4C5m4aejQ3IXr5dpusN9NbhPvTjT26xvfM+v2sW8wlk/FmX7AWXcqqo+J/YecItAV
	 V9dlJLFmAKywNdUqbFJtTD1WxGeMudq78pAZcFTueXPGoDvlJrL3HHIVnxxA5C0FP3
	 OBmnA/imD1n1r8d0ZRtYA/2TN65KUj6HzamXOnU+wZkr9eWxR3DVi4kQSdPxw8ZPZH
	 k/yUJLbhtJvKA==
Date: Tue, 4 Jun 2024 12:01:20 +0100
From: Will Deacon <will@kernel.org>
To: syzbot <syzbot+8336c747d79a4c3a0944@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	mark.rutland@arm.com
Subject: Re: [syzbot] [arm?] BUG: unable to handle kernel paging request in
 task_h_load
Message-ID: <20240604110119.GA20284@willie-the-truck>
References: <000000000000fa65d80619830888@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fa65d80619830888@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello Syzbot,

On Tue, May 28, 2024 at 05:47:22AM -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    6d69b6c12fce Merge tag 'nfs-for-6.10-1' of git://git.linux..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164ce7f0980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=21de3d423116c304
> dashboard link: https://syzkaller.appspot.com/bug?extid=8336c747d79a4c3a0944
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119fbe58980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a8443c980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-6d69b6c1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9fa4d7c3665d/vmlinux-6d69b6c1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/131ac291917c/Image-6d69b6c1.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8336c747d79a4c3a0944@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address 007000000621a118
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [007000000621a118] address between user and kernel address ranges
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3189 Comm: syz-executor371 Not tainted 6.9.0-syzkaller-12124-g6d69b6c12fce #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : cfs_rq_of kernel/sched/sched.h:1468 [inline]
> pc : update_cfs_rq_h_load kernel/sched/fair.c:9441 [inline]
> pc : task_h_load+0x40/0xb8 kernel/sched/fair.c:9466
> lr : detach_tasks kernel/sched/fair.c:9181 [inline]
> lr : sched_balance_rq+0x80c/0xc94 kernel/sched/fair.c:11375

Mark and I were looking at this today and we believe it should be fixed
by:

https://lore.kernel.org/all/20240524005444.135417-1-21cnbao@gmail.com/T/#u

which is queued in -next via the mm tree and will hopefully land in -rc3.

Will

