Return-Path: <linux-kernel+bounces-362539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFE99B614
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670C3B21D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA845028;
	Sat, 12 Oct 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TWYxiun6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FA6F2E0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749884; cv=none; b=P3nfSA6X+0te2rvxOOjgRCdlpFchS5eKtStKVuBsdbX1M6JmhhBpAwkFMOJoQv840qFCvPlaWtJT94/VTOnMG9iZEmYfI5+zEe6iOxsPr2bSixPMrCcdvXOs0GsmrAzN1SSXUfzheT6N+PzEPbgBx2Co0w0OqCDX4Y4jvinzyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749884; c=relaxed/simple;
	bh=F/Nl8SmmBe+I1r5HyZd6V2ThoIvMxT4kzinQ6SmDZWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BF0KK0xRgsGMIVfIez20xJg/Lob/jxQ90d6joF5Rg0eZSC1gQGzNiuXHwovbbCHVbQA3G9ja/dSkmzWxIWSIm15qZZES7VPdrwgtSgIrWn/CqhrhuBbxypJxvY7fDfp82QfSCNuPnao9/uOWXaZ2idIPit5oZmtXKY7YyyCK9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TWYxiun6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728749874; x=1729009074;
	bh=fl5nW5Fm7DWsks+7jgrW29hy56ja579BSq6oxwGLuUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TWYxiun6LS3xc/Y4gu/fF92PRTI2Ccjn29RMWL0hzPQc0EOCFMqsx2eGuxmuAt88t
	 PITslLylbTCI1dgxR4Ij9nHHQePBJOBWyCgiz5iB80AAZ18CME7E6u2tkjVLTew9jP
	 3aqmp6tezXDqEegeroUEhAMOkGpnZ8DDXBzHGeRcxbp10JErmu756k61oSCuiAbkGm
	 gpAPN4ui/19yyVbDN3cNLy1yCvFMr8Sw9U2SzP4JO29f/5EH2DkkS+6apXUeyhuqwy
	 cCMjLLRHkbnFjkZeCNx5w4IK7i6c+NIkwTyV9F0cVTkS4yDdnjZ8Y7GVMkEJPcuU8W
	 isSXqOzaHdrNA==
Date: Sat, 12 Oct 2024 16:17:51 +0000
To: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, ayushtiw0110@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 2/3] staging: rtl8712: Rename PrivacyAlgrthm variable
Message-ID: <20241012161638.67030-3-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
References: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 91c1208ee6d21a26337b3dfc6373f1685024ea26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames PrivacyAlgrthm to privacy_algorithm in order to avoid
using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8712/mlme_linux.c          |  2 +-
 drivers/staging/rtl8712/rtl871x_cmd.c         |  6 ++--
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 36 +++++++++----------
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  6 ++--
 drivers/staging/rtl8712/rtl871x_mlme.c        | 14 ++++----
 drivers/staging/rtl8712/rtl871x_security.h    |  4 +--
 6 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712=
/mlme_linux.c
index 041768d46def..fa6b0adec746 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -122,7 +122,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adap=
ter)
 =09=09struct security_priv *sec_priv =3D &adapter->securitypriv;
=20
 =09=09sec_priv->auth_algorithm =3D 0; /*open system*/
-=09=09sec_priv->PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09sec_priv->privacy_algorithm =3D _NO_PRIVACY_;
 =09=09sec_priv->PrivacyKeyIndex =3D 0;
 =09=09sec_priv->XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09sec_priv->XGrpKeyid =3D 1;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl871=
2/rtl871x_cmd.c
index 218836128e8f..21e00ec83a19 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -407,8 +407,8 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struc=
t wlan_network *pnetwork)
 =09=09 * to avoid some IOT issues, especially for Realtek 8192u
 =09=09 * SoftAP.
 =09=09 */
-=09=09if ((padapter->securitypriv.PrivacyAlgrthm !=3D _WEP40_) &&
-=09=09    (padapter->securitypriv.PrivacyAlgrthm !=3D _WEP104_)) {
+=09=09if ((padapter->securitypriv.privacy_algorithm !=3D _WEP40_) &&
+=09=09    (padapter->securitypriv.privacy_algorithm !=3D _WEP104_)) {
 =09=09=09/* restructure_ht_ie */
 =09=09=09r8712_restructure_ht_ie(padapter,
 =09=09=09=09=09=09&pnetwork->network.IEs[0],
@@ -522,7 +522,7 @@ void r8712_setstakey_cmd(struct _adapter *padapter, u8 =
*psta, u8 unicast_key)
 =09ether_addr_copy(psetstakey_para->addr, sta->hwaddr);
 =09if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 =09=09psetstakey_para->algorithm =3D (unsigned char)
-=09=09=09=09=09    psecuritypriv->PrivacyAlgrthm;
+=09=09=09=09=09    psecuritypriv->privacy_algorithm;
 =09else
 =09=09GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false=
);
 =09if (unicast_key)
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_linux.c
index eca6175e232c..f832501cc196 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -370,7 +370,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09netdev_info(dev, "r8712u: %s: crypt.alg =3D WEP\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09     Ndis802_11Encryption1Enabled;
-=09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP40_;
+=09=09padapter->securitypriv.privacy_algorithm =3D _WEP40_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _WEP40_;
 =09=09wep_key_idx =3D param->u.crypt.idx;
 =09=09wep_key_len =3D param->u.crypt.key_len;
@@ -387,7 +387,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09pwep->Length =3D wep_key_len +
 =09=09=09offsetof(struct NDIS_802_11_WEP, KeyMaterial);
 =09=09if (wep_key_len =3D=3D 13) {
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP104_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _WEP104_;
 =09=09=09padapter->securitypriv.XGrpPrivacy =3D _WEP104_;
 =09=09}
 =09=09pwep->KeyIndex =3D wep_key_idx;
@@ -397,7 +397,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09=09if (r8712_set_802_11_add_wep(padapter, pwep))
 =09=09=09=09ret =3D -EOPNOTSUPP;
 =09=09} else {
-=09=09=09/* don't update "psecuritypriv->PrivacyAlgrthm" and
+=09=09=09/* don't update "psecuritypriv->privacy_algorithm" and
 =09=09=09 * "psecuritypriv->PrivacyKeyIndex=3Dkeyid", but can
 =09=09=09 * r8712_set_key to fw/cam
 =09=09=09 */
@@ -429,7 +429,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09=09=09    Ndis802_11Encryption2Enabled ||
 =09=09=09=09    spriv->ndisencryptstatus =3D=3D
 =09=09=09=09    Ndis802_11Encryption3Enabled)
-=09=09=09=09=09psta->XPrivacy =3D spriv->PrivacyAlgrthm;
+=09=09=09=09=09psta->XPrivacy =3D spriv->privacy_algorithm;
 =09=09=09=09if (param->u.crypt.set_tx =3D=3D 1)
 =09=09=09=09=09handle_pairwise_key(psta, param,
 =09=09=09=09=09=09=09    padapter);
@@ -444,7 +444,7 @@ static int wpa_set_encryption(struct net_device *dev, s=
truct ieee_param *param,
 =09=09=09=09    spriv->ndisencryptstatus =3D=3D
 =09=09=09=09    Ndis802_11Encryption3Enabled)
 =09=09=09=09=09pbcmc_sta->XPrivacy =3D
-=09=09=09=09=09=09spriv->PrivacyAlgrthm;
+=09=09=09=09=09=09spriv->privacy_algorithm;
 =09=09=09}
 =09=09}
 =09}
@@ -506,23 +506,23 @@ static int r871x_set_wpa_ie(struct _adapter *padapter=
, char *pie,
 =09=09}
 =09=09switch (pairwise_cipher) {
 =09=09case WPA_CIPHER_NONE:
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption=
Disabled;
 =09=09=09break;
 =09=09case WPA_CIPHER_WEP40:
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP40_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _WEP40_;
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption=
1Enabled;
 =09=09=09break;
 =09=09case WPA_CIPHER_TKIP:
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _TKIP_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _TKIP_;
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption=
2Enabled;
 =09=09=09break;
 =09=09case WPA_CIPHER_CCMP:
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _AES_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _AES_;
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption=
3Enabled;
 =09=09=09break;
 =09=09case WPA_CIPHER_WEP104:
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP104_;
+=09=09=09padapter->securitypriv.privacy_algorithm =3D _WEP104_;
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption=
1Enabled;
 =09=09=09break;
 =09=09}
@@ -1448,7 +1448,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09netdev_info(dev, "r8712u: %s: EncryptionDisabled\n", __func__);
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11EncryptionDisabled;
-=09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
 =09=09authmode =3D Ndis802_11AuthModeOpen;
@@ -1470,7 +1470,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
-=09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
 =09=09padapter->securitypriv.ndisauthtype =3D authmode;
@@ -1480,7 +1480,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.auth_algorithm =3D 1; /* shared system */
-=09=09padapter->securitypriv.PrivacyAlgrthm =3D _WEP40_;
+=09=09padapter->securitypriv.privacy_algorithm =3D _WEP40_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _WEP40_;
 =09=09authmode =3D Ndis802_11AuthModeShared;
 =09=09padapter->securitypriv.ndisauthtype =3D authmode;
@@ -1488,7 +1488,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09 Ndis802_11Encryption1Enabled;
 =09=09padapter->securitypriv.auth_algorithm =3D 0; /* open system */
-=09=09padapter->securitypriv.PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09padapter->securitypriv.privacy_algorithm =3D _NO_PRIVACY_;
 =09=09padapter->securitypriv.XGrpPrivacy =3D _NO_PRIVACY_;
 =09=09authmode =3D Ndis802_11AuthModeOpen;
 =09=09padapter->securitypriv.ndisauthtype =3D authmode;
@@ -1506,15 +1506,15 @@ static int r8711_wx_set_enc(struct net_device *dev,
 =09=09=09padapter->securitypriv.PrivacyKeyIndex =3D key;
 =09=09=09switch (padapter->securitypriv.DefKeylen[key]) {
 =09=09=09case 5:
-=09=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D
+=09=09=09=09padapter->securitypriv.privacy_algorithm =3D
 =09=09=09=09=09=09 _WEP40_;
 =09=09=09=09break;
 =09=09=09case 13:
-=09=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D
+=09=09=09=09padapter->securitypriv.privacy_algorithm =3D
 =09=09=09=09=09=09 _WEP104_;
 =09=09=09=09break;
 =09=09=09default:
-=09=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D
+=09=09=09=09padapter->securitypriv.privacy_algorithm =3D
 =09=09=09=09=09=09 _NO_PRIVACY_;
 =09=09=09=09break;
 =09=09=09}
@@ -1668,7 +1668,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
 =09=09if (paramval) {
 =09=09=09padapter->securitypriv.ndisencryptstatus =3D
 =09=09=09=09   Ndis802_11EncryptionDisabled;
-=09=09=09padapter->securitypriv.PrivacyAlgrthm =3D
+=09=09=09padapter->securitypriv.privacy_algorithm =3D
 =09=09=09=09  _NO_PRIVACY_;
 =09=09=09padapter->securitypriv.XGrpPrivacy =3D
 =09=09=09=09  _NO_PRIVACY_;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/=
rtl8712/rtl871x_ioctl_set.c
index 9eb67db36ecb..569d26425250 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -337,13 +337,13 @@ int r8712_set_802_11_add_wep(struct _adapter *padapte=
r,
 =09=09return -EINVAL;
 =09switch (wep->KeyLength) {
 =09case 5:
-=09=09psecuritypriv->PrivacyAlgrthm =3D _WEP40_;
+=09=09psecuritypriv->privacy_algorithm =3D _WEP40_;
 =09=09break;
 =09case 13:
-=09=09psecuritypriv->PrivacyAlgrthm =3D _WEP104_;
+=09=09psecuritypriv->privacy_algorithm =3D _WEP104_;
 =09=09break;
 =09default:
-=09=09psecuritypriv->PrivacyAlgrthm =3D _NO_PRIVACY_;
+=09=09psecuritypriv->privacy_algorithm =3D _NO_PRIVACY_;
 =09=09break;
 =09}
 =09memcpy(psecuritypriv->DefKey[keyid].skey, &wep->KeyMaterial,
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl87=
12/rtl871x_mlme.c
index 876788b80953..66f9fc51c147 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -219,10 +219,10 @@ int r8712_is_same_ibss(struct _adapter *adapter, stru=
ct wlan_network *pnetwork)
 =09int ret =3D true;
 =09struct security_priv *psecuritypriv =3D &adapter->securitypriv;
=20
-=09if ((psecuritypriv->PrivacyAlgrthm !=3D _NO_PRIVACY_) &&
+=09if ((psecuritypriv->privacy_algorithm !=3D _NO_PRIVACY_) &&
 =09=09    (pnetwork->network.Privacy =3D=3D cpu_to_le32(0)))
 =09=09ret =3D false;
-=09else if ((psecuritypriv->PrivacyAlgrthm =3D=3D _NO_PRIVACY_) &&
+=09else if ((psecuritypriv->privacy_algorithm =3D=3D _NO_PRIVACY_) &&
 =09=09 (pnetwork->network.Privacy =3D=3D cpu_to_le32(1)))
 =09=09ret =3D false;
 =09else
@@ -426,7 +426,7 @@ static int is_desired_network(struct _adapter *adapter,
 =09=09=09return true;
 =09=09return false;
 =09}
-=09if ((psecuritypriv->PrivacyAlgrthm !=3D _NO_PRIVACY_) &&
+=09if ((psecuritypriv->privacy_algorithm !=3D _NO_PRIVACY_) &&
 =09=09    (pnetwork->network.Privacy =3D=3D 0))
 =09=09bselected =3D false;
 =09if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
@@ -774,7 +774,7 @@ void r8712_joinbss_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09=09=09=09=09=09adapter->securitypriv.bgrpkey_handshake =3D false;
 =09=09=09=09=09=09ptarget_sta->ieee8021x_blocked =3D true;
 =09=09=09=09=09=09ptarget_sta->XPrivacy =3D
-=09=09=09=09=09=09=09adapter->securitypriv.PrivacyAlgrthm;
+=09=09=09=09=09=09=09adapter->securitypriv.privacy_algorithm;
 =09=09=09=09=09=09memset((u8 *)&ptarget_sta->x_UncstKey,
 =09=09=09=09=09=09=090,
 =09=09=09=09=09=09=09sizeof(union Keytype));
@@ -870,7 +870,7 @@ void r8712_stassoc_event_callback(struct _adapter *adap=
ter, u8 *pbuf)
 =09/* psta->aid =3D (uint)pstassoc->cam_id; */
=20
 =09if (adapter->securitypriv.auth_algorithm =3D=3D 2)
-=09=09psta->XPrivacy =3D adapter->securitypriv.PrivacyAlgrthm;
+=09=09psta->XPrivacy =3D adapter->securitypriv.privacy_algorithm;
 =09psta->ieee8021x_blocked =3D false;
 =09spin_lock_irqsave(&pmlmepriv->lock, irqL);
 =09if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
@@ -1165,7 +1165,7 @@ int r8712_set_key(struct _adapter *adapter,
 =09=09=09 (u8)psecuritypriv->XGrpPrivacy;
 =09} else { /* WEP */
 =09=09psetkeyparm->algorithm =3D
-=09=09=09 (u8)psecuritypriv->PrivacyAlgrthm;
+=09=09=09 (u8)psecuritypriv->privacy_algorithm;
 =09}
 =09psetkeyparm->keyid =3D (u8)keyid;
=20
@@ -1542,7 +1542,7 @@ void r8712_update_registrypriv_dev_network(struct _ad=
apter *adapter)
 =09struct security_priv=09*psecuritypriv =3D &adapter->securitypriv;
 =09struct wlan_network=09*cur_network =3D &adapter->mlmepriv.cur_network;
=20
-=09pdev_network->Privacy =3D cpu_to_le32(psecuritypriv->PrivacyAlgrthm
+=09pdev_network->Privacy =3D cpu_to_le32(psecuritypriv->privacy_algorithm
 =09=09=09=09=09    > 0 ? 1 : 0); /* adhoc no 802.1x */
 =09pdev_network->Rssi =3D 0;
 =09switch (pregistrypriv->wireless_mode) {
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/r=
tl8712/rtl871x_security.h
index b498ce4ddd34..5727a84838d3 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -80,7 +80,7 @@ struct security_priv {
 =09u32 auth_algorithm;=09=09/* 802.11 auth, could be open, shared,
 =09=09=09=09=09 * 8021x and authswitch
 =09=09=09=09=09 */
-=09u32 PrivacyAlgrthm;=09=09/* This specify the privacy for shared
+=09u32 privacy_algorithm;=09=09/* This specify the privacy for shared
 =09=09=09=09=09 * auth. algorithm.
 =09=09=09=09=09 */
 =09u32 PrivacyKeyIndex;=09=09/* this is only valid for legendary
@@ -143,7 +143,7 @@ do { \
 =09case 0: \
 =09case 1: \
 =09case 3: \
-=09=09encry_algo =3D (u8)psecuritypriv->PrivacyAlgrthm; \
+=09=09encry_algo =3D (u8)psecuritypriv->privacy_algorithm; \
 =09=09break; \
 =09case 2: \
 =09=09if (bmcst) \
--=20
2.34.1



