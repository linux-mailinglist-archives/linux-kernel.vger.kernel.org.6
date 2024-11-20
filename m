Return-Path: <linux-kernel+bounces-416203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC279D4209
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DA6B2396C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488C15747D;
	Wed, 20 Nov 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhbIQoZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9E15624B;
	Wed, 20 Nov 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127506; cv=none; b=L0Ye7KwE7hP7Y4sc8qH781/0raxHJP/8CLht8NHiw8Do9Hb6H3+BhhZFNs0z+WxVUBJrErwlHV2vShC3UREOqTNPjhbb+cC3vUogErogBRVX8QzLwVNI/5Dcp0fX3YAk3a529r/HmpQBI0O1A52tpaPHqFoykJHff9qIRfNnc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127506; c=relaxed/simple;
	bh=n1srDoU1b0h7yCnyW9fJWDuRcE4pWYnODZ8znYhlqxQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A+6iRhHsG6Hf+/hDKbHj0dfFQpPdFdG/HqMPsEG9qEEQoBBW1ju0ByykR0O320NL6srVeAk9DjQxYB9Ed3ZtrRAsI2s2fHfRE9dhfX8E/ZApOOtGcMrHXEdYD7YFQmTo9NQmusa9FJp+t1rkx1d+vcE1Ps7aV0HS0ZUA8T4rKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhbIQoZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EDFC4CECD;
	Wed, 20 Nov 2024 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127506;
	bh=n1srDoU1b0h7yCnyW9fJWDuRcE4pWYnODZ8znYhlqxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rhbIQoZmX2hvJ2+4LzWix+8eROlOjvuQXHpG7Sr+i/Fk2a12qmExwru0/wLH2XtHl
	 kcWQ0MCjKPNE1r9HF1PUBhZUxyzhtCQ491gH0T72s4m4NfuQVQ+odmUSCVlmUXD8Jd
	 fLSOK+BoPMNWcMTmBFyZps3YHi7jmypFIcaVcdSL8hL/ozE76sZ0RNU8J6/ANDGccj
	 2lHaCbwOHnaVYPLnDpNXsz64mo+K7DuhuCcJFAw9zfdBkTnZj6IESE5MRogsKTF+54
	 titkGFiIlIXqUtMcaX48hLejipADWLVaYikCSwOxN8ACqxTiv90oPlW0yrq+k6oF2o
	 PY82UxSvx5Esg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFEE3809A80;
	Wed, 20 Nov 2024 18:31:58 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <87seroh2qa.fsf@trenco.lwn.net>
References: <87seroh2qa.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87seroh2qa.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.13
X-PR-Tracked-Commit-Id: c818d5c64c9a8cc14853d716bf7ce6674a6126d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3cda60e83c803a3b3b832f371c776e57194b2f0
Message-Id: <173212751743.1310468.7879534812667580921.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:31:57 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 10:27:09 -0700:

> git://git.lwn.net/linux.git tags/docs-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3cda60e83c803a3b3b832f371c776e57194b2f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

