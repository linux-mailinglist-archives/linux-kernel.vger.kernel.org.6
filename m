Return-Path: <linux-kernel+bounces-254164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7C932FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C850B20A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F41A01CF;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308A1F171
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153194; cv=none; b=HXOYKxdjtHqQsj4nyGQTmiJ3wNdmgE9NgaacKD5OEIgG4yM1fiQ7Jfge6WM3B+URnxIWVePPGbVA0CbjHk862MGUyFtaVyF49gwLXcfaPQ5vzKgjzy9AGMsvNaV2jlDZyvj6OZG0RO/tw8VcSHVG9OvDZvbrEBwmC5IDmsCd6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153194; c=relaxed/simple;
	bh=0o/1U5JRdTwRrW33oYSr9k+DHLLqFJzfoxvtBKudZoQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=rBX1AlhR/jHHofBjI/lt7/hixvz1XkUoAMPaIFYTajlDohfZki6Br/pi+7bJBS4Qp+wU6nseb7gYivUR78WkwIeo+HcTJx1asfjaxtVxsKxJcoDu7xRhhKXc51poJHqcU1WCBbbsckZlmOdRZ0jCEHzHL57l43AB+Xu6m7qemU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299CDC4AF0B;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmZO-0000000072I-3aFf;
	Tue, 16 Jul 2024 14:06:34 -0400
Message-ID: <20240716180613.399475893@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:06:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Last minute updates for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 7dc836187f7c6f70a82b4521503e9f9f96194581


Luis Claudio R. Goncalves (1):
      rtla/osnoise: set the default threshold to 1us

Tio Zhang (1):
      tracing/sched: sched_switch: place prev_comm and next_comm in right order

levi.yun (1):
      trace/pid_list: Change gfp flags in pid_list_fill_irq()

----
 Documentation/trace/osnoise-tracer.rst | 2 +-
 include/trace/events/sched.h           | 4 ++--
 kernel/trace/pid_list.c                | 4 ++--
 kernel/trace/trace_osnoise.c           | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

