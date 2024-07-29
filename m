Return-Path: <linux-kernel+bounces-266375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAF93FEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCA1C21560
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7A187842;
	Mon, 29 Jul 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT6HOtVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BD131E4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284191; cv=none; b=Pr+N/kjiBIgSXJOExtniZ2n6zuT2FU/AKzdJO8rmn5icNfqlGRpP7t4TNuLS9wO3bhkmYrAKvfRP7a5xbW2l89dtr0ZTvtOXA99GArq5and1LzRqPfz1zXFbcwi5lriIiKcxadbKZJudIZyPUoEsIFoJVwafEmGSuyA8dwMxiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284191; c=relaxed/simple;
	bh=DoaZfjOuRX5QWhGhy+HpCBG2aFIJbGKEgIJe0MM13Jc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AqotFalmQUmyP003UhxXw32YFFE+v/MllhQ87wEBGRc2YNm85mVi68Gij33zNgwsW8ZcUuNCp1f0LevihOQjpH04DtyI6qTJfRLkJQ5ICLjnjuAHy5ePXiPxKfcmm9KcWXRxBlO7SmLe2z+7s+4OGM2Q/PQbK47nl7lroEPfh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT6HOtVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19740C32786;
	Mon, 29 Jul 2024 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722284191;
	bh=DoaZfjOuRX5QWhGhy+HpCBG2aFIJbGKEgIJe0MM13Jc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bT6HOtVMpvGUJC/vjNzdnHev7rbii2camK9Bm1jfv/OTrHDcW5l0jwO/cuGk7DtcO
	 fxhbahu3AbOpGkqfY2bA5w+AfAv/fJf0dPu7fjlc7khwvYeLGWc70SiSqDoJoNPuUF
	 usnOcJzmFR6M4unRv7btJoB2k6lcfAQ+Ymf/BV68cDJ9nyi0prmCeD5uqJQmBwqjCr
	 UT7oFSps45ecaF6fhNqqcre6lGvGwyHsBR5b4VvkT3i6fxLnxhh8YQWp9avw5RgF8E
	 yaMdyfgu9wZs0BnnCf9EgQ/5CpHhyNSUHs+BnqZVoitAA9AeI9Eq/YxKZYWylOsR1n
	 UZF65Db3BOIgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CB66C43443;
	Mon, 29 Jul 2024 20:16:31 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <l5otbjtybgwldxsmg7cqeh5ecbenu6rhal4rewjwsfe6hham46@szo6q2kcg3ir>
References: <l5otbjtybgwldxsmg7cqeh5ecbenu6rhal4rewjwsfe6hham46@szo6q2kcg3ir>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <l5otbjtybgwldxsmg7cqeh5ecbenu6rhal4rewjwsfe6hham46@szo6q2kcg3ir>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024072901
X-PR-Tracked-Commit-Id: facdbdfe0e6202d74758387ae9189c39f7b4b16c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b5faec9f564ea627c66064a4a6a5904fe5a07dd
Message-Id: <172228419104.31709.554837129219110765.pr-tracker-bot@kernel.org>
Date: Mon, 29 Jul 2024 20:16:31 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Jul 2024 10:44:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024072901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b5faec9f564ea627c66064a4a6a5904fe5a07dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

