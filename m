Return-Path: <linux-kernel+bounces-302643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CA960155
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02CCB22533
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4D4DA1F;
	Tue, 27 Aug 2024 06:09:33 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2102.outbound.protection.partner.outlook.cn [139.219.146.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5213E028;
	Tue, 27 Aug 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738972; cv=fail; b=G83cthXhhQPX0m0zv1YsusyWlSdOeLIbodmYFCSBAm4P5YkLI+7MV9SnM7xScs3p9ARt1P4oX95QnH0UrkXl34CpHLpy7zjEnZYvXF+wAIUC/TDzcwvqK4cdbARF9zxuyVEUfwji0NqDF91UmT7s/FZzBAI7PSLmz8DQQ4O1hsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738972; c=relaxed/simple;
	bh=tR+NGJwAyt6ddgPTyy8ApC9Il6Rd4M7IJbzt3wm9MnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYnpSyqoYOiENI0ETL9o5X0WegKharyJHAdYDdiBED3oZ7EELOZe2NZZuJR+DSCFZ6n5W8w2DdqWYeeyzNo1wjaCgRclZ4GceCeZpXJdPsmG014DIO1vVXMEzrjbAXwSvr16ZX8SJaAGqUUWmL7+DBr89ZJirWk5rxaLUgem/kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoUqZGQhC5aPQWzK2bKXO6IcrKbysxV8Ud2f1nypo1FUXVFjHSqqBlLNxkSt+EUwwmnIF//E8CHKjD8785QODquNivkZvbxbOn17aIngaUMNk1VVTdHyhnXoItgj8C+A88Fs39Bs+E8jW85XtlrqFtKhuBD1Tq6xcRALW3EESkchcC+yighGfErnH5qpiWmprvVGmOZe4G+8xgi6AbyFJZKpBn+aYcEWatLntfrHTXFhfwFtOHHEWpCTnLq+iZxX/iXjBj0jZoMoanKGEz9dAKSaI56P9Jv0E5u/lVvzRyOge+29j0ggVTOvOfBcWj9rovDD0Jx1CFFEptNhUpSzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR+NGJwAyt6ddgPTyy8ApC9Il6Rd4M7IJbzt3wm9MnQ=;
 b=iEQ8+ABk1caSqUER31TDw9l40QSGZZ6CCJHkWw+vPSxQ8OdDoT9HOMsFeu5CbjOz+YrumRY3uOZ/yFyNzz3X34ND0aP0E6xNTe4SZVkdjp+DWyjRvY8AaGCFzuK4ldKzcztGrJPdIhbfU6YfERgOnv7QDNVKL+opZf63za+KhR8gOf6zi3Fh4wozVq0csLaR58Vz0qfA2VfckcMgidXBGghJT6BkgiW7VzP8Xtde2+d6XfcR9Eb0BJArvaVm4cY7ixzOwfWJGfIWayZaZxedjW3gB+uI3Yuwh91xigYDNk8bjCZk8kO5Ck1aAb1yN4pNFltOmkKeJmC6H7N0lp9/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 05:52:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a83:8682:b030:e46b]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::5a83:8682:b030:e46b%3])
 with mapi id 15.20.7784.035; Tue, 27 Aug 2024 05:52:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v7 2/2] riscv: dts: starfive: jh7110-common: Fix lower
 rate of CPUfreq by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v7 2/2] riscv: dts: starfive: jh7110-common: Fix lower
 rate of CPUfreq by setting PLL0 rate to 1.5GHz
Thread-Index: AQHa946azmyE2QDh1EOkjHfeCoNoFbI6mvkw
Date: Tue, 27 Aug 2024 05:52:55 +0000
Message-ID:
 <ZQ2PR01MB13078F4981B9772FD462CC00E6942@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
 <20240826080430.179788-3-xingyu.wu@starfivetech.com>
In-Reply-To: <20240826080430.179788-3-xingyu.wu@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
x-ms-office365-filtering-correlation-id: a3d68e71-9f43-426f-7bf9-08dcc65c7f92
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 +IO7sbKHLUpR+8BL5oTNs7xR/ZESaD0SdY4mQDBUVsHKz7qSUf05aFyYCjwIndtOEgLpOGU1rCws+8+NJHw/tAsmRouus8O2Cn43yPkqXFbpV90jfRl++Qu/ePjWPDNacP8ACKgVfZNK4rf2Fhv8OA8t5TmAaX0/9ey9x3iRZMgg92wluUoOrUq7NZGUmmhiYhdyfIma1L/XmFaqrvynDQfULFxcJaZl/dRvXfyq5/u7cigXdzh1YVM8/xitwSn9YewNSFfWIOU4i3OcOW7ta4AhbDIQK4vgdQ7GlAlLB67vFlE7teosblU2hh+Ev1PPVXFPSIl4/qde1T/Srw6/I56qihzGVJNlro9Trn9Gl0b8/wDr2G+MLFJaJMZs5L7y836NqDMy+/uxQqTbLV/r/K04xSYq5FjAEmcipT/VzC4HjzI8jG6tPIbB5xc/3koXFcDcnbstFZW5yNafip+LKpzcyi9oFrC0w4vNIXIonWYlleucVTIUPRxOQ0rQr+LhbmrLrFoK6wf89ASFyCvdoxbSgth0nZ2aPVLDRSPHSBxWtLOi1HRoLst/BBKQ1aOwLIykLVvrWIGY/tKbiPnDGdKiPw2rladweKh0PLy3sD85iTqt+aB3CcnleRQfme58
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tsFCjaTU0JriSPL0Vhzptns5c6soXn4dVE9vKu0qAW7n2I/IeeGTXkezrE+t?=
 =?us-ascii?Q?9gJI7FlgR6WQacLG95aZEhlFFlL/NFhu2cmxMdg6XOA7DrXwmVvCDXcoFqq7?=
 =?us-ascii?Q?cpo7+e0EMrFkEsozPbc4WwJqFJkDeKeklbQu8ZiRH3pEowZ6u9NmctRuenZk?=
 =?us-ascii?Q?oYYOp1Sk1ORbxgUsz0Xc+C4cL1lYWczVUZpG43Q2Cg1nSdbJ+MJR23bybBZx?=
 =?us-ascii?Q?CGMmBgN9lvkArjQAqig8gss0D6aVBeE3OAjqM/uwWyAMxHG5oar0tAHn+Ept?=
 =?us-ascii?Q?c+2nRjMZaR+YcNiazYn7qXHMVplY4TGyYyqZjkwZ5eMiF7K21RkraIiERmiD?=
 =?us-ascii?Q?LkP47fLuydQwLdxSAUQjE9nI0MPZ8bA8IEp3UtxDncdH6CDxfFMXhrAs+sYD?=
 =?us-ascii?Q?RF4pg3EEAY2oDNmfqoNTtxXRPr+WIDwqNGapIf8vMM9y/NMcvV5C9fuJa+6B?=
 =?us-ascii?Q?wC+047STWV/Ev9jt8xIgcgJVmE2Bqp1q/gv0Gq5lR5IYtQJBph3FrK+Cy2h2?=
 =?us-ascii?Q?JKyyWxEaSxKYEt9fJ60Wo7t6Vhi0lPQZjJB5YN7I0giIYsvKlUZSWrvuv8t2?=
 =?us-ascii?Q?TcGBOHTlAGLFetzABjXR1jeRomlnPSUCcXT0bgmY77jI/18TIrZ7GyjOqNXb?=
 =?us-ascii?Q?f4SoLt3Jq38krOhWOGIomPCPilfWJrrBtTKPXDLSQUMpZWsFN0aqm3N7wL0V?=
 =?us-ascii?Q?rZ3lCIUbRkj4Srdw68fDxxeHFTYpkiZw9fSDbBhmYcs8BB8vcOIUfAxHG6DV?=
 =?us-ascii?Q?3OGbB38lt+Ad31/DbM1T8IavG2f0orKlc232I14b2ACCJ20JOHad+xQHf9d5?=
 =?us-ascii?Q?rDToHfmMH3+LoJPSeBgRA8VCupyjK5OlI8alBDwGiGQIFog03a63d/yAAQVn?=
 =?us-ascii?Q?4bumVahuUGLW9Y8/rK/jYm+qXjhSxPwz/aOA0GFgRXto/LGnQ/fhqOJXpyGq?=
 =?us-ascii?Q?FMB5ic++QJgPjxWZtX8hmiXGa0tgB7OmL4mu+ae9U2wmWOGKfemBVJanwdqo?=
 =?us-ascii?Q?SDCvVWG05FuFCT+8PvwyMqXo3O7YmCOixR8/LCeQmZoXd5lHQ/Kr16Mt2ggZ?=
 =?us-ascii?Q?ypA06T5aEvMujIgsMZQVMETga6G0H0EepQG8eAcTcu2mZuii6ThccX4VFFbS?=
 =?us-ascii?Q?WHVY/0XvBFN/4lk8F47Xq11k6KhJ6WsaDzsgXPDNi6FLmw45Sugdk4erRMEh?=
 =?us-ascii?Q?j1Us4p5bKRrb4FyhoYsS/mWhMWxby1dy+TbgY5u3zbU9M5E6M5FG0/++DvaN?=
 =?us-ascii?Q?OxWLXUw9Z6mYqsQtjN36qMtdYlg6Sxy61RwQqLJV2YpuBG9qHurZ928AJ3tW?=
 =?us-ascii?Q?Ef3RROX5JwmGALcNOw6ozti78FXsn4f8jPeflzRzqun/mz5iaaQkYrBRWlUq?=
 =?us-ascii?Q?4vG0RYNY73rSP0Xt4gb6vRSa+bhVnJbJUCZ1eXOnOSID9sOIXCJNgu/S7X/k?=
 =?us-ascii?Q?WW4TTquDm9X/iqHNXAR1vtL5HV4BQwCJqk3eizDnQtYi+sTJi2xu1GJQA2DA?=
 =?us-ascii?Q?RrpmPJFgJZ9TnggJPkrbY8Po6AhUa2wYEAFFMOM/hOVHpAQjD0ypXTpGrd27?=
 =?us-ascii?Q?lzVv/jOvoD6aic/mUfg/T7DupgMYTaFp5XmkT1Ls?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d68e71-9f43-426f-7bf9-08dcc65c7f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 05:52:55.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIXcHD+39q6lSu+oYjPyfiECM2cUXyUmxnUZ2PRllGaco9Fj4b17oYPzt02HSgrJtUW/JqrWSxd8SPujlxjJGRMhx2Cai9ueTBLtzR+6idc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258

> On 26.08.24 16:05, Xingyu Wu wrote:
> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
> But now PLL0 rate is 1GHz and the cpu frequency loads become
> 250/333/500/1000MHz in fact.
>=20
> The PLL0 rate should be default set to 1.5GHz and set the cpu_core rate t=
o
> 500MHz in safe.
>=20
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 So=
C")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>


