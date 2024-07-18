Return-Path: <linux-kernel+bounces-256769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61A93700C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356342827AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C991459FE;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6t+vql1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC979B8E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337985; cv=none; b=Y/zKHHNYtoBd+ftO9kjPdvi8l7KW4B4PwabpWDG9mzF7QM8pLfRT/x1an43/fprMbX66wFCHC6EUdjaNbrEsC0nwfLdSmHu9+eZGciXlNUAHkSJkhKeWFx8LEki4CzdASbp33gawaBMkQtzo1PjGw+PSKYHuSc1PpLrQ03g35ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337985; c=relaxed/simple;
	bh=odmmWh4/hhwOg18vthPlR26gt3y+A3PdPGOMlSewpmo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GCV+e5trQmO+4U4h+KTfyWc+HmZvxElFqE66750ZBBff0terpcNaP76uqgZLmFl486E/rDeWnvx9a4A0CMFcBKyOe8pJcZGg079tAAVJsWb764wwzmhWw2DBtZFqVji+5YGRIvrmnccuuKV2qFkPb/PPtLftp4AfI875eEpnpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6t+vql1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E37FDC4AF0F;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337985;
	bh=odmmWh4/hhwOg18vthPlR26gt3y+A3PdPGOMlSewpmo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g6t+vql1M7XwL0pmwS2y/NCWxG2beObUa/FO6GvPOQoJ/7IdhIjD3eZHeC/yS+3Z2
	 ZwF+8HZqUoqye62rYlE4kuCA4ZKqoxdqlPwDO8pcJvbynHa9dt7tSiVbm18ITLc7f3
	 9Zr5u1wSvS31bamycaUuO/BOZWwHUkVAUPI3A71nWR5qpZkjCkuSt1zHTqRLMcVQJG
	 2Ai9b8oWT7yu7VVhh483VrRTLsuMjNPe62bsHaE+/e0SgMN4olf2YN1pJ4fWt22asx
	 uXcj0lyFsiC8PV+fGRcT4q+6cIKSbeaK0ZZYUxRv460KlVe5E6lekyMGVo+6mR3UQM
	 svFQW9PqEVIxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC124C43443;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716160421.5586ae41@rorschach.local.home>
References: <20240716160421.5586ae41@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716160421.5586ae41@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11
X-PR-Tracked-Commit-Id: 7dc836187f7c6f70a82b4521503e9f9f96194581
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fd4130e53db0958167510eddbca0f09dc858109
Message-Id: <172133798489.21905.9725135290608480964.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:24 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Tio Zhang <tiozhang@didiglobal.com>, "levi.yun" <yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 16:04:21 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fd4130e53db0958167510eddbca0f09dc858109

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

