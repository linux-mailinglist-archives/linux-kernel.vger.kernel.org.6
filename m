Return-Path: <linux-kernel+bounces-443259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686B9EE966
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709B41887C35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5321576F;
	Thu, 12 Dec 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="P1rfBsof"
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1822135AC;
	Thu, 12 Dec 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015342; cv=none; b=YOBIFOeA3xHyW9xUUVZBgZSKhpZPuU+6S4B4Q8ESI4AJssAYfe6BkcVAWIO7owE2C04IbUOVz2PHkpnTab2a+9OwSkVeT/YhesKh1kN9Kbn+N8P5woi2MG5cD8yZv0wRIuV1ueiVOL+3rsKL3FITjB9/wscsmLiiqTOoM0F9IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015342; c=relaxed/simple;
	bh=uaHUoHwpv1HT3Z4534taOhnHeSNE2hMl9F4tg6u/YC0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NHo/OvKJp8LBkAybkeNblotYXa58+kaKFb6HXeQNmZqufLilbVEmzOg4cv+0QA7Y3uOkuXh+iWEZREDzcGurOmVue8cm1nLvnTPiVnG+28MeFlvvqR5j/tfMVGR2k1kq4u3D8rnfu+oZtxlmy/2fL0qss5LW/6VpMeba1kB8JlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=P1rfBsof; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 7A5E14CEFA;
	Thu, 12 Dec 2024 15:45:30 +0100 (CET)
Received: from [IPV6:2a02:842a:8223:5500::978] (unknown [IPv6:2a02:842a:8223:5500::978])
	(Authenticated sender: julien.robin28@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 23F11780503;
	Thu, 12 Dec 2024 15:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1734014723;
	bh=uaHUoHwpv1HT3Z4534taOhnHeSNE2hMl9F4tg6u/YC0=;
	h=Date:To:Cc:From:Subject:From;
	b=P1rfBsofK4r89SOJp1LL0mMpR3HZwW+XgZlwUXi3d1Isw/MIA7KKzQQ9vUXOaXU9P
	 yMM0jrW1xoRefQbnwXGKIbLwRzej7MEtwT9aEM/U8IX9jeeBgJMKC97xYYR711OYVf
	 op5sOS4ovE6TK8Qqk2t1gayeyJ5Chsxapl0K7oygAPCGpUqC2Yohnj59foshOKuS/1
	 JbZcgp3ovL0wn/QXCP7WX3dVey0Ud2ECiESfxqh7CWBBrufprVRqA77xD4M0Na6xKV
	 2wfoeVuWcb8AJ9LpgSInQZTrkl5KBrOOgP23Z+JIvxsBrTXIoVMCfFjcp0VnIiwbeq
	 cag7FD9ErcbQw==
Message-ID: <6e56ec6c-60ad-48ea-b185-19d7064a53f2@free.fr>
Date: Thu, 12 Dec 2024 15:45:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From: Julien ROBIN <julien.robin28@free.fr>
Subject: Bug report: HP: WMI: Fan speed reading and PWM control fails + dmesg
 related errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello there,

Using intended WMI drivers and associated sysfs through `pwm1_enable` 
and `pwm1` virtual files generally allows manual setting of fan speed on 
laptops, which can be useful to set maximum speed when running rude CPU 
and GPU tasks for example (to avoid reaching crazy temperatures).

I have a new machine (HP 16-s1034nf) on which (even with latest mainline 
kernel 6.13-rc2) this pwm fan control sysfs interface is failing, and 
fan speed reported values are stuck to zero (even when they are 
blowing), through hp-wpi driver.

Just to be sure, I checked using "HP Omen Gaming Hub" application in 
Windows that the hardware is actually capable of fan speed reading and 
setting (the answer is yes).

In details:
  - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/pwm1_enable` writing 
isn't applied (when writing "0", value is kept to "2" and writing "1" 
says write error: Invalid argument)
  - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/pwm1` is missing
  - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/fan1_input` is always 
stuck to 0 (even when fans are running)
  - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/fan2_input` is always 
stuck to 0 too (this computer actually has 2 fans)

The interesting part of the dmesg output is the following:
	[...]
	input: HP WMI hotkeys as /devices/virtual/input/input15
	ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PEP.DETY], 
AE_NOT_FOUND (20240322/psargs-332)
	ACPI Error: Aborting method \_SB.WMID.GTPS due to previous error 
(AE_NOT_FOUND) (20240322/psparse-529)
	ACPI Error: Aborting method \_SB.WMID.RDCF due to previous error 
(AE_NOT_FOUND) (20240322/psparse-529)
	ACPI Error: Aborting method \_SB.WMID.WHCM due to previous error 
(AE_NOT_FOUND) (20240322/psparse-529)
	ACPI Error: Aborting method \_SB.WMID.WMAA due to previous error 
(AE_NOT_FOUND) (20240322/psparse-529)
	[...]

All of the previous dmesg messages are disappearing when booting with 
`module_blacklist=hp_wmi` into the Kernel command line. In place of 
them, we got a single line:
	[..]
	Module hp_wmi is blacklisted
	[..]

So I understand these errors mentioning ACPI are caused by what the 
hp_wmi driver is doing (or trying to).

In order to be sure this isn't an ACPI Firmware bug from the laptop's 
ACPI tables, I used Firmware Test Suite on "DSDT" as explained into 
https://wiki.ubuntu.com/Kernel/Reference/WMI
It turns out imperfections found by FWTS aren't related to the HP WMI 
interfaces GUID. Anyway I'm still providing all of the related files and 
results in case someone needs them.

Unfortunately, going further alone is a little bit outside of my skills, 
but I keep available for any questions and tests.
As it's my first bug report into this mailing list, I hope I didn't make 
too much mistakes! Sincerely sorry in advance if I did.

Best regards,
Julien ROBIN

Notes:
  - Using Debian 13/Trixie (testing)
  - Problem still exists on latest 6.13-rc2 "pure" kernel with no DKMS 
loaded driver

I placed all of the required files (dmidecode, dmesg, kernel config, and 
ACPI tables related stuff) into the following link:
  - 
https://pix-server-sorel.luoss.fr/Manual/Linux/HP-WMI/Bug-Report-2024-12-12/

