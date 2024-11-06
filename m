Return-Path: <linux-kernel+bounces-398700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067F9BF4DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242EA283B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F391B207A3D;
	Wed,  6 Nov 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzOVXNrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E92166307;
	Wed,  6 Nov 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916660; cv=none; b=hDAJqBhdcPl9BptVnBukUcw/LU/zVFzQBvyU7dUUIn3TNqioD3Muyw8gj+YqstiC5hthMNMfuGuMBxK35/S0bwifvsaT9Irf63uCrfhK2qZyz+i5FnM7VpJvU5wbTmM9MqCsWrkkxmQBB7KHMYOfumYt5sIBKlZs3sO8W6REa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916660; c=relaxed/simple;
	bh=oKXOtkyrXWWj/HE3xeBNu4hKNTEHDC7Alj3mGZTUkcA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C64H8bLm/cFKUZGtzpypSBsipd/rbRC42ngLsZEVaTBsBOJXaEgYqpyZygg3M7ubfIIVj10cHfy/vC5XE5Y7wc4+9DPhMphzMWG8ZsYGxKZHvxpxIL0ghNkFhI/ae93fQTMvYmIQYkw/fMKFs5+4/5I82nGEjfEm+VwzRguAGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzOVXNrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3490C4CEC6;
	Wed,  6 Nov 2024 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730916658;
	bh=oKXOtkyrXWWj/HE3xeBNu4hKNTEHDC7Alj3mGZTUkcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UzOVXNrfkaHCRzcrb6ocHIIX+WSv6OaUe6HVgMnCYhvp23XTzCfTgkLxLqCpkztZO
	 Ls/sso9pvzjxLQCWtUah6tuMEnJMBHv/NFA6YH/+UuaCHbizhmTya5s7VUS79/5F7K
	 FUxTL2IARKE9yrF1gtehVNf+ug3TJkkeHymFq1IK6EthkmNhfi7x7Ycu1e6qyzM2Gg
	 funInsvqhzYaE9ZqE/lKywTWpZhi8eLOEf61YBc+9JIsjv4AnPja/Po2ZKIXLb1g7f
	 WdW0C1Wiq9zCUVuqBwA1mVmnNgM7SEjRKAzB58UNOCE+gfUYJCrEvAqnXEW3cGg0JG
	 9tNM5UB4l6Elg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3525A3809A80;
	Wed,  6 Nov 2024 18:11:09 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.12-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <24e9383b-bc82-48bd-9de5-da0b8ae9b1f6@redhat.com>
References: <24e9383b-bc82-48bd-9de5-da0b8ae9b1f6@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <24e9383b-bc82-48bd-9de5-da0b8ae9b1f6@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-4
X-PR-Tracked-Commit-Id: 1be765b292577c752e0b87bf8c0e92aff6699d8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b226d019836fbab759be8f62818851ee5cb0d9de
Message-Id: <173091666789.1367622.14770542544018638991.pr-tracker-bot@kernel.org>
Date: Wed, 06 Nov 2024 18:11:07 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Nov 2024 13:06:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b226d019836fbab759be8f62818851ee5cb0d9de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

