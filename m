Return-Path: <linux-kernel+bounces-340126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ECA986ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A3A1F22399
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F11A4F2E;
	Thu, 26 Sep 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FVPK6/49"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4D188595;
	Thu, 26 Sep 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339618; cv=none; b=cIFuSfdKxke+RVTfaVYojuLVsg97hYdykwPRMPZ4FNMdeQi6jtjToMIDzEc2biTMIIL+eeoAP0kIHPwSzK4e/w8uLTsLmvEB02oMQ+t3HEyQdwFrKRb6f6RPQmfp6GeAy9lLgSylOJBeklDKgdtpcq0/Phlb0YTb+2QEw5z4cEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339618; c=relaxed/simple;
	bh=S6mhnUAdxSZYqgIm5tzaZNXTWNywHxWkmZKl1Y251wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugfwX0ndtcAucGPieYWsh2HCM31NclvqwHpWGDp2Z7dpqxK59BWYiT6BjsbgRU8JPhPTZZ1SQrtiQcbSYhMinsZqt2RqXf6AmUIex5MgS9L/efTEsQvG8DixBqlqI/ZAQrJy75Eb7XnqbB+4TYsWg7lS0R3RGxpJCMShbWvakds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FVPK6/49; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727339614;
	bh=S6mhnUAdxSZYqgIm5tzaZNXTWNywHxWkmZKl1Y251wQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVPK6/49EBKk+3yP4S0pE4zTe+I2NrFliN+vD9UE6G8k35VBezqT2yNH39ohqblFj
	 gnqrV8CU9G5hRJT/pPDfRF8Gg6kMcuix5bvALohHmtWVelaYtokCHpA6TaFZEZFhxy
	 jp2Dk0jI24vfNwkQPgpwsl98UXJHBNUBoXB6IbHYxnLp/tIOQcUUdl81jCjkOKEct8
	 kuAxyl4Jt77NMA6+6fPRgvXZLH53TF3A5BN1UdG8JTp6lcxVtYVzczT/+icVgmvAFC
	 Brg6QMctLCYzDLxXT0LydXsa5Cj2qBbK9sC8WSel7BojnnDhRV6WwCbjKn5Y2uwU3t
	 yQlA2D/5KGS1w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D5E917E1060;
	Thu, 26 Sep 2024 10:33:34 +0200 (CEST)
Message-ID: <e3315457-a969-4890-807b-50a4bd02a333@collabora.com>
Date: Thu, 26 Sep 2024 10:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: mediatek: mt8188: Add missing dma-ranges
 to soc node
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240925110044.3678055-1-fshao@chromium.org>
 <20240925110044.3678055-5-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925110044.3678055-5-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 12:57, Fei Shao ha scritto:
> Add the missing dma-ranges property to the soc node, similar to how it
> was done for MT8195 and MT8192.
> 
> This allows the entire 16GB of iova range to be used and enables
> multimedia processing usages, like vcodec and MIPI camera.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



