Return-Path: <linux-kernel+bounces-236626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB791E51E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3365C1C220D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FC16D9A2;
	Mon,  1 Jul 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OafQCLIr"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664D2562E;
	Mon,  1 Jul 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850764; cv=none; b=RmDLHRIVvAFpU7B8OtPGzugMmtvBCijrWSriGz6WgZf5r/jSuy9FGD7DQvfawptPDjz5CfxR0Leov+pImmw7oZY+zsPy9rrYo2lN/IFHSIrBFSdi0NbbaZR752SfpKMEijvhC72/2Gkz1Phdeu9+qeurXh6DN86iKzS+t2Mkbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850764; c=relaxed/simple;
	bh=aMTWXiPMO9wpqluQw4BQ3jLgh9RS0IDjpur4E9XvBV8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Vo9/b8nnLoercAu32sEyOfbpk+Nc7AvIIBGFIHL4eXchZLUK2aQxnQVPYDk4tDtr2oeu1vingjM/2jSR8lk338DU/Ej8FsUCNsFL2yDHlLB2tktkPWYNcsexrqMC2/1CUDoH7XyaTdfVkgJBJJQ02YQV5ECjttKemi1QohuJn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OafQCLIr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A87EE0006;
	Mon,  1 Jul 2024 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719850753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntIHPlC3pWsKyjKU0b/gbUXd4RhIrGuyI18/MLYaFzQ=;
	b=OafQCLIr2NVKZ9bDnbmUCUft8QmJMyF+d7+VHJaAWM9U5h92Svu3Sc1O9d0TeZmkNDvd/W
	bb9HQClXSW9H9vzJlq1sqrQsnDS72W9WlHkiUixQ5HIlLviC10mQLWXKmKkYnvilqAdC06
	fSBo5yLjcUIKmT5IwU7wOxY11T5GjVTqc7g2SG3Hi3riuY3/ekbB7LwfsLdGfINMB83+Kb
	vr9pDiBlqh+POhMwL6i+uLU6YJ5v6eOhW7ezj3qMMBd88Cp/YDLS5Vd5W18XCLfrQUSY2I
	KyG92Af9NgepLOSxcwXd+Gh/D/qGZGe24W512qbFoGfhrCeYpWsSj+Yp+3E4pA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 18:19:12 +0200
Message-Id: <D2EC7KK40YX5.C3G1SM3FEDJO@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 2/2] reset: eyeq: add platform driver
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
 <20240628-mbly-reset-v1-2-2a8294fd4392@bootlin.com>
 <e9bfd8087ddef3d66f437719530df54a1f6529a4.camel@pengutronix.de>
In-Reply-To: <e9bfd8087ddef3d66f437719530df54a1f6529a4.camel@pengutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Philipp,

On Mon Jul 1, 2024 at 10:59 AM CEST, Philipp Zabel wrote:
> On Fr, 2024-06-28 at 18:11 +0200, Th=C3=A9o Lebrun wrote:
> > Add Mobileye EyeQ reset controller driver, for EyeQ5, EyeQ6L and EyeQ6H
> > SoCs. Instances belong to a shared register region called OLB and gets
> > spawned as auxiliary device to the platform driver for clock.
> >=20
> > There is one OLB instance for EyeQ5 and EyeQ6L. There are seven OLB
> > instances on EyeQ6H; three have a reset controller embedded:
> >  - West and east get handled by the same compatible.
> >  - Acc (accelerator) is another one.
> >=20
> > Each instance vary in the number and types of reset domains.
> > Instances with single domain expect a single cell, others two.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/reset/Kconfig      |  13 ++
> >  drivers/reset/Makefile     |   1 +
> >  drivers/reset/reset-eyeq.c | 562 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 576 insertions(+)
> >=20
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 7112f5932609..14f3f4af0b10 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -66,6 +66,19 @@ config RESET_BRCMSTB_RESCAL
> >  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 =
on
> >  	  BCM7216.
> > =20
> > +config RESET_EYEQ
> > +	bool "Mobileye EyeQ reset controller"
> > +	depends on AUXILIARY_BUS
>
> This should
>
> 	select AUXILIARY_BUS
>
> instead.

Done, looking like this now:

config RESET_EYEQ
	bool "Mobileye EyeQ reset controller"
	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
	select AUXILIARY_BUS
	default MACH_EYEQ5 || MACH_EYEQ6H
	help
	  ...

[...]

> > +#define EQR_MAX_DOMAIN_COUNT 3
> > +
> > +struct eqr_domain_descriptor {
> > +	enum eqr_domain_type	type;
> > +	u32			valid_mask;
> > +	unsigned int		offset;
> > +};
> > +
> > +struct eqr_match_data {
> > +	unsigned int				domain_count;
> > +	const struct eqr_domain_descriptor	*domains;
> > +};
> > +
> > +struct eqr_private {
> > +	struct mutex			mutexes[EQR_MAX_DOMAIN_COUNT];
>
> Is there any benefit from per-domain mutexes over just a single mutex?

Some domains can stay locked for pretty long in theory because of Logic
built-in self-test (LBIST). This is the reasoning behind
eqr_busy_wait_locked().

Other domains are not concerned by this behavior.

More concretely, on EyeQ5, SARCR and ACRP domains can lock their mutexes
for a relatively long time, and for good reasons. We wouldn't want the
PCIE domain  to suffer from that if it happens to (de)assert a reset at
the same time.

>
> > +	void __iomem			*base;
> > +	const struct eqr_match_data	*data;
> > +	struct reset_controller_dev	rcdev;
> > +};
> > +
> > +#define rcdev_to_priv(rcdev) container_of(rcdev, struct eqr_private, r=
cdev)
>
> Please use checkpatch --strict, and ideally mention when you ignore a
> warning on purpose. In this case, the macro parameter should named
> something else, because the last parameter to container_of must be
> "rcdev" verbatim. This only works by accident because the passed
> parameter also happens to be called called "rcdev" at all call sites.

I have let this CHECK from `checkpatch --strict` slip through indeed.
Other remaining messages, with explanations, are:

 - WARNING: added, moved or deleted file(s), does MAINTAINERS need
   updating?

   This is done in a single patch [0] in the MIPS series to avoid
   conflicts in between series.

 - CHECK: struct mutex definition without comment

   This is about the above mutexes field. Do you want a code comment
   about the reasoning for one mutex per domain?

 - WARNING: DT compatible string "[...]" appears un-documented

   Bindings are added in a single commit in the MIPS series [1],
   to avoid conflicts.

>
> > +static u32 eqr_double_readl(void __iomem *addr_a, void __iomem *addr_b=
,
> > +			    u32 *dest_a, u32 *dest_b)
> > +{
> > +	*dest_a =3D readl(addr_a);
> > +	*dest_b =3D readl(addr_b);
> > +	return 0; /* read_poll_timeout() op argument must return something. *=
/
> > +}
> > +
> > +static int eqr_busy_wait_locked(struct eqr_private *priv, struct devic=
e *dev,
> > +				u32 domain, u32 offset, bool assert)
> > +{
> > +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type=
;
> > +	unsigned long sleep_us, timeout_us;
> > +	u32 val, mask, val0, val1;
> > +	void __iomem *base, *reg;
> > +	int ret;
> > +
> > +	lockdep_assert_held(&priv->mutexes[domain]);
> > +
> > +	base =3D priv->base + priv->data->domains[domain].offset;
> > +	sleep_us =3D eqr_timings[domain_type].sleep_us;
> > +	timeout_us =3D eqr_timings[domain_type].timeout_us;
>
> You can initialize these at the declaration.

Done, declarations will look like:

static int eqr_busy_wait_locked(struct eqr_private *priv, struct device *de=
v,
				u32 domain, u32 offset, bool assert)
{
	void __iomem *base =3D priv->base + priv->data->domains[domain].offset;
	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
	unsigned long timeout_us =3D eqr_timings[domain_type].timeout_us;
	unsigned long sleep_us =3D eqr_timings[domain_type].sleep_us;
	u32 val, mask, val0, val1;
	void __iomem *reg;
	int ret;

	// ...
}

>
> > +
> > +	switch (domain_type) {
> > +	case EQR_EYEQ5_SARCR:
> > +		reg =3D base + EQR_EYEQ5_SARCR_STATUS;
> > +		mask =3D BIT(offset);
> > +
> > +		ret =3D readl_poll_timeout(reg, val, !(val & mask) =3D=3D assert,
> > +					 sleep_us, timeout_us);
> > +		break;
> > +
> > +	case EQR_EYEQ5_ACRP:
> > +		reg =3D base + 4 * offset;
> > +		if (assert)
> > +			mask =3D EQR_EYEQ5_ACRP_ST_POWER_DOWN;
> > +		else
> > +			mask =3D EQR_EYEQ5_ACRP_ST_ACTIVE;
> > +
> > +		ret =3D readl_poll_timeout(reg, val, !!(val & mask),
> > +					 sleep_us, timeout_us);
> > +		break;
> > +
> > +	case EQR_EYEQ5_PCIE:
> > +		ret =3D 0; /* No busy waiting. */
> > +		break;
> > +
> > +	case EQR_EYEQ6H_SARCR:
> > +		/*
> > +		 * Wait until both bits change:
> > +		 *	readl(base + EQR_EYEQ6H_SARCR_RST_STATUS) & BIT(offset)
> > +		 *	readl(base + EQR_EYEQ6H_SARCR_CLK_STATUS) & BIT(offset)
> > +		 */
> > +		mask =3D BIT(offset);
> > +		ret =3D read_poll_timeout(eqr_double_readl, val,
> > +					(!(val0 & mask) =3D=3D assert) &&
> > +						(!(val1 & mask) =3D=3D assert),
>
> I'd remove a level of indentation here.

Indeed!

> > +					sleep_us, timeout_us, false,
> > +					base + EQR_EYEQ6H_SARCR_RST_STATUS,
> > +					base + EQR_EYEQ6H_SARCR_CLK_STATUS,
> > +					&val0, &val1);
>
> Calling these variables something like rst_status and clk_status, would
> make this a bit easier to parse.

It now looks like:

static int eqr_busy_wait_locked(struct eqr_private *priv, struct device *de=
v,
				u32 domain, u32 offset, bool assert)
{
	// ...

	switch (domain_type) {

	// ...

	case EQR_EYEQ6H_SARCR:
		/*
		 * Wait until both bits change:
		 *	readl(base + EQR_EYEQ6H_SARCR_RST_STATUS) & BIT(offset)
		 *	readl(base + EQR_EYEQ6H_SARCR_CLK_STATUS) & BIT(offset)
		 */
		mask =3D BIT(offset);
		ret =3D read_poll_timeout(eqr_double_readl, val,
					(!(rst_status & mask) =3D=3D assert) &&
					(!(clk_status & mask) =3D=3D assert),
					sleep_us, timeout_us, false,
					base + EQR_EYEQ6H_SARCR_RST_STATUS,
					base + EQR_EYEQ6H_SARCR_CLK_STATUS,
					&rst_status, &clk_status);
		break;

	// ...

	}

	// ...
}

>
> > +		break;
> > +
> > +	default:
> > +		WARN_ON(1);
> > +		ret =3D -EINVAL;
> > +		break;
> > +	}
> > +
> > +	if (ret =3D=3D -ETIMEDOUT)
> > +		dev_dbg(dev, "%u-%u: timeout\n", domain, offset);
> > +	return ret;
> > +}
> > +
> > +static void eqr_assert_locked(struct eqr_private *priv, u32 domain, u3=
2 offset)
> > +{
> > +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type=
;
> > +	void __iomem *base, *reg;
> > +	u32 val;
> > +
> > +	lockdep_assert_held(&priv->mutexes[domain]);
> > +
> > +	base =3D priv->base + priv->data->domains[domain].offset;
> > +
> > +	switch (domain_type) {
> > +	case EQR_EYEQ5_SARCR:
> > +		reg =3D base + EQR_EYEQ5_SARCR_REQUEST;
> > +		writel(readl(reg) & ~BIT(offset), reg);
> > +		break;
> > +
> > +	case EQR_EYEQ5_ACRP:
> > +		reg =3D base + 4 * offset;
> > +		writel(readl(reg) | EQR_EYEQ5_ACRP_PD_REQ, reg);
> > +		break;
> > +
> > +	case EQR_EYEQ5_PCIE:
> > +		writel(readl(base) & ~BIT(offset), base);
> > +		break;
> > +
> > +	case EQR_EYEQ6H_SARCR:
> > +		val =3D readl(base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > +		val &=3D ~BIT(offset);
> > +		writel(val, base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > +		writel(val, base + EQR_EYEQ6H_SARCR_CLK_REQUEST);
>
> This looks peculiar. Why is it ok to write the value read from
> RST_REQUEST into CLK_REQUEST?

What is abstracted away by the hardware on EyeQ5 is not anymore on
EyeQ6H. Previously a single register was used for requests and a single
register for status. Now there are two request registers and two status
registers.

Those registers *must be kept in sync*. The register name referencing
clock is not to be confused with the clock driver of the
system-controller. It is describing a register within the reset
controller.

This hardware interface is odd, I might add a comment?

[...]

> > +static int eqr_status(struct reset_controller_dev *rcdev, unsigned lon=
g id)
> > +{
> > +	u32 domain =3D FIELD_GET(ID_DOMAIN_MASK, id);
> > +	struct eqr_private *priv =3D rcdev_to_priv(rcdev);
> > +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type=
;
> > +	u32 offset =3D FIELD_GET(ID_OFFSET_MASK, id);
>
> I'd put domain and offset declaration next to each other.

Done:

static int eqr_status(struct reset_controller_dev *rcdev, unsigned long id)
{
	u32 domain =3D FIELD_GET(ID_DOMAIN_MASK, id);
	u32 offset =3D FIELD_GET(ID_OFFSET_MASK, id);
	struct eqr_private *priv =3D rcdev_to_priv(rcdev);
	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
	void __iomem *base, *reg;

	// ...
}

I'll be sending a new revision in the week with those fixes.

Thanks Philipp,

[0]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-3-f53f5e4c422b@boot=
lin.com/
[1]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-1-f53f5e4c422b@boot=
lin.com/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


