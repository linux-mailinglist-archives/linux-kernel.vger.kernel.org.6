Return-Path: <linux-kernel+bounces-375791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F49A9AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3555DB228D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7BE14A4D1;
	Tue, 22 Oct 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E4xyxVML"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35471465BB;
	Tue, 22 Oct 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581705; cv=none; b=oLfTmmOk4e2IIzHr5RoCGknhb7BgqdzbjtPAt9b6KWjHuRTVnPBNeOs0HtkLT4ThQYBqnmPt0vX1Aa9uDZ1Q3ordIw6g9E2mMx2desHh8JzeDxWs2urKAKZwCrfkaZMbb1H2PomMsdsbexzmhehCmxWWvfFbrk9As+vLbErN9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581705; c=relaxed/simple;
	bh=mncV6XjcLUPuWRXPPqMYWxkt3/1zcuG6fht9FXcpTgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBKK5tJPN5YHV2Od2j9kBexQe66RBuC2D3ghdhh08qwVU7nDu6YC0ElzoaTxSE1JXN04jHjv8vFNlUBqF2d2qZRASlNvkE2gtltgCzJ2qngFUQzkhH59fh4aiFPjirAeoyNLr3JVYnQduQD7rSkqEpXt42R1nGuuauxJOXOrjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E4xyxVML; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 39BptoyFQvtq839BptCJaI; Tue, 22 Oct 2024 09:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729581629;
	bh=jbeACBlKmPATg9TY9lfakh5orbRiwjpJqN6f+njt1iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=E4xyxVMLGKUcuxP9Sl0vRgZc8l0ppDa1X8iJXl/F+xBewJYFCUrXgS+sUyBezfk5U
	 Uo810xRWboULP0HeTAVTmKN19iCzuPNiAkfW32RFTzPSYKvkgO5Z/s5gze4X6u0nMq
	 UN+sn1Rt6q2kL1shkVZv7RYhi5OrX/sC3CxWjkTAkzau2dHj01iI6NJrjwRvqhc8pU
	 fQ/9FChq06JTrKg16ixQo8zC0l55lsoCRNi+ZSVHSMRx2xEPMK6tPpnnE4LuLe22yl
	 eUJXPrm/wgxLYv5tFrsUkcABOFbjShqMINvfVV90uT2xRwTHTvbm8vWUkXgAomPul8
	 E/bUg2KN5infw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 22 Oct 2024 09:20:29 +0200
X-ME-IP: 90.11.132.44
Message-ID: <2339841b-034b-440f-83ac-139d95059727@wanadoo.fr>
Date: Tue, 22 Oct 2024 09:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
To: baneric926@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
 DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
 <20241022052905.4062682-3-kcfeng0@nuvoton.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241022052905.4062682-3-kcfeng0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/10/2024 à 07:29, baneric926@gmail.com a écrit :
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> The NCT7363Y is a fan controller which provides up to 16
> independent FAN input monitors. It can report each FAN input count
> values. The NCT7363Y also provides up to 16 independent PWM
> outputs. Each PWM can output specific PWM signal by manual mode to
> control the FAN duty outside.
> 
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---

Hi,

a few nitpick, should there be a v7 and if they make sense to you.

> +static const struct of_device_id nct7363_of_match[] = {
> +	{ .compatible = "nuvoton,nct7363", },
> +	{ .compatible = "nuvoton,nct7362", },
> +	{ },

Usually, a comma is not added after a terminator entry.

> +};
> +MODULE_DEVICE_TABLE(of, nct7363_of_match);
> +
> +struct nct7363_data {
> +	struct regmap		*regmap;
> +
> +	u16			fanin_mask;
> +	u16			pwm_mask;
> +};
> +
> +static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> +			    long *val)
> +{
> +	struct nct7363_data *data = dev_get_drvdata(dev);
> +	unsigned int reg;
> +	u8 regval[2];
> +	int ret = 0;

No need to init.

> +	u16 cnt;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		/*
> +		 * High-byte register should be read first to latch
> +		 * synchronous low-byte value
> +		 */
> +		ret = regmap_bulk_read(data->regmap,
> +				       NCT7363_REG_FANINX_HVAL(channel),
> +				       &regval, 2);
> +		if (ret)
> +			return ret;
> +
> +		cnt = (regval[0] << 5) | (regval[1] & NCT7363_FANINX_LVAL_MASK);
> +		*val = fan_from_reg(cnt);
> +		return 0;
> +	case hwmon_fan_min:
> +		ret = regmap_bulk_read(data->regmap,
> +				       NCT7363_REG_FANINX_HL(channel),
> +				       &regval, 2);
> +		if (ret)
> +			return ret;
> +
> +		cnt = (regval[0] << 5) | (regval[1] & NCT7363_FANINX_LVAL_MASK);
> +		*val = fan_from_reg(cnt);
> +		return 0;
> +	case hwmon_fan_alarm:
> +		ret = regmap_read(data->regmap,
> +				  NCT7363_REG_LSRS(channel), &reg);
> +		if (ret)
> +			return ret;
> +
> +		*val = (long)ALARM_SEL(reg, channel) > 0 ? 1 : 0;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

...

> +static int nct7363_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device_node *child;
> +	struct nct7363_data *data;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &nct7363_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	for_each_child_of_node(dev->of_node, child) {

for_each_child_of_node_scoped() to slightly simplify code and save a few 
lines?

> +		ret = nct7363_present_pwm_fanin(dev, child, data);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	/* Initialize the chip */
> +	ret = nct7363_init_chip(data);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev =
> +		devm_hwmon_device_register_with_info(dev, client->name, data,
> +						     &nct7363_chip_info, NULL);

return devm_hwmon_device_register_with_info()?

> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}

...

CJ


