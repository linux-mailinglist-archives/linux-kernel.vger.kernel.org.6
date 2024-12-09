Return-Path: <linux-kernel+bounces-437488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03299E93F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC23B1641EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418942236FD;
	Mon,  9 Dec 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bI/DGTJR"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65D224894;
	Mon,  9 Dec 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747399; cv=none; b=RO3X/yUwaNH8mSBwJbAn9yalMGkW9CsmI4Qy5tgIYtn21vackYby+4P4jxeiRWBJGDhf6Fr0RrRh92gePTgu/OTEW6vwMMn8bMjMHdaEUBA0h0e8QiqYa7jNdrrV3SuAI6QD4Bau7EYXWu6pnasEogLXeazFFJl1Y5Ccj3GJ6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747399; c=relaxed/simple;
	bh=N+sbYCFuTDwxCcIdAHgel3ganW/gZZAhgHHI2UMTGbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU/JH/NUg7sKwoV2VCkwMTeOuMbe5Uqo7JaTtPkDBW7YA910dIJmUwRnYVK04zvBGFlcp4V8BAFOJ32y9NPXjmsUTQ/8efd6XKVVNAolVc8kR1BkQpuMuZ+kJHKpNGMOol+0OCJ3CQw2eSZKavWGWs9Lsi24syvqmLaf+e0Xip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bI/DGTJR; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=c0w54vZT7PKG1XWtN+/uhpQiw/mRzqEusnhno0TxGLE=;
	b=bI/DGTJRzhytnyCFnnV41Vgg5thANKUze3OAJoHEzQveY2ntPLmOtvUm0FYmYM
	nI2pXExwzoqttNzaW7gMJxZd6Ntlt07qxUypqMX4pT+1yaBs4MWctSheD3e6Tgrm
	Q9rjqNgsNE5l32YTxaJVdvBO7f6vibbzAtBQHXEVp6Frg=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3vzGp4lZnf959BA--.46916S3;
	Mon, 09 Dec 2024 20:29:31 +0800 (CST)
Date: Mon, 9 Dec 2024 20:29:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: Remove unused and undocumented
 "cooling-(min|max)-state" properties
Message-ID: <Z1biqf24yH6HCl8Y@dragon>
References: <20241115193504.3619533-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115193504.3619533-1-robh@kernel.org>
X-CM-TRANSID:Mc8vCgC3vzGp4lZnf959BA--.46916S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxGF4kurWfCrWkKrykZrb_yoW8AF4kp3
	WkZa95Wrs7WF1aya4qgr18Kryq9ws8JFn5ur1DWry3tr43Z3WjqryYk3Z3WF47ZF4fCw4F
	gF1Fqr10vF1YqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaVbkUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh2wZWdWz70tEgABs3

On Fri, Nov 15, 2024 at 01:35:03PM -0600, Rob Herring (Arm) wrote:
> Remove "cooling-(min|max)-state" properties which are both unused in the
> kernel and undocumented. Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

A similar change from Frank [1] was applied, thanks!

Shawn

[1] https://lore.kernel.org/lkml/20241007220542.897605-1-Frank.Li@nxp.com/

> ---
>  .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts   | 2 --
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi             | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> index d9fac647f432..1d53b529af88 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> @@ -19,8 +19,6 @@ / {
>  
>  	pwm-fan {
>  		compatible = "pwm-fan";
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  		pwms = <&sl28cpld_pwm0 0 4000000>;
>  		cooling-levels = <1 128 192 255>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> index d32a52ab00a4..aef63a4f698c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> @@ -94,8 +94,6 @@ i2c@1 {
>  			fan-temperature-ctrlr@18 {
>  				compatible = "ti,amc6821";
>  				reg = <0x18>;
> -				cooling-min-state = <0>;
> -				cooling-max-state = <9>;
>  				#cooling-cells = <2>;
>  			};
>  		};
> -- 
> 2.45.2
> 


