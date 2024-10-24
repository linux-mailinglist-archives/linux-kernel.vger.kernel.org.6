Return-Path: <linux-kernel+bounces-379741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99E9AE306
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC511C22118
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2291C57B2;
	Thu, 24 Oct 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNrbphqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449114831C;
	Thu, 24 Oct 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767024; cv=none; b=RiyUD5eCuctM5vImOW2HG968UFrUcbxcZyERyFl1lQ9O6LwAcjqsIGSnOItUZMXbGsF305w+xdr2miym1KXypoefHV6pvGrL08RcPQ5aeMi/tf07rJ/x+QrSUzNM54vpCGICZmgPLZ5AsyBJa0QbkfGfJ2E/SO0wP7pzfhCO2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767024; c=relaxed/simple;
	bh=Q+2aUQOlCwrtSEboqYEO/jmHPcnMnolsBYc7SBAX9+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOx0Rj6eUHuu2G01IxbRf8WHg6/DCj0Ej5l8tjhSrZhUFoUoGtCryA78A6Jz+IfL54MzCLLW2f9J/7rp74RxfSBde93bX2hQQLIMrb/xrG/A+d1e0+wJFGzVcpnzjbFwYoh4A87sQNZLO2ocByhCNVYzKIre1E/YBIxo95/zKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNrbphqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D8FC4CECC;
	Thu, 24 Oct 2024 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767023;
	bh=Q+2aUQOlCwrtSEboqYEO/jmHPcnMnolsBYc7SBAX9+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNrbphqnGmQUNvIY2Lp1gTpGrvogP0gNj/HseHCiRthBSOSuODIxifoasPvwwxMyP
	 Rr1xab0vdKNRrnUIQ26Iq/rhBJ6MW+WFnBWTXuXN0OBWoPKD4w96CQc5f06msZxXds
	 CoeMiMTwTqwSxd7HnTzHtr1NyI+Xsr7U/UVNZxC7CmVmUnnZsAIy2UinEzOmefsZcW
	 j8vdTEKkCm/wY5N8ceOGqof+6ZQ1YSMYQsIUbdcQBcL0oJUkkdSV3mf2oMyBBxMbIO
	 Ifazp5a8yfK6Qrqgh1oACbTRveCLWh4lwzAjwz+y6Rf4jups+IMx826d/c36m4iVbD
	 xVjgQlVaRcfwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349B0380DBDD;
	Thu, 24 Oct 2024 10:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: dsa: microchip: disable EEE for
 KSZ879x/KSZ877x/KSZ876x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976703002.2195383.9654021587748249769.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 10:50:30 +0000
References: <20241018160658.781564-1-tharvey@gateworks.com>
In-Reply-To: <20241018160658.781564-1-tharvey@gateworks.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, lukma@denx.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 09:06:58 -0700 you wrote:
> The well-known errata regarding EEE not being functional on various KSZ
> switches has been refactored a few times. Recently the refactoring has
> excluded several switches that the errata should also apply to.
> 
> Disable EEE for additional switches with this errata and provide
> additional comments referring to the public errata document.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x
    https://git.kernel.org/netdev/net/c/ee76eb24343b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



