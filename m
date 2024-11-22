Return-Path: <linux-kernel+bounces-418812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC50C9D65D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A3282E96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C91D432A;
	Fri, 22 Nov 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+KuFxCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60761D3566
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314754; cv=none; b=O69DQlAIi0CCTchOKQRNQAnyWbntMOZ7Xj5L40PEQgKjuKwRgdOhHGZz1TkjlTyf5KaSIm8SuFOW9kLeBdjZM3C56nn/R7ELK/WfSHNEShmgtmflLg/Y0dN9WSq663rn1KMNmpqIsI6uRlf5MQYj2rhSjXoX9AdTaf6hnwnGPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314754; c=relaxed/simple;
	bh=9akPIJHhuskV7nG4S5jfjn0aOShiz6X9SQBL3HOsRso=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bLgLZairPQTrNsbOvL5n1/Fl4rXMohkXY/gP4d3PkyzqfolmqWpvELlzSGbLh0EuPZSumpiT+PMTk/DIKCRTOy5GPdLzcK7TpmIqLvxA8OQV5xKFGjJerW8U0hj1i/2G2YwILcvf/r7bRiDLkP2rUkGRHIJGbUUQ4/pBxj0VTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+KuFxCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FF1C4CECE;
	Fri, 22 Nov 2024 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314753;
	bh=9akPIJHhuskV7nG4S5jfjn0aOShiz6X9SQBL3HOsRso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n+KuFxCAM7yq4FeX9VQ5OrWxqcHaKLP3QlHDpGtTXxKq2VFNxvszjtP0o6gehFRm0
	 y4DwSiAr4ZLX9xkYYu5Q0baXAQxQi2McjdrCkx9qzw9znA7aP8kC+9FoYo96FaXAga
	 qd9SMjctPDeQWmCCHMaVizz0nSdfbOlrvuzuGvKXY4jvuiDTJnxW3ZD46/gaa1J0/A
	 hL89jGuoPVLSNUzvShk4omBedQltkyekUQFPbO1kVw21JEnVPfNioUvA82YI0Wzzl+
	 ElnlqvnkK9aJXLKgI7kwqE5EPXCnpqTEYlTaKwkRw1D0Wgeol6LWgwQ3/aCjqHmb0c
	 dMFzbmXbZm5SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F4C3809A00;
	Fri, 22 Nov 2024 22:32:47 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120214531.45d75a60@gandalf.local.home>
References: <20241120214531.45d75a60@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120214531.45d75a60@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13
X-PR-Tracked-Commit-Id: 45af52e7d3b8560f21d139b3759735eead8b1653
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06afb0f36106ecb839c5e2509905e68c1e2677de
Message-Id: <173231476573.2827182.8857506377145057131.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:45 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, Jeff Xie <jeff.xie@linux.dev>, Jinjie Ruan <ruanjinjie@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt <justinstitt@google.com>, Levi Yun <yeoreum.yun@arm.com>, Li Chen <chenl311@chinatelecom.cn>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ryan Roberts <ryan.roberts@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tatsuya S <tatsuya.s2862@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>, guoweikang <guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 21:45:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06afb0f36106ecb839c5e2509905e68c1e2677de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

