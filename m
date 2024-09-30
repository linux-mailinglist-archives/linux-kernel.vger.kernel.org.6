Return-Path: <linux-kernel+bounces-343678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D0989E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3AB2384B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC61885A6;
	Mon, 30 Sep 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N4eeI5bO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15E1EA84;
	Mon, 30 Sep 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688372; cv=none; b=P/pGutGvoubvXB9v51C/gkfIP2VF1pKGTi8PbkxgqeX1SyAx6bIqRjcUqI8U73UTcyefzbyLmtl9joLE8UlJBw+YxRBr/R/nL/1pyl8+l2NdqaiGnJpNpOt1nl51KAtpYNclCJUJXBNyEO2KC8Km039tQNQj/iKDNaw70J08OD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688372; c=relaxed/simple;
	bh=idxgyuER2MHeqDbyn3N5PMcWgX/FiLELm2aeJU9EBOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPvBI9iXxNZEx2ReCH6WFBrvpzIE9iOVrWQJTbbI2yZypRj0mt4zjuhDGYZqUizSRL3z/5qfNEYIlvuZdzSwwMuosX8gw69vcYqU4ynZNtvO8qHkoa9tDVPh7RiGwC7Wjb7c+hrG+FQ2iQeApppvXg0zhjLzIdy70GOmXsF7Dbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N4eeI5bO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727688369;
	bh=idxgyuER2MHeqDbyn3N5PMcWgX/FiLELm2aeJU9EBOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N4eeI5bOKCU5YtmjZfhA0TICxGkvR2FWa6VsAl6iVd0B+CIQqlcFflHGuGD/PWltH
	 DSukScD7rTvlbprhvob8/95C3DiRpA6nB8Q/g38780TJzz0GYQt5uq36XQD2BY2Agr
	 nmlp/xE3A/H3hJTdYttt4Zq/RKfukynwP1hRJ9xia1vGAvoz4MjylQzMrHbhAZ36GF
	 b4GZJSpmvViGFtyGcRIDxnvUQLmsVsU2uXl10gdf6jZfSCChOsvEaUTtV6CINXxjne
	 Pg1giRMJCy/YiaOqluAPaPmhvdC/dqbTdmr7fUWNLqu3yQxRNFsYm6OFnv4JXkNt8E
	 Wvrjb+6Vv/T1A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CA76817E1091;
	Mon, 30 Sep 2024 11:26:08 +0200 (CEST)
Message-ID: <9260a488-e386-4103-bdd0-04bdc2db8f0f@collabora.com>
Date: Mon, 30 Sep 2024 11:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for audio-codec
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
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240930075451.14196-1-macpaul.lin@mediatek.com>
 <20240930075451.14196-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240930075451.14196-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/24 09:54, Macpaul Lin ha scritto:
> This change fixes these dtbs_check errors for audio-codec:
> 1. pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
>   - Replace device node name to generic 'audio-codec'
> 2. pmic: regulators: 'compatible' is a required property
>   - Add 'mediatek,mt6359-codec' to compatible.
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



