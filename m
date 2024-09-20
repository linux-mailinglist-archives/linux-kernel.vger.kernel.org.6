Return-Path: <linux-kernel+bounces-334637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDF97D9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4352282287
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186F18593A;
	Fri, 20 Sep 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="lcetsq68"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880218455A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860991; cv=none; b=WltxsqO20JokQZBJvgQE/Kut5TA3bRs7QbqhwlMH4ehX70yLrGpSS54L8bvpowyXCgsgIj9nKnPOhb/LTqOjh7AnkmbxM1nBs/FckRmKcldjvOebOfcHZrNzVgm29Kv0HwWIMFk6Y4oxZ+HRtFDmHbdCiGgCvnEQtCO7lA3ttis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860991; c=relaxed/simple;
	bh=rzniopT2SXEGxnKqVQ774J7c6PZNdnBcFNJm8rL48Q4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVbLIPv4lkY9v4y8zrF5oQjarl1vZJs2UaLtvfV14KxqT+SI8O62txDvZa4mQs349avXow4hlFwCguyB1kr0nd0untwg+xIO+lf1FDnZmKH4puPGbl8WsvbnLLfBE7L74A/5XiaA+KoEFUlB7EIMKeEhXegrsppHKWpoJdb0GUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=lcetsq68; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726860987; x=1727120187;
	bh=JoAR1sQPtaUlXpgw19sfuDNI5yPJOT9S/zno3S9Toeo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lcetsq68rmSsOmQ2/XAA04TXXdk2Gc98u0GuRlNE/GOAIbT1XgbH0VGEu3hmVhR/B
	 zwCFq+R5qlhhprYkULAkIij3FlxBsdBAiwvfea8Gq7zf0+L4TwSXNSfP7SsDhKQAkp
	 B/BpC79Yv8HfeUV8XrPl312Wfy8F26jT8C4YadTjI8pqQvKgSzhXT5YlPEgFZnvjhQ
	 2CnVmn0kRMxPW6JLEoo/b4KAGyGdQh0F6XjLAcmf4YrZoM7Y2ySAp9v5kF/DwM8CSH
	 gQzT4RmLvFnRusbaov75twv09RzRERfWXd/I1guMZtkaxOeTt+v1Tqpl7rffHN9/If
	 OjO8D2G4OGYvQ==
Date: Fri, 20 Sep 2024 19:36:25 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 2/6] staging: rtl8192e: rtl_ps.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-3-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 0639569e88f9ff06e6da790c39ea977a34ff902d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch aligns the code to open parentheses to improve readability.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/r=
tl8192e/rtl8192e/rtl_ps.c
index 7b6247acf6f4..dba35ba20dac 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -118,7 +118,7 @@ void rtl92e_ips_enter(struct net_device *dev)
=20
 =09rt_state =3D priv->rtllib->rf_power_state;
 =09if (rt_state =3D=3D rf_on && !psc->bSwRfProcessing &&
-=09=09(priv->rtllib->link_state !=3D MAC80211_LINKED)) {
+=09    (priv->rtllib->link_state !=3D MAC80211_LINKED)) {
 =09=09psc->eInactivePowerState =3D rf_off;
 =09=09_rtl92e_ps_update_rf_state(dev);
 =09}
--=20
2.34.1



