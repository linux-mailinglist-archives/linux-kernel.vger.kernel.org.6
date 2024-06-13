Return-Path: <linux-kernel+bounces-213297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D1907380
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619661C24809
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2978D146A7D;
	Thu, 13 Jun 2024 13:21:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F237146019;
	Thu, 13 Jun 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284880; cv=none; b=iiPgqnbxmixdWJH05GVY4t6RMwNQCj5YWdl1wDI1dSFoOdye4enzTZiCTCsuwcztC72cfMwhRs/4GT1XuX/H8vTSJGIMifH0nSxniClDRXxZaKCQLuaK74aktUuPjdI4rX2Ko4pHcOkpH17oGKdOAHaJjJCMMPn7gmd6dAEK9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284880; c=relaxed/simple;
	bh=wyfnjSvyRRFH3TvyQQtUfXAIPyLtOyN5+xGKBbIjwpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSd0NBhbo3L1Mbozy99HpzUdNzY9x53ZJpWnQI4FZXofOcUB+DN+UVxwxy0o05pzUtDgRjgQ+1j9eaxoZ49kHzbOeTyFg88/fRbujZLUNheMhaw77xEzCanygRlcQDG+mFdWsr/4bsTYIvsRPq484IPoQ79ZHs46gqkk1m8WmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-57-666af24c8bee
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v5 7/8] Docs/admin-guide/mm/damon/usage: add missing actions
Date: Thu, 13 Jun 2024 22:20:54 +0900
Message-ID: <20240613132056.608-8-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoa7Pp6w0g/snBSwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M9V8OshXMYKvYeeUjewPjDNYuRg4OCQETie+HXGHMF+fZuhg5OdgE1CSuvJzE
	BBIWEbCSmLYjtouRi4NZYAOzxKRzL5hAaoQFfCQerjrBAmKzCKhKTNl/nxXE5hUwldh/tQss
	LiGgKfF4+092EJtTwEzi0dxXYPOFgGpm/LjKDFEvKHFy5hOwemYBeYnmrbOZIXpfs0ncf8UN
	YUtKHFxxg2UCI/8sJC2zkLQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY/stq/0TvYPx0
	IfgQowAHoxIPr8ezrDQh1sSy4srcQ4wSHMxKIryzFgKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MBZv8XMpez57yo0m47cPZidMCrmy66l+lPN199xt
	3hsZJnAuWPx+neyizmiud5F5MorvjeOMLxlbKDood3yYpi/C8mTzwkimb20XH4S+5XjS6Xdh
	w2nmwHWeTH97dk1+Xv8u8XriP56qJ8tXn1e5p/PDda3m4c4/0hvkGPU2LWU9+u3Fwyo2TiMl
	luKMREMt5qLiRABz75YNewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9fnU1aawa7dzBYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDLWfznIVjCDrWLnlY/sDYwzWLsYOTgkBEwk
	Xpxn62Lk5GATUJO48nISE0hYRMBKYtqO2C5GLg5mgQ3MEpPOvWACqREW8JF4uOoEC4jNIqAq
	MWX/fVYQm1fAVGL/1S6wuISApsTj7T/ZQWxOATOJR3Nfgc0XAqqZ8eMqM0S9oMTJmU/A6pkF
	5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBIb6s9s/EHYxf
	LrsfYhTgYFTi4fV4lpUmxJpYVlyZe4hRgoNZSYR31kKgEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+OVKfXRkzef/T+VbYJojebHRuFnkudPLExj+Fl0
	cZ/L/Nj0ALupLHOWRflwX3G/cqmiwJSt5+VXaZ5129a8f/qp2H+FcexNhvVn9I207v7L7ZL3
	Wn5IdYlzQIQCezj/B4+MFbuXuvVL68l9duQ6o12Ye8ZRgGeXU+cTyb2bDYomvDrw5Iv29lNK
	LMUZiYZazEXFiQBc10u6bQIAAA==
X-CFilter-Loop: Reflected

"lru_prio" and "lru_deprio" are missing in the damos action list so they
have to be added properly at damon usage document.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index e58ceb89ea2a..7bff54963975 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -757,7 +757,9 @@ list on :ref:`design doc <damon_design_damos_action>`.
  - 2: ``pageout``
  - 3: ``hugepage``
  - 4: ``nohugepage``
- - 5: ``stat``
+ - 5: ``lru_prio``
+ - 6: ``lru_deprio``
+ - 7: ``stat``
 
 Quota
 ~~~~~
-- 
2.34.1


