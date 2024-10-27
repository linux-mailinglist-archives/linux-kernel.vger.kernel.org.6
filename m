Return-Path: <linux-kernel+bounces-383694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2A9B1F2D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B452817DF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A917279E;
	Sun, 27 Oct 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KTXw6Vqo"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35F2570;
	Sun, 27 Oct 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730045385; cv=none; b=DCLsjPCG1BsXQSTMLn+4XfYET1d9IID8qu1FSRBkPWNvXae1POZtAPl4fYGScsseFp1JklN6NvFARKDiL7i4AoQs3+WsIjc6eKQTS2iT0T0Y2H/T05gzAO2IgCZohUL3pKLY3iskfBpch++c/ySyR2Db+Vx3xzGT+9GwXKyJqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730045385; c=relaxed/simple;
	bh=AaPU9tcS+fBbu8IfyYbDwrKXzQUMCDGYYgyCYWt7ZRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC2lpKHdRDLM5wTVCyVNBH6lFx7nFIvilPqzwaD4e+FtJy5G7a4ORd0bebNTO/DSWr0aWg/sQt0TOl+1R+Hq3h1pKQdaT0zfoPeLx8IHAY+sW44HRMqzIhjoABDvBam2GPHdoFjKTB8Z93NO9I5OL1YRfUeFlIXriO/Pms+8zeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KTXw6Vqo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730045366; x=1730650166; i=wahrenst@gmx.net;
	bh=P4sc1ZKQ0Pwmu3U7pr1eqvwAGQj//URq6GmindE1cA0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KTXw6Vqoml5RYS1IDDO9sUQlSbtD2O2UcBj4f+v3w/9IoNWvJY+FwSbLCc5Vd3X+
	 zk/xHxZD16rnEGIh7IcHBBz/28gmdkApv7CtaXupKozzngUKZiga2R/M0wqLxDSVB
	 UZFMrdWOA5VikFlzsJ83ZVOSdla54+Sg8gpDKnoFrTJb6eUIey7SJZCZm0TvdzssE
	 uszFJdyn4OOL2JofmQsHOkDOmQ5Euz6PN3EVnxZK83t93TiiT6JEC79wDJFZZuUKM
	 5Qo7N28wGV/z0O1NnZd7YU+WLfWygvguToGfzs4ZOntPbsLzLUqzloo/my9xNBKRY
	 3M80fDP/lQaRXPQv1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1tzEhu12Oa-011pHo; Sun, 27
 Oct 2024 17:09:26 +0100
Message-ID: <492d5691-661d-4dc7-891c-b515ecdd35da@gmx.net>
Date: Sun, 27 Oct 2024 17:09:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241027112557.3866257-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241027112557.3866257-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MD+CMwNShX6wVY/fNeDX7wyp+/clf3CDQ6bfYt7gLl6AMMg2E8r
 C9Id/du/M99gWadJ0P97HZGnP87MiUttXqLTIkJWX4Wd0A8WBAHqoWJP6Uyn8jJEJ5OnRTJ
 Qsp6oIxKe9TfZzNbXtaVR7fep63RbJjnGKnuoKamPksKVaAwpoXrQjK1OBi4jhBCW5La4Lx
 F9G3YPB+/cowL+7fHg49w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+aIhF67vFyk=;8xUBFUp4Ykxl5GRrk9Ms2WiFYpT
 ApsEwg+iWw8mjvyOglb5laNvVQFD0jWbTYvyJ9AmkGcXyFVWXf3Sxva+ZV0bWSQNyhIXNVAbT
 7vhHID2Srr5LA7LvBqcxtusByptIMfV3fwQkHqXdrkQ7E+uLj3K7/T4yYCRzABZDqa2Vc6+La
 NCBbhiaw1nE3otPruVnBZDeDwfzF3FXO1JXHujcm5kz3gJ9gqNtQSqqDY1yTXPPrM283PCsRS
 E6xf8kK6Vjr/iHsMWtN0xZl1TMp4PF1+Nj77HmHbbE1A2TbYnPABBmpEYKrR4Meojuw1vbOvM
 2Sq1IgjUHG0dghIKDX8zHXNbuWMoDOAqXcLDLqMZEbj4Vz/990w6wvpjavcyXcHXCMqaFWayp
 o9utVKKF5d9Y3d+2HD52tsnXmK1R8aF8Dvg4bM8rn/VeZDojoFxhAazGnd6MCLjFvJOj5iz2u
 2hlwGiN2NiUjURpA2uyfy4yYafGvC4T2vzHkAhVW9UKxDGN5slcQ6HZBH2MLcKgeNbmY0KnuA
 NVW5uDRsFTPDtrFD6nJhqSSMNZ59lAv0lzW1ASk0b+3hE+moARLGpo4q3Xm8bfgGZMVeeYRyj
 o/TYJJG3n/Hpq2q0er3AfeGdFU5HidrVWnaAZEwel4Dq25/D4G6HYYUiNZUiWWZ9H7C4dTh4J
 xIkw7QhIfrhrtL2VA5ll6cOPlkdCTXfVaHZDo+wqPUBxRpP8jTn3cs+h5FDhNW3jag3nzQeq+
 vOJxG3o2dXpjldfGjJLPKvtREucnCMe/taX04THiZGD74NsEucAGmA+Kn3/6bQdO50CuQfnkk
 GxPvmFM0BfJ8hpSjDziIoVWA==

Hi Alice,

Am 27.10.24 um 12:25 schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>
> Signed-off-by: alice.guo <alice.guo@nxp.com>
> ---
>   drivers/soc/imx/Makefile   |   2 +-
>   drivers/soc/imx/soc-imx9.c | 102 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 103 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/imx/soc-imx9.c
>
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 3ad321ca608a..ca6a5fa1618f 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
>   obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o
>   endif
>   obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> -obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o
> +obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o soc-imx9.o
> diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
> new file mode 100644
> index 000000000000..7e8a8b2efa61
> --- /dev/null
> +++ b/drivers/soc/imx/soc-imx9.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define IMX_SIP_GET_SOC_INFO	0xc2000006
> +#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
> +#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
> +#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
> +
> +static int imx9_soc_device_register(void)
> +{
> +	struct soc_device_attribute *attr;
> +	struct arm_smccc_res res;
> +	struct soc_device *sdev;
> +	u32 soc_id, rev_major, rev_minor;
> +	u64 uid127_64, uid63_0;
> +	int err;
> +
> +	attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	err =3D of_property_read_string(of_root, "model", &attr->machine);
> +	if (err) {
> +		err =3D -EINVAL;
> +		goto attr;
> +	}
> +
> +	attr->family =3D kasprintf(GFP_KERNEL, "Freescale i.MX");
> +
> +	/*
> +	 * Retrieve the soc id, rev & uid info:
> +	 * res.a1[31:16]: soc revision;
> +	 * res.a1[15:0]: soc id;
> +	 * res.a2: uid[127:64];
> +	 * res.a3: uid[63:0];
> +	 */
> +	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 !=3D SMCCC_RET_SUCCESS) {
> +		err =3D -EINVAL;
> +		goto family;
Please see my comment below. Does it make sense to print the value of
res.a0?

I stumbled above this recently on a i.MX93 board with a vendor kernel
6.6.23 and the firmware hadn't it implemented.
> +	}
> +
> +	soc_id =3D SOC_ID(res.a1);
> +	rev_major =3D SOC_REV_MAJOR(res.a1);
> +	rev_minor =3D SOC_REV_MINOR(res.a1);
> +
> +	attr->soc_id =3D kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
> +	attr->revision =3D kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor=
);
> +
> +	uid127_64 =3D res.a2;
> +	uid63_0 =3D res.a3;
> +	attr->serial_number =3D kasprintf(GFP_KERNEL, "%016llx%016llx", uid127=
_64, uid63_0);
> +
> +	sdev =3D soc_device_register(attr);
> +	if (IS_ERR(sdev)) {
> +		err =3D -ENODEV;
> +		goto soc_id;
> +	}
> +
> +	return 0;
> +
> +soc_id:
> +	kfree(attr->soc_id);
> +	kfree(attr->serial_number);
> +	kfree(attr->revision);
> +family:
> +	kfree(attr->family);
> +attr:
> +	kfree(attr);
> +	return err;
> +}
> +
> +static int __init imx9_soc_init(void)
> +{
> +	int ret =3D 0;
> +
> +	if (of_machine_is_compatible("fsl,imx91") ||
> +		of_machine_is_compatible("fsl,imx93") ||
> +		of_machine_is_compatible("fsl,imx95")) {
> +		ret =3D imx9_soc_device_register();
> +		if (ret) {
> +			pr_err("%s: imx9_soc_device_register returned %d\n", __func__, ret);
Can we please have these kernel logs within imx9_soc_device_register()?

Btw we could print the real return code of the function which failed.

Thanks
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +device_initcall(imx9_soc_init);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP i.MX9 SoC");
> +MODULE_LICENSE("GPL");


