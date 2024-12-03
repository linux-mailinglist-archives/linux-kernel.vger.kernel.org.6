Return-Path: <linux-kernel+bounces-429133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551689E1859
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41C5B2B5ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B61E0096;
	Tue,  3 Dec 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1TxGFct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8031DFDAA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218558; cv=none; b=B/EXw8wRlZLIOaZo176IYEuhJQg4D1b3lSegq7L+uJAAllwVGrCCzEYjGCJjvXDUuCGrvlj7KrIs1QRjYW8mqfUepVaQspz/zrqtnYnJGoz+clUL1BZcaoEd/tF/uvPWu8BQSYRUX8WqpX6RsbZNl27EurFdEompVRFSs+Uik10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218558; c=relaxed/simple;
	bh=4MbPdD0fgenBmKsMWkIX5qKNXxd4Gyne2eA/qrCmZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYrWiUwWJ7I1u+eQWmpErFqnUy++Gi+qCISFITaRURRDQXdyxd7EqExzxrBRzBBzNyPA6C/6LespLFRB7/s/NxTyJqAUG7UC9nJ4tgwtkXRpX584uG8ja4jo3hNu3SSOJ/v/+24FB4FnKqvQc2pXGv5noW1W0eo6kBJYUAQ+pXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1TxGFct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071DCC4CEDA;
	Tue,  3 Dec 2024 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733218558;
	bh=4MbPdD0fgenBmKsMWkIX5qKNXxd4Gyne2eA/qrCmZCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1TxGFctoAdUuxbmsamimZerJU1SBh60x3Op1vphgWJUqBfR7nCxA7UhaQAVWO2wW
	 6UybjqFpytCBEvXiOftgT8IDAoJSPtxst+KnhmhbAiru46yXRjVOcPDQ3As8RWaJwi
	 SCVyE58EnAb/udnfi9D+wT8HmmPIFO/wlvGBDeSI/xg6Cj03u5RaHrdEpMw3zPY3j0
	 2RpV80VCShlzCiUj4prjJHL1F0s9PxTClV19P5Aec7u7mov5rh/ALRcnBb6Os6Fk9I
	 P+7ga3UPaQMaQUNOoob47IbZAGlLEP/kOMOUF2SjRKR3kG5lI9O3l1uPs2kHPh9VQA
	 90crMeZGQNeLQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIPK0-00000002ZIm-0yJl;
	Tue, 03 Dec 2024 10:35:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] MAINTAINERS: fix a couple issues at media input infrastructure
Date: Tue,  3 Dec 2024 10:35:46 +0100
Message-ID: <edb356f1ff58fe5938ffb275aa2574d127bed822.1733218348.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733218348.git.mchehab+huawei@kernel.org>
References: <cover.1733218348.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The media input infrastructure is missing a record for our maintainer's
entry profile. Also, patchwork link is wrong.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..264c0caec2df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14510,8 +14510,9 @@ MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+P:	Documentation/driver-api/media/maintainer-entry-profile.rst
 W:	https://linuxtv.org
-Q:	http://patchwork.kernel.org/project/linux-media/list/
+Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/media.git
 F:	Documentation/admin-guide/media/
 F:	Documentation/devicetree/bindings/media/
-- 
2.47.1


