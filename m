Return-Path: <linux-kernel+bounces-432541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2A9E4CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5C284A99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF81940B1;
	Thu,  5 Dec 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzq/xacw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90754193;
	Thu,  5 Dec 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369431; cv=none; b=RBmAlluW8jaM4AXAXnfbd6vo0GUZaTN9zC8doBV9/mnFc3k7jKRr5uq2s/5eN5v9c/Fctd+1RdsL9VgfwAOsWhjsqlBtpMD1AtHByZfUCnF7Ia1wgeXJVmiv7XzEgp/e2zC3zakPpvo4FUnmqQcKYLURn6w9MkgkWu2Ymy+LSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369431; c=relaxed/simple;
	bh=BdRARaFlEBuohTOisqo61SQo2tlA2TV63iIjSPhw32E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LRh2P7XzevXNILTEjlrlzg1Hw242EoBgL0DcMkzbwJqkXCHamxwd7x//O4d60coPn7U7L52ggyUfjRwZfqXGKPMpRh6f5mK5GsV9abLX7qL+jS+tkDa4zAH9If3gQs2YEMoH+n0MSsga4qecYHZnhh1jEIp17wcB25V7Frdu9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzq/xacw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228EFC4CED6;
	Thu,  5 Dec 2024 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369431;
	bh=BdRARaFlEBuohTOisqo61SQo2tlA2TV63iIjSPhw32E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzq/xacwXwzZSEWXGKZOaT0iUpYpCJ/MKvGLwhzvwSAr1KqFVtXGrQRaY/CXwPeZT
	 O+EhHtUSQP3vH6n6cbCnMtqnxYKWor4jjKbbFnQIplN8z6UZ/JtpsvyPvpvRXzDjt3
	 xNsAclrlW1UEDoj+8BEEJU5hfdQ0lQTmgK5zAOsfSn4DhrngF6frMuJpB83HwKCYY/
	 OTqA+0xpBhcrC07HlEJiHjFe0VQ1fnTpTXIu+ac14XTeDcoQB7nYFJQNsCIXPyCBbF
	 +LYqrCCbfQHNgDngS7TyFdJE0DENGjfySS01sefM2B5g5R1mcAktyn+prm25Fmfq6g
	 ltuM6ZBdhnxvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8B5380A94C;
	Thu,  5 Dec 2024 03:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rtase: Add support for RTL907XD-VA PCIe port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336944556.1431012.4201196272662073979.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:45 +0000
References: <20241203103146.734516-1-justinlai0215@realtek.com>
In-Reply-To: <20241203103146.734516-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, michal.kubiak@intel.com,
 pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Dec 2024 18:31:46 +0800 you wrote:
> 1. Add RTL907XD-VA hardware version id.
> 2. Add the reported speed for RTL907XD-VA.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h      | 1 +
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
>  2 files changed, 3 insertions(+)

Here is the summary with links:
  - [net-next] rtase: Add support for RTL907XD-VA PCIe port
    https://git.kernel.org/netdev/net-next/c/4485043a9bf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



