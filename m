Return-Path: <linux-kernel+bounces-177359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DA8C3D77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3EEB20CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B251487CD;
	Mon, 13 May 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="U/jn0vKY"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FA146D4E;
	Mon, 13 May 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589776; cv=none; b=IJW//d0gDrugrJvsKiWkKxwVBmMHJRrQN7N5/JcN+3KjD6DittglQXKp1s7brcPrimy59l4LkAE6tlegFXEnVDeUuhh5xvN583PFpd1T9anYzGzFkRZSnNivQ41V+afKM/7/h4zte6ki7+jQCS0ZRThhxef7V3Z3DEOpjlagpQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589776; c=relaxed/simple;
	bh=MmX9FpULig5/5mihxwyU5uTtNaJ+zcs97Xoo8Vr4T8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9SnQgG6Orn22ku83VgCgKT4P3u9PFJU/oiG2doSQjD1E0MD+KgU98FcQ45loFnE/52vQ2l+vyYAHK/REt8hyEBK8nGkte/o/L4txDJsRl0WIywMYSu6bWyDF4DO+K30iC8q4xsX702dwJqgdUPL1vD6/l4GgrTWWnLNnPQZbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=U/jn0vKY; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1715589745; x=1716889745;
	bh=8WnIPYmz22YKfjEz50TsMCQIHhCvLUNOX/xgj1FoVV0=; h=From;
	b=U/jn0vKYicg46UhLvK/VgNQWgQpHZq76odqbibwayciFKcqEGZVYLHAn3YdRuGsat
	 OZfuX5YbUD/sgYRjM5gLANxh7Gv37czWow8RGsJV4c06YC0mM5/iYxZ4R/GVEh/AnA
	 CGrSE+/lXhNnet1V+p9/xTJq21VxctgbM7UQx6IueMNUBLdps00UP1gcL5R4xJ/Dn3
	 1JpRWSu8SQi42lRL8JH9CsIpwhRcEW0cWKlJaDNJOopXPQrBkDwq79bHA8IYhiYXya
	 Jlf7O41dg3kR3mxsv+b4otnNF395qMo+agJxlJHLKzUICSq27zP4q9wVfmvd8tHnAQ
	 8bfyYHCqE7gxQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 44D8gL9k022851
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 10:42:23 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
        regressions@lists.linux.dev, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: [PATCH docs-next v3] docs: handling-regressions.rst: recommend using "Closes:" tags
Date: Mon, 13 May 2024 10:41:10 +0200
Message-ID: <20240513084145.2460-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the handling-regressions guide to recommend using "Closes:" tags
rather than "Link:" when referencing fixed reports. The latter was used
originally but now is only recommended when the given patch only fixes
part of the issue, as described in submitting-patches. Briefly mention
that and also note that regzbot currently doesn't make a distinction.

Also fix a typo.

Acked-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v3:
    - Drop sentence about some maintainers preferring "Link:".
    - Add Thorsten's Ack trailer.
    - v2: https://lore.kernel.org/r/20240510183748.13028-1-balejk@matfyz.cz/
    v2:
    - v1: https://lore.kernel.org/r/20240328194342.11760-1-balejk@matfyz.cz/
    - Rebase to git://git.lwn.net/linux.git docs-next.
    - Prefer Closes: tags, mention that regzbot makes no distinction and
      only mention Link: briefly and explain when it's preferred, in
      accordance with submitting-patches.
    - Include a typo fix.
    - Reword commit message accordingly (and make it less verbose :-).

 .../process/handling-regressions.rst          | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 49ba1410cfce..1f5ab49c48a4 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -40,10 +40,13 @@ The important bits (aka "The TL;DR")
        #regzbot from: Some N. Ice Human <some.human@example.com>
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
-#. When submitting fixes for regressions, add "Link:" tags to the patch
+#. When submitting fixes for regressions, add "Closes:" tags to the patch
    description pointing to all places where the issue was reported, as
    mandated by Documentation/process/submitting-patches.rst and
-   :ref:`Documentation/process/5.Posting.rst <development_posting>`.
+   :ref:`Documentation/process/5.Posting.rst <development_posting>`. If you are
+   only fixing part of the issue that caused the regression, you may use
+   "Link:" tags instead. regzbot currently makes no distinction between the
+   two.
 
 #. Try to fix regressions quickly once the culprit has been identified; fixes
    for most regressions should be merged within two weeks, but some need to be
@@ -91,10 +94,10 @@ When doing either, consider making the Linux kernel regression tracking bot
    Note the caret (^) before the "introduced": it tells regzbot to treat the
    parent mail (the one you reply to) as the initial report for the regression
    you want to see tracked; that's important, as regzbot will later look out
-   for patches with "Link:" tags pointing to the report in the archives on
+   for patches with "Closes:" tags pointing to the report in the archives on
    lore.kernel.org.
 
- * When forwarding a regressions reported to a bug tracker, include a paragraph
+ * When forwarding a regression reported to a bug tracker, include a paragraph
    with these regzbot commands::
 
        #regzbot introduced: 1f2e3d4c5b6a
@@ -102,7 +105,7 @@ When doing either, consider making the Linux kernel regression tracking bot
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
    Regzbot will then automatically associate patches with the report that
-   contain "Link:" tags pointing to your mail or the mentioned ticket.
+   contain "Closes:" tags pointing to your mail or the mentioned ticket.
 
 What's important when fixing regressions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -112,10 +115,14 @@ remember to do what Documentation/process/submitting-patches.rst,
 :ref:`Documentation/process/5.Posting.rst <development_posting>`, and
 Documentation/process/stable-kernel-rules.rst already explain in more detail:
 
- * Point to all places where the issue was reported using "Link:" tags::
+ * Point to all places where the issue was reported using "Closes:" tags::
 
-       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
-       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+       Closes: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       Closes: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+
+   If you are only fixing part of the issue, you may use "Link:" instead as
+   described in the first document mentioned above. regzbot currently treats
+   both of these equivalently and considers the linked reports as resolved.
 
  * Add a "Fixes:" tag to specify the commit causing the regression.
 
@@ -126,7 +133,7 @@ All this is expected from you and important when it comes to regression, as
 these tags are of great value for everyone (you included) that might be looking
 into the issue weeks, months, or years later. These tags are also crucial for
 tools and scripts used by other kernel developers or Linux distributions; one of
-these tools is regzbot, which heavily relies on the "Link:" tags to associate
+these tools is regzbot, which heavily relies on the "Closes:" tags to associate
 reports for regression with changes resolving them.
 
 Expectations and best practices for fixing regressions
@@ -326,7 +333,7 @@ How does regression tracking work with regzbot?
 
 The bot watches for replies to reports of tracked regressions. Additionally,
 it's looking out for posted or committed patches referencing such reports
-with "Link:" tags; replies to such patch postings are tracked as well.
+with "Closes:" tags; replies to such patch postings are tracked as well.
 Combined this data provides good insights into the current state of the fixing
 process.
 
@@ -338,8 +345,7 @@ take care of that using ``#regzbot ^introduced``.
 
 For developers there normally is no extra work involved, they just need to make
 sure to do something that was expected long before regzbot came to light: add
-"Link:" tags to the patch description pointing to all reports about the issue
-fixed.
+links to the patch description pointing to all reports about the issue fixed.
 
 Do I have to use regzbot?
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.45.0


