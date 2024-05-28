Return-Path: <linux-kernel+bounces-192109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FA8D1888
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63E51C225E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079716C6B9;
	Tue, 28 May 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uXmoZx45"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517C16C6AC;
	Tue, 28 May 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891891; cv=none; b=Bxvj4d4RPOj9xD4IrWt5lai+LXaBAei+TjL1898GIrsZnvGzVF3BqH3wJQTRi9LO3XAQY3ISa3+cRCYnxP7M3qdlih1pz3VLLRGaBOLvpDkdM3lgF8hE6voJTWfNfeXrmSXncITlJGiOdRa4B+SyOE64v1yZE4vxy3gZM+zyLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891891; c=relaxed/simple;
	bh=eCwSK1GHrFnFt48tdaVfJXIdF4FWIhLcfBXFC1OraC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVpj2pPss57uUex7FZNYvJyrunAiTYZM9akOHvuERHtIr3CN8V5qYRK0g2rZLWBo3t6tdPiotHmXf9PfyIIysiVogDEJP6+NNC5RmqikLdZC6k/18DtC3IdlUecPUtYonXbpU5cm+7rRgfw/nxGRW84NrUkCSX1qFrZps13eEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uXmoZx45; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716891887;
	bh=eCwSK1GHrFnFt48tdaVfJXIdF4FWIhLcfBXFC1OraC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uXmoZx45jNRaFuP8GluwtX/dBcGxZBoC2sG3ztrO7Vw/mLyOgR6UHs5a39tVBZlII
	 tjM15S11SxO8H3TJvsD6+Ut+EF5A3BM2RLN/3GySr33UwEqLb0DH+bSm9OtW2bwZHA
	 ONOPOhmtKh8DTktxE/FsTqxmPJeVm6MBHGDwkenM9P9FvspUPB3kSMpokA5kqdtS7A
	 xHSc80R/5YVbiW+DOYJ+5HEccTEXY+0rLu1ow14Qst+fqaeNEGn7iA4LEOg+joW6Re
	 U2fA/SCgJqgv4hEz+heCV0YecgNueNj8a5r46HzdaJXIHE90lX7QeJNURxq0oM2/zN
	 zarGK7OsgFw6g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 962773782113;
	Tue, 28 May 2024 10:24:46 +0000 (UTC)
Message-ID: <26c862ec-1613-46fc-ba37-5649fd55e159@collabora.com>
Date: Tue, 28 May 2024 12:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] mailbox: mtk-cmdq: Support GCE loop packets in
 interrupt handler
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
 <20240525230810.24623-5-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240525230810.24623-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/05/24 01:08, Jason-JH.Lin ha scritto:
> 1. Add a loop flag for CMDQ packet struct.
> CMDQ helper will use a loop flag to mark CMDQ packet as lopping command
> and make current command buffer jumps to the beginning when GCE executes
> to the end of command buffer.
> 
> 2. Add a looping task handle flow in irq handler.
> GCE irq occurs when GCE executes to the end of command(EOC) instruction.
> If the CMDQ packet is a loopping command, GCE irq handler can not
> delete the CMDQ task and disable the GCE thread.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



