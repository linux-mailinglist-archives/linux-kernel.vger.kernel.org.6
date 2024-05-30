Return-Path: <linux-kernel+bounces-195043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14318D46BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31F91C21DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED4C147C79;
	Thu, 30 May 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CBxnfPbR"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A3176ABB;
	Thu, 30 May 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056554; cv=none; b=Yszj+VSUYxK5+AWsGEKtgf8RbsiVr5sj/h9XhgI9eDXr3fKdS+EBQsovIBV6j+Bk6iPt/IpefOveZxbylvG0qGrkW5PPuzlZl+SUGxSoI8XNgTar0ht0LLrH44BYiEGpORVMj6KdQbpqihpnHWYDVgQG50H21UNKQ8usgvzAfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056554; c=relaxed/simple;
	bh=f7w3iMOvgMcHVOOsSvi9aYunUnB6km1x5VMHwTe8soU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqfZMfGl3hcH4nEGVburkG4vA0VoCYOZCG/fvvUzZ5s0Lxn/PgL8W7bxf97aQHsLXf4YPlyDY2FYGIQWj7L3KCuqD4qJKZnC5teuiq083B/rFCHFY5JLg/t7Awmyg52w/n+iblE5+qnhh16jPSuhBWhTmiAhNKrbsldntZEV3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CBxnfPbR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717056518; x=1717661318; i=w_armin@gmx.de;
	bh=53mmizKieEiS/hDJnvXMCzWONSw8vI/Jx+hyT7cCWx0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CBxnfPbRCfzNRgR3zwI7ktQWl5ZSjDsjyxleVdJOcCsO3v0CduQpF8QzZkf8aX8+
	 xH9qv/RKmiNZB6UL3V6s/CBl67xT+g1/4xvYWdV/gZektGejq+zD0S7a5ckqJf1+z
	 F/LwcYaKga12wTcu3EVIheY+8Q5ZCd3ZoLQRiHBmh0OG6YUkmPizl+aW6Cw+j1Ppr
	 Fr6cSH57u9rLk1WWePW/6sKKWqelOffYNh9iIpdWxlIkcjpsJXSgP726oO+gxY2os
	 8+1TLN6QBMUhV4OLNxJSqrAksz5tyHB+bm4PAW1guVsaIK7FN/CmJ4c3/7wBPg8+S
	 tSoCcoYfk0b/SvleiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1sVE9N1cDD-00uuWA; Thu, 30
 May 2024 10:08:38 +0200
Message-ID: <fa79f3c2-666f-48b8-b39a-f598107b2293@gmx.de>
Date: Thu, 30 May 2024 10:08:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240529205204.81208-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e8E/2DuFszRcohzwqsBoWhU+JD0Iv1Xbx9u4qZfdgJj7F0obfo8
 TPahrenTyD61qn7AUP5GZPdHuDzcE/BbEZ1ldEZFoMFvrTzUJZFG6RExkoNYAbLfCVoah8+
 eCbzIP2tMRzh9hRkxEoa31iATBud/4UCSAsAbML46o7h8nUCehRNu09gwdRLE97oUmbb7Ye
 mNT6nQK3b9gXIlZolMFpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sV5Q+OhjaH8=;nu08ALAPt7sY8o/irAM1pzJZGHN
 tmro41szBhCWyic1A//SNHXE9NqsuSZ7idpIoZfd7AXkgs/z+EAgqu3302+8Kgf2pyApeuYrS
 dv5DJqIZEHuPW6BCRGo3M1qfpYBP3Mm7+xFOxQWikP6Onk7kMszGNXxILES78gfxT2+Ax8I2V
 XmNBRNKm72/rW8VZMmSgpxGnFAu/TEfCqZjFdJqzilVCfmU764WqU2KnhC7uOQ1YO19paegG5
 vnf49YZ6c6oHtlO0gRc5EBi2maMV6VAIbmeCEz4cO5QIY9j4fLO7+kNeh9piQGTcVwGt5Vt7B
 AlktbHyDAZK/5aFZJT9PxNQaGTDl8ZvTrdRGsT1ZGRXQspF3n6FfCIvZ05IIhrccdHy4jQDNN
 icAQB+tMETE9SD8p76H3ZAufTg5SKtWEC3kxzn4gtswyLWqLM7GA9uCl9yktv93WV2moPNAZW
 9n3VTfImcgRomyCD+B7u2VpCvj6q1iEJbp7p6/z+Ci/pIUy7hss/uQGbwI7kkCLulTIRfK1nV
 rvvvHSJN62uT86OvkmtDUbHufpZ+1Bj7rR+/S5+YzGwgggyN5YVIkBHXBq3i6S15S4/ZeBJAD
 QytQ2y5+D17DU44+y/VNpVtF28cFR5GDeQI3habDyMuoMqm1t7GuRKBzmw4f3Y9ir7frwdORh
 412l78qh/UaaEVQdV49pRpOY1+r+zvUBejKJf5jOTleUR3qODS5rkPrpgGRx18h2M4ZmdwYWf
 nGVGOZNW/NzHCUBdVBIQ0fUmawlFSK3NXKkENlNcNJZquFoJCBaWTcZR/j2mnklRaw85UXr8b
 MVMj8gsOmyWTwVfOiE8kz+ytTbi3bSlN2Vgp6bOWR807g=

Am 29.05.24 um 22:52 schrieb Guenter Roeck:

> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> sensors. Such sensors are typically found on DDR5 memory modules.
>
> Cc: Ren=C3=A9 Rebe <rene@exactcode.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
> (Corsair Venegance DDR5).
>
> Ren=C3=A9: I included you as MODULE_AUTHOR since the patch is derived fr=
om
>        your driver. Please let me know if you prefer not to be listed as
>        author.
>
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/spd5118.rst |  60 ++++
>   drivers/hwmon/Kconfig           |  12 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
>   5 files changed, 556 insertions(+)
>   create mode 100644 Documentation/hwmon/spd5118.rst
>   create mode 100644 drivers/hwmon/spd5118.c
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index 03d313af469a..6e7b8726b60c 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -215,6 +215,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m192
>      smsc47m1
>      sparx5-temp
> +   spd5118
>      stpddc60
>      surface_fan
>      sy7636a-hwmon
> diff --git a/Documentation/hwmon/spd5118.rst b/Documentation/hwmon/spd51=
18.rst
> new file mode 100644
> index 000000000000..67e990551a8a
> --- /dev/null
> +++ b/Documentation/hwmon/spd5118.rst
> @@ -0,0 +1,60 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver spd5118
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +
> +  * SPD5118 (JEDEC JESD300-5B.01) compliant temperature sensor chips
> +
> +    JEDEC standard download:
> +	https://www.jedec.org/standards-documents/docs/jesd300-5b01
> +	(account required)
> +
> +
> +    Prefix: 'spd5118'
> +
> +    Addresses scanned: I2C 0x50 - 0x57
> +
> +Author:
> +	Guenter Roeck <linux@roeck-us.net>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for SPD5118 (JEDEC JESD300-5B.01) compli=
ant
> +temperature sensors, which are used on many DDR5 memory modules. Some s=
ystems
> +use the sensor to prevent memory overheating by automatically throttlin=
g
> +the memory controller.
> +
> +The driver auto-detects SPD5118 compliant chips, but can also be instan=
tiated
> +using devicetree/firmware nodes.
> +
> +A SPD5118 compliant chip supports a single temperature sensor. Critical=
 minimum,
> +minimum, maximum, and critical temperature can be configured. There are=
 alarms
> +for low critical, low, high, and critical thresholds.
> +
> +
> +PEC configuration
> +-----------------
> +
> +If the I2C/SMBus controller supports PEC, it can be enabled or disabled=
 using
> +the 'pec' sysfs attribute attached to the i2c device.
> +
> +
> +Hardware monitoring sysfs entries
> +---------------------------------
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +temp1_input		Temperature (RO)
> +temp1_lcrit		Low critical high temperature (RW)
> +temp1_min		Minimum temperature (RW)
> +temp1_max		Maximum temperature (RW)
> +temp1_crit		Critical high temperature (RW)
> +
> +temp1_lcrit_alarm	Temperature low critical alarm
> +temp1_min_alarm		Temperature low alarm
> +temp1_max_alarm		Temperature high alarm
> +temp1_crit_alarm	Temperature critical alarm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7f384a2494c9..111d05718b89 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2182,6 +2182,18 @@ config SENSORS_INA3221
>   	  This driver can also be built as a module. If so, the module
>   	  will be called ina3221.
>
> +config SENSORS_SPD5118
> +	tristate "SPD5118 Compliant Temperature Sensors"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for SPD5118 (JEDEC JESD300-5B)
> +	  compliant temperature sensors. Such sensors are found on DDR5 memory
> +	  modules.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called spd5118.
> +
>   config SENSORS_TC74
>   	tristate "Microchip TC74"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e3f25475d1f0..07c593fae9a3 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -207,6 +207,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+=3D smsc47b397.o
>   obj-$(CONFIG_SENSORS_SMSC47M1)	+=3D smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+=3D smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+=3D sparx5-temp.o
> +obj-$(CONFIG_SENSORS_SPD51118)	+=3D spd5118.o

Hi,

thank you for working on this, i am currently testing the driver on my mac=
hine.
I already noticed the kconfig option is wrong, the correct one would be CO=
NFIG_SENSORS_SPD5118.

Thanks,
Armin Wolf

>   obj-$(CONFIG_SENSORS_STTS751)	+=3D stts751.o
>   obj-$(CONFIG_SENSORS_SURFACE_FAN)+=3D surface_fan.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+=3D sy7636a-hwmon.o
> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> new file mode 100644
> index 000000000000..440503d09d13
> --- /dev/null
> +++ b/drivers/hwmon/spd5118.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Jedec 5118 compliant temperature sensors
> + *
> + * Derived from https://github.com/Steve-Tech/SPD5118-DKMS
> + * Originally from T/2 driver at https://t2sde.org/packages/linux
> + *	Copyright (c) 2023 Ren=C3=A9 Rebe, ExactCODE GmbH; Germany.
> + *
> + * Copyright (c) 2024 Guenter Roeck
> + *
> + * Inspired by ee1004.c and jc42.c.
> + *
> + * SPD5118 compliant temperature sensors are typically used on DDR5
> + * memory modules.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +/* Addresses to scan */
> +static const unsigned short normal_i2c[] =3D {
> +	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, I2C_CLIENT_END };
> +
> +/* SPD5118 registers. */
> +#define SPD5118_REG_TYPE		0x00	/* MR0:MR1 */
> +#define SPD5118_REG_REVISION		0x02	/* MR2 */
> +#define SPD5118_REG_VENDOR		0x03	/* MR3:MR4 */
> +#define SPD5118_REG_CAPABILITY		0x05	/* MR5 */
> +#define SPD5118_REG_I2C_LEGACY_MODE	0x0B	/* MR11 */
> +#define SPD5118_REG_TEMP_CLR		0x13	/* MR19 */
> +#define SPD5118_REG_ERROR_CLR		0x14	/* MR20 */
> +#define SPD5118_REG_TEMP_CONFIG		0x1A	/* MR26 */
> +#define SPD5118_REG_TEMP_MAX		0x1c	/* MR28:MR29 */
> +#define SPD5118_REG_TEMP_MIN		0x1e	/* MR30:MR31 */
> +#define SPD5118_REG_TEMP_CRIT		0x20	/* MR32:MR33 */
> +#define SPD5118_REG_TEMP_LCRIT		0x22	/* MR34:MR35 */
> +#define SPD5118_REG_TEMP		0x31	/* MR49:MR50 */
> +#define SPD5118_REG_TEMP_STATUS		0x33	/* MR51 */
> +
> +#define SPD5118_TEMP_STATUS_HIGH	BIT(0)
> +#define SPD5118_TEMP_STATUS_LOW		BIT(1)
> +#define SPD5118_TEMP_STATUS_CRIT	BIT(2)
> +#define SPD5118_TEMP_STATUS_LCRIT	BIT(3)
> +
> +#define SPD5118_CAP_TS_SUPPORT		BIT(1)	/* temperature sensor support */
> +
> +#define SPD5118_TS_DISABLE		BIT(0)	/* temperature sensor disable */
> +
> +/* Temperature unit in millicelsius */
> +#define SPD5118_TEMP_UNIT		(MILLIDEGREE_PER_DEGREE / 4)
> +/* Representable temperature range in millicelsius */
> +#define SPD5118_TEMP_RANGE_MIN		-256000
> +#define SPD5118_TEMP_RANGE_MAX		255750
> +
> +static int spd5118_temp_from_reg(u16 reg)
> +{
> +	int temp =3D sign_extend32(reg >> 2, 10);
> +
> +	return temp * SPD5118_TEMP_UNIT;
> +}
> +
> +static u16 spd5118_temp_to_reg(long temp)
> +{
> +	temp =3D clamp_val(temp, SPD5118_TEMP_RANGE_MIN, SPD5118_TEMP_RANGE_MA=
X);
> +	return (DIV_ROUND_CLOSEST(temp, SPD5118_TEMP_UNIT) & 0x7ff) << 2;
> +}
> +
> +static int spd5118_read_temp(struct regmap *regmap, u32 attr, long *val=
)
> +{
> +	int reg, err;
> +	u8 regval[2];
> +	u16 temp;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg =3D SPD5118_REG_TEMP;
> +		break;
> +	case hwmon_temp_max:
> +		reg =3D SPD5118_REG_TEMP_MAX;
> +		break;
> +	case hwmon_temp_min:
> +		reg =3D SPD5118_REG_TEMP_MIN;
> +		break;
> +	case hwmon_temp_crit:
> +		reg =3D SPD5118_REG_TEMP_CRIT;
> +		break;
> +	case hwmon_temp_lcrit:
> +		reg =3D SPD5118_REG_TEMP_LCRIT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err =3D regmap_bulk_read(regmap, reg, regval, 2);
> +	if (err)
> +		return err;
> +
> +	temp =3D (regval[1] << 8) | regval[0];
> +
> +	*val =3D spd5118_temp_from_reg(temp);
> +	return 0;
> +}
> +
> +static int spd5118_read_alarm(struct regmap *regmap, u32 attr, long *va=
l)
> +{
> +	unsigned int mask, regval;
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_temp_max_alarm:
> +		mask =3D SPD5118_TEMP_STATUS_HIGH;
> +		break;
> +	case hwmon_temp_min_alarm:
> +		mask =3D SPD5118_TEMP_STATUS_LOW;
> +		break;
> +	case hwmon_temp_crit_alarm:
> +		mask =3D SPD5118_TEMP_STATUS_CRIT;
> +		break;
> +	case hwmon_temp_lcrit_alarm:
> +		mask =3D SPD5118_TEMP_STATUS_LCRIT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err =3D regmap_read(regmap, SPD5118_REG_TEMP_STATUS, &regval);
> +	if (err < 0)
> +		return err;
> +	*val =3D !!(regval & mask);
> +	if (*val)
> +		return regmap_write(regmap, SPD5118_REG_TEMP_CLR, mask);
> +	return 0;
> +}
> +
> +static int spd5118_read_enable(struct regmap *regmap, u32 attr, long *v=
al)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_read(regmap, SPD5118_REG_TEMP_CONFIG, &regval);
> +	if (err < 0)
> +		return err;
> +	*val =3D !(regval & SPD5118_TS_DISABLE);
> +	return 0;
> +}
> +
> +static int spd5118_read(struct device *dev, enum hwmon_sensor_types typ=
e,
> +			u32 attr, int channel, long *val)
> +{
> +	struct regmap *regmap =3D dev_get_drvdata(dev);
> +
> +	if (type !=3D hwmon_temp)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_max:
> +	case hwmon_temp_min:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_lcrit:
> +		return spd5118_read_temp(regmap, attr, val);
> +	case hwmon_temp_max_alarm:
> +	case hwmon_temp_min_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_lcrit_alarm:
> +		return spd5118_read_alarm(regmap, attr, val);
> +	case hwmon_temp_enable:
> +		return spd5118_read_enable(regmap, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int spd5118_write_temp(struct regmap *regmap, u32 attr, long val=
)
> +{
> +	u8 regval[2];
> +	u16 temp;
> +	int reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		reg =3D SPD5118_REG_TEMP_MAX;
> +		break;
> +	case hwmon_temp_min:
> +		reg =3D SPD5118_REG_TEMP_MIN;
> +		break;
> +	case hwmon_temp_crit:
> +		reg =3D SPD5118_REG_TEMP_CRIT;
> +		break;
> +	case hwmon_temp_lcrit:
> +		reg =3D SPD5118_REG_TEMP_LCRIT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	temp =3D spd5118_temp_to_reg(val);
> +	regval[0] =3D temp & 0xff;
> +	regval[1] =3D temp >> 8;
> +
> +	return regmap_bulk_write(regmap, reg, regval, 2);
> +}
> +
> +static int spd5118_write_enable(struct regmap *regmap, u32 attr, long v=
al)
> +{
> +	if (val && val !=3D 1)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG,
> +				  SPD5118_TS_DISABLE,
> +				  val ? 0 : SPD5118_TS_DISABLE);
> +}
> +
> +static int spd5118_temp_write(struct regmap *regmap, u32 attr, long val=
)
> +{
> +	switch (attr) {
> +	case hwmon_temp_max:
> +	case hwmon_temp_min:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_lcrit:
> +		return spd5118_write_temp(regmap, attr, val);
> +	case hwmon_temp_enable:
> +		return spd5118_write_enable(regmap, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int spd5118_write(struct device *dev, enum hwmon_sensor_types ty=
pe,
> +			 u32 attr, int channel, long val)
> +{
> +	struct regmap *regmap =3D dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return spd5118_temp_write(regmap, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t spd5118_is_visible(const void *_data, enum hwmon_sensor_=
types type,
> +				  u32 attr, int channel)
> +{
> +	if (type !=3D hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	case hwmon_temp_min:
> +	case hwmon_temp_max:
> +	case hwmon_temp_lcrit:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_enable:
> +		return 0644;
> +	case hwmon_temp_min_alarm:
> +	case hwmon_temp_max_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_lcrit_alarm:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static inline bool spd5118_parity8(u8 w)
> +{
> +	w ^=3D w >> 4;
> +	return (0x6996 >> (w & 0xf)) & 1;
> +}
> +
> +/*
> + * Bank and vendor id are 8-bit fields with seven data bits and odd par=
ity.
> + * Vendor IDs 0 and 0x7f are invalid.
> + * See Jedec standard JEP106BJ for details and a list of assigned vendo=
r IDs.
> + */
> +static bool spd5118_vendor_valid(u8 bank, u8 id)
> +{
> +	if (!spd5118_parity8(bank) || !spd5118_parity8(id))
> +		return false;
> +
> +	id &=3D 0x7f;
> +	return id && id !=3D 0x7f;
> +}
> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int spd5118_detect(struct i2c_client *client, struct i2c_board_i=
nfo *info)
> +{
> +	struct i2c_adapter *adapter =3D client->adapter;
> +	int regval;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
> +	if (regval !=3D 0x5118)
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
> +	if (regval < 0 || !spd5118_vendor_valid(regval & 0xff, regval >> 8))
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_byte_data(client, SPD5118_REG_CAPABILITY);
> +	if (regval < 0)
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
> +	if (regval)
> +		return -ENODEV;
> +	regval =3D i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
> +	if (regval)
> +		return -ENODEV;
> +
> +	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_byte_data(client, SPD5118_REG_REVISION);
> +	if (regval < 0 || (regval & 0xc1))
> +		return -ENODEV;
> +
> +	regval =3D i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CONFIG);
> +	if (regval < 0)
> +		return -ENODEV;
> +	if (regval & ~SPD5118_TS_DISABLE)
> +		return -ENODEV;
> +
> +	strscpy(info->type, "spd5118", I2C_NAME_SIZE);
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *spd5118_info[] =3D {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT |
> +			   HWMON_T_LCRIT | HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_MIN | HWMON_T_MIN_ALARM |
> +			   HWMON_T_MAX | HWMON_T_MAX_ALARM |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_ENABLE),
> +	NULL
> +};
> +
> +static const struct hwmon_ops spd5118_hwmon_ops =3D {
> +	.is_visible =3D spd5118_is_visible,
> +	.read =3D spd5118_read,
> +	.write =3D spd5118_write,
> +};
> +
> +static const struct hwmon_chip_info spd5118_chip_info =3D {
> +	.ops =3D &spd5118_hwmon_ops,
> +	.info =3D spd5118_info,
> +};
> +
> +static bool spd5118_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SPD5118_REG_TEMP_CLR:
> +	case SPD5118_REG_TEMP_CONFIG:
> +	case SPD5118_REG_TEMP_MAX:
> +	case SPD5118_REG_TEMP_MAX + 1:
> +	case SPD5118_REG_TEMP_MIN:
> +	case SPD5118_REG_TEMP_MIN + 1:
> +	case SPD5118_REG_TEMP_CRIT:
> +	case SPD5118_REG_TEMP_CRIT + 1:
> +	case SPD5118_REG_TEMP_LCRIT:
> +	case SPD5118_REG_TEMP_LCRIT + 1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SPD5118_REG_TEMP_CLR:
> +	case SPD5118_REG_ERROR_CLR:
> +	case SPD5118_REG_TEMP:
> +	case SPD5118_REG_TEMP + 1:
> +	case SPD5118_REG_TEMP_STATUS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config spd5118_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D SPD5118_REG_TEMP_STATUS,
> +	.writeable_reg =3D spd5118_writeable_reg,
> +	.volatile_reg =3D spd5118_volatile_reg,
> +	.cache_type =3D REGCACHE_MAPLE,
> +};
> +
> +static int spd5118_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	unsigned int regval, revision, vendor, bank;
> +	struct device *hwmon_dev;
> +	struct regmap *regmap;
> +	int err;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &spd5118_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
> +
> +	err =3D regmap_read(regmap, SPD5118_REG_CAPABILITY, &regval);
> +	if (err)
> +		return err;
> +	if (!(regval & SPD5118_CAP_TS_SUPPORT))
> +		return -ENODEV;
> +
> +	err =3D regmap_read(regmap, SPD5118_REG_REVISION, &revision);
> +	if (err)
> +		return err;
> +
> +	err =3D regmap_read(regmap, SPD5118_REG_VENDOR, &bank);
> +	if (err)
> +		return err;
> +	err =3D regmap_read(regmap, SPD5118_REG_VENDOR + 1, &vendor);
> +	if (err)
> +		return err;
> +	if (!spd5118_vendor_valid(bank, vendor))
> +		return -ENODEV;
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "spd5118",
> +							 regmap, &spd5118_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	/*
> +	 * From JESD300-5B
> +	 *   MR2 bits [5:4]: Major revision, 1..4
> +	 *   MR2 bits [3:1]: Minor revision, 0..8? Probably a typo, assume 1..=
8
> +	 */
> +	dev_info(dev, "DDR5 temperature sensor: vendor 0x%02x:0x%02x revision =
%d.%d\n",
> +		 bank & 0x7f, vendor, ((revision >> 4) & 0x03) + 1, ((revision >> 1) =
& 0x07) + 1);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id spd5118_id[] =3D {
> +	{ "spd5118", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, spd5118_id);
> +
> +static const struct of_device_id spd5118_of_ids[] =3D {
> +	{ .compatible =3D "jedec,spd5118", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, spd5118_of_ids);
> +
> +static struct i2c_driver spd5118_driver =3D {
> +	.class		=3D I2C_CLASS_HWMON,
> +	.driver =3D {
> +		.name	=3D "spd5118",
> +		.of_match_table =3D spd5118_of_ids,
> +	},
> +	.probe		=3D spd5118_probe,
> +	.id_table	=3D spd5118_id,
> +	.detect		=3D spd5118_detect,
> +	.address_list	=3D normal_i2c,
> +};
> +
> +module_i2c_driver(spd5118_driver);
> +
> +MODULE_AUTHOR("Ren=C3=A9 Rebe <rene@exactcode.de>");
> +MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
> +MODULE_DESCRIPTION("SPD 5118 driver");
> +MODULE_LICENSE("GPL");

