Return-Path: <linux-kernel+bounces-300618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8595E626
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BD9280ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C404400;
	Mon, 26 Aug 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc15RXdn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB2321D;
	Mon, 26 Aug 2024 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634595; cv=none; b=AKoH2NfLtg6brvHxdPMrxs7phd1YKK712xyjhuPwsqLYQvj3vmQYdHAvrkk3ZPst+KyeAajQljYWK/i9C2WSrRJ9vprIZ+2Xfoz8FpUbkPyKY4jcv8fjdUxCCzBEdmCVGfCEHyi3hhtoHnx0kpFkQqPTxP/Ep0V4Bz8mjMSoV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634595; c=relaxed/simple;
	bh=ROGoIA4E2WCTYH12r5QZU/Rd5aHzNZ4t+dp9IisKGCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kzArHnuxsS6C9stqnIc7o63N60RVVq/0jlyllUt+ssGYsEkYmGtvRrfKimxTPFkFv0NyeNBWYWso61YDe3en5nV53WvTfHUQLQHHf311yfyJCuoXNYaAO3XXu4TpdD5EeajS/ZJnoyBdy4hKvFAb3OWZrmNxF8Uexx+pkxBB+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc15RXdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E5C4AF14;
	Mon, 26 Aug 2024 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724634595;
	bh=ROGoIA4E2WCTYH12r5QZU/Rd5aHzNZ4t+dp9IisKGCM=;
	h=From:To:Cc:Subject:Date:From;
	b=Lc15RXdnAvexrqOtq2SrjGsOg0injuYoEhWWtPUwRQr0J72oZsTs/J2XU/MYL27EE
	 58Fae9apznrMl6VO7ncrI/tmwPdZ+gzt1pNTxfoV8DqVsDpPieUBGcYdKgN5JJ8/06
	 pGMpBcIHASOKITpIoxN4nVt0//Y99y8Kqe2gZstObbl56qIYAfbWIeRO0hl18OTUOC
	 PVuPUqG5w4h0LTWkqd4nWApXqK9Q38AMz/cPSsSQzAo2cfvHLoyFkAkm2ipyZkIcWH
	 R7qAx7PKDFRU/dYcONBerNNqLoSRx1XBXiKBWZPgQp3iirGNlACVzgVJz0lr7S/yLK
	 a4eODiDt2EJWA==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Docs/translations/ko_KR: link howto.rst with other language versions
Date: Sun, 25 Aug 2024 18:09:47 -0700
Message-Id: <20240826010949.78305-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
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
Because howto.rst of Korean translation is at the root of translations/
directory while that for English is under howto/ directory, the Korean
translation is not linked with other available language versions via the
menu.  Move the document under the same hierarchy to make it be linked
with other langauge versions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/translations/ko_KR/index.rst               | 2 +-
 Documentation/translations/ko_KR/{ => process}/howto.rst | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/translations/ko_KR/{ => process}/howto.rst (100%)

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 4add6b2fe1f2..2d51f1481310 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -11,7 +11,7 @@
 .. toctree::
    :maxdepth: 1
 
-   howto
+   process/howto
 
 
 리눅스 커널 메모리 배리어
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/process/howto.rst
similarity index 100%
rename from Documentation/translations/ko_KR/howto.rst
rename to Documentation/translations/ko_KR/process/howto.rst
-- 
2.39.2


