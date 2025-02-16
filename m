Return-Path: <linux-kernel+bounces-516761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30622A3770B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A51188DA4C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C91A3BD8;
	Sun, 16 Feb 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRSt0Q1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE11A317C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732311; cv=none; b=u156SwPXRsA68w9Re2qT2RHlk71LiAzDQtxdj36g8tQDC2Aiq1iPHJteU2rMKZGaA6I+pSDQ4esIwTfSN0N/JDELcF46P7jngss3zjkidv7pGKkbyZu3blAZEeVPiWC8slu/rqaQf4Sy37PIZE4FuG7rynGY8fkGICkGQ5c1228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732311; c=relaxed/simple;
	bh=Tc8Dw6trGcA1rQYwjXhPwh5m7KJblFXveq7tdz3kx1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rbazuzm5XvZOT7ZaIooNzuYd95PsBiiTxfyUyZgK2BzHFuTWTwEaHu3De9AMlL/1/TpQuIBTaMId2jxmyo5+g8Txt6LXFtGTdjpV66FKCwGQG9/6PpVMLkMLc9uEpKN6C3tnmmgHNZjzegHw9IAgpRQuZhFVe34RO2ZiBdAuRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRSt0Q1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A148C4CEE8;
	Sun, 16 Feb 2025 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739732311;
	bh=Tc8Dw6trGcA1rQYwjXhPwh5m7KJblFXveq7tdz3kx1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRSt0Q1DA1I+fuxIHGTPjqjGdoA7wtW4eVyqhgpgKaSoyuheCIanSRA1pzFjLlnTQ
	 qilfGKJ0KuGfAWFs9TH4X/0KlDS5ckPWTuIVjwkRFdtb5jpD9T615yS8GfLAF9lKYE
	 x5iRZjIsGQOwkm/zf1veuRVXQRRzYShK8ujuzJyJyvuB63V8GTsrOXio7vMZM7XQcR
	 HmVFxf7ksbTwIIroKP8uA0Ffb6GkUW1AtNp5cZCkt6DzTyWbY8CBUUt8r35uQ6NhF+
	 LINuBb6eXxIDfkCyq8tOpja5mYKLYXjKgKNjIw4/rljqcUdPtYjTkZeMmivcg5wE7j
	 d0uekDIIiSSaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB6380AA7F;
	Sun, 16 Feb 2025 18:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250216094748.GAZ7G0RIr-bVZOHJ0i@fat_crate.local>
References: <20250216094748.GAZ7G0RIr-bVZOHJ0i@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250216094748.GAZ7G0RIr-bVZOHJ0i@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.14_rc3
X-PR-Tracked-Commit-Id: c631a2de7ae48d50434bdc205d901423f8577c65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff1848d81ca63e49bce57c29ffb12c6539333ac4
Message-Id: <173973234114.2551255.3300759296142493019.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 18:59:01 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 10:47:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.14_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff1848d81ca63e49bce57c29ffb12c6539333ac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

