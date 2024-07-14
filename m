Return-Path: <linux-kernel+bounces-251795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858849309EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D341F215FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584C73469;
	Sun, 14 Jul 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kJe2AGvZ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14751FDD;
	Sun, 14 Jul 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960614; cv=none; b=Ku/BwfQDmX9WdA5+U5dwq2LKrEY2jUV6bJ5xvx9T3oZQuhAapE6yHpXpblij1lvtOo7WmhO0/XqIzJe2hqpEEPFdodwHd8bbeaUOTuwDiry4y4QWgqgFQ04ljmobQ+sEr1aEojauKtt3jIc2gJm18r5hdQ3AhbE0jS+Ki4gbP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960614; c=relaxed/simple;
	bh=MWt6vUSJVirl5baT6jQhbOU2aaQeojysvNYPBOIOdXg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GDoUT7E0Th6Tkq1yowA27MV6MuNJUCNYOUlGffBz50V8a768IKUwX6dZ4qISWJNXG+7NYGp5Cke4d7zoNTx5bUfWwxDPU5zyRaqTEwHY+tmkreCFTrQC9au0GQw1z3wlfLO/kzPJ3ZyAxE461jo8XS4sczVAjj6fRTLKRE9WdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kJe2AGvZ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720960574; x=1721565374; i=markus.elfring@web.de;
	bh=g11cNSzqa/kFL592OZP6SLFSSzberrOpC0FsGs3iDiw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kJe2AGvZNiLqBcS673cI0L6DmNN6enKM/0mpEDhW55yzo9aKwq+R6cMvbuo7SJCo
	 QihBNJ1IVDHI71fznR8eYSY8HA1a3SQU8GfgQ5/EBrP9PrVRCOWBiqwBDHRYCyF11
	 W+9enjnw+TCAOHeWRN/jhFJh94syg2/F5+n5qyYKwwn3hnijL07tGfTAHTmxdCmgs
	 WRZgjXR3bFBBcTsElQ5yRyP70bJYbIlxU4i5pUbqV37yxkO+l+or6dKrEKaNkLzzG
	 LAxDtL+oi2gfxQXZug4ZxdwyDygFL8yOYyrONNO/TLkHFu7f2qJppgVQbbxIMLkbc
	 DYU9Xl9NX5tj96k75w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1ryMOH14dz-00jsv3; Sun, 14
 Jul 2024 14:36:14 +0200
Message-ID: <4b78f586-4c87-433e-a57f-0d8ca151b89c@web.de>
Date: Sun, 14 Jul 2024 14:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Ben Segall <bsegall@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sched: Use seq_putc() in four functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gMNiszC8c3AKpW4omBxYkemCqriXY2qBw76sqmW3rj7MjlkTvWV
 doJq59Z4rjCH6VV5XZmH/thT28Zh0q/vCElK/n4gG6VtVPVyBO79GCBwNesBNDIdUujPSuV
 9OhKyC1DY7IwjJhmfXfkYiJIbh8tOWZnQb7WMcgrY4e/aFWIAiSUe7aRnt78gmlpvlXyBp0
 oUk8nPJMoiGnwlz6mMrMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oQQbhroLkC4=;E5ej6YQylfDYKLEikd2yAKCiQrA
 n/FJRMwV4W4WRPryjDIQi8ED/3LjWoAVLK4i3LloZdFOpSfHewYGkXvHLivoBEUZ5GP13E0qa
 Q3u7hsYGQGS8nCiZjAu/EhoIhvu19AO03dBcdO/sCEguLfHwiPZIUnGgF5A0MJtnVoFZn+zlp
 0vdLOsQJxwI1m0Eat9xbuN1hoa10MSC4UVAufkHN2aJH94ADzV0POurgO4Kvzp0ZjsNOMrDrf
 OQltcpGhg891KcG38+UEB4t2D4YmZwFTZYAHXsO73x0NdanHAnI3rthCwtG+jA/nRkuseydwY
 emNFjnOcaaAZQOes84vxB8UCjnaCWHm3xdRh7pyBY5s++i5FBI7GdE1PBjeTr+RInONGYeawC
 07tYWgzw61wUODpwfca9XgvbSexMBKhI+ICUEBGntQtknqggDfL6nN8PExp86nCYrysLpp63p
 /S+bf+sRvPZLoqoufqktWToQfHYKDigwgeJ8lK0Gq8G8VITACmfb/QY8aAn3WFig3E3rRJa3S
 Gd0MOuQb2cAg1GmsbKhEhGv3vKNVuCzJIxExnIXlOSZ2ntDPQfap2e3HCha8hjn7FEMMUw2N5
 UEPAduiZ8wlpYmIZQQd9Erllr6xSjs66Li52WQsOZfjkp6O2+UL/DCyx8wuVxHQJ05imthGSE
 6cpTREXNdjmr6OO9kubZjX5PKp50p5GmiiPWooGAbtb84+JGFPWl+AqFT0cACpkcp86akvunF
 4D40bB1eY8Eoq/OwnOfdeO1pl3grO2LBUsFaTQQTU5tWyE8zGB+eDOLNr3+18q9tII/RRf5nL
 Fb1vKZl/tAckX11hhJQyIRVQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 14:25:33 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/sched/cpuacct.c |  4 ++--
 kernel/sched/debug.c   | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda09949..0c1ce2e1c89b 100644
=2D-- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -245,14 +245,14 @@ static int cpuacct_all_seq_show(struct seq_file *m, =
void *V)
 	seq_puts(m, "cpu");
 	for (index =3D 0; index < CPUACCT_STAT_NSTATS; index++)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "%d", cpu);
 		for (index =3D 0; index < CPUACCT_STAT_NSTATS; index++)
 			seq_printf(m, " %llu",
 				   cpuacct_cpuusage_read(ca, cpu, index));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	return 0;
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c057ef46c5f8..ac9d65c5d0b4 100644
=2D-- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -62,7 +62,7 @@ static int sched_feat_show(struct seq_file *m, void *v)
 			seq_puts(m, "NO_");
 		seq_printf(m, "%s ", sched_feat_names[i]);
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	return 0;
 }
@@ -251,15 +251,15 @@ static int sched_dynamic_show(struct seq_file *m, vo=
id *v)

 	for (i =3D 0; i < ARRAY_SIZE(preempt_modes); i++) {
 		if (preempt_dynamic_mode =3D=3D i)
-			seq_puts(m, "(");
+			seq_putc(m, '(');
 		seq_puts(m, preempt_modes[i]);
 		if (preempt_dynamic_mode =3D=3D i)
-			seq_puts(m, ")");
+			seq_putc(m, ')');

-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }

@@ -389,9 +389,9 @@ static int sd_flags_show(struct seq_file *m, void *v)

 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		seq_puts(m, sd_flag_debug[idx].name);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	return 0;
 }
=2D-
2.45.2


