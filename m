Return-Path: <linux-kernel+bounces-340958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FD987983
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B29286EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64FE15ECDF;
	Thu, 26 Sep 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTY/ZkbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF41D5AC5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377738; cv=none; b=TIANB43BOT4nVNRkfJuCjQmANrJA2fJ6J4Mus3Bo6lE8g2PqMAx5ZGEz6KgEeknWQjVYiGSDneKCoIVUpt6NeJ0tpVzF/wOvweAIGaRUx05M+1RAMNgQ9X3CawB8bo7sIp8MVnyjGsvUEy2M92q/ijVbgrlspp4b0uEeI7LSjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377738; c=relaxed/simple;
	bh=W4Vwz79B7/UebOZ9Pi90NzzLOkD92zmgBMX3RQUvfbo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FMQyihsOMDkCB3KiIb91D5Ndc0+gDM27jgAVR03pJKchf/faWvjXZRMqb2jbFmBGfdmeNhjmHzzt2q+vNyDFXm/SA1UnD8Vbxte9w02/3XKopnDVDVuAM7LZh6TSGLexIbOU61dhOZAi7vzquhZKt+aznmVG89Bnda738KWaP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTY/ZkbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAA2C4CEC5;
	Thu, 26 Sep 2024 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727377737;
	bh=W4Vwz79B7/UebOZ9Pi90NzzLOkD92zmgBMX3RQUvfbo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cTY/ZkbLuGmyDCm4OVh3X83/xPn7LFa+fmfXC9swWRlW11Z3Lox/Q9VAIID6QTQBi
	 /eZhRUw09OKvQZTtvSVN9dmj/WHjfcjNjwp8b0QzsWicPklc+1cC0B8CyqXPErDTxt
	 BXgKGu0jFBoPJFKSivYKfHC+4KpEjqdNQL2iGI92Z6DDqOtWEfLMCNlZPBsxD/Bz8m
	 j1YFxV/7kb6ZK3PSeHjHV1+3AxF/OkakxcQUDnNqC/WQKc7cBzBVMUOicySkEZCqT2
	 DECE5Ky1uH6OSSbAwKGOzJse+CRIDNcOnK+Im4C0H4mvHQARpXzG2EUrCZzA7Gk4JV
	 y8YqJU24LcQEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4CD3809A8F;
	Thu, 26 Sep 2024 19:09:01 +0000 (UTC)
Subject: Re: [GIT PULL] soc: convert ep93xx to devicetree
From: pr-tracker-bot@kernel.org
In-Reply-To: <6c10bab5-e5a5-4969-b28d-11d8a1d5d587@app.fastmail.com>
References: <6c10bab5-e5a5-4969-b28d-11d8a1d5d587@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <6c10bab5-e5a5-4969-b28d-11d8a1d5d587@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-ep93xx-dt-6.12
X-PR-Tracked-Commit-Id: e3eb39e6bab564ed430172f37be835f84e923c23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
Message-Id: <172737774015.1364780.14805978363792235604.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 19:09:00 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nikita Shubin <nikita.shubin@maquefel.me>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 18:10:12 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-ep93xx-dt-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/075dbe9f6e3c21596c5245826a4ee1f1c1676eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

