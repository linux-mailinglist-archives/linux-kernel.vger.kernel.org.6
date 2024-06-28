Return-Path: <linux-kernel+bounces-234663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D1591C93E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502F81F236A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C581AD7;
	Fri, 28 Jun 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WEBHvc7e"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8A80BF2;
	Fri, 28 Jun 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614611; cv=none; b=Ddnhmhc9TFqsMFkEecia4fo6FJXrsGr3KGCHbXTghlPO45eRdm6r6KcV0vc8K6qjRoUin2d/2ZkUz3fac0Qcwi9Lp0v521p8z2qXVzZHF76tUGbPDNyYXFX0ZJAMqqvy38d2cV53CxcgouTQp+Y++NPPgqsIuhn9Owmq4y9TIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614611; c=relaxed/simple;
	bh=8ozV1BOer9XyPVKRBEyirs/ebxELduTRYYFKpZg9gm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcD5aLyyLNNu9OVLhVRuncFYGUqc4Jx4ZWKsQg+TvStVEF54dQXdj8H6QhhUp3MjXdfmz4kBhDwE09tsJTk49k5jKZWL5ckPc3Hi/OkSJ5N0Qoy3sY05Osb6yGke5GGKLgaTqJ56wdyzXL8jghoOcEH7/q/cebB3YNdk5DAz/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WEBHvc7e; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719614589; x=1720219389; i=w_armin@gmx.de;
	bh=lp/Wif3TY6cqzmHouSUY1AF7c9CKGBahm/tFwXve1xw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WEBHvc7ehE5oWXh+uyDorvlWW+NWDYjkhn4cp0dEse18ZSXzP1patlOxGKAXBvKV
	 tPBjZIcJLZDdz4j0rXmxYAZdbFLgr23G5N2wlo5Vscg/s9Q1cA4uqlI3WnEArfCAH
	 1dZmZLYmvo3FMDGmuzOXpq1ndBJVyEYSKIOwtdyOBslg6mYFGUrnbSQfVyTjPxFUA
	 bMk6XZDaQJrerfjb1mpgpAQbACWXEueHoX+qIFtLE7PMh7TYl78/b/g19LbLu6keQ
	 +5zabtHmoXByEDAUI7jq+3D7rrJ0OvdoRwpzY1UWAfCGMEli4rF4FnhbRp7SYH1G0
	 x7NBjBrkVukJTy9ntg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1sC0hA0mgz-00D8nU; Sat, 29
 Jun 2024 00:43:09 +0200
Message-ID: <b4e555cf-dae3-4af3-98b7-15633eb3cc63@gmx.de>
Date: Sat, 29 Jun 2024 00:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240628214723.19665-1-W_Armin@gmx.de>
 <20240628215704.i6ohbuz2zgegr27p@pali>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240628215704.i6ohbuz2zgegr27p@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdqQghFx/kI2mj2VuhTtqErDXTCWv0wEAS1AbMCUOZaBcp9kYhM
 khdeVvyRaI9VCjJFQ1AGnha9woDWNBEkSqwoy1JvBvN1VixQopVlBERIOsgi3HPII/5CYZC
 eQPYPAVgztI4lgWoEwlRTYP6JdB3JjNYGkuhOCyRDyeVeRti9lnoP96SY2AXbQJfXIIr+Gg
 87/5endp5/1OgcLAb6DZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bJhH4pcWBXc=;BbnT2UEwYUzxpiqmxVx2cuxRh5e
 kl23rMRexUlERUXANihCGFjpe1/zP3lKZdL7M7y0NdZYhczDiFe2S7XdQololox1vpunIxZrL
 Ic3sHDsAOXpKVByQI9FyT+kmqLGhcDb58NCDQXIQ3Z7MB+HlE3PcjGK2DYR2CXHMB5+g/FNAy
 cNtl+mm7dYCIQem/ZUW/8d20CdBtdFZviq2OQR/pznLWGi3sDjJhYoUyW5WlCcNnFSl2gdTXW
 W/3sMwZ9GdKtefO1PHbdoLGYRozu/VSPKWKcDM+Pm2UGXy7JwjtbZwPZxBOAlqsfHa61W0X9S
 jWjmGMpv467j8nf6jJI2iWn6yo7KpjksU/mhu2ttrnJzOvgiulBBjRwj1FQmO3sFDRleiSjll
 lgZdHr1H/ByilXVw2+S4/OuE6f1+QhOSgWct3RGKx5TaYnbEXiuaeWyTIntY68fwtWVjqL33R
 9KWone/Wt6RdSVQbScr/xAD3SRlkELPaI04B1DDVsYUfA95ei4p1l9a+xofNUQNGwPMR7H1Yo
 RT2BKefB72563cTHjs6vs6DtgS3PKDZxp/sIBd2DtWtu+ioVAGbmPZxIvEzNaTMP5YVyqiHk0
 Np/fn7Q6BsT4pom4BtLlmcMrvyyloRvXT7DLxmkitAYg9u1ZkHH+9DsbKgKsaTXLw+fPFEH17
 qIIwfwDRdVM28oiyQ1BHUSeB5ryyWb7jNLQmNMtGJxLPQE0LwNejP5SJ2AfrRae6NR8I8NuX5
 9Q2xFncebhwOCZra1Fj0KwJ6EMcMMH9pygTIXrkAD7tENjIyxBnH/jHTBuqWeJaLoIgOxcBcR
 mJ6mk4GuoKnXvDE7/YF8YfdsfWywE3HaxvmpZBw+SOOLQ=

Am 28.06.24 um 23:57 schrieb Pali Roh=C3=A1r:

> On Friday 28 June 2024 23:47:23 Armin Wolf wrote:
>> The BIOS on this machine is buggy and will in some cases return
>> an error when trying to get the fan state, but reading of the
>> RPM values and the temperature sensors still works.
> Does this error affects machine usage (e.g. freeze of CPU or some
> erratic fan behavior)? Or just kernel does not receive fan state and is
> unable to report meaningful value to userspace?

Basically, it seems that the BIOS will return an error if the to-be-return=
ed fan state is less than 2.
Everything else seems to work.

Thanks,
Armin Wolf

>> Closes: https://github.com/vitorafsr/i8kutils/issues/38
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
>>   drivers/hwmon/dell-smm-hwmon.c         | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwm=
on/dell-smm-hwmon.rst
>> index 977263cb57a8..74905675d71f 100644
>> --- a/Documentation/hwmon/dell-smm-hwmon.rst
>> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
>> @@ -360,6 +360,8 @@ Firmware Bug                                       =
     Affected Machines
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>   Reading of fan states return spurious errors.           Precision 490
>>
>> +                                                        OptiPlex 7060
>> +
>>   Reading of fan types causes erratic fan behaviour.      Studio XPS 80=
00
>>
>>                                                           Studio XPS 81=
00
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 48a81c64f00d..c75bfe93f2f6 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1263,6 +1263,13 @@ static const struct dmi_system_id i8k_dmi_table[=
] __initconst =3D {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
>>   		},
>>   	},
>> +	{
>> +		.ident =3D "Dell OptiPlex 7060",
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7060"),
>> +		},
>> +	},
>>   	{
>>   		.ident =3D "Dell Precision",
>>   		.matches =3D {
>> --
>> 2.39.2
>>

