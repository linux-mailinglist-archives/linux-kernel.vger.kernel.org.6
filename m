Return-Path: <linux-kernel+bounces-260444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D372B93A94D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110C71C22471
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62E148FED;
	Tue, 23 Jul 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du8I+pFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E751428F0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773613; cv=none; b=nVwZ+K7t8v8UeD6jhtmoApdTENWMPQQTK1TeC4mkJhNjcVSjZA9lE1ZfM47cW0Zgb+B2LHQGYx3U0K0vjrH6/0+DC1FgYPOQiLKreJdx8dQwBohCdXzLY+gpIn5rlJka5f4afz+M0237Aerl5vJzt98s/I+33YmmmgC7C8a1DCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773613; c=relaxed/simple;
	bh=qZ8wkkdS1/6f9bjx9ZaeHKYGJN0LmsRm2iUhVulcDDs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WUsv5mkEA4OHCQv8jTUTx+iNxXAPoZpEco2F8gTj3OwoJD1QmM+iGKRFsmcWbyd/lPn/M2lLwSNilwpSbqJGZgagezuu95PyYFsrGVc1b0dFVh974EO0Pj5/4LXs8pXLGSLNTgUBu2hLN67ZOqq0onh2B9o+/i/tf5Kz3txROTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du8I+pFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B84FC4AF09;
	Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773613;
	bh=qZ8wkkdS1/6f9bjx9ZaeHKYGJN0LmsRm2iUhVulcDDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Du8I+pFk543uRMNWBeZx56BYuFcDEE8TazJ8DlhKXWeUwI1VM3cJmaPUvQuFP4ePY
	 M+DgaxgyPXF/tJVjZHinkTY8Qzo3W0TD7wD7VW8rRVaVaC357vQgKE1jIUxWWtpEUL
	 pRxaQVZ+SUyfOqvx35z/X8s2AzqyWyFbRMo/KNtUpbfDA8JIA42q9i7Ge9kHQGLJ4C
	 nnY+Q+dafVMVBJcgtdujF42N9wMCRrV6bzcWC2BbzREAnlJhNNTdvQufBa4b7mYwYr
	 5J5bQODehIsavCNIG/PF0uZZbeYB89L5i2Tsa4D5wGirw4zFf/dqSKKzo9h/dOb2b1
	 DUMqPRf4m198A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72A16C43443;
	Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <4a4e7343-3af8-499f-8a7c-544848a71f14@oracle.com>
References: <4a4e7343-3af8-499f-8a7c-544848a71f14@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4a4e7343-3af8-499f-8a7c-544848a71f14@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.11
X-PR-Tracked-Commit-Id: d0fa70aca54c8643248e89061da23752506ec0d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 371c141464b8312ee4a298fad6d17ee26654b7d6
Message-Id: <172177361345.759.5687463486651349295.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 22:26:53 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 15:08:00 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/371c141464b8312ee4a298fad6d17ee26654b7d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

