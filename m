Return-Path: <linux-kernel+bounces-360522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289D999C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3EC285790
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7691F4736;
	Fri, 11 Oct 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GHb/WN63"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EA8F58;
	Fri, 11 Oct 2024 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624032; cv=none; b=fx98pSbntEzRxENf2QcaErfKpCwQBpR6oSt0Cvts6z078Yc6a4OxnnCKTBXsuLvC8AwTOY1r0PNW3lB3O6leTqt9aiHENTYycvHlaeIVb5wSCJzgWEBA9Ah3qY9YSa1XKQdxRmiVzoNJkpHrz9Ywbz9631N8PNjSKZha/ALtHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624032; c=relaxed/simple;
	bh=s65Bz3+ieIAUqwK5ADHiCy63ZY39r7OBbLrjyxkUk4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN0j+TP75SX9Ua/CyYmMSKyOP8FPJ27Xn0TcdZ18I3aTYd/CJGzdYW7yZlZSQkhWp1CiE0CzfgpgYv4KbvhtEGkWE2XTlQcfqzCUl1PjhMgDssxodh8ShO3SnOOHDvOzDvbFn/ZJquqO1suh3svzECkf2X1/Fe/dTdCaJmJwvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GHb/WN63; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <94782cf4-5317-49fb-bd8c-8dfc4eafae74@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728624024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/llnmoIv2jFYjcnFeNjsM9lCHRTODti3ojbao7n7Sc=;
	b=GHb/WN63nq81PzDEaMiWyiiT/1uRK+SE5qK0HiO5zEyIUa6xb/Kru1yvNAGtapeB9cfLqT
	kPQ1e9RFxQfqkX6J2C0MyX/yG8LQ3F9/jPr9Rcr+tLE/znewRfx60kISkh8usXRjIG1TxE
	RKqD5FlpZs8T88R1+ahxticaOgqp1GX7m8Y1bIqa9Qu70SQxy4Vw/EIW2rRarge9iiUc9U
	+N9mu+onKzMq//w/kvVR/0bkO1NUC+qZOLNU3sWaKB+NnPo4dECqakz886nsJOccYyROkM
	aEbDunUbGl9EJCMH5yLlDqy5bI1nKB4IZLNbvBtQ2Cql5TczzBj7WuR4IdlaDw==
Date: Fri, 11 Oct 2024 12:20:10 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan LoBue <jlobue10@gmail.com>, perex@perex.cz, tiwai@suse.com,
 shenghao-ding@ti.com, kailang@realtek.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 derekjohn.clark@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 Kyle Gospodnetich <me@kylegospodneti.ch>,
 Jan Drogehoff <sentrycraft123@gmail.com>,
 Richard Alvarez <alvarez.richard@gmail.com>,
 Miles Montierth <cyber_dopamine@intheblackmedia.com>,
 "Chen, Robin" <robinchen@ti.com>, Antheas Kapenekakis <lkml@antheas.dev>,
 "Xu, Baojun" <baojun.xu@ti.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240812045325.47736-1-jlobue10@gmail.com>
 <87frra2ocp.wl-tiwai@suse.de>
 <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
 <87cymedlrt.wl-tiwai@suse.de>
 <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 15/8/24 19:58, Antheas Kapenekakis wrote:
> Hi everyone,
> I created the following Draft MR for the Ally firmware files:
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/272
> 
> Please comment on it at your leisure. I will remove the Draft status once
> all the sign-off members verify it for correctness.
> 
> @Shenghao: can you restate publicly the license of the firmware files and if
> there are no issues, sign-off on the MR?
> 
> Best,
> Antheas

The firmware is now finally merged upstream: 
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/317/diffs

For now a symlink was added to make the current driver implementation by 
Jonathan work: 
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/318/diffs

Jim and Robin from TI will adjust the tas2781_hda_i2c driver to load the 
correct firmware per speaker vendor so the different optimized 
protection parameters are given.

For example the following can be used to readout the GUID for 
calibration data in UEFI BIOS:

status = efi.get_variable(efi_name, &efi_guid, &attr, &total_sz, data);

Example source:

find /sys/firmware/efi/efivars/ -name *-1f52* -print -exec hexdump -C {} \;
/sys/firmware/efi/efivars/CALI_DATA-1f52d2a1-bb3a-457d-bc09-43a3f4310a92
00000000  07 00 00 00 dd f5 15 41  4d ab bb 0f f4 11 bd 31 
|.......AM......1|
00000010  bf 5e 97 00 00 00 00 24  2f 8d 10 3e 77 b9 7f 10 
|.^.....$/..>w...|
00000020  f3 07 6e 2f b3 d0 93 00  00 00 00 24 00 00 00 00 
|..n/.......$....|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
00000050  00 00 00 00 f2 e1 73 66  8e 08 d9 2b 00 00 00 01 
|......sf...+....|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
00000080  00 00 00 00                                       |....|
00000084

-- 
Best, Philip

