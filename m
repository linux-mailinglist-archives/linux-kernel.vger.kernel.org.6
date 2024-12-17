Return-Path: <linux-kernel+bounces-449246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9AF9F4C55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F8618921E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A281F4263;
	Tue, 17 Dec 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NIr23H6y"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AB1F03E8;
	Tue, 17 Dec 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441551; cv=none; b=ttX8YqNNQqNut1USHALH7E4WjHI6nqEKtotikXS+Aq3VnBAdif2Gk7gpvOzfUdq4oFvpLQ/kEwpHZKGV+/q10PC8GQyu18sG65cXTOlXYk1g572Q4SUCsHKzpvliCyG33BEvoL+RahN5c9AyEV6341Lk3SnWbw6TxsdxlAicPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441551; c=relaxed/simple;
	bh=GystmgYDwjDUbQIi65MhsY/caTgyfH7ztB4WE2dJtiA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GLLl6xRVPp3Kk+pX3c9UKlUTtf8XzdAPZMdd/Dee6338Wjc40PXj3Br4ozG8TGHJD7OCG3ZDA8j9j6Aog7mLS9P3ueyZ+puzW/lXgJx0QqdJMpeUd6qOYjmZYCVAMpj+r/U4uGEBDE7V6tYPbvY4gdtfkq6iqYtiSFTbdntNjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NIr23H6y; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a02:842a:8223:5500::978] (unknown [IPv6:2a02:842a:8223:5500::978])
	(Authenticated sender: julien.robin28@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id BDAFA780502;
	Tue, 17 Dec 2024 14:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1734441541;
	bh=GystmgYDwjDUbQIi65MhsY/caTgyfH7ztB4WE2dJtiA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NIr23H6y0P0y7ECI07vrcZqdYZNUYrTiJPId4Df97UOmejZBZUzOs4FmFjHTCchRw
	 0sxHI2cZGKPd8AFgbbgmTxAKrMRaQsd3L79c1PdmBPYE2BXkWrCslbTrw6G0c04RRK
	 Lc8C1Nt99p/nvrl4/7jxP13SVHuLG2kzkGLTukOVFXu6huWpwaP0e/so7Swe2954T5
	 RAys8lQZNgFCV32rAL6e3md00cKP3L55/KApsLZnkMQuaZf/OiPoB7YPNfVHCBQ8zv
	 ThCX86h854jTnXTdliCXLFJaZLAvyZ9+uuHPOgj1Lz4M1kFsNvc9vrsZUA1SXNFbNr
	 XQNlwXWt5Y9fw==
Message-ID: <4d213541-9305-46ce-83ad-3e4bbc5f9819@free.fr>
Date: Tue, 17 Dec 2024 14:18:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug report: HP: WMI: Fan speed reading and PWM control fails +
 dmesg related errors
From: Julien ROBIN <julien.robin28@free.fr>
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6e56ec6c-60ad-48ea-b185-19d7064a53f2@free.fr>
Content-Language: en-US
In-Reply-To: <6e56ec6c-60ad-48ea-b185-19d7064a53f2@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/24 3:45 PM, Julien ROBIN wrote:
> Hello there,
> 
> Using intended WMI drivers and associated sysfs through `pwm1_enable` 
> and `pwm1` virtual files generally allows manual setting of fan speed on 
> laptops, which can be useful to set maximum speed when running rude CPU 
> and GPU tasks for example (to avoid reaching crazy temperatures).
> 
> I have a new machine (HP 16-s1034nf) on which (even with latest mainline 
> kernel 6.13-rc2) this pwm fan control sysfs interface is failing, and 
> fan speed reported values are stuck to zero (even when they are 
> blowing), through hp-wpi driver.
> 
> Just to be sure, I checked using "HP Omen Gaming Hub" application in 
> Windows that the hardware is actually capable of fan speed reading and 
> setting (the answer is yes).
> 
> In details:
>   - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/pwm1_enable` writing 
> isn't applied (when writing "0", value is kept to "2" and writing "1" 
> says write error: Invalid argument)
>   - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/pwm1` is missing
>   - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/fan1_input` is always 
> stuck to 0 (even when fans are running)
>   - `/sys/devices/platform/hp-wmi/hwmon/hwmon6/fan2_input` is always 
> stuck to 0 too (this computer actually has 2 fans)
> 
> The interesting part of the dmesg output is the following:
>      [...]
>      input: HP WMI hotkeys as /devices/virtual/input/input15
>      ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PEP.DETY], 
> AE_NOT_FOUND (20240322/psargs-332)
>      ACPI Error: Aborting method \_SB.WMID.GTPS due to previous error 
> (AE_NOT_FOUND) (20240322/psparse-529)
>      ACPI Error: Aborting method \_SB.WMID.RDCF due to previous error 
> (AE_NOT_FOUND) (20240322/psparse-529)
>      ACPI Error: Aborting method \_SB.WMID.WHCM due to previous error 
> (AE_NOT_FOUND) (20240322/psparse-529)
>      ACPI Error: Aborting method \_SB.WMID.WMAA due to previous error 
> (AE_NOT_FOUND) (20240322/psparse-529)
>      [...]
> 
> All of the previous dmesg messages are disappearing when booting with 
> `module_blacklist=hp_wmi` into the Kernel command line. In place of 
> them, we got a single line:
>      [..]
>      Module hp_wmi is blacklisted
>      [..]
> 
> So I understand these errors mentioning ACPI are caused by what the 
> hp_wmi driver is doing (or trying to).
> 
> In order to be sure this isn't an ACPI Firmware bug from the laptop's 
> ACPI tables, I used Firmware Test Suite on "DSDT" as explained into 
> https://wiki.ubuntu.com/Kernel/Reference/WMI
> It turns out imperfections found by FWTS aren't related to the HP WMI 
> interfaces GUID. Anyway I'm still providing all of the related files and 
> results in case someone needs them.
> 
> Unfortunately, going further alone is a little bit outside of my skills, 
> but I keep available for any questions and tests.
> As it's my first bug report into this mailing list, I hope I didn't make 
> too much mistakes! Sincerely sorry in advance if I did.
> 
> Best regards,
> Julien ROBIN
> 
> Notes:
>   - Using Debian 13/Trixie (testing)
>   - Problem still exists on latest 6.13-rc2 "pure" kernel with no DKMS 
> loaded driver
> 
> I placed all of the required files (dmidecode, dmesg, kernel config, and 
> ACPI tables related stuff) into the following link:
>   - https://pix-server-sorel.luoss.fr/Manual/Linux/HP-WMI/Bug- 
> Report-2024-12-12/

As an update on this subject, I eventually went further, I obtained much 
more comprehensive information and did some successful tests.

I'm sharing it there, in case some people are looking at this issue in 
the future. If not, I may be able to work on a reliable update patch 
later, to implement new behavior on correctly identified new laptops 
models without altering behavior with the previous ones.


  - 1st change: User defined settings (thermal profiles and fan speeds) 
aren't used unless a "Fan Count get query" = 0x10 query using HP_WMI 
command HPWMI_GM = 0x20008, is played before. This should also be used 
as a keep-alive to maintain the computer in the user defined state, 
instead of having it returning default generic state after a 120 seconds 
timeout.

  - 2nd change: Disabling Max fan speed by writing back "0" with 
HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27 is not enough: it should be 
disabled using "Fan Speed set query" = 0x2E query using HP_WMI command 
HPWMI_GM = 0x20008, and providing 0x00 values (2 bytes).

  - 3rd change: Reading the fan speed with 0x11 query doesn't work 
anymore, instead, 0x2D query may be used to retrieve actual/measured fan 
speed (and the reading of the returned value is different).

  - 4th change: The performance modes / thermal profiles, which should 
be applied using HPWMI_SET_PERFORMANCE_MODE = 0x1A queries, are using 
only 2 values: 0x00 for ECO/Balanced modes, and 0x01 for Performance. It 
only changes the cTDP values of the CPU. But the HP provided app for 
Windows also performs other new queries, including GPU related thermal 
settings.

  - 5th change: No EC register seems to allow retrieving the current 
performance mode, so the ec_read(HP_OMEN_EC_THERMAL_PROFILE_OFFSET, 
&data) thing shouldn't be used anymore.


All the details:
https://pix-server-sorel.luoss.fr/Manual/Linux/HP-WMI/Bug-Report-2024-12-12/HP-WMI-retro-engineering-2024-12-17.txt


As an example of quick/dirty successful tests with the fans:

https://pix-server-sorel.luoss.fr/Manual/Linux/HP-WMI/Bug-Report-2024-12-12/hp-wmi-original-6.12.4.c
https://pix-server-sorel.luoss.fr/Manual/Linux/HP-WMI/Bug-Report-2024-12-12/hp-wmi-FAN-SET+GET-success.c

Best regards,
Julien ROBIN

PS:
About the dmesg "AE_NOT_FOUND" errors I mentioned into my original 
message, it happens when legacy HPWMI_THERMAL_PROFILE_QUERY = 0x4C is 
being used (for Omen/Victus laptops it doesn't work anymore) instead of 
the HPWMI_SET_PERFORMANCE_MODE = 0x1A query.

And about the missing pwm1 file / impossibility to write "1" into 
pwm1_enable file, this is just because as of today, the driver isn't 
providing manual fan speed control other than Max or Auto (so this was 
normal).

