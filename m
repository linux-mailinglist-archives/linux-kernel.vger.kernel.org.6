Return-Path: <linux-kernel+bounces-352367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A78991E2A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABAB1C20FFB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DD167DAC;
	Sun,  6 Oct 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="ioW/s4ia"
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD79173355
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214555; cv=none; b=sfm/hcXvvQE0kugrudYkQezwmklRnTyDs/GA9nmu7y34MtPijGNrv2OYYmz3GMyakj3o6T785weg0Y7jw4rY52Ba11ATbxyX53YHoQPuWNUYtmQE9WYcqaHrfLZh9iRSzAc+EhOYWM3C29a4eBeVuYVXbhBNc04DHKPPyAnPgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214555; c=relaxed/simple;
	bh=B1RoNoBTPlru7z+ct0CZrPOAEtQb+GrBrMtTsOINUM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD9Fd9zasPuARks4uSLKBLxguSUoM0MAZXO56++jraXdhTbaHE30Uc9+pNyWVySa6bmBxL1VDP0Z1grGDlMHRjsPjhv6DUG4k2UbmWolIfh0CxEmJ1nSOQ7ENyOHN+b++PoTdDr98S1bdoyV+wEm+yvnQHaIFCl29r4hj5VUFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=ioW/s4ia; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 1FFDD4402B5;
	Sun,  6 Oct 2024 14:25:22 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1728213922;
	bh=B1RoNoBTPlru7z+ct0CZrPOAEtQb+GrBrMtTsOINUM4=;
	h=From:To:Cc:Subject:Date:From;
	b=ioW/s4iazDZ5t9Oi/Ae/MN1/I+zDso8Me1lzsgbA6NsW60aGAP1oxdte8qEIQjfsB
	 MqDcdSpd8fRUgTJ6Kmbmg1lacuYAPaOf+MS2JZEPhQFq9B3+dEilY/YG5UA/JcMkI/
	 6kflzPwlRhb/BkW65Ewd3IzapY4ksZURo9jhfkNOgAFKwpiA/GsSWFx/Q1pxZJlZA/
	 j3nhj/TZO0GvW6LcfBFLc2UwcHd/dFc7ccPvuG72JRa656PH7MUkNqO8HsQPaP0g0e
	 c4GuQ+LRQ+Dg3le3Qr3G3OV2fTgymSzX+lZSvjiox2YlJuSoELzEH2esKqnOhP8jv2
	 XxlieA16BqglQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] docs: gcov: update lcov URL
Date: Sun,  6 Oct 2024 14:27:47 +0300
Message-ID: <05d89d7b66663a3236102d2e46eac2c474506cf4.1728214067.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lcov moved to github some time ago. Old sourceforge page returns 404
error now.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/dev-tools/gcov.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index dbd26b02ff3c..075df6a4598d 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -23,7 +23,7 @@ Possible uses:
   associated code is never run?)
 
 .. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
-.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
+.. _lcov: https://github.com/linux-test-project/lcov
 
 
 Preparation
-- 
2.45.2


