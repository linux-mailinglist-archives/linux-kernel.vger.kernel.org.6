Return-Path: <linux-kernel+bounces-343688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE0989E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E77F28347C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D518871D;
	Mon, 30 Sep 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EbDMjcHZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396791531E8;
	Mon, 30 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688610; cv=none; b=Ez700JYXmyQyFZLTJJdtn8++G5++HvB79Eki11C5IcxMT4AqXSLolOxYAgJFApWfox11jpK4oSHnejpTU5GXiOLPjCHd1H3E88/RgNrhxeL9AOXaW8isem7dy4FbFGxDHb/DqQHsXV7Xq3PQL/2B8cWcP8lxB1vohkYNLiF/i6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688610; c=relaxed/simple;
	bh=chXonVIjKbTmAdAOSYxXNG0+38/QRF5hIq6lh/WbP+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAbkv0Z5KX72Vks7Yf4S9voq/SGZD65puAQ4U23qmc1vrn7bQ3rLDrFfUdVH4qFQSFZtRIoC+1QbcWf1V9RFuXBb/ixPlt9/hijWpwoRoH2h2ltqts3QR2S2YlCWmY176sHs9lEs5EfB6c3FR6IDh5AOIO91i1beh4dVbFkTbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EbDMjcHZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727688607;
	bh=chXonVIjKbTmAdAOSYxXNG0+38/QRF5hIq6lh/WbP+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EbDMjcHZNHIfl4ef62zGh/PnFFWf9km6MWrEdedLicstQj3EB1mefogTMHLh20hEO
	 ny41w61Ktf7Q+JBvBbPqEiAGhkidOWm+Sl0eZV8RNrNrj0qTX4LN+DzsioXtxLF3oT
	 QRbFiG9FDAryUCW720ch4+G6dTHX4lZiyv8wA2uve0lb8FYZcFEXnHhHuose3UFibN
	 EZCdwHSeD21bysxVskgMsZoYH1heiwVPOKOe4SlZNAR1H2lxQb1GniNFPdnOpjOccp
	 whXFTEpwH3BDej9rQgPFBj442rv1mJnQxv3e4KO0vAKI2B6KVxDc9HbHmjvItvGTsL
	 cUAgbCv+e+rGw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1AB2C17E10AC;
	Mon, 30 Sep 2024 11:30:07 +0200 (CEST)
Message-ID: <fc9d8eee-8d6d-4f1c-82bc-873765dfb458@collabora.com>
Date: Mon, 30 Sep 2024 11:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 Mali GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
 <20240927103005.17605-7-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240927103005.17605-7-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/09/24 12:30, Pablo Sun ha scritto:
> Configure GPU regulator supplies and enable GPU for GENIO 700 EVK.
> 
> The GPU in MT8390 & MT8188 has two power inputs: "DVDD_GPU" and
> "DVDD_SRAM_GPU". In Genio 700 EVK, DVDD_GPU is supplied by
> mt6359_vproc2_buck_reg, and DVDD_SRAM_GPU is supplied by
> mt6359_vsram_others_ldo_reg.
> 
> According to section 5.2 "Recommended Operating Conditions" in
> MT8390 IoT Application Processor Datasheet v1.9, The recommended
> operating voltage ranges are:
> 
> - DVDD_GPU: min 0.55V, max 0.86V, typical 0.75V
> - DVDD_SRAM_GPU: min 0.71V, max 0.92V, typical 0.85V
> 
> To further optimize power saving, we couple DVDD_SRAM_GPU to
> DVDD_GPU according to the following relation:
> 
> - For opp-880000000 or lower frequency, keep 0.75V
> - For opp-915000000 and higher, DVDD_SRAM_GPU should follow
>    DVDD_GPU. The exact voltage for DVDD_GPU should be decided by
>    speed binning.
> 
> This rule is derived from the OPP table in the link.
> 
> In addition, set the voltage spread to 6250 uV, the step size of
> 'ldo_vsram_others' regulator of mt6359, otherwise the regulator
> set_voltage operation fails.
> 
> Link: https://gitlab.com/mediatek/aiot/rity/meta-mediatek-bsp/-/blob/eedd6aedd4b0cfc0ee79b9c9b9650dfa73cf87f6/recipes-kernel/dtbo/mt8390/gpu-mali.dts
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


