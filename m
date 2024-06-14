Return-Path: <linux-kernel+bounces-214849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F332C908B12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6831F2451F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16E195F2D;
	Fri, 14 Jun 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="jSRi3hoV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D7195B16;
	Fri, 14 Jun 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365987; cv=none; b=qUKxWhsq1bGWYKdNbz2LtIp6yF4Xz/O12ei23fwC1duPsgPw3z4vS1Q86JGJw2loZzX+qDGdWJBwKlet9j8fAWpOnDhYWQjyfIuFY1DQtjcWQiB/NP1/yV+EfRtoSGFg4dKaylaEqxwqZMg5nrCBsRVLbYHJDtfTXKn0Y/Zn5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365987; c=relaxed/simple;
	bh=yXlthA35cfeR1MyCqMf03r9IKObV2EtyLUo+AVV/Vro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEdlZLCRUKNhmle0MyL/vWEY5PyzpUooQal/mT8NpycfFAdbXOGP6+9regFAGNdwhs1x6aCaUgNit/WucPsTCvvi102EH7m9r6Eez07GB/sqYsGr3QdhpjMKBQMeNOBlEqi0J3hBUIrA4JKURum9/nwzG/FsVmYNAR1I0ag8iZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=jSRi3hoV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718365974; x=1718970774; i=wahrenst@gmx.net;
	bh=yXlthA35cfeR1MyCqMf03r9IKObV2EtyLUo+AVV/Vro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jSRi3hoVb9fpg50ybPceUfzasqRGeUGCQScWAanhuSGs68EP3jDH3DhykHPIepyQ
	 zUPKpDxbp/J+rvqRCAOSRJQOss9XmxRp8H39dDk0BuE6x2RVIE5viUsOv0ThxQU1b
	 O4Z9rGijZAttQCijhjMyC1hXa4Cz9buI152d+d2cG6uRchrkQoA+xoLpMCcP6LKhe
	 oMyMZogjFAdkh7QNXyQqAZb7tUV5h6WcbfuUklPGw5vnGClgcF0f0/17v1M1G+F/S
	 cVOI9MjymMoqywh8Z/d+cP5Ac0AyJH9d4xN11t6/pp6IGSjtTrii6qbkB/buPBy7R
	 AmbS+bc+iQil8/wO5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1sRbjI2CNm-00xcPN; Fri, 14
 Jun 2024 13:52:54 +0200
Message-ID: <104f23d7-9832-4c06-92c7-d3ea84fbf186@gmx.net>
Date: Fri, 14 Jun 2024 13:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation
 check
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, detule
 <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 <linux-arm-kernel@lists.infradead.org>,
 STAGING SUBSYSTEM <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
 <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>
 <082d9df0-0947-4452-a3fc-87eab2019e01@gmx.net>
 <171836496531.2248009.11650291484570726735@ping.linuxembedded.co.uk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <171836496531.2248009.11650291484570726735@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IVK4kVk1lkaB2alF6g8ChP2vH4UwkZn8RCqNsu2RrEnfQ0h8pe0
 max8l1w/pnF0r8yIx4wki094uvcbytMdLSXwBH2TegYE/V0Fz+C2YxWw+/vWp/pXHxiSP+/
 QHS0L5YUA8XoL2mG98ZGIb2XMDXFC1Ee5x+36USWU/5GTC2pC5HX62AltQ3iirNaVgwiuPU
 EJx+CE9LbCZotQYhWTJ+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IXSy47jmsJA=;XxNo+wybPSb96wXOawF84Ikkh0p
 Rxq85Y5W1LmlQ75ZCF9PeU1SS2wWfKQMNXGf42CYSTlhVWdvOLCJbv2fb3YP3EY4He+OycHuy
 lOM8LIF/YpXDy3WjGtmx03wFUMPeas9OK7kx+g6SUVNlG7tHTRmvrxuXXaMz/HRwgd8NTfGH3
 bOfem205pxAzu7yigz32OckVyvS7B3Trw7pkLoIN/152O6BoqcyQB5dPMyFtwM9Q/gZ0i3Rqo
 yCVBsF87VeBHrFJfzqn+JTncXlbXvHZ1/i7ypDibf6o6kJ+GdLUtbiaW7XbXcqt64RIA//xFC
 y/jJ8nQb0ppv+3qDpy5zwh8RPdQ8nO+ZfGO3Y/15VMBqGJ1sgiWQXImyqcC2UQ9SOfbeKyIUr
 vW3bW5oqXdOe2N+GVd4qzcRAFMqw2OeXiehLmD9ErcWr799OriQsdhpHO9LhN/9laFD2jb1ZI
 bhe1+S5kUUvs3xYOthYFSHw6OTvdHZ9vTHt58hMZ0Vq1OBW/J6baViuL1TcqHo4sTzRrxsS+x
 k9EtI5800/fxANiC1UAi8KocV0oeN54XtoevGFKkriB1nbB0VCikWr88rXeZDbSeu1FJKq+78
 b0KuD4ozxrMz02vqhiXnTjH08kdh1gykQSfLlR/b3IZi3xk955MHI2zqZId2labtlCKK9YEKR
 /nOecab2yKKLHBRj0d9BC65u5BdVU9j+4G8DRoaQG1J6PpsQ4jKx+qdOCB5R4ldMlWQmloLSr
 SRnvqX8rhCzRF3zYQqaEWX/4vWCKE6SMCXpmL4/numP8be0dQwYpdGnpUm0Wwxsb6FJIE58WU
 x45/5ZQVFnDiSFgl4NQmpYGy2gHdmP1iuCfEGQ4A3x8ts=

Hi Kieran,

Am 14.06.24 um 13:36 schrieb Kieran Bingham:
> Hi Stefan,
>
> Sorry, indeed I completely missed this mail.
>
> Quoting Stefan Wahren (2024-06-13 21:01:42)
>> Hi Kieran,
>>
>> Am 13.06.24 um 21:41 schrieb Kieran Bingham:
>>> The vchiq_state used to be obtained through an accessor
>>> which would validate that the VCHIQ had been initialised
>>> correctly with the remote.
>>>
>>> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state t=
o
>>> vchiq_state") the global state was moved to the vchiq_mgnt structures
>>> stored as a vchiq instance specific context. This conversion removed t=
he
>>> helpers and instead replaced users of this helper with the assumption
>>> that the state is always available and the remote connected.
>>>
>>> Fix this broken assumption by re-introducing the logic that was lost
>>> during the conversion.
>> thank you for sending this patch. Maybe it's worth to mention that this
>> patch also drop some unnecessary NULL checks of state.
> I don't understand this comment. Nothing is dropped is it?
>
> The newly added vchiq_remote_initialised() is itself a null-check too!
the vchiq_remote_initialised() only checks the member remote, but not
state itself. From my point of view the null-check for state is
unnecessary, because most of the code already assumed that state is not
null like e.g. in vchiq_open().


