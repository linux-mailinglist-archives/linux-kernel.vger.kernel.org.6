Return-Path: <linux-kernel+bounces-554651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607C7A59AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6BF7A6038
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DD22FE08;
	Mon, 10 Mar 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqiTt5sK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0RcFeGf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE81D79BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624036; cv=none; b=hbwtF1kETCazgszTNvlhX3vBwmjPMMfsCknRXROE/ibMSN/fYFUgaZvAPzq/OGuBbR0QDmWb5+3a/yPvHnGej9lz+sVMCY9tBnmb+3a0Ms2+tmPrHFL3x6py4B/2dv9vcd9RPWIKWoxtZC+DaC+SMadO7Bm6nbWyHo0JCmT6RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624036; c=relaxed/simple;
	bh=nIUS1VxN5/Hz6wdrivIb/OjTycZsUqQPze6V9Vsnb5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo7EdoFgxn1RQV1/DTAvhQ6kvCTNkJGOmOktbREpVWo6SYYRg0jtDvCdadzpdxjYho/wZ0fQQ4AORMRW3Kg0TviQyHXOisC0oYNu9NdzNKcXXzI+VzMsr2bw3Xgs34HavevWnTBmW833dYUNrOp6zVmuKZ6zEpWfgnl6Zk1CZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqiTt5sK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0RcFeGf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 17:27:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741624032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFD536wMdTJ6LY0ss1eyMKKNPZmdrMoobxJp7aKL7vM=;
	b=sqiTt5sK2hynMcn8UYi9tmtrA0vM43uzctbjnNWIf+33TOuKYZU/MZ3xkcdNg7BpjE3Hu2
	9Bv4sQqFiEevtxRT7XdzdqfXXFnuemx22iGeOlg9Xr708zaWkGlg8RhmWuJaUqbzY81SbJ
	7lv/vk9XS5yCUM0r3QC07ZrgZcpr9FOY2HLcwrlAGG6J8b1JQtEJ0EcqkR1PvDLdxEGEzT
	yx0tmAPZTPiau36+qxJZWIZR9vxZ/JtGOKqtbjblIY8S+z4mnsQnw25b6VQBpKF1IyUFeU
	/P/mBIUIA41GqKo25vdbC8wyeJu167okJldR6+zfBTSB/mqAWpxWLCUhUYiD4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741624032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFD536wMdTJ6LY0ss1eyMKKNPZmdrMoobxJp7aKL7vM=;
	b=Z0RcFeGfIEhmUo83NL5oiaTAoSfHiGGean1r0+7Fo9+HDqeGFu4WdKZrHm29/vFEegqxTa
	jRVTzQtYdH0vv6CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250310162710.K9WY5tzN@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
 <20250305090237.2Q9GwRA1@linutronix.de>
 <20250310160102.GG19344@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310160102.GG19344@noisy.programming.kicks-ass.net>

On 2025-03-10 17:01:02 [+0100], Peter Zijlstra wrote:
> On Wed, Mar 05, 2025 at 10:02:37AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-03-04 15:58:39 [+0100], To Peter Zijlstra wrote:
> > > hash. That is why I had the `released' member.
> > 
> > The box was still alive this morning so it did survive >12h testing. I
> > would bring back the `released' member back unless you have other
> > preferences.
> 
> Like I just wrote in that other email; I'm a bit confused as to how this
> can happen. If rcuref_put() returns success, then the value is DEAD. It must
> then either be decremented below RELEASED or incremented past NOREF in
> order for rcuref_read() to no longer return 0.

We can't rely on 0 to be released as it might become active. We could
change rcuref_read() to return 0 if it could be obtained and -1 if it
can not.
We don't have many users atm so an audit should be quick.

> > Depending on those I could fold the fixes directly into the patches and
> > repost the whole thing or prepare you patches that can be folded back
> > and send those.
> 
> Please, it appears I don't have as much time as I would like :/

Sebastian

