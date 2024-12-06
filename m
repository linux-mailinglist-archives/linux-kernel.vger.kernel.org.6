Return-Path: <linux-kernel+bounces-435624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B461A9E7A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B961886BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C420458E;
	Fri,  6 Dec 2024 20:57:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302021C549C;
	Fri,  6 Dec 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518645; cv=none; b=QBNUD50kf7N699cJe/9UgQ4Yx+MaC0/EDND6J+Mg1FaQMdgp2sU+z2Ofn5Y7XjjsJss1n++bE3lPOWNkzd9PTp6Fer2Y7NmZoFI9KqBNQbYX+y5pU0iGuzyoMPmgkjRMYDnC9Yw3SVizaBVRs90Y2ZkouurkNiZEpiC/VP1+Ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518645; c=relaxed/simple;
	bh=ZP7UiqdbBNdHAqucmBS/M5PAsBe7svsYFbqLSaYtB2k=;
	h=From:Subject:Date:Message-ID:To; b=ckw7SDW6O/fTRbmArfBx6VSBlGqHuLNXpC1aw2MKcp3TndPOh74J5u2mUpv74MPsZOLE5Cugl/+9agFeQYTb79WKRvI+dsn7+MJQldHY+AwTnWiFm8Lf5BX8qjqesSjBOY8m8HI8ReZwxMXSuuT2X8peGcnH7B77Z94j79grJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918C4C4CED2;
	Fri,  6 Dec 2024 20:57:24 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.173-rt82
Date: Fri, 06 Dec 2024 20:56:49 -0000
Message-ID: <173351860930.297920.1001273895589568079@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.173-rt82 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 558934529c41c96d730426f18fe0c9aebdcd55a0

Or to build 5.15.173-rt82 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.173.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.173-rt82.patch.xz


Enjoy!
Joseph Salisbury

