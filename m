Return-Path: <linux-kernel+bounces-241650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2253927D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0151C23523
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A281137772;
	Thu,  4 Jul 2024 19:11:06 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D254660;
	Thu,  4 Jul 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120265; cv=none; b=YtDaH2lCf2LTxkW+l5vCmEVL/8zXgYKc4+rekdjaKkmDp7QO7/IUk6L4yCprjmsY3J6BwUAeTb63Xd2Y/SmcIMfRdcJ5CqPeMGErCTcbLg9Jd7VhbnF/WhIBLU3AzEXUvVtCnxAeQcan6J4SfeqEhzJWZkKXJHyPrQt9w3JkyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120265; c=relaxed/simple;
	bh=GC54zaM/PYXMfHoVbZtXtQTY4Xu28HJXdk3ydaIDFtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9668diZSNQL763n7whNq9lKbSZBZ8Y1eBzw4OjXnhdZrbOlC7AwnO0RoZxwUak0hO41bwnVq4hcuSbcVF7+nLLwA55+hsH+Ndf135yoP/FJaIca/r158gfh+MV8kp7J40oFAmACTvSFuW6MXN1jr3w2G25e842s4DMQO/uceC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPRr5-0005yl-2S; Thu, 04 Jul 2024 21:10:55 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/9] arm64: dts: rockchip: fixes support for Lunzn Fastrhino R6xS
Date: Thu,  4 Jul 2024 21:10:53 +0200
Message-Id: <172012023331.904079.9875958937623810307.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240630150010.55729-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 30 Jun 2024 23:00:01 +0800, Chukun Pan wrote:
> Changes in v2:
>   Separate commits for regulator and supply changes
>   Separate commits for R68S Ethernet PHY changes
> 
> Chukun Pan (9):
>   arm64: dts: rockchip: fix regulator name for Lunzn Fastrhino R6xS
>   arm64: dts: rockchip: fix usb regulator for Lunzn Fastrhino R6xS
>   arm64: dts: rockchip: fix pmu_io supply for Lunzn Fastrhino R6xS
>   arm64: dts: rockchip: remove unused usb2 nodes for Lunzn Fastrhino
>     R6xS
>   arm64: dts: rockchip: disable display subsystem for Lunzn Fastrhino
>     R6xS
>   arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
>   arm64: dts: rockchip: use generic Ethernet PHY reset bindings for
>     Lunzn Fastrhino R68S
>   arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhino
>     R68S
>   arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: rockchip: fix regulator name for Lunzn Fastrhino R6xS
      commit: 2dad31528de9ea8b05245ce6ac4f76ebf8dae947
[2/9] arm64: dts: rockchip: fix usb regulator for Lunzn Fastrhino R6xS
      commit: 9e823ba92118510c0d1c050b67bb000f9b9a73d7
[3/9] arm64: dts: rockchip: fix pmu_io supply for Lunzn Fastrhino R6xS
      commit: cfeac8e5d05815521f5c5568680735a92ee91fe4
[4/9] arm64: dts: rockchip: remove unused usb2 nodes for Lunzn Fastrhino R6xS
      commit: cd77139a307fbabe75e6b5cb8a3753e3c700f394
[5/9] arm64: dts: rockchip: disable display subsystem for Lunzn Fastrhino R6xS
      commit: 2bf5d445df2ec89689d15ea259a916260c936959
[6/9] arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
      commit: e261bd74000ca80e5483ba8a8bda509de8cbe7fd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

