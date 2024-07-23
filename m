Return-Path: <linux-kernel+bounces-260381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B478893A7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA52B22EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930211428EA;
	Tue, 23 Jul 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS1C+93x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6613C691
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765146; cv=none; b=q9v781GcZyMU1ugs4k6HdY2qrbM52t/8UpsGjU8NdZmyWpFmTbK/1sM4CR8CqLHlIoObfszX0Iz+b4k4vN7zEo4HaDJr8OombpboPyLRA841C2T0JPY6u4vug5Wk5wpph9U3rjDnHzWgI8u/XZ5MjAjYA+Skb5qvGl3SVQkJ+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765146; c=relaxed/simple;
	bh=1O/B9GTC8E2cXsJ63wa22anOFBbmuWHij1ibjGag0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EHBP5I8/WWXWt6P4jBCxp/eYpdxsCY4keQdt8zHTDcW9OTDqk9dwUSckULyyMUbLJf5Hqb7IZyjjw0gv+u/r7SGTIhjDUvA/ezDwypCVhUVmeVuM/SSfYAnOcx0woOHw2TB5uqG/36uploDpKyjMs92Gu9Y/DYM1Huz6c8p//RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS1C+93x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E519C4AF0A;
	Tue, 23 Jul 2024 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721765146;
	bh=1O/B9GTC8E2cXsJ63wa22anOFBbmuWHij1ibjGag0sA=;
	h=Date:From:To:Cc:Subject:From;
	b=eS1C+93x31076H0tB/1kqgquIM6fXhUUjv9RdQlIDDCz8mxYrVxhOVVdDNgMvbT/3
	 MrcfP+SEtcDaDI+CVW1uIqImy0gkWghFZURFJz764RWC+qJJk3EldeRakD7vwonfPn
	 4WzC8x4Ae333pxyAgQFBTKoZnl1HaRTh4FpZ73itNzOGRW9c7L9huRj632PtRabna8
	 3GpJTZ8SZEz5J0gtMYLPkGtRJhoyDiXGeRTdMKbe8n/1HHSnqMJuECxRl8dR+7Q9Pf
	 b6rh7Qe8QgeT//AYpz1Xzh1tMy5AvbtAnFa3JIvssvHfB/8rEUxSa/Tb7QmsllTIOi
	 FSYNTUslhHTPA==
Date: Tue, 23 Jul 2024 13:05:45 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>,
	SeongJae Park <sj@kernel.org>
Subject: [GIT PULL] execve update for v6.11-rc1-fix1
Message-ID: <202407231304.04FE50257@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this execve fix for v6.11-rc1. This moves the exec and
binfmt_elf tests out of your way and into the tests/ subdirectory,
following the newly ratified KUnit naming conventions. :)

Thanks!

-Kees

The following changes since commit 21f93108306026b8066db31c24a097192c8c36c7:

  exec: Avoid pathological argc, envc, and bprm->p values (2024-07-13 21:31:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1-fix1

for you to fetch changes up to b6f5ee4d53019443fb99dd23bc08680b1244ccfa:

  execve: Move KUnit tests to tests/ subdirectory (2024-07-22 18:25:47 -0700)

----------------------------------------------------------------
execve fix for v6.11-rc1

- Move KUnit tests to tests/ subdirectory

----------------------------------------------------------------
Kees Cook (1):
      execve: Move KUnit tests to tests/ subdirectory

 MAINTAINERS                                        | 3 ++-
 fs/binfmt_elf.c                                    | 2 +-
 fs/exec.c                                          | 2 +-
 fs/{binfmt_elf_test.c => tests/binfmt_elf_kunit.c} | 0
 fs/{exec_test.c => tests/exec_kunit.c}             | 0
 5 files changed, 4 insertions(+), 3 deletions(-)
 rename fs/{binfmt_elf_test.c => tests/binfmt_elf_kunit.c} (100%)
 rename fs/{exec_test.c => tests/exec_kunit.c} (100%)

-- 
Kees Cook

