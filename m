Return-Path: <linux-kernel+bounces-438832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490379EA701
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F01E1889760
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A832248B0;
	Tue, 10 Dec 2024 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bRzqWaIP"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BB1D79A3;
	Tue, 10 Dec 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803694; cv=none; b=PB0e/Q0AVN7kOV+rHwe10kaD+bRThjIqHCed7VMQjBaNzyUcwkG/9r4POTNS6gtEOG1Vfk5JeGwjl3N2CCpHw0U4lasjYEqnKnKZU6fbOHnOOOdg5jTu+tt/mnmHrt8SqZNxnOYyGrVryk/vv/j0y/t+I/qSqaEnXILJtC1dyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803694; c=relaxed/simple;
	bh=Kd14JDL7U4ItsaLyqu11JTLUDIbecDEaGvzz3fHha8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUrEc6PQzOjns7mZW2frA+z28OsrBltWrk7XqEWQzEXORLrWsna8dA0qp7b1ofD66NsnjxSJjsLCPdTbTbtQtgI3POIp5VcxsSJuF1DhST5BdZdbVRRzK6tEEUsNlRueA486A+w9e038JXGbACVO4sKeyMYhmfjh7xarBkKNI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bRzqWaIP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733803683; x=1734408483; i=w_armin@gmx.de;
	bh=oahmG70NCBuHFXkgBAFpg9Aun+eU1gyPJog6Kzl8MqQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bRzqWaIPnh3B0n5pVeODg0XGqMNaxXXuue1F9UkG9mjJvN2s0yWnl1m5UTSyKMHw
	 CUFmLJFiqFGhdze9XkvAYiYYLiL9IL9qXue1r2XijqQN4x/SAzc4fduOAuIfI1XN8
	 PdI5xSdKtbnF70MiWYndxaaUjWFI54NhW8IyozEU1ux81uDambP8x+zjPHQpv5sP4
	 B5Us4MS85Kb8VOaNdzOfYUuStQYV0EHhYlyvcWSn2EBzzYEPbBQwYUQ5KL7Qbxzb4
	 M5RRLo39Dqc9rkxwV8av4YhPKtRJpMTPA5sdXpfSSGfud8S2OOqAwN9laYJPtfKRw
	 o3wjUN2+WOXgalyXzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1tvYs43ln8-00lzJa; Tue, 10
 Dec 2024 05:08:03 +0100
Message-ID: <51dba8ab-b268-40ae-b005-87a5d0ab0566@gmx.de>
Date: Tue, 10 Dec 2024 05:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] platform/x86: acer-wmi: Improve error handling
 when reading gaming system information
To: Kurt Borja <kuurtb@gmail.com>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-4-W_Armin@gmx.de>
 <i4jcyhqxfugfykbtvrwba4udln4l2cgk7zgj3sy7iqncf47a4q@exk6jk7rmmvk>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <i4jcyhqxfugfykbtvrwba4udln4l2cgk7zgj3sy7iqncf47a4q@exk6jk7rmmvk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zui3jdiZlAvLMwDc+Uw2Bly7fJ4KnVaCApWGJAgdYntRdojoIzK
 AgiJHjLTcwNso3hPWgDfjmK//M3UoZuaTBJKZ3AmalxNgQZxcXgjxWFpvRQAvN7r3j/C1Ld
 euy2d59AtcJKwtMLnzNxZszUqtjm/9K9vRGwpKkTzHb5/AkuSrD7hNBcumKkrutrmlpSND9
 ft+O0AeYoYLEYyNZH8VRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EZOHrkQ1pyY=;y7LZjkA05sKiW/JUGNmzZzc+vJd
 1elmSKIG9nDJwlAQLDOOtoN0YIw4zNkRJIcVsfr3CG2XK0UL/uN2+EPiV52r02SI6a4O/xVW8
 fiBoVLvOD5QX6hHcUWmiokyH0RX+7mLX07w0o9SgHEwFr0mat8KwhHa/pEFK0jTZfN6NHiVD4
 vDVwJv6QKDDVaf+9QH3/kolwrQOHyeyLiJlAW/4CPlj1Uf/oWHjoCKEYMqlnJzza+zRuzbu94
 BNyUxVcpagb8ZT9Uv0HQF5saNOrfbZiLZu4W9YnOgZbqp9AJZ18S/BJEI5ypYHKCq+8b6PLAI
 3mEaPPwfkt7oM3LHOEaTGkhf+JUin4SylHR8M1uTt2SU0fQy8TeDG7lXYHZY44G9DqJ65tvxJ
 KjNwmV8W8l58i8wDyiLmC9X8FfsXFDA9DvaGtYedCoIgHeNaxfGAvkH+mla/Cd1WA6yVfv254
 Zw+w/QpVszuBwOESHOqWIX4RuS2uz15y7J0kvzEA5Lp0sTW7pGdWXbsgOTd6obxMWZHB59hBa
 58EeFr9jQUB+FBXhrlxCNx/pkQ4U4L06eHiibNjFGPJc0CiHsjDniaftk49ae8xMZYxwI0CUy
 j6go/HxHO9QwGoNpLPjKUwpobiXY+zYaMJzxWvk7qOs4ASnV+BNls7shTO60s7YLAN/UYS1eE
 IVghDVzfxK2PY7nvqkRGd6RNs1lBGz0qBafPic2TPrwEsO7JSA7rZt6PQmsigwes23F/LD1cv
 jy7+WY0UaO/EjvjhV6vkOMtgb0JMjSoEeWd5BC9tK2ysHbAJkJdECIIQ1w2pLS2BbMw2aBrhY
 9MA5BIJqpNd/A53t84wx1RyuqNf5TFD9SZsPc6xUNRrN6Y/eiG00lO+bt87sj46o/GtkDspu9
 hu8xTdx60rQQnBO8ilp0TaflOadr3mYc7EQiRSVEuvLOYx7wRb+tHAe9wRTT/Yep7AtoWMI92
 YyVxFmigVG8rZY4jkL81EAYBrNorqteUIKejUa5z88cxEAZQ80vcPpmbVDI+9tSYCLGdwYyUB
 btb31zvQAcjPVjFGAhtIhwAHj68XbfdBcxS9PSnFRVldGS1u/3keDIMdg8SaDXMo3VGdxTW3N
 kzYfjrJfZqsQTEfAcv+UlLHbitpsUR

Am 10.12.24 um 03:06 schrieb Kurt Borja:

> On Tue, Dec 10, 2024 at 01:16:55AM +0100, Armin Wolf wrote:
>> If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
>> 8 bits will be non-zero. Introduce a helper function to check this and
>> use it when reading gaming system information.
>>
>> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 55 +++++++++++++++++++++------------
>>   1 file changed, 36 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index dd57787466b9..ac4500f33b8c 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -70,6 +70,7 @@ MODULE_LICENSE("GPL");
>>
>>   #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
>>
>> +#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
>>   #define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
>>
>>   /*
>> @@ -1513,6 +1514,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
>>   	return status;
>>   }
>>
>> +static int WMID_gaming_get_sys_info(u32 command, u64 *out)
>> +{
>> +	acpi_status status;
>> +	u64 result;
>> +
>> +	status = WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID, command, &result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	/* The return status must be zero for the operation to have succeeded */
>> +	if (FIELD_GET(ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK, result))
>> +		return -EIO;
>> +
>> +	*out = result;
>> +
>> +	return 0;
>> +}
>> +
>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>   {
>>   	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
>> @@ -1762,22 +1781,23 @@ static int acer_gsensor_event(void)
>>
>>   static int acer_get_fan_speed(int fan)
>>   {
>> -	if (quirks->predator_v4) {
>> -		acpi_status status;
>> -		u64 fanspeed;
>> +	u64 fanspeed;
>> +	u32 command;
>> +	int ret;
>>
>> -		status = WMI_gaming_execute_u64(
>> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
>> -			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
>> -				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
>> -			&fanspeed);
>> +	if (!quirks->predator_v4)
>> +		return -EOPNOTSUPP;
>>
>> -		if (ACPI_FAILURE(status))
>> -			return -EIO;
>> +	if (fan == 0)
>> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
>> +	else
>> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
>>
>> -		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
>> -	}
>> -	return -EOPNOTSUPP;
>> +	ret = WMID_gaming_get_sys_info(command, &fanspeed);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
>>   }
> I wonder if it's necessary to refactor this function if you are going to
> drop it on Patch 4.

I did it so each patch has a single well-defined scope. And refactoring this function was necessary for
the patch being complete.

Thanks,
Armin Wolf

>>   /*
>> @@ -1942,12 +1962,9 @@ static int acer_thermal_profile_change(void)
>>   			return err;
>>
>>   		/* Check power source */
>> -		status = WMI_gaming_execute_u64(
>> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
>> -			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
>> -
>> -		if (ACPI_FAILURE(status))
>> -			return -EIO;
>> +		err = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
>> +		if (err < 0)
>> +			return err;
>>
>>   		switch (current_tp) {
>>   		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
>> --
>> 2.39.5
>>

