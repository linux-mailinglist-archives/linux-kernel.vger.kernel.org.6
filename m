Return-Path: <linux-kernel+bounces-281989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0794DDE4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899ACB217A9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4416B3A5;
	Sat, 10 Aug 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ0jIBYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A24084E;
	Sat, 10 Aug 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723313387; cv=none; b=C+sdTOm6zKT0AWkCL9BQTURemYV+tjZvgL22oo3/CExdPVkg2TfnAmYdwA0m7baa9QyD2kF3teoi1v7glrTfbVsTnf8GbA7tV+cBggiuQFL+KD6bQ3mLcEiV/YsLM23A7u3AtKtXeMs6pcGtX2viK+DJQo7bwbkOndpB0VkMTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723313387; c=relaxed/simple;
	bh=7dWUteg1UwCdSGUlkc9RsnlitJR2kXP/0nupu0xd/yA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YVkZnw8LzzNfvc/djZyCzbhf2Pu7iO0kv+Ap5nQnio/0kzHi5i1q9wAj07DfoX0HVK7juzBUA4tr38SDMtPUxa3+K8TNjGR1S2aCYKBuLxei+/o9ycY33WoA5Vf9OJxTRd/yTGndDwZ0mVD6RGOCY2MRh104moRSY1B+lu8gYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ0jIBYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82DDC32781;
	Sat, 10 Aug 2024 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723313386;
	bh=7dWUteg1UwCdSGUlkc9RsnlitJR2kXP/0nupu0xd/yA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YQ0jIBYffKnd52iOyHNP+IhBrLs6to92sohMKxXqiFSUk4eejqMySSxQM+lTqATYo
	 Imv7h6/RyeZQz3yf4N3BrjV8i+O1/RPsg+Cx3MZuwJ3NGJfEcVHAvgtjtc7za+9bm+
	 4q0k6Z/JHzswaRa4uHMkw418OEeEPaRGjZgN879ExVYNXZeyla+zY89jkW8wFpXjDe
	 sBNV4h6bxkCOskt8JSwrp7NfFKqSu48Ru6KaozwyvVunTPYawnPwRc1xF0CmC3n2Rs
	 G7E+7xIUw2WhO4fi9K/cjrDkLTXMOvX6PtY0mNQZQTtpfEuPm8A8m0RXYdyD+dADbQ
	 fv/6mSpVeGung==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F169B382333F;
	Sat, 10 Aug 2024 18:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc3, more
From: pr-tracker-bot@kernel.org
In-Reply-To: <f6bxn2o6l3mt63rjaclzcyl64y4cna5sxpnktlh5ws6ezgtdzd@ga3tq6ak64pc>
References: <f6bxn2o6l3mt63rjaclzcyl64y4cna5sxpnktlh5ws6ezgtdzd@ga3tq6ak64pc>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f6bxn2o6l3mt63rjaclzcyl64y4cna5sxpnktlh5ws6ezgtdzd@ga3tq6ak64pc>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-10
X-PR-Tracked-Commit-Id: 8a2491db7bea6ad88ec568731eafd583501f1c96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31b244460634c74430745a74e56f5c88c43f079b
Message-Id: <172331338522.44953.832514137946616124.pr-tracker-bot@kernel.org>
Date: Sat, 10 Aug 2024 18:09:45 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Aug 2024 12:46:42 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31b244460634c74430745a74e56f5c88c43f079b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

