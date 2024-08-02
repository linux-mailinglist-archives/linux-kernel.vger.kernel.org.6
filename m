Return-Path: <linux-kernel+bounces-272872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC399946219
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E661C2153A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE215C13C;
	Fri,  2 Aug 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqAlUpen"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF613633D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617590; cv=none; b=SqDD2KwEjIuNY+oZMnXOMISOcUDaUNqHOSL8Akc6d0IFwpsIXLxkRzS8GK9W+QiNiZyp0BA0DO4qr7QnaWvI79v+XPacUqS8//XoWUDLsYNE5YXSGVdIqV+taPvIhdTjZ3LkKFX0T6KHgD6+URmFWHsSMBEyUs3z8PLJ5/+vzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617590; c=relaxed/simple;
	bh=3NR2A6uZxVOxwjNvyWhjmTfIEJK7m9xETjsES+XsRN4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hJVJ9N0lAvyKPR0ojhJujyjV3RnHPRAKbnKALLfdyfL0wXCWxTUgivLFDAuSKtABAoHWl0CyqbPVjQ2y7DwELfjcyKua2la7Als5Djw+uA63s6e8VfjybcTG7ljEEi598oQW82m9fdhOJNF+Z2WU6Fgx4pr2c8PtfdyQVbil03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqAlUpen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB26BC4AF0A;
	Fri,  2 Aug 2024 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617590;
	bh=3NR2A6uZxVOxwjNvyWhjmTfIEJK7m9xETjsES+XsRN4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PqAlUpenx+6Xy46jOvIAOHOSZZIbfzgqbaJc+PcFYrRY7LUjbvRPJkxpvY3WqsNp3
	 QRYxCjAvUw/DqQEEH0VdMyILFzSx4XIqXXIyDFctweBTlueFW33aUODjnF+/JOPds3
	 Ale5dXzIWakgr8J2VM4vQ+mwJyYJ2iMN+W5jHIkPuIQChkgvNnPSP9QbL4hLmIUKdF
	 XMudbG3lZT+r3H3zn9tely53U64Lx/l1u8i79yysBz6PSxJkfznrVAbu4A2Al/ptYb
	 JBPB/pJdn1wUDlx1CMMedNIAPV/GbNphoNW4DgMc+/mBRPzZXXYY7UiBF0jsxPd6sR
	 knVj+sRcnSimg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E174AD0C60C;
	Fri,  2 Aug 2024 16:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-43770bb1-d5ee-499f-8925-ade7d59c6f38@palmer-ri-x1c9>
References: <mhng-43770bb1-d5ee-499f-8925-ade7d59c6f38@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-43770bb1-d5ee-499f-8925-ade7d59c6f38@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc2
X-PR-Tracked-Commit-Id: 3b6564427aea83b7a35a15ca278291d50a1edcfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 948752d2e010e11b56a877975e7e9158d6d31823
Message-Id: <172261758991.28369.15960104277345307627.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:09 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 02 Aug 2024 08:44:50 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/948752d2e010e11b56a877975e7e9158d6d31823

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

