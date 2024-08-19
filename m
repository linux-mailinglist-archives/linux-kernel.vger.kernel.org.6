Return-Path: <linux-kernel+bounces-291880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500695687B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385801C217B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359B165EE9;
	Mon, 19 Aug 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkiUpUFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1816086C;
	Mon, 19 Aug 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063201; cv=none; b=cxa6Xt0v+g62h79n/CHUUA9pUHf32St4OiMMaaistJrc480C2NKmO2BUO/6XpADaJFSJYFnGtHoTdK5w73s+sJIlogIvK3ScSLwU9KA3zrCwi285B9b47e+0BBRRPr26Xw9tpKdyjpnAci5+T3PZ7bG2DWI0Ht5FvdR+Kxp1BfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063201; c=relaxed/simple;
	bh=Ty++jI/fY34cAIGQ3Pu2/OpBin5PVV1U3/Dix54n43E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVArHQEySZnKIlekkBV4s8KffYWe7Bpxgtt5LO1uFodpoorRSvRBkTay6qB4Pe+LSg+uXzlC1kbYQzk7znJyxn3Gc4S6woeNi9l0IcV+Vh/vgGytPpYbetvp9DWlB1HSb3MRCmnhZ+ij0CKdQbiZG7/AFY3NR/NaYZFL82rx1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkiUpUFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF6FC32782;
	Mon, 19 Aug 2024 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724063200;
	bh=Ty++jI/fY34cAIGQ3Pu2/OpBin5PVV1U3/Dix54n43E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NkiUpUFETMiOxybiCSqdrq+p6pvFyKRm3XC0tdWSB/sjBnrWbNUuUT+tKGemV0SI2
	 0K+G83XJ3q5eA9LhbvOhKrLbhbNoXp2AZrb1ViOfJdHJIeSv+7HFQrh58AGgsHkgBT
	 /cHBbL0m/WtX9JKfcx9taHy5yH4FfaIemvM6jYi5W8PJ2irj8PFGmXoi7vbS2uKE2U
	 tFrmy8eKalX03xDzSrdCQLLpb7Bi/qlZGz0dfYn/Hg+tsxqiRMK621/9T/3ogQXWxe
	 tfre0h+gUWoGqujOc3Wb7HFJTPSeulqu451jZ9H6jdwULTmzojPvSbGWTm2XGHpd2p
	 5Z/uB9kxsEnnQ==
Message-ID: <44aa4b41-c9af-4c0a-a8a8-4d2cd3e1054e@kernel.org>
Date: Mon, 19 Aug 2024 12:26:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
 <4464d0f5-1a40-40b9-8d53-7f0d75b9d062@gmail.com>
 <39eecb79-0b1a-4a17-865f-dcb60a20a893@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <39eecb79-0b1a-4a17-865f-dcb60a20a893@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.08.2024 3:14 AM, Konrad Dybcio wrote:
> On 10.08.2024 3:04 AM, Maximilian Luz wrote:
>> On 8/10/24 1:35 AM, Konrad Dybcio wrote:
>>> On 5.08.2024 1:08 AM, Maximilian Luz wrote:
>>>> Some of the newer Microsoft Surface devices (such as the Surface Book
>>>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>>>> Module (the embedded controller on those devices). Add a basic driver
>>>> to read out the temperature values of those sensors.
>>>>
>>>> The EC can have up to 16 thermal sensors connected via a single
>>>> sub-device, each providing temperature readings and a label string.
>>>>
>>>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
>>>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>>>
>>>> ---
>>>
>>> Gave it a shot on SL7, some names are repeated and one sensor is
>>> totally busted
>>>
>>> /sys/class/hwmon/hwmon66/name:surface_thermal
>>> /sys/class/hwmon/hwmon66/temp10_input:32200
>>> /sys/class/hwmon/hwmon66/temp10_label:I_RTS2
>>> /sys/class/hwmon/hwmon66/temp11_input:31600
>>> /sys/class/hwmon/hwmon66/temp11_label:I_RTS3
>>> /sys/class/hwmon/hwmon66/temp12_input:38000
>>> /sys/class/hwmon/hwmon66/temp12_label:I_RTS4
>>> /sys/class/hwmon/hwmon66/temp1_input:43900
>>> /sys/class/hwmon/hwmon66/temp1_label:I_RTS1
>>> /sys/class/hwmon/hwmon66/temp2_input:44000
>>> /sys/class/hwmon/hwmon66/temp2_label:I_RTS2
>>> /sys/class/hwmon/hwmon66/temp3_input:47300
>>> /sys/class/hwmon/hwmon66/temp3_label:I_RTS3
>>> /sys/class/hwmon/hwmon66/temp4_input:-273100
>>> /sys/class/hwmon/hwmon66/temp4_label:I_RTS4
>>> /sys/class/hwmon/hwmon66/temp5_input:31300
>>> /sys/class/hwmon/hwmon66/temp5_label:I_RTS5
>>> /sys/class/hwmon/hwmon66/temp9_input:37100
>>> /sys/class/hwmon/hwmon66/temp9_label:I_RTS1
>>
>> Hmm, on the SPX it looks like this:
>>
>> I_RTS1:       +31.9°C
>> I_RTS2:       +31.3°C
>> I_RTS3:       +31.4°C
>> I_RTS4:       +28.3°C
>> I_RTS5:       +29.3°C
>> I_RTS6:       +29.3°C
>> I_RTS7:       +29.3°C
>> I_RTS8:       +29.3°C
>> VTS1:         +30.2°C
>> VTS2:          +0.0°C
>> VTS3:          +0.0°C
>> VTS4:          +0.0°C
>> VTS5:          +0.0°C
>>
>> So VTS2-5 seem like they may not actually be connected, but the rest at
>> least look somewhat sensible. I'd probably still keep the names as they
>> at least might give an indication what the sensors could be for.
>>
>> But there's a good chance that we're missing something on how MS
>> envisions these sensors to work exactly.
> 
> I think the takeaway here is that I'll keep the sensors disabled for
> now on SL7 until we have a better idea and not block this driver

I had an idea.. maybe the busted sensor is for something modem-related.
My unit doesn't come with one.

Konrad

