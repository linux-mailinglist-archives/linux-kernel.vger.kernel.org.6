Return-Path: <linux-kernel+bounces-516342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41EA36FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9B47A2B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B331EA7C3;
	Sat, 15 Feb 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GcJ38R6J"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC7189903;
	Sat, 15 Feb 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641255; cv=none; b=DggOYyBq8yJeLek4mZvkR+iognQieYXTDO5pEeSmn5iqUDk1RdxCOj6B1EDQpZkUQB2hFiRi6bCUI4MQsTCy8Oc3bKM+nuW/Nw1nm5ynbRZmxGw6pFwy8tHgRkWnj5Bsy17WK9/kfd19z9AhsyLT8hY7yVIvlZpD7wGvmehVpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641255; c=relaxed/simple;
	bh=ToMJ32MpZzzJ3nOSpEgFIHXzL+CYpATdx2P1nn6+fes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohYOJnh6wLTjNAjMsWMoUgmGWYE3Y+YafEHIF8jwVNORghhi17C4ZIYJiU//NAqOKpCS331LKwmcdRK4534DllbaNxpsrDHmZ21q3bc0j/wEMZdotVynAsSjdeK9hrKvT8gMjaTbRX5isaS9IhvusSa1g5Jxm4Br8jEFj4YSRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GcJ38R6J; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641248; x=1740246048; i=w_armin@gmx.de;
	bh=5ZelvlYh6aBK2LHjsohefzmVMSTHJ2q/ZxcWfXRt01U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GcJ38R6JmtQ8XcBLfpEllU4Ohxv4g/+NDF59lYPQZ72H+QTxOy62rL1ksaEKvodp
	 qnKLXAU/Nw12SIxQy/+0g/Nvh/h0gWRPOGt3jkSR+hO/Wp3+O0h/YMvd1cuFVG/ly
	 NYutLjGTg8CPgdnki/pb6F0DdivV70gQNQ+iV1xDl8X3Y1D4jXU8jn4qt8i6WL9zV
	 F5EMsdcqNz6ZdZChs2o4dfW6W25f6S5gcQZlqEs1zRmkwlxd8GeX/2VpftDFcbqTB
	 HXtZ/CCP0UHA+jb0cdJ1VZNnVk+UoRxkBNcLJVU7SpqT4a/cKR//xwt/FGK8VmWWx
	 aqV1xWp3Idgxdj5jwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1u4kef3e3C-00P3rH; Sat, 15
 Feb 2025 18:40:48 +0100
Message-ID: <9170b163-9eeb-4710-add2-6cefaef1eaaf@gmx.de>
Date: Sat, 15 Feb 2025 18:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
To: Kurt Borja <kuurtb@gmail.com>, jlee@suse.com, basak.sb2006@gmail.com,
 rayanmargham4@gmail.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-2-W_Armin@gmx.de>
 <D7SMPVK7KM8E.3VYTBGLEVS109@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D7SMPVK7KM8E.3VYTBGLEVS109@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LyBIUhimHxi4htnQsAoA1tVI6G/gxeDQNsCl/u6NRhNfwCKJYVJ
 mh6w7QTC3LufKI/woyAsRPNLlFhcLJ3aEvZRBkl9v8EnvkP1Gw5G4G2aIrkBJE+cMBujIvc
 bIO0MkVKI1SLE7KlaeOuw/g6iRWvj6/74D2bg5aHRwmf6tL9mQggWoOOKasNHv55IBWxIvL
 jqBwFcVtdhgoEUR9zVPSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GdrzLYKCTXQ=;WZYUC6pn32itez9k6R0oCCIwAQO
 GaCwgFlRpu7vAmm0tqvPMq5mCHa5WPPLKT4BD3biz4XcQfy8u95RsHMGAd4lzMRzug82xAjAq
 frM1eUW6I6AUsE84sROgTt7oHe89rQrIQuWQjNNxsesXbtwMWcZ1CZM2w+bifQZVCqEsDgVUe
 jJHY72JcoCS4JZBi+i+FQKl/8swNpMXJk0cl6jHEDgLBn4uISgFoLBXJLQ7f81o9WTn7Ld6hx
 4JBPWHjL9MuFQ/4dJLJVpq3JvqjxT3n/2I87YyHlonBdH6rV/hOBY4fU4vUzytDaPTa6dE3kt
 uqJBbGkVD8qv8ZWladwCFTdDhjlLrLG68G0CqZEIwTIOmKUl58kbQVzXVaP1B1hyjhpM15Pwj
 /tFEOEhiK4FE8sqGsOSg/XRu4b6T8GPDhdbp/hV5lpRLUdpsmOGzMqzLg7RLUicM3zwJUssVR
 mPaJlz6KsJPuYAukLpjaoc1Dhvxl448sS19GjwFnXUlxxGO/6LVnHT9kKD3hcA7ppjfIGP1PO
 ta8e6UUh2/lU4TSVwimb1e9ROscm4qNaH06BOSyu6Y7qAsrpG4eh50okrRQCXpacWO+k02Kbx
 05n/jTBfFfzXO+BTQsSPBjoT961YE5VmtvFG2ZrZBhlfbJ/Lol+8Z1epn3kTZ1IlbwzOhKASb
 zcbcaFm23h8RGxKv/4oR/LAT7HhLDhrhtpjBpWJ+IHjOzvCtVb4//xajA/pt+crmbKanqx9gK
 gNh8nC9YBg/Lr/mC870DgCDZZTRNtsN+mCxHCb9YquUriazxrx47aAlAERFWVbjSl7Aivc5gk
 MHcAraj/HTBpF4Z1wGN/Kazr3kvmM42z4SyGNgVtfzLaSaAVNIsjChWbbhWOibf6tTZ0GTEg3
 LxpfJcBZtYvWs8qa9+nYZs3j4rCpTNZTJHEhGd+Y2sHxiz96Ao9e2GFhYiokwXVblBjTWYE/j
 n8iV/xC31lrZMxOeyVrD6x6kayg64WSTFI1wItX91POotHjoUAoqL8GXoImv/pIjKw/NVDYW6
 NaGPXnRbsvsUdJ4OgD9uKMloSUHMOt0hkeulF2xl4ATrYi1/w+CaOsrTXWT0/QrT6n0q9lPCH
 oam+EDNEmFtuby+NEaXnW/TyKe5DRuZw2edESxBSySWMXYNBihAnsk5r2kibxyHaez9Fh2K2f
 6X4vYBflduguYPmTTyVShO5vsaoLzxSfNX2HnRF2sza2NezUk0rp7HVBnMuvMU3O3rexK9fyl
 vPpjiflUIarSpFN7huWL8+bA0yRzb0frr+SmlxMo55hw2fsRv64kAjK+wqIScuh8atskR/Rck
 rMe7RWMf1pydlKqXzfhy3FE2QOHDdUU9uNUL+oLG8vAoHHb0IGrbemCY6UAvBFnDHV7xM0vHQ
 ZWJGhAb/t4KXmt4xGtDkiSKttshrASPUfird5KfEuQpG7WUmB4IADlS2FkNSg5KXTbB2CWVHE
 QmjqH91GrCwC3ubRtRFQeTOhvvsE=

Am 15.02.25 um 02:30 schrieb Kurt Borja:

> Hi Armin,
>
> On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
>> After studying the linuwu_sense driver
>> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
>> the meaning of the SetGamingFanBehavior() WMI method:
>>
>> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>>    change request.
>>
>> - the next 8 bits contain four fan mode fields (2-bit), each being
>>    associated with a bit inside the fan bitmap.
>>
>> There are three fan modes: auto, turbo and custom.
>>
>> Use this newfound knowledge to fix the turbo fan handling by setting
>> the correct bits before calling SetGamingFanBehavior(). Also check
>> the result of the WMI method call and return an error should the ACPI
>> firmware signal failure.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++----------
>>   1 file changed, 52 insertions(+), 23 deletions(-)
>>
>> --
>> 2.39.5
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index 69336bd778ee..f20a882e3650 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>>   #define ACER_WMID_SET_GAMING_LED_METHODID 2
>>   #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>>   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>
>> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>> +
>>   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>>   	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>>   };
>>
>> +enum acer_wmi_gaming_fan_mode {
>> +	ACER_WMID_FAN_MODE_AUTO		= 0x01,
>> +	ACER_WMID_FAN_MODE_TURBO	= 0x02,
>> +	ACER_WMID_FAN_MODE_CUSTOM	= 0x03,
>> +};
>> +
>>   enum acer_wmi_predator_v4_oc {
>>   	ACER_WMID_OC_NORMAL			= 0x0000,
>>   	ACER_WMID_OC_TURBO			= 0x0002,
>> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
>>   	case ACER_CAP_TURBO_LED:
>>   		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
>>   		break;
>> -	case ACER_CAP_TURBO_FAN:
>> -		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
>> -		break;
>>   	default:
>>   		return AE_BAD_PARAMETER;
>>   	}
>> @@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command, u64 *out)
>>   	return 0;
>>   }
>>
>> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
>> +{
>> +	acpi_status status;
>> +	u64 input = 0;
>> +	u64 result;
>> +
>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitmap);
>> +
>> +	status = WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID, input,
>> +					&result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	/* TODO: Proper error handling */
>> +	pr_notice("Fan behavior return status: %llu\n", result);
>> +
>> +	return 0;
>> +}
>> +
>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>   {
>> -	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
>> -	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
>> -	int i;
>> -
>> -	if (quirks->cpu_fans > 0)
>> -		gpu_fan_config2 |= 1;
>> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>> -		gpu_fan_config2 |= 1 << (i + 1);
> This was not replicated bellow. Just to be sure, are there no fans at
> BIT(1) and BIT(2)?

AFAIK the Acer OEM software support the following fans:

- CPU (BIT(0))
- GPU 1 (BIT(3))
- GPU 2 (BIT(4), but untested)

The other bits seem to be unused.

Thanks,
Armin Wolf

>> -	for (i = 0; i < quirks->gpu_fans; ++i)
>> -		gpu_fan_config2 |= 1 << (i + 3);
>> -	if (quirks->cpu_fans > 0)
>> -		gpu_fan_config1 |= fan_mode;
>> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>> -		gpu_fan_config1 |= fan_mode << (2 * i + 2);
> Same as above.
>

