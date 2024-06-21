Return-Path: <linux-kernel+bounces-225180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B419A912D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482FCB262A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E817A934;
	Fri, 21 Jun 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8bzyRZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2q37rOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9E13D521
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994560; cv=none; b=JeJjG71mz3UEtyx4dl8A/mONwpFBkg/znlp/LHKJ1BeLvc1vhODkGKZHBsZCWwD5xku9D5TAGvGoSTd5azBa5805JVCkSyjnh9pr6HK/JU+p/VB1PUfO++mKXDMq5mRFgMvD1knY77chF+RPZLrdy4fSFIJUlUf8DezO0h1Zj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994560; c=relaxed/simple;
	bh=4KGskPPyAVn0nAo6uvFxhKxBCeyYC7GufVGv3zrL3kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XASnArumQDfDvDPlsMQ/IVSpRmck9v0NK6uvsjsp+F24Iacc61D7284Mswpx1adncuj73zrT0TpFwTnzw+L5iQIPStd6r4iUC+ThjwTUS9O7UC/qQzf506ru96WcmwD3qEkpT7NtSC9Ru3tEzW0wI5KS8BjcbbM6p2kFR02659c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8bzyRZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2q37rOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 20:29:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718994557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KGskPPyAVn0nAo6uvFxhKxBCeyYC7GufVGv3zrL3kg=;
	b=A8bzyRZJp0xQschMmCBcH4JKf+w+uYAHOu0gkLZ1cR0g0nL+P8MYFGjlfj5aavYfot5xEU
	sxMnZ8ATkM7fNDF/9y8RltqqU+DiNKuhCPIFNcg4w1IeZTHKX+tViw210y1AKCk7nPwpEr
	rsdq2uuj5MQIw1ZK7tA1K/9lOyxW9Qc3AMngsBJy5bm5bScQGSLfnGicTzfdLIvDEoJAcy
	sdA+2uBIAOi67+kSJocf7pjLCk/DGAVvgJGbtECq6Bsld+Nn5ycLP+bYihIKDheSM4AUc/
	Bz+uHi1lu6UGMoPn0SXQbb6ElwE+HetOgybQk8X2yd4LLM9QgvEQus7h3LV9xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718994557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KGskPPyAVn0nAo6uvFxhKxBCeyYC7GufVGv3zrL3kg=;
	b=U2q37rOk6v0ItClWZOYeYjoE5YS5AdjSn5D0V7CEgc6wjPUz2IIXJGb3j/iQ21Cn5HUNpZ
	PiNuBpZs4SnvTyBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240621182915.S-ULWn0O@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>

On 2024-06-21 10:20:58 [-0400], Kent Overstreet wrote:
> On Fri, Jun 21, 2024 at 12:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> > The alloc_tag member has been added to task_struct at the very
> > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > padding after `ptrace' and then forcing another another 4 byte padding
> > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > due to struct sched_avg resulting in 52 hole before `se'.
> >=20
> > This is the case on 64bit-SMP architectures.
> > The 52 byte hole can be avoided by moving alloc_tag away where it
> > currently resides.
> >=20
> > Move alloc_tag to the end of task_struct. There is likely a hole before
> > `thread' due to its alignment requirement and the previous members are
> > likely to be already pointer-aligned.
>=20
> We sure we want it at the end? we do want it on a hot cacheline

Well, the front is bad.
Looking at pgalloc_tag_add() and its callers, there is no task_struct
touching. alloc_tag_save()/restore might be the critical one. This is
random code=E2=80=A6 Puh. So if the end is too cold, what about around the =
mm
pointer?
Other suggestions?

Sebastian

