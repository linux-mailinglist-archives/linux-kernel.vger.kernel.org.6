Return-Path: <linux-kernel+bounces-180531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE988C6FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC2E1C21D69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C094A0A;
	Thu, 16 May 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTdf/XJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9414436
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821023; cv=none; b=Bbb7GjcPvstnZnNioz14yJuZlajuOFl8xPTCc8iAYUVSP0r7HFnG+hVsqCCsNf4XvhPdsdfD9wXJd7WV9IPycBEynRnr42OKIz7LzFCHUiMD2VnXxXa7MGG6zQC7vEqZ2/G6KUtudJ9UU/uer9+I65olYkmGlndVKTZWrzvzxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821023; c=relaxed/simple;
	bh=uf7I+5F7qdVmhYMv9+0yEJgDV30wZtJ/tQBi/NlUPwQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NslGzjZ2VoZ9oXN+nEFSumCazl/YhEO1YzsTjc4tLAiwu2CJ6vhm1c8/oSb0EJeC34Aj2Igxyoj0b96w3l8k86oNvjucn2HMAnd74AdSbAZIsY82Rqc2e925i+lgFHFM+rlAfsC4ic39tTVQyYmJvCyciAmisqid0tLU0a/Qokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTdf/XJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA2A5C116B1;
	Thu, 16 May 2024 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715821023;
	bh=uf7I+5F7qdVmhYMv9+0yEJgDV30wZtJ/tQBi/NlUPwQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qTdf/XJPYD42JvxJv7qyZOzYzAGMwS6cGFXM5MIzp428RbyOYcNB6je/bTLOiNaGM
	 hweh4hfgQyEcXte7Ws5D33NKfeDUYFQAytvt7FZzSa6Z+sl9gkfqw/dgTEKDDJ4eHP
	 ATQka7KqGydTeH8CnVFbPuErA6C9j1KUFPmcjHGkQVW84CLpb+biP7DSAGub+v8rzs
	 l+v5ivDHUjqNdl48RhTw/VDTj81xlxtKQMPhimuh/pozFJOFUJyLkwvWIkLGedXRbx
	 xGJiHeHyBdCeA/TJ2zAhTnzxdQdlTA4k6lXBPZ/pU/bQfuyNiUkJdcf5pxyUYW3Z/C
	 nev71yq1YYI0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E22F2C43332;
	Thu, 16 May 2024 00:57:02 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10
X-PR-Tracked-Commit-Id: a2a58909cfb5fd5e9f7bb7d954eec0a32fee3f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
Message-Id: <171582102292.27993.10040981159302501980.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 00:57:02 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 12:26:26 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c999d1ae3c75991902a1a7dad0cb62c2a3008b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

