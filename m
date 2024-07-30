Return-Path: <linux-kernel+bounces-266931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151479409F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468FF1C233F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AC18FDA3;
	Tue, 30 Jul 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SCpnZRFO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gOjKUvEg"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B613B780;
	Tue, 30 Jul 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324628; cv=none; b=mYiZLJYx+fibB1Zr8VFpVTUUC/HM3+6ooXImXtxrFvL3pOsEvX1lABTww0vC9kQ5Vx84NmSCT2qqIKUrPfV/UHfDzBqIxtjsEyogqaDnHyYL208HO277knVSuqVzRuphrsKghdDxzkXIL9xQR/Ckxb8jYAz2I3nMpcTxzFsDXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324628; c=relaxed/simple;
	bh=JdKJLcs14SxN51YwQ8AqZjX1VBfSECpjMN02hOEUTqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx/yJBBdsdTS5F6uRwvHm0jolTCrYq1alMo3ja2Wf5gFf7n6Kv+SaUEmqN7FQy+8BOG45r8Uum/lxLST62F6SyJJUyExdXe9Bm4zDbgyq21Raj+pb8CYWXpwLDIdCPeVx8ztDBsDiGi8HWn4OHNzwQki/dq0rJRO8LMIkBPG1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SCpnZRFO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gOjKUvEg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722324624; x=1753860624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phzzdkq7fOGAfE/5nN2HQ8Rb+AHqVU2SBA1vaHHG5FY=;
  b=SCpnZRFOxzdyboo8HFnTW5ABckHj4j9wZu3blVjkUpaqsBe4X/qGOR0r
   Dik4mUwZ+9h0z8sl0DR51UZGjQNb+DeubFpv/LLgLBws0ptyqKV4O5lU5
   VQp738GSdZQ1OpqtVDBwm+UcxbmeFXzvGv3ZJJrsHLFMACTPLEA7Z7D1e
   JJjw4uT/U1k+3UwVcmje3AkRQoq1ozOb3mURRIdFAjwP2gpahJtLxYs0I
   Nu03P9k0IayW9/r8DAxg/OXSidM/904eSxXCpazR92xRn104pND6oJ+9H
   WXNHhfahuNzHhHk5Ls/mSgyRMGQMwbgMOO8FO/ihovh7VKo72Dlay9EEk
   A==;
X-CSE-ConnectionGUID: kypxY0/5SNCSnqMUHtlmgQ==
X-CSE-MsgGUID: BxK5qmE6Tnuw52PxG5QURQ==
X-IronPort-AV: E=Sophos;i="6.09,248,1716242400"; 
   d="scan'208";a="38139756"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Jul 2024 09:30:21 +0200
X-CheckPoint: {66A8968D-20-CA1431AC-CF855369}
X-MAIL-CPID: 1C57A42B986A162BA27F0E30C682380C_1
X-Control-Analysis: str=0001.0A782F1F.66A8968D.0165,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DA58167B75;
	Tue, 30 Jul 2024 09:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722324617;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=phzzdkq7fOGAfE/5nN2HQ8Rb+AHqVU2SBA1vaHHG5FY=;
	b=gOjKUvEgQdABiwt2rGFfKsC2GaDVi1OjvnUHPzG4nHO9QcJSqcVG0m5wLIsNEuPL8NQx1q
	QOd6uuKxN9Gu15HJjw9PPlz27O+GMgXDFzZeLwAkiJZPYSKKDPK2u/uNyRbKs+j8IV7QYr
	e/S68gvGaErQKHLLbEXw00ZjPWN/v6KR7tXx1ZfqebVwPb+wdz7xLdK7kq24/hXPHKGbOh
	HBsuFCzJhLbe9TxYtgbZkIWI2THz+4RQCv0hgHrXuHbNdt2O3NQMXxmdrMfiidW7lAPLvg
	aFMQa2CpRrQ0snmip0vYxUUXjl6sUsvE82lr+U1j2kHXoc1KMersq4sG+nZLTA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Clark Wang <xiaoning.wang@nxp.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8-ss-dma: enable dma support for lpspi
Date: Tue, 30 Jul 2024 09:30:16 +0200
Message-ID: <2840074.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <6c6bb89e-a9d8-4d5c-837a-30f3bae56f0f@kernel.org>
References: <20240729094511.159467-1-alexander.stein@ew.tq-group.com> <6c6bb89e-a9d8-4d5c-837a-30f3bae56f0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Krzysztof,

Am Montag, 29. Juli 2024, 17:10:48 CEST schrieb Krzysztof Kozlowski:
> On 29/07/2024 11:45, Alexander Stein wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >=20
> > Add DMA configurations for LPSPI nodes on i.MX8QX/QM/DXL.
> >=20
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Using the DMA configuration bits from downstream kernel.
> > Tested on TQMa8XxS.
> >=20
> >  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-dma.dtsi
> > index 1ee9496c988c5..8ae5f065b4180 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> > @@ -34,6 +34,8 @@ lpspi0: spi@5a000000 {
> >  		assigned-clocks =3D <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>;
> >  		assigned-clock-rates =3D <60000000>;
> >  		power-domains =3D <&pd IMX_SC_R_SPI_0>;
> > +		dma-names =3D "tx","rx";
>=20
> Missing spaces. Unexpected order, unless that's the coding style for imx.

Ack for the space, will correct. But the order is defined that way in
Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



