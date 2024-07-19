Return-Path: <linux-kernel+bounces-257286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C19377E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6931C2169A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE934137775;
	Fri, 19 Jul 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMmiKiUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBkT/KiN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA713D258
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721392933; cv=none; b=Tp6B2lgP5fXBoHEMyfDQVp99ChI5oTRRCPVKsvJOBrUku5G3TNZ4iJaNndsLNlgJ22eAnM9qRCLBcYAYsTKofcSpkw/Ig7GHuwGiXMMeZahSV96Hkx5gIbpj5sxCTxWQ7kay6UHMqrvqm6fGY8xiEuIUvRbxpqiHxu1BPF+IAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721392933; c=relaxed/simple;
	bh=zDpYpXf0b6/7HUxDF3pGT/bOuDplYUNarjq9dlLn31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxnqYVnE3BSE566PlMSyyuyrKpg05UcFHE0EU1yLBaW40VOI+aScjJEnoUX2W4wCcKvp2N+eJcNBrw6DUzz67LtAvEL0/bmieQKLYMwtC9AgVW43gYh1218wCGBI7nX994NZxRr6x1hsE0itmEmoDLT/eR7tMLrk5Oo1HJgDCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMmiKiUo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBkT/KiN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jul 2024 14:32:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721392336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DS4ZTh/uFKxJ48RV9PLv7ODWrh+ofREviOBi8urmijA=;
	b=jMmiKiUoV6++pAFv+F1rxYL0YRIzmgtDSNJw27bD8Z7XBpGX2EQEJNS0DIZrhy8CC/TauP
	sVvq8AYo5nsR7gsyd4ThBVoF9SFxmAwMx6S+65cumYduDBp7PM8EsYELsvWz2y8OhA4JWx
	49gWt8Uuu1sTNXyQiHapmM2U0omk9A4t6SA6jS9AEXRVcgnuRSiblUoqMmucXxpmGAqbXP
	B1NxP/AhRB7fbyA1CAT+EoGgz5rIvxXQLWm8XIrDLCH5brA4sxAAFUyQuD3ao55v/PbN/G
	zpyRUwY6W/PfKxvy3DuUKtSVfKobLAOead4TD6WPXwnIUjbH08rVyR8luLIaeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721392336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DS4ZTh/uFKxJ48RV9PLv7ODWrh+ofREviOBi8urmijA=;
	b=qBkT/KiNuXbuznKdCkljo1TmRbPD6Xoizsu7kW+SJQ4WYCfRY9J3Ksb7aXFy1NeQ6Hehzm
	TSU+XdBdGh6ev/DQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Max Dubois <makemehappy@rocketmail.com>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	Dan Carpenter <error27@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you -
 Enormous memory leak
Message-ID: <20240719142037-93bd4395-1f6b-490a-8a14-50e7bcc756d1@linutronix.de>
References: <707784492.392759.1721383145890.ref@mail.yahoo.com>
 <707784492.392759.1721383145890@mail.yahoo.com>
 <3bd6b12c-533c-4b6d-bc91-696db8837b3e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bd6b12c-533c-4b6d-bc91-696db8837b3e@oracle.com>

On Fri, Jul 19, 2024 at 05:34:23PM GMT, Harshit Mogalapalli wrote:
> Hi Max,
> 
> 
> On 19/07/24 15:29, Max Dubois wrote:
> > Hello,
> > 
> > I write to you becouse you signed off this buggy commitment long ago.
> > 
> > I don't know how to report it. This is a nasty bug and I think it is
> > related to this committed on 6.6.24 and it is still present from that
> > kernel to even 6.6.10 only in 32 Linux machines with over 32 bit kernels
> > (tested by me on virtualbox and Vmware guests, I don't have real 32 bit
> > machines to test it):
> > 
> > commit 9a98ab01e3acba830cb0917296a13192fd23f305
> > Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > Date:   Mon Nov 13 12:07:39 2023 -0800
> > 
> >      platform/x86: hp-bioscfg: Fix error handling in
> > hp_add_other_attributes()
> > 
> >      commit f40f939917b2b4cbf18450096c0ce1c58ed59fae upstream.
> > 
> >      'attr_name_kobj' is allocated using kzalloc, but on all the error paths
> >      it is not freed, hence we have a memory leak.
> > 
> >      Fix the error path before kobject_init_and_add() by adding kfree().
> > 
> >      kobject_put() must be always called after passing the object to
> >      kobject_init_and_add(). Only the error path which is immediately next
> >      to kobject_init_and_add() calls kobject_put() and not any other error
> >      path after it.
> > 
> >      Fix the error handling after kobject_init_and_add() by moving the
> >      kobject_put() into the goto label err_other_attr_init that is already
> >      used by all the error paths after kobject_init_and_add().
> > 
> >      Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> >      Cc: stable@vger.kernel.org # 6.6.x: c5dbf0416000: platform/x86:
> > hp-bioscfg: Simplify return check in hp_add_other_attributes()
> >      Cc: stable@vger.kernel.org # 6.6.x: 5736aa9537c9: platform/x86:
> > hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
> >      Reported-by: kernel test robot <lkp@intel.com>
> >      Reported-by: Dan Carpenter <error27@gmail.com>
> >      Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
> >      Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >      [ij: Added the stable dep tags]
> >      Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >      Link: https://lore.kernel.org/r/20231113200742.3593548-3-harshit.m.mogalapalli@oracle.com
> >      Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I reported this on Gentoo forums in this discussion:
> > 
> > https://forums.gentoo.org/viewtopic-p-8834077.html#8834077
> > <https://forums.gentoo.org/viewtopic-p-8834077.html#8834077>
> > 
> > In this days 32 bit machines are pretty much unused and I think this is
> > the reason becouse no one reported it.
> > 
> > The bug wasn't present in kernels before 6.6.24 (example: 6.6.23 is ok).
> > 
> 
> Thanks for reporting and sendine me an email.
> 
> The commit you pointed out which is authored by me is in:
> 
> v6.6.4   - 9a98ab01e3ac platform/x86: hp-bioscfg: Fix error handling in
> hp_add_other_attributes()
> 
> So you should have seen this in 6.6.4 as well ?
> 
> > The bug wasn't present in kernels before 6.6.24 (example: 6.6.23 is ok).
> 
> This confused me, as the commit that you pointed out is present since 6.6.4

Given that the commit under discussion is for a HP BIOS driver and the
issue is reproducible in a VM guest without that hardware,
I'd argue it's highly unlikely that this commit is the culprit.
(Or has anything to do with the issue for that matter)

> > I tested it in various VMware and Virtualbox guests and it is very easy
> > to reproduce it.
> > 
> > You just need a VM with x86 emulated processor, over 1 GB of RAM and run
> > some applications like few terminals, a web browser and audio player.
> > 
> > In the log you will see a lot of complains related to vmalloc
> > allocations not present on working kernels before 6.6.24 and this
> > commitment.
> > 
> > Increasing vmalloc like suggested in the log, doesn't help.
> > 
> > Starting from this point the VM become unresponsive, it close apps, in
> > doesn't open others, terminals can't execute simple commands. Sometimes
> > you are even unable to reboot and sometimes the machines freeze,
> > sometimes they go in total kernel exception.
> > 
> > This happen 100 per 100 of the time, it is easy to reproduce it
> > everytime on any kernel 6.6.24 or more (6.7, 6.8, 6.9 and 6.10 are all
> > affected).
> > 
> > Considering the kernel is supposed to support 32 bit I think this is
> > something to fix it then I don't know how and to who point this bug too.

The reporting really should figure out which specific release or commit
is introducing the issue. And if mainline or 6.6.41 are also affected.

The linked gentoo forum thread has some actual kernel logs:

Jul 16 00:01:10 [kernel] alloc_vmap_area: 133 callbacks suppressed
Jul 16 00:01:10 [kernel] vmap allocation for size 20480 failed: use vmalloc=<size> to increase size
                - Last output repeated 9 times -
Jul 16 00:01:15 [kernel] alloc_vmap_area: 240 callbacks suppressed
Jul 16 00:01:15 [kernel] vmap allocation for size 20480 failed: use vmalloc=<size> to increase size
                - Last output repeated 9 times -
Jul 16 00:01:17 [kernel] warn_alloc: 3 callbacks suppressed
Jul 16 00:01:17 [kernel] Web Content: vmalloc error: size 8192, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
Jul 16 00:01:17 [kernel] CPU: 1 PID: 2761 Comm: Web Content Not tainted 6.6.38-gentoo #1
Jul 16 00:01:17 [kernel] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B32.2305221830 05/22/2023
Jul 16 00:01:17 [kernel] Call Trace:
Jul 16 00:01:17 [kernel]  dump_stack_lvl+0x32/0x41
Jul 16 00:01:17 [kernel]  dump_stack+0xd/0x10
Jul 16 00:01:17 [kernel]  warn_alloc+0xab/0x111
Jul 16 00:01:17 [kernel]  __vmalloc_node_range+0x73/0x345
Jul 16 00:01:17 [kernel]  __vmalloc_node+0x55/0x5d
Jul 16 00:01:17 [kernel]  ? bpf_prog_alloc_no_stats+0x1f/0xcd
Jul 16 00:01:17 [kernel]  __vmalloc+0x14/0x16
Jul 16 00:01:17 [kernel]  ? bpf_prog_alloc_no_stats+0x1f/0xcd
Jul 16 00:01:17 [kernel]  bpf_prog_alloc_no_stats+0x1f/0xcd
Jul 16 00:01:17 [kernel]  bpf_prog_alloc+0x13/0x9f
Jul 16 00:01:17 [kernel]  bpf_prog_create_from_user+0x47/0xbd
Jul 16 00:01:17 [kernel]  ? kprobe_free_init_mem+0x4c/0x4c
Jul 16 00:01:17 [kernel]  do_seccomp+0x176/0x7ac
Jul 16 00:01:17 [kernel]  ? __ia32_sys_prctl+0x47/0x5bf
Jul 16 00:01:17 [kernel]  __ia32_sys_seccomp+0x10/0x12
Jul 16 00:01:17 [kernel]  ia32_sys_call+0xd09/0x1063
Jul 16 00:01:17 [kernel]  __do_fast_syscall_32+0x7a/0x99
Jul 16 00:01:17 [kernel]  do_fast_syscall_32+0x29/0x5b
Jul 16 00:01:17 [kernel]  do_SYSENTER_32+0x15/0x17
Jul 16 00:01:17 [kernel]  entry_SYSENTER_32+0x98/0xf8
Jul 16 00:01:17 [kernel] EIP: 0xb7fc856d

The lines with "size 20480" repeat *a lot*, it could be the issue.


Thomas

