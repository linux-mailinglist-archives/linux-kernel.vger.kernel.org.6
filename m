Return-Path: <linux-kernel+bounces-421281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD19D8901
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB4161EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75281B393B;
	Mon, 25 Nov 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmq8HQFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF61714AC;
	Mon, 25 Nov 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547921; cv=none; b=p7ph1idGgccK8tP+PF//4bZBza8pBO1F4frKaGjhKofLBBBOFmWbU5h2/BWRyMps2TGCJ7C+Wp/qDE3/YxEym+11J1jVMybWrknhGxaBVeWdHGfvFJIe15o6hdxqCQ8VremLYglpyrLvR7eR9A4LU0TCNUcyQl3g0owzAsV9tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547921; c=relaxed/simple;
	bh=X7JqZLtQ3bni3tHdVbRaOXV/whaW1WmbALUZDh6XMDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLv1fZyN4aZFEWH+jNmIY4X9Y5phsmq4l06UkNYVSk+RMlMOE+CfWV9XUMw00nT6pYH6n6vtiQGIRI8qU+R1hmselOcO6O3O9i4QinJWy9RmtkG5rtEH2qsmDvxCl45Bynrm27681YNSUquAerYzrX6kKidZjl3qowvYW1ZEvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmq8HQFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0CBC4CECE;
	Mon, 25 Nov 2024 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732547920;
	bh=X7JqZLtQ3bni3tHdVbRaOXV/whaW1WmbALUZDh6XMDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wmq8HQFiA0/D93V4dKKrQ09dEzj9Zp6at/Fi2MjM2fnJ1U0GufpCc51xqiHcw5HIr
	 oQA7rdvtXps+ZSDK9Kci25qBNaL6oCnuiCsahNMVx8+OK9x2w/1Ol/TIBiE4RGhDNx
	 mKuBwNKaR6ikCA5wDzqwcjCLyc4/tMYyAEEAcYLEXJ5aQILuXtTMY48GzZN+CFLh/F
	 W60E7SiJn8rl97p+204XrrbL9HtuaF2mKqjXPRoHCUoRdCEUZGZdE3x3iKgOnXR8SP
	 AGacBQF1NiK1nNM4H5JEOV6jGTjreAwWfN99j9klwNNDM2B8ws6YPinog1Vdw6gx1i
	 mdhjgp0+HaSIA==
Message-ID: <61541768-1b32-4473-a569-850323a6c7a1@kernel.org>
Date: Mon, 25 Nov 2024 16:18:34 +0100
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <893bbd30-300f-4138-8f68-64573e1f0140@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 16:13, Guenter Roeck wrote:
> On 11/25/24 00:52, Krzysztof Kozlowski wrote:
>> On 13/11/2024 04:05, Guenter Roeck wrote:
>>> On 11/12/24 18:39, Sung-Chi, Li wrote:
>>>> The cros_ec supports reading thermal values from thermal sensors
>>>> connect to it. Add the property '#thermal-sensor-cells' bindings, such
>>>> that thermal framework can recognize cros_ec as a valid thermal device.
>>>>
>>>> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>    Changes in v2:
>>>>      - Add changes for DTS binding.
>>>>    Changes in v3:
>>>>      - Remove unneeded Change-Id tag in commit message.
>>>> ---
>>>
>>> I can't apply this one (not in hwmon space), so
>>>
>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> with the assumption that Lee will pick it up.
>>
>> This was merged, while I was AFK, so the ship has sailed, but let me
>> state here objection for any future discussions:
>>
>> NAK, this is not a thermal sensor. The commit msg explains what they
>> want to achieve, but that's not a valid reason to add property from
>> different class of devices.
>>
>> This is some hardware/temperature monitoring device or power supply, not
>> part of SoC, not integrated into any SoC thermal zone. Calling it
> 
> I am confused. We have several thermal sensors registering as thermal
> zone, and fan controllers registering themselves as thermal cooling devices.
> 
> Are you saying that this is all not permitted because they are not part
> of a SoC ?


These are fine, because they monitor or cool down the SoC.  Sensor can
be under the die.  Fan for battery or for battery charger also would be
fine, because it is a real cooling device.  It literally cools.

But treating battery charger as cooling device is not correct, IMHO.
Battery charger does not cool anything down and already we have there
properties for managing thermal and current aspects.

BTW, if power supply bindings miss some thermal aspects, then let's grow
the common binding first and agree on common aspects.


Best regards,
Krzysztof

