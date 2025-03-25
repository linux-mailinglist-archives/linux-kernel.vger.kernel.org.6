Return-Path: <linux-kernel+bounces-574674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA0A6E859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B9216AC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E218BBAE;
	Tue, 25 Mar 2025 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/4mx8UY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480D189B9C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870085; cv=none; b=Y5hSRIfpvT3wPeBcgvIXnJZcf+c8yrZE96AqBANHl61z8h/cUzqlFvSJaDI3MU3jMDtDgOaW42T0j8rI5C9vF/OkvueU26HRx6lsFADM7/+rx/LxRMOVIeJ00giGOfaDjNcrJ5AO6aSyu6JC/dcuNhMdKOMVFkQTIUoX8gwX1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870085; c=relaxed/simple;
	bh=jgMDEBcQBt3jbkJn0sj4GlL7n0bTuplnEPoorcFUjf4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p0BvYnem/gGx9HsV6aWvjCWc2nyxi/zQ95Ww5UOW9P7tdTaEw9zi2zyEuMjVUT1sSQi54tSrtS05c+VcMpQzbL+LGVESlxU9kX5lLtaoZwuMGxl/5v6OqPp9zEkEej/RRWe/BnALWErXZtf42lv1yx4JJCF5ROAiF73M+4fhF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/4mx8UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E79C4CEDD;
	Tue, 25 Mar 2025 02:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742870085;
	bh=jgMDEBcQBt3jbkJn0sj4GlL7n0bTuplnEPoorcFUjf4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q/4mx8UYJ31XV/vTrSvzxUBfVvhhzJFSbIeQyXFnTz5X4Z+Y65wyL2RvOrYoEpZ96
	 0rMrdFQjMAUozTBFpwPga44cQgCA9VF5qyHsra/BrR//dRECedknT7PrCUP+ab0vWV
	 Z83f6a98bntF6qBvhXH1tuC/6TnUlfGJ78vGng3Zof0nNoSlLIiArUGIf/ppU6D+kl
	 maWFMnDwt7GJqRuk7RAEgxKyiwgbfhX0nyuRkuLmsNl6wbdoiPPVUytjGBvZXXQENE
	 pNqJcmQ/9kxObDAEQKnFqmbKTBxHzBr/CNcmmiS+12WrHjS3o38lHjeE84eLwWuU4g
	 +6NzVPgzFFftQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34224380DBCD;
	Tue, 25 Mar 2025 02:35:23 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap changes for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-GTL4MMWuQ_dw9W@thinkpad>
References: <Z-GTL4MMWuQ_dw9W@thinkpad>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-GTL4MMWuQ_dw9W@thinkpad>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-for-6.15
X-PR-Tracked-Commit-Id: 1cf8e152e8c909c2d6c610b35278a7480af7a156
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f2d529458523f6d889a926623f4ddc7de4df063
Message-Id: <174287012177.62635.10605404663261510072.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 02:35:21 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tamir Duberstein <tamird@gmail.com>, I Hsin Cheng <richard120310@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Ignacio Encinas <ignacio@iencinas.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joel Savitz <jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 13:15:27 -0400:

> https://github.com/norov/linux.git tags/bitmap-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f2d529458523f6d889a926623f4ddc7de4df063

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

