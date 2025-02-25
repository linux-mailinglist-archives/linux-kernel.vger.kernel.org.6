Return-Path: <linux-kernel+bounces-531043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685CA43B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E60168907
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605A267AEA;
	Tue, 25 Feb 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aNvQ+Dyp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AK68a+B8"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB2266B77;
	Tue, 25 Feb 2025 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478859; cv=none; b=Drbi3OFW951Oi9fMeHmKFZV6pdcrB7uyi70GovLnWaQUn/OlPZzMD7OV7p3OIZcIuPy/Z24SMvIPrBZ1llnZ8zTKajLEL6HJvaXEmfT2TkSv4va/RtCnfBnM8iQabUXOIrfkPwvN3a3fPXT2ZOWyor5MNIVSs4PFwTD3VADUSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478859; c=relaxed/simple;
	bh=NtRbsleVfFwIICidU/eQzWaR6wzhJYOG3kjsg+cvzBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTKHzEfa6blH49f7TgwSYBa29i6tSjbLWgCGy19s3wFzn/AYsAstzy9Mb/FWm8JUXjizAI94AwSYgr66yylGJDSd/Wt6AWSOSOxDvMN01CS87frmSS/SwD53oanLdgsRcPdxGt+PuEnIKsvR8+TIB72nwBEtoOHNppP4ZTAfaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aNvQ+Dyp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AK68a+B8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740478857; x=1772014857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FT/bNjpK17AKmWrFmC1oGrmgU/J/4HzWEdIi1M3xvy8=;
  b=aNvQ+DypfSIY4vYInglLvsX2qm+eZYaFgH91OgyPKsXAyDS2Z+CqJJdK
   GAskVHsZ7jRTGnRK4fV9s7ydyfBY2meyUbvogRgJwL0vOCWfJBCQI4EKh
   kcvzgW4Bzw8WpeAUZ22cswPXvz55gjrolZhE+7aoHkKp07+DQF4NK0Jld
   CxMGDjRtZ8iS7ONa1uq1+7y8WAhcD+fKWYHnK3kZiEoCjoPdUvitYzlFR
   qDyqieWtGWRxZ8lTKLukiU7H8Pb72Ww/aSEqGYhNmaqWlGLc9g+Yb1gI7
   StD+y8Q2O6HlxN7cmcivRj7f3+KHKPGIvKBPqpjoRzbHkvYT9KGn+WIQI
   w==;
X-CSE-ConnectionGUID: QsBI+sINSrKWHQjBDBASWA==
X-CSE-MsgGUID: 8aKwrTwDSxOsoUj5BI/pOA==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067570"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:20:54 +0100
X-CheckPoint: {67BD9986-1D-C21CC984-D1047F1F}
X-MAIL-CPID: AD44FBA8F505BC75EA53E4781B804E6C_5
X-Control-Analysis: str=0001.0A002106.67BD9985.00B4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECCDB167B75;
	Tue, 25 Feb 2025 11:20:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740478850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FT/bNjpK17AKmWrFmC1oGrmgU/J/4HzWEdIi1M3xvy8=;
	b=AK68a+B89Qybuj8NoLI/VDdEZykmlp/1oKL3xVgpWnaPSQLDF/4bfjwx3jOdNiTXNnfTm6
	rwDsQYJHUL+uRKBs205y7smpffcs0L8WqHok9lJDdp+HASeCDrWkhwb4Xt26CTVtD+nC/T
	wTvnKkk+sFOD+l3UjlXYkfdwhNoot/GbX8gEBuxc6obYw7BJb0XAaCBJtCCQm8ZAhE1b4z
	9jDrYinAxaIjYY3a28xXJjbDQDsAM8ufr+NJ5NUlIFWTzjTmxgPQsKMOqtUZFjStTysd9X
	LPkyOL46ejvCr1E4Yc/IZzCuP6FshuBELfAUEyMRey4AOyBFKEy5CmHGZK/Wtw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/5] arm64: dts: imx8-ss-hsio: Wire up DMA IRQ for PCIe
Date: Tue, 25 Feb 2025 11:20:49 +0100
Message-ID: <4962874.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Z7yxDRO+ICPCu0I2@lizhi-Precision-Tower-5810>
References:
 <20250107140110.982215-1-alexander.stein@ew.tq-group.com>
 <Z36o31uhQuI5lcH7@lizhi-Precision-Tower-5810>
 <Z7yxDRO+ICPCu0I2@lizhi-Precision-Tower-5810>
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

Am Montag, 24. Februar 2025, 18:49:01 CET schrieb Frank Li:
> On Wed, Jan 08, 2025 at 11:33:35AM -0500, Frank Li wrote:
> > On Wed, Jan 08, 2025 at 10:58:18AM +0100, Alexander Stein wrote:
> > > Hi Frank,
> > >
> > > Am Dienstag, 7. Januar 2025, 16:39:25 CET schrieb Frank Li:
> > > > On Tue, Jan 07, 2025 at 03:01:06PM +0100, Alexander Stein wrote:
> > > > > IRQ mapping is already present. Add the missing DMA interrupt.
> > > >
> > > > PCI host side have not use bridge's DMA yet although hardware suppo=
rt it.
> > >
> > > So this is a driver limitation, right? So IMHO the device description=
 is
> > > independent from that and still correct, right?
> >
> > Yes, but dma register space may missed also. I suggest add later after
> > EP side support merged, which can verify informaiton is correct.
> >
> > Anyway, I don't block this change.
>=20
>=20
> Did you run DTB_CHECK? I found new warning was added
>=20
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-aster.dtb: pcie@5f010000: interrupts: [[0, 102, 4], [0, 104, 4]] =
is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie=
=2Eyaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-aster.dtb: pcie@5f010000: interrupt-names: ['msi', 'dma'] is too =
long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie=
=2Eyaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-eval-v3.dtb: pcie@5f010000: interrupts: [[0, 102, 4], [0, 104, 4]=
] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie=
=2Eyaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-eval-v3.dtb: pcie@5f010000: interrupt-names: ['msi', 'dma'] is to=
o long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie=
=2Eyaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-iris.dtb: pcie@5f010000: interrupts: [[0, 102, 4], [0, 104, 4]] i=
s too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie=
=2Eyaml#
> /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8d=
x-colibri-iris.dtb: pcie@5f010000: interrupt-names: ['msi', 'dma'] is too l=
ong

I think I did, but I see the same warnings.
I've prepared a series which addresses schema and imx8qm dtsi.

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



