Return-Path: <linux-kernel+bounces-327409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA894977594
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9670C1F25FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441471C2DBA;
	Thu, 12 Sep 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM2cxeZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F631C32E8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183763; cv=none; b=LDFF+lZEjCFS/QcQ38VIphvdjeG2NZlA/l5viIaJJHVdFyChZX8Lw1vLwjIQZWI8se9luFqGewHtCWuEibtoFYLQYGKUi7Us7YdMoRm8FCyJ5ylQNZaL05FMOQ0b2GVcitCqLlKjV2Y8wol0vk5BfY0+DVurB1qDXZMwCmqyLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183763; c=relaxed/simple;
	bh=6BxCVa4jchysf+xcKSmpn+RyrBWw6ePZ/APiHaxfkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WAMrqudRn6rhIcrCseS9e/gtVpu+GdgNiEyMaRb1KolM6+ARvJ80684UNykqDKlMlGz2KzlCT05GoflY9scnEPjSJndAfAFTtFQ8eycnbceXShRwrPFw/rFIitS7GRMNpBuhBqfBtGUSQW1l0USppZsdAmCv1HT4ZsH59Bk7E60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM2cxeZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3643C4CEC3;
	Thu, 12 Sep 2024 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183763;
	bh=6BxCVa4jchysf+xcKSmpn+RyrBWw6ePZ/APiHaxfkNk=;
	h=Date:From:To:Cc:Subject:From;
	b=UM2cxeZ7YXYH8JtPOTtisPY95zwVoqR99E2A2+BD1IhIclvi09Rui8NmO3RqMxlIU
	 6tusGyswu4yJeSuF8NMInEDPUb0bteda3+5XYIgBcJVA/Drmil44buSsCx/34XC4Aa
	 QTejFBSZtbOKo1WiaTd/Rg+6S8QvqD1KbmtU8BfoRuhzaT6ORzo0muQ/Y/pgwn55EA
	 hhP1BooUqVoxB4v805L3OWbUQs+wTeI4g3rikKoMJ2iTCQNPBeItjQo17jCZU8WYB0
	 ijNXybVWEIHXrizDbwZqSxC1q1fvI1161Z/iWnWWapfqnyrEKf0Ks/faDsXXApyncJ
	 hv+0wEtjJzinQ==
Date: Thu, 12 Sep 2024 13:29:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.12
Message-ID: <ZuN5UuqKk6q16EGl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.12

for you to fetch changes up to b4722b8593b8815785bbadf87f13c88e89a0ebef:

  kernel/workqueue.c: fix DEFINE_PER_CPU_SHARED_ALIGNED expansion (2024-09-11 08:10:44 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.12

Nothing major:

- workqueue.panic_on_stall boot param added.

- alloc_workqueue_lockdep_map() added (used by DRM).

- Other cleanusp and doc updates.

----------------------------------------------------------------
Baoquan He (1):
      kernel/workqueue.c: fix DEFINE_PER_CPU_SHARED_ALIGNED expansion

Matthew Brost (4):
      workqueue: Split alloc_workqueue into internal function and lockdep init
      workqueue: Change workqueue lockdep map to pointer
      workqueue: Add interface for user-defined workqueue lockdep map
      workqueue: Don't call va_start / va_end twice

Sangmoon Kim (2):
      workqueue: add cmdline parameter workqueue.panic_on_stall
      Documentation: kernel-parameters: add workqueue.panic_on_stall

Sergey Senozhatsky (1):
      workqueue: fix null-ptr-deref on __alloc_workqueue() error

Tejun Heo (2):
      workqueue: Fix htmldocs build warning
      workqueue: Fix another htmldocs build warning

 Documentation/admin-guide/kernel-parameters.txt |   7 ++
 include/linux/workqueue.h                       |  41 +++++++++
 kernel/workqueue.c                              | 107 ++++++++++++++++++------
 3 files changed, 130 insertions(+), 25 deletions(-)

-- 
tejun

