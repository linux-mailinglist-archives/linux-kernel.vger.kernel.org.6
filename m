Return-Path: <linux-kernel+bounces-565447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D585A66846
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA4C7A2CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24DC1A264A;
	Tue, 18 Mar 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHyB08cA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6143FC3;
	Tue, 18 Mar 2025 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272059; cv=none; b=m2u/xPqG7kOG6ZNly3VSmuTILYR7WbJcdjksaUGiny0fKJVg7stVN54p4FXLfBeXVi0WcozFfeuh0eeLCR1RKWur99z2BIoeeXAnQFtanwxjYi+fQszMPtNnBJ+CpL7L5s58exFAnh4ZA2HbYd9f7cQNIYwEHUBG3EAmINwdpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272059; c=relaxed/simple;
	bh=Kl8Qli8u4cuAPMvGPlAuCblwOZFuAtWfpZKwPes5DAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/fdNBo+s1vlCIV7ZfTTZn0RcBwga2toel/zAe+/KyGKpZqO2c5K+y0w5ZbpgqEbe5x/fHGT8aBkWvskmdu/kpDDj7wLdbv6+Qw0Vh1Jg5uEmJFPMXCLsnhZY9KY8PPsSyzbmBWUBmH5lGuqvJ5hI6mScJR6utDyUHBeZBLjONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHyB08cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD01CC4CEDD;
	Tue, 18 Mar 2025 04:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742272058;
	bh=Kl8Qli8u4cuAPMvGPlAuCblwOZFuAtWfpZKwPes5DAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mHyB08cASrv9Y7VslNpRWvUa1rUN+UIJ+raZfBtumeWhjSZZ9waoR3y3Gdc+lQHKO
	 8wELw/nWiKby5j2QAXgqeBHM9+gTE3nM5Y277JMXiZGNspQ5qfK4mcZreAj8AEqEz2
	 2mGkCzE7wq3rfqYgqPRo+ib8F43fJCZHQez2wRdqprSYLgoIf5ClsYJSQJILe3Cq+0
	 9qPolEn2/pHBHgBc1XBOkDZ8GsNJTSWmJA+nsjzKsQIXK9MLtQ+T74CBSvGFEh2oUR
	 0PZudJYCNrwypI15lrCG+IvJk8VWXMJUh2JnG1oKw3ARbY6/kMtB67n9jgK+aMu5/N
	 59+l27xpJsmgQ==
Message-ID: <ae61a8ab-f5ae-4369-ac35-49b37fe412fc@kernel.org>
Date: Mon, 17 Mar 2025 23:27:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6 RESEND] platform/x86: Add lenovo-wmi-helpers
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
 <20250317144326.5850-3-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250317144326.5850-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 09:43, Derek J. Clark wrote:
> Adds documentation for all new lenovo-wmi drivers.

You seem to have accidentally lost the commit message for this patch 
from earlier versions and got the exact same commit message as the first 
patch.

With that fixed the rest of the patch looks fine.  You can add for next 
version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v4:
>   - Changed namespace to LENOVO_WMI_HELPERS from LENOVO_WMI.
>   - Changed filenames to lenovo-wmi-helpers from lenovo-wmi.
>   - Removed structs and functions implemented by other drivers.
> ---
>   MAINTAINERS                               |  2 +
>   drivers/platform/x86/Kconfig              |  4 ++
>   drivers/platform/x86/Makefile             |  1 +
>   drivers/platform/x86/lenovo-wmi-helpers.c | 64 +++++++++++++++++++++++
>   drivers/platform/x86/lenovo-wmi-helpers.h | 24 +++++++++
>   5 files changed, 95 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 675f4b26426d..3a370a18b806 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-helpers.c
> +F:	drivers/platform/x86/lenovo-wmi-helpers.h
>   
>   LENOVO WMI HOTKEY UTILITIES DRIVER
>   M:	Jackie Dong <xy-jackie@139.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 43407e76476b..bece1ba61417 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -459,6 +459,10 @@ config IBM_RTL
>   	 state = 0 (BIOS SMIs on)
>   	 state = 1 (BIOS SMIs off)
>   
> +config LENOVO_WMI_HELPERS
> +	tristate
> +	depends on ACPI_WMI
> +
>   config IDEAPAD_LAPTOP
>   	tristate "Lenovo IdeaPad Laptop Extras"
>   	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 650dfbebb6c8..5a9f4e94f78b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
>   
>   # Intel
>   obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-helpers.c b/drivers/platform/x86/lenovo-wmi-helpers.c
> new file mode 100644
> index 000000000000..36d553502223
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-helpers.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Legion WMI helpers driver. The Lenovo Legion WMI interface is
> + * broken up into multiple GUID interfaces that require cross-references
> + * between GUID's for some functionality. The "Custom Method" interface is a
> + * legacy interface for managing and displaying CPU & GPU power and hwmon
> + * settings and readings. The "Other Mode" interface is a modern interface
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various status
> + * lights related to different hardware components. Each of these drivers
> + * uses a common procedure to get data fro the WMI interface, enumerated here.
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +
> +#include <linux/wmi.h>
> +#include "lenovo-wmi-helpers.h"
> +
> +/*
> + * lwmi_dev_evaluate_method() - Helper function to call wmidev_evaluate_method
> + * for Lenovo WMI device method calls that return an ACPI integer.
> + * @wdev: Pointer to the WMI device to be called.
> + * @instance: Instance of the called method.
> + * @method_id: WMI Method ID for the method to be called.
> + * @buf: Buffer of all arguments for the given method_id.
> + * @size: Length of the buffer.
> + * @retval: Pointer for the return value to be assigned.
> + *
> + * Returns: 0, or an error.
> + */
> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
> +			     u32 method_id, unsigned char *buf, size_t size,
> +			     u32 *retval)
> +{
> +	struct acpi_buffer input = { size, buf };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *ret_obj __free(kfree) = NULL;
> +	acpi_status status;
> +
> +	status = wmidev_evaluate_method(wdev, instance, method_id, &input,
> +					&output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (retval) {
> +		ret_obj = output.pointer;
> +		if (!ret_obj)
> +			return -ENODATA;
> +
> +		if (ret_obj->type != ACPI_TYPE_INTEGER)
> +			return -ENXIO;
> +
> +		*retval = (u32)ret_obj->integer.value;
> +	}
> +	return 0;
> +};
> +EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_method, "LENOVO_WMI_HELPERS");
> +
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi-helpers.h b/drivers/platform/x86/lenovo-wmi-helpers.h
> new file mode 100644
> index 000000000000..7e0d7870790e
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-helpers.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +#include <linux/notifier.h>
> +#include <linux/platform_profile.h>
> +
> +#ifndef _LENOVO_WMI_HELPERS_H_
> +#define _LENOVO_WMI_HELPERS_H_
> +
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +
> +struct wmi_method_args_32 {
> +	u32 arg0;
> +	u32 arg1;
> +};
> +
> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
> +			     u32 method_id, unsigned char *buf, size_t size,
> +			     u32 *retval);
> +
> +#endif /* !_LENOVO_WMI_HELPERS_H_ */


