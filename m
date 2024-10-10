Return-Path: <linux-kernel+bounces-359862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DE899919C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9FB1C2098F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067F1E491B;
	Thu, 10 Oct 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="hQTKgnTL"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEC1CCEF0;
	Thu, 10 Oct 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586235; cv=none; b=joEykIkDpLc9hgbF+W0AyYAz2pfxvJLl8nH84R5lQaSdPMtfnDC8qs9DgNB1lY7vI9tXzkD21PML3yl8ROUSRUy4PsCBV9w84W3KLWhWSDR6V0Zs1ChPHvUqiisM5JEthYHahJjZh0V/Bb1Xy2R2+frwsGwuOPDk7seh9dghg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586235; c=relaxed/simple;
	bh=cFgwN1Zqbv065Ue+yTv/+K2fBC6AtCPgR/dTOKr92SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3UN+j2gIWAcpl5ebDriHuJN7AwBHRfFVsGrApMB9JMQq87wSx6ac5Yzl3a7xjWASRPe5L/oFVPy/mHmrZrJ38jl8r16H3eeDINfA1A6BOXOlNU1UQIXmVWKcJ83kfGX73LkSAgTH8IZyXW4pO9Bj+H6ooYTwg0RQl4XvwCOdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=hQTKgnTL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728586224; x=1729191024; i=deller@gmx.de;
	bh=viXXY+/S91oFXXgAqWA9R8jZvbFYmx2wdv/2VfuZ5mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hQTKgnTLY24THrvghsU4qTo/99g7O+nXgNgPM/3aZNqpcY1eZtMiLEGKvVGH0grX
	 MxSysILh8ocDOqjZnEWsHBig4A7gxC0eJcnex8R1lW84JB9O7DOh8THDUvC+z5CeF
	 39d9AViZpnMYVd0Jz/8RJHvzS9kmaGlzmlYPi/WS1j8abPut+lTEuilzawfE7C/1a
	 IjEvwZDxqYzBOgiU2T3oKIXWc3EPz1iBBa7Ps5FP0i6n4ZArqNGWN5KIrcxPJZ8Hp
	 UYv70REkEQhqzbYqlvkMRS16eJsFqKC/THXI7+QQS4e8JbyJ2pRBLSXhiyhSPH4B1
	 drpS/qS1dfzhf/6/RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1tJ8ac3dFp-00Kcc3; Thu, 10
 Oct 2024 20:50:23 +0200
Message-ID: <b7d176a1-9a12-4e6a-894d-7b71087a5560@gmx.de>
Date: Thu, 10 Oct 2024 20:50:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: lba_pci: remove unused macro
To: Ba Jing <bajing@cmss.chinamobile.com>,
 James.Bottomley@HansenPartnership.com
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008072620.38663-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241008072620.38663-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cm0pGSajlpGC0fkhgAviBS7P39tqmUZAkSpr8PWGdVU19dDN4hN
 DiJ3018Vv5w6Sz8EDJNUameXUxKFS+a+5rHd1byptFF1wMHYGb5Fupek8j63H4Yh5C62vB1
 suYF5YOenDCkQkpJwiZ1D4LEcCJFWNg+yGhkwqm4m7LcDL5rGTnRRqxkUKR56E4O2PVuadX
 AIl/IeD3WaFptSF2Mwn8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dn6moj5KnQk=;1BaeYEJCI7zLiV7ncrSCdu59Izg
 8p3+Sa6MPYXjvpZY+KirmWpcuipmTJthwNy9wVs93zHqyoRkWPt4IWZ7sqQ0bk5KAESFvYhtV
 kvt6slDr01M8AQ1wyIJ7rp0lguzeFYcgUcbgrfQvY1jt5irUbDfHlVPMxGg8jUuPuv0h+xUPt
 4OXyF6j82iNxfGyD2Vo8HH9ANabdjhyf4jb8XBYFSGA5gyEwGv2rFsSOAhtGegjfFS8M7bd+i
 Oao46po33wBVLuEznZRNWPa+l0LC7SaIMU2DlSRYSPe9YIbAhVSAiPZfv/Ao6O+WVjqkJy1KP
 VuA+PFrejmQWaYSDf/EcUZeN4TqcMlALYgvkRM1BspJkse2tSYUsR0tEgps2blg2rEU+5P8F0
 AaBtonDR7tYddlIR1yAKb+93/5nvV89MI3GjqLBvNBjtPC6+P1hUj5mUzeJvyeg8Mpw8pugMe
 0x6gyU4YXUD4fad/1ZylLYGgvzaHt/4BRzLj0kjDBCDpjFKJO2BKhlfevE9AiZbBLRv2/HJJC
 l7jN1Hcqps0P/H+JQn5edcAlKysvQWxMHf6BAfaQCMLdVm3I6VyvBDI31oOvhxGqzs9HCS6Fb
 CZ+Sz5ANFdJL+GGYGBgza/ox8cuZVrcE5PJiyFf0vZWoh9i0XyAkOo7XH6yoj1HLjYlwMnlP1
 09MZUQRSV0ukjvY5tEB59CCEdp5jVbiZlLU+dT9Fi9LmF0PpKEG+qXo2KUTn9M9QkO1GjqIGm
 V48EWeIkpOJ1oz68QstR3w6yI8oABqpDuTMrhcI0iSlilfnVwbM9amOIxhW2kHurwKQIKAF2U
 f8+/VPYa9NGETSxpz8lu1wNQ==

Hello Ba Jing,

On 10/8/24 09:26, Ba Jing wrote:
> By reading the code, I found the macro LBA_MASTER_ABORT_ERROR
> is never referenced in the code. Just remove it.

Thanks for your patch!

Of course you are right and this macro/constant is currently
unused, but it may become very useful when trying to debug this
code. In that case it's good to know that value without need to
look everything up again.

So, as there is not much gain in dropping this constant I plan
to keep it here and will not apply your patch.

Similar for the other patch you sent.

Anyway, thanks for spotting this. Maybe you find other more
useful possible code optimizations.

Helge


> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   drivers/parisc/lba_pci.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
> index 3fc3765fddaa..5990766b6561 100644
> --- a/drivers/parisc/lba_pci.c
> +++ b/drivers/parisc/lba_pci.c
> @@ -277,7 +277,6 @@ static int lba_device_present(u8 bus, u8 dfn, struct=
 lba_device *d)
>    *		smart mode as well.
>    */
>
> -#define LBA_MASTER_ABORT_ERROR 0xc
>   #define LBA_FATAL_ERROR 0x10
>
>   #define LBA_CFG_MASTER_ABORT_CHECK(d, base, tok, error) {		\


