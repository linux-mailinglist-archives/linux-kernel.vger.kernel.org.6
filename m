Return-Path: <linux-kernel+bounces-277668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC194A483
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D18281564
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460E1D1733;
	Wed,  7 Aug 2024 09:38:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E031C9DC8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023494; cv=none; b=l9CsI+8vaegqNVppXXGvUakmItKzwhCbKs3doRxbhr4zcJdAUBUlKJDCqKjNVF/FqzjXE0XmdSeJlxEW5aRWpBwhLxnHI1oA1m9g3Y073NaI8gmHtilyCj0J3TMAnudJ67mRmup+lcyT2Ao9mYbU94P/QTFkGHdmSz/kDEkkvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023494; c=relaxed/simple;
	bh=Rs33dyjAvVlGc5O6g7CUWWZS4Bvxw/wNFjp4a0QHVWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pd3egvsLmVg7l4ccr2NSyG1n0S1S18LyUAGiNg/MC/3eCfVfv9EfnPUQj8f+1a9upi5mfCFGDh76wTly00DP8YV9cT4cPjEzAGnk42E5uLOjo0a+ipS+f/QmTH79FUVHMA5LbHif/XhyHjnFt3JD6lqX1DSCN4eMiH8nZ6t31YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1sbd7K-000899-AN; Wed, 07 Aug 2024 11:38:02 +0200
Message-ID: <20dc2cd4-7684-4894-9db3-23c3f4abd661@pengutronix.de>
Date: Wed, 7 Aug 2024 11:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240806120517.406714-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240806120517.406714-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Oleksij,

On 06.08.24 14:05, Oleksij Rempel wrote:
> Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> subnode name. The previous name caused the configuration to be
> applied to the wrong subnode, resulting in QSPI not working properly.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> index 3938d357e198f..4db684478c320 100644
> --- a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> @@ -123,7 +123,7 @@ flash@0 {
>  };
>  
>  &qspi_bk1_pins_a {
> -	pins1 {
> +	pins {

As you have seen such device tree overriding is error prone and would
be entirely avoidable if specifying full board-specific pinctrl groups
was allowed for the stm32 platforms instead of override-and-pray.

Anyways, there's better syntax for such overriding now:

  &{qspi_blk1_pins_a/pins}

which would cause a compilation error if pins was renamed again.

>  		bias-pull-up;

There's bias-disable in stm32mp15-pinctrl.dtsi. You may want to add
a /delete-property/ for that to make sure, it's not up to the driver
which one has priority.

>  		drive-push-pull;
>  		slew-rate = <1>;

These are already in qspi_bk1_pins_a. If repeating those is ok, why
not go a step further and just duplicate the pinmux property and stay
clear of this issue altogether, provided Alex is amenable to changing
his mind regarding pinctrl groups in board device trees.


Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


