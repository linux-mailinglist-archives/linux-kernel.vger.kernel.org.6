Return-Path: <linux-kernel+bounces-563050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D24A6363A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135D3188EB6E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56F1BC07E;
	Sun, 16 Mar 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="BrNurQvJ"
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69F170A23
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138849; cv=none; b=MBVhnTulyef9N+oXk6kox9wlLPWm0VnxoKRy2K42uhRzis/udnDZBp17xnJoVoTviMFaTppX5nSq3M3zRai1WwusfBKR09BjCFw2Xsvn+AYndkwPLcc/ZCT6YSDrXsx2EQ+2D5FG9uDvP7GQeyKAiy86rPRNZo1ifG6sy8mejKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138849; c=relaxed/simple;
	bh=xIAGR3rTi2VFs5vz6FaMb4UDqr6c1u8chTvVITD6Rbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDHSl8tqA3Uu21A42Dul5k+YY+A6JNSU3mBXaA9ssUw7QflfvmEesUwcIgm+cExFl81rGx+kSyhv7emjZygwkCiWbSSb3btzSbFPIcvdK4sY+NghK/eJool5DQkfR3jorBSIzd8YTYNkM7hhZqCyDA4/JoCH6kMfJfmbnMlyuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=BrNurQvJ; arc=none smtp.client-ip=62.149.158.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id tpqXtGvZHRBkHtpqYtwISJ; Sun, 16 Mar 2025 16:24:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1742138654; bh=xIAGR3rTi2VFs5vz6FaMb4UDqr6c1u8chTvVITD6Rbk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=BrNurQvJizAP8V6GaOcxRxujYl+aZmk6563V0x6NNGNZD8Y/H+wB+gt1SLSMfBYam
	 DMXFrUQArNy440RM1kXnUyVm7Tl7d1wsMG2t0BoTuyffpzs/ODWza3EZeLTpXBZd0O
	 PT3IAK8Md7wnpZqhqZKpdaACnvtQJwJB6qV9pfSaKvTw+J5QKmqQzwalzh4H5QWP8Z
	 soM40yy11eMoGNwqXLKmgJ8eO3rOfebhsUDdcJ/bSFDYab1dYp80R/p6TYezYw/zO/
	 nSIyrYznmOT5AQbwc91i8KkGXks7G3BhjLvkJY652n/qqL2u0Kla3QdPxd8G80+tS6
	 p8qecIsBRjq2g==
Message-ID: <6939b245-3ff9-431e-8acb-68fed13d276d@enneenne.com>
Date: Sun, 16 Mar 2025 16:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, gregkh@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org
References: <20250315133140.1707949-1-raag.jadav@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250315133140.1707949-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFF9KlROu73GmuCAIeu9k8paF3bO90ei+ggKlOG70X3qYklfv1jeYjNmxwibJ0DC6GVjTL1fukf7Ewb44RC+CgCPiuQPkexLGLu8r6UR8fDKYC6LOBpC
 e0JqTLVf0/oDC8QNHEXOpZSXha9BQthyc/pwbmUdaw1wrJ+RALrkx+BikLeqjX3DmvzRvvAOBmShudnoUwPPa3WGe8YLDmDoIlhEGFx1iFguWGxPXItrrMVG
 CydqtI65y4zW2zK9jH6vX8XKzPs70IIMWXzVbtNlmBGqsApqTtaWQwkkSIfElSdOz/s2BFdNGaP1E9eqalA4Sw==

On 15/03/25 14:31, Raag Jadav wrote:
> Set driver_data correctly and fix illegal memory access on driver reload.
> 
> Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/pps_gen_tio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> index 6c46b46c66cd..6e4a383957d9 100644
> --- a/drivers/pps/generators/pps_gen_tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -230,7 +230,7 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
>   	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
>   	tio->timer.function = hrtimer_callback;
>   	spin_lock_init(&tio->lock);
> -	platform_set_drvdata(pdev, &tio);
> +	platform_set_drvdata(pdev, tio);
>   
>   	return 0;
>   }
> 
> base-commit: 6f119e3da79ce5e586340059403ab77201c1bb45

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


