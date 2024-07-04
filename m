Return-Path: <linux-kernel+bounces-240727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378999271B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80F1B21916
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273991A3BDB;
	Thu,  4 Jul 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RJ7VLSBu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8E1822E2;
	Thu,  4 Jul 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081796; cv=none; b=IsS0m1tVu49/qSe/MzLtA6klbwmnRo7Hdtm8M7TiEttgpuoxhRimkO4cADf6C9zFct/HrzFaKV7iJzt1oq1g8xYieCdmOdyyvdTZaLD2Cy2mo270pj5ORw0fwkkCnyLuoO+WNgw/6ADBeM4okMBfWJsTXC75hXZMz+Y6QevmkS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081796; c=relaxed/simple;
	bh=+1mAHgPt3THuLbRBMxm88DU/XThtegA8e9GHYVcJVnk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U0TcISNopitWmUdA6OLH8EeoE6tSzoAcfCOlEsvpYTY6fzb39x8wZoC0Rj5qrBAXTlZVGygkQ8ZN1HT353cOWnTlY6keYg5JCl59p4YTxKX69LGsoqgyTrviQaf3+tgzULEXaZur/c3kwiZbVhO7qYzG6xvP+E1E5SYs8CJFRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RJ7VLSBu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720081793;
	bh=+1mAHgPt3THuLbRBMxm88DU/XThtegA8e9GHYVcJVnk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=RJ7VLSBu70E4JQRr8j/FTeeGrJ+6X7wJcoARYxTLPL8lZTnJ4MCuDJlZhdtbkkQCB
	 6rCyD8yztQlLHrJ2bsPSHiYBveTKrY7WFM9fTSItwyinCLM4vx5UPP5uThlpLkQe+z
	 phAvHnj9Ux6sWNYJJu5bEnDLblXi6KYDWbK/EWwy+55dERsxki7uPPemYkpHjvQKuM
	 HbJxUTJUgX6xoXvKEYJMM0IPGbGLYsVPqGIg60xk4rsMNaUJCEL6dfb96BXWS3j60Y
	 LFMQgwbQ8+d2HJhkBZe4lhnTCDnUMpXxz+eQa3pYgiJUQpgSiaxgfq9M1AhbH7OD4w
	 L+CIbs+QkgSew==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2825637821A8;
	Thu,  4 Jul 2024 08:29:52 +0000 (UTC)
Message-ID: <4e7b019c-f685-4370-9f67-f45e0bcbc626@collabora.com>
Date: Thu, 4 Jul 2024 11:29:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add clock provider support to Rockchip RK3588 HDMI
 TX PHY
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
Content-Language: en-US
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vinod,

Please let me know if there are any additional items required for this
series to be picked up.

Thanks,
Cristian

On 6/20/24 3:36 AM, Cristian Ciocaltea wrote:
> The HDMI PHY PLL can be used as an alternative clock source to RK3588
> SoC CRU. Since it provides more accurate clock rates, it can be used by
> VOP2 to improve display modes handling, such as supporting non-integer
> refresh rates.
> 
> The first two patches in the series provide a couple of fixes and
> improvements to the existing HDPTX PHY driver, while the next two add
> the necessary changes to support the clock provider functionality.
> 
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Heiko Stuebner <heiko@sntech.de>
> To: Algea Cao <algea.cao@rock-chips.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: kernel@collabora.com
> Cc: linux-phy@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> --- Changes in v2:
> - Collected Reviewed-by tag from Heiko on PATCH 1 & 2, and Acked-by from
>   Krzysztof on PATCH 3
> - Updated PATCH 4 to make use of a forced consumer put in
>   rk_hdptx_phy_power_on() and rk_hdptx_phy_clk_unprepare()
> - Link to v1: https://lore.kernel.org/r/20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com
> 
> ---
> Cristian Ciocaltea (4):
>       phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h
>       phy: phy-rockchip-samsung-hdptx: Enable runtime PM at PHY core level
>       dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add #clock-cells
>       phy: phy-rockchip-samsung-hdptx: Add clock provider support
> 
>  .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   3 +
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 206 +++++++++++++++++----
>  2 files changed, 176 insertions(+), 33 deletions(-)
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240617-rk3588-hdmiphy-clkprov-f05f165ac029
> 
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com

