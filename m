Return-Path: <linux-kernel+bounces-576141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DCA70B82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFF17A636A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68781266B74;
	Tue, 25 Mar 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJo9oWPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA180266B65
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934653; cv=none; b=UA+L76/GVw+ss+xx8oY8nGHm2InPLsANzG/Bhd8dcax6s/sgPY0c6RZYyWu9qZCzvS+XHkOjvJ0pZSvkyJH+3sdCU9MU7GXd4FcEZPIHjwnPYSUz7rZbU8VVslSQsuwLmPQErqp8rdWQwPMjAF86m4SLa5Fyzrz5UuMuUGUDFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934653; c=relaxed/simple;
	bh=2t/HOFcVV70BdiLzxscYyyfEWDOSbwC7OdcCGR2mCGM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aZog4wBiHj1Osir6VaLpi2DUjGjy1eaeC7mScpyKfK4pn/rr49c8Sauzxd3tc9nJedY6vQrVNAFiev2+sYeQQ4iQLog/SANhbPefhoOJ4KkOZ/ZbpRRS/Di6+p1iTkpL7av33VOeofzSVgemYNQAYWV0QlLKY6Vt0kdla2ShfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJo9oWPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE737C4CEEE;
	Tue, 25 Mar 2025 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934653;
	bh=2t/HOFcVV70BdiLzxscYyyfEWDOSbwC7OdcCGR2mCGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJo9oWPA5hAULRlwAivYm6Dc0TfImLJsVroPZMoDYL08Q9clV7kC5RCQv5sNFUNKL
	 NrQmj/QzEGrfwIupRKbAq936MRW87V/Vcc84o/5hZs0TsyHUcmYRczH+Uw7+Yd4BZE
	 MI4GXQnyYBurw7cJpUveFA7nLcTKQXZTB7xWiThJPg5yTXJbuZdKUsIHNo0lM8pvLa
	 e1C2S7I05SLvMVeBm0mJZKAhQUvljkS333tl8IoyOG5bcosOCcc4eHKMNNFgLKUih+
	 Nq9G/kkGnXhFAmD2N6ypd034Oc7BSWHRtYajscvYUoR0Gl6RXL+AulA1fi4dczLZXy
	 G7MnN3GuzTKkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3749D380DBFB;
	Tue, 25 Mar 2025 20:31:31 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275226396.1561082.10349819324827548938.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275226396.1561082.10349819324827548938.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275226396.1561082.10349819324827548938.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-03-23
X-PR-Tracked-Commit-Id: e40d3709c0225f5f681fd300f65a65ac63b10f83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5048d1176b8e76e687fc145df785118424e1ec2
Message-Id: <174293468985.715410.10135624081277339804.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:29 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:42 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5048d1176b8e76e687fc145df785118424e1ec2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

