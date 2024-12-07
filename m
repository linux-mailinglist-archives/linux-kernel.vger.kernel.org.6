Return-Path: <linux-kernel+bounces-435866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46F9E7E16
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F616C5F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C229422;
	Sat,  7 Dec 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZuQrN915"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760B17E0;
	Sat,  7 Dec 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733541629; cv=none; b=X1aWG4u3V/OMjVOMewfz6gJtYAEJ8ZGBlYdALE8oszkAlULSYwPZE90DJNNzZdPsEpCPd+2dDjpNXOxjaBZ5smSSIqrMSCotFamzbTwGIqUwDQvE9D0gcLllVrjlkDKGXEdPGZKj3qVJq6NdNGBJusGVWm4xhWpmJF8eTnGSPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733541629; c=relaxed/simple;
	bh=KOipeHrAUfTJmsgbpHS6hW1FWevByRJqm2kRap1V1XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ/s8NpVC6VqxZ6bw0sdF5WxXBQlf3MjzG7eBrui3RDmXoQata1AnfvshZw6q6C3F9mqM+ne8JPfAfFsEhRrDENhVTcRNm+e5kgd1PW3aJ7WskWlZbNJHVjh0gviuTG0UdNRrZmXzFq4nWT7lrtagKROQeAdJKirlTrlnUERS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZuQrN915; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733541611; x=1734146411; i=w_armin@gmx.de;
	bh=NhQ5ab5xibBSrDwu/YQL3WmZPdtUTGkaMuqPH1hMOgE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZuQrN915u9AfQQqP0yFoTqYSy03USWMqRHYLF462dN8O104EMW7OQldudYzOa0Ph
	 E7AM4bTHwxq9MjyaaVOHwlq6PnID9UsUwt1xINEKrJKdX5yMA0u1ngyh8I1FTRYbW
	 PH4GHLUflWoJqLB3Mmsn3K8CoXUejaVtCWldb3iGgI0V0giqyweJYAJyamvYHq9Y8
	 H3Sce8FqFbgMUpejtwW2N4ZmSnamnpoZPNiDXMbnZ71qTZHjMTzY+lN2QR50Z7Zcx
	 th36uHg6o4XHLBSbj9/xUdbaMjfzkPGGtwkrYzAvQbeTOqLWXv140V0Df7vjdq1TL
	 Yyr8hxJeb7qrO/yByg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1u0SQx2bDI-00fzLd; Sat, 07
 Dec 2024 04:20:11 +0100
Message-ID: <38399b6a-e31c-4b99-a10e-01dc20649c24@gmx.de>
Date: Sat, 7 Dec 2024 04:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/21] alienware-wmi driver rework
To: Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <eec050e3-1b60-4430-b0ff-91e4e250d8f3@gmx.de>
 <w3sxt2kt64g2b6gjucnsmnydfm4r74pzf2sl6fcjmjwvk3jyd5@2miohw3pslwk>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <w3sxt2kt64g2b6gjucnsmnydfm4r74pzf2sl6fcjmjwvk3jyd5@2miohw3pslwk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5/uZ6IUrenzbPsZk8IyAC6Hh7A4E9Jlnc/57cZm0NyuJ5DOG04h
 EcyN67se+5J1vsHcpGqq/per9hlgSRXDjlOCVjaTZsMVu1mrYX87r9GTCeW3CU5D20RYq++
 7HBQ8vY6K8qLoTFK9oGGpWmfVAUsm07aEn9mJBmM7shw7JYSfSaw7LfGoJYLC/9hCeZEKik
 sfkqU4ovk+KXqLsJsIP6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y2C4iGjK4k0=;khhqCqof3JCco12J7rN8nJnIALg
 7b9COl+PvNKCdN1xveKa4T8Qs1LNC9xxH/o0IZLBlE4xbmBfsvuXxEkX0zhzAUOgu4cShEixi
 fDPj3ER/yt+CDgbeDPV+32csg56hpDF1l3/512fh0wyXGw/PI4cGJe+AeE+4VSsXM9fgFYoN2
 BCtVKMmAlo3/EtI//v4m4AlJvDvDLrHApPKYLrAwxQhD45nc7bVANpSMa77Q8+d0125msvkah
 L/OjG+0YiH5QHkFvD7KxaCeabEh3c/D3miyVrM+TfQNcJV2BmHyXOo9DljsTAH4rRbaZz+zmu
 p5JMhYnBGmBrWauLBBRXVXMFAHy5k29eO/qhOWbYeEZO8+6cYoAbRE3We/UES4bQ9zgfN8qJZ
 GcllmSsrmuv3O2RPfqX/eTBX6JawWDB49pr2fLtmT7IEGF4Y0LNc5DsH+q43yTNPtsZazlduf
 wKcViBNwGdlvrYSl6++NKWYQYoywXV/QUb5D+B+sfOkjwqS32ctOhP7SrSjESAiowbTyoAXLy
 4+Em712hQU523yTCLZzmbYHhGuw07mUPluNpFk9a0zv0oyjBWX9o9wJ9M4Ht5rDukY6SLkKbT
 //h3jheZNDjdUG3SkdzqbiDW6VcS904noqyFBlev4PqWs44JGqYFnheWVxTyZF6T9OLqNGFZ4
 hoZMo8Bq9gKju3CVPMKrqyq9ePORKOFvRU4hA3CSUxBlp2G9YGV/0zjaQU5jPUf+vIOXU+9r9
 9PGPM2W5T+pgl2r7pj6/oh7MfZJFDLsxuKnRiD38XZhjsW9iKLbIErR1mQ+3F8TJNZt/PRs+L
 hbp1h7TSmyECN4NyTszeNVqU+5pUTlES7ro7b3PrFmj4bAFrRtf6Je4zbhFMfsiF1c9oU1fI9
 J+YQKjmwy8QuioQfMmgVA2HzMGNd6ZkZ25FF/5wGmMkCbS/82erCIvxOziq39VdpqFIB1AgNb
 1afiCrIO0cj3vw/WwVuvJZjb7uc0de3C7CKjUfct/R5hzvmtdcg0OkbE/h0C6K0X5PXpQN9Yv
 +i/7ckUpyyHklau6EGV/1HYVRoFUK2hPXlnEdWPHdd+2V3aDLn+cnzpDvv0EhQsufgB1ilUAH
 5taMq8smLtX6d7+SLulhxSWouxFzwj

Am 07.12.24 um 02:59 schrieb Kurt Borja:

> On Sat, Dec 07, 2024 at 12:26:20AM +0100, Armin Wolf wrote:
>> Am 05.12.24 um 01:27 schrieb Kurt Borja:
>>
>>> Hi :)
>>>
>>> This series are a follow-up to this discussion [1], in which I proposed
>>> migrating the alienware-wmi driver to use:
>>>
>>> 1. State container driver model
>>> 2. Modern WMI driver design
>>> 3. Drop use of deprecated WMI methods
>>>
>>> Of course, this was much harder than expected to do cleanly. Main
>>> problem was that this driver "drives" two completely different devices
>>> (I'm not referring to the WMI devices, which also happen to be two).
>>>
>>> Throughout these series we will call these devices AlienFX and AWCC.
>>>
>>> As a preamble
>>> =============
>>>
>>> AlienFX exposes a LED, hdmi, amplifier and deepsleep interface to
>>> userspace through a platform device named "alienware-wmi". Historically
>>> this driver handled this by leveraging on two WMI devices as a backend.
>>> This devices named LEGACY and WMAX were very similar, the only
>>> difference was that WMAX had more features, but share all features
>>> LEGACY had. Although it's a stretch, it could be argued this WMI devices
>>> are the "same", just different GUID.
>>>
>>> Later Dell repurposed the WMAX WMI device to serve as a thermal control
>>> interface for all newer "gaming" laptops. This new WMAX device has an
>>> ACPI UID = "AWCC" (I discovered this recently). So it could also be
>>> argued that old WMAX and AWCC WMAX are not the same device, just same
>>> GUID.
>>>
>>> This drivers manages all these features using deprecated WMI methods.
>> I think there is a misunderstanding here.
>>
>> The WMAX WMI device is identical with the AWCC WMI device, only the UID might be different.
>> The reason why the thermal control WMI methods are not available on older WMAX devices is
>> that Dell seemed to have introduced this WMI methods after the usual WMAX WMI methods.
>>
>> Because of this i advise against splitting WMAX (LED, attributes, ...) and AWCC functionality
>> into separate files.
> By examining the ACPI tables of the devices that support the AWCC
> functionality, I realized none of the newer devices support the LED
> interface.

You are right, i misread the decoded bmof buffer xd.

> At the time I added quirks for those devices I assigned `num_zones = 2`,
> because I mimicked the default behavior of the driver, which was
> assigning quirk_unknown to devices not listed on the DMI table.
>
> This is of course my bad, but fortunately in all these cases the WMAX
> device returned an error code safely.
>
> I can send a fix for this, but it would require a bit of refactoring of
> the init function, which I think would cause merge conflicts if we end
> up reworking this driver. Also we don't know "FOR SURE" which devices
> don't support the LED interface, although I'm pretty sure it comes down
> to the UID of the device, but it's just a guess in the end.

If you do not know for sure which devices _you_ added support the LED interface, then
i would prefer to remove the "num_zones = 2" quirk from those devices for now.

> Thoughts on sending a fix? I believe leaving zones is pretty harmless in
> the end.

Please send a fix for your quirk entries, so we can avoid forgetting this little detail.

> I would love to have advice from Dell on this too. Hopefully they'll
> get back at us at some point. Any time now...
>
>>> Approach I took for the rework
>>> ==============================
>>>
>>> Parts 1-7 sort of containerize all AlienFX functionality under the
>>> "alienware-wmi" platform driver so WMI drivers can prepare and register
>>> a matching platform device from the probe.
>>>
>>> Parts 8-12 create and register two WMI drivers for the LEGACY and WMAX
>>> devices respectively. The code for these probes is VERY similar and
>>> all "differences" are passed to the platform device via platform
>>> specific data (platdata). Also AlienFX functionality is refactored to
>>> use non-deprecated WMI methods.
>>>
>>> Parts 13-17 migrate all AWCC methods to use non-deprecated WMI methods
>>> and the state container driver model.
>>>
>>> Parts 18-21 I splitted the alienware-wmi.c module into the different
>>> features this driver manages.
>>>
>>> alienware-wmi-base.c is in charge of initializing WMI drivers and
>>> define some platform specific data, like operations (Part 10 for more
>>> info). alienware-wmi-alienfx.c has all AlienFX functionality and
>>> alienware-wmi-awcc.c has all AWCC functionality.
>> I would rather split the drivers into:
>>
>> - alienware-wmi-legacy, which handles the LEGACY WMI device and registers a alienware-wmi platform device
>>
>> - alienware-wmi-wmax, which handles the modern WMAX WMI device and also registers a alienware-wmi platform device
>>
>> - alienware-wmi-base, which provides a driver for the alienware-wmi platform device
> If you don't change your mind with the information given above, I'm ok
> with this. That's why I splitted the driver at the end of the series :p

I did not change my mind.

I can understand that most devices either support the original WMAX WMI methods or the AWCC WMI methods,
but from a technical point of view it is still the same device. Also Dell could combine both sets of WMI methods
in a future device, and i would prefer being prepared for that.

We can still split alienware-wmi-wmax into multiple files (which get linked together) later should the source code
of it get too big in the future.

Also having a separate alienware-wmi-legacy would allow users to disable this driver when building the kernel.

>> This of course only works if the LEGACY WMI device and the WMAX WMI device are newer both present at the same time,
>> in this case alienware-wmi-legacy could use wmi_has_guid() as a band aid check to avoid probing if a WMAX WMI device
>> is present.
>>
>> Using the platform_data mechanism to decouple the alienware-wmi device driver from the underlying hardware implementation
>> should be fine IMHO.
> This is good to know!
>
>>> Coments
>>> =======
>>>
>>> This is still kind of a draft, but I did some testing and it works!
>>>
>>> Of course I will do thorough testing and cleanup when I send the
>>> non-RFC version. I just want to get some comments on the general
>>> approach before proceeding further.
>>>
>>> I think this is quite messy in it's current state so I apollogize.
>>>
>>> @Mario Limonciello: I included the reviews you gave me on [2]. I
>>> included some of those patches here, and dropped the ones that did not
>>> make sense with this design. As this is another series let me know if
>>> you want me to drop the tags!
>>>
>>> @Armin Wolf: I don't like the amount of files I made. As the maintainer
>>> of the wmi module, what do you think about making two independent
>>> modules, one for AlienFX and one for AWCC. In order to not register two
>>> drivers for the WMAX device the module init would check if the "AWCC"
>>> UID is present.
>> I know of at least one device which support both AWCC thermal control and
>> WMAX LED control, so splitting the WMAX device driver like this could cause
>> problems.
>>
>> Like i said before, you should view the WMAX WMI device as having different
>> capabilities (= WMI methods) depending of the machine the kernel is running on.
> Yes, it's really unfortunate Dell didn't make a new device for the
> thermal methods.

I agree, sadly this god object architecture is very common with some hardware manufactures :(

>
>> If a capability is available (currently determined via quirks), the driver should
>> do the necessary things to handle it.
>>
>> As a side note: i am currently exploring if we can decode the WMI BMOF buffers inside
>> the kernel, so that in the far future we can remove those quirks and automatically detect
>> which methods are available. But this will take a long time, so it has nothing to do with
>> this patch series.
> This would be an awesome feature! Will you implement Pali Rohar's decoder?
> I'll be sure to make the necessary improvements once is done.

I will base my work on Pali Rohars decoder, but sadly the source code is quite convoluted, so i will
need to do some reverse-engineering.

The decompression alogrithm is already finished:

https://github.com/Wer-Wolf/libdeds

Thanks,
Armin Wolf

>
>> I will take a look at the other patches tomorrow.
> Thank you very much!
>
> ~ Kurt
>
>> Thanks,
>> Armin Wolf
>>
>>> The approach for that would be basically the same, and I think the
>>> series would change very little.
>>>
>>> I would like this a lot because I still think old and new WMAX devices
>>> are different, but I couldn't find another example of where an OEM
>>> repurposed a WMI device.
>>>
>>> @Everyone: I know this is VERY long. Thank you so much for your time in
>>> advance!
>>>
>>> This series were made on top of the 'for-next' branch:
>>>
>>> Commit c712e8fd9bf4 ("MAINTAINERS: Change AMD PMC driver status to "Supported"")
>>>
>>> ~ Kurt
>>>
>>> [1] https://lore.kernel.org/platform-driver-x86/6m66cuivkzhcsvpjv4nunjyddqhr42bmjdhptu4bqm6rm7fvxf@qjwove4hg6gb/T/#u
>>> [2] https://lore.kernel.org/platform-driver-x86/20241120163834.6446-3-kuurtb@gmail.com/
>>>
>>> Kurt Borja (21):
>>>     alienware-wmi: Modify parse_rgb() signature
>>>     alienware-wmi: Move Lighting Control State
>>>     alienware-wmi: Remove unnecessary check at module exit
>>>     alienware-wmi: Improve sysfs groups creation
>>>     alienware-wmi: Refactor rgb-zones sysfs group creation
>>>     alienware-wmi: Add state container and alienfx_probe()
>>>     alienware-wmi: Migrate to state container pattern
>>>     alienware-wmi: Add WMI Drivers
>>>     alienware-wmi: Initialize WMI drivers
>>>     alienware-wmi: Add alienfx OPs to platdata
>>>     alienware-wmi: Refactor LED control methods
>>>     alienware-wmi: Refactor hdmi, amplifier, deepslp
>>>     alienware-wmi: Add a state container for AWCC
>>>     alienware-wmi: Migrate thermal methods to wmidev
>>>     alienware-wmi: Refactor sysfs visibility methods
>>>     alienware-wmi: Make running control state part of platdata
>>>     alienware-wmi: Drop thermal methods dependency on quirks
>>>     platform-x86: Add header file for alienware-wmi
>>>     platform-x86: Rename alienare-wmi
>>>     platform-x86: Split the alienware-wmi module
>>>     platform-x86: Add config entries to alienware-wmi
>>>
>>>    MAINTAINERS                                   |    3 +-
>>>    drivers/platform/x86/dell/Kconfig             |   25 +-
>>>    drivers/platform/x86/dell/Makefile            |    5 +-
>>>    .../platform/x86/dell/alienware-wmi-alienfx.c |  531 +++++++
>>>    .../platform/x86/dell/alienware-wmi-awcc.c    |  282 ++++
>>>    .../platform/x86/dell/alienware-wmi-base.c    |  525 +++++++
>>>    drivers/platform/x86/dell/alienware-wmi.c     | 1267 -----------------
>>>    drivers/platform/x86/dell/alienware-wmi.h     |  141 ++
>>>    8 files changed, 1505 insertions(+), 1274 deletions(-)
>>>    create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
>>>    create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c
>>>    create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
>>>    delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
>>>    create mode 100644 drivers/platform/x86/dell/alienware-wmi.h
>>>

