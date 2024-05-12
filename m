Return-Path: <linux-kernel+bounces-176958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136218C37D4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284DE1C20B57
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3E4DA13;
	Sun, 12 May 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="F3vy2ex8"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D717BA8;
	Sun, 12 May 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536454; cv=none; b=N5r/sUFDTkYIV4at+UJWm8flB2YmByEJ3aP5YugDKBHgB7EpoMgEHzGwZZFZAqlxbMuVP3vs1By8FOcz5JQbGsIPekdd6X1us5R6OH18W3+zf+ohumqMcDPsq3gaGLExgNTMIW4GQR0PT/Zzo0/QLfwMv98h83xbfXBPnThMhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536454; c=relaxed/simple;
	bh=Rz8h5SH/vN5ljEqAG22wkeEZTE2i7FqMBwTIfRf/ScE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9di90Q8SKvEqHUST4OdfCjQ2Y6UsU2niH5g4JIZmWYkIaTlRHn9+kL0IICqEojBXoob8vXqWNcGLlCs5vBIdBHB9kOCPwUHpBA1F5yvwmANh4vzKZ0EjqjH0O/nevysFCA5ah+TSufd1JsRSnL5njhjEy467szIcj6mBvHnzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=F3vy2ex8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715536418; x=1716141218; i=w_armin@gmx.de;
	bh=ZxnIQ0JAXKitnZtKLLipAa7b2YIbxgaE1tOrjgHQ9Nc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F3vy2ex8um7+h3ZfhpjN2qbhsWGtPqWKZs70EhDSYcOS/eqq4bRmAcyBt2sNJZMp
	 i3Bx3Jh4Ov2FnwqooCRLTWyN8O7hdJv6Ne9LygaNxZcVN0PMWPNy2017JSGveERgZ
	 LQuec3uPfO6ySR5BLOp8aM1AXoKyXRdTf2P4O0p9WocON+s6b9171MLpc8RNq3Pd+
	 A6zlMqIdxlbK5CeeafBdbjAuCVDVY/FwV60gqiZKJEHhWB8dHx+Z1+IO2SWwzQGsl
	 y3szQb73I5y8ikEG54h2Dh0vOA868h3lEJLQH2BR1HIuT/oSrEEZUMbgs6ROLdMYb
	 xtTJXALuyUcRz+L3FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1s4gyB452A-00WTup; Sun, 12
 May 2024 19:53:38 +0200
Message-ID: <4d8de625-9018-4926-9519-37f5a90a96e5@gmx.de>
Date: Sun, 12 May 2024 19:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: "Shen, Yijun" <Yijun.Shen@dell.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 Lyndon Sanche <lsanche@lyndeno.ca>
Cc: "pali@kernel.org" <pali@kernel.org>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
 <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
 <BY5PR19MB3922A117E489A55C3C7FAC789AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <BY5PR19MB3922A117E489A55C3C7FAC789AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m4SokKj7X8YDhHxwhCPLBxRpWnhRpNOV++recXzvERsMSfkrZRb
 MvhVxWP+80xvUKiWIax2PhYo9fHKD/F3gX0o7HZTCqLKridsg99GedMXDH9aCxuTgBy9wVy
 Z2otpqS9GyagrMU5trSuWH4AMU+mGrskULE4+WUHghEqYqcdxHw1H3/PNp8J7daannK88+C
 mb5jw6rb67n5ucqaa5EIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YAwosBsfRDE=;pTCzJ2jHl+MG1RaFSsOoJXTazOr
 L5cxjiyzlOFCaNeejoWU0KW2F/zxd37ulMYHhCxBSsAfS0cH3Iv26xcQuVjyVB5OqlL0zbaqu
 8L9ugBa2xjxhCjn7PUvlTE3+ElismA1EIfgOrgU9lHVf8u64KX0QR7V8tA5HYvmsHneoYjgCH
 ZsfJHGM2ttQfxE3adwDb7sSqVA0rN9rGBbRVn+y+5/O1kWuJNQL9vCHgjLUUNOWJ5ggdcwcPD
 DKJfYmume/9dH4bRHG4DjlgOS0nIvNuVettrXceKgkxDvTri8+wjB7cF90UNG/Y4Cra6Pp/eP
 jGClWJv4iCwX5dOfnE6YkApyF1lKpDJXaJWsLKImXUnX3AXZeeXkTwZxlZ8XCY/fYxiIT0n9F
 VJvZxX4UBiCtPiTwxkTDtzeaI8/+OiUODjZlJ1OtlQkHKycdO6a5lKNE2LFuM1y/1x9VGAqVS
 Nvt79I7C7+PQDcZS1VrJWHdRLWvVEWs9Iwr1IOxgXuqBpEwcWMSEgTAYS2si4ZL5it5oeLiJ1
 6sIJwnmeNpb+2M2xnFb0bBuGTzLBRxMVSxYHOp6dy959Jen4zaI+LDBMYSWRhKD/73DM4la9G
 L8bogI2cqH6Jxs3xznhNkhUlmYsOJIssMu02KOnjgWf0qeOpLk5rkJYmm/TcWpKLSxcFEKPOg
 ycs1shIYaT8TLsyTRXwY0EnoRZrREMiRk/vaACfKOVABlgDAixCfPKWhDamnVoGuwzgknCWSt
 CF3awzaDFAiWgnQ6ID4yDS6B/CoPmY0Ja5JSRpOuVUHOydFclgm4qvoC0w++ADAP3MuG/8r15
 /4ejaA4nVuLItJeo/blNdotimOL/LH//eCmcDcNrYHNdo=

Am 11.05.24 um 17:56 schrieb Shen, Yijun:

> Internal Use - Confidential
>> -----Original Message-----
>> From: Limonciello, Mario <mario.limonciello@amd.com>
>> Sent: Saturday, May 11, 2024 11:13 PM
>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>> <lsanche@lyndeno.ca>
>> Cc: pali@kernel.org; W_Armin@gmx.de;
>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew Garrett
>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner Kallweit
>> <hkallweit1@gmail.com>; Vegard Nossum <vegard.nossum@oracle.com>;
>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Dell Client
>> Kernel <Dell.Client.Kernel@dell.com>
>> Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
>>
>>
>> [EXTERNAL EMAIL]
>>
>>
>>
>> On 5/11/2024 10:05 AM, Shen, Yijun wrote:
>>> Internal Use - Confidential
>>>> -----Original Message-----
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>> Sent: Wednesday, May 8, 2024 11:53 PM
>>>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>>>> <lsanche@lyndeno.ca>
>>>> Cc: pali@kernel.org; W_Armin@gmx.de;
>>>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>>>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew
>> Garrett
>>>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner
>>>> Kallweit <hkallweit1@gmail.com>; Vegard Nossum
>>>> <vegard.nossum@oracle.com>; platform-driver-x86@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; Dell Client Kernel
>>>> <Dell.Client.Kernel@dell.com>
>>>> Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
>>>> platform_profile
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> On 5/8/2024 09:24, Shen, Yijun wrote:
>>>>> Hi Lyndon,
>>>>>
>>>>>     Thanks for working on this patch.
>>>>>
>>>>>     Dell side has an initial testing with this patch on some laptops,
>>>>> it looks
>>>> good. While changing the platform profile:
>>>>> 1. The corresponding USTT option in BIOS will be changed.
>>>>> 2. thermald will not be impacted. The related PSVT and ITMT will be
>> loaded.
>>>>>     Some Dell DTs does not have the USTT, Dell'll have a check if
>>>>> nothing is
>>>> broken.
>>>>
>>>> Hi Alex!
>>>>
>>>> Have you had a check both on both your AMD laptops and workstations
>>>> too, or just the Intel ones?  I think it would be good to make sure
>>>> it's getting the correct experience in both cases.
>>>>
>>> Hi Mario,
>>>
>>>    I've a check for this, for both laptop and workstation, the dell_laptop
>> module will not be loaded. So, AMD platform will not be impacted by this
>> patch series.
>>> Follow is one example output with workstation.
>>>    #lsmod | grep dell
>>>      dell_wmi               28672  0
>>>      dell_smbios            32768  1 dell_wmi
>>>      dcdbas                 20480  1 dell_smbios
>>>      dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
>>>      sparse_keymap          12288  1 dell_wmi
>>>      ledtrig_audio          12288  3 snd_ctl_led,snd_hda_codec_generic,dell_wmi
>>>      video                  73728  2 dell_wmi,nvidia_modeset
>>>      wmi                    40960  5
>> video,dell_wmi,wmi_bmof,dell_smbios,dell_wmi_descriptor
>> Ah; right that makes sense.  In that case, is dell-laptop even the right place for
>> this patch series?  I would think the same policies for the platform profile
>> should be able to apply to desktop/workstation.
>>
>> The v6 of this series would block smbios-thermal-ctl from working on a
>> workstation too.
>>
>>>>>      Additional, with this patch, follow behavior is found:
>>>>>     1. For example, the platform profile is quiet.
>>>>>     2. Reboot the system and change the USTT to performance.
>>>>>     3. Boot to desktop, the platform profile is "quiet", the USTT
>>>>> will be
>>>> changed back to "quiet".
>>>>>     This looks like not a proper user experience. The platform
>>>>> profile should
>>>> honor the BIOS setting, aka, the platform profile should be switched
>>>> to "performance".
>>>> I agree, this sounds like the initial profile needs to be read from
>>>> the BIOS settings too.
>>>>
>>>> Furthermore I wanted to ask is there also a WMI setting that
>>>> corresponds to this that dell-wmi-sysman offers?
>>>    Yes, Mario, you're right. This thermal setting could also be toggled by dell-
>> wmi-sysman.
>>> But, for the Dell consumer AMD laptops, like Alienware, the BIOS is another
>> variant which is different with the workstation one.
>>> With this variant BIOS, there is no USTT and also no dell_wmi/dell-wmi-
>> sysman.
>>>> I'm wondering if both should be probed in case the SMBIOS one goes
>> away one day.
>>>    Yep, I think this is a good suggestion.
>>>
>> Great! Although something I wonder is if the policy when changed with dell-
>> wmi-sysman is immediate or requires a reboot.  A lot of the settings in there
>> aren't effective until after a reboot.
>>
>> If this is one of them then it might not be a good idea to make it work for
>> both.
> Hi Mario,
>
>   Just have a check, the check steps are:
> 1. stop the thermald
> 2. run the stress test
> 3. Toggle the thermal setting between UltraPerformance and Quiet via dell-wmi-sysman
> 4. Check the CPU FAN speed
>   The system reboot is not needed, the CPU fan speed changes immediately.
>   A screen recorder here: https://dell.box.com/s/p2bhd2b6cv8z5buk9eao3bosgrrp1lf9
>
> Thanks
>
Hi,

i believe it should be the responsibility of the manufacturer (in this case Dell) that
the thermal state remains consistent across both interfaces.

I think that the official Windows utility only checks the thermal state reported by
the USTT interface, so we should match this behavior.

Thanks,
Armin Wolf


