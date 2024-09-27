Return-Path: <linux-kernel+bounces-341633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A521C9882BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A6B22B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D041898E4;
	Fri, 27 Sep 2024 10:43:18 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CA13698F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433798; cv=none; b=poREnT2r2V9NDnKqeb/g5NXt7Auw9GkV5kRZIUEyGouLC7h9LlKUas58bhcld+cjlWSlLFCaVjph+dj5MQh8CIkZDlbMIdes6MvIYpNe2/L61dYf9Rfp93OZmNtYImCM19uBjx7QEuJl7Ql6lD98WIcS3SvLayb2COZ6jomINSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433798; c=relaxed/simple;
	bh=jT9/gF9zN9f38Kg4XvuycEliaYf16e0Xx2i3cfsIKhk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B2TN6GmYv8deomNmze5vPGgFJ7pZAxhSaDfCvLofUvpwL9jL5LBVFUhZczT5MCONPgtW/uig5zcKgqANXjAfSTbi5do/WsTAEWEEHyMH+e1Ri1Lq0yXKg7JNkW+DGKp7zCP7lPmrx8PSP/87JFbWPTzSXHOj4n5mXr366ASFAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48RAh59t039794;
	Fri, 27 Sep 2024 19:43:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 27 Sep 2024 19:43:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48RAh58B039791
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 27 Sep 2024 19:43:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
Date: Fri, 27 Sep 2024 19:43:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [GIT PULL] tomoyo update for v6.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit ada1986d07976d60bed5017aa38b7f7cf27883f7:

  tomoyo: fallback to realpath if symlink's pathname does not exist (2024-09-25 22:30:59 +0900)

are available in the Git repository at:

  git://git.code.sf.net/p/tomoyo/tomoyo.git tags/tomoyo-pr-20240927

for you to fetch changes up to ada1986d07976d60bed5017aa38b7f7cf27883f7:

  tomoyo: fallback to realpath if symlink's pathname does not exist (2024-09-25 22:30:59 +0900)
----------------------------------------------------------------
One bugfix patch, one preparation patch, and one conversion patch.

TOMOYO is useful as an analysis tool for learning how a Linux system works.
My boss was hoping that SELinux's policy is generated from what TOMOYO has
observed. A translated paper describing it is available at
https://master.dl.sourceforge.net/project/tomoyo/docs/nsf2003-en.pdf/nsf2003-en.pdf?viasf=1 .
Although that attempt failed due to mapping problem between inode and pathname,
TOMOYO remains as an access restriction tool due to ability to write custom
policy by individuals.

I was delivering pure LKM version of TOMOYO (named AKARI) to users who
cannot afford rebuilding their distro kernels with TOMOYO enabled. But
since the LSM framework was converted to static calls, it became more
difficult to deliver AKARI to such users. Therefore, I decided to update
TOMOYO so that people can use mostly LKM version of TOMOYO with minimal
burden for both distributors and users.

Tetsuo Handa (3):
  tomoyo: preparation step for building as a loadable LSM module
  tomoyo: allow building as a loadable LSM module
  tomoyo: fallback to realpath if symlink's pathname does not exist

 security/tomoyo/Kconfig         |   15 ++++++++
 security/tomoyo/Makefile        |   10 ++++-
 security/tomoyo/common.c        |   14 ++++++-
 security/tomoyo/common.h        |   72 ++++++++++++++++++++++++++++++++++++++
 security/tomoyo/domain.c        |    9 +++-
 security/tomoyo/gc.c            |    3 +
 security/tomoyo/hooks.h         |  110 -----------------------------------------------------------
 security/tomoyo/init.c          |  366 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 security/tomoyo/load_policy.c   |   12 ++++++
 security/tomoyo/proxy.c         |   82 ++++++++++++++++++++++++++++++++++++++++++++
 security/tomoyo/securityfs_if.c |   12 ++++--
 security/tomoyo/util.c          |    3 -
 12 files changed, 585 insertions(+), 123 deletions(-)

