Return-Path: <linux-kernel+bounces-435790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64C9E7C5E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C091B1886BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC3212FB6;
	Fri,  6 Dec 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="t0ruZICc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD322C6DC;
	Fri,  6 Dec 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527616; cv=none; b=Qz0AukV7orVdqXHy3HZOsgvxknOjwe0bJtBK/Yqoxy3IC0JohzraiJFjxLC6yfd2hdtF3Sd1oegHWxOxvoi89czP9WlfWa1ZWOQCAIT6SjKWSDhMR0mtSztv36hUav2O7MJgXTtXTZsXzj6KeIKjrixEDOtI2CxYILtPSd1gak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527616; c=relaxed/simple;
	bh=lh9TclqWfedLNmJzpjwnIUC2uXLNtqi/kjjrs+Qkuyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbi/rWjJno5iSxlcVhn47gDW+XPudVzOSZq3ciywvgRNzC9VIfiWqv+29hjOnW0vrHXlTt8BdoeSFyLGskyFtQck8s6CInIVWoRL9LB2ACgYA1KqXVEUzbPCexuXt9Hbqn+oGSSBCNwrkMHmTU+y2w8UFSZ9UvwnmwfHhjpe+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=t0ruZICc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733527583; x=1734132383; i=w_armin@gmx.de;
	bh=GuZrB91kvvbv0KRWU/PYCqIj3eyvN9V4HfTM/mGWrcI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t0ruZICcUGY1hxz+9GwSVUT/lpbQHIlwxN8dskcdKoIJkf8N9G0DOHbGGXII/saj
	 zPgISRQhXI5Q+tXJ5Y/2gRKBqknxKb7yr/3xOZt+KTyO1OgHyfxhc9lyxu0d/3Ycp
	 k2ydPLP+KZCsHOJh1jfZHAIinhElMCnLIVdlj2sIkX/S/nkajD3MNllpyeLsi4CKL
	 c5nUHhAT/iYNSqeGneOws0jrqcrOAMxYS894W2FiQtGo6y3oQCpTJDzAAAZGBUk90
	 cNWNQaexb1R9WUZ14bmGeqiibW7ZsveXbnMgFdVlm4HMHYdwuzHEoU8Mgp+hMJpqB
	 203VqmO0UK9yooLlBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1u13Dp0r7S-00b1oG; Sat, 07
 Dec 2024 00:26:23 +0100
Message-ID: <eec050e3-1b60-4430-b0ff-91e4e250d8f3@gmx.de>
Date: Sat, 7 Dec 2024 00:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/21] alienware-wmi driver rework
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:c22IQjfY+E8bfIVwjFRwFNTVX/uEj2VbmfFtAf7KGtXT0i0BAQa
 Fvpf/MIWxlsE1Fy9RsA6QboRay6XubzeKpQrfkvQYnlak9mKFoX8nxjwTyiBpLf2S4BcmD/
 hEp7gOuuYoTRzKdNm/pwqEp9Ah87059pmPJOkWdfWX7Jz7Z+WHMjp0zvAwU8rfFqA+VlWTf
 Zv5J66Yt1cjYsoaGq2DxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xq8/S7YGNU0=;sjqJWP0nXSbR5eN66PXwJe3jH3b
 bxB6HpUYNbbtU/f/zaWngrfRDAXTPlGoQa7eYFPER1WJAzVTP3Sou8D3QNrdhxGx5SbFhMUl+
 l+CEWyczWa5hxW0CMQL1zdecSSN7TkGx9Zx/+4hvlPcWqZcVOPLJBqx/vrZxmiyU+RLBQIxzV
 ng8WLmGoRjH195mKOP/PQtVmE/ib1sSBfggj1UlGEEjapW8ak/GzIn7H5KH4gq6cnkTSdvjQU
 h0HISPQhiT3fZ4qBLG9jvYg+P97JUH4WDETIXiF6Dj+jzBwINLSg5ndzYYJX5u2GpdG2LYpao
 nTzR5CNjfbzP/HXUY7YtfeDlwxRpYLRX4vALT4bvSQ0fK6aazsehfF8KiAQAOF5w7c6ibN7dH
 rJiF5OMzbi23T6ASQ+ZsoY68AIcbfFb3vPx3ugxC/NKgJiZOjwGiOBUM4xBCBOb4B/o+12pgY
 tNg0bFripwp+Rhq494Ra91l9+sKGrzD/15i0Xe5EWKYkqzqjteuBkhSkiNIJud52IkDNRjBKU
 Rht5efd26RR2R+8ReDtHbnMFNnqb4flGBrK0+eDjEe6vP46u742qUQRpJw5zWnUQouAeugKLk
 hmIByp/lj8cpwbm7Tqx6WZ7SBm/iYWwhN2WjO2Ivv+SUhW2zriPuR+0ffZifOllme9B40hRKV
 QWHIgqcWietv/I6XiDZnFazIp82ttEauxay40pr5HplRehdsxcEUUTir0wppYwGWY8uVvgc7b
 j+30gEJz6BLJwj9lBdpU0ju9C9SzFbVyMiOfuKh3lUqdK4tmYWCBSswCiiZfeemLc2xp0/H6J
 YaLgtDFot9dIlTlEXi9sqJgu9OnRBuGwTYrBNVlcqvj9IrM42XfPGLXcJyxVyZTAUphLrOWqk
 GIxuFFmiEPbOcsL7Uhj4FyKFFa6jw81+SWP6kPUZwbKylztVh+oBiikJ15NlfrPsXuUfdeDTq
 PQrdXMFJLRrkNcVHeRhrDwgF0UpWzxpVQkEoiBQ5nfxVHgxWUV3gQrHeMA5HBlmUlJs29ftlM
 NAYzvNfMd4LZ6NiJudsfTQpr1VbRgPguncLNoHivUDKPn/Hgcp21QuC0/MR6R7oy0ZR7UQCYx
 WkvtQ2s3Uc5VdrjBc/oicXIwOK1iyb

Am 05.12.24 um 01:27 schrieb Kurt Borja:

> Hi :)
>
> This series are a follow-up to this discussion [1], in which I proposed
> migrating the alienware-wmi driver to use:
>
> 1. State container driver model
> 2. Modern WMI driver design
> 3. Drop use of deprecated WMI methods
>
> Of course, this was much harder than expected to do cleanly. Main
> problem was that this driver "drives" two completely different devices
> (I'm not referring to the WMI devices, which also happen to be two).
>
> Throughout these series we will call these devices AlienFX and AWCC.
>
> As a preamble
> =============
>
> AlienFX exposes a LED, hdmi, amplifier and deepsleep interface to
> userspace through a platform device named "alienware-wmi". Historically
> this driver handled this by leveraging on two WMI devices as a backend.
> This devices named LEGACY and WMAX were very similar, the only
> difference was that WMAX had more features, but share all features
> LEGACY had. Although it's a stretch, it could be argued this WMI devices
> are the "same", just different GUID.
>
> Later Dell repurposed the WMAX WMI device to serve as a thermal control
> interface for all newer "gaming" laptops. This new WMAX device has an
> ACPI UID = "AWCC" (I discovered this recently). So it could also be
> argued that old WMAX and AWCC WMAX are not the same device, just same
> GUID.
>
> This drivers manages all these features using deprecated WMI methods.

I think there is a misunderstanding here.

The WMAX WMI device is identical with the AWCC WMI device, only the UID might be different.
The reason why the thermal control WMI methods are not available on older WMAX devices is
that Dell seemed to have introduced this WMI methods after the usual WMAX WMI methods.

Because of this i advise against splitting WMAX (LED, attributes, ...) and AWCC functionality
into separate files.

> Approach I took for the rework
> ==============================
>
> Parts 1-7 sort of containerize all AlienFX functionality under the
> "alienware-wmi" platform driver so WMI drivers can prepare and register
> a matching platform device from the probe.
>
> Parts 8-12 create and register two WMI drivers for the LEGACY and WMAX
> devices respectively. The code for these probes is VERY similar and
> all "differences" are passed to the platform device via platform
> specific data (platdata). Also AlienFX functionality is refactored to
> use non-deprecated WMI methods.
>
> Parts 13-17 migrate all AWCC methods to use non-deprecated WMI methods
> and the state container driver model.
>
> Parts 18-21 I splitted the alienware-wmi.c module into the different
> features this driver manages.
>
> alienware-wmi-base.c is in charge of initializing WMI drivers and
> define some platform specific data, like operations (Part 10 for more
> info). alienware-wmi-alienfx.c has all AlienFX functionality and
> alienware-wmi-awcc.c has all AWCC functionality.

I would rather split the drivers into:

- alienware-wmi-legacy, which handles the LEGACY WMI device and registers a alienware-wmi platform device

- alienware-wmi-wmax, which handles the modern WMAX WMI device and also registers a alienware-wmi platform device

- alienware-wmi-base, which provides a driver for the alienware-wmi platform device

This of course only works if the LEGACY WMI device and the WMAX WMI device are newer both present at the same time,
in this case alienware-wmi-legacy could use wmi_has_guid() as a band aid check to avoid probing if a WMAX WMI device
is present.

Using the platform_data mechanism to decouple the alienware-wmi device driver from the underlying hardware implementation
should be fine IMHO.

> Coments
> =======
>
> This is still kind of a draft, but I did some testing and it works!
>
> Of course I will do thorough testing and cleanup when I send the
> non-RFC version. I just want to get some comments on the general
> approach before proceeding further.
>
> I think this is quite messy in it's current state so I apollogize.
>
> @Mario Limonciello: I included the reviews you gave me on [2]. I
> included some of those patches here, and dropped the ones that did not
> make sense with this design. As this is another series let me know if
> you want me to drop the tags!
>
> @Armin Wolf: I don't like the amount of files I made. As the maintainer
> of the wmi module, what do you think about making two independent
> modules, one for AlienFX and one for AWCC. In order to not register two
> drivers for the WMAX device the module init would check if the "AWCC"
> UID is present.

I know of at least one device which support both AWCC thermal control and
WMAX LED control, so splitting the WMAX device driver like this could cause
problems.

Like i said before, you should view the WMAX WMI device as having different
capabilities (= WMI methods) depending of the machine the kernel is running on.

If a capability is available (currently determined via quirks), the driver should
do the necessary things to handle it.

As a side note: i am currently exploring if we can decode the WMI BMOF buffers inside
the kernel, so that in the far future we can remove those quirks and automatically detect
which methods are available. But this will take a long time, so it has nothing to do with
this patch series.

I will take a look at the other patches tomorrow.

Thanks,
Armin Wolf

>
> The approach for that would be basically the same, and I think the
> series would change very little.
>
> I would like this a lot because I still think old and new WMAX devices
> are different, but I couldn't find another example of where an OEM
> repurposed a WMI device.
>
> @Everyone: I know this is VERY long. Thank you so much for your time in
> advance!
>
> This series were made on top of the 'for-next' branch:
>
> Commit c712e8fd9bf4 ("MAINTAINERS: Change AMD PMC driver status to "Supported"")
>
> ~ Kurt
>
> [1] https://lore.kernel.org/platform-driver-x86/6m66cuivkzhcsvpjv4nunjyddqhr42bmjdhptu4bqm6rm7fvxf@qjwove4hg6gb/T/#u
> [2] https://lore.kernel.org/platform-driver-x86/20241120163834.6446-3-kuurtb@gmail.com/
>
> Kurt Borja (21):
>    alienware-wmi: Modify parse_rgb() signature
>    alienware-wmi: Move Lighting Control State
>    alienware-wmi: Remove unnecessary check at module exit
>    alienware-wmi: Improve sysfs groups creation
>    alienware-wmi: Refactor rgb-zones sysfs group creation
>    alienware-wmi: Add state container and alienfx_probe()
>    alienware-wmi: Migrate to state container pattern
>    alienware-wmi: Add WMI Drivers
>    alienware-wmi: Initialize WMI drivers
>    alienware-wmi: Add alienfx OPs to platdata
>    alienware-wmi: Refactor LED control methods
>    alienware-wmi: Refactor hdmi, amplifier, deepslp
>    alienware-wmi: Add a state container for AWCC
>    alienware-wmi: Migrate thermal methods to wmidev
>    alienware-wmi: Refactor sysfs visibility methods
>    alienware-wmi: Make running control state part of platdata
>    alienware-wmi: Drop thermal methods dependency on quirks
>    platform-x86: Add header file for alienware-wmi
>    platform-x86: Rename alienare-wmi
>    platform-x86: Split the alienware-wmi module
>    platform-x86: Add config entries to alienware-wmi
>
>   MAINTAINERS                                   |    3 +-
>   drivers/platform/x86/dell/Kconfig             |   25 +-
>   drivers/platform/x86/dell/Makefile            |    5 +-
>   .../platform/x86/dell/alienware-wmi-alienfx.c |  531 +++++++
>   .../platform/x86/dell/alienware-wmi-awcc.c    |  282 ++++
>   .../platform/x86/dell/alienware-wmi-base.c    |  525 +++++++
>   drivers/platform/x86/dell/alienware-wmi.c     | 1267 -----------------
>   drivers/platform/x86/dell/alienware-wmi.h     |  141 ++
>   8 files changed, 1505 insertions(+), 1274 deletions(-)
>   create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
>   create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c
>   create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
>   delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
>   create mode 100644 drivers/platform/x86/dell/alienware-wmi.h
>

