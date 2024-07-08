Return-Path: <linux-kernel+bounces-244627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBF92A716
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6321C20B88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02907146A79;
	Mon,  8 Jul 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UxmC4VLq"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7026AC1;
	Mon,  8 Jul 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455261; cv=none; b=FDeU+vV9Fw8DLXiNs6K4ndUYtoN4I0ti19SeaHjzr1NHRkSbmv/BK488Z41GTDpmFOuGsYoV1RtddzC9Gc69vQOBeQM8JwOwzvB/t3nVRjwLbtxZomAZ9p1FY4BbcaXUNUPOcEJdpggx7RHLBJeNC5QS4MKzSA/IbYvdL0SNxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455261; c=relaxed/simple;
	bh=Oj+LJfA/guoAC400tFG193xrCb8ZJTDOz9rrIUWrxeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf3ZI8lf2aetMsD80aRT30NtTkr4qmu7OLbhZ7EHlIGSQNic+A6YYiJVm57NL/OH/1LKKz5Juw/fEG5xW/G17BLWuL0nQupQXCfORi3/29o9Pb9u0TcZYYcFhvZ640y6MCOspLfrBqYGzy9EGSvPE1lgC1S8HqQy7DXSBF10u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UxmC4VLq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720455242; x=1721060042; i=wahrenst@gmx.net;
	bh=LvsGA+5lxztFeqMSYPXAO1R96pOGSaWSKcPKJlckM9k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UxmC4VLqE728ln9L2m96AX83XHGG2mUBSfomM1jB5TGWOxxb54yYcS+sYg6QkO0Y
	 Ebl3Qn0MdAfbhl8VVKBCrlA+nwy+28YQdpOjEDq0qH0h2/93yymaIqq+omj3CsAOp
	 aFfAIu5JyyBAFf1VmzlLfwmUghioHZNg7rpmXFbtzPYUjWYlsEd1mYBqIzWeaVcUQ
	 aVFjxcnIjrCU9HdQ9ZCxzty/SUQB+6Ulc0WFUoo6HdQwPlIt4ufuvRQjsHab3ssBA
	 fU5RwdJ+0RIsG5wa/fa16Q8Rqe8bEhuKlz8txvX50fr9SaiK4Wo1NZ8TIFP85sp6I
	 jeqop7B/SBKmV9lLHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1sg3vx0v5r-00KEGv; Mon, 08
 Jul 2024 18:14:02 +0200
Message-ID: <b1cc367d-6782-4116-b3e7-3dd12e83032e@gmx.net>
Date: Mon, 8 Jul 2024 18:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: Expose Raspberry Pi revision code in
 /proc/cpuinfo
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYfCnyHefUSlXMC0AN1sF0o29rtc9Up4kC3uOgQipZgGkpcBYvx
 M1v1on/tHtXDDvKfC/ElasbzmtBZaeB0DFc7NzKYQzmSwzrtH29ZaGWRBe5W5u+OMUhhsnN
 ZU+10xhGH0FI9LpUHjV/ZaeFy7wIFuVZHY9IP5Q1E0tFGBDRaz3T+kdPFfJIxdehUegvuXP
 zMcDh/0vHoODdDMwAB5FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bPZZAk+L7I8=;YwPagYDr1yYhcFbDWY2BPdRj3Pg
 FhXMSGDRt07gnm/h4qbmGf3Eta5HPlkY27Go3R9D3WACoiKvGrZQ7/5d2J5Zxao2Zya9n/d8C
 84LkOqeC4WWiRuc/ztJkBDIXI67+2HKbvfo4GU7MfuqbeM0zCaTwe3E1k0/3CAudmsewc16gg
 JeVLIOIkAlSZxFgGIAvj5XVnqtG6q/Rx4ucLv1ty7JYozlzYUmu51M+ccRon/YZ5OAGBl5VJD
 N7SODaAwAUY1VtjLOSEc6sztsd3dli+R+8jQFObUmm80zbIEDhXssyk8iXf3OyL+K55Cec3s1
 o+Fxh95m+WSP+fWJ+t2B22kjRKDWm4eTRTlUjIbV02pNRcQlEjV3xd2aJpTtkaS0O3FLuLQE0
 +TLTdTCHOjrh3b9yxNTN4As56i80Dm5lsYZ8neekmWUuX0/h2bVwKq0OFDJtvEKoc3cmRtjXz
 UKPjaOpvDX6KrsiUiAMreBYMZwRbLxti1OZtmbqTk4sd588dE78z895Qszp6Q48H/mj4pOdxA
 nFna9uyoL2baeTDrOqEfGly7MYJHoy0u1EF67NY2TB4sI9+VYBio6XXjOhSwfNAZoKd5BZydp
 6FMrJT/KK0Vybo+xriztiLmRCyoeldTl45P2J8WrVVIUQ6e/B5LS0y4ljgcHUpwzXj1EO5ISR
 pYdwWlID5zMDaTDc+cn8/6g7n/ZHviiajdqmgtjqGWMSwBvZh6O5HZ17DPjkqLLiSzi09lis4
 /AGG4bS6O3Ni8DKpwZMx3EdyYtICQFdEcP67oXLLgmmspc4IdsxTnEHqGj84UiYuFGKkkF6IE
 ZLtskrDvxKpexLm9uylcTEY+0VJEAC9Sm3DmlH4UkXaQM=

Hi Jonathan,

Am 08.07.24 um 01:08 schrieb Jonathan Neusch=C3=A4fer:
> Raspberry Pi boards have a "revision code", documented here:
>
>    https://www.raspberrypi.com/documentation/computers/raspberry-pi.html=
#new-style-revision-codes
AFAIK these revision codes mostly refer to the board and not to the CPU.
The abuse of /proc/cpuinfo has been rejected in the past and from my
understanding this applies also in this case.
> This patch copies what the downstream kernel does and reads it from the
> devicetree property /system/linux,revision. This enables some software
> to work as intended on mainline kernels:
>
>    https://github.com/hzeller/rpi-rgb-led-matrix/blob/a3eea997a9254b83ab=
2de97ae80d83588f696387/lib/gpio.cc#L247
This is a bad example because the application doesn't really care about
the kernel and directly access the hardware registers via /dev/mem. A
proper application would use the dedicated userspace API (GPIO Character
Device or PWM). I would bet that the application does not work with the
Raspberry Pi 5.

Regards
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
> Jonathan Neusch=C3=A4fer (2):
>        dt-bindings: arm: bcm2835: Specify /system/linux,revision propert=
y
>        ARM: bcm2835: Detect system revision
>
>   Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 12 ++++++++++=
++
>   arch/arm/mach-bcm/board_bcm2835.c                      | 11 ++++++++++=
+
>   2 files changed, 23 insertions(+)
> ---
> base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
> change-id: 20240707-raspi-revision-84dffdfaebce
>
> Best regards,
> --
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>


