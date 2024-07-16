Return-Path: <linux-kernel+bounces-253364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F33932014
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2511F22CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83817BD2;
	Tue, 16 Jul 2024 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NWqxhtB7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469714265;
	Tue, 16 Jul 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107879; cv=none; b=a4lnmAQrRI5LImIIeECFSNE++6k7t2vllkYk/rVSddZCagb1ZuFtNuIo+EKTxt+riJjvWUX/Rx0fTG/AZxEoccwl9zqUiYgKB6QCTKNtd/OEvEl0MfuAsr0V9ZWQ15JP3E67Sdws15af9qklGHte4orq3BhkwDFlUc3wTeUwoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107879; c=relaxed/simple;
	bh=GEA9ENbhZWGDPmMJssjlNHfB+SDxG7pIhtmGNTTI+GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GrIIUXkDu/4J/EaCSwuhHymEgOmYemnNsyXklOZfr6hPX8bYdhXWC++XzOxrbxuD/i+U6WrXGsoTFXJDzFELk0MSkhoARImng4WSizCIB570YjIA+T+WmXjp5+UdtlxajNDIoXA0LLt+GdmNv+5f0SMjUKb1sWRiuVNNykFQEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NWqxhtB7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1721107833; x=1721712633; i=wahrenst@gmx.net;
	bh=GEA9ENbhZWGDPmMJssjlNHfB+SDxG7pIhtmGNTTI+GU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NWqxhtB7pWdhEg0wv9oAOJLva/dtCLW3J0lKRFabPWVxsVo3nuT0U56OvnNQGvAS
	 mpjUmc89IhVGpZ/0X6mhaQbyRk3hRvq3XVSJUDKj5ITezhOa0zxKPh83W/Vaak6wX
	 H5xrZWIHmaPFiB0Q7PIak0tBHjjD+1AdF3WutqJS5B9f4mDvjYhlWEvdXRvCdYC7H
	 dFQDTrd6lQHVUZ3dGpnW++hUBSreyXRCk9h0Jb9I3dgAahQH3IC/Klm1z+pnF9qjJ
	 JrVn9C5lRIiqPT9jdnFD0MusE0kvbOwW7miiV4F5UHMVSpiwXk9p7LxZwNV0Tgk7A
	 KbhQPZ1jLrMG3UDYgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1s6AIR0tfC-014AaU; Tue, 16
 Jul 2024 07:30:33 +0200
Message-ID: <e3872f3a-9736-4507-bbd3-2ad7698562b4@gmx.net>
Date: Tue, 16 Jul 2024 07:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
To: Florian Fainelli <f.fainelli@gmail.com>, Florian Klink
 <flokli@flokli.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240715230311.685641-1-flokli@flokli.de>
 <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ov6tpBP0d2OFeSZwwZ/gm/qKTDUvkrxB64dYB53gJH6A3CIFuKK
 VrydRCopr9lL7w+BEINTmhGfq4sSUgKMLhaUgmNbOcFvVmRD4PZxjCcO4RVQ7arwOMTEi0I
 Ry8a0TqX7+djp0WFFS7cl5w3vUzS6nzJiJejjfUdvtLPRp/mXAELrgRJFfDPvLjAmBU3Ds3
 UUZS0nreajzeEJi+0GpxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z30lAduWNCE=;fV0L35pAK3O51tYS5ZEfPlO5vJa
 tckhRHNLsxgh4GhkULVhwz7YfyqMrY9wlsfGX6D38W2TwTLgeh/YP21MzG2k26maw3ksEju14
 BezV1wUyq9ZDurBss4Cc4HOvOZJVTiBXrGT948NTSvDSO8PpyPwG4cAcO7Pj2MSMzUlqjU2IF
 TuIBVXNE/pD0iIUmwqks635Rqvun4TyCI/bnqD03uFA1Rb50rfjPen7VrE8Qdp7lA9FTJGOUm
 8Offb0K7m5NL0t2iwJ1Y81s2r4R1KczeVObdHN+WiwDxoimGNTXO5mn7x+kfPsnIyzChoNumO
 5Rgdaxc5lgL/JhgDJgLIOWmbjyQ70nRQg8FeTmaY3LUp0oUJClQpufU0nUxMCiURdH6CnbOta
 bzMA/iPrvMD15fBhOeM3xQh/qij1rh7IyqAwMH7tZEU1/Q09bPyCYpEolfSjZLr2BLLWYRfIz
 tI7b2/8xZnkZGENcNQua7KQf4k/pDvO9hinrb7mNCTZesF3mYmYprQJFSFKCzH6bN4JRsYIvM
 IGqc2gkNk+3w5C1+4bWtDfTwwpCHQpYzYEGGTVraPQ9xztHHiGa5qPD0gXhB6/An+yYNCKfLY
 H+nQmkWxL9ovXs37wth7NyThaBdkk6U6DnW+CGWlN7amhP/ENDBbKpFaRjxBtjfOYEidLyUE/
 IIwW9ix5FvnxjDIpRJflyFmTdQRFsrYXjFH5j/ecNN7PfAywgnt+FmktjI0m+gK23U3BWmq7X
 sqLrprHTX4r+Sj7pOxpf2cWHwhAULSJ7I60cQcKtCir0xjAYR4bsnj1wfwH+YHshxqib/RWLx
 nCo0xm3m97Mfax0HTC2Emr/w==

Hi,

Am 16.07.24 um 01:19 schrieb Florian Fainelli:
> +Stefan,
>
> On 7/15/24 16:03, Florian Klink wrote:
>> HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.
>>
>> This fixes HDMI hotplug/output detection.
>>
>> See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf
>>
>> Signed-off-by: Florian Klink <flokli@flokli.de>
>
> Assuming Stefan is OK wit the change, I will apply this along with a:
>
> Fixes: a54fe8a6cf66 ("ARM: dts: add Raspberry Pi Compute Module 3 and
> IO board")
thanks for fixing and i'm fine with this change. The GPIO line names are
already correct.

Maybe the subject should be more specific:

ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Except of this:

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Regards
>
>> ---
>> =C2=A0 arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> index 72d26d130efa..85f54fa595aa 100644
>> --- a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> +++ b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> @@ -77,7 +77,7 @@ &gpio {
>> =C2=A0 };
>> =C2=A0 =C2=A0 &hdmi {
>> -=C2=A0=C2=A0=C2=A0 hpd-gpios =3D <&expgpio 1 GPIO_ACTIVE_LOW>;
>> +=C2=A0=C2=A0=C2=A0 hpd-gpios =3D <&expgpio 0 GPIO_ACTIVE_LOW>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power-domains =3D <&power RPI_POWER_DOMA=
IN_HDMI>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>> =C2=A0 };
>


