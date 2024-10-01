Return-Path: <linux-kernel+bounces-345800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9998BB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AC41C23657
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58B1BFE0F;
	Tue,  1 Oct 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPlVhqJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EB1BF804
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782517; cv=none; b=ugDxbYiK5NWxg2nbHBp3VecDfnHaPsmrmaGMzNiChEIsaySKPPUU5V5rQPAYbHdgwR1+srhDSwbmwcdZIlPC2nqJAfFPEKfY9bwv42bnEtEfvKhDAcXlB0zc65ZjgnCFhBzJHUioOYXvmvEy1N8wMuZGBYoryR/uVV8ZcuAlSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782517; c=relaxed/simple;
	bh=01KB6tP7Ie9eCPsnc8LBlGs1DaUFNLllcbFhYKmsJr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cr9Z6eqMqLtQYIT6sX1GKdpOloioVBaZzuJAMPFmG5had8dAV+pnC3WWDmETsPVlgKcDJSXYpsYV5Du1l/LkqwLmJ0tvFixI+Elg4o4hKfw1ZzxEH4fRHchIN6JxlLoSaqXbaGgOhNU10RYcJF2MTMS/1DgtL2/6Pv3+O95gcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPlVhqJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AAAC4CECD;
	Tue,  1 Oct 2024 11:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782516;
	bh=01KB6tP7Ie9eCPsnc8LBlGs1DaUFNLllcbFhYKmsJr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPlVhqJG7jLpuHC7koENBe/YwLTc0TzkCe2z4oeLZH5jYArcFHOJuBosc3a0j07Je
	 9LfB8lwebZNN/gHZ7zf4eNjGvyvl3bFrmYT1QTdnOoY01BFLwLoE3+n69iVqii8eLh
	 tEruN+7lrTFHdCjSRBMfmfGPvlsyz2ALnzXLpzPW9F2jCu7t6nv0Ntxrhp/SdSc77u
	 bHAYpkFO8s0CJK2CKuWRl7mJEGd8wddbW4kAhocOwRWZY4/UyKSoVHHkzWPlU9HmHo
	 irhbe7djKCA586KuxSrkMDKDZmMNsgcSgrJIHcqWuDRaEc/KmdNN81AiLckQGn4hkk
	 wSBoLeFE0kkaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0D380DBF7;
	Tue,  1 Oct 2024 11:35:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: make riscv_isa_vendor_ext_andes[] static
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172778252000.314421.4988733398467937549.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 11:35:20 +0000
References: <20240919061524.264007-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20240919061524.264007-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 charlie@rivosinc.com, palmer@dabbelt.com, paul.walmsley@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 19 Sep 2024 07:15:24 +0100 you wrote:
> The riscv_isa_vendor_ext_andes array is not exported out of the
> file it is in, so make it static to fix the following sparse
> warning:
> 
> arch/riscv/kernel/vendor_extensions/andes.c:11:33: warning: symbol 'riscv_isa_vendor_ext_andes' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> [...]

Here is the summary with links:
  - riscv: make riscv_isa_vendor_ext_andes[] static
    https://git.kernel.org/riscv/c/594ffcf4efe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



