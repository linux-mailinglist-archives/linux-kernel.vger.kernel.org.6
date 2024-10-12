Return-Path: <linux-kernel+bounces-362537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8499B612
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB861F22107
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815D6F066;
	Sat, 12 Oct 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="R4ZnrP/Q"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB84EB45
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749880; cv=none; b=enWDNCtIQ19HLxVs4oPwVGwiIFg5Ob9Rfee24gerNBQY6jNQYPJwlxAfELTPtTpd7meFUPIG2hb05YGENvBzD6EVsQ5aaBOGnNwjoMyyBgxDDrD5oSWWBC3XMXEI8I84y/hXgIqqXWoN9d2brC3VWdYD7W/XEy8+CPsAiJvTmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749880; c=relaxed/simple;
	bh=8eivlslE4oGs45HvFHcvwu3P3Ga4PSBnV3GiaOcyh4s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efpc1a1e8adNx8PPAj2l9UzpuiTiVb6+vmPvgDLeRYEFxElvaxGk3U0GVwcrIQfIzCWjzjNlWJDLpWY86CmHRX7Z+La545OyE2xGw2Zwgr/bGhi6s8ATA7INaJ90RLoGR8qIhu1rfphOG/uwYdBT8H/xK3BLbi5Ace2Rph6FRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=R4ZnrP/Q; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728749870; x=1729009070;
	bh=52WVORkfnDkVyMBFswK6MWZ9dQO2mOxwLkOU4XQvrTM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R4ZnrP/Q5i9V9/1IYVNYB1iZdpH1PuHyRVyvDWSwk72Ag0Ypv5cROVr1/nJgdVC4O
	 CreISNQuwxhtTuyGFy0VblTvLbnusNANRURCo+jbVXzPfb87K3vsRabQYcPdJHV0vE
	 MY1OrXWa9R7JAtKp6UjILSISm88Q6WGRbf7/Pz2AmqsDwQdsHTo3uNwjr2J32T57pM
	 7PEs2FdF6fcltz+NnsuhT9S9SYQIZR6kWYT7ywm2sT4Loj8NcTLCzyCBrQ1GJ5hSN+
	 fXU4D/3ZoaMOotllHrXuqVz4+KLA80ZyqwMpN+cyD06lKeApqHujqNXNs4fMv1wF8D
	 Xyqx0eWeI/rrQ==
Date: Sat, 12 Oct 2024 16:17:45 +0000
To: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, ayushtiw0110@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 1/3] staging: rtl8712: Rename AuthAlgrthm variable
Message-ID: <20241012161638.67030-2-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
References: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 1002e10e3e6da00d359c20630f20449de620c27f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames AuthAlgrthm to auth_algorithm in order to avoid
using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8712/mlme_linux.c          |  4 ++--
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 24 +++++++++----------
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c        |  8 +++----
 drivers/staging/rtl8712/rtl871x_recv.c        |  2 +-
 drivers/staging/rtl8712/rtl871x_security.h    |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712=
/mlme_linux.c
index 436816d14cdf..041768d46def 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -92,7 +92,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapte=
r)
=20
 =09r8712_indicate_wx_disassoc_event(adapter);
 =09netif_carrier_off(adapter->pnetdev);
-=09if (adapter->securitypriv.AuthAlgrthm =3D=3D 2) { /*/802.1x*/
+=09if (adapter->securitypriv.auth_algorithm =3D=3D 2) { /*/802.1x*/
 =09=09/* We have to backup the PMK information for WiFi PMK Caching
 =09=09 * test item. Backup the btkip_countermeasure information.
 =09=09 * When the countermeasure is trigger, the driver have to
@@ -121,7 +121,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adap=
ter)
 =09} else { /*reset values in securitypriv*/
 =09=09struct security_priv *sec_priv =3D &adapter->securitypriv;
=20
-=09=09sec_priv->AuthAlgrthm =3D 0; /*open system*/
+=09=09sec_priv->auth_algorithm =3D 0; /*open system*/
 =09=09sec_priv->PrivacyAlgrthm =3D _NO_PRIVACY_;
 =09=09sec_priv->PrivacyKeyIndex =3D 0;
 =09=09sec_priv->XGrpPrivacy =3D _NO_PRIVACY_;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_linux.c
index ebfb1b2f1189..eca6175e232c 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -325,18 +325,18 @@ static int wpa_set_auth_algs(struct net_device *dev, =
u32 value)
 =09=09=09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09=09=09 Ndis802_11AuthModeAutoSwitch;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 3;
+=09=09padapter->securitypriv.auth_algorithm =3D 3;
 =09} else if (value & AUTH_ALG_SHARED_KEY) {
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.ndisauthtype =3D Ndis802_11AuthModeShared;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 1;
+=09=09padapter->securitypriv.auth_algorithm =3D 1;
 =09} else if (value & AUTH_ALG_OPEN_SYSTEM) {
 =09=09if (padapter->securitypriv.ndisauthtype <
 =09=09=09=09=09=09 Ndis802_11AuthModeWPAPSK) {
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09=09=09 Ndis802_11AuthModeOpen;
-=09=09=09padapter->securitypriv.AuthAlgrthm =3D 0;
+=09=09=09padapter->securitypriv.auth_algorithm =3D 0;
 =09=09}
 =09} else {
 =09=09ret =3D -EINVAL;
@@ -414,7 +414,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09}
 =09=09goto exit;
 =09}
-=09if (padapter->securitypriv.AuthAlgrthm =3D=3D 2) { /* 802_1x */
+=09if (padapter->securitypriv.auth_algorithm =3D=3D 2) { /* 802_1x */
 =09=09struct sta_info *psta, *pbcmc_sta;
 =09=09struct sta_priv *pstapriv =3D &padapter->stapriv;
 =09=09struct security_priv *spriv =3D &padapter->securitypriv;
@@ -472,13 +472,13 @@ static int r871x_set_wpa_ie(struct _adapter *padapter=
, char *pie,
 =09=09}
 =09=09if (r8712_parse_wpa_ie(buf, ielen, &group_cipher,
 =09=09=09=09       &pairwise_cipher) =3D=3D 0) {
-=09=09=09padapter->securitypriv.AuthAlgrthm =3D 2;
+=09=09=09padapter->securitypriv.auth_algorithm =3D 2;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeWPAPSK;
 =09=09}
 =09=09if (r8712_parse_wpa2_ie(buf, ielen, &group_cipher,
 =09=09=09=09=09&pairwise_cipher) =3D=3D 0) {
-=09=09=09padapter->securitypriv.AuthAlgrthm =3D 2;
+=09=09=09padapter->securitypriv.auth_algorithm =3D 2;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeWPA2PSK;
 =09=09}
@@ -1450,7 +1450,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09=09=09 Ndis802_11EncryptionDisabled;
 =09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
 =09=09authmode =3D Ndis802_11AuthModeOpen;
 =09=09padapter->securitypriv.ndisauthtype =3D authmode;
 =09=09return 0;
@@ -1469,7 +1469,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09netdev_info(dev, "r8712u: %s: IW_ENCODE_OPEN\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
 =09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
@@ -1479,7 +1479,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09=09=09"r8712u: %s: IW_ENCODE_RESTRICTED\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 1; /* shared system */
+=09=09padapter->securitypriv.auth_algorithm =3D 1; /* shared system */
 =09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP40_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _WEP40_;
 =09=09authmode =3D Ndis802_11AuthModeShared;
@@ -1487,7 +1487,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09} else {
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.AuthAlgrthm =3D 0; /* open system */
+=09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
 =09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
@@ -1672,7 +1672,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
 =09=09=09=09  _NO_PRIVACY_;
 =09=09=09padapter->securitypriv.XGrpPrivacy =3D
 =09=09=09=09  _NO_PRIVACY_;
-=09=09=09padapter->securitypriv.AuthAlgrthm =3D 0;
+=09=09=09padapter->securitypriv.auth_algorithm =3D 0;
 =09=09=09padapter->securitypriv.ndisauthtype =3D
 =09=09=09=09  Ndis802_11AuthModeOpen;
 =09=09}
@@ -2017,7 +2017,7 @@ static int wpa_set_param(struct net_device *dev, u8 n=
ame, u32 value)
=20
 =09switch (name) {
 =09case IEEE_PARAM_WPA_ENABLED:
-=09=09padapter->securitypriv.AuthAlgrthm =3D 2; /* 802.1x */
+=09=09padapter->securitypriv.auth_algorithm =3D 2; /* 802.1x */
 =09=09switch ((value) & 0xff) {
 =09=09case 1: /* WPA */
 =09=09=09padapter->securitypriv.ndisauthtype =3D
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/=
rtl8712/rtl871x_ioctl_set.c
index b335799b2ad5..9eb67db36ecb 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -318,7 +318,7 @@ u8 r8712_set_802_11_authentication_mode(struct _adapter=
 *padapter,
=20
 =09psecuritypriv->ndisauthtype =3D authmode;
 =09if (psecuritypriv->ndisauthtype > 3)
-=09=09psecuritypriv->AuthAlgrthm =3D 2; /* 802.1x */
+=09=09psecuritypriv->auth_algorithm =3D 2; /* 802.1x */
 =09if (r8712_set_auth(padapter, psecuritypriv))
 =09=09ret =3D false;
 =09else
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl87=
12/rtl871x_mlme.c
index a80c99554273..876788b80953 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -768,7 +768,7 @@ void r8712_joinbss_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09=09=09=09=09ptarget_sta->aid =3D pnetwork->join_res;
 =09=09=09=09=09ptarget_sta->qos_option =3D 1;
 =09=09=09=09=09ptarget_sta->mac_id =3D 5;
-=09=09=09=09=09if (adapter->securitypriv.AuthAlgrthm =3D=3D 2) {
+=09=09=09=09=09if (adapter->securitypriv.auth_algorithm =3D=3D 2) {
 =09=09=09=09=09=09adapter->securitypriv.binstallGrpkey =3D false;
 =09=09=09=09=09=09adapter->securitypriv.busetkipkey =3D false;
 =09=09=09=09=09=09adapter->securitypriv.bgrpkey_handshake =3D false;
@@ -869,7 +869,7 @@ void r8712_stassoc_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09psta->mac_id =3D le32_to_cpu(pstassoc->cam_id);
 =09/* psta->aid =3D (uint)pstassoc->cam_id; */
=20
-=09if (adapter->securitypriv.AuthAlgrthm =3D=3D 2)
+=09if (adapter->securitypriv.auth_algorithm =3D=3D 2)
 =09=09psta->XPrivacy =3D adapter->securitypriv.PrivacyAlgrthm;
 =09psta->ieee8021x_blocked =3D false;
 =09spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -1131,7 +1131,7 @@ int r8712_set_auth(struct _adapter *adapter,
 =09=09kfree(pcmd);
 =09=09return -ENOMEM;
 =09}
-=09psetauthparm->mode =3D (u8)psecuritypriv->AuthAlgrthm;
+=09psetauthparm->mode =3D (u8)psecuritypriv->auth_algorithm;
 =09pcmd->cmdcode =3D _SetAuth_CMD_;
 =09pcmd->parmbuf =3D (unsigned char *)psetauthparm;
 =09pcmd->cmdsz =3D sizeof(struct setauth_parm);
@@ -1160,7 +1160,7 @@ int r8712_set_key(struct _adapter *adapter,
 =09=09ret =3D -ENOMEM;
 =09=09goto err_free_cmd;
 =09}
-=09if (psecuritypriv->AuthAlgrthm =3D=3D 2) { /* 802.1X */
+=09if (psecuritypriv->auth_algorithm =3D=3D 2) { /* 802.1X */
 =09=09psetkeyparm->algorithm =3D
 =09=09=09 (u8)psecuritypriv->XGrpPrivacy;
 =09} else { /* WEP */
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl87=
12/rtl871x_recv.c
index 0c305bd19693..3fb5cd746273 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -240,7 +240,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapt=
er,
 =09pfhdr =3D &precv_frame->u.hdr;
 =09psta_addr =3D pfhdr->attrib.ta;
 =09psta =3D r8712_get_stainfo(pstapriv, psta_addr);
-=09auth_alg =3D adapter->securitypriv.AuthAlgrthm;
+=09auth_alg =3D adapter->securitypriv.auth_algorithm;
 =09if (auth_alg =3D=3D 2) {
 =09=09/* get ether_type */
 =09=09ptr =3D ptr + pfhdr->attrib.hdrlen + LLC_HEADER_SIZE;
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/r=
tl8712/rtl871x_security.h
index 8461b7f05359..b498ce4ddd34 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -77,7 +77,7 @@ struct RT_PMKID_LIST {
 };
=20
 struct security_priv {
-=09u32 AuthAlgrthm;=09=09/* 802.11 auth, could be open, shared,
+=09u32 auth_algorithm;=09=09/* 802.11 auth, could be open, shared,
 =09=09=09=09=09 * 8021x and authswitch
 =09=09=09=09=09 */
 =09u32 PrivacyAlgrthm;=09=09/* This specify the privacy for shared
@@ -139,7 +139,7 @@ struct security_priv {
=20
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst) \
 do { \
-=09switch (psecuritypriv->AuthAlgrthm) { \
+=09switch (psecuritypriv->auth_algorithm) { \
 =09case 0: \
 =09case 1: \
 =09case 3: \
--=20
2.34.1



