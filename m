Return-Path: <linux-kernel+bounces-551947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C2A5734B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A283B167FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB682257AF2;
	Fri,  7 Mar 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZvt0BXD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DC2580C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381427; cv=none; b=Gi4TYQ05piL/39MTMuyx214fUR/FhsTkTDzCfFcYbdomAFvg28CD1Hgbd4Cf8J39Gb8zrCAxQW6kE4+yigwOIbBTqLhVjbLCFzI3sDIX75sVOwHhM5BeBo5OwFCY0+Go0yie6YFqzDx4N8l35Vs462dPeOqtzjXdMHoB4veusfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381427; c=relaxed/simple;
	bh=sfAaqcrlmBLKJimMZdMrHFEsVBgIWQe8WvQOQxX1N54=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E7zPJdWTYYxxS81CmR0oOFme4DzGOS0/0GDbHaOcs24cIk8hthcENuoP1c8BxMkY9J8P+/0cEcis0DjjJAwu7yo/3ARZRZmiySfevh/0filc8lu0jQhxo+SCuX9rX7hUpfJ04GdLMifWgYRFRtQIyKNTo5iF7bE9LQwu5nMAbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZvt0BXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE2FC4CED1;
	Fri,  7 Mar 2025 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741381427;
	bh=sfAaqcrlmBLKJimMZdMrHFEsVBgIWQe8WvQOQxX1N54=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qZvt0BXDkvB+5Pmzl0qRv1JffFj5htbX034rX3QzPexddzt+IYrKTe3sxVy++HMwC
	 TD9xb+Fyf8EToTLDYmQfIHcfuvbbB+aYpBVs00V6MIJT2NLRDjfBr/86+/FArArI7k
	 g2iIFaFgRhj++Fma9heKJH8dZ715D3BlqT8i11v3Nmcy4PtMsC2ZJTHquQngh4dxRF
	 KTEHsuEHN2eLKJ66PttB54kPShi+Tlh4ZRG2NNSNBrlIyW0KSHTr8D8aWwZH0raXw8
	 04UmZrjOKgf9F0zkcSykytd1iP9Egf13qIjNFT8sUpU/wkgnXtsyfyaz9PwAhhwgin
	 S93FXoDvIz5Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF1380CFD7;
	Fri,  7 Mar 2025 21:04:21 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8rls13KRGROvcZ7@gmail.com>
References: <Z8rls13KRGROvcZ7@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8rls13KRGROvcZ7@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-07
X-PR-Tracked-Commit-Id: b1536481c81fb604074da799e4f2d2038a1663f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c5183aa6e74a0817c3a370e6a94e460dbb00098
Message-Id: <174138146040.2483503.1160039449101039784.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 21:04:20 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 13:25:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c5183aa6e74a0817c3a370e6a94e460dbb00098

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

