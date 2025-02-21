Return-Path: <linux-kernel+bounces-526133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890FA3FA73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DC188C674
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524ED1F152C;
	Fri, 21 Feb 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGMiQKTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QC30oP9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD11215F7A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153648; cv=none; b=ulV6Z62jnPzfBq9vR6+LM3hOCTuH1OxdFWyMfZuDB+CYSo7vrcbE+2z9n1dwXxq46FBcntCA+oyTL35Y4hJa6ySunXuU4YXwGqHJvDzh2/pRq6RhJUouE3Pe2As0X6D5BXttNTCq2KcIWzyb2XcMHFQJ2/waVL5OqrVOPJgY1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153648; c=relaxed/simple;
	bh=2zTbKxGHEiAspH6EJGaqTGy63JhIyLJDPB/LxO7NUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5DYpZpQplFJPpERjjyBApjKWxIUtLltj+pbO2kh+4wR+bz1COqu/9cu/qimFkBdvwRgem7DXKGt0Hlrij9fbgUOcKA1ZVv8lt/8XZkS2rTgKvupKM6c0ko60DxOb2mAftdEfbVvcc3VFXybXCGCaqoF2OEp1ON6ZtJ6RQleGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGMiQKTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QC30oP9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 17:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740153645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B7BqszZcWHxZOM6domE+1Uvwd9XAB/lQ84MZ5hhjjFM=;
	b=NGMiQKTjA1p4Bun2dLNGiRM1RatTlHa1UcMzwB5ddvk+4dQZC6vChxKcebkQI4f13v8qW7
	SjdXKrUAQbYymfYMutbHMmzZrtIb9ygl7FRZP0j/L0g//LxEMbjVnONwXq59BVln3h8hMp
	Y/fqbhnINbrAqNqVqhW/IVKvER7WtHvBS1P14S0i2s7oytPQl5OyzlvjoQsth6dLz73LwR
	t4uaWWGf27WEZv+4mISXSM5ls9FBop509wxn+nXeX/l/x8bzbU6hSkfz2mH/UgL4ePW1y5
	W783cruxC1I1Ql/DUcEJArTPtwpqpBt3WRH7LAqYni962zfAJ5oltw6EqvydsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740153645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B7BqszZcWHxZOM6domE+1Uvwd9XAB/lQ84MZ5hhjjFM=;
	b=QC30oP9wVK5Lg+segfnVFRkGOgPqYPhZ8CJM5YMscfsnma0wKJaP5J2RemNhrs6aNCxU5q
	xT5GPoHCOVKPwUDw==
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
Subject: Re: [PATCH v8 00/15] futex: Add support task local hash maps.
Message-ID: <20250221160043.02H2_t3P@linutronix.de>
References: <20250203135935.440018-1-bigeasy@linutronix.de>
 <20250204151405.GW7145@noisy.programming.kicks-ass.net>
 <20250205122026.l6AQ2lf7@linutronix.de>
 <20250220151206.GB11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220151206.GB11590@noisy.programming.kicks-ass.net>

On 2025-02-20 16:12:06 [+0100], Peter Zijlstra wrote:
> I've split up the patch a little and stuck them here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=futex/scope 

futex_wait_setup() has an unused task argument (current is always used).

You solved the thing in lock_pi, I mentioned, by throwing in a
no_free_ptr() in the middle. Well that works, I assumed we wanted to
close the context somehow.

This should work. Let me zap that last argument in futex_wait_setup()
(confidently assuming I won't need it) and then rebase what I got so far
on top.

Sebastian

