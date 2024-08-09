Return-Path: <linux-kernel+bounces-281319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913494D573
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C957E2813AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAF132132;
	Fri,  9 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZPAw3Qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57A80054
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224677; cv=none; b=lBEKqymu2Ms7PdYAd83h124pA/hw5GcS/6Rr+FL+/YjhKCdTWuz9zVzxGUArMtyuE5pVPLOU+AKJmNXdBDCPAXKJjaOQraqkv9PjOi+o67U49qmWRHalwwZ1+y/czjqHhl6tbKfaw+eNE7rXAZnQFLTBCztarLNVAfpxEROHKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224677; c=relaxed/simple;
	bh=h0JqUh3uknTDbuV9cJCQLDV1Qml5g0Y36y69H+vZObA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=al2s0aAP899HEuZrA7Vj5wMdgIdvWyPGNlfHBG1Pxn/ZTiX9j5nq/fEA5CNu64LSoIThE8globJJ5TPQ90dp+gH1Nv9mmwyvSjmUNwTL64X6DRatR8wYHsALybYjPGPsQKQQsKTUxjGBlf6Q7LxnHuW4al86dFLsamHfg0pst/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZPAw3Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F110C4AF13;
	Fri,  9 Aug 2024 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723224677;
	bh=h0JqUh3uknTDbuV9cJCQLDV1Qml5g0Y36y69H+vZObA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TZPAw3QtXU7gvVo7JGJm1QmaS9MSAIxPlfWSW+6NRZ9KYGVmR0taURpHZZUnuDXl6
	 8fDhUFp62GWemFrQLA0YnRUXIas+G4tcBsXRRo54/wulf5XZ8wD2mLWXzLdw25SByn
	 Iua/zLWeWUUSxsReAzWqsd3uIPiGsQB9/8O2QN8DT2oc9niiA0oRemPsRaOLKpxZAm
	 p24k7IendNETHncWAiSKjyPeqCYbNchvngHC1lREqg0D09/x+ugUtl+Wq/K17Pcq3o
	 ni2k/fCdaKJMqwNPx+k5jo3vncS+MuO+48GOFYPMjI4XM6TWdxMiUErCESN5AVX2QQ
	 7hISQaNZ8BkRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3413A382333D;
	Fri,  9 Aug 2024 17:31:17 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240810002345.abb569694b6aa9fb6afa1fe8@kernel.org>
References: <20240810002345.abb569694b6aa9fb6afa1fe8@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240810002345.abb569694b6aa9fb6afa1fe8@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.11-rc2
X-PR-Tracked-Commit-Id: 8c8acb8f26cbde665b233dd1b9bbcbb9b86822dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146430a0c26eb7b515abb04664e1a516078ec5c2
Message-Id: <172322467566.3855220.9590848624651773996.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 17:31:15 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Aug 2024 00:23:45 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146430a0c26eb7b515abb04664e1a516078ec5c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

