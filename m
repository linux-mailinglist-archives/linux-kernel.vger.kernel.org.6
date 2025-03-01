Return-Path: <linux-kernel+bounces-540039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B617A4ACD2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EADD170BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1EB1E51F3;
	Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD91DF986
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846153; cv=none; b=JvDv5u+f20NMdTKdP/Yt62ikA4iCmn60Yy863nhDwh1u7kBkRSigp1L1dphqqMYWlhW6z2yXReVYbLt2yt2rNrY/bhrAk4123vay4+Y6jeeNJUDwYdKPgOVwxl/NkaEmnjQ7oAgnJQ+3GlQRG4uJn7jGvIbkAKAH+04rgkVYK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846153; c=relaxed/simple;
	bh=/hQRfvgKwabKrdoD/oiupNCsMSNskOcWt48X8Kf6mYs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ikdI8uxvx6wsy5f34quaGdNKsgq5uaGwjaASU218PMBHos5RU0OzHu3dl+r6TbeT+PFHdLO69tPvX+g9fpeag76No9l5Hsd2ZQ3KDK5bM8CzguVHpsRR8n1enQiY5Xv1HL2owGkr31/tr7JpqLY95VzomopgmhrfEIBwGKqBHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD76BC4CEDD;
	Sat,  1 Mar 2025 16:22:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1toPcW-0000000Agwf-2zqy;
	Sat, 01 Mar 2025 11:23:20 -0500
Message-ID: <20250301162258.654648143@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Mar 2025 11:22:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: a9a69ea8e363ccc7dbd49baec9f557cca79bcbe9


Hengqi Chen (1):
      tracing: Remove orphaned event_trace_printk

Steven Rostedt (1):
      tracing: gfp: Remove duplication of recording GFP flags

Zhouyi Zhou (1):
      ring-buffer: Fix typo in comment about header page pointer

----
 include/linux/trace_events.h   | 18 ------------------
 include/trace/events/mmflags.h | 41 ++++++++++-------------------------------
 kernel/trace/ring_buffer.c     |  2 +-
 3 files changed, 11 insertions(+), 50 deletions(-)

