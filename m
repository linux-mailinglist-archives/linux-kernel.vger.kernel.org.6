Return-Path: <linux-kernel+bounces-392017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7B9B8EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D171F21AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69715CD52;
	Fri,  1 Nov 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bIaQQQXx"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2514F9F8;
	Fri,  1 Nov 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455749; cv=none; b=EMIfqNvut8YFbBZYklRQVhO0turlAiwfzI7YS3akEPinJ8T6XFW3aQ9QpwLXw1ll+doScfF/7wzkocbqGlaZxUMQ+VUbyOdAX2yVAWE3Ok7sxgzaMknpNplnQ8C0bE1g02X1zgEheJgm0dO9RpNwoNDGIj5PUEKrXWNen/Hv/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455749; c=relaxed/simple;
	bh=nW/mQxNwm264CJ22U0gw45sBe2y1ZlHGFdDBwkSx2MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9F3NONBw8DmNSGKZV2KY5qMTP+vKB72a/OgP5E5FDlAoew0v23QU5ry+23FVYvsP9w3qSC/CD93+8uiVWXijQeZ7vUudy6JAxuVhWPIMI7ixf38izDzlVHtwHyBuSR6ykR0CfBoukfqxtnktTYcXM0Z4cgQyWw14d272xvLTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bIaQQQXx; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/jeTvbrAuhoLK4d33DI8+BzUn2SEMto7euH+TT/645M=;
	b=bIaQQQXxWzhuVJceZQ4+XJQM/VRQVYlKCMVZV9A7Yuf1HaKlyHKhoCkuCj5Kst
	niPBM3jCNyEw4aY1dV9dgEV12vomRW0rJIvB6Zh49Xj+dl1hemUu3WBMNiIZiEwX
	5LQnG6ZrYMGZVRCKakhpT022ijMwbfT/80YTXlJjanua8=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXqg5_qCRnRkpkAQ--.13732S3;
	Fri, 01 Nov 2024 18:08:01 +0800 (CST)
Date: Fri, 1 Nov 2024 18:07:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: frieder.schrempf@kontron.de, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp-kontron-dl: change touchscreen
 power-supply to AVDD28-supply
Message-ID: <ZySofxHCDFMySPS3@dragon>
References: <20241023152637.1301847-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023152637.1301847-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgAXqg5_qCRnRkpkAQ--.13732S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4ApeUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwCKZWckj-1HagAAs4

On Wed, Oct 23, 2024 at 11:26:36AM -0400, Frank Li wrote:
> Update the touchscreen power-supply from 'power-supply' to 'AVDD28-supply' and
> 'VDDIO-supply' as per the binding documentation in goodix.yaml.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtb: touchscreen@5d:
>     'power-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/input/touchscreen/goodix.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


