Return-Path: <linux-kernel+bounces-207230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA690142F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 04:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D80D1C20CEB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2263C7;
	Sun,  9 Jun 2024 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKYtOWCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8244405;
	Sun,  9 Jun 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717899521; cv=none; b=LL7T5Z1mmGQFl6e4z19CsHZ9QNzHE/fjGbWclZEPQrJ0JFtO11Z45IvfXqAbibrjBF+XwOwAzs3+ULYiwFlgSTP5Z5Zp+46Ln1ocCGjkhqEB+90cj5/GtI2x2aYKDonYFG0JSc+fCJzcSl9regdtsHnRvp+qUGu+APLNLDXcP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717899521; c=relaxed/simple;
	bh=tDvJmWyi3nu13k8lWIoGKsJdb4j1Pw77A2/YmYj+qE4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HgjLh706aeNiTt1VuHb64mFxPsLA0tYLlWmyjUm2QO16998iMkS7sYpsVerKg2/pv1yS9XO4zHPlrpWFwzRs5rwGSCX7Kuv7EaIAcFWpDj9qDalPxreUYhxfUpwSyUSs1ooheyUWdfk92eQYznNeMZdMSX860pGDiasjMIivzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKYtOWCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 795CAC2BD11;
	Sun,  9 Jun 2024 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717899521;
	bh=tDvJmWyi3nu13k8lWIoGKsJdb4j1Pw77A2/YmYj+qE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jKYtOWCL251KCVYkL/3G72lcZt2hK3yQOoftlkWka4/Qy+q2JAbZ9uvo0K7q2Z2Fo
	 ySXIkNgmwGLdgzhscACYUuLSKSMeDU9YFBfa7MpDQCiK/qRpWLkoJu+P4FuUvXvtd5
	 xRsXjZmwjfzsXG0I1rnvywMuSj9xkjVGAULJiULqI3jo8uq5qMZL5Idb5u6NZeUkdi
	 CH7b6TGeeM1M7MRS50uD0T4VjMRSQ8C8hNKJpDjCbUGSa2a3At0IKdRb+OFOoIkZnm
	 Bd01k9HVYJB8AagQhCnbLXc5orvnmiOJAbZoiC9MatrfpiDk/p+wvF2I4xrCBOYEhO
	 X/x2ikqqbtyuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D866C43168;
	Sun,  9 Jun 2024 02:18:41 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240609012719.1748309-1-sboyd@kernel.org>
References: <20240609012719.1748309-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240609012719.1748309-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 2607133196c35f31892ee199ce7ffa717bea4ad1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 771ed66105de9106a6f3e4311e06451881cdac5e
Message-Id: <171789952143.28801.11341460538483764420.pr-tracker-bot@kernel.org>
Date: Sun, 09 Jun 2024 02:18:41 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  8 Jun 2024 18:27:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/771ed66105de9106a6f3e4311e06451881cdac5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

