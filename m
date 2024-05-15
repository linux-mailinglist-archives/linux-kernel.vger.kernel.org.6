Return-Path: <linux-kernel+bounces-179287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2168C5E74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27271F22352
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1B1DDDB;
	Wed, 15 May 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWXTAoc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748414F78;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734396; cv=none; b=RGpLFYzz5zi2NyS4aftr43vVj+i3SgsMlIXgRTUxkaucmX8Vy1MLtgjodCI6o/yktEij5UDtRr/HJl7G//AzY+sNTDPe2Dlf8GfCvAL4BptYNsfM4iZGqTnIjExymI42p7zcKNqsjA7OAyXwQMI0PUgX1Z+viJ9nHD0+4hCeSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734396; c=relaxed/simple;
	bh=G1/fcp9CcgD+8mTJO4TXV0MDZRtOnMzwSgnfShcptVA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ArIcy8OoIFSiPp3PTifQazt1mkpfxogaMZRlQwyoA+kzwqygGq8YoqRjf4n2gBUZXLm/xPGHqi5u5LfMYXC+IptQIKoawzmtLSWrC0KKRlkHGpAGAmDpMUOprGjMQCTUpk8qTtba1YIlp3K/FrVtDPnb0z5hYNbTFhKymt1yMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWXTAoc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4092C4AF07;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734395;
	bh=G1/fcp9CcgD+8mTJO4TXV0MDZRtOnMzwSgnfShcptVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XWXTAoc319SWzYTp5pIuzvEWGhyeESj+UcX2v026v0vFjV6BWE4yo1XWMBdBfvQUo
	 RuiHVVTG0oX4d5rrcVgLWuYSgCvpra1b9FXNcg/tFQ2TbXAbC7BTmF9OdxGVV0aHT6
	 PIms+QLLmyebtdbxY/f9IafcdJFALQRfmuSaAydl+V09oKg2ALxn9HNFgBCr/eR6lP
	 ULMnhyAEz13XQkOBn4ovYYUQcWL7yZ9E95Lt0jx5lxE19/W4A85oi+RNxOcK0mA8fc
	 vmvauEkF53MFDKjwLlnFOVN6TW63kS9gP6ims1oZ3B7on/HSRZwWDihU0nUT3TkkAy
	 x6FpYNPyCJqqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA576C433A2;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt update for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514165532.GA2965@sol.localdomain>
References: <20240514165532.GA2965@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240514165532.GA2965@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 7f016edaa0f385da0c37eee1ebb64c7f6929c533
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc883e7a500fcded49e5d295737c7af6ba9fe7b9
Message-Id: <171573439575.24206.9425665902357369776.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:15 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 09:55:32 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc883e7a500fcded49e5d295737c7af6ba9fe7b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

