Return-Path: <linux-kernel+bounces-516351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF4A36FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392823AEB55
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7611EA7C5;
	Sat, 15 Feb 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JjoJcRAd"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4914A088;
	Sat, 15 Feb 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641655; cv=none; b=hGyBIQJscXfVLwOdGKC+5gwJCk324oHaLI+tE+X28b3O2sBFW54KZCDLAEuDy1wYgluRF2l7iX/OVCPO00sjtDojQD7q4Rx/vH7FFmcKJo+l83xCu23yvSthVR0DnU5bQdSVIiLP0VkzylosVxu4OBfWWDnhejZq+XoWKMWdJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641655; c=relaxed/simple;
	bh=wvM7LoQVHQI5hH4NlvHkHP+axlL30mvE1ZjgDDYLEUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIYHurlGXK/UStKKYwrSemqbHCyUHWrTEhV9wRXM5VYAcnLCQgHK8/8Rp6N5iCx/6TJUKAieNTnnWGZkaWERsN+KTJ0Rrn39NAC8hFNrzFEn6v2IhZnO9gBbCSoZqL+r6Xg+5LQXKylvmtVk0Iret4jepk/ZdgdPkkCfdGlT1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JjoJcRAd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641651; x=1740246451; i=w_armin@gmx.de;
	bh=f+6gZg9V+gpw1fhZ3QfSsO5w2OAIbMPBFD7T+udDmFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JjoJcRAdnbhmrfDDkdjxpRe3QeKJs7MnJsXSa325bgnfutDwNwlxLJ44IypTm+jB
	 J/YvlXMUSrcqrZAW83+1CwaMxqtXC+NeF7YVEBgUFggcZNTmrno12izvb8rLi1gKT
	 KU2iKO4SpEElAIc5hkilBvXX5zqszR5h/nXcVecd7idkG+PfNhU817Rh8aHkBCSnX
	 LfWwk+TiyyKZ5osbw/HdMsF+N8ABmVSQT0nw41VSvDasllSm7B8lGzca7yTQAW0ua
	 CrlYGwGcWUzQZOdcJ9zP+YvtcJUa/I2F6iobS6gzHv6jpWw4c+7wKJYfyoosiXxHA
	 LJyNmPdLfRPlduzrpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1trqBh3PoN-00Rsrk; Sat, 15
 Feb 2025 18:47:31 +0100
Message-ID: <9f0d6f8d-1f13-4428-827f-3a3601a1973d@gmx.de>
Date: Sat, 15 Feb 2025 18:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] platform/x86: acer-wmi: Add fan control support
To: Kurt Borja <kuurtb@gmail.com>, jlee@suse.com, basak.sb2006@gmail.com,
 rayanmargham4@gmail.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-3-W_Armin@gmx.de>
 <D7SMRUYV3VHN.3P7MDOALEAS4P@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D7SMRUYV3VHN.3P7MDOALEAS4P@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7fnbh85sapjVAZOpiXiud5Ra/7pPGiF82h9Uz2MeKzZyI5FGIjw
 6OqH2eqTxygmeP207p8MWTSBhGqk1CA0yhuc5JI7SXVvVQlvs854zRoc5sqeVakBY7BEK0G
 9ahOezAXWEULv163Gxqm0YmcpCdbFep9iK1IBWCNFhIgT3XKmwm97o6Y88MrR/kSwcCO2kL
 Neb/S/2mM0vJOByCm+zhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hpG3HYvgu3U=;I5j0gbVELIPC6Wi6C3+OZsAUMKO
 FJtNJV3rTmdRRYQvrhb4dLL88WxDZZXihlYFU8yJ7I/3C2zY8vXYrJ/UAFYXmvXPMWZsUExvs
 9SZQDGg6Iv7+1YEGC24+wTmjrkxkbfiCBGtQMHSV//DmvlGs0+Wpz3CZGi1QN1Tcje9bu3Tov
 QZJE6/t+61d9NwVQGv1EXmqoTvSlB2JnuZgijmN7bSR9lEDJeqhAM+kehHkgKoT2aFERWiV+k
 1dj07l8P9sCKQChdiVg+Za31FvI+xpzm3H97pSIKlowzzNvFL73IuONmWP9TuolXc+7Ho2mdX
 /BQ9HO2aqcY2ZQxDTPpIAdkIXci/z9mGOZjfZZRx7H0fxemlofb8PiF4cifZm0I9B4wsK6XM0
 G4QY2k0aiWo/k2zE75tpBgBeH6K9asxJl64NCRcpnq8eC37GKLMl+nNx6/oYz2kF47rSsmR6S
 kT9/nsLbu+CTuBSHv1cHNK8SudcWd76mmn+DH3EH2E9kywci28+tr1Pz9nmOz7VYtk7hA00Qo
 6RHHSTbSIA6hI2Ovrl/FoHCUOakrbgn144wHFgLug0b/CnjXLW3xd1uaFTXI0U80ERt5hwD22
 Y2IA3fxyshoJ5vn+OdbzwvVtRDBskxL0+vmXhUKTrLInbrdpx5xkYz5B5FEZ+Wv5rElcFlCS4
 pGaTZiD259T+u99xGgyYbtr+mcwnuDH45idlQcQ3oO0jBOhMiRc6hmo5o/udnc3D1G1TkKZSz
 4bGRvLjCsZe1n8sbB9PCT/j7JWp9oTbZaRQsN98N8bb1ZCHDcO6fsjlNrcDW6oeefpz6v6e0k
 Kz5jFmoFyBjMglxh+E7PdFlASJJhrv9Q28Ehx6Dj5p6MfeKsSi1JBg5Xkdpj1iSv+KlVFcha+
 CCyj7CkqGpiGVtv4m26n0rPjpNkNaGeT2UmIzgJs6xBc1Qbl0YYfTqRpQ9kfPD/0elNqrqonk
 Ik5Ug5tH/4l3HcJK/ehGfCqvIi9Hc+7n6iCMtfTtCSKRIsGVbinjxUXxid4t7B93jSjGEhJDN
 Z/2MW1GhRf6ZI5gvpsDKDRsyl147W6tqLFfpVs8Dyxf7O+/atmOAlV3roaLizdzCjWeKsYHqU
 +kdfC7eIXGZYMQHbELpfPjK6/V1gulkNbtO37/T6FdN3wdM+Na2tdUVDsJzuuOLQUiyjtmiPJ
 0UksQDvfQpHOaAjLVHmqeao4XFfbq4grxGokscTVW2H/Zzjd/lovuIddWiw+VjNBg27H+d+ii
 RlRS3ALU8zVpjG0s8b5j2Vhde3DIfgZWG8jS0aMoPSuJRY4Rhk2BjE2oQ2/yxXszcC8TDPWgi
 o6v8JvyEO1vbHUMA92P+uZJo/qMFVcfalcArn8rg885HzRw0O5FEoz5Z5JuEk4d1YLyoDoCNM
 5Y7MuiJlJ1tKejL9s8xTMtEQAwcTeaj0vUDJjrUIli/+g4cU9VgQFbYhxn

Am 15.02.25 um 02:33 schrieb Kurt Borja:

> On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
>> Add support for controlling the fan speed using the
>> SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.
>>
>> This feature is only enabled if the machine has ACER_CAP_PWM enabled
>> and depend on ACER_CAP_HWMON for detecting the number of available
>> fans.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 222 +++++++++++++++++++++++++++++++-
>>   1 file changed, 220 insertions(+), 2 deletions(-)
>>
>> --
>> 2.39.5
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index f20a882e3650..e24f5a323f95 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -12,10 +12,12 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>>   #include <linux/kernel.h>
>> +#include <linux/minmax.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/dmi.h>
>> +#include <linux/fixp-arith.h>
> I didn't know about this, thanks!
>
>>   #include <linux/backlight.h>
>>   #include <linux/leds.h>
>>   #include <linux/platform_device.h>
>> @@ -30,6 +32,7 @@
>>   #include <linux/input/sparse-keymap.h>
>>   #include <acpi/video.h>
>>   #include <linux/hwmon.h>
>> +#include <linux/unaligned.h>
> Duplicated include.
>
>>   #include <linux/units.h>
>>   #include <linux/unaligned.h>
>>   #include <linux/bitfield.h>
> ...
>> @@ -2867,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>   			       u32 attr, int channel, long *val)
>>   {
>>   	u64 command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
>> +	u8 fan, speed, mode_bitmap;
>> +	u16 fan_bitmap;
>> +	int mode, ret;
>>   	u64 result;
>> -	int ret;
>>
>>   	switch (type) {
>>   	case hwmon_temp:
>> @@ -2892,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>
>>   		*val = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
>>   		return 0;
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_input:
>> +			fan = acer_wmi_fan_channel_to_fan_id[channel];
>> +			ret = WMID_gaming_get_gaming_fan_speed(fan, &speed);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			*val = fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
>> +			return 0;
>> +		case hwmon_pwm_enable:
>> +			fan_bitmap = acer_wmi_fan_channel_to_fan_bitmap[channel];
>> +			ret = WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			switch (channel) {
>> +			case 0:
>> +				mode = FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
>> +						 mode_bitmap);
>> +				break;
>> +			case 1:
>> +				mode = FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
>> +						 mode_bitmap);
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +
>> +			switch (mode) {
>> +			case ACER_WMID_FAN_MODE_AUTO:
>> +				*val = 2;
>> +				return 0;
>> +			case ACER_WMID_FAN_MODE_TURBO:
>> +				*val = 0;
>> +				return 0;
>> +			case ACER_WMID_FAN_MODE_CUSTOM:
>> +				*val = 1;
>> +				return 0;
>> +			default:
>> +				return -ENXIO;
>> +			}
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>> +				u32 attr, int channel, long val)
>> +{
>> +	u8 fan, speed, mode_bitmap;
>> +	u16 fan_bitmap;
>> +	int mode;
>> +
>> +	switch (type) {
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_input:
>> +			fan = acer_wmi_fan_channel_to_fan_id[channel];
>> +			speed = fixp_linear_interpolate(0, 0, U8_MAX, 100,
>> +							clamp_val(val, 0, U8_MAX));
>> +
>> +			return WMID_gaming_set_gaming_fan_speed(fan, speed);
>> +		case hwmon_pwm_mode:
> hwmon_pwm_enable?
>
> Other than that:
>
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>

Thanks for spotting this mistakes, i send an updated series without those flaws.

Thanks,
Armin Wolf

>> <snip>

