Return-Path: <linux-kernel+bounces-325386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4C9758FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996C4288A60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF6E1B1417;
	Wed, 11 Sep 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Zm+5NKFB"
Received: from msa.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB411AC8B7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074286; cv=none; b=Nx5W21SXIAbiRzWJBo0B79F6KCmSICqtlyZRqZ+ZO1KXAAeGJsi7/ZeYwFwtRN/n37E6egvNOLGPSL4QimPOpz2JGmXeViVtooqTYZbIG9eqS0DgFynrQs111kMXA7UuhsuCm1LgX3LWNT++Ly2Cxtso26+v3/k2HA3Zh79ytGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074286; c=relaxed/simple;
	bh=vNKUr+PlXHTmLveBgPfYOag8Zx4qv9OhYWFnEdb6kxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1mOrvCTtNVFd2OR1zfgQ6KdCDgATmzz2mh2iKiVicEcp2RecPYaRwmVjpqT9dMSCRm1aP3RE5UHUp1g5sEIquu6pAgCLx+g49yoa9cx23kLg0JiiYDViV1e8qFTeZvvel2LFaFLMii0siH0zXX6x8TvwLA3apD5RodCjbXwfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Zm+5NKFB; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oQldsJviCXp4BoQlespP22; Wed, 11 Sep 2024 19:04:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726074275;
	bh=lVxjfxwgLA6BvKbaPvJ8C6nRt1xFeiC4zWRZWm346vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Zm+5NKFB04PJsJD42ovHXnU4hd8pAyTxwChWqc5CYPx7hD9PPtr+gpOl3J7PeE4CF
	 GdIwhUlQbmOZhJOivcrvh+i+ic99mskRsecOvKJ1uelDZDwAIh8ZnSN7Ut7P3w4YgE
	 ZjTYhXJF3rFlpXJnK8Vg3kPzzEx03k3OQ6Ebsz/HsoqHOOKrQP2MQJgDOJI1bOBD/3
	 rLTMWzsjSHQW++SNOiZEIVOIVzICGYCE8XN/tk5CI0r/4R4DziP2KEcHVyjLdFNaHi
	 4/rHfLG6h60wCGjR7QC9UOhEbAGh63IlhYysd1q4CoWLfsIzpZDCcEi/ih/U1wmasJ
	 F3nPTXDntauBw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Sep 2024 19:04:35 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e45d7a0b-c79c-4762-8b78-a8e595789752@wanadoo.fr>
Date: Wed, 11 Sep 2024 19:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev-6.11 1/2] hwmon: modified ina2xx to match
 SY24655(SQ52205)
To: Wenliang <wenliang202407@163.com>, linux@roeck-us.net
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240911122518.41393-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 14:25, Wenliang a écrit :
> After listening to your advice, I have adapted SQ52205 by rewriting the
> ina2xx driver.At the same time, I would like to clarify that SY24655 and
> SQ52205 are different partnumber of the same chip. Therefore, you can
> refer to SY24655FBP. I have also changed the naming within the driver to
> SY24655, and I hope to receive your response.
> 
> Signed-off-by: Wenliang <wenliang202407@163.com>
> ---

Hi,

...

> @@ -103,7 +115,7 @@ static struct regmap_config ina2xx_regmap_config = {
>   	.val_bits = 16,
>   };
>   
> -enum ina2xx_ids { ina219, ina226 };
> +enum ina2xx_ids { ina219, ina226, sy24655};

Nitpick: Missing space before }

>   
>   struct ina2xx_config {
>   	u16 config_default;
> @@ -117,12 +129,13 @@ struct ina2xx_config {
>   
>   struct ina2xx_data {
>   	const struct ina2xx_config *config;
> -
> +
>   	long rshunt;
>   	long current_lsb_uA;
>   	long power_lsb_uW;
>   	struct mutex config_lock;
>   	struct regmap *regmap;
> +	struct i2c_client *client;
>   
>   	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>   };

...

> +static int sy24655_read_reg48(const struct i2c_client *client, u8 reg,
> +					long *accumulator_24, long *sample_count)
> +{
> +	u8 data[6];
> +	int err;

Maybe adding a blank line here?

> +	*accumulator_24 = 0;
> +	*sample_count = 0;
> +
> +	/* 48-bit register read */
> +	err = i2c_smbus_read_i2c_block_data(client, reg, 6, data);
> +	if (err < 0)
> +		return err;
> +	if (err != 6)
> +		return -EIO;
> +	*accumulator_24 = ((data[3] << 16) |
> +				(data[4] << 8) |
> +				data[5]);
> +	*sample_count = ((data[0] << 16) |
> +				(data[1] << 8) |
> +				data[2]);
> +
> +	return 0;
> +}
> +
> +static ssize_t sy24655_avg_power_show(struct device *dev,
> +					struct device_attribute *da, char *buf)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	long sample_count, accumulator_24, regval;
> +	int status;
> +
> +	status = sy24655_read_reg48(data->client, SY24655_EIN,
> +						&accumulator_24, &sample_count);
> +	if (status)
> +		return status;
> +	regval = DIV_ROUND_CLOSEST(accumulator_24, sample_count);
> +	regval = regval * data->power_lsb_uW;
> +
> +

Nitpick: unneeded extra empty line

> +	return sysfs_emit(buf, "%li\n", regval);
> +}
> +
>   /* shunt voltage */
>   static SENSOR_DEVICE_ATTR_RO(in0_input, ina2xx_value, INA2XX_SHUNT_VOLTAGE);
>   /* shunt voltage over/under voltage alert setting and alarm */
> @@ -589,9 +659,13 @@ static SENSOR_DEVICE_ATTR_RO(power1_crit_alarm, ina226_alarm,
>   /* shunt resistance */
>   static SENSOR_DEVICE_ATTR_RW(shunt_resistor, ina2xx_shunt, INA2XX_CALIBRATION);
>   
> -/* update interval (ina226 only) */
> +/* update interval (ina226 and sy24655) */
>   static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);
>   
> +/* calculate_avg_power (sy24655 only) */
> +static SENSOR_DEVICE_ATTR_RO(calculate_avg_power, sy24655_avg_power, 0);
> +
> +

Nitpick: unneeded extra empty line

>   /* pointers to created device attributes */
>   static struct attribute *ina2xx_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
> @@ -624,6 +698,15 @@ static struct attribute *ina226_attrs[] = {
>   static const struct attribute_group ina226_group = {
>   	.attrs = ina226_attrs,
>   };


...

> @@ -691,10 +775,17 @@ static int ina2xx_probe(struct i2c_client *client)
>   		dev_err(dev, "error configuring the device: %d\n", ret);
>   		return -ENODEV;
>   	}
> -
> +	if (chip == sy24655)
> +		ret = sy24655_init(data);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the accum_reg: %d\n", ret);
> +		return -ENODEV;

return ret;?

> +	}
>   	data->groups[group++] = &ina2xx_group;
>   	if (chip == ina226)
>   		data->groups[group++] = &ina226_group;
> +	else if (chip == sy24655)
> +		data->groups[group++] = &sy24655_group;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>   							   data, data->groups);
> @@ -713,6 +804,7 @@ static const struct i2c_device_id ina2xx_id[] = {
>   	{ "ina226", ina226 },
>   	{ "ina230", ina226 },
>   	{ "ina231", ina226 },
> +	{ "sy24655", sy24655},

Nitpick: missing space before }

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> @@ -738,6 +830,10 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
>   		.compatible = "ti,ina231",
>   		.data = (void *)ina226
>   	},
> +	{
> +		.compatible = "silergy,sy24655",
> +		.data = (void *)sy24655
> +	},
>   	{ },

Nitpick: Unrelated, but this comma could be removed.

CJ

>   };
>   MODULE_DEVICE_TABLE(of, ina2xx_of_match);


