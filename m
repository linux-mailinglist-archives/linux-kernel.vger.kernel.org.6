Return-Path: <linux-kernel+bounces-206169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA8900510
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6F71F21BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65D19A286;
	Fri,  7 Jun 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2a72W1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EB1993B5;
	Fri,  7 Jun 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767165; cv=none; b=kv9zXucxlCaEtIN6MOgZQ2XRNC7dxR3hCuEhAqzC3eiqhwug/J7DBEkbINWQ4XuIs6V0qYYpclWJQABTGal0OYerCu4ih1lRjAyTpv+VC6/rxoYMUdgntEu28foA3VJw4HIylqPcVM980wSWjSDYDL+vrc67nvOcCKEhzYHElb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767165; c=relaxed/simple;
	bh=9P2MGEHwq5f8wM+XNCHAvhIl80sUC4xT2yP1PSWbHtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qwZwfNEpudHpwAfNPe1CZQhZYlWmpyiWwcxI/isuRZDrk2f1wvndGRTH13zMUS07sDG7tRO+D//pEjQGlipRwHOeOmdjDN/ZhS1qwtx++Zn/l7dWl5MdKAAM74mxfaFuHkZjvXIW3T/z4cTJIgg+L2PDxbbvAh4r/jafGc5nEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2a72W1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B08C2BBFC;
	Fri,  7 Jun 2024 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717767164;
	bh=9P2MGEHwq5f8wM+XNCHAvhIl80sUC4xT2yP1PSWbHtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2a72W1chxEu7wVzFBRomegai8wOefu91BSElgX9w4OHqtVLzZJpv8nJfSVjic2KH
	 EDsUA3/7UebudKzEUnrnWeMOz3P74F0MiO7HMOLO4itSkRbuY/AhmbPBimvb/ip0oP
	 vYKsVgctyQPJ+piezTX40ASvY1GswB6mhsJN/47+/Dj6bB4u1mL4KkneetieDRunfl
	 LBiVhXO9q+4ycThFi64Oijm18Tg6wM2I/XGVuuvKqDfrAss5qeIHNEjOPArTCRLI3b
	 N3OBRdrRYymPenT6jy3yIjlTYAe8PGOImzZmc63kka/4B+dVmbvMX3JJP9TayQYsmh
	 gDaIpdNuuZOqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BEC4CF3BA3;
	Fri,  7 Jun 2024 13:32:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Add multicast filtering
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171776716449.27999.6756325734269615428.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 13:32:44 +0000
References: <20240605095223.2556963-1-danishanwar@ti.com>
In-Reply-To: <20240605095223.2556963-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: dan.carpenter@linaro.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 andrew@lunn.ch, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, wojciech.drewek@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 5 Jun 2024 15:22:23 +0530 you wrote:
> Add multicast filtering support for ICSSG Driver. Multicast addresses will
> be updated by __dev_mc_sync() API. icssg_prueth_add_macst () and
> icssg_prueth_del_mcast() will be sync and unsync APIs for the driver
> respectively.
> 
> To add a mac_address for a port, driver needs to call icssg_fdb_add_del()
> and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
> will then configure the rules and allow filtering.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ti: icssg-prueth: Add multicast filtering support
    https://git.kernel.org/netdev/net-next/c/a99997323654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



