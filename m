Return-Path: <linux-kernel+bounces-380619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB49AF3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9461283355
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C61FE10E;
	Thu, 24 Oct 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf7RO4wF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F715A868
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802021; cv=none; b=iyvxXWuoh0sCZ54sQrdK9n7Bk9MHZEuXyRNn1a+2n0y0/z2cQWaQECnqhrHxPMd0ANozTPQTFEuz5pUJ0KhXe8DoNc5Mcl9uI2o8PQITbQL16ZcTXRXPrVNfoMxPLkaqdlIrl/io0bPOnWhgZm+EHmV+288lNX92As2iwr3U5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802021; c=relaxed/simple;
	bh=7I2X+qZ6mP4hmuNpH87zCDTOI+rs15iT+RXn7G4wTfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KalK4F3IkqgjPH1oPeFpZNzdcVEvcEOgoftbD7DgWCSM24L7IFm+TH2c7LCGu+mfKTV6sWqQdjELJv1sxFSo/5ynZOLwAgdDrkYP8ZQ0hoYWSJtpz9Q/htBlceN05IeaHmceQ8Ol5q0ND+SnQtn8ltPanVPAwVqa1X6cSoU+y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf7RO4wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09276C4CEC7;
	Thu, 24 Oct 2024 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802021;
	bh=7I2X+qZ6mP4hmuNpH87zCDTOI+rs15iT+RXn7G4wTfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hf7RO4wF8I/NOH5RvyHPsBwiJWbXw+SHhVGp+xJ9FQGUWFLeKO7Oy8qcvcpj3zKHt
	 YlSxwHb0CJf1GTtvOIL7fAcXwQRDJbaKg06o7OO6FkHMqAYugHU6zMkYzR7cuIB6S6
	 dmsZEGeL1GubYtue7bua8/rBSGjoBZuVkEfLSWmjyDmwF63GIMJVQkL41Ph9wpnxvy
	 DABhibo7mwV8jSzNspZhh5ApCmZPHmEuGCdx/BOgRxhO/xkf0ixe9HBgvMuJtM52PI
	 vkSZQ8jayvjRWjHj0iVyMVjyKA+9+iItk2+N0q+vPnuT7ontqbCcocRFpTfjLJNwFZ
	 L3x0TxNKHaheQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16D380DBDC;
	Thu, 24 Oct 2024 20:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <6b12f129-69d8-4bc0-b369-0942a6bd2d4f@oracle.com>
References: <6b12f129-69d8-4bc0-b369-0942a6bd2d4f@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6b12f129-69d8-4bc0-b369-0942a6bd2d4f@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.12-rc5
X-PR-Tracked-Commit-Id: 67373ca8404fe57eb1bb4b57f314cff77ce54932
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cc65abee8ee1ef5cfeb2748157be232262956a8
Message-Id: <172980202748.2376768.17508327356035946587.pr-tracker-bot@kernel.org>
Date: Thu, 24 Oct 2024 20:33:47 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Oct 2024 08:38:10 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cc65abee8ee1ef5cfeb2748157be232262956a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

