Return-Path: <linux-kernel+bounces-542928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4CA4CF84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA613AC8B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8CE1F4174;
	Mon,  3 Mar 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Y6xqb6Dw"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E4F9E6;
	Mon,  3 Mar 2025 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046216; cv=none; b=mH4y4tJJUGPgW/FCP+R1MrGBrrs9Jjo45pLw0Jn8sHp5wDLJPwL1yHxtIkxLCNfOCXjWWRuOtNFuWyxO6lHmCN9ji+ZNkpSEnC5+xpAGkF02Q93ujiKy/B/63ewV6YT45S7xN2Kjff4efccnVWPCclsFf5HIdSrKm9PgmeucXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046216; c=relaxed/simple;
	bh=2VYHvVPd4rdnwNL6QDMD1wn4q69A1iPto1ooznN7v3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR+6hcBA5txQASREtYs6lNof9KtVBweXY+4oNGiPpnTA3rylpGkjEqWjzL1BKHNvMRh2XAdvPt+M2quWZGoLf7aMlpy05T+oHyFJ0GPVfNgncD/69yIzEbpE9Ps+deBUg+sfYLq1F9NrCp9x9L55JJCiqpyIzcxFF9iIGJq99ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Y6xqb6Dw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741046204; x=1741651004; i=w_armin@gmx.de;
	bh=2VYHvVPd4rdnwNL6QDMD1wn4q69A1iPto1ooznN7v3o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y6xqb6Dwl2gMihmuVYP82ZZRgkg5syR+XxfcB7GpgPsDQTX7K/S84ZnGeIoFeqFg
	 tbbK6yz/i6BbR+h297pvznfO+CoFVEnni2Mj5njKzMp3/bbt22M8rBM+mrlnxxuZi
	 ELU80kMT0Q/PAdhZwO3JTpRBWAjabWMADQLSAz1t5qqlobVxAZ0sMJkwejINXgr04
	 PTpoxKjIZAjfMSemHFtAwkHIRckWzBRi4ki31FNrOZVMr6gfhR7rvXLyjFEDV/kg+
	 +tQyscgOSbVeSKbqP+fG/QWd54ded6iZSvvKUwvWCmTbz92Q1hQ+q+OWoUo/ohcqP
	 mcWb+IllK3oIrQIYCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1u3t9l2JSv-00AmT5; Tue, 04
 Mar 2025 00:56:44 +0100
Message-ID: <3beeeb19-3791-4090-860e-45b8df2568a7@gmx.de>
Date: Tue, 4 Mar 2025 00:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: "Nirujogi, Pratap" <pnirujog@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0RPyHZ6Ypy6g5dLgrB3I3gUm32pXzDj+yeLI5vZsZPlMIuKnn7d
 ICfTzcBjRN9k19p3tkM3rk1dA/X72q9JzKVP0KEX8yU2juR1xUHKAkxwJXVEPnW7xppR0Ys
 04RVFXABpGrhZKscarrAMh4GGdujIenFJmJfpdNKJvarrre/DPdU0rQrheaA6D1C/29FG0e
 TQex8OShyFX4qZpgodN7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3rs4fPzyf3A=;5i5x68WFTDiKYr4LqUHKnuxg6p4
 vt9my5oVBJcKZjRmpKi+TuQsCvaog2RDDDNxOEfPFzu9pXmqEw8VCQapyLojl/sDMiq+XctV0
 VedZs7YbOPQkDPEFDWF76Mp9e0bqce3ZxT4V1m1psaP7OF4cRXYgN3z2s2DT2AvZBRsuiICQP
 4GgSuXF4lJqC1DQJmskKpUjqMQjx2b1iHPQyFpPfQeFQwrsdq7kYl003SALd/XlwYBAsHBLDn
 KLpxwIZ0Hb8ffntzCbI/oURUK5V3W9Gg0li++j/TfCiynHQVZVx/IqdIQUVWZzQwZQ4o0gilM
 hN+PgCXjG0FZSNCFtgRiA0njWAhliFARKJpT2UVdjZdJ2JkIwZ/c5Pn9b6EN8Lq7fn9XIrToZ
 0m3zni3DVvWUzgnCD5lAEBHkP7acN4nS73kmYTuM+PGte4fIg083V+n+ntDdLLWZcfSXJ1tlb
 6GryheSE+OwPu/ad/rZ3HMg+kTmMgZoZha10dFUTBmKYtCHlCFbRxsSNS344evHmqmxRI9BIe
 ZzUHfmuVbMhGXiwzPs3gTIZtDZElgWAKYoRgft1pthHuF3ssB468Pl31wLUUgV1dY4CnlnAxX
 kcqkQynpOMEjLEuQtsor8MadERz3QUVfHVffglZnkizQW/373cxR5TeWURdgVOmZdouNfDyvE
 60vmSnMQJZL1FIYyDnhtnDtOVARDOgu7u5/ob27Ws49cz9kwHxZKjFmyasaqnfo1I1k2lRua2
 JJpF4iCSaANhy2IPcqTGVC+A/otmXEdW4hYcnQyp8lZTLdwtgLCHRUctc8Pocgo/Unoe93t0D
 f54X8K5rf6C2XwVe8ufCyELkj1gql5zZskNJOie4gw7jh+W9rvDLz3YvoYdRdmJZ68K0qqrR4
 m65jzTg8HAhQdl2D3kbPJsWN5jfzrl9m/OvCFmTvIaVrZ+FQWal3gS394wo5jBKxWDuy2TOxJ
 UaSLkOE6XPowbmwyNt9e6N2vqPn8YnYiLUygI26yA/CQmtDgqhHF/AJPEPp21121jke0qAH6X
 gMN82GVthMqG880+tAQidkMlOsfyPenCjj0itGs1dopgX/ulcZ7C0vWS7rsC9fuow2rSTIVC0
 VmP6DcpzdVwjJab56aND7DWtgRQsaOmxNeVYrxaMfhB4xQ093V4LKnvYDCKsbSDRD9qW7qksr
 Q/V4kjhEX+FXQutky2kkIURXzb/MXYZRJrXBLLs80a8U6MIq+ONw9qwUQPkY4aV9ltGjGnka6
 pJvxWShGOkij/TQk5VwFbnkEFhzs1UGjZgXwDEW9B68EtfoRfoxOa3SnqnILuS0fCqowQrzmN
 XyI9CmyKSnU12V54odBEdMdic2RIT4nZJC4H0yLnRMeRRODmOVG3YwfxHSrbnYJ00jxGRw8Cc
 3YoEz6vFZieg1CtF4jS8Q7YMwLdpvA71yLCjVGjOZpUzEe2y0CPPFuQwWg2yoLhrEodAz9jIh
 kFquLw+yTee9pyb095AQa1u21HyA=

Am 04.03.25 um 00:14 schrieb Nirujogi, Pratap:

> Hi Hans,
>
> Thanks for your review. Please see the inline comments and let us know
> your insights.
>
> Thanks,
> Pratap
>
>
> On 3/3/2025 8:41 AM, Hans de Goede wrote:
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> Hi Pratap,
>>
>> Thank you for your patch.
>>
>> On 28-Feb-25 18:02, Pratap Nirujogi wrote:
>>> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
>>>
>>> Details of the resources added:
>>>
>>> - Added i2c bus number for AMD ISP platform is 99.
>>> - Added GPIO 85 to allow ISP driver to enable and disable ISP access.
>>> - Added GPIO 0 to allow sensor driver to enable and disable sensor
>>> module.
>>>
>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>> ---
>>> =C2=A0 drivers/platform/x86/amd/Kconfig=C2=A0=C2=A0 | 11 +++++
>>> =C2=A0 drivers/platform/x86/amd/Makefile=C2=A0 |=C2=A0 1 +
>>> =C2=A0 drivers/platform/x86/amd/amd_isp.c | 72
>>> ++++++++++++++++++++++++++++++
>>> =C2=A0 3 files changed, 84 insertions(+)
>>> =C2=A0 create mode 100644 drivers/platform/x86/amd/amd_isp.c
>>>
>>> diff --git a/drivers/platform/x86/amd/Kconfig
>>> b/drivers/platform/x86/amd/Kconfig
>>> index c3e086ea64fc..4b373edd750d 100644
>>> --- a/drivers/platform/x86/amd/Kconfig
>>> +++ b/drivers/platform/x86/amd/Kconfig
>>> @@ -32,3 +32,14 @@ config AMD_WBRF
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This mechanism will o=
nly be activated on platforms that
>>> advertise a
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 need for it.
>>> +
>>> +config AMD_ISP_PLATFORM
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool "AMD platform with ISP4 that supports C=
amera sensor device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 depends on I2C && X86_64 && AMD_ISP4
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For AMD platform that support Im=
age signal processor
>>> generation 4, it
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is necessary to add platform spe=
cific camera sensor module
>>> board info
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which includes the sensor driver=
 device id and the i2c address.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you have a AMD platform that =
support ISP4 and with a sensor
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connected to it, say Y here
>>> diff --git a/drivers/platform/x86/amd/Makefile
>>> b/drivers/platform/x86/amd/Makefile
>>> index 56f62fc9c97b..0d89e2d4f7e6 100644
>>> --- a/drivers/platform/x86/amd/Makefile
>>> +++ b/drivers/platform/x86/amd/Makefile
>>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D pmc/
>>> =C2=A0 obj-$(CONFIG_AMD_HSMP)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D hsmp/
>>> =C2=A0 obj-$(CONFIG_AMD_PMF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D pmf/
>>> =C2=A0 obj-$(CONFIG_AMD_WBRF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D wbrf.o
>>> +obj-$(CONFIG_AMD_ISP_PLATFORM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D amd_isp.o
>>> diff --git a/drivers/platform/x86/amd/amd_isp.c
>>> b/drivers/platform/x86/amd/amd_isp.c
>>> new file mode 100644
>>> index 000000000000..751f209e9509
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/amd/amd_isp.c
>>> @@ -0,0 +1,72 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> obtaining a
>>> + * copy of this software and associated documentation files (the
>>> "Software"),
>>> + * to deal in the Software without restriction, including without
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to
>>> whom the
>>> + * Software is furnished to do so, subject to the following
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/gpio/machine.h>
>>> +
>>> +#define AMDISP_I2C_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99
>>
>> I'm not a fan of using static i2c-bus numbers for this. static bus
>> numbers are
>> something of the past and we typically do not use these on x86 anymore.
>>
>> Using this static number + i2c_register_board_info() also requires
>> this code
>> to be builtin rather then modular which is also undesirable.
>>
>> For a more dynamic way of manually adding i2c-devices see:
>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/platform/x86/dell/dell-lis3lv02d.c
>>
>>
>> But a better question here is why instantiate the sensor i2c device
>> manually at all.
>>
>> ACPI has a standardized way to describe I2C-clients which tyically
>> is used for all I2C devices on ACPI platforms like I2C touchscreens /
>> touchpads / audio-codecs / accelerometers / etc.
>> I don't see why the camera sensor on AMD platforms is so special that
>> it could not be described in ACPI using an ACPI child-device of the
>> i2c-controller with a ACPI resource (_CRS entry) of the I2cSerialBusV2(=
)
>> type.
>>
>> Likewise the sensor enable GPIO should also be described in the ACPI
>> table as a Gpio type resource in the same _CRS table.
>>
>
> We have to take this approach because ISP is a child to GFX PCI device
> in AMD HW architectures, and since it is not an independent device,
> its device specific configuration (gpio pin ids, i2c-bus number etc.)
> is not registered in ACPI.
>
>> Can you run acpidump -o acpidump.txt on a laptop with this camera
>> sensor and send me the acpidupm.txt offlist ? Please run this
>> on a production hardware laptop model using production firmware.
>>
>
> Please refer the attached acpidump.txt
>
>> I suspect that Windows will also be using the ACPI description
>> for the sensor so we really should figure out what Windows is doing
>> here.
>>
>
> Yes, same ACPI configuration for both Windows and Linux. Similar
> approach followed even on windows to control the isp gpio pins.
>
The OMNI5C10 ACPI device has a _DSM method that supports the GUID f8fd3bff=
-21b7-4a99-bdc8-c414a3e9453c. Do you know
more about the purpose of this method?

Thanks,
Armin Wolf

>> As Mario mentioned we cannot just assume that the GPIOs +
>> sensor address and model are valid for all laptops. Ideally we should
>> be getting this information from ACPI rather then hardcoding it
>> in the kernel.
>>
>
> Yes, we initially assumed CONFIG_AMD_ISP_PLATFORM=3Dy will be set only
> on the intended platforms, but as that assumption is not valid, the belo=
w
> check is added in v2 patch checking the specific ov05c acpi hw id to
> present before running the driver.
>
> /* check for valid platform before configuring isp4 board resources */
> =C2=A0=C2=A0=C2=A0=C2=A0if (!acpi_dev_found(AMDISP_ACPI_CAM_HID))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>
>>> +
>>> +static struct gpiod_lookup_table isp_gpio_table =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_id =3D "amd_isp_capture",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .table =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp",
>>> GPIO_ACTIVE_HIGH),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 { }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> +};
>>
>> This too really should be an Gpio() type ACPI resource on the ACPI
>> device
>> node for the ISP.
>>
>> How/where is this "amd_isp_capture" device created ?
>>
>
> "amd_isp_capture" is the V4L2 ISP driver in this case. The patches for
> ISP driver are yet to be submitted. It will be loaded during AMDGPU
> device probe on the AMD platforms supporting isp4.2 HW. AMDGPU
> reference to trigger the isp device probe:
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu=
/isp_v4_1_1.c#L108
>
>
>> Regards,
>>
>> Hans
>>
>>
>>> +
>>> +static struct gpiod_lookup_table isp_sensor_gpio_table =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_id =3D "ov05c",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .table =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 GPIO_LOOKUP("amdisp-pinctrl", 0, "sensor0_enable",
>>> GPIO_ACTIVE_HIGH),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 { }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static struct i2c_board_info sensor_info =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "ov05c",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 I2C_BOARD_INFO("ov05c", 0x10),
>>> +};
>>> +
>>> +static int __init amd_isp_init(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_add_lookup_table(&isp_gpio_table);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_add_lookup_table(&isp_sensor_gpio_tabl=
e);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_register_board_info(AMDISP_I2C_B=
US, &sensor_info, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pr_err("%s: cannot register i2c board devices:%s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, sensor_info.dev_na=
me);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +arch_initcall(amd_isp_init);
>>> +
>>> +MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
>>> +MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
>>> +MODULE_DESCRIPTION("AMD ISP Platform parameters");
>>> +MODULE_LICENSE("GPL and additional rights");
>>

