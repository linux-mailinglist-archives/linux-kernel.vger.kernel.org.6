Return-Path: <linux-kernel+bounces-351330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D3990FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1637283135
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88521DE4CC;
	Fri,  4 Oct 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMyNAmiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F831DE2DA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070160; cv=none; b=pVEELL7iSDeUZgPnLhHFxQeT/Q6YO+Z9LSf6EUMch5xzm0cDuK8Keb56Vt/jMY2dGomeC9PeTS5dfbw3OKxpt+1ZfpTcNWVInHNV8dxN4wcmNfjpR7IPIDNB/s21fhBaXw/Rsq7ul8bikDfdyNYAgkzJ6mV0Y1K0jB7pSabVASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070160; c=relaxed/simple;
	bh=7f1WwxlAsPRjjkw++ov0fnWKuNPkbGiQHsuOf11eB2A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S11LFxavMIeqwdAPr/n/rdWTklCYjw7UvbSo3jxVUQZ2k5iQEMuK8imP9/l4P+9GAZ1qoZLksP2+5hgX9cISJWIu1OUmHZGDM1wrwTWgaF5zXKtAyJVf/OviQ+ejQWKXLHztEEOZZBU4pU5MxZB6BAvZaJjGAO31T70WZdklmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMyNAmiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2106DC4CEC6;
	Fri,  4 Oct 2024 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070160;
	bh=7f1WwxlAsPRjjkw++ov0fnWKuNPkbGiQHsuOf11eB2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TMyNAmiOSVssKxyq2VVPWZb5MucWQwapElVKWUcuqUstBR6Lvu1eEe4/EM/PEJ7z+
	 P2JYPEwM8TD0W3AnCi/5XA94x5ZuMa7Hj6v6T5jZ7iMXC0eBpBt6bqwiepN4HDYVO5
	 fd/rAOHAz2OKK536zmDp+A9NblKiWXsbshRglmGMvvI02qU5ZXrAWUY8YXCqndDWTa
	 vM+A6Ubh/ZaaLERQ+QqxSVEBAP1cb5+vr4iYK5IRpwAJg24aK2CV5Tdtpy34P5x++g
	 iq6YBg8OFNTYA8IFGdwqGedzviCfwvBHnnRTmWgB632C1Lq5cx2FBmew1NVLswV+0T
	 vVKPt9Du+B29w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB95B39F76FF;
	Fri,  4 Oct 2024 19:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-06f4491c-e8d5-4713-9342-3470d90d42e7@palmer-ri-x1c9>
References: <mhng-06f4491c-e8d5-4713-9342-3470d90d42e7@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-06f4491c-e8d5-4713-9342-3470d90d42e7@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc2
X-PR-Tracked-Commit-Id: cfb10de18538e383dbc4f3ce7f477ce49287ff3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7943f06cfc8693d861816dbe608f84d52dd4af52
Message-Id: <172807016349.2715268.14481192352086944256.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:29:23 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Oct 2024 07:15:11 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7943f06cfc8693d861816dbe608f84d52dd4af52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

