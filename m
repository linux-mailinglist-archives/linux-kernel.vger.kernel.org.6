Return-Path: <linux-kernel+bounces-370053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957109A26A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A44BB28D60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A41DF740;
	Thu, 17 Oct 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqQ/9DxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97E1DF73A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179094; cv=none; b=CICCxdOhg4sgNPwakFiuo/1bXEvA00MqjsPOOeWmQIVfNbHp40A0Y1lLayaVN6Nu2kBIISxhxCgICxh3sJ5/oEpKx9QUBEHc+8f0cPP6fPNzO2P1vtKaMS7eJQWyW8/oNc6rutSE0RTyyaz+iWYg9O7mn53kEI8thL0MmWDta+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179094; c=relaxed/simple;
	bh=ECx1lDXvwWS4376i+gg20ZVRZy7s1XIM5Q1ERrjIGCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hyFY0+gsJvNRm9lYLaeA7ii/dbMtt+VxyEhZ0smUVcT0L3FDgSdj2R2yyWLWD+17ujngcS2f+JPtfuUVroGfSYp5RaF3aCNntrb9xMJOfdmR45KDoDrxsRkUhdPWW0zoPDX/bTfw78ZVZpXTqnDKAPeFmq33SZCyZcIJjoKZvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqQ/9DxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ABEC4CEC7;
	Thu, 17 Oct 2024 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179094;
	bh=ECx1lDXvwWS4376i+gg20ZVRZy7s1XIM5Q1ERrjIGCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eqQ/9DxZA0gG6PokB+PlBPossYFi43fxJu9nthmCv/TAHIQnlHEKI93duunau9a19
	 03AK6FZaFcDj6/20O0U9WJKhgrQriK/lwrBjHA23/GhKnv8vyZHUpoj8jWaBso0bUL
	 cp3wtwo7QMCWSnjFDcxbrhnOJIMpV+8eR7aGT4t2fBqhkzqoBuuQRHBKZHm21cJGsc
	 vY1AzK5N7MxcPJRinq5aT0FBnkpzn9xmLnvKwyvpbAvzh2NdaTr6QWNuU3mmML1QDP
	 wY4yYT5lX+zw7/QaK2Y1sqQS3zJi9QDtlIPevmf70AIF79yqJxLQSNZshssVO0gQGe
	 S3Y2wt833M1OA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
References: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Depend on
 CONFIG_COMMON_CLK
Message-Id: <172917909130.278159.917332740340210062.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:01:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 23 Sep 2024 19:40:16 +0300, Cristian Ciocaltea wrote:
> Ensure CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX depends on CONFIG_COMMON_CLK to
> fix the following link errors when compile testing some random kernel
> configurations:
> 
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_phy_clk_register':
>   drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1031:(.text+0x470): undefined reference to `__clk_get_name'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1036:(.text+0x4ba): undefined reference to `devm_clk_hw_register'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4d2): undefined reference to `of_clk_hw_simple_get'
>   m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4da): undefined reference to `devm_of_clk_add_hw_provider'
> 
> [...]

Applied, thanks!

[1/1] phy: phy-rockchip-samsung-hdptx: Depend on CONFIG_COMMON_CLK
      commit: d8f9d6d826fc15780451802796bb88ec52978f17

Best regards,
-- 
~Vinod



