Return-Path: <linux-kernel+bounces-360740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18D999ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958A61F23949
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFB20ADDC;
	Fri, 11 Oct 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1MoxL+U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/YbdjEJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6620ADD2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634732; cv=none; b=k/YtkVGHWKZOyoT4L91m9ibX5OAfUR8fDFkMTRS/VfABfgFHus6jqvjHcD9TmzB/FmHV1hDIfaZSJnnCHSFDBoMUOe00YRW/pvxLNpqTT1hCHoa32iNN8j8M4ZAeGFcbvway8Fu/1G0pm5Q8t4rQj4MUYbjN+zeWk1rZ5Wdzd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634732; c=relaxed/simple;
	bh=ik7+nBFG7GgZ7gFcABfJWNOmwrXwEej9srC/VTvY3T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYoNKEIEMT0CkEp/JxMQg18lPQXtdwIX1q+xmhDCVfGIAL8GCL8LxIBfunJqpO8qMGNxiEZ8DcEMLsvq6ykH5AFDQXLZAuq6vLfADr2mMit49KX8eDmyGB/xboX2A1SQVv6OuGYfuVlZ5KmRW5GxSf7iukH7C4sy7B1AzPf9HNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1MoxL+U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/YbdjEJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 10:18:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728634728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTtwBVq//DIVFt8L0HAupL1BHd9Kf5PNotg5A0/Llnc=;
	b=z1MoxL+Up0OUYrgrwG3Q/IG3qLi/S8rwdSw4AW8UDbD0q7gNp1OsoV6R70r3wQzqN/Xz+h
	ZQj5E0nTKV8sbttl9RVIrl9qs8vTLqRXFPWDyU4H0W148/oB7R0dQhdg70zSs5Pd00dwqI
	HaXrWRiHbk2h7h4WUdo+0WYhZhqXrFwNP98EbNwFW/5d56FtpqBy0RWBasog+A5iYLM9h2
	zDDBG4o02aGDGO5pnnK/PL2S1MkeLqdYjVZ8aXTFKtjoOM7quJh+wlPTwB6mhqnw7qjQiB
	Pl2ImE+eL2bkATswc1thvxI0BysDeF9fPvM7k+OPNr8jKHSPS0PNQ7iI/2SqbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728634728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTtwBVq//DIVFt8L0HAupL1BHd9Kf5PNotg5A0/Llnc=;
	b=1/YbdjEJ9i+B6Kp6Aa++69cDUW/MjV3G7S1zzzlGj75OVoufscvJCWb+OIE+JrBw7GwGpG
	UMFFLJG9tL/LukCw==
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
Message-ID: <20241011081847.r2x73XIr@linutronix.de>
References: <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>

On 2024-10-10 07:29:07 [-0700], Paul E. McKenney wrote:
> If you have PREEMPT_RT, you need preemptible RCU, so the defaults should
> supply it.
> 
> If you have PREEMPT_DYNAMIC, presumably you would like to boot with
> preemption enabled, and would like it to act as if you had built the
> kernel to be unconditionally preemptible, so again you need preemptible
> RCU, and so the defaults should supply it.
> 
> If you started off building a non-preemptible kernel, then you are not
> using one of the major distros (last I checked).  There is a good chance
> that you have a large number of systems, and are thus deeply interested
> in minimizing memory cost.  In which case, you need non-preemptible
> RCU in the new-age lazy-preemptible kernel.
> 
> Hence the choice of non-preemptible RCU as the default in a kernel that,
> without lazy preemption, would use non-preemptible RCU.

I *think* I slowly begin to understand. So we have LAZY and DYNAMIC
enabled then and PREEMPT_RCU depends on the default choice which is
either FULL (yes, please) or NONE/VOLUNTARY (no, thank you). But then if
you change the model at runtime (or boottime) from (default) NONE to
FULL you don't have preemptible RCU anymore.

If you would like to add some relief to memory constrained systems,
wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
allow to override it?

> 							Thanx, Paul

Sebastian

