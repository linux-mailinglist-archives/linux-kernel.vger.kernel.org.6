Return-Path: <linux-kernel+bounces-242846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A63928DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40106B24749
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCB176256;
	Fri,  5 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBwZ6PJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A1175552
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208279; cv=none; b=XWIkxlryA/C7oBkEcwbfczfUwWAPuQ7WpmqAuChHcKPtT3AAIDBN9L6EW2Jyln77032O54Eq4F83WCToe3eed7M+wf5Yg2vuTKrR8xifFAzYgYwIK6jaj2Bm+4cTAglJl2TLjzA2BC1LH5YQmgo9iJsmPigWj7EMXQziMnWrewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208279; c=relaxed/simple;
	bh=xNdMLT2mUhhiTc4YzHZzzJOgKHC7/CcVqnspUSp4enQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ChxcBFtDNfP4CBVBT9XJLImumrP1IYK7F36J1W/z/KAOfcr4peNgg5AnsHLRI9WyMQXPJO2VzO5AvPHC/pyH69fAyxbssPD/HOmzHuR/2tc1LgRzPvQSStH/QxAR9K6DeCN5OU6A7fUoUSQp7+2jJagJkXQi3r/9wQA1W42M4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBwZ6PJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D284DC4AF10;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208278;
	bh=xNdMLT2mUhhiTc4YzHZzzJOgKHC7/CcVqnspUSp4enQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QBwZ6PJp47zIv0QT8SfWkeEm5xPXq6zhC80kwDN5nWg16OW/OTtRM81Rbx+Turb/H
	 1cW0EWPBRYzyUBDGTioxRwN9YhijdYmdcfV0KKXylD8t4cOUmp6n5MeXpSKPcYH44x
	 3AiklGIy+++wFJw7tlNjYso9KgFnCymQAyZWLkYC1hsbg8WbBzP3AYaf6VWCMNMZL7
	 Uo/NBzavifFAkKsLjqkj08HtJYMf3dNaUbwwqWofonT6bVBpFrOLn6HdPd8J5L7xf4
	 GQM0FoOusDFZn1hCTCOKrzBJnJ5KHd+7Rt2xBTkihAab/J4dwzOH3leVh3yzsWULy7
	 iiH4rKgi/SfbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7A00C433A2;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c0537cb4-d700-4259-889e-c87f011e931b@palmer-ri-x1c9>
References: <mhng-c0537cb4-d700-4259-889e-c87f011e931b@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-c0537cb4-d700-4259-889e-c87f011e931b@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc7
X-PR-Tracked-Commit-Id: c562ba719df570c986caf0941fea2449150bcbc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b673f2bda0c9d306e330a236c87706d8de18107a
Message-Id: <172020827881.9250.5322358935828636202.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2024 19:37:58 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jul 2024 10:16:32 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b673f2bda0c9d306e330a236c87706d8de18107a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

