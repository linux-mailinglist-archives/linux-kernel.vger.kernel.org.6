Return-Path: <linux-kernel+bounces-226865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46549144F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F9B1C2237F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE212EBCC;
	Mon, 24 Jun 2024 08:33:23 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442061FEB;
	Mon, 24 Jun 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218003; cv=fail; b=FBUacXR8nU5gmDBl+Sv+QffxIc8BQ3FffvS50YUAZ8mFsK5XuzJSp79LH2uE5JLt2zQb/n9c4CLWKTpCy4WVilvF6Myo1L5PPh+egtOiDDXL32TDVi3wS6//bKFc7Z/klzLm2FOLl45pygRLb1UToFO/+4uEVXPnEmCPAqYB1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218003; c=relaxed/simple;
	bh=Vw5F0Rn9YNeZ/xGarFhYDYWCu16YJ2RINRCOhW78QqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEe958eMJJ/WkfzD7R7pvM0mIjxVG+Gg3G5AkyhWirMUHfSet7A+wd7DGjvaspeF60WpJZMjTJetXlEXN/XhruT+ixyXWOZ3tBOlQWUIQi5yMxQEJMCMD9asKoQoYQeCvHUThnjFcVKnGpj/1covCeu5TWeWUyEK4hSIHLZOlfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyPFjDRAFE9mMZRnZ8u8EMGjbPXiXnRUCi4igKPXMgSQbbaf80Ekb66wmWgoYvsNQ7goo409Wcn+zTO1Y1tUSccDdI9DbFc8R6iXWc5wh++s/2y1YS44bBEZ8Sv6jQlDqZkepd1x6P0k/vPKNfpw4uuHz1Yue0djfqKeQnfZDCtow5QpQhKhtkKgHZVCevMjxeGN/elv6JJmVuPY2GttHt3CVXUzn5I6iTjtCpRnz7pB/jIcWmjKU7bwLJnpPz08xNFzDAwQzsSN/e2K1v9LZL9j84ZbzIHH4STc3/PTjm2v+TEQs/kSZ4bKXke951LY5eE68G+xLhePlSNl2C7XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnlOEn4GS58Qn2XFXnX1/gT9ceh3HRewoyzMbRqqK4w=;
 b=T9DzqGasx1MF+TQ4L4eIY2i1zR5FUrqpJbqJvLnecu4llZ6qrySEGFBRd631u9z1NPzJO1WWaXHyWUC6EjeGu2mt3vUO4ikALDprsytTkEL742gRdZurVDlYYlwSic+odkQBhyL6WpetJbBOylTyKGqopz5dkNB1iNxOrsX5la4jRjn6qMytdynlfcU7RboO1QK3pIjKxRbWKk3r6MjD5RhyAYidgWsi6PPthRKRWPbtPeyohmcwR/XZcwuNFHf3QbomzAR0nhKsHHUhBZ/RZojV5wq1M8vXpV83WC3XP9twYQQhr8LknyPAvbFe2rtGCNkJOd12q2DptSKshMpZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6456.apcprd03.prod.outlook.com (2603:1096:4:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:33:15 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:33:15 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v4 2/2] arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge2
Date: Mon, 24 Jun 2024 16:32:36 +0800
Message-Id: <20240624083236.1401673-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624083236.1401673-1-jacobe.zang@wesion.com>
References: <20240624083236.1401673-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a335e6-e1c4-4407-5850-08dc942849b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|7416011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Nmr9sAlJm+t/ieLvFos/i6dNoT7xyt0E7e565TFFCmyc+LxlGHfWoaZVEQd?=
 =?us-ascii?Q?hA5Ks+Juxj/XdVwiUMVvZKDmYcT/C4WS56+qrUC3oSj8raFgO/Hs6jJl0c0Q?=
 =?us-ascii?Q?/jHunvOd6IGEktcDp9yO41YMEeJ8+P5/DYUWGtTcjw6YzFfx1+BicbjkKd18?=
 =?us-ascii?Q?aQigyaJw187YOYCHu6PeOr0hGTTAaXxGHq85H95I77mf3p4odPJCkDEj6pvk?=
 =?us-ascii?Q?t3IqnSQ5h2NTK8TAGwt1j/B+9GSivOwvYTI855jZM66REIrvjQh1MT3B++CR?=
 =?us-ascii?Q?0ECSQvvrmxBifmaQXT4OPC2zzbmUDO1spkd6CteJ40/WoR0pa5BIE4J03NLa?=
 =?us-ascii?Q?k+fvkh53ngFU3+miZYA+EKTsrCSyV5Ww8/JzvaqicKyj+RraWK9ekHmJCh+D?=
 =?us-ascii?Q?APVm6009rTObfJYFCAVTySav9+vFQ41QuDsZ2aTy1+auwXrfHiDF+qIyacu+?=
 =?us-ascii?Q?T0/guI5tiZ6bQCpyRlNSQsiGxbz/xF5kHoIbNzHSavkoozxba1a0h5SeRGnA?=
 =?us-ascii?Q?h89t+LvV52mpluSDocawJYZP0XO3wxEkeSPkZFELkdPFswznm5JLwxrJ95sr?=
 =?us-ascii?Q?6tlAfNISWXaLNFkKqn0s/X02TU54vqPmcbV31kfzgpzlYLPYYL2+iHUGKRa2?=
 =?us-ascii?Q?djieZhvAxB33VH3m9SZKFrNC/UBOGUenSfdGQtK0LYVpOTimFtK2dPdXwfbd?=
 =?us-ascii?Q?XWzyDUH9C9EByVnQng6UYPXvIepP16XD20vyiEO0+Xn/nx8NkE+8NOoChcuG?=
 =?us-ascii?Q?J5VAKmL9BSq+mTF/T93oLo17/BhZWmRCvM1MuYIvzCF2IW3ZMADslou5gjBk?=
 =?us-ascii?Q?VcD7X4sc/ekT//lB5OvXSVpT2drYW0Fz3/mnQqDIzoOYqsQtYXrz237OFV9V?=
 =?us-ascii?Q?4fstdfPgDRvnWnuYu+QFsbH0IWFkq4g+nGIZHMYsY02+RBNcRPMo+EsSjJEv?=
 =?us-ascii?Q?CkFRwWTNl/ryuoUJ6mjWmfGY3Fsm1y54fOCzen8GaeJzMxuKPlA3ee8GuxDg?=
 =?us-ascii?Q?nD6kkxBB76wELecrQNjcG+Gv1MV925KO9D6Bd4Mh5XBpZU04DUHDdX48iw1t?=
 =?us-ascii?Q?Y2jtHgi913sF4gO5E3Xh8yEKlh1gs2/jFygH/SKhq2Y5FNPYZcuM3x3mRt87?=
 =?us-ascii?Q?u3CksN5VO3rI9lX3hPPyIn+MPe8zbY9QchfqWUDDUN6TVzAA0VFP6zCBvOs+?=
 =?us-ascii?Q?RqdnF48dGCo4wXKZiwsfJ9WzGp1K79LrUNvvDnGoRpXdpKVrw4Z/S8ywe5Ja?=
 =?us-ascii?Q?4vxeetRsERmMy+Kapsyz7Ooh0ploF/WJRA4vNHEWv6vfDf+9KNqd/0kXnccZ?=
 =?us-ascii?Q?Z5JRSAzcSdh/FjUD5tptIyTEduXqvhjBY82LNaGJS0/VfBPCz2CdC2HHM9cX?=
 =?us-ascii?Q?MaTCwKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(52116011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXqdmOYPQnqUeVxgc4x1cQQqIFAzbo3bx1TFTcGmn/6UMNufbr80UAN7/hka?=
 =?us-ascii?Q?y96z9jkjTRdFOcwtAdbtyV+q8sJQUWsrpmH1KivFWgFdNIidZgysDQtBTbdW?=
 =?us-ascii?Q?tRZ82bamVTtUvcUlbvr5qyfUE8TqaG5A+wSnlTFd77CSPGxsD5a45GWH4/Vh?=
 =?us-ascii?Q?FfF5J9uG64CaRxZ1XYg1SLNS20UOS1z7PBvGtIMO3e6cOVhLWTiI5UTo1IWc?=
 =?us-ascii?Q?BxMAv/HLfutJxu8eudimZRzIIqhtvwKzbL3BCEhytPrJ82jUtQPip0U4L8Ud?=
 =?us-ascii?Q?A8K9ikh4c65oMjM28rdFYkpjrhYLHWOzkI4WqPttZpvga7bYF7Oytix0n+mt?=
 =?us-ascii?Q?XRcwecYEsPO/aCMgXmwPJak3Bl8bxmRWpqNvBFnBZfWacKB8xDLVFnrMt/sY?=
 =?us-ascii?Q?5Bjl/UC4xlEmXEGNYX3J86c54xHBplxkD66/2tuDbpMPblQndwe6oKoDll11?=
 =?us-ascii?Q?v0+x1KxSf4LyuLkw/AYlQJJZwE/P8qSOZOtgaDV57TRvgby2JAodTtVECIqo?=
 =?us-ascii?Q?zXeE0tCfIktX99IKVaBg+wKGdgj84+5vMSEXSoMb04bUQQCg2U1euwiEXY1j?=
 =?us-ascii?Q?Ox6xgk+ffiFjynYMNDjtFcs93mG5M1i+bmeMqPcR90bKGv3qheZjc2rAWHbs?=
 =?us-ascii?Q?I6/Xm5cexsCIU4sd80t1bObbOWelB3hQP9yeD0Vu6rXBWnZZ0PcOEr97ZNe3?=
 =?us-ascii?Q?0FmfukR0UwBbOw5leZ/lnbkNyB1P83AHpxR6+RqIt4+2mR5Q/iFx2QzbLtht?=
 =?us-ascii?Q?EkAezPQoG7y7hTjQtvCnp1Tk/JTPQpVieIJmAAaBjEOQyDBVb1JYyM6k2mWW?=
 =?us-ascii?Q?aKsV2+uc/IIIuUbUFirUu0wocDBWR6M0sga2rpbuX6r9NUvNtNDlip0mFNnI?=
 =?us-ascii?Q?aFai4OFowcPmFS6KmjXVXe7RJhKFanuBclhzWE/XApGQEYwjgP2SuTDaxEVT?=
 =?us-ascii?Q?/94Jh8r4LlKiu6BIHtnSOqxHQCv9hIiVq+cjNryMt0tZm/7rwqFfxOpf6ohr?=
 =?us-ascii?Q?eNcyz6D7PNT2osN2DSpa+pa8M32VBBoRU1sPwOtwjgo0O7W/0+rPYa/b6dUr?=
 =?us-ascii?Q?SoFRtFWJa7KHY3Dl36Amf7Y4jiy0QN0dRziUDIQwKncpHPoAH4SdDliUoNAS?=
 =?us-ascii?Q?GMXt4CLO/uRsmREtSSsukYwV9D/XlTKdb6CvWgppfO19W0Cyi0GwQnG8wTl4?=
 =?us-ascii?Q?Lt82TXBRSNgdnfzvhOkPGjZcPe3pwKTO0pQE54CIW/HK8eoweN/TYkaFsv5X?=
 =?us-ascii?Q?/rKWD2q/J3m78RlkNueYV8omXRASd2zRP4yYu8T57ECYcEtFQ789ft3eDt5w?=
 =?us-ascii?Q?DjvBFMVShvzzGVaqN1AiZApPfZyMcwk7NM1R8iZB9Yl+GyFx9pN0t4wmqvyK?=
 =?us-ascii?Q?AREeWrp39Hb4sRGpFpgRO3pDbMv819SVPv6uwgpJRIDrxCxaNNyu680ynNWO?=
 =?us-ascii?Q?KpLi+0IfZoD9pz88Toq6zJ7cbXaTUQdJwPY5izCgtwNJfN2sPjEfz7CUyzgY?=
 =?us-ascii?Q?Z32gOmhS5nRl+IWb5G0Zsckbap01FAMmhnMSrAJ/qHbLIqyZjT2Eqs3F+1mX?=
 =?us-ascii?Q?ckK3BDdTt5scxopfogN58R4eeNISq6uhr17uXH+M?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a335e6-e1c4-4407-5850-08dc942849b7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:33:13.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YEaqoY+Zg/mw3V5fWXXiJzQaYXlMrCuKMEMZUvpMAnGiatGyAuA4zt15IgJVPU0mOQRet+tZk6Jv+O0YFgCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6456

This add bluetooth node, in uart9 add RTS node in pinctrl.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 8c0bc675690dd..3b6286461a746 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -750,8 +750,15 @@ &uart2 {
 
 &uart9 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reset_pin &bt_wake_host_irq &bt_wake_pin>;
+		shutdown-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &u2phy0 {
-- 
2.34.1


