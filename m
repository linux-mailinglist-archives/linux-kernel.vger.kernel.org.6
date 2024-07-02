Return-Path: <linux-kernel+bounces-237861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B5E923F11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4D11C21E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945019F46A;
	Tue,  2 Jul 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCxxHH+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9316F0E0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927350; cv=none; b=KxEF3I9YUTIB8W98C5gH61YPQSTjVvdTWOOpsboQ9fDASGSw965XvSRAsMrvI0dqotATFeTBaImXMv61cCQJUkN0UI/bS0yny1RkxKDmbI4Ock1J9bxh+PRBVUxQALn0iTfh67fjyNL8Iw+3Bmf+u/lS7Ie2DCNA8PIUoHWjdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927350; c=relaxed/simple;
	bh=a7AM0KEf+jQoBSJOJWM4gD6fd0KNahIDhF3fxcz0q+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NugyHCGJXDzcFCMZBagpDCXVqiAizom8QRZ8L27rZblerbcfCJkdQBRpMOHBfuDAe6w+kfgItgKc8YmixCCEXorhDWzsOqo+tImP6grlso8Wpsav1UI+WxJyCZhtLln5rhffgThflcgm6LMllcF5NhJnJ1z7P0TVCIk5gIyyfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCxxHH+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF3CC116B1;
	Tue,  2 Jul 2024 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927349;
	bh=a7AM0KEf+jQoBSJOJWM4gD6fd0KNahIDhF3fxcz0q+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PCxxHH+YzNjda2lF1wB7wkNpdvAkUEXOnigPLRNjqS0sVghPBMK42agzgfg1RXnnF
	 AiR10wkDzCsCfLP4km8ojSpAI3LON6bgNyzzsK9cTZVIVBlrBM2CYZrF0QCATs5efb
	 OhBLaBUcPbidYeudN8T3O4o860J5mC9b2hnNdydIunNgoRzbiwkY2S3xj0Ba0puaLr
	 Ff1L37AFLF9kAJheCXvwll7FOuFweVRAtocq9VpAYO4Inq84+yCEFASkMGHQtTOtMd
	 qaGWFICnbRV7iQBiMIxOgoHkpSkSNZARRENTL+ZQU7eIxXlRzk0EmOBMpLjVUIjgNt
	 2UwsHLQQP0c0w==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240629-rk-hdptx-compile-test-fix-v1-1-c86675ba8070@collabora.com>
References: <20240629-rk-hdptx-compile-test-fix-v1-1-c86675ba8070@collabora.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Select
 CONFIG_MFD_SYSCON
Message-Id: <171992734651.699169.10657232164142336775.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:05:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Sat, 29 Jun 2024 03:26:58 +0300, Cristian Ciocaltea wrote:
> Compile testing configurations without REGMAP support enabled results in
> a bunch of errors being reported:
> 
>   ../drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:569:21: error: variable ‘rk_hdptx_phy_regmap_config’ has initializer but incomplete type
>     569 | static const struct regmap_config rk_hdptx_phy_regmap_config = {
>         |                     ^~~~~~~~~~~~~
>   ../drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:570:10: error: ‘const struct regmap_config’ has no member named ‘reg_bits’
>     570 |         .reg_bits = 32,
>         |          ^~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] phy: phy-rockchip-samsung-hdptx: Select CONFIG_MFD_SYSCON
      commit: edf9e04955d2387032beac54ebf20b43aaca2adf

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


