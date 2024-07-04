Return-Path: <linux-kernel+bounces-241085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481199276E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7C7B215E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05271AED4A;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9WEZoNS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F6846F;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098657; cv=none; b=chfQhAYfNiOV0bc7j+8sCH5Vo61SMdhsVvl0wTr8erRqCIQ3hibaQ454w2tUTxgLEPVuJzpC2hN9vgglNg2uZjY6l206QSaDmfX+6/SmrH6Vjc1ySMp85l0ysvAkgeBjRvEs8vi6HynzlTvTZipHBLrQfirJ/i+gV3fhA+zmpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098657; c=relaxed/simple;
	bh=P52GeseScYIMI/6SpZlxsaUn4vxd5oniu7tXtl7TbGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UxyfwNA2twck3z66xh3+uSEKDRElPYh9R1kYl1uQad5tXnECqBE2p5WsDDr6zakD639ykeWCl2U2Qi/AiRTz5Co5XTzEoA4TOftseCefqaPtFA74tqvTdy0cfYhGEFRoTXOUfy6PdYsedOiv1Ol5uaNyvYZoWLn29hqGW6rKfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9WEZoNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE7B7C4AF0A;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098656;
	bh=P52GeseScYIMI/6SpZlxsaUn4vxd5oniu7tXtl7TbGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9WEZoNSW5x9LREt6QpcGDpp7AhfxjGaJ0PJUvK9YZKSHAbEBn0Xt6RXZF7v1i2Xt
	 gFqqaWmhRboESpn0lIuXmBwEng5XhifPNUfWArRs8C7wC50bN7VASOVfMFo5aVbos6
	 OxtNPMbLZqp56BRdBCm10wMga/TglC1G4EcwvZQA2bhEjsCWNwc9HlGB0Y1ohVxTaa
	 4zM71QZ72rJDt5zOZprKRzWzMStI8ouJwEGkbbaDuPUslmRliczv+3tizB1CgYz3KW
	 OyOMNFk1rmPQwvsTBk9Q7Gs3G6M4kTeMQflzm91rWEFQYVhD/MmRmsMhGWKsGwbUXP
	 XYVmzftOrKBFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E51CC43446;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] documentation: Fix riscv cmodx example
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172009865664.17306.16379914644000401734.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:10:56 +0000
References: <20240628-fix_cmodx_example-v1-1-e6c6523bc163@rivosinc.com>
In-Reply-To: <20240628-fix_cmodx_example-v1-1-e6c6523bc163@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 atishp@rivosinc.com, palmer@rivosinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 28 Jun 2024 17:25:49 -0700 you wrote:
> ON/OFF in the keys was swapped between the first and second argument of
> the prctl. The prctl key is always PR_RISCV_SET_ICACHE_FLUSH_CTX, and
> the second argument can be PR_RISCV_CTX_SW_FENCEI_ON or
> PR_RISCV_CTX_SW_FENCEI_OFF.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 6a08e4709c58 ("documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl")
> 
> [...]

Here is the summary with links:
  - documentation: Fix riscv cmodx example
    https://git.kernel.org/riscv/c/7c5d838d7090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



