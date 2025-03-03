Return-Path: <linux-kernel+bounces-541903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282CA4C337
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE23188832A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81172144C9;
	Mon,  3 Mar 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ny2zrCp7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKDcZZdI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D492144B8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011481; cv=none; b=n4u0cHI6PZ3ymr3N4d1sf96oFqL3LriT6WYYcGbcxovm1P3OBHmPHYuWLY8xOkyBpWQk0gfu6/3PxHsokobZHAIo+rIe1Veil6SiZ4czdCFbrLiSY6GkI3Y8BY2RW55eD+zq+mjqFoMy8qDXCyujLSLSLCKzQwnnflFd7NjVC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011481; c=relaxed/simple;
	bh=Y/tah3lwJHklvOomI3au8jFkhL1LkY+gA4imGZ/+IlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STErkfCzg6VjnxavprSF2xWrPYbKyVtXu05Px4xxBbG+0LGZs7AfdkjmdanP818J+OASoDuQ9mRoJ+09XmEmjWZkDHsHhvR5C1hqlK2r5Hj4Crfa45PBL729yikYLOcu/6TAs/t1PRQGRicfL+R+0aLY2qx+IZhgPPoMJFna3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ny2zrCp7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKDcZZdI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Mar 2025 15:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741011475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7MU3MKr4C6HE4XbgANOIV7c7IQVRNqmiefLfOocz/g=;
	b=Ny2zrCp7jTRbIisAW0PLMuCRO5AMWxt4etXtYQohiA/45tUAq/15nDOc5WgT1cC5QI7gpr
	Z/h21aCsw+gzblHsuGuvEKOP79f2XX4FSfGObccQ3tJ9yZl8tyuQTmDGG4CDtbGOPjMHwD
	auQzNoj/hElbMGi1NAzq73sH8CdzSAa/wZ375aOmxRBlEzYy6FeLMR7rxOIO898LAOf0oe
	TPdgd9Rgbyp8jerGevtVIjaYB8pVYVC8+HZcAjnYqJas24nXU5f7/s6Nvytu1Dh5dEA8ZO
	zLM4Vl9Ubs09b1kN0O4WkehFe3UZdB2wUtevH4MalhuCOfZuLnFLdgsPfMt65g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741011475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7MU3MKr4C6HE4XbgANOIV7c7IQVRNqmiefLfOocz/g=;
	b=kKDcZZdIoiJ6oHPWnhEUBLGLb6xBYwy0TWO4lPXNrbp0Tz1RQYvXPCfqWKvBffY6RIKiST
	DdXI2KnaomP4t3DQ==
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
Message-ID: <20250303141753.tF-FoCm1@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303105416.GY11590@noisy.programming.kicks-ass.net>

On 2025-03-03 11:54:16 [+0100], Peter Zijlstra wrote:
> Right, I've been going over this and been poking at the patches for the
> past few days, and I'm not quite sure where to start.
>=20
> There's a bunch of simple things, that can be trivially fixed, but
> there's also some more fundamental things.
>=20
> I've written a pile of patches on top of this while playing around with
> things. The latest pile sits in:
>=20
>   queue/locking/futex
>=20
> I'm not sure I should post the patches as a reply to this email (I can,
> if people want), but let me try and summarize what I did and why.
>=20
>=20
> Primarily, the reason I started poking at it is that I think the prctl()
> as implemented is completely useless. Notably its effect is entirely
> ephemeral, one pthread_create() call can re-size the hash, destroying
> the user requested size. Also, I still feel one should be able to set
> the hash size to 0 and have it revert to global hash.
>=20
> Finally prctl() should not return until the rehash is complete.
>=20
> I think my implementation now does all that -- but I've not tested it
> yet -- I've to write a prctl() testcase and it was too nice outside :-)

I kept prctl() mostly around for testing with a few hacks to be able to
always resize it, even if the size is the same/ smaller. tglx to have it
only increasing. However, let me take this and do some testing.

=E2=80=A6
> Anyway, the entire stack builds and boots, but is otherwise very much
> untested.
>=20
> WDYT?

well. Let take a look and do a bit of hammering.

Sebastian

