Return-Path: <linux-kernel+bounces-334641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B497D9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F7281B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD514F98;
	Fri, 20 Sep 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cBVT0r1+"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8718592D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861006; cv=none; b=uCajta+3z/6Lvf3/zonfcyi4m4wH3xSwcN3c+METg9ZqKNqfH4qPn+GuKaiPvl7OG/Qu0sYE+il7Lgui3MvV++QU1BZszV3/tEf8XeTt6ZSxMWYKFw+ChWthQHsWeXsCB1n09c5mnhYZ6EGHxkEIPLZAkJ0zBDC//mfvXz06fDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861006; c=relaxed/simple;
	bh=nMnOH3ejztBIvxM3sl/gM3xAN4WzdHm1spQzvZS2D8c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkcm8odEGESK0Du6ojUa8bvNUOLRjpek4lr9r43jIsARxoqRL0yGZQfAaMOUUuSlVgY8uC+tVYqTEiF8UATkGBqemX9eMTyGiyq0PvX0KzWlwPb2JKqTp6lwiy+vcV3UT0qTO7DzImZIa/r6cFseONbAYqTuNgx20wmbQ5RJwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cBVT0r1+; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726861002; x=1727120202;
	bh=XCfttPUxAeMUA36JDfJs1RJzETrpwmH/h1KY+V2xxsA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cBVT0r1+cQg0ges5WjUVA/vSnpQU3+ryFwGWEhM6tBYrGItRbBqGegT8idX1+yKNu
	 4ulMg6+c1Jp7UF9rzndaw2RqyTMyp3pfpf1WDrDnAMHAd3y2azpzes9C3uAIIwndxY
	 t99gbo8RC0kTHxIpTYhyHXU+N7iPsSyOcFvu5QRtKLgBt13Q+CCWj0ucXIw7q674mx
	 r2IUJ1pEkTn/PQQqbUCEJKN9c4ExqzjAQ+k2Kzo66C+SmvreFcVv4tG3tVqCJrAw5z
	 WY57FdhyEW32unGWMtqGYNzN6bf2M65CRhP+/asvsoGfGF4qhBcyfyBr7rmgl2shn9
	 2GZq6hIeBe76Q==
Date: Fri, 20 Sep 2024 19:36:37 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 5/6] staging: rtl8192e: rtllib_softmac_wx.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-6-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 2ab4ce0cd9e0d7504f5bf41fcfed84cc71cb8ada
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
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 60 ++++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging=
/rtl8192e/rtllib_softmac_wx.c
index c59686d68a33..f66e2a74cdd9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -16,7 +16,7 @@
 #include "rtllib.h"
=20
 int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info =
*a,
-=09=09=09     union iwreq_data *wrqu, char *b)
+=09=09       union iwreq_data *wrqu, char *b)
 {
 =09int ret;
 =09struct iw_freq *fwrq =3D &wrqu->freq;
@@ -59,8 +59,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct=
 iw_request_info *a,
 EXPORT_SYMBOL(rtllib_wx_set_freq);
=20
 int rtllib_wx_get_freq(struct rtllib_device *ieee,
-=09=09=09     struct iw_request_info *a,
-=09=09=09     union iwreq_data *wrqu, char *b)
+=09=09       struct iw_request_info *a,
+=09=09       union iwreq_data *wrqu, char *b)
 {
 =09struct iw_freq *fwrq =3D &wrqu->freq;
=20
@@ -74,8 +74,8 @@ int rtllib_wx_get_freq(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_get_freq);
=20
 int rtllib_wx_get_wap(struct rtllib_device *ieee,
-=09=09=09    struct iw_request_info *info,
-=09=09=09    union iwreq_data *wrqu, char *extra)
+=09=09      struct iw_request_info *info,
+=09=09      union iwreq_data *wrqu, char *extra)
 {
 =09unsigned long flags;
=20
@@ -88,8 +88,8 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
 =09spin_lock_irqsave(&ieee->lock, flags);
=20
 =09if (ieee->link_state !=3D MAC80211_LINKED &&
-=09=09ieee->link_state !=3D MAC80211_LINKED_SCANNING &&
-=09=09ieee->wap_set =3D=3D 0)
+=09    ieee->link_state !=3D MAC80211_LINKED_SCANNING &&
+=09    ieee->wap_set =3D=3D 0)
=20
 =09=09eth_zero_addr(wrqu->ap_addr.sa_data);
 =09else
@@ -103,9 +103,9 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_get_wap);
=20
 int rtllib_wx_set_wap(struct rtllib_device *ieee,
-=09=09=09 struct iw_request_info *info,
-=09=09=09 union iwreq_data *awrq,
-=09=09=09 char *extra)
+=09=09      struct iw_request_info *info,
+=09=09      union iwreq_data *awrq,
+=09=09      char *extra)
 {
 =09int ret =3D 0;
 =09unsigned long flags;
@@ -155,7 +155,7 @@ int rtllib_wx_set_wap(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_set_wap);
=20
 int rtllib_wx_get_essid(struct rtllib_device *ieee, struct iw_request_info=
 *a,
-=09=09=09 union iwreq_data *wrqu, char *b)
+=09=09=09union iwreq_data *wrqu, char *b)
 {
 =09int len, ret =3D 0;
 =09unsigned long flags;
@@ -167,14 +167,14 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, s=
truct iw_request_info *a,
 =09spin_lock_irqsave(&ieee->lock, flags);
=20
 =09if (ieee->current_network.ssid[0] =3D=3D '\0' ||
-=09=09ieee->current_network.ssid_len =3D=3D 0) {
+=09    ieee->current_network.ssid_len =3D=3D 0) {
 =09=09ret =3D -1;
 =09=09goto out;
 =09}
=20
 =09if (ieee->link_state !=3D MAC80211_LINKED &&
-=09=09ieee->link_state !=3D MAC80211_LINKED_SCANNING &&
-=09=09ieee->ssid_set =3D=3D 0) {
+=09    ieee->link_state !=3D MAC80211_LINKED_SCANNING &&
+=09    ieee->ssid_set =3D=3D 0) {
 =09=09ret =3D -1;
 =09=09goto out;
 =09}
@@ -191,8 +191,8 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, str=
uct iw_request_info *a,
 EXPORT_SYMBOL(rtllib_wx_get_essid);
=20
 int rtllib_wx_set_rate(struct rtllib_device *ieee,
-=09=09=09     struct iw_request_info *info,
-=09=09=09     union iwreq_data *wrqu, char *extra)
+=09=09       struct iw_request_info *info,
+=09=09       union iwreq_data *wrqu, char *extra)
 {
 =09u32 target_rate =3D wrqu->bitrate.value;
=20
@@ -202,13 +202,13 @@ int rtllib_wx_set_rate(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_set_rate);
=20
 int rtllib_wx_get_rate(struct rtllib_device *ieee,
-=09=09=09     struct iw_request_info *info,
-=09=09=09     union iwreq_data *wrqu, char *extra)
+=09=09       struct iw_request_info *info,
+=09=09       union iwreq_data *wrqu, char *extra)
 {
 =09u32 tmp_rate;
=20
 =09tmp_rate =3D tx_count_to_data_rate(ieee,
-=09=09=09=09     ieee->softmac_stats.CurrentShowTxate);
+=09=09=09=09=09 ieee->softmac_stats.CurrentShowTxate);
 =09wrqu->bitrate.value =3D tmp_rate * 500000;
=20
 =09return 0;
@@ -216,14 +216,14 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_get_rate);
=20
 int rtllib_wx_set_rts(struct rtllib_device *ieee,
-=09=09=09     struct iw_request_info *info,
-=09=09=09     union iwreq_data *wrqu, char *extra)
+=09=09      struct iw_request_info *info,
+=09=09      union iwreq_data *wrqu, char *extra)
 {
 =09if (wrqu->rts.disabled || !wrqu->rts.fixed) {
 =09=09ieee->rts =3D DEFAULT_RTS_THRESHOLD;
 =09} else {
 =09=09if (wrqu->rts.value < MIN_RTS_THRESHOLD ||
-=09=09=09=09wrqu->rts.value > MAX_RTS_THRESHOLD)
+=09=09    wrqu->rts.value > MAX_RTS_THRESHOLD)
 =09=09=09return -EINVAL;
 =09=09ieee->rts =3D wrqu->rts.value;
 =09}
@@ -232,8 +232,8 @@ int rtllib_wx_set_rts(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_set_rts);
=20
 int rtllib_wx_get_rts(struct rtllib_device *ieee,
-=09=09=09     struct iw_request_info *info,
-=09=09=09     union iwreq_data *wrqu, char *extra)
+=09=09      struct iw_request_info *info,
+=09=09      union iwreq_data *wrqu, char *extra)
 {
 =09wrqu->rts.value =3D ieee->rts;
 =09wrqu->rts.fixed =3D 0;=09/* no auto select */
@@ -243,7 +243,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee,
 EXPORT_SYMBOL(rtllib_wx_get_rts);
=20
 int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info =
*a,
-=09=09=09     union iwreq_data *wrqu, char *b)
+=09=09       union iwreq_data *wrqu, char *b)
 {
 =09int set_mode_status =3D 0;
=20
@@ -359,7 +359,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 }
=20
 int rtllib_wx_set_scan(struct rtllib_device *ieee, struct iw_request_info =
*a,
-=09=09=09     union iwreq_data *wrqu, char *b)
+=09=09       union iwreq_data *wrqu, char *b)
 {
 =09int ret =3D 0;
=20
@@ -447,8 +447,8 @@ EXPORT_SYMBOL(rtllib_wx_get_name);
=20
 /* this is mostly stolen from hostap */
 int rtllib_wx_set_power(struct rtllib_device *ieee,
-=09=09=09=09 struct iw_request_info *info,
-=09=09=09=09 union iwreq_data *wrqu, char *extra)
+=09=09=09struct iw_request_info *info,
+=09=09=09union iwreq_data *wrqu, char *extra)
 {
 =09int ret =3D 0;
=20
@@ -499,8 +499,8 @@ EXPORT_SYMBOL(rtllib_wx_set_power);
=20
 /* this is stolen from hostap */
 int rtllib_wx_get_power(struct rtllib_device *ieee,
-=09=09=09=09 struct iw_request_info *info,
-=09=09=09=09 union iwreq_data *wrqu, char *extra)
+=09=09=09struct iw_request_info *info,
+=09=09=09union iwreq_data *wrqu, char *extra)
 {
 =09mutex_lock(&ieee->wx_mutex);
=20
--=20
2.34.1



