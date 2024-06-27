Return-Path: <linux-kernel+bounces-233016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910A91B121
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB261F25AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC91A0712;
	Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC72196D9E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522124; cv=none; b=HFO00dRz5zpFmYNf3+ajyhYil10z5+T0kLgc/oF0/97coZqvpBr137JDgmkJY9OcdAms6N/5islJXXDsxkTvxE0GFwu1A7ZE5/cOyKCMCoiWlz6cnsG11+KO8cjnsAt+7dWBdY9FS8GkWYmMtq5z4bigo2Tdvh+CQoIU1UkuNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522124; c=relaxed/simple;
	bh=DVtMMc9OlTJX7o3pm0rA4xPaTq1t2DVjF1as0YkxMGI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=AQRzYk42+m87lz54P49NOh7rHCLS4xj9jtzB4i9xCI7RvuKaVwWBTRt0eHXzyTSLCG8E8qoJSGX7Ktg7nMs5S88f9dhyoUUNOYl2tUUQ8cUjBkp2nt3MfJoFCdv9aXXoqSMPOyy0TjVf8pPBN/epIZyIrhKsrw9rcmEL5MUaTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC24C2BBFC;
	Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sMwGe-000000031jb-2Meb;
	Thu, 27 Jun 2024 17:02:56 -0400
Message-ID: <20240627205022.857212058@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Jun 2024 16:50:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 0/3] tracing/tools: Updates for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In honor of Daniel, I pulled down his repo and noticed that he had
a for-next branch that he has not pushed out yet. So I just took
his branch directly, and will be adding it to the linux-trace.git
tree. It is mostly trivial changes.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 28beb730ee167e505c86d1a8ae239e97d0136b13


Daniel Wagner (1):
      tools: build: use correct lib name for libtracefs feature detection

Luis Claudio R. Goncalves (2):
      rtla/osnoise: Use pretty formatting only on interactive tty
      rtla/osnoise: Better report when histogram is empty

----
 tools/build/feature/Makefile          |  2 +-
 tools/build/feature/test-libtracefs.c |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
 tools/tracing/rtla/src/osnoise_top.c  | 19 +++++++++++++++----
 4 files changed, 32 insertions(+), 6 deletions(-)

