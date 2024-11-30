Return-Path: <linux-kernel+bounces-426089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0163C9DEEC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 03:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540BF281713
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC75FEED;
	Sat, 30 Nov 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="C1/8x4Pu"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2B1C6A3;
	Sat, 30 Nov 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732935161; cv=none; b=G2gfO1Zaz7AdDHQLcJURPIugAK3+r/2EXO/RqUuZTR7enVo/DZBcv5QLvTvavZRJzkv8kljvHlrC6va72GsdUCjzp6Fn7P8jK3elg9m/Bw0JltYAP7ON8CaefxsLtDUodw04BMgfO5laJ99II1lOu6ZcnavAga3uGYppiPBy0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732935161; c=relaxed/simple;
	bh=oDnvGh9Y3FuGoEDDSax72GAfXIQt6PJCrsfuROrYa9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAsDMTHMtRuDZ0xGG5Nlu2q+jMTgXbvn4t+M+PRsAKwbxiYs5Jh6VO54NkgbiETqEnnJAqPd9a7GLGGHTD4fHN3nPGuSpIEzpjX54XFxpbXZb9mwbDv6U9o383aOOu/Sl3EGhssPZXGlrSAMx4zoqNReu54yXAfOzQdlyiXpico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=C1/8x4Pu; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [192.168.0.10] (unknown [69.138.96.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 3B343165855;
	Sat, 30 Nov 2024 03:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1732935148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LGeLb72tXBsoXJcX46w/dSAw/DjIbeqvi+Y8uCf72Ps=;
	b=C1/8x4PuHcf+ZIVqoIjksN3gr3OtSr+YanB7Va3bOPZT958LJWENisvyrs9mYy5yuMtXB1
	XvCW+gl54OEIAASnH0qiqUmncO0uXUf9IcBmbYHKOOViTozpo1tuhguJfJE0wrQcA86k3i
	aR48RSSH0GuFCjXluCciazWVsBTpLd8=
Message-ID: <cf0f3894-3c62-40b4-af48-afac1c7d0379@ixit.cz>
Date: Fri, 29 Nov 2024 21:52:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240507131522.3546113-1-clabbe@baylibre.com>
 <20240507131522.3546113-2-clabbe@baylibre.com>
 <Zp5q5V_OnLAdvBrU@hovoldconsulting.com>
 <CAFBinCC9ftXxkyoiY=3ia6UubTeG-cHXa40ddd7WMNUhvVjr+g@mail.gmail.com>
 <Zp_WiocH4D14mEA7@hovoldconsulting.com>
 <CAFBinCATe+RXHz6Cy9cbo=vYL+qm_kz1qDTB8oL775xdgk=TYg@mail.gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <CAFBinCATe+RXHz6Cy9cbo=vYL+qm_kz1qDTB8oL775xdgk=TYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Martin,

are you planning sending v8 soon?

There seems to be general interest, if it makes working on it more joyful:
https://www.reddit.com/r/raspberry_pi/comments/1gznt7p/has_anyone_used_this_board_usb_to_8channel_serial/

Thank you
David

On 25/08/2024 06:56, Martin Blumenstingl wrote:
> Hi Johan,
> 
> On Tue, Jul 23, 2024 at 6:13 PM Johan Hovold <johan@kernel.org> wrote:
> [...]
>>>> Do you need to include any copyrights from the vendor driver? It looks
>>>> like at least some of the code below was copied from somewhere (but
>>>> perhaps not that much).
>>
>>> If you - or someone else - have any advice on this I'd be happy to go with that!
>>
>> If you copy code directly (even if you clean it up after) you should
>> include it, but not necessarily if you just use it for reference for the
>> protocol.
>>
>> It doesn't hurt mentioning anyway when you add the reference to the
>> vendor driver, for example:
>>
>>          Based on the XXX driver:
>>
>>                  https://...
>>
>>          Copyright YYY
> Thanks, I'll include that in the next version.
> 
> [...]
>>> For slow speeds I never receive the "Transmitter holding register
>>> empty" interrupt/signal when using the full TX buffer.
>>> It's not that the interrupt/signal is late - it just never arrives.
>>> I don't know why that is (whether the firmware tries to keep things
>>> "fair" for other ports, ...) though.
>>
>> Perhaps you can run some isolated experiments if you haven't already.
>> Submitting just a single URB with say 128, 512 or 1024 bytes of data and
>> see when/if you ever receive a transmitter holding empty interrupt.
>>
>> How does the vendor driver handle this? Does it really wait for the THRE
>> interrupt before submitting more data?
> The vendor driver:
> - first acquires a per-device (not per port) write_lock [0]
> - then waits for the (per-device, not per port) write buffer to be empty [1]
> - and only then submits more data to be transmitted [2]
> 
>> You could try increasing the buffer size to 2k and see how much is
>> received on the other end if you submit one URB (e.g. does the hardware
>> just drop the last 1k of data when the device fifo is full).
> I have not tried this yet but if still relevant (after the info about
> the THRE interrupt) then I can try it and share the results.
> 
> [...]
>>>>> +             * If we ingest more data then usb_serial_generic_write() will
>>>>> +             * internally try to process as much data as possible with any
>>>>> +             * number of URBs without giving us the chance to wait in
>>>>> +             * between transfers.
>>>>
>>>> If the hardware really works this way, then perhaps you should not use
>>>> the generic write implementation. Just maintain a single urb per port
>>>> and don't submit it until the device fifo is empty.
>>
>>> I tried to avoid having to copy & paste (which then also means having
>>> to maintain it down the line) most of the generic write
>>> implementation.
>>> This whole dance with waiting for the "Transmitter holding register
>>> empty" by the way was the reason why parts of the transmit buffer got
>>> lost, see the report from Nicolas in v6 [1]
>>
>> I understand, but the generic implementation is not a good fit here as
>> it actively tries to make sure the device buffers are always full (e.g.
>> by using two URBs back-to-back).
>>
>> If you can't find a way to make the hardware behave properly then a
>> custom implementation using a single URBs is preferable over trying
>> to limit the generic implementation like you did here. Perhaps bits can
>> be reused anyway (e.g. chars_in_buffer if you use the write fifo).
> I cannot find any other usb-serial driver which uses this pattern.
> Most devices seem to be happy to take more data once they trigger the
> write_bulk_callback but not ch348.
> 
> If there's any other (even if it's not a usb-serial) driver that I can
> use as a reference implementation for your suggestion?
> I'm not sure whether to use a dedicated kthread, single threaded workqueue, ...
> 
>>>>> +static struct usb_serial_driver ch348_device = {
>>>>> +     .driver = {
>>>>> +             .owner = THIS_MODULE,
>>>>> +             .name = "ch348",
>>>>> +     },
>>>>> +     .id_table =             ch348_ids,
>>>>> +     .num_ports =            CH348_MAXPORT,
>>>>> +     .num_bulk_in =          1,
>>>>> +     .num_bulk_out =         1,
>>>>
>>>> Set both of these to 2 so that core verifies that you have all four
>>>> endpoints.
>>
>>> I will have to test this because I thought that:
>>> - using 2 here makes usb-serial allocate an URB as well and by default
>>> assign it to the first and second port
>>> - usb-serial should not touch the second bulk in / bulk out endpoint
>>> (as they're entirely vendor / chip specific)
>>
>> Setting these two should make core make sure that the endpoints exist,
>> and by default they will be assigned to the first and second port, but
>> you can override that calc_num_endpoints() (as you already do).
>>
>> For the second IN EP, you could even let core allocate the URB and use
>> that instead of doing so manually (e.g. by submitting yourself or using
>> the generic read implementation as mxuport does).
> Thanks for the hint - I have tried this and it indeed simplifies the code!
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca9962384ca88b0007df8738ae5829/driver/ch9344.c#L1100
> [1] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca9962384ca88b0007df8738ae5829/driver/ch9344.c#L1152-L1156
> [2] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca9962384ca88b0007df8738ae5829/driver/ch9344.c#L1166

-- 
David Heidelberg


