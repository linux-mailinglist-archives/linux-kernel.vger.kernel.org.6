Return-Path: <linux-kernel+bounces-414869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B629D2E88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1728163B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65F1D3585;
	Tue, 19 Nov 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM67PC/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067381D356F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043189; cv=none; b=jyUXSe+En8OycjfxFU3C/R57MXio5TYnGcPAIOsNCFd4mSSII7WQhAkXT+y7G9BEfVwR4ooylRAn7DSpYw0MfMjMtK1CHjP8gmQPSOHQJGmMouMkCUQXOnhChmtZiXzbQ/KKA3J27sevP+ec2I8k+rm2dGbDXwW0FIk7QOoWUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043189; c=relaxed/simple;
	bh=whqnJCbb+IZq2Ca6LUBJGhLn6EUgYtcicwSvJiKR2iQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rrDk+RA/ghRxuijnUpuTn4RMprT1v2gsxC+DkBZpTpR15hek+ZkDnbbo03u+14pbHJh0XDS/0TaXly6jWUSpa/87TX1/xYPauu0li1ciGyDqGtMeq9wcvUc8dXR1fA3L0Pzyf7ch3oCBqgY53dni7r/bjDBwf2tnyLdhehSPYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM67PC/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAECC4CED2;
	Tue, 19 Nov 2024 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043188;
	bh=whqnJCbb+IZq2Ca6LUBJGhLn6EUgYtcicwSvJiKR2iQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DM67PC/02oSl3V5yCl2bOkSjqedezeMX/RZ6PTMjqpJggcm5PfCh4xAUj8Gb+t9s4
	 aVjuUiOMK9apB9Coxz/l3ZS67IH+BLBJ/fuMUESMe9SbbpEty2J5TLmd9g3uI3CSsk
	 j5oQS2GMDHg50c+bkd5DY68WSPgH7yYY5GVkJX6y6o5uPNlgQcsZO++DienacSwBv/
	 xkp2VYq4d834TPXlh2idHa+qAGi5oMDZBRMaQgNUat0gQeoXX3Kba8eF4JaT2AsV2d
	 ALinsV7iT+VJoLn33sdsvmziZe+gT/YANqUhYO+cZlpXTfH7KyRC7M8J9K2MGs61k+
	 QozfjqKTr6YJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC243809A80;
	Tue, 19 Nov 2024 19:06:41 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <4df7ba8c-f373-4b22-9387-7674e5f903a7@paulmck-laptop>
References: <4df7ba8c-f373-4b22-9387-7674e5f903a7@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4df7ba8c-f373-4b22-9387-7674e5f903a7@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.11.01a
X-PR-Tracked-Commit-Id: ad0558f3883130954ca724697f2d19aef93967b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26c9fdd6f3a4ab6c49500b6bb0fdd0a87c63932d
Message-Id: <173204320014.653509.15399794414281476450.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:06:40 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu, linux@weissschuh.net, skhan@linuxfoundation.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 10:40:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.11.01a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26c9fdd6f3a4ab6c49500b6bb0fdd0a87c63932d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

