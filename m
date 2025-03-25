Return-Path: <linux-kernel+bounces-574655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D06A6E82A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7D173B03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67318B47D;
	Tue, 25 Mar 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldKR/SPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399F1891A9;
	Tue, 25 Mar 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867878; cv=none; b=DAO4pTSUChhjKmeCqdeFq8oAlf0EDstzslpVXytTNjL2PwWoXGMR9dbmzZVXhamDGs4En9Fx0pLWKgc2qFEGWPObH1pqBIgusrBKZbwny0VipqaJqjWz4H4T9ikLLbr47G3hDPrh1OWkePUN9c3ukTaI3g7qJt7rom8E3C56OK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867878; c=relaxed/simple;
	bh=DmUNbLkBSA7ZvMjcnypyyYYW/0NgleKxl+kCIDqrTLU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cLzF9wB0gaqH9A/jSok3I4SUnvTk+WMBOZ0L9QCVH7tb7saX3ybTZ9H2FyFOYJ9rnl7VsJaWJlrky2IRwyIeHAdpobi5w2wsYX5HZZbmzd47mGMFzF87p1181n0/U3wnXJZDBaLaPTKDVIdBKzeATdAJHmqtD2SMHdP6PI+8ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldKR/SPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35391C4CEE9;
	Tue, 25 Mar 2025 01:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742867878;
	bh=DmUNbLkBSA7ZvMjcnypyyYYW/0NgleKxl+kCIDqrTLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ldKR/SPwApMw1nTd/eFqH5xn1tc1CiskXZf4rO8WvcZYn0QRTaJnwPK51DmxygQwo
	 uP7rEmxxLXxYpLH+z/Hi7Ci7MyQ5Vg/wA7izXznN7gvCFHnb716vFmjqlCuaK5ZyNs
	 wUdGaBlH4idJpambtsLbXhSkq8xGFATPeJlBz96KMAJw3FUuDuZMqsvEq62Fk5VWSv
	 pGgvUvZNu2GWtqUPdRXJrgNzzTe/2ixZa92wKlumpTcxzXVAc2kg+pBEfl+0F7+wiN
	 FyIN+MeXtzaWI1QOZi/tS+T5F5KhITm1xIx2B4iRlv1w6nBvzEK7j6sTnYMvDU4tUJ
	 PSX0+VupKRUQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE031380DBCD;
	Tue, 25 Mar 2025 01:58:35 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <87tt7mjhqj.fsf@trenco.lwn.net>
References: <87tt7mjhqj.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87tt7mjhqj.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.15
X-PR-Tracked-Commit-Id: 323cc36ef68bc2c8ca0bd5f528736432afc1a36a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f81c2b81508c4f479f2cf1ac0dbb138927dc6188
Message-Id: <174286791413.53720.9062851156408080962.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 01:58:34 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 13:39:32 -0600:

> git://git.lwn.net/linux.git tags/docs-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f81c2b81508c4f479f2cf1ac0dbb138927dc6188

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

