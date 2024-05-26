Return-Path: <linux-kernel+bounces-189880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA578CF629
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9302B21070
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDE213174B;
	Sun, 26 May 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS5QyzLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95C1A2C21
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716759118; cv=none; b=R9KlKg5MkuU7tfF2kKAzwoo0OlUipBNFUVAjNUGeMjpoCfJjSyeSdRhKmwtzOtdYyd/AWIqvgIY6MavK6H0GPk2ae5sbtQDCrlmJYDnEvEMmQjKhia5sa8s3zgRnlBwZhsU1IYnmK49WsU3dwfh5p6ovlclzMFQ/0iUX8d4H1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716759118; c=relaxed/simple;
	bh=OVrLoTT3VWRKK8+T51uPGfdBRWS6IIkjOL2Z/igbpbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GtseqS1kaqptipc/ngLx20elWzTDe6irM9zIfLK+xWOYtkgI3wPsvjjIRd9UzItLybPQlC4ErtmKMRsFz926Y1wrk4xSOX0InLB75wQVeOBjDhPPu3ccjEKOFBH85r6Mjn8bW3BO1SW6W7/DjVUF2205yu1JfvAkmecLK4IUojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS5QyzLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E28FFC32786;
	Sun, 26 May 2024 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716759117;
	bh=OVrLoTT3VWRKK8+T51uPGfdBRWS6IIkjOL2Z/igbpbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FS5QyzLoBFYerJnHpUnVAB70uEkEV4hyKXuEXrr0X1StypT7HB432u2N/TFyXlqBn
	 ijLB00tZA/dyE/cuuwZ3lbsBidLGSoeweNu9gS81DZ/2vGk/74WU1HiHNE2rBK2Cmx
	 WK+A1M7ijsLoK3cPMBPtRhaUK9z4St4slOCjzVhWkTEi8fF1VZgC5d9bSabGAlLYap
	 YjPUqfrEkBak8GFkxe7+wEKyKR+l26180KufnnQsUasOBtbCv91RCwxpPUWfTN23p2
	 HbXXIjkv23iUOnRlQfyukKAxtSrO2MYddTepLeP7fSFjL8kV1pHrRlUqO7GIksOBIH
	 Qc8pGkuypzq9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1FE4D38A65;
	Sun, 26 May 2024 21:31:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 2
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171675911785.27088.9320331335675774714.git-patchwork-notify@kernel.org>
Date: Sun, 26 May 2024 21:31:57 +0000
References: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
In-Reply-To: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 24 May 2024 08:53:40 -0700 (PDT) you wrote:
> merged tag 'riscv-for-linus-6.10-mw1'
> The following changes since commit 0bfbc914d9433d8ac2763a9ce99ce7721ee5c8e0:
> 
>   Merge tag 'riscv-for-linus-6.10-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2024-05-22 09:56:00 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.10 Merge Window, Part 2
    https://git.kernel.org/riscv/c/f1f9984fdc5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



