Return-Path: <linux-kernel+bounces-283995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227094FBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA05CB225D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A391400A;
	Tue, 13 Aug 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="I38AvioT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E7134A8;
	Tue, 13 Aug 2024 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515100; cv=none; b=Y/ZO7iOGmsPyBkhBGuCd2NN1RzQUc3HwN5D1Eh7TDirEE3pDb1VPoXzzYvxpsgPWrQyE/DO9+HD6UPoifI6YpbTZ2mywO5WajIVeP7G5HXTwE51mKjqcaOW7TvDXeNGuUSW0gZ3svjzxZqVvQZNUn+zi9vACNQsv4PdhNnwi2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515100; c=relaxed/simple;
	bh=+bgA8kgkwcOUDh++Y+cT7RONyGBQO8zxnko/TIiwJlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPjjoM3hCaaws1bySLvXJYUOK6QF18vJJRY2PVBCiQfHQqAXk+65cr12+RfcmwyrYiW5QhutqaExRmHOP/TnJx39ekON2uY9F6Bmp7MSt9EvAwhc9Zin43raAbhKSOtyw3GUTmW6WAWHZ/0JEgC2Vwa2YHoyDfTQJCp2ivGDuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=I38AvioT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723515085; x=1724119885; i=w_armin@gmx.de;
	bh=II5PRsYnuyUiw0g3QFYNDgdl2LwxhEM1GBt9uI/GHpU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I38AvioTwyu0uXcanvRfuOyEP8JbcYi5BGLGqfjSCFmojxowYspTcgcfvzESGRCl
	 uf26ckV96LjM8V/zVeD1EzuZcZhtELXed/ScqnsxfGgKGAVXYuwm3wbuY+f4eixxo
	 72/NTG2V16lYe2ILKhNx6vmKt5UGnD4iwATKS2ZH98EHAhGjK0BNTKAiEi2z82Av0
	 k1//j14UdAMksqNsIEE1yJQuXmldQ8hXXooRTlwwonDeqZH5fQP1WNsP1EHlyyLag
	 y8cjY5HNq4ECHPnrP9Ten8VTGANHQXAqAlg4PSHgVNmvCN8sLHrBWFPIv+9axw5wk
	 R1cMrXaT9Oe5d+bsQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1s0o5S0kOF-00h9gm; Tue, 13
 Aug 2024 04:11:25 +0200
Message-ID: <e9a3f879-8de8-4330-915a-1cef583b0e82@gmx.de>
Date: Tue, 13 Aug 2024 04:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: lg-laptop: Add operation region support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: matan@svgalib.org, ghostwind@gmail.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240809175211.5962-1-W_Armin@gmx.de>
 <4cbf5396-37e5-5e66-e26f-c43186e285da@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4cbf5396-37e5-5e66-e26f-c43186e285da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5+1Pf075biab82M4BuDD0bnx6NmCUHlpLmKNtGIA9el6v2D+4YZ
 GdoV6Tixc46qLdRhL2PUkjUPusE2+hMe5R77jjD6LVSRMiz+H3bkvQfo5UsOQvNsp47lpAF
 T1uyn81AJAvlGs0fmAJQbvv35pbAqiZ3ci+GB/vLnWYbILlWd9roJYS1+ZBFZujZkWYEih4
 aoxEDhGHHg8NVuY8ZbGpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pn3ruTzFB+4=;kqoY1lTE6IMO8tJKeVojMNe/Phi
 3BMCKiBW8+8QPgjTRkUIuZh75QOAEaeJw+5t9nMffwSfubJsG/o+mc0coqQPK8JPrQt7MkM2C
 t//l+CXzbU5gCbVU9oUuG4W0MOvpgg6ZlCEPAtaTSRpG1WGn8zKjSMH/A37MTMvN0+cql4qFA
 Ui4OvyijurZSzHhLD2w6dyQzmTXpvc+8bNAcuFp+R9Jp5POaXjXH8+A8pIohhalkEoQOKTL5I
 0DrCcer+1xVq1vv+cZag2sDanUiIF4Qo/srFWm6yGR4BcWKaK2E1keLS3Al0ji41h5uCNnTbF
 m2j6DBw8s7CBZRWxk6QyZqIY6P/3edx8t/SUuL6dlbWsl3DQEVPhBIieUN9zHXi0A3o5DpH2z
 4ThgRq3x6XnOas+lkJztlAzrPIfgSKWw1R3Sx/2c0wlIk+DVvX6amwaus1q0Z12lGMDbital5
 zu9xJXCwUJz8AaLItXn9Ec7FaSwI5+kIVob3yKVg9VP8Q1NvEtoBh54iS2+ydc2d+VgeMnFBK
 4VyMZhY2QU2y4ijInpHA77zTryhc8niw+QJhuA34+AVchZePMlLYWc/TxPMnOWNx8GH4WekJQ
 ogIxABHOoNQNIgdDloNLEzukyEbdTJxuZ7xXcij1m+yri0sfWHxllR857JR9Tsu0QD3dG7gLd
 a4XtMDIQuLqSae5YEK8DODTaQzINixC05af7qVNZgFJEWA6cWBJjxVdKzFqZI3sjK9UgCSlI/
 grnmjecO6p2BGbege5jv/fWnOIQdV32sFGOZUEldRagVgoToXJYOR+f/n5SACi9ABAGuo8qqG
 ANh1+xeVOJIJvold8ooteERA==

Am 12.08.24 um 14:19 schrieb Ilpo J=C3=A4rvinen:

> On Fri, 9 Aug 2024, Armin Wolf wrote:
>
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
>> methods, various thermal zone become unusable since any attempts to
> attempt
>
>> read their temperature results in an ACPI error.
>>
>> Fix this by providing support for this operation region. I suspect
>> that the problem does not happen under Windows (which seemingly does
>> not use short-circuit evaluation either) because the necessary driver
>> comes preinstalled with the machine.
>>
>> Tested-by: Chris <ghostwind@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/lg-laptop.c | 128 ++++++++++++++++++++++++++++++=
+
>>   1 file changed, 128 insertions(+)
>>
>> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg=
-laptop.c
>> index 9c7857842caf..6310a23f808c 100644
>> --- a/drivers/platform/x86/lg-laptop.c
>> +++ b/drivers/platform/x86/lg-laptop.c
>> @@ -8,6 +8,8 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>>   #include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/dev_printk.h>
>>   #include <linux/dmi.h>
>>   #include <linux/input.h>
>>   #include <linux/input/sparse-keymap.h>
>> @@ -31,6 +33,25 @@ MODULE_AUTHOR("Matan Ziv-Av");
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
>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR	0x3E8
>> +#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR	0x5E8
>> +
>> +#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
>> +#define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
> Any particular reason why there are not in numerical order?

Hi,

i decided to group all fields connected to the DTTM flag together, but if =
you wish i can
sort them in numerical order.

>> +#define LG_ADDRESS_SPACE_CPU_TEMP_ADR		0x21
>> +#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR	0x22
>> +#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR	0x23
>> +#define LG_ADDRESS_SPACE_MB_TEMP_ADR		0x24
>> +#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR	0x25
>> +#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR	0x26
>> +
>>   #define WMI_EVENT_GUID0	"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
>>   #define WMI_EVENT_GUID1	"023B133E-49D1-4E10-B313-698220140DC2"
>>   #define WMI_EVENT_GUID2	"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
>> @@ -646,6 +667,101 @@ static struct platform_driver pf_driver =3D {
>>   	}
>>   };
>>
>> +static acpi_status lg_laptop_address_space_write(struct device *dev, a=
cpi_physical_address address,
>> +						 size_t size, u64 *value)
> Why is this write function taking u64 _pointer_?

Good point, i will change that.

>
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
>> +	byte =3D *value & 0xFF;
>> +
>> +	switch (address) {
>> +	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
>> +		dev_dbg(dev, "Fan mode set to mode %u\n", byte);
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
>> +	if (bits % 8)
>> +		return AE_BAD_PARAMETER;
>> +
>> +	size =3D bits / 8;
> BITS_PER_BYTE x2
>

