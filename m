Return-Path: <linux-kernel+bounces-348647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FB98EA0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E31F27559
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9A84A3F;
	Thu,  3 Oct 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="MsSvtfax"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329483CD6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939050; cv=none; b=VApfXWNRLKJldqC6FVoqefgv7jICW/SXVlug+Wer2zZrsvXgY4ayngWqZCTcGJWeFmh4c8+xJBS23M8SOL94P4Xc08PQ7zxVHz+rVwgw2ZJsgcIybPFk2GjWjZCS7qjX41J2hRL4/J5+LmQkfTUuFVSzeLFMANiQBGg8F2ylZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939050; c=relaxed/simple;
	bh=FT1dmSR/7HphGaCqeu0Bu4MPYzB0xAljnPfu2hcfees=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmQ/RMN0S0rAVNOLsHVPy71TlVyeyITxIAm7KSq2HxgpiJ19y1rsLE+uc1sj27vLD+8hG759kJsZsSaWfpY6Bi8y7hrB6aKGB3yv6VcPRhfAHcaLdxbuQzgslEhX81CvgGMOFL6GZfJD+p15dX8AeODMcRWlepX8wuaaySmeTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=MsSvtfax; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1727939043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ks5kXRH2BTbpTCJlHFhMKYsjQkBC+Fxm53rc1k7x+kY=;
	b=MsSvtfaxe7/k3/Q9YBhCyGJQX0sJdaVCEpd331r8GU9MbBwqGaRX5sAepe9sNJFM92UrhP
	cAhw48xRCJlpUMakGCEa3bPuTRqCv7yGgf/q2VhbafaIqAY3SNU3tXY8mDXvwV4dg4n/zO
	3Vf0IGxrTK8B35u7MpV4AIPVn6kE9lB8YN1p5vieW8ju+qTi6/UDiD0QrNvA57oqTNrUqG
	MLCNy5kxoWCPTnr1Fppi/i2vlsSxZnUncBYtTFJ/tdeFt+h/o3EIHHBHe3K1Xvzxl9QGsV
	2EchTRCTeKweMeRcPG0DaqE60V9ZhqkziD3rAqyoWrbCGqNf7v9uERMaMzu9qg==
From: Xingquan Liu <b1n@b1n.io>
To: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH] staging: rtl8712: remove parentheses after &
Date: Thu,  3 Oct 2024 15:03:53 +0800
Message-Id: <20241003070353.65998-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove parentheses after & to fix checkpatch warning
Unnecessary parentheses.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/rtl8712/rtl871x_cmd.c         |  8 ++---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c   |  2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  6 ++--
 drivers/staging/rtl8712/rtl871x_mlme.c        | 34 +++++++++----------
 drivers/staging/rtl8712/rtl871x_mp.c          |  6 ++--
 drivers/staging/rtl8712/rtl871x_pwrctrl.c     |  6 ++--
 drivers/staging/rtl8712/rtl871x_recv.c        |  8 ++---
 drivers/staging/rtl8712/rtl871x_sta_mgt.c     | 34 +++++++++----------
 drivers/staging/rtl8712/rtl871x_xmit.c        | 28 +++++++--------
 drivers/staging/rtl8712/usb_halinit.c         |  2 +-
 drivers/staging/rtl8712/usb_ops_linux.c       |  2 +-
 drivers/staging/rtl8712/xmit_linux.c          |  2 +-
 13 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index ffeb91dd28c4..218836128e8f 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -48,7 +48,7 @@ int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
-	_init_queue(&(pcmdpriv->cmd_queue));
+	_init_queue(&pcmdpriv->cmd_queue);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 	pcmdpriv->cmd_seq = 1;
@@ -633,7 +633,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcm
 	struct wlan_network *pwlan = NULL;
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	if (pcmd->res != H2C_SUCCESS)
 		mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
@@ -672,10 +672,10 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcm
 				goto createbss_cmd_fail;
 			pwlan->last_scanned = jiffies;
 		} else {
-			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
+			list_add_tail(&pwlan->list, &pmlmepriv->scanned_queue.queue);
 		}
 		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
+		memcpy(&pwlan->network, pnetwork, pnetwork->Length);
 		pwlan->fixed = true;
 		memcpy(&tgt_network->network, pnetwork, (r8712_get_wlan_bssid_ex_sz(pnetwork)));
 		if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 0653aa27b1fa..ebfb1b2f1189 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -892,7 +892,7 @@ static int r871x_wx_set_priv(struct net_device *dev,
 		/*Return received signal strength indicator in -db for */
 		/* current AP */
 		/*<ssid> Rssi xx */
-		struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 		struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 		/*static u8 xxxx; */
 		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
index 2b539335206a..f9b5588fe4d6 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
@@ -488,7 +488,7 @@ enum _CONNECT_STATE_ {
 uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u32 ulInfo;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index 34c9a52b4c42..b335799b2ad5 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -40,8 +40,8 @@ static u8 do_join(struct _adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct  __queue	*queue	= &(pmlmepriv->scanned_queue);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct  __queue	*queue	= &pmlmepriv->scanned_queue;
 	int ret;
 
 	phead = &queue->queue;
@@ -228,7 +228,7 @@ void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state =
-				&(cur_network->network.InfrastructureMode);
+				&cur_network->network.InfrastructureMode;
 
 	if (*pold_state != networktype) {
 		spin_lock_irqsave(&pmlmepriv->lock, irqL);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 70c295e97068..a80c99554273 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -44,10 +44,10 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 				 Ndis802_11AutoUnknown;
 	/* Maybe someday we should rename this variable to "active_mode"(Jeff)*/
 	pmlmepriv->passive_mode = 1; /* 1: active, 0: passive. */
-	spin_lock_init(&(pmlmepriv->lock));
-	spin_lock_init(&(pmlmepriv->lock2));
-	_init_queue(&(pmlmepriv->free_bss_pool));
-	_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	spin_lock_init(&pmlmepriv->lock2);
+	_init_queue(&pmlmepriv->free_bss_pool);
+	_init_queue(&pmlmepriv->scanned_queue);
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
@@ -57,9 +57,9 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	pmlmepriv->free_bss_buf = pbuf;
 	pnetwork = (struct wlan_network *)pbuf;
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
-		list_add_tail(&(pnetwork->list),
-				 &(pmlmepriv->free_bss_pool.queue));
+		INIT_LIST_HEAD(&pnetwork->list);
+		list_add_tail(&pnetwork->list,
+				 &pmlmepriv->free_bss_pool.queue);
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -93,7 +93,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
-	struct  __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -285,7 +285,7 @@ static void update_network(struct wlan_bssid_ex *dst,
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
-	    is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		if (padapter->recvpriv.signal_qual_data.total_num++ >=
 		    PHY_LINKQUALITY_SLID_WIN_MAX) {
 			padapter->recvpriv.signal_qual_data.total_num =
@@ -317,8 +317,8 @@ static void update_current_network(struct _adapter *adapter,
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
-		update_network(&(pmlmepriv->cur_network.network),
+	if (is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
+		update_network(&pmlmepriv->cur_network.network,
 			       pnetwork, adapter);
 		r8712_update_protection(adapter,
 			       (pmlmepriv->cur_network.network.IEs) +
@@ -483,7 +483,7 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	spin_lock_irqsave(&pmlmepriv->lock2, flags);
 	/* update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress),
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress,
 		    pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
@@ -536,7 +536,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 				} else {
 					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
+					  &adapter->registrypriv.dev_network;
 					u8 *pibss =
 						 adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
@@ -726,7 +726,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 						cur_network->network.MacAddress);
 					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
-					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
+					spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL2);
 
 					ptarget_wlan =
 						r8712_find_network(&pmlmepriv->scanned_queue,
@@ -846,7 +846,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL;
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event *pstassoc	= (struct stassoc_event *)pbuf;
 
 	/* to do: */
@@ -915,7 +915,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 				free_network_nolock(pmlmepriv, pwlan);
 			}
 			/*re-create ibss*/
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
 				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
@@ -1646,7 +1646,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct wlan_network *pcur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 
 	if (!phtpriv->ht_option)
 		return;
diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl8712/rtl871x_mp.c
index 099c512c8519..c6bc7b546166 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.c
+++ b/drivers/staging/rtl8712/rtl871x_mp.c
@@ -52,9 +52,9 @@ static int init_mp_priv(struct mp_priv *pmp_priv)
 			 ((addr_t)(pmp_priv->pallocated_mp_xmitframe_buf) & 3);
 	pmp_xmitframe = (struct mp_xmit_frame *)pmp_priv->pmp_xmtframe_buf;
 	for (i = 0; i < NR_MP_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pmp_xmitframe->list));
-		list_add_tail(&(pmp_xmitframe->list),
-				 &(pmp_priv->free_mp_xmitqueue.queue));
+		INIT_LIST_HEAD(&pmp_xmitframe->list);
+		list_add_tail(&pmp_xmitframe->list,
+				 &pmp_priv->free_mp_xmitqueue.queue);
 		pmp_xmitframe->pkt = NULL;
 		pmp_xmitframe->frame_tag = MP_FRAMETAG;
 		pmp_xmitframe->padapter = pmp_priv->papdater;
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index cd6d9ff0bebc..b22129f5d4f9 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -86,8 +86,8 @@ void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps)
 void r8712_cpwm_int_hdl(struct _adapter *padapter,
 			struct reportpwrstate_parm *preportpwrstate)
 {
-	struct pwrctrl_priv *pwrpriv = &(padapter->pwrctrlpriv);
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
+	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 
 	if (pwrpriv->cpwm_tog == ((preportpwrstate->state) & 0x80))
 		return;
@@ -96,7 +96,7 @@ void r8712_cpwm_int_hdl(struct _adapter *padapter,
 	pwrpriv->cpwm = (preportpwrstate->state) & 0xf;
 	if (pwrpriv->cpwm >= PS_STATE_S2) {
 		if (pwrpriv->alives & CMD_ALIVE)
-			complete(&(pcmdpriv->cmd_queue_comp));
+			complete(&pcmdpriv->cmd_queue_comp);
 	}
 	pwrpriv->cpwm_tog = (preportpwrstate->state) & 0x80;
 	mutex_unlock(&pwrpriv->mutex_lock);
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 8a3566214af7..0c305bd19693 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -66,9 +66,9 @@ int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				    (RXFRAME_ALIGN_SZ - 1));
 	precvframe = (union recv_frame *)precvpriv->precv_frame_buf;
 	for (i = 0; i < NR_RECVFRAME; i++) {
-		INIT_LIST_HEAD(&(precvframe->u.list));
-		list_add_tail(&(precvframe->u.list),
-			      &(precvpriv->free_recv_queue.queue));
+		INIT_LIST_HEAD(&precvframe->u.list);
+		list_add_tail(&precvframe->u.list,
+			      &precvpriv->free_recv_queue.queue);
 		r8712_os_recv_resource_alloc(padapter, precvframe);
 		precvframe->u.hdr.adapter = padapter;
 		precvframe++;
@@ -654,7 +654,7 @@ void r8712_recv_entry(union recv_frame *precvframe)
 	s32 ret = _SUCCESS;
 
 	padapter = precvframe->u.hdr.adapter;
-	precvpriv = &(padapter->recvpriv);
+	precvpriv = &padapter->recvpriv;
 
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_RX);
 
diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index 2c806a0105bf..41b8a24e2f33 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -53,7 +53,7 @@ int _r8712_init_sta_priv(struct	sta_priv *pstapriv)
 	psta = (struct sta_info *)(pstapriv->pstainfo_buf);
 	for (i = 0; i < NUM_STA; i++) {
 		_init_stainfo(psta);
-		INIT_LIST_HEAD(&(pstapriv->sta_hash[i]));
+		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 		list_add_tail(&psta->list, &pstapriv->free_sta_queue.queue);
 		psta++;
 	}
@@ -153,22 +153,22 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 		return;
 	pfree_sta_queue = &pstapriv->free_sta_queue;
 	pstaxmitpriv = &psta->sta_xmitpriv;
-	spin_lock_irqsave(&(pxmitpriv->vo_pending.lock), irqL0);
+	spin_lock_irqsave(&pxmitpriv->vo_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vo_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->vi_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vo_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->vi_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vi_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->bk_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vi_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->bk_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->bk_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->be_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->bk_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->be_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->be_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->be_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->be_pending.lock, irqL0);
 	list_del_init(&psta->hash_list);
 	pstapriv->asoc_sta_count--;
 	/* re-init sta_info; 20061114 */
@@ -181,10 +181,10 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 		preorder_ctrl = &psta->recvreorder_ctrl[i];
 		del_timer(&preorder_ctrl->reordering_ctrl_timer);
 	}
-	spin_lock(&(pfree_sta_queue->lock));
+	spin_lock(&pfree_sta_queue->lock);
 	/* insert into free_sta_queue; 20061114 */
 	list_add_tail(&psta->list, &pfree_sta_queue->queue);
-	spin_unlock(&(pfree_sta_queue->lock));
+	spin_unlock(&pfree_sta_queue->lock);
 }
 
 /* free all stainfo which in sta_hash[all] */
@@ -201,7 +201,7 @@ void r8712_free_all_stainfo(struct _adapter *padapter)
 		return;
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
 	for (index = 0; index < NUM_STA; index++) {
-		phead = &(pstapriv->sta_hash[index]);
+		phead = &pstapriv->sta_hash[index];
 		plist = phead->next;
 		while (!end_of_queue_search(phead, plist)) {
 			psta = container_of(plist,
@@ -226,7 +226,7 @@ struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		return NULL;
 	index = wifi_mac_hash(hwaddr);
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
-	phead = &(pstapriv->sta_hash[index]);
+	phead = &pstapriv->sta_hash[index];
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
 		psta = container_of(plist, struct sta_info, hash_list);
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 408616e9afcf..78cffd233902 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -88,14 +88,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			((addr_t) (pxmitpriv->pallocated_frame_buf) & 3);
 	pxframe = (struct xmit_frame *) pxmitpriv->pxmit_frame_buf;
 	for (i = 0; i < NR_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pxframe->list));
+		INIT_LIST_HEAD(&pxframe->list);
 		pxframe->padapter = padapter;
 		pxframe->frame_tag = DATA_FRAMETAG;
 		pxframe->pkt = NULL;
 		pxframe->buf_addr = NULL;
 		pxframe->pxmitbuf = NULL;
-		list_add_tail(&(pxframe->list),
-				 &(pxmitpriv->free_xmit_queue.queue));
+		list_add_tail(&pxframe->list,
+				 &pxmitpriv->free_xmit_queue.queue);
 		pxframe++;
 	}
 	pxmitpriv->free_xmitframe_cnt = NR_XMITFRAME;
@@ -137,7 +137,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			goto clean_up_alloc_buf;
 		}
 		list_add_tail(&pxmitbuf->list,
-				 &(pxmitpriv->free_xmitbuf_queue.queue));
+				 &pxmitpriv->free_xmitbuf_queue.queue);
 		pxmitbuf++;
 	}
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
@@ -370,7 +370,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 	u8	*pframe, *payload, mic[8];
 	struct	mic_data micdata;
 	struct	sta_info *stainfo;
-	struct	qos_priv *pqospriv = &(padapter->mlmepriv.qospriv);
+	struct	qos_priv *pqospriv = &padapter->mlmepriv.qospriv;
 	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
 	struct	security_priv *psecpriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -452,11 +452,11 @@ static int xmitframe_addmic(struct _adapter *padapter,
 						  pattrib->icv_len;
 				}
 			}
-			r8712_secgetmic(&micdata, &(mic[0]));
+			r8712_secgetmic(&micdata, &mic[0]);
 			/* add mic code  and add the mic code length in
 			 * last_txcmdsz
 			 */
-			memcpy(payload, &(mic[0]), 8);
+			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 			payload = payload - pattrib->last_txcmdsz + 8;
 		}
@@ -775,7 +775,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return;
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
 	list_del_init(&pxmitbuf->list);
-	list_add_tail(&(pxmitbuf->list), &pfree_xmitbuf_queue->queue);
+	list_add_tail(&pxmitbuf->list, &pfree_xmitbuf_queue->queue);
 	pxmitpriv->free_xmitbuf_cnt++;
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 }
@@ -853,7 +853,7 @@ void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 	struct list_head *plist, *phead;
 	struct	xmit_frame	*pxmitframe;
 
-	spin_lock_irqsave(&(pframequeue->lock), irqL);
+	spin_lock_irqsave(&pframequeue->lock, irqL);
 	phead = &pframequeue->queue;
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
@@ -861,7 +861,7 @@ void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 		plist = plist->next;
 		r8712_free_xmitframe(pxmitpriv, pxmitframe);
 	}
-	spin_unlock_irqrestore(&(pframequeue->lock), irqL);
+	spin_unlock_irqrestore(&pframequeue->lock, irqL);
 }
 
 static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
@@ -874,26 +874,26 @@ static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
 	switch (up) {
 	case 1:
 	case 2:
-		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*ppstapending = &padapter->xmitpriv.bk_pending;
 		(phwxmits + 3)->accnt++;
 		break;
 	case 4:
 	case 5:
-		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*ppstapending = &padapter->xmitpriv.vi_pending;
 		(phwxmits + 1)->accnt++;
 		break;
 	case 6:
 	case 7:
-		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*ppstapending = &padapter->xmitpriv.vo_pending;
 		(phwxmits + 0)->accnt++;
 		break;
 	case 0:
 	case 3:
 	default:
-		ptxservq = &(psta->sta_xmitpriv.be_q);
+		ptxservq = &psta->sta_xmitpriv.be_q;
 		*ppstapending = &padapter->xmitpriv.be_pending;
 		(phwxmits + 2)->accnt++;
 		break;
diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8712/usb_halinit.c
index 313c569748e9..b3cd59b9830c 100644
--- a/drivers/staging/rtl8712/usb_halinit.c
+++ b/drivers/staging/rtl8712/usb_halinit.c
@@ -285,7 +285,7 @@ unsigned int r8712_usb_inirp_init(struct _adapter *adapter)
 	u8 i;
 	struct recv_buf *recvbuf;
 	struct intf_hdl *intfhdl = &adapter->pio_queue->intf;
-	struct recv_priv *recvpriv = &(adapter->recvpriv);
+	struct recv_priv *recvpriv = &adapter->recvpriv;
 
 	recvpriv->ff_hwaddr = RTL8712_DMA_RX0FF; /* mapping rx fifo address */
 	/* issue Rx irp to receive data */
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index 4a34824830e3..0c953298d42d 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -134,7 +134,7 @@ static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 static void usb_write_mem_complete(struct urb *purb)
 {
 	struct io_queue *pio_q = (struct io_queue *)purb->context;
-	struct intf_hdl *pintf = &(pio_q->intf);
+	struct intf_hdl *pintf = &pio_q->intf;
 	struct intf_priv *pintfpriv = pintf->pintfpriv;
 	struct _adapter *padapter = (struct _adapter *)pintf->adapter;
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index ceb6b590b310..fb7eadafe73a 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -150,7 +150,7 @@ netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
 {
 	struct xmit_frame *xmitframe = NULL;
 	struct _adapter *adapter = netdev_priv(netdev);
-	struct xmit_priv *xmitpriv = &(adapter->xmitpriv);
+	struct xmit_priv *xmitpriv = &adapter->xmitpriv;
 
 	if (!r8712_if_up(adapter))
 		goto _xmit_entry_drop;
-- 
Xingquan Liu


