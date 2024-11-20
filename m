Return-Path: <linux-kernel+bounces-416393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01739D4436
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D29281DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A241CF7CE;
	Wed, 20 Nov 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUIF6CF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF11CEAA7;
	Wed, 20 Nov 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143377; cv=none; b=Bf/EUtuhLOqJHboHF7lqdUsTb3Xqi6X3Yu5LlhobsMveLjjoSfWmgi0HprC0o/ZqivN5sPA10r2kQipRyOjr4sX7Gc7yy99tKLzwKGi7+Gc6HpjKIRY+LCQ5aTOaQjC0zAEhVtm1QikjYGqAc0tHvxjx5dlhNCk6UP9r/M3BmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143377; c=relaxed/simple;
	bh=VocptHBS0rmlrNpshNygYOGIvrZRrLn7KS4Eop2EylU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jXM1XO1AghWMpuY/95fBIww6hH+KUD9bVeY0gZRR1ZAb5I5sqk5noMSejHIR/yjCsjx/b0CWpjCzZ34kTNttWLcEaLsBeUQ7yeeK+LM7dWFiFgjcTdFhKB0cCH+VTMuRcGI7f5vIA7hov+tdtXeay5gkWQBBAQWXKAGA4UxS3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUIF6CF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EAC4CECD;
	Wed, 20 Nov 2024 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143377;
	bh=VocptHBS0rmlrNpshNygYOGIvrZRrLn7KS4Eop2EylU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KUIF6CF+FxuRJFPmxsEkhPsTfZZC7wYdMPE1wDHeSAk0ZTc+92iV5TPBDFx1k+gJD
	 xRKK27anan86wZeiqSRGWbv2eZJqI2SvLIamxPIm4X1dP7yBiYiyKVfWIB6tebnFDB
	 0RxB8kVKqFcYQuCwlt/KELJA36zbg5TyD8s/AiGWI93wJVWA5fmTxNpQgKgK8PUuiT
	 Ol5ihLcDVs7Us3/UYjRe3eghQLUYRHk0ChOdW+FR5KD2QtYu/RxN5/KYxU7U9fN2hO
	 w9Gcb3E4LhtSE2LfQWadR4lqUrgQvE98oczrDOuZiGYLtU1j5GVbv0b7ar9Y/rWSPS
	 GkFZpvQveo/TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349403809A80;
	Wed, 20 Nov 2024 22:56:30 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.13-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20241120133055-375032487@linux.intel.com>
References: <pdx86-pr-20241120133055-375032487@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20241120133055-375032487@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-1
X-PR-Tracked-Commit-Id: c6a2b4fcec5f2d80b0183fae1117f06127584c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcb3ad4366b9c810cbb9da34c076a9a52d8aa1e0
Message-Id: <173214338888.1377324.10487091921219395351.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:28 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 13:30:55 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcb3ad4366b9c810cbb9da34c076a9a52d8aa1e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

