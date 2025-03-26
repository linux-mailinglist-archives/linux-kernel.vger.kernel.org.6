Return-Path: <linux-kernel+bounces-576691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2EA7130F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F26164FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B8C8FE;
	Wed, 26 Mar 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05oq96x1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Slg6KHW/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788E3D6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978991; cv=none; b=VG7DKqru5h6F8+VwbhJwFONb6UqYNnd0V+8pOENuTy0ornxB5OsVF8v46vyUlsRNSu4bTPSYsQao2E8dQJtfezOlihTfRc8ELMb69LdAxdr/t09315A49XsxFv4HJVd9DX8zK/G4Xvow/Hmh3uuRDisTA6yTZWH3p68VNFXwE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978991; c=relaxed/simple;
	bh=LmVzw6P+iwvxitQOaKzKJxAmqr4PJZaBYQK11RdBHps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af9sPDsxoHgG/rOoFERtyrCZfI0BNXVO0nsGHaUoQQ9wkJJeWbDM2jHOv2zX+MV0cD0DucWZHFchaWRCzuoGjudD4DmqbxIe7aQIsib7adeI4/rI1frkTn5frp/7zWqlckyILqvCyXd62Z5t3SsGFlhpIUd485QnDtC/nwZ0190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05oq96x1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Slg6KHW/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 09:49:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742978987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gz8F9ltzV/QRdNcarKMp9yp/7xAhXEuaj3rVo3/1kgY=;
	b=05oq96x1+nxFYWli3nQBqNN1Dhyn5StuiNIn5WjpITSSj7gXMmiph4yVDhJcvoWX9m6mOS
	WI6V11g1KBvy2jU3u9Or5OPthwboAg/czmQUJGqDGp6fvs3vloAyQddoZ9R/71PX+F5bMf
	eyKDUJKKkxy+FnJ2bNf+fHGnDvjuHfPQu4xbxVUJFJbpgzHKdiENArwW/yWKLbrNg97YLg
	5ITySVgn/Ff4gARvc8l+vXElHEAiWKiTVwhZIfdmUZWv0UHY6e0fIVTVoL0f+lKYOkv+uW
	IuUQqhTgSEvLjowYR5MMaD3DwvgYprdF7jNZ/EJPaE79GAiZ+7pfejmXX5VmPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742978987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gz8F9ltzV/QRdNcarKMp9yp/7xAhXEuaj3rVo3/1kgY=;
	b=Slg6KHW/MP0RLMPnd8SjXrz/MMgDQvf4NZ2S+DRUSASkMgqXUgDKdR3oDlw5DCwRFJz1aJ
	585i+j0L52DcgwAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250326084946.VyD9JdIt@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>

On 2025-03-18 18:54:22 [+0530], Shrikanth Hegde wrote:
> I tried this in one of our systems(Single NUMA, 80 CPUs), I see significant reduction in futex/hash.
> Maybe i am missing some config or doing something stupid w.r.t to benchmarking.
> I am trying to understand this stuff.
> 
> I ran "perf bench futex all" as is. No change has been made to perf.
> =========================================
> Without patch: at 6575d1b4a6ef3336608127c704b612bc5e7b0fdc
> # Running futex/hash benchmark...
> Run summary [PID 45758]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
> Averaged 1556023 operations/sec (+- 0.08%), total secs = 10   <<--- 1.5M
> 
> =========================================
> With the Series: I had to make PR_FUTEX_HASH=78 since 77 is used for TIMERs.
> 
> # Running futex/hash benchmark...
> Run summary [PID 8644]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
> Averaged 150382 operations/sec (+- 0.42%), total secs = 10   <<-- 0.15M, close to 10x down.
> 
> =========================================
> 
> Did try a git bisect based on the futex/hash numbers. It narrowed it to this one.
> first bad commit: [5dc017a816766be47ffabe97b7e5f75919756e5c] futex: Allow automatic allocation of process wide futex hash.
> 
> Is this expected given the complexity of hash function change?

So with 80 CPUs/ threads you should end up with roundup_pow_of_two(80 *
4) = 512 buckets. Before the series you should have
roundup_pow_of_two(80 * 256) = 32768 buckets. This is also printed at
boot.
_Now_ you have less buckets so a hash collision is more likely to
happen. To get to the old numbers you would have increase the buckets
and you get the same results. I benchmark a few things at
	https://lore.kernel.org/all/20241101110810.R3AnEqdu@linutronix.de/

This looks like the series makes it worse. But then those buckets are
per-task so you won't collide with a different task. This in turn should
relax the situation as a whole because different tasks can't block each
other. If two threads block on the same bucket then they might use the
same `uaddr'. 

The benchmark measures how many hash operations can be performed per
second. This means hash + lock + unlock. In reality you would also
queue, wait and wake. It is not very use-case driven.
The only thing that it measures is hash quality in terms of distribution
and the time spent to perform the hashing operation. If you want to
improve any of the two then this is the micro benchmark for it.

> Also, is there a benchmark that could be run to evaluate FUTEX2_NUMA, I would like to
> try it on multi-NUMA system to see the benefit.

Let me try to add that up to the test tool.

Sebastian

