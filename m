Return-Path: <linux-kernel+bounces-337454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FC6984A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A11C2300E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456861AC423;
	Tue, 24 Sep 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wf9v91rx"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDE3FB8B;
	Tue, 24 Sep 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199041; cv=none; b=qJ5FAdql7NdFZJZQug3kPB1eM/whuZ2+r3kL35ZuLSyKsYA+xvK+PG/jZIcbJaXI7kci+rEslg5RxTSpBviVuENVtBPPJF2rjnUQYg6DMBUHyTaBWGlsKxxVax9+DXMRTLisayewuPLMJ88Qi7AFAvvdR6fLT0PHFEcAsMeQpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199041; c=relaxed/simple;
	bh=RO2ZB2mAtNaAGzdO4HuTNrORlxBQ6Qaq39Q0YnDNI8g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y91jwSBGvYp/aj/DmAHdvRlvqkJs+HUCIaEQipF8C8MvvGbf41SN92Nj6f/hzh2fFXZOD501tFvMtNzc/YVh5ozp5NW80q4gWErftRJIRcmAGsvJtJVhnPwO7xo3OmbJpfZAkWW84F3VaLVN7NRBcAJN1G0wc8Ia5msv1UNHAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wf9v91rx; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727199026; x=1727803826; i=markus.elfring@web.de;
	bh=4mfwioSqNz1uaXMGzI6rNjNw0tbkP090IrnGZupCa+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wf9v91rxSNdGDLLl0AMKUiQ2QTdlc0kreAk4pcwAJEI8/2P1Inb6NVHtJgK3FKRY
	 ZqDpLujR9i5PHPDsjaP5ZzaBBsSQsuAHXHAdeP+bzdAwvDJBOcRH33ZHDZYd3kAD1
	 hjbXBT8y1AnhU8WjbZ6gZRDzA2dSrQqLevk5TBPiyKbIBMI1AmIgL4EUDKyK1eGAw
	 64eeWjZIwKF13bVvFDheeDPk85wKI4IAbvtdPHn+Ncv8aGGVnU0LEyUHG+II3O3jz
	 N/jocAYaqYwcI4On540TNX9NJu7g1tHUD7utwPxoGHikXgSbLKyAUgG5erJ18ZGAN
	 QSYwdkrYrnHhw6NKvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1rrNal11nV-00u6Yf; Tue, 24
 Sep 2024 19:30:26 +0200
Message-ID: <641ff33c-3687-42d7-933c-484bf3ab595c@web.de>
Date: Tue, 24 Sep 2024 19:30:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wen Yang <yellowriver2010@hotmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] soc: amlogic: canvas: Call of_node_put(canvas_node) only once
 in meson_canvas_get()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x907D9MwWHI2ckPDKuTvoYE0b+ZRZLxcbFnLePj3PC5GDLUoMSX
 HAq3QNdlAW+3i9H6I4tKBVcL6YDhd7GIIUQnuCAQKS0beJTnJaR9mOvDpACUzOnikB7xgYt
 Q0WRJ1Ku5YzaUmo1K5sHlLKZpTkYmYqYwn8GPTzxJdtpYZ8uvM30En5LHOoCkFkawFwY2dw
 iVlWGxBMj9diT6t+/SVaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XNVQTf+Rhd4=;diLSSIvOa9yn75IMCCgotgIqeDN
 5UqB54P61CPlc4r5ZZALfsxLQ9chaxX+dwTR1WTOAFNXh+y/SUo8ULH6yaourTyWoTcediPiq
 q6MN/SCAsYuBTdX2G47lH16lzp/RQHArzsGrOK66aI5saP2EUAwYYbs0+MBgo3c0GnuYkaEA+
 64Slj4/QB6Pl2Uoj0cWI4ND/14ydb3lPbmbPeM3UHNhxTV9K6TT65cLJMg4ujBZNyiVQCAupX
 tjLA5MlKbGVdjXy+EuQjULmlIZOcyEJQJzkdDCpaBqi6MqsFlL82fJlHK56B2AQi8Dm8VmR8z
 hQwHrWQRTtMWB8QPLzS+a15UXga9t02UlNV6EXtrzmuhe5jc0P7VWIRhqRmenNwcCNxfw/LOS
 fiG+farVjti1/5BjRBjZhAqAXvIBzT3VMiKCRJsHY6FJRQg8noCVn6gjHWwOMHU6H1OH9abZs
 MaJqt+EPVGf8t+2LCoEqmGvUv0KSEy6IobcpxJomIFnxaOG55x9o2esoWRGhlLN0N3j7zBww3
 pJMKVP+9xAlxLnWf+tYDArAqNzY/h8Um7B5FCX8cvcOs9bIJo/Gq6u6T/1WKX4dzop0CVs7Pp
 jbusyx0g7ISGAruO+fW0A6y9S37ZZFZuhEfgPSjlIZtKtbJ0WJX7Psx+aJ5fQUuuxzeFvDObG
 UMJwNGsWOptfJbz48D93wNjLuWXXIY5YadWAX/On+RBueRtnAo51z4HqWVRHWz9x7/J423xw2
 Rz25EUi4WtluiuRGyXmmdbw1CkkCoQwLw6VBmRGN4wxh8JtaPvc+fMPtycWPo/de0SnFliZ4O
 3d0n2XtwJIteF3/+LHFIZHUA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 19:01:58 +0200

An of_node_put(canvas_node) call was immediately used after a pointer chec=
k
for a of_find_device_by_node() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/amlogic/meson-canvas.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meso=
n-canvas.c
index b6e06c4d2117..245157053ed3 100644
=2D-- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -60,12 +60,9 @@ struct meson_canvas *meson_canvas_get(struct device *de=
v)
 		return ERR_PTR(-ENODEV);

 	canvas_pdev =3D of_find_device_by_node(canvas_node);
-	if (!canvas_pdev) {
-		of_node_put(canvas_node);
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
 	of_node_put(canvas_node);
+	if (!canvas_pdev)
+		return ERR_PTR(-EPROBE_DEFER);

 	/*
 	 * If priv is NULL, it's probably because the canvas hasn't
=2D-
2.46.1


