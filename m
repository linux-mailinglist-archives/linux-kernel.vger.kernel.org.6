Return-Path: <linux-kernel+bounces-397343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECA9BDAC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A4E1C22CED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639614A4FF;
	Wed,  6 Nov 2024 00:58:22 +0000 (UTC)
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021111.outbound.protection.outlook.com [40.107.42.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99351130A54;
	Wed,  6 Nov 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854702; cv=fail; b=WUXbQxzj0Hhj8dGZs0yFlOLh0E89+pB97sZN6UPaV1rxRON2+TSjm6GwLIRYvuOCvRADxZlOgYSjyxebLGF9axaI/PAn/cQ7uuK+l7yQBuukrMRy0852gl2J36mLdqYAZSo4rV7xfmYQOveji65TYyZaJ02Pl6Eg8rZYKoD7GOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854702; c=relaxed/simple;
	bh=XWRbryqSgfMo81szwgk91HGUrrb+ZPB0GxVRluyDt3o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DSBeaVYSswpP7O3R411zOWCpyWLr5WNHGjrcRQDBNZ+4c4cZw4szO2AKpIuG8C/Kis5w9JUXFdZiHSgsgMoixQgi+WlEpYMkG149yceLVwy6GPbAu3hjAd3/s85+n5O4s/0/iEwA0+ocVYE69KHUrMDebTDVYwXfZmUb4p1JyhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irondevice.com; spf=pass smtp.mailfrom=irondevice.com; arc=fail smtp.client-ip=40.107.42.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irondevice.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irondevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAlbo7t35+oc7ff1a2zbKOFTV3K8Be5kqvnqWajNc32dAgW06HoN79xoaFIN9vi+0JpbTuvP5amovkc+8tOktd1v5Z2K5jLwZjnw0hpvcJ2jj0qqtFj8pqvUmZ4Dj2topF/NHYfEMOLaFHAA4HAduO27SnFcZw88w52yG7CLEHdi+4tB2weovpHAvlfow70b9obDvvLNpPzVELtNrjEIpy72tTpx8vfSKnfLZQCYvFGKdNwl03SQ/yPssoDasD0eDVl3iyOeZobBaKwywwB6pi0QppweWJ2pf3QdaMIEpAyPrkgNTHZZyYssxgUxU8XvoMfjdMwoMUrnIFAiIbgijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYEwDQfDeqxNQsw9TYrhNPFt6WUhugmsNScw2SaSfEI=;
 b=lUh5HXt9/LyXbgUHgZCUHXYbNJcltABQh2rFu9ClL5ogHA7B4ZqDcm51YPfq9zWW7xZ9cCISp1oT+RttiB7RVgTSPcI6qSGJmP83nfTI+Nr09ja+osaPfxo8430GmykJ8gL5+/p9asSaJs9ZkYQHZ3ovTrlcnS/8ayvxpBKk4DCl8NXNlFUsAedoOuken5qayZ4DvwkMEioqYzz3VWttbyMP/MbLko5ppaug2k+9yF87tSg0pU5PwHCfhMsPZ8Kj6Pz83KelloHu6suCleVQgt+Z2JuhxdDvDka96+FPUXY7Q1jJRtTd3qjlmdXskeVjDDdotc7NQ4AmV2Yp2QACqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=irondevice.com; dmarc=pass action=none
 header.from=irondevice.com; dkim=pass header.d=irondevice.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=irondevice.com;
Received: from SL2P216MB2337.KORP216.PROD.OUTLOOK.COM (2603:1096:101:14c::11)
 by SL2P216MB2112.KORP216.PROD.OUTLOOK.COM (2603:1096:101:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 00:58:17 +0000
Received: from SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e8d:9550:c46b:2756]) by SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e8d:9550:c46b:2756%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 00:58:17 +0000
From: Kiseok Jo <kiseok.jo@irondevice.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiseok Jo <kiseok.jo@irondevice.com>
Subject: [PATCH RESEND v4 0/2] Add a driver for the Iron Device SMA1307 Amp
Date: Wed,  6 Nov 2024 09:57:58 +0900
Message-Id: <20241106005800.7520-1-kiseok.jo@irondevice.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0086.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::19) To SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:14c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB2337:EE_|SL2P216MB2112:EE_
X-MS-Office365-Filtering-Correlation-Id: 7626e150-cd3e-4ef8-179b-08dcfdfe195d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nXSg0OT1qQVQNkJryJELwUT5L33vyO3cbCZRVbNDZCMTLMuO9utSw9VM4IyZ?=
 =?us-ascii?Q?vF8O7LYnm+WV5dkac9F34lr7PRkkEGRbqOcZXQykmYXteCcqnx3Q0G4Zqp7n?=
 =?us-ascii?Q?HYYvxc3YcI6iSwXyK4Th09AneY32dHZ7zw/2EB2ODlPVnYPOv5/XHlG4773Y?=
 =?us-ascii?Q?ujSM5putdhURl85Qwr64MDDhCNF3/p/O4T+l4aHfWpRqpT9krk+cRN/FVc3c?=
 =?us-ascii?Q?vIT9o8GwyGB9XgvsePWAfPzLd+zmgtGSzzfwPat4ivk9oKBg3sIWp+QKwWZX?=
 =?us-ascii?Q?viUsmeHad998zRH5muDvVdty7XklIHg3PmxHX0jmiWGyQFXQ1DYQgQA7XmFN?=
 =?us-ascii?Q?tZ9pOpOORmeCowmC7geFWxIQ6m7j2myrUNkF9zG8OJtWC7l7mMrpQNwk3lFA?=
 =?us-ascii?Q?rzc3LUyYwJ34uyuLD49r37GK5xkmuvM4kHYReRmy6RkQ4qX/j197GK8zLItk?=
 =?us-ascii?Q?DX0ted/y8X6kMdbcKkNvX690+EEmdvccL4IecP1f+K4p+bA1PnP+xnHLAwaI?=
 =?us-ascii?Q?CRXOXrqSo5pzj+iYWOPkckNsWtG2Hl/RKFh+QJVV+BZWpXJrqyUExnoMC02v?=
 =?us-ascii?Q?LAMa1tzNp8AfUiJ+qI1uPwXFGYEqa2T0D8roXhYd7wfCgkNV6cGjTqESgK9D?=
 =?us-ascii?Q?RxpN2e8sCudsQ5mUffA8c06Be43PwC/yb8jxkmvL2dX70q5kgsU3fuSmmnC+?=
 =?us-ascii?Q?VcVzT2sEf0GXIUhAABbz8qmfRVNYzETHdPDK/GPqvnT8hDBHHUju99b3dpxo?=
 =?us-ascii?Q?aDcQvLUC39ZqMAeSboLQdN/IJGb+BZqaaPUsu91Dox5Pxgy9CzofYRcjqy22?=
 =?us-ascii?Q?NRKH3R8GP86XcJwedU7wR/aj0BoJ76G70yP+VXtLptv9MDsW6UotpkZZZcXJ?=
 =?us-ascii?Q?33UcmHM2ani5/EdxP3DjDTp5RQ/G8kiEb2+PN/EyY500rajnYyBiPT+503Qs?=
 =?us-ascii?Q?xMOb3VzTWV36UmSB8Qr5YnrHeX8pqAAxgK41QQUm/WH/jCSNwBZHfCtsMVE8?=
 =?us-ascii?Q?wpEP9CwSeRbLMyjtRN3PBQE6vNsO2KgBp/4L1qhaN7t9d43AWp2lQwPItTLH?=
 =?us-ascii?Q?+X21n9RRwiLF3EbP1VnvWVHFebLzBhCNf2dOfKr7kMRPiTf3HLjXRH0GBHl+?=
 =?us-ascii?Q?7dSbrEulfDzD16TKtqCRFlu/1Wb8h2yrP7sXTz0fzJGyKlgAjeWe4rxIdCfO?=
 =?us-ascii?Q?aHRZdLFEJE3KgTzbOs8CUEYukJOs7E2lkg05hTyHBh+6h1CfDZw+OHSiZHyt?=
 =?us-ascii?Q?XT+yujc5uObUzFQY3Y/6hRM5PH7RkLbZLFXXsPhRj+E3X7M2vqLss4p9P7yD?=
 =?us-ascii?Q?hESEagcr8U9SZltuyH86rVLRHtBjjoDROXyRJCnMTr3mZbOFLwS0V9UpkAme?=
 =?us-ascii?Q?YDMgBTw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2337.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NsdnneR3rP5MpS/QqXFO1e8AoYfQaB8aggCQNhh0843zLWrJMBhlZBd3qKIT?=
 =?us-ascii?Q?UfmbKlvQWvzDQiBhTQF68pmdF5NzvfHQDK/izw1U/b+czjcL6CVAeqmaTCDa?=
 =?us-ascii?Q?ZUhLBcZACDIjqYQb13yURdL6H+v7zozIicg4vWXRaCQkXulEAp5KUwPahf5Z?=
 =?us-ascii?Q?xLCfHl9Zr/qaXLQLUSBbZ3gD7dOVxPWc6SffZj5wA2lquYZv2DNtcWh5XxGk?=
 =?us-ascii?Q?dm5UvMSDbbVjBaI/2zSUe6+68MKgZW23lBm18SrvyaUjVp96GpL4tpZ7jvhM?=
 =?us-ascii?Q?cw7E5wLJ8V63iPaEzbryuH4XtRu9ur1WLuqsT9rPNeDEyeax9iPh6Zc+9or8?=
 =?us-ascii?Q?8Awt+Gf29S2WP1Xwu9DZqhkYIVS5BfCchNgICmoNM0+ExrC1wzqhR52e+Tzp?=
 =?us-ascii?Q?cVFHMa61069KnPQFMgNYonI+9S9p7qgPlNCgNvVJ/xz1q9qE91Tvw3PAF8qi?=
 =?us-ascii?Q?5jD4nPE17uP+OP+v33i7TuX/rpeXMtSZb45YO/PD8tWzDjvR1erCDZtk2qkp?=
 =?us-ascii?Q?SpCsvXa9v8KBFKzSUMzryACAZmAq+sS48AZzlZ0ksK/YD9ocEDtlMqngmV/+?=
 =?us-ascii?Q?f7wODk5ePBcQFwEDoaXobjOyS0WX7YGfdH2q82uNgNabyUajpq0prSo22DsA?=
 =?us-ascii?Q?5+A0YFNJynT0Pz3VD9qrtC/Y/BSVz5aZJ553e4f6zto4YRMQvA1FuF4RZMzI?=
 =?us-ascii?Q?L+M9/CX2qTPSWSGhZgEoreTMRZdzssaTf3n4Z59j3A+e/SZ5Y9O/pdELIF97?=
 =?us-ascii?Q?9GZGZ2znCZ20Q3zwGWosMNpNrwjqoLcQnxqRGCIz022n2m1jhQKHuNIX2Hd6?=
 =?us-ascii?Q?GDhnRu7CESbJCp8iulvcmPAzljbozZO4iwXV0nR/1WS/e1C6npqTLW+U528M?=
 =?us-ascii?Q?OYyYUbwC5FXK2tTPLPXrYr+pNJuk43VcPq550Ae6eHu5VQmT1TgvdfxHVl+X?=
 =?us-ascii?Q?vP8l5H4twgGHdgDH5NVNtBpcPl9vfgkFJauUdbbIp2XdisfGt2+gx7S8Jqd9?=
 =?us-ascii?Q?hsIpWJgcIPdlOcACRgtB6dAp8u1P0s7K91fFDa+Cb3iLHtsaUOHWS2chsy0D?=
 =?us-ascii?Q?HJ7JGIYoWG4R8witHKSLc8E/FRPp8lIu5O+WnQNg1m3IGix5f0vgnKsMnenl?=
 =?us-ascii?Q?bR2ZCiXHNMCZv9D+m4iH0dkVm2xf6s0traIeHboy02lFw5JoLE7Se4N7onka?=
 =?us-ascii?Q?K7HoFik8qITWp1IGt/BWA2NAfY/18cQqlsz60bpMplg7KU5eKefdAFpAGh8Y?=
 =?us-ascii?Q?KqsdRdWAq15FIuwdSZhMsGeXDXiwnwiK4dlDADQHOhKxzbkcg0L1TzzAgJWw?=
 =?us-ascii?Q?ZWihCgCb82HO7eP/eLUPRJdkWRtqiTmA47CTWkbnNJMfm7/o1vdO8jpIsK3o?=
 =?us-ascii?Q?DQpiYW7F+S4UYHFvtuqN9T8DTqOwC20Miw+QmoaYnvmkO+5X650XpdcGlQiW?=
 =?us-ascii?Q?2/yEzXGA9cXBqOpj9Qtu9HpTlXeZ1h0bCUX6a0+kMeFJdThoe/NS/FfItuH7?=
 =?us-ascii?Q?JYSkDskxId46QrgnUzR2hLEwtfxjd1VTsQeYeBMET6qGbsXE5L3ZX9Z5hC6S?=
 =?us-ascii?Q?KYhMwMlTZQuR6xNUZldPdZd60DJ64HtHSNDu+yJw5fBgvKX13Be/FJ7nhtRp?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: irondevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7626e150-cd3e-4ef8-179b-08dcfdfe195d
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:58:17.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b4849faa-3337-494e-a76a-cb25a3b3d7d1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWOBJJtVPaCsnzpSMkCYLg7t6cKA9L+9POEAUqDV3Is1jVs1vFTdH8UJHVHD4VGt2Oqcs+hlch4je9DPKx7a1M7setDh1jcMULwLclcHJdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2112

This adds basic audio support for the Iron Device SMA1307 amplifier

Kiseok Jo (2):
  ASoC: dt-bindings: irondevice,sma1307: Add initial DT
  ASoC: sma1307: Add driver for Iron Device SMA1307

 .../bindings/sound/irondevice,sma1307.yaml    |   53 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/sma1307.c                    | 2052 +++++++++++++++++
 sound/soc/codecs/sma1307.h                    |  444 ++++
 5 files changed, 2561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
 create mode 100644 sound/soc/codecs/sma1307.c
 create mode 100644 sound/soc/codecs/sma1307.h

-- 
2.39.2


