Return-Path: <linux-kernel+bounces-331719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D707297B073
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D391F2222A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B717BB2E;
	Tue, 17 Sep 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4IRscx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5017B425
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578044; cv=none; b=G3UOYexLr3YbQl5U6/ev+Hd6yreCZvAI3FLR1AS4WbBvmFNj9l1i6AfasnhGJGQ8OzpIah3nhIGesgO2xLYTzbJ6rnJCANt0jePHMKfmG5T6TnzEB76NZZhV8+JfOknsAuHauun8wcG3Bsa+UNyxDVW3ywqrVogmttPTdg7TRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578044; c=relaxed/simple;
	bh=pIppZEbDiVADR7CG3QuxR5cXk1Q5xPxo9bdADzgacR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3KI2/r83TMxCd05AgK9EBJDE2nt70CLgnB6DLv97ZSYpTxfNYqdDxvK8FfSCesMjXcDDFJZ/mS1lSsoVrtKP0C6+IMpD3nLOQRg4LQctQbuz4SFa+uUM6PdEBC/1kTSEFvItRZlXo1cGWisjhrgpHc4o33X/7yv3LDhICNFpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4IRscx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE6C4CED0;
	Tue, 17 Sep 2024 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578044;
	bh=pIppZEbDiVADR7CG3QuxR5cXk1Q5xPxo9bdADzgacR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M4IRscx41RmjikmLTvfArV6iuO3WwyTmo84DRb+nmVghVFRO0p9kcwfmJN2hnPGPs
	 3c/U6GRrFRD/IIdt0PI1dMV8wwuQaWQKoaicZHcLgDZy7/hnAAjDFd0dF24Tg1tQ45
	 OjGSRVlZbDJbpg0+9+MyxlzNsroZ5AvAfmDS88Vruoic/d+24USBerU0WHcL+cRyBc
	 Fx/FpWXsQDjjNB6weZ7gc9uc63EV2XvD5qRsgwz6mLXnPtLbhFQnxrhn7hx0W+8ZKc
	 NaCfViG+M55Sqo0tkeHRoQn+h6hmTrgJZSH6i4nkBVll1lHwfEtpsbDDvnrbuYVc2D
	 h8GpD6vz6TjZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC3D33809A80;
	Tue, 17 Sep 2024 13:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove redundant restriction on memory size
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804552.126252.15064993791243643422.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:45 +0000
References: <20240624121723.2186279-1-stuart.menefy@codasip.com>
In-Reply-To: <20240624121723.2186279-1-stuart.menefy@codasip.com>
To: Stuart Menefy <stuart.menefy@codasip.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jun 2024 13:17:23 +0100 you wrote:
> The original reason for reserving the top 4GiB of the direct map
> (space for modules/BPF/kernel) hasn't applied since the address
> map was reworked for KASAN.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
> ---
>  arch/riscv/mm/init.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Here is the summary with links:
  - riscv: Remove redundant restriction on memory size
    https://git.kernel.org/riscv/c/d6a1928134a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



