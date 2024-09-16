Return-Path: <linux-kernel+bounces-330370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA51979D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF47B238FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141B146586;
	Mon, 16 Sep 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Pzd199Zt"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27D13C8E8;
	Mon, 16 Sep 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476641; cv=none; b=uAosv+DkSfwBz5mU9+q2CiUJiREMyBFglou2s/a1XlwR+Yf5rPbB0xFVIAKHVRaDKm9jtAwWTzqDlRbg4Q6JeeG5QZ9b86v6HIu0SFF/Rb+KnZPj5JMR/WzSly0iam3Xubh0lz1ja9LKGSZW+KFQfl7bR/QwVLARFFUWwWiLqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476641; c=relaxed/simple;
	bh=t+IQ9RTWxdzVYuVdIhvfKJXVAtXQvpZ4skDYvaDknGU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s+ffUbluFKxq3C63pHHryaTaYESx4FhQo8c3dZaU9cTH4HWi53ltad9fFY2yPiqDJK5JHS/ydhnJyoWcFSbe0kGxvQSqUkX9l3hR2lSJEpunpUaKsbeS57mpIX+h6HPxVVmU19X6+Zu8xpROTA4MX+gdJPS0rdB2vpeAlkJEwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Pzd199Zt; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726476627; x=1727081427; i=markus.elfring@web.de;
	bh=Cdh2sCthxJLXSaRFkitknB67DXkRE1TaqYOdeu6G4HA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pzd199ZtFvk5zroQrvRvsWBon6K6Qg0OoRt1Q/jxMBViCdHVcvuUSW75j0lufMHK
	 Kc5B7hxeK010ar7xQVnYA3E2r1PLezddPbTfIxijHD9BE4XMUobMZJVHuxxo6ZOSp
	 ZvW42L8oolv0oAEhJuxPFko5PRFDvdLQzaivTy4H9D1hkNEbGIMh+Tfw9Zd08MAC/
	 kY1lWgofEUaJmg9R4q3+h7G5pAQCWRW1cip1QtObBwFMr2m8p8F21T2x6wz+Kze7e
	 P3ZR+YAxO5efpFPqGsXY4pPIyPTSFiiUcLfQc76dOHjgnGm5n0B4inb19SSU5OByM
	 FJAs/ppsXZmIaCZ17Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1sMpMP1V0c-00jF6P; Mon, 16
 Sep 2024 10:50:27 +0200
Message-ID: <6a6c87d3-9e4f-4980-ae06-b0d5e16dd0c0@web.de>
Date: Mon, 16 Sep 2024 10:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] ASoC: tas5805m: Improve a size determination in
 tas5805m_i2c_probe()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-sound@vger.kernel.org, Daniel Beer <daniel.beer@igorinstitute.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Content-Language: en-GB
In-Reply-To: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eDizXtHr60xTMZBo2z3uuH8kBSZwS0zyTfYJUn0VJ9XiL/Ihu3X
 BAvRLOycnnhnzi6YcJGjLCXTEOjpX8+dsInfgQNrh2V4p2fSzF9FGOYJznToZaFQhlXlbGe
 v1f+Cx3PexFNN51Tlrn8aOwLLqEkCR3mkX/fiS9xEk7ClGSMySOqetUERytbELJG6ClZ4Jk
 rddQ5osIBoihXEtMGdIww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GYJePe2PaRQ=;OXTG5OmtR568fIFs5X4a5WyJS0a
 LbP1Vfd+u5n7ZAVnJY+JEc1E6UMpERU1o6qdMJfOzi9Va7nl0bg3lhkEt6SFPwiUDx7sTzaqr
 LRqf8g4sCEyQsqi7KogTTJx/OXb4WEXCPrAS3Zg4LZhk0EW9TVAg4dqqtKWSy15hHz1tmixR6
 cR6/F7OaYttkgY1shPJSFt8f7fCgXUwSptw9BCdGMP8t2l4G0xWFi9t69fCeKiW15RgSqx8KD
 LlDHPPxHOy47UO0Fp2hONg9Qh5DquVAejDsBtnlu7E5HP8J4z4Dv6MOiFjHFanJP5dywz7Wc1
 /h5aYswwRLRYKYwvH4Yx9FFq6ucF3ohvrG3MlUAvZIW7JpMgx2sPZbfwBYKezexd71JZmQeOY
 hb5d1VsK57/27R5a1XJDt/7cYyTPAsmOsJhkrIavbv00oikQLxaNOgac3PMvHdryJHiiHdJH0
 waDvQqp3Q7HvMH8fN7pXZImp8M84QWmhO8Fa92E8v2APMH2F0tF04uoGQ0TqHJRDjDWzOhREb
 SJyfFj9GzE9QBX6gdD/Z9XAPwt8L91nx12vJtit7GdobMXe2DyVr3DeNYJn9pViWjjEnTuP/U
 979+DZMBYeGadeLT57FTa5veGdG2SF70jwaEirNiFmAY8Ifn7iWXsGAUlTrMNvgwlp6fuJjmm
 ZpQIlQ5xZrdGirbaRo/+hFoRdynMIVgJJVdqgJusTXfIAky3uIROBHjJ/99lf0qulx79RYFGN
 ZoWOxbzrvS+5vZ5cNMbz47sa+JKY71WHVxl4nMs9lrHvWLKl0OoxWBrMpAMxXaUkO3eMuJLdp
 j4+tYiAZyE68Gp5AQgztbVuA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Sep 2024 10:20:12 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/codecs/tas5805m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
index f37eec960364..d4f028451071 100644
=2D-- a/sound/soc/codecs/tas5805m.c
+++ b/sound/soc/codecs/tas5805m.c
@@ -473,7 +473,7 @@ static int tas5805m_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}

-	tas5805m =3D devm_kzalloc(dev, sizeof(struct tas5805m_priv), GFP_KERNEL)=
;
+	tas5805m =3D devm_kzalloc(dev, sizeof(*tas5805m), GFP_KERNEL);
 	if (!tas5805m)
 		return -ENOMEM;

=2D-
2.46.0


