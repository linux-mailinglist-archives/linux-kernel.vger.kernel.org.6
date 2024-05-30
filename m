Return-Path: <linux-kernel+bounces-195224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7008D4934
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC5A1F2142E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264E176AA1;
	Thu, 30 May 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="en3bq4pT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AF157E74;
	Thu, 30 May 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063423; cv=none; b=qpaNUlF5ybj0PreWUYO0yVakOSm802MQ690ObYc7iz+EacGWB/XL6Adg3kkCpl9YGHSQ5nOAENErQpG3y0w4kswJ6nhsWk0AE97UDBgDdFBTSKAMtbBbGG+mLDzaBemxRJTsFtovsChcZcmclUC0/gFdPm3xDWV1tBhCHP/AYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063423; c=relaxed/simple;
	bh=bwJjFeyzBTMV6+dpXNKXktvgWL+phVmXZH4aj9xRd3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL/NaPh6A8k2FEpQG7mF+Ym+VbqpJ9vLy6SpzbgcgISsIPdO32RdfLCCdWrUItDTqk4iOOK8kIj1CSmoBRjFIaNcem92qLVxGIHpnKHppRNV1yRGz4/tgBR86eg3VVqFiNwz4WDSuMxpR44vRflnbBNlgSOxpvXh61U70vtvx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=en3bq4pT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717063419;
	bh=bwJjFeyzBTMV6+dpXNKXktvgWL+phVmXZH4aj9xRd3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=en3bq4pTZ9qiSymwfShbESCLgG/446i3zs7x8XSG7XPwH0YJAVT/b+AQbZ/VdJBb4
	 NVT08gO+VHH6JCHBHnCMYwtoct5QLYmDw7/1iO4mABP8OE6q62m4G7moA2TOKy33CL
	 49Nphd7a6pGYyPLdIKfqWMd0NLLZ49l8hb6mRFqETEUK+Jq3yPtl0uG0Go8p1k4Ztm
	 rL57F6x/IzOLXxZsDqbYKz0ZBHnSFW0/m33GQa5Fmu90d92FwjKff1n2rAbOacDqPe
	 i2CM3BkqxM1+87oLnaQ0+shS1UG2ifg3YWBwX6zPTIWNGYKXa9xBRxuqFoYx4VfX5u
	 vYA9p/iuwZRsg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF91137821A7;
	Thu, 30 May 2024 10:03:37 +0000 (UTC)
Message-ID: <f833747f-71de-4537-861a-8758fa350846@collabora.com>
Date: Thu, 30 May 2024 12:03:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173
 GPU
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-4-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240530083513.4135052-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
> of the Series6XT GPUs, another sub-family of the Rogue family.
> 
> This was part of the very first few versions of the PowerVR submission,
> but was later dropped. The compatible string has been updated to follow
> the new naming scheme adopted for the AXE series.
> 
> In a previous iteration of the PowerVR binding submission [1], the
> number of clocks required for the 6XT family was mentioned to be
> always 3. This is also reflected here.
> 
> [1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a43c79c2a.camel@imgtec.com/
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



