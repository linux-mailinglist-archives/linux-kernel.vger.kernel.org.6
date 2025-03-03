Return-Path: <linux-kernel+bounces-545227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE7A4EB54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A377F8C63CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED22980A7;
	Tue,  4 Mar 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY3Bcvwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weIS7mWu"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186424C089
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110024; cv=fail; b=qkPPg57XxXB9kByT4XLY+RXjBpcj+p8TeKCYyOzyx4w34t1yXhm6EgrO+2uBCg5O2js2nBO8pOf2ggi83uVa7egWBPD32RTtlM8SJPEFcPbNrkZvx7KLv800QS6D934VOMdxjNfqc+bdkn9cpu6RpnidVDThWNJVct6+N8a2EMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110024; c=relaxed/simple;
	bh=iJT3Z7BK5OQVZ/ql/mi8ZIHEITXLoosb+AhRIs7vzt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0rKXWjtsM5esU+S91EIpf2XcUnBqzh3WTzA8JEBFwpuzphciRWEJB5nvS/BTLK44602UkjbuEGMrEmV2Mg2t0/EHsZtyOp0ks7dLARfiLP+grVZ0hekcOPJMhv8WYg4ofDyf+DVYyoc0Jyi6JQgNHGMhGhiiGekacjp2HmITmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY3Bcvwq reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weIS7mWu; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id F063840D1F53
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:40:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fnN3myczG0Xp
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:32:24 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 581704273F; Tue,  4 Mar 2025 18:32:09 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY3Bcvwq;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weIS7mWu
X-Envelope-From: <linux-kernel+bounces-541511-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY3Bcvwq;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weIS7mWu
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 7AEB941B2E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:11:16 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id B317D2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:11:15 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D2E7A3A4B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655A1F4C8A;
	Mon,  3 Mar 2025 11:08:21 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2502281957310.12637@angie.orcam.me.uk>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fnN3myczG0Xp
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714716.44834@C58mo4HyuhCi7FtUN965AA
X-ITU-MailScanner-SpamCheck: not spam

On Fri, Feb 28, 2025 at 08:15:02PM +0000, Maciej W. Rozycki wrote:
> On Wed, 26 Feb 2025, Thomas Wei=DFschuh wrote:
>=20
> > > > By default, when kptr_restrict is set to 0, %pK behaves the same =
as %p.
> > > > The same happened for a bunch of other architectures and nobody s=
eems
> > > > to have noticed in the past.
> > > > The symbol-relative pointers or pointer formats designed for back=
traces,
> > > > as notes by Christophe, seem to be enough.
> > >=20
> > >  I do hope so.
> >=20
> > As mentioned before, personally I am fine with using %px here.
>=20
>  Glad to hear!
>=20
> > The values are in the register dumps anyways and security sensitive d=
eployments
> > will panic on WARN(), making the information disclosure useless.
>=20
>  And even more so, I wasn't aware of this feature.  But this code doesn=
't=20
> make use of the WARN() facility, it just prints at the heightened KERN_=
ERR=20
> priority.

Indeed, I got confused with some other patches where WARN() is used mostl=
y.
This makes it a bit murkier.

> > > > But personally I'm also fine with using %px, as my goal is to rem=
ove the
> > > > error-prone and confusing %pK.
> > >=20
> > >  It's clear that `%pK' was meant to restrict access to /proc files =
and the=20
> > > like that may be accessible by unprivileged users:
> >=20
> > Then let's stop abusing it. For something that is clear, it is
> > misunderstood very often.
>=20
>  Absolutely, I haven't questioned the removal of `%pK', but the switch =
to=20
> `%p' rather than `%px' specifically for this single hunk of your patch.

Sure. It would be great if one of the maintainers could confirm this pref=
erence.

> > > "
> > > kptr_restrict
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > This toggle indicates whether restrictions are placed on
> > > exposing kernel addresses via ``/proc`` and other interfaces.
> > > "
> > >=20
> > > and not the kernel log, the information in which may come from rare=
 events=20
> > > that are difficult to trigger and hard to recover via other means. =
 Sigh.=20
> > > Once you've got access to the kernel log, you may as well wipe the =
system=20
> > > or do any other harm you might like.
> >=20
> > As I understand it, both the security and printk maintainers don't wa=
nt the
> > kernel log in general to be security sensitive and restricted.
> > My goal here is not to push site-specific policy into the kernel but =
make life
> > easier for kernel developers by removing the confusing and error-pron=
e %pK
> > altogether.
>=20
>  Let me ask a different question then: is your approach to bulk-switch =
all=20
> instances of `%pK' to `%p' as the safe default and let other people fig=
ure=20
> out afterwards whether a different conversion specifier ought to be use=
d=20
> instead on a case-by-case basis and then follow up with another patch, =
or=20
> will you consider these alternatives right away?

I am considering on a case-by-case basis. But mostly the decision is that=
 %p is
enough, because by default %pK has been the same as %p anyways.
Also the current wave of replacements does not touch valid users of %pK.
They will stay and later be replaced with a new and better API.

> > Security is only one aspect.
>=20
>  I think it's important enough though for us to ensure we don't comprom=
ise=20
> it by chance.

Agreed.


