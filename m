Return-Path: <linux-kernel+bounces-437530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D659E9476
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DA118878D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5282248BF;
	Mon,  9 Dec 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PkXEga3K"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2A22068A;
	Mon,  9 Dec 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747918; cv=none; b=fGxDXGU+JQGJkvWTXIhoueePsRL73d42CN8IsCzIpJ6eugaXViO4ir9XATThVWr8GUZn4gA8DSUD0g1FnEMV80fXiaXH1hLCgG9gSMYpFs/XrSrwzaXY8wmVizReaT7/hMbDQmaCjK+2gENSqQOsZuY2Go2dfSOQ9QYPWoYmrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747918; c=relaxed/simple;
	bh=Uasg6/SNEB69YisucaqWqZZ4VUkZJjS9utpq28O7SvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehJJZv0MO+i5GqDtlPYysOHj8YvZXbHwevZ+CBCo02ljxrtvEtOBjNN3Eow7wloBg+PgfnaMNwI8IBV9Cc8qzVZCHd2yUUWVflcSZsCGS2xhZe7YJl4NrVKuq26GhA2pjefRQKR6GMS5ER9diSZxkWLbeaq8AmXZT94WHRh8eQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PkXEga3K; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HSQa61tbPwqUeRkPuD+XeddE/YYm1t+0527lCAZDVbQ=;
	b=PkXEga3Kr1UJDtXcvvImu3rh8lbk6jQ3qSI+Nv8pWYbSjyWijbWI1zNS2b6FXw
	SaUc/oBI2Yd9+GHRQBr0E3brsRRZLTwlc0DCgx74rVHm+MruRW7Gdgy1jnCnZ7lL
	zFdaDfhnDnmaTxVUspnF27OpyAyHJyk9z3Tfef3zewdno=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXEPCL5FZnDnZzBA--.46129S3;
	Mon, 09 Dec 2024 20:37:33 +0800 (CST)
Date: Mon, 9 Dec 2024 20:37:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: abelvesa@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, shengjiu.wang@gmail.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
Message-ID: <Z1bkixjbyFhH3ZgL@dragon>
References: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
 <20241119015805.3840606-4-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119015805.3840606-4-shengjiu.wang@nxp.com>
X-CM-TRANSID:M88vCgDXEPCL5FZnDnZzBA--.46129S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW5XF15XFy5Ar4ruw4DArb_yoW8JFWfpF
	yfCr43Jw1vgF1rC3sIqr1Sq3s5Gw43GFs3uF45XryUt3y3uryIqF4Sgrsagw1xXr4fuw43
	tF12qr1UJ3WrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz7KsUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEROwZWdW4JcK1gABsM

On Tue, Nov 19, 2024 at 09:58:05AM +0800, Shengjiu Wang wrote:
> IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which
> missed the clock gate part.
> 
> IMX93_CLK_SPDIF_IPG is the correct clock.
> 
> Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Hi Abel,

I guess it would be the best for you to apply the whole series through
clock tree?  In that case:

Acked-by: Shawn Guo <shawnguo@kernel.org>

Thanks,
Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 688488de8cd2..56766fdb0b1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
>  				reg-names = "ram", "regs", "rxfifo", "txfifo";
>  				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> +				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
>  					 <&clk IMX93_CLK_SPDIF_GATE>,
>  					 <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
> -- 
> 2.34.1
> 


