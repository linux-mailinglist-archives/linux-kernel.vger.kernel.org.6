Return-Path: <linux-kernel+bounces-393753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD19BA4B2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B177281EEE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC816131A;
	Sun,  3 Nov 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KMRjrisj"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEB4430;
	Sun,  3 Nov 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730624224; cv=none; b=oeMyYnPDamS2u5Zo5ATNT0qbz3xG+IGlBvhm0bSFSfkAEFlaHK8/Kjmg64+qFoW3qqVHonCQrVylDjDuGp2956RW3VjG0MT5XhNL7DpgFwtLogfZcyxaJs5OJaFu5G/3cbVHmzNZWaIix4HyvwCTBbZ78DMO/llq1sURk3Mtdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730624224; c=relaxed/simple;
	bh=nORtiY9uHfPHgxEEaP89jK2rBqH9zUkwwpIA8zQzeoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeKQEghf+NkU2Dry7oscaSDxS47YdjdtF0Cplsf9hZC4v9kMl4PfEmlkEtWDYb1nBVj5u2UW4X3HAKZoIyfcCxc1xZyIk8YVlyu9bqz4lULmyH04fHwnfo9UmGaJi8ARhxtfpKbOmQH/esrogqZwcy6RQ6evCK6bc5oxD/45gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KMRjrisj; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jADZZ7en+gydtucAasF5Pal9zTL96eGVMOGaLqmJrXk=;
	b=KMRjrisjTVC3p4foZE3GdlDsBF9C5IIHpxOGOmELcDe5Mz7p7aKybJbsrJlNPM
	k0NmYgb3/lYaNPEypitE3i2m/qp+2zmh6VOJRfcq/HwPls9KKR56jx594IOcqx+U
	28ITKauXX6tnDnmlpvbVOaESdu2DYdKzCFntxRkseEV4s=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBXHyKmOidnFxOXAQ--.16305S3;
	Sun, 03 Nov 2024 16:56:08 +0800 (CST)
Date: Sun, 3 Nov 2024 16:56:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: add single-master
 property to all i2c nodes
Message-ID: <Zyc6pVCVLW+s4Bi9@dragon>
References: <20241025095915.22313-1-eichest@gmail.com>
 <20241025095915.22313-2-eichest@gmail.com>
 <ZyWv+BVp91xYr4UZ@dragon>
 <ZyY33Ai6xndqTHzi@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyY33Ai6xndqTHzi@eichest-laptop>
X-CM-TRANSID:Ms8vCgBXHyKmOidnFxOXAQ--.16305S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWkCry3Cr1rGFWktFWUurg_yoW8Cr4Upa
	10kF1UJrn5Wr43CrZFqw1xZF9I9a1rJr4kurW5KryxK3WYyFyYqF40kws3Wr4jvr4xWa1S
	yF15Zr1Skw15ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBMKZUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgCMZWcnHxgt4gAAsj

On Sat, Nov 02, 2024 at 03:31:56PM +0100, Stefan Eichenberger wrote:
> Hi Shawn,
> 
> On Sat, Nov 02, 2024 at 12:52:08PM +0800, Shawn Guo wrote:
> > On Fri, Oct 25, 2024 at 11:58:02AM +0200, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > By default we expect all i2c nodes to be single-master, we do not have
> > > any module or carrier board that uses multi-master mode on any i2c
> > > controller. With this property set, we benefit from optimisations made
> > > exclusively for single-masters.
> > > 
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > index 5fa3959141911..95d5d2333ca1e 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > @@ -367,6 +367,7 @@ &i2c1 {
> > >  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> > >  	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> > >  	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> > > +	single-master;
> > 
> > Hmm, I do not see this property is documented in i2c-imx bindings.
> 
> According to the discussion we had in this thread
> https://lore.kernel.org/linux-i2c/2bbddaxyjkxfmlgmq3yqcbzo7dsb2pq5bvdatk2y4ig4iintkt@35btqkdv7sy3/
> it is not necessary to have the property documentation in the i2c-imx
> binding because it is already documented in the dt-schema:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/i2c/i2c-controller.yaml

Ah, thanks for the info!

Shawn


