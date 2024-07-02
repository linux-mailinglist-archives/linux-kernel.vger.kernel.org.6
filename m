Return-Path: <linux-kernel+bounces-237294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4491EED6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330A42833A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EE7E0FC;
	Tue,  2 Jul 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CoUYIKQ6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893F5CDE9;
	Tue,  2 Jul 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901143; cv=none; b=JzEP158lKBZP/GLJVatMXrciiKO1UMimU4+TWc3sQ1y9g62pMkI+2T3MBaVaTf6wc0atkAgwNo7k5ThGc42SG2AwZ2xwZx9QXdMvbYgAD0Jt/e/sCMyB9DBX9Ye0wvtATvCUV4uhhE7438G3PKRV2stMSLi5Nj1PW0Cit4Ff5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901143; c=relaxed/simple;
	bh=O0w7oKR0burBEOSpg+U3UFChgxP0OfT3G9l1MZDodiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7txL0vhEhmWloTQ+y5vX/ECoYRboDVwExS9ICbiLJ4Xh4FjlPcOVDZQ7zp/ihnnfqnRrOgRxVt+mkh+iqd0IMSn5oNvA4trtV6BnezIwrmc3zlMAGxJ85D+JCA+HSQQeiqybEOrCKsj2LPJwV+cI2wcEu8DkKDHv3ZAQTcXvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CoUYIKQ6; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Ak5QZwwkUOt94pN1EzjhG1GszUbTrlXG7hmPV7Sskx0=;
	b=CoUYIKQ6GYEzZp3TKUEtEfKy7wrlsPkaps7HvlVQ/V9uREkeuMJ635kHQogJ9x
	arN06v5fF/Z0eeB0+viRPlkHb8obnpRQ9BO1Rm5l6l0lUhcY65yPviTUrxqF2kW6
	UX2WPl6oLD4VW7dQMxd/KjAFdaUJOPUoGSUNcw3OlGyOE=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3Pwedm4Nm4zIHAA--.18405S3;
	Tue, 02 Jul 2024 14:18:06 +0800 (CST)
Date: Tue, 2 Jul 2024 14:18:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
Message-ID: <ZoObnDqMd2EL4W6F@dragon>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
 <ZoN90rHfpK7niqEr@dragon>
 <ZoOAjSUp29DBhY+/@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoOAjSUp29DBhY+/@lizhi-Precision-Tower-5810>
X-CM-TRANSID:M88vCgD3Pwedm4Nm4zIHAA--.18405S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF15GFWDXrW8uw13CrW8tFb_yoW8uw48p3
	48CF1aqr18tFW7ur9Ig3W8KFn5Kwn5tF1Uur17G34jyrnIyrnrtr1rCr45ury8Xr4Ik3yS
	9Fn0qr4fKrn8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6_M3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRsQZWZv-d19HwABst

On Tue, Jul 02, 2024 at 12:22:37AM -0400, Frank Li wrote:
> On Tue, Jul 02, 2024 at 12:10:58PM +0800, Shawn Guo wrote:
> > On Mon, Jul 01, 2024 at 11:03:28AM -0400, Frank Li wrote:
> > > Add irqsteer, pwm and i2c in lvds subsystem.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
> > >  2 files changed, 87 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > > new file mode 100644
> > > index 0000000000000..1da3934847057
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > > @@ -0,0 +1,77 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +&qm_lvds0_lis_lpcg {
> > > +	clocks = <&lvds_ipg_clk>;
> > > +	clock-indices = <IMX_LPCG_CLK_4>;
> > > +};
> > > +
> > > +&qm_lvds0_pwm_lpcg {
> > > +	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
> > > +		 <&lvds_ipg_clk>;
> > > +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > +};
> > > +
> > > +&qm_lvds0_i2c0_lpcg {
> > > +	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
> > > +		 <&lvds_ipg_clk>;
> > > +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > > +};
> > > +
> > > +&qm_pwm_lvds0 {
> > > +	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
> > > +		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
> > > +};
> > > +
> > > +&qm_i2c0_lvds0 {
> > > +	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
> > > +		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
> > > +};
> > > +
> > > +&lvds0_subsys {
> > > +	interrupt-parent = <&irqsteer_lvds0>;
> > > +
> > > +	irqsteer_lvds0: interrupt-controller@56240000 {
> > > +		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> > 
> > Is compatible "fsl,imx8qm-irqsteer" documented in bindings?
> 
> In rob' tree
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=285c645d842c5a15d3be2d653faaa5f68d81be1f

I do not see "fsl,imx8qm-irqsteer" in the patch.

Shawn


