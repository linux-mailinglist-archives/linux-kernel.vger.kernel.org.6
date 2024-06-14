Return-Path: <linux-kernel+bounces-215177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC6908F32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC47281E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BF195FDE;
	Fri, 14 Jun 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rhLNILGX"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAB195B04
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379711; cv=none; b=HxbnbSjDboVEd6yA2IYFkvXjnnEGHQoKhBGqpKucPuJAQkYsT8bpjD+1pnF3wl4GpGmz+xOxJWimzAsu6ken51T+CLWyEpqsR8T9WHNihuhxxsiQ7uL9aE6SDUtJfpOn3IwUc8pSdTJGkTzA/ZL/YmEt+qOtdQzwmt5OS/rOGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379711; c=relaxed/simple;
	bh=G8B8akW16zGg8zUlOix/RFqn7c0bYnlcLHUwDty6SOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR03ng1tHcaXIw2tiJwEmGGf5CKLhUQLCeVy2fmrznnD5tl7nu3l9BygBNRGr+M1ZRNoGywoJCeKs7hUmg7Qe3+Fy6rVzY9nMwWxa6aLe5pBclXHKXU5ldUAVGmuIzHglOaowjrur+RfoIqIlQNw7Z4qra/YPseiDrlYJ66FxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rhLNILGX; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id I93YsIab3c2iUI93Yse5qb; Fri, 14 Jun 2024 17:41:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718379706;
	bh=fMkYys7M3zvaEsKBAT2YIbRf9BEpH1IjB7DODovtk1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rhLNILGXGh6aZy8/ZRpK3rclBOuHKCCxpwcPv0Hhqjvh0e+xj4zkrYdYkzN51+IzO
	 1A7ebratQJgPPg7UOz4eMBXylChdfGeMEK9rBNIKG7RCRUhtR/jKQTAO9JKgvXdl4y
	 bLb1dFMa61l7Vixmqo2HriueRmAc0t9RHPN30bpm5zEcKmdnPZYESj557sUlHdpi3c
	 bMJDrcajhRAij70CcfBXO/l/Yrjd9AnTFu7FepxREKkV6nTd0PAi75hkS7wUPCbsiS
	 5e4fEamEtnPCSBfswOQtnBg+rpzSc8T+bM54+D+M0sN8j784Pa2pe2GSxbLDsNQaz1
	 wVMwtr8UiyOYw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Jun 2024 17:41:46 +0200
X-ME-IP: 86.243.222.230
Message-ID: <d6428e19-986d-4451-bfcf-17705cc9e53b@wanadoo.fr>
Date: Fri, 14 Jun 2024 17:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] ALSA: hda/tas2781: Add tas2781 hda SPI driver
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 lgirdwood@gmail.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com,
 kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
 v-hampiholi@ti.com, v-po@ti.com, niranjan.hy@ti.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
 broonie@kernel.org, soyer@irl.hu
References: <20240614040554.610-1-baojun.xu@ti.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240614040554.610-1-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/06/2024 à 06:05, Baojun Xu a écrit :
> This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> It use ACPI node descript about parameters of TAS2781 on SPI, it like:
>      Scope (_SB.PC00.SPI0)
>      {
>          Device (GSPK)
>          {
>              Name (_HID, "TXNW2781")  // _HID: Hardware ID
>              Method (_CRS, 0, NotSerialized)
>              {
>                  Name (RBUF, ResourceTemplate ()
>                  {
>                      SpiSerialBusV2 (...)
>                      SpiSerialBusV2 (...)
>                  }
>              }
>          }
>      }
> 
> And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> added into system as a single SPI device, so TAS2781 SPI driver will
> probe twice for every single SPI device. And driver will also parser
> mono DSP firmware binary and RCA binary for itself.
> The code support Realtek as the primary codec.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---

Hi,

not a must-have but using "checkpatch.pl --strict" could slightly 
improve readability in some places.

Maybe at least,
    - ./scripts/checkpatch.pl --strict --test-only=Blank
      --> to save a few LoC

    - ./scripts/checkpatch.pl --strict --test-only=parentheses
      --> to improve readability and reduce the length of some lines


This is already v8, so feel free to just ignore this mail and the 
--strict option.

CJ

