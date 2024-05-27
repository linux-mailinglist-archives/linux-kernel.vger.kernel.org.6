Return-Path: <linux-kernel+bounces-191060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF748D0609
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1241C21893
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7063155CBE;
	Mon, 27 May 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjwFSv63";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jA2a5ozo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C4155C9C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823325; cv=none; b=oDy0rV12uX419K4HITVWzGubYXDdIFqmI9r2E5dtQKR56F/MIzEM7ErZg07zdQk1utsAX43TZA8i3YBI64EqEw5ymhrA5h1SCCBeAeWI/lInhbCDPOA7wMgjeb9duDnXtUfLfyTUbNK3SfKQ1rxljkr+OCWEF6NF0XTExTnpUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823325; c=relaxed/simple;
	bh=8yDqH1guaI1Q9x9D66JaZGPaSe5Jg0E5183vppqvvAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lns6PVtLgYXTeKCaNYXYRTkwrtFrlItySkALgeEdOPJT+NaJAdGaG5MpRQya3gq263A/ESSgawEtGvDlGscJbpk9fb+Sw8D3QZ8sHa7pQJi7NzUSZI4U3yDxMZeMl59OsJFwndKCUhXayXGHwgv9icvEYDDHncKNes009CbxCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjwFSv63; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jA2a5ozo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 17:22:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716823321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X66fRhEaG53HhvO210CrX2zRjnKUjNPhLSmLEZ6FadU=;
	b=mjwFSv63M3pL0o8AQPPlDwb8cNHWtiAvIlZve3Mh/KqQuyBDQwAHuCtdlblx2gmquFCIyb
	lC5JumC36i6HOxHdyzg4fce1zNV61N0qfXiGnrQk/+uOwcI8CPNsB1qCLusFMKIho/dY+t
	8utnUgpaDWDCFpCGJYVIhH6KWDCRp4rTjh9zs0NQ2pirSj6lSRxhNw/mwnQOSUURfBkfFW
	XWbmP+EJl+ql9fcfqIOo6zwk3LVPknnLLX4YGw7wStPxR5Lg5Z4GJChFIWJOkSLLD9ObZ9
	lj0NENyeiF4vbOjgn3onpvMKpNJZNjF/UjyusHP2zrpoUXf++8ReY9mPUQbBew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716823321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X66fRhEaG53HhvO210CrX2zRjnKUjNPhLSmLEZ6FadU=;
	b=jA2a5ozoRRwPXEkr59T06IohpNMxoHt93F3L5pfCvB1UME/7/9QBKakAIf1dyuGdx7V2Eo
	z70qVr1UVEY+fBBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Message-ID: <20240527152200.P1rU7FaG@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240420232505.2768428-1-shakeel.butt@linux.dev>

On 2024-04-20 16:25:05 [-0700], Shakeel Butt wrote:
> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
> and with always irq disabled. So, replace it with the irq disabled
> version and add an assert that irq is disabled in the caller.

unless PREEMPT_RT is enabled. In that case IRQs are not disabled as part
of local_lock_irqsave(&memcg_stock.stock_lock, =E2=80=A6) leading to:

| ------------[ cut here ]------------
| WARNING: CPU: 0 PID: 1 at mm/memcontrol.c:3150 __mod_objcg_mlstate+0xc2/0=
x110
| CPU: 0 PID: 1 Comm: systemd Not tainted 6.10.0-rc1-rt0+ #17
| Call Trace:
|  <TASK>
|  mod_objcg_state+0x2b3/0x320
|  __memcg_slab_post_alloc_hook+0x13c/0x340
|  kmem_cache_alloc_lru_noprof+0x2bd/0x2e0
|  alloc_inode+0x59/0xc0
|  iget_locked+0xf0/0x290

suggestions?

Sebastian

