Return-Path: <linux-kernel+bounces-323185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FED97391A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531ACB23863
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810B192D7B;
	Tue, 10 Sep 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eaGPx47v"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F718E11;
	Tue, 10 Sep 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976256; cv=none; b=FgWu4JHOcvQU12bJOhpmnaV4NoLFS86+JleCFDuNMm3sfkVrMmNQU2Cg24+Aj97wzo9kCQ+3TtMfXJN16FoviWNXLb+zM8uqhwqnf1KAfHt0K8RBxw6yKtJNxuU2uIt17k0ffDcO89tn1fjRKJl2SzZxzeBsJYW4EsHAm6ICgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976256; c=relaxed/simple;
	bh=dYhzfGqHXYEOx8MS6KvaDFYNnbAbgP5YUojlUAiEMAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QNBsbn6fTD4eKAvIAuYrf5ar7XPNckjxoUXNWdd/YtCUbwxgOIyuT+y5AYEd0EtqByFMwF7rpVjEuvcjjNciF8H1doiB0aTUayZDKvTDpZB/sXXGyvIgyOXMMaloUM7bCTzVqFQ8ZelgnpJBpMrb+SVleUhP01dAHSxQuOVqciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eaGPx47v; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D6931C2497;
	Tue, 10 Sep 2024 13:50:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D6B7C000D;
	Tue, 10 Sep 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725976238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKaZoEWr8UWtqcWAfis4JtnDRQPZMMSkWUHYpeNsgqY=;
	b=eaGPx47vgkkjXWUCMPhevbzMVrQx+6xiGAlWW1jjipJdpQiNhIsAiuyDC7TDz/BFoQFJSH
	5FbcGgVYB41zBYzcUmIxkZGyrp2FqyVK0tDTCtDBbCDAjYLpg2Ps1+zkVOAFEhNrPNpK9a
	knMtt3c6Emm6LpuHYQf0/QGK9NFH3Wlq52sL8/lmQcQbckzrh8F6/GPa/Xm6B0gff9i5AT
	Mbyt4rbAEzoyCHsCipRVb0jWL1KJvId5qvMHc1228PvJXjkN42P6o0VBwuywXW5Naq6D+X
	fJUQMEwVlEg38PNdi0PxJ8jCSHcDLiTY0LPBO76k2yZOlD0t39bv78NPLKdghA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 15:50:37 +0200
Message-Id: <D42NIH63EHZG.KKWZR2WZB68L@bootlin.com>
Subject: Re: [PATCH v5 09/12] xhci: introduce xhci->lost_power flag
Cc: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 "Kevin Hilman" <khilman@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Roger Quadros" <rogerq@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Peter Chen" <peter.chen@kernel.org>, "Pawel Laszczak"
 <pawell@cadence.com>, "Mathias Nyman" <mathias.nyman@intel.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-9-8664bfb032ac@bootlin.com>
 <1cd45625-84e4-43aa-ae2b-a59f10add898@kernel.org>
In-Reply-To: <1cd45625-84e4-43aa-ae2b-a59f10add898@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Mon Aug 5, 2024 at 3:41 PM CEST, Roger Quadros wrote:
> On 26/07/2024 21:17, Th=C3=A9o Lebrun wrote:
> > The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
> > expect a reset after resume. It is also used by some to enforce a XHCI
> > reset on resume (see needs-reset-on-resume DT prop).
> >=20
> > Some wrappers are unsure beforehands if they will reset. Add a mechanis=
m
> > to signal *at resume* if power has been lost. Parent devices can set
> > this flag, that defaults to the XHCI_RESET_ON_RESUME value.
> >=20
> > The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
> > controller. This is required as we do not know if a suspend will
> > trigger a reset, so the best guess is to avoid runtime PM.
> >=20
> > Reset the xhci->lost_power value each time in xhci_resume(), making it
> > safe for devices to only set lost_power on some resumes.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/host/xhci.c | 8 +++++++-
> >  drivers/usb/host/xhci.h | 6 ++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 0a8cf6c17f82..2c9b32d339f9 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1029,9 +1029,12 @@ int xhci_resume(struct xhci_hcd *xhci, pm_messag=
e_t msg)
> > =20
> >  	spin_lock_irq(&xhci->lock);
> > =20
> > -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken=
_suspend)
> > +	if (hibernated || xhci->lost_power || xhci->broken_suspend)
>
> Why not treat xhci->lost_power and xhci->quriks & XHCI_RESET_ON_RESUME in=
dependently?
>
> XHCI_RESET_ON_RESUME is sued by devices that know they always need to be =
reset on resume.
>
> xhci->lost_power is used by devices that don't have consistent behavior.

The goal is to avoid almost-duplicate functionality. I feel like:

    XHCI_RESET_ON_RESUME is the default value of xhci->lost_power,
    which might be modified at resume.

Is a more straight forward solution than:

    Both XHCI_RESET_ON_RESUME and xhci->lost_power define if power was
    lost at resume. First must be statically known, second can be
    updated during runtime. If second is used, first one must NOT be
    set.

Indeed, the first solution brings two additional lines of code as you
commented below. I'd argue the easier-to-wrap-your-head-around logic is
more important.

Tell me if you are convinced the second approach is better.

>
>
> >  		reinit_xhc =3D true;
> > =20
> > +	/* Reset to default value, parent devices might correct it at next re=
sume. */
> > +	xhci->lost_power =3D !!(xhci->quirks & XHCI_RESET_ON_RESUME);
> > +
>
> then you don't need to do this.

To be honest, I added this line out of rigor. We could remove it and say
that any device that modifies xhci->lost_power once at resume must set
it at each later resume.

The above line felt like a small safety net to avoid logic mistakes.

>
> >  	if (!reinit_xhc) {
> >  		/*
> >  		 * Some controllers might lose power during suspend, so wait
> > @@ -5228,6 +5231,9 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_=
quirks_t get_quirks)
> >  	if (get_quirks)
> >  		get_quirks(dev, xhci);
> > =20
> > +	/* Default value, that can be corrected at resume. */
> > +	xhci->lost_power =3D !!(xhci->quirks & XHCI_RESET_ON_RESUME);
> > +=20
>
> nor this.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


