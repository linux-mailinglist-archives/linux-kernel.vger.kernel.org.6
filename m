Return-Path: <linux-kernel+bounces-320144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EA99706A7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10F5B21665
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CC1509B0;
	Sun,  8 Sep 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Te4cUR0Z"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2514E2EF;
	Sun,  8 Sep 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792082; cv=none; b=T1IdRY/J3ddmn/lv7LjhBi9geQxVVU1rcuul5Z+qbM9qWlRtJMclWXbX3huwgylPFHrgKZbIHT6RZjnKQojtt3vFZcragCIhQT6zHQkgvNBL3wIed640tAmh/dkZHCb6uxx0wVT1OwsiMfYvGpwWAyJcVEyzI2YC8Kqi7iB/DDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792082; c=relaxed/simple;
	bh=SIx70ERL/JQKB7CyDIc/XfZXKI0K0q6I9jq3FYhYevY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9F1l+zoht/Za1lVil5rK1n73u4QGN7iGhfZxNLTTelJYHn4V/r4i9VNxHo5CZnew5eZA36YrwYwsV/HloA5ajxSzvPzHc8SbpWUwCqDBTzyR4VG3f6sjGaxEQsWF8yEkjzMJ3h6QPsfOflDr72lgWg7gZerWzfnmhV2OWDSog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Te4cUR0Z; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725792068; x=1726396868; i=wahrenst@gmx.net;
	bh=SIx70ERL/JQKB7CyDIc/XfZXKI0K0q6I9jq3FYhYevY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Te4cUR0Z2jBibzIF4oLtyfj1s46+j/gY/5jUlTgnoQKhzjt0rCOMgo/34sKZGDA+
	 IJ9NsWVlWpoOIqt0+aD8ODnHdbmyXy4TIAUj16bPBj3aZig6ipX5UbxFezfxgDMEA
	 jsaQbBO3JDHmy1QTu9TRYggRzRK6mfjYOyWuAo7Lb1XhDDJv1oXn3dPNBgNpZKaMa
	 jZvgQ8+2kolMQcbsLpGRxGeqa1A6aYFMiPItUTs5gNWzfMwvgJp1tZqMiNP8cvlRK
	 cJgbw1wxXL/8wJ3Xhi8ynkA92DwIK2PiPjFN2SCp4W74Agt7xlf4PrHmLLFfcovFZ
	 UKdF7sMcBIGXUK+M6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.128] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1sjeqv0F3N-003eOW; Sun, 08
 Sep 2024 12:41:08 +0200
Message-ID: <c7e302b6-fc62-4754-ab1d-7c2771cccf60@gmx.net>
Date: Sun, 8 Sep 2024 12:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] staging: vchiq_core: Factor out bulk transfer for
 blocking mode
To: Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20240906072506.174026-1-umang.jain@ideasonboard.com>
 <20240906072506.174026-4-umang.jain@ideasonboard.com>
 <5e3f9758-e392-44af-83c4-e60714046708@gmx.net>
 <2f5af934-de4a-4548-ac59-f23c3ae0f54e@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <2f5af934-de4a-4548-ac59-f23c3ae0f54e@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5ag+yar9VbvCZJx2KrkUY3NgHVgzEl93RkyEb+ysX3jtlDIj7z
 b1RzHCv5QozqmvcXMOF2omRhk51bOEKBbd/yXxJ61yENDie63R1Q2a/fEaCgdAx7SeVaa4K
 pUvQe/SdiabObPCPMAQAwelfRD/Mo3A2ki4VBPf5Hx9jUDsyz5pgMmKPny7AHD8HBXuTk4c
 G7OqShMMNN7E0SK15fq2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mX0rXUukPB4=;8hQ5wngErmNoi15rt/q9XoYVRMA
 aCAkJJ98JTgaaDPnwqAB9RXcFEiKd7rPJVVHnDQFyOM83EYjT3Udx2YerN9U5ZIzew30OuF1R
 QB9CBu7lMg6Sg8jxkIM8q0s4yMvMHWAQ3DC16vcdf3HRHT+ofPEy/42QIb1OQJHAzJ1ewFfKl
 oxI9RIM59uDjFAXrvAXCeybMI+6LezCX7lXF8RWjfUBC4pYbZw/E5zcCNILTkc30vMiwin2dn
 g2RJuoSyYCALvy2vnLLce6gBjg8nhOR1pdBqU7nJ2bgDukaQUyMuUjJ+jVRDw3380gLuGFHTn
 etvnL+s3/lkU5e5RQAb4p3UQOe6HFFnc33VTW5Nf3G0+/HQuB9bmDyC79/uYouhToXsD6chss
 6rjWoFmnw4sI9fTd6MxuMaOqJfii2+Yg91f7T72orOxVw6oMEqcdVFEWx9gAx9qE62vX8p5RT
 D15PJrJ5rH9wb1ueyXKbtOd/EtEEfTe/TwYqRdp2sSz1qVUkZ4um4KQirdQ0wT3IMeM2gIeDg
 DA5OCrOKGY9DOZAHQ373TfjE9oPIlJNXtC995IpigtwOmCOq/RRLzxe0pFHc0CpcNO0WSW5D4
 jEccZXPO2XpGjZ1KXWLdV4NCvBB5VTPGjgGANO6Ji9tK9DYhfgyI9fOBOJtz9UNW+n2VJ7NeI
 2qG1QAvRbWJOpp8kAXkmm/PeOrd9vMYkz69xRLvJSN03gWe/KLwZjGP8pAOqztlJhR8aX1rUN
 yUsAdsNruFU8ZkVVoAqY6gIm4KbWrDbzIKkikEgtOpx7a3Sx4POOgkwO2MZCMHPyHWlcsrEwr
 /yiMbIN2xGVjCidpokTXNaqw==

Hi Umang,

Am 07.09.24 um 20:26 schrieb Umang Jain:
> Hi Stefan
>
> On 07/09/24 5:19 pm, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 06.09.24 um 09:25 schrieb Umang Jain:
>>> Factor out bulk transfer for blocking mode into a separate dedicated
>>> function bulk_xfer_blocking_interruptible(). It is suffixed by
>>> "_interruptible" to denote that it can be interrupted and -EAGAIN
>>> can be returned. It would be up to the users of the function to retry
>>> the call in those cases.
>>>
>>> Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
>>> for blocking bulk transfers.
>>>
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> i applied this series on top of recent linux-next and the vchiq ping
>> test on Raspberry Pi 3 B Plus (multi_v7_defconfig) crashes or hanges
>> strangly.
>
> This is really annoying. The behavior is non-deterministic
>
> I tested this repeatedly and I see the hang on my 3rd ping test.
> The first 2 ping tests completed successfully.
>
> Here is the output for all 3 tries:
>
> https://paste.debian.net/plain/1328739
>
> I'll take a look and fix it in next version.
I was too imprecise with my information.

Just try "vchiq_test -p" which makes a big difference in reproducibility.

Best regards
>
>>
>> I bisected the issue to this patch, but it's possible the root cause
>> might be introduced before.
>>
>> But i'm pretty sure that the series introduced the regression.
>>
>> Sorry, i don't have the time analyse this issue deeper.
>>
>> Best regards
>>> ---
>>> =C2=A0 .../interface/vchiq_arm/vchiq_arm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +--
>>> =C2=A0 .../interface/vchiq_arm/vchiq_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42
>>> ++++++++++++++++---
>>> =C2=A0 .../interface/vchiq_arm/vchiq_core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++
>>> =C2=A0 .../interface/vchiq_arm/vchiq_dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
>>> =C2=A0 4 files changed, 49 insertions(+), 9 deletions(-)
>>>
>>> diff --git
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> index c4d97dbf6ba8..688c9b1be868 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> @@ -968,9 +968,8 @@ vchiq_blocking_bulk_transfer(struct
>>> vchiq_instance *instance, unsigned int handl
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENOMEM;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 ret =3D vchiq_bulk_transfer(instance, handle, data=
, NULL, size,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &waiter->bulk_waiter,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VCHIQ_BULK_MODE_BLOCKING, dir);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D vchiq_bulk_xfer_blocking_interruptible(ins=
tance, handle,
>>> data, NULL, size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &waiter->bulk_waiter, dir);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((ret !=3D -EAGAIN) || fatal_signal_=
pending(current) ||
>>> !waiter->bulk_waiter.bulk) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vchiq_bu=
lk *bulk =3D waiter->bulk_waiter.bulk;
>>>
>>> diff --git
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> index f36044bab194..43f951fa4b89 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> @@ -2985,6 +2985,42 @@ vchiq_remove_service(struct vchiq_instance
>>> *instance, unsigned int handle)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>>> =C2=A0 }
>>>
>>> +int
>>> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance
>>> *instance, unsigned int handle,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *offs=
et, void __user *uoffset, int size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __use=
r *userdata, enum vchiq_bulk_dir dir)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct vchiq_service *service =3D
>>> find_service_by_handle(instance, handle);
>>> +=C2=A0=C2=A0=C2=A0 struct bulk_waiter *bulk_waiter;
>>> +=C2=A0=C2=A0=C2=A0 enum vchiq_bulk_mode mode =3D VCHIQ_BULK_MODE_BLOC=
KING;
>>> +=C2=A0=C2=A0=C2=A0 int status =3D -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!service)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (service->srvstate !=3D VCHIQ_SRVSTATE_OPEN)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_exit;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!offset && !uoffset)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_exit;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (vchiq_check_service(service))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_exit;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bulk_waiter =3D userdata;
>>> +=C2=A0=C2=A0=C2=A0 init_completion(&bulk_waiter->event);
>>> +=C2=A0=C2=A0=C2=A0 bulk_waiter->actual =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 bulk_waiter->bulk =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 status =3D vchiq_bulk_xfer_queue_msg_interruptible=
(service,
>>> offset, uoffset, size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 userdata, mode, dir);
>>> +
>>> +error_exit:
>>> +=C2=A0=C2=A0=C2=A0 vchiq_service_put(service);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return status;
>>> +}
>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * This function may be called by kernel threads or user t=
hreads.
>>> =C2=A0=C2=A0 * User threads may receive -EAGAIN to indicate that a sig=
nal has
>>> been
>>> @@ -3018,12 +3054,6 @@ int vchiq_bulk_transfer(struct vchiq_instance
>>> *instance, unsigned int handle,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case VCHIQ_BULK_MODE_NOCALLBACK:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case VCHIQ_BULK_MODE_CALLBACK:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> -=C2=A0=C2=A0=C2=A0 case VCHIQ_BULK_MODE_BLOCKING:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_waiter =3D userdata;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_completion(&bulk_wait=
er->event);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_waiter->actual =3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bulk_waiter->bulk =3D NULL=
;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_exit=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>>> index 985d9ea3a06a..2dd89101c1c6 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>>> @@ -474,6 +474,11 @@ extern int
>>> =C2=A0 vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance
>>> *instance,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsi=
gned int handle, struct bulk_waiter
>>> *userdata);
>>>
>>> +extern int
>>> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance
>>> *instance, unsigned int handle,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *offs=
et, void __user *uoffset, int size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __use=
r *userdata, enum vchiq_bulk_dir
>>> dir);
>>> +
>>> =C2=A0 extern int
>>> =C2=A0 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned i=
nt
>>> handle, void *offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 void __user *uoffset, int size, void *userdata, enum
>>> vchiq_bulk_mode mode,
>>> diff --git
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> index 550838d2863b..830633f2326b 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> @@ -304,6 +304,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct
>>> vchiq_instance *instance,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userdata =3D &w=
aiter->bulk_waiter;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D vchiq_bulk_xfer=
_blocking_interruptible(instance,
>>> args->handle,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, args->data, args->size=
,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userdata, dir);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto bulk_transfer_handled=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (args->mode =3D=3D VCHIQ_BULK=
_MODE_WAITING) {
>>> mutex_lock(&instance->bulk_waiter_list_mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_e=
ntry(iter, &instance->bulk_waiter_list,
>>
>


