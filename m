Return-Path: <linux-kernel+bounces-335580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2397E7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40BA281C76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08D19409C;
	Mon, 23 Sep 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yc4yh4II"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882E2F2D;
	Mon, 23 Sep 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080704; cv=none; b=ZZrYJEJIYTqq9FFKOovlHaYLAApEMpjF+LxU5nbzd/JWCC41IZVm2BHQvHO8vKEaE6MJLGdWljWRJlEc+s2sABSN+fDm+9Rkehwf+YoqbO+o4PPcgT6afLLAyal1XpeiFbwKNaeUuA5TCS4kf2kxbccyqnIk0VIpGZyUL22JRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080704; c=relaxed/simple;
	bh=rcivXolReutd/1EqUvrpD3Vx/mkT+TgRwYLp20qEAFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMqdXwm9acEpCGMCx1+BR6zAhQzWzEYhCQThfGTEgqqijznl/ePFo0z4V/vgwcD3VB0lo9+nBwppxWq1P5fibWYJblu0Uk/QoAj++vZfA1VOafOs3u0Wbb6V/HjbyajSms3qcbDe1TAUO9bkQX4hfoWv8athtLgdggCMi+FbNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yc4yh4II; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727080700;
	bh=rcivXolReutd/1EqUvrpD3Vx/mkT+TgRwYLp20qEAFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yc4yh4IIsBOEZ8VMS85XjlBoF93yTvLouVXm+ZJRDYk4ufZtVgvE2QZvOVey8j4Yz
	 39B+x6EbQFr4+Nmqnx7BMgqzq9wnQ5H/Aw6YYuLQuARSI2miIbjsX0Uyq19+ri2Ic8
	 YgzfivkH9sHlcTUNxZwHh6EQP7sfFCr12AdJSdoiNzL6F8U0YIhHa0l7e6JfJHWoE9
	 tWaH+AsYq4/5K2wS8MkDOySW7M/tT63ugKatzUNj7wuNh0sJSH9d/mXo0BvQDMwwlr
	 BvC9I1zp4fucbr2DLmAKE6xi76HWw1lARPGt3iml6xw2qTUugYKRTmAN4BDoK8MX2i
	 oX9Mk+szMRFhQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F26E717E1060;
	Mon, 23 Sep 2024 10:38:19 +0200 (CEST)
Message-ID: <3f5055ad-924b-423e-88a6-9e5d46cd8c13@collabora.com>
Date: Mon, 23 Sep 2024 10:38:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: mediatek: clk-mt8188-topckgen: Remove univpll
 from parents of mfg_core_tmp
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-3-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240920134111.19744-3-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/24 15:41, Pablo Sun ha scritto:
> Same as MT8195, MT8188 GPU clock is primarly supplied by the dedicated
> mfgpll. The clock "mfg_core_tmp" is only used as an alt clock when
> setting mfgpll clock rate.
> 
> If we keep the univpll parents from mfg_core_tmp, when setting
> GPU frequency to 390000000, the common clock framework would switch
> the parent to univpll, instead of setting mfgpll to 390000000:
> 
>      mfgpll                            0        0        0   949999756
>      univpll                           2        2        0  2340000000
>         univpll_d6                     1        1        0   390000000
>            top_mfg_core_tmp            1        1        0   390000000
>               mfg_ck_fast_ref          1        1        0   390000000
>                  mfgcfg_bg3d           1        1        0   390000000
> 
> This results in failures when subsequent devfreq operations need to
> switch to other frequencies. So remove univpll from the parent list.
> 
> This solution is taken from commit 72d38ed720e9 ("clk: mediatek:
> clk-mt8195-topckgen: Drop univplls from mfg mux parents")
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



