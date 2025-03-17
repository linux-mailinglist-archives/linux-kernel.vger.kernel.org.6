Return-Path: <linux-kernel+bounces-564825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF9A65B62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFBD3B14DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FA1D61A4;
	Mon, 17 Mar 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bDis2Lu1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C181B4241;
	Mon, 17 Mar 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233606; cv=none; b=sc014ggzp3x47oel8FPlh00xxe1mYA+7cmZ7/qTTeW2LCoV/iUBf1jplX4+u1kI8QSh8YzxUQKgLiTYdIu72vLT/wSY+iz69EKLemL/Muf+6UNjAbhOJJbgi5owInz5YqlxTYfsB7dqNQCxnGbAqKMdtFKRMy487Lrg6BWx8l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233606; c=relaxed/simple;
	bh=96XrU3V7dfA10jUBILtr9fJx5dTZ4DBQF0wZ/SZDgEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcpR0WwjdiatRmNZe7uuVSzy/uQ4Sq5V0RfJ9rlp/+6PlpWQT6NW6RDfpiWmZYh5mojWIG4ruusEREHRhNrPt228eP2CQjkR5IX+ba4R0KV3JlDbIf/CbJfsVkmj/orCVvhczfTXVh2Ny1vK+aLCJY2rOTuVvcsy4FMXo3V0MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bDis2Lu1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742233593;
	bh=96XrU3V7dfA10jUBILtr9fJx5dTZ4DBQF0wZ/SZDgEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDis2Lu1Uxq21mRBB3bbm3eHvWehGkKXV9txgSaOM+D7+8M0VIm9c9vJVyYknMm6f
	 kd3zTneZbPlyKchxxE9s9A/ZhUhI6nLxGYBHAZa3j2aTVIm0uy+wuKMIjEwERemVhF
	 eL4YcEXYDhoqsYzlO9PU0kCl87MKiP0uhaxcarmo=
Date: Mon, 17 Mar 2025 18:46:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <aaa1fe3e-9813-4701-9c55-405925d8d1f7@t-8ch.de>
References: <20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org>

On 2025-03-17 14:40:26+0800, Sung-Chi Li wrote:
> The ChromeOS embedded controller (EC) supports closed loop fan speed
> control, so add the fan target attribute under hwmon framework, such
> that kernel can expose reading and specifying the desired fan RPM for
> fans connected to the EC.
> 
> When probing the cros_ec hwmon module, we also check the supported
> command version of setting target fan RPM. This commit implements the
> version 0 of getting the target fan RPM, which can only read the target
> RPM of the first fan. This commit also implements the version 0 and 1 of
> setting the target fan RPM, where the version 0 only supports setting
> all fan to the same RPM, while version 1 supports setting different RPM
> to each fan respectively.

Can you explain why this set of command compatibility was chosen?
I would have expected to fully support the v1 commands and completely
skip v0.

> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> ChromeOS embedded controller (EC) supports closed-loop fan control. We
> anticipate to have the fan related control from the kernel side, so this
> series register the HWMON_F_TARGET attribute, and implement the read and
> write function for setting/reading the target fan RPM from the EC side.
> ---
> Changes in v2:
> 
> - Squash the read, write, and register of fan target attribute to 1
>   commit, as they are the same topic.
> - Probe the supported command version from EC for setting the target fan
>   RPM, and perform the set fan target RPM based on the supported
>   version.
> - Update the used variable type to kernel types (i.e., u32).
> - Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 130 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 125 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 9991c3fa020ac859cbbff29dfb669e53248df885..b118a355f67d7238a6f596cf01a49d5b621b31d6 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -21,6 +21,12 @@ struct cros_ec_hwmon_priv {
>  	struct cros_ec_device *cros_ec;
>  	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
>  	u8 usable_fans;
> +	int set_fan_target_rpm_version;
> +};
> +
> +union ec_params_pwm_set_fan_target_rpm {
> +	struct ec_params_pwm_set_fan_target_rpm_v0 v0;
> +	struct ec_params_pwm_set_fan_target_rpm_v1 v1;
>  };

No need to give this union a name. It is only used once.
It doesn't even have to be a union but can be two dedicated on-stack
variables.

>  
>  static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> @@ -36,6 +42,25 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec,
> +					 u8 index, u32 *speed)
> +{
> +	struct ec_response_pwm_get_fan_rpm r;
> +	int ret;
> +
> +	// Currently only supports reading the first fan.
> +	if (index > 0)
> +		return -EOPNOTSUPP;

This needs to be checked in is_visible(), not here.
(Or only support v1 and not have the restriction)

> +
> +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0,
> +			  &r, sizeof(r));
> +	if (ret < 0)
> +		return ret;
> +
> +	*speed = r.rpm;

Comments from v1 still apply.

> +	return 0;
> +}
> +
>  static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
>  {
>  	unsigned int offset;
> @@ -52,6 +77,49 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec,
> +				     int version, u8 index, u16 val)
> +{
> +	union ec_params_pwm_set_fan_target_rpm req;
> +	int req_size;
> +	int ret;
> +
> +	if (version == 0) {
> +		if (index != 0)
> +			dev_warn(
> +				cros_ec->dev,
> +				"v0 only supports setting all fan to same RPM (cannot just set idx %d), set all to %d\n",
> +				index, val);

How important is v0 in general?

> +
> +		req_size = sizeof(req.v0);
> +		req.v0.rpm = val;
> +	} else if (version == 1) {
> +		req_size = sizeof(req.v1);
> +		req.v1.rpm = val;
> +		req.v1.fan_idx = index;
> +	} else
> +		return -EOPNOTSUPP;

If braces are used in the other branches, also use braces here.
Also this case can never happen, remove it.

> +
> +	ret = cros_ec_cmd(cros_ec, version, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
> +			  req_size, NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_write_fan(struct cros_ec_hwmon_priv *priv, u32 attr,
> +				   int channel, long rpm)
> +{
> +	switch (attr) {
> +	case hwmon_fan_target:
> +		return cros_ec_hwmon_set_fan_rpm(
> +			priv->cros_ec, priv->set_fan_target_rpm_version,
> +			channel, rpm);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static bool cros_ec_hwmon_is_error_fan(u16 speed)
>  {
>  	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
> @@ -75,6 +143,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  {
>  	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
>  	int ret = -EOPNOTSUPP;
> +	u32 target_rpm;
>  	u16 speed;
>  	u8 temp;
>  
> @@ -91,6 +160,11 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
>  			if (ret == 0)
>  				*val = cros_ec_hwmon_is_error_fan(speed);
> +		} else if (attr == hwmon_fan_target) {
> +			ret = cros_ec_hwmon_read_fan_target(
> +				priv->cros_ec, channel, &target_rpm);
> +			if (ret == 0)
> +				*val = target_rpm;
>  		}
>  	} else if (type == hwmon_temp) {
>  		if (attr == hwmon_temp_input) {
> @@ -130,8 +204,15 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
>  	const struct cros_ec_hwmon_priv *priv = data;
>  
>  	if (type == hwmon_fan) {
> -		if (priv->usable_fans & BIT(channel))
> +		if (!(priv->usable_fans & BIT(channel)))
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_fan_target:
> +			return 0644;
> +		default:
>  			return 0444;
> +		}
>  	} else if (type == hwmon_temp) {
>  		if (priv->temp_sensor_names[channel])
>  			return 0444;
> @@ -140,13 +221,26 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long val)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		return cros_ec_hwmon_write_fan(priv, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
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
> @@ -178,6 +272,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
>  static const struct hwmon_ops cros_ec_hwmon_ops = {
>  	.read = cros_ec_hwmon_read,
>  	.read_string = cros_ec_hwmon_read_string,
> +	.write = cros_ec_hwmon_write,
>  	.is_visible = cros_ec_hwmon_is_visible,
>  };
>  
> @@ -233,6 +328,27 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
>  	}
>  }
>  
> +static int cros_ec_hwmon_probe_fan_target_cmd_version(struct cros_ec_hwmon_priv *priv)
> +{
> +	struct ec_params_get_cmd_versions_v1 params = {
> +		.cmd = EC_CMD_PWM_SET_FAN_TARGET_RPM,
> +	};
> +	struct ec_response_get_cmd_versions response;
> +	int ret;
> +
> +	ret = cros_ec_cmd(priv->cros_ec, 1, EC_CMD_GET_CMD_VERSIONS, &params,
> +			  sizeof(params), &response, sizeof(response));

cros_ec_get_cmd_versions().

> +	if (ret < 0) {
> +		dev_err(priv->cros_ec->dev,
> +			"error getting target fan RPM set command version: %d\n", ret);
> +		return ret;
> +	}

If neither v0 nor v1 are supported, this will completely prevent the
driver from being probed. Is this intentional?

> +
> +	priv->set_fan_target_rpm_version = (response.version_mask & EC_VER_MASK(1)) ? 1 : 0;
> +
> +	return 0;
> +}
> +
>  static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -260,6 +376,10 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
>  	cros_ec_hwmon_probe_fans(priv);
>  
> +	ret = cros_ec_hwmon_probe_fan_target_cmd_version(priv);
> +	if (ret < 0)
> +		return ret;
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
>  							 &cros_ec_hwmon_chip_info, NULL);
>  
> 
> ---
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
> 
> Best regards,
> -- 
> Sung-Chi Li <lschyi@chromium.org>
> 

