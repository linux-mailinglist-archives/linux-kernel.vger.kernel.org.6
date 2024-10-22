Return-Path: <linux-kernel+bounces-376740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4799AB557
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B851C23108
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15BD1BE853;
	Tue, 22 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="WrCJ8CIS"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733A80C13;
	Tue, 22 Oct 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618957; cv=none; b=jWOXSkNBs4jidSXq3i8Pt1EQhdISh3NdKdDXB+/BrFetmPcXI1YrxRAhrVcC4Oy9AjDS8A7lYE2p3h3V4f4/Cy5TnYIrhdoqZeh/+I/oo6bzoWmUYMc7Fh2q+D9KPEUx8i5pbDQDXk0W9Y8JmPC5Rb5a+cLCLvsAYpRmcmlI8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618957; c=relaxed/simple;
	bh=v9o+diiWPAzNW6fcahbOqHdppyHhmJ37GjMy4tZPO6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OO2dhZ4zguLOeTMU3BL9CiwBQSGuyHsd8EBM/Rhbpn49cvNlFA0JchvnNcI8MGTMvgOfdewmgbMK3Tz/boZUxve94yfuD9fqsp4mbGfFx7qElRbPJrnKSwn1eK5dcAEqdJuF2/4douW4diTReoWotgWhtMrhbLXxiJb8ypZJBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=WrCJ8CIS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YzXiqSqg0aayLyb7AVqmSvNxO5PvD8+CWdeuiriR2g4=; b=WrCJ8CISZzKR5F2k23TGKepHhJ
	AmOqL5WWVvwpujLtGGbInXiQsofKfQ6xN1HBHTd9jnbuwTeNXRBElnzZyGaIVU//dsb9pSgVGfxO1
	9mrqlMaxDHWr8adQivIIl97piVyPc1u2LWwQ0T6EVfzBbc/90bbi59QNJrZFjavcFgZXwmsVdBgBx
	zG40HCAtTJF9I5Q1y1MLf0bULCuOQ1Kvyy8UhRyQ388bxkJLGfSoproLFmGXNM1HNBPa8G9P6J37S
	njkI06N7B57rT3mh29Ggx9+YxeavFAhS1AgfiZpKvUOeZiNOUJVpwGKmzYEIGACNTbgqa/qZUjQAJ
	es6L8phw==;
Date: Tue, 22 Oct 2024 19:42:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Conor Dooley <conor@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio
 Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>
Subject: Re: [PATCH 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
Message-ID: <20241022194221.43b9073b@akair>
In-Reply-To: <20241022-refurbish-laborious-e7cc067966dc@spud>
References: <20241021173631.299143-1-andreas@kemnade.info>
	<20241021173631.299143-3-andreas@kemnade.info>
	<20241022-refurbish-laborious-e7cc067966dc@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 22 Oct 2024 17:59:10 +0100
schrieb Conor Dooley <conor@kernel.org>:

> On Mon, Oct 21, 2024 at 07:36:30PM +0200, Andreas Kemnade wrote:
> > Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
> > on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
> > equipped with an i.MX6SLL SoC.
> > 
> > Expected to work:
> >   - Buttons
> >   - Wifi
> >   - Bluetooth
> >     (if Wifi is initialized first, driver does not handle regulators
> >      yet)
> >   - LED
> >   - uSD
> >   - USB
> >   - RTC

and also touchscreen.
> > 



> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
> >  .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
> >  .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
> >  .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514
> > ++++++++++++++++++ 4 files changed, 562 insertions(+)
> >  create mode 100644
> > arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts create mode
> > 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts create
> > mode 100644
> > arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/nxp/imx/Makefile
> > b/arch/arm/boot/dts/nxp/imx/Makefile index
> > 92e291603ea13..58db45352b666 100644 ---
> > a/arch/arm/boot/dts/nxp/imx/Makefile +++
> > b/arch/arm/boot/dts/nxp/imx/Makefile @@ -290,6 +290,8 @@
> > dtb-$(CONFIG_SOC_IMX6SL) += \ dtb-$(CONFIG_SOC_IMX6SLL) += \
> >  	imx6sll-evk.dtb \
> >  	imx6sll-kobo-clarahd.dtb \
> > +	imx6sll-kobo-clara2e-a.dtb \
> > +	imx6sll-kobo-clara2e-b.dtb \
> >  	imx6sll-kobo-librah2o.dtb
> >  dtb-$(CONFIG_SOC_IMX6SX) += \
> >  	imx6sx-nitrogen6sx.dtb \
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
> > b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts new file
> > mode 100644 index 0000000000000..33756d6de7aa0
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: (GPL-2.0)
> > +/*
> > + * Device tree for the Kobo Clara 2E rev A ebook reader
> > + *
> > + * Name on mainboard is: 37NB-E60K2M+4A2
> > + * Serials start with: E60K2M (a number also seen in
> > + * vendor kernel sources)
> > + *
> > + * Copyright 2024 Andreas Kemnade
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6sll-kobo-clara2e-common.dtsi"
> > +
> > +/ {
> > +	model = "Kobo Clara 2E";
> > +	compatible = "kobo,clara2e-b", "kobo,clara2e",
> > "fsl,imx6sll"; +};
> > +
> > +&i2c2 {
> > +	/* EPD PMIC SY7636 at 0x62 */  
> 
> Could you explain what you're doing here, please?
>
I am not sure what you are really after with this question...
So I am guessing a bit.
I describe the hardware as good as possible. The sy7636a (apparently
=sy7636) driver could probably be used here but the driver and its
bindings needs to be extended to specify an input supply and some gpios.
So at the moment I could not use a machine-readable way of fully
describe the stuff here. But I want to put a human-readable mark here
so if someone extends the driver, he/she might be aware that there are
some possible users and candidates for a Tested-by here.
For the JD9930 it is even worse. No driver in kernel. I have a pretty
dirty one requiring some rounds with the brush before sending it.
So the mark is good for information what is missing and for teaming up.

Regards,
Andreas

