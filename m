Return-Path: <linux-kernel+bounces-319938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C789703F7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438861C21116
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5E166F2E;
	Sat,  7 Sep 2024 19:45:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F63CF73;
	Sat,  7 Sep 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725738321; cv=none; b=ctQUxovfkPFrfzH0mPc2NY1x++9gv49VKqj++D5edDuTmoQBF1OvxeGf3ezJvPcZVj9wIVC7IpfQtIcQ23IGWaspzJZlt/5Zl7WvH1pHv6cG8jd9k8WsA0DzQT1VKCpt4j2MEnk0R/av58V0peAp2dUviTuMUSxcwFX//3GVeKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725738321; c=relaxed/simple;
	bh=a11L3BiqR8pWB1XEUA8SYREbSUpQyEExYTYDAV7HqLs=;
	h=From:Subject:Date:Message-ID:To; b=nZcK9pKmXHtnxtGGCdYwRfzvb7AGj9Eu4j9LX5u1M6MT0y9Y1WU12P/O++KwYlXrz+W2f4KGiwNHCQabx2akC+lcnrv5yi6ZZF26t5y4SGomH1a3A2Da2IzdAtHR/Dr/eyuLkAIMwE32g6Jr7xGsle7rsVn3Yn9gztoesk5IbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2450FC4CEC2;
	Sat,  7 Sep 2024 19:45:21 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.108-rt40
Date: Sat, 07 Sep 2024 19:44:40 -0000
Message-ID: <172573828019.1778744.8853962147785788605@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.108-rt40 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 218b08de751396df722ba7ff028113ab2d385bbc

Or to build 6.1.108-rt40 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.108.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.108-rt40.patch.xz


Enjoy!
Clark

