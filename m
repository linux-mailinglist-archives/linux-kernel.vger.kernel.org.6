Return-Path: <linux-kernel+bounces-359949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC19992EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED812288A75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746F1E132F;
	Thu, 10 Oct 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axUPrGjZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A11CEEA4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589321; cv=none; b=L67j9gtVfrnoXKUHhQ9YBGf4gMOIxR4kxEAwSWBd/WaAg5hOmlPBJpmtXmhsQ1blBXpsxwRkXQBs2qvYQIPeGGHjYP+H7WByuGFaQYeNZqvK2Hk3duaWfwBjHVCGa0UaLMmXvc+j+uKzKkPCtj2nW38TOpepHx6NuA/TJ47Gizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589321; c=relaxed/simple;
	bh=Zro1HpePXgGRO6zxYed8MTwT5KZp8Z+w0fujtg83CkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eZFRo8+aTcMBzFgUNJpA0yo0mubrAR3DsYyIXSwXByAe+BfdXuERN1bjg2d7b0mA4m3GPoPrv5r0DZAWMUG0SesQzK3w8yUo90QF9aoCJ4fFufleVs11pV+laE5uepwiMlt8UB5ClAeNXkGIENrWSj1iJtkuSxxe0zVH1Tb+Wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axUPrGjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C5BC4CEC5;
	Thu, 10 Oct 2024 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728589321;
	bh=Zro1HpePXgGRO6zxYed8MTwT5KZp8Z+w0fujtg83CkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=axUPrGjZTk4OhfYbUi2Kkkh+5DZeWXfnlY3jUa8KZMZmv+Ww/oZKYP2HnWz1UsIfb
	 dVOcA6aZGjbpFrHbmtNjD7jBnajvsjp/OBjWsq9Rbg0j4EhEd5U5PPTbk9TIYlhruc
	 hIWbtab830xwkPMDX2Txns815uNxtyfDIQcJSamGVw+wobPGcuIqCTkB5Z4h/OBDeo
	 DPNHf/kwjzBOXL05V3d2Bv5YPZ47DsgVwBbYvyvVwlBPUU78NHGwmeztIy1jN5YP2V
	 Wsw+oYkAduCtD2EKXiqDofAAZI1II9d8sbal8bdM9CfspJVqWNEpz273A2BAQIW0Jr
	 suIzcIKQDFxIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4F3803263;
	Thu, 10 Oct 2024 19:42:07 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: Fix for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241010112636.2dba6885@gandalf.local.home>
References: <20241010112636.2dba6885@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241010112636.2dba6885@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc2
X-PR-Tracked-Commit-Id: 912da2c384d510ce40c5af9c3adc316afa4ec547
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0edab8d1324dfeee52aad763236c9015e413c4c2
Message-Id: <172858932568.2148416.6110311848721509859.pr-tracker-bot@kernel.org>
Date: Thu, 10 Oct 2024 19:42:05 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Oct 2024 11:26:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0edab8d1324dfeee52aad763236c9015e413c4c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

