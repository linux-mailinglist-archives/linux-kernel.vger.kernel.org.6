Return-Path: <linux-kernel+bounces-391982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1559B8E29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC734B222AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4F15C13F;
	Fri,  1 Nov 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CJ3teuCV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCD42C0B;
	Fri,  1 Nov 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454566; cv=none; b=gpo5NtvojGkrkydrzbhlnYG/rY7iZa57MLfAcVob64SCzn14963jTiTpjdi7GTYeLenOq2qo+f0KaLhOQaxslePPOWd9pqwmsGAaZWosiCulYoe65Mlo5Y6TqYTTYScOP7SGDigYcmsZaGU9CCdZ17yjZnmU1lY/hxf72w8xJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454566; c=relaxed/simple;
	bh=tIjeF0eix8nbfRW8y1gE3n4C3MRQR8Pe+zuD9kbXwhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLDpIKm+ANkMBapI8q6DVKd1CsB5KR3aGA7iI0hR34iAxteQWeNtHKXApLseq3xerhQVvWFUzMMgJODbW4GMArqiGkzej6ZHjlOpoBve0LbLgyzFR5Cd5gpZ2dgwytTyQ5A1Za86WUwj1U1JDRB7f7Sh3sih9kxQUr/vwIt+9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CJ3teuCV; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xLbFvxO9wbFKIlHLG0ze0IRckOOUzPQ/fxFGtuwV3QU=;
	b=CJ3teuCV74Kij0nIv/QJ78QgPOMCAtiUCCmWMjrqSIiBXombK+q+II3fIjoUxH
	xz/sn4mCMGD9Vrb8DyrFFn/aQJpZ2qEgO3nsrKwNM/yStUXwHAsOdUqyPHpTa+v8
	1CSNp8ALf7kvsHnsbwP49vR+/tHhTx85/3YfD7LudL9jk=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXje77oyRnJPxjAQ--.14016S3;
	Fri, 01 Nov 2024 17:48:44 +0800 (CST)
Date: Fri, 1 Nov 2024 17:48:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexander.stein@ew.tq-group.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8: move samsung,burst-clock-frequency
 to imx8mn and imx8mm mba8mx board file
Message-ID: <ZySj+lVvO4eBjDjj@dragon>
References: <20241022220429.1281129-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022220429.1281129-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgCXje77oyRnJPxjAQ--.14016S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW5ZFykAryrAFy5uFW3Wrg_yoWfAFg_CF
	y7Ww1Dur43AwnrKwnIkrW0k34jk343ZrW3Jr1ftrnFyw43u3ZxAFykt3s5AwnrGF4IgrZr
	A3yrAas3A3yfKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8k-PUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhqKZWckfBh4iAAAsg

On Tue, Oct 22, 2024 at 06:04:29PM -0400, Frank Li wrote:
> Move 'samsung,burst-clock-frequency' and 'samsung,esc-clock-frequency'
> properties to i.MX8MN and i.MX8MM mba8mx board file. These properties are
> not applicable to i.MX8MQ MIPI DSI, which uses the compatible string
> 'fsl,imx8mq-nwl-dsi'. The properties are only valid for i.MX8MM and i.MX8MN
> devices with the compatible string 'fsl,imx8mm-mipi-dsim', as described in
> samsung,mipi-dsim.yaml.
> 
> Fix warning:
> /arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb: dsi@30a00000:
>     Unevaluated properties are not allowed ('ports', 'samsung,burst-clock-frequency', 'samsung,esc-clock-frequency' were unexpected)
>         from schema $id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


