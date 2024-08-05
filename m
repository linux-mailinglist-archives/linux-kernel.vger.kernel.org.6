Return-Path: <linux-kernel+bounces-275488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2417D948669
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04591F23CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D24171E49;
	Mon,  5 Aug 2024 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjcHlIg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B716F850;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902057; cv=none; b=ImXuVL9C4g6uu2tmyqu9MbfO8M0ooQmLrAKR6lywx2K/bs2iHj4JlwRNiQceVCQsqokI6kyDe46d+2v2PrZbPkp9Fcx3rZlQst9MQejWZ7fFuhpNtb6ywoSCdORSCFVt4pR58DtDqoH04raU1Kp/mSvdo9AYydTToAFpeq16pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902057; c=relaxed/simple;
	bh=YOacJKFxKyNVmQpresSsfetJyoR67HqF+afcKUIrj5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W92KBv4mDXe/Qe83wCuVjdZlBrgMGzsgiEEaXYbgCpPV2/RAC1/iAWrxKZpdjQtpZS4rnZR7IUH8knTAzrkCqXJwjkjxAICivsnOJG2l8esTBi0PeP39456Fy840AB9VwTEQjcsX5fAlB5tMcOZ1u7Vt5ZVSt8AFuldVmDreysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjcHlIg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FB1BC4AF12;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902057;
	bh=YOacJKFxKyNVmQpresSsfetJyoR67HqF+afcKUIrj5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kjcHlIg4uykzAIDVqCMRcH9/SpjV/Yq9Tn1Z8PTQx75B58Ach6dg/9mh9ST1G91N5
	 AKWo23dAt3aC6uQP2pv+ISwTu47xXyunHbRzuswSSYyXgib2bntYVuv9+s4OG/GbAj
	 RmfU8LRn9dUeiQR29idL+b+77dYVNXaBO8ULmmw+xdweVTtaIBlrN/KjNaBi5NbAMC
	 5Ke6GGJsYOotrV6qPCgcXT1MiWWABsxQJZFuQFRJN4Jt90mcI66+s8q/6hrdQIWdEB
	 V+OJ2TCGOXoncFuGBEFDfhz1FNW6wUeLq2mcH1nxhge8543oxujECJCLVfHp77DyDc
	 JhZslccrVE5oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D430D20ABC;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tools: ynl: remove extraneous ; after statements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172290205724.12421.5395655484283570485.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:54:17 +0000
References: <20240802113436.448939-1-colin.i.king@gmail.com>
In-Reply-To: <20240802113436.448939-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Aug 2024 12:34:36 +0100 you wrote:
> There are a couple of statements with two following semicolons,
> replace these with just one semicolon.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [next] tools: ynl: remove extraneous ; after statements
    https://git.kernel.org/netdev/net-next/c/e8fc78eb658a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



