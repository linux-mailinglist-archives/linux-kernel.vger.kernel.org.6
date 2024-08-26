Return-Path: <linux-kernel+bounces-300619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E795E627
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07054B20CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E44C6C;
	Mon, 26 Aug 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKQG1c+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1BF3C17;
	Mon, 26 Aug 2024 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634596; cv=none; b=aQlRTuOtDGHdd0dk0wgK+o7kc1dileY8/c5tgdFLyMymm+8ntZ5vYAYYMDSbL114A4QcI3jqw3xdDM+zeipdSUhoWzrm9SyUV7sNLuf5G1glzokX9jBv6KbRwF7AhZuzcVYhUCaRfE25QIE718Oz1H0sy3UyaRc/ms8dSCX4VzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634596; c=relaxed/simple;
	bh=vkgA3skHEp/LBzeVpDujXZElTXUjSN183SFaQIf9OL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2bbxqVOpSnwUhF9X0fxiz/4ttwsTuucqc1gmWnMbMrNJy8mHO5k+hzqp3VesWo/7YlR+F3QaGPqmJ5ecUZWgMmj0hGQ0sanGCSkgDGx+6NTBVTnlD0+3EhICdNwjYL+Qi0KJMmfIiBpbSg7yiv+LNZaJw0CmDxgoHsUD4biCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKQG1c+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C84C4AF16;
	Mon, 26 Aug 2024 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724634595;
	bh=vkgA3skHEp/LBzeVpDujXZElTXUjSN183SFaQIf9OL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKQG1c+nA6Snke5jkN29cefO9fWlhA/Rn919VSN7feWRxoKXOTJdNKTm6XwdQJ5vI
	 41eJUFHChDURbjQGOJdL2/CQn0rYAKFuE0dHXMj3zxMUScLFgcMzMPGnrMIN4hOMBA
	 nDcm4ZDKfhSCeqFHkRkEu984LnEe9EdUugv4hHvo9bVvAP5UuHLvNiSJVy0gS2M2mp
	 BZuS6DJfn1Y4dLcOf/2LiSMt9o4yBEfrBArX51CM+5dmpAEBkg2e6UlI+XJCxYU8zL
	 reP5QhPd4myAmPKK435gAC7JVepfvTkznPUG/yH8NAHfdQxWwvdM95gpN8kCbqj1tR
	 sGMAp33Fbv1jw==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Docs/translations/ko_KR: link memory-barriers wrapper with other language versions
Date: Sun, 25 Aug 2024 18:09:48 -0700
Message-Id: <20240826010949.78305-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826010949.78305-1-sj@kernel.org>
References: <20240826010949.78305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The menu for documents of other available languages is created for
documents in same file hierarchy under the translations/ directory.
Because memory-barriers.txt of Korean translation is at the root index
of translations/ directory while that for English is on
core-api/wrappers/memory-barriers.rst, the Korean translation is not
linked with other available language versions via the menu.  Move the
document under the same directory hierarchy to make it linked with other
language versions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../core-api/wrappers/memory-barriers.rst      | 18 ++++++++++++++++++
 Documentation/translations/ko_KR/index.rst     | 14 ++------------
 2 files changed, 20 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/translations/ko_KR/core-api/wrappers/memory-barriers.rst

diff --git a/Documentation/translations/ko_KR/core-api/wrappers/memory-barriers.rst b/Documentation/translations/ko_KR/core-api/wrappers/memory-barriers.rst
new file mode 100644
index 000000000000..526ae534dd86
--- /dev/null
+++ b/Documentation/translations/ko_KR/core-api/wrappers/memory-barriers.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+   This is a simple wrapper to bring memory-barriers.txt into the RST world
+   until such a time as that file can be converted directly.
+
+=========================
+리눅스 커널 메모리 배리어
+=========================
+
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../../memory-barriers.txt
+    :literal:
+
+.. raw:: latex
+
+    \normalsize
diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 2d51f1481310..a20772f9d61c 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -12,18 +12,8 @@
    :maxdepth: 1
 
    process/howto
-
-
-리눅스 커널 메모리 배리어
--------------------------
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ./memory-barriers.txt
-    :literal:
+   core-api/wrappers/memory-barriers.rst
 
 .. raw:: latex
 
-    }\kerneldocEndKR
+       }\kerneldocEndKR
-- 
2.39.2


