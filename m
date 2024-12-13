Return-Path: <linux-kernel+bounces-444471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F193F9F0761
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A74188BE99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96D1AC8AE;
	Fri, 13 Dec 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WgRD6Mus"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237418E377
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081167; cv=none; b=F+DUzPWXP+BgexYt2FhpBftjH+Q4oONqdfrGIdvJxHyC1RoyDS0/nVNDABwjtNn/Yi/NH8CnYnNvTESUmV1DgAhMI7g3zDxAkIWxENrOauJFVs3XCNWGR41sHvbc36SWSMY2t9AJaP9W0sAd/lFfMRyD+dgGRCDe2eGkFXjRUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081167; c=relaxed/simple;
	bh=oSGM60y09Oxd4LnsiKPrEWXfPyzP08a8xYxLQZNZM+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvZOMDHWiB+Srhu81nofC/LkWWjgiJ/B2vZiJqkyqUTOHzanx71yqJxULFjdpnszqUek74flGf/Sziaamv71rth+AvUv8rWmj8g0YxA6XtJc/lof99KTNFKMmkabgtBpmw7gMRvTRjBReVdARBntr1Bkkq/aakapXQniKTDeLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WgRD6Mus; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734081163;
	bh=oSGM60y09Oxd4LnsiKPrEWXfPyzP08a8xYxLQZNZM+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WgRD6Mus15QRPVQyv3ZOZqP6oGeND583a9mh22fZknno9xbpB3EdKMtUwpqpEPMIP
	 oDyNRvtVEfYTui+tIVPGip3TiQLENYSjWT2p4apuvAZewIh30dug0YudNd7jui5EJq
	 p4BHyywFAZVMDE96AcpkyS0CD9BDs/ThXLVjPIWQNdDGScber5aIEviqELhYcIG3mD
	 OpMBG5p4gf+2MCtTObNG0D0yDDz6flbfhvGlsz9okgrXJP6ZxrfAyqYsnytCzcA53q
	 LOTarkgwVnZ9zebMEtRk3yo0+hLTOJN3M5pV96m6iWmKCShG3LyIzH0ThP9+jBEAzb
	 eQXoYJKqfEEyg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4199417E100A;
	Fri, 13 Dec 2024 10:12:43 +0100 (CET)
Message-ID: <7f2949bc-55ff-4d62-b310-6240f70a1673@collabora.com>
Date: Fri, 13 Dec 2024 10:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: mediatek: phy-mtk-hdmi: add regulator dependency
To: Arnd Bergmann <arnd@kernel.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Phi-bang Nguyen <pnguyen@baylibre.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Daniel Golle
 <daniel@makrotopia.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241213083056.2596499-1-arnd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241213083056.2596499-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/12/24 09:30, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver no longer builds when regulator support is unavailable:
> 
> arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi.o: in function `mtk_hdmi_phy_register_regulators':
> phy-mtk-hdmi.c:(.text.unlikely+0x3e): undefined reference to `devm_regulator_register'
> arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_is_enabled':
> phy-mtk-hdmi-mt8195.c:(.text+0x326): undefined reference to `rdev_get_drvdata'
> arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_disable':
> phy-mtk-hdmi-mt8195.c:(.text+0x346): undefined reference to `rdev_get_drvdata'
> arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_enable':
> 
> Fixes: 49393b2da1cd ("phy: mediatek: phy-mtk-hdmi: Register PHY provided regulator")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry about the miss.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



