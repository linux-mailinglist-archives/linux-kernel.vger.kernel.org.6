Return-Path: <linux-kernel+bounces-271639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF49450FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4637D1F2782F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75FA1BE230;
	Thu,  1 Aug 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw514SYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCF1BC065
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=uUpIUCRDqbIliVDNF5mbPbGcacEhDbw/7ZzMIkyucjg3O26EUS0HBzElTu09Hoo1jqIPFToI+zBaFaT2A/1nfGMs+orIgPRJ42Ion/5+khegjJNGRXcu3FyBTzOMBWdtPZJDSM10mDi5AH+nqVYYhBeJ0Q6I+VpUIBAhldo7Qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=UnU0PcJkTz7cc/UhgE+UHGawejA3Ev86arXcn5fJvjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fyCygEBQIF6mT6axt0nI35qusTJnQrHmfhz9ccmMfU53hBXfTFbNAFnmYb96qSpy3yCl+Tlbqp0BPkWFnJjsIwUL+0f+mcoBWsZGwOiPTeMxyHIsGmbAdjbV6VhCGTVMDkYkcmhBP4d5sm/LudhHSOTMPh01QEbNWH1R7x7IVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw514SYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF67AC4AF16;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530438;
	bh=UnU0PcJkTz7cc/UhgE+UHGawejA3Ev86arXcn5fJvjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dw514SYO10HSU4S2KN37Up2qlHI6vk6ytedOFarXOZRly+IMAd9pRz72GDdLwhBWi
	 R+lf88ijiC5aRLJVcmfB85Ji92VAN/tc66Fmzbq+eZGs4ePA5CcNJz7E9v6e57wpfS
	 VQ5v4ZpzB4fRt6c21oqx2OlSBPut8caQd+v+xgkz0VMDoJ94h1tObTmtNTeV7LdI/6
	 gIQumVEs7Zxl2/ZyQ4mZa8Fr3qSYybc4vk+XAGSdOJxmYu1DDeQue4t+2qb3HpcoEa
	 7dAsoONg75R/16HL59dFCOUv8l0y8+JFKXq1RKkeheRjaErEPraODgIW9XSx9JCIep
	 txVSWHb2Tu+ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC884C3274E;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] cache: StarFive: Require a 64-bit system
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043783.13740.5911748203881194794.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240722154519.25375-2-palmer@rivosinc.com>
In-Reply-To: <20240722154519.25375-2-palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org,
 emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org,
 conor.dooley@microchip.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 22 Jul 2024 08:45:20 -0700 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This has a bunch of {read,write}q() calls, so it won't work on 32-bit
> systems.  I don't think there's any 32-bit StarFive systems, so for now
> just require 64-bit.
> 
> Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] cache: StarFive: Require a 64-bit system
    https://git.kernel.org/riscv/c/57e5c814e915

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



