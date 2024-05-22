Return-Path: <linux-kernel+bounces-186844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BB8CC9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4B51F225E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9F14D6F6;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BELPVch4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244E146D53
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=KENkNG7QdhzM5sF+FBDeOT6dv4H4aHGb/bTh6hbZTI9Oq9/ZKLltPFoRV26eG2I1yfvivXGY80Mga6icoyvw0XvlWMxxhGkzk0eCEvvyMU6W11soegmUJu2wmbd2Xo5j78Byr7QimnKt9OUeKzaDdFbzJvwV0GBz0Nga82cBfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=ioi6hVc2nEfWRbNZ3lg5Z200sbO2gZVHrpry3fbgHJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JAhWL5UQT7ToXkjMfQCLUQZ2A+eK3O3AahFGupJ/AWzMiOTOWfbSDZMep5lDr1Dp3AZVRWPRaZLj3X1bTuVsPQNg08f+NCCHt44iHTxF7A0+TvMx4GrDdmjPTucOaOsND8kStnghFwgusmxL9JR9YicB/r5yXSZ1dFxNkRJpfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BELPVch4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC5CCC4AF07;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=ioi6hVc2nEfWRbNZ3lg5Z200sbO2gZVHrpry3fbgHJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BELPVch4tSn7j38Q2vYR5hdVashLpRM9ExSHZwKcvf+4TrFUXuGVQQA3u7OS8dL98
	 cdroRK3JWQ2fBJQVqW75Xh0O5ouemy0W/xE0UFGLTri+QYoq6qfkOMA7ittCLgNDVN
	 Q3owqXjqHykWiXEIffm6vqHHZzd5jhafjeODEk+uuC7HCAd+RwkJZn7i7E7T0LCGZa
	 3WCgMob95z7L2h1HdT8xzNmpeSjzdvx9x/FhEvzqbarfReRyq+2g0hD2myMV8tNY4K
	 aHsDOqkNvqSwrS7d+wQLm2CnFZynaCXg6UwJO6mDW09ELVBtriIZhmrRSIEuAqHE31
	 zxujMedqGoANw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94D65C43638;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] riscv: Extension parsing fixes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190760.9409.9505694012625639228.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
In-Reply-To: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 conor@kernel.org, conor.dooley@microchip.com, cleger@rivosinc.com,
 evan@rivosinc.com, palmer@rivosinc.com, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, ajones@ventanamicro.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 02 May 2024 21:50:49 -0700 you wrote:
> This series contains two minor fixes for the extension parsing in
> cpufeature.c.
> 
> Some T-Head boards without vector 1.0 support report "v" in the isa
> string in their DT which will cause the kernel to run vector code. The
> code to blacklist "v" from these boards was doing so by using
> riscv_cached_mvendorid() which has not been populated at the time of
> extension parsing. This fix instead greedily reads the mvendorid CSR of
> the boot hart to determine if the cpu is from T-Head.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] riscv: cpufeature: Fix thead vector hwcap removal
    https://git.kernel.org/riscv/c/e482eab4d1eb
  - [v4,2/2] riscv: cpufeature: Fix extension subset checking
    https://git.kernel.org/riscv/c/e67e98ee8952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



