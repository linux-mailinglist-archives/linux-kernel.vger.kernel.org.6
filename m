Return-Path: <linux-kernel+bounces-282009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DC94DE37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDAB20F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8934713D2B8;
	Sat, 10 Aug 2024 19:15:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE64AEF2;
	Sat, 10 Aug 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723317359; cv=none; b=s4Mz0Vg+UbqK/uDmVMC24tyMQuGpZVgJLBXuitFFC52MIzppfwTAc5Q9PFOXUK5lj4GKSqin+J5dxlKWbnBGUnvY5scTIzZIlWEv9+5EU6hLBOlAkbaCPDPbCAjJhlL7djpI5QCOe9ZJ6uwI7AlDB1/r7ExYE0DdDNLbEhYsr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723317359; c=relaxed/simple;
	bh=akeQkLeZq2D6l135IlMUW7VzJAIzqUwuLLHpuvyNfxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzZWfnmRu8RyLcKM4gbWMCLktUb1tWJn/BVQMMhRCtn40nTlciNpZDj8rehfIFN+Q4g+Ebvii/ftLtdSHnmZ2PCdEcCOPSAjKlRTKecnVO5Drmlw8Q0bLNV9vfb0LUZfqVSr6a1zIc7kGaFJjE34/ztYcebOTRGhDYHIhArweMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1scrYx-0006Wd-Sw; Sat, 10 Aug 2024 21:15:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Florian Klink <flokli@flokli.de>,
	Rob Herring <robh@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4] arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5-plus
Date: Sat, 10 Aug 2024 21:15:37 +0200
Message-Id: <172331732519.282332.134829187911746949.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808103052.1894764-1-flokli@flokli.de>
References: <20240808103052.1894764-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 8 Aug 2024 13:30:47 +0300, Florian Klink wrote:
> This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
> rfkill node for M.2 Key E WiFi on rock-5b").
> 
> On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
> enable signal inside the M.2 Key E slot.
> 
> The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
> rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
> node referencing RK_PC4 on &gpio0.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5-plus
      commit: 8e0eb3dea9739cc5ada7a2d10319734dbbd2699c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

