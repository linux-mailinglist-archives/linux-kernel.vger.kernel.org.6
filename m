Return-Path: <linux-kernel+bounces-531031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB4A43B33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02E87A64F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DD2676E9;
	Tue, 25 Feb 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YIpHkrT/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OaDhyVGy"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E826560F;
	Tue, 25 Feb 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478765; cv=none; b=hWc0qpJHa+mXh459oK7nJBU++7ay+16Fiu86c7tKXzeLMnXGgcNodSHZMms/rDaxKYA3/Yy9+iPfS6z8+tbCVEzF3C/B3RqMSPQy1PBM7Zbcy+TEKRnViDId2s2anbTm8B8K9Ha19pCtRwhBu0/SscGbevWb15tZiTeFuIK4Dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478765; c=relaxed/simple;
	bh=zwCSl9rSCoYPTDUkk49lQppPWA4xOyyReSmUTIG5s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI4EppujRglKcaYaKDEyl0Gg95ItGqaxthFeMeOg622eQbWfp7MDkzwllXsvNUhYnc6ZFIDG5xFabqeeFyKEwQaoZVEDTu4o57P/WRcmYyv54a7m6/Iq2qhPTO9o2Gs5kMEsbwdjZcAUjSNtpNpanRqeNciASIXG7X8YbdryLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YIpHkrT/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OaDhyVGy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740478761; x=1772014761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DKR2/tifCb6okA4X4epz/KUOoNfhkvPJV9FCmEibHqI=;
  b=YIpHkrT/eyJ/LTn8WnUQ9PUkLvC5AsVvojarmrTP1ov6yOCu8cxQ0Uzw
   a3mo5vLI5xrp4ZoedDOjPXysO9TU9YZ7TrEhcHcbqi4krwuwBFVCOlsq6
   /sDmXZpV5eMyqvAKKl7QPPgeqg487yfpiaaIiwBWEAuv+oSh6BIgwztwy
   GP6ThmXGMonG6HsD2NMg5xVCX6oy/INP2ojw0veN6VH/WqetEae5gPOtv
   TLLhMX4j510J3e2xeu+oFjZrPd7jYxvvGC8cytTZLdiImUyFfZvzS7gdl
   2USYK0uhf6YxPxWMJXFZUCJ60nHSL9O8eMc+udmUFq7fRDVGx36QdHmYx
   w==;
X-CSE-ConnectionGUID: xABZvsWMRgG2Dhmn/Dj8gQ==
X-CSE-MsgGUID: ZllzypggQ6ulAa3R2d3UHg==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067507"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:19:12 +0100
X-CheckPoint: {67BD9920-57-EBA888C4-C1AC8B84}
X-MAIL-CPID: 78E27B4DAC71B22F8FCE08B9E6208EC3_0
X-Control-Analysis: str=0001.0A002101.67BD9921.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14472160AF0;
	Tue, 25 Feb 2025 11:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740478748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKR2/tifCb6okA4X4epz/KUOoNfhkvPJV9FCmEibHqI=;
	b=OaDhyVGyq/jpR0XnEBugrkJikhHocbi3gCS84qUod9vNJ7g8aFm6OnQBBGPVfs++S0/EBL
	YBLqXyUAYLpP8hUPLRRuV0uHjFmO/TpQFW3G/t0OH1V+jwRxcpiHQ2A/+9RncuBA/n7J37
	kHXnybS6V5qLvRWkmn8+oXLwnRt8tkvNOG5zY7Cf4KBKI5q9XDwwXgEyiRiQ0qO24V4AZ8
	PTI8vs2Ljr46oPJAi5GwhR46gq3K+yjpVvthtCwntelqwX+lkH7Lc2su2GJTpDbRVreJ01
	yAKVtaIUOvqA4CAzzoiMJhLGjXWtJFlyehSalSglKUS2XVIgGxsDZ8DEh4cltg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 5/5] arm64: dts: mba8xx: Add PCIe support
Date: Tue, 25 Feb 2025 11:19:03 +0100
Message-ID: <4633177.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Z7zCyHtpKo0WAPMh@lizhi-Precision-Tower-5810>
References:
 <20250107140110.982215-1-alexander.stein@ew.tq-group.com>
 <20250107140110.982215-6-alexander.stein@ew.tq-group.com>
 <Z7zCyHtpKo0WAPMh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Montag, 24. Februar 2025, 20:04:40 CET schrieb Frank Li:
> On Tue, Jan 07, 2025 at 03:01:10PM +0100, Alexander Stein wrote:
> > Add PCIe support for TQMa8Xx on MBa8Xx board.
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  arch/arm64/boot/dts/freescale/mba8xx.dtsi | 32 +++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boo=
t/dts/freescale/mba8xx.dtsi
> > index 276d1683b03bb..117f657283191 100644
> > --- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> > @@ -36,6 +36,13 @@ chosen {
> >  		stdout-path =3D &lpuart1;
> >  	};
> >
> > +	/* Non-controllable PCIe reference clock generator */
> > +	pcie_refclk: clock-pcie-ref {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <100000000>;
> > +	};
> > +
> >  	gpio-keys {
> >  		compatible =3D "gpio-keys";
> >  		pinctrl-names =3D "default";
> > @@ -208,6 +215,12 @@ &flexcan2 {
> >  	status =3D "okay";
> >  };
> >
> > +&hsio_phy {
> > +	fsl,hsio-cfg =3D "pciea-x2-pcieb";
> > +	fsl,refclk-pad-mode =3D "input";
> > +	status =3D "okay";
> > +};
> > +
> >  &i2c1 {
> >  	tlv320aic3x04: audio-codec@18 {
> >  		compatible =3D "ti,tlv320aic32x4";
> > @@ -309,7 +322,16 @@ &lsio_gpio3 {
> >  			  "", "", "", "";
> >  };
> >
> > -/* TODO: Mini-PCIe */
> > +&pcieb {
> > +	phys =3D <&hsio_phy 0 PHY_TYPE_PCIE 0>;
> > +	phy-names =3D "pcie-phy";
> > +	pinctrl-0 =3D <&pinctrl_pcieb>;
> > +	pinctrl-names =3D "default";
> > +	reset-gpios =3D <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> > +	disable-gpio =3D <&expander 7 GPIO_ACTIVE_LOW>;
>=20
> "disable-gpio" is undocument property.

Thanks for noticing, old downstream property slipped through. Will remove i=
t.

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



