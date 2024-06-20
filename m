Return-Path: <linux-kernel+bounces-223142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71A910E65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC73B25AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E51B3F07;
	Thu, 20 Jun 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="D/oFQvgh"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3691B374E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904240; cv=none; b=Rjhaf0NuKLYjoKbxI/qKKQ7lVqVadRNGcUYnMI790NT5Xxh3MlP35h+WjXaglI1UoColxOuQrByEFUc97cQ0d39nhJVt02k9nj6ZZ+2DrI7YprIFF0wtVIruoPoC1WGTwDOcxZjWIKtwfozOYFUIuNtG9jryWERZ1Zm9xQhJE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904240; c=relaxed/simple;
	bh=ONH5auuAOTuHgD7nUneEjH4UhcF/+3Eihv1qKoZxitg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNeMggGDz3X8mlRIYAWk7CLiCNBLwI8npFOoYAQZSIZATBXMldsRL3xmt/k9nma2byZxtOizH7Eogj2Aj+AJ5+F68kaifti9Ul1s03NEz3FI0q39v3dajTXbwK1L3KS68IDn1jp4EHgfMMRi5H7X/4MUcirSCLLMJrKkRs7atIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=D/oFQvgh; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KLVhsuPMas2bgKLVhsCVx9; Thu, 20 Jun 2024 19:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718904230;
	bh=ihK0V93i0kUYjZJxFoTyf13pwL1rOBXEjTiHXm80Fik=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=D/oFQvghy7dXACkonDzJ57U3Epo2n6WVhLieiPe9y3fSV68U10gAFME9D7t/0TeUO
	 wBVSB9uIYJhcm69wRDDAKdL4rXf2SaJQ1gAhAf/WuVS+gxO9gsXG1fV2E1Sf8/Y9a3
	 krapwyI4WZePfaU22OKhI7WnBUrBHnVsfbi0buPp5ftaN4KFxU3tjvgSbYxmcQNFaw
	 wxRVloasWSC19zZVF0tKggy3Quldcw+HoxelGs3SuoeYuR0e5e9vhuYmdKZYats7Mq
	 /rfo2+4tTm/TwSOWphDXLaDho3V+wSbosIuiYLoiNs6oOra8HX0Lj4xY4K1S8Kk1GE
	 hoNxUrLVYtXRQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jun 2024 19:23:50 +0200
X-ME-IP: 86.243.222.230
Message-ID: <464e68fd-7175-4de1-b037-3a40c1e134c5@wanadoo.fr>
Date: Thu, 20 Jun 2024 19:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panel: ltk050h3146w: add check for
 mipi_dsi_dcs_enter_sleep_mode
To: Chen Ni <nichen@iscas.ac.cn>, neil.armstrong@linaro.org,
 quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240620074720.852495-1-nichen@iscas.ac.cn>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240620074720.852495-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/06/2024 à 09:47, Chen Ni a écrit :
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> index 292aa26a456d..24bf05d0589f 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> @@ -526,7 +526,7 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
>   		return ret;
>   	}
>   
> -	mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>   	if (ret < 0) {
>   		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
>   		return ret;

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


See: 
https://lore.kernel.org/all/588e8b4519487f6d33419c4b0fa7f8ea1b26cb58.1619869792.git.christophe.jaillet@wanadoo.fr/
which never got any feedback.

CJ

