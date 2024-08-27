Return-Path: <linux-kernel+bounces-302503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0595FF88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FD81C21B28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F141803D;
	Tue, 27 Aug 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY6a8RPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC2175AB;
	Tue, 27 Aug 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727827; cv=none; b=S8VpXKHJIqNKseYzQ2U5e0VcLlJ6C0dHkGD4n2WH29GSkV02MSyuYRNUDx/vJzj1oFtYpGdenhZRudgj9RAJXg/aLwkCtety9XAvtGT3GXN3reGE3EyE6Q63niX89apTpa4tzM5bMtIQHsxly51Dj4rFG+A1fXRjf24W9OTqKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727827; c=relaxed/simple;
	bh=u2NvqBkkbAzeQS7kbk6mVRAqMmq/sCoTqOpDlC8ObH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CijCp6gYkeISpWn6sU78eGNVuW3bBYFcbF+jr4S4V6Kipey4VZljk/AoVxAeT+lSS4ftEciz3lKvPc5cUdcbo6ii8eLWHopaGcv1gjWBnLXMJnLeiNtJwSyfO80GC7p11FNBDgab8MmmGOHPv4p4hpt6hevmW8wPZvlRXRUN+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY6a8RPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFEFC8B7A1;
	Tue, 27 Aug 2024 03:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727826;
	bh=u2NvqBkkbAzeQS7kbk6mVRAqMmq/sCoTqOpDlC8ObH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OY6a8RPdw9Luuff4EEXqoYQ20kM4cDnSH4oLzMmXmLvcp7zdWOu8f2pmGtUshmUuv
	 ODo3sVqZm6X73X5o7hQ8YUmy1OKNAMLp3A5fY5MHeMevbNFuX9Z1O3qn8cSV2fm0Zx
	 uQRc+l8/gyPycbhm0wvQnoAoFPPidRVKgkK4BK36GDyHyMWwyF8M4Ot8b1jnylzVUV
	 Iep6rJFGZLUVItLG7qQGkwtxQRYOBESzs7U3xlM8lfti/5w++g2Rqnv3Jp2Wn5suQK
	 CIM1D2b3yHRjAJlqhnHI8kEkEfLjhtDePNiW513jOuqY+gzFW++E3YvzSYjfNQvkMQ
	 ncPu0O6S/4D4A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] selftests/damon: add access_memory_even to .gitignore
Date: Mon, 26 Aug 2024 20:03:28 -0700
Message-Id: <20240827030336.7930-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON selftests build access_memory_even, but its not on the .gitignore
list.  Add it to make 'git status' output cleaner.

Fixes: commit c94df805c774 ("selftests/damon: implement a program for even-numbered memory regions access")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index e65ef9d9cedc..2ab675fecb6b 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -3,3 +3,4 @@ huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
 debugfs_target_ids_pid_leak
 access_memory
+access_memory_even
-- 
2.39.2


