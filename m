Return-Path: <linux-kernel+bounces-388633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4F9B6259
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F291F21B83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FC41E6DEE;
	Wed, 30 Oct 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="cSmHCIOU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65C53370;
	Wed, 30 Oct 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289242; cv=none; b=KlfO5Q1N4FxQXMX/w6xd1LSCVhO+zxamKB+ozT5gI/0kewldDyFVZ+YeJtuFUYqsKtdJuEdfDrrGXgP0KFTUPiU73Yoys01NpCFDTPQoclbSOOXr51er10gzoPMDTgufounUi73LalLVo2teTcltupyjZePAEfahy3WWlVpL2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289242; c=relaxed/simple;
	bh=ILLcoEoTLUm3cTHoGIXKplpQxL+l5de/PTN9J5SNpWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVc2o3xb8AhYr2/agydnJjaoRpuLhv3tQfjR7vvF9bEeQoglmB4TSvPotcXafIDW5yq8lR1QJ2Ym7ml5jfyFJKpjV8vIkbZW1w4OO+60UOW+xLkOleo+KEcCxiPmjbezdXEDl/c8e1w/ARwHG3ehWZKi/M9LMUB5S8bPsOBQFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=cSmHCIOU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730289219; x=1730894019; i=wahrenst@gmx.net;
	bh=MWgQKaEJsBWQZzZRi7igT98SmnXpUOoVlYgKJAFqdSY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cSmHCIOUCj++5LC7QhLejuOpztGP6jWT/gxtBDFUumvabHlm/Y2gG+Hd2jd4/Q62
	 qxVsIyOj3++GVRcY9V2sDz6ym16Vr9wgLUt/QTvuIEuTGXSVjs6LzAJSQjxBElRKI
	 THUuTv4B5ZPER87my1uGE9U8vuCc1y3LEY3HrMG/iMCE4tFFSuoZS24pwJfZNfguI
	 AYyh2af6sgy+LhKtkxZI9WwTFRYs1HWwURffRMUbLiRbrSAkdXvG8IOTk0XMKmnIZ
	 rFEyTcxBiAFWFSzndp9KfqIc76gvSNPo1BegWudSLbGTNxeLK3Pv5+vPnD55Ezzg1
	 gMf285AT9i4RsM8kGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1tNmdv1jhg-00RLek; Wed, 30
 Oct 2024 12:53:39 +0100
Message-ID: <9e239176-b1f2-45ef-a731-636f5a78aaa2@gmx.net>
Date: Wed, 30 Oct 2024 12:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, alexander.stein@ew.tq-group.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nAU/v9tnjeYaZL9gXJfznUoO/fGQeGzQLDk/lF7wlo2mLonJGd8
 t3ckT9k1biAyNLgNra5/5wtPNnTm8gyTPWUlP7Ch7cDp8P8SqYKy8/yDlque1t9yHCjuimA
 mDINeeHSDyJB/T+4wYW0W1jwaILpOEXXwa9oe2rFXysQ6er7tNs081a3dq4Dyn4ZpdhX6O0
 kMbDQz2zLUXbM9lel5hHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BkUbYhaiXek=;btPbuJ7l9uQvmb9M0f39zfxZrgj
 DEofWF3td4ONEWcaus8DgpUWv9xtX+VFnPbjEWUIpyfHrPfG6GBLM7SFgVsUzikqpNmmpvWIx
 6phsJqVAU7VL1kvP+XwW4eIczmx7PDLRBcEv7bHAzgDZktQGcWMQWf66fZqbFJKnDT5RN46hV
 9MyJ6vbd1GV3LOZJDTqhyq4j1SCYJZn9FnBa9AhJ3f+eDBEDNxnx3wnLuttf2aiRaDoam0/Vy
 jT4YEgb9TkFfdgNPM6NA2sEirS/czPjXWzV6Rk+G4n/KuUkfbpMGKp47w/KYc9nmQ8UTpD1Ma
 SJyQ8VjFdwiWYX0KvDt0QFKent+De1GoP3fLZE0ttEAd2/d/ztamJqe5FSFnK69zXQCpFMeam
 Ezv4tzeFTQfhSmDXf52Ybtshl9grM31NURhHGDkVe2AyxKLAfvzE9mGmiSNLmw26Q99/FphPx
 pJGS+AXQYeDyG4I5nKPTFfWoEwwaa/PYi7kiizBKKvgc3wFD1YgZyJl82PCoSO7U36UrO5dyU
 DplX1exVT/pmjh3KnyTRnopz57985EMzO/5AmHkoApLIthcQtJpsNvi1vww8qvisOwmMq0JMB
 8wkPAQ3cWqGbjWqhzqX0GUgXW7O9lxhPKytMg07x1Jj0NVn3WrGK8l6hMZ9n+F3VaDPHxdSXB
 aao65i4aR/ftTarXObooCyodMK6XK8/TEEmGGbvbpTQElzjRO4ScRZRZKzda3fFlXUYLLBdc8
 SbyEvINex49v3VS5LEo7zHeNLRwYvhwx6TG1TGX3kvxHSTY3R7GAS2EH9iYHqecxOSQMp6AF4
 tPp2NFpcJ/SMHzKq4Hq//Vsg==

Hi Alice,

Am 30.10.24 um 10:13 schrieb alice.guo@oss.nxp.com:
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
> Changes for v3:
>   - return -EINVAL when arm_smccc_smc failed
>   - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __func__, res.a0);
>   - drop the pr_err in imx9_soc_init
>   - free the memory in the reverse order of allocation
>   - use of_match_node instead of of_machine_is_compatible
>
>   drivers/soc/imx/Makefile   |   2 +-
>   drivers/soc/imx/soc-imx9.c | 106 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 107 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/imx/soc-imx9.c
>
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 3ad321ca608a..ca6a5fa1618f 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
>   obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>   endif
>   obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> -obj-$(CONFIG_SOC_IMX9) += imx93-src.o
> +obj-$(CONFIG_SOC_IMX9) += imx93-src.o soc-imx9.o
> diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
> new file mode 100644
> index 000000000000..823395584533
> --- /dev/null
> +++ b/drivers/soc/imx/soc-imx9.c
> @@ -0,0 +1,106 @@
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
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	err = of_property_read_string(of_root, "model", &attr->machine);
> +	if (err) {
> +		pr_err("%s: missing model property: %d\n", __func__, err);
> +		goto attr;
> +	}
> +
> +	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
> +
> +	/*
> +	 * Retrieve the soc id, rev & uid info:
> +	 * res.a1[31:16]: soc revision;
> +	 * res.a1[15:0]: soc id;
> +	 * res.a2: uid[127:64];
> +	 * res.a3: uid[63:0];
> +	 */
> +	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 != SMCCC_RET_SUCCESS) {
> +		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
> +		err = -EINVAL;
> +		goto family;
> +	}
> +
> +	soc_id = SOC_ID(res.a1);
> +	rev_major = SOC_REV_MAJOR(res.a1);
> +	rev_minor = SOC_REV_MINOR(res.a1);
> +
> +	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
> +	attr->revision = kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
> +
> +	uid127_64 = res.a2;
> +	uid63_0 = res.a3;
> +	attr->serial_number = kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_64, uid63_0);
> +
> +	sdev = soc_device_register(attr);
> +	if (IS_ERR(sdev)) {
> +		err = PTR_ERR(sdev);
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
> +static const struct of_device_id imx9_soc_match[] = {
> +	{ .compatible = "fsl,imx93", },
> +	{ .compatible = "fsl,imx95", },
What happend to fsl,imx91 ?

Best regards

