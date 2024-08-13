Return-Path: <linux-kernel+bounces-285611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC195105C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95131F216F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA31AAE0A;
	Tue, 13 Aug 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsG3PcFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BE1A0AE0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590961; cv=none; b=jM+LJK6M3vp1Ur9nE3iI5xvD7U1Ej24Vx4yRgZb1zsgp5WNXxGd9PO4IhNFsJEtXBFWGeWN2j38e9XXJMn/sHqPESv4n+C0jb2hoOsXUHbE4tZAFEnL8ESQIRUymlNNujPKZtxGAzV7zTUI6nx2o21sg/gPySsGQfhKfvO4dako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590961; c=relaxed/simple;
	bh=Royr2k1bjovXsdPHJu6PchvBcZQB4upKx9cd99ls4BM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VPVet7WbKeqRnI7gD14Q49CYKV5e+nWvIr0aZ6U5RiLmvy7fArPhBpkj+MHCY0jP1Ddu/djnnA9Gv648memivqAWeyBdoqHUJcwBsiD0j4yxNZ1/Kcb6DEJAYYtO3q2b0YGDAsUAvo5w5HSit/bLrr4OGfPUhCogdg/Fh3ZqWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsG3PcFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669DAC32782;
	Tue, 13 Aug 2024 23:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590961;
	bh=Royr2k1bjovXsdPHJu6PchvBcZQB4upKx9cd99ls4BM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DsG3PcFIXnFWLU5ojUwwwEtmpPhiLWEofF5P6HIBynQ1FshXQIh5RPCMSvgWfkEVZ
	 o+PkH8TP2WMqOoRyo2f7CUdA4RsEmuOlGU25Y01mYSXhDdN0JkmDbdsk2Kj/TGj+ro
	 S1m4X3BGBYIuijOT6b9KmEhJClOynF5wJJVFDP+Oe8ROdXiDF2FL1T+JAor4h3vI6e
	 hgQDxdAVyqm1re3tMOm6XfsFB8iXwwZRMrt5GNUcpoTTgq0B60wbXDUtFhZG6AOhRQ
	 yo8NWM22s+VHO0n4r3AptyBxlyR7FOj/RjmHgTXDqirRHN4C4BAzLto4dIJg+8t1ua
	 tK6AaVcxyOy8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0523823327;
	Tue, 13 Aug 2024 23:16:01 +0000 (UTC)
Subject: Re: [GIT PULL] execve fixes for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202408131327.15CD984B5@keescook>
References: <202408131327.15CD984B5@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202408131327.15CD984B5@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc4
X-PR-Tracked-Commit-Id: f50733b45d865f91db90919f8311e2127ce5a0cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b0f8db921abf0520081d779876d3a41069dab95
Message-Id: <172359096025.1804347.9509632670269898102.pr-tracker-bot@kernel.org>
Date: Tue, 13 Aug 2024 23:16:00 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Greg Ungerer <gerg@linux-m68k.org>, Kees Cook <kees@kernel.org>, Marco Vanotti <mvanotti@google.com>, Stefan O'Rear <sorear@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 13 Aug 2024 13:27:44 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b0f8db921abf0520081d779876d3a41069dab95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

