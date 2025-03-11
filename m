Return-Path: <linux-kernel+bounces-556926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6AA5D0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F883B9511
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42A264A62;
	Tue, 11 Mar 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bCQfcmQc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4A3FD1;
	Tue, 11 Mar 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725232; cv=none; b=W9Y0OozFPkPc8ucTh2xUC3Vox6lqE2cCL8jKU5rSFrDcsKJ0potRR52d4+ZrUO5soUJNp9eBzokq/z2aUMrEhECrM693LcXxevxSGMUaidqXgGZZEWJ5P3Oy4HCauWm30IgG+H1fdEJunfoCXopEbRETAiLRduLlQJHuXdAbokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725232; c=relaxed/simple;
	bh=pOzb3Nz/zD0DRDufrGnfPga5H13b7U/B1B0ndJPw5Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9lNBnf5Yy0yeyoC8hWyRb2kqavxO5NuI/bnD4H4u7Rgc5xNPcpYYzstJ0JIQP6s3rrKYvO+IFxxq7+sX96OkoJcThc0NNDpt12m1KiAg35AmACYKRBbdp7d6UJ/0CtF369m0jvszywgAHjaAuCqhNdSiYtUvgy1uHGi45eyQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bCQfcmQc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741725216; x=1742330016; i=w_armin@gmx.de;
	bh=dcGSOamJeNLbd+u0oyckWC6uyntFbzEhWUPr2fc9q28=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bCQfcmQcbcKTiiAFUHZgsdW+APPktYvOx8GP1qmqr1pzhK1hKrXYA2JmiHRRZBpg
	 1wocTdta0Lybh8EyXlwp4X/LhNuD1OZkoOH1Gn+RdY4EJPTS7XBu9YtJH2l5q8C+v
	 HD2HcKnITjxUlvyxZHtE3CgjdrKGZPQKzUYq1ELkEFgvb8zaV4i3R7HfgFWDRu7dQ
	 xe4yxRIwPPE0+mkJnzXwoqi6IyY5BZnxjnNs6zzuQjDaSo5J8kfpoJvlK4eInPw77
	 odw0AG5zU2yXBVBJiMSH4w1TtlBbB5RBmCZNTmfyaUr5TFjFPYePTk+pjRPo4uKuf
	 UXXWg5xozirKayQtTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1tGXYe2sie-00aI5F; Tue, 11
 Mar 2025 21:33:36 +0100
Message-ID: <e75f2513-fe24-4de5-aa90-6dd6e8a12cee@gmx.de>
Date: Tue, 11 Mar 2025 21:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] platform/x86: Add Lenovo Capability Data 01 WMI
 Driver
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-4-derekjohn.clark@gmail.com>
 <8605fff9-0fac-45e6-a5ce-a3b04fe81b9f@gmx.de>
 <CAFqHKTkjvd96P5WQPnyJYUNky3FOXT1gLOmFM6vFa7NGR2t8gA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKTkjvd96P5WQPnyJYUNky3FOXT1gLOmFM6vFa7NGR2t8gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LKb/ds0KVJBgkd8nwD69RZ8ae1FX8iT9rzC/Dwo4ccevbrPmAM9
 TbWIAnR4mJkkYMx8ZfELZZy1X4vOZBZi5gyzZNL2gb2fwTCU68Dyw/3ijdU3GHchjPxNj4+
 w1Oxk6BagXnRHD2d3NGpA1pEbr6OjXMFY70v4kDtVU/tadWBiEANhh8/4bIbDApVFGgNFMO
 6AaJjBS1Z1sWglrG5dUdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TaAhMnkEYwE=;m1SlX+ey1wlLL0KmmSgWyob/ics
 L9N/cHd+QIXl8G0UDsdwvSPTrRWSsjH3zob+7w4rXZij2aWtYyRUGouhC3GmOzmABDXDwX3OT
 eeWktGk/OtsQ0kCJse5P+3tSjh2N6MKm0RA7pgPld/iZb4Gu7l1/k7Tg9s/ZE55yfu/AyEBdl
 K2a5uR9Re1ksQOcZlWbsFh7X6WKHZ25ELP6Z+iRXqph+8gqdNmXcdaWXfo/ZW++OTZb6INDa1
 uCNYTCg13R7rLDq2t+sZ5RZlWn9Hn9qlWnVC8h+0Z5RasDZ2Vf3ls5Kveh+dM4Tz4J7xPHTjo
 6ZVYNy1i/hQAnQYYg8Rtni/OTuM2PutCOlPZtia3Nehck1N2M36fh2EDeiyygHMWYCSC6yOvR
 Pjun9jyaVO6VnzXVnH56deetO1nQ4jd9jwKyRa7FkiNkPcGGwdjAxrbq8K2ueLACphXRx45MJ
 2lHQKOU981Jlzzs4JuuwsEuOdGfXtlkR4AoYk3tAORVZLRVxUCHzhPApiyp+7/aasDmM9SPbU
 J1eNlyySox+/MzG3Pt+Nf1ENICDP0jhEbh0wAuNAK/V2CpuFH+HAWEDQSObVnVqNsdYKPznoK
 XKuLK4BwKRBmoTQl8gaSIgAZCSHCcNBqGeW1OlAxAFRHhO0E5Np5rl/bW2PUWMZvHUJGF5a02
 a0aO7CMJRKLp650hHY0UNpjrdUyS8nXvNiVqn4WJU3Su/VO7Ref6ltgVjp/TyjNKM5wtkruzX
 id5B5rjL8kIfjgoaANxZazLx1VxmmieDRN+rBnzt0tLSCpBNWZoCvkFaHISXwNLEJe1g9SVpQ
 8ajyIPQMDnh2DPxWCAwWItgimEHuXo7wxrwA4HzLXwGxARpTK8Xrh//rjHo7EK7szexCqFfxR
 ioP7R8SYvreZGGigW5UyoD1p2/KpvXajIiCmKFiZYU7hv9QgLlwHbhoaqXoDsmmqXnMD/76R6
 suUOLZCQhdyjhXl9LboFKRVUAWJrP4Su5YP1aHD0U+vCwsGr4XYbQ0/CFb5L8w9PfPcQqai0T
 SXjAFZrivWDezdnwysb6VV8KeYbXKtDCXU6Y7R8k8EKq5+IAGBEwXvogtePDMJnkZfaOzCq9l
 h43pVJrCTtJfG0MCOcji2CMICIYjXUF48o5riL0IKr+XE1ZXC00yNPaSdYWWwOuKFjqt96J1F
 ewApA3ZVdd6tI1XkVCkyD9L67hCduI46kqOu2KUQiw0dU2Z5gO5NyLJW5gX2NuekdxkPmKqX/
 A690QpIe4YuFl/R0JHgfDJZQPjPSTJVMCcuAcVVk+6vmnbh0JYJHzu8trFvsuxDMyywiFqDWf
 8ejo1ASi0y4nuOxo7ikP4yKKBBi99ws7sMXpWu/5vtLnjjpcThjLSRYjWBC+0F86Ptz9vUt+4
 bneT3u0PE+LCBPyG/YJ+bDH4UW+nwIE+ZoixSUPyBXMbAeMnkPf3dMLhR8w8tyrz/9g2nJ1Es
 3bak8v6zExRWABO6YX2/D9Xnn1Uk=

Am 10.03.25 um 23:26 schrieb Derek John Clark:

> On Fri, Mar 7, 2025 at 3:05=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>>
>>> Adds lenovo-wmi-capdata01.c which provides a driver for the
>>> LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
>>> enabled hardware. Provides an interface for querying if a given
>>> attribute is supported by the hardware, as well as its default_value,
>>> max_value, min_value, and step increment.
>>> v3:
>>> - Add as component to lenovo-wmi-other driver.
>>> v2:
>>> - Use devm_kmalloc to ensure driver can be instanced, remove global
>>>     reference.
>>> - Ensure reverse Christmas tree for all variable declarations.
>>> - Remove extra whitespace.
>>> - Use guard(mutex) in all mutex instances, global mutex.
>>> - Use pr_fmt instead of adding the driver name to each pr_err.
>>> - Remove noisy pr_info usage.
>>> - Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv.
>>> - Use list to get the lenovo_wmi_cd01_priv instance in
>>>     lenovo_wmi_capdata01_get as none of the data provided by the macro=
s
>>>     that will use it can pass a member of the struct for use in
>>>     container_of.
>>>
>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> ---
>>>    MAINTAINERS                                 |   1 +
>>>    drivers/platform/x86/Kconfig                |   5 +
>>>    drivers/platform/x86/Makefile               |   1 +
>>>    drivers/platform/x86/lenovo-wmi-capdata01.c | 140 +++++++++++++++++=
+++
>>>    drivers/platform/x86/lenovo-wmi.h           |  19 +++
>>>    5 files changed, 166 insertions(+)
>>>    create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index cf7f4fce1a25..f6d3e79e50ce 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13157,6 +13157,7 @@ L:    platform-driver-x86@vger.kernel.org
>>>    S:  Maintained
>>>    F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>>>    F:  Documentation/wmi/devices/lenovo-wmi-other.rst
>>> +F:   drivers/platform/x86/lenovo-wmi-capdata01.c
>>>    F:  drivers/platform/x86/lenovo-wmi-gamezone.c
>>>    F:  drivers/platform/x86/lenovo-wmi.c
>>>    F:  drivers/platform/x86/lenovo-wmi.h
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconf=
ig
>>> index 875822e6bd65..56336dc3c2d0 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
>>>          To compile this driver as a module, choose M here: the module=
 will
>>>          be called lenovo-wmi-gamezone.
>>>
>>> +config LENOVO_WMI_DATA01
>>> +     tristate
>>> +     depends on ACPI_WMI
>>> +     select LENOVO_WMI
>>> +
>>>    config IDEAPAD_LAPTOP
>>>        tristate "Lenovo IdeaPad Laptop Extras"
>>>        depends on ACPI
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Make=
file
>>> index 4a7b2d14eb82..be9031bea090 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)              +=3D lenovo-yoga=
-tab2-pro-1380-fastcharger.o
>>>    obj-$(CONFIG_LENOVO_WMI)    +=3D lenovo-wmi.o
>>>    obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
>>>    obj-$(CONFIG_LENOVO_WMI_GAMEZONE)   +=3D lenovo-wmi-gamezone.o
>>> +obj-$(CONFIG_LENOVO_WMI_DATA01)      +=3D lenovo-wmi-capdata01.o
>>>
>>>    # Intel
>>>    obj-y                               +=3D intel/
>>> diff --git a/drivers/platform/x86/lenovo-wmi-capdata01.c b/drivers/pla=
tform/x86/lenovo-wmi-capdata01.c
>>> new file mode 100644
>>> index 000000000000..0fe156d5d770
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi-capdata01.c
>>> @@ -0,0 +1,140 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * LENOVO_CAPABILITY_DATA_01 WMI data block driver. This interface pr=
ovides
>>> + * information on tunable attributes used by the "Other Mode" WMI int=
erface,
>>> + * including if it is supported by the hardware, the default_value, m=
ax_value,
>>> + * min_value, and step increment.
>>> + *
>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>> 2025
> Acked for all as Mario suggested.
>
>>> + */
>>> +
>>> +#include <linux/cleanup.h>
>>> +#include <linux/component.h>
>>> +#include <linux/container_of.h>
>>> +#include <linux/device.h>
>>> +#include <linux/gfp_types.h>
>>> +#include <linux/types.h>
>>> +#include <linux/wmi.h>
>>> +#include "lenovo-wmi.h"
>>> +
>>> +/* Interface GUIDs */
>>> +#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3B=
E018154"
>>> +
>>> +static int lenovo_cd01_component_bind(struct device *cd01_dev,
>>> +                                   struct device *om_dev, void *data)
>>> +{
>>> +     struct lenovo_wmi_cd01 *cd01 =3D dev_get_drvdata(cd01_dev);
>>> +     struct lenovo_wmi_om *om =3D dev_get_drvdata(om_dev);
>> Why not using the *data pointer to pass the cd01 data? This way the cap=
data driver
>> does not need to know the structure of the private data of the lenovo-w=
mi-other driver.
>>
> I can do that, sure. Seems preferable TBH as it allows me to call it pri=
v again.
>
>>> +
>>> +     om->cd01 =3D cd01;
>>> +     return 0;
>>> +}
>>> +
>>> +static void lenovo_cd01_component_unbind(struct device *cd01_dev,
>>> +                                      struct device *om_dev, void *da=
ta)
>>> +
>>> +{
>>> +     struct wmi_device *om_wdev =3D
>>> +             container_of(om_dev, struct wmi_device, dev);
>>> +     struct lenovo_wmi_om *om =3D
>>> +             container_of(&om_wdev, struct lenovo_wmi_om, wdev);
>>> +
>>> +     om->cd01 =3D NULL;
>> I think this is unnecessary, please remove the unbind callback.
>>
> Acked.
>
>>> +}
>>> +
>>> +static const struct component_ops lenovo_cd01_component_ops =3D {
>>> +     .bind =3D lenovo_cd01_component_bind,
>>> +     .unbind =3D lenovo_cd01_component_unbind,
>>> +};
>>> +
>>> +static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
>>> +{
>>> +     size_t cd_size =3D sizeof(struct capdata01);
>>> +     int count, idx;
>>> +
>>> +     count =3D wmidev_instance_count(cd01->wdev);
>>> +
>>> +     cd01->capdata =3D devm_kmalloc_array(&cd01->wdev->dev, (size_t)c=
ount,
>>> +                                        sizeof(*cd01->capdata), GFP_K=
ERNEL);
>> Cast to size_t is unnecessary here.
>>
> Acked.
>
>>> +     if (!cd01->capdata)
>>> +             return -ENOMEM;
>>> +
>>> +     cd01->instance_count =3D count;
>>> +
>>> +     for (idx =3D 0; idx < count; idx++) {
>>> +             union acpi_object *ret_obj __free(kfree) =3D NULL;
>> I am not sure if the compiler frees ret_obj after each loop iteration. =
Did you test this?
>>
> No, but I'm not sure how I would. I was manually using kfree before
> but was asked to change to the free macro in an earlier rev.

When loading this driver on you machine you can use kmemleak (https://docs=
.kernel.org/dev-tools/kmemleak.html)
to detect memory leaks. If no leaks are detected then ret_obj is likely fr=
eed after each iteration and you
can keep using __free().

Thanks,
Armin Wolf

>
>>> +             struct capdata01 *cap_ptr =3D
>>> +                     devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KERN=
EL);
>> Please call devm_kmalloc() on a separate line.
>>
> Acked.
>
>>> +             ret_obj =3D wmidev_block_query(cd01->wdev, idx);
>>> +             if (!ret_obj)
>>> +                     continue;
>>> +
>>> +             if (ret_obj->type !=3D ACPI_TYPE_BUFFER)
>>> +                     continue;
>>> +
>>> +             if (ret_obj->buffer.length !=3D cd_size)
>>> +                     continue;
>>> +
>>> +             memcpy(cap_ptr, ret_obj->buffer.pointer,
>>> +                    ret_obj->buffer.length);
>> Using devm_kmemdup() would make sense here.
>>
> That's a cool function. Ty, I'll use it
>
>>> +             cd01->capdata[idx] =3D cap_ptr;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void =
*context)
>>> +
>>> +{
>>> +     struct lenovo_wmi_cd01 *cd01;
>>> +     int ret;
>>> +
>>> +     cd01 =3D devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
>>> +     if (!cd01)
>>> +             return -ENOMEM;
>>> +
>>> +     cd01->wdev =3D wdev;
>>> +
>>> +     ret =3D lenovo_wmi_cd01_setup(cd01);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     dev_set_drvdata(&wdev->dev, cd01);
>>> +
>>> +     ret =3D component_add(&wdev->dev, &lenovo_cd01_component_ops);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
>>> +{
>>> +     component_del(&wdev->dev, &lenovo_cd01_component_ops);
>>> +}
>>> +
>>> +static const struct wmi_device_id lenovo_wmi_cd01_id_table[] =3D {
>>> +     { LENOVO_CAPABILITY_DATA_01_GUID, NULL },
>>> +     {}
>>> +};
>>> +
>>> +static struct wmi_driver lenovo_wmi_cd01_driver =3D {
>>> +     .driver =3D {
>>> +             .name =3D "lenovo_wmi_cd01",
>>> +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>>> +     },
>>> +     .id_table =3D lenovo_wmi_cd01_id_table,
>>> +     .probe =3D lenovo_wmi_cd01_probe,
>>> +     .remove =3D lenovo_wmi_cd01_remove,
>>> +     .no_singleton =3D true,
>>> +};
>>> +
>>> +int lenovo_wmi_cd01_match(struct device *dev, void *data)
>>> +{
>>> +     return dev->driver =3D=3D &lenovo_wmi_cd01_driver.driver;
>>> +}
>>> +EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);
>> Please put this symbol into a namespace too.
>>
> Yes, I noticed the mistake right after I sent the patch.
>
>>> +
>>> +module_wmi_driver(lenovo_wmi_cd01_driver);
>>> +
>>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/=
lenovo-wmi.h
>>> index 113928b4fc0f..07fa67ed89d6 100644
>>> --- a/drivers/platform/x86/lenovo-wmi.h
>>> +++ b/drivers/platform/x86/lenovo-wmi.h
>>> @@ -45,6 +45,22 @@ enum lenovo_wmi_action {
>>>        THERMAL_MODE_EVENT =3D 1,
>>>    };
>>>
>>> +/* capdata01 structs */
>>> +struct lenovo_wmi_cd01 {
>>> +     struct capdata01 **capdata;
>>> +     struct wmi_device *wdev;
>>> +     int instance_count;
>>> +};
>>> +
>>> +struct capdata01 {
>>> +     u32 id;
>>> +     u32 supported;
>>> +     u32 default_value;
>>> +     u32 step;
>>> +     u32 min_value;
>>> +     u32 max_value;
>>> +};
>> Please put those struct definitions into a separate header file.
>>
> Acked.
>
>> Thanks,
>> Armin Wolf
>>
>>> +
>>>    /* wmidev_evaluate_method helper functions */
>>>    int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 ins=
tance,
>>>                                    u32 method_id, u32 arg0, u32 arg1,
>>> @@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_devic=
e *wdev, u8 instance,
>>>    int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 ins=
tance,
>>>                                    u32 method_id, u32 arg0, u32 *retva=
l);
>>>
>>> +/* lenovo_wmi_cd01_driver match function */
>>> +int lenovo_wmi_cd01_match(struct device *dev, void *data);
>>> +
>>>    /* lenovo_wmi_gz_driver notifier functions */
>>>    int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned=
 long action,
>>>                                enum platform_profile_option *profile);

