Return-Path: <linux-kernel+bounces-178114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC428C48E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CE71F242FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C41272D6;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEaRZr++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B186248
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636018; cv=none; b=Ilml8F560Y+JRNEqRjCryDNGULQlIle4FHUBmoKhAoXFe9+ZICd6wbvEHqjfOfz6IubZ2CdrU7ZDtycrN4y8Q4iyDP1naVgMcYb5FnKHVfnKbQc/CUUujFVzx1XldxymqFR25FJbnF+LQLP5n6rWCyQONydRzx9jgwREQ6HQrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636018; c=relaxed/simple;
	bh=qSwCsG/UKqWSg1QH5yitDmeyRfd3PRrrpUs6fZ2n/bU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T5Aj3+GWqNaurtpRk31DXMSNHgPu3GF9fUmTYNwsBB0jKW5Mz25ybQTIpUETtvDCnxghXfqZRbKYhuM4I7+XARPuiTtDEBxHSR61BB3XJsNXeIO8d13i9Sd8WG2Z+NpXxMcAVlnXb5x0/JVAcoUYfnbxlAlY+uGMdpkJHKFWKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEaRZr++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C530C32781;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715636018;
	bh=qSwCsG/UKqWSg1QH5yitDmeyRfd3PRrrpUs6fZ2n/bU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EEaRZr++fMKyMDUh7SpHE/d5vSGvZ6VYVndWRZWMu3s7SkKaOYM+8+xv06FWriCkY
	 SnOpt5PuhWGnGkmq1PWMWcZpTAUogCHo/9eUYnr/oZf2fEYkYl+ayM8jrH0V0WbgdW
	 1y/HfC7ee3PHXWpANCuGyCjhiPjk9NfGvWGQFETP+ifEAeULAiPEyiQZApeM8/i3n8
	 Ug2xFOpe+YbscJF2MRPaFHYYZL9CYb5najBomuKVQDu3tmkNpaIoc8HkawkLC16SZQ
	 xFLKDjg0YAU7StsYEvKopoQN1tP6PQ1WfOuRtnXFYUJvJS+fEcjLEtS6+qBfHQol7G
	 0/WdAIwd8dUvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3C67C433E9;
	Mon, 13 May 2024 21:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202405111224.433C7AEAB@keescook>
References: <202405111224.433C7AEAB@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202405111224.433C7AEAB@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-6.10-rc1
X-PR-Tracked-Commit-Id: 4bbf9c3b53e637eb3a14ee27b996300ce88e752a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92f74f7f4083cb7b1fdab807cbbe4f5ece534fbc
Message-Id: <171563601799.15304.2529127000817275744.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 21:33:37 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>, Jini Susan George <jinisusan.george@amd.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Vignesh Balasubramanian <vigbalas@amd.com>, Vijay Nag <nagvijay@microsoft.com>, y0un9n132@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 May 2024 12:24:23 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92f74f7f4083cb7b1fdab807cbbe4f5ece534fbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

