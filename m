Return-Path: <linux-kernel+bounces-449327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D879F4D40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1086163079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18931F6680;
	Tue, 17 Dec 2024 14:09:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428291F4715;
	Tue, 17 Dec 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444581; cv=none; b=DB6bz6TV7nCWDImCljRE9vFYhsd6NWerOHez7XVcXXSqMb85XRsbsw0V2YE2AW9oSG1gOambPhSm/Dq9gFXAYcCD+2fWCETDszbSw7pH/wOUakxQMHa7s0vmtGrCr4yhS5XqNXAz27r7JUfhZRoiratguhIjJpW76RRVRuHAbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444581; c=relaxed/simple;
	bh=rDonAVGGWW6PFKwxtszDRWhSj8mUk4mnoimvKQa925s=;
	h=From:Subject:Date:Message-ID:To; b=ZRnKgDmvgy76lHfND94RD7k7vmYYkG1lv3UUvS4TwccVZJT/G1bEdYfQSoCGcvB4WZQYFQWYeTjnif4EYSrVsDjq2Wm3ivdp0bLkH0zOOwrUn+Ua31/ye+0T1yroqBYXNb71Ym4np/RAMS+M8KgCjKIuuriN8OAMLmF2yKuLDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C821C4CED3;
	Tue, 17 Dec 2024 14:09:40 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.65-rt47
Date: Tue, 17 Dec 2024 14:07:11 -0000
Message-ID: <173444443147.646964.7670137323699042231@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.65-rt47 stable release.

Note that this was originally going to be a v6.6.66 based release, but that
stable update has a number of merge conflicts specifically that collide
with PREEMPT_RT changes, so I decided I needed to give that a bit more thought.
Hopefully I'll work throught those conflicts next week.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 01b5936cdde41052fc80f5c8cb65f5b2dfaa2f0f

Or to build 6.6.65-rt47 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.65.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.65-rt47.patch.xz


Enjoy!
Clark

