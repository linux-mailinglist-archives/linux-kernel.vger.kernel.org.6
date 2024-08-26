Return-Path: <linux-kernel+bounces-302137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CF95FA66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EE71F221A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE32199EA2;
	Mon, 26 Aug 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jnd96svT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9C824BB;
	Mon, 26 Aug 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702979; cv=none; b=dF7BvZzPtbtRrgUJCAPazk3djMcaXG6Z1EPlpbBLL0zR73lpOPyQC7660rWeoL0SCS6Z+u/OU2op1qh4YeCar/ev2dmbIJWLlnGFCDS/Af3WczxEiHjklVlbJlwuCLiI3AES8XvKTtGtsZv2RLPcoZjGgqnKJlxY70WKfzR2qoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702979; c=relaxed/simple;
	bh=sHLqj1vAwxaDhY/qSRsWk8lF+qSBLJUR2tdp7mhUfoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRAXDyb0WtWDgHIxo07zqv1i+20i9IMQh7dVt1R7z8cF0wt94kIlJm3mGI1wLrkUqGl/Lbmi9KTOTsZkleZwJ/yPeNg2eZZv4/lGUD+2VqQ2PBcJI6Y/Ph7zkO/pC3+IxQxxFZVvh+dHguFd84fLq2PiyTnD4NzsPQFWNbEewCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jnd96svT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724702967; x=1725307767; i=w_armin@gmx.de;
	bh=knwYtvYxPn6SDhKMVyGV5cB7bPNqMtK85l882hQvwJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jnd96svTLTnyffpC1ResqqcoLRf1pcD359aHzMmRLaFI/BnRwKPdnqL5Jyt8aoWB
	 A+0C0PqPS4I3h7rKoIvPZdirTi1VmwtVRBo6ETPPiP9VMma4b69n5SSCdlJ20AWzn
	 b5w2nDXtLqowFVfYSH+1lgT1vOkt6iY3v5HWEpIVR85jgyww/m3/viuK86b0XQKSw
	 IlYt4oZTckJ+cjE6OCZ4DIJXgoLVjU25Yc/4ShGCLzj852AhVC6tpo8ogQC5SyDuU
	 NblFCronwkG91ttxRJFx1RhEXtTIpVmpDXzL9eDH40DUmQKVSJQUx1EQZJUEAEj68
	 aGvqvUsW1GzQvcBJVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1stfRP2lVA-00DXV0; Mon, 26
 Aug 2024 22:09:27 +0200
Message-ID: <1f6d06a3-1e5a-4b34-b43f-c3d23ee7218a@gmx.de>
Date: Mon, 26 Aug 2024 22:09:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: lg-laptop: Add operation region support
To: Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
 ghostwind@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240813022903.20567-1-W_Armin@gmx.de>
 <bb7926e9-759b-4899-b616-c8c7ffcc9a55@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <bb7926e9-759b-4899-b616-c8c7ffcc9a55@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FhwR26gbEkYBRU+cUEhs0OWMbx3ezsSoKcIt8k4WtIYwDqby6x+
 TGQBMAJGG0o/zqIOn+ugK93rFJ0gDF5XrsKR30Vt1aHef6GJs8FVBmXK8DyAQiZ5ObrKZPi
 Z8nliRoOtVrMfFf3E4v+2tRE637Gp0R2q4891+nIIEPr9JsMnSc5NiPjbD9XZ5bX9JkN+u3
 SG6kwQ+OKNTNNduBgo4cQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vlPw3dKcljk=;jHZktkBx+G0icpZz8DJwE4sBtjI
 cy0DbFlOpOKcPHQ3k3Hbxn5yfBhY88VbAJ9bndwGr7W2uQWk1yZaO0sV46ASrslBJCmo/k/Wj
 SE1tRweBj78Jcv3oJXj98RH3oZmFMctl/yR23ddgthvwepdO+WQ677/iFMEH2Honz+A1H2V6o
 BT46ndNNqVANfY/pIbcpwJcLY3PRcE2ryQebvp2KcGmTONOHJr8dC39BWF4fi/mmar0jRHWOY
 wdFlExk2GdNi210HdudcIn2kGBmQTbwKKj542U+GUu1stAzxx9cvCLYoYnfq5HEdnxJlhEHVo
 BFAXX85eUYZ8qpdOUTLcZsBV5pq7jpEBt8KcrEJZie5u8dtE0tqj7w8Xov/5M8Nyr8ueN3X00
 0EvS+/A++lM5TUcMwP3dQ8AP6/oDi0cjQCbN6cUcrCO2H8EgtsWYYWTmc+naf9FXPDvwyAijQ
 kT+/x+WcKAVHW0yWP9Pe1ePXjOxljIa3EYECNrpsvzM7ABbJBw+M56D8SiTImw9VpoqtGvMnQ
 1abC5ggV/z/3K4l/mTKIGRxfPJgpDtpwrb4e+5UuNqkcRc7xpUXCOekJURAPS414P0/BqfF+R
 fDpkSvMEAjLwthtbxUUITno5p8s9dwuSOX2yMg6bIsiGKPhDKM2cEkWH+sqBmU3g6yntiQcKO
 fy+aI5xnrqzbDFpRNUQgrlo8bqTx2INbsut3wSC/WLnp5UrRbgB6pgyDfF/qWiRsnku0G6y/e
 HWXh4nPxzY1M3AImTC4YlMuK5z4qF5wpHU9eXrxD53LKeENGoMJZoBBPmriSwGboR5drBqv9E
 CCiFuSIfoIjPeWRwH/DzhkPQ==

Am 19.08.24 um 13:37 schrieb Hans de Goede:

> Hi,
>
> On 8/13/24 4:29 AM, Armin Wolf wrote:
>> The LEGX0820 ACPI device is expected to provide a custom operation
>> region:
>>
>> 	OperationRegion (XIN1, 0x8F, Zero, 0x04B0)
>>          Field (XIN1, AnyAcc, Lock, Preserve)
>>          {
>>              DMSG,   8,
>>              HDAP,   8,
>>              Offset (0x03),
>>              AFNM,   8,
>>              Offset (0x10),
>>              P80B,   8,
>>              P81B,   8,
>>              P82B,   8,
>>              P83B,   8,
>>              P84B,   8,
>>              P85B,   8,
>>              P86B,   8,
>>              P87B,   8,
>>              Offset (0x20),
>>              DTTM,   8,
>>              TMP1,   8,
>>              LTP1,   8,
>>              HTP1,   8,
>>              TMP2,   8,
>>              LTP2,   8,
>>              HTP2,   8,
>>              Offset (0x3E8),
>>              PMSG,   1600
>>          }
>>
>> The PMSG field is used by AML code to log debug messages when DMSG is
>> true. Since those debug messages are already logged using the standard
>> ACPI Debug object, we set DMSG unconditionally to 0x00 and ignore any
>> writes to PMSG.
>>
>> The TMPx, LTPx, HTPx and AFNM fields are used to inform the driver when
>> the temperature/(presumably) trip points/fan mode changes. This only
>> happens when the DTTM flag is set.
>>
>> Unfortunately we have to implement support for this operation region
>> because the AML codes uses code constructs like this one:
>>
>> 	If (((\_SB.XINI.PLAV !=3D Zero) && (\_SB.XINI.DTTM !=3D Zero)))
>>
>> The PLAV field gets set to 1 when the driver registers its address spac=
e
>> handler, so by default XIN1 should not be accessed.
>>
>> However ACPI does not use short-circuit evaluation when evaluating
>> logical conditions. This causes the DTTM field to be accessed even
>> when PLAV is 0, which results in an ACPI error.
>> Since this check happens inside various thermal-related ACPI control
>> methods, various thermal zone become unusable since any attempt to
>> read their temperature results in an ACPI error.
>>
>> Fix this by providing support for this operation region. I suspect
>> that the problem does not happen under Windows (which seemingly does
>> not use short-circuit evaluation either) because the necessary driver
>> comes preinstalled with the machine.
>>
>> Tested-by: Chris <ghostwind@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
Any updates on this? I would prefer to have this merged for the upcoming 6=
.12 kernel since
without this patch many LG notebooks have unusable thermal zones.

Thanks,
Armin Wolf

>
>> ---
>> Changes since v1:
>>   - attempts -> attempt
>>   - sort defines in numerical order
>>   - make lg_laptop_address_space_write() take a plain u64
>>   - use BITS_PER_BYTE
>>   - manually check fw_debug when handling fan mode updates
>> ---
>>   drivers/platform/x86/lg-laptop.c | 136 ++++++++++++++++++++++++++++++=
+
>>   1 file changed, 136 insertions(+)
>>
>> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg=
-laptop.c
>> index 9c7857842caf..55d31d4fefd6 100644
>> --- a/drivers/platform/x86/lg-laptop.c
>> +++ b/drivers/platform/x86/lg-laptop.c
>> @@ -8,6 +8,9 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>>   #include <linux/acpi.h>
>> +#include <linux/bits.h>
>> +#include <linux/device.h>
>> +#include <linux/dev_printk.h>
>>   #include <linux/dmi.h>
>>   #include <linux/input.h>
>>   #include <linux/input/sparse-keymap.h>
>> @@ -31,6 +34,26 @@ MODULE_AUTHOR("Matan Ziv-Av");
>>   MODULE_DESCRIPTION("LG WMI Hotkey Driver");
>>   MODULE_LICENSE("GPL");
>>
>> +static bool fw_debug;
>> +module_param(fw_debug, bool, 0);
>> +MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages=
");
>> +
>> +#define LG_ADDRESS_SPACE_ID			0x8F
>> +
>> +#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR		0x00
>> +#define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
>> +
>> +#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
>> +#define LG_ADDRESS_SPACE_CPU_TEMP_ADR		0x21
>> +#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR	0x22
>> +#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR	0x23
>> +#define LG_ADDRESS_SPACE_MB_TEMP_ADR		0x24
>> +#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR	0x25
>> +#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR	0x26
>> +
>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR	0x3E8
>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR	0x5E8
>> +
>>   #define WMI_EVENT_GUID0	"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
>>   #define WMI_EVENT_GUID1	"023B133E-49D1-4E10-B313-698220140DC2"
>>   #define WMI_EVENT_GUID2	"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
>> @@ -646,6 +669,107 @@ static struct platform_driver pf_driver =3D {
>>   	}
>>   };
>>
>> +static acpi_status lg_laptop_address_space_write(struct device *dev, a=
cpi_physical_address address,
>> +						 size_t size, u64 value)
>> +{
>> +	u8 byte;
>> +
>> +	/* Ignore any debug messages */
>> +	if (address >=3D LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR &&
>> +	    address <=3D LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR)
>> +		return AE_OK;
>> +
>> +	if (size !=3D sizeof(byte))
>> +		return AE_BAD_PARAMETER;
>> +
>> +	byte =3D value & 0xFF;
>> +
>> +	switch (address) {
>> +	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
>> +		/*
>> +		 * The fan mode field is not affected by the DTTM flag, so we
>> +		 * have to manually check fw_debug.
>> +		 */
>> +		if (fw_debug)
>> +			dev_dbg(dev, "Fan mode set to mode %u\n", byte);
>> +
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_CPU_TEMP_ADR:
>> +		dev_dbg(dev, "CPU temperature is %u =C2=B0C\n", byte);
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR:
>> +		dev_dbg(dev, "CPU lower trip point set to %u =C2=B0C\n", byte);
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR:
>> +		dev_dbg(dev, "CPU higher trip point set to %u =C2=B0C\n", byte);
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_MB_TEMP_ADR:
>> +		dev_dbg(dev, "Motherboard temperature is %u =C2=B0C\n", byte);
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR:
>> +		dev_dbg(dev, "Motherboard lower trip point set to %u =C2=B0C\n", byt=
e);
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR:
>> +		dev_dbg(dev, "Motherboard higher trip point set to %u =C2=B0C\n", by=
te);
>> +		return AE_OK;
>> +	default:
>> +		dev_notice_ratelimited(dev, "Ignoring write to unknown opregion addr=
ess %llu\n",
>> +				       address);
>> +		return AE_OK;
>> +	}
>> +}
>> +
>> +static acpi_status lg_laptop_address_space_read(struct device *dev, ac=
pi_physical_address address,
>> +						size_t size, u64 *value)
>> +{
>> +	if (size !=3D 1)
>> +		return AE_BAD_PARAMETER;
>> +
>> +	switch (address) {
>> +	case LG_ADDRESS_SPACE_DEBUG_FLAG_ADR:
>> +		/* Debug messages are already printed using the standard ACPI Debug =
object */
>> +		*value =3D 0x00;
>> +		return AE_OK;
>> +	case LG_ADDRESS_SPACE_DTTM_FLAG_ADR:
>> +		*value =3D fw_debug;
>> +		return AE_OK;
>> +	default:
>> +		dev_notice_ratelimited(dev, "Attempt to read unknown opregion addres=
s %llu\n",
>> +				       address);
>> +		return AE_BAD_PARAMETER;
>> +	}
>> +}
>> +
>> +static acpi_status lg_laptop_address_space_handler(u32 function, acpi_=
physical_address address,
>> +						   u32 bits, u64 *value, void *handler_context,
>> +						   void *region_context)
>> +{
>> +	struct device *dev =3D handler_context;
>> +	size_t size;
>> +
>> +	if (bits % BITS_PER_BYTE)
>> +		return AE_BAD_PARAMETER;
>> +
>> +	size =3D bits / BITS_PER_BYTE;
>> +
>> +	switch (function) {
>> +	case ACPI_READ:
>> +		return lg_laptop_address_space_read(dev, address, size, value);
>> +	case ACPI_WRITE:
>> +		return lg_laptop_address_space_write(dev, address, size, *value);
>> +	default:
>> +		return AE_BAD_PARAMETER;
>> +	}
>> +}
>> +
>> +static void lg_laptop_remove_address_space_handler(void *data)
>> +{
>> +	struct acpi_device *device =3D data;
>> +
>> +	acpi_remove_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID=
,
>> +					  &lg_laptop_address_space_handler);
>> +}
>> +
>>   static int acpi_add(struct acpi_device *device)
>>   {
>>   	struct platform_device_info pdev_info =3D {
>> @@ -653,6 +777,7 @@ static int acpi_add(struct acpi_device *device)
>>   		.name =3D PLATFORM_NAME,
>>   		.id =3D PLATFORM_DEVID_NONE,
>>   	};
>> +	acpi_status status;
>>   	int ret;
>>   	const char *product;
>>   	int year =3D 2017;
>> @@ -660,6 +785,17 @@ static int acpi_add(struct acpi_device *device)
>>   	if (pf_device)
>>   		return 0;
>>
>> +	status =3D acpi_install_address_space_handler(device->handle, LG_ADDR=
ESS_SPACE_ID,
>> +						    &lg_laptop_address_space_handler,
>> +						    NULL, &device->dev);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
>> +
>> +	ret =3D devm_add_action_or_reset(&device->dev, lg_laptop_remove_addre=
ss_space_handler,
>> +				       device);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	ret =3D platform_driver_register(&pf_driver);
>>   	if (ret)
>>   		return ret;
>> --
>> 2.39.2
>>
>

