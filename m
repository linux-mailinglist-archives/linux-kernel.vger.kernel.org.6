Return-Path: <linux-kernel+bounces-255863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6E9345C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF54A1F2209D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8730C6F2E7;
	Thu, 18 Jul 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK+kNfHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CD41C7F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266039; cv=none; b=Ih75pr0M6rvbSdrCiC4Hr2va3A/4lvtHwXVDoOrthlNCx5oO66A9AUu8aLo9zEHTMY2JuqNuX2cfCSVlgmeDdhH6ATfcT7meFnJRCVtQJ1zE2M1QDkNvPmSXboALPBc2m8ygBstayzVgusF1XXQBQGgs4YBFlrC4VNCMfpySS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266039; c=relaxed/simple;
	bh=JO16FKA7RowewVKySosCmPIRkXc9ZVjlAO+1hSh/HnI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dXBFS8VyT16Zm9VFFQFeDO1OQN+TQe689I4chIKHs7DsGJpByBzztxhT7IXCCYyANlhh6LiOTE8ysmMScH3Y5mJATPE4AVYX52fcFVvmTOsiFzE/Ysv99P2+jvfpYYOn7kuBKxJOPrjdGdhxgRZDJyCtdLi+Bgnsgmd8p6pR1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK+kNfHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C3C4C4AF1B;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266039;
	bh=JO16FKA7RowewVKySosCmPIRkXc9ZVjlAO+1hSh/HnI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZK+kNfHb4sKhxFsslGD3hQ7iwfRfukwT3g5kaSygt9nTVczQmz6EJW3r78YfoQJkE
	 +gpAHhiO1Z15fKxQnHjCj7ABuUFlYAB1CwpmX15SEHS3VvEiaqU7eIKpm2+mLvV2z+
	 P9to8Y6I94kBWqghbpg6/uG+FDcwezFhYTy1EEHVjzN5OIBFVHhRANv+3EPv6lzvsr
	 RojRYe7F2FFfeq3wmo8fs0zf2LSbcCN8TkypCAkzqGYSrjyMcz8lr4ZCYDfKjA/EPP
	 AvShy+hN1HF2Vli2qnaEGQ7DtndsvHmfTM+EmKa4nV4Wmo7gXBo9CfWaoquu+d7LhN
	 IDENB1NMJICmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EF04C4332D;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716142242.GW501857@google.com>
References: <20240716142242.GW501857@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716142242.GW501857@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.11
X-PR-Tracked-Commit-Id: b0eed397623f897d3ccac9bda2bd2f53331b571a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fea17683c4fbb06a727cd94abf4c9588a580ab12
Message-Id: <172126603945.24030.6318595219589549681.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:19 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 15:22:42 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fea17683c4fbb06a727cd94abf4c9588a580ab12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

