Return-Path: <linux-kernel+bounces-254791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16B9337A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A40BB22852
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F11B970;
	Wed, 17 Jul 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWFYMh3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34131CD1F;
	Wed, 17 Jul 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200306; cv=none; b=nS5tAAMoyrTwvLRDuJVrngL17RpXQC8nNk/meidrs7JpehuQep4NyKIIeYkWjmM+NlKsa4xLRTZft5y1QlCKb+g+mbi+MxjZP7B5G4ENpn2kwo/7ZPMOLeAc3f2R3BeNOgA+q7P/DvotEm3bmCkKmea3T9JqBpfyNlm/64uTN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200306; c=relaxed/simple;
	bh=qqz2dTQAyhsrr8JcadvDgbuxVDuo0fTC4NGyVOzaHXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFcP4sFXV8EUEIIuFYp0uJV36Ffl6oO6TwcpU4sJoX+MrtzZHfEjTXL26Ct6iulgKlHm+yU6y0mzsm7LowktxHKbnBDDnUv07SoW4TVNzwf7T+ntFbZXOcHrMAaApHiNWkguxKHYN4wVw2ZfVZbJWgSFKt9aScUh+sXkTaLPxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWFYMh3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B3DC32782;
	Wed, 17 Jul 2024 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721200305;
	bh=qqz2dTQAyhsrr8JcadvDgbuxVDuo0fTC4NGyVOzaHXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qWFYMh3Cs1hGN0lO4VjK+On3biP7Ol+puJxEkcfuhWFPBe37nNSywThDqc2nZyyYW
	 IABc2KQ/dBmjQ6zG1SY9vPOOpYDPxYoDS9j7GUrSz/HimvY5PSLD0KdbjTaTKZeNk+
	 ljqq4TesDOm3+Iz7xXjeeaAZgKGen3kj1752DnEI/rlkTo6rIHbNcR5zr6quSmfm7j
	 HXQGH/DpZiOK7lGbsjxhCtpHJV6hNhKoeZInKYbMzadpZKkurPYDE9bYJuRfPxK6Fn
	 1lEz7/dq/DC63TWriC/Ta6ZjSTWt91TjUHq0J8XN9j2lCSk6u3tN2Gh+GlkYESuMf8
	 WPr2yKaVSbC5w==
Message-ID: <14e3654e-27b1-41f7-a66f-03ec47e95593@kernel.org>
Date: Wed, 17 Jul 2024 09:11:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, =?UTF-8?Q?Marcin_Str=C4=85gowski?=
 <marcin@stragowski.com>
References: <20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com>
 <20240717-gpd_fan-v3-1-8d7efb1263b7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240717-gpd_fan-v3-1-8d7efb1263b7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2024 08:46, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped IO.
> I have only tested it on my device Win Max 2 2023.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  MAINTAINERS             |   6 +
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/gpd-fan.c | 674 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 691 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af4b4c271342..9ced72cec42b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9372,6 +9372,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
>  F:	include/dt-bindings/clock/google,gs101.h
>  K:	[gG]oogle.?[tT]ensor
>  

...

> +// device EC truly access start
> +
> +static int gpd_ecram_read(const struct gpd_model_ec_address *address,
> +			  u16 offset, u8 *val)
> +{
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&gpd_fan_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;

Again, definitions are at the top. Read Linux Coding Style.

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	*val = inb(data_port);
> +
> +	mutex_unlock(&gpd_fan_lock);
> +	return 0;
> +}
> +
> +static int gpd_ecram_write(const struct gpd_model_ec_address *address,
> +			   u16 offset, u8 value)
> +{
> +	int ret = mutex_lock_interruptible(&gpd_fan_lock);

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

> +
> +	if (ret)
> +		return ret;
> +
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;
> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	outb(value, data_port);
> +
> +	mutex_unlock(&gpd_fan_lock);
> +	return 0;
> +}
> +
> +// device EC truly access end
> +
> +// device quirk function implement start
> +
> +static s32
> +gpd_read_cached_fan_speed(struct gpd_driver_priv *data,
> +			  s32 (*read_uncached)(const struct gpd_driver_priv *))
> +{
> +	// Update per 1000 milliseconds
> +	if (time_after(jiffies, data->fan_speed_last_update + HZ)) {
> +		s32 ret = read_uncached(data);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		data->fan_speed_cached = ret;
> +		data->fan_speed_last_update = jiffies;
> +	}
> +	return data->fan_speed_cached;
> +}
> +
> +static s32
> +gpd_read_cached_pwm(struct gpd_driver_priv *data,
> +		    s16 (*read_uncached)(const struct gpd_driver_priv *))
> +{
> +	// Update per 1000 milliseconds
> +	if (time_after(jiffies, data->read_pwm_last_update + HZ)) {
> +		s16 ret = read_uncached(data);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		data->read_pwm_cached = ret;
> +		data->read_pwm_last_update = jiffies;
> +	}
> +	return data->read_pwm_cached;
> +}
> +
> +static s32 gpd_read_rpm_uncached(const struct gpd_driver_priv *data)
> +{
> +	u8 high, low;
> +	int ret;
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +
> +	ret = gpd_ecram_read(address, address->rpm_read, &high);
> +	if (ret)
> +		return ret;
> +	ret = gpd_ecram_read(address, address->rpm_read + 1, &low);
> +	if (ret)
> +		return ret;
> +
> +	return high << 8 | low;
> +}
> +
> +static s32 gpd_read_rpm(struct gpd_driver_priv *data)
> +{
> +	return gpd_read_cached_fan_speed(data, gpd_read_rpm_uncached);
> +}
> +
> +static s16 gpd_read_pwm(struct gpd_driver_priv *data)
> +{
> +	return data->pwm_value;
> +}
> +
> +static int gpd_write_pwm(const struct gpd_driver_priv *data, u8 val)
> +{
> +	const struct gpd_model_ec_address *address = &data->quirk->address;
> +
> +	u8 actual = val * (address->pwm_max - 1) / 255 + 1;
> +
> +	return gpd_ecram_write(address, address->pwm_write, actual);
> +}
> +
> +static int gpd_win_mini_set_pwm_enable(struct gpd_driver_priv *data,
> +				       enum FAN_PWM_ENABLE pwm_enable)
> +{
> +	switch (pwm_enable) {
> +	case DISABLE:
> +		return gpd_write_pwm(data, 255);
> +	case MANUAL:
> +		return gpd_write_pwm(data, data->pwm_value);
> +	case AUTOMATIC:
> +		return gpd_write_pwm(data, 0);
> +	}
> +	return 0;
> +}
> +
> +static int gpd_win_mini_write_pwm(const struct gpd_driver_priv *data, u8 val)
> +{
> +	if (data->pwm_enable == MANUAL)
> +		return gpd_write_pwm(data, val);
> +	return 0;
> +}
> +

...

> +// hwmon subsystem end
> +
> +static int gpd_fan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpd_driver_priv *data;
> +	const struct resource *plat_res;
> +	const struct device *dev_reg;
> +	const struct resource *region_res;
> +
> +	data = dev_get_platdata(&pdev->dev);
> +	if (IS_ERR_OR_NULL(data))
> +		return -ENODEV;
> +
> +	plat_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (IS_ERR_OR_NULL(plat_res))

IS_ERR_OR_NULL is usually poor code.

> +		return dev_err_probe(dev, PTR_ERR(plat_res),
> +				     "Failed to get platform resource\n");
> +
> +	region_res = devm_request_region(dev, plat_res->start,
> +					 resource_size(plat_res), DRIVER_NAME);
> +	if (IS_ERR_OR_NULL(region_res))

IS_ERR_OR_NULL is usually poor code.

> +		return dev_err_probe(dev, PTR_ERR(region_res),
> +				     "Failed to request region\n");
> +
> +	dev_reg = devm_hwmon_device_register_with_info(
> +		dev, DRIVER_NAME, data, &gpd_fan_chip_info, NULL);

Fix the alignment/wrapping.

> +	if (IS_ERR_OR_NULL(dev_reg))

IS_ERR_OR_NULL is usually poor code. Or wrong. Cannot be NULL.

> +		return dev_err_probe(dev, PTR_ERR(region_res),
> +				     "Failed to register hwmon device\n");
> +
> +	return 0;
> +}
> +
> +static int gpd_fan_remove(__always_unused struct platform_device *pdev)
> +{
> +	struct gpd_driver_priv *data = dev_get_platdata(&pdev->dev);

What is this __always_unused? How pdev can be unused if it is just here?

This entire driver still does not look like using Linux coding style.

> +
> +	data->pwm_enable = AUTOMATIC;
> +	data->quirk->set_pwm_enable(data, AUTOMATIC);
> +
> +	return 0;
> +}


Best regards,
Krzysztof


