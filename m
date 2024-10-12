Return-Path: <linux-kernel+bounces-362234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E844599B278
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EE91C21B54
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5D14D2A0;
	Sat, 12 Oct 2024 09:14:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752414B976
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728724464; cv=none; b=F73GAWJFJHjQrOylcGruDmODgjzkMmH7nXPqriv3ieDFOVX2fbRTLRXq5YzIOpGr/auoLCil/AdE95V79mosNhtjUE9h6Xd1GXf5PFIsJFS5x46LwXGUj0E5aIy0C5x5QuTqTnQVnan8pPtCaHJOv8rx+508F1F8b64e89Xgd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728724464; c=relaxed/simple;
	bh=3LHydQiAiD03vtWPPABjHy0IBzvZy1wqYjDNe1hgsc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG59ZyCMNGY2xO4kOPLft07MLrg20mQDistKtgrfKTKB9Wy//MgUHfa9nAB/MlWdZuLEDGKg5nIcPIPNWheH59ERAszOvfQUZPPoRW0t2m2i3D2rq2BwrF1SuU3nxG/eL1ZIv2B5ReSYfHcmr7HqEw8dueKUV8XMaapc9fp5YoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49C8e5US022046;
	Sat, 12 Oct 2024 09:14:19 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 427eb1g992-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 12 Oct 2024 09:14:18 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 02:14:17 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 02:14:16 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [usb?] WARNING: ODEBUG bug in corrupted (3)
Date: Sat, 12 Oct 2024 17:14:15 +0800
Message-ID: <20241012091415.2172948-1-lizhi.xu@windriver.com>
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
X-Proofpoint-GUID: U-My3hK45w8uwZEwt0ZXPdlK4i0fKYCI
X-Authority-Analysis: v=2.4 cv=ce6ArWDM c=1 sm=1 tr=0 ts=670a3dea cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=jrUbwfyzUzmEghs5bJgA:9
X-Proofpoint-ORIG-GUID: U-My3hK45w8uwZEwt0ZXPdlK4i0fKYCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-12_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410120065

rtl delayed work not be canceled before put usb device, it trigger following issue:
ODEBUG: free active (active state 0) object: ffff88811dc037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680

#syz test

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index aab4605de9c4..4d68a2437b0e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -440,6 +440,7 @@ static void rtl_watchdog_wq_callback(struct work_struct *work);
 static void rtl_fwevt_wq_callback(struct work_struct *work);
 static void rtl_c2hcmd_wq_callback(struct work_struct *work);
 
+static char deinit;
 static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -449,6 +450,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	if (!wq)
 		return -ENOMEM;
 
+	deinit = 0;
 	/* <1> timer */
 	timer_setup(&rtlpriv->works.watchdog_timer,
 		    rtl_watch_dog_timer_callback, 0);
@@ -473,6 +475,8 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (deinit)
+		return;
 	del_timer_sync(&rtlpriv->works.watchdog_timer);
 
 	cancel_delayed_work_sync(&rtlpriv->works.watchdog_wq);
@@ -484,6 +488,7 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
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

