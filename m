Return-Path: <linux-kernel+bounces-304054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF96193C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709251C212F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27481D417C;
	Tue, 27 Aug 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixpGDnQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF80155327;
	Tue, 27 Aug 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794237; cv=none; b=Z5F5jv0cUmZAgaBZibDK99RvR9eY56SahVVX84XcqDwxyR5TqGTjyoa7sMq7VBP71ci8f+yM6gAD+mqHLBY71WnB3ZZ06LYzkLkDmD/R85Bx3umQQ0lUhZX9LWtU2GPP2E/clNt7x0moLQ4mOm4xWqztKHBa2h0JHbPkLIaPAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794237; c=relaxed/simple;
	bh=SiFewKdJZ96BKKjRglMfqrzpjVveektUJP9nH4YQJYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ms9NFdGIzlOAiqUgRuQ2cHyrYZ6ijqe8BHXHWPKP2JmKEFnx9dsOflHkUfG3F1I7Ca+xAm3STjk298GQEAxTsVPOhRYf8sVctH/bOOt0Uy+lx96LJDcBWn2SyG2yJJLmFgXo2jU5Zy9gqGqGONZ8YnoLAfBlGfZvx3IuwXW1wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixpGDnQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988ADC4AF11;
	Tue, 27 Aug 2024 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794236;
	bh=SiFewKdJZ96BKKjRglMfqrzpjVveektUJP9nH4YQJYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixpGDnQg7vUOTkslVGISYacbg4rAlDVHdjZx/weUfshcdVzBaCuLDXvI3HGZnRYe4
	 XooCbHIlVWkK9X3q5Q8kHrJdOZGjfRUknoglEUMd5adFww8nXFPFWm6AHoi00E1hIu
	 0APQsE93/CpXPZYbUgdy/6IdJXbZZ2EpatbZp3JfImsxHv3OQGdaw0cXupz18peTuN
	 iGvTcb15ML84NCuPJM1wbhW30YAilEBJhS9zOZaOX0rlv1QxQFReIas/N1PNl33zWv
	 EEZmgMxzJstrre1TD3d6zDvRXT9Q1vtCkhlVaGcAYuyLiTauLghqg96Hz/N/kzUrlX
	 sLqxTH3Fd1Eqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECA3822D6D;
	Tue, 27 Aug 2024 21:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ag71xx: support probe defferal for getting MAC
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479423674.767553.1264849823275053489.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:36 +0000
References: <20240824200249.137209-1-rosenp@gmail.com>
In-Reply-To: <20240824200249.137209-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Aug 2024 13:02:37 -0700 you wrote:
> Currently, of_get_ethdev_address() return is checked for any return error
> code which means that trying to get the MAC from NVMEM cells that is backed
> by MTD will fail if it was not probed before ag71xx.
> 
> So, lets check the return error code for EPROBE_DEFER and defer the ag71xx
> probe in that case until the underlying NVMEM device is live.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ag71xx: support probe defferal for getting MAC address
    https://git.kernel.org/netdev/net-next/c/be04024a24a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



