Return-Path: <linux-kernel+bounces-216798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02EF90A69C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375701F24495
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6F18FC95;
	Mon, 17 Jun 2024 07:11:39 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CD18F2EA;
	Mon, 17 Jun 2024 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608298; cv=fail; b=enbdiBwVDNIXkQrO2OTj4CqG1p4HaU0q3I3XeXfbc+dk1aF0vSIDu9vdypjUdr2OEAIQA9DprqELU/mtIehKM+jBPnr14uRDU+cZ4NxMCPaeARr4hNIowgESE6WmWjcGVzNjmPpgjksjRFhdq8h5yGysNkRMbDt0N+pLef0wlzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608298; c=relaxed/simple;
	bh=X6CbfSWuWN6tcDzUl3C7LEFpRzeBI34kXvy/cAqMzo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5dkHukrsNZPPX9yc9rhbPnr646oNGDJTfb/Z4rSLD0pVK86gwPhO+8px00MqFsZRHxgo5Py0lqOqaedqB95G0vgveyyRQcVL8J8Qqt9v7ntpPjf4IXg/MTjTbhKHJvLuhBn32I8R088SnZ4VZWXREo5Bqil5SC0pyMGy6uIUyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzQbDt2iB25R4c+/mlawCG92HXF3xuL0Tc3nwsaYuEmLbFqwexhhc9G4z/jAk6/h1JkpOihTMMPAbICDAMUNm+5LxboG3nVUPkqKtLUkEtUBWIiz4AViwdkLAFjBw88gH+my4q14/mzczlNDeu+NxVudNrhyAV5gVIwDfjf1YZG5EhD5OzkhbD84x6N49CrJpXpBQSY3lNhHx+VZ3KqEib2gQWKIVb9ryI3My2O8izQ4sMQ1DxfdM3walpZyi4Z83bltRz7W/Btc3r4sz4LTOVkyE5BHw9H+J3AXHeLtK88IqyqmegW0IqbTqpgc+49457NOp7YOzyZ14et4p0+LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdzMnZ6hnydbPcbxzcpTAl3xkMClQP31BdtgdcWbrto=;
 b=hPTqzUCFxtA7bEnl2UCeuVw1jOZSlIaE3HFWGyt5MR6v3MhTkGwPdYp4cSV9b6bqujpg0rCN67olZXV9abz3Ejpg8dTkjqfUHsuDkQ7MONiXzLDeQy+nirJdR50E2PksNZ3tTDBzJ3pFzi71ZzI+L72UCsVDxQRpWLQYosVr64jyNGjAXmO7r72UrNQ2aV+PWSYCSkXMb7PqkJFllZxE1DLMYpLmw58N+fldfZ4rRB5TG43TaTmlVFbrC7CYUoC6Ub1HXJLJZI+0mBdU1dKp9egEQ9j8Pwt4HUqp/W+bQd96t5X9JLKsfbkmiujfpkp6GInhVt9hy/ZV+mdzG4XwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:31 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:31 +0000
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
Subject: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon, 17 Jun 2024 15:11:11 +0800
Message-Id: <20240617071112.3133101-5-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 122b36c8-e5ac-4c6f-ae02-08dc8e9cb704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|7416011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O6DTPmyGLKqLyBp3b2AsbM7AA4hasQecLDpW8wnotFzuTz9eSfzCH9bQlI0M?=
 =?us-ascii?Q?dWulnEHLRQhBWx+KxqgjmpO2ll6jjisQaXMn8H0LmOESMbnWGKo7b1V/MzbJ?=
 =?us-ascii?Q?pc/bXicFbcOD5YVvR5tXGQAKSyZoNfNSFki1H3JQrY0hevcbC9IZBfIzvFAd?=
 =?us-ascii?Q?LygvaMR3/8m5VtTsIlB6P3yAbJyFxt/KHQPAxwzaL81dCSBVRr6q5V5B+UH9?=
 =?us-ascii?Q?fgACjfVZTIPK9fKxctBv4vsYUN2ElF/0g23ReDLRlYv+B9kBrjgnTcuTe883?=
 =?us-ascii?Q?etCSC+swg7VJrdaOWriRuI39VtYhhj5sBt7tvreOJegNX4kQM6eYPLlWwAsN?=
 =?us-ascii?Q?ZU+MdhtcRqC6BQzNR55pp343TRftJP1vxueq0H/2Jnb1FddF1liQKp4a1uY9?=
 =?us-ascii?Q?RC5xcifCmNz4v/nvRYzv0UHp4AldmSpCYzpkoEZpL3Db02D89eAvmAQDDjjG?=
 =?us-ascii?Q?VFQyoQI72ztBzOuh17h/6c6dSYIHm49vDj8onApecLFTcgWZniJ8/EtJhSsc?=
 =?us-ascii?Q?RkaqoVMB1B/K+uSB6V4eq+6PAoCU1JdDlvyXP1ceYYR3EZnrJaUQPcZxWvP5?=
 =?us-ascii?Q?cfYcakcuQ/ZL//mFncKpQTiueitDOOAx1a8BKLs9yh3BbZWw++ENgXCk2UpI?=
 =?us-ascii?Q?Y3Wt1TI+YjmutUlfc+78teoNFGIp+wKdLkR4lvLf9+0vsm52vuj9x/Uid9h2?=
 =?us-ascii?Q?PaxdjNFT8x0y6g+mTTnNwkM8qT6fvEcpp2iEAdAC56ikapYEIWMXZDcDMc3t?=
 =?us-ascii?Q?iXcgmzsxutuGiBuyhzUV9iFJbVBlkeznroRtKE1h1lBh1xRJFgsYRE/yWLSL?=
 =?us-ascii?Q?bP8lxfK5Crng/87XCXFhUziRfwNUNLfPBAULwurR40jJ1vByAfoQ2XggITuA?=
 =?us-ascii?Q?dnNHjstM7He37k2wzloQ1skXxOpmhv8a1/in8XgmsxtEbg2lPW1uY5LgA9r8?=
 =?us-ascii?Q?8BCCrJvNtUrQiwsGTREM/PFv4QHd2IRsUN1QnPs4y0fa5QJltVT60+y7Z0XG?=
 =?us-ascii?Q?1blaauwlwbTQ7JLDSAXQ823glyXtSiELQ6RvGpaNzuUBK6WFrt1z0fV61D4n?=
 =?us-ascii?Q?bTalVHQt/jnUP7icZHE7yktHCTwBPrG8Jmaw7aONdOsieUSE7NtIO3nk8ACl?=
 =?us-ascii?Q?nAr/jSPNWF8Rbg67jXSC1KzI17JFxwniZwSZZ8rzTPRF/Kq0B5qpDc74H0f5?=
 =?us-ascii?Q?/9cvYoNmvMihc7FY0V8iahkhglgoG4vpXSP/M2jTG3vmOcv/xnDntwpOfWCx?=
 =?us-ascii?Q?pZ99o3BEiA1+wYiPs/2kmT8R1AcahMeOmaSxpyEiRQz7TLvUNslQKKRMKq66?=
 =?us-ascii?Q?5Nl/1tDWQ2kgYrHQP6ZUs1+SzTIGX7EHNkbX/eg0BRF7Fn1bsBPLGLSGP1Tl?=
 =?us-ascii?Q?TD66Zlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(7416011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhi57PAps6WrlH0bgqiWkfrlc8nzBQl1m+M0YNjs+igQh2Me3cT7uwd1JCLj?=
 =?us-ascii?Q?jnD41Iolz5e2sY5ZrQzMgrI7WRxZ8/u/JjGJ3qeKJ9MLAAlS9BSh86tJbKU1?=
 =?us-ascii?Q?YJq1Cq3dRUnCiUgjOZ3OmbjGXzG100hzQk8mnWNKky00xSHms5gKU6OGLygr?=
 =?us-ascii?Q?bAiWo2SHqOsHTTWiL7iI9Cx8WG2tNxQdqx5Xxx6skur8MZqlkx9UuwayxwGx?=
 =?us-ascii?Q?SG0+QMWIVmUkV2Uil0cVBtJS9NKR3lGKU7gWfLH16ik6fSrwkTfo4d3UW8o2?=
 =?us-ascii?Q?OFguZcft6caJ1j2ekL/gOZpvEXno5OwJUY1ky8N1VrNCgvpFaM0j3yEyUDm2?=
 =?us-ascii?Q?mWGg1suBMSOT2WFVEeMQ8mkCAtT/nKlQpDR+bm3uEoZi7dh7C7bYvqVQG76M?=
 =?us-ascii?Q?J2vXY8IUaPqHozWMrwGy8gFz2g0q/EYd51OaPnO/NcjhLcdg4MBqd1bzw6RL?=
 =?us-ascii?Q?ItMtijetqzeFl4OejPrHimthtnswyj7xCQ5YHNYlHkr/kStdidKR9eOMrscf?=
 =?us-ascii?Q?ppSLLXQ8vItsY8ibCH9OFauo8vzI50NaCUxUmsdS5h3ShQIaYj1gsFx4P0Zw?=
 =?us-ascii?Q?8iqKu3glZ0u+SS4ttiBH+ml06TByJcnKd61cpi8bgt/a4BonkFV5z64vXSis?=
 =?us-ascii?Q?+GIJj78fvg/fywLvbdQxI+iuyAa9LhzmmT5Mn3Rbqqo3SAELEUxQZ41+WdlL?=
 =?us-ascii?Q?Y9pRUNAjBAquSM7CdB187dQU8k0Bo3+AwSx7V8XTw/bnH5aLUtOTZtMbxUr5?=
 =?us-ascii?Q?cpW5stTYdDkaMXcHF0Oq1q39xkjPe/1PZzJHTX8Gc40rVFEzFk/fLq98UoIS?=
 =?us-ascii?Q?KZQCxKQumbDkgErurQJxZY+Afy0+lPmI8oEW1e7aLE1VNmV9GWd/V0VnZUsH?=
 =?us-ascii?Q?LC3e8szgO+jYhWFLOUlGKhSnsvLfuk8DQ2oZFhuHzEVmcOnewj8W+w+FAt3E?=
 =?us-ascii?Q?6XWtJY61DzSiWEqu8/H5TXbVQd+GRP3C53bwAcXhkLjMsB+kTauP2klaKYTO?=
 =?us-ascii?Q?4gpdBsRPlV9yKTIeBy0w37r/zVSUWh8H2cOBMZlhT5KBmlHUkNXPIT0EoYgL?=
 =?us-ascii?Q?dCKhHlX5Fx/d7KYrVVk9Tydv+2oes/ytzqfvGf068UC1caaR0SQUdMQIhhE7?=
 =?us-ascii?Q?aGcWTMvUJu62mgle95hunMLUPUva1QHO822ZMgt9askh7B9zx6Nhf3+RhHvw?=
 =?us-ascii?Q?pvV1hRSYJWLWJ2sRNC09rT7i2LQmXY1t9P0szuZos2dAneE38gY4SxluB0Tp?=
 =?us-ascii?Q?W6Lg/r4FwFEMRCTsz8ZELNJWFNltntOkUWoqGINpaQ/Ru7hEa4tPirg0M72n?=
 =?us-ascii?Q?MYq186ZsxmlAMg3HZ85Nz+4hisj6PIfWXbP3hgQ9bIkaF18t9XlXyNOy3maV?=
 =?us-ascii?Q?lG74+JP2HDTpC6QSgD602Rch8AZdK2QmtyvTQRVR9OHKpdVtaLXbEoZjBdWi?=
 =?us-ascii?Q?wpPBKL3C2JWMeGzj3F1lVXIlmRSKnQp9hxJi8tk9V4Y9X2by4ZklWJathrsD?=
 =?us-ascii?Q?JipUh/aOG6bfMVAD/tooXp2PQWR3fnawGaZ57nRHYK6Hdq6u6iw469ipkCXk?=
 =?us-ascii?Q?WlPFaILev0t1eyMSxrtNuL5z4nngizwpYnsrTLqujKJs4yUoO9GwsRLm8zc9?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122b36c8-e5ac-4c6f-ae02-08dc8e9cb704
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:31.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdIoMJoh8n4usGsxWe0+VUXG25Pb8maaSxekX2onTwim91EKi+/zBf2Nqozw2Ifcm9FDnVn3kNFR5ygj3ItFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 233bab17bffd2..7d7cc3e76838c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -365,6 +365,23 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "32k";
+		};
+	};
+
 };
 
 &pwm11 {
-- 
2.34.1


