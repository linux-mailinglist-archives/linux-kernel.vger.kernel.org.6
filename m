Return-Path: <linux-kernel+bounces-416389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DF9D442F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2154281972
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020981CB31D;
	Wed, 20 Nov 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+GyaYSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003A1CB312
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143369; cv=none; b=D8EPiWNaHNbv4e5znbZ8p9emyryVO+q437R6DsDrTOlFZgetegiAyAZLbNkpzpIqVR+M5FzyFNmonA+Jb/iYkq+qNPhu3cQdfO+E895YvIZqnRcCYy6/XfKE4UNxezf56lQTPG+i7AmYkTiLamcWjfhjpP+FRqQlc7+1ORvEU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143369; c=relaxed/simple;
	bh=OCCtQUkmFoR9akyuptfADaI4wZwVOk9jv7fmEuJ+9VE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NZ3NVRpzBwoBfGZnqq8ESKeCDNBc6SMs5tXRxsd3XBVMcYFkjhOojZMQ/Y+T9qFXZ1xmY/eB37iEpMdLc6n6a+NZs3Co/sFk+l5o9aTmlsRjlTHrBRWo1YfS5O4xe84aZC4fWIn0UciPI4RZ2Dbm4wmtLx1PtgOKV0buDTJl8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+GyaYSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EF8C4CED3;
	Wed, 20 Nov 2024 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143368;
	bh=OCCtQUkmFoR9akyuptfADaI4wZwVOk9jv7fmEuJ+9VE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d+GyaYSrobevUvTCgzLahALilXE4YetqleKCo3kUr0jv7+BMMfiGw9MXWU9h0sxV2
	 Wi8zUxrABby9ZUhpvQWBMpSv/OLFjquoB6qt7+QTkHpyHAOJ/dskJFAbQzyMxIKOHc
	 JARe1RQPsiOtXmI/w90utlUKNJc2nr7wzxvo9HefHAvdXLYyXIVaURiokpkSGZJD1N
	 eT9Ha51ATwGX5xklJABnELTSQTM+A6jB/E7Evx0U3Ca2uU+il/A3AgWzfH7LJYC/xE
	 Kl3IW8AD1bcOjJ3CnZNhSwIsb2xFM/kKv/23Bj0/OWGsSFV3n8rhf1NgPsQnR9ZJRm
	 6k/bl4aHhrQnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB30D3809A80;
	Wed, 20 Nov 2024 22:56:21 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
X-PR-Tracked-Commit-Id: 903796855b6152c479bae07dcebded77897f9e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b57807cbbf36f17448cdb42e69a949aa76605440
Message-Id: <173214338057.1377324.11247263640577159717.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:20 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 22:16:01 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b57807cbbf36f17448cdb42e69a949aa76605440

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

