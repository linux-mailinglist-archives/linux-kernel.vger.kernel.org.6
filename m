Return-Path: <linux-kernel+bounces-521879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E3A3C36D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E69172A05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BA1F4621;
	Wed, 19 Feb 2025 15:18:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7A15CD52
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978320; cv=none; b=IAiu9UyJpDmQGu4cmLF7Y6KPSwq7T1MUSDVq4udtxZp7A25DeUgdn+Y/PrcKozmvoYS2m0gG5YQ8PgaGMGX5epRWwJbsPQXoJBRbH315rTQfwu4k8JDm+Nhot/D86PcS16b770B3zwmGsSEe/+TicUSoyU64QjZMAJb3qWEz1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978320; c=relaxed/simple;
	bh=IYMOAsuocQeUIhrt3NQrP7BYsYpAi8IZBrqhx9VOmZg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qQqWCnfdUW6/43mBupsDtm22lhk8q1UhOD84wJdqtJvH2KOuN3CaFvPyOqZnWBljmTouh5z2lGxDRBxKqeIoQ/vV/ib7p5OrzGXxljeMbB7PKUS7rgHOrfhcFfEXIf9CgmZbdl3kDKouBA0zcklnIrWEGsmBp9sD5nrNCQ6yFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7856BC4CED6;
	Wed, 19 Feb 2025 15:18:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tklqp-00000004bYI-3w7Y;
	Wed, 19 Feb 2025 10:19:03 -0500
Message-ID: <20250219151815.734900568@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 10:18:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] ftrace: scripts/sorttable: Add arm64 and remove weak functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
sorttable/for-next

Head SHA1: 264143c4e54412095f4b615e65bf736fc3c60af0


Steven Rostedt (6):
      arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
      scripts/sorttable: Have mcount rela sort use direct values
      scripts/sorttable: Always use an array for the mcount_loc sorting
      scripts/sorttable: Zero out weak functions in mcount_loc table
      ftrace: Update the mcount_loc check of skipped entries
      ftrace: Have ftrace pages output reflect freed pages

----
 arch/arm64/Kconfig      |   1 +
 kernel/trace/ftrace.c   |  44 +++++-
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 401 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 436 insertions(+), 14 deletions(-)

