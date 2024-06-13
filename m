Return-Path: <linux-kernel+bounces-213503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57393907623
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5833B22DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E929149C7F;
	Thu, 13 Jun 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KLnXcahS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58F145FE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291451; cv=none; b=I5yOSTmhKq9IISDBvw+2LcvUVcRYNeaZhHADgVgChSETMCLhkbWCFnAuuLJsqR7GyQPSIZgCKiypPg/+uErqPi/gkt5kZvH5xRNV0P4dPu9PEvqeYpkR7nGA8Foyu2uFLBM0ojpuenSyVWytG1tYEA1rH1cQZ44RhSGtOuTdLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291451; c=relaxed/simple;
	bh=C8+7Q95rup1dkVkxvwEADGOn4f1wiUjE8zc+qzXfe+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ5xXXJhVK5o4YXM3Jjv6yqtNH4RA8UNK9qLXXxMNuTmaCxLNGjoVbYjBrWzN4eeCc9wkSXYHmUuKdcYAjgAfylceSeXgyyYkAkjqpumrBVFZjxIYq9z+YHhQZt9llXwHNYz/JLDDQ75AbGfXHIlbP2ufe7dSRZxua7eG5Z0NMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KLnXcahS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718291448;
	bh=C8+7Q95rup1dkVkxvwEADGOn4f1wiUjE8zc+qzXfe+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLnXcahSEZeK/t/aaFTH9g6LlvAreuAyF7Vdo8TqyJgJo02hdBpdL68O9e1kJxZDG
	 2M49xoEHuYbm8BbzvCqhm4rPXkSTfB5MxYiLIrjONwAowwLW/uniUYmlDtCP0GBYJQ
	 /ue3dtE2/Brkacxf8qdJ2KCb77QH87xi+vwiioByi9skyq+uvIlgZdTFMHvSgn1dyh
	 ZgTmzLk4ENU9+u57Jvw3dWdjGiPobqGin7ShB3k5VsbB5kF9mfSAGBdlgcGSCFBeyZ
	 tzoz2oGGj2hPO4VSNtTXhXkrbXx3W9AGqCtb4OV6ltl4fXIEzfDjvUhL1qkktCbZNx
	 cm3XYdNJHyzIA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 752B937809CE;
	Thu, 13 Jun 2024 15:10:47 +0000 (UTC)
Message-ID: <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
Date: Thu, 13 Jun 2024 17:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/06/24 17:06, Jason-JH.Lin ha scritto:
> Add unregister mailbox controller in cmdq_remove to fix cmdq unbind
> WARN_ON message from pm_runtime_get_sync() in cmdq_mbox_shutdown().
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Hello,

I think you forgot about...

https://lore.kernel.org/all/6fcd48b14e865c25e6db7559fe6b946537bfa0ce.camel@mediatek.com/

...as that would also resolve this one without any hacks.

Cheers,
Angelo

> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4aa394e91109..1399e18a39a4 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -371,6 +371,8 @@ static void cmdq_remove(struct platform_device *pdev)
>   {
>   	struct cmdq *cmdq = platform_get_drvdata(pdev);
>   
> +	devm_mbox_controller_unregister(&pdev->dev, &cmdq->mbox);
> +
>   	if (cmdq->pdata->sw_ddr_en)
>   		cmdq_sw_ddr_enable(cmdq, false);
>   



