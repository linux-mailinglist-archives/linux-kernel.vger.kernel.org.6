Return-Path: <linux-kernel+bounces-310014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87F96731C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B845B1C214C5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51018130D;
	Sat, 31 Aug 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1r3Rv0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC014B971
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725131638; cv=none; b=XUqxlXd+HL9AGghMKtZL9xQq/OxlR6Cb/mwmaXrzZCgO00Pw9ycFX563Yr0mCxM8cE7atGLdcmo9ZSePNtuNilU6FDRjuC2dzn7GC7d4adqquFDmuHVeyK9+OHc7CO12dhE1vTkcJ8M62d3mPbt/6pH05ad0X/WuWaqMdsQZack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725131638; c=relaxed/simple;
	bh=U6T7mw1d4OGGfnaoEfzpw2v28SOTPVl5mQaHULrTzPA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ltNpMl1Z3KKfW5n62H3V/2wA+p+hPBRL8IFxAolBNCpAcmOH+DHRm6aaZ5oxK7VIvt2l2fB6uhh/QCw0czYaavS/KP461Ct1F+wLbPU5bbMTgahUMJk6bsTkuQH4p6pp7LEkpJk1sec3qNmrcvCiEW4Tsr+gbJIuBkBXDdWNsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1r3Rv0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B33C4CEC8;
	Sat, 31 Aug 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725131638;
	bh=U6T7mw1d4OGGfnaoEfzpw2v28SOTPVl5mQaHULrTzPA=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=r1r3Rv0R8G003aS9kDdGn28HV0AqNG28f4jAM+xxAf+caHkeWcs/j28FCa8j5KWMp
	 aIji8PITGZEozd6UR0ss4PpUOHvaZrF6LAFggU7K0uKAW0Pz9LNltzrwq7CFHM+RmO
	 rZYTXM1Rxw2WQKGMdXEM12ckcjz9616MKAfNjWXnRfA85YV5G1xZXaKhTUQr41KH0l
	 NtnqLqNKRx15LiJVHKRAJ01oCrl4+FgjGERawsJLAWsJOzKbrvTEu6NiQFTdWmm4Sq
	 qT9/enn4COu9SfRZPSBeD+RG21Jq5jkIUXKfED3R4c1t9FmnymQXQHhPZO339NI71N
	 5I5Nf1pZiLirA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC53809A80;
	Sat, 31 Aug 2024 19:13:59 +0000 (UTC)
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.11, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a0cf5f32-3250-48de-bc04-445ae1459b0c@app.fastmail.com>
References: <a0cf5f32-3250-48de-bc04-445ae1459b0c@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <a0cf5f32-3250-48de-bc04-445ae1459b0c@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.11-2
X-PR-Tracked-Commit-Id: 9cc7b1705141d1a077493dc107ed626e8dc84681
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35667a2969d80a08b1df4066cbf282fc5d875cc4
Message-Id: <172513163846.2915779.8366939144023883866.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 19:13:58 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 Aug 2024 10:03:51 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35667a2969d80a08b1df4066cbf282fc5d875cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

