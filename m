Return-Path: <linux-kernel+bounces-413770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29799D1E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DCF283B38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315514265F;
	Tue, 19 Nov 2024 02:40:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B513C695
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984016; cv=none; b=iSbg7I4RKKlPLO1C7ATFZEZ9bDdWovsdKHM/Ugi91JcwaTbiyjOm5bJ2inGmTmqlUSt9eUascsL/kOI/nvbZ0Db+MkT+I98k86sunmEGg/ougUS0Gzwd9cr7fzms8bMuBvzkYRp5hedRdzcMoMDS/LmMOfyoVJDteKe9SMzgJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984016; c=relaxed/simple;
	bh=TYpwLVFhA0FIcqxoMuAZC8vMMRYAjn2k1qUZx0F2yA8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=XIfm0r0Jaz9yOOsEeitjfM5z8WuzrQePa7++Fu9gAC8oCI5ciWkGajaclI0aXjE+si05Od6gm+Rp8jkodoV6DBN3tZoB4zlnfkTqQxGsGXbpc4HW/D/xToIsLIFLz+RpkdBoAQNHEW4UHCXnhMoqU84G4kYHy2Rsm0DOLZMfZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11033C4CECC;
	Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDEAa-0000000ED2R-2ebY;
	Mon, 18 Nov 2024 21:40:48 -0500
Message-ID: <20241119024016.371665360@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 21:40:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Last minute updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 6ce5a6f0a07d37cc377df08a8d8a9c283420f323


Colin Ian King (1):
      tracing: Remove redundant check on field->field in histograms

Jeff Xie (1):
      ftrace: Get the true parent ip for function tracer

Tatsuya S (1):
      tracing: Fix function name for trampoline

----
 kernel/trace/trace.c             | 33 +++++++++++++++++++++++++--------
 kernel/trace/trace.h             |  7 +++++++
 kernel/trace/trace_events_hist.c |  5 +----
 kernel/trace/trace_functions.c   | 26 ++++++++++++++++++++++++++
 kernel/trace/trace_output.c      |  4 ++++
 5 files changed, 63 insertions(+), 12 deletions(-)

