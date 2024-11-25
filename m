Return-Path: <linux-kernel+bounces-421422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0D9D8B16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A150416780F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3861B6D1A;
	Mon, 25 Nov 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctOCiO4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC61ABEAC;
	Mon, 25 Nov 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554771; cv=none; b=tbITWgVB1I1OP7q7lfvCGzNVYhAQRfG+yJcjhQ5ZYQu6yZMZrd8r5pS1BKJXEpxoo+CbPzqCjltKvhyTcBi9svtxN6NtGpUauSyiqQ4M6nEi7nSqFJYKgNuFHtLwWm5I+OhVrL3jPGe0QjqNtu5JFvvICucxaQiCdvOIsU31iB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554771; c=relaxed/simple;
	bh=KtOOnhBNVpAKdAt3JpdknAUI1CMe4LmkorKrMIv82RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYJp9Fu5XjxkXwIKIwBrlgfiAeSIt3uq/p20dJNf89i3fydd6XQhVCq4YL72RHgCs4DKThcypkmCUiKXd/eMzQgzC/eLXPnAoOZUpRagDWQB5KtGx3VPXJLIfYBQgVZXLdsQ3HuDx+KyQ0BKvlGAambVkEawZfyewMkS10MzdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctOCiO4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EF7C4CECF;
	Mon, 25 Nov 2024 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732554771;
	bh=KtOOnhBNVpAKdAt3JpdknAUI1CMe4LmkorKrMIv82RQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ctOCiO4uXrYbXIPuqEYW7Q9lND6/6xO0fPromgXDIiozCIJ0ogxIqkRWv+NIWbbqx
	 PPHDijT6HN64vkNjwHDvLCl3pXbqDIoBK3YhBI9hOOWVQ5IzoZB2ZSB2HZ1sIYLtLg
	 RaSvQ/gpZ2/dmwisb1D5qcDkwbgnZPDrc0pyumj3NOckYBOCK3vxbHr+8MwzycjU4Q
	 UJeQpc/pJkPd5ck9dg7AWPGaPGHkJYQOhOnghxaPq4VY9aNKeAmjXZecWULK09a7kS
	 XmRWQGt+34xtlRNUwETK/nqBP0BtpaN8dU5ein2QwAat+w0PcJxAdbpB5gz3cqgxqg
	 A4LiDAzZjtGBQ==
Message-ID: <fd20d991-60ca-41b0-adda-c2272975cd0a@kernel.org>
Date: Mon, 25 Nov 2024 18:12:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add properties for thermal
 sensor cells
To: Guenter Roeck <linux@roeck-us.net>, "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@weissschuh.net>, Jean Delvare <jdelvare@suse.com>,
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241113024000.3327161-1-lschyi@chromium.org>
 <20241113024000.3327161-2-lschyi@chromium.org>
 <4efe981f-f7ae-41c7-9c12-2aa3a5d2d046@roeck-us.net>
 <eb1c249c-5f42-4878-8934-09d6ea5c43f2@kernel.org>
 <893bbd30-300f-4138-8f68-64573e1f0140@roeck-us.net>
 <61541768-1b32-4473-a569-850323a6c7a1@kernel.org>
 <eda10481-d1f2-45c4-a5ff-0f26398fe6bf@roeck-us.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <eda10481-d1f2-45c4-a5ff-0f26398fe6bf@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 17:41, Guenter Roeck wrote:
>>>>>
>>>>> with the assumption that Lee will pick it up.
>>>>
>>>> This was merged, while I was AFK, so the ship has sailed, but let me
>>>> state here objection for any future discussions:
>>>>
>>>> NAK, this is not a thermal sensor. The commit msg explains what they
>>>> want to achieve, but that's not a valid reason to add property from
>>>> different class of devices.
>>>>
>>>> This is some hardware/temperature monitoring device or power supply, not
>>>> part of SoC, not integrated into any SoC thermal zone. Calling it
>>>
>>> I am confused. We have several thermal sensors registering as thermal
>>> zone, and fan controllers registering themselves as thermal cooling devices.
>>>
>>> Are you saying that this is all not permitted because they are not part
>>> of a SoC ?
>>
>>
>> These are fine, because they monitor or cool down the SoC.  Sensor can
>> be under the die.  Fan for battery or for battery charger also would be
>> fine, because it is a real cooling device.  It literally cools.
>>
> 
> Sorry, I don't get the distinction since you specifically refer to the SoC.
> How about drive temperatures ? RAM temperatures ? Temperatures reported

Several of them are part of the SoC, like DDR. But even if they are not,
I agree they could be a thermal sensor, but I would stop before calling
them thermal zones and this patchset leads to such calling.

> by networking chips ? Power supply temperatures ? We have all those registering
> thermal zones. The ASUS EC controller driver registers thermal zones
> for its temperature sensors. Dell and HP drivers do the same.

Maybe we need to clarify that thermal sensors and zones are not specific
to SoCs?

For now all bindings say:
"thermal-sensor: device that measures temperature, has SoC-specific
bindings"


> 
>> But treating battery charger as cooling device is not correct, IMHO.
> 
> Confused. The patch you object to isn't introducing a cooling device,
> it is introducing #thermal-sensor-cells. The EC reports temperature


The next patchset is. This is one of the problems with series from
Sung-Chi, Li - they add hardware description piece by piece, to match
the driver needs, while we expect to see complete hardware picture.

In the complete picture (f:lschyi@chromium.org in lore) you would see
the battery being called a cooling sensor with explanation:

"The cros_ec supports limiting the input current to act as a passive
thermal cooling device. Add the property '#cooling-cells' bindings, such
that thermal framework can recognize cros_ec as a valid thermal cooling
device."



> sensor results, and the driver wants to register those as thermal zones.
> Yes, it may well be that one of those temperature sensors is close to
> a battery charger, but I am not even sure if that is really the case.

Hm, my impression based on very limited commit msg was that it is about
battery.

Probably I don't understand how the hardware looks here, but sorry,
commit msgs and bindings descriptions are for a reason - to help me
understanding it.

> 
>> Battery charger does not cool anything down and already we have there
>> properties for managing thermal and current aspects.
>>
> Agreed, but unless I am missing something that isn't done here.

Yep, I connected two separate patchsets, because they form greater work
of making power supply a cooling device, AFAIU.

> 
>> BTW, if power supply bindings miss some thermal aspects, then let's grow
>> the common binding first and agree on common aspects.
>>
> 
> I don't even know how the two patches are associated with power supplies
> or battery chargers in the first place. All they try to do is to enable
> adding the temperature sensor values reported by the EC in Chromebooks
> to thermal zones. I don't recall any previous limitations on the ability
> to register thermal sensors as thermal zone with the thermal subsystem,
> and I am trying to understand what those limitations are.
> 
> So far my approach was "ok, someone wants to register a thermal sensor as
> thermal zone - fine, let's do that. We have close to 50 thermal sensors on
> a variety of devices - including but not limited to disk drives, memory,
> Ethernet controllers, Ethernet PHYs, SFPs, RTCs, and ECs - registering
> as thermal zones from hardware monitoring drivers. I don't recall anyone
> ever saying "no, you can't do that".
> 
> I am trying to understand if some of those are inappropriate and, if so,
> why that is the case.


Probably would be nice to drop remaining references to SoC from thermal
bindings and just interpret thermal zones as system-wide.

I retract than my objects against sensor cells, but I keep my objection
of changing these bindings piece by piece. This should be one complete
work for bindings so we see what this hardware is supposed to do.

Best regards,
Krzysztof

