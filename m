Return-Path: <linux-kernel+bounces-377735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765769AC339
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF1F1F24636
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749519CC0C;
	Wed, 23 Oct 2024 09:13:37 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2097.outbound.protection.outlook.com [40.107.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9E15B547;
	Wed, 23 Oct 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674817; cv=fail; b=mZNeY9nv88BXYp8yotcYiFdNQihWWMv+0hQya1DMgPaHFekXBQOzgCBxJMxaoz6UGxPYn8oMhLFqG7a1U0dFGoX8df3cUUrLGcBr+1zRlBL15aYpQeL4qRT9lTMbcLS1145grkvUK2Ig1NpInIKH4vfG8Rf7VMy3YT3/KJR//oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674817; c=relaxed/simple;
	bh=2RjhCla6GxRf0cfuDHoXBU7H3h/FcRlNzUO/gRvrwdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azfaOZtVocDldRAhcf9Z4egcypIgfnrjU0J6vE9QAC3cr04C0RqaVPioVOPzR5pNA1Ql+vMJgcIKCRlPoi4T41yuwg0929ef/D5M3wU496Q1aALTqWE0FdWXmYV6yN3NpB8fIMt1+MK9xTIGgp4IhWmmpq6fhcQC0ROJS2au1Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjlM4TnKIT9IHlmsSUiNbkALRREGd486OnCTHyyTGL5ZZGqbK0+doWewIIxYS/BKQtUGBFic64qBoxWgKM+FeFuSu2Q5eyYEMpyKO922MDFh6kNywy83s0fKfCnNzXo3Z3sB09uDuMhuy7oP1FtIiKrUo0DnvQv0RUAeDgeIjPf2ttcrI+NenJ2ozrvNnA8svAdM3U4hPo+Yoi00/p5Z39uaVERH5cyIft71GUuvJRcRv2+9XS80eET31MHhtUyXx4fj3HcB9J7Dm355z4/yfUd4rTZmqSDgkCC7XpGq2iwonBlzcLzA+Px1A7qQB5JsoKEdm6ae6W25es+IbR8YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SizgIdNgryjdOlgkT7YRB2O9/7ON0hG/owpTs5VbQAE=;
 b=o8hpKpvmjiC2YmvThAaHVRazaRKphSvHQX5CDTQt4I/FZWfvM4cec2JvbPXx6cTlVhxeVy5D9NpwuEbjzrqUWueQhtZhVy0e5aTQZQk9vKzf2BVgpo5S/R6a3/GFOUceKXDnXyFxaZO/WLj9Ex5TN9mL7v0zrjbS6dx5md6vRAiAjgONl5DbjDwO9fhgdrUF2buVgMtqDmg9dzs8HIMkMJKfBbohtlTCqsnK8F0OGkJd0PrsuOjoSFDRaWk+TmzgYIDXcI/awN9belLYfkIT0qQEbWcKKRWQREirHFcLAk3OYb1kHmtjf5qZERgWztbSmvdjwUMg4nYTccTzIxhsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2PPFDCD372071.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::153) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 09:13:32 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 09:13:32 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Wed, 23 Oct 2024 14:41:15 +0530
Message-ID: <20241023091231.10050-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::6) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2PPFDCD372071:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c164a1-963a-4f51-7916-08dcf342f76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4IN91rlNk1gA617Aa4ooP+FJbFrDVJ9k3wZec5A8e9IYQi/RTMDUDUlx0KU?=
 =?us-ascii?Q?1WU31S4DUA+E73RFRZEx2Ylb+tQL1r+SpXWnwA5MS+M0RADof0WZEUHepLQo?=
 =?us-ascii?Q?SQRN5KgtKXG3dgpR6jkLr8Sjiu0+aJ3KTbT3waaikhpVLYAJ6S5dy5lqqgxH?=
 =?us-ascii?Q?1i2RXT4vCg+vT3raDcBtzdTVaT2fFeA9LfNyrg03oxPHq3neN7PajP0eSjT6?=
 =?us-ascii?Q?TYENEM0h4lZ1QCwpODfvgsxgCZeFaBQR0DN+LE5W01bTP8ZB/+DqHFELyAWY?=
 =?us-ascii?Q?9kCfzRllAu7eRl0Gt3O7qbGyt1LENLCKVbiGbL3hgvYoq0AStDDJWuC75pBq?=
 =?us-ascii?Q?VZDDeIlIjXykijMAElmxcUW3sOWfJDtNnA3Y1f0adN634L/w/VHDbOnEhYtJ?=
 =?us-ascii?Q?a9U1YrTA6Kk3aYRwZEQBrU2sH25zz+tMPfmJkGuL6Y9RTMMjuBUorvjco89Z?=
 =?us-ascii?Q?099FK4HM5jrMSdZoGCxLwqFW1Fg+6JJBJXI7G3FoQvY3D/twxg869TwGwz7R?=
 =?us-ascii?Q?vdospMbh208V6w7F66xrxhddufHs3dwRPvVRQMPb20dPUMsptsHc81Iajy9m?=
 =?us-ascii?Q?cEnHDwkayMmMIKOCf+NAzj8ymkeufAx9OIymgo7xJ0LzpFQNA/lOM6j9xfTJ?=
 =?us-ascii?Q?pSbcUUu+Q4LR5iJal8cu8CeF99+o7w3UTRsSyeU2SB+WYpe4ei8GabyMIxNs?=
 =?us-ascii?Q?i1fprpRa3XEXCREAVJ5678keQ89TQoIBGx0kV7N1v2mfWw1hCmKMwyAItIOF?=
 =?us-ascii?Q?QpB6Z1bappeizuJnGjGagXedmh8SO9Q5cyX5BO0DMoqDiqI7NQYJGZIfYdXE?=
 =?us-ascii?Q?UKnkAL1ZkUGPDzuZ0skwkYjWkVVdKi0Y85FSj/FsfYdxUmQZ87smo9cToPpd?=
 =?us-ascii?Q?eFpa0rh6kYiSmjd1B11wYQ0Bl/8Cb115wEGQtfcngoubZwol57PmUVs/K+uc?=
 =?us-ascii?Q?Eo3FGMtLxbiUP2D/VuomTluljOBsN3ySXwHy/Tw1hlsbClvd37GcanrDcqYA?=
 =?us-ascii?Q?yVb5QdMrsyp7YmFBM+2KbQaP9GYgZbO79CMYNGgliWFiAP2QfcGnbVoTZbyl?=
 =?us-ascii?Q?EEmwxR5KXncErFmgdfl6RfXV8jgoBjOjGAE+4iHxNNA1CuomF+TIEKoeNNvA?=
 =?us-ascii?Q?K36e6S63zQOzgqfqlTwnvfCv9ACNW07kZVfQT1ZdjXUhWAI4UOoJ+Djiurfd?=
 =?us-ascii?Q?o8Y2vtIOAWhiN71VtMLl/u1Rh8iC5cwMMD8v9uoMGFsjIpjEhLSzKme0Y+RD?=
 =?us-ascii?Q?84+bloYfgJtfu3/Gmnl72u0XYaY3cmNtYm0LzxkCf7hdo8Nur7FFfQjOwTgx?=
 =?us-ascii?Q?Ojltj8f0BoFD+q/uyAd6Qfws6Cu5JPmHcj8Wtt0buWngG7nNDYKq/NBLDb97?=
 =?us-ascii?Q?bMrxvW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2lrmGSV/mtX9qQN9NweBqj8mROkTCn+/+EynbECTCk57xghXls79bWrEU8p?=
 =?us-ascii?Q?HL3VrbwwBNYJ9FUm5iQBq+GopPt1HzGAvg4O0UmWPzSWhFqjgU8E9LKbx+0E?=
 =?us-ascii?Q?Lj53dguu0lT0FiCD+Lxqod4PFENncsD39MD0YMCBk4IlgoYt81VB8UmMKzgV?=
 =?us-ascii?Q?Mnh3J99SpgQtEiVVhaoQ2eAjRPyVPoecY5chk7/nN9ioq4JWO3rOMuesM8S2?=
 =?us-ascii?Q?36ke4WrB1Ftog+NPLwuSphNfZ5/yAXj0dz3XHJchjwKRnz2Pa3Bz4I0Q1Q/i?=
 =?us-ascii?Q?t728oq0Ig10LLy38+mw3t5Ospy8S4rdQEPNy53BaxbKHXPJE/O7LPUWM0oAy?=
 =?us-ascii?Q?OgxRqMmqElJMZNK1UwsDJUlIYjaHIREQE1W5rRJ69BBHcq5JaCg9n2O9M0rv?=
 =?us-ascii?Q?eTDrmXJS9yJZnOgJ87cyCz9mAf/roqNvDLBXpBbIztt+bwNz1IFNCMhqg+RA?=
 =?us-ascii?Q?5GveCSzM79rdS1nM1XgzbYl/ss5hcxwurZ4u77jjzZD1dhopLOZDlourWrVZ?=
 =?us-ascii?Q?jcLGDNlgLirdflrUMuNxngLNhSWtvVjT4buCKVmrufxBzL3TrQbnl1QdLA+a?=
 =?us-ascii?Q?dUgzXtUXPFnNDJ81RSteIRpH4BmasSxT15Vn94ALp7m2aGn/dzOVaDyn+3UB?=
 =?us-ascii?Q?CjbgOshBLP7s8oqX4/AJHgp7zGd7CaDT5pUVfKog8bKZUbJVPupKH2PPT9/c?=
 =?us-ascii?Q?UPjB/uywbRY8OaYvb83Kn4d8xvVW5pXwrlKgyXHsp9rc5Aa8kts1GqowpAOh?=
 =?us-ascii?Q?9ItudidjZTbwPWBDwuK7g6NKTTcfIzhxCIjaZw7TQbTMvGbJi5megGmlbf1y?=
 =?us-ascii?Q?nDkNpm3HuWzFoEhpxJC1JPJlZ8/lDBjE3k+QuWntcP37s4Cs4hWrZSAKCfc/?=
 =?us-ascii?Q?gS95E7PJIoifOp4NwSOhQXYq/cHlBG+C7nrYed9TyECw5624CE+MesCc9W88?=
 =?us-ascii?Q?zyi7y8H/JoSBuejagMFZrBSROgtDo5XKw75xFFMhxZS0iYhhyGedQGeytVHR?=
 =?us-ascii?Q?Eu9yrVyoIpuiwaXUIxmn8ZQjOJmH3HkZ+9xTvx6DwKOZZ7T6orH9WYexlMvQ?=
 =?us-ascii?Q?wUjZM6Z4mqb4hF06vOlc0qj+cNWUoYZlsruXRPlF8KlRkSntq0KiTTEWBk4h?=
 =?us-ascii?Q?lPuXfZi96dSaQpVp+AuH+v2vYcK7PYyVXWdg5O/OwUocS8vmEgWDTnRa0LGr?=
 =?us-ascii?Q?2VfbFcL583QNJy3DKgVrn1tTQx8EmDj+AgVRZSEhfwl6eOK7YzHQXHi2qbEr?=
 =?us-ascii?Q?183pKkC8ljJJ/uXPjTFQ9DGrlbMmjNUoqP2r55fWuTPQqyJGxvUrDjc/CcM9?=
 =?us-ascii?Q?bhJ8B6PuYLWNq6xsuY4aYi0MxlgFew62uRwvNl0EzU1uHc1C6xlZ3FcQyvHG?=
 =?us-ascii?Q?2zoxsGRP2Xp/OI/ARI95/i8RDL3eMRoXjxWOLdEKhiyyY93u75Z2KJIPIodH?=
 =?us-ascii?Q?kxgXNBen/Iuz6IjlkmzJsBz2EBLpj6CNRa8l8o6p6mQFzHj7usDyspFjwBgB?=
 =?us-ascii?Q?E2eOWImaaQnFMyhGDwZmBPkvPyreMNOMNf+UGgGSFhbrrQ4G72P8mCZ8vxgF?=
 =?us-ascii?Q?/sx7qCRbM7KuFdT+044HSdJCVUhG2+AJRIAmxnpLaDbW2d11ZJqPEOMplWCC?=
 =?us-ascii?Q?wF2r/++1xFuY5NZiKLr28gs=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c164a1-963a-4f51-7916-08dcf342f76a
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:13:32.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIIU1S/XL3zK5CwwWcOCh9faL3kcjbqMhddXuxM6LlnhdbSbmso+N2Hvf2wAZBAxMApodzbtizZO4GRDq60e4X0inJ6dY36Mb3Zs5L6Ggcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFDCD372071

Adds support for the Nitrogen8MP SMARC System on Module and
the Nitrogen8MP Universal SMARC Carrier Board.

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..58979c030519 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1097,6 +1097,12 @@ properties:
           - const: avnet,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
           - const: fsl,imx8mp
 
+      - description: Boundary Device Nitrogen8MP Universal SMARC Carrier Board
+        items:
+          - const: boundary,imx8mp-nitrogen-smarc-universal-board
+          - const: boundary,imx8mp-nitrogen-smarc-som
+          - const: fsl,imx8mp
+
       - description: i.MX8MP DHCOM based Boards
         items:
           - enum:
-- 
2.43.0


