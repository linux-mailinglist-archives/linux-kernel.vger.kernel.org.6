Return-Path: <linux-kernel+bounces-252255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D809310A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440B12829FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE461850B3;
	Mon, 15 Jul 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ropr15gH"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF81E890;
	Mon, 15 Jul 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033534; cv=none; b=e42biGHdKxwWYyx0Tlvrb4WbpVkCMohUxPFa9SmZcbzRt4SkRApxZWa11cK+EOlSpfGYtG6yE6+Y+SwKzFmo3Wb4cT4PWE3WicFtmtXcZuD1SyIGLur7WEHG6nJpsa2soOIg7W1iZfp1m3m/UvqBYhSZtAVKnuFlq7vto2x5eW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033534; c=relaxed/simple;
	bh=lPPSCe+ov7UF3C243GO/UqavibELTq39WhED1+GwWNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McNBUa9SQ0+SuC/ksiTXoCL7f2ZTRVvkkCMcWds7DJgrlG8anpeJRiNMO1sBkTIMRQmM14VWG6wWs0gP2OnMfIpY9JEUbz8qJvMcr9IPpI/3fpWl4pLdgt5Eck4ijKe5aqf6DNHwijl1CJCceMm/yHAQpasCSd1nzkA7k1ygAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ropr15gH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721033505; x=1721638305; i=markus.elfring@web.de;
	bh=A2wbh4kaLbKzhVBmO3dybv3YRMmrGDYw8khYFcvl2GU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ropr15gHStMe+xMOdO6KXrdQglh4Z6C7wg0izTlVeN2C6hjFqOEudBkLxeQTiyUN
	 vLFodoSwJIdKUwHMgAOzWbbmlia+vYSeaQmsutyUUx3LwXYpJr3opQKMQOnAuMGQT
	 x5dHaIkrU84aRPKyYa3rQVUsWHromqU9COEoIVQNrQMpHGuzyzJfLjZWFIxKfr3OO
	 m7Yuo+qYiA9RLHVQJKXBMFCe5/8swO4XwzouHxq8ZyWESlHvngJiMoJB8aRFhgUBd
	 PYKvIT5qeyWs2QneetTedM/rviY1kNpZS4vKAMNzjrzF8ysh1ElgOC2mYIESKcdWY
	 /oNLcKlK5XQXa6LNlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qv3-1s6GuK2ShB-00vErd; Mon, 15
 Jul 2024 10:51:45 +0200
Message-ID: <e346d688-7b01-462f-867c-ba52b7790d19@web.de>
Date: Mon, 15 Jul 2024 10:51:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] locking/lockdep: Simplify character output in seq_line()
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <aa9e1986-8631-405e-96f5-86a0f5a1eab2@web.de>
 <975d2b0f-f84c-4c84-adf2-098fef59d90b@redhat.com>
 <7560b341-27b4-45b9-8b73-202ec7f27200@wanadoo.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7560b341-27b4-45b9-8b73-202ec7f27200@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Mg74PvR7pnkoPncBRx+bICjO9uS+vtQ9nUJkqfaLTg3WCI0b5L
 WXkFcUBppVWx1KqkBIazziPqLCdD+S6YHf8wO+ncPHhd24HruhXzvr5tdlaCKQv0LRb1xId
 Jhw4/5SUNKx0VHY8f089LZONyCJFapw9wiHGz3eVZU24JDuaul7xMHdoNaHo7Xo/h3dSU1y
 V1tsEX4GS4SnTn6+u+chw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b3IYyir/BDs=;sfFrpKiVnLUrcW0KrKt+NKgLWHh
 RqrTlGtXmH2pu5IQEEIDVz/eAkPZzC4r0r58mKSji8NhFEPmO/Q+krO6Q5A0Jd2ftN1MlD+2E
 SNucwaOMWPID2JBU5QRp8OFO5bSDF8rR7/oyObDPQvmZ92bnrPNgfWCSYEA/CkUiosD3lPjNs
 8XFMXVIzt7QvMCmDSE63Dbb7u5tUmuYUNrdbJg95bLkTbwQsGgT8iutMgnG80MMh6r6ZYYJHB
 90rrykTn0JRVf0+yfz8e3YThflN7dmnMHFGF1yc6BxhGMEfNo5pIVF7VPm0TCiVaTHBIWOOyb
 ggjQ3PR7M1mTTkrQJNWnuS4fFDyi3fS5ABgHQki2lsq4Xu3UYCs45fCLqUnRGMVkVuwKwdGEy
 YpBK483D0dL2DsO0I++ZNNhhOixMTqV+QVZKADW860CJAZ12bvO2C/MAhQYjQ5ie9BK7mIHdP
 SYb7brxZ75rTeFamVm6EZdZMH4tz/a3rH0VOmfSUSEQJT+ByvawfK1jzjXAvWtA+pMJzXVT1d
 xX7S7Nj3JMCW7Tjgk96rNXkWkiGQDviT/RsL6mmNk1uvn1KdRKTvCWhu7qJeNRMUP+TIFWZYv
 GDXaBDkfjl8nAUlm96z3pwllGe0MQUiwLTWV9QoQ05ed7kDwVS0L1Z/K/9wLqmtjXcI5p/JZi
 iAmJGnmmmcpVCAYnMvH7QEPqMfuucWtNEAywSex27mHnngCeHxXMDgBX9nCVc/8ouZVwgL7AB
 BCuq6znZFyxWmaPkDcD5g/kTegqatUOg/81afLMmNrX1Q80vozTh3xHRKs2ZD6oA+pm8BhybB
 VPrh0Pq1cMUH7hd9RYm48qcw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jul 2024 10:42:17 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one sel=
ected call.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index e2bfb1db589d..6db0f43fc4df 100644
=2D-- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -424,7 +424,7 @@ static void seq_line(struct seq_file *m, char c, int o=
ffset, int length)
 	for (i =3D 0; i < offset; i++)
 		seq_puts(m, " ");
 	for (i =3D 0; i < length; i++)
-		seq_printf(m, "%c", c);
+		seq_putc(m, c);
 	seq_puts(m, "\n");
 }

=2D-
2.45.2


