Return-Path: <linux-kernel+bounces-207167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4172901322
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43ABAB20A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655601757E;
	Sat,  8 Jun 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL/gTqzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC691CA9C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869525; cv=none; b=O0JmmRxt/RTadpDxUJhBf9ZZXweLw3iuO3jmxnrZgo/HoSbXuEhKap0U1cejWB+L6zwmci6QxxiFStk3t+YZhvkZiBmWAcYkK1cHRQwSgbEMsl6zn7UiYkLgK+63h0JQt0J4j6SqOxHFZi/DBKb3rSqaxxzQ0lWduTRyaJLdoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869525; c=relaxed/simple;
	bh=fZAX2nfLXX5P3YZWQRDshYWd5pMbr2uLK5EPiHB26Ow=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d5eVlDgzVtWV21BZ9Gfl2zYdl5JdkyWmTazY47AKD5TKVFiFfNxyxkE51A9TPWDZ/LupIBNvvAnHTNf13Q4QVyc8RncIs8dMI4UsmHwQ8wOmFqZWAOv/sYT1aIzOwPjCutzzruqBWSSFBq53HQGxtdRL1WO77q3Micaw0EU9SYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL/gTqzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C9BC2BD11;
	Sat,  8 Jun 2024 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717869525;
	bh=fZAX2nfLXX5P3YZWQRDshYWd5pMbr2uLK5EPiHB26Ow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hL/gTqzJOP3ymHCURPkYkCqyXx0+em/LE/pTL9AnqRrjQxpaIeJKztiOIMR+Hb+kL
	 DSUk+08kxqq0I1nojq2yvk3chEo829ncu5TMA/txAMLX95Jc53PgatNmAWh3wubKpS
	 rVEhBBotMm+XdRfQA7i+nMOWX4JliZGTJOYuUDJpqEqIrqqjp9xK6x4dVLo72cAx3x
	 GvYid/469YdH3uCCi+sNo4DwDKKgOX+qiQ9G1jqIwP+aAWUC0vVxFs8/qB7trCTkvm
	 wrg3IUxYKWov55W4lhwB0sq9KXhsmkSuV1pjW3VczOcswXvQhMzNZB7/41DLWahFFq
	 pSfo78qolSbEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D1E0C43168;
	Sat,  8 Jun 2024 17:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <xaohohlelhzbc5a3hmrutryyeth3u77paq5w2skjqyahrusodj@ogoroplzq6uy>
References: <xaohohlelhzbc5a3hmrutryyeth3u77paq5w2skjqyahrusodj@ogoroplzq6uy>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <xaohohlelhzbc5a3hmrutryyeth3u77paq5w2skjqyahrusodj@ogoroplzq6uy>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024060801
X-PR-Tracked-Commit-Id: a3a5a37efba11b7cf1a86abe7bccfbcdb521764e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 061d1af7b0305227182bd9da60c7706c079348b7
Message-Id: <171786952496.31702.2542718315018499056.pr-tracker-bot@kernel.org>
Date: Sat, 08 Jun 2024 17:58:44 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Jun 2024 19:42:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024060801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/061d1af7b0305227182bd9da60c7706c079348b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

