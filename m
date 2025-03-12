Return-Path: <linux-kernel+bounces-557537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE82A5DA85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E2B18967C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0C23E33E;
	Wed, 12 Mar 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NkpHAdAK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89823A99A;
	Wed, 12 Mar 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775709; cv=none; b=DKoQHWtxeO34Q+VCDKRbHCkJbSuODiqK8VO/y4Fw9RgqxdGl131S48MJkhW1XTrp/8U0TDpUIqBTkSFR1op3R2rCo+uOdhz+oMRPFYLXH4DyttQg7Ne37mfO4PLLrICFr136q4MgtV3pOGnrFL5uYUSTcI9p9Du+1t4uTgMCA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775709; c=relaxed/simple;
	bh=GAAKQGlAjAuFb7UCdS2YikzUcIS5KkMpOhjlyDoWf2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCRz7xsfTd4UNH/Gx+9MU0F6jA+TWzlLl3jg3J21C1cLnRSEE0RknZ0Z8I7NL9iwAwESi/ikPBXstBXjeEf619VluO7Vi8PAHdqZaAKVLuim9QR7hf1lpJrsvaqsLigiR1j86/mg0U2asUbc73sfavHZXUPFIyb8xm/1Cz8ZNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NkpHAdAK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741775705;
	bh=GAAKQGlAjAuFb7UCdS2YikzUcIS5KkMpOhjlyDoWf2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NkpHAdAK4bSBd/fK+25DC9Egq4jUa32E+759mAKcA6fomtUOkLF82BT1EPpm5AM4q
	 9LGB5GO1/tfBSEPlAKFD2J0u4mUoczY2yESMRW3Ole4kjrTrFFGn/UpDGIPT5O2w98
	 GcA1AB4LQMxvu6yDvEumnhavuFqFA/malEUxvTgdZ3ntUns2kuJ7r03+z+qdY9exjt
	 0Tlv9fSkYrXnV8tEhBrFBkHtnHtj1Ed3fWQz8edyykAxJMAbX9YXr9D8UzP40tux1o
	 C1ZrrMP6+Voa1uZmCTaZ0QAIuGynAZRQwqD34wUkWGUCX15l4XcSQXUlfQZ0PYhPtv
	 Wld+8PyfNM1nA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D1E717E1010;
	Wed, 12 Mar 2025 11:35:04 +0100 (CET)
Message-ID: <9dca8772-6bc0-4105-98d7-e4f804b0d637@collabora.com>
Date: Wed, 12 Mar 2025 11:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250311122327.20685-1-friday.yang@mediatek.com>
 <20250311122327.20685-3-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250311122327.20685-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/03/25 13:23, Friday Yang ha scritto:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> To prevent handling glitch signals during MTCMOS on/off transitions,
> SMI requires clamp and reset operations. Parse the reset settings for
> SMI LARBs and the clamp settings for the SMI Sub-Common. Register
> genpd callback for the SMI LARBs located in image, camera and IPE
> subsystems, and apply reset and clamp operations within the callback.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



