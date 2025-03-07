Return-Path: <linux-kernel+bounces-552097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF3A575BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B19F3ABA18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BF258CF5;
	Fri,  7 Mar 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AE0+SHRe"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CF19006F;
	Fri,  7 Mar 2025 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388712; cv=none; b=KzKdFZSTMtiqhnujPXxZD9dBgQPpnCsguGh2ynsPCtu2PsV4X5OUGkGJDkiuGGCNLECE/J+n//ojafSKmAwiwrZxdfEPiSw/GiT7xrE1XFf0RWmFFB/A8TaBEHDjEtRDnVEUT7seKSb/YIggc6Rmp84YrgoxOd7bb/RQWdO1YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388712; c=relaxed/simple;
	bh=dPjV6qr5bduWD1uGC/xdThRclFntVnoo9J9fXjkAPUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlqzZqrzHRxofNw1ry8DRzuwPtDIwIe8nbk+pbUs2/PCeFroqaG8P/+LtYDE4pC8OxCAj3858tvdRKxLvSePAceMgPMfMTm2pFoaMoFKneANVPH18FqYYjMTd5tb108nT/CMIZ00gNBHh34ULfsH5jT0yTOeViguXJilWuQBwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AE0+SHRe; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741388682; x=1741993482; i=w_armin@gmx.de;
	bh=JFvsgHh/aKf8sPNJsNPn3odDpW5n1RGgRixtE6DoZSQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AE0+SHReeFRl+J/qe3zx+J8q0l8+TgzvmuCP4ZUN8DPxP0XqO/PrkatrlSz56U0B
	 RrmTOLQL9/Ojb1zETJmF2MQLmRTScUdII1A1NSQvwEYCxyZ5gpBEfxnUCNPV4dPPW
	 8uSTPU700MyOMTCfrRRqkjTB4cIBNWw+uaL08imK37qri5Q80D1FZGVFwTQDROUZU
	 3KLAICQNUnSGy/bVgdC4BBPdOV0EshiW4soov1V0CDaewyffpDtrVcmC1Alvv9XXL
	 voOcAoF8vxpf+kQAXoyU6LdQ3JBSeHztDjm85MIHKMpVt+Olri/yhUJU98cHiZRg2
	 abU31NuqrL23UbznDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1t5Rmf3trw-0130ZC; Sat, 08
 Mar 2025 00:04:42 +0100
Message-ID: <8605fff9-0fac-45e6-a5ce-a3b04fe81b9f@gmx.de>
Date: Sat, 8 Mar 2025 00:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] platform/x86: Add Lenovo Capability Data 01 WMI
 Driver
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-4-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250225220037.16073-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njtD0EYeBRKA8tP9azBpCO7IhmhcIuUVmEKt0EVF8rMmvmWPykz
 uN7NJHyrCc7L3NDhKb+7ss5MxpMj/ig0xEoZqAtHVjn99GR5YIyiR+5yPEBUQP5B14csQug
 25XXldi8Gp1Lkm01RYJOOxRZk0Z7ejjGGkET4ToL+FKVChRcWQXkd6r9oYTNLvO9mFEM+SX
 63QECCH/Wgg8qR6vqBVEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bi3d9a5Nehs=;doYaFnPUKtnv7jhfZgdexG8Q8e8
 vN+SHse7/QotKDV5X/9DqxgmgMQd5osrnFbZtm5PmM3I1NCSiGew8CcSG9vakCchZzUUMYBmB
 vQhxQ4+sKu1/qjx1xDBvuF4XCmSSUeEevn+KCJfO0dPmXBXfYndx6sZy+mP+Unr4444Gox2wV
 GHANdttmeMcMI5fhTfRv6Ld1UwZLrptzxZwphl5G1KdEcqe5dQbJUIisTumEEPHD/abEvhilL
 dA3MxkSaudQz3gJVqrDqSyJdpMdlOMqehfc7xF5A4jKbx3tIPg+gA1y307jeG4zXDd9DIgwJn
 kg2wpcyBVhkH9pEDZNRi1wRt7YYdxEyR4lRI3lfWWgTkP207H1+c2AUzggoHyrBmUiWj5ihtO
 7wn6TG9oPv1mMGgr7LdqIfgWPb6QHgz64n6VV1rCb6Cvw5RAhaTlkOmRbavUGwHdluzz5U6UH
 FvYtjhXVcjuCRDfmeHgWuJITH/1gOUt4MeIsToaFWrDo1P2fn1E157Sdn7d5ddms39ILhmzDi
 2NqajsMaEd0OJuKMM35qY4z+Jj4zJUBWbkm/SM3YtHQJGCnIZHKRwxUYqEJ6NmP8mESpLLbBt
 ECVaUGIi87MscnDvZn265IpIrg8SZxJ0Xew6wc+e4l4lNl7yYyHeWIoSn+L5TyE0BsVt5NNMV
 KHE1JctIxXPxCsIi9dVF6QMrjgPFfumu+GbjLdQaOw4b+npuOq1zD+ICyOH7KUurmAsxyx4mw
 KM2XwbYA16xuiELrSmKy8ikKCd/bLqmpohGR3uSs0uIB/5VjeSkkkDAMxrwODsQY6/gdiBkL+
 G1yQAXTF8+A7FdLPT0FafsIYTyA3WZpYz1rV67lm9ROAVTE5ntPmZ2fOtJrIo7HjoxdBX5ESJ
 kJalO17S/tglbDTUo+Zk+J5KCYOk6WwETFGY6+XeVWRTO35uhIIlQO2/eTHWLVNe/VNvohAQ+
 iR7QNSkNWa8s8DjUwzALm8XEErJgIvBpxnm+itRvzbVdLJSwQdHM2FozAuZjgwhSi+ocFZM1J
 4vUd36W3gdH0adRytkvoxZgRIaSdGZMYw65sVCmt1zsOQVm2EfYBz6l47jufsGPhMU/zGJCBz
 jb7YLWBgvFO9FvFw5/EdV7YWDTKxO6luUB06327O9C5cIYLxcMGzfbh7/m7/1Xm8vMxkzycjC
 Dj3WpDsAUMGa3zS2f6J/PEml1oCmfGsLk48fraJtjPCepsQJc5yIBJi32ikfNa3/6cpZg3bv5
 zNy08eYlz5b5kYBbV5BNPpyds9mFnlJBaHS+KFK2bMzsD1WwuY8xRVV/DCTHaIAW4CE5L0hRM
 SvyHO7pmanycYMQ6iUigWubeg5NgID/iyYExUxPeGLIKU2Y2u6+Mk9BmSPdPW70BAdQIX3yaI
 T77hcbEpxCP9dqPBZCdFN4hIoz56iAA5mEoatcu9Nk2W4ichbXV/4Yfy7t

Am 25.02.25 um 22:59 schrieb Derek J. Clark:

> Adds lenovo-wmi-capdata01.c which provides a driver for the
> LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
> enabled hardware. Provides an interface for querying if a given
> attribute is supported by the hardware, as well as its default_value,
> max_value, min_value, and step increment.
> v3:
> - Add as component to lenovo-wmi-other driver.
> v2:
> - Use devm_kmalloc to ensure driver can be instanced, remove global
>    reference.
> - Ensure reverse Christmas tree for all variable declarations.
> - Remove extra whitespace.
> - Use guard(mutex) in all mutex instances, global mutex.
> - Use pr_fmt instead of adding the driver name to each pr_err.
> - Remove noisy pr_info usage.
> - Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
> - Use list to get the lenovo_wmi_cd01_priv instance in
>    lenovo_wmi_capdata01_get as none of the data provided by the macros
>    that will use it can pass a member of the struct for use in
>    container_of.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   MAINTAINERS                                 |   1 +
>   drivers/platform/x86/Kconfig                |   5 +
>   drivers/platform/x86/Makefile               |   1 +
>   drivers/platform/x86/lenovo-wmi-capdata01.c | 140 ++++++++++++++++++++
>   drivers/platform/x86/lenovo-wmi.h           |  19 +++
>   5 files changed, 166 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf7f4fce1a25..f6d3e79e50ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13157,6 +13157,7 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-capdata01.c
>   F:	drivers/platform/x86/lenovo-wmi-gamezone.c
>   F:	drivers/platform/x86/lenovo-wmi.c
>   F:	drivers/platform/x86/lenovo-wmi.h
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 875822e6bd65..56336dc3c2d0 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called lenovo-wmi-gamezone.
>
> +config LENOVO_WMI_DATA01
> +	tristate
> +	depends on ACPI_WMI
> +	select LENOVO_WMI
> +
>   config IDEAPAD_LAPTOP
>   	tristate "Lenovo IdeaPad Laptop Extras"
>   	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 4a7b2d14eb82..be9031bea090 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)		+=3D lenovo-yoga-tab2-pro-1380=
-fastcharger.o
>   obj-$(CONFIG_LENOVO_WMI)	+=3D lenovo-wmi.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>   obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+=3D lenovo-wmi-gamezone.o
> +obj-$(CONFIG_LENOVO_WMI_DATA01)	+=3D lenovo-wmi-capdata01.o
>
>   # Intel
>   obj-y				+=3D intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/platf=
orm/x86/lenovo-wmi-capdata01.c
> new file mode 100644
> index 000000000000..0fe156d5d770
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface prov=
ides
> + * information on tunable attributes used by the "Other Mode" WMI inter=
face,
> + * including if it is supported by the hardware, the default_value, max=
_value,
> + * min_value, and step increment.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>

2025

> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/component.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/gfp_types.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +#include "lenovo-wmi.h"
> +
> +/* Interface GUIDs */
> +#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE0=
18154"
> +
> +static int lenovo_cd01_component_bind(struct device *cd01_dev,
> +				      struct device *om_dev, void *data)
> +{
> +	struct lenovo_wmi_cd01 *cd01 =3D dev_get_drvdata(cd01_dev);
> +	struct lenovo_wmi_om *om =3D dev_get_drvdata(om_dev);

Why not using the *data pointer to pass the cd01 data? This way the capdat=
a driver
does not need to know the structure of the private data of the lenovo-wmi-=
other driver.

> +
> +	om->cd01 =3D cd01;
> +	return 0;
> +}
> +
> +static void lenovo_cd01_component_unbind(struct device *cd01_dev,
> +					 struct device *om_dev, void *data)
> +
> +{
> +	struct wmi_device *om_wdev =3D
> +		container_of(om_dev, struct wmi_device, dev);
> +	struct lenovo_wmi_om *om =3D
> +		container_of(&om_wdev, struct lenovo_wmi_om, wdev);
> +
> +	om->cd01 =3D NULL;

I think this is unnecessary, please remove the unbind callback.

> +}
> +
> +static const struct component_ops lenovo_cd01_component_ops =3D {
> +	.bind =3D lenovo_cd01_component_bind,
> +	.unbind =3D lenovo_cd01_component_unbind,
> +};
> +
> +static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
> +{
> +	size_t cd_size =3D sizeof(struct capdata01);
> +	int count, idx;
> +
> +	count =3D wmidev_instance_count(cd01->wdev);
> +
> +	cd01->capdata =3D devm_kmalloc_array(&cd01->wdev->dev, (size_t)count,
> +					   sizeof(*cd01->capdata), GFP_KERNEL);

Cast to size_t is unnecessary here.

> +	if (!cd01->capdata)
> +		return -ENOMEM;
> +
> +	cd01->instance_count =3D count;
> +
> +	for (idx =3D 0; idx < count; idx++) {
> +		union acpi_object *ret_obj __free(kfree) =3D NULL;

I am not sure if the compiler frees ret_obj after each loop iteration. Did=
 you test this?

> +		struct capdata01 *cap_ptr =3D
> +			devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KERNEL);

Please call devm_kmalloc() on a separate line.

> +		ret_obj =3D wmidev_block_query(cd01->wdev, idx);
> +		if (!ret_obj)
> +			continue;
> +
> +		if (ret_obj->type !=3D ACPI_TYPE_BUFFER)
> +			continue;
> +
> +		if (ret_obj->buffer.length !=3D cd_size)
> +			continue;
> +
> +		memcpy(cap_ptr, ret_obj->buffer.pointer,
> +		       ret_obj->buffer.length);

Using devm_kmemdup() would make sense here.

> +		cd01->capdata[idx] =3D cap_ptr;
> +	}
> +	return 0;
> +}
> +
> +static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void *c=
ontext)
> +
> +{
> +	struct lenovo_wmi_cd01 *cd01;
> +	int ret;
> +
> +	cd01 =3D devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
> +	if (!cd01)
> +		return -ENOMEM;
> +
> +	cd01->wdev =3D wdev;
> +
> +	ret =3D lenovo_wmi_cd01_setup(cd01);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(&wdev->dev, cd01);
> +
> +	ret =3D component_add(&wdev->dev, &lenovo_cd01_component_ops);
> +
> +	return ret;
> +}
> +
> +static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
> +{
> +	component_del(&wdev->dev, &lenovo_cd01_component_ops);
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_cd01_id_table[] =3D {
> +	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> +	{}
> +};
> +
> +static struct wmi_driver lenovo_wmi_cd01_driver =3D {
> +	.driver =3D {
> +		.name =3D "lenovo_wmi_cd01",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table =3D lenovo_wmi_cd01_id_table,
> +	.probe =3D lenovo_wmi_cd01_probe,
> +	.remove =3D lenovo_wmi_cd01_remove,
> +	.no_singleton =3D true,
> +};
> +
> +int lenovo_wmi_cd01_match(struct device *dev, void *data)
> +{
> +	return dev->driver =3D=3D &lenovo_wmi_cd01_driver.driver;
> +}
> +EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);

Please put this symbol into a namespace too.

> +
> +module_wmi_driver(lenovo_wmi_cd01_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/le=
novo-wmi.h
> index 113928b4fc0f..07fa67ed89d6 100644
> --- a/drivers/platform/x86/lenovo-wmi.h
> +++ b/drivers/platform/x86/lenovo-wmi.h
> @@ -45,6 +45,22 @@ enum lenovo_wmi_action {
>   	THERMAL_MODE_EVENT =3D 1,
>   };
>
> +/* capdata01 structs */
> +struct lenovo_wmi_cd01 {
> +	struct capdata01 **capdata;
> +	struct wmi_device *wdev;
> +	int instance_count;
> +};
> +
> +struct capdata01 {
> +	u32 id;
> +	u32 supported;
> +	u32 default_value;
> +	u32 step;
> +	u32 min_value;
> +	u32 max_value;
> +};

Please put those struct definitions into a separate header file.

Thanks,
Armin Wolf

> +
>   /* wmidev_evaluate_method helper functions */
>   int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instan=
ce,
>   				    u32 method_id, u32 arg0, u32 arg1,
> @@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_device =
*wdev, u8 instance,
>   int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instan=
ce,
>   				    u32 method_id, u32 arg0, u32 *retval);
>
> +/* lenovo_wmi_cd01_driver match function */
> +int lenovo_wmi_cd01_match(struct device *dev, void *data);
> +
>   /* lenovo_wmi_gz_driver notifier functions */
>   int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned lo=
ng action,
>   				enum platform_profile_option *profile);

