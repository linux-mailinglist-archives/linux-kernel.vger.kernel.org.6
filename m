Return-Path: <linux-kernel+bounces-550170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A7A55C24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37BB1896AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDFB13D52E;
	Fri,  7 Mar 2025 00:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020835028C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308328; cv=none; b=LFoSSnQBM+QE8IW2xdEPNDjubmZ4TFmJK/mJIj4ke1FRFxYFYFM7AFhMD42aK/OxqzYZoSSbhEF00LDIIoMQjUFFLyIw08PYSj16AwHQu6/ZfUtrDjDqkuay4Ua+YgsmU9qk0vJSvwoa9EPCtU8tLaf1M55u+SmIYtDPZFo4B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308328; c=relaxed/simple;
	bh=ODGu1KUtq6L6OsCmFCgd4AbKUDCB2rn6ttG57ujgYYM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cHDTFVv4/0463VoeKhgNhhXnkGIze21TxE38hsMUOnIIgb2TXBSH3IaYOd+D6hhD9GvJuVSdxa52BeMzaa+WIbqEQepGooxZYr2BSEID2oW6rgEN8XT05bmRzZtFE6Jp4Q2PIHItsQgPqGRJfnSAwe8GM/b7eU1kUupONithKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E087C4CEED;
	Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqLqB-000000005Ag-0QhA;
	Thu, 06 Mar 2025 19:45:27 -0500
Message-ID: <20250307004526.954574184@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 19:45:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/3] tracing: Update MAINTAINERS file to include tracepoint.c
References: <20250307004511.688485107@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Updates to the tracepoint.c file should not only be Cc'd to LKML, but also
to linux-trace-kernel@vger.kernel.org. But because it is not listed in the
MAINTAINERS file, it does not get added.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/20250304103724.174ecb36@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..c203aa4225b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24063,6 +24063,7 @@ F:	fs/tracefs/
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	kernel/tracepoint.c
 F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
-- 
2.47.2



