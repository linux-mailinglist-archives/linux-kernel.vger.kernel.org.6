Return-Path: <linux-kernel+bounces-340512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B841987475
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2E22869B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EA3A8F7;
	Thu, 26 Sep 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wQiSklLO"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F525258;
	Thu, 26 Sep 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357461; cv=none; b=A9LQYsqFczkuborGNzHaxfjHYwT7Jew0q+wP3EzaFU30d6XFG+neQmvWRi2xs2PvUe+RGosTsSSMzCA4Nkg37TVPzHcHIod4CMNWWim1GQPJiMIJdFtslELMbhEkF4Ca1Dc3NWIViETkNtIqTygYshDapw/rY1FQpm6m9DC0/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357461; c=relaxed/simple;
	bh=8D2Y6WGTjAXKFg4Ac21d/3s/libBT4mfFHN/VTNVv18=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A5jzMhxol18xtc0ASYoLsz+UVumrSmUkTScqqyUe961fxu4nSTIFcx+WZSM4FJwRgkPE7SArb1fwCfcCXxM/h6+cuoj6mXkfcpfhzPhOeFOpHvdaqpuGPZxsG8xe9lZCBEo4JjzcfGi7ujnHqrN6IjJBpXOSI4ULYsocjE5a/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wQiSklLO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727357425; x=1727962225; i=markus.elfring@web.de;
	bh=nOEM71AyOr4nfT0t970wYpqeIO6G8tPBN1vASVmd/So=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wQiSklLOVXr8Hhip5gGtQB5tfKog6OWPZcSiPPtHF9r6GPzBZY1SMLD+vLJEGqzj
	 RPO3f0hS/B2YDL9OKYmoFf+VtsL7ryyEI0h7egqkrCcVkGGVCcXEQ7E261ZqSV51K
	 f2pRiD0K4sYqBmKGo5Of7HSwl1FiQcNs3UAffgUA4cYEy6tLDw22v6Cs+YQJWYyj2
	 I09a6WgeN43MNqveOkbBo5bGCE5CIEe3arjovykekSxQDDu9CuJv0P53cTNv2hXE9
	 JUqPXUASJQaCeaioRqAOwbK9LLP3riOMKxuWjJPd2Tx5l0rD/W/s916dywIMlb80F
	 JNwfrxrOONfqwsSPCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuSs-1sFH9h3Oom-00hy5l; Thu, 26
 Sep 2024 15:30:25 +0200
Message-ID: <6c4afcdc-fa86-4f0a-a6c1-ec8265190fd0@web.de>
Date: Thu, 26 Sep 2024 15:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Barret Rhoden <brho@google.com>,
 Ben Segall <bsegall@google.com>, David Vernet <void@manifault.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Josh Don <joshdon@google.com>, Juri Lelli <juri.lelli@redhat.com>,
 Hao Luo <haoluo@google.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrea Righi <andrea.righi@canonical.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sched_ext: Call put_task_struct() only once in
 scx_ops_enable()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N1c6y1Yj0TUu9WDWBqn0PyHHTgWKUGD/64HdV190odsvuWqhLT+
 2/KlR2ZLWL0NXSd6WNesSyL1dUdmY0EqYaj1eanwdoeXkvtrdT7kgYDWsq4SUyEHjXJu8Oi
 S99b/FufIRXf+mqYvqpMC19/GsTeIk6O2+U16B7uCC2H6nkqueRVAQqui9JaNHJ6KGO3GSs
 +aHDeQCH8/R33qBV9Sg0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R8or0bQMyog=;w7RC1hpJ5ZaVX2dTD0fS7EjxMSt
 YjV2w71YTe/vA8fl2RP5LnW+Iwk3DIkdku0Q7JzzO6lCy9rtO0eu6XK6LsXhH9YK4VwKVeF0c
 bh/HhNbm2Opc6wiS6HBUe1MxOtXeMFQgog8/VJiF0WCBk2lrJvD+Fy0/+kk+Io3cwyzDQJZyK
 dkiR8s0GDBUzy5N28gyKM2EFlebGuza8kbzv5ma1xPPG3PS0STVJPh5t61GUZi7l6FYdtgGuc
 m6HSbGY97bwDbsQcm+YjNBB8qFqSPObvTPN1P9tP7mF33/ZjTHpnvWGwplEVr4dNAA5CVbO/s
 nYbSWBAvUqx3wkFZKJXG+qrWJ6rJTcyL6DRDPfrbeZ53PsGRR4cIPtkGLNLMexw62mdPtmtK1
 kVdEUvtEHz8lejEy4je9OFCFBnArS+CSfsvCFFKwrVb3H+9paEid74z+6vhycMsnW2vv1IrwN
 PV1y4/aJjCX5LQR/WfvjgvyDYJcQwaIX9OoRja3n71+186WKyMMT0jLkquSD3U4cOWUk0+wKA
 2tbqGstvbw7XCz3UxVnRsCDGm7RTBfFTQatW3TL3t5/8A5m7salpRG8zKrAgI/XNR2E9umDlV
 AB7YaRbpgbj5UnFa9L3gggaGQdYaehUdQP4vChjd78P30qSB+T+ma9aKKgdrNIS/Bl6sWVkIg
 DOlOYHyFnroSIBdJQAslNg48q2+m9kgE7DAf1JGod91bWaw9TVIkh3lnOgW3UAwah/PeJF3a9
 5ylQ4I6Korbpgfuc/an6M7xJsNWbN8X2RqBillsTiOjYAtQULgLmPQ7cvwuzScJ17rTKu2CSW
 NF/YQi1b7w6mTNU7jO4vcbpw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 14:51:07 +0200

A put_task_struct() call was immediately used after a return value check
for a scx_ops_init_task() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/sched/ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9ee5a9a261cc..4b89ea20e355 100644
=2D-- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5091,8 +5091,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops,=
 struct bpf_link *link)
 		spin_unlock_irq(&scx_tasks_lock);

 		ret =3D scx_ops_init_task(p, task_group(p), false);
+		put_task_struct(p);
 		if (ret) {
-			put_task_struct(p);
 			spin_lock_irq(&scx_tasks_lock);
 			scx_task_iter_exit(&sti);
 			spin_unlock_irq(&scx_tasks_lock);
@@ -5101,7 +5101,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops,=
 struct bpf_link *link)
 			goto err_disable_unlock_all;
 		}

-		put_task_struct(p);
 		spin_lock_irq(&scx_tasks_lock);
 	}
 	scx_task_iter_exit(&sti);
=2D-
2.46.1


