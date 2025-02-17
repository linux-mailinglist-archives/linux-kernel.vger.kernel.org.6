Return-Path: <linux-kernel+bounces-517328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B958BA37F47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F127A3FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409F21766B;
	Mon, 17 Feb 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UTFWmIGp"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A2217666;
	Mon, 17 Feb 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786530; cv=none; b=ek+k0tjqYNtIt38YcHPg+U+EY4ds1BNjUlDx1NIcFjFAFSbCSTJsUICw0Nfejre/BzDJzp8xFsQ63j+z7UDCOgRJ7Ad0wYQzjiBcCLaS/WzIvE9+GPtpUCpjk7xa4es9oiCWa9UgU70FQSE8BCux3Ob6r+OswNFKQ07uzdLRx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786530; c=relaxed/simple;
	bh=3Pn2XY0R5r/pkW9Wa6PkniaTqmqz1SSKpcWPRAAjRpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYJ3DscNDM1vbHB6DjE4dPhFHtqK88EIbcRh5lcfN3iKMFnZbd+j6iUnxgSg979nicICvxanwUMynDUYyL52QZlGq6K+hMs7MFAE+HuxS2GWUXfjZ7RAbyT25G+uVlcuaa1BIPHT2M3FVTg+qYSgHErJZWb2PREbQScNunid+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UTFWmIGp; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=cWvBvJY/V1Stch0H93wsamiErQGrI0aoePeCBYg4NqA=;
	b=UTFWmIGpiWYlPHdNS4u/Y1OSiMDcjea6jJG5r6XMeLCd5gWcxzFzvpodReDC5t
	p0CStdUGEBRMCJUzAKh/NHr1q/6WWp+Du/cPe5qtNMMOrTGECnAdoK/xfw5UTdbJ
	aYIh10M9KSkqJVySYW0O2WAIZoqrihbiXSb5MVuzAXQkY=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgC38fbyCLNnJaVNCQ--.19260S3;
	Mon, 17 Feb 2025 18:01:23 +0800 (CST)
Date: Mon, 17 Feb 2025 18:01:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq-librem5: remove undocument
 property 'extcon' for usb-pd@3f
Message-ID: <Z7MI8UuBconRVEyL@dragon>
References: <20241023220252.1392585-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023220252.1392585-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgC38fbyCLNnJaVNCQ--.19260S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh-2ZWey3iu+2gAAsK

On Wed, Oct 23, 2024 at 06:02:52PM -0400, Frank Li wrote:
> Remove undocment property 'extcon' for usb-pd@3f to fix below CHECK_DTBS
> warnings:
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: usb-pd@3f: 'extcon' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/usb/ti,tps6598x.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


