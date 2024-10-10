Return-Path: <linux-kernel+bounces-358329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0B997D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDF21F258B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD31A0AFB;
	Thu, 10 Oct 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tp7la6zt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BWUt3kV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0321A08B1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541934; cv=none; b=FbJD+VzVlzibPNILyqf6T+TkZXdEp+J8KlrT0HJYX6ktDQvyytGQMfoMrfl+GBtqvcrwgYwEK0fochcZJeyydgsgEqvmA9Gx/hnX7fd5wSf+s9rc66DolzTjQwVF4ST6Ils00i7CxVusVcWI6lujZkHDlvmnyfIMIoMr8S93lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541934; c=relaxed/simple;
	bh=PcxiXBH5S2CpgKiKp7aG2U6MiH3nPR4YLOFWFO/acHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnomL5hOlfwuwr8gxvf1PKXPxH7HmYnDXOn9VrNdFDRHE84oDrYG3ODKGL3sjvh9bc2BaZkWpQCNWYU7Ey5djYX6Yrhc7Il4KJF200z0g7KP9GIhovz9mvmc1Xwk913h6SgVMt137Pw3xsOtlbuWJdv3cp3K7f154FX9nYYfYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tp7la6zt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BWUt3kV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 08:32:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728541929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ma9hix//GgNJ8yBgR6Y/fS4jhkGf1eka8chg5leXufM=;
	b=tp7la6ztP0PP7vBZK+WK2+2hZsWaC/nRHRyz4cUYLAC1k9iuBHA1rvX2OJLu3A85FHpKaP
	RwGRdYBkam02b/Jzvx06pal+UOTYjHzCJ8q6s9yle92TnMC8aU32N+gtfNGQFXLobzt7Hr
	RnvmzcWEqtSbqlttUD5BmuH8RD7DhqImom2J4bDmD9Px4QTMSiuJwtXt0Ynal9yf2Irc52
	Cyspdu0NL7mVGXbXqAHF0xQB08qxfnI+33wbp/a/NFckZcK7tDbjBxDTD8UE1KaqZ6oAX4
	gSlSeZciwRqiYPcyFkCZDlUKthghQvyugT0S9DfCAdOag6ioVEjR8N5yASeRcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728541929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ma9hix//GgNJ8yBgR6Y/fS4jhkGf1eka8chg5leXufM=;
	b=3BWUt3kVlLckTjQXuZbm2HkA5H7/gVolQqPYnDv+yE5XSye2buJhQuMmy+J8XsEyaidpQ3
	DGOkdvnKWNkJ8dDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010063207.xIrynIqO@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>

On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
> In order to support systems that currently run CONFIG_PREEMPT=3Dn that
=E2=80=A6
> Or am I once again missing your point?

The change is:
| config PREEMPT_RCU
|        bool
|-       default y if PREEMPTION
|+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)

Now:
- CONFIG_PREEMPT select PREEMPT_BUILD
- PREEMPT_RT select CONFIG_PREEMPTION
- PREEMPT_DYNAMIC selects PREEMPT_BUILD

and PREEMPT_BUILD select CONFIG_PREEMPTION

so in the end, this change is a nop, right?

> 							Thanx, Paul

Sebastian

