Return-Path: <linux-kernel+bounces-394769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E409BB3B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586CEB236B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F81B21BC;
	Mon,  4 Nov 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="P27KsnWv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26A17965E;
	Mon,  4 Nov 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720420; cv=none; b=syYDeOP8GpIW3LRC9Q+wxZ9WXuNIRdfHKAzPl42hjAKL/p1Y8L5RS9r1vxAkJ/Cnh8cS3xPZM6v3MsrSb68bQ3wbkeobuapZPAcF0RZZP4ZSSgIufPl78OLiziwiEMghlDmvmIMr64TmaKQisxuudxx3hqo3zBc7NDGxVVgr6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720420; c=relaxed/simple;
	bh=c57Zoi8U0JO0A7Jhh061HUAgGo7tbiZ8WkPLhNfNZV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka8ewuKYL/sDLmGatuYqEN5NPh45zN9Gqepam3iNt34D0NwjduagarzjqNjonRq1benVJDQihn+0HunQk5H+Z5ddz6xwqnKo8INJ6CKURvUbPhTSBK4nMDWFXhWpNIr8FWbT5RLhWuKKzNT/QbUeCrXmVXPmMaFe2HgXHjb+CZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=P27KsnWv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730720381; x=1731325181; i=wahrenst@gmx.net;
	bh=b/8Rj+ll4xmJpAgQwRFULejLJ462aBUN9BpO1b7fUiI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P27KsnWvXb3p8seK7CdTpQwZJv+ajTYoGusu45XUUvcg9pEwFUhwLJElBwooJDvz
	 YqlD1mGexa83y5y0vniGfg3cXSjrqtaZX9/2nFaqpNAr9C0rlMO65BultHblIM88M
	 2zYJW5M/+NxCoRte76rJbnm6Wlcr5CuKSoD32i1Y6KX70b8wvSB5GV+r1/lLgg7tR
	 Nj9XysPNAeUVSZ163uW7bGWeGkLKINEW6T597vAZJ3H95dOgy1DLuhzq6zWvrnxrA
	 0n9F+raM2VBD4LNGisSzRTnMHGKQ+nu1PAmEYecR32fjCwQ9CCn79EAmE9gBB1NYJ
	 JS3bm9TanNOG7jGSCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1t4Ztx2DCe-001TxB; Mon, 04
 Nov 2024 12:39:41 +0100
Message-ID: <787b45a1-9f8d-493d-8930-e1c8d396c818@gmx.net>
Date: Mon, 4 Nov 2024 12:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Shawn Guo <shawnguo2@yeah.net>, linux@armlinux.org.uk,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, elinor.montmasson@savoirfairelinux.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon> <ZyY41nJY9ghwe-Y4@eichest-laptop>
 <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>
 <ZyiAMpjmXuVMi5FX@eichest-laptop>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZyiAMpjmXuVMi5FX@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/Ff28dwutGChcGoN0CcwsmrcFyQ0cuAnKhb/YZT6ZjH0zaQ0pp
 ZFZFY8D5HTEuTp8ow/BpcV9BFi6nixpw/w4wL8cj1SnGYC0Dvv08URliCvK5/1xAXKW8gX8
 ZE3aMei11B8xUEHC8ozZe0+E3Iz0tYY21P+7VRm6gFjTKxGik6fQUPJjMLjGuWyWo+wMQ7/
 v55ovpJ87i9Z5mR9jU78Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:USca7qz7HGU=;jP9qSUW+W0J7zyAKcKBoMjwUm4p
 Lo0q+L660AgjqhYFXdhddQ2G1A/003kLKpgOV6b8XklfW4yDsqRTyNfibQnc6icnJ0hakOeZJ
 ZTyEzaeLTMTqTnK85K7f/jRiL6gBELdWEeALXK7GwLH3537A04jJKDsA8h88/iNl2WRZ6y/Md
 BvLK+owpesJpme2sWT/Q+n6Uk/XShUU2AYU1wMfzu0xuL8F2oTmv+7rGmcAyPtXb+E70UtXk7
 XOQJMkzK1mT6NqeMTK+5jJYQh1St39Ug11NAZ4BxmGAq8PCOLenKmtIRddqgt3SMUITDd2pjl
 ckYs5ey92mhnqEWOaAnKVeM/ep432mQ2GsYJXL6oAa/dfuzkHYNx2OH7K+ISSw5jDiC3TfGVe
 0fGggUjAqF1GXRmrU2XXVuYqNcMRNm432VWrua+5edvFW/Q09QIX3bsZnZJeC2b0s/g8nM3yn
 RX7Zpl/AMpmsH2jMfzBLjR3Q6zjC1LDLj6XmabduI0t8P2W6Y4xEyj0KgFg8FgxtuABRecF3g
 TpBiZw4+4LOp8S3ojfhkkxUNVzzuVyH2r2S2SojSn8L42U+5gA/tl6RlUSqoEkk+g2HNUWHDq
 hvMKPj2baCj7GB7Q3UCsW3/3LAgRMjXdgHZMxnVWNG4X6gy5l8/IweRWlxROmLaMh4QWRUx6s
 +dtQs61hNZi6hsQP/fiM1yOXHOM0ZWRa7CgQ/xI+lIErTm/NpgtHzNG/W7RPVcTIQMv6fINFY
 5r09LJwrRikMivkWzwdD6ehWlsB6wWJ8HJgQ+2wFD4QN7lwhxPDEy6H7dSHjBwzaYN62nsMi4
 OfYLkJfNSh0o27ZWV5voGlJQ==

Hi Stefan,

Am 04.11.24 um 09:05 schrieb Stefan Eichenberger:
> Hi Stefan,
>
> On Sat, Nov 02, 2024 at 04:35:19PM +0100, Stefan Wahren wrote:
>> Hi Stefan,
>>
>> Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
>>> Hi Shawn,
>>>
>>> On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
>>>> On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>
>>>>> Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. =
This
>>>>> change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif s=
ound
>>>>> card node properties") which moves away from the old "spdif-controll=
er"
>>>>> property to the new "audio-codec" property.
>>>>>
>>>>> Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node p=
roperties")
>>>> It doesn't look a fix to me.
>>> I agree somehow, it was just that before the referenced commit our tes=
t
>>> succeeds with the imx_v6_v7_defconfig and after that we get the
>>> following error:
>>> [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-=
card: snd_soc_register_card failed
>> this error should have been in the commit message including the
>> information which platform/board is affected.
> Okay, I will add this information to the next version. We see this error
> on an Apalis iMX6 which has in my variant an NXP i.MX6Q SoC.
>
>>> So maybe it is not a fix in the sense of a bug, but it fixes the error
>>> message. However, I'm also fine with removing the Fixes tag.
>> But this patch doesn't look like the real approach.
>>
>> Could you please clarify the impact of the regression?
> So the problem is that before commit d469b771afe1 ("ARM: dts: imx6:
> update spdif sound card node properties") the audio driver was
> using an implementation of linux,spdif-dit and linux,spdif-dir which was
> directly inside the fsl,imx-audio-spdif compatible driver. Now with the
> referenced commit the idea is to use the more generic linux,spdif-dir
> and linux,spdif-dit compatible drivers. That's why this driver must be
> enabled in the kernel configuration.
>
>> Is it just this error message and audio works fine or is audio also bro=
ken?
> It is not just the error message, audio is not working because the
> driver deferes and because it is not enabled it will never succeed to
> load. I don't know if this is called a regression, because the driver is
> there it is just not enabled in the imx6_v7_defconfig. I thought because
> a lot of the i.MX6 based board use the generic driver, it makes sense to
> enable it in the imx_v6_v7_defconfig.
okay, thanks for the clarification. From my understanding
imx6_v7_defconfig is just an example config for testing. All possible
users of these boards might have their own configs and stumble across
the same issue. So I thought it would be better to add the dependency in
the Kconfig of the FSL audio driver.

I'm not that audio driver expert and don't know how the dependency
handling between the FSL audio driver and the required codecs like
SND_SOC_SPDIF. So it's possible that I'm completely wrong here and your
approach is the best we can do.

Best regards

