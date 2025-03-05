Return-Path: <linux-kernel+bounces-547773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC1A50D68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD627188F9C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78C24FBE2;
	Wed,  5 Mar 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AULhPude"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420862580FF;
	Wed,  5 Mar 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209964; cv=pass; b=J49mv0Gm4eAkEUOamk7kLOuM9pVSjTm+j+PWOCtcrzcJvKnfi5UnCqDCOBU0kKOoBCoxiaPvIcnEWUiiy1P0weRV0awGeWeJvMnFa3UNFJbvPWT3amNovcEp3s0MXUBm93xx/oBiNZUlJk6bAftqBLjRl7ZxMVtQhPWcrh3ZxAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209964; c=relaxed/simple;
	bh=LMbKV6HLs/wP8Acj/14iSmt88yTJTNOf+1XkGmhdLiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djD9EaoGW+EsZNfFo6KF04Calh7BJy1dKv9xu7jsZ7xnxhaHLUoOjb7SaeK89rf8v+xLHMqWXaexl+dRGFicAjR3ZVZmFpfzPUrtv3Apkm7YCqh0wIxWIUtw1pXVpYSmTbuKdFsgnkrDAC7z0deL3238ZJoXtKmmiVKtXDNFbMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AULhPude; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741209935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GL2SGXZ8q9mgFZcQeVJ59+xbCI18dGLBsFrz5HBtxii7m7macFyQPIUFGDWMKSn0XFEfCZRiTDrFH21ulZmT3cLupRZU+bH9mF8BfV9hgkTjAFMU/D2lsVhr0CViY2+26C8SkKE2oTJLbMhEEOGSpSI1Syl87oDlHQ7VH5m9yvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741209935; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S2UIo1syohylbzOnft0Fm8/vENKskSYrX6KC1r45rPk=; 
	b=F2GPIQb/iE/9eFe2KCfoiF9GunvIhP3kjlfm9Doen5WOZdoq3cjjCNu46RpffEVd+VoCUcug0vjjqAIQL1LQIK+gAcZSFyRpYy3zB6/zh3rpzQJFWs5Atyx/artQj7BJQbr0Nh0AloB1ODx/KtOKoeBAUQgpJ2DOYlNEoKgcxUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741209935;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=S2UIo1syohylbzOnft0Fm8/vENKskSYrX6KC1r45rPk=;
	b=AULhPudeZhhRknxfMNgckFThfnNsjSw8gbhG3n3n2lSQvMOoFvIrYcJsb6f4Irdv
	F7kKZ/M/YZiGX6sIXvm1UDkYj5rSO7uRXKTuKEs/gvdRXqcpo9tDk8OvXgzL369364w
	PTTGQ1KFxZKTZ/JutPDYkG6xNUAEDE76aedVlRvU=
Received: by mx.zohomail.com with SMTPS id 1741209933733237.76483107649017;
	Wed, 5 Mar 2025 13:25:33 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 05 Mar 2025 22:24:27 +0100
Subject: [PATCH 7/7] arm64: defconfig: Enable Rockchip SAI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-rk3576-sai-v1-7-64e6cf863e9a@collabora.com>
References: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
In-Reply-To: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The RK3576 uses Rockchip SAI for audio output.

Enable it in the defconfig.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3a3706db29822036d25a7228f8936e2ad613b208..d503b5de2d2efb6d66d7fb8d7bafc10c0cf37b36 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1002,6 +1002,7 @@ CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_X1E80100=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
+CONFIG_SND_SOC_ROCKCHIP_SAI=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m

-- 
2.48.1


