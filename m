Return-Path: <linux-kernel+bounces-333512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864297C9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF25FB2215D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212519E831;
	Thu, 19 Sep 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BMfBjYxS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED721E4B0;
	Thu, 19 Sep 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751649; cv=none; b=CoKM4YLucrxVo8QAFCTlBGQJcdmztlSh4ulbup/xrQBFqHjwaSa1oy3zY2uJ95k4ijWHK+H4gldJj0rbug17/7+OEZtBJHjlZgNR0sHVqinRe+pH3X3d3iIXvn8nnElmLpgogPQR5Xj+QBkbthi98UG9UqDJFnXYKar/jI8BUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751649; c=relaxed/simple;
	bh=lVpBhjn/lwbFw1fgMeadNurIObhRHR8S3Xp7BExSnJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NF64T8tiy0KATi3BB2/SOrgq2nYzaggNx3KCUd7WoyupaFVPzv114jkiOlBTvoElM0FTCloNAtXo8K+s9EWfkWhMkY1lR9qkaDpfz1ngjngbiSShmJxckCHTTesIdkNrmxjvl14wlxiqU7Sx8u5Po5pPOGpT2+BViFNzFryBjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BMfBjYxS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726751645;
	bh=lVpBhjn/lwbFw1fgMeadNurIObhRHR8S3Xp7BExSnJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BMfBjYxSZUtylya1Dy1KCbuAOar8fp3lQNYaP5lzmtN4ADZ5OFMoSwyvV66BvUwUJ
	 FO0F0Lc/2v3lnr7zQYj0a1L7+kTvgKNcWWhejqNlFPQUU6QvdWuSVnZBR6zz51USIw
	 YkFQkysbTl/ZYYKPea7zEPvtp6yJqY3zQfOyUXGVzE+Yul9rXGk9YYauef8bXfrz9N
	 qnu5u1pqUYGMyVGRPcB4wMpd28Ncd/f75prTefG5Ktxd8O42LnunbWmwt6B6DvI4j9
	 T2ynEQIIJaS8O6f4kxFjiEiuN84HhwFB4f48vBMOiCEkRJmWBPO+5A0CTHzgSqltwy
	 LpVqf06RQ8vRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1D8D17E1516;
	Thu, 19 Sep 2024 15:14:04 +0200 (CEST)
Message-ID: <0a78959a-2d72-47a0-83f1-89065ff48d0a@collabora.com>
Date: Thu, 19 Sep 2024 15:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui: Disable DPI display
 interface
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Pi-Hsun Shih <pihsun@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jitao Shi
 <jitao.shi@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20240916162956.267340-1-alpernebiyasak@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240916162956.267340-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/09/24 18:29, Alper Nebi Yasak ha scritto:
> Commit 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183") adds
> a device-tree node for the DPI display interface that feeds the external
> display pipeline, to enable HDMI support on the Pumpkin board.
> 
> However, the external display is not fully described on Chrome devices,
> blocked by further work on DP / USB-C muxing graph bindings. This
> incomplete description currently breaks internal display at least on the
> Cozmo board. The same issue was found and fixed on MT8186 devices with
> commit 3079fb09ddac ("arm64: dts: mediatek: mt8186-corsola: Disable DPI
> display interface"), but the MT8183 change wasn't merged until then.
> 
> Disable the external display interface for the Kukui device family until
> the necessary work is done, like in the MT8186 Corsola case.
> 
> Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> Link: https://lore.kernel.org/linux-mediatek/20240821042836.2631815-1-wenst@chromium.org/
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



