Return-Path: <linux-kernel+bounces-357623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808A997367
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E21C2239C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610D1E285C;
	Wed,  9 Oct 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="idoToPjW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwR2683q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACD1E0E15
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495726; cv=none; b=VeZCe8FKKaMo65cE8UpRr/ArK5dOZYdsYIsGfglK/VoWoidxY539RA6kLIwchuupJUyOUEaMGOh6yMZgzv3tNP2FgvWpLRPDlRKVz65W0yOR8pH45j/MZ/jwvld/k0UAogtEYDq3qhnxbKqIt1QaiBMmR3NUL2fG2Ta7pBz/yIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495726; c=relaxed/simple;
	bh=Dq8dhkcUMwvocb1/PpnBKHelE6ztLVCrKvdQe0JKaZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFas830snAE22Xmk3KmebSjx5uJkjvK6zH7QhNguVtOwsiAW1//D+2AezIrNPT/x4iCqrvSjsDDHmY9HoeJN07kVh5twFM8hM+j4YJEXki8efA6Uq7prjLQ8uOdgWbsRA9wIzLKhqHeyg4AK0pN9MUYwWkJXPFuaMvlOZ8R0ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=idoToPjW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwR2683q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 19:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728495721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4NzPkzSamq4wPYIyI+V3fbrjzREE47+0T16MjDevhc=;
	b=idoToPjW9IIZDH/PieIO/xxWGI8o2a+8YKU9EqXIGvgD4bK9DJWpyIR91/icnaVlAVJ/cs
	hvy9Xf2eOZaFWG1V33MriNkIp6WfyRe4n2LD2agxMzks3JRrc135cJxP8HYXvndmwodjDL
	pQ8madiYCpyO19nV3/IFPWvojj8fRnzCWr9DAN6/1r5YoqDdSa7aumXTco8TBmNuqv5nDR
	agxiBOhRXz2P+XKKOsnhcbph9u7DNiO0gCcoiL4OSPPdrqZUoo0vwTx1p9lmjbkkfNlW1y
	ZidEgGlHPeLFPK5RfT+OlSeINWEaGpb5oH6xnetNXtYkyv0XgYlnoQ9ek08bEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728495721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4NzPkzSamq4wPYIyI+V3fbrjzREE47+0T16MjDevhc=;
	b=LwR2683q1ylEqzRdIPdSCiWK0i6OwtiwyUSJV+XPu9jSgQYG19E8HY0FpS4GTHltIOHTFP
	A3UfX/d5ECyPvfDg==
From: Nam Cao <namcao@linutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: bigeasy@linutronix.de, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
	aou@eecs.berkeley.edu, bp@alien8.de,
	Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
	dave.hansen@linux.intel.com, mingo@redhat.com,
	john.ogness@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
	pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
Message-ID: <20241009174153.Hk5MGakp@linutronix.de>
References: <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>
 <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>

On Wed, Oct 09, 2024 at 09:44:59AM -0700, Palmer Dabbelt wrote:
> On Fri, 06 Sep 2024 11:48:03 PDT (-0700), Palmer Dabbelt wrote:
> > On Fri, 06 Sep 2024 08:13:24 PDT (-0700), namcao@linutronix.de wrote:
> > > On Fri, Sep 06, 2024 at 12:59:06PM +0200, Sebastian Andrzej Siewior wrote:
> > > > It is really time.
> > > > 
> > > > riscv has all the required architecture related changes, that have been
> > > > identified over time, in order to enable PREEMPT_RT. With the recent
> > > > printk changes, the last known road block has been addressed.
> > > > 
> > > > Allow to enable PREEMPT_RT on riscv.
> > > > 
> > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > With the printk patches applied:
> > > 
> > > Tested-by: Nam Cao <namcao@linutronix.de> # Visionfive 2
> > 
> > 
> > Thanks.  LMK if you guys want me to take this through the RISC-V tree,
> > but no big deal if you want it somewhere else -- and if there's some
> > dependencies already going in through some sort of RT tree maybe that's
> > just easier.  So
> > 
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > 
> > I don't have a test setup yet, but I figure it's a new feature so I'll
> > just flip it on as a config post-rc1.  Presumably this just works in the
> > QEMU virt board, or is there some wizardry I'll need to copy?
> 
> and it breaks my boot test script.  Looks like it's actually working mostly
> fine, I'm just not getting the "reboot: System halted" message that I'm
> checking for to make sure the system actually went down cleanly.
> 
> I'm not sure if this is expected behavior in RT land, or if we've got some
> sort of bug.  It sort of smells like we're losing the last printk() line...

I also had some occasional problem with rebooting my Visionfive 2 board,
which was fixed with:
https://lore.kernel.org/lkml/20241003084152.2422969-1-namcao@linutronix.de/

Any chance this fixes your issue as well?

Best regards,
Nam

