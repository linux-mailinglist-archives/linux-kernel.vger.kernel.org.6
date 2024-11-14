Return-Path: <linux-kernel+bounces-409751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9939C90F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA0928201D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463418C010;
	Thu, 14 Nov 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="aKH1AkZv"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B0262A3;
	Thu, 14 Nov 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605988; cv=none; b=AVuSspQxVMqFUSjV+6hHgxFz5C+8suqxNjIyv8w+7WmJ96xf93A4guzM+TZzoyDo4PfNNpQZ80D+zpAKWxV2xpfmX0Kb0QTx8nd4cZ8vJwz59srk21pGFGQGqMzfV6Xr796s9kx5PzqBb/w3Sweq/MVyJ1tWvjPYdX/nneUm5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605988; c=relaxed/simple;
	bh=LY1ej1vw3fIzR3cAO2ctNDFKI5g/jCoGlcy7UtLDXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8rgyVO2/crYdAYWU6Nq58I6Akm7VQzXbupVZfDzXpJmEzKlud+mycocLf3wBkQw0iBjqSI/+KwX85+UwvaJxG0ZMIObJxpt2RQa8J3bltPlZFwUKuQXfF1pc6mwxVe7nJ7i8xRx0S1AUps4tXaYvMEvQlkrQBEDWOJOzFsP38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=aKH1AkZv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731605971; x=1732210771; i=wahrenst@gmx.net;
	bh=QVyaKxFQo0Kexw7pAfdHq+ncZpVV9gGVzi64IeD5HVw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aKH1AkZv4GuaaruAM8sKJc4etq6PuUvjZEofA3B/hGGXlFQksaasy9nGczpEYr8m
	 De8mvNn0Qw8fcPlYqP/qHSN9zmC6xkLi+TIjkMtfNkuRHRBHIDivrJ8E5RfFHHAdu
	 Lqa1kUy33z+hNLsUTnllHXwkF1xfjUPUfQFN+1JlfRO3dNRy4UWVUqEKA3Jvr/5YK
	 s9oio+l07opu+DkSw6jxwDv5yh29yhcesW/V14upUTKdmx20j0W9WcFYNqRF2GF8G
	 P35YajvpMF8kCpvsPYgkW1UP0aFfZb3Xz+PTPxKLARxHgc9Kndvnl886pE7yFzEcA
	 +EadB2MDw8fDPgHg0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1tzKYR1Xgq-010Om6; Thu, 14
 Nov 2024 18:39:31 +0100
Message-ID: <4c157893-ceba-4a6a-a860-182af5f08c5f@gmx.net>
Date: Thu, 14 Nov 2024 18:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, alexander.stein@ew.tq-group.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241111032307.144733-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWx//gh6D80b94XAjSQH6K7k2iTU+lf7hW09THpVA0oyHpePheO
 OWblZo9UujBnxMeitHWu+Kp0PdSSRhNm+362P/8b+gBDGQxvje5FPWC5IutnRPVgRx2lUoY
 wEMuVInYLPTMVMsSFMOvkJ6TdCFjOaapBbB0G1hIej20NU7mgMqPv91IEMrUodN8zADnzRp
 AB0eUZ3/4g/Ssn9kT0K7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J5ap3uADCfA=;ET7q+/xSlZQGYeUqoSGP+iApWXy
 21TUSkvaNEqAG0R31qz/KshsqnfjHuVvh0UZOS+45OroAstuk3kVTVK7KiSZ5kE/Q3CdFhwrv
 yu3vN80qn10GxQ7b0GyM7D2QzPmv8JmgNAxNq8Sb+zvKdxZi3rg+Bdl/D3FbrLKIFch0iLmcP
 KB9laSsqdxtmt5X+clIa8O5Jl7IIs8cynDNwphhYY1ewcWt+3QPSr6vlHvPIhNlM6PKVyhVLX
 fV7OtuEAd36oDnRu57fHPu5wL3aF6Dyxc7FWFrfXSZ/pXn52xr5X63eKU89/lqukWqI6DSATG
 KihEcHMfs3NMZm/2nfArp6fqRsKyYOv7zc9yXNoB4cee2bUnO8GEs0hkyh+c+P6ypJbozWfc6
 XLJsFhHvJN/8Vr48nB8yQpsq/3P6bU6Hb5oxwb1sGTfV2C3urW+xIQ+wKGygUmQiTfxZoXoUq
 t11jpLn+5Q7wFHsbW4QbiEhDspFFhNRNopGVPgj6AadR7AX4Y4roGwu+60CENz+VZKgM5EOd1
 5wPtYVLqL2j6qBUA3CQKImZ7J8dGcm7Ojsf46GCxwq7kGi5gcUjuoTTEcyDAqJ+e2Or1CoF7b
 mHjRjYJpyNNuC927sfyZPsIDKYoC/THwz7NFsdrKUsmfpsDN7JmpD+9AZINXRcRGAcesRjWUq
 H2ep1Xzp6/thKJr4nQ4PT6ktA70Yj+ZgHyosVYQSr7J744XF469qNXtco6GRcIDXQZdW9MVVO
 2SxvLduCEOIZv62i9hahsL84yAaPYAKGyE08pRj6+XElwtcDWC/K53QlShIzycpwjre6J/sn4
 DYVRq57nW27iBfHYh25DJACWPveqcT8Uph7kjGG2QeaiddarkTe4IgSsB4yBlwGuhL3wBk0c7
 nkhA7nConmaKf8FwiULcCOp7KUCL2rWbzgHKQAv8WjTpsyhw0yb8BbBGt

Hi Alice,

these are the new comments

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
I like it that soc-imx8m.c handles the corner case
CONFIG_HAVE_ARM_SMCCC=3Dn in order to increase build coverage.

Is it possible to adapt this driver accordingly?
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
> +	{ .compatible =3D "fsl,imx93", },
> +	{ .compatible =3D "fsl,imx95", },
> +	{ }
> +};
> +
> +static struct platform_driver imx9_soc_driver =3D {
> +	.probe =3D imx9_soc_probe,
> +	.driver.name =3D "imx9-soc",
Just a nit:

.driver =3D {
 =C2=A0=C2=A0=C2=A0 .name =3D "imx9-soc",
},

This makes it easier to extend later. Maybe we can use a define also for
"imx9-soc" and use it
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
here too

Regards
> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register imx9_soc platform device: %ld\n", PTR_ERR(=
pdev));
> +		platform_driver_unregister(&imx9_soc_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(imx9_soc_init);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP i.MX9 SoC");
> +MODULE_LICENSE("GPL");


