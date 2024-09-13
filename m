Return-Path: <linux-kernel+bounces-328795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323649788FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE852897A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153981465A0;
	Fri, 13 Sep 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fBKuZZ5E"
Received: from msa.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61513AD03
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256000; cv=none; b=mXcU/PXd6ceh1sKVKViZTBZnxwNLlBCdZ7KYDpjbFD4DdfdfUkAi5vT9saw8bYc48vG6cvGZQ6mboQpGvxhIUWqKxbpyohy3MKaUtTtOvQdrcN3vnbC9lpNnGA7zTLj+xvOtilWtk7PS6pwVBsQacpzo2iKNyJEH3/Iz39c0Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256000; c=relaxed/simple;
	bh=FJf2/qicU/Ub7t4CHyb6DnSpZplsW5xVb2wAQve19O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C15FTTvQONznPlTbX7FLGB6c6i/BYjHr62J0MHSo2Wdip3sM951JCiaAlMvc7eOaatwVrZk+XxUWtluYW4mGJxv46Mf9xgamG1FxpLAQk0nJpiO+Xd+gHQE7wNW7lNCHYgBz9Ocv5TrxuUVLyL7Jn6/55ljmCWXqet4f2i8MWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fBKuZZ5E; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pC1OsIlQM71UmpC1OsZYb7; Fri, 13 Sep 2024 21:31:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726255919;
	bh=nVA7uG1NwgGwCUCbBVabP7FPCkwT9VHonPQjHtNDTOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fBKuZZ5EdgcATloIEZ5h5J9PNsbxS/ecJLKobaFG7LPiXngodlYSiNpyGK8QaU7QD
	 aKoXPnxlSmr1cCp8sJC3dM5S5vNUBv69LXmL0mGhD1vVRhpAfSr/prKajXeokmmmpw
	 5SeXNiubfk4DZWonLlU/7DVG1G0psXvCiNsAISd0qin0OlMXwP2BSxJeKXqS7Tze2V
	 uBItcOO41KlLwmnMsaS0+f8avUnxVLeL0S4Th79pagkAmJfhU68wCMvyYt9ZhPB2Pa
	 FPKTrANkK/TuyMV0cm4fCxYR3xM14A+iCajiWIPjC1i0f69YddexGu2PtrTCVuYgN5
	 zEKMuZIKj9lwA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 21:31:59 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c4e7b3ac-d8fa-47b9-84f6-e3332bb54e12@wanadoo.fr>
Date: Fri, 13 Sep 2024 21:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
To: Abdul Rahim <abdul.rahim@myyahoo.com>, rafael@kernel.org,
 rui.zhang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913191249.51822-1-abdul.rahim.ref@myyahoo.com>
 <20240913191249.51822-1-abdul.rahim@myyahoo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240913191249.51822-1-abdul.rahim@myyahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/09/2024 à 21:12, Abdul Rahim a écrit :
> strcpy() is generally considered unsafe and use of strscpy() is
> recommended [1]
> 
> this fixes checkpatch warning:
>      WARNING: Prefer strscpy over strcpy
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>

Hi,

in order to ease the review process, when you send a new version of a 
patch, the subject line should state the version: (i.e.: [PATCH v2] ...)


It is also a good practice to explain what has changed with the previous 
version.
Finally, it is nice to provide the link on lore to the previous version.
All this should added below the first ---.
Here it could look like:

> ---

Changes in v2:
   - Remove an unneeded extra parameter (MAX_ACPI_DEVICE_NAME_LEN) in 
the 2nd strscpy() call

v1: 
https://lore.kernel.org/all/20240912205922.302036-1-abdul.rahim@myyahoo.com/

CJ

>   drivers/acpi/thermal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 78db38c7076e..6671537cb4b7 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
>   		return -ENOMEM;
>   
>   	tz->device = device;
> -	strcpy(tz->name, device->pnp.bus_id);
> -	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> +	strscpy(tz->name, device->pnp.bus_id);
> +	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> +	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
>   	device->driver_data = tz;
>   
>   	acpi_thermal_aml_dependency_fix(tz);


