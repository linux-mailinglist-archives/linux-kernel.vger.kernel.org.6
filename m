Return-Path: <linux-kernel+bounces-198059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65AF8D72ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4EA1F21674
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C9748A;
	Sun,  2 Jun 2024 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdfV4cEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28F5661
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717289059; cv=none; b=O5/bwHqVk0bJtVXCk8w1WPY9uQ6IhVzAKlkF+EgmvqfZkBR/mjPxopWqjaC8poFCKr/XG52D5G7QWEQ/w7ydz1tojPI/+7YJADWVEFKtGauKSABkjHqeIQg31EEveVzwDouh6zGp8Aw8SPK+o+QtECGFdNuHsO9nR/7n+B/kGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717289059; c=relaxed/simple;
	bh=1QwaP8zO/f0f8TGpN9v0zzlEPBWVwQ8/e+DjiuAf3MA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DUEjJuO0xSlm3V9E0Hn2mEWLZD/JpfHNb3SD5Wfd5Ymi/uPdZJg6lLkRd3qwlqN6JZ0GKVyMkhAifNDJcb7+DPmqCrv8+eXRKN4+eQCFH2yvR2iLxCoGhFbvNakwRfxPHN4gIwqcXHF1Qz13PD1Apzb5aWRkL5nKIK1F7QdeCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdfV4cEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B542C116B1;
	Sun,  2 Jun 2024 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717289059;
	bh=1QwaP8zO/f0f8TGpN9v0zzlEPBWVwQ8/e+DjiuAf3MA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UdfV4cECj7WH21SvmAEzDdfmwBu8lU67QRLaD6EKFypWL6VKP02/1dPrGGN75CUg5
	 OC61AD1TynObSYCZTc7KH1s5H4NH5MFhrtBR7Loz5bBGhOh0Xag2+KYERMFNhQnSe2
	 DayGoHwWyixNUdmaOz4kAuEbBkPvNEx3YJ3aU5vquH0SxfkLnKn7Pj/9D6+Qwhf+4i
	 7m/elt4y3WMgwui6F8k2QLd8YHZ9WiWlgjKppXiERVWVf7dSxOBwfYuN6Y3Add4XHI
	 6Gj3OHU9S6gsNEGqq5XIihLtz7RCPLYXYb0pi60kexKaaoPI0uSUp8oPD+8Zf+bTWT
	 sWpUIjLz9ci5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 022E6C4361B;
	Sun,  2 Jun 2024 00:44:19 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240601234350.GA424664@workstation.local>
References: <20240601234350.GA424664@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240601234350.GA424664@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.10-rc1
X-PR-Tracked-Commit-Id: f94b77709e82242c1101e59a90a7807455c4ab2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54bec8ed5732339438271d07376890454fa58046
Message-Id: <171728905900.19494.12873760797572412462.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 00:44:19 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Jun 2024 08:43:50 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54bec8ed5732339438271d07376890454fa58046

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

