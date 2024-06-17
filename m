Return-Path: <linux-kernel+bounces-217091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEAB90AA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25381C232C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D0195B31;
	Mon, 17 Jun 2024 09:55:09 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A00193085;
	Mon, 17 Jun 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618108; cv=fail; b=Jgw9tH4j2ywYWXTGMirh1OG1SzwobbSoC6w/IjqvjXXIXp5oWqUcOJOQ7TIUEbcYRXmlP2tVUvrzIvEuQpcmKd6VV7729bu+4YKBeJtquB7Bc46isrL/mLWF76VXPP4xcTxP1HUJvEuWMdBlZ9sFMidf7grThHhUQjTbE5dVYgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618108; c=relaxed/simple;
	bh=8L4rZ3UOBocrXOLxjB5pA9UDA8FYXDZpCiIT3jiQnbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjq1iNVocrA3xqqZdKdTXt7JtNR3TzQC1Pm7Yx/9HrJj96sb8M7GfOGalkm/G3BK3deM6L84+1K09MY0RdbA5hi06Ey3yaDYKauvGUcp4rxTD0CNmI2Phg8im79mI4CZrV9fnJTmr4pTCnj+Z81bn1t7IsUbCJibDDZZqOUSe2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdmWWmrtEOmV03eAHw8TjwYZlGdCpKBi0J6uQ9pSeUJN8sCxYgkpjKc6VLDW76mXDgciUmHLNq0Gnf23IEU0F8ytReB5aP4q3ohQLCj83qBRyRq5q35B/Fa9Uwxg5vEHD7xSuohxeoNDHE4ZNS3oPRBOrOJrazItjq6q5FhNUse+Fym5Z9HN/UFyGJcSJoTwTGYXdf9cw0i83ViUkLvNsSD31+M124DP0KODW7TwDv9u+o0mWwTikzC0OWG3BZPxKZGjBd25VtL/6/pTwlCLxK8IeivboVdp3j5Lr+ArF6InwDoCG3rBUSyvaw28PVcscT3SbBwW9xzfoJrF7dav+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BaY40C9D7V1DfkSfhQKQOIobjp70GWJYf/jhXtkHoY=;
 b=OeIb4HVHeRGSclL9e2Bud0VBcb3wg84NXoFBFXKV6OGHd70O5fa2MznMDd/Nk8QwfX9gSos4mawu9khk2wxlRKmM9rtu2o4xYHjC5hs14RIjQQmBqjPG/DQdI6oaNxHsDYSL0n6wWPYKhRMI/YwO7evHXt3eABCVr7VEi4cUPjEh3oneQe46vpXp8wB/1htARsKbL+RLjd4gj+pO6/xvX1hiFFhnllzzB7dnTnnuDgdjU9P8SZUhd7gKxLuY88jv/LOImFdc60NUlm6e8PqdMxkLbKHaYyR4mcNsaltArEsWv5GImPagRpNAQC241RKCi5qy8r8bY6aQesRitR8S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6772.apcprd03.prod.outlook.com (2603:1096:101:8d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:55:00 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 09:55:00 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alexey.charkov@letovo.ru>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "heiko@sntech.de"
	<heiko@sntech.de>
CC: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Topic: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Index: AQHawIWSGno1qGDO5k+YxfPMD0x/C7HLrc+AgAAGRQU=
Date: Mon, 17 Jun 2024 09:55:00 +0000
Message-ID:
 <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
 <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
In-Reply-To: <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEYPR03MB6772:EE_
x-ms-office365-filtering-correlation-id: 3521782c-56b9-4efe-252d-08dc8eb38d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?s4mx+eJw0enJlSDyikBhfPNokXrGCj0GUrQEXfTr5/bNlY6NtfvM3UwnzI?=
 =?iso-8859-1?Q?MbhCnofzKq76OdFTjhbsZbcgrjvpZnneccTZnETSexBkPpyLXNPQnUaPiX?=
 =?iso-8859-1?Q?dT1ri28B7GGsW5E/XKjS2u1PWd6OgxnIOSOocXiqC4DZR0a4DymWijqrZv?=
 =?iso-8859-1?Q?900gB0KVnoJLWMDE9fpkTa+r7JXo1gGJVDX9EYwk18+snnbcwSpCZq1gq9?=
 =?iso-8859-1?Q?f0QMGaoNINAc5YwBIOQ5g1aNyYBEkYRGyoF+IzXxWXBUwxGWhqqKhCm3NM?=
 =?iso-8859-1?Q?kA/EJRKTry5FZ3OD9nxnvbq77wP1Rcmwx4Wl9Ijg0iootH/1iX0oWsO7mu?=
 =?iso-8859-1?Q?v1J7enOXUp6M1N/NYRCXVrJgz3qxr6RKfaIQ0taHei1ST68FuNR/TRSIAN?=
 =?iso-8859-1?Q?XhmELPgN/YQRqrq5oT0sKd6z3tB+FT+puYeV+x3WojYTdEIsnasEtSyN3i?=
 =?iso-8859-1?Q?9BXLjqH/Jt5KaxtmLi1FKa5YWXYzJIsIJ7RL81Jb5zGLn21KgbdiIPsEBC?=
 =?iso-8859-1?Q?GVsfbZu2gf3dTiic84XsnmJpPlo5D6Yo7MbXj+R3Fd+/ru1nbaCmLt9Yrh?=
 =?iso-8859-1?Q?F5hrieggg1YP2eki+Z/FDMnqVvj0QLThPEe+1T3q9CH3mt/V+9V+QvRyNa?=
 =?iso-8859-1?Q?xRKKzSXByzctQiujWg0OjtADC+tSdCT+nCtmIXZU6pRDSccsWVEcCeG75p?=
 =?iso-8859-1?Q?rDisK1TZSQkVopwDfO6NCP6rjgbA4dab6A2cEqMFkZKuJVOQgTs6ck0tde?=
 =?iso-8859-1?Q?R0N1kJ4gH+NktGefzCJbMAJMhFQ+IVEmS/0Vk8yTZGqoSwn8LdmR9krjko?=
 =?iso-8859-1?Q?i3LdKfgNGxmd16300HUslmoILxTAr5gVSTbDWvPTODfj5VCx7NTdVGROAf?=
 =?iso-8859-1?Q?HbGHPn0MrlA+9C1ivK35hSa0GMi8yMUR+iHF6Qd87Ax3kebs1BHVh85PVs?=
 =?iso-8859-1?Q?JIEvEk82AW2dVMIxFgaOoGm2wtqNahwpLL4c8b3zcFhk6URw1UiEm3POML?=
 =?iso-8859-1?Q?jSMBOn8lyn3uYFYuuzir7DXaO7vq4VRUz3T7dV3FW0702HSAD0Mp4gAqaw?=
 =?iso-8859-1?Q?08HtcKLqaJ30CYYBWfROMZgOCFRFxOrjqh9VxSEiKy1Yg7ABYEhaUI438c?=
 =?iso-8859-1?Q?cHebKP/ud0Jpv+xDvB9tuD1fXXfDgazIU0o1H9+faqQw/qZxXx8uJ1+NB1?=
 =?iso-8859-1?Q?foNmB/uD9Q4oDHz3K9k9ShknQ4IqMYDWfjbj77WbpZSfd2nVT9qPQO7kA6?=
 =?iso-8859-1?Q?p+1E9WhTRrxj+MMi4QAjKFFC/KLOemXMeeKBLvq05dQCf5nJ0wHOibgmP3?=
 =?iso-8859-1?Q?xNRtdm4UyklCUPGVUFKLBxR/ff0kZJbTBCpeh09LOgDIBgrYx0AXB2wcBg?=
 =?iso-8859-1?Q?4K1Irvq1CuxPAl1tMbDblcHQzfGiHKXE7sbZalGMQkWrQxx6sSVzk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l0RsULeJy0YM+0xfw8ZjdVmL8HWBfFJV5K3G+N9YUFcvSgQidVSIusKdw/?=
 =?iso-8859-1?Q?xKTQ4vqXN/fJ/ExtI6NYbrcr5N47ZdMSro0VtnNeJ8gvaXMO7bAcSf1MtU?=
 =?iso-8859-1?Q?C4XW6XUby9t+58YLRkhuDB9Wsox72igskMZYV+U9OkonrtfcmLbknwWADq?=
 =?iso-8859-1?Q?hlswh4gZUkkFq4unpHPkJ55q50MrERFB2Y3H3TGwDA8dZa0U7A02Ht1xAf?=
 =?iso-8859-1?Q?mnIWfKN7W/Rll1llmnNYh1c/iYzFjvJlNsaa6hjJKpPaDIBpkm9SQOYq/d?=
 =?iso-8859-1?Q?Vm2OAoQ5CCBVk/psC3a785IRQD9Jbf36V/ybD9Wt2f6Qvm3d936I0rlAZ6?=
 =?iso-8859-1?Q?Yvh/4JiQSvTmp38KMRFkTqbrVmPb54kNLGpL6VmMgoj4SHGgwOLndvPqas?=
 =?iso-8859-1?Q?i0nzAuXNudYcm0lIvu3C9EyERXtVrccIjWkv7lfr6sjrN6lrI00wL/A5/T?=
 =?iso-8859-1?Q?BD8qRJLvqQSQ0qjITR3s/4tL6N19V6qjEe1oAOQILHrmTfD4Q41hfYseNK?=
 =?iso-8859-1?Q?oVjdmh+E5lNiXkMq6QKn3t+fRC5OPGtFQLc68PufIxUUWgSCUkSXkm0KID?=
 =?iso-8859-1?Q?sGSlBXdr6UJ+c+Cnm2zWymdzkdSGJ0eTmwqcniZZne19XUiLl6IDzpn+H1?=
 =?iso-8859-1?Q?dwIk+ngGgZIxA/3kG90SdnrpZgStk0MsKDhoasSgCRVJL5Ebhc+dcgN2aQ?=
 =?iso-8859-1?Q?EI06+Jeaf5tA+EOzO8KA+QqRmoFx0dg2bk//+wbhjqwkAG6iIqu8br33eS?=
 =?iso-8859-1?Q?Ezc2sgfrKBDLDR0bnm9MYG7oNNA2yqs16n/UlHGA+l4uFQWwOeIURnlQcs?=
 =?iso-8859-1?Q?vkTdOJjpBaiDBxBPlWmFpxgJe5EfTxXHomfX2WxRyeHnEoz+xHF99TL9fi?=
 =?iso-8859-1?Q?FA4RoruTKBeuFNow+Fn90BvZ7OAPXNQSeYpaM3Wr96J70BnCboZkCcJHwN?=
 =?iso-8859-1?Q?LZRhyoIerJB/9QU5CHbpf1XLTmOmY8WUob0CIDHOB35JuOwXT2u7tHO+TN?=
 =?iso-8859-1?Q?0Jn4hIUzQoKB7XgHRcc+KUsoam2anKNotw8T0AY2rfItGdxN7JXrntQuSv?=
 =?iso-8859-1?Q?QC58kaw4ipFbgbCmJ9ZeOnn1EPvImkKQmC+lYU2C7dAbyz8rV5SRH1Xcpr?=
 =?iso-8859-1?Q?OXpnXtwemFyrHzF6rpSOtaYHPd98fjQ+96ykCxpVFsNECTSMHJYIOjyZJt?=
 =?iso-8859-1?Q?4L4y1sv6H2jvr2G3hm5QOlmplG3jlzv7e9zrh+0PFgqZA8mRTmmxIVPFa/?=
 =?iso-8859-1?Q?QaZE3q1swqNGweAY4GzDDz29xEi8AuZfmJO/P/ctl1o2tCwGTwu/NF7z6M?=
 =?iso-8859-1?Q?ohAUmCwlYabzfxJhdkQtkcVsSKA4vnG/RDSTpKg0m4VBt9WDMpR6zN000O?=
 =?iso-8859-1?Q?6cCGxvRtLjHt69NU0I4LC7B+VlK1nLoCGRhJV8NJ6/1jCTyS+ohZVlzK+Z?=
 =?iso-8859-1?Q?d+YVOgoA/gjDLaMMPsR5EhPMPhXvoW7kK6nEh7faN/SZhaB/MKq5lwDON/?=
 =?iso-8859-1?Q?lCqYBPDcCHZ0X1MMnJt2lThUfBU2SB0tfV4Lob1+s6Zvn4403MhAv2KO3T?=
 =?iso-8859-1?Q?4HU2e5QC3mIHib0sE+VggH37JOEIU9bZpXtYiZk3nYxPNfRR6+YMAzC5lM?=
 =?iso-8859-1?Q?DRKg+UgmfR/4B6DptrPJ4u31Jyru+j5SVW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3521782c-56b9-4efe-252d-08dc8eb38d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 09:55:00.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8at4cJjiEHyLq9Sa1sCEn5WCt4i355/t82clof37xhGFw6mSz6OZmFP7Zqcw2kbVAkC+QKX7p17nvYESmdXbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6772

> You refer to wlan in the commit message, but there is nothing wlan=0A=
> related in the patch itself. Update the commit message perhaps?=0A=
=0A=
At that time, I want to describe that wlan and bluetooth were from the modu=
le named BCM43438. But, it's true that wlan do not be metioned in the code.=
 I will update it in next version.=0A=
=0A=
> I thought you'd need to also reference the respective GPIO to be able to =
trigger its =0A=
> state, not just switch the pinctrl configuration to GPIO.=0A=
=0A=
You means the shutdown-gpios? I configure it in the bluetooth node, it can'=
t be configure in rfkill node at the same time.=0A=
=0A=
> I'm also wondering if bt_reset_pin is the right one to use here. On my=0A=
> Rock 5B I had to trigger bt_wake_pin to get Bluetooth up and running.=0A=
=0A=
Yes, I try to configure bt_reset_pin, bt_wake_host_irq and  bt_wake_pin in =
pinctrl separately. Each of them works well. After I connected a BT device =
to Edge2, I input rfkill block 1, bluetooth function failed. Then I input r=
fkill unblock 1, it can rework. So at last I only configure the bt_reset_pi=
n.=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

