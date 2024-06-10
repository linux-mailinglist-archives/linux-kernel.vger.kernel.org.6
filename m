Return-Path: <linux-kernel+bounces-208473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B56902592
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31834B21E06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE70143742;
	Mon, 10 Jun 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF4agIZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4D13DDCE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032862; cv=none; b=NQXM065E4vcOMC6w+uWaEf7o+UVmoYJWpciNBxL/pIY1FhtS8S7U+W2oBXoZj5wdSjSUoAZcaXtyIfngxcnqggL1oRGepPN9oQgKRRkd3Oma5/kTZ4g6cs4RSNhmI6Yt+qUrESREaMX6kkSXkp0DjVIBHAwvMQNoqSPcoEGuznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032862; c=relaxed/simple;
	bh=wrEyc/XOccK5lcvUAFHZMzKW2b4TGOK8NRquUO/ZqfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yc5uWXu6rodpgKEA/N274yWeoXij+loTB6JUQ+gFlrdhP2nSe8zXiD1TfybcPTKy0mUSFWUqlnw4Xn5p8i1Hv49K7yTDFlcdTL6H0E+WCvVZZf7s8GkSU9noNpN6A6OBWnNF1NTWVfrtD/ps1ik17iMgeyoImk8aoAv9qzSD7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF4agIZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ACC2C32786;
	Mon, 10 Jun 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032862;
	bh=wrEyc/XOccK5lcvUAFHZMzKW2b4TGOK8NRquUO/ZqfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YF4agIZLqnty+hVCpPe+arb55voccu/wz5PLFlNZmY+GFV+SflhWRnHCJG2ZXHxzr
	 2RPTZekLP0XqSVRu5Abbl9bPPzZLlSBtQm1sOAQttObYjIvHe4mFilJcxk/srfyuLW
	 MTqX4YgK36BXSb5HawiX9+23BAF65cX5Ta4e3grtys+Oj9bY9E4pH3ffMFo/wsOCeD
	 CCbJZFd9A91k1eGN08MtSCWbJTZAd6quINEi48uEGpB1kDVJyPJ3oAMwKdI1dM9XFQ
	 niMlJEn4vZHY5l0+m2/p40JmciPmyb1HDmYHyWVqBJ2PBoeypPJ3NlrpVQ+xv6jYay
	 U8iASVN5VEm0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F18CBE7C76F;
	Mon, 10 Jun 2024 15:21:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Fixes for 6.10-rc3
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171803286198.3082.7486991860696715697.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 15:21:01 +0000
References: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
In-Reply-To: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 07 Jun 2024 07:25:49 -0700 (PDT) you wrote:
> The following changes since commit c3f38fa61af77b49866b006939479069cd451173:
> 
>   Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc3
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Fixes for 6.10-rc3
    https://git.kernel.org/riscv/c/0a02756d9145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



