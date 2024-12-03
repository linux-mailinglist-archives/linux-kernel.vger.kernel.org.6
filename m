Return-Path: <linux-kernel+bounces-429134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A867B9E17C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C07D16679D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E41E009B;
	Tue,  3 Dec 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXmMLJQQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A81DFDA7;
	Tue,  3 Dec 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218558; cv=none; b=MlPFlKEDpdV2Bj1pGWZ7j2BATmopR1dQYPgyasYdQY8M2locVDxNBpWMsIKWHCiont9UIPugWnmJ/GyRqyPLwQSOQGFQbDt5wI8aVhKeJuXu4A3zojl69UtTZ3XUWSGfWUvBnT2tP2qfcg/n6VNN5pHD/sfvzImtyxTV2izVD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218558; c=relaxed/simple;
	bh=hGg97z1aGvCJyLpg/DxEFMXyC9lrOMhGN2xRMCry7xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyrh+hQkbpTVXF51e5u6655Eqc8kv3N8mACxbqemr+Mnxr/+T3x9JQAzxOfJTbXlbexcloVE3yiNxQJr61MUSDagdekE7TxBfN9s3hmWP64iIjNbAOr2iHdIb7PN90kn/K/bgmuyTvZ80AZlE9msGMz5XIhGcwViYe2FXjgFK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXmMLJQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CE7C4CED9;
	Tue,  3 Dec 2024 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733218558;
	bh=hGg97z1aGvCJyLpg/DxEFMXyC9lrOMhGN2xRMCry7xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXmMLJQQoQS/rNS8wJYPYrOPBQEPyQZ8wS4l/okhL0L1v3EEf2d/+KJbX8eFP2rgC
	 jH9h8+tCxoncxhPbAklnu+XVLhk/3XDSRL493IscNPt564R9BdBpilbrEETt9u0Fjc
	 i96jLMGu/O0KUYUbhMd0AtawIYejRdnCgHAhVAhZrBlXqExZkZFu5ektF9qRI6KWWy
	 4tFX637IOBBE4pWGPkk33/tc8ubDPO4tG9EAYMzMRE2gw5uSoWkGNh0ilnAltJIQPj
	 4qGCk1Qw4g6hhEgWJwsll+TIbpXrstjw1m5Kvw6fxhI3JB5ePQiY9Lfe0G0GDFg3Yx
	 uMx+qoYXrg3DQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIPK0-00000002ZIi-0rjD;
	Tue, 03 Dec 2024 10:35:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH v4 1/5] docs: maintainer-pgp-guide.rst: add a reference for kernel.org sign
Date: Tue,  3 Dec 2024 10:35:45 +0100
Message-ID: <8f663390c31d6c0c7acec3f39a4a7bf334a01309.1733218348.git.mchehab+huawei@kernel.org>
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

The media profile documentation will point to kernel.org sign.
Add a link to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index f5277993b195..795ef8d89271 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -903,6 +903,8 @@ the new default in GnuPG v2). To set it, add (or modify) the
 
     trust-model tofu+pgp
 
+.. _kernel_org_trust_repository:
+
 Using the kernel.org web of trust repository
 --------------------------------------------
 
-- 
2.47.1


