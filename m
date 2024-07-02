Return-Path: <linux-kernel+bounces-238085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726EC924334
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301AB28D09B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AD1BD02E;
	Tue,  2 Jul 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lyXAp1ML"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6915218A;
	Tue,  2 Jul 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936410; cv=none; b=XKky3jWgRIZN4KThAp5h2+Ue5QihALLVFdfq5tTU8l7Gs+3FC10rJmCjIY+W8qM1iEW0noXWT221L2CtNweoBDxmyGWWgsyt0WyOE4g9rLdbCPQ3AJn6yMEYQik6NEwLkxJQvwezPtWOhbCOEzkPMcFVN/IYfqmEZjmefyFRedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936410; c=relaxed/simple;
	bh=2COgCSUa3zORMm0SV/qu+bVvJrlj3rEJdBLczCkYGCs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=P2Ms86xfCC4sUpUIIAPySOhOCmeQPLGeIgKtRwgkSP2z7fGYEGmbi5rJPjKDV41RApsE3HxNWrUGu3JN+kf8KUG4mxiAB/KiH1ruNc/OjDDOkMofS+KrO/N5KVjMeLwVXeHiN9YQfmJ/zL7Z/IYf6FKAylOPSuLfnp9Wb6O1l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lyXAp1ML; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E08DC1C000C;
	Tue,  2 Jul 2024 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719936406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3M1Jm/V1rIBa+qIxaSYsQiMZl7q8DuReOIHyHzdUtY=;
	b=lyXAp1MLIyjUWsGHxISJyf4VUTkZ0G4vuBxhaFEfCApEv3dgNriMMNW1JCPMCTsfyH9v/Q
	uiMjOp8qSPNr0BOMAOnYs90eSvVuNqFqUuxGwCFCMrxT+7GcO+HRdQ5LdUvTvIw5EgVCau
	Q7PRXYFB2+SHZm3xXjeqEJRvrAdAcumDSqz6baeNWsJMC7eM/Xjq2BWnDTzQS+rEY1LLUy
	mfv/FBGJnOVnAuDKZWbPELn3s87/lL6lxMN6W0Osf8dr6NGcw+fD0OhniI4GmxHpvV6dKG
	ZdR+YZGo4r4YMNfMsxxh52mGw9pkelj1zEmukn5TqHmXTan4O7ZfZgA79W7DuQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 18:06:45 +0200
Message-Id: <D2F6KKV208I2.GMP386BWZ9QE@bootlin.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 2/2] reset: eyeq: add platform driver
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.17.0
References: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
 <20240628-mbly-reset-v1-2-2a8294fd4392@bootlin.com>
 <e9bfd8087ddef3d66f437719530df54a1f6529a4.camel@pengutronix.de>
 <D2EC7KK40YX5.C3G1SM3FEDJO@bootlin.com>
 <3fe74a3fc2747c8f9a3f433352720cfed76918ba.camel@pengutronix.de>
In-Reply-To: <3fe74a3fc2747c8f9a3f433352720cfed76918ba.camel@pengutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Philipp,

On Tue Jul 2, 2024 at 11:19 AM CEST, Philipp Zabel wrote:
> On Mo, 2024-07-01 at 18:19 +0200, Th=C3=A9o Lebrun wrote:
[...]
> > > > +#define rcdev_to_priv(rcdev) container_of(rcdev, struct eqr_privat=
e, rcdev)
> > >=20
> > > Please use checkpatch --strict, and ideally mention when you ignore a
> > > warning on purpose. In this case, the macro parameter should named
> > > something else, because the last parameter to container_of must be
> > > "rcdev" verbatim. This only works by accident because the passed
> > > parameter also happens to be called called "rcdev" at all call sites.
>
> Thinking about this again, it would be even better to turn this into a
> static inline function instead.

I thought about it but checking drivers/pinctrl/ it looked like macros
were more common for container_of() encapsulation. I'll go the static
inline function. Plain, simple:

static inline struct eqr_private *eqr_rcdev_to_priv(struct reset_controller=
_dev *x)
{
	return container_of(x, struct eqr_private, rcdev);
}

>
> > I have let this CHECK from `checkpatch --strict` slip through indeed.
> > Other remaining messages, with explanations, are:
> >=20
> >  - WARNING: added, moved or deleted file(s), does MAINTAINERS need
> >    updating?
> >=20
> >    This is done in a single patch [0] in the MIPS series to avoid
> >    conflicts in between series.
> >
> >  - CHECK: struct mutex definition without comment
> >=20
> >    This is about the above mutexes field. Do you want a code comment
> >    about the reasoning for one mutex per domain?
>
> Yes, that would be nice. I'm not pedantic about the lock comments
> because in reset drivers it's usually pretty obvious what the lock is
> used for, but mentioning that the mutexes cover register read-modify-
> write plus waiting for LBIST on some domains seems like a good idea.

Sure:

struct eqr_private {
	/*
	 * One mutex per domain for read-modify-write operations on registers.
	 * Some domains can be involved in LBIST which implies long critical
	 * sections; we wouldn't want other domains to be impacted by that.
	 */
	struct mutex			mutexes[EQR_MAX_DOMAIN_COUNT];
	void __iomem			*base;
	const struct eqr_match_data	*data;
	struct reset_controller_dev	rcdev;
};

>
> [...]
> > >=20
> > > > +static void eqr_assert_locked(struct eqr_private *priv, u32 domain=
, u32 offset)
> > > > +{
> [...]
> > > > +	case EQR_EYEQ6H_SARCR:
> > > > +		val =3D readl(base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > > > +		val &=3D ~BIT(offset);
> > > > +		writel(val, base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > > > +		writel(val, base + EQR_EYEQ6H_SARCR_CLK_REQUEST);
> > >=20
> > > This looks peculiar. Why is it ok to write the value read from
> > > RST_REQUEST into CLK_REQUEST?
> >=20
> > What is abstracted away by the hardware on EyeQ5 is not anymore on
> > EyeQ6H. Previously a single register was used for requests and a single
> > register for status. Now there are two request registers and two status
> > registers.
> >=20
> > Those registers *must be kept in sync*. The register name referencing
> > clock is not to be confused with the clock driver of the
> > system-controller. It is describing a register within the reset
> > controller.
> >=20
> > This hardware interface is odd, I might add a comment?
>
> Yes, please. With the knowledge that those registers must be kept in
> sync, this goes from strange to obvious.

Done, I added a plain comment on both assert and deassert:

	/* RST_REQUEST and CLK_REQUEST must be kept in sync. */

Thanks Philipp,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


