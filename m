Return-Path: <linux-kernel+bounces-335210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012CD97E295
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18BC1F21A20
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0940C03;
	Sun, 22 Sep 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASuDiuLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26836AF2
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024318; cv=none; b=OjFOkjjKz/2uN7lPbOCHJOCO1uysPkUdu1mGjPOi5DOrUN+eZ76pIStYwodETNkoIy2wt4tj1AdRCkVUShkH7D3K1f+weL1qId9CBCr5AHpw/1lAsyfDfAdtX0ud7fpUq1pSYGch34ttWlzigOPO8XTGEYvlr1yP6/9yifa2ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024318; c=relaxed/simple;
	bh=OheYRyaEoEo8MfIFPonqCUOtRbZhQm4U3MpWeEXA6Es=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fLJq5CeAHiHwe3JRyemY26dMup8Tp4mKsi/HV8HrVpFAU9usGRX1pYY+JiiI8IQYkWKpbrA/fjqe2oZspF10P3TP/c7/eAu6K9wJk1yqlKmNiNKhRzJSbWS1IoOeCU8d6gbSiIQwhh6hXsUetVlplnzpLqrPONa9E9U+OIJCfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASuDiuLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD70C4CECE;
	Sun, 22 Sep 2024 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024318;
	bh=OheYRyaEoEo8MfIFPonqCUOtRbZhQm4U3MpWeEXA6Es=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ASuDiuLpnC8gAnN9JY857JCET6mSYJm/ES/StFCtoOuZj//tfK4M+5bVkBUqyBL24
	 AxLlNS9xGWM/JolR4UxqUpY8pYEMTBbCjc4rCbQsrit5FPxcXuyF7nNIwwDa9s8MHe
	 qUi+YqEwpW114YBMoowQeipt86v6JWBlm6agdT4Tdeeh06bjWxyrTIzg6in868uCQE
	 m4EQVwreVfGbQiDuioTSb1F1e+Dg4PdxRsJePno3cTEa8/38FCM9c8uyP3ouaG/rno
	 M/GEc5AJp9zpPGbkQBrAQ5AydzdM2z9Zqh25eWLyEJb468apo6hDlG+znpZa7hbDOK
	 hHZWdhGvkl6/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A843806655;
	Sun, 22 Sep 2024 16:58:42 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240922041219.2906a1ab@rorschach.local.home>
References: <20240922041219.2906a1ab@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240922041219.2906a1ab@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.12
X-PR-Tracked-Commit-Id: 75d7ff9aa0ae1a8d1b3f9c8c87dde3a4fbe9a2cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af9c191ac2a0c857f59d75b6812fef078ab1cefe
Message-Id: <172702432081.2797494.32561965479189784.pr-tracker-bot@kernel.org>
Date: Sun, 22 Sep 2024 16:58:40 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>, Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 04:12:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af9c191ac2a0c857f59d75b6812fef078ab1cefe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

