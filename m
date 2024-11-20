Return-Path: <linux-kernel+bounces-415096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD09D3183
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D9028422B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA50224D6;
	Wed, 20 Nov 2024 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgRU6TQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC931EF1D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732063755; cv=none; b=urkLya5zVfMvNy+jO8SGE2/FM0aRk+SvFJJHQNE2kM2sS12K6+m4Kd085qaH+0IHdQ/HtJayqqPyvYEFjHY4AEG/la/DlVBOiE6iPL2hkM0vEVOsZKweNYDfTyQp7XF/PmYA8DXtpyNZ0eOCyhuHfUT4BI8YugK4lrOvVnLCAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732063755; c=relaxed/simple;
	bh=VOBXS4F5Yygb1Rw34mA0i/6pHtdeBv3c4nrMdrf2dpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LQx5QuT1RffNcw9T9jUMErW0OB9sqcRMXeMoaAQac2kcFQeqS/fGL71KqPfdWKgCb2hh2MrsOrNN9udwx6LksCMwRqmK4KsosvATETEl7xCISTsKCNa8bnrrcvMwswPjIJMK/1GpBEognIOgFQzDAPIbXv50DYMYdYmBKPBNg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgRU6TQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04F7C4CED1;
	Wed, 20 Nov 2024 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732063754;
	bh=VOBXS4F5Yygb1Rw34mA0i/6pHtdeBv3c4nrMdrf2dpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XgRU6TQ428cB1OE5PD35MXK+txvniivUbjcxhkZPTZ3zIzXJkx4zTm+mhgSrAElzf
	 x4pgJ9M78kfWHvV471+8L3CS+4Iv2S78hoOXJTuz+svBrky//i1Sl5O1j0Lc0ZvDaR
	 yTlKtr5jrfNRaWZrI8AztHQ0ioMh1j+R5Th7H2MCzJf8kn+SA9alD8fCu8zF1tYcd8
	 1eNXisDtsOkAuGONVfemOwwpxot5HYJjPufXadRSaUaO6Z2mwRwh+9v1MyMHjJxFqb
	 Q5WfRTwIAluruAwUbKqdVU34LMAaAXsfYg1VXqSwSpJpEOUnHntqfEbvxfSDvv1kTd
	 x6D+DZAKw6tgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD043809A80;
	Wed, 20 Nov 2024 00:49:27 +0000 (UTC)
Subject: Re: [GIT pull] timers/vdso for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <173195758949.1896928.8792221019523581466.tglx@xen13>
References: <173195757899.1896928.6143737920583881655.tglx@xen13> <173195758949.1896928.8792221019523581466.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173195758949.1896928.8792221019523581466.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2024-11-18
X-PR-Tracked-Commit-Id: 7fa3c36ea2707c495cf31ccab733ac8bf3f9d0c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 035238752319a58244d86facd442c5f40b0e97e2
Message-Id: <173206376625.738777.82851625862976880.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 00:49:26 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 20:22:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/035238752319a58244d86facd442c5f40b0e97e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

