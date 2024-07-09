Return-Path: <linux-kernel+bounces-245793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D792B959
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256DC1F25DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E0158A33;
	Tue,  9 Jul 2024 12:23:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645EE13C687
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527835; cv=none; b=E6qr/P68BcG3OMOc4Ru7Y0yR018trXWZ7KDHYLNrHQApxY3l0YX2TsIvSmbCLNvziNWAl+aOFO6ctALEMKJk8oCvHCBMFftbfzMRsJ+LhRSzrQqMbvyIgS20nmEPjxrZOW2t+Rn/xSVjMFk8t2j6Kz5XNay99m1h/6HXGZ+/Kuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527835; c=relaxed/simple;
	bh=2uIdGNthO8fCtFFjFrKsg/sGLVUFtY4fWkTdM/n0HaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN3dk/EDF9wak5z8vGTH0hIsXIcglv5eTjsQzN6nRreOyzcrqySx6TjWKyxwyDuxCulLI/pA4+YOPAalRyArOqsVqxFMbxFF8vg2mzUDyX2OMpqqLa4RbEhYvgtinyP/qjsgwJ7JKd9ulgVg0ThHPRhocXtQsU6XrKTGk8hePq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1sR9se-0002hP-Jl; Tue, 09 Jul 2024 14:23:36 +0200
Message-ID: <f9aab3f2-47d5-4c1b-ad0b-53c711701577@pengutronix.de>
Date: Tue, 9 Jul 2024 14:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Add missing gpio options for
 sdmmc2_d47_pins_d
To: Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240709121619.1588520-1-sean@geanix.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240709121619.1588520-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 09.07.24 14:16, Sean Nyekjaer wrote:
> This enables DDR50 mode for the eMMC on Octavo OSD32MP1-RED board.
> 
> Fixes: be78ab4f632c ("ARM: dts: stm32: add initial support for stm32mp157-odyssey board")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> index ae83e7b10232..70e132dc6147 100644
> --- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> @@ -2229,6 +2229,9 @@ pins {
>  				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
>  				 <STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
>  				 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-pull-up;
>  		};
>  	};
>  

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


