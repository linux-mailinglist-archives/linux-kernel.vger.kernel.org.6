Return-Path: <linux-kernel+bounces-550014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3EA559EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FA3B1B06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33527CB21;
	Thu,  6 Mar 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fSjdSC5s"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504821F4185;
	Thu,  6 Mar 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300745; cv=none; b=JwbWbuwzBqEi2VsIhRL4mVvq2egcGIsfD/3f9h6cbrPDksvpuIVVAjWs/am860nIY1VojWptfOBhP4cDS5pFGrGFQFvyEO6T6Ky7uKyNP/RbYzSJfMdMrtLQYBPopT+r9+oSo+lxju0COKYcIaGu/wsXQoUADkDQfS5E4MzbWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300745; c=relaxed/simple;
	bh=x1Woj64CCjmZrfdWYDFCS6r2XUCd5eTejleo/ZgAa40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZlE8l1r1TlCTMAMjfTZtwl/POcGSHX3PdLQfV/JXvLQLT9HOCYJgia+TYn8ZpaDjnnWMIv/m5CnifxqdOJREqU053+Ja29PA/KhN2KXwkwENPVpnSqlEs5iWu3aEGeGy4iIQ0TrHDA9xCDSXzhIIuiEH9iM5q2Mk9mfpFrJaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fSjdSC5s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741300740; x=1741905540; i=w_armin@gmx.de;
	bh=tAr+3qndrO4mbKcD+KVaVkp0ADfs8Cfpe1Qp5AXaf/U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fSjdSC5szJ5mY6ijbylbQWq7aXdigAL6onuVPXKo2lLnvire7HLzkfHm2TRGPOAn
	 NXScr4DzMFVxJFjSyFbjyVwz55McyvTjSbV/2Tv/zBi0o24lLij0u4YRs/642rscc
	 ocxCHWgJrllmMy6H2MfguuR0CNZ+CB2yUBSw9eqLNPQkk2xnez6ZMQLLr5y7dcD+e
	 HNRJD3FekHCsVnPzFAISzQ6CR0lkQEbqbazkB+WQHveCy53YHJeqq//fxzF84Z95/
	 W8glZodXdRQUeuT0YvV3PU7cxsp6olG1jnoETp3snesM4zA2l1ApZbICgionkezUm
	 ss7vjwbz59JYPeYoqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1t33Em0gPc-00x3RE; Thu, 06
 Mar 2025 23:39:00 +0100
Message-ID: <79051f75-9217-4fd4-a515-e958a587a32b@gmx.de>
Date: Thu, 6 Mar 2025 23:38:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] platform/x86: alienware-wmi-wmax: Add a DebugFS
 interface
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-9-395e7a1407e2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250305-hwm-v3-9-395e7a1407e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eBhWsDHOvwMs0tcQ1i1j8f2n6fYJ65v+QYZroTyY4CVhymF9QYR
 Rok/e492658FCeV0M+JJFVKqj4LazWUDN/DeSw9ncFWLzh/vvoRKmK8pHjlXbJA4v/BT+tE
 B6yk5iduYpwgD1MrFapnWRlJktR23tVM/GOzFVDtvKCzBsxdHVZ9Y3ib93eiokQlYQhWK7z
 IssskdrmmQZCLuTCMAmgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SOsfHhcHV/U=;GuCPtiSUuD/q+C8Z76x9imLCfjV
 RpQrPFfWnrCPngbcwbNII5d+/IOq7VCZDDGGrPAltUqmpKgg8dwlLKBQD6eD31f5orodox2Kg
 PpjK6sya/yLBb8N59WCk9K93kyE2tiAR7Bmhmdl/WVowqs/keMqIwobj7Eyh69KwxGsD/G/Dd
 TuXP+M74w1YaB8WNpj2LL7fzURwK7zfPAzCSA/EnRKrROq+hDi+uyfg3L83R4H+LT651eSI1G
 rTAmY+zl4y5DaQLQ74paNQFgz94s+cCr5UDMeq0xhGoB/ik/TW08eIRIC7J/EcfCoLaPPxzyI
 mEqWrnN60tEkUN88GCF2slQkQI3crrezDasR6IDg8m4cjiFNJbMKtBBw75QTxajkGRUZaDSY1
 Bzm51NnpbWUdLKuXUG56yRRFdUZD+Qjg6JV/rmhbS/VCS54F0hO+ndG76DdoJx+avYLyVDNcD
 Gxtm0NTz9uS+42GLUZglqeP1p2VlqypeIVZGWdl6bKWcALBjGFg8twg642E76h0RkI8oZqKoS
 4mE1147iq1FeZOem92xJ3H9zu7SJqTyO/And7z9E7okvrXZ4VlD97UaluNiClQ4++A7Kwe4R0
 sSBKC+AlLbWbVsWmcR4T12tP7rgUPpAbuFPlBSf71liOfWUz3apJGS414OgQ9RGSY5ZlQkP8b
 raxYylVNApOBf890y0UJRNX1/CNgDKTiMsAKwHk7z54bda0ZRLgfkaR1i2QuIlwr6YI5znwlQ
 +f4kbjPwoUMhO3ptagGR/LPukySnEcT9OP+3bb5PP7+CTn5jsOydxJ1nJXgV2NacqpvyrUvuw
 Ep8bdxzp+UhVvP7BusZ8xFupxO2xpIPgbTVObqrx6zTbGIh0ZqpE8OX5uI73AkLJXJ2sb+ZjH
 0xPnxjbxrqcWyiVftIfdcPjC50VwKUW3FOdoJKHQS18nmTZKrxsEskxqInEk4Gg/MERbPVDtq
 zO9F8lvBsr3vH8gYE9YQ2r/Q3WeNcvhW8LNczlO+4uONtHLW9St8YtOISD/ZFs9XB6Z9ZTpXL
 AderqRoj0bYS8zLZ/A7dG0gJ7pXd7CmfFrzXwv54umxGrwpWxk1AiIl4064J6YX4+IxLJzF4x
 T9nJR2NXmXr/SUkrXXAwUP4fW/hW8Jn2/dTkbKvliEoeKfpBdoQh/Bud27dhXtJXZacXDOtx5
 SX6kMJaf67r8+Oy5mvjYAH5Eja/EHYKjzzjrzhlrZCE26hXpsJmCag85uO5ImaVV060miJsuD
 FcbapujZ9LIzkzZF3+dJ50l2Mew4UO+Rbpy609qEpFimlFf8oO6DAn+6rCAzkoYCb6yGTGoSy
 hRLK+Lf34ggRuaVXtnt3emsEzwqpOXmuWhxxGsNPcF3Uvh/Y+UBaL7jBLeqJMI9GD6XhuWfXN
 vB5IYSE5OncB4mZEKZvJLTpKBn+sqzXJYaV0181dCb0dIxIAhsZzlMVAXe

Am 06.03.25 um 01:57 schrieb Kurt Borja:

> Add a debugfs interface which exposes thermal private data.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 92 ++++++++++++++++++=
++++++++
>   1 file changed, 92 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index de4e8f177aadc9552b05cc732e41ee458b761143..23f8680a212fb9ef2a6f23aa=
fcc2d25738ae4364 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -11,6 +11,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/bitmap.h>
>   #include <linux/bits.h>
> +#include <linux/debugfs.h>
>   #include <linux/dmi.h>
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
> @@ -18,6 +19,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/platform_profile.h>
>   #include <linux/pm.h>
> +#include <linux/seq_file.h>
>   #include <linux/units.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
> @@ -1343,6 +1345,94 @@ static int awcc_platform_profile_init(struct wmi_=
device *wdev)
>   	return PTR_ERR_OR_ZERO(priv->ppdev);
>   }
>
> +/*
> + * DebugFS
> + */
> +static int awcc_debugfs_system_description_read(struct seq_file *seq, v=
oid *data)
> +{
> +	struct device *dev =3D seq->private;
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +
> +	seq_printf(seq, "0x%08x\n", priv->system_description);
> +
> +	return 0;
> +}
> +
> +static int awcc_debugfs_hwmon_data_read(struct seq_file *seq, void *dat=
a)
> +{
> +	struct device *dev =3D seq->private;
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan_data;
> +	u8 bit;
> +
> +	seq_printf(seq, "Number of fans: %u\n", priv->fan_count);
> +	seq_printf(seq, "Number of temperature sensors: %u\n\n", priv->temp_co=
unt);
> +
> +	for (u32 i =3D 0; i < priv->fan_count; i++) {
> +		fan_data =3D priv->fan_data[i];
> +
> +		seq_printf(seq, "Fan %u:\n", i);
> +		seq_printf(seq, "  ID: 0x%02x\n", fan_data->id);
> +		seq_printf(seq, "  Related temperature sensors: ");
> +		for_each_set_bit(bit, fan_data->related_temps, priv->temp_sensors_siz=
e)
> +			seq_printf(seq, "0x%02x ", bit);
> +		seq_puts(seq, "\n");
> +	}
> +
> +	seq_puts(seq, "\n");
> +
> +	seq_printf(seq, "Temperature sensor IDs:\n");
> +	for_each_set_bit(bit, priv->temp_sensors, priv->temp_sensors_size)
> +		seq_printf(seq, "  0x%02x\n", bit);
> +
> +	return 0;
> +}
> +
> +static int awcc_debugfs_pprof_data_read(struct seq_file *seq, void *dat=
a)
> +{
> +	struct device *dev =3D seq->private;
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +
> +	seq_printf(seq, "Number of thermal profiles: %u\n\n", priv->profile_co=
unt);
> +
> +	for (u32 i =3D 0; i < PLATFORM_PROFILE_LAST; i++) {
> +		if (!priv->supported_profiles[i])
> +			continue;
> +
> +		seq_printf(seq, "Platform profile %u:\n", i);
> +		seq_printf(seq, "  ID: 0x%02x\n", priv->supported_profiles[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void awcc_debugfs_remove(void *data)
> +{
> +	struct dentry *root =3D data;
> +
> +	debugfs_remove(root);
> +}
> +
> +static void awcc_debugfs_init(struct wmi_device *wdev)
> +{
> +	struct dentry *root;
> +
> +	root =3D debugfs_create_dir("alienware-wmi", NULL);

Please use a unique name for each driver instance. You can do this by comb=
ining the
WMI device name with the driver name.

With that being fixed:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +
> +	debugfs_create_devm_seqfile(&wdev->dev, "system_description", root,
> +				    awcc_debugfs_system_description_read);
> +
> +	if (awcc->hwmon)
> +		debugfs_create_devm_seqfile(&wdev->dev, "hwmon_data", root,
> +					    awcc_debugfs_hwmon_data_read);
> +
> +	if (awcc->pprof)
> +		debugfs_create_devm_seqfile(&wdev->dev, "pprof_data", root,
> +					    awcc_debugfs_pprof_data_read);
> +
> +	devm_add_action_or_reset(&wdev->dev, awcc_debugfs_remove, root);
> +}
> +
>   static int alienware_awcc_setup(struct wmi_device *wdev)
>   {
>   	struct awcc_priv *priv;
> @@ -1381,6 +1471,8 @@ static int alienware_awcc_setup(struct wmi_device =
*wdev)
>   			return ret;
>   	}
>
> +	awcc_debugfs_init(wdev);
> +
>   	return 0;
>   }
>
>

