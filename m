Return-Path: <linux-kernel+bounces-343775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BC989F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DC21F21EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75C6558BA;
	Mon, 30 Sep 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFHQNYwa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQjC5srC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0961741D1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691748; cv=none; b=TlDCwOMAiZy2bsUAU3iys+6w2ic+dP642Ysuq3VDQOw15lAholeQASsb5+ePsYCGz3QXptadkMF0aFZrvfRiJdfkUHF1EAmz6nqsyxcxz90jdJIbIPjJCyI+a0qZnF8W5Su0yBy+1WwYlT/3PjsYtOcCtWj/ZsEfIxoFFr1uFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691748; c=relaxed/simple;
	bh=XnAIQZY3d0mjEO/MmhFTWYhC82TcLroMyoi4wIznrCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeupV43gSYMbVdCm24uJ5hZqTVURUJAVZ/3yryRr2ZZVVkDTtwwgGFSefwaNV3vyPlp9ybAPRZ/d+JXE60ZhlMUczBib7659zImapJmV0izr3bdJzVGxR4kOAh34yZC+0hPvE9JB6Hd5bFy/pp0UrY9j0oMZj0AK7IsUWM/QSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFHQNYwa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQjC5srC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Sep 2024 12:22:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727691744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eSp9RkDK47YInIXsiINyou7i4My3KIjpO1cjCWuO4w=;
	b=ZFHQNYwafO0wZuT/ucBNEf7mejaRtFogfwHX+VWL8/tLERbkug7vhX83r300VXMauBYIe3
	FWRXoCrc9Q63CEKxNEA2/tKreJ6gdOr24jP+WPbhCVXepbFx2rUBCoxnklDQPoIqvXLKZn
	fQzr8CaBffzGpxy6gbQtOeOEAytYGlkz9Sux/euMmhwC9lyoQiwER82fBu/hUq2O34Tr6t
	8+N9uVgQq2DZeTsOfl7CgAPHTPnhIe0pwZAZddPpQr8q767iOJkCEkTYORlACc37mWcP5Y
	DcsqhvHpLHelkefNg096G02+wJscoQBZNHGEx6eXFQWujHSA9zCvmSWpIZmcGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727691744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eSp9RkDK47YInIXsiINyou7i4My3KIjpO1cjCWuO4w=;
	b=vQjC5srCXfVvsUCLZIq61F2rL45WSJ7g88iAMm1caVtgkFpDO35RA8xrVfAy1NUtMEQEmk
	KvAcf/r37Vm0ljCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/3] Allow to enable PREEMPT_RT.
Message-ID: <20240930102223.j780j0oy@linutronix.de>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
 <e058fcbd-dc30-4e7e-b54b-969d9dd67d4a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e058fcbd-dc30-4e7e-b54b-969d9dd67d4a@linux.ibm.com>

On 2024-09-30 10:39:17 [+0530], Shrikanth Hegde wrote:
> Hi Sebastian.
Hi Shrikanth,

>=20
> Added the ARCH_SUPPORTS_RT in arch/powerpc/Kconfig. Selected the preempt_=
rt in menuconfig.
> It *compiled and booted successfully* on POWERPC/ppc64le.

=E2=80=A6
> So, Curious to know what are those patches that are left for POWERPC?
> would like to work on those and get it enabled on POWERPC.

Based on [0] this is what I have in my queue:
| powerpc__traps__Use_PREEMPT_RT.patch
| powerpc_pseries_iommu__Use_a_locallock_instead_local_irq_save.patch
| powerpc-pseries-Select-the-generic-memory-allocator.patch
| powerpc_kvm__Disable_in-kernel_MPIC_emulation_for_PREEMPT_RT.patch
| powerpc_stackprotector__work_around_stack-guard_init_from_atomic.patch
| POWERPC__Allow_to_enable_RT.patch

Be aware that PREEMPT_RT run only on 32bit PowerPC and 64bit from FSL
which is the embedded variant. That means it (64bit) had altivec but
also a "simple" MMU. The P-Series (server grade hardware) version has a
hashing MMU which has additional locking constrains. I never tested this
outside of qemu and this was limited to booting.

The traps patch in the queue was submitted a while ago
	https://lore.kernel.org/linuxppc-dev/20191015191821.11479-4-bigeasy@linutr=
onix.de/

and reduced to the traps.c part.
The powerpc should be reviewed and then decided what to do with them
before enabling.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/t=
ree/patches/series?h=3Dv6.11-rt7-patches&id=3D28e79a9ab2504e245837070f27f52=
5520a6f5acb#n147

Sebastian

