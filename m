Return-Path: <linux-kernel+bounces-268516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2EA9425A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56531F21E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC94CB4E;
	Wed, 31 Jul 2024 05:14:48 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDD4962C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402888; cv=none; b=blFiiogjQ8D3tPc7qyyeqC8Bgxq45CfHmiuC0pTLThlHtPLbrUDPwQgATqm/JXxz4Sz6kxL5DqHcH+DR5J5GC5EscYvehqkqBC9GCdeHZFn8mnAuPbPvG7RosU+6GF/YZiDqOI2jt7gk6skK6fIfCsPf8i28HBLlEcHvpwDmnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402888; c=relaxed/simple;
	bh=4ZI0Wpyx7ga2N+tZBpBe2IUKk5wgli7LcgomRmI+zTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQuF7S6NcEqrX0bQtugtyATva2vg0hREQj8fSm10AbWto+3101VqCN7m70vY9g6fgPNH5/QHiViV+EIx3dEgKXAFf1wpAe5Q0p1AR8ktuWGJXx/K37MLFI6R/TiaJ7oT5O7nGgWUrQnK+Ytz+9cvPt4uzNHofrTzwskii6SWZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fea44f725so5149811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722402885; x=1723007685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bHr5UoxMmOWXdOMBm887AC2LAV/6qvukNS7WD9xl04=;
        b=QPc+/sKGSUXGVOpymrS4uMUot1fBcUpPqNGKJKzjZYKG8C+fN0o/u8myd5r7lsLMHR
         h5gjfu86gmr4c0o936RqEsKnc7N9K9JOG2qMJg8H/y/GoXpnBDT03IhOBHqLwaupA6pH
         XR6B5EJ1nJm3RvQD4x97kaXL47EP7MVkhAklEO9oTEgj+Q5iOqWLRvlg72SDe12261UF
         /X5Fgs7KJ9WI7jPcPRHts54/HmIkyY4Kd77Dl9AQ7BLOjVhJlFUZa9H6yRbP2rfNusMC
         fhhSCyFimIQysQgei62VIuubcOp7x01IIbzBVWygw5emnF3h6kIIX+PY7JvTC/++YW13
         +F1w==
X-Gm-Message-State: AOJu0YzOxSq5Kqsl/F6B8yyDo0MlyAwxbeBYF6SZ4CrXNWsLJm0ufwBJ
	96tU5cMwq4HnhrP8KpG9m0vhz1oCywiAFdE0++sGJMl9XCMgVgpU
X-Google-Smtp-Source: AGHT+IFUN9KPZoIAgSpDyDaxGlh9FjOF+9M/T4IVGJ8qeq26tK9d84jvOJplSuKCn7VrsrMdoq1tQg==
X-Received: by 2002:a05:622a:2987:b0:442:1bdc:2a6 with SMTP id d75a77b69052e-450375d488bmr59059661cf.30.1722402885414;
        Tue, 30 Jul 2024 22:14:45 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f943352sm70403686d6.73.2024.07.30.22.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 22:14:44 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/2] scx/selftests: Verify we can call create_dsq from prog_run
Date: Wed, 31 Jul 2024 00:14:37 -0500
Message-ID: <20240731051437.69689-2-void@manifault.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731051437.69689-1-void@manifault.com>
References: <20240731051437.69689-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have some testcases verifying that we can call
BPF_PROG_TYPE_SYSCALL progs and invoke scx_bpf_exit(). Let's extend that to
also call scx_bpf_create_dsq() so we get coverage for that as well.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/sched_ext/prog_run.bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/prog_run.bpf.c b/tools/testing/selftests/sched_ext/prog_run.bpf.c
index fd2c8f12af16..6a4d7c48e3f2 100644
--- a/tools/testing/selftests/sched_ext/prog_run.bpf.c
+++ b/tools/testing/selftests/sched_ext/prog_run.bpf.c
@@ -16,6 +16,7 @@ char _license[] SEC("license") = "GPL";
 SEC("syscall")
 int BPF_PROG(prog_run_syscall)
 {
+	scx_bpf_create_dsq(0, -1);
 	scx_bpf_exit(0xdeadbeef, "Exited from PROG_RUN");
 	return 0;
 }
-- 
2.45.2


