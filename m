Return-Path: <linux-kernel+bounces-343679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77405989E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CB0B237EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDCA188737;
	Mon, 30 Sep 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HID+3H9Q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7E18787B;
	Mon, 30 Sep 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688374; cv=none; b=seR0KoHMSnCM6vrkfJ87ILRwuJSpP8nR/zcuJRn1UaD7oUXeqLxf6Lb9+wU87UzRaREz+ZfzmEf8VOYGvo3S6lULRVYDI8TcYr+cE+uDVjir4VTrHXIetEScUOJxmGdjze5F3FnJ4KZbD+Tgnupo0Gn8uRe5xeTOgu3cwCTsRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688374; c=relaxed/simple;
	bh=ESiC2GOpvxGfYWJul0YYydb+LAlHnP6rF2ndfAGzpQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipk1GTF1ECgjaxFz0vonEP+sPaiEmtZH1S1ZcxiOvsdbpSpsDRfNIOQSw726dUxBqPxD2HTnK0fShhZBJvM7SbphqARQLcbKhHYq3TGPc9GkvxAeKauskpZZXwaYTWGjl2BZAqyTz3MA/ftEHAxOPzTqWmTCVAHiWChetew5TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HID+3H9Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727688370;
	bh=ESiC2GOpvxGfYWJul0YYydb+LAlHnP6rF2ndfAGzpQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HID+3H9QbZnQQwdbU8gSz8uf+Tzch3B/xjKgNr+Uhi+HGZsWtTo/kVZEHXHM8Txmn
	 BMwyXnZxzDC+l7V4NaBs/uJU63cm/Cpiilh1+laqz7+KQsokRrX5+n7CkGxbJxUUBj
	 qWBnjndvLGUSpnkKDhkRGldKcEbEqa1Re0NhGLF41+JQudOdlsuRRDlBTlBddqYPlO
	 blAVnHuASno4ANbcJqrXY3PIb3uBxXTIl5ihuCx829XRR3jN9djPgx2Wi5IpovNlyd
	 Za28LwM5HwVDVBtEOwFxtAs0nnpi2SK+hyrnuGFc630gW0RS5FNUWXbNhY/I7o1oAP
	 w+wU4V4TyKKLQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1405517E10AF;
	Mon, 30 Sep 2024 11:26:10 +0200 (CEST)
Message-ID: <2782dd71-25ae-44ae-a8df-6af995ef7413@collabora.com>
Date: Mon, 30 Sep 2024 11:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: mt6359: Update generic node
 name and dmic-mode
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
References: <20240930075451.14196-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240930075451.14196-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/24 09:54, Macpaul Lin ha scritto:
> Some fix and updates in the following items:
> 1. examples:
>     Update generic node name to 'audio-codec' to comply with the
>     coming change in 'mt6359.dtsi'. This change is necessary to fix the
>     dtbs_check error:
>     pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 2. mediatek,dmic-mode:
>     After inspecting the .dts and .dtsi files using 'mt6359-codec', it was
>     discovered that the definitions of 'two wires' and 'one wire' are
>     inverted compared to the DT schema.
>     For example, the following boards using MT6359 PMIC:
>      - mt8192-asurada.dtsi
>      - mt8195-cherry.dtsi
>     These boards use the same definitions of 'dmic-mode' as other boards
>     using MT6358 PMIC. The meaning of '0' or '1' has been noted as comments
>     in the device trees.
> 
>     Upon examining the code in [1] and [2], it was confirmed that the
>     definitions of 'dmic-mode' are consistent between "MT6359 PMIC" and
>     "MT6358 PMIC". Therefore, the DT Schema should be correct as is.
> 
> References:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/mt6358.c#n1875
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/mt6359.c#L1515
> 
> Fixes: 539237d1c609 ("dt-bindings: mediatek: mt6359: add codec document")
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



