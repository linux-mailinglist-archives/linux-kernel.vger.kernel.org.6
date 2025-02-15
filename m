Return-Path: <linux-kernel+bounces-516010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9A6A36BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57693B24FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919017799F;
	Sat, 15 Feb 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy41Tav0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFB21345;
	Sat, 15 Feb 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592395; cv=none; b=nP1ras7YjGEgnp2XZGuv3mwuOjeMXN5dOav73s+sm9NQsaK19bH/3ihooUMapPVd+z/tfnKJogRwf4V1iZR6RhR1PcfrDArSWlqnqMwtga3BkTwcrus3Jk7zKI4TtlORN3xkhV4N3jB4wRpzaEOo3LFt8/T1czI9s7iLurithUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592395; c=relaxed/simple;
	bh=Y5cx3BzWy0r1NBmCtxKnym1I/Xf4ODvZRE9CYmKEmMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pbbeviyDLaSh8S88nEYF1zqfVwiCj52SuD+/SCXFBMmJrPGxPNXtqvmB7tG7P0rErciaDDjxFl+dH85NRiz3dULS95KyPf6f31Y8UGQOkQFIjFS1yz6R2tMfoLtIbKLK4cSbdC1AFM+Vk/IJpikXp27WX0e0qTfQ8Htz+0GXixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy41Tav0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CFEC4CEE4;
	Sat, 15 Feb 2025 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592395;
	bh=Y5cx3BzWy0r1NBmCtxKnym1I/Xf4ODvZRE9CYmKEmMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fy41Tav0cjL8THQxPs0qvqsTM0gv9znNGTU/rj05YjfDqz0OTh/HUwh1jbenTESyZ
	 eJOk7rHfTHREsyy1jhOqLdmfqGyDEK4O/3uVy8NrrCeGVN1F2eC2hRb6PC4bf3Eeap
	 zylZRn9KG1+7w1T0jU96eqMTd73kbf+MZIf0aa5VzAoQm1wSBSFcg+xDUNgo7VjtSA
	 5Pwik8lC+beM/uNkSP4Cx4zfeiuTBxKvlvkwIsN8UMjDGkQb61aHlRHLfGUBqTzNYk
	 qpul8vW8T6fk23BEMJ15W77aldHJxNAxnN/heNe7WDq/KBHQqyVqhbHTQ+5Rdr4SFf
	 bsDZu8aK7XMHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE48B380CEE9;
	Sat, 15 Feb 2025 04:07:05 +0000 (UTC)
Subject: Re: [PULL] alpha.git
From: pr-tracker-bot@kernel.org
In-Reply-To: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
X-PR-Tracked-List-Id: <linux-alpha.vger.kernel.org>
X-PR-Tracked-Message-Id: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.14-rc2
X-PR-Tracked-Commit-Id: 1523226edda566057bdd3264ceb56631ddf5f6f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ff71e6d923969d933e1ba7e0db857782d36cd19
Message-Id: <173959242438.2188392.17832954861309834199.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 04:07:04 +0000
To: Matt Turner <mattst88@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 16:34:18 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ff71e6d923969d933e1ba7e0db857782d36cd19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

