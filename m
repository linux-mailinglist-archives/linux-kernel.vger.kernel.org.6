Return-Path: <linux-kernel+bounces-576732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B9A713B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3E9188EA96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5531187872;
	Wed, 26 Mar 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lu1feKwL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="55Swh33O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B32F42
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981519; cv=none; b=MMsL6a6UqaxNqSmuMYpQMBL8r8aja2hI31dvO5zuvwjnIZS2ScJGmnn61viJHUD/iy2JCsRCsPfGLb/FGzY2L3R3glhE33vmDIeDpBIh1Ayul+W2jJcGJQzhXd4ilGKjaZ7lElt6Gz39ktwS2kLjktJNpSLLwJ5ayparwFjVRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981519; c=relaxed/simple;
	bh=flg3l++JFrsj3kJkUANQTt1Ji2Y0LiAbuxFybUdhtx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7rJ1ouBUheVBk4zvWGYX9P3t0T4Ws0qprdmlef4XQ8Uxg0TolF3UDZmMuFzlii2iBe3EclgElZmOZbtMM99kjDb6bGVAdtzYtFhTV8K+qCO11R6V72t3A7sBIUQVzp9x6bMOvZ665fsgkw3F4cTAZNpe73Nkpc1AGfEO7CiR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lu1feKwL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=55Swh33O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 10:31:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742981514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spFZOhmUvoAs6K2ujJCU4wgUAPTTw6QUCrfcN3N5bls=;
	b=Lu1feKwLiZWmr1kUuYTZgfzROyDfAXlac3TK0qt6te4hDWdQ7jPeqkCVgbjl81B1ahRErE
	CgaPTpavXKkhrRNz0r5Ktuxk1aR9y9SxZAk5TagCozyHPmVLRbOVjUrHFnjLkE/wJInpTi
	F68wekQgtAd7SpSLPfgUNyKUMF+Enh3uAC81dwuos+uq/v40uUSQsg0sxUFCM+VXX8Qkmp
	gtL3brgv6qdpzHJcjwrhj2eL3ZWj8Inc0leZCBEEfUAVc9MGVoMaQKK8CRYhd26JyZ3zf/
	Gt6XKrjHEr1MzzgzoTtpzu23YddlblncVwLc9DakuRVG1wDHN40ZmDE2ndT4vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742981514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spFZOhmUvoAs6K2ujJCU4wgUAPTTw6QUCrfcN3N5bls=;
	b=55Swh33OMQx4omuV9cleDLYpERT3aQxUFR238hGLziq7ADXVj1pbCDMuRasba70en1ifbz
	wkWpAoMZUZ0k+6CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	"Nysal Jan K.A." <nysal@linux.ibm.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250326093153.Ib5b2p6M@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
 <587d45c3-2098-4914-9dfc-275b5d0b9bb7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <587d45c3-2098-4914-9dfc-275b5d0b9bb7@linux.ibm.com>

On 2025-03-26 00:34:23 [+0530], Shrikanth Hegde wrote:
> Hi Sebastian.
Hi Shrikanth,

> So, did some more bench-marking using the same perf futex hash.
> I see that perf creates N threads and binds each thread to a CPU and then
> calls futex_wait such that it never blocks. It always returns EWOULDBLOCK.
> only futex_hash is exercised.

It also does spin_lock() + unlock on the hash bucket. Without the
locking, you would have constant numbers.

> Numbers with different threads. (private futexes)
> threads	baseline		with series    (ratio)
> 1		3386265			3266560		0.96	
> 10		1972069			 821565		0.41
> 40		1580497			 277900		0.17
> 80		1555482			 150450		0.096
> 
> 
> With Shared Futex: (-s option)
> Threads	baseline		with series    (ratio)
> 80		590144			 585067		0.99

The shared numbers are equal since the code path there is unchanged.

> After looking into code, and after some hacking, could get the
> performance back with below change. this is likely functionally not correct.
> the reason for below change is,
> 
> 1. perf report showed significant time in futex_private_hash_put.
>    so removed rcu usage for users. that brought some improvements.
>    from 150k to 300k. Is there a better way to do this users protection?

This is likely from the atomic dec operation itself. Then there is also
the preemption counter operation. The inc should be also visible but
might be inlined into the hash operation.
This is _just_ the atomic inc/ dec that doubled the "throughput" but you
don't have anything from the regular path.
Anyway. To avoid the atomic part we would need to have a per-CPU counter
instead of a global one and a more expensive slow path for the resize
since you have to sum up all the per-CPU counters and so on. Not sure it
is worth it.

> 2. Since number of buckets would be less by default, this would cause hb
>    collision. This was seen by queued_spin_lock_slowpath. Increased the hash
>    bucket size what was before the series. That brought the numbers back to
>    1.5M. This could be achieved with prctl in perf/bench/futex-hash.c i guess.

Yes. The idea is to avoid a resize at runtime and setting to something
you know best. You can also use it now to disable the private hash and
stick with the global.

> Note: Just increasing the hash bucket size without point 1, didn't matter much.

Sebastian

