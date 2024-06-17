Return-Path: <linux-kernel+bounces-216811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F490A6DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BF1C23CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12570188CB1;
	Mon, 17 Jun 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="h94ImflP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184517E44B;
	Mon, 17 Jun 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608735; cv=none; b=XzoSo/obHYtT0rIRlUKcAO4YnSzGAGrbsOc0+vpSFkYttkLXUzlBW5dBhg4UFSlHw1bkM6b9GIzdxyNNjZwP60iWiD9c41VPX/clP+xu5n5JXqbYGpwLl7vwQwAk60Uvqh3RmGr+teVyFwmVyhlVA2bgN2WNH/m1eCJeUsiVbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608735; c=relaxed/simple;
	bh=3sRLSqmKqtBy1mVIjZ4jMKBwKP5vz0LMe7LZ60/woNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG84lKKrMfXjbmC2p2vM/2xJgVU3T27trFRdG/3AXiAlaDSDKZmOkU6YHSiSl/frdZ2SmjHLulKigztjXm4OpNrd8g1Tt/ifAWVS4aPzSJQzVaYDtJ3X8hPc41qPXeWe4bf00sNimT+8jz+3Ci+nVMYJp1ebNMgExPcgPt9xgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=h94ImflP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 533561F9B7;
	Mon, 17 Jun 2024 09:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718608726;
	bh=q7QMgSvLT6tpB5yAK78EPV33Z7ib0EHfluQ4HnCmDtA=; h=From:To:Subject;
	b=h94ImflPQUu4NOfRwurKDZh3mex8qrJffrsVdqZiAyAnXVNwdC3SpN64OT/BzlJiT
	 ALmvT5QSxy9YF4ccCZnHCEonCzQrFxVhVcbrmjcHa2VGtfBYuWEfnzzMccsWh7RePT
	 iYtuLRR+otcTYriw3xug1WqG8+ZvLcsEtpkV0s+bPwAA+jF0mxNMW037G0JsX5i0In
	 V0+6wyYERIYpWrseAz2T/4vqp2xXhBb+WG00KKz9l4t1V6s1eA9XpG1mfh7Ex/s61o
	 r53+RN2WHrunBZKPTXyYOXJMkwL53QQrORtb5/tO2AQCWvvoUj89XhHQ2Dux9H/wTL
	 bCRvDah91j7dA==
Date: Mon, 17 Jun 2024 09:18:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: add TPM device
Message-ID: <20240617071842.GA4832@francesco-nb>
References: <20240613134150.318755-1-ivitro@gmail.com>
 <Zm+gjpsGhzjbEgP8@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm+gjpsGhzjbEgP8@dragon>

Hello Shawn,

On Mon, Jun 17, 2024 at 10:33:50AM +0800, Shawn Guo wrote:
> On Thu, Jun 13, 2024 at 02:41:50PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> > 
> > Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> > 
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > index 4768b05fd765..c9ae5f0bb526 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -227,15 +227,16 @@ &ecspi2 {
> >  	pinctrl-0 = <&pinctrl_ecspi2>;
> >  };
> >  
> > -/* Verdin CAN_1 (On-module) */
> > +/* On-module SPI */
> >  &ecspi3 {
> >  	#address-cells = <1>;
> >  	#size-cells = <0>;
> > -	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> > +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, <&gpio4 19 GPIO_ACTIVE_LOW>;
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_ecspi3>;
> > +	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_pmic_tpm_ena>;
> 
> Would it make more sense to have tpm pinctrl in node tpm@1 below?
It's the pinctrl of the SPI Chip Select pin, not something about the
TPM, I think it's correct to have it into the ecspi node.


> > +	verdin_som_tpm: tpm@1 {
> > +		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
> > +		reg = <0x1>;
> > +		spi-max-frequency = <36000000>;
> > +	};
> >  };

Francesco


