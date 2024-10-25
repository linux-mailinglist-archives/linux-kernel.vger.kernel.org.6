Return-Path: <linux-kernel+bounces-381249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCD9AFC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB4E1F243D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7A1D14FA;
	Fri, 25 Oct 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="tC0tMUhz";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="gj4f4wzh"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E1D0F5F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844804; cv=none; b=Rb2cFrLIKG3D9EBMz0bKb+LvGD3EImhGVi+6anIJXvyDdAR9rD027FttRiK6OvmSYVnbGNFq34DBQatwovXnvQKsV9X9HZGSCm2NjEfmFDxTmeh+aqy5lYN3jTrlqsK0HRrirIeR9Ne8dd76osa+6xmP7LT2lhz7DtS2ST4HN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844804; c=relaxed/simple;
	bh=66BJsGKSO0zFJ5xRn6kHzXxXZ0lN+l9CnEWscQpaTEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPF845k8iSu1Wvaf2CmXUCKMMJi1LNPI9U1Ip25ANVKtTho/dJdd8HRPx4VntAkzAkmZkBwMK7a12800fw16aqUXnNRVdo+dRf6YvRjwrfUemczIvEfkvwgO55P6WQ3tU8WFlbSWkVQZu2XcKZlqudF+z4a1nXEPsXDDf2kU+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=tC0tMUhz reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=gj4f4wzh; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729845701; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=GxT94cQL1fAndlDPcyAmj+ZFucIh1j+4l3cVtvOBc3c=; b=tC0tMUhzEWt2Bw+7t9ZYLg1UY1
	XXSu1c37jgyps9NvuMLb9ILBgXrzORQUJFwlMzfi1latraBQvjBmIKmsiI63vppLPxAx1sjie9RR7
	7dVGpRWXfJ2TcqufXR7R4z7RHqMxMSXKjy+AR9NpBmwbp1v3Qe96xAqjSbmHy/+cGBUcenYPjXstn
	0Kuc+S0uSeduvng5VGa07NrxYLpMAM2zHzLtSqW2rGHY9MSg/hk9FYXe6NxpANH4hV/ajSFBBIYiw
	+eFmz7mEKyXerLNM8pGocssGLbGceu3epqYrcoLx3NLNE19uauyEc+uFh7pLRF6sJybmqxfiLW/Qr
	nRFU4DfA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729844801; h=from : subject
 : to : message-id : date;
 bh=GxT94cQL1fAndlDPcyAmj+ZFucIh1j+4l3cVtvOBc3c=;
 b=gj4f4wzh/OeQ3OhDm6UQTmqLMgRLxbGioUA3Ql/enJ/WUdkY20Yoek2fV4c/n/gb6XRxf
 I4KptQ7fzo3GmhkREpUObndtKX+aDwl7VD10641dtM8sSqPaELEhVlCHUbAuHLDADbOXlf2
 brYrzI9iocei7ESvWYD821+v3U49EShR1ZjGywz9XD669MkBdIvXqHUPKDeVhoOeYGpPjPS
 TmembqpvsCqWTpbkp3r1VI4tLxPdlin9zB+1XoMZYqsI0QOYp/tbTa+3DOExhM5tO8ESAYr
 BXA5FG/Pgw/Tb7SKuAChwiFG+lz63orIYWiXcrx8sB7a7a/Wv8p0KiNt22EQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4FeB-TRjx9W-Q5; Fri, 25 Oct 2024 08:26:15 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4FeB-AIkwcC8o9Lr-IbvN; Fri, 25 Oct 2024 08:26:15 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 2/2] wifi: ath10k: Flush only requested txq in
 ath10k_flush()
Date: Fri, 25 Oct 2024 10:23:48 +0200
Message-Id: <d0a3e1b61ae7ff8cc1a474b37d1064eeea11cbff.1729844329.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1729844329.git.repk@triplefau.lt>
References: <cover.1729844329.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: rOGE1OR-wPMB.MfRlSBb0rz_J.nqOuzACkFap
Feedback-ID: 510616m:510616apGKSTK:510616sRI4AHN5Hf
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The ieee80211 flush callback can be called to flush only part of all hw
queues. The ath10k's flush callback implementation (i.e. ath10k_flush())
was waiting for all pending frames of all queues to be flushed ignoring
the queue parameter. Because only the queues to be flushed are stopped
by mac80211, skb can still be queued to other queues meanwhile. Thus
ath10k_flush() could fail (and wait 5sec holding ar->conf lock) even if
the requested queues are flushed correctly.

A way to reproduce the issue is to use two different APs because
each vdev has its own hw queue in ath10k. Connect STA0 to AP0 and STA1
to AP1. Then generate traffic from AP0 to STA0 and kill STA0 without
clean disassociation frame (e.g. unplug power cable, reboot -f, ...).
Now if we were to flush AP1's queue, ath10k_flush() would fail (and
effectively block 5 seconds with ar->conf or even wiphy's lock held)
with the following warning:

 ath10k_pci 0000:01:00.0: failed to flush transmit queue (skip 0 ar-state 2): 0

Wait only for pending frames of the requested queues to be flushed in
ath10k_flush() to avoid that long blocking.

Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
Closes: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/net/wireless/ath/ath10k/htt.h    |  7 +++--
 drivers/net/wireless/ath/ath10k/htt_tx.c | 18 ++++++++++--
 drivers/net/wireless/ath/ath10k/mac.c    | 35 ++++++++++++++++--------
 drivers/net/wireless/ath/ath10k/txrx.c   |  2 +-
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index d150f9330941..ca8bf3b6766d 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -1870,6 +1870,7 @@ struct ath10k_htt {
 	spinlock_t tx_lock;
 	int max_num_pending_tx;
 	int num_pending_tx;
+	int num_pending_per_queue[IEEE80211_MAX_QUEUES];
 	int num_pending_mgmt_tx;
 	struct idr pending_tx;
 	wait_queue_head_t empty_tx_wq;
@@ -2447,8 +2448,10 @@ void ath10k_htt_tx_txq_update(struct ieee80211_hw *hw,
 void ath10k_htt_tx_txq_recalc(struct ieee80211_hw *hw,
 			      struct ieee80211_txq *txq);
 void ath10k_htt_tx_txq_sync(struct ath10k *ar);
-void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt);
-int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt);
+void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt,
+			       struct ieee80211_txq *txq);
+int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt,
+			      struct ieee80211_txq *txq);
 void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt);
 int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
 				   bool is_presp);
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 211752bd0f65..ef5a992e8cce 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -140,19 +140,26 @@ void ath10k_htt_tx_txq_update(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->htt.tx_lock);
 }
 
-void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
+void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt,
+			       struct ieee80211_txq *txq)
 {
+	int qnr = -1;
+
 	lockdep_assert_held(&htt->tx_lock);
 
 	htt->num_pending_tx--;
 	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
 		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
 
-	if (htt->num_pending_tx == 0)
+	if (txq)
+		qnr = --htt->num_pending_per_queue[txq->vif->hw_queue[txq->ac]];
+
+	if (htt->num_pending_tx == 0 || qnr == 0)
 		wake_up(&htt->empty_tx_wq);
 }
 
-int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
+int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt,
+			      struct ieee80211_txq *txq)
 {
 	lockdep_assert_held(&htt->tx_lock);
 
@@ -163,6 +170,11 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
 	if (htt->num_pending_tx == htt->max_num_pending_tx)
 		ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
 
+	if (!txq)
+		return 0;
+
+	htt->num_pending_per_queue[txq->vif->hw_queue[txq->ac]]++;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 86386a0af14d..74c28a68a7f0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4385,7 +4385,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 	u16 airtime;
 
 	spin_lock_bh(&ar->htt.tx_lock);
-	ret = ath10k_htt_tx_inc_pending(htt);
+	ret = ath10k_htt_tx_inc_pending(htt, txq);
 	spin_unlock_bh(&ar->htt.tx_lock);
 
 	if (ret)
@@ -4394,7 +4394,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 	skb = ieee80211_tx_dequeue_ni(hw, txq);
 	if (!skb) {
 		spin_lock_bh(&ar->htt.tx_lock);
-		ath10k_htt_tx_dec_pending(htt);
+		ath10k_htt_tx_dec_pending(htt, txq);
 		spin_unlock_bh(&ar->htt.tx_lock);
 
 		return -ENOENT;
@@ -4416,7 +4416,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
 
 		if (ret) {
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			spin_unlock_bh(&ar->htt.tx_lock);
 			return ret;
 		}
@@ -4430,7 +4430,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to push frame: %d\n", ret);
 
 		spin_lock_bh(&ar->htt.tx_lock);
-		ath10k_htt_tx_dec_pending(htt);
+		ath10k_htt_tx_dec_pending(htt, txq);
 		if (is_mgmt)
 			ath10k_htt_tx_mgmt_dec_pending(htt);
 		spin_unlock_bh(&ar->htt.tx_lock);
@@ -4693,7 +4693,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 			is_presp = ieee80211_is_probe_resp(hdr->frame_control);
 		}
 
-		ret = ath10k_htt_tx_inc_pending(htt);
+		ret = ath10k_htt_tx_inc_pending(htt, txq);
 		if (ret) {
 			ath10k_warn(ar, "failed to increase tx pending count: %d, dropping\n",
 				    ret);
@@ -4706,7 +4706,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 		if (ret) {
 			ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
 				   ret);
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			spin_unlock_bh(&ar->htt.tx_lock);
 			ieee80211_free_txskb(ar->hw, skb);
 			return;
@@ -4719,7 +4719,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to transmit frame: %d\n", ret);
 		if (is_htt) {
 			spin_lock_bh(&ar->htt.tx_lock);
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			if (is_mgmt)
 				ath10k_htt_tx_mgmt_dec_pending(htt);
 			spin_unlock_bh(&ar->htt.tx_lock);
@@ -8045,10 +8045,12 @@ static int ath10k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-void ath10k_mac_wait_tx_complete(struct ath10k *ar)
+static void _ath10k_mac_wait_tx_complete(struct ath10k *ar,
+					 unsigned long queues)
 {
 	bool skip;
 	long time_left;
+	unsigned int q;
 
 	/* mac80211 doesn't care if we really xmit queued frames or not
 	 * we'll collect those frames either way if we stop/delete vdevs
@@ -8058,10 +8060,14 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
 		return;
 
 	time_left = wait_event_timeout(ar->htt.empty_tx_wq, ({
-			bool empty;
+			bool empty = true;
 
 			spin_lock_bh(&ar->htt.tx_lock);
-			empty = (ar->htt.num_pending_tx == 0);
+			for_each_set_bit(q, &queues, ar->hw->queues) {
+				empty = (ar->htt.num_pending_per_queue[q] == 0);
+				if (!empty)
+					break;
+			}
 			spin_unlock_bh(&ar->htt.tx_lock);
 
 			skip = (ar->state == ATH10K_STATE_WEDGED) ||
@@ -8076,6 +8082,13 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
 			    skip, ar->state, time_left);
 }
 
+void ath10k_mac_wait_tx_complete(struct ath10k *ar)
+{
+	unsigned int queues = GENMASK(ar->hw->queues - 1, 0);
+
+	_ath10k_mac_wait_tx_complete(ar, queues);
+}
+
 static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 u32 queues, bool drop)
 {
@@ -8097,7 +8110,7 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	mutex_lock(&ar->conf_mutex);
-	ath10k_mac_wait_tx_complete(ar);
+	_ath10k_mac_wait_tx_complete(ar, queues);
 	mutex_unlock(&ar->conf_mutex);
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 5b6750ef7d19..b848962fc8fb 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -82,7 +82,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	flags = skb_cb->flags;
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
-	ath10k_htt_tx_dec_pending(htt);
+	ath10k_htt_tx_dec_pending(htt, txq);
 	spin_unlock_bh(&htt->tx_lock);
 
 	rcu_read_lock();
-- 
2.40.0


