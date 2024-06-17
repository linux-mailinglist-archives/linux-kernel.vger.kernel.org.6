Return-Path: <linux-kernel+bounces-216625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82090A25E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3AE1F216BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0122176AAB;
	Mon, 17 Jun 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PsDFP1S5"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D9229D19;
	Mon, 17 Jun 2024 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590447; cv=none; b=nRhsxJO09PHW+7oDiaENRAU3q6pNYRj2lfYQfIRV2biiPNMsywUvRaPd/l7zZXiO8eYOE7u9siwrIbQiTp+C4Hvx13iYG8dNlE56lQizAzT18lns1lsCNSgY64GpEwBd+x+wZ5HknYR3E/Vj1LG9pCzU9sz+2PTQL9zjPvlkpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590447; c=relaxed/simple;
	bh=+ChJNRRhh6Ooomnz0uf9uVFqgEdgCQiqOFIj1PoFZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWOiPU/+nv0MKEDc5oSYLkI/tV4A6uaie4d6GlRaaubJokRWSnGgojIijiPqUAVpHF+4FEp0LZDF0qTviB3WOqZDYvlsKx5eGkyTKR0LZ3SCPs7qgAhgTXAGBCkkwu3kCk42vwP16jBYjKsDttbLIejk18Q6ggUspi3DFdzOMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PsDFP1S5; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=71gC8yDm4k7eZg1Y0V9ZDsb/7u05Sw61OERK9LlIG18=;
	b=PsDFP1S54lW+pwukb5k3tc5SV2Jw46kJRjPpnqYwFwRmZVAvbtt+iviZoNH2xF
	DGDyURIWlyq1Gh7gNhWV2Z7Uc/Ob91WNcZanfkdjiAJxj031n3GXZeGs/IR1Q5Cm
	Cihwi4BfUOirsyhFUNExNam2O1YCnvfCQlKJqcm3aVZrI=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAC3H_XOm29mtfXNCA--.38477S3;
	Mon, 17 Jun 2024 10:13:35 +0800 (CST)
Date: Mon, 17 Jun 2024 10:13:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mp-verdin: add HDMI support
Message-ID: <Zm+bzkh7CgBuFs53@dragon>
References: <20240610141001.32034-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610141001.32034-1-francesco@dolcini.it>
X-CM-TRANSID:C1UQrAC3H_XOm29mtfXNCA--.38477S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3zVbDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxIBZVnxc0yGvAAAsU

On Mon, Jun 10, 2024 at 04:10:01PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Enable HDMI output on Verdin iMX8MP on all the supported carrier boards
> (dev, dahlia, mallow and yavia).
> 
> HDMI DDC I2C is used in regular I2C mode, see link on the related
> dt-bindings patch.
> 
> Fix CEC and HPD pinctrl, having a pull-down on HPD and a pull-up on CEC.
> 
> Link: https://lore.kernel.org/all/20240515062753.111746-1-marex@denx.de/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks!


