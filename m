Return-Path: <linux-kernel+bounces-576083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B033CA70AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A2D19A0B00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273D1F463F;
	Tue, 25 Mar 2025 19:49:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5151F152A;
	Tue, 25 Mar 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932178; cv=none; b=BG00BD2MlCIiZv2uYMyNA+ukShxrrPdgB6GRTbxAvfZD8CuSyeXCwAdw5DuBkeHj/AY6IOjHU3i6Ag/lWCvZrmJVQmGNVPv7kHP319WBAzmsY7ZWXDgpFXWCIs0tPNHtwWxiUCAlxMxoeWuxvgwBPvWCsugqKgJG46SQ3FfcAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932178; c=relaxed/simple;
	bh=11PceBHmr2h6Io1LcGM3hWr2ukF/qSGUBM0IF/niTKw=;
	h=From:Subject:Date:Message-ID:To; b=BWXK54yrbTbtFDwazcR4vZtC2gSQdT/sIjrmDDNf+rpUYfE0Km3K9vuP8FRkztb2Zwdb2qbaN7lI1o5DI0J6/vFWcm7QHU2feKRwaeBvAMT2sVSBYB53eMggyQ5novAIeBSJyk/2thratHkRl3bJLHej+apKmogeXoVZGbA6mYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A858C4CEE4;
	Tue, 25 Mar 2025 19:49:38 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.179-rt84
Date: Tue, 25 Mar 2025 19:49:17 -0000
Message-ID: <174293215757.812224.5467551567780761272@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.179-rt84 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 7ac5ee098afa36869af41948246db1dbe2000db7

Or to build 5.15.179-rt84 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.179.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.179-rt84.patch.xz


Enjoy!
Joseph Salisbury

