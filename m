Return-Path: <linux-kernel+bounces-360044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33019993D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DD1C232A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426901E1325;
	Thu, 10 Oct 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GU9B7lqo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0151C9B93
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592895; cv=none; b=QDq7fH85AmqwadMEASDe18pLLeFPmUjHuA+IYO9mDcwflVYJzvktWPylyo+StjS3K9AmB2138oYnKMtsTMbXXrMwOoU6q4ntESq8iOZb+yFlVBtInJX65GdtchyaDhyM9DV7SZ15EylS0HPWkPhOvXzA/biMsD069I8QofBZfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592895; c=relaxed/simple;
	bh=QiZxYKetmob9MgU1nbXPY+Etfo0R7c6qGycDpTCrxC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzGiBaTEl7US7YaGzszYcJhnO3FnbQt/DN5PxQXdDn9sN3NGQVHhQEKnXklqhvs/YuP+mofJTvCbCznB1tIxbEzThpMgAjZnc05Pgm6rYGdEJJUW/E3CQBUkvpaKk0sME0+pc2iFJwJbRiviPz5nbK80RYGWBJLii/qFUTeqWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GU9B7lqo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ZZioV/QivGBgk/ibL1eN/WkjLoQlB9h9SKTPPEKnRjc=; b=GU9B7lqofHXymPOD
	gBQ7JAbFl3X85xXelDZLmeQNC46z7bbB4fdwSR3uCpBeiPjo48LBTYVseb5oYonDEIwsiTid8khq0
	Hvr9d+RxWUXFHOx0PS3mpXA+8vYwo7kJTUcXSaFCF0jR0N9oIKgokw7grFvznQUhjyqIxXKmCUlRw
	s29GleqI+zDLPknwU8EpsWJ24cg+NdzdpD196pjzlExpOce3N5/Z38JxWC2h7gLrZaainsx3hTXvs
	xsKgWN8NtN0ErGsAvzyZWpFeiEfw8kqMts2p9XeCFmuqn0ZdedlL5yu7krywlB1g7te4XgOFMlfeX
	g9tdMiPEDzBgh6UyzQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syzyS-00AMhk-2o;
	Thu, 10 Oct 2024 20:41:28 +0000
From: linux@treblig.org
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] comedi: comedi_8254: Remove unused comedi_8254_ns_to_timer
Date: Thu, 10 Oct 2024 21:41:27 +0100
Message-ID: <20241010204127.271377-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

comedi_8254_ns_to_timer() has been unused since it was added
in commit
d42b5211d861 ("staging: comedi: comedi_8254: introduce module for 8254 timer support")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/comedi/drivers/comedi_8254.c | 37 ----------------------------
 include/linux/comedi/comedi_8254.h   |  2 --
 2 files changed, 39 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index 6beca2a6d66e..9b7747dab747 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -77,10 +77,6 @@
  * to create a 32-bit rate generator (I8254_MODE2). These functions are
  * provided to handle the cascaded counters:
  *
- * comedi_8254_ns_to_timer()
- *	Calculates the divisor value needed for a single counter to generate
- *	ns timing.
- *
  * comedi_8254_cascade_ns_to_timer()
  *	Calculates the two divisor values needed to the generate the pacer
  *	clock (in ns).
@@ -472,39 +468,6 @@ void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
 }
 EXPORT_SYMBOL_GPL(comedi_8254_cascade_ns_to_timer);
 
-/**
- * comedi_8254_ns_to_timer - calculate the divisor value for nanosec timing
- * @i8254:	comedi_8254 struct for the timer
- * @nanosec:	the desired ns time
- * @flags:	comedi_cmd flags
- */
-void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
-			     unsigned int *nanosec, unsigned int flags)
-{
-	unsigned int divisor;
-
-	switch (flags & CMDF_ROUND_MASK) {
-	default:
-	case CMDF_ROUND_NEAREST:
-		divisor = DIV_ROUND_CLOSEST(*nanosec, i8254->osc_base);
-		break;
-	case CMDF_ROUND_UP:
-		divisor = DIV_ROUND_UP(*nanosec, i8254->osc_base);
-		break;
-	case CMDF_ROUND_DOWN:
-		divisor = *nanosec / i8254->osc_base;
-		break;
-	}
-	if (divisor < 2)
-		divisor = 2;
-	if (divisor > I8254_MAX_COUNT)
-		divisor = I8254_MAX_COUNT;
-
-	*nanosec = divisor * i8254->osc_base;
-	i8254->next_div = divisor;
-}
-EXPORT_SYMBOL_GPL(comedi_8254_ns_to_timer);
-
 /**
  * comedi_8254_set_busy - set/clear the "busy" flag for a given counter
  * @i8254:	comedi_8254 struct for the timer
diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
index d527f04400df..21be0b7250b4 100644
--- a/include/linux/comedi/comedi_8254.h
+++ b/include/linux/comedi/comedi_8254.h
@@ -129,8 +129,6 @@ void comedi_8254_pacer_enable(struct comedi_8254 *i8254,
 void comedi_8254_update_divisors(struct comedi_8254 *i8254);
 void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
 				     unsigned int *nanosec, unsigned int flags);
-void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
-			     unsigned int *nanosec, unsigned int flags);
 
 void comedi_8254_set_busy(struct comedi_8254 *i8254,
 			  unsigned int counter, bool busy);
-- 
2.47.0


