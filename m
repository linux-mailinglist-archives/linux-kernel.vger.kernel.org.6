Return-Path: <linux-kernel+bounces-363038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068499BD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC7D1F21C17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1799460;
	Mon, 14 Oct 2024 00:58:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF3E571;
	Mon, 14 Oct 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728867524; cv=none; b=XR30Dpl/kcqle6VQa4U9LkgvV72QeX0Qf2bXNXdPogQJUfDgzLt2Xxbg/jKk6G6gYSRpkCSW4w42daM5lBnEt7SYHbsadOks7zzIU9z1dP+aR+swxM21XhQ3MCm5DU5pNSALdbP23PeAncI7DUvhKrVHdP8PdbzYOax5r7KWS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728867524; c=relaxed/simple;
	bh=Gr+KlT1rcgr7lKo96GtTAiXjZh73jf03wqP/VShyVoU=;
	h=From:Subject:Date:Message-ID:To; b=eSI5npDCSOIIR7bfVuaJw/tIFYyTwoevWKrNUOLYQxk6jWhQyPGRbB0LKoPjte05Qri0KUOTznrKInNRTJkDSuo6jm6dg625yAcb1qGRKW5cf72fDKsRBgGjtPU9/10DOTdmNVKYYEnjYJwtYMix63lp925w9WVmUye4TNZBE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FCCC4CEC5;
	Mon, 14 Oct 2024 00:58:43 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.112-rt43
Date: Mon, 14 Oct 2024 00:57:47 -0000
Message-ID: <172886746761.1228816.10896284728770667009@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.112-rt43 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: aeb869fed79ab431e8ef77d8d655755ab3ec9a15

Or to build 6.1.112-rt43 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.112.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.112-rt43.patch.xz


Enjoy!
Clark


