Return-Path: <linux-kernel+bounces-228655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB729164BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5621C20C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AF14A4C9;
	Tue, 25 Jun 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0BjG071"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953E149C41;
	Tue, 25 Jun 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309632; cv=none; b=JBjw56NsO5eYYLdkeWHuNsXR7yvcn1N9lA0FcX1krLPuSMc6SYvBfA1ltZ2s8SIKLpaKhjfGzAe8ICJnU1SaXBLLM1ArCh14XGAR211dqfbcMlEyPhpe0HuYyo2/kb4RL9b0mszr0u1uQEHAgCDPYbjcOWnKRVvv56uoMohmdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309632; c=relaxed/simple;
	bh=DhuCZNKDAvoxF5E2kVpU185CoWKjC9CR1dMA3XS5PfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2Q3LHdV4RY6JLheZs+MbiogNVR0+Cv9NzdJV/CYASbk9zYdJsleWQomAwTRt5BpNWQ4myC4f+SEJabUaB6sm6Vl1OThUHZPTD5waNahYJ6mDSKckBLwpS5ZV37/iCaG3+1ffrRbRa0q77iKegtuG/fG1zrJ7zOnYVMxMS8Qra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0BjG071; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA4F0C32786;
	Tue, 25 Jun 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719309632;
	bh=DhuCZNKDAvoxF5E2kVpU185CoWKjC9CR1dMA3XS5PfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0BjG071QPIFIc9GiibZw1nkStLzz0jRWakJ1w4BRcdh8DVZb00EdEiZ90qMctWv/
	 zBNL5M99djTiTAuoJUIfi0fOwM6L8eQrsXhASb7nS4hYO1t80raLLzz89C8dQz1ker
	 11eu+io/s9Z/0Y8EsVg7vBzsPNZCes8Hf/bxTV36Rw+6q7x5EGXoVlEeN4/0Bh3FUR
	 gL2xH44SIi1iNPyUTuO8ZWGNYycTLytc87BNOYBB3E0araccIbJ2FhD9URd9rLXDof
	 KpwwMBvjoCGwx/HYSag7n8PpKlsTQC8cxtIPZS0ZN7yJHLFNm6zBJK4yNMtM/Aqdfo
	 xvWvt2X40g5yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D64F1C54BD4;
	Tue, 25 Jun 2024 10:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] net: macb: WOL enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171930963187.32121.3291379970254335785.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 10:00:31 +0000
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jun 2024 10:27:31 +0530 you wrote:
> - Add provisioning for queue tie-off and queue disable during suspend.
> - Add support for ARP packet types to WoL.
> - Advertise WoL attributes by default.
> - Extend MACB supported WoL modes to the PHY supported WoL modes.
> - Deprecate magic-packet property.
> 
> Changes in V7:
> - change cpu_to_be32p() to be32_to_cpu(), eliminating unneeded conversions.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] net: macb: queue tie-off or disable during WOL suspend
    https://git.kernel.org/netdev/net-next/c/759cc793ebfc
  - [net-next,v7,2/4] net: macb: Enable queue disable
    https://git.kernel.org/netdev/net-next/c/3650a8cc5b34
  - [net-next,v7,3/4] net: macb: Add ARP support to WOL
    https://git.kernel.org/netdev/net-next/c/0cb8de39a776
  - [net-next,v7,4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
    https://git.kernel.org/netdev/net-next/c/783bfe279e54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



