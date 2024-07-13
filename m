Return-Path: <linux-kernel+bounces-251533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE279305FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E222F1F21CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367E13A894;
	Sat, 13 Jul 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vTOC5H6c"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CD13957E;
	Sat, 13 Jul 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881808; cv=none; b=ZJHh/OXZaAXEy57CTxuUiZVvR5ZP/6y9dZWCnEWeB+G5+ycUAp3lJF63I5G4Fc3xrbvmJQW+PwA2ZaUACQ1gWnyzSIf5A6Jk0KHLVjE4x8IjlEVGod9rSasjrsFH8d+mdszccifYrNq4cQ8HuSw4hXP5tub6ut2DEmiUVqL5gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881808; c=relaxed/simple;
	bh=0IUsix3yW+JZP3A6RF/R61sx0LwAcRmuY1vIpsGlq9Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iZst76TlsD5+l7SC6k/FtMHqdNFu+AQra3HpOaPlwDfs+31ZmBCe0UJemekKTe7RT2xpnvWPFlrgntwaFG8Efmu4LyhlAopulus6ghWJQjztpJU+4XDrXzJ6Foh9hb4QFRDi3JBbHI1S0bLJa2WOUgO3W5zm94+1sbgfj6LvCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vTOC5H6c; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720881798; x=1721486598; i=markus.elfring@web.de;
	bh=7fQ9elM2VGZvsrn+aU88EfXnuV3oDFRum+kdAh3DWyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vTOC5H6c3YIcp+kw+C80ctFZbIszyei6gG2OsPLmyO/2BA1/a6gXs7TBPOZvreeI
	 pZ0JWCKbYEhy5ze/whGxRVs5oSFtuCautBveADC4vZfRmhXbK4d5MbeqCvH1wOhvj
	 Gb0PUMMPXK+tD8ezPW/KsrFOaN+WjrHMNPNvCVMd/BIgSpxESaNK3MPx2zXeeVlaH
	 j0/wWq5lOCn37ZNrzQXwPXSmM0QBrdzEcQvAzzOjT1ldlIdLcwmt92OnhAylfiFu3
	 zcqDAbzBIGE2UqM5d6GZ16IIi8d9PYn9jowh3iIO419V9CqIXjl4mzSLaLHHSlvgm
	 rmqjTGqSosXlxrwf4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2PdU-1sVP7g01bK-008iUe; Sat, 13
 Jul 2024 16:43:18 +0200
Message-ID: <9142662e-e709-48fa-9ac2-a4fc16e6228c@web.de>
Date: Sat, 13 Jul 2024 16:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] regulator: core: Use seq_putc() in
 regulator_summary_show_subtree()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zSnmLgqOq/vavYWScmBThEVNkt31I8NcwGe8bKeYdqulYqGUtiQ
 NgBpMKaMfnlKkUm1EVIrRMzy0ulTzd6zMikubVrEk44FMTSs7FCb8UrTKqjUwqtnUH6Vcg3
 a3owwCJdSJj3KybiPpYRafpBDID+sW7N/oLFTjGX+v+q6JWPfL0ivJTuow1P//bkOGkHKNp
 LwO8t2nD/y87k56LsuFBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7U1ypnc8ehM=;8DGI+m4Z+kXS3EawXYwvsbLPare
 NFK8rpsbFngwSULrTpYeW04AkgbviPV17JGi2pna8UVYSvH3UVii04Hf9XcIjGfBYJR0gCQz5
 6RpU3XlcXqGPhS8iJWxC3f/rI7h5Nr+GogEMLyTK0sMEAGhOPKT2B/X2kBYuea7JK+FcCkMQ6
 qWZSavfPCmPxVIob9AzRrhWVprbWNe57MjbYtwYV3qjcOfIXbNjEcN3tV0wPGzGbKzmpQDcqz
 0BuOnhfCLpLmVx8fmL6mcgY4Ein9HrsQ2/YDGxBAMsOK9c0bQ3LS9X+AhL1LlEIgJ1I9x2cKe
 nEmKFowGpQLjxhgvSrUu0QL4ed8pW+kw+KhYkcyTv6IL/NxMrs0gG/qD2TRTb6oO9dIJ80D29
 2RFOnc0jAtkiOHgphrQVrUic+FX5L2xBf9VEJI20ARjQfxecKfGG4RCGAeNbmz29PouPePlWW
 DzxIet53U+nKtyAwyqF8at053K40qYD4gbPqrtYaS5HHQodlHZDxP/dm+KU89BIRznnPZtNMC
 5cv+YXiCUTzIgQQ8fr/bX7g61tXcYVCMKmMQqhoR4zWu/bYHRrFsZZaSnHF4LG7VU8T7IxD02
 YrPxsNR/+VdKHnLf4JgKDiqW/CLju1WeXuSdAMg2cIrDhTp0j2iZ40Q2lp1Gaa86pHtbtJw3S
 ge+jDpYtdBC7vsNpEC6HOVLNKQM6vrNs22trY50fJloZ8kfIOTvN+WaI+72jpOZ1aOa1uc6+6
 Iaws8vr1TN4rjtPpsTDYolBGezJIyae1RvF4MJKpjZERovLL9dnNlPlaxOHkGmoPjc73rLWxx
 5V3WBIEcpwysVM93atK9EbTQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 16:36:30 +0200

Single characters (line breaks) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7674b7f2df14..3200bf129fc6 100644
=2D-- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6099,7 +6099,7 @@ static void regulator_summary_show_subtree(struct se=
q_file *s,
 		}
 	}

-	seq_puts(s, "\n");
+	seq_putc(s, '\n');

 	list_for_each_entry(consumer, &rdev->consumer_list, list) {
 		if (consumer->dev && consumer->dev->class =3D=3D &regulator_class)
@@ -6125,7 +6125,7 @@ static void regulator_summary_show_subtree(struct se=
q_file *s,
 			break;
 		}

-		seq_puts(s, "\n");
+		seq_putc(s, '\n');
 	}

 	summary_data.s =3D s;
=2D-
2.45.2


