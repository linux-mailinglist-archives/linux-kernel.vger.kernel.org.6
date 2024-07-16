Return-Path: <linux-kernel+bounces-253285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC5931F12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEF3282039
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE3CA40;
	Tue, 16 Jul 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lxuNgjXh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D53224;
	Tue, 16 Jul 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098868; cv=none; b=ehAzA+wpZQ+5SdpwhB5wQWFI2m/Qk3gANssKv6kFMM6cskcP5DzG9Zxd32UllgAee07bu51e5vJtWKLUby55seyHeMXhm9YemKw9HFEODmCC02IvBfVaX7oKSNTVmeVqsBfNfxqDGc/52WoKhLn5Sb4Irj2sS6DlXiuMCQYkLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098868; c=relaxed/simple;
	bh=wIZrglgYO769FiWXo1dTFFsEPXihHFxfIcMy8tkZCfU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=igyVC6E+M4yEDSRfXx8oSX/fagpXSAdEGI1CACNEDEtwXfQsBa8vBDKI+fsnw8POYoxv+4Ltp3RhDgDPbdXi+C9bQ/SsqL3ptQp2RKCMmFKqM1brjwTto7PtLj0Ce4XrCXTPsjHj0pGzigY5rJ/3dBJRQTXM4wICZZw8/VtQPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lxuNgjXh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721098862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rswZVR3IzZAW4VDWUHfqlBwWT/NMTNi3QeFCfqZztcA=;
	b=lxuNgjXhtThjdVjaTyB7CTsdTVTkjfUE9RDuu8hlmnVLhQQqRpFmd0OLVyoDrSZy+yWYkZ
	dATGbyxVxVsR+OInDlBIzVeCe7qzZnZmJFVMYOkrB3k2wt/8IugXdMZqYgpJKon4O0scLl
	H+k5sQJ9w+kiBhOtOuOGGd75F4U1Z58hN8EF9PL/Fb0Ao7620HF9sv0N3jja+daz0nYX8p
	vttaTk1jdramm55qdAykKHzixGmZPDfu4kbQhRtz0CKwGXiHcpCQ5XDEEEIotIgsFJBLdY
	fBB9R7iOi0/WCvtdwEohs7uZO8+iFoSCzNut4auLRwdLCw92z3grtk/v6qDSHA==
Date: Tue, 16 Jul 2024 05:01:01 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, sbinding@opensource.cirrus.com,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l42: Convert comma to semicolon
In-Reply-To: <20240716025307.400156-1-nichen@iscas.ac.cn>
References: <20240716025307.400156-1-nichen@iscas.ac.cn>
Message-ID: <32852e06f72e570de3da00f4ded84211@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-16 04:53, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 90f6a2a20bd2 ("ASoC: cs42l42: Add SoundWire support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Nice catch, thanks!

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  sound/soc/codecs/cs42l42-sdw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l42-sdw.c 
> b/sound/soc/codecs/cs42l42-sdw.c
> index 94a66a325303..29891c1f6bec 100644
> --- a/sound/soc/codecs/cs42l42-sdw.c
> +++ b/sound/soc/codecs/cs42l42-sdw.c
> @@ -323,15 +323,15 @@ static int cs42l42_sdw_read_prop(struct
> sdw_slave *peripheral)
>  	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> 
>  	/* DP1 - capture */
> -	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
> -	ports[0].type = SDW_DPN_FULL,
> -	ports[0].ch_prep_timeout = 10,
> +	ports[0].num = CS42L42_SDW_CAPTURE_PORT;
> +	ports[0].type = SDW_DPN_FULL;
> +	ports[0].ch_prep_timeout = 10;
>  	prop->src_dpn_prop = &ports[0];
> 
>  	/* DP2 - playback */
> -	ports[1].num = CS42L42_SDW_PLAYBACK_PORT,
> -	ports[1].type = SDW_DPN_FULL,
> -	ports[1].ch_prep_timeout = 10,
> +	ports[1].num = CS42L42_SDW_PLAYBACK_PORT;
> +	ports[1].type = SDW_DPN_FULL;
> +	ports[1].ch_prep_timeout = 10;
>  	prop->sink_dpn_prop = &ports[1];
> 
>  	return 0;

