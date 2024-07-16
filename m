Return-Path: <linux-kernel+bounces-253185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E8931DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3344C1F226E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB84A920;
	Tue, 16 Jul 2024 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/a3sT+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5492914;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088191; cv=none; b=jjIeHqnIPsW9NlhFpIebSF/NhPU8EXt6Rmgm1AN4tIQVEyH7cdCkgnFLvLZCz0hsxCS0fkNMwkV7erd6FQZFm8eK3nypCkYOF+cE3xGh5Z6kSV02OBiPnJzVjl3aUljoQzer8T5xt+zkveFCj0E9QL2dxmwYzQfeHughivxJ7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088191; c=relaxed/simple;
	bh=P/wwbST6a26Kh2+wxa79kAKB94I/Qf4nVkxsZE/JNc4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fyve6arsB/64S2F7RMU0A4r/R2vHQ2pjlleGrCdr2pJU8f2XeDKAjnB3LsVlE3APvSMfIpuFdnNc4B4ifkntea4zIYIlAfsy/GqzJEFmLoDg/LCWmqbPeaN6EzatAT5+ttcrHM7idz5mCdtiYVhL+ynGXo9lpnQkiNlBJVG//gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/a3sT+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83CB4C4AF0C;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721088191;
	bh=P/wwbST6a26Kh2+wxa79kAKB94I/Qf4nVkxsZE/JNc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C/a3sT+kHrXjXsK11mUDcxNJeINtfNL3ejL5AI9N5PR+5usoguy4Sdpm572b2u+gG
	 GU8HuIOUPpraE0l8TNkQap3u+1PBXmAjYjd2+l86xDKn/UWcS1J7/X0nfBQBhSQbdT
	 ho++cACNepJWaFVQzETH/8xp1lqa7MPRxSwl3w3c/fo1cqDNGqDRC1uKogXSqJygnr
	 AthVP7xO9dlk06oOebig1hTnUrBzlW+5O3SkNwKOjxOOauXNetvQfz2t+SLBdsHpHF
	 pMJra8hzYFpPIwU/ORfozz6FNmy/ngKwjxFydZWiWSrBIu7RY627b0tnajfWuPBNdZ
	 K08u8vy+HqNWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73182C43443;
	Tue, 16 Jul 2024 00:03:11 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
References: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc1
X-PR-Tracked-Commit-Id: 0543f29408a151c1c4a12e5da07ec45c2779b9b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cb9dc10a6c32f2e485f2be47f3d32a45a3fe499
Message-Id: <172108819146.30335.14336543593205411131.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:03:11 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Jul 2024 15:51:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cb9dc10a6c32f2e485f2be47f3d32a45a3fe499

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

