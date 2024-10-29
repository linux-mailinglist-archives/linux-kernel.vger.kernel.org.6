Return-Path: <linux-kernel+bounces-386581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A39B4564
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B11E1F22C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792D20403E;
	Tue, 29 Oct 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="duCfu6Gf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65744204036;
	Tue, 29 Oct 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193200; cv=none; b=pwezhrR/0ImcosWaEYTPwQq5FIjWY7rGX48mkMtwQuQ5lBruBBQDZOXx+2cZ/i0mPW1jAZplX0US0PBEW/dWF+rtLFDlgAVXBaOyoLxA7Ya1q40R4Qz+iriDrsqvyoFjltSbszZayBlY+oXoei7vIHj6ypZssal7Vh0BwPGiDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193200; c=relaxed/simple;
	bh=ZV9FZQ/FRGNceUqvRSyK4M/UBt7LMq5R3lf/jpr2v10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFRPGvLGSkhfSS+rKYDILTUh2G5A/MIRFx0yrtrioJq9e3UbEPDgKyQf/gkkkm32X588qW4VzmznEKlYiNIOBHAzY79T5p8BfLQVGatu9gxzKV049dWqF11QISIVz7LqsuX1/bNHBPQXs8P1kCVBgczwgYXy0PEj5GHR/3HwbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=duCfu6Gf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730193182; x=1730797982; i=wahrenst@gmx.net;
	bh=UdHybwxJHfIWWeB1x52ApmSTqen0m8Kxqryhs4Fqv4A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=duCfu6Gfqx+34r3pyTqsQqywfu13oudJVvlm36ekCORHWA4Qu3ZYo4OjeAPLU+Df
	 DC1p4BoFvgRI829gfbrX+tr0dTIcVcbtaaZ3mq7qJBcx4k8zwS2VYbBEYjKTfArlJ
	 TfLSfC3NC4ZqKHcpWVZgqt4xFJMy6uJ3IW8UrIZdyBCUGCy7vhrvAY4iNFNne2WcM
	 2vhSDuRAI2CmXN097rYUoc3FYKpJicHhdtihe0Qn57GENh45JujFNap2gr44WxRTf
	 H4U/w6Tn7zLWM5etss7psCFWEwxDkvcD6wjtTpBGPoSvoPrepkj7Y+iQxdnchgVW/
	 T6tiPN+eT8b5WIWHvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1tvKT41OZg-00zcQ5; Tue, 29
 Oct 2024 10:13:02 +0100
Message-ID: <30bd4862-daa9-41bb-95dc-990ea462dc95@gmx.net>
Date: Tue, 29 Oct 2024 10:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:47lZj0L2HimalgwtdkzW8j/307ghRkB+c6p1VmAszfCxoXW1k7m
 +vXl+4d5OqAz92YgmOpiPs7FDVYiRPvc/12AZbKjtygEaZgh4w4Iv/xGH8UiY8sO3jRXZoX
 /uwcPIjqFLaeaz9W1A3Kj7Vxkej07z1DmT0A8xh6/XEz7bmz5xkQ53x8TROrIjtOYbAAOcV
 b7ZMVs8zDAJM+r943s9Hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nrNEsX5f0I8=;8y1FJ4HfOGy/tAv5yhc6qIYJ3rt
 Ef4fSVxvAVFsN3Map/PVaK3jv4brMUHLuD5KB9KK3JtqUteePoXuoKD1Xy+TJzn4xT3zHRltx
 D1Uj6z8dxBjv+jwNDq1m7Ro5UZO5mUEUwfFX2773gjs40WQ5AqL0mVxDFhgxNzvlHE0l0hN8g
 gcoZSvNwcQ9/pDb9StwWbaB8xSwIPFrDJibqw5CwotoWyDT9o4M4YPXJcnFUyeG7tk87a/qbI
 ZQv22l4Mfb5TbzokejA54PIOa1rljoVkzk4dmNAFfrVBAmSMNv490CxNAtlx1y44pCKvaD1E1
 DI3FBvGHvAmoE4EvgmPUo/1hhJZLf4Fm+AsOFe8VcNbvtaP+2f4AoT/2zajo3Otz8Iun6uhQd
 QFiBWy537W/G/49R4dIZxxt3diz75h5Xc36Gsif4TBy4K4k6hCkw9whEyltAV7Hmu3MuriFho
 /PKjq8TsSnftWVUCdbLu0aP9dOBMYStAM6Iy+y8JnpNN8wSMA27L/oYeyc9UUq/BY56+9E788
 oKFiz+v9wdKV8EOFZ+/S9T+UEpN3LyrP6DsresvFyDB+hB1HtGFLGQ0VXo+9/ZGpveUjU4Uwq
 Uvpja5ECBlzkNmtjEUatpbfjP2ZzQS1ejb3csBjt8IAgaC5X2mYcoSveGUbPt0XesLyudj1dU
 SRQBr8br83lwAx1nJw80PvNhHGxZrNnfYoNFjJT6cjASgzgZwXFH4E0vFO5f1RHJ49UeekIY4
 9lOu0Q7MqW+PA+NwGGf4KZhLMbADea7XpswQUAkcvl/dN1UeoRUsKvLsos83TPaBtNYfPNuWw
 nAS+IgD/P1QT5Hv7aqEuNXwA==

Hi Alice,

Am 29.10.24 um 09:34 schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>
> Signed-off-by: alice.guo <alice.guo@nxp.com>
> ---
>
> Changes for v2:
>   - refine error log print
>
>   drivers/soc/imx/Makefile   |   2 +-
>   drivers/soc/imx/soc-imx9.c | 103 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 104 insertions(+), 1 deletion(-)
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
> index 000000000000..0722e69110f9
> --- /dev/null
> +++ b/drivers/soc/imx/soc-imx9.c
> @@ -0,0 +1,103 @@
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
> +		pr_err("%s: missing model property: %d\n", __func__, err);
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
> +		pr_err("%s: SMC failed: %d\n", __func__, res.a0);
> +		err =3D res.a0;
The pr_err() looks good to me. But in this specific case, I would stick
with assigning -EINVAL to err, because the SMCCC_RET.. codes are
completely different from Linux. I wasn't clear about that in my last
comment.
> +		goto family;
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
> +		err =3D PTR_ERR(sdev);
pr_err("%s: failed to register SoC as a device: %d\n", __func__, err);

After that we can drop the pr_err() in imx9_soc_init() and avoid
unnecessary error logs.
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
> +			pr_err("%s failed to register SoC as a device: %d\n", __func__, ret)=
;
> +			return ret;
> +		}
After dropping the pr_err we can get the rid of the complete condition
for ret.

Thanks
> +	}
> +
> +	return ret;
> +}
> +device_initcall(imx9_soc_init);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP i.MX9 SoC");
> +MODULE_LICENSE("GPL");


