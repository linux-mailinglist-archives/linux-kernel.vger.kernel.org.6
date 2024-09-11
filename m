Return-Path: <linux-kernel+bounces-325085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52A9754D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022031F237DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF674192D86;
	Wed, 11 Sep 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Jcnkyfab"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3981714AC;
	Wed, 11 Sep 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063028; cv=fail; b=lXGKzJ9hE8AuE4gbV3H0EWxiTckM+C2t/hDyZjz1lFjJP8JTaJGQiDl/0Rdt0uqEbYzlqr8e2+38lJhavscpNNarjLpuX4o7lOM7lu9uuhImpGSiN8E/OURxJTHw9LGMGXfJ/0T6SROzrwv7jcRuIh4036OA+SBcrK53ujC7hjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063028; c=relaxed/simple;
	bh=145yfSfg34CwYiEOk9+nwY5qJAKgM4rEpu+SDPnVLYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y8QYusbIRGEveIEASX0Mx3nEn5UZRaJ4/L4rWC4d4BCLq7Sk4S1WzRddThx9pOOLidatEVqUCRd6AICAp7Z/tKKTBELkt1KoNqPpb6aAQ1kQzeiHK4bSG/qa3+HSsyMTtnU+S/egTQ3shblW41eFhCF3M7A4bC2WdNzksu1nHkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Jcnkyfab; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAo69O002338;
	Wed, 11 Sep 2024 13:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=U1wbnlQ3LlUuV2uBCrYo4ozutCGTv
	Dji8/lmOtQz/qY=; b=Jcnkyfab32lzt3eyBszl4J2HVjp7cp+32l7m5/O2CJJs4
	+Tz04249S3NoEg8hhdGfxCjDVAiCxk9wkhR1zDntnsKP1+4uSwcf49/rqS+43p3/
	/lIjvsaIMKeawc8unrHx7WWJqJfdFdIeBxzFTjF9oY1WRd6h7wQGlGo5yF5UHXa5
	ERvJ/tZ3132KIvwo3ewlXMci26lE26FuzLRi3vSJtaYeh1rPU4VxIIdFUlF3Oicb
	bU61/MFqdN1/LvpT5V2hDLzIUScrpZGm0Qd7InRaWwozPZS+2dbPDyDUwCPHvGG2
	66WFUwPY81XEx+ZfirwCNvb9znWdEonhU3W7iroGg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41gg0gvjat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 13:57:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0e6HD/oCvOPZi8nOFMjruTL37k4nHeyoODRpMpdYPtpgFzpHXLn3/jiz0hbhZ1Kqrh7m7kTVeSIPHJX1gOQgKG1cJheVBAn0Ngfgfrj4XVEPNDC2BYcIRBl6yaACoB37AhIFp+pfmp8Ub7e0IbpZNme2917Kso4mD4J4rJw9on1xWjXo8RYRRxggFRCofyVSH4Q9537wYPBdeAmOTz9OAxZeDMTCtFLbCH2ZC/xNNFmk5h2asYZDRbKcILOO1fDdXCrXfkLB26Ln7eo7EpJZQRldBmQfFZXtV5gFuhspGpCmOVPuTD3V+ygIpg8j/PUcXMz/Tgv+auNBgxJTRRgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1wbnlQ3LlUuV2uBCrYo4ozutCGTvDji8/lmOtQz/qY=;
 b=lK3yUCcaVl2+cecK46GrJm4+6is4x4aB40WCHmHKYpLWuiQfeNskW6tW9lMdk7srYvsku3jjbTlaxAmrvfDtYc7TTs428JjIF8ujGg0hbMcZ/7r3GwsHZhB8Q3yL9UrJ6P+5ztun21xnHGyhtGKbafNVo8DNpuk/Rp092ir80HcOjwJKiH1LsGBsLbOkD2QBxuYiOSr/V7LsPrylxtAlJYox3qa65fh58vmaACtuOGisQB7IIqqvgSWz6wjYwnjreYKnVvlvcZWG70twY1AhfheE6uWG27LJ+NHPIr2j21WN+7zV+MTE33rKsz3Tb83KW0NMSvGiSTZEaaUwXU5MZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BY5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:a03:1a0::48)
 by CH4PR13MB7195.namprd13.prod.outlook.com (2603:10b6:610:243::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 13:56:54 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d6) by BY5PR16CA0035.outlook.office365.com
 (2603:10b6:a03:1a0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 13:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 13:56:52 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDum0s014425
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Sep 2024 21:56:51 +0800
Received: from NAB-HP-ProDesk-600.. ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDukkn028151;
	Wed, 11 Sep 2024 21:56:46 +0800
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc: yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Subject: [PATCH 0/2] Add framework for user controlled driver probes
Date: Wed, 11 Sep 2024 19:53:17 +0530
Message-Id: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH4PR13MB7195:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: efc81dd0-f391-4a7c-342c-08dcd2699762
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZLbE2dTbQugX8FqdRUmTpfZBhTNOS9v+YdZ9TTbhI5bBa+ltfATBmiHlNGo?=
 =?us-ascii?Q?iqNq4qy90Rs6biROcrpx81gsTGjeTsvketSW2i+6H5QBhNqjOry4kXRCgZ/H?=
 =?us-ascii?Q?yHfycdlt3bDouInGKDU9i2vJGdON7xiz8A5ifNCEg7kAutDfFqEr7OsqMFo2?=
 =?us-ascii?Q?XArbsbf6nLHaBCdhdY4+5SqREbnV1+dCDmsfEuSUaMWP8kPeVMF4rZbnM8Hi?=
 =?us-ascii?Q?925Wrjg+m6TZZ3EmyCgC3B3bb1qDIcO+sY9aXQq0vLzvPewt2DV7cgO2rWfC?=
 =?us-ascii?Q?xGUy4k+58Z57u0yZbCZ2aszrBukTXwHhAhWqY/MC9QvhQInpEQ8AQZzGGrKD?=
 =?us-ascii?Q?H4pEXk7MHsAlGXdgrHfXk4ydtiOuFq+95ya7WtBLzU0m9ybpEw/1KStTQWZP?=
 =?us-ascii?Q?U2KBTiJEeewlU7xXf8IReQXbp+g/yGdlIM5SGkBRGlIPXPTMBwSyN38nVr4i?=
 =?us-ascii?Q?J02KT+6/XaK2iyTisVPhwnu6p0tjgSKrlMqNs62SS7Avr4+SBRvpfqmCCK6M?=
 =?us-ascii?Q?AD3d11Cr85l4HGnOztF6EO30QzpJQpNuO+xnNqTZSpIKKPb7kUF2Ly+YALMn?=
 =?us-ascii?Q?vJfMYGt62O/pKSE58eWwKd5q775Wpwwmc8DmPdY8VYt2X2TKwTPdo5JngPKm?=
 =?us-ascii?Q?MCut8G+2lHGR/bd+EL2cuXViG4WJ+I/POqJR3XTqpbgY6dEQIeVc8xQRWpwF?=
 =?us-ascii?Q?pYCCjuOgmtLOsT313E6DvyE+B9hpfJlxWJWYNSSKAKP1DVWNlF9l7qFIcTe2?=
 =?us-ascii?Q?9qC80IhwUmOshu+CNi78WHkBJn+cb9D0ovuJHW6if8ILbYm7dxHsH9kQfPWk?=
 =?us-ascii?Q?PuyJVhSsJ6yKIsTp17pxeGp5vKeNBgpyaMTcW+ob0d4fNzvGuWqn4fyq3vN9?=
 =?us-ascii?Q?KeZphaPZtN9qq0wBpLrqi/ixTdZCNs0FETjMXtBitIB+FSesuBEp0jV8R+lP?=
 =?us-ascii?Q?yWBBtLLunDKRYU7aQRK3aSY4Ffnr+75tDaxxeNmizlX9qDutAORYexo5vW0v?=
 =?us-ascii?Q?fA7H2KDeOjoVYYrqyqK1WTpAc7LSNAvpta5eocOZ3WuUNqO7NGNra5hpXd/q?=
 =?us-ascii?Q?prYuQ9NTXgA/KzwPUIYq3ZVl6OErhD0tMnub3mUgLMLwS7BBnTHhvgkQtmk3?=
 =?us-ascii?Q?gvjUVoXcsZFZxpsOu3qtUro6nxpE5Dqu9eD1RnNBIR5anTzdAyeYuddihqVY?=
 =?us-ascii?Q?jidbI4bc+nvM2DSHFdBifdQ1H0ZcrENsXZoc53iZcIocGyjESGeTYYNpA8Iw?=
 =?us-ascii?Q?altgH4Imw2QqhqOfa5/b1UFKb0SwL9WY2mk58wOvV0mCkAmXV6nyCWI7LFx5?=
 =?us-ascii?Q?VQ2R63s/jIgxrc4lTiai0sdGB0gJloxz0kEgiZFGru6bSGPgYvZZlLFvT0IN?=
 =?us-ascii?Q?v200thQE5JRiTgIhtG+dZvCJGYwKYHgTCnvOcO71e0w3D0EcrWALrSSTPbj/?=
 =?us-ascii?Q?S7L8szKCiHCL8iWOuX3CKz2TRzy7YwZF?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UoskVsow4tfI7QsSl0n7Bt2d/yAPqhDIyqyMPoFZOFal7rc+cw+Pne5HePDJ/UhxfPZnO2jZyxIWY7q/Vxo7aas9lsxjRvaYuv3//uAWZ5rs1O834rYvQFEPh57i4WOmWU4BYNie8hLj/M1Cp6GL8bFw+7NxeGJLotOZQqFOLd21KGTlIfMvYXQvYCH/1zJoyxP3QMOTyis1Q/eMbpclZj3wZXNXGhpzE4uYeppugJElCYEY+KdvHlCDhNAtot6XRz29uh3w7Ju9XhSYcWCrQ4V6uyyAKieRhUrANPtDY9AtJdakB7//yMjx7dyerJ4syWDK5KzZclcXD1eDR5KLkG0MphEpGb05O7rx3aX8oZjbsrTln090+8Ea4joO3VRIWio2xNYjA2AgZL8Txv18tqyBYUDdN++TCvBKNLFEEVmvFl0R4t52tZ5YvOqttjeQPrGMs7eeZ2UmKbfRkMgYEvoeAebf+80sXr02qr2l2cdGNG0zw2EAiM7+afShW5BKFoggGnLd+hVgd9wVzooFVfs7dFLK/3rDVNZ+QRo93tfiP3UzCcDgKuMPmVeQRckSTGopQkZjVdvNoJmMclVjm1paWf3Vd7nrHMr6cLcHTeSDZI4dvf+4jZRpg3WxPgfR
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:56:52.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc81dd0-f391-4a7c-342c-08dcd2699762
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR13MB7195
X-Proofpoint-GUID: hVSpMxmOW4tT4JzE_XAq4-oxQVkhA-lU
X-Proofpoint-ORIG-GUID: hVSpMxmOW4tT4JzE_XAq4-oxQVkhA-lU
X-Sony-Outbound-GUID: hVSpMxmOW4tT4JzE_XAq4-oxQVkhA-lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

Hi,

This patch series introduces a new framework in the form of a driver
probe-control, aimed at addressing the need for deferring the probes
from built-in drivers in kernels where modules are not used.
In such scenario, delaying the initialization of certain devices such
as pcie based devices not needed during boot and giving user the control
on probing these devices post boot, can help reduce overall boot time.
This is achieved without modifying the driver code, simply by configuring
the platform device tree.

This patch series includes 2 patches:

1) dt-binding document for the probe-control driver
   This document explains how device tree of a platform can be configured
   to use probe-control devices for deferring the probes of certain
   devices.

2) probe-control driver implementation
   This provides actual driver implementation along with relevant ABI
   documentation for the sys interfaces that driver provides to the user:
   /sys/kernel/probe_control/trigger - For triggering the probes
   /sys/kernel/debug/probe_control_status - For checking current probe status

TODO:
 * Fix changenotice warning related to MAINTAINERS file update based on
   community feedback for the patches proposed.

Thanks, Nayeem

Nayeemahmed Badebade (2):
  dt-bindings: probe-control: add probe control driver
  driver: core: add probe control driver

 .../ABI/testing/debugfs-probe-control         |  14 +
 .../ABI/testing/sysfs-kernel-probe-control    |  13 +
 .../probe-control/linux,probe-controller.yaml |  59 ++++
 drivers/base/Makefile                         |   1 +
 drivers/base/probe_control.c                  | 275 ++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-probe-control
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-probe-control
 create mode 100644 Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
 create mode 100644 drivers/base/probe_control.c


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.34.1


