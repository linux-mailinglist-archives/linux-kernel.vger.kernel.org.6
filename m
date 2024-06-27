Return-Path: <linux-kernel+bounces-232024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7891A1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3697280F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272EF1304A2;
	Thu, 27 Jun 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aRvdGEAs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32241304A3;
	Thu, 27 Jun 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477546; cv=none; b=FU3Hf27nru1SxtcAgm8s+P2rB6eZEQE6GGvhjEzCHRL3pDuJHNYv5LnyF3YeFR5Y9y4UOSnM5i0SD8lB8UmzDxRdlO9WNzzcgTocDIdknV3xKyG60B811/G7a7hzDu45PWtTTQ4FhdrYBa4SlomZ0SPJRxHBEvx1EA+iXinU524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477546; c=relaxed/simple;
	bh=EyoPoXrPDGo2VmUULjYB6t4i7WeQmc3bKPn161Uq5C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APUhho1V87xEhSO2xU4WHfSQZaw1UEgqtMoTywUYPcpGJVteUTgMkbx7tOx/7A318OqPDgjLJhUMqLa8xpPnro2yhurKeZgSyOpV322l2vpiMstLjjpNnX1p0g4lGPsFO/lAvTjx6OQUYHfsPP+KZ1In+Lo8AnrhIAmvPzDGDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aRvdGEAs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719477543;
	bh=EyoPoXrPDGo2VmUULjYB6t4i7WeQmc3bKPn161Uq5C4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aRvdGEAs/GUEQ0n0QxDwOX4pNpA2bj5xIypAsKVq3+ZqSP5/i0mH3Iss5UD4hTKAQ
	 JRAd62aimRIaXDW1Rfgyzt2AY2oadnB665vfEJcuLCtTOZ2ylxlX3gE5lKBJV9cdMm
	 rAbZ+Ry6xHvFzIlWDBhgM3FzZo1PvIILqSbw+UDH7bDOPoMKYM4OVAhNS++6dWOYYz
	 tqHXKh87FScwc63ckIolkzqrVkxG8PXGIG2Ix6MpqPAtBR9pXSXxwQuu1UDyutIEr3
	 4gc8e8F+QG+dsVtKVqRmAU0Tw69tF9lhROLrWVzW9kVrX06IlAuhEp8jLtVxciOa/c
	 gLgPzgMTHq8lQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 279AB3780626;
	Thu, 27 Jun 2024 08:39:02 +0000 (UTC)
Message-ID: <1e32a8b4-0cae-47c7-9112-f0b6e78bf31b@collabora.com>
Date: Thu, 27 Jun 2024 10:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
To: Yassine Oudjana <yassine.oudjana@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Daniel Golle
 <daniel@makrotopia.org>, jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240626202406.846961-1-y.oudjana@protonmail.com>
 <20240626202406.846961-3-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240626202406.846961-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/06/24 22:24, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks and resets
> on the platform, enough to bring up all essential blocks including
> PWRAP, MSDC and peripherals (UART, I2C, SPI).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

If the resets were properly bound, you'd get my R-b here. :-(

It's a 20 minutes job anyway, go-go-go! :) :) :)

Cheers,
Angelo

> ---
>   MAINTAINERS                                  |   4 +
>   drivers/clk/mediatek/Kconfig                 |   9 +
>   drivers/clk/mediatek/Makefile                |   1 +
>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 138 +++++++
>   drivers/clk/mediatek/clk-mt6735-infracfg.c   |  79 ++++
>   drivers/clk/mediatek/clk-mt6735-pericfg.c    |  92 +++++
>   drivers/clk/mediatek/clk-mt6735-topckgen.c   | 394 +++++++++++++++++++
>   7 files changed, 717 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
> 



