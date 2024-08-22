Return-Path: <linux-kernel+bounces-297938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A160C95BF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11391C22441
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511916C684;
	Thu, 22 Aug 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1TDGObf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3937700;
	Thu, 22 Aug 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357440; cv=none; b=bmWYE9UNmvs6DtSayujVU3BK8Jz7iNX9L/Q8xgw9RAk2y1nYACEnGUhpNjJPkIlKphhkkjMMtn27dkTTqpupmbGBPPp4vO48jz16Wr5oKlkO0uehhQ1CKIMyTqw1hO3fJMGUQPY96/z2j955wF+ye/UVZpCT68pg5T7RolXPlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357440; c=relaxed/simple;
	bh=2olOYlEhDKY/G+FpnxPpgpCrGEcepJvMHQxLrsw8W/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PbT4yY3PHYAQMEqGjW8F6gDCfTKxlH4Vxp28ajJGgf158DdEJ2GjB/CGI3iIHYAbpbU31Ze7/+iF2MhbGKvWxM3rVDISpyfmW/pLY51r+1KoOWFljw6whCIvFiYBULP26+9BuPdOpEwqF96zBC/ivUbIe0mO6ioRUq5oOuXCyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1TDGObf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D61C32782;
	Thu, 22 Aug 2024 20:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724357439;
	bh=2olOYlEhDKY/G+FpnxPpgpCrGEcepJvMHQxLrsw8W/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k1TDGObf+aAXn1OujxglzxJQlV3Bz3WFbc3HLZxenhWD1IpY5nbFpZR7+Ly7GcFal
	 a9w8guKB2AlBOEWeES9e4neYFHuICvzBJph1BemUKvbYv18HRBtvQkQMvMGOLQPrks
	 yjlOBNskN3IowBUgHMMaKU3C0qEdayxqGDb5pyrngO/TsEpnf+IDYCYNput1c+X8Dv
	 P4rLv3X4oN2aeTlFDCi/sdG600nV48B15iY5cF5zlXgTHyNMAPNzd85NLGroT1JScJ
	 R3fbXf9q7eh1VBYsBxvsJa/5fFQw/U7nWYP2LIOxnaXV1iPEYJCIIhMVgH6SbIVreX
	 UYBIZAXF+zIEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1AA3809A81;
	Thu, 22 Aug 2024 20:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: xilinx: axienet: Multicast fixes and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172435743953.2469005.10916421971671295339.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 20:10:39 +0000
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, edumazet@google.com,
 michal.simek@amd.com, andrew@lunn.ch, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 11:40:54 -0400 you wrote:
> This series has a few small patches improving the handling of multicast
> addresses. In particular, it makes the driver a whole lot less spammy,
> and adjusts things so we aren't in promiscuous mode when we have more
> than four multicast addresses (a common occurance on modern systems).
> 
> As the hardware has a 4-entry CAM, the ideal method would be to "pack"
> multiple addresses into one CAM entry. Something like:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: xilinx: axienet: Always disable promiscuous mode
    https://git.kernel.org/netdev/net/c/4ae738dfef2c
  - [net-next,v3,2/5] net: xilinx: axienet: Fix dangling multicast addresses
    https://git.kernel.org/netdev/net/c/797a68c9de0f
  - [net-next,v3,3/5] net: xilinx: axienet: Don't print if we go into promiscuous mode
    (no matching commit)
  - [net-next,v3,4/5] net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
    (no matching commit)
  - [net-next,v3,5/5] net: xilinx: axienet: Support IFF_ALLMULTI
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



