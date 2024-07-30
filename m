Return-Path: <linux-kernel+bounces-268179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037C94213F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DF7286B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318318DF62;
	Tue, 30 Jul 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKVi3rFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038618DF86;
	Tue, 30 Jul 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369754; cv=none; b=ecf8WkaLvswrmS6FCBU2Bh4oR6skMObil2CLSSX2l7VNh2fc9m1KWxi9xeaHj87jlq1DmSR5cPC8broxpz3bxEwEMZBeRu6CamKFxXix2Nc0nYotn2GwR856TPjMfSLfD+w/9KgynUotZpiaH5rQJK3OH7ZORYoi/Jdbwp/axI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369754; c=relaxed/simple;
	bh=Gd2Fy99fIGY4r+kREoRRvwhoqt6nSW69Q175nJlSZyo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FYd1BiUj1+frp/TP72WDezKUOmGKcMPID56E7w9dtBUvO0Ms3xW9OKnVPDbp35U/2zj9VnIxDTNsm9/ssW2w90fd+OCx1Q1AY5YMVdSoHJqSWGCQzxB+kXMFsb6+CbXleB6M3lyJcmlIxYRVcy6KToAInG6s/ldDL7/Tu74AvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKVi3rFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AFA5C4AF09;
	Tue, 30 Jul 2024 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722369753;
	bh=Gd2Fy99fIGY4r+kREoRRvwhoqt6nSW69Q175nJlSZyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZKVi3rFaXB81F7FzWvO5Hq2nuoZEBS0iKVLAvtFcTCIu5hAfYVr4t3BlPE4sG5m9u
	 YpjqCtPRead6Q5Fhg9Y2GrdYpdtJLqKbSlXftC+kLNJHutw8Lohsr4nYtIW6N6wrOh
	 D0Ujg/QRSRI2S8OZv+CqZZRYGfK8TLIIsJUNbPnBb2i3DIixYjqrkCMzBjI+u3ygM/
	 hj4Ef4csBmSoCg+rkZATEloJhPkQzP3ASL8JdcmrVQeOPM2LFrOrwEIBYP5sFl+Uc0
	 siCvKoUo9H611KizylVmmzvdxwsHZ25zw9bYHXnpVZZXUQiVt5Q7lKSp6ggNhAKsL5
	 1oYxBoAwcX+Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70830C43619;
	Tue, 30 Jul 2024 20:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform fixes for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqjX1lwASMRAxAdm@tzungbi-laptop>
References: <ZqjX1lwASMRAxAdm@tzungbi-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqjX1lwASMRAxAdm@tzungbi-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-fixes-for-v6.11-rc2
X-PR-Tracked-Commit-Id: df615907f1bf907260af01ccb904d0e9304b5278
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c91a7dee0555f6f9d3702d86312382e4c4729d0a
Message-Id: <172236975343.13037.11306936190508339079.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jul 2024 20:02:33 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Jul 2024 20:08:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-fixes-for-v6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c91a7dee0555f6f9d3702d86312382e4c4729d0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

