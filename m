Return-Path: <linux-kernel+bounces-304568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746169621EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15E41F25B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295715B57C;
	Wed, 28 Aug 2024 07:59:11 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229615B0E5;
	Wed, 28 Aug 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831950; cv=fail; b=Dc+zddU38PZ+Gr39f3IU1Ea7fvgvYKJ1kBO1way3y+lO25Ok6LE+quczuzmkMVNEEYsrKj8YCenCip5agOF7PE938PM21CcvQ7e0X9E7BpKCxjZrXhEwHHgk5P6oCh0ueKUrYoW46z6PnpfQ5ZStqitSHAakg1Z3oDPJXGsQmes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831950; c=relaxed/simple;
	bh=h+Hs0m6/cSuwHWjV9ozDkHgYrLqIDH+FcLjF+oo8NVQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QcXbB+eAh6OKE7BYW+Wo6OCasd2G4zdo8lyQ+8JJVx70utUEv0EemLfca5d7+daDfLtrblsZR9lJ2hS2VIGsOeLm4Yo9zd/FLD/Fe6bh8jeptgfzARFb1gt9vM2AICOTGHnyoRRm22WInJXi7hD3iZ6heMTJZMW2EErRzx10zRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlC6lt1sMTf5PLmnr1eSbgY4IRooD+WlFyOnsHFnN5yHmYonLjbNBtnWLPjZzOvgKahedGxkURQAQxUq6lodcZ8E+9ECRyGuVWymNFABLvr62GjlOZiiobKVySzigfRxwj1rSsj8SnaPxI3ZmNTb2wRDgDK89I4aGBIhPcZLw4VtaWj1a2ogqQLemBQR2VwDl1MZ7kGfk3FEt9VOS5UfosRrKws3twOjCyYqB3V59XQzIuhos6qzh9IeHe5JFKTzjb1mnk8BfKSal7HlD53hADsiBVUUv1DnUJA6Kf09NNvqZQF/HPfytl6WzhSDqStF0bLkej7oDAFRZbQ91usYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1kHgXmrSPqoIUrNEDouXkjYJiqFWo4tKOJ1j6SrAPw=;
 b=bzOoJD8Bfkt+ouh42zUr2wJbNk5zTthrJQlg/4meM4ikOADRhFVBNx0nrY0wgXMmAI/+uIYSWg20MbBYdyfy5xwlJskyyeo1+PtQP2rxShU883o+h/L8fNJX3PDmRn6VSAmY2resOPeaJrb0EsT+3DQprAN9KF1+p9KyTuAbdJQ3KNZwBjxmfP4dI899CyDgF1gYe9dm0NDAuvFt6Anrq+D3yMi0By6HhFNMd2/r7pruhGNp05onQW5cIPZqNM1vnZxRRwEbcf/EX1GOZkc+lXZ6CynrOTtInbxXX7Xxci94O/j5y4eiUUVk2fkR57WKAJumC6zYqQKUC53M0G+06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8765.apcprd03.prod.outlook.com (2603:1096:101:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 07:58:59 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:58:59 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 0/2] (no cover subject)
Date: Wed, 28 Aug 2024 15:58:48 +0800
Message-Id: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjYzmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDI10FJSSM
 xLz0lN1M1OAAkpGBkYmBhZGFropJcW6hkmGZsbG5qbJJpbJSkCVBUWpaZkVYGOiY2trATBT/q9
 WAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>, 
 Muhammed Efe Cetin <efectn@protonmail.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724831937; l=3411;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=h+Hs0m6/cSuwHWjV9ozDkHgYrLqIDH+FcLjF+oo8NVQ=;
 b=Z04yZzcTqOww91LskCdHZw0poNS+kA3tcZd1M7QFkUFYMXfKzAEmx2rB+b1g/mon8cVv+sFvS
 YyoZ/FDGXCaApiBxDA0qMC57K4pG3e0tcewZ38YT+eWsEpHiJGlfRPb
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ad38e3-53a2-469f-9725-08dcc7374634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEZUYVArNzRUS0lLdHBZRVBCUEkrRDNpN2s1ZFd3V2k3Q054cTZ4MTdIQkNi?=
 =?utf-8?B?d2Z4K0xUU0tYK0hXR3hxbWIza2E2OVJSZTRiQ2RmakVxbjEwZHhvN1N3dW80?=
 =?utf-8?B?aEhwVDdjaWg0dnVFVEloVlBrZ1dieG9vQ2Rta05VSHBQWVdEWGtsTmEwSUxw?=
 =?utf-8?B?YlJuUVJjazg2T0ZxZXhTa3doRldLZC9LNkxTMnBoWWdNeHJZeWRzb2pwd0Rv?=
 =?utf-8?B?eVZIM1BXbUVZbXVKQndmRkZwQXA4aEtyUEVwRlVEQ2ZsUVBjVVd5RXZ1UnFq?=
 =?utf-8?B?Ni9Ba1RaMDhJenQ3N2dFRWw3N0FmazRZbXo1T3RhVHhLakdmdGJKTGEyWmJP?=
 =?utf-8?B?NUZtYW84ZnpHK2VUQThxR3d4a2hkaEN4ZzhUYmtDTGVib0I4clZzeVgrdm5x?=
 =?utf-8?B?R3ZRV0VsUEJzTWs0cWt2T2ttYzE5OFFiOS9kVE5oUjJ1aFhyU3ltZWVWRmJu?=
 =?utf-8?B?dGowd0dGUEtiRnNmckc4cDRrYkxmOGlKSjFGZERVZ2ZhQXJCT1R0VVJrWEdq?=
 =?utf-8?B?Ujl6cW5mclFVaWFEUmJ0a3VqZm5OOHgzYStyTG0wdytkQjh5Y3c1WktyWTBE?=
 =?utf-8?B?M0VvK2J0WGdsSmtscHR6K09kZVhwMFd3alNSZUEvSjFNS0srdHM2YXpYNWRk?=
 =?utf-8?B?eDkxbXUvcU9NcGQrempBMmNHZjd6RTlUZUQ2em5MNVBqY1dBNlB3ZVE3Qkx0?=
 =?utf-8?B?MEgxNDNQZ2puSGJvOUVBVG9UU0RiZ093VHlxdDN2TGZIVWZxOS9oVm1KaVpG?=
 =?utf-8?B?aHpmaUl2S3pMOTlSdE9SYlFuQUhmQ3hZZmFwTjNaNjMwZjF4SVZtejZBa2RB?=
 =?utf-8?B?a1F4MVJ5alBZYW5BTGEvdFpZTFFTSndSWENFZzBxc3NjdHVTMTJzUkxGK2Y2?=
 =?utf-8?B?cnR6eUN4YUZiOXJObnVlampYa2hyOG9LT0hadUhuSEwrOFlUOGliWmkyRmhI?=
 =?utf-8?B?SUt0aHNuLzhkcDdQL00xa2puWVJRelQxN0syM05LRlRUWmMvbTlMWkNvcVZV?=
 =?utf-8?B?Yy8zMHBQZERlTDBlMHJRb08wS1ZEaEtJWlh0WkNWb3cwVXlNdGlRMUV0aERy?=
 =?utf-8?B?SXZCZmJmL2tOcVR3bjQyOFdsU3kreWdFWFZ6UGF0dlY0Y21mQWZHUzUxZThN?=
 =?utf-8?B?NngreFlIc2JOcE12bE9GZ3hWK2liTVkzOUNpRXFuUTlTenF3cFBOTXlya1du?=
 =?utf-8?B?dTQ3WHM2YUgvSEVsZFh5cVVhMUlKQzhOTG9wekZuanhkb3E1NjVhaVlaWjR5?=
 =?utf-8?B?Sno4T1UzbmZXUEhzaW5xNWdOc0lTYWhlMDJ4TGluS3psWTJQNzQ5TWpLMnZ2?=
 =?utf-8?B?cGVSRDV0c2RkbS84MVlxdVY5UWMzSWRCa25wbUo3SlZqQnpKcWlJN09Fck82?=
 =?utf-8?B?bzZCdFdxdFRpM3JxT1dEeERtbmdWVFlXZjRGTHV5cGZFSE8xaGMxNk5vTUFy?=
 =?utf-8?B?QkJDT3BVdlhFT1pNTXRGNVU5WmdnQ2FLaGd5MVBUVGxNZStPSXRBbjY1UXcr?=
 =?utf-8?B?Nm1Xc3RTRm9ocEVsNkZaYVRVNlo0cjBEYTJLM3N2TllRZkRzZTdLaGFUU0pF?=
 =?utf-8?B?MXdSZ0svZ29hRG5XakhiOTB2NXUzWDB6OHIvV2JqbDlka1FSMzlyWWhrOXc1?=
 =?utf-8?B?c3oxOWl2VEVnQy9SZXBmYjQzeTlwdEI4QlIzcElhS0FyR0s4K3lqOVg5eXMr?=
 =?utf-8?B?S3cxZWVCT1h4WHl1ekxIV3ZzUXkva1drNU44TG5wb01sNloyYmlYeVBxVVF3?=
 =?utf-8?B?MFFsQm02YXhGSm45cmtuZWFwd2trb0pORE1GUGlVUmlnRVRWSlNkRjRZb2cw?=
 =?utf-8?B?Sk1yZytVRFBzb2ptMUxqN0dGVlJQRTNUZTYrZWU1bndhYTdoYUtXYTQzMVRi?=
 =?utf-8?B?ZjF1dkxCUEw1eG9OaktISlhKaXNPaTJZTFRMUmFxSk9MbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alY5Yi81R2dyUHZxcXBKL2JtRHlWamJFVnZyN1pwWUhkTFVydW1KcnJKRDZO?=
 =?utf-8?B?aGlQZW84N3lkS09ZVTRVMHljVnhpb2J6MVNZbExJbHNzRkZ3M0JOcUFMdUlH?=
 =?utf-8?B?eTgrMCtETmpPYkY0L3ZKZlJMRU1vTnVBL29OUEJPOGtBeDVmRnhMdkorRnRO?=
 =?utf-8?B?M2VpTDVQYkRBOGZMUXZNMmJVQUFmbkFHTG5GY2loSXFSZUc0Z1A5RUNFbGRz?=
 =?utf-8?B?UE9vM0VQcWlwN0NRa3BiM1N2NFY3YkpFQWMvOXl0TUFBM2VWRFdHdG14UGJv?=
 =?utf-8?B?dExKVmxqYXN0WlN0aS9ZUnJ2NU9hRVk1RFYzT0NIYzRJK0VNRnhLMThWLytI?=
 =?utf-8?B?djFqMkdlUjdsQXdCcW9keDQ3L3gzNmdmdUV0ZGpKSjB2eTZBQVdoR2ljOTlw?=
 =?utf-8?B?UnllY2Q4TE1XWGhMd3ZqMXk1SkNBT1RuU0dGVW4rR2lnSktaa1RWbkNBWXNq?=
 =?utf-8?B?bU9haC92blQ4Ui9UbUErbEoyZ0ZhMFR3Nm9zNFBMcS9MZURodkNRZXdhcllT?=
 =?utf-8?B?R0dNTkx2L2hGeWpNT2VLTUV1S21LTk1QUzZxenh3ZlZCRHk2RXFnampDTjl3?=
 =?utf-8?B?VHFMYnVWTjNVQ2lnNk14am9Xb2UwQWN0VEpvYWY5Qjh0TkQ1NU4zbDVuMThB?=
 =?utf-8?B?cXJjajgwd2s1OFNRMjR3cWpVc1pDNENKTFdhQmdMdCtTd3VzbnJITUtRWHNJ?=
 =?utf-8?B?ZmlQK1lUVFNMVUttYTRkOHU0aFRJditLR0JRRGlZYTZXQVhlKzZzT2JIeFlH?=
 =?utf-8?B?MjFnQ1ppYWdaR1lJY3pkN3lPSmxXY2dkUEM2SE1oSS9NSXEvK2VkT3lyUkpk?=
 =?utf-8?B?SEJxd0FUOEFvZEFjL1BCTzdzakdYYzJGUys3Ly8zU3p3SjZPQWJXQTI4N3B5?=
 =?utf-8?B?NU5KK1l5d05uNWhWVS9hVzc4dXlzMVhFNVlwamx3cjdDS0cxK3NLYnVFY1ZZ?=
 =?utf-8?B?RTFETGxNVktEUkJHM0k4RHQreEVZQlhVZ3QxV0gvZExQRmRsS1Zlb0srcHlU?=
 =?utf-8?B?bTh1QlN3SGEvRmhCUnJ5VDBCb3FCbGxBUmtwL2NhK0VIQXBHT3VZVDQraGw4?=
 =?utf-8?B?MVhHQi9KdGZIL0VXSGxWUWJtcFB4RDRoZEFmYzF3QU93VjFQVE9GL0tUWGJQ?=
 =?utf-8?B?dXEyMVBLT281RHNZWkZqbHgreVFwNjg4ellidzRISTdxT051MjBiSTVQUURU?=
 =?utf-8?B?bkVpZWlpd0hENXpCSUxhKzR6bGpUYUpJTHQ0c1lrdFp4Z3UvZkgzOVU0ZkVB?=
 =?utf-8?B?NXVlN0pkaDNNRkxYTlBmK0NIOHRJVjZ5eFNPL0F3YkR2TUN2TGtOUVBBdW83?=
 =?utf-8?B?cVZQTWxBZDVFbmpKR2hhSzZieUNVWGk2VDZDWmp2M3ZkNzJtUzcyY0ZLYTZv?=
 =?utf-8?B?SXd4UTA5SmtncnpaaitqSHNjL0Y3V215cGpNeEQ5QTBveHo4aGNqVEVSNk1Z?=
 =?utf-8?B?ckN4cGM2ZTJtU0FDdVIrdDdGZUI3S1RqenZZeUlmM2UzM0hiQndicEhzbCtE?=
 =?utf-8?B?YjBTWjVvYTVKS3Z0RDhnanN2NWNTdW4zRlJaeDJJVERvQzdkUTZkelNuZ2RP?=
 =?utf-8?B?K0NIeTJNV2dtMmI2RUN1enJEMGxjT1g3bWpjejhzSm9mWXJjaHlFR1MrQ0Fn?=
 =?utf-8?B?VHU3NlRYRWFGWFVsKzJZQm02bEp6UkpoTTBKUEFSeFlUNW80YjJwRlFkajVL?=
 =?utf-8?B?M0tGdDNRdE1TT3A4M2xRbTlMMjNGMXpyOG51aytaUDdQVEZDRG1hNVVxZ2N2?=
 =?utf-8?B?b2trVEdmRzFTUEE3blEwaFJjV2QySTk4SkRYSmd3amhKTzNhb1BNTGU2Y09n?=
 =?utf-8?B?Q2FCZEdPdUNSV2NWMEU4Vm04QTJuTjZFUGNpTVBiREd0TlhvYnA2RGRWbm5i?=
 =?utf-8?B?c2lqLzZ4Y1JQQnk4VTBvYlVYUHhMUEY3Q0E1UnZYdU05YStvUlB6VHlIc0RZ?=
 =?utf-8?B?YzRSU3I2a25rMTNGeHVFZXphU3ppUzk0R0dnZHBldnpaNjdRbUhad01XRytY?=
 =?utf-8?B?TDBPbndMSHMyemNCRURGZTR0WFl5YVpCUkdmb05MVkkwWENoZnhIZCtFQThm?=
 =?utf-8?B?T0hobUxQdG85RmROdTRMbXFIQms4VEc3Nk5TbFJHMk1HZkJ0NFpWTkViRkxG?=
 =?utf-8?Q?lVkJag1PYW27xBqSNnIvW27pg?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ad38e3-53a2-469f-9725-08dcc7374634
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:58:59.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njivwxAuLEWEGFoVFDDuOwoVo/fVu/jKm308KJlstM6sUDdY9wBqa27SY/A+1N9XlxA1WqO9oQVhlIpFB0UBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8765

Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
compatible so add it to Apple's devices.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
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
Jacobe Zang (2):
      arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
      arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible

 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi             |  2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts              |  2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts              |  2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)
---
base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
change-id: 20240828-dts-1b163375c49c

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


