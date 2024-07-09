Return-Path: <linux-kernel+bounces-245575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01A92B482
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EB71C223A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A494155756;
	Tue,  9 Jul 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lublin.se header.i=@lublin.se header.b="afTHkUMp"
Received: from dysnomia.uberspace.de (dysnomia.uberspace.de [185.26.156.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BB152E03
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518976; cv=none; b=ft1DbWBpZIV4QPOG4CnA5zxeCtuifz5CNQrqHcftvhRD3MVpxt/VigXcPU7ZY/+T2UxjFxJMlnQZg+hWxuTVj/FrcVnvj3fWVAzSW3gzoFSUBzYFnSfaqK++BULLFo5Ufvwg8xlTptllVzCjotOvcyiXXzFxUZucC24rlKZ/Tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518976; c=relaxed/simple;
	bh=J28vytkAXeItdQ7/bjBTdps+euXBoHmzPP3WrYWLhbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtvC0jJ6D/QRTiSKjyPIW3BmFatASbui7HVUKeHVv3JKySYZ4LtwaoyaQU09scB4rYj2p/52i050x57UyYcQRwTx378LrgWHtta/+mluKeDuzEbOD56HVgf1qNBKiN0M0cD48GVECDAuUGwyAdnPBiJrxW6gzh5wlTFyN16h5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lublin.se; spf=pass smtp.mailfrom=lublin.se; dkim=fail (0-bit key) header.d=lublin.se header.i=@lublin.se header.b=afTHkUMp reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lublin.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lublin.se
Received: (qmail 32309 invoked by uid 989); 9 Jul 2024 09:49:29 -0000
Authentication-Results: dysnomia.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by dysnomia.uberspace.de (Haraka/3.0.1) with ESMTPSA; id C17CC1C002A; Tue, 09 Jul 2024 11:49:28 +0200 (CEST)
From: Daniel Lublin <daniel@lublin.se>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Lublin <daniel@lublin.se>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: add reference from dynamic debug to loglevel kernel params
Date: Tue,  9 Jul 2024 11:49:10 +0200
Message-ID: <4c1da56d2f123af8566744ab61c9d41e0b32de64.1720518466.git.daniel@lublin.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: BAYES_HAM(-0.125073) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) FORGED_SENDER(0.3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 1.574926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lublin.se; s=uberspace;
	h=from:to:cc:subject:date;
	bh=J28vytkAXeItdQ7/bjBTdps+euXBoHmzPP3WrYWLhbA=;
	b=afTHkUMprtqCajiP7pGX0Eh0e6h8gzpRZUD8HlnOdKYMvkFUlXg+OfBVWbuNk3GSE7FX2aJWeE
	VzEeFiWyHdj0xIzO8tAbPFwHtqCJDTpJOqcyiwq0G90tZ+cJD/2nz/OBR7sYz6mVqqBW+66kRO8y
	ts9FzRAxc7ARdvBSorrrz69YNoeA/Lh0tDJrdvy/rFElFEInFG5LsrdBueoH6daXJiNVRfBggvkf
	v2+dXoNq/SPUhh/LHU/6d6OqMQnPY14z6gQ7fkT5UHEgl0YkOsuWaRH77mabWXF0aFn82JGgudPX
	Mm1bsnDIZr0AmCvG4WoPhrn6Crlhud04LQzrR3KUBAAplpM3TWHIr/9eo/kDzc4glHBD7bf14CEc
	5Ec+9Suqloc40Fp7KMevI1snh+IHduFe8GmBITJ6Y8YjKfeh6I64m6+Go5kovM8G8TlXJNtGNb9L
	0ls8dVW4sSJbKGMZraPIRGVSKxROpcXox0H5m5unPvt9/z+TCULJhcrK2LL5b2KOMYs/HLJTvZ+X
	vyRX/5ekCgA77BpAiftXSxzFRSIllJ9/b22sKP4XXIUHz2IIaBzwQplmcYcBRItaFAfCP0w5i1fJ
	bWds3DE6MF5na+zfcGsQMoKqtWBsRJZxAVNjJjUTCdvxm+MSpo6T1Nw5OYgz0Vn7qlbZFWKrB5rQ
	k=

Signed-off-by: Daniel Lublin <daniel@lublin.se>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..7e55097e559d 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -26,6 +26,12 @@ Dynamic debug provides:
    - format string
    - class name (as known/declared by each module)
 
+NOTE: To actually get the debug-print output on the console, you may
+need to adjust the kernel ``loglevel=``, or use ``ignore_loglevel``.
+Read about these kernel parameters in
+:ref:`Documentation/admin-guide/kernel-parameters.rst
+<kernelparameters>`.
+
 Viewing Dynamic Debug Behaviour
 ===============================
 
-- 
2.45.2


