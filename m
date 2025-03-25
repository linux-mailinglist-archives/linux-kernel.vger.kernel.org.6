Return-Path: <linux-kernel+bounces-574620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8EA6E7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C213B94B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F760189F3F;
	Tue, 25 Mar 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZleyC1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4151632C8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863504; cv=none; b=kQPQCiz10UI7/WU5fSf/QNyrkRdDp2zDfoyGBeJTDvNOBOPHyRLT483P0N4myWvu/9EhSxvwhg1EsVsu27sGoKOxoIM+n4Odo1DHLrSjYjtglb0D5buONX92GwzHatctkT7DiIO5/+TC/6faf6+oH2CRHY5Q8n5YTJIQFPTbM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863504; c=relaxed/simple;
	bh=k2AUDHgBKvfjjsqO39lJdZu8qbgblOqaVh1IyzP9ilw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p4x9boSBIO3KTqEPSzkz0jPJwsCyXXulSDXdGDIALLjZkX3ZNXelwzud4ELto4clykmRuhLw1EciirDC5o36il5JLIpSML1OP5GeeGcXZP2TBZcIO7dB9Lt0zQt3nQujnKr19Z9JuNTwFNHhD9Yf2iYUwr0SjPV1s64ieuoPNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZleyC1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21A4C4CEED;
	Tue, 25 Mar 2025 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863503;
	bh=k2AUDHgBKvfjjsqO39lJdZu8qbgblOqaVh1IyzP9ilw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AZleyC1G47qw7aISJEGD5nna8iKKRlfrUIFCQ9yCs4d2v4ek3JN2Zm++mJF+Xelsy
	 SEOngQhI10zxV7+HVkMvfx04efwVCmIoee+l8GDiqexoX8QVB3mKhzOzoZsRXvqhrr
	 Bzu473GmKWZRCN5oiG8roV4SWpkxrNXsjWjoz9T7/motWgHNlcM2ZpjuQtlbXFzIUL
	 lslv6toJEbKc7qn6knjmB9Iq/1//tnh7oA0i/SKJkp5VyOp0CoE626OG/xfjSmz2g9
	 5G8nfBItA2ZuGjT79bxzswiTfI30Nrsmim1GjiyRyMpo4QIpb0xNgSAl8AubjH0dj1
	 XgAlyamG5g40A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C73380664F;
	Tue, 25 Mar 2025 00:45:41 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503170912.7B08D1FE19@keescook>
References: <202503170912.7B08D1FE19@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503170912.7B08D1FE19@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.15-rc1
X-PR-Tracked-Commit-Id: 8d68cabeb1ff1cea57caae79a76a5606b11dbb4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f773fcbdb4698175ca908d332a1f7f3d4c8e93c
Message-Id: <174286353980.36585.11689762270844733073.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:39 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Akihiko Odaki <akihiko.odaki@daynix.com>, Baoquan He <bhe@redhat.com>, Dave Martin <Dave.Martin@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, sunliming <sunliming@kylinos.cn>, Timur Tabi <ttabi@nvidia.com>, Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 09:12:08 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f773fcbdb4698175ca908d332a1f7f3d4c8e93c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

