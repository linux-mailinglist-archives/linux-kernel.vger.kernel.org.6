Return-Path: <linux-kernel+bounces-262236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9593C2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5E4282F60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CE19DF47;
	Thu, 25 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4znUMVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7419B3D5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=UsjcY+/HRNyraelmVgin9q33QyQgNa8hYrvkU3GbWICPeWvDXhHIluPku2UNuZwjjQ9MZ5rz1eOIfOTzSo7THppWzNJkB+o1lGpHvRSaSVSIBxxVAygDRf7MZ+2Ov7gn/dMNh1fER5JQiLk9shUe9Ob/+M3x+X2xrOQYsJn3M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=TpI1ixtnkgK6069tyFCaTDiH2JIMGFEYHPdFbLBMSYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s9cL4Abf6oKrmiFTdnnjf9ebvT1tWnhN20HWcUnzATaBtRaYik5PibqpCd6xREK43Sblm790O90rmGnC/VuWvynJM1q763h201ei1c03TcxnDIvAyMKoGOay0rdplIdnBtaKZQBCytfdsEPAmfUB7trpVesvHMNsrMC3sXqxg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4znUMVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CDBEC4AF15;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=TpI1ixtnkgK6069tyFCaTDiH2JIMGFEYHPdFbLBMSYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P4znUMVW3nVwf8QCbMHEF386qnVMNPF2hpPk5cDnaT+hL49ZqkHRdyRIR0f1j+iE/
	 sJrH5EO7OXKVwBHjd30bqAOMfLl14WXce1GRo+RswGCksVr/FfypVg5pdhdoDvIrh7
	 Gt+W2zDU+9iH8DvjHeeHT6xtwN0IZbP6wuJbPYKtuVRy91eaFTMtMbPxMUbnZoyODw
	 JkUdmP+wpv9Q4hmQCKWNyfBtSyQu/uq5PaalAnn7h5f+rmysWcrK8y2zweh9XktVtW
	 jNlJXHdIse0aY7Xl1cEDU5005+MKR1i17kPwwQjtxhUd/KBaCWVBWY29T40w7cgxg0
	 W55c7Tvkc+Aow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65997C54BB5;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] riscv: boot: remove duplicated targets line
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363940.6240.8844559149155554407.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240613153053.3835-1-jszhang@kernel.org>
In-Reply-To: <20240613153053.3835-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 emil.renner.berthing@canonical.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jun 2024 23:30:53 +0800 you wrote:
> The "targets:" is duplicated in another line, remove the one with less
> targets.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  arch/riscv/boot/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [RESEND] riscv: boot: remove duplicated targets line
    https://git.kernel.org/riscv/c/8d22d0db5bbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



