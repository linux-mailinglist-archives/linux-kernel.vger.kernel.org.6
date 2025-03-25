Return-Path: <linux-kernel+bounces-575094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256CA6ED77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1B171205
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E32255E49;
	Tue, 25 Mar 2025 10:18:22 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020141.outbound.protection.outlook.com [52.101.128.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F8255E34;
	Tue, 25 Mar 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897902; cv=fail; b=ZTalqldz27cJFtioFRYeghWeIM29i5fj9oYJulRkEy5K1ZbGdsLyM5lxaDW0MP0qLMrP0sf17qK7Lv1IasLOOjnO74R3PEcK583DoMsvWAZ/0N1X/l+Hh6T38dnAvEJ9F/LGKg3f8nvQn3YnHNlzwSS6wvLKrUUJcm8Whkk/yHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897902; c=relaxed/simple;
	bh=BQOH410D1CucFZNYkwi9JFwxsaurzgYktUTCdYko/2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iiPlPEcEFYoTzqeb/nhm8aHCgHWrzS6FkKMtazJnCP3ALgzJvffXdx1gdw5K8bNz3rbWEMqT6W9Tey3nlxygnEtdUDRQM+eFtEQQq8uZCeb2nT4f+wNwTJfVTwHtuKyM4qFzkuMgXDm85cSvAjZYPpvU8bRo4a8RNxnMG2e8INI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMr0xiT8Lp4GBq6fubs6daSR+NR7seeJjd5xGWmE6tghR/iQeeToc5Pn1lvX4JVbGvljvC+VQMM7M1tPCBxIPyzMAtJclBQ3p7MY1eeCDhvQcqUj1yuXXyHVn2x6V0t+zTZzixNHO7ccj/yovuo1V1ldD3ncNIT4Z8MPFoVoieP75ObFJK/i8Ti8+jXo1mdxPHImwMvkTo61f5EqalLSx34DWX30fxccsU9hzFMfLKnFiCjwScAhnBQCMtOdrHdrZz62vVa2rl1Pza0713ZB02I5SNKpMyB/cVJWP8gzUdRvwIyg4mO1Y3kR/tv6OzJ6za1EqqDxk5E3jlC9cmHNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5yF0B8OmdFG/b90WKI/YJJUQx5/OG3MyDkmHqDb6kk=;
 b=ZoTtYfTDdUmKMtD91vA5n8xGZeoCR638nSh+XE1tPyMGhRHkn897xXoA+PB66wwePjPZRq24URJn8ZgYuB+s1pdaUeD4dAlxBvocgfUvNgzdREZa8Cc8jJpF6F4VFR0xvEiKsDR/FDpckcPZpIgDLY4HWNuWwYUJ3fVO9P7fWuOcAD9RzqCR8Pv9EYxyd1az07rSUDwJKvTZef/ahV6fXAzXgO31LPv+EacHsRXsoGDY/sdWGrMPjJveQ91CW+kNMv8r2663t4Ql++ZTeFjnSknNV3O6IW1m9Lq4wvl5o3h8Obg5i3MF5pRbW7AglwprTDB2qXByEGVL9dPCs0bRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0204.apcprd04.prod.outlook.com (2603:1096:4:187::16)
 by JH0PR06MB6438.apcprd06.prod.outlook.com (2603:1096:990:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:18:09 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::66) by SG2PR04CA0204.outlook.office365.com
 (2603:1096:4:187::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 10:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 10:18:08 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8E3ED4160CA0;
	Tue, 25 Mar 2025 18:18:07 +0800 (CST)
From: Guomin Chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Guomin Chen <Guomin.Chen@cixtech.com>
Subject: [PATCH v2 0/2] mailbox: add Cixtech mailbox driver
Date: Tue, 25 Mar 2025 10:18:05 +0000
Message-Id: <20250325101807.2202758-1-guomin.chen@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|JH0PR06MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cc4eb7-5049-4a24-8b46-08dd6b865734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXFYWFVEMGNLd3p5N1lqL0RLNUZVTmpteDZTbDJ4Mzg0ZFdRQm5ENHdpV1B2?=
 =?utf-8?B?NUVYUWFEblNsc2RGaHRsTUhrS0RQME52NkdZS3AzMlN0ak4vVmk2eS93Rm5o?=
 =?utf-8?B?QjZ4NkxYaWdMcXVEeVdOV0o3Z3RISVVVcU1aNWJzcUlDRkl1UmxaM3NJbkxn?=
 =?utf-8?B?UDJnY1B4TGdrRzh4VzROZElXNENYSjZZOHJsRFN0RnB3c3g5NjUrVGJPVDZG?=
 =?utf-8?B?ZUZ0eFlLb0RaT3BXNjQ2ak5DYXdmQm13MW1LNzhVZjRPS3lxVFZzc0UyeGdU?=
 =?utf-8?B?Rlo0WWFIWUc0TmgxUlFwelNGWURSekIxZmZjdk9CWEhXbmlYZ25uY2ZEL2ZH?=
 =?utf-8?B?L08rbEFpVFB0aXc5VnUyY1dKYVFPZnl1Q09GVFlvMHpzN1RSNlkvRFlIamh3?=
 =?utf-8?B?MGdTekFrNzRUeUtWcHNWZFhod002eEpWcWpqaDRudHk0S25SemFnSHJTcmJz?=
 =?utf-8?B?OU1aMS9jbUZ3aWxOYldlanJhTjF1YnROWHBiU3YzUDcyZytJQWhqNStWRjZy?=
 =?utf-8?B?NldDbTRuekUxQTR0aktiT1k0SVlTSHRWWVNyK3FyNkhmRWdrL3dQYVI4aGhl?=
 =?utf-8?B?MHFlZXJoSStIVmV5bXhYd1RsdCtIK2p5VStDSUh2R1Evam14WXR4VVNvZW4w?=
 =?utf-8?B?ZFBkSXJ1cTdGWVl5N2w3dmdzdGRHdDFJaXZBRHN4VUZuNmFFNDhLYmZTRmt6?=
 =?utf-8?B?TWY3WlltNHV5S3dMaXRya2dGQ2VtQ0RKL0NOamcvMkt5T0xSTUZDa0E5R1lQ?=
 =?utf-8?B?SGdZODlXYzlyT3JZWi9ZalpIRld4SUZiUmtMTWhxejlCV1pMcWdpNFM5bFB4?=
 =?utf-8?B?ODJjRlNMZkxvWXhHZjRKbTJXNDRSbWVqZVpPZ2xnZU5nVnZMV3JGSE9wMWl4?=
 =?utf-8?B?dnJ2VHR2NEJiZ0lPTFJ5b21QM3piYXhldkdodC9wVEMvbVA1T3g0NjA2aW9E?=
 =?utf-8?B?MHdoQXNrUWs5NnlpWVdkZk9vNUQ2bVY3eW9NNE9PR0dMZVRJdXhlNFNXUS9O?=
 =?utf-8?B?OEZqNkhlK3owSnd1ZWpKOFlUckFSbFFDYk5ta2VRTkFmbEhiZXEwbTY1dE5T?=
 =?utf-8?B?R2dXTnpKWmtMUDdUTTI2UEdIUjAwelUvMERQK2NwK0p1M0Npd25pcEFCekJm?=
 =?utf-8?B?cWNlT2t5NHF5N3l6WE1kZmZyMGlkUWtYL3E5WndteFJoRHl0ZG5XZ0xnMVRW?=
 =?utf-8?B?OUVKZVZnSjFHcWRRbFJFTExLZm5FNUt0VE1Da1BkdHNhWHFPZHlSL2dLYU44?=
 =?utf-8?B?bkpoSGlhMFBOSmpWZzdMbW55MFREZksrZ1hPRG55ZEdCazhXY0xHdW1MT0Rh?=
 =?utf-8?B?R2JsS0tQdllSRHQ1MGFiblY1cDdQV1VKS0tYcU9ZbjBHM1JGYnpKeWR3cmFl?=
 =?utf-8?B?N0hMZjJYemRXbEhsQTA0SGNBTWd5S1FERnBuRGFJMUlkcjNMbVUwSEt0dDRt?=
 =?utf-8?B?d1JkSzMrSThjWjlGM3hoM1MzQlV3eW5wa0RUOU0vL2NpbkpsNng5bThVaVlV?=
 =?utf-8?B?eTA0REkwUmhDWktmU2VFTE5GZXplU0FOV1IxZVd6cUNIZXdTcWZKQW1sa09U?=
 =?utf-8?B?MzF6VHI0dEFNL0gvVjFra1grVm1tYngvLzhtcXF6aUk0WjJvSExVUHIvSWdL?=
 =?utf-8?B?aGgrM1QvZjRmcHVEWkFqbDBtSzlBSUY1Qzl3NFdxTC9HRTl2dW1mWVRyNFFU?=
 =?utf-8?B?ZERNaFkxa2NtOWFPb0FpNVBBMk4waUdRVmJTdTBiUkIxTFd5Y0NheStsZFVU?=
 =?utf-8?B?ajAvcHd0Q3ZFNTBuWitlbEkwL2gyRVQwc2ZYa2tsWjR6ZVNUUGM2NG1tandp?=
 =?utf-8?B?M3BGY0lPUmJCRnJPTXZUSVNxQ3JCN1Q4ekxJNmNnN3N4MUh1K09tRk4rWWZh?=
 =?utf-8?B?OGhSQUNxZnJqRmVPNUEzUGtpM3puZTR5U2UwK00wYk5qWnhyTmMzbERacVll?=
 =?utf-8?B?VCs4Q3UwWWNFNWs4azhxUllhZXVGOC9MaVhObURjQkIwWmxUYUVIcjZWZmdG?=
 =?utf-8?Q?z/SX1jekQXFlckZrswBmnfZFG4T1Mo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:18:08.7454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cc4eb7-5049-4a24-8b46-08dd6b865734
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6438

From: Guomin Chen <Guomin.Chen@cixtech.com>

The Cixtech mailbox controller, used in the Cixtech Sky1 SoC,
is used for message transmission between multiple processors
within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
and others.

The Cixtech mailbox is unidirectional, so it typically operates in
pairs—one for reading and one for writing.

Each Cixtech mailbox supports 11 channels with different transmission
modes:
 channel 0-7 - Fast channel with 32bit transmit register and IRQ support
 channel 8   - Doorbell mode,using the mailbox as an interrupt-generating
                mechanism.
 channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support
 channel 10  - Reg based channel with 32*32bit transmit register and
                Doorbell+transmit acknowledgment IRQ support

Changes for v2:
- Update the Subject title.
- Rename the bindings file to be based on compatible: cix,sky1-mbox

---
Guomin Chen (2):
  dt-bindings: mailbox: add cix,sky1-mbox
  mailbox: add Cixtech mailbox driver

 .../bindings/mailbox/cix,sky1-mbox.yaml       |  80 +++
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/cixtech-mailbox.c             | 633 ++++++++++++++++++
 4 files changed, 725 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml
 create mode 100644 drivers/mailbox/cixtech-mailbox.c

-- 
2.34.1


