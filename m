Return-Path: <linux-kernel+bounces-526216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52BA3FBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC910882E15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4174211A02;
	Fri, 21 Feb 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYWpmjpN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8OTyGVN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D2210F65
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155748; cv=none; b=eymL5dpsirJilN2kshW6lIIcv2N1uVa4BFV0AaBLswSNM1PcdpIpwHI5sK9gAf35pZkrs9HnhXPYf4eb0HiAwmiBYIgsqBxqRaYYE+EztE6fz7QjpzRuUKFz+vV73MFTnqBQbPSXveC3gMyCispyKsRetq4csWH1j6c74v1PRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155748; c=relaxed/simple;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJPpmrnCbo9gKmdCHDcKMS+imqESwd0pusP6QGMVgQnhZ83uMd58OFSM36OgtsmQsfCK/Zo5emy98G0/KzSOVzF5OlLHY//82e7cAPJaSO/KH2X6YQcR+Tfqopekn5oVYGr4SV4fl9nEWmzRIMAWlKmqEdCGqkGMuGBkXiJ7Gew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYWpmjpN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8OTyGVN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 17:35:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740155745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	b=mYWpmjpNLtzKJEiLEH2jyeaBamwMEiPmDHCM/V6vvvr1xOS5mAd6WKx7EVH1YlXDkazsDs
	juLH4ckJxI3LQ4Le4L1mhOM0e6SxnCG0Fie+QfcQzeySOt7GDJ/AUSmWiNwSZwz/UgKbbC
	xj9/V89LFBkzihe021rrv26CLv3N/Dhp28c4VQsKlXqTQ6LO/WQ1SKZzfIrBuG9CIJgjTr
	MRKhfZIIbFtb5thEYZYE4KtMQEKGlXVvbzCbPCPaeYwNqTh+AxiOtJoDejyw/cXN3OUEpL
	tcdlRMOSFY99HjjDtc1wz5ELiInmFpeLziTB1DA/mh4Ov215tPYH0joBNe8AXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740155745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	b=t8OTyGVNdd3rNU4n4pvwbbn/mpMKWNpuRbQTJgGOkYYGJuBWXg6YX8mfelmF6XB8YFcA0P
	zBcrTt1ICrrLseBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] lockdep: disable_irq_nosync_lockdep.*() for
 PREEMPT_RT.
Message-ID: <20250221163543.erVpjzHa@linutronix.de>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-1-bigeasy@linutronix.de>

On 2025-02-12 11:36:17 [+0100], To linux-rt-devel@lists.linux.dev wrote:
> Guenter reported a sleeping-while-atomic warning on PREEMPT_RT with the
> NE2K card. Turns out it is a questionable construct which requires
> lockdep tweak to not get reported. It was added long time ago to deal
> with the NE2K and has today two users.

ping.

Sebastian

