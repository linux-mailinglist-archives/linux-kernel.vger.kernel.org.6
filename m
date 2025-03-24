Return-Path: <linux-kernel+bounces-574399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550EA6E4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EACE18977A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D11F4297;
	Mon, 24 Mar 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd89IWan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D81F4276;
	Mon, 24 Mar 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850037; cv=none; b=ljPS1GN2B9XxQdJV0cvX/z4DxeaLPsZDVGD9b/TiGVhNAIHmVfkvyhAtonzgAXNBvBc5cowGOLDajTQ+VT+IPIkUYF3sG4zG88jKiKrOo0C6xa6BH7+Y5yHrEsszQwkybMBpsI+ArqDueZQiPrub5dUSA4pDe7g8wira4vsRbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850037; c=relaxed/simple;
	bh=JrIaUP2v2TnIs16rlc3lWLfutCQd8a9OOWtcasg8QhM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CDtA5I1yTcnUY2ODD4y1rP7qfiFp5MUu0XeI0Q5jF3ZWzLTTs5pRvsfe3LU5ysF+D4/0kiGk2chzyiPezzsMpZzKuqjr36FDhgvbEFBQULvLeW1Z7aPKBxPNXVlZV83pp9M8psnaBQnn9JxwugNxRLAmMiEvon1eJPfTSJ1PqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd89IWan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705C6C4CEDD;
	Mon, 24 Mar 2025 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850037;
	bh=JrIaUP2v2TnIs16rlc3lWLfutCQd8a9OOWtcasg8QhM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bd89IWanLgnaugxHSOldyTD6cljqEAyvW5ymH3Go8P7JMuUrKlCUGQwiH1VfK3QgC
	 tCJ7UXNvlnzJ5g/55UGUYhEnCYbC45kbVoLk2jgPqZUcHQf3gLp9c8kqUAJoAuerPv
	 e4fAT8NyzosCdgsZ1CRqpiRt3vPwFDJFJ8LAGkN8cqyChpI2CNzxeIBGbjKGh/YTO6
	 cEohTIUhAL2z/oUorE9rMITqXgBhLwAG26K7Efxm4za6kBCsyH0jPC6T930xNsAFSa
	 O8XoOOQ/x/6GND37VOftONoKvvYHsycU5JCEUwpJoLRbS0BfSo3JYs4tjJd9Fq9ChZ
	 IgxrPwoWlmpTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3AC380664D;
	Mon, 24 Mar 2025 21:01:14 +0000 (UTC)
Subject: Re: [GIT PULL] vfs sysv
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-sysv-abc5d9a610b9@brauner>
References: <20250322-vfs-sysv-abc5d9a610b9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-sysv-abc5d9a610b9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.sysv
X-PR-Tracked-Commit-Id: f988166291e035f315ee8a947587f7a3542f1189
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaca83f7b13fbe54c853f63eca9e849e6b441459
Message-Id: <174285007371.4171303.16689276162255717806.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:15:55 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.sysv

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaca83f7b13fbe54c853f63eca9e849e6b441459

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

