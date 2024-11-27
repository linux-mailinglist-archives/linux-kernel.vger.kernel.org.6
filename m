Return-Path: <linux-kernel+bounces-423594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6789B9DAA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FE8B22743
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623AF1FF7C4;
	Wed, 27 Nov 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qJa2PpUB"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D31F8AF0;
	Wed, 27 Nov 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718902; cv=none; b=uld3m0OY6mcF8C0vX5ihtNjDFUf1d7rhE8dNuPrwKM8y0Wf+jCp+jRagZr/ec+pnjDk4+05GiT0AkPcdbGx4cgcK9cAv7U9DOXEU/Jy0LkRGQ3EzNnBOd1Gqwi3tzUlPrya+5xnT6yvpS4NVHCamHG6cynj9Bsx+4Xn3CZyApxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718902; c=relaxed/simple;
	bh=DDKHOcZVEQqmT2tDYAg9UCohhtIYMR7MqQELcTZI6oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDOoILO4/MNADefodrJ5seaQW0AsrjhGLGS+iauB4X6pXDHoDO9sIFhU+JaVHv2Gw8kEWqJp8JvVWoEvW6HYB2ZBqOAK0rgTYWj77c6vFzq3qRE+bmFWXdmk43Rf22b8I6cDzL+yt91+IWTfg9ZAKFZBGtwM5flsGHz8fedsFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qJa2PpUB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732718873; x=1733323673; i=wahrenst@gmx.net;
	bh=DDKHOcZVEQqmT2tDYAg9UCohhtIYMR7MqQELcTZI6oU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qJa2PpUB4eTGSulOxpThbCXW2fCNG84wXndDxKxLVgh6xxylDt8UthMens3gaPQD
	 1yCeJuucThAXHJnMsmYB0jzLqT6KiANRrF6ya6+3Bg1ogH4INJrsp1XwpnMGgz3JY
	 rd7u59Nbguxq0ZLSwAMyJw+X3MgzJY7im3qq0bnkd2J3U+JCjZ8Xc2KcK7iAQ/L/m
	 EXeFL0fU5zskc+zn+SdjGu43MbRUHhKrhAZ1lifd+w8DDAsjYcv1Hf4RB7/AlQjZJ
	 7g0Xxyn4WeC/9UDWG3v2pELqY6KD2DCbBEMwzM5CldMRd4fuacwq9vn0zDiGdTJrv
	 36KIfL32yhIORRNsSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1tdsqw2QhP-0158e7; Wed, 27
 Nov 2024 15:47:53 +0100
Message-ID: <ef166c83-2fec-47dc-a3e8-215c211be0db@gmx.net>
Date: Wed, 27 Nov 2024 15:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] w1: ds2482: Add regulator support
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
 <20241125-ds2482-add-reg-v4-2-475a7a08df96@gmail.com>
 <d83667b9-23a2-4f1c-9a9a-12ce1e3a3983@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <d83667b9-23a2-4f1c-9a9a-12ce1e3a3983@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DD+OXLEbEfzJ4wF1shxmnpW3CCCIy9Yjqg6+ZvsDT6RgTvYbSFF
 kt84E5SObR61yjZkW2dpCdaH1EFDrtIzM97AVbilvx6v5bdup9YwDoyyMS7lbWj9wnKNp0W
 SSuMZgu4jAcWkGsybUYdHtELwcBVhNYDqO1JKRoEAeD/BQyHTZp3XT55ESM5Vs61ccy9sv3
 nt2BAlHp0jZw9iVnX8TrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N/dFw8CD9u4=;G/6yG3EC59rfSYyfNa7UUmylOr3
 229y0E9rMRte05cKPq2ICnOfgwnI/MxNWC5pCg+wTqDg4SeB83Jy7Kq3gMFhw2XJJPI7Jcz8z
 5SH/xs6it7ICnMPVOh8KNR70v9s+c0ZOA6YaddXeqQTJsccVyVmMppGWbUH1HQ21b5PFVtpPm
 9iQrcqXJLoLqvvByNXk4rTlcfQ7/2/8TAR1dv76osvYD2fA6nWtwvKSyAP0BGWA0SZeVmX/zN
 BrtEuIDiRCm3wur8cG+HqR4foTyIKl0ggze9RNfr6PdL/NRGgx14CTU7lTHvWpZOz3/i7WWU7
 H9JBLE7gwiLsdNsPz9NpGLjCPCFFUQh59wTYhYWh75YqEHZBVDra4qU8W0vNKauZsyFGH3c8t
 bFfogY+XwK+qmr1U1i+6YIdruzHgBlJAF5JYs4bKUJ4lDUO4wxJKBOoBHlXfIgrQSQ39Hkmno
 TC7qh9uXiL3msUy72uWNwKAd4sV2EpUU8mEP+Y/NsiUtG49w2ylPE6lM3WGlqxTvoIEudcPj4
 li5qbfM73+KWgYhHS4OXFg/AbhlD1bNXasYi4p/lSNzigTFoQQoUP/OrkwkKGtCHskEgaNpco
 KMd9+sBtRFo6e1fBQYaWOMHTWkO0cTJBY1Fy+JI8Qg1tPW7F37yWc0TOLxaSXrvVYXkREIyD+
 0rZYa+5tm6jozHicXDwqdmkZxjdfDHMth3o2kJs7mCTACGwgWuTbOXu6yVDrHAuH0UKX06Ou3
 2cy3ykC/fTWVIT9nSdzJsMUus5Rxq5s3GnsQ47PZzCAWql9klXupjlzktRypmrYtkBJkFQ2tZ
 3uidIqRZ9P4M+WhE2Jjw67QvRLr8KtUrOTsisXrvluWBZSiVe418tD5Gp0VJnktgFASW313Ho
 dCzRkxhin196/DzG/jVuSMhlAChd4F0hXj1IIS9jVHYH2bxvJQmIretuKdbsqOm0bwbNyFzuI
 462G/KnW4L4MzmU64pBj6F7yRq4jxeod/UR/62bTcmAlACzL3Jhk9ALrwrcE54Bqn7EOku+vJ
 LwT+HexucTdZyR6K/dxe9Yz30uv0rcvVMhlZC9MmDBUHv9mF1C9HKO9L7IGAwGmn50Si1LlOg
 ffhieqrg8OOOf/lNH6gjrSstk5aS1E

Hi Kry=C5=A1tof,

Am 27.11.24 um 15:21 schrieb Kry=C5=A1tof =C4=8Cern=C3=BD:
> I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>> @@ -457,6 +459,10 @@ static int ds2482_probe(struct i2c_client *client)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 ret =3D devm_regulator_get_enable(&client->d=
ev, "vcc");
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&clien=
t->dev, ret, "Failed to enable
>> regulator\n");
>
> This will cause a memory leak of `data`, I would refactor the driver a
> bit in the next patch revision. Should I create a separate commit that
> switches from kzalloc() to devm_kzalloc() or keep it in patch 2/3? The
> separate commits way seems correct to me, so it is clearly
> distinguished. Sorry that I missed it.
I'm not the maintainer, but i suggests to send a V5 and add a separate
commit to avoid this issue. The merge window is still open.

Best regards
>
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->client =3D client;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_set_clientdata(client, data);
>
> Best regards,
> Kry=C5=A1tof =C4=8Cern=C3=BD


