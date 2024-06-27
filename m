Return-Path: <linux-kernel+bounces-231870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82363919FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B316B1C21EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3545016;
	Thu, 27 Jun 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PIRaZpEY"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DEC43AA1;
	Thu, 27 Jun 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471525; cv=none; b=ftI6UDrWEhMwEzUIReEpeVb5A6cbF0edlBYsRok23w0+pqZquooX6dAbNTqDr3aziYvLLKXk5wWTZoBUhDco+rf7j9bXZiuRbuy7RuUjYaKEiLeoOBO64Ur9GvF/gLimoIAFbpwjBsFYG0RU0l9nu3cFldAQKmfDhEiIkUMv61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471525; c=relaxed/simple;
	bh=CAiHWTasWQsvNes4gquJBgUiczd3fYgut0h3LyWdH10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJN/VZbeAXqLGTCYfPX5jwHkrXDmRpBV90EEFCjIttFdRiAVRw7cY+8K25BxjZWti9PrD/kZOZ+ZrDONHvZR8W3FJKk2VnfZ4UqPXcrRf92080ENdphbbAHgNYbJ0xEG4BEiTzPCoXZ6KfrKRN7Ny8QdFzk5HsK8lKvnPFtgUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PIRaZpEY; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LsbeIB50EDgsPrzDnKsKFJzpQszBkOYrVjadj/myF5I=;
	b=PIRaZpEY1NCT+/kZFp4m1lILrLLOfrExLn06eRaO3hABYjq8151HKppNRBLPVt
	ulsfL9045x2oscTS+0V8/SoaEQXz167ylV/O1KLVnDQ891muiaGbkSoPFOOIHBcE
	n7mycWSqtGTekBzHRT6vvDR8DDeku14OgOuaTWJYk/Vhs=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3v8ltDX1mxG8aAA--.52621S3;
	Thu, 27 Jun 2024 14:57:51 +0800 (CST)
Date: Thu, 27 Jun 2024 14:57:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
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
Message-ID: <Zn0NbIvFdfpMPHAx@dragon>
References: <20240613134150.318755-1-ivitro@gmail.com>
 <Zm+gjpsGhzjbEgP8@dragon>
 <20240617071842.GA4832@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617071842.GA4832@francesco-nb>
X-CM-TRANSID:Ms8vCgD3v8ltDX1mxG8aAA--.52621S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17XF15Kw15uFyxtF1fJFb_yoW8Wr4Dpr
	WSkFs5J397Xr43Cr9Iqwn7ur9xKa1fAr4Duwn8KryUtrnIvF98GF1xGr1xur1q9r4fA3yF
	kF15ZryS9w1rAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO8nOUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQ8LZWZv-cwmYgAAsM

On Mon, Jun 17, 2024 at 09:18:42AM +0200, Francesco Dolcini wrote:
> Hello Shawn,
> 
> On Mon, Jun 17, 2024 at 10:33:50AM +0800, Shawn Guo wrote:
> > On Thu, Jun 13, 2024 at 02:41:50PM +0100, Vitor Soares wrote:
> > > From: Vitor Soares <vitor.soares@toradex.com>
> > > 
> > > Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> > > 
> > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > index 4768b05fd765..c9ae5f0bb526 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > @@ -227,15 +227,16 @@ &ecspi2 {
> > >  	pinctrl-0 = <&pinctrl_ecspi2>;
> > >  };
> > >  
> > > -/* Verdin CAN_1 (On-module) */
> > > +/* On-module SPI */
> > >  &ecspi3 {
> > >  	#address-cells = <1>;
> > >  	#size-cells = <0>;
> > > -	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> > > +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, <&gpio4 19 GPIO_ACTIVE_LOW>;
> > >  	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_ecspi3>;
> > > +	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_pmic_tpm_ena>;
> > 
> > Would it make more sense to have tpm pinctrl in node tpm@1 below?
> It's the pinctrl of the SPI Chip Select pin, not something about the
> TPM, I think it's correct to have it into the ecspi node.

The name pinctrl_pmic_tpm_ena seems confusing then.

Shawn


