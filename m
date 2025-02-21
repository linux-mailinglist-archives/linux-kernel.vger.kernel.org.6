Return-Path: <linux-kernel+bounces-526685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11BEA401FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7261F3A9421
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23772202C4A;
	Fri, 21 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehGHcpZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8B36AF5;
	Fri, 21 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172853; cv=none; b=QiAlbiTEMUzKMq/WeL4L13hpoIonvQIniSBawJLwCWfKQCyj9nAApn5OuMLvGjO2nIjGSVRIWJz3z529xyj/vgp0DYYeqkI9zvD600jnM2QaNzhviJZraqPkIY7np/EIaPU/dgZrKCfVLgw13eP1MnLjMGhbupdrEwCCCqc3/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172853; c=relaxed/simple;
	bh=GvH9sbf7BjzVWFctUss3vdfXB5v/gMmJhuXeWp5vhR4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eAw0NMYpadDnWNkceOj/M5dDSMNFgExFEN6FOEMQ0zHAfYjpRtUzTKfHwkrzST+fB5sziDD3GDbQ3eBcmOkPE+DQBnWRlFN3A4HcTWCPRc32c1Pr/P6truuzsqzQBD9Iut1S++p5n/Sbek5QfP25HOProq54Sj4NVaLl2mNr0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehGHcpZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD9FC4CED6;
	Fri, 21 Feb 2025 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172853;
	bh=GvH9sbf7BjzVWFctUss3vdfXB5v/gMmJhuXeWp5vhR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ehGHcpZLA82BG3NeQW1mzIokptL1heZNAKn2OlmevvNA4nJyEBeEXylo+8B9kjTIK
	 F1DfXEjDDalkhK1qTXGJrWq82SLTzF1H2OqtkhQRG4IfQqnmaG58QLAvAp1FCLBY7h
	 HrdI4mTPOkKZmYYUKeW+xb7KguWMoUWOSNvh2uLwP2NuBTWa630S4Yjag1uq5E5KFf
	 iMi5TLctaDQslRa+2SoqJA6dGHP4C4vY71rlgjMuwmZxrsneVfScIQ4EAa2DB1Bux3
	 l2P85JHdo4DIjtVSy+c6n4w0BHq99qdrf4FCFFqZmChaDASpdDhkBlZul9CphPXQ9r
	 yu7h98jPP9ALA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 860B3380CEEC;
	Fri, 21 Feb 2025 21:21:25 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <22f7e0e5-1ccc-41bf-a474-6cd09b23a26f@app.fastmail.com>
References: <22f7e0e5-1ccc-41bf-a474-6cd09b23a26f@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <22f7e0e5-1ccc-41bf-a474-6cd09b23a26f@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14
X-PR-Tracked-Commit-Id: e31e3f6c0ce473f7ce1e70d54ac8e3ed190509f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff202c5028a195c07b16e1a2fbb8ca6b7ba11a1c
Message-Id: <174017288435.2210212.11849723681477106984.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 21:21:24 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Feb 2025 22:04:42 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff202c5028a195c07b16e1a2fbb8ca6b7ba11a1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

