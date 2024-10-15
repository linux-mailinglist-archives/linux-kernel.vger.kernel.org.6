Return-Path: <linux-kernel+bounces-366521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A799F6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0981F245AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32571F5822;
	Tue, 15 Oct 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRJbT8mE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613891B6CFA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019403; cv=none; b=Jt0vc1wYkBq2fBNnf/jVfgD2WkrQbouU+tWKvIsQPIlKo9+us4sgQyeB+DdV7gHKTDajYRyAsP75Jz/i22h+iTsEWrdXYvUgxCH6a1B6chqkJQyUumtH4iO2W0TEm7WFW1tr3Zr5zKFKdRGMTqMCrSg9tGfZYnTbvI6Q9C1AeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019403; c=relaxed/simple;
	bh=5iWXZ53rot+fSPM6RrRkbWjbUMnFmoDRwBgw6wALVHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Opn8hk611ExYSXSkau5d7FhC8w2JVMsWJBYRoUsoXxVbplLMQo8z/kGPLyt1MAoY3eZ5jZI1gXfZpYgjwQiqEM7eQHZKsoC04HsLTiC3K/cqEv9KZIQY0lmV6RnhRuK2s0Q0nvQOl8pKjzZu1YtEHVyAPrycl1Fo0m7Hb5PH7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRJbT8mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398BCC4CED1;
	Tue, 15 Oct 2024 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729019403;
	bh=5iWXZ53rot+fSPM6RrRkbWjbUMnFmoDRwBgw6wALVHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NRJbT8mErxCTPetFZ+EG5LBphTWxgW4n0P5H/QfZRN332NYu+IK9qs/qgLoYDeqaK
	 VxZYTkb0hbCHhmgmVrONUtuQrySNlPQgvneP3SGN+gjrY/VfxhowwIRZ524A0UeBNC
	 2ZzF/WJHF0uIgWHwSA/FfNtmI1r4DSavzYajMJFBTcgKyndseamIHuPUVPkvNT7irU
	 vY992M7cJPe8HFafmxmLHI+Yb46FOMXZBl3R+7uq9j5uT88NV2OSO3EetZBcWWxYMy
	 ZG88duHQFIJ0ORpkqf7NuhrwxRASwGb8h498E0j+kKSdpijKfO4+9QncrpyEF11wQs
	 nfYcG/04B10UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1433809A8A;
	Tue, 15 Oct 2024 19:10:09 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: A couple of fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241015113751.7cb18c09@gandalf.local.home>
References: <20241015113751.7cb18c09@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241015113751.7cb18c09@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc3
X-PR-Tracked-Commit-Id: 09661f75e75cb6c1d2d8326a70c311d46729235f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
Message-Id: <172901940841.1265868.10209805221015401129.pr-tracker-bot@kernel.org>
Date: Tue, 15 Oct 2024 19:10:08 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Oct 2024 11:37:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

