Return-Path: <linux-kernel+bounces-351215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47064990E92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790481C203A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E52281C4;
	Fri,  4 Oct 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3gl3irH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2911DAC9F;
	Fri,  4 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066633; cv=none; b=lMmZSQg7w5Pliylqp65ZCaa+X6bhA5DQxVDrTvi0E+ifjq3pI2a8qzdP04JFys5kGaLD0K6OeNZbAI5g7eHplYgw2YFUewVCWVIBV7cx157iMKFWtb7RmHLQg4yPxV9E6hLjdazVnxgXhmyTgk2SaEJaPPyjhdNq55kEpNtrxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066633; c=relaxed/simple;
	bh=KTwYNgnxfFZfZZhflfSORKvJEzuyuDojzbmdZYgIjSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p/mDJxj+iijNp12wgMvzIT0wflTJls6HCArHVQUbNJ2LsAe1bKg95dOAIoRoP+bwVjt2/mhrk6d18nIsmm13kTfOfCUadz/WKgkhnxquGkc0TUy6rbgi8LCtvqBxKm7Fmj+4WI0dvL8a5OSI7OI0NGzsH9jElyKJRjkVzDSvWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3gl3irH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6BDC4CECC;
	Fri,  4 Oct 2024 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066632;
	bh=KTwYNgnxfFZfZZhflfSORKvJEzuyuDojzbmdZYgIjSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P3gl3irHkNqJfXxKjmF2jY4vCXWVOg2hK/i29Iuow8mvDs3P64IOLZwCUK38z+RK4
	 B/5kowicWkNfFWH9WNxk0kX4jmYLLCUegFrim+RQcIaxyeFZxoBc32ayaTqyDPz6jT
	 TirjmE7t1791DusbdSyDTPubllW3lYKl2GfouZT0JckSdZYIJZ6CAjj3aQp5iBF6wa
	 hDeSXqG8zTyFH+XXhu/Hei0BIfGhI5C9xJmmlXDBoMznZDGUxy2VOezcI4zbbW8a28
	 t2i+xivOL7w8hdAT8+BvO8w8koHK5fH0bs2el4GxcYgAdxL4M8jyg9DbM+1p6YGh+e
	 2alT1xNNgxFkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE66539F76FF;
	Fri,  4 Oct 2024 18:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-af: Change block parameter to const
 pointer in get_lf_str_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806663656.2691890.10874417922332901666.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 18:30:36 +0000
References: <20241001110542.5404-2-riyandhiman14@gmail.com>
In-Reply-To: <20241001110542.5404-2-riyandhiman14@gmail.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rsaladi2@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 16:35:43 +0530 you wrote:
> Convert struct rvu_block block to const struct rvu_block *block in
> get_lf_str_list() function parameter. This improves efficiency by
> avoiding structure copying and reflects the function's read-only
> access to block.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: Change block parameter to const pointer in get_lf_str_list
    https://git.kernel.org/netdev/net-next/c/c55ff46aeebe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



