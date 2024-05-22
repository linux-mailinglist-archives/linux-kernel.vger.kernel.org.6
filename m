Return-Path: <linux-kernel+bounces-186848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5D8CC9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670A51F21276
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492F14F128;
	Wed, 22 May 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urSOuSEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62214D29A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=lxYH9FRZ7ZSys5nWR79Y+TJuN2XcBLNiz1F22QWOCMRPMz1f6YXjPwWd2ExJ5z2wencalhDYHoTOE7KoUZGlBYAZoQldx/L0T49wEbCf0CK2S+W/1Xqzz79L9qBKDBRuqGLEIO8xMtmPk71orT3Cl2ENT8gVwygIACGcpslK7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=WxJ6YXhCfPuZ517v7LggLzpx3WamKrtIwMEXRH1SkOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGTiTJCSjJQrpkOxi8AJ7UOUVYHspzLrdo5xFdZk2V+TuF8avluyPkobw48N8/FRMx3CcCpBKyeSFEvgW0RF2WjfmfEXZpMWdtnT3zv3HPADIUZPHdEeQK7gpt6Dp1jVaxYvxfAsKKqCKcWqiaBWPQxoVXT051Qv9qLLuhIxNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urSOuSEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9E76C4AF0A;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=WxJ6YXhCfPuZ517v7LggLzpx3WamKrtIwMEXRH1SkOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urSOuSENx+V2tYjtyhElDa8RGuy6Yw2ejpx3a5Jpk2tG1Is1oN+9fpqbUqBszAYLI
	 highrSAdxr5LyMCPvlFNIzGXb+Hce93cFZCuKLDhnLQQFKD5Y2h7h3cErqWqNfXLHc
	 PPrtRCjOZEhRCk6mgWUcgUvdxMqhB/GtUDsOyVAmiZJoYf5PVynhnbOLyOduA1u6kt
	 mfKiJGmD4ixh2Wj+kaFbeA56QwAjLCfuFIpeOCD8JIsZLfBNVUxabigZfyTcvMLSJB
	 RZeLZzsH0pHAsyE4dGd/nYRxwvPMtjoJUe8W8IH7eLBqfsMKtyjUzsNh6OZ9stqfBO
	 cYPt0Me+dG28g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADCCFC54BB1;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: typo in comment for get_f64_reg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190770.9409.8853343046568203839.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240317055556.9449-1-rockrush@rockwork.org>
In-Reply-To: <20240317055556.9449-1-rockrush@rockwork.org>
To: Xingyou Chen <rockrush@rockwork.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 ajones@ventanamicro.com, cleger@rivosinc.com, aou@eecs.berkeley.edu,
 palmer@dabbelt.com, paul.walmsley@sifive.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 17 Mar 2024 13:55:56 +0800 you wrote:
> Signed-off-by: Xingyou Chen <rockrush@rockwork.org>
> ---
>  arch/riscv/kernel/fpu.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: typo in comment for get_f64_reg
    https://git.kernel.org/riscv/c/fca93def4e41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



