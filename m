Return-Path: <linux-kernel+bounces-352024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF1991939
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F557B218F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B5158DDD;
	Sat,  5 Oct 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpzSyoIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DAC158851
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151659; cv=none; b=PZlCnJeFnG98JnmnBIcxh7Aob7oHak95B6UwIKyVapGINpuR1FZiw15Uak5hbD5cWBQYnhaT3U2onBd0GYWq31FNUnCkIvHhJawSsM0ZPn0qPqPpHkJ3HnN5/13HZgWvlUuIsLZhEMM5EzZ99ZU3JmSeehm/f2DnaIrA9Bw7xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151659; c=relaxed/simple;
	bh=kOk1mEifP5ATm7KsX2A7pW+Oe5vTm9hLLRMZ9JhqF+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oJoi4T3HKVB3pckvWTxqc2z5DZA0JiGnL4Qa/XIvMWZXr7frbkrajnHuTFy/lIX8o/0o7XGm3SjkNcPDzjfjNghnOuD/QHKm0lO/bmAcOt5QwT68i+YzyCX7WhaUaj1vcHkL/T9yNHF7hqwUTr5/tdwtMyT+OoW++tlgE1AFw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpzSyoIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729A3C4CEC2;
	Sat,  5 Oct 2024 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151659;
	bh=kOk1mEifP5ATm7KsX2A7pW+Oe5vTm9hLLRMZ9JhqF+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YpzSyoIoqU49nCLEjAXb0xYnAFxItNRqMoE1lQOHBcWx9tHUmLzMdgon4LCsrLwnP
	 hhTDtnTNtDwbK61fncNLEF/3CgYzsrdRwsNkbTw5uwd0d2qKenSOBdUor7QXvWL7dC
	 Q2JvR9MfZhWG8V5JZzck8aJu8KU690rzaZTKDFEX6DYyZY9+M78Q+4wPmPMN8/iRvH
	 Mut6OgxqLblN9g1+3cJvJ4nZW+ZjotNXFHQe6n4Bs6LVtrelQrOXCL75Jl4RnlICTj
	 v40uhpBwbnJLf2vRTOXcjVAzb8yoWjAYZbeYcpQ+ofT7GU9nsQWeO6atAhPwlrb017
	 Jx0dfLgIiZTXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7109D3806656;
	Sat,  5 Oct 2024 18:07:44 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241005150431.12546-1-jgross@suse.com>
References: <20241005150431.12546-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20241005150431.12546-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc2-tag
X-PR-Tracked-Commit-Id: 9af48210ea5f1539e1999154b0acd343efdb370b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc20a3e57247e21e1bd582f604b20bf898f7d111
Message-Id: <172815166291.3145223.6038597083348976320.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 18:07:42 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  5 Oct 2024 17:04:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc20a3e57247e21e1bd582f604b20bf898f7d111

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

