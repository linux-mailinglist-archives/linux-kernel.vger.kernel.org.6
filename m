Return-Path: <linux-kernel+bounces-322339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC0972782
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36502862A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE34436A;
	Tue, 10 Sep 2024 03:08:02 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020110.outbound.protection.outlook.com [52.101.128.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6914F9EF;
	Tue, 10 Sep 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937682; cv=fail; b=pUtO75JHMwB8m3ujekuwssDNeCgOpSNjdDSu0jmku6qic0Wu09KIQLzXzIWX9LsfO4UldJihiOooh5PEVkr5VHh3ssweVVmlLXGMcTMjV9AtwtnYJMjw/VFgFIc7pG43iHyoTQFioSC6l+/k871PJRsQO9WURQmf34KEtdWksI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937682; c=relaxed/simple;
	bh=S8CJao7eVnx5Qs7xLub3iZcMCvRQEKrMGIan7eziKDk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=AyhUrpSGh2O0UjbeU9kmwPRitrAKdu+dU6M9wGIAVuz/6sUZIYWidvmzeo1f1+OLKGd9NdACPHuQ2O0bIsCoQlZ3nTvILiqn1NUK7tvvBe6Xo1RV9fI/Xx8sEpTBL5zN1XBZXpCeGL5ugc47wc2WPiW6dVYAussP8d8DQO9Xm3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+srECYw1kQkvqCbRGYy9CaD+E3aovMtMzJt77n03VKaesOmqxbwpdbmRGpL03o6rvkjjUMxy02Wyn2xrKAaU6EhJPHdpYecM3nmMawHO6gJM+3fD1wJY+66bFgb6ihKuUNWuAVMhuwrNg+R752/ryWK5uIOUFNjCXSwZP1rSErj6c6l8bvQK0Odh74GWFDFAAcdmrKoLSDzEPF0FgI9P0/WhySe27sKHCSxigFeVhJZ+61STg57yHiukYyiVIJC4NpimdWXx9BpzQ5urhue6t3Q3xPWgrsjbbkP0/93P3PBsoIfQKRgxsjwGpNLpjgzb6B6emHzesq7BA8JMq79pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVKS8S9gR882jebGmFGqmn8Z8+a42VMRtmQRyCOT3ww=;
 b=eCvZLpHhVZiSIA8kvwD2atlklibTakvsqpWhbh40E3tYLaUNroUHL2zpZVvy3SujtPn13v6CU7HWBqN7v19GyQhcMf8DcA9cS0tg3aX6iQRgU/mY+1awGaqrxiBsKtRZpdGgMCmVArUqG/FCFW9BF1rgmUWu6XOFgbDBK08KtVDWpuDbfSv8EZFH+icCP90fvRv6MVjIR0+h5JXjj6GwUXmIiPn2RygCnHVIstmomIwuhQoJaWz/EtEdqYHP9edm4PmDcHxz+RMDDiTHh//gvBfcSFHdAO6ntsScO7fI/IJaUsi5AQReRVeS3MliwHwPPZVyj/xWZ6vgsEk1+g4StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SI2PR03MB6783.apcprd03.prod.outlook.com (2603:1096:4:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:07:56 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:07:56 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 10 Sep 2024 11:07:47 +0800
Subject: [PATCH v14] arm64: dts: rockchip: Add AP6275P wireless support to
 Khadas Edge 2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-dts-v14-1-82b39bd91257@wesion.com>
X-B4-Tracking: v=1; b=H4sIAAK432YC/22NOw7CMBAFrxJtjZF/ODYV90AU+EdcECM7CqAod
 2edLhLlG+3MLlBDSaHCuVughDnVlEccTB46cMN9fASSPALglEuquSZ+qoRZpoToT04aB3j5KiG
 mz5a53nAPqU65fLfqzHjD+wBCQommVkWkUfXx8g7t99HlJ7TEzMQ/TaCmbIxGG+WVNDttXdcfz
 p6pNNEAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, jacobe.zang@wesion.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, nick@khadas.com, 
 Muhammed Efe Cetin <efectn@protonmail.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937673; l=4483;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=S8CJao7eVnx5Qs7xLub3iZcMCvRQEKrMGIan7eziKDk=;
 b=IMOJhAYULA4nSpcX3uKpeROqiuJZkajG0XAvoAx3E3gk84j0mCuyPYiGBLlLFZ1QXzwDcrEHQ
 HHGWBHsuLPsArNox0t1/yBKNfwIKj3WP29CGLqOfZ2HdtyjrtU59Nzp
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SI2PR03MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: e92d8f99-3cad-4829-e5f2-08dcd145c48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjEyMjM4bzZZRTFCOEthU1A3SkYxNVlVWUpkTk9DaVdJYk9nUUN2Q29hV21y?=
 =?utf-8?B?S0VmZkR2ZGhtUXUrVmtJcEh6TUphdHNRa2JBd242bzBvWmxlanJiWGtjdUtF?=
 =?utf-8?B?dGNrQmZSU1o2UEhtWnNseXNHL1pXdGVORDBoOS9BbmlGYWRpUUlyZTAweWJS?=
 =?utf-8?B?Uy8rdlN1TVVQVEM2a0RpT0pGNzFhVE52Z1dYWlNob3Z6VlRIQmpvUzhDZVFy?=
 =?utf-8?B?ODVKb0lXdHlZSmJVK2wxeTdlS2dxbGhPaWZjTDZhKzNCU3ZoUXBtemRFcEFC?=
 =?utf-8?B?S0JXOUFUampUbUlqS0Y4Vnp1U2Q5NzZUMXNTT2tlWENPdVhmV3JoYUwrSkRy?=
 =?utf-8?B?NzVac0thMm9ycVduVzFjNDkwbS9RdmFERHFyQzN1VFl1c09IUzRZdXNzUFhX?=
 =?utf-8?B?Q0VCZk1lQjVOcTExdnRhZzZIcVNGWnFMWWRlRXVNZ1BwanV0T25BS0wvVGZR?=
 =?utf-8?B?alBOQXNYcDdPcmRLdHlDVkhRK2xkbzFCSGNNU2t3Ri9UclNIZk1BL1loMnhk?=
 =?utf-8?B?OWRZRytRTVVKQ2RIVHAyZ2dEWkE0TGVYaXZydkM3TlpKc3lsUG5QRUhDSnBh?=
 =?utf-8?B?SGs3L0hJa0V4L2JwUlhsQmlnU0xwdGVhUllSR0NwUTlqQlVlM0xvMUFLT1p6?=
 =?utf-8?B?VWVRTEttNS9xZFdKMDVwc3hFQXpuM2p0RmdBdHY1dDMxcUpGTXNHdnBNeEZL?=
 =?utf-8?B?dkt4R0JqTUpaeCsyUHMrWnpUT2FOdlp6cFBpUUV2VVN3cGR4b2srM3BqeWdD?=
 =?utf-8?B?d2FlSkZrNzBHL05ZQnNDOFBSRTlBZ0l3a0gxYnlyMkUvVHVHVnpNelV0eGdG?=
 =?utf-8?B?QUxiemcydUhrRVNBMUQwN3haWXBjWkl4SkFaakF0NFVYOGdWcldZZjJnQ1lE?=
 =?utf-8?B?bkkrTGdVdDZQYVgyTHZwbGh2QnRScytvSlF5WFVsNzhNbjdzNUdzR2RBSGZZ?=
 =?utf-8?B?K05EY09uSkp3SDIvanlQN3RYc295VER6aUdzbHFPV0h5a09pSWdaSWFPb3RC?=
 =?utf-8?B?b1ROUUcvTlJDQVNUK2tjVEl0TDAybWIrVDdwM1FjbEZqditYUVdzL3FJcVAw?=
 =?utf-8?B?bVlLWWFtV0NEVkdENE1TYVovVlo3RnVRa29CRWRWSjUvUmFBZ1hxN1dhbjdq?=
 =?utf-8?B?K2JCT3ZaUzFnZ2FmdXM5anFOREpIdGxrbzBJdDVlNWRRYnRKcm1aSXE5bGor?=
 =?utf-8?B?eDRNRE9uVkI0Y0pPTG5SWWlqcnJYYkFUUHA2Y2FmMmQ1djlkeDlDRGpjaDNX?=
 =?utf-8?B?S0dzVXBFTWtCUXQwZHNFOXlKOUdEcjNZVFQ2ZlpDSUZMNkdnUUZnTWFmc1Q4?=
 =?utf-8?B?SXdaK29oS2FtOExSQ3Y1RmtPZ1lYQ0VVQkpmM1dDVElzN1F5U1AvcGVUYlBY?=
 =?utf-8?B?d3lEYTZVWVRBOGliSVIwTUtKZnpUUjBoVDQ0a2d5NnZVcjZLQ3ZzSThXNFBS?=
 =?utf-8?B?cTF0VitCQkpmaG9QdEhzNEdJREdseGw1dWpvQkdLSG9rRlZVdUUzRGNsRWFl?=
 =?utf-8?B?cXZkdnN6YkJVZWgrWFE4OUtCWkpmcWpuazJKekg5UWR3SHUvdGJMOGhlcHZ1?=
 =?utf-8?B?blp4bEppTnVoRlIyUGJQbm9Nek5yVG9jbGl1SEJvdHNlSFVSZ2NIVVVnZlpW?=
 =?utf-8?B?dml0amszMjhmZVNuazdJYk9qQnZMUCtrMWxtRzNMS01sdjFLelJxOFpVOEEz?=
 =?utf-8?B?NmJ5bEtGdlVueEJHZ2JYVWRZNit6RXZGSVROSkVIRVNlMmtGQWhCWlRvdktB?=
 =?utf-8?B?ZER1SUgrTXE5cUpiMXR2VkRmcURpdEZJSUxFbUFoemJiV0RYenptZW1FNmZU?=
 =?utf-8?B?WGt4aHZpRWF0WHNIVHhWOExCbnNOTW5EYlAxVUNqU2pBYXBYdmRraGxpSzBY?=
 =?utf-8?B?NzE4Y2JHWUoxVERUUWdxSTZ2VHAvK0ZQK1h4MDlPbW93c0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZ5TjZMVWRCeFhsWXRFOTBBVnJQcEhObzlkNm9xR3VRRUxEWFBSUmhodlhs?=
 =?utf-8?B?bFBEV1hmOWdYUTk2YlN1UzEyRkkyOWtLK213alFTQktTNmlmUzAvSm5aM1Qx?=
 =?utf-8?B?ZVFhUHNrbGZjam5MTGNyMTl3SUhTNnFId3ZrSHN3cURCOE5ESHpDZzhZTmQ3?=
 =?utf-8?B?cW9Cc0hyRGtveUxLRkxXd2E0LzlnbHlHKzRJaFZOZ1ZSOWhaZWtaRHZqS2Yx?=
 =?utf-8?B?MzkyZWk5L3lVWmlEWVlMYlVIaFFLekQ5RWNjMzl2M3hYY3FTdzlJSGZrRUpi?=
 =?utf-8?B?NWVUTnRPaHl2QjFlUVRWT0xjMW9WMnNCaTVXWURwYWE2SWhwZGxYUXRVU0tT?=
 =?utf-8?B?QjlOdklUUFBjMnlsdnZoS3BDU3RLcXkwcTJDRnFxcWNkdk1rNHJ2OHprekRh?=
 =?utf-8?B?NHhOMVBLY0UxS3I3NzFlT0NUV0hkdW9YS2hwSENHT1R0SVNpNmlxcEJEMFg0?=
 =?utf-8?B?UUFQelArMGhuVXdFclU0dTlNS3hWYWgwOFRrVFRJNjNjUU8xWEx2WGZHaGFJ?=
 =?utf-8?B?TlkyK1d6TFo3ZVIrSWxVS0RNUnF0bHZFUUNjMkNwb01PY2JvMTZjNEFOOTVs?=
 =?utf-8?B?TjRpVWJGbFUrdTdBSEJXMVFBNXhsL1RsMFJuL2hNTG1VY0szcGx2YzdmbTJP?=
 =?utf-8?B?a1BUQ0x3OGdUL0VSVDRpNDZiNTY3REFOdFJVbkhrdTg4d3IzTmRVY01HcEVS?=
 =?utf-8?B?V2pZQVlzLzNtb0MrenhyejVsQnl5cjgxaVoxWUowTkFEM3N2NTBYWGlQRk5j?=
 =?utf-8?B?VmUzQjFzeDVoVlpPdDdMVEk2QVVwRzhwOEJobmpCWFZoZzB2YWlXUXpXZysy?=
 =?utf-8?B?MTM5MnRKZnBidytIZHZGVXg2N0c4MXd6RHpaQWhFYm1tS0Y3d0Z3WGhwaThL?=
 =?utf-8?B?K0RTeHFTbEkxcTF0dGpSeHB4YSs3V21UL3VOaXRxOE92YW00Y0ZvL0VuNWU5?=
 =?utf-8?B?SnRCdmQzeSs2YXJVMXRXMXNwbGxsNnhRdEJlMStDb0xFWXlkTnpqRlQ0MzR2?=
 =?utf-8?B?eWp6R05MSDRqVlJVMlE3ZlhsQy9DUDgzSFVPcVlyZnc5YVNTVThFSm91cSt1?=
 =?utf-8?B?RjZ3MmVsRS9wMENMUXU4SVRHYjB1QlZJWTdjc0hoMlVJOVlkTVdNSWYyNXFt?=
 =?utf-8?B?dCtvWXNtWFZkQjZBTHNKU09qL0tlNVg1ZGZQTi9MTW5uTEJPb1kxcDJsZi9J?=
 =?utf-8?B?MUhzR2xxSEFDeFdqWjBWQWgxVFFxSEQ1QjA4eUdSYnhxSjQ4eFVFNmh2THpE?=
 =?utf-8?B?cTFtTXBMbWJlb0dyMnZZZGw4MDJXTWszYjBPdVJsRkpLVDQyVTZ4RGNveklK?=
 =?utf-8?B?cUFPYnpGaEtDdExHRXlsYlhmQmN3SDBxbnhJamlQb0VLQkIxKytrS3VrMjJD?=
 =?utf-8?B?SVEvNEd6WDgvM293aTlVYVdGZ1Fjb25EYzZzWjFncXNIV2JEWnVydEpWRUd5?=
 =?utf-8?B?YzNXUGZMempjVC82NkFhSitUaG1pYzQ0V2NpZGRXby9BQmw0aUM5aVF0dmZi?=
 =?utf-8?B?K2VFWDk3akhOci9MamJ3Z1hlVFpkWTNEU2hPc1plYWpOaGE1SHlpM0Fic29K?=
 =?utf-8?B?ZzR0SnpRbnhnTHhqR2VDSEUrTkcxVk9ZbVlka09ZQnNsRU1OL25QUlBpMi9S?=
 =?utf-8?B?c2FISU8xaUlqMlEyVTJaQTUvbUxiNHhiRkRrU0hpSTBRcXY4N3hRWTJJRVJ0?=
 =?utf-8?B?UThTdDJzZ3lZdjZMRGpJOEhYYlB3V1l1MXowVEx0S0hEV0tPMElSRENDOFp5?=
 =?utf-8?B?Y2VVWS81WEt2U3B0RlBiSGxVOVRDd1ZCeUFLWThRclVweWZyNXR5TGhZQTdW?=
 =?utf-8?B?VmUyTW5PeTFQRTlQcnBzRGdpdlJxSFJuUzU4VVhvVEJQRUwvVmRGZVJ5U2o3?=
 =?utf-8?B?WVpHRU8veFpEZ2d2VUl6RWhldnlFWkc3aHRSNktMcHJRaXh1SmRzRHBBbml4?=
 =?utf-8?B?b2ZVcXRPVkM2Y2ZBWGpwV1dxMndvQVlURnk4R09sa3RsVmQvK1hDYzZ0T3NZ?=
 =?utf-8?B?cWt4TzZteGlqaENqc3RZejlxZnBwVGZPWjJDdExmaHB4SUxpVVdPRTdwVVEz?=
 =?utf-8?B?Nm9uNzFLS3BPeXpTc0t3V0oyQ2FKTGtTRktuY1FIY0d2M056T3MxSnRaVTRu?=
 =?utf-8?Q?mQUb238S1Flkigf7sWJpYNb/M?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92d8f99-3cad-4829-e5f2-08dcd145c48b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:07:56.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Eh9uX3d6xoYIe5tzBw0yHdA0ux4jdKy4BUl6sKTZ0qTkFZThrqLl/OmfOZm8u65KYQkDAW+PiC3E/ttBCZapg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6783

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Add basic Wi-Fi support on Khadas Edge2.
---
Changes in v14:
 - Removed fallback compatible
 
 - Link to bindings: https://lore.kernel.org/r/20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com 
 - Link to v13: https://lore.kernel.org/r/20240828-dts-v13-0-6bff9896d649@wesion.com

Changes in v13:
 - Change patch 2/2 argument from driver to bindings.

 - Link to v12: https://lore.kernel.org/all/20240828033953.967649-1-jacobe.zang@wesion.com/

Changes in v12:
 - Add fallback compatible for Apple's devices

 - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/

Changes in v11:
 - Split DTS and submit separately

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/
---
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..b80a552dad883 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
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
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {

---
base-commit: fe57beb026ef5f9614adfa23ee6f3c21faede2cf
change-id: 20240828-dts-1b163375c49c

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


