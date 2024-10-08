Return-Path: <linux-kernel+bounces-355483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485AF9952F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7721C1C23762
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF87A1DFD8E;
	Tue,  8 Oct 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvRP+z0O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJfttHoR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C291DFD1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400049; cv=none; b=OO1oyKjYTTUk1ruhg6vtvjmThrPrsxMOck2LbW0VJ8h8Itd0kkTrg2KVAa5mbXXLaSjnaNQmzv+tJoMT15FKBW41OV3DSs5EkI0EgRKfKbLyP5dIHcoAUoh55/MSCxTiI4SRsEudvA8CyICIcjigL3JHBgGbOKiGHPkdaGAH2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400049; c=relaxed/simple;
	bh=QCgviBaJeMoGo2qmUaA/6pGtkNj7nqyUSHHv20Utdrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Nyfz6/+DuL5GxgsDY0h8qLnwHlaF3LlYMD/7MEgIBRR5ZBYL0qCJfc01x1SvXpESzIp0qRnrFVoKDrQB62iWFqWZ7s7vuPR7396VTzvvSrhMg5R0k2Ti7VBK9N2JnU4wWYcFp0Migroj/gnued1nmJ5S1LvWyOWmGFYwVPFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvRP+z0O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJfttHoR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 17:07:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728400046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPc3xG3krSZmBTcw/AubqHB8oaYBJUxW3tDmqN3SWB4=;
	b=HvRP+z0Oai1Hm6fWBEzOmbK0AnFUxvRqQ1fKyjVqFZwpcYHa1rLkbOADyL7TYVkl+vzJ7A
	qwTQwxY5FHHg9bAoHdkhm9TZEg4FP7KScxwDxOubi9iKtQqabUCTPPwyyB7adjGuDzf0b0
	jCFjvvijGFBSPKmCug8R4gG2gMPDeOez0Hryeuck2/2uBsi2LLHRINPWXZhpr49XIoTxOS
	V10g3IUX5PXo5L54h73EqZq0FNncwODOO0DEnxg/RupvH4GZTrQbErx3S5F8HDC3IxbIjJ
	ZQoEf7NwechzhgRD2lhZALXIPo+aa/X9YXuSEz7l/fJax/MYpZ1nHA1UXbfbgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728400046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPc3xG3krSZmBTcw/AubqHB8oaYBJUxW3tDmqN3SWB4=;
	b=YJfttHoRwDElmtwGqAzKc+QiXD1hXeeHwKbOhp1CuFlsPjYvXcs9WzanlvTSPEcbw4cbqn
	3FzWBIRfn8U3aaDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 5/5] sched: Add laziest preempt model
Message-ID: <20241008150724.s5rOW5nS@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.671722644@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007075055.671722644@infradead.org>

On 2024-10-07 09:46:14 [+0200], Peter Zijlstra wrote:
> Much like LAZY, except lazier still. It will not promote LAZY to full
> preempt on tick and compete with None for suckage.
>=20
> (do we really wants this?)

This is like NONE/ VOLUNTARY without the .*_resched().
irqentry_exit_cond_resched() and preempt_schedule.*() does nothing
because only the lazy bit is set. This should trigger all the spots
which were filled with cond_resched() to avoid warnings, right?
There is nothing that will force a preemption, right?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
=E2=80=A6

The description is the same for two lazy models.

> +config PREEMPT_LAZIEST
> +	bool "Scheduler controlled preemption model"
	bool "Scheduler controlled preemption model (relaxed)"

> +	depends on !ARCH_NO_PREEMPT
> +	depends on ARCH_HAS_PREEMPT_LAZY
> +	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
> +	help
> +	  This option provides a scheduler driven preemption model that
> +	  is fundamentally similar to full preemption, but is least
> +	  eager to preempt SCHED_NORMAL tasks in an attempt to
> +	  reduce lock holder preemption and recover some of the performance
> +	  gains seen from using no preemption.

          The scheduler won't force the task off-CPU if the task does
	  not give up voluntary.
> +
>  endchoice

Sebastian

