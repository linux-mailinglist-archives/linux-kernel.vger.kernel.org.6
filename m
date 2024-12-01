Return-Path: <linux-kernel+bounces-426708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E69DF6E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF06162DEB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB91D86C6;
	Sun,  1 Dec 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JtCLHlRJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC71BC094;
	Sun,  1 Dec 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075931; cv=none; b=HkdkzyIJj3wnfr904ydmJRYYL7/St/wGq6DgfS7eaVXHJYbprbDJbe6r74owrqbTmNOLq4Ma9tbuOUnpSkzFOh0UZlvzF1+AfgAEk/ujMKOQAI78dQO4vapDH0KlOcBxcQEGLJfC58SCY779JnXApwpQ1X/O4A56oCeXcMuJVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075931; c=relaxed/simple;
	bh=Hq4481C+0KO6/BSBgy36PO7z+3nnE/ExcU1Z1tIJx18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDegpPagWPm2n4YmlA+eGSDV9aveUaWNzKxqB515omJ/cYoQhuTjFUO6ZOhhSJIIZlimosCjMkR4Z0yTLv316j6ThLYTUZw5rzergR/kLAUMMyZh/MUb87K5MOhfG4jZaDa78mqEQfBdd9xMd4fKds6MeiJdYaRgknYthKuO1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JtCLHlRJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733075920; x=1733680720; i=w_armin@gmx.de;
	bh=rlHQ8/p3xS/Ykqg8LHS+OG2al5HrpauYglCNK+JgmU0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JtCLHlRJ8upfiXrveCBT/fDIc11ApFOVPAxez/TVN90J8nLx0z58x0xNdKSWIA/W
	 /ZzeTWYkBXCLLQebdMp1RdHk5NRXxQ042cWzPSf6pPIOPl5wSsgeLFawi+Tw66NJ4
	 jn4BV3HvEhuigvsP/OuzWNIAaofE7A4z/QPVf5qld+zYbdpQr9+qR9haBC6bDdpHr
	 A5gAshGnNpipLkpT3pvxl7/2YbF/7zDCIMy8545glWYc7HS+b7Lawkl/LnMg73eCs
	 zeLuIl0J0c82IzLp6z4fnoh1bUup9Ik7jweSsv5eqMVe0H1yuNJyG5kHnozLcC/9y
	 BMPcKCZjaNs67UQFrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1t49DC1fug-00XTe3; Sun, 01
 Dec 2024 18:58:40 +0100
Message-ID: <3530748f-4819-4a02-ae6c-c459952ba82f@gmx.de>
Date: Sun, 1 Dec 2024 18:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI
 TFAN as thermal subsystem
To: Werner Sembach <wse@tuxedocomputers.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241127112141.42920-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241127112141.42920-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iNXq5KMPgNzHhE4xDnFQPJr4UksiC/fnVp+SReufR23hjU+WSUV
 QopGLGtd2ONGe7spKIo9lDLxzRaaDIuHWlnhFiPiBqrbVSMAjit60fJ7du068MA45nUQpLK
 eLYnOrGPyIerCbaHaYBTq4QvJuhhkwgii9gDTZe+5sqf5DChRFEeh1yYOd1p061yZXnOqzg
 Yik55epFe5NruEMJ2vqzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AT2YW/6Yv30=;1HomO/3/SRCWf5iRXaGHRZEEsNJ
 0NGcwDEuf2ffYfaOM2VgPr9OVbNA8A1t2ZeDgH3AyQcYXjHNDtQQiOKGg47s9qtWldBFDyagO
 ox46GfxTDP3UE+Toqc2M8kl4/wxSGSUJBMMh/Ga0JPe8TCwEi3BS+ddah5hGKLMWYfzQIO/4J
 XytJXPf0WrdHpPTNyxKLVoT2X6PR9P5P4qR6lJHY4fuBXPGzKjpLzVIliwvxOWzsvi8Ew+IBS
 culre0CN7Akst7JWHTWiFSYbR0NuPdWxtp7HCRkUu0jarp2lsyR5g8X2P/7FXPj/stZ3NZGJJ
 OvqD1S1Ref/TMtTTt62F/+6teFlx1MwCkJ7KORs8eaaQgZwmB9hrazpqLeU45jhqi6KuYoRWk
 D7J0Z5M9yPZQryELBA7LYNy7keY0diYzLiLwtMzopBxUjDQqqiVZ9Ca7WIi+DOyVTb6j85RDt
 oe87USKNGKJtqwPKCfRt5mMEZ7zfE6GndBQYrNrslLnrlYLx8HZqD4nv/CODwdAf9ST47h7G7
 Uv0R6KI3GX6JQfGT+XHcCbG90aeQpXCn2mfCvQ7o6aGI/VUkNK5SfJBJ0e8NJW5AaJbUhhe+a
 YTEpo815HFKRXts9arEKv2nZI2f4k/pnx6Ttim82cCFonoDLlv9QzL4I8upl18WS7WzAvnOl2
 k4CBZvmNMd63bWdnSLkiR7jyKGYEQ/mHUP9IMnx8Amv6ct9G2Bbm8W3gXxP3NGFSRZemsSClK
 8qJl8daWNdMhpwm7421KDpXDleGo2RuBWmYZVoe1J7MnguTsMu5exTi38JwzSm+afnYLaH/pY
 MoOvfbu/7w3jvBhHgWLU3I9X0BHrVqqZ7RFUHseDJPjyUaZhR8/Bqi8rI8w6JbeDHkFUSn3at
 M+gv67XZ9ynZohRG+uWuocOUR010UFk+ZBK3QuETPorLds0sPTNCJupIcqsCEsG5Bp8pJbQZw
 pxOCU3PyXwyZBwN5STDduaEy+SAJFb6VgGrY7KPsHSGg3OsdzSxOOk8iwqJH1ZaJAL2pVHsLQ
 QlON+PtjyiSFHo6mKoDmcupdDDN1uhBoRSqcc0E+B9U7/4uwwokxPuMVq0uTr+sPgLRH62Ei4
 M44GysP1JcJYYgQoA7Cc1mh8z3VAR3

Am 27.11.24 um 12:21 schrieb Werner Sembach:

> Hi,
>
> Following up to https://lore.kernel.org/all/172b7acd-4313-4924-bcbc-41b7=
3b39ada0@tuxedocomputers.com/ and https://lore.kernel.org/all/f26d867e-f24=
7-43bb-a78b-be0bce35c973@roeck-us.net/ I experimented with the thermal sub=
system and these are my results so far, but I'm hitting a bit of a wall:
>
> As far as I can tell to implement "2. As long as GTMP is > 80=C2=B0C fan=
 speed must be at least 30%." I would need to add a new gevenor, lets call=
 it "user_space_with_safeguards". I would be nice when the temp <-> fanspe=
ed relation could be passed via the thermal_trip structure. And safeguardi=
ng the hardware from userspace only works when I can restrict userspace fr=
om just selecting the preexisting "user_space" govenor.
>
> So my ideas/questions:
> - Add a field "min_fanspeed_percent" to the thermal_trip struct that wil=
l only be used by the "user_space_with_safeguards" govenor
> - Add a "user_space_with_safeguards" govenor that is the same as the "us=
er_space" govenor, but on trip, a minimum speed is applied
> - How can i ensure that on further speed updates the min speed is applie=
d to? I could just implement it directly in the cdev, but that would be sp=
agetti coding around the govenor.
> - Can I somehow restrict userspace from using certain govenors?
> - I'm a litte bit confused about the thermal zone "mode" sysfs switch, h=
ere it says deactivate for userspace control: https://elixir.bootlin.com/l=
inux/v6.12/source/Documentation/ABI/testing/sysfs-class-thermal#L20, but w=
hat about the user_space govenor then?

Hi,

i am having little experience with the thermal subsystem, but i suggest th=
at policy decisions like "min_fanspeed_percent" should either:

- come from the hardware/firmware itself
- come from userspace

Effectively this driver tries to enforce a Tuxedo-specific policy that is =
not directly based on hardware limits. The book "Linux Device Drivers"
says:

	"the role of a device driver is providing///mechanism/, not/policy/."

Furthermore:

	"When/writing/ drivers, a programmer should pay particular attention to t=
his fundamental concept: write kernel code to access the hardware,
	 but don't force particular policies on the user, since different users h=
ave different needs. The driver should deal with making the hardware
	 available, leaving all the issues about/how/ to use the hardware to the =
applications. A driver, then, is flexible if it offers access to the
	 hardware capabilities without adding constraints."

The issue is that the Tuxedo-specific policy is not directly connected wit=
h the hardware. Some hardware might need a bigger minimum fan speed than
other hardware for example.

The hardware (or rather firmware in this case) should communicate those co=
nstraints to the linux driver so that we do not need to rely on random
temperatures for hardware protection.

This ACPI interface however basically provides us with a hwmon interface a=
nd Tuxedo now wants the kernel to enforce their policy on it. I suspect th=
at
happens for warranty reasons, right?

Maybe there is a way to enforce this policy through userspace applications=
?

Thanks,
Armin Wolf

> Best regards,
> Werner
>
> Werner Sembach (1):
>    platform: x86: tuxi: Implement TUXEDO TUXI ACPI TFAN as thermal
>      subsystem
>
>   drivers/platform/x86/Makefile                 |   3 +
>   drivers/platform/x86/tuxedo/Kbuild            |   6 +
>   drivers/platform/x86/tuxedo/nbxx/Kbuild       |   8 +
>   drivers/platform/x86/tuxedo/nbxx/Kconfig      |   9 +
>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c  |  96 +++++++
>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h  |  84 ++++++
>   .../x86/tuxedo/nbxx/acpi_tuxi_thermal.c       | 241 ++++++++++++++++++
>   .../x86/tuxedo/nbxx/acpi_tuxi_thermal.h       |  14 +
>   8 files changed, 461 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.=
c
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.=
h
>

