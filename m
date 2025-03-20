Return-Path: <linux-kernel+bounces-569384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9AA6A21D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A3883755
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3378219A8E;
	Thu, 20 Mar 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0ElIC1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAC1A238C;
	Thu, 20 Mar 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461804; cv=none; b=qfZu81Vs7PLl6vjP4O2gbOn7qB2Hyv0qO/0KSwOZLYwxYa6uNBx8+Q9lJWs6Ji7VgY9RNcD8AermnjNkfKW4rGm8ZlkCCnaIumPJqFmniqv90olEW9ZYTU5HQMbH1frwLa1ow210RR4HbtdlzbN5HoHFdCIwPiZjdTr8bjDCHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461804; c=relaxed/simple;
	bh=N/WCH9wLdNAYNBgfMktBPcK72cJ6FTGefuujzbktXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0jLQXj4Pc1ZfcnnuEd8uV7FTijxklmbS+cLTEbJkRHKuzI4HkG7UemlUWhmHIfsxcpWtyPWk7upLpn3WOSsZfOCqTnVmi6zbVf4Aowylj61lr6te4AJvk4l+ODfvq51KlfKmCQNB4Z9aRtL9POhhkdRLUzbEqQgACYQuSDwj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0ElIC1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D39C4CEDD;
	Thu, 20 Mar 2025 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461803;
	bh=N/WCH9wLdNAYNBgfMktBPcK72cJ6FTGefuujzbktXZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0ElIC1kZ9K0wnZ8vZnVCo9bhMYuZDBUMxD3iFbU9JyNva2IIxiRlE00zLKx82kgS
	 3MVM8SSK6BD+dMyf/XjFlNoyQeRk4E4E9hubQbEUgw8pW3oVei/3iOpGrBvKA3Uugl
	 wIP711CM0Qyj1EMVcDr6HYCTwsc6GMqYGSWOWioxUizddvYAZicKHLLBtm8fAAFE+1
	 EBbp1TWvjELZPldGEyQTCbQpcR2uOCpZ6r3OzQXDGX2ASujUirr6FKS23Fz3jOcqT6
	 1ERrg1fbITyWRgBYSXMMbihOJiLsOIz0ShJOjx9OeuiZo16CUdT6PnnZ05Un7KVxWD
	 AYEdXto7IFYjA==
Date: Thu, 20 Mar 2025 10:09:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: adp5055: Add driver for adp5055
Message-ID: <20250320-flawless-sambar-of-aptitude-395df0@krzk-bin>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-2-aac2d3705802@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-upstream-adp5055-v2-2-aac2d3705802@analog.com>

On Thu, Mar 20, 2025 at 02:53:55PM +0800, Alexis Czezar Torreno wrote:
> +#define ADP5055_REG(_name, _id, _ch) \
> +	ADP5055_REG_(_name, _id, _ch, &adp5055_ops)
> +
> +static struct regulator_desc adp5055_regulators[] = {
> +	ADP5055_REG("DCDC0", 0, 0),
> +	ADP5055_REG("DCDC1", 1, 1),
> +	ADP5055_REG("DCDC2", 2, 2),

Nodenames are lowercase, always.

> +};
> +
> +static const struct of_device_id adp5055_dt_ids[] = {
> +	{ .compatible = "adi,adp5055"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adp5055_dt_ids);
> +
> +static int adp5055_probe(struct i2c_client *client)
> +{
> +	struct regulator_init_data *init_data;
> +	struct device *dev = &client->dev;
> +	struct adp5055 *adp5055;
> +	int i, ret;
> +
> +	init_data = of_get_regulator_init_data(dev, client->dev.of_node,
> +					       &adp5055_regulators[0]);
> +	if (!init_data)
> +		return -EINVAL;
> +
> +	adp5055 = devm_kzalloc(dev, sizeof(struct adp5055), GFP_KERNEL);
> +	if (!adp5055)
> +		return -ENOMEM;
> +
> +	adp5055->regmap = devm_regmap_init_i2c(client, &adp5055_regmap_config);
> +	if (IS_ERR(adp5055->regmap))
> +		return dev_err_probe(dev, PTR_ERR(adp5055->regmap), "Failed to allocate reg map");
> +
> +	for (i = 0; i < ADP5055_NUM_CH; i++) {
> +		const struct regulator_desc *desc;
> +		struct regulator_config config = { };
> +		struct regulator_dev *rdev;
> +

Where do you parse the 'reg' which you said is a channel number in the
binding?

> +		if (adp5055->tset == 2600)
> +			adp5055_regulators[i].ramp_delay_table = adp5055_enable_delay_vals_2_6;
> +		else
> +			adp5055_regulators[i].ramp_delay_table = adp5055_enable_delay_vals_20_8;
> +
> +		desc = &adp5055_regulators[i];
> +
> +		config.dev = dev;
> +		config.driver_data = adp5055;
> +		config.regmap = adp5055->regmap;
> +		config.init_data = init_data;
> +
> +		if (adp5055->hw_en_array_gpios)
> +			config.ena_gpiod = adp5055->hw_en_array_gpios->desc[i];

So a GPIO per node thus enable-gpios in each node.

Best regards,
Krzysztof


