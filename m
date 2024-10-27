Return-Path: <linux-kernel+bounces-383751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A89B1FD3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBE81C2086B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924B157E9F;
	Sun, 27 Oct 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bavFuiHq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693C1DFE8
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055815; cv=none; b=aRAt2YFula31imvyy5C8icgrOXoC8AcxR+Gv8MZxKT05cdtj57hyP2dLUDAEYqrLOo7KkVARk1YQDGnUniUNk4numjV2HkgA8T3RBxoGRry8TnEONO7WvMckFxVujhSPMPywAQkdi7OlODtbTsvKKX4sha6mKNCl8O+HW0ACW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055815; c=relaxed/simple;
	bh=xNP1YdtT/Rne+yViDRW+aQsMGGvVFEsLTpT95PsoQS0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iyrZDcAITJhfKiYNtfafjEAo+4mWsr0sTGR15CEqELCdlcsFy7L26wtfjBG/fMrBr46+eqhtTuL6SkFl5orCm4Dxv/7FJJVWN5DEKbJA83iIsmIXAby/DlaTJI+NMwe9heX/Tih61d2lppigN1jloOoK/eDGcr/iNauvjrdPRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bavFuiHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5EAC4CEC3;
	Sun, 27 Oct 2024 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055813;
	bh=xNP1YdtT/Rne+yViDRW+aQsMGGvVFEsLTpT95PsoQS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bavFuiHqwb/1iA/dxhXgLLXSj4mCyHSUnJQ1lLS6NXZ0SrG8iJ0jlvOuTwsC+mITz
	 a6y8XK8zrQxycbEq5jC3akLmsNY/lsHBL6QaQk6VoKDaS4keidu23/7PXiUjqzqJun
	 mjTbsqKT4tlkhIPINpWfGyoWEHj+6dCGIzVcsydeaBMxlcSc14AObS9JVu60E8kPTa
	 DpvwHpNKwKjqlcTsWhoU/EBx3yH6AYZY0We11Z9SncRRvJBHoupFcSkeGY1wQt+qci
	 MJcbP2bM2X3BaPlCQoWZHp/gutv3wr3zo913m79efnttbOdGsjEorlYAQJRDSI6WS5
	 pfY2dZhrmIp0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3673809A8A;
	Sun, 27 Oct 2024 19:03:41 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Function graph fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241026034506.2fe3e1aa@rorschach.local.home>
References: <20241026034506.2fe3e1aa@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241026034506.2fe3e1aa@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.12-rc4
X-PR-Tracked-Commit-Id: a574e7f80e86c740e241c762923f50077b2c2a30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f69a1accfe2e2ee2c43096abd9080b1fdb0c894d
Message-Id: <173005582053.3431633.17287997692977352638.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 19:03:40 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Li Huafei <lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Oct 2024 03:45:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f69a1accfe2e2ee2c43096abd9080b1fdb0c894d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

