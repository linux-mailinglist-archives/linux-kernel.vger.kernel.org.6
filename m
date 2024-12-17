Return-Path: <linux-kernel+bounces-449653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025919F535A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E1818845CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084241F7577;
	Tue, 17 Dec 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMhcEoMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696461DE2AC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456277; cv=none; b=jqSuCp6xTRbxoJkw8srPh7cPcq2amESnrMVwpiYWbr0g8UXFYkymmBOkx3FvpPgorgReSVA0FJUiQacjgBokStH/Xpvw3K785iZCpnuQ5iMXLg/VQG4aqOEmXGw/HPTM1mqtUICG19VHh1pq6y6yY6aQjE+zgFdd5O5inhld3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456277; c=relaxed/simple;
	bh=oGndJHx3kPL6sY3zlsI7/o1jzzaoLFH/0rOCy8bQ5zs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TRgbU9OZ7zYVdWOYUX+N1e+JXD028t2BKpuo+NrE7ksCGoEcUaO/Fhrjt5L4inqF1D3g5kbfIsVQojDJ/OUI3WQQqeXPtyKcRgncyane+kW607Yf5BP6FkCYmBbRZKT/ocJvGg5ag+xabeU6TGhADsO4ZxDRpwpndHnLmY0SuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMhcEoMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357D5C4CED3;
	Tue, 17 Dec 2024 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456277;
	bh=oGndJHx3kPL6sY3zlsI7/o1jzzaoLFH/0rOCy8bQ5zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BMhcEoMr7JiqOVabmymFXIBDa0fYt8C7RQhWqXiZbI3nyCR37RNwrXOxsEt2mEcDo
	 hBkN6ETFm1Iny4OpER/lBrQtgnNpJUXCWCHbGFA1aU+WOoue3kHIZjXhiUXL8tlAX8
	 PuqFNYoNRu+sNxhAbZwlfkjvC/Ep2Glix3OjilZ2j1sqfYQorZE+8/aoweEIQePeFo
	 luvS/imLwR+T2PNeGcNB8KlE4Lgk4iB4d4vWGO29v0aFytQJ7x1oTfMzBWZS6vmImi
	 lrmPsymM0Lrm4pS+Qb2R5MV6i5u7usTfV+yeShQuh55Aoidl9AxUgvOyu6UODynddu
	 pSD1wzOmrItGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1363806656;
	Tue, 17 Dec 2024 17:24:55 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z2GJfmDTrzh0mM8P@debian>
References: <Z2GJfmDTrzh0mM8P@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Z2GJfmDTrzh0mM8P@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes
X-PR-Tracked-Commit-Id: 6422cde1b0d5a31b206b263417c1c2b3c80fe82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed90ed56e4b1311797302c2e6107f5049ba4586d
Message-Id: <173445629432.974395.9252918788891852590.pr-tracker-bot@kernel.org>
Date: Tue, 17 Dec 2024 17:24:54 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Dec 2024 22:23:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed90ed56e4b1311797302c2e6107f5049ba4586d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

