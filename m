Return-Path: <linux-kernel+bounces-256767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FE93700A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EAD1C20C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E97CF30;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoDgqFUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DD29A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337984; cv=none; b=kDqwLCB2qVO/iWl07ZfX85f3cAfn3XBXU+6Tb9DcrPMKDbC+7NLQqI+ATokxWZNgu6CMSpR2fSHWwijFYwnMXEwhPtKP+Yk1FTtcFRu21ZN5yiZQKPGG9bFxiEYDdS3vzXdUHtsSHwZPBlgiSxQMXaTkMUmMeEkEgoC35PahzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337984; c=relaxed/simple;
	bh=NXxMTForTFpagKi/czQvaebJWkLD1gK5FgFy2FkS/N0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GkN2DNXFEE2MZYOREArp7vsCfqXnidpwo/YMolAlicTuuN49WT8DFKs0/2I5HTYp/861jIEoQ2IJjh2IoStmBiwKO5pslFVnI7xuVE4KxzczkAL+Ye7uEYnid5LYq5EUV3paMSnQhmyrRA4e7xMQUx/kLE4IITm96R2ixSl+v5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoDgqFUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E925C116B1;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337984;
	bh=NXxMTForTFpagKi/czQvaebJWkLD1gK5FgFy2FkS/N0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OoDgqFUENHIOEYRtMDYn0Kuy4Al2a7K+7VTMgFFF/oFfs9nJ6OHUgO5z+uCFy5ijM
	 E0YO0Q1GRcPYzfYAfcp3/zZd7Rojn/Ual3s6rRSHotMLCwOVT5oZNfkTW1ahRa2sua
	 WpG4c453+lUleT5A6Et7ArpZAeU2R26nsf9FbPkpCuEZojtajjNeQ5FPONZDpiX2F5
	 YlIHO7MzwO+8u20Fbi+FCJ5PBJKQ3ypJGb023DoUENeEHwRLi0uR1+MbU6vp/6Lu2y
	 3uQ7cWZrtVvQYxWCy9OXBJnFS8t4eQVzuQNQszQ7BiLl47RiDgsYDdAfSUbvl/w7oT
	 y7gAfqZe8e/5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4083AC43443;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.11
X-PR-Tracked-Commit-Id: c26b1b89b8a9fd8665e79cd798bd970e233772b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91bd008d4e2b4962ecb9a10e40c2fb666b0aeb92
Message-Id: <172133798424.21905.14577472450305387457.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:24 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa <jolsa@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 23:44:45 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91bd008d4e2b4962ecb9a10e40c2fb666b0aeb92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

