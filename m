Return-Path: <linux-kernel+bounces-425905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706829DEC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6F9B21008
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989A1A255A;
	Fri, 29 Nov 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Oq6SxJrm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEB19F423;
	Fri, 29 Nov 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908583; cv=none; b=PZYh8ChiQ63XotOPBAZrs57jvJaZ4VEUGx3BV/rxJr+KUWl2L8bChqVv0DS28Y5L+xZD8XX6HvfpY6vZaxQJC82Dp2+m+B1bHsQ+fBKV4YqURtyX4ARhRfQib8pyQl5pla4sfiM7b15XesCu7J/DRtl95h5O8DpjjFufKIxAFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908583; c=relaxed/simple;
	bh=/J52vrmfcRnK7jbiYRJT3pVi4JjkolvStR/bcNydMJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcFdeKYwe/5bf34A9dRrSqKVfH3oD74mW8D+IYkBKzr7ctR7oU8mqvZ5Gf36GKd4BLk/5yjYqCIaa9q6ch6/ZG+G3ijq/0DCtQY1WXm9fz/T+g3vicqXE01kf7mmqSkTOvGmrVb1WJ4HmsUp4iqejRDSjSLafycsk/uNhsShSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Oq6SxJrm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908569; x=1733513369; i=w_armin@gmx.de;
	bh=A9ePkhf5Nu7hLnolpjIecmRfXH2fTSGVAzXsoIu+/c0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Oq6SxJrmx7RZPyMdr4K2Vbqcrg0O5lkv5MRXFu2vtxikdxciVxdZjMgHWXZnnw2C
	 lKAtd78mnCbjiYfH9Gswd0ZUlhEy2SN69dsst/V0iKwDjXzpYbvFU/MquVIk8V7Rs
	 Kw7c2o698aQ7AB7AYUxMAx8D6bJGMjiPO6ZnFkXGJVz99a5sygGP5ZN18qa1177Ld
	 EdUd5r7pSO2IIQtFY3XFDCoOBJoqP7TIJ/LNAMviQn0Qvc3l2EYiI1JPx8erxUVjM
	 DZeuUnpcfUARzF0w6KDHSpvRLGWttv77afgIWTEI5Y5uEv7gVUh/Hx5bSZRs8mYB3
	 vVMqLbr9lHPSsjGFhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1tEdhi29jH-00Fp1O; Fri, 29
 Nov 2024 20:29:29 +0100
Message-ID: <a56a1bed-de18-4530-aed5-ea8471962c71@gmx.de>
Date: Fri, 29 Nov 2024 20:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing
 thermal policy
To: Hans de Goede <hdegoede@redhat.com>, auslands-kv@gmx.de,
 corentin.chary@gmail.com, luke@ljones.dev
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241124171941.29789-1-W_Armin@gmx.de>
 <13590dd6-1529-487c-842a-85b44c577811@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <13590dd6-1529-487c-842a-85b44c577811@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8LvAS8TCA7ldVXthPmQ+/nOv9jKYXF1kZbDWHUYH3kFMmUYe0yu
 t3SaLmEY1LuUpL8S5nejG9KODvPpWcFN4orqsWFywEKMAlwrJpR6Bol7NYIPjkLQJu9V9GF
 +mrDYlvDTh4tc9/eU0WFriXXahmSOk8z/jDoeLgCSpwRwPdWbrFr+mjFOwDbaWUIRogTZXX
 OfOf7vDs14N6O3r0DFl+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+pwvYrRx9Bo=;L2Y0D0ldyucPb2B5Dq3ZufIAsT7
 hMZiXd+iUwbu2WGl+cdocz9Ci4q/INYY5gcfMpG+dpg8O8SPMNptLMe5c+7+xZTd5hj+WBiSz
 UjzP9AlqfL7v5lDpSw8lIiemillwle2IZ3FakborNUVQSOsQU/xzj7743R75uyYeFy1+m2x7T
 s3GNRw85gWlXD61wR2YHaUcrQzVuBglLkKeWv9f8HfpcRU6HWZbq4zPDMQePd42B/ADC+Q00S
 sBGFZnghQhPOUW5CLiKxEJWL2dhBwpiXp/j1MY7aw523sxg/+RVJucTlDnNhT8W5hKgf+9qz8
 CUBzBZZ6DAtkCyXhkP/w6spWQ30hfss0EACssgQP8ANpeB5ID7HFiwNhwJcYVkjhWUkScl096
 PSPVfH6wZUFlikSD7X+CMcG4cZYsKZKdMEPqOOOOV02knivoGbVhlSRpDd9DowfnUGLmD3FU9
 e9Zw5y3SE7F004dM37SplRBq/e5ij08I2ng/4W4beYof8Xe+85M32fjpfTbFyQhf5s8xnUV2k
 QFJv61fz4s3FAIqhtAvdTx3oTlvX8AcunA2yuNqZL8KmUFBCmdEzCEjELOhEXEnyrUzqc9puj
 2Flh54JBK6KX7PISFJgYLSvGLNuN+Yi51k+S3J/Fd2T0laDM8R23sXPK8wWh/XK5WeNUDY1S8
 HNrWNWubI6g1R5adtZMH02FY3oEBMNhevfhSscKanyK1DuQVM7iYrPwNGGO85fH6Suo3UQgKu
 75v0nvag7PI/Q9UxXsiIj2BcowBAzhAMAZiIwWPhKGPMi4Eb4s2xdi9pGe9JOGW5ql0+f6NbI
 jdQjD6ZBfgtAwsR/SVEcYja/bn6yAoA9H149mULvvEBi2LDQgGUMmzZZSZC1E7byEU+awygC7
 D2joKdJa4zK3ISU8f+LgctL0EoyZdncTAG1E1EOmmEyxPBMjCHW0nTKmLkuQzAJUpNRj/c5uP
 Pty2VJ8PwyyGbdShtPxOhz0FYKB29+wZNg2gjbeOjI4vEWso0Yibe8lydMW4BpH5H5dHk2Yl7
 ev/267MRobJMYv+36jZsDHl6xK1GicwUdYpjngkKOwrtGK3YAgfRsNlIKNEQtsN/X25hCUvs1
 oVYf2CMBScoHxj3EBRvtKvRJITvFG8

Am 25.11.24 um 10:39 schrieb Hans de Goede:

> Hi,
>
> On 24-Nov-24 6:19 PM, Armin Wolf wrote:
>> On some machines like the ASUS Vivobook S14 writing the thermal policy
>> returns the currently writen thermal policy instead of an error code.
>>
>> Ignore the return code to avoid falsely returning an error when the
>> thermal policy was written successfully.
>>
>> Reported-by: auslands-kv@gmx.de
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219517
>> Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle thermal policy")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans

I forgot to add the following tag:

Tested-by: auslands-kv@gmx.de

Can we pick this patch for the next fixes pull?

Thanks,
Armin Wolf

>> ---
>>   drivers/platform/x86/asus-wmi.c | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index ba8b6d028f9f..8bd187e8b47f 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -3696,7 +3696,6 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>>   /* Throttle thermal policy ****************************************************/
>>   static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   {
>> -	u32 retval;
>>   	u8 value;
>>   	int err;
>>
>> @@ -3718,8 +3717,8 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   		value = asus->throttle_thermal_policy_mode;
>>   	}
>>
>> -	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>> -				    value, &retval);
>> +	/* Some machines do not return an error code as a result, so we ignore it */
>> +	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev, value, NULL);
>>
>>   	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
>>   			"throttle_thermal_policy");
>> @@ -3729,12 +3728,6 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   		return err;
>>   	}
>>
>> -	if (retval != 1) {
>> -		pr_warn("Failed to set throttle thermal policy (retval): 0x%x\n",
>> -			retval);
>> -		return -EIO;
>> -	}
>> -
>>   	/* Must set to disabled if mode is toggled */
>>   	if (asus->cpu_fan_curve_available)
>>   		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>> --
>> 2.39.5
>>
>

