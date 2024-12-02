Return-Path: <linux-kernel+bounces-427683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC59E04BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5897283C91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1260204088;
	Mon,  2 Dec 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Hf/bBhfA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160F1FECB5;
	Mon,  2 Dec 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149429; cv=none; b=aomcMK/wu9wY7lRddfYoIT/Na/1Br4S4EAMMIsTG4fqnxfK192G6ICLqV4C2z+IHsQwAULaHLFqgAtkZrTaqUQGQWA2MiprJG8UmCbqOnwBleUOxjAdB0KgFLR7HkezhBaqwXRIt+t91MkDOae8sX0xHjGspdbhrl0hFT3s+hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149429; c=relaxed/simple;
	bh=Ao5ICESfCnEB0/KxGPrgZXMQvmXXWhoXoVh6BKt2AIE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ur2SUbJyTDlhOxyGi6RU+hjTxLWd7wUKI4Kb5+R/MfiAVko78c/pWzSeNwTAdqKteMvNmFoZU2mKjRorCEXF2LtWQibF0DsDiGzLSiGd/5MXR3iTt9CHM14tFjPLZ5x6rt3aYok3Agu91IyoMXpwm/DCbgC5mT6RV8MVsM8EE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Hf/bBhfA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733149416; x=1733754216; i=w_armin@gmx.de;
	bh=Ao5ICESfCnEB0/KxGPrgZXMQvmXXWhoXoVh6BKt2AIE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hf/bBhfAq9LwBkIf6GIAbdcbe3BAXGfFtAD2L7ls6NEp8/ISSDOviVJ853ZtMtAT
	 q7fk2LBm5KBYdaapwujRTiFZ2U/2HwuqdIsIR+oAqF+1wduedey+wJkt2vkw7ZOu4
	 lMOFW140tNWCet2vSwsX72rLZNPQYvCmMBH3EZVEsLNsfKhQJP4q/GS30SbfwHlGr
	 8c4kXGqLfhL4hZrC74hiDxTgi8AGRPMaIIVlMOOi5Dom0cIP9Ox2bVQYAuLZO90qE
	 oB+RUbezJbth0AqmJjmXolVB4C7QdTMhb9/SkicasHaecpTBbJVntX9NXtGGNxwZU
	 FUrYEY/ja9rFxpXY4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1tD9V337MU-00IxWS; Mon, 02
 Dec 2024 15:23:35 +0100
Message-ID: <c06686ad-f755-4f14-8df8-f5b47e246f98@gmx.de>
Date: Mon, 2 Dec 2024 15:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing
 thermal policy
From: Armin Wolf <W_Armin@gmx.de>
To: Hans de Goede <hdegoede@redhat.com>, auslands-kv@gmx.de,
 corentin.chary@gmail.com, luke@ljones.dev
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241124171941.29789-1-W_Armin@gmx.de>
 <13590dd6-1529-487c-842a-85b44c577811@redhat.com>
 <a56a1bed-de18-4530-aed5-ea8471962c71@gmx.de>
Content-Language: en-US
In-Reply-To: <a56a1bed-de18-4530-aed5-ea8471962c71@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZgQPLWC76QF/iO8H6NqcAHN3kNPw16JZA4xNuBq9btomrzuLJO
 cmovFWm/HaIsZCJe3rgeLg11+rqJgUUVekdFLMS/CTJvNxGbQBecifKhrjS2Z3FIc6Uo9qd
 TXZ008jKtE/H38CQt3UrhBcA9RwShS9eyU+1vJ5ESxXi9YI1CfOQhnYhqlcKhDE+qeKw3tF
 yFj+tw8h8D4w8JkcRhEnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ofpj5GPojQ8=;6hJddhfTgd3TOZTOSVWnFtqtZKA
 GNSB03rFB2tW7BEnOm9VcMlkCuzesCg3mOUFms/DMhCr6JzGdblNEJ4CJzpY2wUfAu0UUeTz4
 0TrdB2UGrQPwwEBb0s7rrdNoe6EcGfaETfKIQGSAebKvAywscHtCNBUmNqY71FucEq79LNk3g
 gSirjDz0EQGpQbtVEiQnAI8JuuBWqApq0Mb8Q1/0WphOOVMen+pD+nbvYkhs3HaYFFOOH65et
 sUIfLozVw0Whb2FIrtYxGTOkMgIYbcZsIqL4xk9ALAimJ6w+s4Bh0ds0SocHEPQ8PNT644DSg
 IKziRbkSg6ykmUv4J0lsecGYOp4B9ao12qruR6vioYCP8sm8q3uX8huPcwqMWFV6aElWp/q/t
 XUg9TYM+hB/OjioKyzufl607hiwpRMAhqa3VHtZFwZM4P74/czHOVjzmASIu3gJ+weHS9J/IR
 OpVLGknr1KlyiTV0Mfn0myJKhkqRg2YnpzJREej1ZT/tK85raa6Eac4MPKTcdZRAEH67shqyh
 FAA4O6yr09dEqWUCm1b+a5ICEZi8txFm74hUhpSQmZG3hxx8P0B2/eRQCXl+YATYjeP3m5u5+
 StdiOAZopES2uubfrCVUIP2CwgPI4ULWZirG5PxOhON0e7pypsiOcvhjzl4nIliVDS+ZnH1QO
 oJK8GAOqJ6IYWBY1ar2fyQODdnbWoYY+0xM+Cbw5vMQzNHgR+0UGVibXkJvCOGyOi7tX7Cqta
 Zp3UmO4eoA8wnYvH62U2wtVFqY5wVUSCEl/+yKa41rMJAPiKAZH3sRPbyXWQ/Kutw4n3+3ndy
 bqsPQhFTX7EXV/2VBavQwGRabqoCd0JFoCfTR7iye7xK97nXrjtDGKLXeTifb2UB+Tpc/0sfU
 8EFfm2uvgAl3Ygevv96IjSbjzNMqChqTT5f6un4I+y7cehn34Glhs4iafoNmLrFXRHOpUvNKz
 2glhiS4sQYJE4z+oWLtBibBjpL7xWYXrf1RCMhR74o3LWB8PvpfAYYTFg02fEpxD3UQFlBrww
 NOczHUoegKvsqBAAHxvNqim08fc6BfDrYxp94QCqMozRh641bJ8riSbXbzoC6/aJWZ4yBqJWW
 Ptco9+cyozSCIsdzByKhiwcGZPrqrz

Am 29.11.24 um 20:29 schrieb Armin Wolf:

> Am 25.11.24 um 10:39 schrieb Hans de Goede:
>
>> Hi,
>>
>> On 24-Nov-24 6:19 PM, Armin Wolf wrote:
>>> On some machines like the ASUS Vivobook S14 writing the thermal policy
>>> returns the currently writen thermal policy instead of an error code.
>>>
>>> Ignore the return code to avoid falsely returning an error when the
>>> thermal policy was written successfully.
>>>
>>> Reported-by: auslands-kv@gmx.de
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219517
>>> Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle
>>> thermal policy")
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
>
> I forgot to add the following tag:
>
> Tested-by: auslands-kv@gmx.de
>
> Can we pick this patch for the next fixes pull?
>
> Thanks,
> Armin Wolf
>
Another user (Edoardo Brogiolo <brogioloedoardo@gmail.com>) reported a sim=
ilar issue with another Asus machine,
see https://bbs.archlinux.org/viewtopic.php?id=3D301341 for details.

Are there any blockers left for this patch to get accepted upstream?

Thanks,
Armin Wolf

>>> ---
>>> =C2=A0 drivers/platform/x86/asus-wmi.c | 11 ++---------
>>> =C2=A0 1 file changed, 2 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/asus-wmi.c
>>> b/drivers/platform/x86/asus-wmi.c
>>> index ba8b6d028f9f..8bd187e8b47f 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -3696,7 +3696,6 @@ static int
>>> asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>>> =C2=A0 /* Throttle thermal policy
>>> ****************************************************/
>>> =C2=A0 static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 u32 retval;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 value;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> @@ -3718,8 +3717,8 @@ static int
>>> throttle_thermal_policy_write(struct asus_wmi *asus)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D asus-=
>throttle_thermal_policy_mode;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 err =3D asus_wmi_set_devstate(asus->throttle_therm=
al_policy_dev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value, &retval);
>>> +=C2=A0=C2=A0=C2=A0 /* Some machines do not return an error code as a =
result, so we
>>> ignore it */
>>> +=C2=A0=C2=A0=C2=A0 err =3D asus_wmi_set_devstate(asus->throttle_therm=
al_policy_dev,
>>> value, NULL);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_notify(&asus->platform_device->de=
v.kobj, NULL,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "throttle_thermal_policy");
>>> @@ -3729,12 +3728,6 @@ static int
>>> throttle_thermal_policy_write(struct asus_wmi *asus)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (retval !=3D 1) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Failed to set thr=
ottle thermal policy (retval):
>>> 0x%x\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
tval);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Must set to disabled if mode is togg=
led */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (asus->cpu_fan_curve_available)
>>> asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled =3D false;
>>> --
>>> 2.39.5
>>>
>>
>

