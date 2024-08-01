Return-Path: <linux-kernel+bounces-271438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92484944E42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E52E282C86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C01A57E9;
	Thu,  1 Aug 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzCLO2ja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2F16F0DF;
	Thu,  1 Aug 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523374; cv=none; b=HO/DK/uL8iJUb3Ayrt6RYeArviop4/KASD2Q4gR9bomnc3Y4Jc4UDy9abNJ11CVrzpi1fkXQRSi2k3XLfsuUluLIj0p2phacXtJk7/3rkA9GNrhkG37BxBYGB8Zem8axW+hMoHF9XLFPr1UnkzfHY8pLGJ9Brmbx+1ulBxliqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523374; c=relaxed/simple;
	bh=vsnUwlDgswKtPBEdrjKpAt+f6RKHkVBuq8cL70YdSG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK6/GFWFefBXTpZhWdrdTzZY+rCu19lJxeVhZQscg4kUdDom1PGl/r1Nf3wYa7xAUsjfJG1aTh8HMKh/u8gITA7abZbS+Nyi2hght+fDh/FBJFeiuBZXJDDZlAH0c6KfhW45iLXsxyt5ImB+xdn6B8cetR0m733duBz48jOOJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzCLO2ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3804C32786;
	Thu,  1 Aug 2024 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523374;
	bh=vsnUwlDgswKtPBEdrjKpAt+f6RKHkVBuq8cL70YdSG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NzCLO2jaQhboFa+G3aQ1PGn7LcVVTcRFUFzup4H4cV1egI0rq8yijOzxu/d+2Eeic
	 r8LIjNqLWW1Fk6MD7jRrN7fU9kffP9En2Jin8T9g8PDSJnlso3xuFq8ju/1ycQP+5T
	 7J8Dn2PBUIrWwJkKwfF0L8zt8kFnBHu/xc1zZQqFxD2SzhbgT6he3jRqBpzvMOJ7TZ
	 aWWKH3OtS7gkuh/5rCoPUNMO3/aTjOgOc2Zw6T5q37VWSB+U3GMZr9cLTzxgg4/gKj
	 EQFyS343MgD2+HQ1Xmr2m0lkrhVsrj8QbrtCq7fgtHb7+rMrTC3V+PSPN6ZhrJqHlY
	 Xiu1bLiEyJo0w==
Message-ID: <b738737e-ff71-434e-a27d-2f7056416c74@kernel.org>
Date: Thu, 1 Aug 2024 16:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: nuvoton: add new driver for the Nuvoton MA35
 SoC USB 2.0 PHY
To: Hui-Ping Chen <hpchen0nvt@gmail.com>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731014313.113417-1-hpchen0nvt@gmail.com>
 <20240731014313.113417-3-hpchen0nvt@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240731014313.113417-3-hpchen0nvt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2024 03:43, Hui-Ping Chen wrote:
> Nuvoton MA35 SoCs support DWC2 USB controller.
> Add the driver to drive the USB 2.0 PHY transceivers.
> 
> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>


> +struct ma35_usb_phy {
> +	struct clk *clk;
> +	struct device *dev;
> +	struct regmap *sysreg;
> +};
> +
> +static int ma35_usb_phy_power_on(struct phy *phy)
> +{
> +	struct ma35_usb_phy *p_phy = phy_get_drvdata(phy);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(p_phy->clk);
> +	if (ret < 0) {
> +		dev_err(p_phy->dev, "Failed to enable PHY clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
> +	if (val & PHY0SUSPEND) {
> +		/*
> +		 * USB PHY0 is in operation mode already
> +		 * make sure USB PHY 60 MHz UTMI Interface Clock ready
> +		 */
> +		ret = readl_poll_timeout((void __iomem *)p_phy->sysreg + MA35_SYS_REG_USBPMISCR,

sysreg is a regmap, not io address. How could it possibly work and be
tested?!? This cannot work. Test your code *before* sending it.

> +					 val, val & PHY0DEVCKSTB, 1, 100);
> +		if (ret == -ETIMEDOUT) {
> +			dev_err(p_phy->dev, "1.Check PHY clock, Timeout: %d\n", val);
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * reset USB PHY0.
> +	 * wait until USB PHY0 60 MHz UTMI Interface Clock ready
> +	 */
> +	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, (PHY0POR | PHY0SUSPEND));
> +	udelay(10);
> +
> +	/* make USB PHY0 enter operation mode */
> +	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, PHY0SUSPEND);
> +
> +	/* make sure USB PHY 60 MHz UTMI Interface Clock ready */
> +	ret = readl_poll_timeout((void __iomem *)p_phy->sysreg + MA35_SYS_REG_USBPMISCR,

Same problem.


Best regards,
Krzysztof


