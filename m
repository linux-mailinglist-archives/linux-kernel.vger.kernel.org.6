Return-Path: <linux-kernel+bounces-387156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F059B4CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9D61F24677
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213A191473;
	Tue, 29 Oct 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OmpZxEF7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NwJXQOds"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2A1CD2B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213858; cv=none; b=aluukn42FCkj0Lv7q375ZcEuNdZ0wjUuq+jM4IqGjFFkKMgc+2cxDxvCsnA9HzOtHADpVrRRmHV5o8U6/G9zMyVp4jxoxvEWcRIxH1ArPOp/ZyeDd6jk8aHjtVsB/dW4sL1Q4NFepiiITq1gpOjq9+sjeMhOeyXB3GQklQDMZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213858; c=relaxed/simple;
	bh=9PFid10Uv6uAUUyrFZ2/Q8eVIYYcrHe96AR0Ve+7XpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsMzZRvLfyImMZTytL65JRDNP+fIvNMTp0JxZsNZZhHtqu7fOCoWCMMTVMHllpMDqKQdUbza+MzsqMPp4Ta8m5VLrdEWExyrVUAODTOQ6NlRyE6WAJuWZ05p1NIwQ+MYGAjJdcJERBs7v/tY0emW0HgeTRjXWFokt/vIR1exwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OmpZxEF7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NwJXQOds reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730213855; x=1761749855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zg0GIWTJ0gIBdn8bx3R5q/8K4ThtGbMW6yAW6haWnBg=;
  b=OmpZxEF7nb1bQcZ4tEd0twzLCWFcP6eCVAgKg9xusGVg7KH8JiUdne5x
   S2v/FD9ZgbeQzX0NWZ2VrZnEyVXjy7Mzk0l+hgKo1vqp4Bl5y2b0bsltf
   XhMRYFjP73iCq0uiJ84PXV+sRcVEcJmO7FhOwfeRBmIQJOBq8Nhn8OS35
   srbEvK+3SZXtjNUXnlGt5bfUb5DAA1xWjhmXMOxMEFDKVWgJ7U5Y7K6BM
   2eA6pAL5g3dr6cmyR962pdFbzocxpRhxBX0jkKh+OvfhZDU12/KFGXqYW
   7fqgIyj9kgHgbX8kQHCzST0fzi7cJXQWfDAk8neCCwGugTJChvmrGQdIw
   A==;
X-CSE-ConnectionGUID: J+1KD0e5Tpil280W5o0OnA==
X-CSE-MsgGUID: /P/YmSlgS0aH4y/spWe0Fg==
X-IronPort-AV: E=Sophos;i="6.11,241,1725314400"; 
   d="scan'208";a="39739781"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Oct 2024 15:57:26 +0100
X-CheckPoint: {6720F7D6-19-D31EDE1A-D52D6119}
X-MAIL-CPID: 29BC832677B656F5C80FE0DCDCDE5336_5
X-Control-Analysis: str=0001.0A682F21.6720F7EA.0044,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC81D167601;
	Tue, 29 Oct 2024 15:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730213842;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zg0GIWTJ0gIBdn8bx3R5q/8K4ThtGbMW6yAW6haWnBg=;
	b=NwJXQOdsTGo4c2vSDpaWSuQMTn6GA6GD31HGnKODdoiNAJnsKLOLEguB6E7ORDGoc+S5iv
	npo1+ZZ3SqMt7vr6yyfEtxDyK8mXqvwtqTZmjvwKZ6Z9xlnmRfxhPNQiCaDsF223FYn+gK
	F+5p1YEM0TlsygejfpV0AdXsRu+KItqAP1naD8RkcbKh50sJw6PB5aBkMHtzX4OXwbEAOp
	M6nEASrfpaE8VyBM5X/oGgBXmqFAh6JnZOlPzE4dvcPge/0pLamVJUo3MEo7bWgWS/cotG
	h0Tane3By8SrODsNB3RDTh7RHo/3Jmy3KO7aJk8f+hfft2p36B6JzVjNqzz7/A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: wahrenst@gmx.net, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>, alice.guo@oss.nxp.com
Subject: Re: [PATCH v2] soc: imx: Add SoC device register for i.MX9
Date: Tue, 29 Oct 2024 15:57:20 +0100
Message-ID: <12544933.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
References: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Alice,

Am Dienstag, 29. Oktober 2024, 09:34:06 CET schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>=20
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>=20
> Signed-off-by: alice.guo <alice.guo@nxp.com>
> ---
>=20
> Changes for v2:
>  - refine error log print
>=20
>  drivers/soc/imx/Makefile   |   2 +-
>  drivers/soc/imx/soc-imx9.c | 103 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/soc-imx9.c
>=20
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 3ad321ca608a..ca6a5fa1618f 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
>  obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o
>  endif
>  obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
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
> +		goto family;
> +	}
> +
> +	soc_id =3D SOC_ID(res.a1);
> +	rev_major =3D SOC_REV_MAJOR(res.a1);
> +	rev_minor =3D SOC_REV_MINOR(res.a1);
> +
> +	attr->soc_id =3D kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
> +	attr->revision =3D kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
> +
> +	uid127_64 =3D res.a2;
> +	uid63_0 =3D res.a3;
> +	attr->serial_number =3D kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_=
64, uid63_0);
> +
> +	sdev =3D soc_device_register(attr);
> +	if (IS_ERR(sdev)) {
> +		err =3D PTR_ERR(sdev);
> +		goto soc_id;
> +	}
> +
> +	return 0;
> +
> +soc_id:
> +	kfree(attr->soc_id);
> +	kfree(attr->serial_number);
> +	kfree(attr->revision);

Please free the memory in the reverse order of allocation.

Thanks
Alexander

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
> +			pr_err("%s failed to register SoC as a device: %d\n", __func__, ret);
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
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



