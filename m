Return-Path: <linux-kernel+bounces-216799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7F90A727
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716EFB2542D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFF18FDC3;
	Mon, 17 Jun 2024 07:11:41 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3518FC87;
	Mon, 17 Jun 2024 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608300; cv=fail; b=Zhz3xyso09ItM2ZhJhpgFTL8Nch+7AVAnxkr/411fOLajG5ryB+zp/vqCn5lG06m73V50YIY2ZcoJEHpwa/RQNvOGORndRYM1jpa154OguS4CJmS+Clro63JuGV/XjlGw44UJQsKsGm0M1y204eSZ18MzehykdtIB8Cm+foI2xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608300; c=relaxed/simple;
	bh=RTUQ5wihoXzDoWetdR+PnyBNl861AYMb4jjU4Gp793o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYxld5i1fMm497pllYWSOFtzdl9VPY1PMXFp7oGUWdYUGxZviPMwC1a5ppUFS2wEwb0VTn2kEkj2Fn65Zn2+SuVwQHdRlKMf8ncrf66QUPD0YI5lX11OGOphl/r0zDDckUnaWeiSmf8gA+2qj3nd6YZHpJvJqhdgMhwfmcfGeGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVcjF88zYewM/N25kisMM6wKYGcHr+/0hH4zopTvMaOdkMnR/rgpIVzeyhGGPUTWse+ZJsxtHj148dWU4iv3qcP6ZVSgg8ndiJ0k4JO2Yp7I3NQzZ6ERYUOUa9/dKJRmfHNvFdoLOTf91y7ovntMTlEUr8C8HsCAG46zC/4bHN7lfN2zlYGDFQAN2veeovuEoe1jagAilOkS+2+3q3nu230Dt/hjccA8iUpD1KpXTbx/VhBDoYEOs4wpXAz/sLwFB5hJm7hKUFDryCM6+2qQRC5r6rq8NARzA1GJ4UUFvFf+x4gE1rC9ok81/SeMh2CzVwSDhy5xzFAIx3sy5TZH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpovuagVKrldqpdu9kaWlX4cHVi+n3y77eRANlmMoRc=;
 b=iOSk3QUYHmJWoqobiSs2Vs2GY6rT7FECugitO9Dh+GiXwT/zmAL1wsmMDA551CwVCH6uiyk3yKwsTB84gcvuzYRoJP7tVNECuVE/ZBLsct1le2hH1Pagn+HbLh5qYPE7O89GoWiZEjLqvvaJBaZweuB1hft8Wjo15KktG2bFZm+tp7kqLXgjFp8o21VrmMNNbqYTx7/c9plzMwk7WmFipVbWDSVjc9H8/uSbCkuSbH8hXAU5ss45IBoH4t4sbp5muiVs79mWu4j3U5v9YD/wxS5RQVsw1TiZAot8zWfEEzbcK7/ni3ffH1ChudaJyCV1YtFN+9QItTyxd8BURhTgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:34 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:34 +0000
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
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Add cpufreq support to Khadas Edge2
Date: Mon, 17 Jun 2024 15:11:12 +0800
Message-Id: <20240617071112.3133101-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617071112.3133101-1-jacobe.zang@wesion.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d6ecb6-e983-4ee1-6557-08dc8e9cb856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|7416011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX20fmEiwdTXIVe49RZi3C8cjn6FCG+/mUetGIl5lFodbyfTiY/VzAhZLEzc?=
 =?us-ascii?Q?0tZx4EsJTxpQAmNcKKowK7MvHX9lrFXSWUh3+P3hpdJGexQ1A+sMd9CcdI6c?=
 =?us-ascii?Q?EeBwN762GjwFmmvHWJLuiJiInasJH3wVZSaE8gzVCmFX65vEeMYXos6c/L/Z?=
 =?us-ascii?Q?RZFksBWsMyFClBjolqFCgXfX+pPKPS4lhmMK9eTagN+YOaGRCD+gxd3MuxXE?=
 =?us-ascii?Q?WsX37XSqWZgvejK7DwR7D9VVmBop+SZ7iBi676k8wEOrZk0sXDzP52uMEavj?=
 =?us-ascii?Q?RlE5TrxGLXlg7dHM0XIo8RboiNFY7ulrcPK7QVtg4CDpympEKKoQSNUOCcx2?=
 =?us-ascii?Q?vZ47TisypYHVcJtxBiE6mwz37lgGdEPuePKYLD6HG6M+yHI7DiPQr2U0UWHD?=
 =?us-ascii?Q?Tkh2oYIOI4gDoIHRxFowrn8CBInH6Klegt4WHMqbmg77GmP+/83JyMTErZ84?=
 =?us-ascii?Q?xsJPG7EQUkqUcjZPtVCmUyCAQTGsGW8FI1K2kx3nKpjYcEVUojyIYX8M1YVe?=
 =?us-ascii?Q?2q4VFQv1LVJ89AtApLTx23eI5xOL0iM0IEwo+JwoHJbCqgrSVOg9HVOjsxgF?=
 =?us-ascii?Q?zQNtsdfrMsB0SI6spTQAXcQuD7Tv3j7BhIj0PGaIaLvqAdQi9NaP9cSpWzqy?=
 =?us-ascii?Q?PhhDcYVbQTYUf73mVGkmrEpXjNba49fv/7hSCmxvDKF7ux4DI5DomTcO2rMS?=
 =?us-ascii?Q?dzB93UeNWX//q3i2sSefsEnrGXkwZVZHPnssyQPAcsrY2kImCx/QGh3Y3RI9?=
 =?us-ascii?Q?Uakc9U1HRxP8w8+qM+8jqC7BCys1TSeM5sPz3qv2nabkUw66qdOmeG1LE5KY?=
 =?us-ascii?Q?3vweJVlZa9RuAxfHrP0q11kpWLCneckvznY9Ae75AlvbVLvw+/RUYpMCxJH9?=
 =?us-ascii?Q?HBoixkQ64Wp1VLbzxpt8cNtO+RwYUUvZ0VLsBce6gkCs+JRQQxevHpNsm0JT?=
 =?us-ascii?Q?LrcACu+EtkMTqNxw0JCt7f9JSZJk6+5fqX11VFLVCcaO1CbrI2zpFNOMQ1gk?=
 =?us-ascii?Q?D0w5yutUWWKX4VSNx7gOUKdw/crQ2xpL+gIRtMtqcQx8dpHcGo7KLptYpkKk?=
 =?us-ascii?Q?7XVw89SWh5MPAZXyWUxZVAN7DVEnCkbyzCM7vXzkTtCcUgD2tFQullkdqQx7?=
 =?us-ascii?Q?Rem9KcgBQVlZ72Lrng8S0rACDiDKANBXPZxFpDcODT2ulErpc3fD5qxjR3zO?=
 =?us-ascii?Q?u+Nw1NM13lv86wr6PiJ4XXpSCGCpl5MZn/8XpxkxaCdEEQX6z+psYZ4zEPcS?=
 =?us-ascii?Q?y6HHv/xPyshor8S2IHbAv6cb5ry4qpA1+rDdraTKyMMacg7cEGK4XQbiHbnT?=
 =?us-ascii?Q?mNpS6maR/ThspjgxQHf22LFjZoD90/KIVZmx8zUgku+keBzb41B2oFkbAE5K?=
 =?us-ascii?Q?SMWoYHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(7416011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prSfRsiFGbKUqbnZ7UlcQkdJUfcTeF9ELgxw4vWvdi3qkXmIzCeLX2p70Ogn?=
 =?us-ascii?Q?IiTI3EobuhEMSRLRHePL5GyzmPCtG9SNpjoMVd8Je+uq17AOVIu551WLCNoo?=
 =?us-ascii?Q?lPc19OyMZPitkdLR0sjNyTnS4US07BBgIBdmPdzhsuK6aYtHUfQsGx+fxck/?=
 =?us-ascii?Q?lX/Gi6jgg7taIGdWnkSu7fThqyAYSssTn5KRf/NjBAxqKoaXhHd0Yez35zTi?=
 =?us-ascii?Q?7QyaJthsgMw9pHWOQuwaxxiMZs7iSBsMCfeDx6mWa+bQ9Yu/RwZCXrYIEc05?=
 =?us-ascii?Q?1Ddfklsp452ilPI/z6AoaOnsH4d0ljHjm85rB3QJLPFJqKmjsMwU97Bbe8Vi?=
 =?us-ascii?Q?s0jblbYibI/zNc/mxa9Nl7JWEjXaEALTf13DCQu0JIR6i01PTg28uKDkcAnu?=
 =?us-ascii?Q?eS0gieKmtipjDahxssS/18iFrzN/M6XR75Ja2RCDKFYZqQxq4VpxkLvTlMSc?=
 =?us-ascii?Q?wwRt/Jpy5pHWqQ7OxzK7PnlAC9PTVyNzivmRNMsNf7E8RPstPwOT8YV3/Q9b?=
 =?us-ascii?Q?sfiF7Ltsl143CTlpymlUX1uql5Dn9Id6DnE40sRd4jtRd/EhiTMZYbq+tz6g?=
 =?us-ascii?Q?FU31fTd+DDuVbKRWb8WgzbopQlNlHBYbntbYqeM0myAksiTTB9Cnu/+llKSh?=
 =?us-ascii?Q?t2EsHNScNF1JTV4bjt4AmTNiWlU9KWEVQp6G1pTeV9v41bqfNTVrh0O4gdJ9?=
 =?us-ascii?Q?KcN0Sp7gUL9tMEW760p3WQhVNhrMvJw+eVj0spByoUbkfMmpSwCQ2FuoQyEu?=
 =?us-ascii?Q?e7HtVMQaH8oiID0AfvEIQgosYsH5xmLU7qMue1q5VUQ18I0RH2wDx2lBMen+?=
 =?us-ascii?Q?YEtDTy1G1PE2vFxGXf4bVpGR+4GesrP65ugWUGWSmyHLTvt9cgkxOjJ1z04m?=
 =?us-ascii?Q?hKfnspp4JNSAutEHBzesyveBZKtXOx0Pr9a+GbF9AuCM8tnSL/4VZR294uJj?=
 =?us-ascii?Q?3sASXbB4Cej681sVPQios2vxJsYDKRszkkwM2D6WuFkq2d0hYlcH2Hs1u0Cn?=
 =?us-ascii?Q?KfsGNLv8tUik6M56hrqSjJp+zgKJA0h5WoBJjaoi1VVTHE3obu9FbqMy9d5Z?=
 =?us-ascii?Q?L8vXyKfZ6E4XHl8d4ehq+p1qbc2+GVc9LHd7KJND0BwRZWeI/DOdShMMOHQh?=
 =?us-ascii?Q?nZ4HLI9g2mFaBPsDxwF1b7qBW0F+EzUXsD+bQOm7/LWqYNLf8MbhoBLuDCoR?=
 =?us-ascii?Q?DUuHSr/4ZAqUVkpnXhEI2xxeJwJaUny2Rbi8/N2Lxv3cMO2ipqS5i5kHV9+b?=
 =?us-ascii?Q?FsLvwuqPvpUS8h242gqvCezN3XKf0nb2o+h7gcul1I8HperLMQp/72X6NrOR?=
 =?us-ascii?Q?xsVr0FXl/AibgNgmZ3DdhGMTAAicF2ldJDHazuCJ5jcrBFdMlnsnS9Umkv6/?=
 =?us-ascii?Q?+siaKw9w/GbVTh2m7g0TvQ9M+78Gx7VKwsC7D6f4yUGhAWuJyKESZBKbVkTz?=
 =?us-ascii?Q?5FrhhgscVoRBrYEGOEKOIUC57f4cssUg2l1xs2PI3pKuA/D0W9YxrIliFiMP?=
 =?us-ascii?Q?iLMK/YmCKLuHsBBjsssJCEKq+9P7+EZIe/wE33vKbxGSp0IWDHuNJWFJNbyl?=
 =?us-ascii?Q?4CIaV2xXmKr1E05i8WpTqRZTOmS+ihBjc6k1tPgBY4AaEVKHOCv97f1Jjiqe?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6ecb6-e983-4ee1-6557-08dc8e9cb856
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:33.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC6B839YeWQPLag9doHM26o3sem8uD0FozAmYCSyubJC+xpSm2iVvBLrCTQmOrSmqjSxnRsY2fDQZjNzqXhzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

This adjust CPU nodes on Khadas Edge2.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 7d7cc3e76838c..5fb15d3dc23e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -160,34 +160,42 @@ vdd_3v3_sd: vdd-3v3-sd-regulator {
 
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_mem_s0>;
 };
 
 &cpu_b1 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_mem_s0>;
 };
 
 &cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_mem_s0>;
 };
 
 &cpu_b3 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_mem_s0>;
 };
 
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l1 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l2 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &combphy0_ps {
@@ -208,7 +216,7 @@ &i2c0 {
 	pinctrl-0 = <&i2c0m2_xfer>;
 	status = "okay";
 
-	vdd_cpu_big0_s0: regulator@42 {
+	vdd_cpu_big0_s0: vdd_cpu_big0_mem_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
@@ -225,7 +233,7 @@ regulator-state-mem {
 		};
 	};
 
-	vdd_cpu_big1_s0: regulator@43 {
+	vdd_cpu_big1_s0: vdd_cpu_big1_mem_s0: regulator@43 {
 		compatible = "rockchip,rk8603", "rockchip,rk8602";
 		reg = <0x43>;
 		fcs,suspend-voltage-selector = <1>;
-- 
2.34.1


