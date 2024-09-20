Return-Path: <linux-kernel+bounces-334639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6D97D9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6BC1C21F03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A0185B73;
	Fri, 20 Sep 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="s4Vv0Ior"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE7185945
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860994; cv=none; b=o/Vufs62dXsHvjAmH3cL3mhyJWWNUkaviZxec1gDPJjYDfVAA+6euyu1ofco93lYxPLbTJwEm+6bSn4YxJ7s0AWkG/Va4iu1Q+vjpc1QsEvyLUjT0oLzNsPonsAvyEttHKSwNlz2afumu3Grocy5haHNnKoVaeaRexEO8/4Vl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860994; c=relaxed/simple;
	bh=2vJdAkaGHBV2TryFPtly9aJyvY4P+y7rsefucB2Yny0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnH6jn9qTq6Lfhjf3iVMJ9A7UlPlSBPsMgIQsXK72GkeE0700m+F4kzhQwVTqM72VJ88lgoNGFnI8albDN0dyRBu7GG9oBQmECEjKBJOSUW2m+kHZ1dC5xODU0m9zh0K7ojkW7uNXQX9viXptN6w/BsGRqu0uoqDIcg89u8ncMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=s4Vv0Ior; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726860990; x=1727120190;
	bh=sbGQSHTR6+O7rkQs09WSrwZvj804vgR4gxpRVPNuecY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s4Vv0IornLqT3NG9ZziRHhwKO3L5hS1yFZ5ihUvOaODGm4nFvKQqABUkoZjjeMekB
	 i7BTutRXj1Euz3ZrBmBGsZlWwTg4I16Q5tDaAkRTRb4L2fdmnw05WJ+/1+3IP3VaVX
	 nKAxX/nT7EVEc31BwmaFpO/RRX9ARfq68uJXuEsYBdXqzJ5XSErPrFJzBGDob+nJMZ
	 AmQQDyc9Y5qrcjh9WpRQyLR9QTG7SVmiBfmu+9gHWVqsn+3Bsl8jJTKNgJaRPy1scc
	 /4fpDQmljHdC8qgMLwLNFC7+F/wQ6YI/SQ+hF7Lnr683daZ98lEEUx/Zb+u6RkWAtY
	 U8runOh12ZLQQ==
Date: Fri, 20 Sep 2024 19:36:28 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 3/6] staging: rtl8192e: rtllib_rx.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-4-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 86f967b24fe94662b3ae11800954633aa4fa5f85
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
 drivers/staging/rtl8192e/rtllib_rx.c | 91 +++++++++++++---------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192=
e/rtllib_rx.c
index 8fe224a83dd6..e58be8e07917 100644
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
+=09=09=09      ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
+=09=09=09     memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=
=3D 0)) {
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
--=20
2.34.1



