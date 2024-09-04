Return-Path: <linux-kernel+bounces-313991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CC96AD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CF1C22FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12D10F9;
	Wed,  4 Sep 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNvoX74d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4A63D;
	Wed,  4 Sep 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410427; cv=none; b=mkxgo8EAtINaf1Ck3QAF/m+4mZyWL/aNSXn1uUsuKllVsikDa5Kkbyf6IQFIPC4ANQ/4T3ZyAlPkvjwlEBsnlf/nOl4Nz3DnZdHJBm18107K0A9iK2e6wpD3H+8FmKmxshJv9yZu/3DbcwWlt7iABIKXZ9Oo/ktEM7rYm7YN3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410427; c=relaxed/simple;
	bh=NQTLg5bczNH9g7vw6cDN6r6ZhkUqIo0BJg9a6AhK2vU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OlOwrc/IGOdq6wM8jnIXfaA1EnHSBumEQlwLOufNqvCLnYDYPUwxo1KJV3fvCjTFhe0qpiNzgNBGOv2R9spkz6l6kjRtgRyTGwfep1Z7kRtgBeq8RXgL6uyaBQm4WOnjGcrdtEZrAZj9XndKuhidebgwNTeItavxhUPPqslqDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNvoX74d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5728C4CEC4;
	Wed,  4 Sep 2024 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725410426;
	bh=NQTLg5bczNH9g7vw6cDN6r6ZhkUqIo0BJg9a6AhK2vU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNvoX74d0vYWBt6y6+dg0PEp4sSf9gAd5JNxFuTHEmuWqFRepmXwpRq82k57TL3x/
	 DfFx19uASY4e571K6LlkUXlbCDh6fdBpY6wQjC4MN92M6rGpnR2dWiDVeP0CkZHw+E
	 AZUsiTzmCwcke2Kf/ks84y6AyD7cQOD3/xm6cNQija9QkqcgW03Ybnqs6BJ8la6J5L
	 MD2JOiJCarcGr5z1zGsOhfdnlwFVEqOd+uQEJoBn/99IjowCoRoOdyrYV0ymcfKH7H
	 oUUJJj+sEdRk5PXcZu2cMEIhY8iNWn1GAAVl/J/R2Nk55BVB3hkSUunU8oZ6cb0RF/
	 YPxCn+Qtjv3Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBA33806651;
	Wed,  4 Sep 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] qlcnic: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172541042750.524371.1727696328534362665.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 00:40:27 +0000
References: <20240902112904.556577-1-yuehaibing@huawei.com>
In-Reply-To: <20240902112904.556577-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Sep 2024 19:29:04 +0800 you wrote:
> There is no caller and implementation in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic.h         |  1 -
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h | 10 ----------
>  2 files changed, 11 deletions(-)

Here is the summary with links:
  - [net-next] qlcnic: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/6c76474fc1ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



