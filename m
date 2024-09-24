Return-Path: <linux-kernel+bounces-336784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4379840C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A992878E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B871714F9F8;
	Tue, 24 Sep 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KizET30Z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956A14F123
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167306; cv=none; b=X6ZyJs6IdOT1MkJOgXStzKgOLp0t4/jg8HZFae0q8k798rz74zc9G3YiIBVYV7SiBIUbfvB12tVPN8s7vTsPWd7tfUGuMuzdJ7mgSEjl8oXa83YqZUDDLiTs7LlU3LSqMceaBo0VQz0hdxt4g22c6M/VIK5u3K+wd9EPZfZBIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167306; c=relaxed/simple;
	bh=0Nxohz98wsc6izrrKqrkIzll7iRJ8I4nyuTfQRY2aaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1L79xh5PsFYesK4j85eIAYZ9DXVDbJj6pINIJaujEnzDfeP/WhT8+Ey1F/87vxyOpohHCxvwyhiSK6XoYKIuLUCACUfOXY0FjpHTFhr+qRqaGkp09BIlK1XxmYMpQKDvKiOIT6yPuJow9oMhzEHqRTxp8D8lu2Z5APxCB6/x0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KizET30Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727167302;
	bh=0Nxohz98wsc6izrrKqrkIzll7iRJ8I4nyuTfQRY2aaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KizET30ZYWAlv4XJzFn4/Dn1JgreGEciuLmwr+bPzLztL1s7S8v62aUwodhOw7GkZ
	 L7vJYwiUkgi11IbHhlC/FhOGcKljWZPOvsubEJ0Gsy5oaYBIW38Xwozwl8/MDBABqG
	 DpGcR4jlc0FFjh6pYTOAWwkTPngqI8hq7cCBjaGTn7LuUMLUJx+eS/zJIWNz6VyuEi
	 5xPCeYaWWWMQowVPReqfQnAXrcnKCki4eO5bjtbc1TBOUzp84WMhRxu1qOH1Q3orRg
	 B3fHiJ/gNashbVw7dlzcof0RJ/MC9Jotki+VA7cdgRAlkumLta3C5IKa5Nua+orLtJ
	 +MgFE6MFXk2fw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D98017E1067;
	Tue, 24 Sep 2024 10:41:42 +0200 (CEST)
Message-ID: <9a7b67a4-f4aa-44df-8933-876396e873d9@collabora.com>
Date: Tue, 24 Sep 2024 10:41:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Depend on
 CONFIG_COMMON_CLK
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/24 18:40, Cristian Ciocaltea ha scritto:
> Ensure CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX depends on CONFIG_COMMON_CLK to
> fix the following link errors when compile testing some random kernel
> configurations:
> 
>    m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_phy_clk_register':
>    drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1031:(.text+0x470): undefined reference to `__clk_get_name'
>    m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1036:(.text+0x4ba): undefined reference to `devm_clk_hw_register'
>    m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4d2): undefined reference to `of_clk_hw_simple_get'
>    m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4da): undefined reference to `devm_of_clk_add_hw_provider'
> 
> Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409180305.53PXymZn-lkp@intel.com/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



