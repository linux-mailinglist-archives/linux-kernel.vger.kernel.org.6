Return-Path: <linux-kernel+bounces-445658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA009F1929
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F50B163E14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E688198E90;
	Fri, 13 Dec 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1TLE6JG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BF15573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129299; cv=none; b=LhUHFKz+Y0QZJqtjJFSLYRQkri68VdzM7SORnb9GcdpuTUbQk1+/D3Pz3zr2CpffqVhRgZaiqjBdUW3/Tvyq1lGZZmzQMak5bmfI5z9RD8nqdhgLFta7cYkUWwvJy50O4VlQTyiqYQfIV/eMOiSWHIW6CCxtp+mfd3SVgyjVDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129299; c=relaxed/simple;
	bh=XPTlpQtwF+ZkXHg9wDTdT84ApntOBmVexMUHSL0CMxw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C64IDPZ23H7QhJDh11BxKJyyyZrgu2bqqwtLy5KLY/8+i4eYp6vgQVhjH2pIkujg3maNLziy9QgTc4YnEjOE0Ykti+ERol/i/flnaabUEXGbR7gz+6gCqT7XrzOLtv36P9+8vYFDptwaXPEjogfOOdGbCRoAiUe2DI81zri3HTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1TLE6JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A44C4CED0;
	Fri, 13 Dec 2024 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129299;
	bh=XPTlpQtwF+ZkXHg9wDTdT84ApntOBmVexMUHSL0CMxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r1TLE6JGpb82beWGgaF3o3pFzYUgDF/OWAULzvHTqqIrCfBBn5xFM44X3L2dLNCIp
	 5UgDCf2DX3w1Y9/Qttwi8feMsMOlMt0IJHA1lncpp0mMe3/O5kwEOg4CPPndJ46r2t
	 MW7afNyMm/a4G3FjgY2uWsrtX1QlWWKyRE5FtHSV/C0g/XezttaZ3aS8P8ddjhmcWa
	 D3wqlnhajNKDeqBNrYLZTeLa97GXze/N6n1nKq1gOBhKdsJ6zSOG06FV3muC0lSbmS
	 aCt9tSNnwdHlLY9q3yeaLZp8mddcHw0rG0zqV9SpMVXx+bB2ImdfhKe68BWuwifo/p
	 LzGPay9FzEI4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF14380A959;
	Fri, 13 Dec 2024 22:35:16 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d041d4cd-3e9f-4533-ac26-e0d67be93496@palmer-ri-x1c9>
References: <mhng-d041d4cd-3e9f-4533-ac26-e0d67be93496@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d041d4cd-3e9f-4533-ac26-e0d67be93496@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-rc3
X-PR-Tracked-Commit-Id: 21f1b85c8912262adf51707e63614a114425eb10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b3d5dfce3a1ac2e87cae8ea6b279038d418a6c
Message-Id: <173412931526.3178864.2460721745326330363.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 22:35:15 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 08:36:22 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b3d5dfce3a1ac2e87cae8ea6b279038d418a6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

