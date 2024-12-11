Return-Path: <linux-kernel+bounces-441387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1FE9ECDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69DA2819B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7C230274;
	Wed, 11 Dec 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGQcZ/uG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGWJ1/QJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F422913A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924897; cv=none; b=sNDIAx157smpndTbARM+iOQeHU3yuEEQ2h1XXj8sB31x5qCUtqcyKLbuX2GThAAbhT0wgSLEwvjm2nMXgHqDVd9GnHGvGWJe33apU5PrC65g4Ds2XzIjPHJw7UicXs1nUbAChWPP/fa45Wskwq/WzgesLvR1/EM79XxLPJDbevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924897; c=relaxed/simple;
	bh=FcEdyf32adcRhq16rtWJRAyApwazxa43Y8h9mC5uJpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C86ujJDwCZPY9bs7GNUhPHeHopFEooiEM2bq3HIeftKnEF+oMb9kmTMYf7UanTJikUeJW0jteh1qh3krZJxVGtYXWLMNjV7zZZ57WasGSw0NbRGaJ6LyHi89E91JQltXIXQtUiciVu9gw8VtG6KgHg37tIcm5ku1QqkuCsMtC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGQcZ/uG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGWJ1/QJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Dec 2024 14:48:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733924892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcEdyf32adcRhq16rtWJRAyApwazxa43Y8h9mC5uJpw=;
	b=ZGQcZ/uGgidddEs3TRPAx70QGE3OqHBArWQm7LVbRXrH5zIpemuLwluP9BPgjfarNJE6VR
	Gzxooaltlx1/u2IwRGJO52dzZGQwj0Ms2OoAuQZeeX6AsBBjyW4/AgU4NjBafj+cf7S7MY
	7Kh7/ZXdSTtRZ9uwX2i5YMsGj5j1JibsBKKZARQOkXdYifAlL+gcPRAUkrCwGkAguD3FgN
	ANx019KPS3XZArgZhr3v/7ngtE8B9Cc7QwNjjcZvBmIPyHDw2avGieG0NAQLcUKLk0Uysk
	7R0CR9ju70YGRTU51uj7HfXwOINQR09eq8hBMjZUhn6CWSmFpL50yoneP/aARw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733924892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcEdyf32adcRhq16rtWJRAyApwazxa43Y8h9mC5uJpw=;
	b=uGWJ1/QJNPCk1yC0pohHZHR/KTLJ5f/gqbruvx+vLUe+FfiAu8MBPugFmO1OS8sANofSdq
	tSQ1JxBa0i/sKKAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Message-ID: <20241211134811.wM_UADhQ@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241210160556.2341497-3-arnd@kernel.org>

On 2024-12-10 17:05:54 [+0100], Arnd Bergmann wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> gup_pgd_range() is invoked with disabled interrupts and invokes
> __kmap_local_page_prot() via pte_offset_map(), gup_p4d_range().

s@gup_pgd_range@gup_fast_pgd_range@
s@gup_p4d_range@gup_fast_p4d_range@

The functions got renamed=E2=80=A6

> With HIGHPTE enabled, __kmap_local_page_prot() invokes kmap_high_get()
> which uses a spinlock_t via lock_kmap_any(). This leads to an
> sleeping-while-atomic error on PREEMPT_RT because spinlock_t becomes a
> sleeping lock and must not be acquired in atomic context.
>=20
> The loop in map_new_virtual() uses wait_queue_head_t for wake up which
> also is using a spinlock_t.
>=20
> Since HIGHPTE is rarely needed at all, turn it off for PREEMPT_RT
> to allow the use of get_user_pages_fast().
>=20
> [arnd: rework patch to turn off HIGHPTE instead of HAVE_PAST_GUP]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This version works, too. Thanks.

> ---
> There is an open question about whether HIGHPTE is still needed
> at all, given how rare 32-bit machines with more than 4GB
> are on any architecture. If we instead decide to remove HIGHPTE
> altogether, this patch is no longer needed.

HIGHPTE isn't much about 4GiB+ but about the page-table which is
offloaded to HIGHMEM. Maybe it is more likely to be needed with 4GiB+ of
memory. No idea. X86 had support for up to 64GiB of memory and is the
only architecture supporting HIGHPTE :)

I guess if you have boxes with 4GiB+ and can proof that the performance
improves without HIGHPTE (since you don't have to map the page table).
The question is then how much of low mem has to be used instead and when
does it start to hurt.

Sebastian

