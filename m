Return-Path: <linux-kernel+bounces-387872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B069B5710
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DC31C22556
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E620B211;
	Tue, 29 Oct 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7h4Ix41"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E52038D9;
	Tue, 29 Oct 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245222; cv=none; b=JhdzDc1PS+ewz0h7/slfOFoJeEOPGw5O2ld/BjsMr+RCa+jMF2sQnYU9FDbTc9gAGN5G/QEGNgKnbkapmLt99iOn6r1bZ69YMW+UW9NekaDEqenTAUvBZRnf0s3LGwasHAfZlLWzleHRnczvjxppR7DFEE65e7IWsdtKBvgbUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245222; c=relaxed/simple;
	bh=nqikMNqk5KcFw6pJ/2AgWheBAqr2U4u/7Wf45PqqTek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gRpGqe/DN4dLVxABJUEOB9Xrhbz04HtW4l1eUYNF6NTmreXG9BYFZc5CloJZgITdGt9ZDGQlmci2QQJOLxcPDK6hTkIetVB/S1LuBMt7jJPKBNsF5B8KmF++UEPjX7brcJ5OzTXOJ9gas6Kz26Nmd7EA36QxDa4kYTBRiwmowQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7h4Ix41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC9CC4CECD;
	Tue, 29 Oct 2024 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245222;
	bh=nqikMNqk5KcFw6pJ/2AgWheBAqr2U4u/7Wf45PqqTek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7h4Ix41gTiPawBjhaRn88a/CK/OE39jyluNcWH5LcdRxInOO0zGJ8yES5xCUbSZ+
	 NgI73z7XtXMZETBEUoXg76rl45tczh9hKF/vbiROd77iisrWhgMlmbXP7YcXOYZhw4
	 SBbgcZxVTfJHkP4eByxvtsBvgpmPeQcGnavjPTLU16DbI080CsXSOkZzBy3IR9LwIm
	 O85uFawaJJ94xUz7cipontyQPweZ0dbSrb9UiCQVpO9OV0BJ7KfWRszNgsMLUshpQG
	 4lHAiOmqyFR5GwUIQEmERFxKYW9VKSFt0wLkd02/2iVvCRugo4tOg9IVvHUKiDygmU
	 OEVtnE0cxc0wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB8380AC00;
	Tue, 29 Oct 2024 23:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: qlogic: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024523000.854097.15526799604945066918.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:40:30 +0000
References: <20241024195534.176410-1-rosenp@gmail.com>
In-Reply-To: <20241024195534.176410-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, manishc@marvell.com, rahulv@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shshaikh@marvell.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 12:55:34 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../qlogic/netxen/netxen_nic_ethtool.c        | 14 ++---
>  .../net/ethernet/qlogic/qede/qede_ethtool.c   | 34 +++++------
>  .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   | 60 +++++++++----------
>  3 files changed, 50 insertions(+), 58 deletions(-)

Here is the summary with links:
  - [net-next] net: qlogic: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/a27646c42ec9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



