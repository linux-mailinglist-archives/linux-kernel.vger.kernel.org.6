Return-Path: <linux-kernel+bounces-436683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9679E8953
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C971028338C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8823524B4;
	Mon,  9 Dec 2024 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pWj9OKzj"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED144360;
	Mon,  9 Dec 2024 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712255; cv=none; b=CmAyH9Yuchxog3i+tXOAlavLpErBr5IygW1B9WARKuqbLnDJo4vAEqXVP0L2k0LgRNq7+mBq1k6jPOsoqUnDquBlX39BFvNXI/nG6kvyfBr2XROlOi1TYMoxodBCPj4GMGIOhY1i7RLOUD2aJxiz3rGR45VxuYAIhdNdxrSGTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712255; c=relaxed/simple;
	bh=zA2nkF0y8Sjf3rsPDrKJaR+atSvDhSlhp4CCwXzKnAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOeXXFNtELoiabmpFF0yuvG7DionezCXAsd4nH9ABheJIC95Z+X4nYY+GmjXb0QUBkajoG3dAo0zONQt2OA3qDUWt0xYwJMZlYMSbw6KVEHlMjTVo2zzA6LZYT4O7p/aWBA15AYIxaFhTwNONftZgBK7fbtJMaGbNtg441auSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pWj9OKzj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733712243; x=1734317043; i=w_armin@gmx.de;
	bh=FmbZk1a0fMJXf0Nfw0yj1e+EHuahcYj1EelZPGLrDX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pWj9OKzj5hcM9A9K5OIPH/VdnXJDvzB+sNB9wV1f/xXC9X+OavNwmWQioNmG8t4m
	 HpbZGEHf+n2Hdw5LcNuHgNpDdrNx9bOtvQxcF4of6KwrZXFCbDCA3S5OD3RJEL0yD
	 x2RaxDcV165qu647aUFciAvsynBDzYHCTPPJUFiyQPKODGLLHvI6j4EEmwX0PQ8tm
	 Db8/uFO8xczxckYNszxMlRLlK6x9orgw2BL1sc7YSdkWoNOoNtqgLE05ShllaYmlp
	 wyEtKnUWT7pJ0Wa1cIfPj3fNXEgHh522+SUWWYzP8xs7NYBW2ooo606AM9zzZY0CU
	 VfI3OpGIwO0kw1AeZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1t5HBa1Zqj-00L2DY; Mon, 09
 Dec 2024 03:44:03 +0100
Message-ID: <21edd314-b168-4766-9654-c7ea08d7ac4b@gmx.de>
Date: Mon, 9 Dec 2024 03:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] platform/x86: acer-wmi: Implement proper hwmon
 support
To: Kurt Borja <kuurtb@gmail.com>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241129193359.8392-1-W_Armin@gmx.de>
 <20241129193359.8392-5-W_Armin@gmx.de>
 <la7mxoxn3rawxij4ybdzpf7xzbiidl66ejv6qxb4sh4n5ugsvu@64royvkee6kv>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <la7mxoxn3rawxij4ybdzpf7xzbiidl66ejv6qxb4sh4n5ugsvu@64royvkee6kv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RkCUILvIn47xCG9ecO/Pk/tb2RhwzsFIIrFx/e1FyfjS3RLqMXd
 eDwwmn9iNmYJ15jRHoA/cVcIPSimo44/YoidQInx1uD4ysCsV4UTf4KFVGf4gnSmqK2lUXv
 z+nA7cVPsIoPozo8wGoObBvmwNq6ew8XlCq7r99lxcMAXNhROlcCoBzribn0RuMXXSdKRLt
 a6Pqe6pVDKILX1xgGCKxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5NRrHsSiFjo=;3pTJiaC5McFPr1SEnS+f05u4SS4
 nBN6YGbaCANXBV74V9P7bcXaIisgshnOt06DJ0xY5N3vDXBVvZKZn8FK5vaXpNi12I+vvoZXV
 Ob3T/HqqxQYikcLnUVIW1zX4Alky+JU6DwFF2iTdLeKtYgkfk/4A5Uo1g0MxMjLUJQxg4Cdgi
 d8i/tgup/xWsxHr4jzjM/UxYAd9qjs1Wx0a5wMzB7XOxSBdbNfkgPMe5NyJwxTpz6Qp15/c5K
 wJYw66a44BXt1PFbY27TPgMuXFt3R9nHUgfSakiD6Affn6O1F7KuD+JUsYgPqAggQgh9y4lQE
 9mECrnWCArIMvhgOscotVcMBD9gx+nlGRkb5kXlgAgeF4oTy9hdQfhzmUqF3Cuq2L/r0iLpMf
 R1BXnCLiXB/rpTZrdddPd5vcUnTu401cWfqnDBHYI3AoS/AffsnSJAFidrKN4x+hWBp9407yi
 C0jPg2Re1jEe71n/6e3v+cJh85SrgtsxJ8eoaHBLPUR5M/7Gq6IA0OTLExgz1gdI/h8szqzbr
 t7lUKDyykz4eESfP8Wg68DmHOf93HJVQkCwdIYH8mI9yFFZ8UPpbjxvvYmZswcSie+Y9eFfFY
 89o4dgqxfZHmutbGe8hf7ZxbVuyiF7tu5glr0CdIYYN1hAV/83zI3ACaSM84KvH7myj+Z2cDp
 JpX3vbAHA2DkjHRSq4N624sOq9NAqLo/PTKT1S7IjK06aWIps6Q3dy4YP+YGtcItraVf+RzcP
 nEWG+LPstELz2rLuMwmoHmoF0vc8B2xLYTW8hCc5OlrKA9asTRA0TVKdtVRHPgWPkwQ6+05/r
 4L9kFjA9LpBbp5vMUbCL8nYP8EhIfhSfbI3OC9IFJEBo+QlH5sPsgNsXauGNYVrAPDPuuf1OG
 2I37zNcF+xSQ2zLBiXAFfglagXICMWHRHG99K7SR2rhuIC9cLrtElPN6v0cnlD/HpDa4PW3af
 7RB7oZGWBCfz+S1SHCpWhVyt8Fh9ScfT4dEme0EibCeiRx/kQwvPLMcW8F7b3kxpjKAvgo9Ax
 EtVo4JvDNroxPNrPJB0aiaRQgMCa4eZTlh9lSZfTY9eGgfaGCjX47EVtQiqPVHZ0ACgYjcJYG
 dPfS55bS+pMME6jdBx4UrJIv3a9W+Y

Am 08.12.24 um 21:20 schrieb Kurt Borja:

> On Fri, Nov 29, 2024 at 08:33:58PM +0100, Armin Wolf wrote:
>> After looking at the ACPI AML code, it seems that the command 0x0000
>> used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
>> all supported sensor indices available through the 0x0001 command.
>>
>> Those sensor indices seem to include both temperature and fan speed
>> sensors, with only the fan speed sensors being currently supported.
>>
>> Use the output of this new command to implement reliable sensor
>> detection. This fixes detection of fans which do not spin during
>> probe, as fans are currently being ignored if their speed is 0.
>>
>> Also add support for the new temperature sensor ids.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 114 ++++++++++++++++++++++----------
>>   1 file changed, 80 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index ac4500f33b8c..2c1ea6155bd3 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/input/sparse-keymap.h>
>>   #include <acpi/video.h>
>>   #include <linux/hwmon.h>
>> +#include <linux/units.h>
>>   #include <linux/bitfield.h>
>>
>>   MODULE_AUTHOR("Carlos Corbacho");
>> @@ -71,7 +72,10 @@ MODULE_LICENSE("GPL");
>>   #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
>>
>>   #define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
> Hi Armin!
>
> This macro is defined twice.

Good catch, i will send a v4 patch series to correct this.

Thanks,
Armin Wolf

>
>> -#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
>> +#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
> Here ^.
>
> ~ Kurt
>
>> +#define ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK GENMASK_ULL(15, 8)
>> +#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK_ULL(23, 8)
>> +#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK_ULL(39, 24)
>>
>>   /*
>>    * Acer ACPI method GUIDs
>> @@ -99,9 +103,17 @@ enum acer_wmi_event_ids {
>>   };
>>
>>   enum acer_wmi_predator_v4_sys_info_command {
>> -	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
>> -	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
>> -	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
>> +	ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS = 0x0000,
>> +	ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING	= 0x0001,
>> +	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS	= 0x0002,
>> +};
>> +
>> +enum acer_wmi_predator_v4_sensor_id {
>> +	ACER_WMID_SENSOR_CPU_TEMPERATURE	= 0x01,
>> +	ACER_WMID_SENSOR_CPU_FAN_SPEED		= 0x02,
>> +	ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2 = 0x03,
>> +	ACER_WMID_SENSOR_GPU_FAN_SPEED		= 0x06,
>> +	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>>   };
>>
>>   static const struct key_entry acer_wmi_keymap[] __initconst = {
>> @@ -272,6 +284,7 @@ static u16 commun_func_bitmap;
>>   static u8 commun_fn_key_number;
>>   static bool cycle_gaming_thermal_profile = true;
>>   static bool predator_v4;
>> +static u64 supported_sensors;
>>
>>   module_param(mailled, int, 0444);
>>   module_param(brightness, int, 0444);
>> @@ -1779,27 +1792,6 @@ static int acer_gsensor_event(void)
>>   	return 0;
>>   }
>>
>> -static int acer_get_fan_speed(int fan)
>> -{
>> -	u64 fanspeed;
>> -	u32 command;
>> -	int ret;
>> -
>> -	if (!quirks->predator_v4)
>> -		return -EOPNOTSUPP;
>> -
>> -	if (fan == 0)
>> -		command = ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
>> -	else
>> -		command = ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
>> -
>> -	ret = WMID_gaming_get_sys_info(command, &fanspeed);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
>> -}
>> -
>>   /*
>>    *  Predator series turbo button
>>    */
>> @@ -2688,43 +2680,86 @@ static void __init create_debugfs(void)
>>   			   &interface->debug.wmid_devices);
>>   }
>>
>> +static const enum acer_wmi_predator_v4_sensor_id acer_wmi_temp_channel_to_sensor_id[] = {
>> +	[0] = ACER_WMID_SENSOR_CPU_TEMPERATURE,
>> +	[1] = ACER_WMID_SENSOR_GPU_TEMPERATURE,
>> +	[2] = ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2,
>> +};
>> +
>> +static const enum acer_wmi_predator_v4_sensor_id acer_wmi_fan_channel_to_sensor_id[] = {
>> +	[0] = ACER_WMID_SENSOR_CPU_FAN_SPEED,
>> +	[1] = ACER_WMID_SENSOR_GPU_FAN_SPEED,
>> +};
>> +
>>   static umode_t acer_wmi_hwmon_is_visible(const void *data,
>>   					 enum hwmon_sensor_types type, u32 attr,
>>   					 int channel)
>>   {
>> +	enum acer_wmi_predator_v4_sensor_id sensor_id;
>> +	const u64 *supported_sensors = data;
>> +
>>   	switch (type) {
>> +	case hwmon_temp:
>> +		sensor_id = acer_wmi_temp_channel_to_sensor_id[channel];
>> +		break;
>>   	case hwmon_fan:
>> -		if (acer_get_fan_speed(channel) >= 0)
>> -			return 0444;
>> +		sensor_id = acer_wmi_fan_channel_to_sensor_id[channel];
>>   		break;
>>   	default:
>>   		return 0;
>>   	}
>>
>> +	if (*supported_sensors & BIT(sensor_id - 1))
>> +		return 0444;
>> +
>>   	return 0;
>>   }
>>
>>   static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>   			       u32 attr, int channel, long *val)
>>   {
>> +	u64 command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
>> +	u64 result;
>>   	int ret;
>>
>>   	switch (type) {
>> +	case hwmon_temp:
>> +		command |= FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
>> +				      acer_wmi_temp_channel_to_sensor_id[channel]);
>> +
>> +		ret = WMID_gaming_get_sys_info(command, &result);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		result = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
>> +		*val = result * MILLIDEGREE_PER_DEGREE;
>> +		return 0;
>>   	case hwmon_fan:
>> -		ret = acer_get_fan_speed(channel);
>> +		command |= FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
>> +				      acer_wmi_fan_channel_to_sensor_id[channel]);
>> +
>> +		ret = WMID_gaming_get_sys_info(command, &result);
>>   		if (ret < 0)
>>   			return ret;
>> -		*val = ret;
>> -		break;
>> +
>> +		*val = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
>> +		return 0;
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>> -
>> -	return 0;
>>   }
>>
>>   static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] = {
>> -	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT), NULL
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT
>> +			   ),
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_INPUT,
>> +			   HWMON_F_INPUT
>> +			   ),
>> +	NULL
>>   };
>>
>>   static const struct hwmon_ops acer_wmi_hwmon_ops = {
>> @@ -2741,9 +2776,20 @@ static int acer_wmi_hwmon_init(void)
>>   {
>>   	struct device *dev = &acer_platform_device->dev;
>>   	struct device *hwmon;
>> +	u64 result;
>> +	int ret;
>> +
>> +	ret = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS, &result);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Return early if no sensors are available */
>> +	supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
>> +	if (!supported_sensors)
>> +		return 0;
>>
>>   	hwmon = devm_hwmon_device_register_with_info(dev, "acer",
>> -						     &acer_platform_driver,
>> +						     &supported_sensors,
>>   						     &acer_wmi_hwmon_chip_info,
>>   						     NULL);
>>
>> --
>> 2.39.5
>>

