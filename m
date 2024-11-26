Return-Path: <linux-kernel+bounces-422217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267879D9600
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B97E283973
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D01CDFA7;
	Tue, 26 Nov 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQmhsDtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687867DA68;
	Tue, 26 Nov 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619416; cv=none; b=SYurdyqK/Vxsa0p6tePEQg1yuEvwiwEDHgRTa7G1r0FGOeAx84YhkpE6k92+A/kEB1uLNwhaYDrR8u0VHhehmOU0lQXjRo7pGrsg5hu+aO368gC81tkJaqJIxRqSg3+MNzbD/2uOlN0kK7zA+0krZPTuVP/oRN/5lgz/Y45rsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619416; c=relaxed/simple;
	bh=YSELgeIz82RADEql14/t1EXb+6i2e+P7ABdlJAwN9VE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JvqmJEirhpNr+it1bK3OzGqq2h96nbm69hMuAjBx66z4gl5H3naxJCp+6niwIzydH8FwfDu60j/0bUeVYC9ExQSod2SuZT3R/G1U9ByRvIJ98hMA2GFnHVud8V2MQmjoXyV90IrzVuCQMPjUe2ZbOa8ysF9jEGsocJ2Af+R1hHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQmhsDtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF89EC4CECF;
	Tue, 26 Nov 2024 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732619416;
	bh=YSELgeIz82RADEql14/t1EXb+6i2e+P7ABdlJAwN9VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rQmhsDtGHgZCzvVzZBt7fn2ztuz20Lk+A/h46VRqrCaegCebr1Zbxo2NZ+Ob0zdOA
	 UWzJpoSSu2iBALpetVFov1tDH/mgIgUgbGniciwikmzY+tueNM/DKk5WSAVk+1ACFU
	 +tivys9qA0izpv1MFc2g/RydJfJIBBqmEiXPfLSuTFOwx75/QdQ61Qwtm/hLd1FG05
	 tlaekR+3TJhzBcjRxfog2LP9GafXY1R68O+XECtmeLO/5DBPxFrf3FrXuiR6h3c49B
	 2jUtq4QF/6SGbPAxM7hhHuEbEr8gWRfsaHL/V8zDY2EInxH6UxD1FqfWHNUI9xGfEi
	 WXegTKljtYkAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00A3809A00;
	Tue, 26 Nov 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as
 broken
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261942880.352444.541353075631044825.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 11:10:28 +0000
References: <20241122141256.764578-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20241122141256.764578-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexis.lothore@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Nov 2024 15:12:55 +0100 you wrote:
> On DWMAC3 and later, there's a RX Watchdog interrupt that's used for
> interrupt coalescing. It's known to be buggy on some platforms, and
> dwmac-socfpga appears to be one of them. Changing the interrupt
> coalescing from ethtool doesn't appear to have any effect here.
> 
> Without disabling RIWT (Received Interrupt Watchdog Timer, I
> believe...), we observe latencies while receiving traffic that amount to
> around ~0.4ms. This was discovered with NTP but can be easily reproduced
> with a simple ping. Without this patch :
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
    https://git.kernel.org/netdev/net/c/407618d66dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



