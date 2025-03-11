Return-Path: <linux-kernel+bounces-556921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC99A5D0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EBD3B82E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F626264A7C;
	Tue, 11 Mar 2025 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DM2qMPTC"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA6222572;
	Tue, 11 Mar 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724484; cv=none; b=gQNk784FAupJQly3IbiZ/ra6I1+h2B/kx3k+gdUfX9TK2YZXfISx4mjZ3pMW8rIrJWJ8RYv5O933yUS01Wwn9Us3JJdTpHzlsz/iq47USHNVrhhYhCH8KD6geoPQXCtVValywRvuSeMwm4okmUtbb0SjoJKVxRcG8Vj5QUC80+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724484; c=relaxed/simple;
	bh=THdU/mYmhkTbOBHFBvvqXs1HCv0DfBINVZku1GntJQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsndExAAJzOtGQ9jB9MCwRxU3bIR9YogcGsln4rMG4uqRmZJXDmbhswcYRH9ocGwzBpvidCmlB6EqGieTbttcGrJAbCaQHvPPvb2/sgAkcJAB4q5tYjwnHzL7aheVddKEQp5oaCuzF0SNXUrzGsRf1vU0Qu8l/mcGWm7AZdG0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DM2qMPTC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741724471; x=1742329271; i=w_armin@gmx.de;
	bh=eLlTewnnzfem89h3kNoQRzyOqUPgmAkLeoeJlRw5HrY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DM2qMPTC2WuLIRFVWxba5cVErptSlORrisEBg5ZZb5G823enSW3Xh07IQnfiNfXB
	 jZCog800p79fk/puOh81mJ9E8w3nMs7CPQBxA5CZh7ylOf+r4v3+cwCcsAAcwldSm
	 6hsW03LAWntSzdknhu23CzrbEJD83x8GMrSS/6/E9qQL+YDtQORN86pg8szWrL9CN
	 N7iupkpA5HXeJLgKc4mhlroE/RzceI/PFn5yy+J0TH2cHgtI9taKDdF7R2g/vCz0y
	 a7CpNu7TYvPDLMtpi5q8khWgLo0SJ/qawZnpFMUP+uJyH1S4zsJKx6KhoJD3RggaM
	 giIL/CO2eFHT8RKj2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1tCX1j3mkT-014hOV; Tue, 11
 Mar 2025 21:21:11 +0100
Message-ID: <cd4ab6b4-d6c2-441a-805e-6069e1c57737@gmx.de>
Date: Tue, 11 Mar 2025 21:21:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
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
 <20250225220037.16073-3-derekjohn.clark@gmail.com>
 <dd6f0d07-d629-40ce-9009-1a0919d93493@gmx.de>
 <231333f8-8b00-4e56-bfcb-e11c264b35b2@gmx.de>
 <CAFqHKTm-T5G3ZyQwjbO3KSaq=T1wS6vSGWxzsuzvqGmoTLj_hg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKTm-T5G3ZyQwjbO3KSaq=T1wS6vSGWxzsuzvqGmoTLj_hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PAdTaikogSe4OJzcPJow92xwsIgQrxVaBJ3gy06iXDyCARkc1QJ
 V9bnjLzTmD/btAboTN2JRtg/UXGSjG0qott9WQkSIGufSg4Fr4ZJxvOG1JjUq+s/3tYnWhH
 UwZIxtd0tnEW+pbX9Lv1/ufgBiK9LbdEIi+TaU7u9JShz9F35WWLtHBZhx6Dvp66iH/MpAb
 IJnzgcD6DCMnfXb6l7w5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZVUMflTdMio=;momvvgOmRfG40vOtO3WAEFluCEA
 7qVby+ypfngYFh8ku2B24wmNMOyK3rvDal7/ioPQg2q9i3+Od6cN9QoRuNEVTbT3NFW3sCBJY
 1X3y5ACCNJy02e6+gsylvUu626UlsKyj1VJGxENKKbzE1u/ZPO3fw2oYel+Eqkdhp93L/oW0n
 /OYk9Zz6s+WUDsb8MvijDUfgypnb9qHs2yNjBhIXHO96bplSB+nAmpo4l+mbytKP9SKQ5FTQt
 neYeMRZocnBGpHEwFqJuTfGLFRnUr/wjwutafA2EgFwuXIPkWrsZO/sLZQLq6YQ8PhzgxzntJ
 9SDmfwBi49p/ynwAmZdeZ8BoG9Jl4NRFz2ClQyvu8fTZGZiJzt/26vPXRaWqei/U2pMKDFgT5
 2LSmp15z5nhfmqIepQg+aicBvBjq8wzBcF0ZY4nePbsnWq/XZDljXqDLaHlw8EFwwrFHqf2pc
 DYKOt2SXDsD4nOZ78/gsqGJgZILT3N8o3UcD40e7WnG0QuugPbNFx7+UnLIncBeTD7io4O3Yf
 y3tmXST+OoL6Kg5gmsKfBmWoNJwrvmF70V6PNpUHi0v+pWYVXUGcDoixqFOANdjKVrdlURDHI
 ruu54X4QA+wO+XEtitVkrMREORKevuhlb7SgG6cNmL/LI2bidxE2xHst+JGOtHUFJ6gyeYote
 tgC/aZs7Ru1fNBKpWLzfbDqtsTB/8FFAM9RizwQ+5iv+NIFRMJb/LN9syyxI+wjJiLCxhCsSi
 zCufDSmIx8XPto1aUOsQMxNU7MFQPoLvm5m8+0YAA2uIYTHirKjTVVU3H0GI5nmlxB6AgFSM+
 mUB6ER7QaOM5nzgJEo4orXXigZuN45Nh9y/h8P+GoUeUYSmLJ36d3ennuy+UtojztQGIh3cBG
 S0y0um8RV4mPa70CBC+bOR2+fdam/vTVplqx6XNvAFd/OYM4IH4FzcfzxZdHLR8n+alGbpBG8
 ljI2aDEU2eJdE46Kinat4+yZL+slVPjgI0qvITQ4lhGBJNasjcXwiablr/NoXZs5ToeVsILwX
 eQ7V48W+BOlCuKDG6giWEc/6xC9IyoT4CS1X/bHWv3lxCiQqk5yeM6MxN3bR3/Kx/Y/OZlafE
 fAiUqbcrbULkPvVD1L434fFVHW5uFkNXM+t4nySrF7y4Ofo9gHdiS4GupRe57Yba0sAgDsOhd
 sWAygu5OKe6xgFwdwR/G+TPr8kEXuxpqmfOnMISx5vPtn7DZcGSrcTLm679KomUz5HCFjtT/V
 hvkIO25vOAdAvndZeEB1IDkDxqSIoDW3nOu7KcseouWn3G1tLivEbP1tICYp1cp2chUL+CFtc
 66xFVi+olWc3y30kGUKozM98FXUpVYXhHLeHNEgvnMNBeGvzO4UaZHGEwmgAqZS8UIlrZokPz
 3F9jLWpz8pBn81h1v5EG3g+YfKgrXe/iFpFULTP/qkWOkfXBwa6wJpJqJWlUYuV+rEurVE89g
 P5HTrQl5vC9PC3CSfIckCQwGtBSzAoVO6EmJTeuu4/l6386aMv6O3aJEzyY9dVd2j/qBPFw==

Am 10.03.25 um 23:20 schrieb Derek John Clark:

> On Fri, Mar 7, 2025 at 4:41=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 07.03.25 um 23:47 schrieb Armin Wolf:
>>
>>> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>>>
>>>> Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
>>>> Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware.
>>>> Provides ACPI platform profiles over WMI.
>>>>
>>>> Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions for
>>>> wmidev_evaluate_method as well as prototypes for exported functions.
>>>> v3:
>>>> - Use notifier chain to report platform profile changes to any
>>>>     subscribed drivers.
>>>> - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifi=
er
>>>>     chain.
>>>> - Adds support for Extreme Mode profile on supported hardware, as wel=
l
>>>>     as a DMI quirk table for some devices that report extreme mode
>>>> version
>>>>     support but so not have it fully implemented.
>>>> - Update to include recent changes to platform-profile.
>>>> v2:
>>>> - Use devm_kmalloc to ensure driver can be instanced, remove global
>>>>     reference.
>>>> - Ensure reverse Christmas tree for all variable declarations.
>>>> - Remove extra whitespace.
>>>> - Use guard(mutex) in all mutex instances, global mutex.
>>>> - Use pr_fmt instead of adding the driver name to each pr_err.
>>>> - Remove noisy pr_info usage.
>>>> - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
>>>> - Remove GZ_WMI symbol exporting.
>>>>
>>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>>> ---
>>>>    MAINTAINERS                                |   3 +
>>>>    drivers/platform/x86/Kconfig               |  16 +
>>>>    drivers/platform/x86/Makefile              |   2 +
>>>>    drivers/platform/x86/lenovo-wmi-gamezone.c | 374 +++++++++++++++++=
++++
>>>>    drivers/platform/x86/lenovo-wmi.c          |  77 +++++
>>>>    drivers/platform/x86/lenovo-wmi.h          |  62 ++++
>>>>    6 files changed, 534 insertions(+)
>>>>    create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>>>>    create mode 100644 drivers/platform/x86/lenovo-wmi.c
>>>>    create mode 100644 drivers/platform/x86/lenovo-wmi.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e20c32b3c480..cf7f4fce1a25 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -13157,6 +13157,9 @@ L: platform-driver-x86@vger.kernel.org
>>>>    S:    Maintained
>>>>    F:    Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>>>>    F:    Documentation/wmi/devices/lenovo-wmi-other.rst
>>>> +F:    drivers/platform/x86/lenovo-wmi-gamezone.c
>>>> +F:    drivers/platform/x86/lenovo-wmi.c
>>>> +F:    drivers/platform/x86/lenovo-wmi.h
>>>>      LETSKETCH HID TABLET DRIVER
>>>>    M:    Hans de Goede <hdegoede@redhat.com>
>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
>>>> index 7e20a58861eb..875822e6bd65 100644
>>>> --- a/drivers/platform/x86/Kconfig
>>>> +++ b/drivers/platform/x86/Kconfig
>>>> @@ -459,6 +459,22 @@ config IBM_RTL
>>>>         state =3D 0 (BIOS SMIs on)
>>>>         state =3D 1 (BIOS SMIs off)
>>>>    +config LENOVO_WMI
>>>> +    tristate
>>>> +    depends on ACPI_WMI
>>> Please rename this module to LENOVO_WMI_HELPERS.
>>>
>>>> +
>>>> +config LENOVO_WMI_GAMEZONE
>>>> +    tristate "Lenovo GameZone WMI Driver"
>>>> +    depends on ACPI_WMI
>>>> +    select ACPI_PLATFORM_PROFILE
>>>> +    select LENOVO_WMI
>>>> +    help
>>>> +      Say Y here if you have a WMI aware Lenovo Legion device and
>>>> would like to use the
>>>> +      platform-profile firmware interface to manage power usage.
>>>> +
>>>> +      To compile this driver as a module, choose M here: the module
>>>> will
>>>> +      be called lenovo-wmi-gamezone.
>>>> +
>>>>    config IDEAPAD_LAPTOP
>>>>        tristate "Lenovo IdeaPad Laptop Extras"
>>>>        depends on ACPI
>>>> diff --git a/drivers/platform/x86/Makefile
>>>> b/drivers/platform/x86/Makefile
>>>> index 5f6307246e69..4a7b2d14eb82 100644
>>>> --- a/drivers/platform/x86/Makefile
>>>> +++ b/drivers/platform/x86/Makefile
>>>> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI)    +=3D thinkpad_acpi.o
>>>>    obj-$(CONFIG_THINKPAD_LMI)    +=3D think-lmi.o
>>>>    obj-$(CONFIG_YOGABOOK)        +=3D lenovo-yogabook.o
>>>>    obj-$(CONFIG_YT2_1380)        +=3D
>>>> lenovo-yoga-tab2-pro-1380-fastcharger.o
>>>> +obj-$(CONFIG_LENOVO_WMI)    +=3D lenovo-wmi.o
>>>>    obj-$(CONFIG_LENOVO_WMI_CAMERA)    +=3D lenovo-wmi-camera.o
>>>> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)    +=3D lenovo-wmi-gamezone.o
>>>>      # Intel
>>>>    obj-y                +=3D intel/
>>>> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c
>>>> b/drivers/platform/x86/lenovo-wmi-gamezone.c
>>>> new file mode 100644
>>>> index 000000000000..d5329fecba47
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
>>>> @@ -0,0 +1,374 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface
>>>> provides
>>>> + * platform profile and fan curve settings for devices that fall
>>>> under the
>>>> + * "Gaming Series" of Lenovo Legion devices.
>>>> + *
>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>> + */
>>>> +
>>>> +#include "linux/container_of.h"
>>>> +#include "linux/printk.h"
>>>> +#include <linux/cleanup.h>
>>>> +#include <linux/dev_printk.h>
>>>> +#include <linux/dmi.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/notifier.h>
>>>> +#include <linux/platform_profile.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/wmi.h>
>>>> +#include "lenovo-wmi.h"
>>>> +
>>>> +/* Interface GUIDs */
>>>> +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>>>> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5=
F"
>>>> +
>>>> +/* Method IDs */
>>>> +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
>>>> +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
>>>> +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
>>>> +
>>>> +enum lenovo_wmi_gz_type {
>>>> +    GAMEZONE_FULL =3D 1,
>>>> +    THERMAL_MODE,
>>>> +};
>>>> +
>>>> +#define GAMEZONE_WMI_DEVICE(guid, type)                             =
 \
>>>> +    .guid_string =3D (guid), .context =3D &(enum lenovo_wmi_gz_type)=
 \
>>>> + {                                                            \
>>>> +        type                                                 \
>>>> +    }
>>>> +
>>>> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
>>>> +static DEFINE_MUTEX(gz_chain_mutex);
>>>> +
>>>> +struct lenovo_wmi_gz_priv {
>>>> +    enum platform_profile_option current_profile;
>>> This variable is only assigned and never read, please remove it.
>>>
>>>> +    struct wmi_device *wdev;
>>>> +    bool extreme_supported;
>>>> +    struct device *ppdev; /*platform profile device */
>>>> +    enum lenovo_wmi_gz_type type;
>>>> +    struct blocking_notifier_head nhead;
>>>> +};
>>>> +
>>>> +struct quirk_entry {
>>>> +    bool extreme_supported;
>>>> +};
>>>> +
>>>> +static struct quirk_entry quirk_no_extreme_bug =3D {
>>>> +    .extreme_supported =3D false,
>>>> +};
>>> Can you make this const?
>>>
>>>> +
>>>> +/* Platform Profile Methods & Setup */
>>>> +static int
>>>> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv
>>>> *priv,
>>>> +                     int *supported)
>>>> +{
>>>> +    return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>> +                           WMI_METHOD_ID_SMARTFAN_SUPP, 0, supported=
);
>>>> +}
>>>> +
>>>> +static int lenovo_wmi_gz_profile_get(struct device *dev,
>>>> +                     enum platform_profile_option *profile)
>>>> +{
>>>> +    struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>>> +    int sel_prof;
>>>> +    int ret;
>>>> +
>>>> +    ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>> +                          WMI_METHOD_ID_SMARTFAN_GET, 0, &sel_prof);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    switch (sel_prof) {
>>>> +    case SMARTFAN_MODE_QUIET:
>>>> +        *profile =3D PLATFORM_PROFILE_LOW_POWER;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_BALANCED:
>>>> +        *profile =3D PLATFORM_PROFILE_BALANCED;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_PERFORMANCE:
>>>> +        if (priv->extreme_supported) {
>>>> +            *profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>>>> +            break;
>>>> +        }
>>>> +        *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_EXTREME:
>>>> +        *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_CUSTOM:
>>>> +        *profile =3D PLATFORM_PROFILE_CUSTOM;
>>>> +        break;
>>>> +    default:
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    priv->current_profile =3D *profile;
>>>> +
>>>> +    ret =3D blocking_notifier_call_chain(&gz_chain_head,
>>>> THERMAL_MODE_EVENT,
>>>> +                       &sel_prof);
>>> Is it really necessary to call the notifier here? AFAIK the notifier
>>> needs to be called
>>> only:
>>>
>>>   - when the platform profile was changed either by the user or the
>>> firmware.
>>>   - when a new notifier handler was registered so that the handler doe=
s
>>> not have to wait for the next user input
>>>
>>> Please only call the notifier in those two situations.
>> I thought about this a bit and i came to the conclusion that my proposa=
l would not work. The problem is that if no
>> gamezone driver is available the notifier handler will not be called at=
 all.
>>
>> I instead suggest that you move the notifier inside the lenovo-wmi-othe=
r driver. Then the gamezone driver registers itself
>> with this notifier and supplies the current platform profile if the len=
ovo-wmi-other driver requests it. In this case
>> it would make sense to cache the current platform profile.
> I have a few questions as I want to make sure I understand how to
> "reverse" the information flow for the notifier chain.
> - Would it be as simple as filling the data pointer sent by other with
> a pointer to the profile in gamezone? If so, would gamezone return
> NOTIFY_STOP or NOTIFY_DONE to indicate the pointer was filled so that
> other could verify?

Yes, the data pointer would ideally point to a variable with a type of "en=
um platform_profile_option" inside the
lenovo-wmi-other driver which will then be modified by the gamezone driver=
.

> - Since other might be initialized before gamezone, should I do a
> notifier call chain every time I need to know the platform?

Yes.

> - How would the WMI events notifications work as well, since currently
> they are what calls the chain and other has no context for that.

WMI events that change the platform profile are of no concern to the lenov=
o-wmi-other driver because
he always asks for the current platform profile before performing an opera=
tion anyway.

The notifier used by the WMI event driver can be constructed like the noti=
fier inside the uniwill-wmi
driver available at https://github.com/Wer-Wolf/uniwill-laptop.

Thanks,
Armin Wolf

> Cheers,
> - Derek
>
>> Thanks,
>> Armin Wolf
>>
>>>> +    if (ret =3D=3D NOTIFY_BAD)
>>>> +        pr_err("Failed to send notification to call chain for WMI
>>>> event %u\n",
>>>> +               priv->type);
>>> Use dev_err() here please.
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int lenovo_wmi_gz_profile_set(struct device *dev,
>>>> +                     enum platform_profile_option profile)
>>>> +{
>>>> +    struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>>> +    int sel_prof;
>>>> +    int ret;
>>>> +
>>>> +    switch (profile) {
>>>> +    case PLATFORM_PROFILE_LOW_POWER:
>>>> +        sel_prof =3D SMARTFAN_MODE_QUIET;
>>>> +        break;
>>>> +    case PLATFORM_PROFILE_BALANCED:
>>>> +        sel_prof =3D SMARTFAN_MODE_BALANCED;
>>>> +        break;
>>>> +    case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>> +        sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>>> +        break;
>>>> +    case PLATFORM_PROFILE_PERFORMANCE:
>>>> +        if (priv->extreme_supported) {
>>>> +            sel_prof =3D SMARTFAN_MODE_EXTREME;
>>>> +            break;
>>>> +        }
>>>> +        sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>>> +        break;
>>>> +    case PLATFORM_PROFILE_CUSTOM:
>>>> +        sel_prof =3D SMARTFAN_MODE_CUSTOM;
>>>> +        break;
>>>> +    default:
>>>> +        return -EOPNOTSUPP;
>>>> +    }
>>>> +
>>>> +    ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>> +                          WMI_METHOD_ID_SMARTFAN_SET, sel_prof, NULL=
);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct dmi_system_id fwbug_list[] =3D {
>>>> +    {
>>>> +        .ident =3D "Legion Go 8APU1",
>>>> +        .matches =3D {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
>>>> +        },
>>>> +        .driver_data =3D &quirk_no_extreme_bug,
>>>> +    },
>>>> +    {
>>>> +        .ident =3D "Legion Go S 8ARP1",
>>>> +        .matches =3D {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
>>>> +        },
>>>> +        .driver_data =3D &quirk_no_extreme_bug,
>>>> +    },
>>>> +    {
>>>> +        .ident =3D "Legion Go S 8APU1",
>>>> +        .matches =3D {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
>>>> +        },
>>>> +        .driver_data =3D &quirk_no_extreme_bug,
>>>> +    },
>>>> +    {},
>>>> +
>>>> +};
>>>> +
>>>> +static bool extreme_supported(int profile_support_ver)
>>>> +{
>>>> +    const struct dmi_system_id *dmi_id;
>>>> +    struct quirk_entry *quirks;
>>>> +
>>>> +    if (profile_support_ver < 6)
>>>> +        return false;
>>>> +
>>>> +    dmi_id =3D dmi_first_match(fwbug_list);
>>>> +    if (!dmi_id)
>>>> +        return true;
>>>> +
>>>> +    quirks =3D dmi_id->driver_data;
>>>> +    return quirks->extreme_supported;
>>>> +}
>>>> +
>>>> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
>>>> +                         unsigned long *choices)
>>>> +{
>>>> +    struct lenovo_wmi_gz_priv *priv =3D drvdata;
>>>> +    enum platform_profile_option profile;
>>> Unused variable, please remove.
>>>
>>>> +    int profile_support_ver;
>>>> +    int ret;
>>>> +
>>>> +    ret =3D lenovo_wmi_gz_platform_profile_supported(priv,
>>>> +                               &profile_support_ver);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (profile_support_ver < 1)
>>>> +        return -ENODEV;
>>>> +
>>>> +    priv->extreme_supported =3D extreme_supported(profile_support_ve=
r);
>>>> +
>>>> +    set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>>> +    set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>>> +    set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>>> +    set_bit(PLATFORM_PROFILE_CUSTOM, choices);
>>>> +
>>>> +    if (priv->extreme_supported)
>>>> +        set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct platform_profile_ops
>>>> lenovo_wmi_gz_platform_profile_ops =3D {
>>>> +    .probe =3D lenovo_wmi_platform_profile_probe,
>>>> +    .profile_get =3D lenovo_wmi_gz_profile_get,
>>>> +    .profile_set =3D lenovo_wmi_gz_profile_set,
>>>> +};
>>>> +
>>>> +/* Notifier Methods */
>>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
>>>> +{
>>>> +    guard(mutex)(&gz_chain_mutex);
>>> The blocking notifier already does the locking itself. Please remove
>>> this mutex.
>>>
>>>> +    return blocking_notifier_chain_register(&gz_chain_head, nb);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
>>> Can you name the namespace similar to "LENOVO_GAMEZONE_WMI" please?
>>>
>>>> +
>>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
>>>> +{
>>>> +    guard(mutex)(&gz_chain_mutex);
>>>> +    return blocking_notifier_chain_unregister(&gz_chain_head, nb);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
>>>> +
>>>> +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
>>>> +{
>>>> +    struct notifier_block *nb =3D data;
>>>> +
>>>> +    lenovo_wmi_gz_unregister_notifier(nb);
>>>> +}
>>>> +
>>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>>> +                     struct notifier_block *nb)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret =3D lenovo_wmi_gz_register_notifier(nb);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    return devm_add_action_or_reset(dev,
>>>> devm_lenovo_wmi_gz_unregister_notifier, nb);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI")=
;
>>>> +
>>>> +/* Driver Methods */
>>>> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
>>>> +                 union acpi_object *obj)
>>>> +{
>>>> +    struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvdata(&wdev->de=
v);
>>>> +    struct lenovo_wmi_gz_priv *gz_priv =3D
>>>> +        container_of(&gz_chain_head, struct lenovo_wmi_gz_priv, nhea=
d);
>>> I fear that this will not work because gz_chain_head is a global
>>> variable, not a field inside
>>> struct lenovo_wmi_gz_priv. Also this would crash the kernel should the
>>> main gamezone driver be
>>> unbound from its WMI device.
>>>
>>> I suggest you move the WMI driver for the WMI event into a separate
>>> module. Then you use another notifier
>>> inside the new module to allow the gamezone driver to listen for
>>> events. For example this separate WMI event driver
>>> could use the "val" argument inside blocking_notifier_call_chain() to
>>> specify the type of event (like THERMAL_MODE_CHANGED)
>>> and the "v" argument to pass a pointer to a u32 variable containing
>>> the new thermal mode.
>>>
>>> This also allows you to extend the separate WMI driver later to
>>> support more WMI event GUIDs.
>>>
>>>> +    int sel_prof;
>>>> +    int ret;
>>>> +
>>>> +    if (obj->type !=3D ACPI_TYPE_INTEGER)
>>>> +        return;
>>>> +
>>>> +    switch (tm_priv->type) {
>>>> +    case THERMAL_MODE:
>>>> +        sel_prof =3D obj->integer.value;
>>>> +        break;
>>>> +    default:
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Update primary Gamezone instance */
>>>> +    switch (sel_prof) {
>>>> +    case SMARTFAN_MODE_QUIET:
>>>> +        gz_priv->current_profile =3D PLATFORM_PROFILE_LOW_POWER;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_BALANCED:
>>>> +        gz_priv->current_profile =3D PLATFORM_PROFILE_BALANCED;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_PERFORMANCE:
>>>> +        if (gz_priv->extreme_supported) {
>>>> +            gz_priv->current_profile =3D
>>>> +                PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>>>> +            break;
>>>> +        }
>>>> +        gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_EXTREME:
>>>> +        gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>> +        break;
>>>> +    case SMARTFAN_MODE_CUSTOM:
>>>> +        gz_priv->current_profile =3D PLATFORM_PROFILE_CUSTOM;
>>>> +        break;
>>>> +    default:
>>>> +        break;
>>>> +    }
>>> Please use platform_profile_notify() to notify userspace of the new
>>> platform profile settings.
>>>
>>>> +
>>>> +    ret =3D blocking_notifier_call_chain(&gz_chain_head,
>>>> THERMAL_MODE_EVENT,
>>>> +                       &sel_prof);
>>>> +    if (ret =3D=3D NOTIFY_BAD)
>>>> +        pr_err("Failed to send notification to call chain for WMI
>>>> event %u\n",
>>>> +               tm_priv->type);
>>>> +}
>>>> +
>>>> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void
>>>> *context)
>>>> +{
>>>> +    struct lenovo_wmi_gz_priv *priv =3D
>>>> +        devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>> Please do the call to devm_kzalloc() on a separate line:
>>>
>>>      struct lenovo_wmi_gz_priv *priv;
>>>
>>>      priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>>
>>>> +
>>>> +    if (!priv)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (!context)
>>>> +        return -EINVAL;
>>>> +
>>>> +    priv->wdev =3D wdev;
>>>> +    priv->type =3D *((enum lenovo_wmi_gz_type *)context);
>>>> +
>>>> +    dev_set_drvdata(&wdev->dev, priv);
>>>> +
>>>> +    if (priv->type !=3D GAMEZONE_FULL)
>>>> +        return 0;
>>>> +
>>>> +    priv->nhead =3D gz_chain_head;
>>>> +    priv->ppdev =3D platform_profile_register(&wdev->dev,
>>>> "lenovo-wmi-gamezone",
>>>> +                        priv, &lenovo_wmi_gz_platform_profile_ops);
>>> Please check if platform_profile_register() was successful and return
>>> an error if not.
>>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
>>>> +    { GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
>>>> +    { GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) },
>>>> +    {}
>>>> +};
>>>> +
>>>> +static struct wmi_driver lenovo_wmi_gz_driver =3D {
>>>> +    .driver =3D {
>>>> +        .name =3D "lenovo_wmi_gamezone",
>>>> +        .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>>>> +    },
>>>> +    .id_table =3D lenovo_wmi_gz_id_table,
>>>> +    .probe =3D lenovo_wmi_gz_probe,
>>>> +    .notify =3D lenovo_wmi_gz_notify,
>>>> +    .no_singleton =3D true,
>>>> +};
>>>> +
>>>> +module_wmi_driver(lenovo_wmi_gz_driver);
>>>> +
>>>> +MODULE_IMPORT_NS("LENOVO_WMI");
>>>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
>>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>>> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/platform/x86/lenovo-wmi.c
>>>> b/drivers/platform/x86/lenovo-wmi.c
>>>> new file mode 100644
>>>> index 000000000000..0de2c37e69bd
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/lenovo-wmi.c
>>>> @@ -0,0 +1,77 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI
>>>> interface is
>>>> + * broken up into multiple GUID interfaces that require
>>>> cross-references
>>>> + * between GUID's for some functionality. The "Custom Method"
>>>> interface is a
>>>> + * legacy interface for managing and displaying CPU & GPU power and
>>>> hwmon
>>>> + * settings and readings. The "Other Mode" interface is a modern
>>>> interface
>>>> + * that replaces or extends the "Custom Method" interface methods. T=
he
>>>> + * "Gamezone" interface adds advanced features such as fan profiles =
and
>>>> + * overclocking. The "Lighting" interface adds control of various
>>>> status
>>>> + * lights related to different hardware components. "Other Mode" use=
s
>>>> + * the data structs LENOVO_CAPABILITY_DATA_00,
>>>> LENOVO_CAPABILITY_DATA_01
>>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>>>> + *
>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/wmi.h>
>>>> +#include "lenovo-wmi.h"
>>>> +
>>>> +/* wmidev_evaluate_method helper functions */
>>>> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8
>>>> instance,
>>>> +                     u32 method_id, struct acpi_buffer *in,
>>>> +                     struct acpi_buffer *out)
>>>> +{
>>>> +    acpi_status status;
>>>> +
>>>> +    status =3D wmidev_evaluate_method(wdev, instance, method_id, in,
>>>> out);
>>>> +
>>>> +    if (ACPI_FAILURE(status))
>>>> +        return -EIO;
>>>> +
>>>> +    return 0;
>>>> +};
>>>> +
>>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8
>>>> instance,
>>>> +                    u32 method_id, u32 arg0, u32 arg1,
>>>> +                    u32 *retval)
>>>> +{
>>> Please give this method a more descriptive name.
>>>
>>>> +    struct wmi_method_args args =3D { arg0, arg1 };
>>>> +    struct acpi_buffer input =3D { (acpi_size)sizeof(args), &args };
>>> Cast to acpi_size is unnecessary here.
>>>
>>>> +    struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>>> +    union acpi_object *ret_obj __free(kfree) =3D NULL;
>>>> +    int err;
>>>> +
>>>> +    err =3D lenovo_wmidev_evaluate_method(wdev, instance, method_id,
>>>> &input,
>>>> +                        &output);
>>>> +
>>>> +    if (err)
>>>> +        return err;
>>>> +
>>>> +    if (retval) {
>>>> +        ret_obj =3D (union acpi_object *)output.pointer;
>>>> +        if (!ret_obj)
>>>> +            return -ENODATA;
>>>> +
>>>> +        if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
>>>> +            return -ENXIO;
>>>> +
>>>> +        *retval =3D (u32)ret_obj->integer.value;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");
>>> Can you please rename the namespace to "LENOVO_WMI_HELPERS"?
>>>
>>>> +
>>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8
>>>> instance,
>>>> +                    u32 method_id, u32 arg0, u32 *retval)
>>>> +{
>>> Same as above.
>>>
>>>> +    return lenovo_wmidev_evaluate_method_2(wdev, instance,
>>>> method_id, arg0,
>>>> +                           0, retval);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
>>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>>> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/platform/x86/lenovo-wmi.h
>>>> b/drivers/platform/x86/lenovo-wmi.h
>>>> new file mode 100644
>>>> index 000000000000..113928b4fc0f
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/lenovo-wmi.h
>>>> @@ -0,0 +1,62 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>>>> + *
>>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI
>>>> interface is
>>>> + * broken up into multiple GUID interfaces that require
>>>> cross-references
>>>> + * between GUID's for some functionality. The "Custom Method"
>>>> interface is a
>>>> + * legacy interface for managing and displaying CPU & GPU power and
>>>> hwmon
>>>> + * settings and readings. The "Other Mode" interface is a modern
>>>> interface
>>>> + * that replaces or extends the "Custom Method" interface methods. T=
he
>>>> + * "Gamezone" interface adds advanced features such as fan profiles =
and
>>>> + * overclocking. The "Lighting" interface adds control of various
>>>> status
>>>> + * lights related to different hardware components. "Other Mode" use=
s
>>>> + * the data structs LENOVO_CAPABILITY_DATA_00,
>>>> LENOVO_CAPABILITY_DATA_01
>>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>>>> + *
>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>> + *
>>>> + */
>>>> +#include <linux/notifier.h>
>>>> +#include <linux/platform_profile.h>
>>>> +
>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> This causes a build error on my machine. Please only use this macro
>>> inside source files
>>> for modules and not inside header files.
>>>
>>>> +
>>>> +#ifndef _LENOVO_WMI_H_
>>>> +#define _LENOVO_WMI_H_
>>>> +
>>>> +#include <linux/bits.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/wmi.h>
>>>> +
>>>> +struct wmi_method_args {
>>>> +    u32 arg0;
>>>> +    u32 arg1;
>>>> +};
>>>> +
>>>> +/* gamezone structs */
>>>> +enum thermal_mode {
>>>> +    SMARTFAN_MODE_QUIET =3D 0x01,
>>>> +    SMARTFAN_MODE_BALANCED =3D 0x02,
>>>> +    SMARTFAN_MODE_PERFORMANCE =3D 0x03,
>>>> +    SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
>>>> +    SMARTFAN_MODE_CUSTOM =3D 0xFF,
>>>> +};
>>>> +
>>>> +enum lenovo_wmi_action {
>>>> +    THERMAL_MODE_EVENT =3D 1,
>>>> +};
>>>> +
>>>> +/* wmidev_evaluate_method helper functions */
>>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8
>>>> instance,
>>>> +                    u32 method_id, u32 arg0, u32 arg1,
>>>> +                    u32 *retval);
>>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8
>>>> instance,
>>>> +                    u32 method_id, u32 arg0, u32 *retval);
>>>> +
>>>> +/* lenovo_wmi_gz_driver notifier functions */
>>>> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned
>>>> long action,
>>>> +                enum platform_profile_option *profile);
>>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
>>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
>>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>>> +                     struct notifier_block *nb);
>>> Can you please create a separate header file for each driver?
>>> Otherwise this header file
>>> will contain many different things from different drivers, which will
>>> maybe not even be
>>> available depending on the Kconfig settings.
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>>>> +#endif /* !_LENOVO_WMI_H_ */

