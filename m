Return-Path: <linux-kernel+bounces-336628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDBC983D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895A21F23E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453913FEE;
	Tue, 24 Sep 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1WauIL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75F77111
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160027; cv=none; b=U9xjoX9ZA7cx9RwVE8AbKvH7G7HpA7BAKIiD7pGNxB8uuR8VXytEkHSNxwS0FKtw/E/B4V0noyg/X7dSvbub4X952xRggRqZkrrGURklzvOD5P4zxRHmDpiirBwqaumONRSpTPTMzpwy+J5kE2tgk/yJryNV+7LmYvbOR91PgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160027; c=relaxed/simple;
	bh=om1pN1QTZvdrpe7l+Q60/DGIUzN5Y0snEy9rwFg0pMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mGebqJvkb87jw2hcPnrO5o8yMx7j/g+Gjjk6BPCeuorvAFhLjsth/vPyGIuXRqVN16WHTJuc7Pc6wZHpUlmkWD2RKnimJKoxd7NorPg7UeO0Qrv6u02dqs07exE5sYADu3YVEy6O3lf6I2I665/L370h9o1Di9uy7OUV9gwaUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1WauIL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A283CC4CEC4;
	Tue, 24 Sep 2024 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727160026;
	bh=om1pN1QTZvdrpe7l+Q60/DGIUzN5Y0snEy9rwFg0pMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1WauIL1aVGCsJuHkdce6XeneCuno6wJN0j7MKwpN7ZKkUt5ap1nKnEybskZPN+ry
	 acrQQGYahvrD+LQmwaHoeT72fyUggarjJv8pkYz1a+ogsf166bbsb5cnJ/kBLGwi29
	 vzXP+2ouHd0JCTE8QhBLVgkkLtYGasj2EprklIbiIWsqNDAHcjmI++uIJWQul/MIDA
	 ca8T1UUueENn/sHaFGxQ/dzBY4oaUReJ/Jnwnq++UkGtgOB0pATgruWTb4vbJk/EOV
	 wlHJBlg6WZLNSsOIYnhAiCgmXFzvJRDAZWvxDokXqytG3X7f/2mnYWdk7Mo1Ny/FRE
	 aQEVAgO0+SsxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E163806655;
	Tue, 24 Sep 2024 06:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] tools: Add barrier implementations for riscv
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172716002873.3899939.6509449388750546652.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 06:40:28 +0000
References: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
In-Reply-To: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, parri.andrea@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 06 Aug 2024 15:01:22 -0700 you wrote:
> Add support for riscv specific barrier implementations to the tools
> tree, so that fence instructions can be emitted for synchronization.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - Fix typo in commit message
> - Link to v1: https://lore.kernel.org/r/20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com
> 
> [...]

Here is the summary with links:
  - [v2,1/2] tools: Add riscv barrier implementation
    https://git.kernel.org/riscv/c/6d74d178fe6e
  - [v2,2/2] tools: Optimize ring buffer for riscv
    https://git.kernel.org/riscv/c/aa5736dc7aa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



