Return-Path: <linux-kernel+bounces-359058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E779986E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA571F2523E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A401C7B8D;
	Thu, 10 Oct 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="laEKuPAa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0D1C2DAA;
	Thu, 10 Oct 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565144; cv=none; b=lSKycnS0/1T2t2HYjn/5L/dry4/MTtF6edAP+BGJmbrWO/pmB+bXid1Xd9DmXejf4Ud4WLb1Fy0LkDZqgksFljPEqNHzTH0hVjZJ3WP3K/YVnAC+MS3OvZPOt30cw0xOXO/37NVQxl0M4EZxjPC5XUEcbyswOktNG4n3CNDw1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565144; c=relaxed/simple;
	bh=q0iEWP95qwwtGXsHq48Npy9+HyLqfY/XYIOSdxzTgaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=am7ew/APESSRzVqjf1/FMNF4BGQrl4VB3U+zTDKF6vFRLOFHgZcgu3qJXCdv2hZVXEmLjT7ch3q6VZhQLEe768I8MZbENslCYnct4DcyQjKbxihPyiOXbQn27xpgbMUI/FsPfh1dqCZ/g3V9E7LauIA/K6Lt8fYmv7oOV/a7f48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=laEKuPAa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728565140;
	bh=q0iEWP95qwwtGXsHq48Npy9+HyLqfY/XYIOSdxzTgaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=laEKuPAayGim8pWgwRekogrjcQft5YoywLWptCKTVe+STMBrugzS/QVfiWVb2ndaV
	 d7GVSzFgGp7m82Nb5hxMNI9cTGaYoZf1lpxqDm9zQbvZcxgMosZSUnCjwo5QwDOo9C
	 WNYqOUiAlJfxUVdBZzuYYCsSZWr5KOjZWJBV5VB6vNPyHbPdIIIpVprACCM4KdfrF6
	 Gt+N33mHLjCPYzDwroQIDTJU3k8MOAJJxL2lsRomutci3WsYL84uh0mZpObqJIgsEf
	 FwPgs5pCugfKjoLA47svNZ7lxHd6LuVD7w0W6evhOFNK8qa13L0ztpfF80OPSCOg9p
	 nOWCZONvmn2KQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA01817E35EF;
	Thu, 10 Oct 2024 14:58:59 +0200 (CEST)
Message-ID: <d74b0ce0-f0f1-4088-a036-f4872ba87a0c@collabora.com>
Date: Thu, 10 Oct 2024 14:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: clock: Add MediaTek MT6735 clock and
 reset bindings
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <20241010124529.78460-1-y.oudjana@protonmail.com>
 <20241010124529.78460-2-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241010124529.78460-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/10/24 14:45, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add clock definitions for the main clock and reset controllers of MT6735
> (apmixedsys, topckgen, infracfg and pericfg).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


