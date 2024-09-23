Return-Path: <linux-kernel+bounces-336364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C4983A33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819FF1F229C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71E12C473;
	Mon, 23 Sep 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX2n41ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1334155759
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130891; cv=none; b=aTTtkq8e4Auc8USUqsPP3R4HxxeYqVvlcJFFv/z7RfvpbM38/4xiYkWXXZC1fLHiFjr1l8WQx/44RnxjlL2jiX4/N4g5QSriW7PX1VC0cYEd1FKuOEOQKqPMPWEewl6bcRXj+y7pah9r4Mk3QVaRAcyJ4EcbGk0EYsgICQxYZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130891; c=relaxed/simple;
	bh=JLCk6Bw+l6ujro12N8C7eIxDP+q5JcwkIsbzzAubuLo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AtTCgjtI7bpR0/qE13HR2KMuPnTZ90zlKytCp8+X+rwcObsHDCkriC78OJp8qbgVu5C9RgiiTKXzxyAQkIjoOOtPbeDeGj/jdkEIS0EtexnJZtaVvlt3ykmSxDm27B/ykdA8B93GQ5mTEWIiD66cb1pXrClzr6b+9VjKk0VtKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX2n41ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93026C4CEC4;
	Mon, 23 Sep 2024 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130891;
	bh=JLCk6Bw+l6ujro12N8C7eIxDP+q5JcwkIsbzzAubuLo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mX2n41gaIrnEEmajBYbo5MligklwFb10OL3qRpT749WIk5uiwkzNXSKXG05bFuwtD
	 HcxyE1IjJkxLE8q+rQMttww2asOo/a7j1UpDJ+5WUThJeVwGaaVYvSoI4JJZDMt+8K
	 McNofxsqHhew3+aD11TpRsJa14HZLV9TpkbGsU1DBp9qdenT5TZILOP0Vn+hI228Xb
	 W09aPxxOsVltYx1iPtCOFef2cg2pvVH/PtuwS7TZTnSKqk92grEOSoNo55VJdbapte
	 gkdr8bF0COc69SBHfnTRBkoXDlcT9FOJGZzQRDSsfhCNh1qyunTJCLx3tKIppuK16T
	 L/ehF97DbDZNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339D13809A8F;
	Mon, 23 Sep 2024 22:34:55 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923155948.GC7545@google.com>
References: <20240923155948.GC7545@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923155948.GC7545@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.12
X-PR-Tracked-Commit-Id: fea88a13a5d14b9f56fa338b47f2044806b3e64d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20d9ba738b9696ee882c6ecf55cfae8fb8b64040
Message-Id: <172713089403.3509221.5834518210742847736.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:54 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 16:59:48 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20d9ba738b9696ee882c6ecf55cfae8fb8b64040

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

