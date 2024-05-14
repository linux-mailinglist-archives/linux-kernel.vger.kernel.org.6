Return-Path: <linux-kernel+bounces-178774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80748C577A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B571C21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4A144D0D;
	Tue, 14 May 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFDHNYgh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F51448D2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695242; cv=none; b=I8DdL9/VNAgZsIFFOYeuNbeKeZyModDcLEmaKbq/Swf/aOWj3iVUP23mSdDSfo2YMeJgFuuCvBpxKf6q1JBziZV4GYcxcIPDxhct7NrKqmnYWI82gpaOLAnWME2dN3J4eizVydS8mu3iPno1HYnnU43dGr/Ixw512Zo7OGFZc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695242; c=relaxed/simple;
	bh=q4VWeFDoYuUSIevq7piqtaLyouhlVQEVm3uHhS2qql4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGyYMPYoQoNjcQViqWrOqjHVORheBCCHUVr66h60+rzS+QyORKqD9GnBLZSvt++28OGr/H/pkzJepWcJPHQWG2qz4/rI6BCwn2EYgrA8USSXGKTp6j5h15caU9qJyvmvoN2EFrip8Rk9bmV9WDv6SoyqlzXutYqqYlZaCtEJuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFDHNYgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DCFBC32786;
	Tue, 14 May 2024 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695242;
	bh=q4VWeFDoYuUSIevq7piqtaLyouhlVQEVm3uHhS2qql4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SFDHNYghZQwpvf3B9Oej71J/1ka7QsDyj6yo/Fhb5wd4Phj4BLWY+CZizo9p583Cc
	 sy7QQSqt3Q0d1tFdVPbgoNETnuXN1MBw7KJU2cDdhywfH2eARKL8575WxSkjkR2a9I
	 hhb7XD4EJKyAs0OE5fidHtBMkOlr1R7mgsepE25qyaHVCXhgTruKv2z9sQiYUxoBL7
	 iO2JYaeu/UOi25d3fPhGWSC8UIISr0e5k8OzBk3QPeoQt2FRSmA62RN4w8Us1O5pTH
	 DoGoG8qr9VO0amBU5UVTVhPUOlzGcNarikz09hKjHceh+04aocgbBOoo5dmQK6Mx31
	 mF3pbOVG3Omjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30CB2C3274D;
	Tue, 14 May 2024 14:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171569524219.4793.14427180278508799172.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 14:00:42 +0000
References: <IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, unicorn_wang@outlook.com,
 conor.dooley@microchip.com, guoren@kernel.org, rafael@kernel.org,
 sunilvl@ventanamicro.com, svenjoac@gmx.de,
 prabhakar.mahadev-lad.rj@bp.renesas.com, dfustini@baylibre.com,
 linux-kernel@vger.kernel.org, jszhang@kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 11 Apr 2024 20:12:40 +0800 you wrote:
> CONFIG_CLK_SOPHGO_CV1800 is required when booting the minimum
> system for CV1800 series board.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800
    https://git.kernel.org/riscv/c/92cce91949a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



