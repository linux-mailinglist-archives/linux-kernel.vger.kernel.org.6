Return-Path: <linux-kernel+bounces-577623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC5A71F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3547A4835
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F41DD539;
	Wed, 26 Mar 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B0IPwAmz"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AC18DB19
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018502; cv=none; b=ZSTN6tW+KPDWpEmBjSPuewucPEstdlR5TWRGLsw9eBsqcsDFyPpLaUhK9vUxruO3+eEAOiJFOgR4MsRABSz4chkpgELxQQIoiGTBkRapkMYJCZnrH2neeaSMIbt2FQXIHFoks5bTjHhAJB2iRG/4oPPqeNaJNWdZWqk9qXRcwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018502; c=relaxed/simple;
	bh=0XnBnD4+ydufiq09f7pvFepxh2CUzKDKLLHDKetzYYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meJfWZZbZTxZ1SEQbZXlzb886B+3RejBEXjGdOHkvFlTHmgyrHvHG7kKvrxvRNpnyyzqmFvD+Lg/pM1essCKyrx3BT4b3d8W9ABIrtaq2awiXs0TJqSeJ+QjsDcf92NMAGIrVKCKvO0bcbIXiRAo/Dp7q94m9BdV1DpyHvohcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B0IPwAmz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26a2f86e-2dcf-45d1-917e-764654b2fdf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743018489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46v2ME6r8Bz45TvoQm1oLuVGFCxnVNUplbEi7rFWwzg=;
	b=B0IPwAmzrKghZ1igT9tb1imWpc63CTvkKks/6et2t/Z+r5evjY2yuW8DL0YJZ9m8TsI3re
	S5UcafTBasXR1hs4cetKNHhbWPwlE1ox1dpyAVj6xHQgfVoZuz3gsRtDEWaMjfY+uw6wbF
	xaJp2y76dRHL8jL5nOt82RLY7YLgEik=
Date: Wed, 26 Mar 2025 12:47:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/6 RESEND] platform/x86: Add Lenovo Capability Data 01
 WMI Driver
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
 <20250317144326.5850-5-derekjohn.clark@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20250317144326.5850-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/17/25 7:43 AM, Derek J. Clark wrote:
> Adds lenovo-wmi-capdata01 driver which provides the
> LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
> enabled hardware. Provides an interface for querying if a given
> attribute is supported by the hardware, as well as its default_value,
> max_value, min_value, and step increment.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

All exposed attributes are passed to "Other Mode" on my Legion Go and Legion Go S.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

> ---
> v4:
>  - Make driver data a private struct, remove references from Other Mode
>    driver.
>  - Don't cache data at device initialization. Instead, on component bind,
>    cache the data on a member variable of the Other Mode driver data
>    passed as a void pointer.
>  - Add header file for capdata01 structs.
>  - Add new struct to pass capdata01 array data and array length to Other
>    Mode.
> v3:
> - Add as component to lenovo-wmi-other driver.
> v2:
> - Use devm_kmalloc to ensure driver can be instanced, remove global
>   reference.
> - Ensure reverse Christmas tree for all variable declarations.
> - Remove extra whitespace.
> - Use guard(mutex) in all mutex instances, global mutex.
> - Use pr_fmt instead of adding the driver name to each pr_err.
> - Remove noisy pr_info usage.
> - Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
> - Use list to get the lenovo_wmi_cd01_priv instance in
>   lenovo_wmi_capdata01_get as none of the data provided by the macros
>   that will use it can pass a member of the struct for use in
>   container_of.
> ---
>  MAINTAINERS                                 |   2 +
>  drivers/platform/x86/Kconfig                |   4 +
>  drivers/platform/x86/Makefile               |   1 +
>  drivers/platform/x86/lenovo-wmi-capdata01.c | 136 ++++++++++++++++++++
>  drivers/platform/x86/lenovo-wmi-capdata01.h |  29 +++++
>  5 files changed, 172 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dde75922aaf..56ead241a053 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>  F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-capdata01.c
> +F:	drivers/platform/x86/lenovo-wmi-capdata01.h
>  F:	drivers/platform/x86/lenovo-wmi-events.c
>  F:	drivers/platform/x86/lenovo-wmi-events.h
>  F:	drivers/platform/x86/lenovo-wmi-helpers.c
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 13b8f4ac5dc5..64663667f0cb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -467,6 +467,10 @@ config LENOVO_WMI_HELPERS
>  	tristate
>  	depends on ACPI_WMI
>  
> +config LENOVO_WMI_DATA01
> +	tristate
> +	depends on ACPI_WMI
> +
>  config IDEAPAD_LAPTOP
>  	tristate "Lenovo IdeaPad Laptop Extras"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index fc039839286a..7a35c77221b7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>  obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>  obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_DATA01)	+= lenovo-wmi-capdata01.o
>  obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
>  obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
>  
> diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/platform/x86/lenovo-wmi-capdata01.c
> new file mode 100644
> index 000000000000..b6876611ffd9
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface provides
> + * information on tunable attributes used by the "Other Mode" WMI interface,
> + * including if it is supported by the hardware, the default_value, max_value,
> + * min_value, and step increment.
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/component.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/gfp_types.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +#include "lenovo-wmi-capdata01.h"
> +
> +/* Interface GUIDs */
> +#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
> +
> +struct lwmi_cd01_priv {
> +	struct wmi_device *wdev;
> +};
> +
> +/*
> + * lenovo_cd01_component_bind() - On master bind, caches all capability data on
> + * the master device.
> + * @cd01_dev: Pointer to the capability data 01 parent device.
> + * @om_dev: Pointer to the other mode parent device.
> + * @data: capdata01_list object pointer to return the capability data with.
> + *
> + * Returns: 0, or an error.
> + */
> +static int lenovo_cd01_component_bind(struct device *cd01_dev,
> +				      struct device *om_dev, void *data)
> +{
> +	struct lwmi_cd01_priv *priv = dev_get_drvdata(cd01_dev);
> +	int count, idx;
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	count = wmidev_instance_count(priv->wdev);
> +
> +	if (count == 0)
> +		return -EINVAL;
> +
> +	((struct cd01_list *)data)->count = count;
> +	((struct cd01_list *)data)->data = devm_kmalloc_array(om_dev, count,
> +							      sizeof(struct capdata01 *),
> +							      GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	for (idx = 0; idx < count; idx++) {
> +		union acpi_object *ret_obj __free(kfree) = NULL;
> +
> +		ret_obj = wmidev_block_query(priv->wdev, idx);
> +		if (!ret_obj) {
> +			((struct cd01_list *)data)->data[idx] = NULL;
> +			continue;
> +		}
> +		if (ret_obj->type != ACPI_TYPE_BUFFER) {
> +			((struct cd01_list *)data)->data[idx] = NULL;
> +			continue;
> +		}
> +
> +		if (ret_obj->buffer.length != sizeof(struct capdata01)) {
> +			((struct cd01_list *)data)->data[idx] = NULL;
> +			continue;
> +		}
> +
> +		((struct cd01_list *)data)->data[idx] =
> +			devm_kmemdup(om_dev, ret_obj->buffer.pointer,
> +				     ret_obj->buffer.length, GFP_KERNEL);
> +	}
> +	return 0;
> +}
> +
> +static const struct component_ops lenovo_cd01_component_ops = {
> +	.bind = lenovo_cd01_component_bind,
> +};
> +
> +static int lwmi_cd01_probe(struct wmi_device *wdev, const void *context)
> +
> +{
> +	struct lwmi_cd01_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdev = wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	ret = component_add(&wdev->dev, &lenovo_cd01_component_ops);
> +
> +	return ret;
> +}
> +
> +static void lwmi_cd01_remove(struct wmi_device *wdev)
> +{
> +	component_del(&wdev->dev, &lenovo_cd01_component_ops);
> +}
> +
> +static const struct wmi_device_id lwmi_cd01_id_table[] = {
> +	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> +	{}
> +};
> +
> +static struct wmi_driver lwmi_cd01_driver = {
> +	.driver = {
> +		.name = "lenovo_wmi_cd01",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lwmi_cd01_id_table,
> +	.probe = lwmi_cd01_probe,
> +	.remove = lwmi_cd01_remove,
> +	.no_singleton = true,
> +};
> +
> +int lwmi_cd01_match(struct device *dev, void *data)
> +{
> +	return dev->driver == &lwmi_cd01_driver.driver;
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD01");
> +
> +module_wmi_driver(lwmi_cd01_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lwmi_cd01_id_table);
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.h b/drivers/platform/x86/lenovo-wmi-capdata01.h
> new file mode 100644
> index 000000000000..c7067a8d0398
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-capdata01.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +
> +#ifndef _LENOVO_WMI_CAPDATA01_H_
> +#define _LENOVO_WMI_CAPDATA01_H_
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +struct capdata01 {
> +	u32 id;
> +	u32 supported;
> +	u32 default_value;
> +	u32 step;
> +	u32 min_value;
> +	u32 max_value;
> +};
> +
> +struct cd01_list {
> +	struct capdata01 **data;
> +	int count;
> +};
> +
> +int lwmi_cd01_match(struct device *dev, void *data);
> +
> +#endif /* !_LENOVO_WMI_CAPDATA01_H_ */


