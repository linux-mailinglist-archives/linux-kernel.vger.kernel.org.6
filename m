Return-Path: <linux-kernel+bounces-379708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C30C9AE27C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BB4282BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10251C07EB;
	Thu, 24 Oct 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OmlyPAns"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF216FF4E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765636; cv=none; b=W3rqEvCIVfNgOOn1gbkuyjgskcpeucn3Wbhaos2Fot/9KNNeHm26XaYrp2dyxjPKn4xaHl6aMDsc7oliqD2xgTx3ptyRyzBGkhZiwOyAPnHr1XCBZ0EedjmCxiXHUkqBOmFg6CZ3LD2/gwg0CxgwJXLOO3ej4lpUu/stYcDJhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765636; c=relaxed/simple;
	bh=GVoa/lCJ2pdfllPCWKL+/MbqTQi4UeFVGaIAtJ31GHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUPoWiSsQMJnvXgwUVf4+42ZicsjsNyvIAr8Nrmfy+0VmBjciblufSKiPXSgiTY61CQTLZUsaOj/Ida2T83Ql0i2aT/iN8WfUvVEDv1/DY0lwF1qFgo8OtVdiyzjCU0VLsYMffeIM2pwCklLxw6V/QC3X6DfWDTrO3cfW+hlXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OmlyPAns; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729765631;
	bh=GVoa/lCJ2pdfllPCWKL+/MbqTQi4UeFVGaIAtJ31GHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OmlyPAns36iyW1gjyZhueCp9W5XLw1NFgqZN/Mm4UWIQsSD0/ey7wbiwJsTRvI7LT
	 7X7iRpQriAOBptIhj83HQ4oFqurBheUb8BnpXMxdx9suEED0JToGar6kgWbzgxeiGK
	 nIgszf+09sdrO/FMduIK8sZGoDZubAJXYmoWmywzPv330aoab2sj0N1bMEhI9LXNjC
	 C6PLm3acDEBUzlv/Z0aiZVt/ShkYj8mjwD6iXRkZxe+HIYpG+ZS9f0VVeBPgf2qW7h
	 1X3xBtaGtkSsALRBmhefHZ8bTeUe4c76dr244/yR/hIRvT1Nu0I04wxzROFhlWRJ2x
	 8tfgaLeVPO32A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3A51F17E1245;
	Thu, 24 Oct 2024 12:27:11 +0200 (CEST)
Message-ID: <9ace7c33-7e45-4d87-869c-8d45afb47750@collabora.com>
Date: Thu, 24 Oct 2024 12:27:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] soc: mediatek: Add command for APU SMC call
To: "Karl.Li" <karl.li@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chungying Lu
 <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241024092712.431605-1-karl.li@mediatek.com>
 <20241024092712.431605-2-karl.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241024092712.431605-2-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/24 11:27, Karl.Li ha scritto:
> From: Karl Li <karl.li@mediatek.com>
> 
> Add command for APU SMC call.
> The APU microprocess's start and stop sequence will process in ATF.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>
> ---
>   include/linux/soc/mediatek/mtk_apu_secure.h | 32 +++++++++++++++++++++

This is firmware stuff!

Please move this file to
include/linux/firmware/mediatek/apu.h or apusys.h

If you expect that the APU will *never* have any non-secure commands, then you
can add the "-secure" suffix (apu-secure.h) - but if there will ever be any
commands that aren't secured, you should not call it xxxx-secure.h

>   1 file changed, 32 insertions(+)
>   create mode 100644 include/linux/soc/mediatek/mtk_apu_secure.h
> 
> diff --git a/include/linux/soc/mediatek/mtk_apu_secure.h b/include/linux/soc/mediatek/mtk_apu_secure.h
> new file mode 100644
> index 000000000000..ea491bc24adb
> --- /dev/null
> +++ b/include/linux/soc/mediatek/mtk_apu_secure.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_APU_SECURE_H__
> +#define __MTK_APU_SECURE_H__

Please, __MTK --> __MEDIATEK (also because the folder is called "mediatek", anyway)

> +
> +enum mtk_apusys_kernel_op {

here you can keep the prefix as mtk_

> +	MTK_APUSYS_KERNEL_OP_APUSYS_PWR_TOP_ON,			/*  0 */

and MTK_ is ok for those definitions too.

Cheers,
Angelo

> +	MTK_APUSYS_KERNEL_OP_APUSYS_PWR_TOP_OFF,		/*  1 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_REVISER,		/*  2 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_RESET_MP,		/*  3 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_BOOT,		/*  4 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_START_MP,		/*  5 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_STOP_MP,			/*  6 */
> +	MTK_APUSYS_KERNEL_OP_DEVAPC_INIT_RCX,			/*  7 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_SEC_MEM,		/*  8 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_DISABLE_WDT_ISR,		/*  9 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CLEAR_WDT_ISR,		/* 10 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CG_GATING,		/* 11 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CG_UNGATING,		/* 12 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_APUMMU,		/* 13 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_DUMP,		/* 14 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_WRITE,		/* 15 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_W1C,		/* 16 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_COLD_BOOT_CLR_MBOX_DUMMY,	/* 17 */
> +	MTK_APUSYS_KERNEL_OP_APUSYS_SETUP_CE_BIN,		/* 18 */
> +	MTK_APUSYS_KERNEL_OP_NUM,
> +};
> +
> +#endif



