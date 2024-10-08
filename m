Return-Path: <linux-kernel+bounces-354501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00999993E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D51C21847
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73113AA45;
	Tue,  8 Oct 2024 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="llvyWqoK"
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B712B9BB;
	Tue,  8 Oct 2024 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365615; cv=none; b=KqkDtil1cy82SSIHTVLckCdJFOfUHHkf+fiwYRTyvoLnkhVHXnlxvDlO1eywpLHhBy0AhHN3o06gAwO726W74qf0uCcwZA7XFmYPKfbSMThGClDKLcGuqq8uc852MSSQeF1/t9oRMEEO7WCDYhVKGPh1iBdnm5m3WoknDBLJVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365615; c=relaxed/simple;
	bh=9ni54QSrdwSHq7d2+a5BcIF4MYsHCRqrUkKPaPuMo3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSQjHzzAWXeEY3nSHxsoXNp7+iTiO4GLEUEjXVJaOmzQ2NXEzC/4pmMfGsH+ym3wgVeuKqSYUCXdnGsnyIkzNvuIqc6gcQpoGLceQ6l1sYBOeN0oVICbG12utc7ZfLbuUvVni+Nb5Y6RmwpqSTTPLyCe25RP4TvAbUF8zouOwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=llvyWqoK; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id y2hYsjl8DMzKhy2hYsly9M; Tue, 08 Oct 2024 07:24:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728365048;
	bh=hoL86RdTqQ8BynHJyVQv0VQLGn74SF5+hgmDuDEGZHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=llvyWqoKgOPDkgmksNGiAUZvkK9V6Ms4sg6ksdFktnf2OfAxAUXxSsW8f55g+KyfF
	 XarA9mB0f9e1N2TBaRxuvhRt2WcYHpBtFshE6SrOzxuoqpGaArHesAxMNxKaCiXWK8
	 AilL1N5oM/grhXMI8+sqpCIvhhGjvI+P96yDN0T8gcZGewzXYqp6/muGDQoWjSxRiY
	 +WDPbgyogFQ/ZL6i6DfYFdqxnV+7ZfYdGyx+2ybBiicC1IQI1OZFuOHTrp7w5XyBf4
	 1r114NLHeWkkV53KA/nTeH9Bg9XRYP/D3QTx1Df+xZDrkgXx5nvzyHzDmwjSSjcGr/
	 SLU2k+haLLvhg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 08 Oct 2024 07:24:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a5517624-6e26-497a-bcc7-84d7dd786d5c@wanadoo.fr>
Date: Tue, 8 Oct 2024 07:24:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Sound:mixer:Remove unnecessary assignment of sprintf
 result in build_mixer_unit_ctl
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, perex@perex.cz
Cc: tiwai@suse.com, k.kosik@outlook.com, xristos.thes@gmail.com,
 wangdicheng@kylinos.cn, kl@kl.wtf, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241008033022.11280-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241008033022.11280-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/10/2024 à 05:30, Zhu Jun a écrit :
> Simplified code by removing redundant assignment of sprintf return value
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   sound/usb/mixer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 9945ae55b0d0..dea6cbd65667 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -2224,7 +2224,8 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>   		len = get_term_name(state->chip, iterm, kctl->id.name,
>   				    sizeof(kctl->id.name), 0);
>   	if (!len)
> -		len = sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
> +		sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
> +
>   	append_ctl_name(kctl, " Volume");
>   
>   	usb_audio_dbg(state->chip, "[%d] MU [%s] ch = %d, val = %d/%d\n",

Hi,

even if not needed, using snprintf() with the same sizeof() as in 
append_ctl_name() would be nice, IMHO.

CJ


