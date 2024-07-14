Return-Path: <linux-kernel+bounces-251800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E5930A06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D4CB21318
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688A12FF96;
	Sun, 14 Jul 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lt9eMhqC"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4301B656;
	Sun, 14 Jul 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720962783; cv=none; b=YOUQ/vEc5fttQIW3B5fxVP0XLxJx0b5Wp8hq+FlIZdISGoIzKGECBUIGMeTnmYlwdjMex0ytjZT1Kr3EdcX3ITbZxwB/E/i0RrT4Ozc3ZC/A68EtVthXkZ+4VODxTbPv+ERlOft8PRT5bfXSPxLi7FP14tgLabyPtLktZWUENVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720962783; c=relaxed/simple;
	bh=X/wht4a2Q32j75kP6Ucx3nxVTOQw3hxX+8IH2xU2dRg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E9Ee1ZZNbcgOlO89RXolhP/hh8BYlJmV3QvURbmb2NYO1Ymj3Cvb8KBOO356pkmchLkp1UPsY7v0A+JtCxUUM6rTDol3vJAbLboEvS8A+TMUMA5mV1YlwtOsjNzE0HOxYFOB7FL/64h/mKT2PQCLeFNp03L8t9L/Yd7wzlg71ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lt9eMhqC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720962769; x=1721567569; i=markus.elfring@web.de;
	bh=jar1fGm/qjofZUU6lUjEG2U86Ixx1QKmvpwr82lNIlw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lt9eMhqCwsvTwB9VAjcRGPalzGRUoEBdLUYVHlfHsGXyUSPo/W6HEJ0Y065eRAog
	 Y2iTKg2ZPqfHll2PhMFdB74yYhXkW+nNT8hY2dIDyF/g6T489x9xUrQuJYaBkrW8s
	 UuC9lbmSUKzy+YG8srgGyKlZGWKrifiNEqfYBm27o7BKWVks4vnNjYJwY+TaLWJEM
	 sL5qgI3apPDF2p/jkr+YRscH5VByA+NasqkCV8LbBco3eF+q0aq7q68JyCr6W/XFs
	 2cZe9Tnx/vDmwconTQsOi3eJGVgZbnWfvxlUDx9MDSIY2vmQ74s4WhqO3UEb2s0HT
	 XZHxs6ROFPOPFA0n4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1sVRbq0JW3-008MFF; Sun, 14
 Jul 2024 15:12:49 +0200
Message-ID: <28e7c8b8-1b18-4d31-a878-d5846d3115c8@web.de>
Date: Sun, 14 Jul 2024 15:12:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] time: Use seq_putc() in udelay_test_single()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LgPVlcmNFjfuZXOvHoA6ArSZh7PtdQntif/t/DAqQERHaCuJoeY
 j5vKd7F0j4EojGsIJroMF/Ncg6ibfvwy0mX7Jwgbm683HOstJAmdbpeXltiWUAffPB3OxfE
 SFTYa0ZY/UmtTO8zKGYWo4g3ExtUPblJfLEy8oG51wPhFpTgc7jYOYaWzkN7AGvUVA0B/wo
 N1rPhHD7i2CvKFgJTT3lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LKn3SorblLs=;93R8VsiioS8BNBP8eiuY2wUqEOY
 66pa1Ml6myiXkAwy1m0FfGH4OlvG4VXBz44+4O7HoUNCG/5up5f3MGZB4Aa3htyz1oJdpB3sq
 5GjHsNIPlLjBAfBSpqEDdePa1tjL3i9uD8W5aivjMFzzMSM9exMTgMKSc9ugyfOe4oTm0MJym
 atx8CIv2QtjVEsc68aMP7Kn81fz0SJqUPeLiO+oAtIxuOEXnEY1AC4JILrVANhyuQr2fIfnta
 6ubAvuS5MaEvkSdwHtZOJJrxNYhpYX/PqtVi+QGCH02lOnYl3qa8LvY4Ny1djz4cXW1qS1kk1
 3A8dwwQSssEU+LQJ4pbOtOcLaknKV2O7U2G/W7OuhWRePF+75ycWRop3NgR4yf+gsUYfoLHTa
 omx2Rv+LkfFH/6bDWrdLT3xJbB1RatmMukqtfnwBSo0S69Mb6GDWowLw0lJEgpmk7Yx9aAoms
 ne34newmmN8X5loOglQZvHYPQquljGEgu90yFx7v7m1Q3ck1MhJyNb2zFpH1TyKv1kXTyEohi
 +60Zya6qAycv2KzUSWH7BeE9BubbV+2kunzjDpzaNUnKZE6q0lcDA3XgmJYyqVXAkQG0/RnJY
 1YRqEoNK0e9VbFerUZbWck4LEUVpt1QpCxVWVTwTUOpTbK6dTlPWqgTMIVXNHddBLwmNMOudZ
 RqkRGf3NSYrQS/U/bKV4CJ0Sq6kaalweHeiab/A5+oHQYS2TIAGEly1VYGe6L3bbgpklMgki8
 hmKgkAZQvcjsM/5f8J1GqW4aL27pseoNPP1n6baYmK6fciB09A/CFwvly+CVPpQyMlrDq5wAc
 w1kzrFQv4DcvJUOjZBi4qqpg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 14:50:06 +0200

A single line break should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/time/test_udelay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 783f2297111b..97c33c8773de 100644
=2D-- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -59,7 +59,7 @@ static int udelay_test_single(struct seq_file *s, int us=
ecs, uint32_t iters)
 			(usecs * 1000) - allowed_error_ns, min, avg, max);
 	if (fail_count)
 		seq_printf(s, " FAIL=3D%d", fail_count);
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');

 	return 0;
 }
=2D-
2.45.2


