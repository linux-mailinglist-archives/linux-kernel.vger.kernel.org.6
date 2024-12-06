Return-Path: <linux-kernel+bounces-435454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F299E77EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0433284E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E98204563;
	Fri,  6 Dec 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VOJX02fW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AE204564;
	Fri,  6 Dec 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508909; cv=none; b=qAZnRhrB2MzkXDoqPX6lBDsL07rxmQGxOty073FaF/gflip0XjaPu5Mxa8OEyq8u1c+ljUAv1Ak8mOmVPPAeawy+AzvJ0oNvrQR2rr66CXyO1Dq0UqCeTUgcKgP0nfDUeJsck5JA5R5SHGc1r4foA/FH9eyld6GjqfKTAMAH920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508909; c=relaxed/simple;
	bh=acY9QYkkj2FPlaqOV9k2ALcWmvnYFb5Djq/L+K2WqAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbAs35zQnq7MYdk8DE323BUudSMDCRG6y4HnWrSQPlUEbJ+A9MHzti38YYEe4lSUAcCuAAjVuHvzjq/ZA6m4mojlNsTa8mKIwIuX4dSzWBbafU2NkgyR8l4yprFanTA68lGK7Vvc6acCfWi/3SQdD2B8QCMnFgoEV8yE9BHuAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VOJX02fW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733508904; x=1734113704; i=w_armin@gmx.de;
	bh=acY9QYkkj2FPlaqOV9k2ALcWmvnYFb5Djq/L+K2WqAI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VOJX02fW6UMM2Ig/br6qRyauJ1QF8JLVRmHy9HCTz48Wd6rZf2CAVcGTa1w5BXC4
	 bKSa6IygSk9xoecARwW1H48FfWdg6SwLMwyx/edxunPtgPnCdZum+64UoxPeytZ+x
	 5h0V7HDswvlIDJiEFJYVdRq+JFlZSP81LtXDwoAXE95EU3jGrJc2fpGS3bYKlbzLY
	 taZPbtLE4GTWCCrniGmax64xw88EWo7KtvZ7TRwi+EFIOCMidKb0edfNcM4ISOfLp
	 clHDIjxTNwDsRGB1zjBP7JGFedHMvdf/7RWcE+VRzTNZdHUHVBZVe8lIcOEusBKvx
	 oHOXWW15x8x4tXT0vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1syUyT2l2j-00SMxY; Fri, 06
 Dec 2024 19:15:04 +0100
Message-ID: <bf3b9efd-6700-485a-bd0e-f81de1e11fcf@gmx.de>
Date: Fri, 6 Dec 2024 19:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] asus-wmi driver fails on my laptop
To: Yura Strilets <yurastr100@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <33bfcda8-3d3d-46b9-84f0-44e0e9f44230@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <33bfcda8-3d3d-46b9-84f0-44e0e9f44230@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqhSvlqpwvBpTYv7338/mK4fck667VMNfCQkH9+BWs/WWr9tOGZ
 +Rd8cc5JI9glx4k3ekGfxdwTwKxC4mUCDUGKnc5pnRZL3X4+ZnInmS+EbXrIkacJC1quNxb
 sPRgvFLJ1QuWLIlNV7869HvEP7+LmUOIKTa5RrC0eRgpoUUBeMCOYSlQrzirFS3U1MqEWLN
 A/yKWS/tcUasqVBhhlyJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/mExfcB00e0=;wdRbfLWlH151AbiciLd3nOP3XG/
 W55jS0mdHCFOt3wrLDfv4a23GICYMdQRq3s4CPsX+B4BRqfDiVijBTWeDUlAdAcIN4saX0aXl
 Qlt82jvP5V6I4IpNTJXAiFpx1EkGdkMtsTmvK49kflN875VRJFhfVyOMyThm7MAxR7KaR9LE0
 e8IsUSQDJCRsSOjIAsTFoE+n2KNEyBd14dBkllBiQs3HxS46Z3py6mkD02HCjqVWCFlo46N8a
 FiQh1vEeGnLg9fszYcNXC8SvZNrBv1qxfC8ujCN6y+4YZH63+KGVNK5IiHY+EFxqTqJ6rsedO
 EiMr/Dk02IWW26gS6VWPdbGMKP4FrhbmIWS8Wfq7Pu37k81cfD9aK5pinYcFeQyZJZcxo/NL0
 YZPOfPIVTFnwS35TwGC4GMrsBdror3VF1o6Fa5EJtri+xisFDE9fxELB2ZUjKf84p3wH8v0Sc
 UvHFfRCRcgL+6UXOE41mlghuJQLmHFbqsZyDt2LoNljbSIOL7lw8rU47ZbvIV3zWMlD90eQo0
 RwhFQRPuE0p0w4Wzl3QWOl03jZNHi53QEam3Pi2qW3AihW2ARVbFZpQJluczZOAjVTKdzZuHD
 /waX4Bl+S3uyNhPCao76DhEAEKXwHyiTA630u6+kX3JaooQd158UeW2gKVeK69g7uqjIAQXfC
 LWvql5eeNaB7wfNd17ekBK3KujdgFYz5mKYbwo6izPpMzYx2cEI8IhWxXXCJUo4Ny8o1a8RhC
 cViLVl7Fk3XMxlIURC6OA/qpeRRKYHuJFBnv5T4rD5KS83OoJBnW3kJxXf7uJLTI9rfBFmSgN
 f3evI/Fav3i/QDunwRtyI/SV/YT/TIw5QLZ0u/7D5bNd1PsJ4SYXGvO6I3DvY8OOTuJcOo+uk
 5iM5xQkA/4ux+/zj4RBiwdxG5/mZ0DtqwAVshUs0dYY62AOdft2P1KovRDU6Q9UePkXZU5V7U
 evHy+Y7k1t9InBBDfkJDUhlMyML0VD9o7NPc6RHiLFKTQouHhibAhjeI8qRra+gYgnO+H6PXs
 /dNUXEyvA8lcHOhLu7zv1FN6IdXU0F+QgGsrTle2Fttbp5i7lLZTeAc3BGg8bbAXGdd53woVj
 XVyK5ZlNzJRiR5rHfQpPIMqiQq0yfw

Am 06.12.24 um 14:33 schrieb Yura Strilets:

> Hello,
>
> After upgrading from 6.11 to 6.12 a bunch of Fn+Fx buttons(touchpad,
> mic, kb backlight, my asus) stopped working and the
> /sys/(...)/asus::kbd_backlight interface is missing, which,
> considering the dmesg, looks like an asus-wmi driver issue.
>
> I've been able to bisect the issue to the commit
> [b012170fed282151f7ba8988a347670c299f5ab3] "platform/x86: asus-wmi:
> Fix thermal profile initialization"
>
> Additionally, here's some maybe-helpful information:
> my laptop's model -- ASUS Zenbook UX3402VA
> linux distro -- Arch Linux
> .config for bisection -- was taken from /proc/config.gz at 6.12.1 arch
> kernel(attached in [1]) and missing options are default
> dmesg logs -- The "grep asus" parts of both good and bad scenarios can
> be seen below and full logs are at [2] and [3]
>
> =3D=3D bad.log =3D=3D
> [=C2=A0=C2=A0=C2=A0 3.664546] asus_wmi: ASUS WMI generic driver loaded
> [=C2=A0=C2=A0=C2=A0 3.713358] asus_wmi: Initialization: 0x1
> [=C2=A0=C2=A0=C2=A0 3.714126] asus_wmi: SFUN value: 0x21
> [=C2=A0=C2=A0=C2=A0 3.714131] asus-nb-wmi asus-nb-wmi: Detected ATK, not=
 ASUSWMI, use
> DSTS
> [=C2=A0=C2=A0=C2=A0 3.757420] asus_wmi: Failed to set throttle thermal p=
olicy
> (retval): 0x0
> [=C2=A0=C2=A0=C2=A0 3.757425] asus_wmi: Failed to set default thermal pr=
ofile
> [=C2=A0=C2=A0=C2=A0 3.757429] asus-nb-wmi asus-nb-wmi: probe with driver=
 asus-nb-wmi
> failed with error -5
> =3D=3D end =3D=3D
>
> =3D=3D good.log =3D=3D
> [=C2=A0=C2=A0=C2=A0 4.557898] asus_wmi: ASUS WMI generic driver loaded
> [=C2=A0=C2=A0=C2=A0 4.776587] asus_wmi: Initialization: 0x1
> [=C2=A0=C2=A0=C2=A0 4.777253] asus_wmi: SFUN value: 0x21
> [=C2=A0=C2=A0=C2=A0 4.777256] asus-nb-wmi asus-nb-wmi: Detected ATK, not=
 ASUSWMI, use
> DSTS
> [=C2=A0=C2=A0=C2=A0 4.777258] asus-nb-wmi asus-nb-wmi: Detected ATK, ena=
ble event queue
> [=C2=A0=C2=A0=C2=A0 4.805497] input: Asus WMI hotkeys as
> /devices/platform/asus-nb-wmi/input/input15
> =3D=3D end =3D=3D
>
> [1] .config - https://pastebin.com/raw/3nDSV8Sm
> [2] bad.log - https://pastebin.com/raw/fvR5Sjzt
> [3] good.log - https://pastebin.com/raw/EazfLAWA
>
> Thanks,
> Yurii
>
I am aware of this issue, the necessary fix (commit 25fb5f47f34d) was alre=
ady submitted upstream and will likely
show up in the stable kernels soon.

Thanks,
Armin Wolf


