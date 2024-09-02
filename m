Return-Path: <linux-kernel+bounces-310443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80218967D10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A3C1C213F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FA8F6D;
	Mon,  2 Sep 2024 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VOfr7+Ge"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BAC2C9D;
	Mon,  2 Sep 2024 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725237888; cv=none; b=TroULWqKg1AExU4hsxNwqfxQcI6kaNpcJiyUvoJd5ZjRZ7CbWVJs/P4B2WZZ2qS8Q6gfv0FDyXMcLsB2fkQt4VJ1KmXtwzjgm4A9AcEKER3AEkBnXMFCPhgLRBk9xGVJ/wPaT95jD6eMgV0TpKAoJUlu0D2opTTycmsCyBRmEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725237888; c=relaxed/simple;
	bh=/x705rAfgF75MUo9iF/CKwEW1aloVRl/vdZnmjt8W3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQHBZWnmnME35fa7RePGYHIP8//Ig3hOWlz76OHFasVZ3DAD0JKrkuTWEWsRwGTF2/LLP0j0zYvFMd745/97+DnTzRYcMJvG9HdXP1bHigac4+IVZCyST+BBHDcKRrRom0ovG7SzQsxHapC6Z/loCWyCxoXM81LUl6O3/FSQzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VOfr7+Ge; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EY/h5LzwGRTv5EzCS/bIRFPXd5nGllWSOGp5Qy6FBLM=;
	b=VOfr7+GeYMicO13dJOYP3NK6J4OgGhPTDFgaXgIexUgofZda7zn/TWGIWryDc2
	/7CsIzY0ykr/UYP/f+ZvPA/C9J5tZ82495AjsmjalrteB+r51f/4mEayvKZzTFIN
	2VU43g1wpy1d5muv3V56Fd9TulTuSKswy+Y/Opoa5IDJs=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDn_1hhCtVmQStLAA--.41797S3;
	Mon, 02 Sep 2024 08:44:19 +0800 (CST)
Date: Mon, 2 Sep 2024 08:44:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
Message-ID: <ZtUKYSe6Psx8hbZ9@dragon>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
 <ZoN90rHfpK7niqEr@dragon>
 <ZoOAjSUp29DBhY+/@lizhi-Precision-Tower-5810>
 <ZoObnDqMd2EL4W6F@dragon>
 <CAOMZO5BigqCqfou7NAzeVZ0Fp+AJQV20BYexROnaCJwU+etF2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BigqCqfou7NAzeVZ0Fp+AJQV20BYexROnaCJwU+etF2A@mail.gmail.com>
X-CM-TRANSID:Mc8vCgDn_1hhCtVmQStLAA--.41797S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa73kDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhlOZWbU5NNHqQAAsb

On Tue, Jul 02, 2024 at 07:56:03AM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Tue, Jul 2, 2024 at 3:18 AM Shawn Guo <shawnguo2@yeah.net> wrote:
> 
> > I do not see "fsl,imx8qm-irqsteer" in the patch.
> 
> I sent a patch for it yesterday:
> 
> https://lore.kernel.org/linux-devicetree/1c1e3224-1b3d-438c-bce4-56143292462c@kernel.org/

I applied the series.  Please help push the bindings update to get
landed.

Shawn


