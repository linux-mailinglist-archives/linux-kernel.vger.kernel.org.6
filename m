Return-Path: <linux-kernel+bounces-197988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03E8D71A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 21:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A530B21459
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CE154BE0;
	Sat,  1 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iA4I6u5I"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98D107A8;
	Sat,  1 Jun 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717269494; cv=none; b=jw2CmPLhPwO1XfInv77oB5FYeT1TZEz+sFY3J+ckmM6iRnYKB6WkyelgkyHJH01OpyAfmLVbgVa8mReBjDm3+QBXWDkQwtoJ1NQRfZpzUY72M29c+FC3qNbpm6n//LH9awxTmyr9cMwbA5ZKkFOVMYIJivdGTuzwKmAxlps9kPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717269494; c=relaxed/simple;
	bh=KJmg3R0Ejq5hGo+OoeqiAtXID1N3ZKeGgA0vegLiV6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvWKkXFPjgLDvFCP9SfQJ8heYQUL9mWk5N2Vhmgpm2MWoQ8Unndf/R/PU0anNC+yw7R+cI4LkN9kUFuCLoJuthL3RDCfkpauaMa1RwP3Iv8oH4UCfuOkMoM5S27szmE5Tfx/dVznVHJQOCJ9JG5h73ChLWy7jsRPBgab2ygXntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iA4I6u5I; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717269462; x=1717874262; i=w_armin@gmx.de;
	bh=EwMMPVrARQ9WXGXQErzIgsv4r4gEGRtIiO0jfnVAv4c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iA4I6u5ImS4ObLNbLoY24xD4r+k7bP156iJG28cKr68CEKiAcH7omivJAUD/3Swn
	 TCM7Xjjj4mCBOvMO7aWSZ8y1VCD5hhG6735/R06NxVblwIo4jrfOh118gaGZjRSt9
	 xaP5Jtb98wYL3YH1H+OQNyHimtMlEbC73FBP0uScDkMmTChyWlhI6f7E8HXEwKKn8
	 TcleBR/Ax2KRNoLzizkPmEbDKkX6aYw2TfiaefVQHsHBA16tKPfQOBTzSMAXhotSY
	 X89RgNFWtbgqO0a0O0YRD5Z+bBnYves6WXzNNkBfhn3IChiin93pX0X3N7Bn/jkdp
	 o/gJ37jZKotCp3OjoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1srRgn2qzn-00pIZv; Sat, 01
 Jun 2024 21:17:42 +0200
Message-ID: <542eb99a-8299-4673-be52-d9632b923c33@gmx.de>
Date: Sat, 1 Jun 2024 21:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 3/4] hwmon: (spd5118) Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-4-linux@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240531230556.1409532-4-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mySayoKmwhaPp+yaRixYF7avlKZWmLmIcPQ0Cgayw0zEz0RJ31z
 2i3FQFBzr8Ur9f1SMsUEvBocaJHuXDHZ4xtDPmpM9lqLlo/hDLC69cX6HEagi6SgsuWjhpA
 8zmm4fcxDoD5sKHR3V//QOKlt3GOaUs4JDZ7UKVnP4fJ4nLyGIewjfeLF8MdL5t2618tLAf
 01Cpy90us89krU9ZrEYbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8WRd7BSGgbE=;bCpJDtj7FFVFSV4S8yUjiu/Qsp6
 GQyj85n45817/RU5Oj4FRTBKrXWABEUyK5ynY/EnOrAj3QWDPCDzanOYIdgMlq/DXMte4/9cO
 H/iggENSoRxJ15ltZhG5L6OOnNo8hTQ+l1UkLnuE5LcX5iM03hwLcRfThRyo9y+A8TKdAREVh
 ZfKeqXRbq/tbTnUZ1bwFUlG1svc3k0mMZfwqzCTGbE5v8SiMcgMu46WR2pjS6cSpSxmOkF7Qe
 2mN75gjICisJdoWMN1qvVajFyyxQJw4vWQM49UpBa/zV2B0zrx3Kao9U23KQYgNZ5qZ5VBTZV
 f6XCS0LkO9CIS+CIzqQTOz64Zvy9/cEMakDXHGrGuOi6Br63VaksSErZWOnGRteDV4bqALXBB
 7SuuJlbrKcEyAVOfaP6FC4SDi/7CIdivDrvdlw5YGYarI+p7sxC6mgRjpOWMNsS5TWyWsI/7Q
 G4dcipnZIgFGMGYjOI+6nLlFyK1KGFButkeVY2QeHxgAfRjhk2ELRCLb8eyIBnEUBhIwLiUeQ
 7niWzWhvOo5Qq65AC3n4qUPl+hlD8WgrSmS9d9sqZQr2fQShZoi+6gmEV12oJ0hlQmme/cunG
 +Cmy88lqlkRF7ZkO/OoRc7mt57Ur75YvEXS8sxprUtl8HsLCxcIFVkWxFRPc89zAKSs9j8Yf9
 s4a4ttCHj85TZLrDCF4oiZPydScOYoXxOINtNmJpUlsRdozqXPW7i1qCYRvGq7P/hqRVIt055
 qQLK2hqYY0YJpoCOwrhanwDDcBpN0j+MRfQ7YZu+2zX6vwZ3wbe/ysOqCP6PH7sK0h3y2CVaA
 UoNuGppIC8VovAndGCUWOeY5+ZINiog7uMSNd60gcPvZ0=

Am 01.06.24 um 01:05 schrieb Guenter Roeck:

> Add suspend/resume support to ensure that limit and configuration
> registers are updated and synchronized after a suspend/resume cycle.

Hi,

it seems that 6.10.0-rc1 cannot suspend/resume on my machine. Kernel 6.9.1=
 however
can successfully enter and leave S3 and S4, so i tested the driver on this=
 kernel
version.

In both cases, the driver was successfully preserving the settings, so:

Tested-by: Armin Wolf <W_Armin@gmx.de>

> Cc: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: No change
>
> v2: New patch
>
> RFT: I tested the patch through a suspend/resume cycle, and it seems
>       to work, but I am not sure if that had any effect because,
>       after all, the memory is still active during suspend/resume.
>       I was unable to test a hibernation cycle with my system.
>
>   drivers/hwmon/spd5118.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> index d3fc0ae17743..baa315172298 100644
> --- a/drivers/hwmon/spd5118.c
> +++ b/drivers/hwmon/spd5118.c
> @@ -20,6 +20,7 @@
>   #include <linux/i2c.h>
>   #include <linux/hwmon.h>
>   #include <linux/module.h>
> +#include <linux/pm.h>
>   #include <linux/regmap.h>
>   #include <linux/units.h>
>
> @@ -432,6 +433,8 @@ static int spd5118_probe(struct i2c_client *client)
>   	if (!spd5118_vendor_valid(bank, vendor))
>   		return -ENODEV;
>
> +	dev_set_drvdata(dev, regmap);
> +
>   	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "spd5118",
>   							 regmap, &spd5118_chip_info,
>   							 NULL);
> @@ -449,6 +452,31 @@ static int spd5118_probe(struct i2c_client *client)
>   	return 0;
>   }
>
> +static int spd5118_suspend(struct device *dev)
> +{
> +	struct regmap *regmap =3D dev_get_drvdata(dev);
> +
> +	regcache_cache_bypass(regmap, true);
> +	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE=
,
> +			   SPD5118_TS_DISABLE);
> +	regcache_cache_bypass(regmap, false);
> +
> +	regcache_cache_only(regmap, true);
> +	regcache_mark_dirty(regmap);
> +
> +	return 0;
> +}
> +
> +static int spd5118_resume(struct device *dev)
> +{
> +	struct regmap *regmap =3D dev_get_drvdata(dev);
> +
> +	regcache_cache_only(regmap, false);
> +	return regcache_sync(regmap);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, spd511=
8_resume);
> +
>   static const struct i2c_device_id spd5118_id[] =3D {
>   	{ "spd5118", 0 },
>   	{ }
> @@ -466,6 +494,7 @@ static struct i2c_driver spd5118_driver =3D {
>   	.driver =3D {
>   		.name	=3D "spd5118",
>   		.of_match_table =3D spd5118_of_ids,
> +		.pm =3D pm_sleep_ptr(&spd5118_pm_ops),
>   	},
>   	.probe		=3D spd5118_probe,
>   	.id_table	=3D spd5118_id,

