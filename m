Return-Path: <linux-kernel+bounces-333772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4197CDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F402B282386
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779141CD2C;
	Thu, 19 Sep 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="MFuDDXFV"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76622638
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772117; cv=none; b=aIy6IZOpvss583DkYKK5EpN5hsYigxxVf4hPVdQSMV7aW8Bdj574WkFHafnQjKe55Dk8FvBEJ8BOCWAAw11h56ixh9tCgeajdAujNhwh5GpxQlr/QXLw/sEe/wWXiCpFnx7BtVz+/AecfIRH6kSkhWymPpVzH8lgNC6XSWjn6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772117; c=relaxed/simple;
	bh=mwV/Dh+6ndOh1bKE6ZVxlm9TBVnwtPJmuipDF3PAmXI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cNGBvL40sUy70BMvNvdhBX3cVgfm8sSYnOZpUPE4JUSvHAQi33McHcIPa5a2j8C7PaqJp4GKXX9PzFmRcLB2s9Z0sN+ZOorg6n519t1G999caPTuytavHjhoHHOA7gDDZngvK6/J1IJ6QMb7Ha9+WjsXlAaMCn4H8adxUhL+Qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=MFuDDXFV; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726772104; x=1727031304;
	bh=vCdptPGsbI2RGOnRhJy5HnUwZymikqcUgdOGNq4W8Ic=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MFuDDXFVYYaspVTxdXAHTiuqbAiAfZgJBVeaCGK9bi1I2pgHoMN1vycjikWUrWPpe
	 xc/xUeCSO7rYLkZqWlhwacIGbC/5arnBhv8k3DNZwZuYTbVdZ28+N8FmxsfSgqjFqA
	 EsjVextfP6iPaN3S12EU9A6L3ULtnw3WesNIlz5YZ1fkmw6W4CU3h5XI5cvtDfbMjx
	 sZffgjCwPN26m4CsxWbe0ZZKECLczCi/FjxY/sjGiMlRX5ZZVz7QNdUJJsdpaVllA0
	 cboDbsFLMZI1HcwQO3b+XGWClBcdcGAHdxo5qIrzrQEA5YpRmgVi7ah16wwSlNR2t0
	 KRUu7/VCaVfNQ==
Date: Thu, 19 Sep 2024 18:55:00 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] staging: rtl8192e: Fix alignment to open parentheses
Message-ID: <20240919185445.119969-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: be627dd3b3e95feeff6afe9fad91854f5d792a7a
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
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  9 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 ++--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 11 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 30 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 10 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 26 +++---
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 20 ++--
 drivers/staging/rtl8192e/rtllib.h             | 30 +++---
 drivers/staging/rtl8192e/rtllib_rx.c          | 91 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 53 +++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 60 ++++++------
 drivers/staging/rtl8192e/rtllib_wx.c          |  3 +-
 13 files changed, 172 insertions(+), 193 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/s=
taging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 7061f1cf4d3a..d909f5c4fd21 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -101,12 +101,9 @@ bool rtl92e_config_rf(struct net_device *dev)
 =09=09RF3_Final_Value =3D 0;
 =09=09while (RF3_Final_Value !=3D RegValueToBeCheck &&
 =09=09       RetryTimes !=3D 0) {
-=09=09=09ret =3D rtl92e_config_rf_path(dev,
-=09=09=09=09=09=09(enum rf90_radio_path)eRFPath);
-=09=09=09RF3_Final_Value =3D rtl92e_get_rf_reg(dev,
-=09=09=09=09=09=09(enum rf90_radio_path)eRFPath,
-=09=09=09=09=09=09RegOffSetToBeCheck,
-=09=09=09=09=09=09bMask12Bits);
+=09=09=09ret =3D rtl92e_config_rf_path(dev, (enum rf90_radio_path)eRFPath)=
;
+=09=09=09RF3_Final_Value =3D rtl92e_get_rf_reg(dev, (enum rf90_radio_path)=
eRFPath,
+=09=09=09=09=09=09=09    RegOffSetToBeCheck, bMask12Bits);
 =09=09=09RetryTimes--;
 =09=09}
=20
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_dev.c
index 2672b1ddf88e..cf1231fe5319 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -321,8 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device =
*dev)
=20
 =09=09if (priv->epromtype =3D=3D EEPROM_93C46) {
 =09=09=09if (!priv->autoload_fail_flag) {
-=09=09=09=09usValue =3D rtl92e_eeprom_read(dev,
-=09=09=09=09=09  EEPROM_TxPwDiff_CrystalCap >> 1);
+=09=09=09=09usValue =3D rtl92e_eeprom_read(dev, EEPROM_TxPwDiff_CrystalCap=
 >> 1);
 =09=09=09=09priv->eeprom_ant_pwr_diff =3D usValue & 0x0fff;
 =09=09=09=09priv->eeprom_crystal_cap =3D (usValue & 0xf000)
 =09=09=09=09=09=09=09 >> 12;
@@ -335,8 +334,9 @@ static void _rtl92e_read_eeprom_info(struct net_device =
*dev)
=20
 =09=09=09for (i =3D 0; i < 14; i +=3D 2) {
 =09=09=09=09if (!priv->autoload_fail_flag)
-=09=09=09=09=09usValue =3D rtl92e_eeprom_read(dev,
-=09=09=09=09=09=09  (EEPROM_TxPwIndex_CCK + i) >> 1);
+=09=09=09=09=09usValue =3D
+=09=09=09=09=09=09rtl92e_eeprom_read(dev,
+=09=09=09=09=09=09=09=09   (EEPROM_TxPwIndex_CCK + i) >> 1);
 =09=09=09=09else
 =09=09=09=09=09usValue =3D EEPROM_Default_TxPower;
 =09=09=09=09*((u16 *)(&priv->eeprom_tx_pwr_level_cck[i])) =3D
@@ -345,7 +345,8 @@ static void _rtl92e_read_eeprom_info(struct net_device =
*dev)
 =09=09=09for (i =3D 0; i < 14; i +=3D 2) {
 =09=09=09=09if (!priv->autoload_fail_flag)
 =09=09=09=09=09usValue =3D rtl92e_eeprom_read(dev,
-=09=09=09=09=09=09(EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
+=09=09=09=09=09=09=09=09     (EEPROM_TxPwIndex_OFDM_24G + i)
+=09=09=09=09=09=09=09=09     >> 1);
 =09=09=09=09else
 =09=09=09=09=09usValue =3D EEPROM_Default_TxPower;
 =09=09=09=09*((u16 *)(&priv->eeprom_tx_pwr_level_ofdm24g[i]))
@@ -1325,8 +1326,8 @@ static void _rtl92e_query_rxphystatus(struct r8192_pr=
iv *priv,
 =09} else {
 =09=09if (rf_rx_num !=3D 0)
 =09=09=09pstats->signal_strength =3D precord_stats->signal_strength =3D
-=09=09=09=09=09 _rtl92e_signal_scale_mapping(priv,
-=09=09=09=09=09 (long)(total_rssi /=3D rf_rx_num));
+=09=09=09=09=09 _rtl92e_signal_scale_mapping(priv, (long)
+=09=09=09=09=09=09=09=09      (total_rssi /=3D rf_rx_num));
 =09}
 }
=20
@@ -1737,7 +1738,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 =09    ieee->ht_info->cur_short_gi_40mhz)
 =09=09ratr_value |=3D 0x80000000;
 =09else if (!ieee->ht_info->cur_tx_bw40mhz &&
-=09=09  ieee->ht_info->cur_short_gi_20mhz)
+=09=09 ieee->ht_info->cur_short_gi_20mhz)
 =09=09ratr_value |=3D 0x80000000;
 =09rtl92e_writel(dev, RATR0 + rate_index * 4, ratr_value);
 =09rtl92e_writeb(dev, UFWP, 1);
@@ -1898,8 +1899,7 @@ bool rtl92e_get_nmode_support_by_sec(struct net_devic=
e *dev)
 =09struct rtllib_device *ieee =3D priv->rtllib;
=20
 =09if (ieee->rtllib_ap_sec_type &&
-=09   (ieee->rtllib_ap_sec_type(priv->rtllib) & (SEC_ALG_WEP |
-=09=09=09=09     SEC_ALG_TKIP))) {
+=09    (ieee->rtllib_ap_sec_type(priv->rtllib) & (SEC_ALG_WEP | SEC_ALG_TK=
IP))) {
 =09=09return false;
 =09} else {
 =09=09return true;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_phy.c
index fbe624e235df..b5f516c18b72 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -632,10 +632,9 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_d=
evice *dev, u8 channel,
 =09=09=09case cmd_id_rf_write_reg:
 =09=09=09=09for (eRFPath =3D 0; eRFPath <
 =09=09=09=09     priv->num_total_rf_path; eRFPath++)
-=09=09=09=09=09rtl92e_set_rf_reg(dev,
-=09=09=09=09=09=09 (enum rf90_radio_path)eRFPath,
-=09=09=09=09=09=09 CurrentCmd->para1, bMask12Bits,
-=09=09=09=09=09=09 CurrentCmd->para2 << 7);
+=09=09=09=09=09rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+=09=09=09=09=09=09=09  CurrentCmd->para1, bMask12Bits,
+=09=09=09=09=09=09=09  CurrentCmd->para2 << 7);
 =09=09=09=09break;
 =09=09=09default:
 =09=09=09=09break;
@@ -992,7 +991,7 @@ static bool _rtl92e_set_rf_power_state(struct net_devic=
e *dev,
 =09switch (rf_power_state) {
 =09case rf_on:
 =09=09if ((priv->rtllib->rf_power_state =3D=3D rf_off) &&
-=09=09     RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
+=09=09    RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
 =09=09=09bool rtstatus;
 =09=09=09u32 InitilizeCount =3D 3;
=20
@@ -1013,7 +1012,7 @@ static bool _rtl92e_set_rf_power_state(struct net_dev=
ice *dev,
 =09=09=09rtl92e_writeb(dev, ANAPAR, 0x37);
 =09=09=09mdelay(1);
 =09=09=09rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
-=09=09=09=09=09 0x4, 0x1);
+=09=09=09=09=09  0x4, 0x1);
 =09=09=09priv->hw_rf_off_action =3D 0;
 =09=09=09rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
 =09=09=09=09=09  BIT(4), 0x1);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging=
/rtl8192e/rtl8192e/rtl_core.c
index dc1301f1a0c1..82a1b19fa1b3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -253,7 +253,7 @@ static void _rtl92e_update_cap(struct net_device *dev, =
u16 cap)
 =09=09u8=09cur_slot_time =3D priv->slot_time;
=20
 =09=09if ((cap & WLAN_CAPABILITY_SHORT_SLOT_TIME) &&
-=09=09   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
+=09=09    (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
 =09=09=09if (cur_slot_time !=3D SHORT_SLOT_TIME) {
 =09=09=09=09slot_time_val =3D SHORT_SLOT_TIME;
 =09=09=09=09priv->rtllib->set_hw_reg_handler(dev,
@@ -326,9 +326,8 @@ static int _rtl92e_qos_handle_probe_response(struct r81=
92_priv *priv,
 =09=09=09network->qos_data.active =3D network->qos_data.supported;
=20
 =09=09if ((network->qos_data.active =3D=3D 1) && (active_network =3D=3D 1)=
 &&
-=09=09=09=09(network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
-=09=09=09=09(network->qos_data.old_param_count !=3D
-=09=09=09=09network->qos_data.param_count)) {
+=09=09    (network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
+=09=09    (network->qos_data.old_param_count !=3D network->qos_data.param_=
count)) {
 =09=09=09network->qos_data.old_param_count =3D
 =09=09=09=09network->qos_data.param_count;
 =09=09=09priv->rtllib->wmm_acm =3D network->qos_data.wmm_acm;
@@ -390,7 +389,7 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *pr=
iv,
 =09=09=09network->qos_data.param_count;
 =09} else {
 =09=09memcpy(&priv->rtllib->current_network.qos_data.parameters,
-=09=09&def_qos_parameters, size);
+=09=09       &def_qos_parameters, size);
 =09=09priv->rtllib->current_network.qos_data.active =3D 0;
 =09=09priv->rtllib->current_network.qos_data.supported =3D 0;
 =09=09set_qos_param =3D 1;
@@ -406,8 +405,8 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *pr=
iv,
 }
=20
 static int _rtl92e_handle_assoc_response(struct net_device *dev,
-=09=09=09=09 struct rtllib_assoc_response_frame *resp,
-=09=09=09=09 struct rtllib_network *network)
+=09=09=09=09=09 struct rtllib_assoc_response_frame *resp,
+=09=09=09=09=09 struct rtllib_network *network)
 {
 =09struct r8192_priv *priv =3D rtllib_priv(dev);
=20
@@ -819,7 +818,7 @@ static short _rtl92e_is_tx_queue_empty(struct net_devic=
e *dev)
 =09=09=09continue;
 =09=09if (skb_queue_len(&(&priv->tx_ring[i])->queue) > 0) {
 =09=09=09netdev_info(dev, "=3D=3D=3D>tx queue is not empty:%d, %d\n",
-=09=09=09       i, skb_queue_len(&(&priv->tx_ring[i])->queue));
+=09=09=09=09    i, skb_queue_len(&(&priv->tx_ring[i])->queue));
 =09=09=09return 0;
 =09=09}
 =09}
@@ -905,7 +904,7 @@ static void _rtl92e_if_check_reset(struct net_device *d=
ev)
 =09=09RxResetType =3D _rtl92e_rx_check_stuck(dev);
=20
 =09if (TxResetType =3D=3D RESET_TYPE_SILENT ||
-=09=09   RxResetType =3D=3D RESET_TYPE_SILENT) {
+=09    RxResetType =3D=3D RESET_TYPE_SILENT) {
 =09=09netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
 =09=09=09    __func__, TxResetType, RxResetType);
 =09}
@@ -970,7 +969,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 =09}
 =09if ((ieee->link_state =3D=3D MAC80211_LINKED) && (ieee->iw_mode =3D=3D =
IW_MODE_INFRA)) {
 =09=09if (ieee->link_detect_info.num_rx_ok_in_period > 100 ||
-=09=09ieee->link_detect_info.num_tx_ok_in_period > 100)
+=09=09    ieee->link_detect_info.num_tx_ok_in_period > 100)
 =09=09=09busy_traffic =3D true;
=20
 =09=09if (ieee->link_detect_info.num_rx_ok_in_period > 4000 ||
@@ -1030,8 +1029,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
=20
 =09=09=09ieee->link_state =3D RTLLIB_ASSOCIATING;
=20
-=09=09=09remove_peer_ts(priv->rtllib,
-=09=09=09=09     priv->rtllib->current_network.bssid);
+=09=09=09remove_peer_ts(priv->rtllib, priv->rtllib->current_network.bssid)=
;
 =09=09=09ieee->is_roaming =3D true;
 =09=09=09ieee->is_set_key =3D false;
 =09=09=09ieee->link_change(dev);
@@ -1170,7 +1168,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
=20
 =09if (queue_index !=3D TXCMD_QUEUE) {
 =09=09if ((priv->rtllib->rf_power_state =3D=3D rf_off) ||
-=09=09     !priv->up) {
+=09=09    !priv->up) {
 =09=09=09kfree_skb(skb);
 =09=09=09return 0;
 =09=09}
@@ -1571,7 +1569,7 @@ static void _rtl92e_tx_resume(struct net_device *dev)
 =09for (queue_index =3D BK_QUEUE;
 =09     queue_index < MAX_QUEUE_SIZE; queue_index++) {
 =09=09while ((!skb_queue_empty(&ieee->skb_waitq[queue_index])) &&
-=09=09(priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
+=09=09       (priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) =
{
 =09=09=09skb =3D skb_dequeue(&ieee->skb_waitq[queue_index]);
 =09=09=09ieee->softmac_data_hard_start_xmit(skb, dev, 0);
 =09=09}
@@ -1640,7 +1638,7 @@ static int _rtl92e_close(struct net_device *dev)
 =09int ret;
=20
 =09if ((rtllib_act_scanning(priv->rtllib, false)) &&
-=09=09!(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
+=09    !(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
 =09=09rtllib_stop_scan(priv->rtllib);
 =09}
=20
@@ -1952,7 +1950,7 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pd=
ev)
 =09=09if (dev->mem_start !=3D 0) {
 =09=09=09iounmap((void __iomem *)dev->mem_start);
 =09=09=09release_mem_region(pci_resource_start(pdev, 1),
-=09=09=09=09=09pci_resource_len(pdev, 1));
+=09=09=09=09=09   pci_resource_len(pdev, 1));
 =09=09}
=20
 =09=09free_rtllib(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/r=
tl8192e/rtl8192e/rtl_dm.c
index e9ca5a8768ad..207dc0e57315 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -540,11 +540,9 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi=
(struct net_device *dev)
=20
 =09=09=09for (k =3D 0; k < 5; k++) {
 =09=09=09=09if (k !=3D 4)
-=09=09=09=09=09tmp_report[k] =3D rtl92e_readb(dev,
-=09=09=09=09=09=09=09 Tssi_Report_Value1 + k);
+=09=09=09=09=09tmp_report[k] =3D rtl92e_readb(dev, Tssi_Report_Value1 + k)=
;
 =09=09=09=09else
-=09=09=09=09=09tmp_report[k] =3D rtl92e_readb(dev,
-=09=09=09=09=09=09=09 Tssi_Report_Value2);
+=09=09=09=09=09tmp_report[k] =3D rtl92e_readb(dev, Tssi_Report_Value2);
=20
 =09=09=09=09if (tmp_report[k] <=3D 20) {
 =09=09=09=09=09viviflag =3D true;
@@ -1765,8 +1763,8 @@ static void _rtl92e_dm_check_fsync(struct net_device =
*dev)
 =09=09=09=09   (REG_C38_TH + 5)) {
 =09=09=09=09if (reg_c38_State) {
 =09=09=09=09=09rtl92e_writeb(dev,
-=09=09=09=09=09=09rOFDM0_RxDetector3,
-=09=09=09=09=09=09priv->framesync);
+=09=09=09=09=09=09      rOFDM0_RxDetector3,
+=09=09=09=09=09=09      priv->framesync);
 =09=09=09=09=09reg_c38_State =3D RegC38_Default;
 =09=09=09=09}
 =09=09=09}
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
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rt=
l8192e/rtl819x_HTProc.c
index 9c9c0bc0cfde..ec43b5fda06e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -228,7 +228,7 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_i=
nfo)
 }
=20
 void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_h=
t_cap,
-=09=09=09=09  u8 *len, u8 is_encrypt, bool assoc)
+=09=09=09=09     u8 *len, u8 is_encrypt, bool assoc)
 {
 =09struct rt_hi_throughput *ht =3D ieee->ht_info;
 =09struct ht_capab_ele *cap_ele =3D NULL;
@@ -308,8 +308,7 @@ void ht_construct_capability_element(struct rtllib_devi=
ce *ieee, u8 *pos_ht_cap,
 =09}
 }
=20
-void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2=
RTAgg,
-=09=09=09=09u8 *len)
+void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2=
RTAgg, u8 *len)
 {
 =09if (!posRT2RTAgg) {
 =09=09netdev_warn(ieee->dev, "%s(): posRT2RTAgg is null\n", __func__);
@@ -357,8 +356,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, =
u8 *pOperateMCS)
 =09return true;
 }
=20
-u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
-=09=09       u8 *pMCSFilter)
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet, u8=
 *pMCSFilter)
 {
 =09u8=09=09i, j;
 =09u8=09=09bitMap;
@@ -398,7 +396,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, =
u8 *pMCSRateSet,
 }
=20
 static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
-=09=09=09  u8 *pOperateMCS)
+=09=09=09     u8 *pOperateMCS)
 {
 =09u8 i;
=20
@@ -418,8 +416,8 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *ieee=
, u8 *pSupportMCS,
 }
=20
 void ht_set_connect_bw_mode(struct rtllib_device *ieee,
-=09=09=09enum ht_channel_width bandwidth,
-=09=09=09enum ht_extchnl_offset Offset);
+=09=09=09    enum ht_channel_width bandwidth,
+=09=09=09    enum ht_extchnl_offset Offset);
=20
 void ht_on_assoc_rsp(struct rtllib_device *ieee)
 {
@@ -453,7 +451,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 =09=09=09     pPeerHTCap, sizeof(struct ht_capab_ele));
 #endif
 =09ht_set_connect_bw_mode(ieee, (enum ht_channel_width)(pPeerHTCap->chl_wi=
dth),
-=09=09=09   (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
+=09=09=09       (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
 =09ht_info->cur_tx_bw40mhz =3D ((pPeerHTInfo->RecommemdedTxWidth =3D=3D 1)=
 ?
 =09=09=09=09 true : false);
=20
@@ -494,8 +492,8 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
=20
 =09pMcsFilter =3D MCS_FILTER_ALL;
 =09ieee->HTHighestOperaRate =3D ht_get_highest_mcs_rate(ieee,
-=09=09=09=09=09=09       ieee->dot11ht_oper_rate_set,
-=09=09=09=09=09=09       pMcsFilter);
+=09=09=09=09=09=09=09   ieee->dot11ht_oper_rate_set,
+=09=09=09=09=09=09=09   pMcsFilter);
 =09ieee->ht_curr_op_rate =3D ieee->HTHighestOperaRate;
=20
 =09ht_info->current_op_mode =3D pPeerHTInfo->opt_mode;
@@ -559,7 +557,7 @@ void ht_initialize_bss_desc(struct bss_ht *bss_ht)
 }
=20
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
-=09=09=09=09   struct rtllib_network *network)
+=09=09=09=09=09 struct rtllib_network *network)
 {
 =09struct rt_hi_throughput *ht_info =3D ieee->ht_info;
 =09u8=09bIOTAction =3D 0;
@@ -661,8 +659,8 @@ static void ht_set_connect_bw_mode_callback(struct rtll=
ib_device *ieee)
 }
=20
 void ht_set_connect_bw_mode(struct rtllib_device *ieee,
-=09=09=09enum ht_channel_width bandwidth,
-=09=09=09enum ht_extchnl_offset Offset)
+=09=09=09    enum ht_channel_width bandwidth,
+=09=09=09    enum ht_extchnl_offset Offset)
 {
 =09struct rt_hi_throughput *ht_info =3D ieee->ht_info;
=20
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rt=
l8192e/rtl819x_TSProc.c
index 89092cd434de..3e04da7468b0 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -25,7 +25,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 =09=09while (!list_empty(&ts->rx_pending_pkt_list)) {
 =09=09=09reorder_entry =3D (struct rx_reorder_entry *)
 =09=09=09=09=09list_entry(ts->rx_pending_pkt_list.prev,
-=09=09=09=09=09struct rx_reorder_entry, list);
+=09=09=09=09=09=09   struct rx_reorder_entry, list);
 =09=09=09if (index =3D=3D 0)
 =09=09=09=09ts->rx_indicate_seq =3D reorder_entry->seq_num;
=20
@@ -36,7 +36,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 =09=09=09=09list_del_init(&reorder_entry->list);
=20
 =09=09=09=09if (SN_EQUAL(reorder_entry->seq_num,
-=09=09=09=09    ts->rx_indicate_seq))
+=09=09=09=09=09     ts->rx_indicate_seq))
 =09=09=09=09=09ts->rx_indicate_seq =3D
 =09=09=09=09=09      (ts->rx_indicate_seq + 1) % 4096;
=20
@@ -139,7 +139,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
=20
 =09=09ResetTxTsEntry(pTxTS);
 =09=09list_add_tail(&pTxTS->ts_common_info.list,
-=09=09=09=09&ieee->Tx_TS_Unused_List);
+=09=09=09      &ieee->Tx_TS_Unused_List);
 =09=09pTxTS++;
 =09}
=20
@@ -221,11 +221,11 @@ static void MakeTSEntry(struct ts_common_info *ts_com=
mon_info, u8 *addr,
=20
 =09if (pTSPEC)
 =09=09memcpy((u8 *)(&(ts_common_info->tspec)), (u8 *)pTSPEC,
-=09=09=09sizeof(struct qos_tsinfo));
+=09=09       sizeof(struct qos_tsinfo));
 }
=20
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppT=
S,
-=09   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool add_new_ts)
+=09=09   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool add_new_ts)
 {
 =09u8=09UP =3D 0;
 =09struct qos_tsinfo tspec;
@@ -291,14 +291,14 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct=
 ts_common_info **ppTS,
 =09=09if (tx_rx_select =3D=3D TX_DIR) {
 =09=09=09struct tx_ts_record *tmp =3D
 =09=09=09=09container_of(*ppTS,
-=09=09=09=09struct tx_ts_record,
-=09=09=09=09ts_common_info);
+=09=09=09=09=09     struct tx_ts_record,
+=09=09=09=09=09     ts_common_info);
 =09=09=09ResetTxTsEntry(tmp);
 =09=09} else {
 =09=09=09struct rx_ts_record *ts =3D
 =09=09=09=09 container_of(*ppTS,
-=09=09=09=09 struct rx_ts_record,
-=09=09=09=09 ts_common_info);
+=09=09=09=09=09      struct rx_ts_record,
+=09=09=09=09=09      ts_common_info);
 =09=09=09ResetRxTsEntry(ts);
 =09=09}
=20
@@ -335,7 +335,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 =09=09while (!list_empty(&ts->rx_pending_pkt_list)) {
 =09=09=09pRxReorderEntry =3D (struct rx_reorder_entry *)
 =09=09=09=09=09list_entry(ts->rx_pending_pkt_list.prev,
-=09=09=09=09=09struct rx_reorder_entry, list);
+=09=09=09=09=09=09   struct rx_reorder_entry, list);
 =09=09=09netdev_dbg(ieee->dev,  "%s(): Delete seq_num %d!\n",
 =09=09=09=09   __func__, pRxReorderEntry->seq_num);
 =09=09=09list_del_init(&pRxReorderEntry->list);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/r=
tllib.h
index d6615f787d53..ca87aa9f374e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -795,8 +795,9 @@ static inline u8 frame_qos_tid(u8 *buf)
=20
 =09hdr =3D (struct ieee80211_hdr_3addr *)buf;
 =09fc =3D le16_to_cpu(hdr->frame_control);
-=09return (u8)((union frameqos *)(buf + (((fc & IEEE80211_FCTL_TODS) &&
-=09=09    (fc & IEEE80211_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
+=09return (u8)((union frameqos *)
+=09=09(buf + (((fc & IEEE80211_FCTL_TODS) &&
+=09=09=09 (fc & IEEE80211_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
 }
=20
 struct eapol {
@@ -1416,7 +1417,7 @@ struct rtllib_device {
 =09 * This function can't sleep.
 =09 */
 =09int (*softmac_hard_start_xmit)(struct sk_buff *skb,
-=09=09=09       struct net_device *dev);
+=09=09=09=09       struct net_device *dev);
=20
 =09/* used instead of hard_start_xmit (not softmac_hard_start_xmit)
 =09 * if the IEEE_SOFTMAC_TX_QUEUE feature is used to TX data
@@ -1425,7 +1426,7 @@ struct rtllib_device {
 =09 * This function can't sleep.
 =09 */
 =09void (*softmac_data_hard_start_xmit)(struct sk_buff *skb,
-=09=09=09       struct net_device *dev, int rate);
+=09=09=09=09=09     struct net_device *dev, int rate);
=20
 =09/* ask to the driver to retune the radio.
 =09 * This function can sleep. the driver should ensure
@@ -1461,8 +1462,7 @@ struct rtllib_device {
 =09bool (*get_half_nmode_support_by_aps_handler)(struct net_device *dev);
 =09u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 =09void (*init_gain_handler)(struct net_device *dev, u8 operation);
-=09void (*scan_operation_backup_handler)(struct net_device *dev,
-=09=09=09=09=09   u8 operation);
+=09void (*scan_operation_backup_handler)(struct net_device *dev, u8 operat=
ion);
 =09void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val=
);
=20
 =09void (*allow_all_dest_addr_handler)(struct net_device *dev,
@@ -1721,23 +1721,23 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, s=
truct iw_request_info *info,
 #define MAX_RECEIVE_BUFFER_SIZE 9100
=20
 void ht_set_connect_bw_mode(struct rtllib_device *ieee,
-=09=09=09enum ht_channel_width bandwidth,
-=09=09=09enum ht_extchnl_offset Offset);
+=09=09=09    enum ht_channel_width bandwidth,
+=09=09=09    enum ht_extchnl_offset Offset);
 void ht_update_default_setting(struct rtllib_device *ieee);
 void ht_construct_capability_element(struct rtllib_device *ieee,
-=09=09=09=09  u8 *pos_ht_cap, u8 *len,
-=09=09=09=09  u8 is_encrypt, bool assoc);
+=09=09=09=09     u8 *pos_ht_cap, u8 *len,
+=09=09=09=09     u8 is_encrypt, bool assoc);
 void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
-=09=09=09=09u8 *posRT2RTAgg, u8 *len);
+=09=09=09=09    u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
 void ht_initialize_bss_desc(struct bss_ht *bss_ht);
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
-=09=09=09=09   struct rtllib_network *network);
+=09=09=09=09=09 struct rtllib_network *network);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 =09=09=09=09     struct rtllib_network *network);
 u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
-=09=09       u8 *pMCSFilter);
+=09=09=09   u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
@@ -1757,10 +1757,10 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *=
t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppT=
S, u8 *addr,
-=09   u8 TID, enum tr_select tx_rx_select, bool add_new_ts);
+=09=09   u8 TID, enum tr_select tx_rx_select, bool add_new_ts);
 void rtllib_ts_init(struct rtllib_device *ieee);
 void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee,
-=09=09=09 struct tx_ts_record *pTxTS);
+=09=09=09=09    struct tx_ts_record *pTxTS);
 void remove_peer_ts(struct rtllib_device *ieee, u8 *addr);
 void remove_all_ts(struct rtllib_device *ieee);
=20
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192=
e/rtllib_rx.c
index 8fe224a83dd6..5f437c227ecc 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -409,12 +409,10 @@ static bool add_reorder_entry(struct rx_ts_record *ts=
,
=20
 =09while (list->next !=3D &ts->rx_pending_pkt_list) {
 =09=09if (SN_LESS(reorder_entry->seq_num, ((struct rx_reorder_entry *)
-=09=09    list_entry(list->next, struct rx_reorder_entry,
-=09=09    list))->seq_num))
+=09=09    list_entry(list->next, struct rx_reorder_entry, list))->seq_num)=
)
 =09=09=09list =3D list->next;
-=09=09else if (SN_EQUAL(reorder_entry->seq_num,
-=09=09=09((struct rx_reorder_entry *)list_entry(list->next,
-=09=09=09struct rx_reorder_entry, list))->seq_num))
+=09=09else if (SN_EQUAL(reorder_entry->seq_num, ((struct rx_reorder_entry =
*)
+=09=09=09 list_entry(list->next, struct rx_reorder_entry, list))->seq_num)=
)
 =09=09=09return false;
 =09=09else
 =09=09=09break;
@@ -600,7 +598,7 @@ static void rx_reorder_indicate_packet(struct rtllib_de=
vice *ieee,
 =09=09if (!list_empty(&ieee->RxReorder_Unused_List)) {
 =09=09=09reorder_entry =3D (struct rx_reorder_entry *)
 =09=09=09=09=09list_entry(ieee->RxReorder_Unused_List.next,
-=09=09=09=09=09struct rx_reorder_entry, list);
+=09=09=09=09=09=09   struct rx_reorder_entry, list);
 =09=09=09list_del_init(&reorder_entry->list);
=20
 =09=09=09/* Make a reorder entry and insert
@@ -736,7 +734,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, st=
ruct sk_buff *skb,
 =09/* just for debug purpose */
 =09seq_num =3D WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
 =09if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
-=09   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved)=
)
+=09    (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved=
))
 =09=09is_aggregate_frame =3D true;
=20
 =09if (RTLLIB_QOS_HAS_SEQ(fc))
@@ -876,9 +874,9 @@ static int rtllib_rx_check_duplicate(struct rtllib_devi=
ce *ieee,
 =09frag =3D WLAN_GET_SEQ_FRAG(sc);
=20
 =09if (!ieee->ht_info->cur_rx_reorder_enable ||
-=09=09!ieee->current_network.qos_data.active ||
-=09=09!is_data_frame(skb->data) ||
-=09=09is_legacy_data_frame(skb->data)) {
+=09    !ieee->current_network.qos_data.active ||
+=09    !is_data_frame(skb->data) ||
+=09    is_legacy_data_frame(skb->data)) {
 =09=09if (!ieee80211_is_beacon(hdr->frame_control)) {
 =09=09=09if (is_duplicate_packet(ieee, hdr))
 =09=09=09=09return -1;
@@ -887,7 +885,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_devi=
ce *ieee,
 =09=09struct rx_ts_record *ts =3D NULL;
=20
 =09=09if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
-=09=09=09(u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
+=09=09=09=09  (u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
 =09=09=09if ((fc & (1 << 11)) && (frag =3D=3D ts->rx_last_frag_num) &&
 =09=09=09    (WLAN_GET_SEQ_SEQ(sc) =3D=3D ts->rx_last_seq_num))
 =09=09=09=09return -1;
@@ -976,7 +974,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *=
ieee, struct ieee80211_hd
 }
=20
 static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff =
*skb,
-=09=09=09struct lib80211_crypt_data **crypt, size_t hdrlen)
+=09=09=09       struct lib80211_crypt_data **crypt, size_t hdrlen)
 {
 =09struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 =09u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1008,8 +1006,8 @@ static int rtllib_rx_get_crypt(struct rtllib_device *=
ieee, struct sk_buff *skb,
 }
=20
 static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *s=
kb,
-=09=09      struct rtllib_rx_stats *rx_stats,
-=09=09      struct lib80211_crypt_data *crypt, size_t hdrlen)
+=09=09=09     struct rtllib_rx_stats *rx_stats,
+=09=09=09     struct lib80211_crypt_data *crypt, size_t hdrlen)
 {
 =09struct ieee80211_hdr *hdr;
 =09int keyidx =3D 0;
@@ -1092,7 +1090,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ie=
ee, struct sk_buff *skb,
 =09 * encrypted/authenticated
 =09 */
 =09if ((fc & IEEE80211_FCTL_PROTECTED) &&
-=09=09rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
+=09    rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 =09=09netdev_info(ieee->dev, "%s: =3D=3D>decrypt msdu error\n", __func__);
 =09=09return -1;
 =09}
@@ -1152,10 +1150,10 @@ static void rtllib_rx_check_leave_lps(struct rtllib=
_device *ieee, u8 unicast,
 }
=20
 static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
-=09=09struct rtllib_rx_stats *rx_stats,
-=09=09struct rtllib_rxb *rxb,
-=09=09u8 *dst,
-=09=09u8 *src)
+=09=09=09=09=09  struct rtllib_rx_stats *rx_stats,
+=09=09=09=09=09  struct rtllib_rxb *rxb,
+=09=09=09=09=09  u8 *dst,
+=09=09=09=09=09  u8 *src)
 {
 =09struct net_device *dev =3D ieee->dev;
 =09u16 ethertype;
@@ -1175,9 +1173,9 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtll=
ib_device *ieee,
 =09=09=09 */
 =09=09=09ethertype =3D (sub_skb->data[6] << 8) | sub_skb->data[7];
 =09=09=09if (sub_skb->len >=3D 8 &&
-=09=09=09=09((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
-=09=09=09=09ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
-=09=09=09=09memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D =
0)) {
+=09=09=09    ((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &=
&
+=09=09=09    ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
+=09=09=09    memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D=
 0)) {
 =09=09=09=09/* remove RFC1042 or Bridge-Tunnel encapsulation
 =09=09=09=09 * and replace EtherType
 =09=09=09=09 */
@@ -1220,7 +1218,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtll=
ib_device *ieee,
 }
=20
 static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buf=
f *skb,
-=09=09 struct rtllib_rx_stats *rx_stats)
+=09=09=09=09 struct rtllib_rx_stats *rx_stats)
 {
 =09struct net_device *dev =3D ieee->dev;
 =09struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
@@ -1322,8 +1320,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device=
 *ieee, struct sk_buff *skb
 =09=09&& !is_multicast_ether_addr(hdr->addr1)) {
 =09=09TID =3D frame_qos_tid(skb->data);
 =09=09seq_num =3D WLAN_GET_SEQ_SEQ(sc);
-=09=09rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
-=09=09      RX_DIR, true);
+=09=09rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID, =
RX_DIR, true);
 =09=09if (TID !=3D 0 && TID !=3D 3)
 =09=09=09ieee->bis_any_nonbepkts =3D true;
 =09}
@@ -1380,7 +1377,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device=
 *ieee, struct sk_buff *skb
 }
=20
 static int rtllib_rx_monitor(struct rtllib_device *ieee, struct sk_buff *s=
kb,
-=09=09 struct rtllib_rx_stats *rx_stats)
+=09=09=09     struct rtllib_rx_stats *rx_stats)
 {
 =09struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 =09u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1412,7 +1409,7 @@ static int rtllib_rx_monitor(struct rtllib_device *ie=
ee, struct sk_buff *skb,
  * This function is called only as a tasklet (software IRQ).
  */
 int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
-=09=09 struct rtllib_rx_stats *rx_stats)
+=09      struct rtllib_rx_stats *rx_stats)
 {
 =09int ret =3D 0;
=20
@@ -1576,11 +1573,9 @@ static int rtllib_parse_qos_info_param_IE(struct rtl=
lib_device *ieee,
 =09} else {
 =09=09struct rtllib_qos_parameter_info param_element;
=20
-=09=09rc =3D rtllib_read_qos_param_element(&param_element,
-=09=09=09=09=09=09      info_element);
+=09=09rc =3D rtllib_read_qos_param_element(&param_element, info_element);
 =09=09if (rc =3D=3D 0) {
-=09=09=09rtllib_qos_convert_ac_to_parameters(&param_element,
-=09=09=09=09=09=09=09       &(network->qos_data));
+=09=09=09rtllib_qos_convert_ac_to_parameters(&param_element, &(network->qo=
s_data));
 =09=09=09network->flags |=3D NETWORK_HAS_QOS_PARAMETERS;
 =09=09=09network->qos_data.param_count =3D
 =09=09=09    param_element.info_element.ac_info & 0x0F;
@@ -1693,8 +1688,9 @@ static void rtllib_parse_mife_generic(struct rtllib_d=
evice *ieee,
 =09=09=09=09=09       MAX_IE_LEN);
 =09=09=09if (*tmp_htcap_len !=3D 0) {
 =09=09=09=09network->bssht.bd_ht_spec_ver =3D HT_SPEC_VER_EWC;
-=09=09=09=09network->bssht.bd_ht_cap_len =3D min_t(u16, *tmp_htcap_len,
-=09=09=09=09=09=09=09=09  sizeof(network->bssht.bd_ht_cap_buf));
+=09=09=09=09network->bssht.bd_ht_cap_len =3D
+=09=09=09=09=09min_t(u16, *tmp_htcap_len,
+=09=09=09=09=09      sizeof(network->bssht.bd_ht_cap_buf));
 =09=09=09=09memcpy(network->bssht.bd_ht_cap_buf,
 =09=09=09=09       info_element->data,
 =09=09=09=09       network->bssht.bd_ht_cap_len);
@@ -1864,7 +1860,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_in=
fo_element *info_element,
 =09if (*tmp_htcap_len !=3D 0) {
 =09=09ht->bd_ht_spec_ver =3D HT_SPEC_VER_EWC;
 =09=09ht->bd_ht_cap_len =3D min_t(u16, *tmp_htcap_len,
-=09=09=09=09       sizeof(ht->bd_ht_cap_buf));
+=09=09=09=09=09  sizeof(ht->bd_ht_cap_buf));
 =09=09memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bd_ht_cap_len);
=20
 =09=09ht->bd_support_ht =3D true;
@@ -1882,10 +1878,10 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_=
info_element *info_element,
 }
=20
 int rtllib_parse_info_param(struct rtllib_device *ieee,
-=09=09struct rtllib_info_element *info_element,
-=09=09u16 length,
-=09=09struct rtllib_network *network,
-=09=09struct rtllib_rx_stats *stats)
+=09=09=09    struct rtllib_info_element *info_element,
+=09=09=09    u16 length,
+=09=09=09    struct rtllib_network *network,
+=09=09=09    struct rtllib_rx_stats *stats)
 {
 =09u8 i;
 =09short offset;
@@ -2329,9 +2325,9 @@ static inline void update_network(struct rtllib_devic=
e *ieee,
=20
 =09dst->wmm_info =3D src->wmm_info;
 =09if (src->wmm_param[0].ac_aci_acm_aifsn ||
-=09   src->wmm_param[1].ac_aci_acm_aifsn ||
-=09   src->wmm_param[2].ac_aci_acm_aifsn ||
-=09   src->wmm_param[3].ac_aci_acm_aifsn)
+=09    src->wmm_param[1].ac_aci_acm_aifsn ||
+=09    src->wmm_param[2].ac_aci_acm_aifsn ||
+=09    src->wmm_param[3].ac_aci_acm_aifsn)
 =09=09memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
=20
 =09dst->signal_strength =3D src->signal_strength;
@@ -2449,8 +2445,7 @@ static inline void rtllib_process_probe_response(
 =09 */
=20
 =09spin_lock_irqsave(&ieee->lock, flags);
-=09if (is_same_network(&ieee->current_network, network,
-=09   (network->ssid_len ? 1 : 0))) {
+=09if (is_same_network(&ieee->current_network, network, (network->ssid_len=
 ? 1 : 0))) {
 =09=09update_network(ieee, &ieee->current_network, network);
 =09=09if ((ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G ||
 =09=09     ieee->current_network.mode =3D=3D WIRELESS_MODE_G) &&
@@ -2466,8 +2461,7 @@ static inline void rtllib_process_probe_response(
 =09=09}
 =09}
 =09list_for_each_entry(target, &ieee->network_list, list) {
-=09=09if (is_same_network(target, network,
-=09=09   (target->ssid_len ? 1 : 0)))
+=09=09if (is_same_network(target, network, (target->ssid_len ? 1 : 0)))
 =09=09=09break;
 =09=09if (!oldest || (target->last_scanned < oldest->last_scanned))
 =09=09=09oldest =3D target;
@@ -2527,8 +2521,7 @@ static inline void rtllib_process_probe_response(
=20
 =09spin_unlock_irqrestore(&ieee->lock, flags);
 =09if (ieee80211_is_beacon(frame_ctl) &&
-=09    is_same_network(&ieee->current_network, network,
-=09    (network->ssid_len ? 1 : 0)) &&
+=09    is_same_network(&ieee->current_network, network, (network->ssid_len=
 ? 1 : 0)) &&
 =09    (ieee->link_state =3D=3D MAC80211_LINKED)) {
 =09=09ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 =09}
@@ -2553,8 +2546,8 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 =09=09=09=09stats);
=20
 =09=09if (ieee->sta_sleep || (ieee->ps !=3D RTLLIB_PS_DISABLED &&
-=09=09    ieee->iw_mode =3D=3D IW_MODE_INFRA &&
-=09=09    ieee->link_state =3D=3D MAC80211_LINKED))
+=09=09=09=09=09ieee->iw_mode =3D=3D IW_MODE_INFRA &&
+=09=09=09=09=09ieee->link_state =3D=3D MAC80211_LINKED))
 =09=09=09schedule_work(&ieee->ps_task);
 =09} else if (ieee80211_is_probe_resp(header->frame_control)) {
 =09=09netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rt=
l8192e/rtllib_softmac.c
index 0fc97c868f81..326b4c422be9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -244,8 +244,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, stru=
ct rtllib_device *ieee)
 =09=09=09 * to check it any more.
 =09=09=09 */
 =09=09=09netdev_info(ieee->dev,
-=09=09=09       "%s():insert to waitqueue, queue_index:%d!\n",
-=09=09=09       __func__, tcb_desc->queue_index);
+=09=09=09=09    "%s():insert to waitqueue, queue_index:%d!\n",
+=09=09=09=09    __func__, tcb_desc->queue_index);
 =09=09=09skb_queue_tail(&ieee->skb_waitq[tcb_desc->queue_index],
 =09=09=09=09       skb);
 =09=09} else {
@@ -348,8 +348,7 @@ static inline struct sk_buff *rtllib_probe_req(struct r=
tllib_device *ieee)
 }
=20
 /* Enables network monitor mode, all rx packets will be received. */
-void rtllib_enable_net_monitor_mode(struct net_device *dev,
-=09=09bool init_state)
+void rtllib_enable_net_monitor_mode(struct net_device *dev, bool init_stat=
e)
 {
 =09struct rtllib_device *ieee =3D netdev_priv_rsl(dev);
=20
@@ -719,8 +718,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 =09else
 =09=09encrypt =3D 0;
=20
-=09if ((ieee->rtllib_ap_sec_type &&
-=09    (ieee->rtllib_ap_sec_type(ieee) & SEC_ALG_TKIP)) ||
+=09if ((ieee->rtllib_ap_sec_type && (ieee->rtllib_ap_sec_type(ieee) & SEC_=
ALG_TKIP)) ||
 =09    ieee->forced_bg_mode) {
 =09=09ieee->ht_info->enable_ht =3D 0;
 =09=09ieee->mode =3D WIRELESS_MODE_G;
@@ -730,13 +728,13 @@ rtllib_association_req(struct rtllib_network *beacon,
 =09=09ht_cap_buf =3D (u8 *)&ieee->ht_info->self_ht_cap;
 =09=09ht_cap_len =3D sizeof(ieee->ht_info->self_ht_cap);
 =09=09ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
-=09=09=09=09=09     encrypt, true);
+=09=09=09=09=09=09encrypt, true);
 =09=09if (ieee->ht_info->current_rt2rt_aggregation) {
 =09=09=09realtek_ie_buf =3D ieee->ht_info->sz_rt2rt_agg_buf;
 =09=09=09realtek_ie_len =3D
 =09=09=09=09 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
 =09=09=09ht_construct_rt2rt_agg_element(ieee, realtek_ie_buf,
-=09=09=09=09=09=09   &realtek_ie_len);
+=09=09=09=09=09=09       &realtek_ie_len);
 =09=09}
 =09}
=20
@@ -1042,8 +1040,8 @@ static void rtllib_associate_complete_wq(void *data)
 {
 =09struct rtllib_device *ieee =3D (struct rtllib_device *)
 =09=09=09=09     container_of(data,
-=09=09=09=09     struct rtllib_device,
-=09=09=09=09     associate_complete_wq);
+=09=09=09=09=09=09  struct rtllib_device,
+=09=09=09=09=09=09  associate_complete_wq);
 =09struct rt_pwr_save_ctrl *psc =3D &ieee->pwr_save_ctrl;
=20
 =09netdev_info(ieee->dev, "Associated successfully with %pM\n",
@@ -1177,10 +1175,10 @@ inline void rtllib_softmac_new_net(struct rtllib_de=
vice *ieee,
 =09=09 * and the network does broadcast and that those two bssid match
 =09=09 */
 =09=09if ((apset && apmatch &&
-=09=09   ((ssidset && ssidbroad && ssidmatch) ||
-=09=09   (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
-=09=09   (!apset && ssidset && ssidbroad && ssidmatch) ||
-=09=09   (ieee->is_roaming && ssidset && ssidbroad && ssidmatch)) {
+=09=09     ((ssidset && ssidbroad && ssidmatch) ||
+=09=09      (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
+=09=09    (!apset && ssidset && ssidbroad && ssidmatch) ||
+=09=09    (ieee->is_roaming && ssidset && ssidbroad && ssidmatch)) {
 =09=09=09/* Save the essid so that if it is hidden, it is
 =09=09=09 * replaced with the essid provided by the user.
 =09=09=09 */
@@ -1190,7 +1188,7 @@ inline void rtllib_softmac_new_net(struct rtllib_devi=
ce *ieee,
 =09=09=09=09tmp_ssid_len =3D ieee->current_network.ssid_len;
 =09=09=09}
 =09=09=09memcpy(&ieee->current_network, net,
-=09=09=09=09sizeof(ieee->current_network));
+=09=09=09       sizeof(ieee->current_network));
 =09=09=09if (!ssidbroad) {
 =09=09=09=09memcpy(ieee->current_network.ssid, tmp_ssid,
 =09=09=09=09       tmp_ssid_len);
@@ -1218,7 +1216,7 @@ inline void rtllib_softmac_new_net(struct rtllib_devi=
ce *ieee,
 =09=09=09=09if ((ieee->current_network.qos_data.supported =3D=3D 1) &&
 =09=09=09=09    ieee->current_network.bssht.bd_support_ht)
 =09=09=09=09=09ht_reset_self_and_save_peer_setting(ieee,
-=09=09=09=09=09=09 &ieee->current_network);
+=09=09=09=09=09=09=09=09=09    &ieee->current_network);
 =09=09=09=09else
 =09=09=09=09=09ieee->ht_info->current_ht_support =3D false;
=20
@@ -1314,10 +1312,10 @@ static inline u16 assoc_parse(struct rtllib_device =
*ieee, struct sk_buff *skb,
=20
 =09status_code =3D le16_to_cpu(response_head->status);
 =09if ((status_code =3D=3D WLAN_STATUS_ASSOC_DENIED_RATES ||
-=09   status_code =3D=3D WLAN_STATUS_CAPS_UNSUPPORTED) &&
-=09   ((ieee->mode =3D=3D WIRELESS_MODE_G) &&
-=09   (ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G) &&
-=09   (ieee->asoc_retry_count++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
+=09     status_code =3D=3D WLAN_STATUS_CAPS_UNSUPPORTED) &&
+=09    ((ieee->mode =3D=3D WIRELESS_MODE_G) &&
+=09     (ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G) &&
+=09     (ieee->asoc_retry_count++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 =09=09ieee->ht_info->iot_action |=3D HT_IOT_ACT_PURE_N_MODE;
 =09} else {
 =09=09ieee->asoc_retry_count =3D 0;
@@ -1581,13 +1579,12 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, st=
ruct sk_buff *skb,
 =09=09   WLAN_FC_GET_STYPE(frame_ctl));
=20
 =09if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-=09     ieee->link_state =3D=3D RTLLIB_ASSOCIATING_AUTHENTICATED &&
-=09     (ieee->iw_mode =3D=3D IW_MODE_INFRA)) {
+=09    ieee->link_state =3D=3D RTLLIB_ASSOCIATING_AUTHENTICATED &&
+=09    (ieee->iw_mode =3D=3D IW_MODE_INFRA)) {
 =09=09errcode =3D assoc_parse(ieee, skb, &aid);
 =09=09if (!errcode) {
 =09=09=09struct rtllib_network *network =3D
-=09=09=09=09 kzalloc(sizeof(struct rtllib_network),
-=09=09=09=09 GFP_ATOMIC);
+=09=09=09=09 kzalloc(sizeof(struct rtllib_network), GFP_ATOMIC);
=20
 =09=09=09if (!network)
 =09=09=09=09return 1;
@@ -1599,8 +1596,8 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, stru=
ct sk_buff *skb,
 =09=09=09assoc_resp =3D (struct rtllib_assoc_response_frame *)skb->data;
 =09=09=09if (ieee->current_network.qos_data.supported =3D=3D 1) {
 =09=09=09=09if (rtllib_parse_info_param(ieee, assoc_resp->info_element,
-=09=09=09=09=09=09=09rx_stats->len - sizeof(*assoc_resp),
-=09=09=09=09=09=09=09network, rx_stats)) {
+=09=09=09=09=09=09=09    rx_stats->len - sizeof(*assoc_resp),
+=09=09=09=09=09=09=09    network, rx_stats)) {
 =09=09=09=09=09kfree(network);
 =09=09=09=09=09return 1;
 =09=09=09=09}
@@ -2226,9 +2223,9 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 =09=09return SEC_ALG_WEP;
 =09} else if ((wpa_ie_len !=3D 0)) {
 =09=09if (((ieee->wpa_ie[0] =3D=3D 0xdd) &&
-=09=09    (!memcmp(&ieee->wpa_ie[14], ccmp_ie, 4))) ||
+=09=09     (!memcmp(&ieee->wpa_ie[14], ccmp_ie, 4))) ||
 =09=09    ((ieee->wpa_ie[0] =3D=3D 0x30) &&
-=09=09    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
+=09=09     (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
 =09=09=09return SEC_ALG_CCMP;
 =09=09else
 =09=09=09return SEC_ALG_TKIP;
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
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192=
e/rtllib_wx.c
index c730d921463d..b25343f01f8d 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -134,8 +134,7 @@ static inline char *rtl819x_translate_scan(struct rtlli=
b_device *ieee,
 =09=09=09=09((ht_cap->short_gi_40mhz) ? 1 : 0) :
 =09=09=09=09((ht_cap->short_gi_20mhz) ? 1 : 0);
=20
-=09=09max_mcs =3D ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
-=09=09=09=09=09      MCS_FILTER_ALL);
+=09=09max_mcs =3D ht_get_highest_mcs_rate(ieee, ht_cap->MCS, MCS_FILTER_AL=
L);
 =09=09rate =3D MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 =09=09if (rate > max_rate)
 =09=09=09max_rate =3D rate;
--=20
2.34.1



