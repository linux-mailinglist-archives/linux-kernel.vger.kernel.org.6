Return-Path: <linux-kernel+bounces-553056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B942A582E8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE9E188E30C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CF1A00F8;
	Sun,  9 Mar 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d3oSvCHS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AD17A319
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515017; cv=none; b=ucAHT+KZNDLywbCD4WYuDmlythGTUmx3XG3ONBuDukF/clSRlu5ID3pUwUoOSlqBZaac9JvSV/SNPqL4n6s0pXCYZvuzFS1c/YlaVH7DlMSWa3tpeVr7gKwh+mEzVit6kARCnfGR8deZqCYD0HAkF20uL+112iHArEL/GOq5xSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515017; c=relaxed/simple;
	bh=d/sNiwmDwosR14KhyiJOFG26A3mxq5tUt5OjZfyGCYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz8WlvYHQ6Jmew6ON/UbYdlI1pfk8QX20l4p/Ykoxz+RCIQTiflMh3a6XzTxWOUap4mkiEe6UVAobTZed30rR7FojTxqWMOrU5WV9UkMnXEp/SFRzpoIEE6tctQfm9HQCRV6d690D3NZ2uikdSO/Jms4Pu3FyTvGqd4Q9fYiii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d3oSvCHS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741515007;
	bh=d/sNiwmDwosR14KhyiJOFG26A3mxq5tUt5OjZfyGCYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d3oSvCHS5cB/kc+sh08WU4QYk686sVu5viglEkz1Dpz4jFk4pz2M6yCdDFoVrUGMp
	 mzkmd2BY7dwnh5wYCfZs1XwPdJPgWNylmHPMRYAXEQ77KPrp75GOXknvQvr9yZm4JW
	 kQcsyFX2VwJ+jrThmHCUUugIWVdagFfNHGaGmHVwWx5bG6PZLAVBqISEcaf6f2D/dk
	 V0z2ACr4SIBdKsV4zJGe8twzBVmFtSdKOZ2S87Gl8Dm28LE4e2bGyZKwLEaiKCpaZt
	 dHK4JwKf1UFN6dRfNcZBEwnp3M5cq77OTG9s6YIK02fkv5IrB5gWd9uzu0LI02y+1T
	 /+k0mG/Ze2oKw==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 58DC617E0B25;
	Sun,  9 Mar 2025 11:10:07 +0100 (CET)
Message-ID: <22142c86-c8b5-4427-9764-a7daa4a005b1@collabora.com>
Date: Sun, 9 Mar 2025 12:10:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] phy: hdmi: Add color depth configuration
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-2-35087287f9d1@collabora.com>
 <CAA8EJpqYE1drM6=C0AwPZ-e5RkWqjMTpWQiwhA64qby1mmVL1Q@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAA8EJpqYE1drM6=C0AwPZ-e5RkWqjMTpWQiwhA64qby1mmVL1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 3/9/25 11:16 AM, Dmitry Baryshkov wrote:
> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> Extend the HDMI configuration options to allow managing bits per color
>> channel.  This is required by some PHY drivers such as
>> rockchip-samsung-hdptx.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  include/linux/phy/phy-hdmi.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Just to confirm, are you passing TMDS char rate or pixel clock for
> DeepColor (bpc > 8) modes?

It's the TMDS char rate, but we still need the bpc info to program
CMN_REG(0086) in PATCH 12.

Thanks for reviewing,
Cristian

