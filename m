Return-Path: <linux-kernel+bounces-531804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C6A44533
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E1A188F18D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445416C854;
	Tue, 25 Feb 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PxWNJ4R0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB42AEE4;
	Tue, 25 Feb 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499196; cv=none; b=Cv3JrP6hPDhQuOXrYuBo2ryQZA/ueiWmBrldGMba7bKLid47Mo1lqoFNU5LFdcmlJwXzE7AOdwOpAABoZLp6vku8ph/LlEhd/PvKY/k5DoCwwz0JlMm0xnEpmnAmJiPxXr19ASwtX0/YvE49r/slyQlD20j0ktalmLm13/R67yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499196; c=relaxed/simple;
	bh=vU/jJyxqtXWQ08fyslpvzJxRG6WC82WSeVW8eQEOgRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t516W4m4WOabMhOILiD4NzDRD0IP/wcHw9NvxQNVS2aDBTZKBQAt9cf2p0YtJFFiZizLXM4rrB3e/5qnvGlqEIJFqOurM6wqWhVO3Ehj86PwU55w2lUbnOkn6mcNMosYKIisAPP/tLnvhE2ieQN2m/1wKzcBhOCEoehjxv2tJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PxWNJ4R0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740499189; x=1741103989; i=w_armin@gmx.de;
	bh=VoH3BvQCgsX1U5LuCaZ1VFv1FfMkRAgbcCzq9pEohVo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PxWNJ4R0KtYNt+o+1bJ+QNLqTMAB5MWRY5wRzg48O+TuUVYW3hq5sASzSmpqEj6i
	 +By/W20NpAgvJNKFXoN/rb/GtsfVulSgt31T9MxEUS2pG0xosYJWVToUZ8bggjFkW
	 JEOSq7nLudixysSa/V3UY27no6VjFwl9WitH/UZSh0Qka2e1CRHU87z++3E2RNr9R
	 YjA+jwEtrF9NnhG8MIg2q/oH3I84fasAJbg/OgQjp82wpBklPc0Tyt3SAWxCbZXE2
	 x8x9xcBW/mNtBViObf0KTepY5/si8+lTWwXxpbTHxbCsbp1QAPhg/csPq3KbXhRGO
	 frOhAI97WqH45+Nh7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1szJAn1sBw-00aIYO; Tue, 25
 Feb 2025 16:59:49 +0100
Message-ID: <9aab6df8-892c-40d2-9834-954ca764d5f4@gmx.de>
Date: Tue, 25 Feb 2025 16:59:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: change quiet to low-power
To: Luke Jones <luke@ljones.dev>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 Antheas Kapenekakis <lkml@antheas.dev>
References: <20250224223551.16918-1-luke@ljones.dev>
 <7a958091-84a0-4ec5-bd4a-3e5f973772e0@amd.com>
 <0d67e31ce334085b815f79f9c57a2c4e35870423.camel@ljones.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0d67e31ce334085b815f79f9c57a2c4e35870423.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aBR4wKS7B+kEl44VvOkPmuHEPmld0+ugeeXQtJHAIqLGRMkC06M
 OvQLPUsPJOvHJ6+9SSAd7lCYTMAR0ajuLBDmjOkhhXc98P89akh1a04mnel8Wnto2iciEvB
 cOBshWvngeEGXQFvLBkNYyDHcPBczRivettYPE2v7tq3dpu3JD/+rt4XdJsPQdeRxN5o5aO
 2R5fBtGUNn2dQjy9cZvqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GU357jzTE48=;1yIagCdh0kKUVMPbRHlT3u+6Xrh
 WrVPJi16bBu8/KgbMkO5H864iQe8ApKySUYdC/X/YQBXhaFLlA+E7WVwv2pLW7ykd7YXxY+Kx
 23PcULWJHzD/4+RvnU7aNuGJVRL3Vw7pvVybcoFLF5GHZHx39Jl1mH4182CI1RrsXJ8Luoxrm
 GMw/IHzCQLzTxeWgvYrww5S+6tFsZZ066nl/UZCbGtlaPpUAj3Mq0qxzHQaQ0e9nGKbo4jAqb
 2hVOSi9imBg5C3h07PGhjQ31coeckwZsvdJhvnInxkw+zQnIixiB7M8ePiFScjaU12GL2jImm
 pJL2ugypCJXVdRgrx0NOlEGanEN11yBh0Log5v6VecRmUJ/KcaYrH2ySsHMzNrK+Q5KEmVfmg
 zAyd1R3KJS9WxMO1yHNTvzUy2woPjCCDg1JtARod8sLxElGuFGph2OlAvporHonkNQban1+In
 ZtKmWiJt5+tfLnBeKAOWYe2rHqnX8BcwJrp9YK/c/X3fQ9YS4N1Ymqfb4YynvpQBpEGtT9gC/
 Wm8XIA9qXJa5KEvFc9UWit6gEPPcppPreBhfQYnJXRIx3GzbeKf+Ioo1QWXfedi6H+NSo49ab
 JoGSAYJqW9p8YO78Q6BlJ37uznty9v+Csr1uav4DVATQWoD9LLMiumxapNCmYfPkl1SfXlM0x
 zfIeNeIbIA8rGYjcCBK19CgOI4VaTpcNXP1+kchfA/+gFIaNINSQ6qwcjhKNZD0XNAZDDTQg7
 M8aCcfwIKw4LxWdx80vR9YA4oKELYbAgaWkSK2FbEFOUUnb29PLwyEwfTEJK/1hqrNLEpXTQ6
 cT4ZKB67GQ/9j4T0XoPdqhfhXXgekN1L64cTwsiwQDp2p6FU+T3iVp9NuoAfWuVJqLxqwm2/d
 gP+6+6dJgwe+NItZDO5qJaGjHOVYqnWB/lQpyWp2rg3179M7iOVULZALsWZ7zw/EepYOQAuj0
 oKvus8vIF9N1uCJl7y/qMRIZ4NDmcSqINpGFxB3FJxIhWWdvUY2a2iPrurk+Ygt1M/XLgnhhu
 A8U//ocnQ18vQgCZh+uuV1cWYhJBkUAtMnCgJIQmZ7Owv6fXxCpX5DHvbitYrZbq8pPO6yHpW
 vc7/11FE0cKcZHPlVUyKl117hYTVAZ1iUT09heTjdCLhG/PxA3uFQTnnDnXc0NSZ+S65PFS7K
 nuowX6hL+SXM9mA31IvQOhyhuxR1oTeUIZDYDnG1c+boQlhbQocqqmy7N48Obikt8gm8h2Obo
 1lfXQeSAZJUnfp87nRiNeLw4U2iV6JVbAkbW/R+wPMXWYbQX6HG3pfY+3lunU8AJUV9BT3rF5
 eo0BmjpwOQ8o4SGzQCfCgLltul4PBm//kVGjUQ23bquUjcAuf3XUf3Amy27LwcgapbJ+uX5AT
 4rp2vm49NpK+1tlEngb9BncRiwV3TyHJuFRkHeBvVdvF9wpGBwSIwWfFk3

Am 25.02.25 um 07:13 schrieb Luke Jones:

> On Mon, 2025-02-24 at 18:39 -0800, Mario Limonciello wrote:
>> On 2/24/2025 16:35, Luke Jones wrote:
>>> From: "Luke D. Jones" <luke@ljones.dev>
>>>
>>> Change the profile name "quiet" to "low-power" to match the AMD
>>> name. The
>>> primary reason for this is to match AMD naming for
>>> platform_profiles and
>>> allow both to match. It does not affect Intel machines.
>>>
>>> The quiet profile is essentially a low-power profile which tweaks
>>> both TDP and fans - this applies to 80+ ASUS laptops.
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> IMO - this should have a fixes tag since this should probably go in
>> the
>> 6.14 cycle too.
>>
>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple
>> handlers")
>>
> Good point, thanks. I assume when pulled in this can be added?

Antheas is concerned that this patch might break brittle userspace scripts
like "echo quiet | sudo tee /sys/firmware/acpi/platform_profile".

Maybe we should instead change the strategy used by the legacy platform-pr=
ofile
handler when selecting supported profiles?

Thanks,
Armin Wolff

>>> ---
>>>  =C2=A0 drivers/platform/x86/asus-wmi.c | 6 +++---
>>>  =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/asus-wmi.c
>>> b/drivers/platform/x86/asus-wmi.c
>>> index d22748f1e154..de19c3b3d8fb 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -3945,7 +3945,7 @@ static int
>>> asus_wmi_platform_profile_get(struct device *dev,
>>>  =C2=A0=C2=A0		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>  =C2=A0=C2=A0		break;
>>>  =C2=A0=C2=A0	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>>> -		*profile =3D PLATFORM_PROFILE_QUIET;
>>> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
>>>  =C2=A0=C2=A0		break;
>>>  =C2=A0=C2=A0	default:
>>>  =C2=A0=C2=A0		return -EINVAL;
>>> @@ -3969,7 +3969,7 @@ static int
>>> asus_wmi_platform_profile_set(struct device *dev,
>>>  =C2=A0=C2=A0	case PLATFORM_PROFILE_BALANCED:
>>>  =C2=A0=C2=A0		tp =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>  =C2=A0=C2=A0		break;
>>> -	case PLATFORM_PROFILE_QUIET:
>>> +	case PLATFORM_PROFILE_LOW_POWER:
>>>  =C2=A0=C2=A0		tp =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>>>  =C2=A0=C2=A0		break;
>>>  =C2=A0=C2=A0	default:
>>> @@ -3982,7 +3982,7 @@ static int
>>> asus_wmi_platform_profile_set(struct device *dev,
>>>
>>>  =C2=A0 static int asus_wmi_platform_profile_probe(void *drvdata,
>>> unsigned long *choices)
>>>  =C2=A0 {
>>> -	set_bit(PLATFORM_PROFILE_QUIET, choices);
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>>  =C2=A0=C2=A0	set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>>  =C2=A0=C2=A0	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>>
>

