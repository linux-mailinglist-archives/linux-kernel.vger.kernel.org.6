Return-Path: <linux-kernel+bounces-216584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFF90A1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96EC1C20F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB41D27A;
	Mon, 17 Jun 2024 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="SHU5LOIO"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF26610C;
	Mon, 17 Jun 2024 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588393; cv=none; b=O++V7wAmq3H3EloJJPZevoS3n2K7Q2m4yeMbcCRMWYPL2ioiahugrk4sqvS/0/uG04P9L5eUUZF4/pZOy/In7ReRaYBm2jx2rdEJHNzwff0/1+Ci+UTuGyKVwd82l8medg/ieHDwYUlstAT0Lz38/S2vhaEcGW+fzZFEsfQcaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588393; c=relaxed/simple;
	bh=chHB4K5e/KhG9RamBUJG4lk7r5XF+mO524wLBWR0oWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izh4Lb/lfb0g30INBFTuXRhmhd6RCfXtm8uLCkEyiFmoMJVCu/9B6G4sPkLsg3W0LbS3gTzbYKzdJN+Sr43gQdOD1V20TwRVZc1cfaxjgG4MJ74M1nzYtbdiFB8IHmZ8S8C13GiGcIJLkwG1UZg2LsSpTrlKxV3nfIdaXdpB4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=SHU5LOIO; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nmo4LZa4f+ke849HrHa0sDohJipa88iAo1w8uLmnG2Y=;
	b=SHU5LOIOQqerZVdPpmCPmDkCpwnCMYz3ChViEcfacPcNvTGk44m1imtZDG3MaW
	iX/KgHz5YkFtAGB/ePFi/iFFa1EDXOePd446Ko4lAtqcSktuRVsACt736o/IclWm
	Jyij00hDU7kMDrX3ylib7VaKkz1w7cUJtfBxuJXJGopO0=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrABnzvrOk29mF54LCA--.41752S3;
	Mon, 17 Jun 2024 09:39:27 +0800 (CST)
Date: Mon, 17 Jun 2024 09:39:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/13] ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
Message-ID: <Zm+TzS6+ZByF3MHt@dragon>
References: <20240606090206.2021237-1-mwalle@kernel.org>
 <20240606090206.2021237-2-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090206.2021237-2-mwalle@kernel.org>
X-CM-TRANSID:ClUQrABnzvrOk29mF54LCA--.41752S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy3XFyfAFW5Xw1fArykGrg_yoWkXrg_ua
	yxWan5Aa10qF98XryUJr18JF13Kr1UWr93tr1avFnrZFyav3WxXasIgayjyr45GFW5KrZ8
	XwsxZr4Yyr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8BnQUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg8BZVszYrtxowAAsG

On Thu, Jun 06, 2024 at 11:01:54AM +0200, Michael Walle wrote:
> The iMX.6 cannot add any RGMII delays. The PHY has to add both the RX

s/iMX.6/i.MX6?

Shawn

> and TX delays on the RGMII interface. Fix the interface mode. While at
> it, use the new phy-connection-type property name.
> 
> Fixes: 5694eed98cca ("ARM: dts: imx6qdl-kontron-samx6i: move phy reset into phy-node")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> index 85aeebc9485d..d8c1dfb8c9ab 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> @@ -259,7 +259,7 @@ smarc_flash: flash@0 {
>  &fec {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet>;
> -	phy-mode = "rgmii";
> +	phy-connection-type = "rgmii-id";
>  	phy-handle = <&ethphy>;
>  
>  	mdio {
> -- 
> 2.39.2
> 


