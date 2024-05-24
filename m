Return-Path: <linux-kernel+bounces-188983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269D8CE945
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD314281ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30C381C6;
	Fri, 24 May 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb8NE7lo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD830364A9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573243; cv=none; b=R9vaaewTMkXu/u9f1pt+vxPtDgHxBOzK5ChngL7fB0+cnjfsTcT6DSyb1+4RcAh4apsqMSawlX46tRBAA8x1dFzmN+CtXwKlJ766EgsiWdW40SaOheIMubAKpEDVCIHHRFYJgG7XYIQx6xJf/UL8+jdXKexm0mI4AdHRgD6ygKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573243; c=relaxed/simple;
	bh=a8FRGjwS7yVe1x4dwsLgW7ohOOtu/OgEm0+BDao6S58=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N8acFQesefZvGi2eFkhALJLNGm9Pfz7YjBFYyG+R1tlDaYeuAMW5yUM5hxpHARYU5l3eALXuj60kIYTJp+/jmOdlkZKt5QWgT92yW5Upk+57bPQTuWalvai11N/Zn6NZERkT8FkTjhbBqXZA0CTWyTQaSuXP2YOe9kWEWZls90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb8NE7lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CF90C2BBFC;
	Fri, 24 May 2024 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716573243;
	bh=a8FRGjwS7yVe1x4dwsLgW7ohOOtu/OgEm0+BDao6S58=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cb8NE7lorRw40C+JkGbg7opxcHXe06A6eV5c0eN7VH0OkNI9cwAAa5IqU0b+xTkBU
	 JtUWdciILuzBbvF5wmknkNIdRai4p0j9iCl52TJJsBWntd8TlTHH/NzAbDB4DqJxDv
	 KPaldnsirqbv/eA1oU0D8vHV1qT2pcowQtlFY0R0/0LoNYZ+6wVEsJH6e7vuwEVoys
	 lblJN2N6VkxDGF14akxqnKzKDM+wywNQYQ14vMY2b/8ZK8MtJarOvMgRIK6LCK5oYc
	 SWfASo0gIs9hu3GZUR9N+yyNLT3yxjmjo9o1JhCGFiEohMftEEu/hmMGEUAaEOv0gf
	 2m1TAj69A6/RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8218BC4332E;
	Fri, 24 May 2024 17:54:03 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
References: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw2
X-PR-Tracked-Commit-Id: 6ca445d8af0ed5950ebf899415fd6bfcd7d9d7a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f9984fdc5e37303d7180ff7a85dfecb8e57e85
Message-Id: <171657324352.4634.9284203217407590763.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 17:54:03 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 08:53:40 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f9984fdc5e37303d7180ff7a85dfecb8e57e85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

