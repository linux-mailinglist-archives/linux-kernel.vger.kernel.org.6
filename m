Return-Path: <linux-kernel+bounces-197991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E106F8D71AD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 21:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B41B1C20B6A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49832154C11;
	Sat,  1 Jun 2024 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Pxy2MPUV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F744171A5;
	Sat,  1 Jun 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717269831; cv=none; b=KKjJZVfx7XUhoxk1qZmiOxlzix/7m33GuAEAefEzUwp8+kqf0ZQQRB2LYVqaq+x8gsVKcvTn7qhtckTPAxstdE7nOVndJRJCjIKzJTYvRd5Sg/UBq25cKVgZGthjyTlDxIMBpyY9H5DXmP0kFrcqTErtCvmyoA1qdXUg8ohRDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717269831; c=relaxed/simple;
	bh=An57snNAVWPM/Jd6dWaMAbWr+p4o459kcQwDlqhWjdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgXHsraHarcNeOmdr5F9/LyVsb0ms+uckpEzx6r8p/2n54jEJv7VTLDYkVX9TQI/vajY7lxylogSBW5/O8Jxo8a18ngmZDsKPMbRwDa6vwszBJqAkHoINYsckgYSlSEy8pJTBx8r85fKXb1Y62v6Q4mfRdRF8jaCtIV5l7l9GjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Pxy2MPUV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717269804; x=1717874604; i=w_armin@gmx.de;
	bh=5iWYMGr3Z9QM/GtgZJ3Kx+3BmVGKNlOjqb+ZMe0xvfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pxy2MPUVGWr3hijaYDg/yx1eCUZ9XaIp1jHq4pcGIDiAY8nnzky8HkrWsssXC71v
	 0hLevXvTfVUhzC+mXmDZ/ndapOnZbbLTnsCKWbZrznIIVgI2ObF4pjo5W8USh+beY
	 OP07SDy0o2a9AeOZXxeX+2+n5HOquTjyvgjtWAPO/YaIBWyUyWM6vl90dlcya8ArR
	 tOXOVgyXrVwQttxHCUzOkWdytJTFZjR3wr8wevXaYFufzHTaRd3jJq52WwhZLajzf
	 3/o09pwuxc6sadBawcfuTr6E3tB4Quvmv+EWiUwdjC/KZXU3ApY9zZbv9GVyVJOVt
	 nDDKozEw8DsCjLc5+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1sYgGd2nLf-0183qj; Sat, 01
 Jun 2024 21:23:24 +0200
Message-ID: <b3109c26-dde1-44cf-b431-80957c97de5f@gmx.de>
Date: Sat, 1 Jun 2024 21:23:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
 <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
 <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
 <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>
 <4e4341e4-2165-40d4-909c-9d5164e97942@t-8ch.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4e4341e4-2165-40d4-909c-9d5164e97942@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nl2ZL9DzOWscLAZzj4pxS/2xcRN7csMsdJN5BXRyQHPcES/oX5C
 5EyHI0SM2GwJ5CWiFINrMGy3U5/t7pEC5MR0GsaNLbrto7Bjk88Jdeb5saIFubD1f8T4uh2
 HgBvkgPuy2yALqZQSbmmU7oAxQxGXV0S3/xhXcVDJWH2QyfPzMZAAS8qMo7s9KxMReMI5IE
 iRDGNHfWPH1i/Y2+4avQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RocisHFiDs0=;xJvP+AsNP0agfOEdM+8EpcR+hG5
 AoQMzvgYdj6NbdSYzdVZTCSlnP0bdUrEe7k3yBAQx6dCBZMpGaFIMnbp5Iratzzxbp3Ahf2YU
 41+LqTduQDJm2oRRtcemp149WflnkjYtW/nVZDUu2bwkuSz5r5wK0KmrhghH8LATAb9z3BIs4
 ImQ9Nv7SqyBPP6VA2zYphJgORMSbEotG7lhhz2k9ROQc2iU40/k+sJt0QSsc56dnnJNt159/c
 feB07tytFp3BVZ7fa64SIepA3rVjOoHSHerrWyuv71+IGJp0ziSwKe7CMl2/yhUHzG/h4NmvV
 KohmjJxzgc21/lRaVgtz07vEV8zzvDuaS5KV8h8GG/vMeGbgUhJ39zFTKfwCazQj7ZRoUy3Q2
 7JEXrUaCvO4LkgcAGID+DcN4PreR6LYzeFkRE9XlLLjekT4zOPAxT1bpSa6zwaC/Sb6ewehY0
 pxkngSnN1wGCGtdZf2vBo14xH4UupqdDzpwg6sBSpesKjQCxIS+11ieM6iMOhJc2zRTgEjwhL
 Qh2A2I4WR7WSP/khom2jbXR01X7nkLf5/MuQ8W3I3WMmH9acxeP3IrCDsxjHIgwxQ+Jhask4f
 JRy9HWgjN2oTMuBSVvoouhY3pOuRv7pnxzbLFKMFbGh5swdtFZxEYlmWlaqEBZM+lHqEIKXai
 69WRtDPhGP1Y9VdzIyLGvklNSeuh6tXUWALuOPx6l81MR1OPnAsiJIwZwD37DVgrUz130AygH
 mgHnlfvKjaf+XtsKEw3Q1aQ/Rl1Kg6j6hT6YwAZ//ClBkLURNcKXgTyTFMVpONTdZ/uofuRcv
 7bufuvG+4BJDiRawbSMwM44V6/LmEvhFc5ko2FrJH3v/g=

Am 01.06.24 um 16:08 schrieb Thomas Wei=C3=9Fschuh:

> On 2024-06-01 06:48:29+0000, Guenter Roeck wrote:
>
> <snip>
>
>> Makes sense. Another question:
>>
>> This:
>>
>> +        struct nvmem_config nvmem_config =3D {
>> +               .type =3D NVMEM_TYPE_EEPROM,
>> +               .name =3D dev_name(dev),
>> +               .id =3D NVMEM_DEVID_AUTO,
>>
>> results in:
>>
>> $ ls /sys/bus/nvmem/devices
>> 0-00501  0-00512  0-00523  0-00534  cmos_nvram0
>> ^^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^
>>
>> which really doesn't look good. My current plan is to go with NVMEM_DEV=
ID_NONE,
>> which results in
>>
>> $ ls /sys/bus/nvmem/devices
>> 0-0050	0-0051	0-0052	0-0053	cmos_nvram0
>>
>> We could also used fixed strings, but "spd" results in "spd[1-4]" which
>> I think would be a bit misleading since the DDR3/4 SPD data format is
>> different, and "spd5118" would result in "spd5118[1-4]" which again wou=
ld
>> look odd. Any suggestions ?
> In order of descending, personal preference:
>
> * spd-ddr5-[0-3] (.id =3D client->address - 0x50)

Hi,

this will break as soon as more than 8 DDR5 DIMMs are installed.

> * spd-ddr5-[0-3] (NVMEM_DEVID_AUTO)
> * Same with only "ddr5-"
> * spd5118-[0-3]
> * Your proposal from above
> * nvmem[0-3] (default handling)
> * 0-0050-[0-3]
>
> Also can't a user of the eeprom already figure out which kind of module
> it is by looking at the eeprom contents?
> The first few bytes used for that seem to be compatible between at least
> DDR4 and DDR5.
>
> So using plain spd[1-4] could be enough.

This could cause problems when DDR6 arrives.
Personally i would prefer the spd5118-X (NVMEM_DEVID_AUTO) format.

Thanks,
Armin Wolf


