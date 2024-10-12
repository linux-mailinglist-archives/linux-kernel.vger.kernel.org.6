Return-Path: <linux-kernel+bounces-362042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90C99B03A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97DB1F23307
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCDB175BF;
	Sat, 12 Oct 2024 02:47:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD212564
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701256; cv=none; b=Dv1XwHD53KpLyfyseFyQW7cNtFdUSbG2aR3cmNqkxWUSfkLoV1WGMEj7A/jBWp+Tc7Ps5X1cprdmm3eSOIfuRAc5kAgvkY/YeT/aW6f9FEKy1uuLnyxYqmdrg8ZnAF2y3pW9bo3mfvQvQK4cmqhosyYOm/88g4r9GXlzP95h/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701256; c=relaxed/simple;
	bh=ZHtFv/D6WMwxN0OY0iL7e7eIjI4k33vRW1AcVW7cfcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHS665g7xVxzBracU8poNnVbDaYMX2fZILGeU2eKxm0riknrOFY5oo8btoTUEvwpVKvEsLYm9amBtSDZ9s1F23+0FbSmchCBjxkBMccTRKftplAoGiaXaE7C5QSHFDcb5gEAbSk/u9HbOtQArnKayFSpvY7WAYLh4LHNhQzUzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49C29f4c030183;
	Sat, 12 Oct 2024 02:47:31 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 427g38g0p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 12 Oct 2024 02:47:30 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 19:47:29 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 19:47:28 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [usb?] WARNING: ODEBUG bug in corrupted (3)
Date: Sat, 12 Oct 2024 10:47:27 +0800
Message-ID: <20241012024727.2538384-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
References: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kWODwYczA508HtARHOEP6Agb7-jwdL6B
X-Proofpoint-ORIG-GUID: kWODwYczA508HtARHOEP6Agb7-jwdL6B
X-Authority-Analysis: v=2.4 cv=DukE+3/+ c=1 sm=1 tr=0 ts=6709e342 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=DAUX931o1VcA:10 a=HG7cOu_1BVOWzwgf2wwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_23,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410120018

rtl delayed work not be canceled before put usb device, it trigger following issue:
ODEBUG: free active (active state 0) object: ffff88811dc037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680

#syz test

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index aab4605de9c4..c6e4a5e59880 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -472,7 +472,10 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	static char deinit = 0;
 
+	if (deinit)
+		return;
 	del_timer_sync(&rtlpriv->works.watchdog_timer);
 
 	cancel_delayed_work_sync(&rtlpriv->works.watchdog_wq);
@@ -484,6 +487,7 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 	cancel_delayed_work_sync(&rtlpriv->works.ps_rfon_wq);
 	cancel_delayed_work_sync(&rtlpriv->works.fwevt_wq);
 	cancel_delayed_work_sync(&rtlpriv->works.c2hcmd_wq);
+	deinit = 1;
 }
 EXPORT_SYMBOL_GPL(rtl_deinit_deferred_work);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index d37a017b2b81..aaa16bc23e91 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1064,9 +1064,9 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 		ieee80211_unregister_hw(hw);
 		rtlmac->mac80211_registered = 0;
 	} else {
-		rtl_deinit_deferred_work(hw, false);
 		rtlpriv->intf_ops->adapter_stop(hw);
 	}
+	rtl_deinit_deferred_work(hw, false);
 	/*deinit rfkill */
 	/* rtl_deinit_rfkill(hw); */
 	rtl_usb_deinit(hw);

