Return-Path: <linux-kernel+bounces-331075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B897A812
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7455428723F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CCA15C15D;
	Mon, 16 Sep 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epNn7lfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6741BDC8;
	Mon, 16 Sep 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517205; cv=none; b=mbJxkmwybHS2VHGb8MIGYCgFvmZJErFFfDWgcQAQtlNDrg8drVflw3aK4tjFrfTg//hFyrMiJ9I5SCGQewHhQpXCpW50Z2qWLfdmkkZqEVdl7ta465Ui7hDxv65dz11oEWn9CqBEeWpg73A9PH2I/GImYG5YhApx8oiFLYJK8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517205; c=relaxed/simple;
	bh=042xKiugapJc43LxR42bMaAA6xbM9HZQ6BCxpTlaGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3AFQwAjbvKrXPOUUo3HLjKO0vcUTJfU5WWABBN8YzmwFxKA6pb54mGCbLIcNbMl8KqEsbsADEwvyt76FIePSQ1TvhU2ub/Iq0+z1hTbreiZVvBELhdBXiQ0aK4FwryI3Wn5+y5F7uIVcBlvgdAjKCKwLUukntTlST/vhiTDfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epNn7lfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF6C4CEC4;
	Mon, 16 Sep 2024 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517204;
	bh=042xKiugapJc43LxR42bMaAA6xbM9HZQ6BCxpTlaGDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=epNn7lfIsL4lQZP2Rb7q/TSy+MEdH3jq5a1fvdxmco2JjE2igLqjWxbR+rj31kSqA
	 dNz4vtV8ESXn9QZgtfGcPSSgj2P/K7VAbmXLLbqSuk5SwWpduLOeyN09+hUX1c/xqX
	 dC8FvGK0OLtguB4GTDFiAemxv8ABapPfjDNnS9eLdJy1No/ZqkjE4M3+xGzqLdsh9s
	 GIBSQh2Xiq5lQQMeq7XKs23rV3UX++NRaGF3GDJsh4sCTz6UR7JhXuR7XKt4BF6pXF
	 U2l1/3bNapVkhEtP6CqfnTEwBEtQOMJQ45JLsGZGdEkecIwYiSJfZuPOfTOt/0J2ew
	 QpFYyVCGozQNg==
Message-ID: <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
Date: Mon, 16 Sep 2024 22:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/09/2024 18:48, André Draszik wrote:
> The MAX20339 is an overvoltage protection (OVP) device which also
> integrates two load switches with resistor programmable current
> limiting and includes ESD protection for the USB Type-C signal pins.
> 
> This driver exposes the main path and the two the load switches via the

...

> +
> +
> +static irqreturn_t max20339_irq(int irqno, void *data)
> +{
> +	struct max20339_irq_data *max20339 = data;
> +	struct device *dev = max20339->dev;
> +	struct regmap *regmap = max20339->regmap;
> +	u8 status[6];
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, MAX20339_STATUS1, status,
> +			       ARRAY_SIZE(status));
> +	if (ret) {
> +		dev_err(dev, "Failed to read IRQ status: %d\n", ret);
> +		return IRQ_NONE;
> +	}
> +
> +	dev_dbg(dev,
> +		"INT1 2 3: %#.2x %#.2x %#.2x STATUS1 2 3: %#.2x %#.2x %#.2x\n",
> +		status[3], status[4], status[5], status[0], status[1],
> +		status[2]);

You should not have prints, even debugs, in interrupt handlers. This can
flood the dmesg.

> +
> +	if (!status[3] && !status[4] && !status[5])
> +		return IRQ_NONE;
> +
> +	/* overall status */
> +	if (status[3] & status[0] & MAX20339_THMFAULT) {
> +		dev_warn(dev, "Thermal fault\n");
> +		for (int i = 0; i < ARRAY_SIZE(max20339->rdevs); ++i)
> +			regulator_notifier_call_chain(max20339->rdevs[i],
> +						      REGULATOR_EVENT_OVER_TEMP,
> +						      NULL);
> +	}
> +
> +	/* INSW status */
> +	if ((status[3] & MAX20339_VINVALID)
> +	    && !(status[0] & MAX20339_VINVALID)) {
> +		dev_warn(dev, "Vin over- or undervoltage\n");

Same with all these. What happens if interrupt is triggered constantly?


> +		regulator_notifier_call_chain(max20339->rdevs[MAX20339_REGULATOR_INSW],
> +					      (REGULATOR_EVENT_UNDER_VOLTAGE_WARN
> +					       | REGULATOR_EVENT_OVER_VOLTAGE_WARN),
> +					      NULL);
> +	}
> +
> +	if (status[3] & status[0] & MAX20339_INOVFAULT) {
> +		dev_warn(dev, "Over voltage on INput\n");
> +		regulator_notifier_call_chain(max20339->rdevs[MAX20339_REGULATOR_INSW],
> +					      REGULATOR_EVENT_OVER_VOLTAGE_WARN,
> +					      NULL);
> +	}
> +


...

> +
> +static int max20339_lsw_get_error_flags(struct regulator_dev *rdev,
> +					unsigned int *flags)
> +{
> +	struct max20339_regulator *data = rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(rdev_get_regmap(rdev), data->status_reg, &val);
> +	if (ret) {
> +		dev_err(rdev_get_dev(rdev),
> +			"Failed to read MAX20339_STATUS%d: %d\n",
> +			data->status_reg, ret);
> +		return ret;
> +	}
> +
> +	*flags = 0;
> +
> +	if (val & MAX20339_LSWxSHORTFAULT)
> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> +
> +	if (val & MAX20339_LSWxOVFAULT)
> +		*flags |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> +
> +	if (val & MAX20339_LSWxOCFAULT)
> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> +
> +	return 0;
> +}
> +
> +static int max20339_lsw_dt_parse(struct device_node *np,
> +				 const struct regulator_desc *desc,
> +				 struct regulator_config *cfg)
> +{
> +	struct max20339_regulator *data = cfg->driver_data;
> +
> +	/* we turn missing properties into a fatal issue during probe() */

Your binding does not look in sync with above.

> +	return of_property_read_u32(np, "shunt-resistor-micro-ohms",
> +				    &data->shunt_micro_ohm);
> +}
> +
> +static const struct regulator_ops max20339_lsw_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = max20339_lsw_is_enabled,
> +
> +	.set_over_current_protection = max20339_lsw_set_ocp,
> +	.set_over_voltage_protection = max20339_lsw_set_ovp,
> +
> +	.get_error_flags = max20339_lsw_get_error_flags,
> +};
> +
> +#define MAX20339_LSW_DESC(_sfx, _enable_mask, _csel_mask, _ovp_mask, _status_reg) { \
> +	.desc = {                                                 \
> +		.name = "max20339-" _sfx,                         \
> +		\
> +		.ops = &max20339_lsw_ops,                         \
> +		.type = REGULATOR_VOLTAGE,                        \
> +		.supply_name = _sfx,                              \
> +		\
> +		.enable_reg = MAX20339_SWCNTL,                    \
> +		.enable_mask = _enable_mask,                      \
> +		\
> +		.csel_reg = MAX20339_SWILIMDIV,                   \
> +		.csel_mask = _csel_mask,                          \
> +		\
> +		.regulators_node = of_match_ptr("regulators"),    \
> +		.of_match = of_match_ptr(_sfx),                   \
> +		.of_parse_cb = max20339_lsw_dt_parse,             \
> +		\
> +		.enable_time = 11000 + 1100,                      \
> +		.off_on_delay = 13,                               \
> +		.poll_enabled_time = 2420,                        \
> +		\
> +		.owner = THIS_MODULE,                             \
> +	},                                                        \
> +	.ovp_mask = _ovp_mask,                                    \
> +	.status_reg = _status_reg,                                \
> +}
> +
> +

Here and in few other places - just one blank line.

> +static struct max20339_regulator max20339_regulators[MAX20339_N_REGULATORS] = {

This can be const and then use container_of instead of rdev_get_drvdata().

See:
https://lore.kernel.org/all/20240909-regulator-const-v1-17-8934704a5787@linaro.org/

> +	[MAX20339_REGULATOR_INSW] = {
> +		.desc = {
> +			.name = "max20339-insw",
> +
> +			.ops = &max20339_insw_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.supply_name = "insw",
> +
> +			.volt_table = max20339_insw_volt_table,
> +			.n_voltages = ARRAY_SIZE(max20339_insw_volt_table),
> +
> +			.enable_reg = MAX20339_IN_CTR,
> +			.enable_mask = MAX20339_IN_CTR_INSWEN,
> +			.enable_val = FIELD_PREP_CONST(MAX20339_IN_CTR_INSWEN,
> +						  MAX20339_IN_CTR_INSWEN_AUTO),
> +
> +			.active_discharge_reg = MAX20339_IN_CTR,
> +			.active_discharge_mask = MAX20339_IN_CTR_INDISEN,
> +			.active_discharge_on = MAX20339_IN_CTR_INDISEN,
> +			.active_discharge_off = 0,
> +
> +			.regulators_node = of_match_ptr("regulators"),
> +			.of_match = of_match_ptr("insw"),
> +
> +			.enable_time = 15000,
> +			.off_on_delay = 1,
> +			.poll_enabled_time = 3000,
> +
> +			.owner = THIS_MODULE,
> +		}
> +	},
> +	[MAX20339_REGULATOR_LSW1] = MAX20339_LSW_DESC("lsw1",
> +						MAX20339_SWCNTL_LSW1EN,
> +						MAX20339_SWILIMDIV_LSW1ILIMDIV,
> +						MAX20339_SWCNTL_LSW1OVEN,
> +						MAX20339_STATUS2),
> +	[MAX20339_REGULATOR_LSW2] = MAX20339_LSW_DESC("lsw2",
> +						MAX20339_SWCNTL_LSW2EN,
> +						MAX20339_SWILIMDIV_LSW2ILIMDIV,
> +						MAX20339_SWCNTL_LSW2OVEN,
> +						MAX20339_STATUS3),
> +};
> +
> +static int max20339_setup_irq(struct i2c_client *client,
> +			      struct regmap *regmap,
> +			      struct regulator_dev *rdevs[])
> +{
> +	u8 enabled_irqs[3];
> +	struct max20339_irq_data *max20339;
> +	int ret;
> +	unsigned long irq_flags;
> +
> +	/* the IRQ is optional */
> +	if (!client->irq) {
> +		enabled_irqs[0] = enabled_irqs[1] = enabled_irqs[2] = 0;
> +	} else {
> +		enabled_irqs[0] = (MAX20339_VINVALID | MAX20339_THMFAULT
> +				   | MAX20339_INOVFAULT);
> +		enabled_irqs[1] = (MAX20339_LSWxSHORTFAULT
> +				   | MAX20339_LSWxOVFAULT
> +				   | MAX20339_LSWxOCFAULT);
> +		enabled_irqs[2] = (MAX20339_LSWxSHORTFAULT
> +				   | MAX20339_LSWxOVFAULT
> +				   | MAX20339_LSWxOCFAULT);
> +
> +		max20339 = devm_kzalloc(&client->dev, sizeof(*max20339),
> +					GFP_KERNEL);
> +		if (!max20339)
> +			return -ENOMEM;
> +	}
> +
> +	ret = regmap_bulk_write(regmap, MAX20339_INTMASK1,
> +				enabled_irqs, ARRAY_SIZE(enabled_irqs));
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "error configuring INTMASK1..3\n");
> +
> +	if (!client->irq)
> +		return 0;
> +
> +	max20339->dev = &client->dev;
> +	max20339->regmap = regmap;
> +	memcpy(max20339->rdevs, rdevs, sizeof(max20339->rdevs));
> +
> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED;

Why shared?

> +	irq_flags |= irqd_get_trigger_type(irq_get_irq_data(client->irq));
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq,

Shared interrupts should not be devm. It leads to tricky cases during
removal. If you investigated the code and you are 100% sure there is no
issue, please write a short comment in the code confirming that. Or just
don't use devm.

> +					NULL, max20339_irq, irq_flags,
> +					"max20339", max20339);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "IRQ setup failed\n");
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_GPIO_REGMAP)
> +static int max20339_gpio_regmap_xlate(struct gpio_regmap *const gpio,
> +				      unsigned int base, unsigned int offset,
> +				      unsigned int *const reg,
> +				      unsigned int *const mask)
> +{
> +	if (offset != 0)
> +		return -EINVAL;
> +
> +	*reg = base;
> +	*mask = MAX20339_VINVALID;
> +	return 0;
> +}
> +
> +static int max20339_setup_gpio(struct i2c_client *client,
> +			       struct regmap *regmap)
> +{
> +	struct fwnode_handle *fwnode;
> +	static const char * const names[] = { "vin" };
> +	int ret;
> +
> +	fwnode = gpiochip_node_get_first(&client->dev);
> +	if (!fwnode) {
> +		dev_info(&client->dev, "Skipping gpio chip initialization\n");
> +		return 0;
> +	}
> +
> +	ret = PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&client->dev,
> +			&(struct gpio_regmap_config) {
> +				.parent = &client->dev,
> +				.regmap = regmap,
> +				.fwnode = fwnode,
> +				.ngpio = ARRAY_SIZE(names),
> +				.names = names,
> +				.reg_dat_base = MAX20339_STATUS1,
> +				.reg_mask_xlate = max20339_gpio_regmap_xlate
> +			}));

That's not really readable. Please split PTR_ERR_OR_ZERO.

> +	fwnode_handle_put(fwnode);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to initialize gpio chip\n");
> +
> +	return 0;
> +}
> +#else /* CONFIG_GPIO_REGMAP */
> +static int max20339_setup_gpio(struct i2c_client *client,
> +			       struct regmap *regmap)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_GPIO_REGMAP */
> +
> +static int max20339_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct regmap *regmap;
> +	struct regulator_config config = {};
> +	struct regulator_dev *rdev;
> +	struct regulator_dev *rdevs[MAX20339_N_REGULATORS];
> +
> +	/*
> +	 * either "dig-supply" is needed, or alternatively "in-supply" will
> +	 * supply power
> +	 */
> +	ret = devm_regulator_get_enable_optional(&client->dev, "dig");
> +	if (ret) {
> +		if (ret == -ENODEV)
> +			ret = devm_regulator_get_enable_optional(&client->dev,
> +								 "insw");
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "failed to get regulator");
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &max20339_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&client->dev, PTR_ERR(regmap),

return dev_err_probe

> +			      "regmap init failed\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	for (int i = 0; i < ARRAY_SIZE(max20339_regulators); ++i) {
> +		config.dev = &client->dev;
> +		config.regmap = regmap;
> +		config.driver_data = &max20339_regulators[i];
> +
> +		rdev = devm_regulator_register(config.dev,
> +					       &max20339_regulators[i].desc,
> +					       &config);
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(&client->dev, PTR_ERR(rdev),
> +					     "failed to register MAX20339 regulator %s\n",
> +					     max20339_regulators[i].desc.name);
> +
> +		/*
> +		 * For the LSWs, we really need to know the shunts' values
> +		 * (from DT). Fail if missing.
> +		 */
> +		if (max20339_regulators[i].desc.csel_mask
> +		    && !max20339_regulators[i].shunt_micro_ohm)
> +			return dev_err_probe(&client->dev, -EINVAL,
> +					     "property 'shunt-resistor-micro-ohms' not found\n");
> +
> +		rdevs[i] = rdev;
> +
> +		dev_info(&client->dev, "registered MAX20339 regulator %s\n",
> +			 max20339_regulators[i].desc.name);
> +	}
> +
> +	ret = max20339_setup_irq(client, regmap, rdevs);
> +	if (ret < 0)
> +		return ret;
> +
> +	return max20339_setup_gpio(client, regmap);
> +}
> +
> +static const struct i2c_device_id max20339_i2c_id[] = {
> +	{ "max20339", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max20339_i2c_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id max20339_of_id[] = {
> +	{ .compatible = "maxim,max20339", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, max20339_of_id);
> +#endif
> +
> +static struct i2c_driver max20339_i2c_driver = {
> +	.driver = {
> +		.name = "max20339",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = of_match_ptr(max20339_of_id),

Drop of_match_ptr and earlier #ifdef. Not much benefits and limits usage
to OF-systems.

Best regards,
Krzysztof


