Return-Path: <linux-kernel+bounces-541511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B0A4BDB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A1189443D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515B1F3B8B;
	Mon,  3 Mar 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY3Bcvwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weIS7mWu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE141F37C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000098; cv=none; b=VmYMIk7c/cISAhXuVXZuM5+Z+xE76T7s+BwKGTKCNQBfuAjB1WmZFyFWXrZVlZNUyZIA1KGEcoI03ftfPH6x4JyMlVdmPFf9pTsWMtprPKmfQDuvARPDQJGRF2qexS7FC8WIYyDCsyYnrAuiJcZfLcFWd5oiM4lF4zVK0W9Cr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000098; c=relaxed/simple;
	bh=sB62K8wzOoMq7iYIPZzQzh73bdFdBfG2WSbcYg3oeVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc/h0fBJOzm2gxz+9+g4uclDyPYWHq+T1PetUWofsfiPeRrCuGJoFp7i4oxHqORkiA/z2Bn06xOsOyeR9VpfCAlrs8e0M0sxibkb3Skc9xqJhAPO1NG1dZsAICcwT9fGs1sBBbcyuaF9ZYr/txFMYKnY9EmzoVGulHbWZxjQt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY3Bcvwq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weIS7mWu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Mar 2025 12:08:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1D+CnraKUZCvWBX2D//PKQHKSwg0AKuuuoMcb0rgws=;
	b=WY3BcvwqJfY3+izuTEss/XpsgEDHLEaBomUNon3BENJfcWrR9vFNFyQh+HE0Ng0LU3VJOV
	cLOhtw/pgT7QEX5+3fnLR+WZEgEEcg3m057qcuRhitc8b9EcjiVXxSGEPipOy8QaGULV1n
	FMbP+++SB7bbOd7OkE0/sSp4nfRb0wC4D7ObJZEGhDxnn4HFPIo8zIjBr/GQxQbrg2xuvt
	5WE3Frj635yzpVKORmTTpXTuUOjDnfpWeDu2kxbXbUTDFlKe+gziyLP4TogcUvzKudOl5W
	3x7WOYHzmQj0qAjeL1jcBmDr20VHXPT/KIhn4zIP8CiDsVlxRfYPzTlnFhKPRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1D+CnraKUZCvWBX2D//PKQHKSwg0AKuuuoMcb0rgws=;
	b=weIS7mWuYbNKbYzEpacOGd7w6cmMf55sMrM4/Mj2I5nQ/q7V+crriNXkCP2mUClA/2cbkK
	328REvnkCOCCwFDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't use %pK through printk
Message-ID: <20250303115007-beb39d5b-71f5-458a-82fe-9e82c9ab720e@linutronix.de>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de>
 <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu>
 <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk>
 <20250225091250-eac544ad-4e5b-47f7-83fc-5212c720483a@linutronix.de>
 <alpine.DEB.2.21.2502251654370.65342@angie.orcam.me.uk>
 <20250226105757-e935ee3e-f70d-4e0e-83bb-61307722a186@linutronix.de>
 <alpine.DEB.2.21.2502281957310.12637@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2502281957310.12637@angie.orcam.me.uk>

On Fri, Feb 28, 2025 at 08:15:02PM +0000, Maciej W. Rozycki wrote:
> On Wed, 26 Feb 2025, Thomas Weißschuh wrote:
> 
> > > > By default, when kptr_restrict is set to 0, %pK behaves the same as %p.
> > > > The same happened for a bunch of other architectures and nobody seems
> > > > to have noticed in the past.
> > > > The symbol-relative pointers or pointer formats designed for backtraces,
> > > > as notes by Christophe, seem to be enough.
> > > 
> > >  I do hope so.
> > 
> > As mentioned before, personally I am fine with using %px here.
> 
>  Glad to hear!
> 
> > The values are in the register dumps anyways and security sensitive deployments
> > will panic on WARN(), making the information disclosure useless.
> 
>  And even more so, I wasn't aware of this feature.  But this code doesn't 
> make use of the WARN() facility, it just prints at the heightened KERN_ERR 
> priority.

Indeed, I got confused with some other patches where WARN() is used mostly.
This makes it a bit murkier.

> > > > But personally I'm also fine with using %px, as my goal is to remove the
> > > > error-prone and confusing %pK.
> > > 
> > >  It's clear that `%pK' was meant to restrict access to /proc files and the 
> > > like that may be accessible by unprivileged users:
> > 
> > Then let's stop abusing it. For something that is clear, it is
> > misunderstood very often.
> 
>  Absolutely, I haven't questioned the removal of `%pK', but the switch to 
> `%p' rather than `%px' specifically for this single hunk of your patch.

Sure. It would be great if one of the maintainers could confirm this preference.

> > > "
> > > kptr_restrict
> > > =============
> > > 
> > > This toggle indicates whether restrictions are placed on
> > > exposing kernel addresses via ``/proc`` and other interfaces.
> > > "
> > > 
> > > and not the kernel log, the information in which may come from rare events 
> > > that are difficult to trigger and hard to recover via other means.  Sigh. 
> > > Once you've got access to the kernel log, you may as well wipe the system 
> > > or do any other harm you might like.
> > 
> > As I understand it, both the security and printk maintainers don't want the
> > kernel log in general to be security sensitive and restricted.
> > My goal here is not to push site-specific policy into the kernel but make life
> > easier for kernel developers by removing the confusing and error-prone %pK
> > altogether.
> 
>  Let me ask a different question then: is your approach to bulk-switch all 
> instances of `%pK' to `%p' as the safe default and let other people figure 
> out afterwards whether a different conversion specifier ought to be used 
> instead on a case-by-case basis and then follow up with another patch, or 
> will you consider these alternatives right away?

I am considering on a case-by-case basis. But mostly the decision is that %p is
enough, because by default %pK has been the same as %p anyways.
Also the current wave of replacements does not touch valid users of %pK.
They will stay and later be replaced with a new and better API.

> > Security is only one aspect.
> 
>  I think it's important enough though for us to ensure we don't compromise 
> it by chance.

Agreed.

