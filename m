Return-Path: <linux-kernel+bounces-539713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2CA4A7AD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293F17A94F9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9714B08A;
	Sat,  1 Mar 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTWZNtFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E785C5E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793800; cv=none; b=MbM367Q2miXhfbLEQTQf/rWW2lydBC64/XRvQosw0yIjVgKJ1krDBT22ebMTe1FY3wVMC9/7q8cLxKjPZJzPRrrYReBtllj3uMWiXXdpOyJHUaWsSl/1RLz3cnKOGluYAc3EMynww00ECrLW9T6+T1+U7lIYQjSvCMFUxlTwCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793800; c=relaxed/simple;
	bh=MYDE1/k5EPm0g4TLh6eFIYHvetoDAA5BI1FDuKoNU/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hTX/7P6vkZjZsThmg27EdmwgttP9SIU1jaKc77WvHlcXSWGH4lqvVy2gY8yv+e9HmW0KN1Y6HHI+cvJ4F164fc7yhOzYJ+08khcqfGtMbIuobN/DEAjRKhWXxUhTN+HVUNj1t0i9hhMyihNHe4Gk/dfFXsE5DGhOgdW+OqXVEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTWZNtFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB4CC4CED6;
	Sat,  1 Mar 2025 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793800;
	bh=MYDE1/k5EPm0g4TLh6eFIYHvetoDAA5BI1FDuKoNU/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eTWZNtFFiv3rRUt+wBxlkMsQ30kIOve/Yry4u5wCQq9htFICdDxgRfNoFAvu3MH8o
	 n3QwtFijFAKgpNtpkDqBK6Ppk6a9TW5X88tm71ow+nC//3uAYOTBbAzEVWVIjRFeBq
	 f9or+buqHr4uHe4QvemAg/ifF0DcW6lCgYo88cOpjA/Qcgyr+IH9WVuIZuFp8f4wbv
	 doacS17Kcaw90Vx1lifzQXw0BiUErzC8Jx4mQS63qjdk5EZGyxjdgnd24g6SvOzY6J
	 l+vF8JHv66l/ZKMoXlgG6AUWtrNbh2L29BjnGshvbVG7IfMQEr8QJaKL4dI3eCTNyS
	 XFmhOSbEGCUSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F85380CFF1;
	Sat,  1 Mar 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: add check for deleted inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174079383202.2336000.16821475492671345149.git-patchwork-notify@kernel.org>
Date: Sat, 01 Mar 2025 01:50:32 +0000
References: <20250227155420.48885-1-chao@kernel.org>
In-Reply-To: <20250227155420.48885-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, leocstone@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Feb 2025 23:54:20 +0800 you wrote:
> From: Leo Stone <leocstone@gmail.com>
> 
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5] f2fs: add check for deleted inode
    https://git.kernel.org/jaegeuk/f2fs/c/81edb983b3f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



