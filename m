Return-Path: <linux-kernel+bounces-445127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C29F11B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FF0164E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912311E3791;
	Fri, 13 Dec 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MKOQFssY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B31E0B75;
	Fri, 13 Dec 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105830; cv=none; b=IFMkbSnKh9E0hkYsY1lBPBQvToRooDD+9AluSzADDmvZ1M9InG+HmCRUr2sEInPlrZcnxOhpzhxtcB9rkTD5r86laiNtBEG2Jm2z9dMWBKe0YmzzmCX/O2XhJCeSE3T8mQiW1AP9ZczwCMJSZU2sfnIzUTaGCUnLixxWrYyz3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105830; c=relaxed/simple;
	bh=9CUyDLEEMV5qyxKzXcyDb9Bk0pHXrY+UG4VcLupdXmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Drcgl5B6SD1OWW9lZP7XrqIi7BnjV2hxtND+feFWAvJzb4KuOnqINyalskhHnh9Q6xAGw+HMO4q4UWRytOlntbKpfwtQIDLz5iKw0ISTQAC26nrVjF6HVAI9oLJqPh8HstLIDEwt+aq6XUoCAArm9Y7nCw+sOvKxCYJnkUZ/CIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MKOQFssY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB21024000F;
	Fri, 13 Dec 2024 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734105819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9vZk0DTsI/bg+ANJhh1zU7eKOQQ40nhMEZ4aKgjFCA=;
	b=MKOQFssY1ZmRAEmIhvcApp8YueSah6mdUcNLSYxoBuMs9ZXqFGLOgfT7uso+rgcQ8OAMUg
	HmcJJW/qIeJGSqTLr/R49qSxhRrrLr5aMUx8dshXdXNc/WJSBGriQdEr6nAbblXcnBAyji
	w1zIZMS+kCvLUmFKrZ3FdRxcZNLM7Ioz4jscCgNlw9eMN40PYlmfEN1J/Du4L6A07WinzJ
	1U5HV1B3K/7uDzCJBQ/4EWs96vLLTwFCiQVqrwR+vCelah3VaGZ7NF//6arj8Eb+sQ8Hmz
	7X66HdHTLXqrP6n5is3838mDEg+PxzmTSzahvzJeDE3A3U3BP9soBqMke8pXCQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Dec 2024 17:03:38 +0100
Message-Id: <D6AP7JCNSME9.3FS7XCZJ37GM8@bootlin.com>
Subject: Re: [PATCH v6 4/5] xhci: introduce xhci->lost_power flag
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Roger Quadros" <rogerq@kernel.org>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mathias Nyman"
 <mathias.nyman@intel.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-4-28a17f9715a2@bootlin.com>
 <70aced7f-0311-43b9-96af-c8325c39ff2b@kernel.org>
In-Reply-To: <70aced7f-0311-43b9-96af-c8325c39ff2b@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Thu Dec 12, 2024 at 1:37 PM CET, Roger Quadros wrote:
> On 10/12/2024 19:13, Th=C3=A9o Lebrun wrote:
> > The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
> > expect a reset after resume. It is also used by some to enforce a XHCI
> > reset on resume (see needs-reset-on-resume DT prop).
> >=20
> > Some wrappers are unsure beforehands if they will reset. Add a mechanis=
m
> > to signal *at resume* if power has been lost. Parent devices can set
> > this flag, that defaults to false.
> >=20
> > The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
> > controller. This is required as we do not know if a suspend will
> > trigger a reset, so the best guess is to avoid runtime PM.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/host/xhci.c | 3 ++-
> >  drivers/usb/host/xhci.h | 6 ++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 5ebde8cae4fc44cdb997b0f61314e309bda56c0d..ae2c8daa206a87da24d58a6=
2b0a0485ebf68cdd6 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1017,7 +1017,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message=
_t msg)
> > =20
> >  	spin_lock_irq(&xhci->lock);
> > =20
> > -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken=
_suspend)
> > +	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME ||
> > +	    xhci->broken_suspend || xhci->lost_power)
> >  		reinit_xhc =3D true;
> > =20
> >  	if (!reinit_xhc) {
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 4914f0a10cff42dbc1448dcf7908534d582c848e..32526df75925989d40cbe7d=
59a187c945f498a30 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1645,6 +1645,12 @@ struct xhci_hcd {
> >  	unsigned		broken_suspend:1;
> >  	/* Indicates that omitting hcd is supported if root hub has no ports =
*/
> >  	unsigned		allow_single_roothub:1;
> > +	/*
> > +	 * Signal from upper stacks that we lost power during system-wide
> > +	 * suspend. Its default value is based on XHCI_RESET_ON_RESUME, meani=
ng
> > +	 * it is safe for wrappers to not modify lost_power at resume.
> > +	 */
> > +	unsigned                lost_power:1;
>
> I suppose this is private to XHCI driver and not legitimate to be accesse=
d
> by another driver after HCD is instantiated?

Yes it is private.

> Doesn't access to xhci_hcd need to be serialized via xhci->lock?

Good question. In theory maybe. In practice I don't see how
cdns_host_resume(), called by cdns_resume(), could clash with anything
else. I'll add that to be safe.

> Just curious, what happens if you don't include patch 4 and 5?
> Is USB functionality still broken for you?

No it works fine. Patches 4+5 are only there to avoid the below warning.
Logging "xHC error in resume" is a lie, so I want to avoid it.

> Doesn't XHCI driver detect that power was lost and issue a reset in any c=
ase
> via the below code
>
>         /* re-initialize the HC on Restore Error, or Host Controller Erro=
r */
>         if ((temp & (STS_SRE | STS_HCE)) &&
>             !(xhci->xhc_state & XHCI_STATE_REMOVING)) {
>                 reinit_xhc =3D true;
>                 if (!xhci->broken_suspend)
>                         xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x=
, Reinit\n", temp);
>         }
>
> >  	/* cached extended protocol port capabilities */
> >  	struct xhci_port_cap	*port_caps;
> >  	unsigned int		num_port_caps;
> >=20

I'll wait for your opinion on the [PATCH v6 2/5] email thread before
sending a new revision.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


