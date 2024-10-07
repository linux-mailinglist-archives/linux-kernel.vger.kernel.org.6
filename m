Return-Path: <linux-kernel+bounces-353597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A299301E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6881F2139C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690E1D6DB9;
	Mon,  7 Oct 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FVNAV2X4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4431D54D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312851; cv=none; b=A/nt3dHM6EhvXFJFoAeJow8Krufs4lcyTp6l6y9WZq/eI2NogyuAVA8+ufjXdHaQZMxUaVc5Kql9JlXSW5H1KG5+FKSgACD8woixTQREWOHfRuu26yIj4HDPFP6gpoOrtEIdDlprSRIFS0Q0+qMS4TnScyI45lr4/GjnYbNsTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312851; c=relaxed/simple;
	bh=9/Ra/jDDnLa5AUszXp1dUHjFKSxU6y6Jqx381bWuyDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktCBa7C424hk4+dDfTyG0PNkzmHyu0n4zipgjgpTm9464ZlwSMOROK/XSq/fVscVQ97bXGoDh+Q3fqnSQ150G4tHN3lzxF+IdhLYDA1Of4cN+MhrXLM8L0rMxP8BgJd5ChfLgzK3tRyECElbbFg4v7oX6MVQufIUweR8gZL6G40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FVNAV2X4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728312848;
	bh=9/Ra/jDDnLa5AUszXp1dUHjFKSxU6y6Jqx381bWuyDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVNAV2X4utwp+8hiBgmNYD1A3OTPIU65XCMGxEyHZ1AV7sdeDtBxGOTqTS5CKlAhL
	 P+GQaixTJqVnWh3JfR0hZvE18Bl5O9Em/W1fix/bnNaIM2ARm9caHXvEX/fBSPrgAt
	 RBvtBhOOas0vaD5J9Yk4cYlqAxgrnjQTi1/80RXmDK7qXcLlnV6jlJURkFyNInaUnC
	 IU6sHuz/WNEyWMoBAa7whXIzQbjGM0IcMZ5g2DkVO8QvU4ZsA//kR/A1o0YprNulhr
	 Lin2tHzmOFYMHGusSIFl0ugj0QRrckzbHqSdGM/b9XqBd6CdyEZZTgOpUDZuNnC67U
	 hqBqv26xkzTww==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 88E5217E35FF;
	Mon,  7 Oct 2024 16:54:07 +0200 (CEST)
Message-ID: <381fcbfa-edfb-46c8-8ee2-1386af2ba4c4@collabora.com>
Date: Mon, 7 Oct 2024 16:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: pwrap: add pwrap driver for MT8188 SoC
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007024350.7878-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241007024350.7878-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 04:43, Macpaul Lin ha scritto:
> MT8188 are highly integrated SoC and use PMIC_MT6359 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6359.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Actually, MT8188 and MT8195's pwrap registers and code flow are exactly the same:
since they are, we don't need this commit (or we don't need it right now!), and
we can just update the binding so that we can declare...

compatible = "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon";

...hence this driver doesn't get any commit :-)

Cheers,
Angelo


