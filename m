Return-Path: <linux-kernel+bounces-344772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AF98AE21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C3D1F22705
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B4199EB1;
	Mon, 30 Sep 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAodx1mL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D11991D2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727704; cv=none; b=GondL51eVjNbFStxw5M6wNGr8BHysIfEXPUYQrqC5KM6M1qJxHlwWlhW74tCbjQfz5VaM1z2iaiwIMPCXyQhywKlM886nwOnMjRcBdZn/WaIBHYz9FcVDTU+x5JgUdb2ph9SLMOuu6fsckNt5X0knF/4fVrHBGLS31vtSgZ17Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727704; c=relaxed/simple;
	bh=Ix1/J8/ZCM7Rygz3fmAmmwGlPzX9/owS4561k2gM2EA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZOl5TmfYtKFDwT1NUpoEAuD9V4kup7PwLO4HhLjCXPH2t9do01RVc8NLGsDZiymBrrtQaW5TmMpk1dEUfk9kr+BY7jtknxnpGNHx8/ypHOjno9UY8kAdAKzhLJoJLqO0mTHVsSaAppDq4/apb2LpKG5vnnthFbIkRvyTohfsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAodx1mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE4C4CED0;
	Mon, 30 Sep 2024 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727704;
	bh=Ix1/J8/ZCM7Rygz3fmAmmwGlPzX9/owS4561k2gM2EA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MAodx1mL+TS2yK2TE1EDeiuBynMTMsKMDKXjP2wCnBuwVxnCddyLAee1PmbqUbdow
	 fsFr03ADoTpG67hd+60XJHoQxd7jraF3uTY1a3I5fHABti3uvoszE6XsQM6ib3P0bb
	 4FQ0BoirVRMX6spZjX95sm+Cf/ITTvkiCNjXRk8NWB1U75zAa9DS0wCHl7TVGs7cxK
	 EQ/Ip4sgl5omy9iC+7W8yZvPVgIYFm4XMnVvssY6Z51OwJKfY9qNXLc23D7SVmPshI
	 lJ5wMzM45W+FjM+OilPKPjACqlIily354PxPx0Ouo5R824uEH2SJMBvhuF4qUwoeYU
	 2QOc6v3OEHHQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E573804CB9;
	Mon, 30 Sep 2024 20:21:48 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241001005322.9e65df06e0f7c4aac19337ca@kernel.org>
References: <20241001005322.9e65df06e0f7c4aac19337ca@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241001005322.9e65df06e0f7c4aac19337ca@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc1
X-PR-Tracked-Commit-Id: 34820304cc2cd1804ee1f8f3504ec77813d29c8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 190ecde722dd0531d087a9964537560aa35c769b
Message-Id: <172772770691.3918229.5899088032134158398.pr-tracker-bot@kernel.org>
Date: Mon, 30 Sep 2024 20:21:46 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 1 Oct 2024 00:53:22 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/190ecde722dd0531d087a9964537560aa35c769b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

