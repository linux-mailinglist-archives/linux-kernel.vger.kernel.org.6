Return-Path: <linux-kernel+bounces-410576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF879CDD7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC08282DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFC31B4F02;
	Fri, 15 Nov 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HzkLcKM9"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C351A3035;
	Fri, 15 Nov 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670144; cv=none; b=FO2A6WMLxDUt9Fv6KB6QmXx6kpdWbV2gATR021PSAuCUD4+V8bVVZLOcCqirBOtPIkFNhAO+zuQYw5DrlMR1y+Hm4Dr9G4sAeL4xUjNl2bTmBfm3BnXHJTP4Yj2sFuv41575gpBMt4Lm52YOEwDb8RcHca8uF1sBG2TZWd03Zcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670144; c=relaxed/simple;
	bh=khhIHEWNliBVmZA8AvYG6B06OtGY+JuVr147WSE1KVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSXXvL5pKgEg0NvqjkhHQ8Rj1UkAZ6+zdz7U3D14+Uj6zWB4iyxmrJm2meBQLPmk2nB3mymbWoSoFFtvyqaxbF4kXRIhbab4305jiCiAqRboNPmb2zC7HhZdzvckdi0166xpm0X+1vUIfKzfAu7wJ6SmB8LdMXpCvD2f7pEuL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HzkLcKM9; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731670127; x=1732274927; i=wahrenst@gmx.net;
	bh=/iHklA1u1HSma9IIWEW6673IUC2eLYhmJHz0Wf2MHys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HzkLcKM98/oQnqqa6rSkYQY5hO0TWHiqYj+9H9xQSGWZQwAd0euRoWfQLQQQAZiP
	 ym7qyJRUGS4ZmJqLkiAjq9+y3Ne61f0zRbptjsqo6MqC2oryPXkyASTY8MgqiiWK2
	 IEkjEitThQAJUqg/HiCLNKrcBvj6oZddlteuUY7tMfpILYXOt0MjIHpWnfe42H59/
	 RckPGYDoE8l91JaHTT6h8wm/qRcPqEQAbi1ofQVnBB/BPDj1rSQzHpzECKtnnpegu
	 Wmi4TPBMqi6HVY/wopJY95yj/3JBuYxFTu6h37huKWOt3k9DgoCgUTYN4qu1UARVO
	 vdh6KV92CQykSSfZkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1trs4U3bZ2-00sfCZ; Fri, 15
 Nov 2024 12:28:46 +0100
Message-ID: <c5055e0b-ca0f-45d6-a837-849a4784a530@gmx.net>
Date: Fri, 15 Nov 2024 12:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2NV0gc29jOiBpbXg6?=
 =?UTF-8?Q?_Add_SoC_device_register_for_i=2EMX9?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alice Guo <alice.guo@nxp.com>
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
 <4c157893-ceba-4a6a-a860-182af5f08c5f@gmx.net>
 <DU0PR04MB96364D1935D61D31176127F3E2242@DU0PR04MB9636.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <DU0PR04MB96364D1935D61D31176127F3E2242@DU0PR04MB9636.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQQsVEnyZOpXWwsvGCJz0dO2UnTUGCVoYVfn+Ohkb8N7rgGKJZ+
 M5Z5Su1MI6ekTH8qSmBwO11yCsuzqigT9Gp0OnwWBtZ20zszGlrxzrIBvAkUCEfjwT20kDt
 MYqAADw8uV85B8a1cUk/yQ2vUqbLiZ/4FHPbU+ED28eM+MMyMulNbqHDEpj2sDAB01RMiB2
 5rxmA+tCxmMCV6BPeF8xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iWJ7vcRfSMg=;gl9e5eCkEuiswttGriclICC16Wl
 3NakQVPmvViZ5e+vwBWp2rx7fM4o62k8frWyfIDWXGn3lRB1Y3dJhrujhMSpYKSm7bO5kcUtJ
 4l7we+SyNlzPTBtidI/ZlSql8PEF9i7C/Yn+ZQa3rOXFQ1JUOda2RIo9EM6usRQY05RQz6SmM
 nnKuAXCyQEB7P2Jh7YzhjHjkP34PiNxj3Mdmw1cF1mDpqleBWv16Qsghy/87Q8XzWU8UKFUa8
 RvwfBsfUzzE/7Z0Kd380RvMq0BhxO33t0VffqtOI7am3em+ZUUr2i+wCnfeuUlLT5L+xVjwwL
 aW0LP5IMyN5/qWh4YveYDMSBw8p+bCHmio+vYTG1z+EzoLPBH0ToeXOTZDgpP4aEDeEvZpMs8
 0kaTmYF1DABUcJZ3UjyKzp9WBZlxjCjMZvuwtVNQtt37vVMDzbGffH6qTGzYohrquMobeDFvM
 pEHT+hEwHwPfTX4OrdH0JFmFOP9c5NaEVvM1NXUWgyXzTCDf6+m//muIh4F55v5j5X/l1fcYG
 gVDZFu0+v5uKrf1hfQkno59Ovhbx2CfeV97xsU2ACnqxsAKYOTXU+NeO+fEulo4pNGJxI6vqC
 +7DkqT2ohvOSsYmZzB03dGq4iP0XdTeulWbK9cu/qFjyJX83AMNxm+CHpR9NoFsXuumm8Ujqt
 yX1/HnGkke5dBNBpH8ad0vRKWGTX+8n704KBjwXAN3S3Iq+PYYmatSMMdZjjlQf5AolZ+MpYg
 7zPVS3Ca2vEFKHHuLqA/kLK6bRvG/CbaDA9lJALau37jnxJyjKPXhfiDXIphYgY8aoEQuWsSB
 /BROQkx9FYAj3mgciXJyfxnTnArl8BXmFeYdlNPeQygIY+SkSdtcUyU41N3KKaulwS4/gCh/x
 CxyGsPYPkAaM5ix5aeozEe0EO3708pOPw7HOV5z0RYBbBmtfOsaegg+Fq

Hi Alice,

Am 15.11.24 um 08:24 schrieb Alice Guo (OSS):
> Hi Stefan,
>
>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Stefan Wahren <wahrenst@gmx.net>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B411=E6=9C=8815=E6=97=
=A5 1:40
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>;
>> alexander.stein@ew.tq-group.com; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com
>> =E6=8A=84=E9=80=81: imx@lists.linux.dev; linux-arm-kernel@lists.infrade=
ad.org;
>> linux-kernel@vger.kernel.org; Alice Guo <alice.guo@nxp.com>
>> =E4=B8=BB=E9=A2=98: [EXT] Re: [PATCH v5] soc: imx: Add SoC device regis=
ter for i.MX9
>>
>> Caution: This is an external email. Please take care when clicking link=
s or
>> opening attachments. When in doubt, report the message using the 'Repor=
t this
>> email' button
>>
>>
>> Hi Alice,
>>
>> these are the new comments
>>
>> Am 11.11.24 um 04:23 schrieb alice.guo@oss.nxp.com:
>>> From: "alice.guo" <alice.guo@nxp.com>
>>>
>>> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
>>> which are provided by the corresponding ARM trusted firmware API. This
>>> patch intends to use SMC call to obtain these information and then
>>> register i.MX9 SoC as a device.
>>>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>>> ---
>>>
>>> Changes for v2:
>>>    - refine error log print
>>> Changes for v3:
>>>    - return -EINVAL when arm_smccc_smc failed
>>>    - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __=
func__,
>> res.a0);
>>>    - drop the pr_err in imx9_soc_init
>>>    - free the memory in the reverse order of allocation
>>>    - use of_match_node instead of of_machine_is_compatible Changes for
>>> v4:
>>>    - fix the build warning: 'imx9_soc_match' defined but not used
>> [-Wunused-const-variable=3D]
>>>    - add Tested-by and Reviewed-by
>>> Changes for v5:
>>>    - probe imx9 soc driver as a platform driver
>>>
>>>    drivers/soc/imx/Makefile   |   2 +-
>>>    drivers/soc/imx/soc-imx9.c | 124
>> +++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 125 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/soc/imx/soc-imx9.c
>>>
>>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
>>> 3ad321ca608a..ca6a5fa1618f 100644
>>> --- a/drivers/soc/imx/Makefile
>>> +++ b/drivers/soc/imx/Makefile
>>> @@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
>>>    obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o
>>>    endif
>>>    obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
>>> -obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o
>>> +obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o soc-imx9.o
>>> diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
>>> new file mode 100644 index 000000000000..4ef92260e8f9
>>> --- /dev/null
>>> +++ b/drivers/soc/imx/soc-imx9.c
>>> @@ -0,0 +1,124 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2024 NXP
>>> + */
>>> +
>>> +#include <linux/arm-smccc.h>
>>> +#include <linux/init.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/sys_soc.h>
>>> +
>>> +#define IMX_SIP_GET_SOC_INFO 0xc2000006
>>> +#define SOC_ID(x)            (((x) & 0xFFFF) >> 8)
>>> +#define SOC_REV_MAJOR(x)     ((((x) >> 28) & 0xF) - 0x9)
>>> +#define SOC_REV_MINOR(x)     (((x) >> 24) & 0xF)
>>> +
>>> +static int imx9_soc_probe(struct platform_device *pdev) {
>>> +     struct soc_device_attribute *attr;
>>> +     struct arm_smccc_res res;
>>> +     struct soc_device *sdev;
>>> +     u32 soc_id, rev_major, rev_minor;
>>> +     u64 uid127_64, uid63_0;
>>> +     int err;
>>> +
>>> +     attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
>>> +     if (!attr)
>>> +             return -ENOMEM;
>>> +
>>> +     err =3D of_property_read_string(of_root, "model", &attr->machine=
);
>>> +     if (err) {
>>> +             pr_err("%s: missing model property: %d\n", __func__, err=
);
>>> +             goto attr;
>>> +     }
>>> +
>>> +     attr->family =3D kasprintf(GFP_KERNEL, "Freescale i.MX");
>>> +
>>> +     /*
>>> +      * Retrieve the soc id, rev & uid info:
>>> +      * res.a1[31:16]: soc revision;
>>> +      * res.a1[15:0]: soc id;
>>> +      * res.a2: uid[127:64];
>>> +      * res.a3: uid[63:0];
>>> +      */
>>> +     arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
>>> +     if (res.a0 !=3D SMCCC_RET_SUCCESS) {
>>> +             pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
>>> +             err =3D -EINVAL;
>>> +             goto family;
>>> +     }
>> I like it that soc-imx8m.c handles the corner case
>> CONFIG_HAVE_ARM_SMCCC=3Dn in order to increase build coverage.
>>
>> Is it possible to adapt this driver accordingly?
> Currently, i.MX93 and i.MX95 obtain soc_id, revision, and serial_number =
using SMC call. We do not provide a second method like imx8mq.
>
> 	/*
> 	 * SOC revision on older imx8mq is not available in fuses so query
> 	 * the value from ATF instead.
> 	 */
> 	rev =3D imx8mq_soc_revision_from_atf();
> 	if (!rev) {
> 		magic =3D readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> 		if (magic =3D=3D IMX8MQ_SW_MAGIC_B1)
> 			rev =3D REV_B1;
> 	}
This wasn't the corner case which I had in my mind. It was about
building this driver with COMPILE_TEST, but the

#ifdef CONFIG_HAVE_ARM_SMCCC

in soc-imx8m confused me and let me think there is no definition of
arm_smccc_smc for the other case. So it should be fine without the ugly
ifdef stuff.

So please ignore this comment and sorry for the noise

Regards
>
> Best Regards,
> Alice Guo
>


