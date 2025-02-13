Return-Path: <linux-kernel+bounces-513122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28AA341D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D96818838EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719E281379;
	Thu, 13 Feb 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtAoRzvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85928134A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456405; cv=none; b=kRdN2qZGgNFeQ08zNOQ9zG/qa+NP01XFT2cbApB31s+ami1ZXiT1kvHn0scmZMQHwF+sCKZ6AG8wwaqc0ypRTiTxsDkHZMrQMxkzTjkwJXr3FAzr3uxxm6dkmBq1ki6h8AuDj41N27Z1MuGyWj05/OtIMv1MEVjLc98G2aNw1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456405; c=relaxed/simple;
	bh=07usGt1nxc0FC8bBEeP0t7h42KmIbvUtMbZ9M3Tt4ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A6T5QUbfwUSpK0ASujvk+EyqikaKWdzDK7CU7HInw6tdSskee/Ey4kdMEiJxgPGWYMrFV/xt8+NmlSTXQHlIOyb3TwlUNYzVak9RBuSGH93jTy9nnQIBf4ER1cWXw1ZkCpG+g13qZLBsqrK91lPH0PG4flNhp4e77AhqObveKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtAoRzvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F2C4CEE9;
	Thu, 13 Feb 2025 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456405;
	bh=07usGt1nxc0FC8bBEeP0t7h42KmIbvUtMbZ9M3Tt4ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DtAoRzvCfrFcwM/EoY1fLtsKsSkjXzZrglAQpuSmWdSHn+mUzD49mDL0Z9U1E4m/R
	 8aGwhZvxQV9oGrSm8AcnfVv/c5lWL/bRaVowNpmvrdwB4xGre6bU/7CDVzFGkDMbqt
	 TC1iTa7HA9jx0f3z4Wb8PvLtQ82cT7APZkcFJ/oU7IN1SqY233Cggs91okgaRHpHQj
	 FZUDlCJxR29TXBg4gWMz+xGKzD1eDvHR787KJWnV+XaFft9jONuP9oyEOc/c4W7xMN
	 2TvtZ+MTaCDeKG5NOoaxtXdO4E+g/7OM+gVxHnTJr73P9YTWnHbNz4rix2Ze53nUfB
	 N5zUUIquPik0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4A380CEEF;
	Thu, 13 Feb 2025 14:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv: Use of_property_present() to test for non-boolean
 properties
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173945643426.1243861.13922610517205148727.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 14:20:34 +0000
References: <20250205143903.413959-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20250205143903.413959-1-emil.renner.berthing@canonical.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org, spersvold@gmail.com,
 paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, conor.dooley@microchip.com, palmer@dabbelt.com,
 cuiyunhui@bytedance.com, sudeep.holla@arm.com, mikisabate@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  5 Feb 2025 15:39:01 +0100 you wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated and since
> 
> commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used on non-boolean properties")
> 
> a warning is displayed when used incorrectly. Fix it by switching to
> of_property_present() as recommended in the same commit.
> 
> [...]

Here is the summary with links:
  - [v1] riscv: Use of_property_present() to test for non-boolean properties
    https://git.kernel.org/riscv/c/b9524a73725d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



