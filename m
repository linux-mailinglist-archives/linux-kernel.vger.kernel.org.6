Return-Path: <linux-kernel+bounces-197358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2968D69AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682A0283AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF7017E47D;
	Fri, 31 May 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/gLOADh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92F17E458
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183208; cv=none; b=IZ2v/sq6ZkS71Bcz9WEEhw6is6bsXRxVGDNZGidkSfOdGBvCtwAFlchAY33nBfXfpyLFbQv0Sc5FzMw9CLyjqJ25BJHQcKK1DqZUfsjjkz77uYCmeACdxqNnepFmqNRFv8ReR2bhbQXg4WJmvl75YqZDsMUimfN/BT19+6sdKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183208; c=relaxed/simple;
	bh=uvgNr+17dGAuta3h+AvGUhyHsaMfOoqD3cJPO7N8Dso=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mo/+G56dk6mMlnwr9dLh/V1IxFwTcnrik4Wdqd6UYzNiOXqYJPib0zVxQxvAHxeHun878IAO8FjEfIRRtNFMDki/4FImxhIeI9YT1b8kqeFk7ICZP7RmkllYbYet+55GnpAjTW/tcf4dEGnA/KlYvpkLz+Lbpb62SS7SmpWB8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/gLOADh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D961C4AF0C;
	Fri, 31 May 2024 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183208;
	bh=uvgNr+17dGAuta3h+AvGUhyHsaMfOoqD3cJPO7N8Dso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h/gLOADhfnPFaTr3kF7dumdjE+R3svsY6PSWoImYWpsXMF/BKicHou9l0aaNdLKNh
	 /4iV5Ig8hWfioCTMsP+TewrJQs0pARlbxMAC1a23OmN9fCGvOf5GGBdnasZpmYZVRD
	 TgVQlf8w4xbDRIzwlvY6fW3gqC6vedKk3m+YVwdAn/OV+hwrdlbnXXmMxiJckbXehg
	 OX8/BJ80qdzhTl1DReEbewJZ/le5Tr/Ar/CEl0z2Uahegl9K1I/qwu3qe6QPoWnnsX
	 lBo23Ohbn8nCcO9OZ1ytZSdP2Qa4S/ZVuQ/4uDHzjGVJHi9FUoyTdy+HOBiuLudDQx
	 hii0DW/wuu3Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3081CF21DC;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d5ff54e8-e0e4-4b50-8461-c23eeb95b31d@palmer-ri-x1c9>
References: <mhng-d5ff54e8-e0e4-4b50-8461-c23eeb95b31d@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d5ff54e8-e0e4-4b50-8461-c23eeb95b31d@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc2
X-PR-Tracked-Commit-Id: 1d84afaf02524d2558e8ca3ca169be2ef720380b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6cc9799b4c16b1bd42de35be563d4fa6ea43799
Message-Id: <171718320798.20247.3141512146525127618.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 19:20:07 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 09:06:48 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6cc9799b4c16b1bd42de35be563d4fa6ea43799

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

