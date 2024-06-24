Return-Path: <linux-kernel+bounces-227134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C19148E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389DB288DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255B13B7AE;
	Mon, 24 Jun 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cbfG0/9O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62913B2B8;
	Mon, 24 Jun 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228874; cv=none; b=qqcKU/SDloQ7g6JD4MSYe0a642bb1rka6OS2e9HNXqrMGCHVLptjnqCXdoOy5kTI57zJo85TV2NXgpZoQ8ScnBP4qQY3zLl5uiq68K6nsWYdtng3E7QX/bQRgjm28GpLwvLfItvZeOEgVqx301n5yS2un/4bJCpy+YyYQo50pdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228874; c=relaxed/simple;
	bh=YLhTWK6igYJuPvZyPGLIMWGPCfN4vQMIvMus5EY3xto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpk5rPV8MR+BdYSGS2egtkEotdwN5q81jNKHHtjpfbn/ItVygvSEA+GlZ2gXrivIb5EMJR76Eage3xZSfxNdljwwDMV+99KCJX3ouMhaIUkigJT6MQ/nOJoyHR830s9xGqbgPenimL2PHz5k9TuZi3oVOriKttffcD+88pqtD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cbfG0/9O; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719228871;
	bh=YLhTWK6igYJuPvZyPGLIMWGPCfN4vQMIvMus5EY3xto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cbfG0/9OvAfM0klxsGM6D/6s7rhg2rwR4bxDE2ioVTZxtCrPkBdS8olFDK7/n2l2Y
	 5/+V+LDSkOvfUWs5X1Qf76/KyO+fVQk1TuLGLMw7G7ub+GafZtKnDKThb4Qy5NmSrt
	 cICuYf61w9t22Tx2xqs01glNX3mIyXIMsotyV8NIt23aS+cm5TaIuu0lHksqSRZptQ
	 ov/96GNysovLsUnMgpjOdMtBLKS2ervVFiBwmsCg4WW41AFsxcCYhMr6vMeXQW5vcc
	 ulbZjeU7LU/n15eAavqaEelm+znFmvRpnBN4R2zEKsZp1djp0IG+iyUGaNGsLdWUVm
	 biDXYud5GoVRA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8857437804C6;
	Mon, 24 Jun 2024 11:34:30 +0000 (UTC)
Message-ID: <05841850-aeb6-47b6-916b-f4889d971d5c@collabora.com>
Date: Mon, 24 Jun 2024 13:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20240608-md-drivers-mailbox-v1-1-6ce5d6f924ad@quicinc.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240608-md-drivers-mailbox-v1-1-6ce5d6f924ad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/24 18:31, Jeff Johnson ha scritto:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4aa394e91109..8247584bcbeb 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -790,4 +790,5 @@ static void __exit cmdq_drv_exit(void)
>   subsys_initcall(cmdq_drv_init);
>   module_exit(cmdq_drv_exit);
>   
> +MODULE_DESCRIPTION("Mediatek Command Queue(CMDQ) driver");

MODULE_DESCRIPTION("MediaTek Command Queue (CMDQ) Mailbox driver");

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



