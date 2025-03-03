Return-Path: <linux-kernel+bounces-542521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DFA4CAC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1D73B8B07
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FE2163B2;
	Mon,  3 Mar 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E627dgP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321F215F61
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024623; cv=none; b=Lh+FDfC/6cTbutvoZlH6PRqkFD/w2AafRl1i1iebVwJHVeSZ+FSIASCANRKqMzQGuY286uHHsMl1NelUeMCYBydr/dCdFwxjEitSb+kWL0Wy4tL4dL0Dxas9CHV6Shx4RHxvuZbMPJHnnisXpUaGqWdn7SULjvQaN/8LiqPjR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024623; c=relaxed/simple;
	bh=EnkEjPJJ14sakAvRuvpBAn3ogLqAHieXi4O2vmsFT+8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G8es/EqwPmdFAiwZqUb6GJEchDEjioqKczLl+5wr1VdGfWkCGDVlpQ0OO2GhdvTusK/tdPaEbRriVTbn7dCGP2sJ23O3BZgkhSSNugv0dqOa8Mn6gJZvsvfBvUtFUZZAyrLDLlmyBIy+C45tTXup9lsXzCHHrYR7/0/ECyHDS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E627dgP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C372C4CED6;
	Mon,  3 Mar 2025 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741024622;
	bh=EnkEjPJJ14sakAvRuvpBAn3ogLqAHieXi4O2vmsFT+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E627dgP9VvKJOYZbwk6Sxi2AV1vOkl5TQhwhELy1tF6h198AFJs2xPO5N2/c7DIhy
	 hQ+DyjVHiwTv9JpZcH7a8F9NZ5XtZ9wBNGDq3gnUoxQSNjhD3bsPKA5ANzR7kQql8e
	 c3s32tIH/cxUb67Z9NIDpu9YF0467ViUzoKEYu9rAKD75QYSWghh67RC6IoiYmbEg0
	 cIeL0gVHflhRsBsvB/z+SY5+t/jGytqNXG+2tFr0NvqImybWvzmygQppiK2YTrA2Dl
	 Pp16XkkI9RK/dt5sAyN8atlPoGx+D6qKsBsi0WhwZrOlOnijplXwTrDYURA8HK9Ozu
	 k/1ImQQ9z+olA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6A3809A8F;
	Mon,  3 Mar 2025 17:57:36 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250303130912.f5c90441a656c84edbbe5ba2@kernel.org>
References: <20250303130912.f5c90441a656c84edbbe5ba2@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250303130912.f5c90441a656c84edbbe5ba2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.14-rc4
X-PR-Tracked-Commit-Id: fd5ba38390c59e1c147480ae49b6133c4ac24001
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26edad06d5c34038c5d15ee082c80a62dcbd74bc
Message-Id: <174102465497.3669258.4075723104283692956.pr-tracker-bot@kernel.org>
Date: Mon, 03 Mar 2025 17:57:34 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Mar 2025 13:09:12 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26edad06d5c34038c5d15ee082c80a62dcbd74bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

