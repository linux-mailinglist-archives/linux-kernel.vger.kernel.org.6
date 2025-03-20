Return-Path: <linux-kernel+bounces-570056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BFA6AB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310713B24C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196332222DC;
	Thu, 20 Mar 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgHBqKhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981D19DF98;
	Thu, 20 Mar 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489545; cv=none; b=n7M5ukZ3mq5LeyXd99nK+pxyq/jYgyvDkgAJDlPW/YzLf06nFGxokqDscTchYxT1QpF9Aa8YIWB6hy1lbtSLjzTHt841rH8QNWP2jkSNL+mj7J3IcxQlfyzI83kAeOpNwGzhdCpeFy3z/DWALmFHFPpKKkyMMq3avXoW8q/k6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489545; c=relaxed/simple;
	bh=HWAppdyLE+tSuREdaAW/Nnb1S8EdoAieaN9iTTI13QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5o9w8GXTq8bI3Lmq7PZXUtioTFIIUswa+SS6KCLQ0KEwxZn4EshBl3/9HRWCkN3YMkdDmnfQuvDms1kTQKExuFqgQfNGUrftsXB99uXm6MH3YAFDxax5JJYRwPRZRX0zGyukZcB0kHROFyrPFZwsQ066B9+h/zRVPtzdzpNa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgHBqKhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEB7C4CEDD;
	Thu, 20 Mar 2025 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489545;
	bh=HWAppdyLE+tSuREdaAW/Nnb1S8EdoAieaN9iTTI13QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgHBqKhvAabsJD0TM7MxiuKrSw/oA8pr194vFb7TISCnga8NlW6V8YfsfzjESNIQm
	 ElsGcIQaOU3OIAOGuckp5KpbhGFRtiXqVLc9fuyzOqlOCVn44xq+Ti3QfBYSBLa/6D
	 so8GY/5kBntn6qcr72lnWppf7irYlNMZJAeXAAomdGSoAK7wfPaJlBZWwx4yS443fT
	 4yeAOYspOgg5IGnX2T0CopmOsER+FoHpeU8RkVNA9cOy+Om21Rw8ab03vM9Zg6i19R
	 q0AX7ifYIExSljCrgy4WFYtTt9qeL5P1crrhGF21vdVCa4YbdhkewtYH2xZeKOavDr
	 t4/KQt20m7vdg==
Date: Thu, 20 Mar 2025 16:52:20 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] mfd: rohm-bd96801: Add chip info
Message-ID: <20250320165220.GB1750245@google.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
 <fd445f9cbbdaa3fd5d7a9e59093f86e5ff7139b1.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd445f9cbbdaa3fd5d7a9e59093f86e5ff7139b1.1741864404.git.mazziesaccount@gmail.com>

On Thu, 13 Mar 2025, Matti Vaittinen wrote:

> Prepare for adding support for BD96802 which is very similar to BD96801.
> Separate chip specific data into own structure which can be picked to be
> used by the device-tree.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/mfd/rohm-bd96801.c | 83 ++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
> index 60ec8db790a7..1232f571e4b1 100644
> --- a/drivers/mfd/rohm-bd96801.c
> +++ b/drivers/mfd/rohm-bd96801.c
> @@ -40,7 +40,21 @@
>  #include <linux/mfd/rohm-bd96801.h>
>  #include <linux/mfd/rohm-generic.h>
>  
> -static const struct resource regulator_errb_irqs[] = {
> +struct bd968xx_chip_data {
> +	const struct resource *errb_irqs;
> +	const struct resource *intb_irqs;
> +	int num_errb_irqs;
> +	int num_intb_irqs;
> +	const struct regmap_irq_chip *errb_irq_chip;
> +	const struct regmap_irq_chip *intb_irq_chip;
> +	const struct regmap_config *regmap_config;
> +	struct mfd_cell *cells;

We're not passing MFD data through OF to be fed back through MFD APIs.

It's generally considered better to device_get_match_data() on an enum,
then populate MFD cells using that as a differentiator.

  git grep compatible -- drivers/mfd | grep data

> +	int num_cells;
> +	int unlock_reg;
> +	int unlock_val;
> +};
> +
> +static const struct resource bd96801_reg_errb_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "bd96801-otp-err"),
>  	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "bd96801-dbist-err"),
>  	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "bd96801-eep-err"),
> @@ -98,7 +112,7 @@ static const struct resource regulator_errb_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "bd96801-ldo7-shdn-err"),
>  };
>  
> -static const struct resource regulator_intb_irqs[] = {
> +static const struct resource bd96801_reg_intb_irqs[] = {
>  	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
>  
>  	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
> @@ -345,18 +359,37 @@ static const struct regmap_config bd96801_regmap_config = {
>  	.cache_type = REGCACHE_MAPLE,
>  };
>  
> +static const struct bd968xx_chip_data bd96801_chip_data = {

Just call it 'struct bd968xx' then below instead of cd, use ddata.

  git grep "cc =" -- drivers/mfd

VS

  git grep "ddata =" -- drivers/mfd

Conforrrrrrmmm ...    =;-)

> +	.errb_irqs = bd96801_reg_errb_irqs,
> +	.intb_irqs = bd96801_reg_intb_irqs,
> +	.num_errb_irqs = ARRAY_SIZE(bd96801_reg_errb_irqs),
> +	.num_intb_irqs = ARRAY_SIZE(bd96801_reg_intb_irqs),
> +	.errb_irq_chip = &bd96801_irq_chip_errb,
> +	.intb_irq_chip = &bd96801_irq_chip_intb,
> +	.regmap_config = &bd96801_regmap_config,
> +	.cells = bd96801_cells,
> +	.num_cells = ARRAY_SIZE(bd96801_cells),
> +	.unlock_reg = BD96801_LOCK_REG,
> +	.unlock_val = BD96801_UNLOCK,
> +};
> +
>  static int bd96801_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
>  	struct irq_domain *intb_domain, *errb_domain;
> +	static const struct bd968xx_chip_data *cd;
>  	const struct fwnode_handle *fwnode;
>  	struct resource *regulator_res;
>  	struct resource wdg_irq;
>  	struct regmap *regmap;
> -	int intb_irq, errb_irq, num_intb, num_errb = 0;
> +	int intb_irq, errb_irq, num_errb = 0;
>  	int num_regu_irqs, wdg_irq_no;
>  	int i, ret;
>  
> +	cd = device_get_match_data(&i2c->dev);
> +	if (!cd)
> +		return -ENODEV;
> +
>  	fwnode = dev_fwnode(&i2c->dev);
>  	if (!fwnode)
>  		return dev_err_probe(&i2c->dev, -EINVAL, "Failed to find fwnode\n");
> @@ -365,34 +398,32 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>  	if (intb_irq < 0)
>  		return dev_err_probe(&i2c->dev, intb_irq, "INTB IRQ not configured\n");
>  
> -	num_intb =  ARRAY_SIZE(regulator_intb_irqs);
> -
>  	/* ERRB may be omitted if processor is powered by the PMIC */
>  	errb_irq = fwnode_irq_get_byname(fwnode, "errb");
> -	if (errb_irq < 0)
> -		errb_irq = 0;
> +	if (errb_irq == -EPROBE_DEFER)
> +		return errb_irq;
>  
> -	if (errb_irq)
> -		num_errb = ARRAY_SIZE(regulator_errb_irqs);
> +	if (errb_irq > 0)
> +		num_errb = cd->num_errb_irqs;
>  
> -	num_regu_irqs = num_intb + num_errb;
> +	num_regu_irqs = cd->num_intb_irqs + num_errb;
>  
>  	regulator_res = devm_kcalloc(&i2c->dev, num_regu_irqs,
>  				     sizeof(*regulator_res), GFP_KERNEL);
>  	if (!regulator_res)
>  		return -ENOMEM;
>  
> -	regmap = devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
> +	regmap = devm_regmap_init_i2c(i2c, cd->regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
>  				    "Regmap initialization failed\n");
>  
> -	ret = regmap_write(regmap, BD96801_LOCK_REG, BD96801_UNLOCK);
> +	ret = regmap_write(regmap, cd->unlock_reg, cd->unlock_val);
>  	if (ret)
>  		return dev_err_probe(&i2c->dev, ret, "Failed to unlock PMIC\n");
>  
>  	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, intb_irq,
> -				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
> +				       IRQF_ONESHOT, 0, cd->intb_irq_chip,
>  				       &intb_irq_data);
>  	if (ret)
>  		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
> @@ -404,24 +435,25 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>  	 * has two domains so we do IRQ mapping here and provide the
>  	 * already mapped IRQ numbers to sub-devices.
>  	 */
> -	for (i = 0; i < num_intb; i++) {
> +	for (i = 0; i < cd->num_intb_irqs; i++) {
>  		struct resource *res = &regulator_res[i];
>  
> -		*res = regulator_intb_irqs[i];
> +		*res = cd->intb_irqs[i];
>  		res->start = res->end = irq_create_mapping(intb_domain,
>  							    res->start);
>  	}
>  
>  	wdg_irq_no = irq_create_mapping(intb_domain, BD96801_WDT_ERR_STAT);
>  	wdg_irq = DEFINE_RES_IRQ_NAMED(wdg_irq_no, "bd96801-wdg");
> -	bd96801_cells[WDG_CELL].resources = &wdg_irq;
> -	bd96801_cells[WDG_CELL].num_resources = 1;
> +
> +	cd->cells[WDG_CELL].resources = &wdg_irq;
> +	cd->cells[WDG_CELL].num_resources = 1;
>  
>  	if (!num_errb)
>  		goto skip_errb;
>  
>  	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, errb_irq, IRQF_ONESHOT,
> -				       0, &bd96801_irq_chip_errb, &errb_irq_data);
> +				       0, cd->errb_irq_chip, &errb_irq_data);
>  	if (ret)
>  		return dev_err_probe(&i2c->dev, ret,
>  				     "Failed to add ERRB IRQ chip\n");
> @@ -429,18 +461,17 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>  	errb_domain = regmap_irq_get_domain(errb_irq_data);
>  
>  	for (i = 0; i < num_errb; i++) {
> -		struct resource *res = &regulator_res[num_intb + i];
> +		struct resource *res = &regulator_res[cd->num_intb_irqs + i];
>  
> -		*res = regulator_errb_irqs[i];
> +		*res = cd->errb_irqs[i];
>  		res->start = res->end = irq_create_mapping(errb_domain, res->start);
>  	}
>  
>  skip_errb:
> -	bd96801_cells[REGULATOR_CELL].resources = regulator_res;
> -	bd96801_cells[REGULATOR_CELL].num_resources = num_regu_irqs;
> -
> -	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, bd96801_cells,
> -				   ARRAY_SIZE(bd96801_cells), NULL, 0, NULL);
> +	cd->cells[REGULATOR_CELL].resources = regulator_res;
> +	cd->cells[REGULATOR_CELL].num_resources = num_regu_irqs;
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   cd->cells, cd->num_cells, NULL, 0, NULL);
>  	if (ret)
>  		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
>  
> @@ -448,7 +479,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>  }
>  
>  static const struct of_device_id bd96801_of_match[] = {
> -	{ .compatible = "rohm,bd96801",	},
> +	{ .compatible = "rohm,bd96801", .data = &bd96801_chip_data, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bd96801_of_match);
> -- 
> 2.48.1
> 



-- 
Lee Jones [李琼斯]

