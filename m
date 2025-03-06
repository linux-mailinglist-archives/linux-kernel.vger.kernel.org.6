Return-Path: <linux-kernel+bounces-550035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D849A55A46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A46A3AD9D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69D27CB3C;
	Thu,  6 Mar 2025 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D3tKmEFK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7A206F22;
	Thu,  6 Mar 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301948; cv=none; b=f2Pl40ZDhbIdRBzz8vuUonnQp02Q97nHSj+tfo1GYaD0F0e7N4bHcOkGzvi/x83sxqMezexv2z2IKt/JWnWtaLCwo5/NkKr23BWzqHALA54nsf9u84MBfl3/zZBqS+WnQZKZH1rjdwEhjnreX+ZzSTis6HZfFCY0NyDpTNQ7n0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301948; c=relaxed/simple;
	bh=pSulLbtc+j9hYMi+E3gm6BJaS45EyXyHd5kIPYcyCLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLa1TU34DH7dsaoPM3J8s8iZ9IWhiI02aC6h8dbOMAteitmahlXEky3MoqJrKeQZ+TkT/C2kMZlkEQVKvsQbG4saBz23phYuA+g8ERtfuaXKsHKi8wNCwkoxSgCHEvEkQ4x3cgd533h4uJBNVZW5d78EK06fo52QEf+gNqTgXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D3tKmEFK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741301912; x=1741906712; i=w_armin@gmx.de;
	bh=Xe6arez3DQshWl+28R7jzGpRj7+Vuv2XpS35bGQuJkM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D3tKmEFKLkU1Eo66/PUO4AEd/W21sbW1PTf55NhXCf3lf+9jPVWdBYZo/vtUAa81
	 xXyPe/mOGnYaAp+j8zQkweFHmfULdlf+3DzHDQIQbz1HimW1FErbtwjueS6GLV2gQ
	 2PFHzqNjbs3lHYsduQvUKEvd7lU1+ymGFnE4nlT2fHSFUdK48e7RxtOTlhrTMu5o/
	 eMcL/MmOYjJjGD5fPvOORj0fEMaf/JQDLGQCiT96ERLCVyWMVVMso5F9KmXu9PVR8
	 CP4bdIOUoTSJvjSsWu2Gwi9hyAnd7ChO5/3Hyvakq4hjM8efZ5Vem8ldA+GDa+Ci0
	 mX1CxnUYesvO0d+Sxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1tc6hf34I8-00Nibn; Thu, 06
 Mar 2025 23:58:31 +0100
Message-ID: <0261bbf5-d618-4ce3-bcbe-05f498063f19@gmx.de>
Date: Thu, 6 Mar 2025 23:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] platform/x86: Add Lenovo Gaming Series WMI Drivers
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250225220037.16073-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pwccptvPGX5P59AL3tKKnNk0zA9g6fM5AMJ4IjFvamgSueDNkM6
 GqJNGh3qcKAod4mvHn1qsyeyhCXy5PJ+1jFlvgL3n38L1aEtOQCjkDDD4hhNqwWLe9WoIa4
 TOnZIaBeieyA5xQ5B4+XplZDATliaLnTdTjia8/33j204HSvbIO447S8ovBcOZKM3bBmctD
 IMDnUJkF/dscfAqGHjnmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RPmzLe00E4o=;kHmc4lUIrO+ILYbsguusiTDP66+
 YQtV0IxPlHbtyg/d6Z5gL1CY5fGW+JBIj9z1iVovRZltSP310PiXK7ai1A4A1taGAxRhMFjIo
 49RqsHD0lwyDy5eTtOGm+9kThWSniTRi42GKixGVTPKZcwp8ZtQqmtUq2AkvZwIfMZf3Q0YHA
 ghBpVhUEo4aJSCzEBJsQzRWfho7BIDljuuRiy5X0l8uicS2p654CBV60JOTPbu1it8TwXekT+
 8VjdCfWBohPDCp6CV+P0kbVbMlBKflGKANMn3r4PiNwJolrl/jYBgCWR+On26c+KIYWTW8O9y
 DyAfN9K58sNkPqbrSgCtHXKRTPybW+i/W4mosUvkzr2lMGoPInbBUPfiSfMOTU1o9Sajke/l+
 Y+Ctr/QDcUrE594Y8x+lemjurOWJMTB1IjiLtCEeH80x9YGSE05fozlOFbvHZpPAv8CWQ2Zlz
 PC+IqrqvIxtgAXJepxkC/75/8KRIUZneLG6+ae1KFuWxjmBSqVjyCksIJ7nw4ZIKTf3c/3f7Y
 496DrCke6iWVlQqFzYxbG+TVypeQ62bIoaOUxFw72Gmsx6fk/12xYKw3X4kxppNP/7kkWb8RE
 9xr0Ay+HKm44TyFk7sJG0p1r2lOb+G9mjwM0e/gBDcCxOYxI581oE10DmFDK9Fg73VzrMefjh
 zw0Um97oWKqbDwDTiUfjfajL3yo2Bp3gAVrGd8KYnnAjt6sbg+aR9jzvpWCKZsySNSEDs5qv6
 hWLBuxQ8DE6wPr+n++5U77op9qEwz2Bekzrm4jWUOYyiBPgR8oK07+wXqDhx7wtPsTPNtzUBp
 n9sbIt7MK+Dap7jlVsLZdjDXwEdvSCj8H4WVPHPf8dzqmLWxwdGPoCCAb0OCCh9/Vm8AtykKZ
 IWvkc3KYA/CAa2PBU4ME/JkCpffykKM7GNewSc7c0ALjYQTbSOuoAH9UI/FQNrH+o5VsvHc8A
 uLQp3+l48eTZGIhQswvJ2Xh2LhHoWIJwgpphef+Z2/PJlFoCmV0586rcT34BeoWudwk/U7cYa
 lClVYVy8bH2Qf/NPVjqSvJXooM87W76GoOEv70BxqWhF9pqtGvIe0d6b38SRdXxqSLxBwGGrm
 2UXLLCWq3JaTal4KigI393VciWrWzn7VARz6jZnqfPPCfPv7DMBtz8IR6fJoMe0MqEeQV63YH
 BdL5zZasmJJ3TrcPlF+i30XdYooTZBGCGBV3Nsl3JLtF/wF/CpKU9e/VEIg9BB3ZHzYlZBW+i
 QWojNXJ/fKfpCeDbcwO+RpxE5XCrLRdFvwjM5qrbFTC/8WlOVOGsV27OksVCY8uiiJ/GyG5Mt
 k4HKCx/VFRUdNXphm9hcugrcH7CpNXq+YSo84y2zLOL0l6MRSjcBWKByKSR6O+VQ8V5KgUbCU
 m20yqV/s5EvZ+LM87PMGxWou3h70Dg5nIIsbgSYM1wMm6Jr/6UrORfKffd

Am 25.02.25 um 22:59 schrieb Derek J. Clark:

> Adds support for the Lenovo "Gaming Series" of laptop hardware that use
> WMI interfaces that control various power settings. There are multiple WMI
> interfaces that work in concert to provide getting and setting values as
> well as validation of input. Currently only the "Gamezone", "Other
> Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
> I attempted to structure the driver so that adding the "Custom Mode",
> "Lighting", and other data block interfaces would be trivial in a later
> patches.
>
> This driver is distinct from, but should be considered a replacement for
> this patch:
> https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/
>
> This driver attempts to standardize the exposed sysfs by mirroring the
> asus-armoury driver currently under review. As such, a lot of
> inspiration has been drawn from that driver.
> https://lore.kernel.org/all/20240930000046.51388-1-luke@ljones.dev/
>
> The drivers have been tested by me on the Lenovo Legion Go and Legion Go
> S.

Sorry for taking a lot of time to respond, i was a bit preoccupied with
university stuff. I will review this series tomorrow, so far the code
looks promising.

Thanks,
Armin Wolf

> v3:
> - Added notifier chain to Gamezone and Other Mode drivers.
> - Added component framework to lenovo-wmi-other driver with
>    lenovo-wmi-capdata01 acting as a component.
> - Completed all suggestions from v2.
> - Checkpatch produces CHECK complaints about the Other Mode macros
>    reusing some variable names. This don't appear to create the condition
>    it highlights in my testing.
>
> v2:
> https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekjohn.clark@gmail.com/t/#m9682cee65783ff3a9e927f2ad1f55c4cbfc37615
> v1:
> https://lore.kernel.org/platform-driver-x86/CAFqHKTna+kJpHLo5s4Fm1TmHcSSqSTr96JHDm0DJ0dxsZMkixA@mail.gmail.com/T/#t
>
> Suggested-by: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Derek J. Clark (4):
>    platform/x86: Add lenovo-wmi drivers Documentation
>    platform/x86: Add Lenovo Gamezone WMI Driver
>    platform/x86: Add Lenovo Capability Data 01 WMI Driver
>    platform/x86: Add Lenovo Other Mode WMI Driver
>
>   .../wmi/devices/lenovo-wmi-gamezone.rst       | 355 +++++++++++
>   .../wmi/devices/lenovo-wmi-other-method.rst   | 142 +++++
>   MAINTAINERS                                   |  12 +
>   drivers/platform/x86/Kconfig                  |  35 ++
>   drivers/platform/x86/Makefile                 |   4 +
>   drivers/platform/x86/lenovo-wmi-capdata01.c   | 140 +++++
>   drivers/platform/x86/lenovo-wmi-gamezone.c    | 374 ++++++++++++
>   drivers/platform/x86/lenovo-wmi-other.c       | 549 ++++++++++++++++++
>   drivers/platform/x86/lenovo-wmi.c             |  77 +++
>   drivers/platform/x86/lenovo-wmi.h             |  94 +++
>   10 files changed, 1782 insertions(+)
>   create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
>   create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi.h
>

