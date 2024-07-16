Return-Path: <linux-kernel+bounces-253205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825A931E26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F94B1F229BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98B17BD2;
	Tue, 16 Jul 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCbAXvxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E3E541;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091114; cv=none; b=p9wmfaVXZdECeGS2Y08nCySFWcgB+muSWnqfDmpC/5P2YUjUbfJppazTN0I28kjkWuGTs4zaiKnRZQgTW50HFzA3ywQjWzvq27Q7JiNQpl+K/5tNDGgGJWhOwy3ptf4sLWU0M0vlXHcqkOQA96CnPstQgCri+WPmLERJM518CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091114; c=relaxed/simple;
	bh=srxK5AQQs2Z8EAPrrBPHxO+El3AWp0v3BRodEy9gMg4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NcQMX2BwYsm0KeOWmGVZFK6ZaAdC/tAjIXe9+uVN4Eedj8j7O5P+odAzc/lHhI17e1oq9veKK8oBO3Qf7w0UJC1WTVQ4btUev0BFGGJMB7D1oaO00Zj2FScBbdIS4XmKYBsjR2KQ/mThXmkEIY52HsFKtVy0YmqDOquJKgFHSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCbAXvxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C4AC4AF12;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091113;
	bh=srxK5AQQs2Z8EAPrrBPHxO+El3AWp0v3BRodEy9gMg4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kCbAXvxLbd3kjhCIpfCHky6kw6ShGctF7N5YaLzDbzF7ni0ZCUSpK/dWbAn6tpQur
	 rdgpjeJle1unIgVy+rLzt9/z86E+FmLoAsvEiCBJcl+S1bUzJu2cZyRLluNUUqquD7
	 jwYRtyjtNnpnwWLkQQ8fwdrEAKgJfc5XrB9CvwGgAlIwwA+PcanI9+16OBKUMilwta
	 EVMZ6ZoInVPm/irBLXIVQZNr+nIhSvDWeSUhpYG3bzp1nWlky0A1QeJhmuwzeLshjx
	 sEpvqWZ3l5JTZ+S68r++2UUUz7JFe2yzeaTjrQfjxS+d2vGazT2rGUWZMQCIZ6w96m
	 bL/S98c/WZ4kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB3E4C43443;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpSiUTZBAOgDYYNQ@tzungbi-laptop>
References: <ZpSiUTZBAOgDYYNQ@tzungbi-laptop>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZpSiUTZBAOgDYYNQ@tzungbi-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.11
X-PR-Tracked-Commit-Id: 4baf1cc54433ff7c6e5178517bc8768001416681
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89c491389331faea09a247da47ebd95982dae06e
Message-Id: <172109111369.26590.13999304546468370339.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:53 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:15:13 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89c491389331faea09a247da47ebd95982dae06e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

