Return-Path: <linux-kernel+bounces-533512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C530A45B86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBE23AF7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C42459D7;
	Wed, 26 Feb 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwyunGtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/YExrf3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E30191F88
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564914; cv=none; b=i/FIcCx2eqlaHWDTbEUrzqPd0jFLRGf/srpbTKD1kmnEog8KuB1hXmnaOTO8ivnCKv5kXTknXAdk6bJLtVLV4npAZt41WyJSaUzZZ40Ogf2HbbRkYUA+VVGKnS+JdIJGb1SwH1HU/a/p4B8PRehoZlU/M7bJk7eY/slETmLOkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564914; c=relaxed/simple;
	bh=VliJvLOuyXQTOYYkSGnDCSTNfPCoJUgmdPKgZznEy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePlHdxzU8DnxwOq9Ee5Jmk1YXPfuf4fmF8MDwJS6sag5ZVrOwv2w1WV14ndTfWEuLpbSuSGgQlxIZ94WLIV7khUjZbgJS420qED4jIgxH9+DI+d75WrojL5SD8zxlGQzO8ly69xDvgaxiBpI4HVgItK+Wi1VFuRtcCALPEvgYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwyunGtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/YExrf3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:15:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740564911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MVpIWlVP4LUlyOlJvD8fkfJgxbO3epYN/LpGvKk6ss=;
	b=MwyunGtJvojTScCpLwMD4KKFfj3on6OBGZ869NwjluSTeOqDXbAS5+8+D23GF/Gdq9v3qG
	yakT8xYABGtvLh8nEspKTwaPswzYOcwYMNirCfLBJISvDJR96mKLlWobjGTUn/muw3QikO
	PS5Mt7NqFcUQCoaIZq4DkfDdgVGgSx1/OhyAbzWi3V8beO/XV7iOupoN5WAwOts5y1mu5t
	HkdQqpmSxHEM9/vbaWFceU0Rfite8LqCSD3F633v15kZlaEUYUP5WqMjx7IWlugSt56tf8
	8tA0+H8zmeVZtjpt71UxSaHD9bw6iUvIVMJIBf+ghVIGkB5Ya6FaxQpFMx4vsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740564911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MVpIWlVP4LUlyOlJvD8fkfJgxbO3epYN/LpGvKk6ss=;
	b=r/YExrf3pYyrwyEyG2J/TjI1y19YOlLdoGPmng0Ox1yUycYXAw3e4nuKIwCV4Ivimb6PDi
	eMDaSzzSlKDhanDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't use %pK through printk
Message-ID: <20250226105757-e935ee3e-f70d-4e0e-83bb-61307722a186@linutronix.de>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de>
 <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu>
 <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk>
 <20250225091250-eac544ad-4e5b-47f7-83fc-5212c720483a@linutronix.de>
 <alpine.DEB.2.21.2502251654370.65342@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2502251654370.65342@angie.orcam.me.uk>

On Tue, Feb 25, 2025 at 05:32:12PM +0000, Maciej W. Rozycki wrote:
> On Tue, 25 Feb 2025, Thomas Weißschuh wrote:
> 
> > > was suddenly lost from the kernel log, the access to which unprivileged 
> > > users can be denied if so desired according to the site policy.  Whereas 
> > > running the kernel such as to have all output from plain `%p' exposed just 
> > > to cope with this proposed change, now that seems like a security risk.
> > 
> > Your point makes sense.
> > *But* the addresses in your example are already hashed,
> > as indicated by the all-zero upper 32 bits.
> 
>  Darn it!

Agreed.

> > By default, when kptr_restrict is set to 0, %pK behaves the same as %p.
> > The same happened for a bunch of other architectures and nobody seems
> > to have noticed in the past.
> > The symbol-relative pointers or pointer formats designed for backtraces,
> > as notes by Christophe, seem to be enough.
> 
>  I do hope so.

As mentioned before, personally I am fine with using %px here.
The values are in the register dumps anyways and security sensitive deployments
will panic on WARN(), making the information disclosure useless.

> > But personally I'm also fine with using %px, as my goal is to remove the
> > error-prone and confusing %pK.
> 
>  It's clear that `%pK' was meant to restrict access to /proc files and the 
> like that may be accessible by unprivileged users:

Then let's stop abusing it. For something that is clear, it is
misunderstood very often.

> "
> kptr_restrict
> =============
> 
> This toggle indicates whether restrictions are placed on
> exposing kernel addresses via ``/proc`` and other interfaces.
> "
> 
> and not the kernel log, the information in which may come from rare events 
> that are difficult to trigger and hard to recover via other means.  Sigh. 
> Once you've got access to the kernel log, you may as well wipe the system 
> or do any other harm you might like.

As I understand it, both the security and printk maintainers don't want the
kernel log in general to be security sensitive and restricted.
My goal here is not to push site-specific policy into the kernel but make life
easier for kernel developers by removing the confusing and error-prone %pK
altogether.
Security is only one aspect.


Thomas

