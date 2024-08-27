Return-Path: <linux-kernel+bounces-303325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47767960ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFCAB245B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90F1BC073;
	Tue, 27 Aug 2024 12:44:34 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2116.outbound.protection.outlook.com [40.107.239.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4FA19885D;
	Tue, 27 Aug 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762673; cv=fail; b=WMk8UFGWYlH4HNi7b3Hi5hDWkg7hQ469DBaqvLiKThd+rdRjoRuqKyKe25UPdYZosgBnnnx28IzzuY5weXHFuP6tw322ab+GM9aRdg7CVCGnPXTc/HTmtbPcUq11O7/SinX83U7BRtPmnVJTKIQWv0JJQXb2UPdUm2atnQ6hitY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762673; c=relaxed/simple;
	bh=TP4NWlE6iBl/GOotmenIt0Kdt4CHcra/20YLL/K3vpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MsfPgofQGfTJsCqyGqJKMTktCDbM4jWmefNvz/UhjL0Qh1epMjpuHrgxjaSkqbdr9BKnmELaDaM61Lb2HB+HOgXmsnN+dL4bZ7Wgjhuo3L5KsYYLOHu7Is5+6e203ORvRgdw5KpZdZTyQQcXjKXcuMO6T6C5Kb4cioVAuqVE6wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqWDRhcHlXehKpaG76ulQd5YpNATp/Ue5wor6quX1Lv7Ut0iQ5hns5RB0UtZyROIWK+DuWzafogpaeM0Gj2cJ/LtgJAawvxcLkOtSqaeo1TDaPcFKCBbvaKqeK/2r6muPfkmdJpolsxhC6jpKJLHOSar/mmIHNyUlww8p+4rJLe8ZwMDtVfgfLgtbOGLmnG69gWYoo0KvtNtBYUnzweRPpMkcT9tUdX9u1OiqvB6NC3QOtoBMd4335JD+VksKu/wORLDZSffcmjPECbgZdxJWbWSIZfo0zH22ebq/5zYtYeKQn0HU0JpIVXJH3xy7d8XfGrjWMnARXNFVuYGtnJLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP4NWlE6iBl/GOotmenIt0Kdt4CHcra/20YLL/K3vpc=;
 b=a93QJrMiZaq45txXP9wInlaQZnDQDhzhrOkGgyXrxG2VK25H0hf/MHUCy0sSH3UYCBvan9jdIbpmT3FDF0AKTSWSUbgN6G0y+HM0iuPIoihrLeMfXSq+O5dw6oD3If/CJzpPhowRTpBJ4tFJhUSNcVxWiCpJ6FmaqxtYzNSYccsuJAGrSvOx6CPnjmRrHXgz3RJy25AMTkq25yJKGXEZOnupdikslpk1HGGxEQe9fhDqsTQdPD2N6glYj7AZnHq4Fc8n6UKeFq074LDsBWWZ0QOggEWfEU2YC72ME13USsrM+VWrHJVHCXglMbEuPv/fSEiC5Sjk3jTOd6K6sxVRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN3P287MB0751.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 12:44:27 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:44:27 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Fabio Estevam <festevam@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa9VRUHO5mIgJDEES+QtfARtJnGLI0x5OAgAYyo1OAAA9eAIAACOky
Date: Tue, 27 Aug 2024 12:44:27 +0000
Message-ID:
 <PN3P287MB18299C837F8F39E8C5C088908B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
 <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de>
 <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <CAOMZO5BUrJBo5+bEyBA3i7q9Kb0HXgRwu8J-kV9JbDMFcx-WGg@mail.gmail.com>
In-Reply-To:
 <CAOMZO5BUrJBo5+bEyBA3i7q9Kb0HXgRwu8J-kV9JbDMFcx-WGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN3P287MB0751:EE_
x-ms-office365-filtering-correlation-id: de50e5b4-505e-4457-2739-08dcc695fce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFY0SFR1YUUwRmQ1cFB5MENDMXFCV29GeGJEWGplYnhENzdyUkJTSnRXZjlW?=
 =?utf-8?B?MVFrbUwzNWtwdUR0eExyRWlPcGtwQU5uZGNLLzQyckJ1YlFuY093bElVRlo4?=
 =?utf-8?B?Y2hZV3FQRVoxM2F0R203OHdCYTR5azNwQkcxSkdtdlJzY2QvamdYSlJOMVpp?=
 =?utf-8?B?cjNDV0hDZVh4MWN2OXdaMFF5eVA0MkgzMUxFVkdnSlkxUlM1NDlpeVVPaS8v?=
 =?utf-8?B?QjQrVVhNeVg5cHk1NFJkTkRkdkdhNUdNamhmdU5CSW4rMmliNDZ1TU9vMGpK?=
 =?utf-8?B?R3lidzFGdVNqUUJOakZmeFlqWDViUVI5SGZpR2NGRFdSWG5zYzVIeWZqQnVQ?=
 =?utf-8?B?aHZQelpiNi84YlNSZnc5VUFsMW1ZU1VUNXBtN0ZIc0JaaklhUnl6cldsSlRz?=
 =?utf-8?B?Nkd3ZWdNVVVHU1dlYUlYRHpjdWNHaUFFSlhHaTBLT2E4WlJkcTI0VEtYYkg1?=
 =?utf-8?B?dzJ5d1p6ZTkxd2VpcFBoY2VzU2VpM1NnK1N5MVhZZjFid3RVV3Y3ZkhlQWxk?=
 =?utf-8?B?cnF3OFhsUlhhdTgxUEprZjg5bmxNR1JHSlFqSlpIamxoRjRjMk42TXlQQzdU?=
 =?utf-8?B?Si8yRGplcllVdStYMWlIVUdkZUNTNEFDTEZCcWdYdHVyYVFUbnhqbzd6YUNj?=
 =?utf-8?B?R2xhM0EwYmxwckdIZ0wxcVNvOVFvTTZxaCtYd0lZdWloVFczQWgvUStBSHBB?=
 =?utf-8?B?a2VOOEd3L1NUNVFxQXFqQTdZZDVkSloxdWVkb3VXakdxYVd3SUxnS2FYWWo0?=
 =?utf-8?B?V2s0dUdxczRpUWtIaml4RUprckM2TXIyV0JFY25wK2xPYXVtQ0VONTB3NHVY?=
 =?utf-8?B?bGRzc0kwSHNYODUxRnkxMFU3UEVOTkt0cStPTFZLZjQ2TUF5SStLNUJFc1Uz?=
 =?utf-8?B?dk1qU1Y4UVpNK1NwS2lXbnZyc2o5RjFHZyt0SWg4R1UzZGJJVnFHMEU3eVBr?=
 =?utf-8?B?eUg0RWZzQ2VjamUvTHR1ejRjWWdscW5DNFlMQ3A2aXZ5bVI5b3pPZUFoS2xJ?=
 =?utf-8?B?dUZxQ29HSkZxWjNaQ21uRnU3dnNodUFLRTEvM0pIZmFoWEE0SXpmc0JvaGYz?=
 =?utf-8?B?bGJla1Bla2NPam1PdUJvVXhNakhRZDgzRzFUZTJsd3NHQmxKL0ZOMytlYURp?=
 =?utf-8?B?dzJnNGFONWtwTHRlaHZpaWtGVlJBUmhuVXl6cHdoWXJ3RERidVErMWlaTytD?=
 =?utf-8?B?T3I0MlY4RTlrTFZ3YzVvUWt0RTlCS3EvSURKbWZvdGFEdno2bWxZaTFSZlB6?=
 =?utf-8?B?d216YU90QmpkMWtrbk9UOFoya2pTVVBYMG93VmFtaXZYYThBWXZxcWhaQm04?=
 =?utf-8?B?VTU3QzhhOUZFRkc5N2NBYWxSWWhTUVJ2RmE3U3FEbFZSVmlSZy9kaHplaFBP?=
 =?utf-8?B?S1Uwc24vRXdwZDM1YXI2NWNhSVVCc0w1VURzKzU0N1Q1Q2U0RUtpaHBJNGhm?=
 =?utf-8?B?WUN1K1IrL1dPblQrRlJobWhJM29qUitZWnJ4N01ISURQMWRoTXdTS1l1ZFRs?=
 =?utf-8?B?d1RSNzlQR3R5aUQ3VUpWWVJMUUpoUU9PVm5aNlVqTDFlU3F5MTloUDRzdHNn?=
 =?utf-8?B?RUJ3b0FyUGhxV0FWNzVXcXFrUGZVb0wrZ2FsSVdVcXkxZ1h2aXBzSzFhWENr?=
 =?utf-8?B?dmxSYWVZeEc1S09yeFEwaElEZGEzRy9JZXppRDJTUmNxVFE5clBudmo5Q09M?=
 =?utf-8?B?a2tlZkkxWUNQZXJydGtpNmR3MHN5UzU3WWNHU2x3aDdqRUxQc3JiN2ZEQXNh?=
 =?utf-8?B?NXE3MDB5U1NrSnVpR0pWQW1sdlBpM0J2eFVPK2h2MEk1TDBlQUFkM3hEUHFq?=
 =?utf-8?B?cnhCN3dVS0FFSkhnVmdNMW9IVWVjbDcvT3NKMUk4N2UxVGpYeU5aL0c5ckdC?=
 =?utf-8?B?OXZsZkE4UzJ3WFpOem1QbkNDWTFuZ2U3UEEwR2lKZTlWMkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2RianV1K2tLOTQ0OVc1S2VBcWNvdmRqSkNHbW5sWGUyQm9sQjFzVkQvZFNL?=
 =?utf-8?B?MVQvQ1Y2Qy9jdHdNWVk1NmRiaWQ5N1VDVW9zVFFvb1Exako3b1hLRC9oRWhD?=
 =?utf-8?B?aGdOSzlVNXlJdHBac3dZL0d1dVFZblllOU5Ha3QxbWI2QWJjMXhYV2t0ZDFn?=
 =?utf-8?B?ek5YVXg4UzJLRG1pU0ovVnNUVmtaMDAzRGt4SXZkOUt5dGdUdWNIK0NaWGdX?=
 =?utf-8?B?ekdQbk1aSEdCWlpkbmRpbHcvVnRVazN6UFpjS0N1c3QvcUpWSzhIN3lqN3Zl?=
 =?utf-8?B?blNhM0dqc2VkakNjUzhmYm4vR0Z0YkRRdk5qL2lXT3hMM3RPY2lzMWhkK3FD?=
 =?utf-8?B?dmlPUmRERUozTEtyM3NZbVFlc253b3pqM2ZudU9xeUFvdStmditxUzc1MW44?=
 =?utf-8?B?aTdoMTBOV1Bkajh5QkYvVEtzUEhHd3FVVUtXdEhtRmswV3NrbVpQeklZLzNn?=
 =?utf-8?B?UXhYcWh2dFljUHcxb01jNU5seS9KV2t5aWNFcmIreDZRTEJYWmJJSDBMd2JG?=
 =?utf-8?B?L2xkU3BwOXZ4VUxHYXppK25sejQyUW8wblpOdTJ0Y0dId0tRQTJKRmJta1Z3?=
 =?utf-8?B?a1JtZUlsRWJTMFFpOTQxSFJnamltbHlSQzhhOWp3OEVRTDYyL2JreDhyTXdS?=
 =?utf-8?B?T20zK3NYY0FaN0FpTTV1eG5SRWd5em43QVRKcG1iemoxS2ZKakUvUzlzbTNw?=
 =?utf-8?B?TVp4YStXWWsrc0l6T0s2MGdQNEUvaUFtWkxpK0VMcHk3Z1FKNnh5QmFEclhZ?=
 =?utf-8?B?Mlc1QzZDSnhORW00ZlBjVjkxN2RIbzdUMndYS1NodHovM1dkQ210NSthUUVZ?=
 =?utf-8?B?UWtiWUJSa3hZbWpxaitwNml5RlYvRFBRU25xaEZDVkhFdXVaeUp5OXJMcHlo?=
 =?utf-8?B?VndNYWdoejVQMmU2clA0RCt6NXhWNm5BbDlTc1YwQ3o0elVFODFneW5SaXhI?=
 =?utf-8?B?ZEQrVkw5dHIrbVR2dDA0T3lsV3VoYm92TDgrWnA0eVV4MzFvbGh2bjRqMzlT?=
 =?utf-8?B?bW1qTEVDcGtRTVhMVVBPRWxrZk9CREt3MUZrWFFPWFhBTy82UGxNOTRXWm9G?=
 =?utf-8?B?a01ZRXN2ZEpZUVJNY3ArbFJOYkloM1FraEU3bUkybUVqZE5ZNnVLemVxVTkr?=
 =?utf-8?B?Q1RXTEdBZFlZSlJGTFVTR3ZLM085SnlOakVKTGhNQnVicmlyYUtWcGxWZndU?=
 =?utf-8?B?aVg4SlV3Um43OFkwalFoeGRyWUU4WnN4d1hZd0pudzd3ck5ncE9DRVVKYkJI?=
 =?utf-8?B?YWhOUVpwVVlydzBUaFVLR1lrK1U3R3lCUmxoemRhdEhLckVNTjMxa2NhZElN?=
 =?utf-8?B?dWFVOEF5UDNyWUxoVndsakp0aXNvWTNkaUtDWmZqTzBYOVJuSEdDT3gzTjE1?=
 =?utf-8?B?cFJxVkM2WTNyb25qYitrd3E4SXFtbUdEQ3B5eHhtTitmMFdHZTBuZU9QL0JO?=
 =?utf-8?B?NjgrT2xLNm90Q05rNEFaemdNTHpZc3BLZ1BNYlpvR3lNZUZBUVpMZ1luTDUx?=
 =?utf-8?B?c1ErUmxxcWZVVnBrZ2UySDI4Uk9oSlZzcWx0dWdKZmlxREt5NzUzMTZJd2p4?=
 =?utf-8?B?UXhubXNVaHBuemlRUENLYVB6RWFoSVg5WWZpc2sxdVBxNnNMRy9FOTJnY2kr?=
 =?utf-8?B?Nm0ycFBuNDZCZlNxRjhZcnAraloyck8xZWtRZHRUNFk3d3MwZnd1QXpobGw0?=
 =?utf-8?B?VXIxRVNlRFhnTnl5aVhQQVNsR0hCdWVYWEM4SHZQdDlnU291M0tSTHJVN2ly?=
 =?utf-8?B?Nmg0RXhlcUNPcDNQTVVhOU5OMk1CRFdFR2RCYUVoN3g2SkZpaDJFNUpNVUlY?=
 =?utf-8?B?Q1AyQS96azMvVjF2ZWFVbURLYUpMcmorS2tNbDFEZC9VRzFtQ3Y3a2RzR1l6?=
 =?utf-8?B?VEtFendaanUvSjBGdStxdC9FRWtvNU03MDMxTDdXUklXUGdicGh6dHYyR1Np?=
 =?utf-8?B?KzdzT1hYaEIyakh1ZGtzU1VPN3d1dmYvc01qV3REQmd2akxjVnU2M0pXczNa?=
 =?utf-8?B?TE93Ykd3N1JIQ0V2Rk5OZUo3U093VHhETHhZeGMwMytBMENacWpvRmlYZWZ6?=
 =?utf-8?B?ZDhpS2Y2VlBMQ25MdW9Razg1dTJSZ2R2TlAxRHo0Nnk3NVU2dDhuRWY5Uk9h?=
 =?utf-8?B?aHJGWnpaOGhkRXJMT3pTZng2cEc4VzVqWWVDbzRPVUc3K3E1Vmt5VmxtbHdY?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de50e5b4-505e-4457-2739-08dcc695fce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 12:44:27.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXAQDxPkrDb42yIBf9c4ZIpwLd8rM25S2eh/F/RnW8JG9ZcFd5slATQilc5YlOgqlKexTqwovXiXN+l8e2ABzN5bZqtoitxkYy0cet4gwG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0751

SGkgRmFiaW8sCgpDdXJyZW50bHksIHRoZSBFdGhlcm5ldCBjYWJsZSBpcyBub3QgY29ubmVjdGVk
LCB3aGljaCBpcyB3aHkgaXQncyBzaG93aW5nIHRoYXQgbWVzc2FnZS4KSWYgSSBjb25uZWN0IHRo
ZSBFdGhlcm5ldCBjYWJsZSwgaXQgd2lsbCBnaXZlIGEgbG9nIGxpa2UgdGhpczoKClvCoMKgIDEy
LjY3MDM4NF0gZmVjIDMwYmUwMDAwLmV0aGVybmV0IGV0aDA6IExpbmsgaXMgRG93bgpbwqDCoCAx
NC43MTkyMjJdIGZlYyAzMGJlMDAwMC5ldGhlcm5ldCBldGgwOiBMaW5rIGlzIFVwIC0gMUdicHMv
RnVsbCAtIGZsb3cgY29udHJvbCByeC90eAoKUmVnYXJkcywKVGFyYW5nCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206wqBGYWJpbyBFc3RldmFtIDxmZXN0ZXZh
bUBnbWFpbC5jb20+ClNlbnQ6wqBUdWVzZGF5LCBBdWd1c3QgMjcsIDIwMjQgNTo0MCBQTQpUbzrC
oFRhcmFuZyBSYXZhbCA8dGFyYW5nLnJhdmFsQHNpbGljb25zaWduYWxzLmlvPgpDYzrCoE1hcmMg
S2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+OyBzaGF3bmd1b0BrZXJuZWwub3JnIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsga3J6aytkdEBrZXJuZWwub3JnIDxrcnprK2R0QGtlcm5lbC5v
cmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcgPGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBpbXhAbGlz
dHMubGludXguZGV2IDxpbXhAbGlzdHMubGludXguZGV2PjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+ClN1
YmplY3Q6wqBSZTogW1BBVENIIHYzXSBhcm02NDogZHRzOiBpbXg4bW0tZW10b3AtYmFzZWJvYXJk
OiBBZGQgUGVyaXBoZXJhbHMgU3VwcG9ydArCoApDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4KCkhpIFRhcmFuZywKCk9uIFR1ZSwgQXVnIDI3LCAyMDI0IGF0
IDg6MTbigK9BTSBUYXJhbmcgUmF2YWwKPHRhcmFuZy5yYXZhbEBzaWxpY29uc2lnbmFscy5pbz4g
d3JvdGU6Cgo+IFvCoMKgwqAgOC42Mzk4NjBdIGZlYyAzMGJlMDAwMC5ldGhlcm5ldCBldGgwOiBV
bmFibGUgdG8gY29ubmVjdCB0byBwaHkKPiBbwqDCoMKgIDguNzA4NDUyXSBmZWMgMzBiZTAwMDAu
ZXRoZXJuZXQgZXRoMDogVW5hYmxlIHRvIGNvbm5lY3QgdG8gcGh5CgpXaGF0IGFib3V0IHRoaXMg
bmV0d29yayBpc3N1ZT8=

