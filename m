Return-Path: <linux-kernel+bounces-552307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CBEA5782E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BCC3B6854
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951317A2EA;
	Sat,  8 Mar 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH6APekX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CB1779B8;
	Sat,  8 Mar 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406412; cv=none; b=LK7yQK2ObP3s99diygsXxuE3OOZN+ZPV3V+GdrHcLBdfXPfzvYHVAz1fzosXtR9o3/gZYe2byxd+6GcjBtydDAz4ituS1rF41gOqP4OP+XtJIgFYkvcc8ASAip+08b8S3/s/n/ERiWr90P3iVqg3gteIMU5UtargA/3uzY4fE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406412; c=relaxed/simple;
	bh=ViqGyPEeJggtd3m/P4z9rbC73RF+/FE79lcIusBiVL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kjaiiAyMuSGqoiBmORuoivK1jQKKANuQJnzHEFfH1fQGk9p4B34Rpfv5pdGV7bfPXnBBX+qI3fGLeTeltRzssLbvApyeYPx7CF1ub7fcC+3z0biEu0FCkQsmieE9j1TX8e+1u/wGjvqQJhREoR+pztISOToUO9uhXUYDMl4sqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH6APekX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C0C4CEE0;
	Sat,  8 Mar 2025 04:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741406411;
	bh=ViqGyPEeJggtd3m/P4z9rbC73RF+/FE79lcIusBiVL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TH6APekXKuw/VG3TzEaSv/RP5CcXVByMNkmR4M5vOsRuaQ9VUZHV7yw8OpTg2GeMZ
	 /+A+Lwr9Lhf1C4g5lLk+mpwc1GoPFY1re/pU2XDfgvA0HoINviD2F1HWnlVhR+P2zm
	 0xVcs1oCJFy9Gdw4bgL+/loTNSTiSEg1n4c8O3Yt7OjS5YnJ4EMluU4Q8Et4H8eQ5W
	 BjQOCPUavZ1uMI7F+f4JgG7sHxY0LCi+RX72Na5cH39COSDUtbcRpWwRgGe4enWET4
	 +QDfyAYowrLI/ujym3Lqyu7kFd21iaZ/cCYsggsgMJZPmLEchCAUZupTARRaWJ4cNI
	 jSFAXqZy+b6hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC6380CFFB;
	Sat,  8 Mar 2025 04:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: tja11xx: add support for
 TJA1102S
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140644498.2570715.14636868576802803016.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 04:00:44 +0000
References: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
In-Reply-To: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dimitri.fedrau@liebherr.com, dima.fedrau@gmail.com, marex@denx.de,
 o.rempel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 19:37:25 +0100 you wrote:
> - add support for TJA1102S
> - enable PHY in sleep mode for TJA1102S
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Changes in v2:
> - Drop fallthrough tja11xx_config_init
> - Address net-next
> - Link to v1: https://lore.kernel.org/r/20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: tja11xx: add support for TJA1102S
    https://git.kernel.org/netdev/net-next/c/5d7610577fd9
  - [net-next,v2,2/2] net: phy: tja11xx: enable PHY in sleep mode for TJA1102S
    https://git.kernel.org/netdev/net-next/c/5b3178c452c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



