Return-Path: <linux-kernel+bounces-411574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E99CFC52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C06288837
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBA1922C4;
	Sat, 16 Nov 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAReENS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978E191F6A;
	Sat, 16 Nov 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722427; cv=none; b=WHfGNDyW3eZNWfPeNaGO+8fkPaBI9NaZM9B5xXx6LFG/kJDkQ7OBhziEdK+iI757lVVwWMdfFh5Uey5pZawlRKI9VX+C72H3vRcDCyzxRpVL3fgw3K+2hruGNx4FYmkOTftYpv26oVt/DsHVYnzGBNsGnuRB8ipKlJ7PlpX8pf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722427; c=relaxed/simple;
	bh=XFXNcv+y2jaE8MH3Zzx8m/ZTT7XfsFV3w93gUyXM/Xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f1FRoqOMW3R3no/+dTqnIKlUmtMRCueYy3i8C8ijSlkQ+0sTun2V5ZyUSLu/j2Jgs9t3voD870K1pR5Doiq7qv11BHEo2IRtrbhBdjXnwoacxgTgJwxzuxUpL6mIH7e8TY0w5RSke+xt9imwK6vI0irrTyiHCEjpqHpWSSqFO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAReENS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6550CC4CED0;
	Sat, 16 Nov 2024 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731722425;
	bh=XFXNcv+y2jaE8MH3Zzx8m/ZTT7XfsFV3w93gUyXM/Xk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dAReENS7cJAO58FKpRI4cwIrCOacCXyFZeW890PDYnPPsGN0x8qMxduhDmt6osHHp
	 FsHcdit22NBzSj8K4iYEFynbPaOqDhECUuWT2AXDJwgpN147cGnXBantN93YkYEXwZ
	 Sm2WDK4gQgYqNARp07kYpRHUHvZI8d/14FTEzblo5scOQGkPHt1iyy/Nvrac0iNoD6
	 JtPLCbuQ0x0MTZ/iyT6kc4G1Xxi4r9fCjVeKiWqPLn0QxmocL8cXXLm+QhXB0zthKM
	 Jh2oTcDcKJWMNcA+KJEOjSQNU6eoXrXVNAhE0MvEfJlbFHQygGbpr9f/Y/LWUBgZn9
	 WrdiS4GGZ5ScQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCA3809A80;
	Sat, 16 Nov 2024 02:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Modifying format and renaming goto labels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173172243608.2797219.7333896071358961263.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 02:00:36 +0000
References: <20241114112549.376101-1-justinlai0215@realtek.com>
In-Reply-To: <20241114112549.376101-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 19:25:47 +0800 you wrote:
> This patch set primarily involves modifying the enum rtase_registers
> format and renaming the goto labels in rtase_init_one.
> 
> Justin Lai (2):
>   rtase: Modify the name of the goto label
>   rtase: Modify the content format of the enum rtase_registers
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] rtase: Modify the name of the goto label
    https://git.kernel.org/netdev/net-next/c/fdb53791195c
  - [net-next,2/2] rtase: Modify the content format of the enum rtase_registers
    https://git.kernel.org/netdev/net-next/c/39007e1c1c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



