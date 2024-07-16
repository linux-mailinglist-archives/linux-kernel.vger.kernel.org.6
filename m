Return-Path: <linux-kernel+bounces-254331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C99331DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF50EB2328D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E141A01DB;
	Tue, 16 Jul 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFXv4IV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E419FA89;
	Tue, 16 Jul 2024 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158100; cv=none; b=pTPxkjZWSp9GRq4a7o1/EVnXEBFDWhqMkyNLCs68f7IOWBqfxD+9z60FCcPre3F3GNlDgmY1Tioi0JSIRwU5TdBEp/JiwmxCmTMzOH9S2gypyCfVpt2dn0hacNBKzmnc72+41MGfrUPjhTR7Uq2TH6SUZ/PalwaVnsM4o2ihuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158100; c=relaxed/simple;
	bh=fwZzjZvpJ3NtNYL2pxXVDsofjYRn+aeMt0sGGQb+k3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spcrJdl7d/SONV4+V8blRSEoZfiLW8U4Z1FBD29PsW51KpcBvCq3CKQMxHSv1MDy/TuU48p3Ri5+MwXxiUaiAZXHDGP+IDBTuZu5B4L/FRDIsALsjB5KKs/xTA+aAlCaRraFoUi2tCAtIMTgY4VyMqnkDS4qhEAcF2v768p18ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFXv4IV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9BDC116B1;
	Tue, 16 Jul 2024 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721158100;
	bh=fwZzjZvpJ3NtNYL2pxXVDsofjYRn+aeMt0sGGQb+k3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IFXv4IV6sa+x2zE/ELDtws5cZOkWvdHOZ76ERZa+wp9M7UjYDRKvlZhGAcZN/aErN
	 BSkn/LAXcKiemmuQKne9K5CmBiMfUiRyo7bftcYo9d89FjWGR3dYw4rpHgMcxJZjKw
	 n6MwqS+SUihuNsNPcgS4YwPr1LUDltnYI10iM+7LLHsSHbDQFs1TshQH9VKn7T4gZa
	 gsG7NVwRA0QmzGlPwboOqyDXZTlVjdz76IeMJjXDNNF41WzqR5lyvWf9pjqKBalkyj
	 l+1nYCBrmTsG2mNZD7jI9OkcQV+153cQCwJjDc0T1UOM6A4ulz3K12+wFjfvEiwSuV
	 pcCfEZBd232pA==
Message-ID: <7e4e45e1-9a77-4780-a5bd-ac44cd7c6cdd@kernel.org>
Date: Tue, 16 Jul 2024 21:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
 <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2024 18:58, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped IO.
> I have tested it on my device.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  MAINTAINERS             |   6 +
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/gpd-fan.c | 759 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 776 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af4b4c271342..9ced72cec42b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9372,6 +9372,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
>  F:	include/dt-bindings/clock/google,gs101.h
>  K:	[gG]oogle.?[tT]ensor
>  
> +GPD FAN DRIVER
> +M:	Cryolitia PukNgae <Cryolitia@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/gpd-fan.c
> +
>  GPD POCKET FAN DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..368165a25979 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -727,6 +727,16 @@ config SENSORS_GL520SM
>  	  This driver can also be built as a module. If so, the module
>  	  will be called gl520sm.
>  
> +config SENSORS_GPD
> +	tristate "GPD EC fan control"
> +	depends on X86
> +	help
> +	  If you say yes here you get support for fan readings and
> +	  control over GPD handheld devices.
> +
> +	  Can also be built as a module. In that case it will be
> +	  called gpd-fan.
> +
>  config SENSORS_G760A
>  	tristate "GMT G760A"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..91c288451290 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> +obj-$(CONFIG_SENSORS_GPD)	+= gpd-fan.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>  obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> new file mode 100644
> index 000000000000..b7e7e73528af
> --- /dev/null
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -0,0 +1,759 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/ioport.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "gpdfan"
> +
> +static char *gpd_fan_model = "";
> +module_param(gpd_fan_model, charp, 0444);
> +
> +static DEFINE_MUTEX(gpd_fan_locker);
> +
> +enum FUN_PWM_ENABLE {

FUN?

> +	DISABLE = 0,
> +	MANUAL = 1,
> +	AUTOMATIC = 2,
> +};
> +
> +struct driver_private_data {
> +	enum FUN_PWM_ENABLE pwm_enable;
> +	u8 pwm_value;
> +
> +	u16 fan_speed_cached;
> +	u8 read_pwm_cached;
> +
> +	// minimum 1000 mill seconds
> +	u32 update_interval_per_second;
> +
> +	unsigned long fan_speed_last_update;
> +	unsigned long read_pwm_last_update;
> +
> +	const struct model_quirk *const quirk;
> +};
> +
> +struct model_ec_address {
> +	const u8 addr_port;
> +	const u8 data_port;
> +	const u16 manual_control_enable;
> +	const u16 rpm_read;
> +	const u16 pwm_write;
> +	const u16 pwm_max;
> +};
> +
> +struct model_quirk {
> +	const char *model_name;
> +
> +	bool tested;

Why would you add here untested models?

> +
> +	const struct model_ec_address address;
> +
> +	int (*const read_rpm)(struct driver_private_data *, u16 *);
> +
> +	int (*const set_pwm_enable)(struct driver_private_data *,
> +				    enum FUN_PWM_ENABLE);
> +

Drop all or most of these blank lines.

> +	int (*const read_pwm)(struct driver_private_data *, u8 *);
> +
> +	int (*const write_pwm)(const struct driver_private_data *, u8);
> +};
> +
> +static int gpd_ecram_read(const struct model_ec_address *const address,
> +			  const u16 offset, u8 *const val)
> +{
> +	int ret = mutex_lock_interruptible(&gpd_fan_locker);

Don't mix mutexes with variable declaration. See existing examples how
this looks like.


> +
> +static const struct model_quirk gpd_win4_quirk = {

You mix data definition with functions. That's confusing code. Look at
other recent drivers how this is organized, usually definitions are
together.

> +	.model_name = "win4",
> +	.tested = false,
> +	.address = {
> +		.addr_port = 0x2E,
> +		.data_port = 0x2F,
> +		.manual_control_enable = 0xC311,
> +		.rpm_read = 0xC880,
> +		.pwm_write = 0xC311,
> +		.pwm_max = 127,
> +	},
> +	.read_rpm = gpd_win4_read_rpm,
> +	// same as GPD Win Mini
> +	.set_pwm_enable = gpd_win_mini_set_pwm_enable,
> +	.read_pwm = gpd_read_pwm,
> +	// same as GPD Win Mini
> +	.write_pwm = gpd_win_mini_write_pwm,
> +};
> +> +static int
> +gpd_wm2_read_rpm_uncached(const struct driver_private_data *const data,
> +			  u16 *const val)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +
> +	for (u16 pwm_ctr_offset = 0x1841; pwm_ctr_offset <= 0x1843;
> +		 pwm_ctr_offset++) {
> +		u8 PWMCTR;
> +
> +		gpd_ecram_read(address, pwm_ctr_offset, &PWMCTR);
> +		if (PWMCTR != 0xB8)
> +			gpd_ecram_write(address, pwm_ctr_offset, 0xB8);
> +	}
> +	return gpd_read_rpm_uncached(data, val);
> +}
> +
> +static int gpd_wm2_read_rpm(struct driver_private_data *const data,
> +			    u16 *const val)

All your functions are really weird.

The const here is just meaningless. So meaningless that just wrong and
confusing, even though technically correct.

This applies everywhere - drop this odd style and keep only meaningful
const.


...

> +
> +static int gpd_fan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct driver_private_data *data;
> +
> +	data = dev_get_platdata(&pdev->dev);
> +	if (IS_ERR_OR_NULL(data))
> +		return -ENODEV;
> +
> +	const struct resource *plat_res =
> +		platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (IS_ERR_OR_NULL(plat_res)) {
> +		pr_warn("Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	const struct resource *region_res = devm_request_region(
> +		dev, plat_res->start, resource_size(plat_res), DRIVER_NAME);
> +	if (IS_ERR_OR_NULL(region_res)) {
> +		pr_warn("Failed to request region\n");
> +		return -EBUSY;
> +	}
> +
> +	const struct device *dev_reg = devm_hwmon_device_register_with_info(


Declarations go to the top of the function.

> +		dev, DRIVER_NAME, data, &gpd_fan_chip_info, NULL);
> +	if (IS_ERR_OR_NULL(dev_reg)) {
> +		pr_warn("Failed to register hwmon device\n");
> +		return -EBUSY;
> +	}
> +
> +	struct dentry *debug_fs_entry = debugfs_create_dir(DRIVER_NAME, NULL);
> +
> +	if (!IS_ERR(debug_fs_entry)) {
> +		DEBUG_FS_ENTRY = debug_fs_entry;
> +		debugfs_create_file_size("manual_control_reg",
> +					 0600, DEBUG_FS_ENTRY,
> +					 (void *)&data->quirk->address,
> +					 &debugfs_manual_control_fops,
> +					 sizeof(u8));
> +		debugfs_create_file_size("pwm_reg", 0600,
> +					 DEBUG_FS_ENTRY,
> +					 (void *)&data->quirk->address,
> +					 &debugfs_pwm_fops, sizeof(u8));
> +	}
> +
> +	pr_debug("GPD Devices fan driver probed\n");

Drop

> +	return 0;
> +}
> +
> +static int gpd_fan_remove(__always_unused struct platform_device *pdev)
> +{
> +	struct driver_private_data *data = dev_get_platdata(&pdev->dev);
> +
> +	data->pwm_enable = AUTOMATIC;
> +	data->quirk->set_pwm_enable(data, AUTOMATIC);
> +
> +	if (!IS_ERR_OR_NULL(DEBUG_FS_ENTRY)) {
> +		debugfs_remove_recursive(DEBUG_FS_ENTRY);
> +		DEBUG_FS_ENTRY = NULL;
> +	}
> +
> +	pr_debug("GPD Devices fan driver removed\n");

Drop

> +	return 0;
> +}
> +
> +static struct platform_driver gpd_fan_driver = {
> +	.probe = gpd_fan_probe,
> +	.remove = gpd_fan_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +static struct platform_device *gpd_fan_platform_device;

static, so how do you support more than one device?

> +
> +static int __init gpd_fan_init(void)
> +{
> +	const struct model_quirk *match = NULL;
> +
> +	for (const struct model_quirk **p = gpd_module_quirks; *p != NULL;
> +		 p++) {
> +		if (strcmp(gpd_fan_model, (*p)->model_name) == 0) {
> +			match = *p;
> +			break;
> +		}
> +	}
> +
> +	if (match == NULL) {
> +		match = dmi_first_match(gpd_devices)->driver_data;
> +		if (!IS_ERR_OR_NULL(match) && !match->tested) {
> +			pr_warn("GPD Fan Driver do have the quirk for your device, but it's not tested. Please tested carefully by model parameter gpd_fan_model=%s and report.\n",
> +				match->model_name);
> +			match = NULL;
> +		}
> +	}
> +
> +	if (IS_ERR_OR_NULL(match)) {
> +		pr_debug("GPD Devices not supported\n");

Drop

> +		return -ENODEV;
> +	}
> +
> +	pr_info("Loading GPD fan model quirk: %s\n", match->model_name);

Drop

> +
> +	struct driver_private_data data = {
> +		.pwm_enable = AUTOMATIC,
> +		.pwm_value = 255,
> +		.fan_speed_cached = 0,
> +		.read_pwm_cached = 0,
> +		.update_interval_per_second = 1,
> +		.fan_speed_last_update = jiffies,
> +		.read_pwm_last_update = jiffies,
> +		.quirk = match,
> +	};
> +
> +	struct resource gpd_fan_resources[] = {
> +		{
> +			.start = data.quirk->address.addr_port,
> +			.end = data.quirk->address.data_port,
> +			.flags = IORESOURCE_IO,
> +		},
> +	};
> +
> +	gpd_fan_platform_device = platform_create_bundle(
> +		&gpd_fan_driver, gpd_fan_probe, gpd_fan_resources, 1, &data,
> +		sizeof(struct driver_private_data));
> +
> +	if (IS_ERR(gpd_fan_platform_device)) {
> +		pr_warn("Failed to create platform device\n");

Drop

> +		return PTR_ERR(gpd_fan_platform_device);
> +	}
> +
> +	pr_debug("GPD Devices fan driver loaded\n");

Drop such debug statements, kernel cannot print anything on module
loading/unloading.


> +	return 0;
> +}
> +
> +static void __exit gpd_fan_exit(void)
> +{
> +	platform_device_unregister(gpd_fan_platform_device);
> +	platform_driver_unregister(&gpd_fan_driver);
> +	pr_debug("GPD Devices fan driver unloaded\n");

Drop such debug statements, kernel cannot print anything on module
loading/unloading.

> +}
> +
> +module_init(gpd_fan_init)
> +
> +	module_exit(gpd_fan_exit)
> +
> +		MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cryolitia <Cryolitia@gmail.com>");

That's some odd indentation above.

Best regards,
Krzysztof


