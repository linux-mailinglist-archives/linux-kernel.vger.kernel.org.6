Return-Path: <linux-kernel+bounces-572451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F86BA6CA6D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A241E4612B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975122836C;
	Sat, 22 Mar 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N2sjWFla"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E772222AC;
	Sat, 22 Mar 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651756; cv=none; b=F2PyQ/N932WQsxK9fUJprMdjdkqTf9O/qUriF/2wVK5NXc41iTLbtBboMKXAz1ZUhC/I3KZcEPuHoVewjSGbUINrVLcnp2VTICYevxDvvSaozfoIbyX9yZpniTERAGjDe2FdiDUF9UHpA8xxYTiWLLBvkvAsJ/LMtN//7pAwLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651756; c=relaxed/simple;
	bh=ZHkCw6IuTbEdi4xGFQIaMVrZjDeLrYloikfrNaTIzag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g279pdG9UNfGjwJULhcTBVBV5volaAX+uAG6CNVUBv3CGu4Ar1l+XY5JsxGK4boCFO7lHqIvOVZCZhLMbx6F/yoA7nYLaS5M6B5DHfLD5HXn5gc/z6SyvSQdStjm0k4pTUIn8eltOEjQmMFs4+vkQ1L/I5E5/LI1gc2AArhuaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N2sjWFla; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742651748;
	bh=ZHkCw6IuTbEdi4xGFQIaMVrZjDeLrYloikfrNaTIzag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2sjWFlaYXtpjV7FZvEcResfnOcrX96tMxoIAo83jZaa1feV4fngL/Vac6DMLCk+k
	 6zCKu6ohZAb2PXEPYfG1FIFtBizlERqtK5waABA4RQmGEsqGjmjmHND5dEAqR2Q3VA
	 R8NnDO+Am8O5zxaoTcYDbK/YVaMWJzPlwW7FG9j0=
Date: Sat, 22 Mar 2025 14:55:48 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>

On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
> The ChromeOS embedded controller (EC) supports closed loop fan speed
> control, so add the fan target attribute under hwmon framework, such
> that kernel can expose reading and specifying the desired fan RPM for
> fans connected to the EC.
> 
> When probing the cros_ec hwmon module, we also check the supported
> command version of setting target fan RPM. This commit implements the
> version 0 of getting the target fan RPM, which can only read the target
> RPM of the first fan. This commit also implements the version 1 of
> setting the target fan RPM to each fan respectively.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> ChromeOS embedded controller (EC) supports closed-loop fan control. We
> anticipate to have the fan related control from the kernel side, so this
> series register the HWMON_F_TARGET attribute, and implement the read and
> write function for setting/reading the target fan RPM from the EC side.

Should it be possible to switch back to automatic control?
I can't find anything in the hwmon ABI about it.
And neither in the CrOS EC source.

Am I missing something?

> ---
> Changes in v3:
> - Drop support of v0 setting target fan RPM, thus also simplify
>   implementations.
> - Align coding style to existing code, including using if-else rather
>   than switch-case, and ensure little endian conversion from read data.
> - Only log warning for failed probing get fan target command version
>   instead of fail the whole driver.
> - Link to v2: https://lore.kernel.org/r/20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org
> 
> Changes in v2:
> - Squash the read, write, and register of fan target attribute to 1
>   commit, as they are the same topic.
> - Probe the supported command version from EC for setting the target fan
>   RPM, and perform the set fan target RPM based on the supported
>   version.
> - Update the used variable type to kernel types (i.e., u32).
> - Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 90 ++++++++++++++++++++++++++++++++++++++++---

Also update Documentation/hwmon/cros_ec_hwmon.rst .

>  1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 9991c3fa020ac859cbbff29dfb669e53248df885..d54fd85ccb4350fc297bde62a2d98f386ce1a8de 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -21,6 +21,7 @@ struct cros_ec_hwmon_priv {
>  	struct cros_ec_device *cros_ec;
>  	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
>  	u8 usable_fans;
> +	int set_fan_target_rpm_version;
>  };
>  
>  static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> @@ -36,6 +37,21 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec,
> +					 u32 *speed)
> +{
> +	struct ec_response_pwm_get_fan_rpm r;
> +	int ret;
> +
> +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0,
> +			  &r, sizeof(r));
> +	if (ret < 0)
> +		return ret;
> +
> +	*speed = le32_to_cpu((__force __le32)r.rpm);
> +	return 0;
> +}
> +
>  static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
>  {
>  	unsigned int offset;
> @@ -52,6 +68,31 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index,
> +				     u16 val)
> +{
> +	struct ec_params_pwm_set_fan_target_rpm_v1 req = {
> +		.rpm = val,
> +		.fan_idx = index,
> +	};
> +	int ret;
> +
> +	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
> +			  sizeof(req), NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_write_fan(struct cros_ec_hwmon_priv *priv, u32 attr,
> +				   int channel, long rpm)
> +{
> +	if (attr == hwmon_fan_target)
> +		return cros_ec_hwmon_set_fan_rpm(priv->cros_ec, channel, rpm);
> +	else
> +		return -EOPNOTSUPP;
> +}
> +
>  static bool cros_ec_hwmon_is_error_fan(u16 speed)
>  {
>  	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
> @@ -75,6 +116,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  {
>  	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
>  	int ret = -EOPNOTSUPP;
> +	u32 target_rpm;
>  	u16 speed;
>  	u8 temp;
>  
> @@ -91,6 +133,11 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
>  			if (ret == 0)
>  				*val = cros_ec_hwmon_is_error_fan(speed);
> +		} else if (attr == hwmon_fan_target) {
> +			ret = cros_ec_hwmon_read_fan_target(
> +				priv->cros_ec, &target_rpm);

Can be on one line.

> +			if (ret == 0)
> +				*val = target_rpm;
>  		}
>  	} else if (type == hwmon_temp) {
>  		if (attr == hwmon_temp_input) {
> @@ -130,7 +177,15 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
>  	const struct cros_ec_hwmon_priv *priv = data;
>  
>  	if (type == hwmon_fan) {
> -		if (priv->usable_fans & BIT(channel))
> +		if (!(priv->usable_fans & BIT(channel)))
> +			return 0;
> +
> +		if (attr == hwmon_fan_target) {
> +			if (priv->set_fan_target_rpm_version == 1)
> +				return (channel == 0) ? 0644 : 0200;
> +			else
> +				return 0;
> +		} else
>  			return 0444;
>  	} else if (type == hwmon_temp) {
>  		if (priv->temp_sensor_names[channel])
> @@ -140,13 +195,24 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long val)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_fan)
> +		return cros_ec_hwmon_write_fan(priv, attr, channel, val);
> +	else
> +		return -EOPNOTSUPP;
> +}
> +
>  static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT),
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET),
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
> @@ -178,6 +244,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
>  static const struct hwmon_ops cros_ec_hwmon_ops = {
>  	.read = cros_ec_hwmon_read,
>  	.read_string = cros_ec_hwmon_read_string,
> +	.write = cros_ec_hwmon_write,
>  	.is_visible = cros_ec_hwmon_is_visible,
>  };
>  
> @@ -233,6 +300,18 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
>  	}
>  }
>  
> +static void cros_ec_hwmon_probe_fan_target_cmd_version(struct cros_ec_hwmon_priv *priv)
> +{
> +	int ret;
> +
> +	ret =  cros_ec_get_cmd_versions(priv->cros_ec,  EC_CMD_GET_CMD_VERSIONS);

Spurious space after '='.
This also tests for the wrong command.

> +	if (ret < 0) {
> +		dev_warn(priv->cros_ec->dev,
> +			"error getting target fan RPM set command version: %d\n", ret);
> +	}

This could return the error instead, not requiring a new warning.
(The first one of the driver)

> +	priv->set_fan_target_rpm_version = (ret > 0) ? 1 : 0;

Check for the specific protocol version that is supported, to be
forward compatible.
The get_fan_target_rpm command is not checked.
Checking for both commands and storing the results in a bool should be
enough.

> +}
> +
>  static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -259,6 +338,7 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  
>  	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
>  	cros_ec_hwmon_probe_fans(priv);
> +	cros_ec_hwmon_probe_fan_target_cmd_version(priv);
>  
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
>  							 &cros_ec_hwmon_chip_info, NULL);
> 
> ---
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
> 
> Best regards,
> -- 
> Sung-Chi Li <lschyi@chromium.org>
> 

