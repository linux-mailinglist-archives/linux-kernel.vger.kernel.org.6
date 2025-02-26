Return-Path: <linux-kernel+bounces-534047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62BA46213
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A871188F81D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7D21B9C5;
	Wed, 26 Feb 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UIueZEZw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkL9E1tS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215D3209
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579366; cv=none; b=JlEwLUhLMcKTH13uUihOfQPBmiE8GgGRp7c/7ne7QDvXWU/Lw30EQT9wHQhG5gD0AbfUC9pM7uGaLTOHElglxC6MuJzbbec/OlEX5Cai+25UpUHcnywx30A15BPed5PiYQZFobABaXwd23425H6Kn9d7HDKbvi24+rHFS2yRz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579366; c=relaxed/simple;
	bh=+22gOs8S5d4E9UxPZqeJIYphnE6ScP1uHa78A/JGDKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxWJUXkNdv7pHk76TgXax6CUUT69gEq2Xict8zDippMiqABB0J3hRxMnhApE+4hd6VUbFX+N5GOK572bBrgYwUsN3BeOaIO86h/pzxlE23tvJkyVFlw1Ij/sSH2e/8MhndRUeNJHKVvh79dBoJU9MHBG3tzz9A/mwbiJlJX/WWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UIueZEZw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkL9E1tS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 15:16:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740579362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvs8XNbEl/alJbdW70qIi28Rlefg4eDpG/mkImN9p4U=;
	b=UIueZEZwb2vEfIzdUy7smeKVEuQsme7oCJqisG0+orYlq9ITKsRYY70MluvDDJJSdyRSg2
	mLmo2sUPZLCtwmZAit71JQJYKZHNVwFqO0d4lFrTlmdMnzgfU6KJ0q5RDIfGgSmDJu1RU+
	2U72Ic+V2XJZzKi11e/464GJWXg0+N8dbBZkxV4cFQDrH/8cUPMs4HE+2j+P8OvEuUX3zM
	4fo8TKe9x54V7M6vcNzJxd4qrrvrJBpvM+zsKdPmBLTaejF4KcwpWbaGarKWPQGt+6+JbQ
	SMpwGBxkBYFFy67SCE6huQrw/LVPHSmFu+Qkb+s0lYM70B6+4CaNjJ2hWBCpLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740579362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvs8XNbEl/alJbdW70qIi28Rlefg4eDpG/mkImN9p4U=;
	b=PkL9E1tS+b4dGmodcwg9JESlpefuRuFYNpZhohnz1ZeZA1Eekco+v79CrLzQd8E6zUAjOk
	cy+bvzLr+rXw4SBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226141601.VBQ91ZDb@linutronix.de>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223224014.GC23282@redhat.com>

On 2025-02-23 23:40:15 [+0100], Oleg Nesterov wrote:
> Well... I won't really argue because I can't suggest a better fix at
> least right now. Most probably never.
> 
> However, let me say that this patch doesn't make me happy ;) See below.
> 
> On 02/21, Sebastian Andrzej Siewior wrote:
> >
> > Oleg pointed out that this might be problematic if one closes 2.000.000
> > files at once. While testing this scenario by opening that many files
> > following by exit() to ensure that all files are closed at once, I did
> > not observe anything outside of noise.
> 
> and this probably means that we can revert c82199061009 ("task_work: remove
> fifo ordering guarantee") and restore the fifo ordering which IMO makes much
> more sense.

So assume that turning around will fix the problem because the cancel
callback is run first followed by the clean up.

> But:
> 
> > Fixes: c5d93d23a2601 ("perf: Enqueue SIGTRAP always via task_work.")
> 
> Yes. So, to fix this specific problem in perf this patch changes task_work.c
> 
> And after this change we can never enforce a "clear" ordering, fifo or even lifo.
> The ordering is simply "unpredictable/random".
> 
> I'll try to find and read the previous discussions tomorrow, but iirc Frederic
> had another solution?

Two at least:
- having a pointer to the next item
- avoiding the wait in the task_work callback. I think this is the
  unfortunate part. I think he had something but was very unhappy with
  it.

> Oleg.

Sebastian

