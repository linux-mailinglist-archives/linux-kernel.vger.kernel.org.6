Return-Path: <linux-kernel+bounces-411257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C739CF53B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8461F2A346
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62751E2306;
	Fri, 15 Nov 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq2etV49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131141AF0CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700129; cv=none; b=ilWZ6lKfpUny2dya8+0rar15bqk1sCWNNcYyZHbkPfsSUXrz//5tcPcmDdPe/P6PaFiji6E5hI9GFILYSyyFZSLgLvtG0vSLd87Eii6bS4aqLqKQZqNagD47RKtEutQe8anMAoihrzl6Ntl7+zaOCKXWwiQWY/r/CwT6C1GBRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700129; c=relaxed/simple;
	bh=x3zXTofVl75+XYZaSjz/i2wGqJZbPhanzMbvQjRGel0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ItsEyRg7vhFDJOjoP1tGm3ZYgTO3L47q/HMqfbKX7K7tnRCh8VXeUHMKWBRa2dMyskI34h6mkipKZAT8Yq3mQJP2tj9tZGRUzX8MdPfj8ziI50zkG5GFTS/r/SRliTWar+WD+t2PoeGBID9Qlf2EzTZi/O4K5D7gC5cXmBpQFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq2etV49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814C3C4CECF;
	Fri, 15 Nov 2024 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731700128;
	bh=x3zXTofVl75+XYZaSjz/i2wGqJZbPhanzMbvQjRGel0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dq2etV49x7/dxBcuiZ28DhU0qDmr6pTMivRFqCWJNAfzAp2QDJPcH/VA4r7muW6xb
	 gO7lU5nxUkQaF+btdd8tScVswIJufAerlIgDwyt7KlNMTyehG3f0svRaIhN4yYVdi5
	 XGuV4Ud2OBJSPn4cObebU2Mg7X2nyrc/6rnp7PGF6rN2hNkAQemjddH6AaKgaB/FZv
	 sllg+dPaNdiNOjkoDFvrQfXcdPdXgo6/8pStHvAdho0SVqxSfitD53LR/swqS3nqzA
	 2ZLoYfVi/ksSr0SttpzroiZtJGStJXfp9NcLVqwI/UwQY2Ko+iCYS8aO5dvhYgDw4P
	 ilhd5m04Nhejw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 720B83809A80;
	Fri, 15 Nov 2024 19:49:00 +0000 (UTC)
Subject: Re: [GIT PULL] A Single RISC-V Fix for 6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-257c7a1f-aca6-48f9-b3ec-6a4673f8d33e@palmer-ri-x1c9>
References: <mhng-257c7a1f-aca6-48f9-b3ec-6a4673f8d33e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-257c7a1f-aca6-48f9-b3ec-6a4673f8d33e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc8
X-PR-Tracked-Commit-Id: 57f7c7dc78cd09622b12920d92b40c1ce11b234e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8bdb3c8be08c9a3edc0a373c0aa8729355a0705
Message-Id: <173170013917.2698975.1950787133841750972.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 19:48:59 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 07:38:59 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8bdb3c8be08c9a3edc0a373c0aa8729355a0705

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

