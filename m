Return-Path: <linux-kernel+bounces-192619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A208D1FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8511B1F2434D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFD171660;
	Tue, 28 May 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSipuzVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGpR9+PY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14682171643
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908946; cv=none; b=BbruN2VuKljeb47VDJaCNvO7CRXryaM5FAlcdVvQfjHnmSWDKYAJ38O8FTuzwC5e7/U6xcXKcjCSOlZ0wO3U6qS8dtJf8CB6W2QTejcCmgt68syCTLVtnpnRLUeRlqlre1oH9ZZcEjZ4tTPFPbzsjgHtYogV/4Zq2n7228+k6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908946; c=relaxed/simple;
	bh=Z/6iY5aPorPuPiA1JrVusuywGqYQJMJRO0cBMjmbbag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOxHAqu7tyX8UM6R8CjwaGkBZJ4UUo3orkN3k0tUVn4HPkBMwdlZQdO02qYBoTGvI02F6K2fE7ImCCzLqu+Q+t3rgXB/40vUAqhKw8zHqKwE2LrujfHN2z3avraxo0TmZRzjKa0OH3nB1HRprFZzzVdXBY8NWGbUzmB2O67H7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSipuzVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wGpR9+PY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 17:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716908937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P48KJGTArLH6kgQrKn8ymy/o3CVNJ+TGFjmrkgVpgSM=;
	b=HSipuzVzdq1tErQh6KB0HH8CO5WEx5w9dsM3H0Kn4nwQLhDjkaSdUYZu9LefKpCEqoGLeF
	7mBUqMkiasBFiH8dYhVgCmi6aGfOxrpmlz6ZZqO78XU5SFaCgxK6OczZOcWwlil1Do35/5
	iagbre8hh0TEairibM0xQjY2w9YrrRv5nrtSZLo1n52HEzKmZ2PvZvqlecFCjTOK1prN17
	WRnBovQiCRAq7SbuEoRi3byU4t/5kHdSMZMC3MIxWPCK6PnSj2+hG446NJNn+u9aW43T5+
	Rhhmrvx28TiZzFtoIbdlayQyTwaMxdyITv5ti8XlUvaNVDGYaxZ5g2k6Cbl3AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716908937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P48KJGTArLH6kgQrKn8ymy/o3CVNJ+TGFjmrkgVpgSM=;
	b=wGpR9+PYb2nKbg3mNFFgI59xNVSjFbua4gaC27YVtSyBMnqD2XNEqI6jkPQxfIFVjDd3U5
	OfjGMwdXgcfg9TDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <20240528150856.u4rArjaq@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
 <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>

On 2024-05-28 07:59:57 [-0700], Shakeel Butt wrote:
> One question on VM_WARN_ON_IRQS_ENABLED() in __mod_memcg_lruvec_state().
> On a PREEMPT_RT kernel with CONFIG_DEBUG_VM, will that
> VM_WARN_ON_IRQS_ENABLED() cause a splat or VM_WARN_ON_IRQS_ENABLED is
> special on PREEMPT_RT kernels?

we have the following in the header file:

| #ifdef CONFIG_DEBUG_VM_IRQSOFF
| #define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
| #else
| #define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
| #endif

and this in Kconfig:
| config DEBUG_VM_IRQSOFF
|         def_bool DEBUG_VM && !PREEMPT_RT
|

which means on PREEMPT_RT we end up with "do {=E2=80=A6"

Sebastian

