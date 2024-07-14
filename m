Return-Path: <linux-kernel+bounces-251771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D237A930990
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8007F280F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988B535C8;
	Sun, 14 Jul 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ADrCIItH"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DF26AE6;
	Sun, 14 Jul 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720952751; cv=none; b=oD+/cviACVFpHoIdtZNycYxTvUOEQeSmMmgqGSgx/A5nCDRKQhmkEejuRNRpsvxEVDaZuc6fuqxj+xF8Br+jt3CA/UB9v/sioRciRs9z9RRSEWMryHbNTSpdm+Y5egelKEvNzvNMkc4fY3cI1ycllZqOQmjfRJaZCSRWu/tCp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720952751; c=relaxed/simple;
	bh=AfWnb9cfrD1x1VDWpWZbqdYgV13IMZnJ805PXrY/Vn4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hrL71pz5hE6xkOQZCaIkwklGQXkL0Dn78TxRQusdUc+l01L/bYmk9NW+Bc6nq232JQ7AzPnlZapGpYN4vUk9hVDgE5Zh7nJm7I5CNhcGu5Rt+/b1Oo+eDk3+UyZ9G/mLRdxIQqbP1MM8Ud/qhDqLQfgIRXcH89OruIpKCuCW+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ADrCIItH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720952729; x=1721557529; i=markus.elfring@web.de;
	bh=svmi7O2EV7BzborbEmqMMS6ECP2Aalnt/a8I7tOnb6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ADrCIItHKk6eBjb6TlEf1VwnW6ecIkBPSpvhEX54/QCSnsIsgsO3syLFZ6LoVh49
	 T7T+OCgbH2gxmZv1Jy+z3Q9SHj5w7CP1jkj9xTbWggWjkA2QDPBoidEeF1MAKZrrK
	 AXn+X7Udlw8vglYnKvfyHtcUs6a2V5SV/KvMqa2kH4TBCEnZyCe3w5tOEUJAEDTXI
	 Rf93hRdcqJJ5z1W38OGuSZ+bOdSGEvMsVV7QXCgz1PuIPlJ8ZmVLxpsZdB8K6mQtZ
	 w/5IiU1LQJX2rd/csmxmbM/YUF6SRsVbN0C8Fp9fUvbySr78Iz/VkgipL0b9LRodq
	 nWXocW2cioEgoes5ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWkh-1roOXC0mO3-00a17u; Sun, 14
 Jul 2024 12:25:29 +0200
Message-ID: <aa9e1986-8631-405e-96f5-86a0f5a1eab2@web.de>
Date: Sun, 14 Jul 2024 12:25:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] locking/lockdep: Use seq_putc() in five functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HG7/r8wz98ZCZb6+fZl/pSi6QZXKyJgXP9E7E/U5Tn8P2qfvXtr
 g9T9TdcWIUJor+SUZWajwcjUKxaynbH6O3JukRIezAQYXYyeDcm3IS8IFUSr/WtAEROrN+A
 M8MaNEGT3oI5CnQClLFYJvMclD1aLXlG8z5YCSMRaOKXZyqIrdoCXGTTw1kTyu4Rxgbi7Vc
 QGAMPcd8zHzdfXltmwchA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/1ij2NdqdbY=;jbakHNe1ogzGRBc2s39J6deAK97
 2K9SbGxBToSEbYxaI5MD7eDL77YnFcejl1m2Ay9TAwuqIvEcrR4Pf7tDCV1P32BK6P8pSJMzD
 1MqoH8s/4/72ljkNoi1C9p1F+5cbWD0qA4V1Gc3iKP2YX/AJohWjpE5BdJo6002wT6e1Vx26y
 LWHmwAsAARyqbRAciAcXdDqEN1RL4cpz7WJRsdwmWiGfP9PPnz8qRqjJcDfPdP5Qdu6pN8k5V
 m5gmoza1+SE9Qxqy51DERBs/8TvXEsGGD8RDnLvJ0oDf1sxTiC/uFXqGZ5T6EzTMrczQ4itgX
 YTJJYh2diiiELdjGRsVDcCpOeqnWa8J/QN1BAKlY2JK8r1C2DzgA1Wn3DMf0ROZSg2zdP+MMc
 QX7MFwi/aVVZk1xvDo8kQZfPczotXEfKOoKSovwd7dlwlhgM3KW69CGIqrhy7maLbJADgnsMh
 cvZrkB7Pbn4IvRa2SyvqI0GzFIXFgFA0gAoQbEHlfrc/VbzGh15uAL9kYes90C2DHROl1gE9J
 aRPzQnGTRDNwtpb7cx8wMCTW/b+DDZuzMo4h/RGaAOe2ec6WO29NWQUAU9mQ4vYm1xD/07QbA
 +lp/JGpP7Z8iA8Ct7oCM+Oyt54PUCSUs+TlRP90yl/ryxN9zH6j4SY5izrRCpiGs93100KCYf
 m/CbG9YCi6Mw8felWEAEXnJkKR7OQHF6O7ZIcXtTO1cbRQB162w5GSNdWd3Vvj9DwQYopvVlg
 2B9slOrzbb2pI5vgo9vm4OZWbV3r8zlcJaUfyaXH4nDEIWAs05zKseGmvW2/IfKi3eydHFLS5
 5AA0mdFg2+oe6xwqX7UMrn8g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 12:18:16 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/locking/lockdep_proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index e2bfb1db589d..4612d1c4f45e 100644
=2D-- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -101,17 +101,17 @@ static int l_show(struct seq_file *m, void *v)

 	seq_printf(m, ": ");
 	print_name(m, class);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		list_for_each_entry(entry, &class->locks_after, entry) {
 			if (entry->distance =3D=3D 1) {
 				seq_printf(m, " -> [%p] ", entry->class->key);
 				print_name(m, entry->class);
-				seq_puts(m, "\n");
+				seq_putc(m, '\n');
 			}
 		}
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}

 	return 0;
@@ -175,9 +175,9 @@ static int lc_show(struct seq_file *m, void *v)

 		seq_printf(m, "[%p] ", class->key);
 		print_name(m, class);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	return 0;
 }
@@ -379,7 +379,7 @@ static int lockdep_stats_show(struct seq_file *m, void=
 *v)
 	/*
 	 * Zapped classes and lockdep data buffers reuse statistics.
 	 */
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
 #ifdef CONFIG_PROVE_LOCKING
@@ -422,10 +422,10 @@ static void seq_line(struct seq_file *m, char c, int=
 offset, int length)
 	int i;

 	for (i =3D 0; i < offset; i++)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	for (i =3D 0; i < length; i++)
 		seq_printf(m, "%c", c);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }

 static void snprint_time(char *buf, size_t bufsiz, s64 nr)
@@ -512,7 +512,7 @@ static void seq_stats(struct seq_file *m, struct lock_=
stat_data *data)
 		seq_lock_time(m, &stats->write_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_write]);
 		seq_lock_time(m, &stats->write_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}

 	if (stats->read_holdtime.nr) {
@@ -521,7 +521,7 @@ static void seq_stats(struct seq_file *m, struct lock_=
stat_data *data)
 		seq_lock_time(m, &stats->read_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_read]);
 		seq_lock_time(m, &stats->read_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}

 	if (stats->read_waittime.nr + stats->write_waittime.nr =3D=3D 0)
@@ -561,9 +561,9 @@ static void seq_stats(struct seq_file *m, struct lock_=
stat_data *data)
 			   ip, (void *)class->contending_point[i]);
 	}
 	if (i) {
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		seq_line(m, '.', 0, 40 + 1 + 12 * (14 + 1));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 }

=2D-
2.45.2


