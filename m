Return-Path: <linux-kernel+bounces-245960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1404A92BBEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458301C20CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C6188CBD;
	Tue,  9 Jul 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lublin.se header.i=@lublin.se header.b="pRqhuJMD"
Received: from dysnomia.uberspace.de (dysnomia.uberspace.de [185.26.156.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEC18A92B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533141; cv=none; b=ahoCtzwtVfne+1qoMa6EfuU+pOKgShfd7dLHMLE0rr/vNW1CWP5bwiy4TyBFwUaF0EXBHk8h1O3Igb0PNzDuYdhuIw/K1gXBBmc8GHPfuewoatokkWU2TsrPf0TcEtIfMuKh8NEWnpl+OE3ZOgGxqVO5mvD9FSHV8zxMFBzCPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533141; c=relaxed/simple;
	bh=qKJYEZA0smcFgq+FhK5l8Y1wMc+S0BF7hSq8um9dZro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUU1sV1Xl2o4hff8KbnRllM2ONagTOqbOKxcI+RO5jgcrVDjgOnCt+PTerZZyTfRHeMqRr1hL/ecxLmgiQtxuI5XXlTEJZELIjwHjJ75vsTRkG3OiEXMQCBnG7Gapqov+JupoB0Zh1hX9OGgTkAmUWNlTmviQp//WiXo4uiukmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lublin.se; spf=pass smtp.mailfrom=lublin.se; dkim=fail (0-bit key) header.d=lublin.se header.i=@lublin.se header.b=pRqhuJMD reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lublin.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lublin.se
Received: (qmail 1058 invoked by uid 989); 9 Jul 2024 13:52:15 -0000
Authentication-Results: dysnomia.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by dysnomia.uberspace.de (Haraka/3.0.1) with ESMTPSA; id 8E7421C002A; Tue, 09 Jul 2024 15:52:14 +0200 (CEST)
From: Daniel Lublin <daniel@lublin.se>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Lublin <daniel@lublin.se>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: add reference from dynamic debug to loglevel kernel params
Date: Tue,  9 Jul 2024 15:51:57 +0200
Message-ID: <4633bdb82c1c7c014d79840887878624a55c59f8.1720533043.git.daniel@lublin.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-1.146869) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) FORGED_SENDER(0.3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 0.55313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lublin.se; s=uberspace;
	h=from:to:cc:subject:date;
	bh=qKJYEZA0smcFgq+FhK5l8Y1wMc+S0BF7hSq8um9dZro=;
	b=pRqhuJMDNktpa9RcjYugQHzAGjLblsecUTBYWZx/4DvzEVBB3dyvFYhbr+98tAWbdafy2gtxu/
	sepKGIMSWSq56+a5xCOG1bNI0mExpZqAdhT6Uu49Pd9DrHuwrpI+dr2ixoLHbYOkLcCmd0OKhn+R
	QGRP+jS8svYsW2fttNh8xSX2HQxZLtZ2LRs4HIqpInQL87kdeAXO92nJ7IbV1T1lk68I2w9nIOCe
	e8hGwl9V7te8pDZWk7+DM25Unhbok7yr/h7DBkyF4dDmJqB06+Sljb2T2rjSySVWDSAxc8mGJirP
	7KDlOzG2QYSxrD3rGc33BKF7eTFWdF6fQiAxsYMjdF5D5OctaOoHv4lA0MDxx3kOAL1CLdgwpP/D
	3P+GRvZ13hEYi2bXc5lTLlAM90phhBFAGSBofnPlfmZUccLyd41p29A2kdhBUMma4gwsWt0AZEKc
	0LkHo1bOib2cG0wrw5VUO90ejZvKlFLZQPwhCVCW54mYTgU0iwjNNmkdHUEG0+PbE7sswB1Q0X5N
	9Tjd3Jz0gLfA0w/upVdHzISxRU+vm1Bm3r2weqJwjFQZu3dgU5mCBRhHE/2YcwjdKE79u+RJCdM7
	WnidAdkdujjp7DUI7EAhOygYx6FBV3lqh+3+8Fjknv+mWfN1daVRAX+A6IhrOaYQeIAvL3pk9ok8
	g=

This is useful information for somebody who has managed to dig into
enabling debug output, but is wondering why there is no such output
appearing on the console.

Signed-off-by: Daniel Lublin <daniel@lublin.se>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..7c036590cd07 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -26,6 +26,11 @@ Dynamic debug provides:
    - format string
    - class name (as known/declared by each module)
 
+NOTE: To actually get the debug-print output on the console, you may
+need to adjust the kernel ``loglevel=``, or use ``ignore_loglevel``.
+Read about these kernel parameters in
+Documentation/admin-guide/kernel-parameters.rst.
+
 Viewing Dynamic Debug Behaviour
 ===============================
 
-- 
2.45.2


