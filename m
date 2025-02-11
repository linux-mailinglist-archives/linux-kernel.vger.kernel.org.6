Return-Path: <linux-kernel+bounces-509854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0ACA31524
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D04166352
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04102269CE7;
	Tue, 11 Feb 2025 19:23:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036E263887;
	Tue, 11 Feb 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301819; cv=none; b=ptlOi0D2Y9Qy4Gyk82hdbGTZgGivmJltkhvlRB8IB+xstpNkB7wlReLKgBHdGJA7CoTGLFVvGdgJhRzdqnCOKhk+kxUBbN+I2AdqLKY5/NfKccylHZEvt+w7p96Ty2e3aYKcmgp/e6FJ9nxXOW+UNehFFCHx/UbdX8yJTbmU+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301819; c=relaxed/simple;
	bh=aggAe8fHAizfpeAH//5i3NJGeL7PvsRvpIGGY09JX5g=;
	h=From:Subject:Date:Message-ID:To; b=K1P2CJxRBCyGAm+bWLrMPsrc6IHHNK3rIq7M7oJvZ+nIi+lj6cRQHdlS1ZzHLC1Ih8LKL8gUairId3OltoJri/LXc3WjapPApnXygqLX2HkP4Qqyxecc7xlLymKhDtrnPzOxLuqJq49MYRimcuK2q6sh+rPFS8FXCDODG6sYmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA74DC4CEDD;
	Tue, 11 Feb 2025 19:23:38 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.76-rt49
Date: Tue, 11 Feb 2025 19:22:48 -0000
Message-ID: <173930176802.665083.12006644729227619653@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.76-rt49 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: eb0ecea9c61288d4af1a6e54237b969d74ee9ad4

Or to build 6.6.76-rt49 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.76.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.76-rt49.patch.xz


Enjoy!
Clark

