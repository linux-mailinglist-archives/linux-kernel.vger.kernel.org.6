Return-Path: <linux-kernel+bounces-427761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFCF9E08EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE6FB84F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF520A5C1;
	Mon,  2 Dec 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="m8XNpNqg"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341B205E1A;
	Mon,  2 Dec 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150273; cv=none; b=IlrfXjcJkVKwbDzqEWzCnnjt8Y12+TtPol8i7wCU/xLs6a9nqTr+doAa6L1ghG5tvoTR4etJzxY4HT/6rsLtQZ6/TWOB2tBnUprMxvSBUEPS9rHSn9zf2mClf6oBg9qt2owWnm4XRhSHYXbPQ8tcqFbz8UqsAcA/nzQ4ySFv3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150273; c=relaxed/simple;
	bh=GdWRBAvtrKxGMvv7J8kqBJ4ESCM0A2fi/MH/wlzjEJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuuBgP63iuwGueu0Uvb0TiCIqC5cumIBvAb+v942Ys0C1Ad/MYNcVy8ZOEIdqVBfg9VC91OYnKfVyhtsmQOwuIp/k4/DPiI0oPYEspjoFkiqwlQyq1x8aQA1E7QNl3bAuNpLos/wCc/tjSIwmnEby65aMmOPQe/OrQyF4/mvLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=m8XNpNqg; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.115] (pd9e59944.dip0.t-ipconnect.de [217.229.153.68])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1B8912FC0073;
	Mon,  2 Dec 2024 15:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1733150261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1hG54e5AGZe7r71oY+MTrcsCSAYBgIyew9PDcTZvf0=;
	b=m8XNpNqggjfavXSBVtYLxppcCzpoIAzM9tCc1UtQL2OkZPw4VBEQqvTPeWs8OUmnwmiFxx
	5z0Fh+D9o3hfdJxPfYyo3jcEtvCw8b+AE36iUt/uTxKjbnrmVEte505s0iKYQskls/zoDN
	9hZQ2SWEoLLleAeisf1ZSDsmumhHoHk=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <453e0df5-416b-476e-9629-c40534ecfb72@tuxedocomputers.com>
Date: Mon, 2 Dec 2024 15:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI
 TFAN as thermal subsystem
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241127112141.42920-1-wse@tuxedocomputers.com>
 <3530748f-4819-4a02-ae6c-c459952ba82f@gmx.de>
 <faf77fbd-ac09-4736-a31f-57f44800e067@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <faf77fbd-ac09-4736-a31f-57f44800e067@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans, hi Armin,

Am 02.12.24 um 10:40 schrieb Hans de Goede:
> Hi Armin, Werner,
>
> On 1-Dec-24 6:58 PM, Armin Wolf wrote:
>> Am 27.11.24 um 12:21 schrieb Werner Sembach:
>>
>>> Hi,
>>>
>>> Following up to https://lore.kernel.org/all/172b7acd-4313-4924-bcbc-41b73b39ada0@tuxedocomputers.com/ and https://lore.kernel.org/all/f26d867e-f247-43bb-a78b-be0bce35c973@roeck-us.net/ I experimented with the thermal subsystem and these are my results so far, but I'm hitting a bit of a wall:
>>>
>>> As far as I can tell to implement "2. As long as GTMP is > 80°C fan speed must be at least 30%." I would need to add a new gevenor, lets call it "user_space_with_safeguards". I would be nice when the temp <-> fanspeed relation could be passed via the thermal_trip structure. And safeguarding the hardware from userspace only works when I can restrict userspace from just selecting the preexisting "user_space" govenor.
>>>
>>> So my ideas/questions:
>>> - Add a field "min_fanspeed_percent" to the thermal_trip struct that will only be used by the "user_space_with_safeguards" govenor
>>> - Add a "user_space_with_safeguards" govenor that is the same as the "user_space" govenor, but on trip, a minimum speed is applied
>>> - How can i ensure that on further speed updates the min speed is applied to? I could just implement it directly in the cdev, but that would be spagetti coding around the govenor.
>>> - Can I somehow restrict userspace from using certain govenors?
>>> - I'm a litte bit confused about the thermal zone "mode" sysfs switch, here it says deactivate for userspace control: https://elixir.bootlin.com/linux/v6.12/source/Documentation/ABI/testing/sysfs-class-thermal#L20, but what about the user_space govenor then?
>> Hi,
>>
>> i am having little experience with the thermal subsystem, but i suggest that policy decisions like "min_fanspeed_percent" should either:
>>
>> - come from the hardware/firmware itself
>> - come from userspace
>>
>> Effectively this driver tries to enforce a Tuxedo-specific policy that is not directly based on hardware limits. The book "Linux Device Drivers"
>> says:
>>
>>      "the role of a device driver is providing///mechanism/, not/policy/."

But it is a hardware limit, as the hardware will wear and might break if not run 
within its limits.

As this driver is for already released hardware, a firmware fix is not possible.

>>
>> Furthermore:
>>
>>      "When/writing/ drivers, a programmer should pay particular attention to this fundamental concept: write kernel code to access the hardware,
>>       but don't force particular policies on the user, since different users have different needs. The driver should deal with making the hardware
>>       available, leaving all the issues about/how/ to use the hardware to the applications. A driver, then, is flexible if it offers access to the
>>       hardware capabilities without adding constraints."
>>
>> The issue is that the Tuxedo-specific policy is not directly connected with the hardware. Some hardware might need a bigger minimum fan speed than
>> other hardware for example.

Currently this driver is for exactly 2 TUXEDO devices (Sirius 16 gen 1 & 2).

Future devices can have different limits provided by the ACPI or a list in the 
driver.

>>
>> The hardware (or rather firmware in this case) should communicate those constraints to the linux driver so that we do not need to rely on random
>> temperatures for hardware protection.
But then the driver still needs to enforce them.
>>
>> This ACPI interface however basically provides us with a hwmon interface and Tuxedo now wants the kernel to enforce their policy on it. I suspect that
>> happens for warranty reasons, right?

The ACPI interface is only present on TUXEDO devices (TUXI stands for TUXEDO 
Interface and TFAN for TUXEDO FAN). And we want the policy for the devices to 
live longer, not only for warranty.

TUXI meant as a simple getter and setter interface for the EC. We don't have 
access to the EC firmware source so more complex stuff needs to be done 
somewhere else, i.e. the driver.

>>
>> Maybe there is a way to enforce this policy through userspace applications?
That's no enforcement as userspace can just write the sysfs directly.
> An important role of device-drivers is also to avoid driving hardware outside
> its valid specifications. E.g. charger drivers in the power_supply subsystem
> have constant_charge_current and constant_charge_voltage settings which
> give a max charging speed in Amperes and a max charging Voltage (typically
> 4.2V for single Li-xxx cell batteries).
>
> Setting these too high can be very dangerous leading to batteries catching
> fire / exploding. so naturally the drivers also have and enforce
> constant_charge_current_max and constant_charge_voltage_max sysfs attributes
> and the values there do not reflect the maximum what the charger-chip can
> handle, but the maximum which the manufacturer has specified for the battery.
>
> This info can e.g. come from devicetree but if not present then the values
> applied by the firmware at boot should be read back and used not only
> as active, but also as max values.
>
> I believe what Werner wants is pretty much the same thing, allow userspace
> to provide its own fan management, but have the kernel monitor the temperature
> and if the temperature goes say above 80° Celsius, enforce a min fan-speed of
> 30% and at 90° enforce a fan-speed of say 70%.
>
> Yes the exact values are a for of policy, but this is a policy to protect
> hw from getting damaged and as such is fine to have in the kernel.
>
> As for how to implement this with the thermal subsystem (which indeed looks
> like it might be the way to go) I'm not familiar enough with the thermal
> subsystem either.
>
> Werner, I suggest that you send an email to the thermal subsystem maintainers
> and ask them about this. It would be good to start with explaining your
> problem before asking the questions. I would leave out details about the ACPI
> interface. Just say you have a temp-sensor + pwm to control fan speed combination
> where you want to allow userspace control while having the kernel monitor
> things and have the kernel overriding userspace's fan speed setting when
> things get too hot, to deal with e.g. the userspace process crashing at
> a low fan speed setting.
Ack
>
> Regards,
>
> Hans
>
Best regards,

Werner


