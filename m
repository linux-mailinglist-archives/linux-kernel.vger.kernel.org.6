Return-Path: <linux-kernel+bounces-325210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E48975632
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EEF1F25117
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6861A305C;
	Wed, 11 Sep 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="VtJbLr+3"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902C1A2C21;
	Wed, 11 Sep 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066638; cv=fail; b=AS1PrIozV50DpbDXGertdgAqIvO95KXd8R/CIAqftrhRV3QqSbFA8CXqZtzrOyaS4bd8U1zFEwKqgMWrMIrPkeSG2IFRnlcf9jA0B7fTI9ijK3fRXPAyp+6L55xujwGFB+5v0JQZrJs8U2MUcb5ABlUmukh//9ygU8pElJ6yHAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066638; c=relaxed/simple;
	bh=kPcCtiXdC4Hqs2i+EGoAUBlRdl6TaHyF9Z0e3tlETIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUfNke76kV0gc0k5dqQhcIjzISw29HuHqwCwK5KvNph9xinazrqkDkI3J9WpnQcze1wHAkgjHETRQUdcfOcrXrPGrOGFtxsRm0ERt6Ew8kbzDqWb0t6lz+1j/mZKcN9f3zJDOLkE/0niqGWYkrhMbQcn724EIwANU6U3JIjx7A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=VtJbLr+3; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BDpCMF006872;
	Wed, 11 Sep 2024 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=okXKix+
	wMsPjGad5wRbAqTaDqhk0dwlt53c5jOo+FQs=; b=VtJbLr+3EI94iR8kH1Fq0tV
	O59w1Q7OCsxQ3BumSjc9lDJajtzP8LFxoTaC/fi2ZKozI/grGCWVUiLyRfzzLcMf
	73iRLGgONGef8+AwTf8jwKT5gLa44K09763P1yc5TL93viQLFB3HWHRvvihR+4I+
	1hlkbgyrXAei/rdQ61p0ucjsII9mJBCZshobnl5F7txKcrydswmDLoBlx7K4M8GE
	H684hAorZo17jez4Vm9v3HE6QhrVOtrKQRO7GF4uaIvNjeC4+C6qDBFd8KdK2eTg
	ktDk9M2amy+S4NisWVt0rBIJNRJddKPNbxDaFPjdTa2Z+R6tgumZ9+iLIrUogqg=
	=
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41jv568rh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 13:58:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e63Me4nAIkxn+8C9IIscO5MkClXsXXpuqm1YWYHtBU8jxq5V5mzPBl9nkhxmypPfGMPUi8F5N8KOKPwO1Pr79SgGNN4xtjOoZyVzUPDmAx10K9LgnVsAVSkG7vB+k1e4O+o3O75zjXao7XbRW/WJH14Hm/W0iJQvZ0iS7ws/x79WNvX25LpeC3ODpbRBo3TsS3aIA1iRqtW+Bh9//R8oW+ffIZT0eI8HEZXCoA/yqK1GJfCyB4kmuNCUPbzrw8YxyhqV0pnpI7eGh4vyg9dnTJZkDKssRonNIfUsJ2tSqVjaCiHZQ/Ih3j/vyzwU72+ugVmoLvUk+BJR3hVruvxCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okXKix+wMsPjGad5wRbAqTaDqhk0dwlt53c5jOo+FQs=;
 b=AQGqfIQ0bsQrgphhNrQxoYyYSF0dLPQzzlIrKAx0kuVVnxvhPtwUzzhnPFypMNUDM2ft8u33vcKv+9oXEHGm21Jnm/IN+dqBMqg+Tdwgw4srFYShD2+FYkTx7SyZQhZ1E0Ok/H4a45p9s9w2LoSirUQsZE7TOBrBhddwIbgEJlglrLhpSWFQcba6JBszQNXQ9t1qyVeGPR/rcqNoOTeCdyervXY7j1DmAN3GSuXh2x+hiR/ci2mTK/InoO5nbAW7JHyJVRW7mzB9Q0pYw9RRe4/OOKE2CO2Mr6WCen+sNQkoxkkqMTeG07YRnjU42T1XAqWIYZvlrUyz/adbri+FHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BN8PR15CA0057.namprd15.prod.outlook.com (2603:10b6:408:80::34)
 by IA3PR13MB6951.namprd13.prod.outlook.com (2603:10b6:208:533::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 13:58:10 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::de) by BN8PR15CA0057.outlook.office365.com
 (2603:10b6:408:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 13:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 13:58:07 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDw5K3007895;
	Wed, 11 Sep 2024 21:58:06 +0800
Received: from NAB-HP-ProDesk-600.. ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDukkp028151;
	Wed, 11 Sep 2024 21:58:04 +0800
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc: yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Subject: [PATCH 2/2] driver: core: add probe control driver
Date: Wed, 11 Sep 2024 19:53:19 +0530
Message-Id: <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|IA3PR13MB6951:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e3c6af91-ad92-4ce6-d976-08dcd269c459
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYnPQL/kLcN/MuPpiy+TKY4S5q94K7Jfp5v/cQPJYDQwHST4OoIxwvXdsLGA?=
 =?us-ascii?Q?TXKHJJdCYYTsGAFqLq9ZH9Vtu+TJvPHSZY+oJXq4ZacXibqvSAcIzH7d2n8v?=
 =?us-ascii?Q?tfTX5h1mF84SEo/Ip/fzNSeI8tPfmIqx1eesN0x6mnrmb1WSiebg2DHaWG6y?=
 =?us-ascii?Q?YHhaxdLZV3GRN+PSajieEV3mBZYi2NJ2i0AhcI3AWw7YZRuSKmp4mUR1R8dk?=
 =?us-ascii?Q?OMwWEfVyOJ0uKPAtdQ6yPSeCRX6ES6G+YdcpiR5aQRLHIRxKjcD+64e12bzG?=
 =?us-ascii?Q?UyMg2bE/FETILa8zVfumPXbzoEjHGI4V0uzzpCywZXHaxpg2ayekNb+RYhCy?=
 =?us-ascii?Q?3p1C2IucRW4cFc3hTdVrUE9DVuWIZnqoPgTxYaJM5bLDf66LMIFZGGPGQgpf?=
 =?us-ascii?Q?2O/U0Ohc1oZp9UIh0B/OAgibeBNbZ61wzYwQSYp5jhiPOie8jfrA+PUz6jbk?=
 =?us-ascii?Q?V8jyHN9BGJC/ldIQmZNymPUeeMisesQV+wNS5cf7/fWEhYAlTSNwIPD6MMI1?=
 =?us-ascii?Q?/PXg1iayxYej3fCezylsblT0npncqH6NvWT4RD/Mb9eLY1er7Dgh/zinCqNG?=
 =?us-ascii?Q?roNEG0hUH5R/IFn5nImZaRP4tgb7k87npkG64T+B7vfQG/H29Q0MqKbUZJb7?=
 =?us-ascii?Q?X0cWz9F1hRlxAV0f8R6A+ut2Tyhb1VS1LA9sRo14YGkP5RkLhctsjTBypX5+?=
 =?us-ascii?Q?FlFI18s0U2t1wAJ08BzOzYCke7yc6U7iTgY1OyUJ6s8XFmIGaL555iivocg/?=
 =?us-ascii?Q?+ZDQIWd72pSFj/do2WwSpzZtWm0Wk+s9WVlbfgFzNqeL4h3Cioy39TZTIPPk?=
 =?us-ascii?Q?/ThMNoBZ9bTz9JXlPRLOFgS+MRsw4YDt6bYYWWJ438QHw7QXIF4Ecsrr8wVP?=
 =?us-ascii?Q?1KrUGkgfKY0i9+QmRnzEJEZqhe3musojJMNrcFT/eYK7MU4QsJjCj0nIe1tE?=
 =?us-ascii?Q?vQReBc91GbNMXaZL0FAs+of8JDSLvffEp27r0oYo6l96Y+EyZIsQPDFKf9mW?=
 =?us-ascii?Q?d1aX9VElh00nD8CHIEZ4yu7y3DcFgVg4UbADSoWpXWZUqsPM10wXyltqjq0n?=
 =?us-ascii?Q?VOg6c60UjWVQMDOznSO7dLZk5N6XQd2T/g1q4YdbibyD7Ax8YTsJ1U+4UXcq?=
 =?us-ascii?Q?qwFoergmKgmzldWzNn/aeap7zFwMZtU07NtgocJ5sG8jmhrXOoFuAeI3vwoW?=
 =?us-ascii?Q?h6ZL9HDVpjFID+RNlc3Amdx1DQznPzPFIX1MgcJslG8tz24G1N/t1zL4n4Kv?=
 =?us-ascii?Q?NmDn+op6s5PSFh04E88lblAsAIyN6qogBFm7twoTuAo01cQ08ZnedIjfWiTH?=
 =?us-ascii?Q?+pZDOVYTorZORzfqXb0fuZIhTdUZCnnsumCbsf0RgN0YdLpOyI8PLM7XM5GN?=
 =?us-ascii?Q?ZfVoXIsdwZgIDEwmGBNBqzQr3EbtosG1F0Dbjd4p+kbW+kUxtNhKuA8f5Hl6?=
 =?us-ascii?Q?hGMsW9WkDl/L0VXJm6rDUgpB9HvXZyFR?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/qY6h3a9Hky3yqE+IIhm/r9mODd4n5hZ1Ng52V3FFuXTtFfqO8DBj4oVC3s2frc97ewgRdRtrxpM50l+RQ1XgT98zVUFWiM8DXHl3Zb9BUJoSl22GDDEqSYLZmT2zS3DJo1TW3omQS4H52LptjHi28qCkYg8kzEg5mPn4cX2kABHis2Uoj35HciSzrbUHlwHN9D/nnaF3Jt6DHi1Xvdifo0MX9zulSYGSCIcYnxTMCDMzsarNk7ZFccEuLBPGPul+r172wcU7+qN9jHYAusu9qbXkcQLEQvW3jFsRM187eRetZSILu1tDWt0teUeMddzju/QXt/dmimsaoVyInw+oSwYCUvgN1ChizfPiT/8tAHL4meucfaYIM+F2LrGj7jIh1ad+PE2GgvGb88ju/20m18Woj6n6Neoa7+AfS0oa/7ZTabR73RO8kLXy6r3jsh4JU7uU5KstIWdyrYNQBZTLyKqQj0oFw5pgVYjOsLJMjw0L203nzIRQj+TD++H3VVUuocmVwBWRcwFCMB/Tl1b6lcoSCqewUV1PxobySVrlAMqsmNdk19/trwSY+wyTryK51QY4nXrfcxQsKaN6FiraRct5fhou24OfIkcS5QaNqR7sHBpQyW9EZfZvgqK6MwB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:58:07.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6af91-ad92-4ce6-d976-08dcd269c459
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6951
X-Proofpoint-GUID: pYYv0bKABVrK1drdbmq9PnLPkEu0CeLV
X-Proofpoint-ORIG-GUID: pYYv0bKABVrK1drdbmq9PnLPkEu0CeLV
X-Sony-Outbound-GUID: pYYv0bKABVrK1drdbmq9PnLPkEu0CeLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

Probe control driver framework allows deferring the probes of a group of
devices to an arbitrary time, giving the user control to trigger the probes
after boot. This is useful for deferring probes from builtin drivers that
are not required during boot and probe when user wants after boot.

This is achieved by adding a dummy device aka probe control device node
as provider to a group of devices(consumer nodes) in platform's device
tree. Consumers are the devices we want to probe after boot.

To establish control over consumer device probes, each consumer device node
need to refer the probe control provider node by the phandle.
'probe-control-supply' property is used for this.

Example:
    // The node below defines a probe control device/provider node
    prb_ctrl_dev_0: prb_ctrl_dev_0 {
        compatible = "linux,probe-control";
    };

    // The node below is the consumer device node that refers to provider
    // node by its phandle and a result will not be probed until provider
    // node is probed.
    pcie@1ffc000 {
        reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
        #address-cells = <3>;
        #size-cells = <2>;
        device_type = "pci";
        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
                 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;

        probe-control-supply = <&prb_ctrl_dev_0>;
    };

fw_devlink ensures consumers are not probed until provider is probed
successfully. The provider probe during boot returns -ENXIO and is not
re-probed again.

The driver provides debug interface /sys/kernel/debug/probe_control_status
for checking probe control status of registered probe control devices.
 # cat /sys/kernel/debug/probe_control_status
 prb_ctrl_dev_0: [not triggered]
  Consumers: 1ffc000.pcie

Interface /sys/kernel/probe_control/trigger is provided for triggering
probes of the probe control devices. User can write to this interface to
trigger specific or all device probes managed by this driver.
Once the probe is triggered by user, provider probe control device is added
to deferred_probe_pending_list and driver_deferred_probe_trigger() is
triggered. This time the probe of probe control device will be
successful and its consumers will then be probed.

To trigger specific provider probe:
  # echo prb_ctrl_dev_0 > /sys/kernel/probe_control/trigger

To trigger all registered provider probes
  # echo all > /sys/kernel/probe_control/trigger

Signed-off-by: Toyama Yoshihiro <yoshihiro.toyama@sony.com>
Signed-off-by: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
---
 .../ABI/testing/debugfs-probe-control         |  14 +
 .../ABI/testing/sysfs-kernel-probe-control    |  13 +
 drivers/base/Makefile                         |   1 +
 drivers/base/probe_control.c                  | 275 ++++++++++++++++++
 4 files changed, 303 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-probe-control
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-probe-control
 create mode 100644 drivers/base/probe_control.c

diff --git a/Documentation/ABI/testing/debugfs-probe-control b/Documentation/ABI/testing/debugfs-probe-control
new file mode 100644
index 000000000000..3cd08906031a
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-probe-control
@@ -0,0 +1,14 @@
+What:		/sys/kernel/debug/probe_control_status
+Date:		September 2024
+KernelVersion:	6.11.0
+Contact:	Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
+		Toyama Yoshihiro <yoshihiro.toyama@sony.com>
+Description:
+		Probe control driver debug interface, that shows registered
+		probe control devices which were defined in platform's device
+		tree, their probe status and respective consumer devices.
+		Sample output::
+
+		    # cat /sys/kernel/debug/probe_control_status
+		    prb_ctrl_dev_0: [not triggered]
+		     Consumers: 1ffc000.pcie
diff --git a/Documentation/ABI/testing/sysfs-kernel-probe-control b/Documentation/ABI/testing/sysfs-kernel-probe-control
new file mode 100644
index 000000000000..4602f41aa025
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-probe-control
@@ -0,0 +1,13 @@
+What:		/sys/kernel/probe_control/trigger
+Date:		September 2024
+KernelVersion:	6.11.0
+Contact:	Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
+		Toyama Yoshihiro <yoshihiro.toyama@sony.com>
+Description:
+		Write-only attribute that allows user to trigger probing of
+		probe control devices.
+		Write specific probe control device name to trigger probing
+		of only that device or write 'all' to trigger probing of all
+		probe control devices.
+		Writing a probe control device name that is already probed,
+		will result in an error.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 7fb21768ca36..4e2b115ea929 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -7,6 +7,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o
+obj-$(CONFIG_OF) += probe_control.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
diff --git a/drivers/base/probe_control.c b/drivers/base/probe_control.c
new file mode 100644
index 000000000000..6cfc03df6c33
--- /dev/null
+++ b/drivers/base/probe_control.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * probe_control.c - Probe control driver
+ *
+ * Copyright (c) 2024 Sony Group Corporation
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/device/driver.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+
+#include "base.h"
+
+/*
+ * Overview
+ *
+ * Probe control driver framework allows deferring the probes of a group of
+ * devices to an arbitrary time, giving the user control to trigger the probes
+ * after boot. This is useful for deferring probes from builtin drivers that
+ * are not required during boot and probe when user wants after boot.
+ *
+ * This is achieved by adding a dummy device aka probe control device node
+ * as provider to a group of devices(consumer nodes) in platform's device tree.
+ * Consumers are the devices we want to probe after boot.
+ * fw_devlink ensures consumers are not probed until provider is probed
+ * successfully. The provider probe during boot returns -ENXIO and is not
+ * re-probed again.
+ *
+ * The driver provides debug interface /sys/kernel/debug/probe_control_status
+ * for checking probe control status of registered probe control devices.
+ *  # cat /sys/kernel/debug/probe_control_status
+ *  prb_ctrl_dev_0: [not triggered]
+ *   Consumers: 1ffc000.pcie
+ *
+ * Interface /sys/kernel/probe_control/trigger is provided for triggering
+ * probes of the probe control devices. User can write to this interface to
+ * trigger specific or all device probes managed by this driver.
+ * Once the probe is triggered by user, provider probe control device is added
+ * to deferred_probe_pending_list and driver_deferred_probe_trigger() is
+ * triggered. This time provider probe will return successfully and consumer
+ * devices will then be probed.
+ * To trigger specific provider probe:
+ *   # echo prb_ctrl_dev_0 > /sys/kernel/probe_control/trigger
+ *
+ * To trigger all registered provider probes
+ *   # echo all > /sys/kernel/probe_control/trigger
+ *
+ * For details on configuring probe control devices in platform device tree,
+ * refer:
+ *  Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
+ *
+ */
+
+#define MAX_PROBE_CTRL_DEVS 50
+
+struct probe_ctrl_dev_data {
+	struct device *dev;
+	bool probe;
+	struct list_head list;
+};
+
+static LIST_HEAD(probe_ctrl_dev_list);
+static DEFINE_MUTEX(probe_ctrl_dev_list_mutex);
+static atomic_t probes_pending = ATOMIC_INIT(0);
+static struct kobject *probe_ctrl_kobj;
+
+static int probe_ctrl_status_show(struct seq_file *s, void *v)
+{
+	struct probe_ctrl_dev_data *data;
+	struct device_link *link;
+
+	mutex_lock(&probe_ctrl_dev_list_mutex);
+	list_for_each_entry(data, &probe_ctrl_dev_list, list) {
+		seq_printf(s, "%s: [%s]\n", dev_name(data->dev),
+			data->probe ? "triggered" : "not triggered");
+		seq_puts(s, " Consumers:");
+		if (list_empty(&data->dev->links.consumers)) {
+			seq_puts(s, " None\n");
+			continue;
+		}
+		list_for_each_entry(link, &data->dev->links.consumers, s_node) {
+			seq_printf(s, " %s", dev_name(link->consumer));
+		}
+		seq_puts(s, "\n");
+	}
+	mutex_unlock(&probe_ctrl_dev_list_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(probe_ctrl_status);
+
+static void enable_probe(struct probe_ctrl_dev_data *data)
+{
+	/*
+	 * add the device to deferred_probe_pending_list
+	 */
+	driver_deferred_probe_add(data->dev);
+	data->probe = true;
+	atomic_dec(&probes_pending);
+	dev_dbg(data->dev, "enabled probe\n");
+}
+
+static ssize_t probe_ctrl_trigger_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct probe_ctrl_dev_data *data;
+	int probes_pending_l;
+	int ret;
+
+	probes_pending_l = atomic_read(&probes_pending);
+	if (probes_pending_l == 0)
+		return -EINVAL;
+
+	mutex_lock(&probe_ctrl_dev_list_mutex);
+	if (sysfs_streq(buf, "all")) {
+		list_for_each_entry(data, &probe_ctrl_dev_list, list) {
+			if (!data->probe)
+				enable_probe(data);
+		}
+	} else {
+		list_for_each_entry(data, &probe_ctrl_dev_list, list) {
+			if (sysfs_streq(dev_name(data->dev), buf)) {
+				if (!data->probe)
+					enable_probe(data);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&probe_ctrl_dev_list_mutex);
+
+	if (probes_pending_l == atomic_read(&probes_pending)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	/*
+	 * Re-probe deferred devices and
+	 * wait for device probing to be completed
+	 */
+	driver_deferred_probe_trigger();
+	wait_for_device_probe();
+	ret = count;
+
+out:
+	return ret;
+}
+
+static struct kobj_attribute probe_ctrl_attribute =
+	__ATTR(trigger, 0200, NULL, probe_ctrl_trigger_store);
+
+static struct attribute *attrs[] = {
+	&probe_ctrl_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static int probe_control_dev_probe(struct platform_device *pdev)
+{
+	struct probe_ctrl_dev_data *data;
+	int ret;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev,
+			"driver only supports devices from device tree\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&probe_ctrl_dev_list_mutex);
+	list_for_each_entry(data, &probe_ctrl_dev_list, list) {
+		if (&pdev->dev == data->dev) {
+			ret = data->probe ? 0 : -ENXIO;
+			mutex_unlock(&probe_ctrl_dev_list_mutex);
+			dev_dbg(data->dev, "probe return: %d\n", ret);
+			return ret;
+		}
+	}
+	mutex_unlock(&probe_ctrl_dev_list_mutex);
+
+	if (atomic_read(&probes_pending) == MAX_PROBE_CTRL_DEVS) {
+		dev_dbg(&pdev->dev,
+			"Probe control device limit exceeded, probing now\n");
+		return 0;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &pdev->dev;
+	data->probe = false;
+
+	mutex_lock(&probe_ctrl_dev_list_mutex);
+	list_add_tail(&data->list, &probe_ctrl_dev_list);
+	atomic_inc(&probes_pending);
+	mutex_unlock(&probe_ctrl_dev_list_mutex);
+
+	dev_dbg(data->dev, "Added dev to probe control list\n");
+
+	return -ENXIO;
+}
+
+static const struct of_device_id probe_ctrl_of_match[] = {
+	{ .compatible = "linux,probe-control" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, probe_ctrl_of_match);
+
+static struct platform_driver probe_control_driver = {
+	.probe          = probe_control_dev_probe,
+	.driver = {
+		.name	= "probe-control",
+		.of_match_table = probe_ctrl_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init probe_control_init(void)
+{
+	int ret;
+
+	probe_ctrl_kobj = kobject_create_and_add("probe_control", kernel_kobj);
+	if (!probe_ctrl_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(probe_ctrl_kobj, &attr_group);
+	if (ret)
+		goto out_err;
+
+	ret = platform_driver_register(&probe_control_driver);
+	if (ret)
+		goto out_err;
+
+	debugfs_create_file("probe_control_status", 0444, NULL, NULL,
+			    &probe_ctrl_status_fops);
+	return ret;
+
+out_err:
+	kobject_put(probe_ctrl_kobj);
+	return ret;
+}
+
+late_initcall(probe_control_init);
+
+static void __exit probe_control_exit(void)
+{
+	struct probe_ctrl_dev_data *data, *tmp_data;
+
+	kobject_put(probe_ctrl_kobj);
+	debugfs_lookup_and_remove("probe_control_status", NULL);
+
+	mutex_lock(&probe_ctrl_dev_list_mutex);
+	list_for_each_entry_safe(data, tmp_data, &probe_ctrl_dev_list, list) {
+		list_del(&data->list);
+		kfree(data);
+	}
+	mutex_unlock(&probe_ctrl_dev_list_mutex);
+
+	platform_driver_unregister(&probe_control_driver);
+}
+
+__exitcall(probe_control_exit);
-- 
2.34.1


