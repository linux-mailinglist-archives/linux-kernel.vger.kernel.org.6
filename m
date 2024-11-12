Return-Path: <linux-kernel+bounces-405469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882149C5211
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D57B2C22A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CCC20CCFF;
	Tue, 12 Nov 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vICjfThp"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A720822B;
	Tue, 12 Nov 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403297; cv=none; b=s1VTZQuOZwO9PnDDQv64K23xmTxzjLrXxhiUjkovEmLtUaWdPk3koY2mgzNFRLON8X2pzUoxwsgNsW0VctlwJspb3uFgbGaLPArJ+LYVW6GClMfF+WQi0obI6qxxjG9V80COjrxHKsceikH9wOFGQ1kOaPdD622Yq+lJqze7/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403297; c=relaxed/simple;
	bh=q6sUNujCAGQ84ZsUtouhoj460+E/ZoNqg/e8MU8HfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9sOxv1FpiIytEZQQUVSYchGX/s5R7FqUtcS/AuzoqoXEM0gpYJ+QE5riWxh51b73RrBMlZo5HXjojaVLT/oU2Qjg0wgyE3/Eu92C+BufF8qS5eQVkZFJVms8qMOpCKbXEobY8dYtd/XR9acAGD+KfIHlx0Qz5r85QcqMi28qIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vICjfThp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1NDuG/Ek6UwySU5b5S9VUet0r8r0uWRHJmv4yhmBVac=; b=vICjfThpB44W/UUdv+m/03XqST
	kRqQU358wC2WI5j6oEd8cUW80bnT9aTrEjBnSdiEqtH9kn/nqh5uOjLmdrECxfhHGwxIKJRv2VjKA
	kJsiVla4+ogKtXR0sRTSMZOpq/9MZDHLtEa7ZyN1o52dpwrgQYqlFtoGndKN73UvlH9q6I04malso
	YD0niXMR5e9Eq8FUasGM64qwKva0Ng3OiLSGnfmSRbysk4YgIgPltJZqyVwdAdfLuSQIIOClBjyEN
	YJlpdPb3vaVmHC/F216LKeiYlWD01YisBirqDKOCCFCFXygPQYq4I9MIGEKy24RicEwfCEirNJinm
	PlBeVOlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAn5P-0003oM-2J;
	Tue, 12 Nov 2024 09:21:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAn5M-0007LA-34;
	Tue, 12 Nov 2024 09:21:20 +0000
Date: Tue, 12 Nov 2024 09:21:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, salee@marvell.com,
	dingwei@marvell.com
Subject: Re: [PATCH 1/1] arm64: dts: marvell: mcbin: fix PCIe reset property
Message-ID: <ZzMeELwScAMdrkQ6@shell.armlinux.org.uk>
References: <20241112072049.765097-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112072049.765097-1-jpatel2@marvell.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 11, 2024 at 11:20:49PM -0800, Jenishkumar Maheshbhai Patel wrote:
> Set reset gpio to active high
> 
> Fixes: b83e1669adce ("arm64: dts: marvell: mcbin: add support for PCIe")
> 
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index c864df9ec84d..a8c732a47360 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -181,7 +181,7 @@ &cp0_pcie0 {
>  	pinctrl-0 = <&cp0_pcie_pins>;
>  	num-lanes = <4>;
>  	num-viewport = <8>;
> -	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
> +	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_HIGH>;

Is this change due to switching the driver to use the reset controller?
If so, NAK to all the changes - DT files are meant to be forwards
compatible (older DT are supposed to work with newer kernels) and it
would seem this would break that rule.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

