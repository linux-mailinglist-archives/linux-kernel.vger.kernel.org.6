Return-Path: <linux-kernel+bounces-241580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFA927CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E396F1F2464C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951A13C669;
	Thu,  4 Jul 2024 18:01:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3513AA3F;
	Thu,  4 Jul 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116101; cv=none; b=r2qtU18ExYb6xhOLPX9ezyVbtk2TLHpfHyu29hCtyT1P7KwcL6i2SUArPZNR0aD8qTyd9unS49J6SKChONPKSuTSSdCie0/hcNzrCSPPRuge1C+Oj+Ckol35xM2+640bG28I1F0QXE1FlHY9nIgdEjmsyspFtvf39tNwAzlNb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116101; c=relaxed/simple;
	bh=43DBVSLzyHNXqk7Gd5ZjEIIfgtZDfgF2AQONSSZynik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwUWCpS3Gh1/II/0TtJQGfrUzbbfVzv67bxlS4LqfePSwnlzIt/59oMf/jfOhCWNsrelM2ztMDYdnn9zlOUOA/xLVb8zscaVS3ynvB0LSRhls0rcx9fbYzMi/1gQN+wlgQ+nqu2/KLEpIMmd0oR334jX0N+8ADhF5WFWuc6o2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPQls-00049m-Ll; Thu, 04 Jul 2024 20:01:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chen-Yu Tsai <wens@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dma-names to uart1 on quartz64-b
Date: Thu,  4 Jul 2024 20:01:23 +0200
Message-Id: <172011606369.897267.6481211960386426581.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628120130.24076-1-didi.debian@cknow.org>
References: <20240628120130.24076-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 14:00:43 +0200, Diederik de Haas wrote:
> There have been several attempts to set the dma-names property on the
> SoC level (in rk356x.dtsi), but that appears to cause problems when set
> on channels without flow control.
> 
> Quoting part of a previous attempt for clarification:
> 
> > Nah, enabling it for bluetooth is fine because you have flow control.
> > My issues have been on channels without flow control. Without DMA it
> > simply drops messages or the channel hangs until you close and reopen
> > it. With DMA, when an overflow locks up the channel it is usually
> > unavailable until the board is rebooted.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add dma-names to uart1 on quartz64-b
      commit: bf6f26deb0e84089700c1b864f643442e262e16b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

