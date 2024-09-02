Return-Path: <linux-kernel+bounces-310805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C4596816D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E0A282AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E417F4EC;
	Mon,  2 Sep 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="B81TBXzP"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B717E017;
	Mon,  2 Sep 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264746; cv=none; b=gumsNXlrk1md8SAzL0evPAt0DJ0SFC7qJhYSxCqjAsS7Qbv42Fs0X9ZcZoOUcceghk6lX2vMxyhqvesbEq3j9gbWMzzYvg3VJPPTAjkzQgNtUAlSyq7jLcLbxi/g2TbErsJzKDKtoV/5+0L045isHzTbONh6E7Z5F8YD/CDzn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264746; c=relaxed/simple;
	bh=uuroy6YNPQNnktpHhPfgTMxnxCdZ1u2w5GiFuqhg2qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPi85+fOTTDQ5SiV5lxTc/ITjrwuRAxQdDv5V5vJMXhOfkyg9GDdIaxSNNzJcW1037U58e4WIgMOS+k4o7vyzg33IdwsZg699PnDxqovvv2m4ZJDYsTWNliSbp10f6REP/8++OklJjtYdN1cEOyGw5BVmQV9mMKHAYG91AdCkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=B81TBXzP; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B45E24459E;
	Mon,  2 Sep 2024 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725264740;
	bh=uuroy6YNPQNnktpHhPfgTMxnxCdZ1u2w5GiFuqhg2qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B81TBXzP20aFyvp+4P4jtDokBSBCfz6j8sQLfncg5yV0pAsKwIiejjIsld5emdGcN
	 Cuav+rtppgvDIpTW6IVewnoiz9NeVKq1kp8QMJDVMS71l2110+e6snWsS5JMpyF8t8
	 0CpbtmNX57hXLPDZeYw4GtPoxJ2FY5PjvPZGgXQwFgqOZ64J13FRp8nBbaMGo8PihI
	 Fhxvghj3taBW1vG8lrRUvIvY75Lr+vSP3QxOpYW5tQW2YvPjNKEL/O6x0D4XfMV08f
	 tj5tCo4IPGpOwn8pC+MonHPlS1yRJ6Oj5L4hYeQehqK5b7wIVU43Gw8TygxdMvroty
	 UcztlBwVQIu0w==
Message-ID: <3980ad8b-d27c-482e-bbb7-3b243ecc8744@asahilina.net>
Date: Mon, 2 Sep 2024 17:12:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add quirk for RME Digiface USB
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Geoffrey D. Bennett" <g@b4.vu>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Mark Hills <mark@xwax.org>, Arun Raghavan <arun@arunraghavan.net>,
 Cyan Nyan <cyan.vtb@gmail.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
 <20240902-rme-digiface-v1-1-6e88472a2744@asahilina.net>
 <8734mik2m6.wl-tiwai@suse.de>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <8734mik2m6.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/24 3:10 PM, Takashi Iwai wrote:
> On Sun, 01 Sep 2024 23:31:50 +0200,
> Asahi Lina wrote:
>>
>> From: Cyan Nyan <cyan.vtb@gmail.com>
>>
>> Add trivial support for audio streaming on the RME Digiface USB. Binds
>> only to the first interface to allow userspace to directly drive the
>> complex I/O and matrix mixer controls.
>>
>> Signed-off-by: Cyan Nyan <cyan.vtb@gmail.com>
>> [Lina: Added 2x/4x sample rate support & boot/format quirks]
>> Co-developed-by: Asahi Lina <lina@asahilina.net>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>  sound/usb/quirks-table.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  sound/usb/quirks.c       |  58 +++++++++++++++
>>  2 files changed, 247 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
>> index 73abc38a5400..47fd18791396 100644
>> --- a/sound/usb/quirks-table.h
>> +++ b/sound/usb/quirks-table.h
>> @@ -4546,6 +4546,194 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>>  		}
>>  	}
>>  },
>> -
>> +{
>> +	/* Only claim interface 0 */
>> +	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
>> +		       USB_DEVICE_ID_MATCH_PRODUCT |
>> +		       USB_DEVICE_ID_MATCH_INT_CLASS |
>> +		       USB_DEVICE_ID_MATCH_INT_NUMBER,
>> +	.idVendor = 0x2a39,
>> +	.idProduct = 0x3f8c,
>> +	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
>> +	.bInterfaceNumber = 0,
>> +	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
>> +		.ifnum = QUIRK_ANY_INTERFACE,
>> +		.type = QUIRK_COMPOSITE,
> (snip)
> 
> Recently the quirk tables are rewritten with macros.
> See the commit d79e13f8e8abb5cd3a2a0f9fc9bc3fc750c5b06f
>     ALSA: usb-audio: Replace complex quirk lines with macros
> in for-next branch of sound.git tree.
> 
> Could you try to apply to your new entries, too?

Sure! Note that I open-coded the USB match because I need to add
USB_DEVICE_ID_MATCH_INT_NUMBER (to stop the driver from binding to and
claiming all interfaces, QUIRK_DATA_IGNORE() is not enough for that).
Should I leave it like that (since it's the only case so far) or do you
want me to introduce another macro for that case?

I'll rewrite the quirk info stuff with the macros for v2. I'll also
remove USB_ENDPOINT_USAGE_IMPLICIT_FB since I'm pretty sure that does
nothing here (at first I thought I could get it to pick up the implicit
FB with that but I ended up having to specify the sync/implicit_fb stuff
explicitly).

~~ Lina

