Return-Path: <linux-kernel+bounces-363102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C893A99BDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ED81C219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1313C8EA;
	Mon, 14 Oct 2024 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3loLTEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7D55896
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873557; cv=none; b=t/+4JDqFwH5teEQPqp5HDIBj7xec1nT6EommuwV4fieM1D19uaNent7gwNnqLC1RBg+6pQvbcuqXycrp7kVxELEUSVqVSOjKPmONXIfREUISg9cYbR0lrdGpF/V+OVO3/4QgUfEbMvZbJmXfd2xFTLNZc7A57or6owf0kO/a6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873557; c=relaxed/simple;
	bh=JYPywARIUcj4QI2RshZWaqNdmhjtjrRP/QE7f6Qf7fQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IdlIEvIs/Fo3lpFWE/yIzMn3jQnJqu15P6+/ZgQON/PeXJWWHDO/saHH7LVFnzTyJfua++HTmGbS60s5h6YZ1TfiyeOxL1eXC2DrmYB4Q5tia26kkmGi1SFln+pmhrlHrX3cyVibQC7V5jMkxIkPE0Gy+xoY2Bf7bRDe1bQZaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3loLTEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B69C4CECE;
	Mon, 14 Oct 2024 02:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873557;
	bh=JYPywARIUcj4QI2RshZWaqNdmhjtjrRP/QE7f6Qf7fQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I3loLTEzaFtnYNnC9QR7XA6CPP3t6omnpoLZVKNtvIR8aGI2rhF/+2ZmZACmAJVRw
	 5A+1E5s2HVKmA25vtLpTXCZdwfhVOWkvMijpHMxNufwSEXt+3vh2v/c5KPORXeaX1T
	 0w38srG1GvillwsgsEDi/XvLqDunujFmRmRfgGuA7P2MeE2+nnRU9JFGulEqQwVhPU
	 JUz4Ft6mm2rr0hUAVLWG5HNiCMonG039LaYYV3MQe5YmD5s+ER3uHx+Lc1W9wKX0y+
	 lLjqymDVBSN+hWDWmB+ds+syKt/8dRp+qK5AQxFdcUsaYrkEqsna3dX5g/Yyg8Q1pL
	 whS2tneWto8aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B41DD38363CB;
	Mon, 14 Oct 2024 02:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwvF9HasqHKW80ni@kroah.com>
References: <ZwvF9HasqHKW80ni@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwvF9HasqHKW80ni@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc3
X-PR-Tracked-Commit-Id: bd2b7f62a0d5feda8b21c7371058e8cd2956151a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f683c9b134f2b0cb5d917296a142db1211468a78
Message-Id: <172887356263.3903120.2522356875814174800.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 02:39:22 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Oct 2024 15:07:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f683c9b134f2b0cb5d917296a142db1211468a78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

