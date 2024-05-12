Return-Path: <linux-kernel+bounces-176977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92A8C380B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4517282405
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FAE4EB31;
	Sun, 12 May 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MqsURCuu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5DF510;
	Sun, 12 May 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539716; cv=none; b=r91oyiQK2sN6TSuC4pUnTqvvDCekWa2S0OKfD/blJ3ZF2/DNrE1Y+E8rBWvA8mwgU12uGCWPESYpMTHGOm3MVPnkLFucmbIAZRomSfcSLIjocym/F5jTapS/5AtHPlbQXg6xaS3LfTpt5vKKTfZz8vdkIgETjQLobnY2bGrhW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539716; c=relaxed/simple;
	bh=lkb7RsDU4hipYYXRUKzjxf8mSYCs3vJ54tdgYhn8+KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVrG57nubE//QIiw75bTEHQKzsVX1Hhta3LYFU/RYFD6MSlHWPG3xzxkvFvuJnyhQ9QeMkwSkYIx+0jL5nUj94oooso9qIjlH225ZQxqZgOxk8imdrSA05ElegfOeOGzSy2CjSumXAxMBHjVBcd30rYA09dMsQGxkQ1cCJmlLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MqsURCuu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715539680; x=1716144480; i=w_armin@gmx.de;
	bh=lkb7RsDU4hipYYXRUKzjxf8mSYCs3vJ54tdgYhn8+KA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MqsURCuuOIA5xncfoJEDH/MvhYqfoVWuwrsY/QY88ALW74pTOnqR/1i29jFf+SJi
	 Io3ReU3mjwPYV4Z4JMLwB4ormqHznoqqUtunMxpY9lUlBvig83o7JWGmfHz4wqLj3
	 YZbdYjRot7QEhFVULgrdypocn4djcriwoTcL+NfczUnUwmEUC1oNGEw3f7vyD6lvb
	 Uy9WdOj7dFI36KSxtuuhoi0ilppaX37bO8EJHYwgvtdDu/Im5WG8Y5kB7Y8eFPBmW
	 XE2ecc69MyqHTe8FD0Fv7hziP+QUl0npevljOt4bodZ0AYNtIWeUP7sHJQkpY6nJz
	 3oSFUFzhHjbO1OcKwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1seISD1cE9-014RsA; Sun, 12
 May 2024 20:48:00 +0200
Message-ID: <e583ccb0-b0be-4fb6-8e70-e4cd6921d77d@gmx.de>
Date: Sun, 12 May 2024 20:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Shen, Yijun" <Yijun.Shen@dell.com>, Lyndon Sanche <lsanche@lyndeno.ca>
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
 <4d8de625-9018-4926-9519-37f5a90a96e5@gmx.de>
 <d38043cd-7fc2-4255-a795-23e64ee4a8c2@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <d38043cd-7fc2-4255-a795-23e64ee4a8c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CkL1BEDOMO6DojLjzd7txmE6jyfcZ0r8RvJ+3Wm2YBQ/uKfVDII
 B04nC/c9rLdFj5U4OSCjxsTkN8vd7So+BaHYAeY7g9ahUst2/+ClPXhhGEn0PlOArGGUjag
 MP5S11nMtyRc2QZVaj6S7RMvgPJ1tI/6ZYSOl7Jn+0VQ1PrhToS9aGiD469Ac+pegB/bv9o
 rLJYysBHqnKpBGSvjA7Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:32doWJtV08w=;nNkHNMhFZmu2M8TJPJsHjOQorcZ
 Yihj2CBzfPWkoLvrrmZ6r8bp/3koFk5Et5e//pqh86S+L95TiP2gyt9vS9NtxJrEUuTAJB0iA
 yK4ZTi47zxVWQ1rxyw8uEqXh9feCw6B+Gy23RY9gGjgWZJTWp+YfcCny+1IPEGhqAJUpDXxP2
 FPYrkDbhe00p70sqdJDATYeFx5dIVPnuqE73z0NvQcu5gbJuth7Si7W0HnbwQ1h37qrnIN+Ly
 ZPrDgVmNxxN5k4UOjZS0e1jBugy3GpT+SN3tYdIDeYrIMobAOe5aiEVv4C2lYzyuUR57yxHlA
 OVkhpKxglWMV+MyYdkLavSWXK1VQOZ+nLJuhhk7hlN+5/TqjH9vY9Kuui1+gzJw1BoVjschNF
 mfQi6YZkKL/327jM52+wIzHOs3TTvT63JxuiEL0GiIm5nrJwRGdx4P7WtBZk87U8v1NpNyYJf
 zN1LZyb1bDYObyU80v35cl0UvUcQc5J+aGaaW+oPAuyp8YZqa63mOAuka0r3ah9ipHqbMEvY2
 ldfYYEYF5D8orhaGhq71amgxmZzL03/KLi+CfUe6bekSuXEpl4JskLish7/bCWF3wVRbgRwvc
 DFU7qKIE4rusqQqWwOq4KqK1Nxev7Hw23fQRnGqQ9jbhr7Wj+449Dv2bzF/y5ZD0NkwTndTYR
 S7t6Fy3l9I6UyinGfmW+ixSoXnV7RHXptuvuqyeYbKXLRPXmcOLDFOYIWcoI0Eb9qYvlmNn4E
 di2m8TGij1X2xDCPN1O+rzSdPKHGs0X+GXN3I061rbrEdL5QQWT32LHRoQAm7Q4Lxry5/78FP
 rzpQfCQq/Gr9LGynKc9mk52x/ksBAR8ejGoRS5rpVCLCU=

Am 12.05.24 um 19:58 schrieb Limonciello, Mario:

>
>
> On 5/12/2024 12:53 PM, Armin Wolf wrote:
>> Am 11.05.24 um 17:56 schrieb Shen, Yijun:
>>
>>> Internal Use - Confidential
>>>> -----Original Message-----
>>>> From: Limonciello, Mario <mario.limonciello@amd.com>
>>>> Sent: Saturday, May 11, 2024 11:13 PM
>>>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>>>> <lsanche@lyndeno.ca>
>>>> Cc: pali@kernel.org; W_Armin@gmx.de;
>>>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>>>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew Garrett
>>>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner
>>>> Kallweit
>>>> <hkallweit1@gmail.com>; Vegard Nossum <vegard.nossum@oracle.com>;
>>>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> Dell Client
>>>> Kernel <Dell.Client.Kernel@dell.com>
>>>> Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement
>>>> platform_profile
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>>
>>>>
>>>> On 5/11/2024 10:05 AM, Shen, Yijun wrote:
>>>>> Internal Use - Confidential
>>>>>> -----Original Message-----
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> Sent: Wednesday, May 8, 2024 11:53 PM
>>>>>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>>>>>> <lsanche@lyndeno.ca>
>>>>>> Cc: pali@kernel.org; W_Armin@gmx.de;
>>>>>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>>>>>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew
>>>> Garrett
>>>>>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner
>>>>>> Kallweit <hkallweit1@gmail.com>; Vegard Nossum
>>>>>> <vegard.nossum@oracle.com>; platform-driver-x86@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; Dell Client Kernel
>>>>>> <Dell.Client.Kernel@dell.com>
>>>>>> Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
>>>>>> platform_profile
>>>>>>
>>>>>>
>>>>>> [EXTERNAL EMAIL]
>>>>>>
>>>>>> On 5/8/2024 09:24, Shen, Yijun wrote:
>>>>>>> Hi Lyndon,
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0 Thanks for working on this patch.
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0 Dell side has an initial testing with this patc=
h on some
>>>>>>> laptops,
>>>>>>> it looks
>>>>>> good. While changing the platform profile:
>>>>>>> 1. The corresponding USTT option in BIOS will be changed.
>>>>>>> 2. thermald will not be impacted. The related PSVT and ITMT will b=
e
>>>> loaded.
>>>>>>> =C2=A0=C2=A0=C2=A0 Some Dell DTs does not have the USTT, Dell'll h=
ave a check if
>>>>>>> nothing is
>>>>>> broken.
>>>>>>
>>>>>> Hi Alex!
>>>>>>
>>>>>> Have you had a check both on both your AMD laptops and workstations
>>>>>> too, or just the Intel ones?=C2=A0 I think it would be good to make=
 sure
>>>>>> it's getting the correct experience in both cases.
>>>>>>
>>>>> Hi Mario,
>>>>>
>>>>> =C2=A0=C2=A0 I've a check for this, for both laptop and workstation,=
 the
>>>>> dell_laptop
>>>> module will not be loaded. So, AMD platform will not be impacted by
>>>> this
>>>> patch series.
>>>>> Follow is one example output with workstation.
>>>>> =C2=A0=C2=A0 #lsmod | grep dell
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dell_wmi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28672=C2=A0 0
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dell_smbios=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32768=C2=A0 1 dell_wmi
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dcdbas=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20480=C2=A0 1=
 dell_smbios
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dell_wmi_descriptor=C2=A0=C2=A0=C2=A0 20480=
=C2=A0 2 dell_wmi,dell_smbios
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 sparse_keymap=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 12288=C2=A0 1 dell_wmi
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ledtrig_audio=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 12288=C2=A0 3
>>>>> snd_ctl_led,snd_hda_codec_generic,dell_wmi
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 video=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 73728=
=C2=A0 2 dell_wmi,nvidia_modeset
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 wmi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 40960=C2=A0 5
>>>> video,dell_wmi,wmi_bmof,dell_smbios,dell_wmi_descriptor
>>>> Ah; right that makes sense.=C2=A0 In that case, is dell-laptop even t=
he
>>>> right place for
>>>> this patch series?=C2=A0 I would think the same policies for the
>>>> platform profile
>>>> should be able to apply to desktop/workstation.
>>>>
>>>> The v6 of this series would block smbios-thermal-ctl from working on =
a
>>>> workstation too.
>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Additional, with this patch, follow behav=
ior is found:
>>>>>>> =C2=A0=C2=A0=C2=A0 1. For example, the platform profile is quiet.
>>>>>>> =C2=A0=C2=A0=C2=A0 2. Reboot the system and change the USTT to per=
formance.
>>>>>>> =C2=A0=C2=A0=C2=A0 3. Boot to desktop, the platform profile is "qu=
iet", the USTT
>>>>>>> will be
>>>>>> changed back to "quiet".
>>>>>>> =C2=A0=C2=A0=C2=A0 This looks like not a proper user experience. T=
he platform
>>>>>>> profile should
>>>>>> honor the BIOS setting, aka, the platform profile should be switche=
d
>>>>>> to "performance".
>>>>>> I agree, this sounds like the initial profile needs to be read from
>>>>>> the BIOS settings too.
>>>>>>
>>>>>> Furthermore I wanted to ask is there also a WMI setting that
>>>>>> corresponds to this that dell-wmi-sysman offers?
>>>>> =C2=A0=C2=A0 Yes, Mario, you're right. This thermal setting could al=
so be
>>>>> toggled by dell-
>>>> wmi-sysman.
>>>>> But, for the Dell consumer AMD laptops, like Alienware, the BIOS
>>>>> is another
>>>> variant which is different with the workstation one.
>>>>> With this variant BIOS, there is no USTT and also no
>>>>> dell_wmi/dell-wmi-
>>>> sysman.
>>>>>> I'm wondering if both should be probed in case the SMBIOS one goes
>>>> away one day.
>>>>> =C2=A0=C2=A0 Yep, I think this is a good suggestion.
>>>>>
>>>> Great! Although something I wonder is if the policy when changed
>>>> with dell-
>>>> wmi-sysman is immediate or requires a reboot.=C2=A0 A lot of the
>>>> settings in there
>>>> aren't effective until after a reboot.
>>>>
>>>> If this is one of them then it might not be a good idea to make it
>>>> work for
>>>> both.
>>> Hi Mario,
>>>
>>> =C2=A0 Just have a check, the check steps are:
>>> 1. stop the thermald
>>> 2. run the stress test
>>> 3. Toggle the thermal setting between UltraPerformance and Quiet via
>>> dell-wmi-sysman
>>> 4. Check the CPU FAN speed
>>> =C2=A0 The system reboot is not needed, the CPU fan speed changes
>>> immediately.
>>> =C2=A0 A screen recorder here:
>>> https://dell.box.com/s/p2bhd2b6cv8z5buk9eao3bosgrrp1lf9
>>>
>>> Thanks
>>>
>> Hi,
>>
>> i believe it should be the responsibility of the manufacturer (in
>> this case Dell) that
>> the thermal state remains consistent across both interfaces.
>>
>> I think that the official Windows utility only checks the thermal
>> state reported by
>> the USTT interface, so we should match this behavior.
>>
>> Thanks,
>> Armin Wolf
>>
>
> Why?=C2=A0 Windows also does ACPI-WMI differently than Linux.=C2=A0 It's=
 not as
> easy to check both from a Windows utility due to that.

Actually, it is quite easy to check both interfaces from a Windows utility=
 Both ACPI-WMI objects can be accessed by
Windows applications, the utility just has to interact with an additional =
WMI object, but they decided to not do it.

Also the original smbios-thermal-ctl utility was created by Dell itself (i=
 think?), so they likely would have implemented this
if it really was necessary.

As Dell likely only tests their machines with Windows (if at all), i propo=
se that we try to match the Windows behavior.

Thanks,
Armin Wolf


