Return-Path: <linux-kernel+bounces-574753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1DA6E97C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3B16ED22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAF254849;
	Tue, 25 Mar 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnjO6who"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDA253F36
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882856; cv=none; b=WsACiCydjilWNhUj8z8wHQR2Eqk372NJ1jvhDvvIG4I/I3njXQcr6emXNCbi0tAWA8BlygzP1UxKhJgL7HiFPiYEyVvz184i93RpZvDL6vFJkFjNRy7axjk4EjvkNNv3j+hpJB9KRtA/m5yRe1L4BW0HsDYZ4Ju8u+yTK2RHguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882856; c=relaxed/simple;
	bh=sh46vdWJaEn9cvgzEcbM8p3Kf1KhKtDKAGET2zLnaEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZBueJ5U1iAY58tYpOtbJn3y7v9FA2gKqNe4+HlILNBfADwsSUr9fwVnWUrz/VQlbztve3ayk9zFxAnmYQKlL+D//hIB3511aeIRz7w0v1HYyLKQfmHQXBOmCw65Yc1MRcBdXJMCRHcSlmjlLBANy6YGLY9J76biniBRh/6ioIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnjO6who; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A704BC4CEE8;
	Tue, 25 Mar 2025 06:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882856;
	bh=sh46vdWJaEn9cvgzEcbM8p3Kf1KhKtDKAGET2zLnaEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BnjO6who2ChvJTgeuO+I0VEm/62xuQyDRUNBQcvNKmbikcgOsZ+mPoeemshT4BCg5
	 y0PWi7Nuh8tekJLMhzK5pmMCC6UlAhAOLxrEkGwzs7xigVNqZS+s3My7D3zWXLDl1S
	 sFYPQALnXDEm852vROC+fkmDMYvT4cJsywpyXGZCxhLkfVW/+oknaC6aLzwDSCm6qT
	 vBXiUUc/t1gjYcdUDIV0aqej2f8zq1XWN/4aJGEIApbv9Lr2M03OIy9GYaMGUclFzU
	 2YoGQv+mdeNsxqgjwkhuzK20NPy1s9HTa61tmigoykyfdBETrxFhHX1D9ki4sTbadl
	 oyy2P3/Jyh1ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AC6380DBCD;
	Tue, 25 Mar 2025 06:08:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96oNui7G1OTIyLg@gmail.com>
References: <Z96oNui7G1OTIyLg@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96oNui7G1OTIyLg@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-sev-2025-03-22
X-PR-Tracked-Commit-Id: f0373cc0907ca7918266a507d6b3b5d75ee839ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ac6067bd808ceb147d562e624d0348796e4e355
Message-Id: <174288289284.109792.3972634793825470219.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:12 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 13:08:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-sev-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ac6067bd808ceb147d562e624d0348796e4e355

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

