Return-Path: <linux-kernel+bounces-262235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0793C2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6234A281A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F919CCE2;
	Thu, 25 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHQI4lMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586119B3C8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=uYmbPBb3O+wCs0LWd/aRdLzed86Jgn9y2SnYMs5aqp+GRjvRbKbXobuevNHaMUhMnjYJ0aDyBh9N8azfA85aHvXHF6I2+5Dbd3zlGFqcuVde1Z6x7fMxqwsR4WmG/97MOYTIbZPfSlXaCkaeMvopoH2FFT/KoL7Er5PTnQOk1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=uLoleUQwNiKBJ39xNzNzucuRi48WbYIMOUXXJTn3Jgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cK4XFct9+8w1SelZaKLUT6pbj+QyoKLzr6/3ud7feglnPMTHtY55kCqq2wUrsGPUVPHp3rXbTERBZHQUgGaYdIaSXXktJ9jg5wb2dxbk5o9BL18xuW1fJ7od81u40Eoy4CKYIQUxEwxqHjdG3ER20giXDql7fQc85BXP8Lq+KAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHQI4lMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 510C1C4AF11;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=uLoleUQwNiKBJ39xNzNzucuRi48WbYIMOUXXJTn3Jgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lHQI4lMqLlyl/3Zl7ur5lOeFPS9fyezqHl6fE1eOvnwtJf5VYh52JcXkuBraQhlqu
	 tjBwMjcMAORgVRTSry8JxBmyB6e5bKjXBDb2uiX0TxD/6e4K+Tq/wb/EaIvEp+xc0y
	 SRb0rDwecTl86ne7s6z2hEfL7whG3SOnIJD+Gmmbs9abRMO4iCzsSOnnHX6uCYtRcj
	 tvDr7NUrbKg9upYjXXm3tFJXEgbDwvIuhsqat/yEVPBWHV6SquGoOkF3CbZ+Dbl+A9
	 ZpOxIsHkXLpVqHiE+dkxPoK8gJm/fN3ibFPxFpaw9rCTmDN3zU5i2xODOU8oSDMlZQ
	 2TK74GgxakObg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 489C8C4333D;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Enable SPCR table for console output on RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363929.6240.827816040310708972.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 aou@eecs.berkeley.edu, rafael.j.wysocki@intel.com,
 conor.dooley@microchip.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 ajones@ventanamicro.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  2 May 2024 00:37:50 -0700 you wrote:
> The ACPI SPCR code has been used to enable console output for ARM64 and
> X86. The same code can be reused for RISC-V. Furthermore, SPCR table is
> mandated for headless system as outlined in the RISC-V BRS
> Specification, chapter 6.
> 
> Changes in v2:
> - Added code to handle early_init_dt_scan_chosen_stdout().
> 
> [...]

Here is the summary with links:
  - [v2,1/1] RISC-V: ACPI: Enable SPCR table for console output on RISC-V
    https://git.kernel.org/riscv/c/38738947db38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



