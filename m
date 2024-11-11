Return-Path: <linux-kernel+bounces-404451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014269C43DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858121F21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8E1AA1C3;
	Mon, 11 Nov 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CYJ2oACd"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F71A76D4;
	Mon, 11 Nov 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346708; cv=none; b=ouC7CQq6/homia4XXsdKZfcXOgarm6lupCsy1nVHGRKaB12BjyRT/0XCOQtHmgLWddvC1mbjYA08HsaNIhpd4FUp/oXdpil/7/MeFxNIOxHzCEJ0uKV4FB9CNpzhMJcZemaaIWZ2QEVX3p4Ni81qmSXLWuT6EzFDg3xEl/5ujpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346708; c=relaxed/simple;
	bh=xxes8ZYVvfrk64X89XxSM8W9LIlOo1LuHzAFIPYNyLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk+1agfOQBMGqmDPq3uFOGfoidwanZYSeJpkTAyjx+uf7B1vM3ORcXRB9RlYQpkMKxjfmkATAJt6OiUeZTrCeeSyEPJ7C8CchUlw4lvjmSH42/ZcsV0C25iF0vyYRRjy15ZZnR77YU/v4MnO22N9Q5L+yLzjMe9aTdM7B//fY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CYJ2oACd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731346689; x=1731951489; i=wahrenst@gmx.net;
	bh=6OSw8xUt3COc/0od6QRSNQ+KToWY8URRRE3wwtW0ph0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CYJ2oACdo/j4zgm110Rm9RRALPBYpjL9AU8iQldZplnBAdNAWaEFRBEXrxB4fKB8
	 NNKOPnYjXSz/DJvfihJ245N/PZE10rbB9T1DqgMafxmoGaIBCSMgiIJTvkL6KAUlg
	 WEkVCROQ6/OmEqnxrePBJOySPCSF5ZqZyVdkCRBN3QGGVBhD0tu/vxHUUokrpIca4
	 kk9WbKB7EGysubNRir4bPbzDjigy/qst6CfpYRIecnbX8ACuZ3hqKwx14WGTAjNFN
	 gsqD2tj+PLI0kJ22fHb9Izv+NB62rB5kGKdAwFheApuRLvwMpnvNBLDsHtrHFkGxj
	 f6ouG7psmwA7hCVXXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1u4BUV0p02-00svqL; Mon, 11
 Nov 2024 18:38:09 +0100
Message-ID: <eed25785-7972-43ce-9903-d8350e51ff7e@gmx.net>
Date: Mon, 11 Nov 2024 18:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com
Cc: imx@lists.linux.dev, s.hauer@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>,
 alexander.stein@ew.tq-group.com, kernel@pengutronix.de
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241111032307.144733-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dDNJzKU6qVuVwcuDn4e8a77d+91AdGDxjZ4AID7/NRDufgd9egR
 /B+Bg8xSjkSE62HryDFEqI3N7NjN0j1i4Czvw75+6HHzlNcsuvSoOxrCBo0sxUA1Mla/7rj
 RwYpx+suhsQfsNsf+Cwbck56IQdN3iaaw6w8fsSKgArEe8kxJJNXxt4SSnlhdmDEM/z2mcT
 h/UbA1kCYa7zv0jgB8BhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QtLGtceA+KQ=;4SM/hF+VxEnePS0VaBqjz2ONwmi
 LX7/TaksXGo7IUXWEhjmsr42Ah8300Wjs5w5KCbPRynad8jYgDOQjX8JbwVVnmZxHyTncY3bp
 EPUr7rMZVfSfKzvD/hvta5R8RmrYyGpl+irCNiJF1rfUP3mmb11RcqeqTiJ+FA5m4ksO88Joq
 6EWKzeTD4MXVgdXBnZ6eM1Kk536vMQacqmW2rtcyS6Ryt+uorgOH5lQjDyy06km9dNqDAHSRf
 1zDUSjSXwpuz6SD3gjrJqRInBF+1QJTOy6ZT1qGsdV1dCU+tMVLBwlEFzKvuq0mcnSysjeHMP
 QPW67+aw6WcWsQN45WV92guF180spiQwnXfKFPrMONX7I1g5V6Q8IazfYV1sSkvrP6dAptpBk
 HGWp3ZM/I9PZmTMfNhZL79UsNTx1r6BWRbSrn4DkzMl0a2GrFx3JyzZprZWFU+sFweWqyGyaI
 lXncnhcLkcDqcHCbfQ/w5D1CcDzDU3Q9S5AJZjuGvtJxiN81O25NsLCUgybuRHVsTgvKu5Nut
 bgjtFm6o1qNhs6q4yMJEOgjakl3rHcYzb8vudyveBgLdOYJCvmIQsfRoPCbNzd+rV3+fwCetx
 SRkdhe93OXqI177np2T0BoCEINxAFIOvhFwT7uEV6XWIowOqFbN4coTe8yMIgiLdOgMGM2/Dg
 pTNUFLUb1SfvUQMVUYlofmSpjXKqOPl97sOIpcYJWGRC5nd9DwnACfebwK7Fjur6VbgLDpfjx
 J7c64IKRDKPGxp6tzmr44toFwf55DLc3n6aNuiel3Froc7/JK6OaLX+0QPiix1UIWDq1njTdZ
 l4GAUcE/iev/8UuV+VpIvx1aQbm/NHHFlAEb6aXmk8rpTK/y0iYGT5p1xaziyj7llxM8A0V37
 qZszukPk9+9rbnLQUiLIQ0KghIucWQnzCVpuovK02GOBrg96mirh01M8f

Hi Alice,

Am 11.11.24 um 04:23 schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>
> Changes for v2:
>   - refine error log print
> Changes for v3:
>   - return -EINVAL when arm_smccc_smc failed
>   - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __fun=
c__, res.a0);
>   - drop the pr_err in imx9_soc_init
>   - free the memory in the reverse order of allocation
>   - use of_match_node instead of of_machine_is_compatible
> Changes for v4:
>   - fix the build warning: 'imx9_soc_match' defined but not used [-Wunus=
ed-const-variable=3D]
>   - add Tested-by and Reviewed-by
> Changes for v5:
>   - probe imx9 soc driver as a platform driver
>
>   drivers/soc/imx/Makefile   |   2 +-
>   drivers/soc/imx/soc-imx9.c | 124 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+), 1 deletion(-)
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
> index 000000000000..4ef92260e8f9
> --- /dev/null
> +++ b/drivers/soc/imx/soc-imx9.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define IMX_SIP_GET_SOC_INFO	0xc2000006
> +#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
> +#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
> +#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
> +
> +static int imx9_soc_probe(struct platform_device *pdev)
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
> +		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
> +		err =3D -EINVAL;
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
> +		pr_err("%s failed to register SoC as a device: %d\n", __func__, err);
> +		goto serial_number;
> +	}
> +
> +	return 0;
> +
> +serial_number:
> +	kfree(attr->serial_number);
> +	kfree(attr->revision);
> +	kfree(attr->soc_id);
> +family:
> +	kfree(attr->family);
> +attr:
> +	kfree(attr);
> +	return err;
> +}
> +
> +static __maybe_unused const struct of_device_id imx9_soc_match[] =3D {
In case everything is correct, "__maybe_unused" can be dropped
> +	{ .compatible =3D "fsl,imx93", },
> +	{ .compatible =3D "fsl,imx95", },
> +	{ }
> +};
MODULE_DEVICE_TABLE is missing
> +
> +static struct platform_driver imx9_soc_driver =3D {
> +	.probe =3D imx9_soc_probe,
> +	.driver.name =3D "imx9-soc",
.of_match_table is missing
> +};
> +
> +static int __init imx9_soc_init(void)
> +{
> +	int ret;
> +	struct platform_device *pdev;
> +
> +	/* No match means it is not an i.MX 9 series SoC, do nothing. */
> +	if (!of_match_node(imx9_soc_match, of_root))
> +		return 0;
> +
> +	ret =3D platform_driver_register(&imx9_soc_driver);
> +	if (ret) {
> +		pr_err("failed to register imx9_soc platform driver: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pdev =3D platform_device_register_simple("imx9-soc", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register imx9_soc platform device: %ld\n", PTR_ERR(=
pdev));
> +		platform_driver_unregister(&imx9_soc_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
 From my understand all these stuff belongs in the probe function now,
so maybe the existing one should be renamed.
> +device_initcall(imx9_soc_init);
I think this should be replace by

module_platform_driver(imx9_soc_driver);

Regards
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP i.MX9 SoC");
> +MODULE_LICENSE("GPL");


