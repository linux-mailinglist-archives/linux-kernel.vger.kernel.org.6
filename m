Return-Path: <linux-kernel+bounces-524035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CEA3DE41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC696188E8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4581FE46D;
	Thu, 20 Feb 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fx5+gHue"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44011FCFDA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064755; cv=none; b=EmXb5s7WngokR8HPcEvuLn/QLql32sXaVDaMF4cm/b44vevmf2aOas7tMiSRF+yNNtg4Mihw3zXSvBVhI13G5FaK6YK32ZWgs/RZ9JnB/lqHrxjI1IkErbQOl8bxDsef+A+g9w2IxCUoq5KsPxmx5H0Xq4AhzwUUpNEPCsK25Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064755; c=relaxed/simple;
	bh=q+rI1MFGx1dmzUkCsd87R8AaxLfHoGvv+Cb6RXBBXvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+Zrts7XycJoyl2ZrMg3RjL0qCTlM+YoRYhAgtfz9t1L9CFXViqloECqvBdx2vfZmfkGPHAbMjEDBrM5qqu1txM0LjOUq5bYX4wWm/fcC2yVXFr4cEJHTfkyx14eJY6Dtx7EpLza498k2QiH4Qw8pQgRdRx1URFofPg6lGLyhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fx5+gHue; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740064751;
	bh=q+rI1MFGx1dmzUkCsd87R8AaxLfHoGvv+Cb6RXBBXvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fx5+gHuek4r6O15kJIdNiY8QLR8+QYAZewk/yQq9aAnvCyRYpmG/UWaON1i06z2aQ
	 TLUMvvJUzO6B7s46LFKcheLn4Z/EBXrD2IgUQNzDTMIVIv7DfMoP0uN6KXdHMUQyc9
	 /ByHxhbKp/hBSgmd+Vb67byCfX7kWU2krqZh9wHLN7p4BCGWIVer7E3tEMg4wB6T7d
	 If/ujMqhJAkOYxNDNHt1ga7g/am38tK4YmUwuHgSRTqzNjkv/H8ejvqeLQiuSUEGZN
	 CleBAjd3/4LTvz8zaqduKNZNzsFMSXZTFMXqT2hmMZ3CCnxyiu8EwdTiDb0AVk81b8
	 uUn3f8PFzlsHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 60DC717E0E95;
	Thu, 20 Feb 2025 16:19:11 +0100 (CET)
Message-ID: <10d4c956-4f46-495e-b91f-adf69a1565ef@collabora.com>
Date: Thu, 20 Feb 2025 16:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Add extra entry for
 MT8395AV/ZA Genio 1200
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250220-mtk-socinfo-genio-1200-evk-v1-1-a683ad028bc5@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250220-mtk-socinfo-genio-1200-evk-v1-1-a683ad028bc5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/02/25 16:02, Louis-Alexis Eyraud ha scritto:
> The Mediatek Genio 1200 EVK P1V2 board has a different socinfo match
> for MT8395 SoC (commercial name Genio 1200), so add it the driver.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



