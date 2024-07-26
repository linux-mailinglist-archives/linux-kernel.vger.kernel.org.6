Return-Path: <linux-kernel+bounces-263582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D1F93D7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EF21C23172
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E017BB15;
	Fri, 26 Jul 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMSBFbay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE421B970
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017249; cv=none; b=PeRNH+cvIZ+BCUB4DsawuWd8XYwHDs+PM0h9Lt5VROUlDh20DN7sSjREf33Wna9fWbNxG6w3GZx7XtxiKI11MuTlItwgaHTAXF7gWnovtInzt1QYr/MePe9pbEeiRS+3U0qV1YFFvf7DLAB06GzkjWcdRgHNsy7Y6F8qzuSka+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017249; c=relaxed/simple;
	bh=NWjjK1JvqXQ+qMlLwZFDXYa6h9mR93PiozshNCMlfyk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S/+VaCtHPnAG0eyof74K9z+V9XEkijPoIeJyA01LxhZrpiBsK6tfgwjo6zT7fdhLsms+lhjM2JVnxyF8bT7RCz0dJMG32jlCtmyXEkaXGbMSBniOPKzvr8SDF1TfgnEwqAKeHbhj2m/j/8Tyti6OoYESVTccdb55faYRfV9vFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMSBFbay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7EF2C32782;
	Fri, 26 Jul 2024 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017248;
	bh=NWjjK1JvqXQ+qMlLwZFDXYa6h9mR93PiozshNCMlfyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XMSBFbayK2oWow8ZHVcrg7si7wP3L4I3AaI0N8fp/DmHsz5U8OWUMF1zE+x3ZnLQd
	 jQD0U8RrVBZzUZzaU7jEu7V8GnCklHqhuPiVzclP15cGFxR2JBmSjMq7a5jlzvvF3v
	 rfstOB2ilHNSeH0FBtRv4TkaP/XTemAjpmQ2WdMQRhYP99XIHNID/R2WKYOPdtueLh
	 pEE0zRwssu9KXoiWdutRbb/Rijjc7i27UXSsLX1A1GQQwDOgkCx6mlIRt7LhmLEADK
	 Ss7FPlZ4ROHFGpL//HP5q2LIkaYb3K0iD1QdbNotKyHLoDMuaJZvTWCRGKQ6uZO0Ao
	 Sj5Ihhtue3PdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA49C433E9;
	Fri, 26 Jul 2024 18:07:28 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726084246.GA29687@willie-the-truck>
References: <20240726084246.GA29687@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240726084246.GA29687@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 36639013b3462c06ff8e3400a427f775b4fc97f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6294b5b1fdcdcb23c6882f2edb4bae1db3fc096
Message-Id: <172201724877.32235.12654880526708968264.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:28 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 09:42:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6294b5b1fdcdcb23c6882f2edb4bae1db3fc096

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

