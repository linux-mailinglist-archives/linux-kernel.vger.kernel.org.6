Return-Path: <linux-kernel+bounces-345368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C198B547
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481141C22D60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D371BC9E9;
	Tue,  1 Oct 2024 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U31qsXFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIrtdk5i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E83307B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767040; cv=none; b=rLnqLnhn/gARDuo0q2zfReQdTWESQb1tJCT+u8xpN3eg0+NtVwhrvaYQ8EN5KxmIWggYwKYYn7aHfZZxlXzRtnPEe/WHFN6OVggTxn3s3rqW2duL6JL/I+cibZ2Fdupa+eo3L3sdq1odF0aX3T0Cnk+yPJWUhHc96Zp0t0ohn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767040; c=relaxed/simple;
	bh=o6U00/4DKcqGapuVsQcX6/V+OCblxV9Yjq3xKBp48gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNxXEWP+8qyK8cl2PJ9A0V0fTqHjm5nB3EzeVNGc5tZwiUHz14OoJgVFOxMu/o0q/fRBmnbK6/jKkfSCT5F0k8LnV0LQ+txbrJ6+8qUyWdDmijH/dT8YMD4BP3gaXbR2eLE9pP+MglC9f5Sod92O3Bc2ipI23rP4FNL+JsJ7Szc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U31qsXFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIrtdk5i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 1 Oct 2024 09:17:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727767035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwPHt3mkb/aIvRq2IhhUHUGUS4GmGsb4LieIthsEsx4=;
	b=U31qsXFrMbNz2aLcbOvn0XRMAuwQ4r606JTihgg1iDAScYLW7rM7v+fj/bmx5YYWu1+LXb
	n4ZJ+xVoIxAGx6RGPOI3QOlMxEGROr/evMlO+5HXKs0fq8BhQezhU819vpzbM8TpNHR9fl
	KiOh4ecoh303X1dUSicx/ei+5NJZ3nO69l8MQA+oOv53c94ue1MeCqksHyYjr6qAEhI1s/
	fRUckfxnU9taMSCsFJmtq7o1qZQ0gPgnJPc4JA+B4kd6J9IzPvBqXdx3H9cHNEM2uXd3aX
	ZoqHos9zhyELFTD8Isp2FnRVjUf6/lgkqpCX8Yi44i7owZ2HoWO9l/zSdQj/zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727767035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwPHt3mkb/aIvRq2IhhUHUGUS4GmGsb4LieIthsEsx4=;
	b=ZIrtdk5ipldylIJkCVGoNKqDy2BUScABu/2bT5QTgqbm/EJRrpTmigjOjBejC1HzA+6mR1
	i+2/CpQD+Go3p9DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 0/4] locking/rt: Add sparse annotation PREEMPT_RT's
 locking.
Message-ID: <20241001071714.b41SSwDM@linutronix.de>
References: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812104200.2239232-1-bigeasy@linutronix.de>

On 2024-08-12 12:39:01 [+0200], To linux-kernel@vger.kernel.org wrote:
Hi,
> 
> the series adds sparse annotation to PREEMPT_RT's locking which
> substitutes spinlock_t and rwlock_t.
> The way local_lock_t is implemented, sparse annotation works for
> PREEMPT_RT due its spinlock_t usage but not for !PREEMPT_RT because it
> is just preempt_disable().

A friendly ping.

Sebastian

