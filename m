Return-Path: <linux-kernel+bounces-352751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FC9923C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E604AB2241C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EAC20314;
	Mon,  7 Oct 2024 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="sfq0Tpxl"
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D353C0B;
	Mon,  7 Oct 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277323; cv=none; b=aBO4aSJthkK0uhMyo3QUYJ/bHEMrkidFVB2NoGE1+Anzpb0ut1uzI6dxLCaqwY3YWgvc0ZWAtFGXnwwcypv/fTG69OfBCcJQSP2Qo008qDC8NOONFxe+GcyOoDlU2CwYfwkCxBFEgXvN7z7+KnxDn7IXTuulwbgMxRegM4DCkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277323; c=relaxed/simple;
	bh=AVq7ffhL3ZN51fmf75QAPcx7Wn3ylu2Ol3tLggyH95Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVkuWWkAAP71Gk+xo942ZP1/qmEs5PZ1hHawohutQ6SiD7k9jsSmyPOXbJrXWEIk02Qoh+L9OxcLZ/94TYquIqbtxcsRcPi4dvjnHSVo4A1LzrCP+e4JsIj8warwnrp74BH5yewmw+4aOkRLd9elXQhsJTMCiTi9vFt12jjvCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=sfq0Tpxl; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id C964744079E;
	Mon,  7 Oct 2024 07:59:12 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1728277152;
	bh=AVq7ffhL3ZN51fmf75QAPcx7Wn3ylu2Ol3tLggyH95Y=;
	h=From:To:Cc:Subject:Date:From;
	b=sfq0TpxlKvEis4lwSpLBZoA2dZ13fibB9rDFOyN9pFOYZlpjWRRsxsyeoSjkzNPOp
	 AFWptZI7sbBRMcbeS7tu6jBg73dQgE6VIfURcX9K09RAQQNNvKn83vhih1aDYXn3Bn
	 xHEy945HRSTzYt8D+IDi35ulqkDwglp6bXr+kgaQ2AW0CvwxobfHCck5/2O4H4rURd
	 7gvEgZI0anSxn150mD8ludIx1U7w04bRT3B4rbqKeFHksKzLlo4CAxaO8g51RFUjxe
	 mxodMaM/78f3XjkoZKJVR8GZVWzuEiVibZ0iJc4Dwsw6K7szjaY15GyABOvR0jmRNe
	 B6jeyxa2Qimew==
From: Baruch Siach <baruch@tkos.co.il>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] docs: gcov: correct build machine files copying
Date: Mon,  7 Oct 2024 08:01:41 +0300
Message-ID: <2ca2302b84196df56b5527a066bf6884a634ad7d.1728277301.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.gcda files are not present on the build machine. These files are
generated at run time on test machine. The sample gather_on_build.sh
script listed below correctly refers to .gcno files only.

Fixes: 2521f2c228ad ("gcov: add gcov profiling infrastructure")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/dev-tools/gcov.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 075df6a4598d..71052273c084 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -148,7 +148,7 @@ a) gcov is run on the TEST machine
 
     from the build tree:
       - all C source files + headers
-      - all .gcda and .gcno files
+      - all .gcno files
       - all links to directories
 
     It is important to note that these files need to be placed into the
-- 
2.45.2


