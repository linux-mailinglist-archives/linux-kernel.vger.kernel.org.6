Return-Path: <linux-kernel+bounces-358433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FDE997F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0442D2870B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE41CEEA6;
	Thu, 10 Oct 2024 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJgDuOd7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJgNkL9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A619D897
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544946; cv=none; b=NoAmadLLQjgL8LYNJIiH3uOHw31EpnXwWa+iIb2SbGxt5ZLtTAq047UfsWRjhqQbwbZIEBKHIxpvNCRaF/jCW+puDHLYHP7mKAlCDJbzDMQqtEpTLy4/gi0PfuGp2TCM1x7uczWBlUG8Yf6Qyns3HO/13IxV5K86o+c1TKqD9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544946; c=relaxed/simple;
	bh=GQMDrgk5mxTRpJnrhOXeZMXVpNbpT+SFD6fjRGJ1SUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn29soJ262OpZu4WmCwrCdCZkNWSg0HOVuhRNXcyH1P361QOADGhk0qyToRRIASgYLu+M982F92KnB4XkS9N4bWR0vqAwG4GeSzSbbiZ2IyKLlWvREy8gN6XcCvqVWWsRsb5eTERVFiRpyvf2cf1YbA4Izm7WT5HDA0mgAWka9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJgDuOd7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJgNkL9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 09:22:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728544943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJWq+WrjAnOQW/Z4MV/lFjidcQilwcqFqWs7drRmOIc=;
	b=jJgDuOd73K9nzdys010cN+4zWy/CY4+cDtC9ixpxy3ZkqRsNW6OTcvUFb+KyCJgUEO3Oio
	A4vBIc4UBPRld6JTWSGyZ21ZR8iUiHUuCSs8SxzNso7q6YbXzjl3EwlBV0u6RXqKYsC4c4
	BGurcmfdb+73Q4Ma8LYCBalOHYlh8EubQaI/7bCDPVOeaATQuy/NWk5YcgCgz1VSll78Pd
	QFwhnwRw9OwyGV0FWmrujp2+Lc0XP+3R0Zd84a5nG4R5IdpgbyJbpLA6UWZzrb2b/95per
	chNlqru4KcseSRGAK8TlFbpMiKWwOus45A8lGNg7srH7osPQbj8afCJRzI2/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728544943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJWq+WrjAnOQW/Z4MV/lFjidcQilwcqFqWs7drRmOIc=;
	b=yJgNkL9wKacnUec+y+pdxf7V2cRsPpmeggT3ArPqpU4RxazJN6VK7pDCzI4BMrNchgCfbz
	rt3fDFz815QqnIAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 7/7] powerpc: add support for PREEMPT_LAZY
Message-ID: <20241010072221.48wfFV7I@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-8-ankur.a.arora@oracle.com>

On 2024-10-09 09:54:11 [-0700], Ankur Arora wrote:
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Add PowerPC arch support for PREEMPT_LAZY by defining LAZY bits.
> 
> Since PowerPC doesn't use generic exit to functions, check for
> NEED_RESCHED_LAZY when exiting to user or to the kernel from
> interrupt routines.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> [ Changed TIF_NEED_RESCHED_LAZY to now be defined unconditionally. ]
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/powerpc/Kconfig                   | 1 +
>  arch/powerpc/include/asm/thread_info.h | 5 ++++-
>  arch/powerpc/kernel/interrupt.c        | 5 +++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8094a01974cc..593a1d60d443 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -270,6 +270,7 @@ config PPC
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RETHOOK			if KPROBES
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RSEQ

I would move this up to the ARCH_HAS_ block.

> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 6ebca2996f18..ae7793dae763 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
>  #endif
>  #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>  #define TIF_32BIT		20	/* 32 bit binary */
> +#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */

I don't see any of the bits being used in assembly anymore. 
If you group the _TIF_USER_WORK_MASK bits it a single 16 bit block then
the compiler could issue a single andi.

Sebastian

