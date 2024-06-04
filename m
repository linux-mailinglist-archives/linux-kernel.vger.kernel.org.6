Return-Path: <linux-kernel+bounces-200246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB88FAD80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083A71F23390
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DF1428FD;
	Tue,  4 Jun 2024 08:24:40 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43313C672;
	Tue,  4 Jun 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489480; cv=fail; b=o2jCIHez+/qWZG19D6zl+MdqNcGn5ayTK8XtSFgTQs3iKNCJUcfh3KYvX4LiFV2oC1igsKsdxk8FadbsvB0LVs/0JOufjT7/bmQ5VZtD0knqI1rkh6eHb2h5CA9W5SVy9wQ3/Rk3hRCHQgopxXeTjOUUnV2qv1YHIjOcszX+qxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489480; c=relaxed/simple;
	bh=VrX2WgHckJfya45CCMyKlPiUGMwBclr9OkWBMgBRXg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXDXffEbnJpzT0eJaGYrk1tzteJ3lpgdKVQanKS0P39o/hlM2ahECSaXxr6AO70iZl2fTp+RMJbm+Q+qg7RZQDKclTHHVykycoAE9DBy4TvGsyuJL/Sy7fLpHugg096oPbmhGV/+RmJag8T1vKvYruav9tt2N9SVRRU+ZctufLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuKWYXcsYpKHr7gF7l8OsQ6wHNUmya6lcgv08/TLZ4Eaif9gP2b2hjhCyeqYQalJ6gp+qnhLVt4a0u21HNo6gqn449/PJp5Q7oezzWaVcyVvHpZS0N2mhl6fY8uLXQflgk6UyxCr3tAIcoORO/GuJ6CQEsKjvq5VN3sd//zVuDcZn9dkfELgFoBOTvUZIYxiYfrpk90iloozM2hlxqBi5bfDf8pwllffPgp5sH7fFHYmogYeDgcKfFYN6Bu0axyjB+SY2BVVH73K4ZenVXy6ez7LZMFZQO4w+S/e/x2URXHCIMeE93Qgr1YWdPnep/FLPfjPpoCIADjJGTalUw/fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrX2WgHckJfya45CCMyKlPiUGMwBclr9OkWBMgBRXg0=;
 b=Vod1RX/SWpBBgIAljXEVPhuOQvYJUQa/kRCsk3vKaVYG2EmPGi+x3BiJICgnV6GqeXxQKjfdOO/2cUnIGN5Tx99L+L4m/t/0TpG+N3vk/P/u05IPV2Q4hySMBaxFiODbSZIt2gWwIoL7XVR56uFOV/05eVp6PQP4dmARr+uLzzUdH9hXMljfw8xs5K+guLf4JwPcBDuCz9UhnlfmAWtz13gjWT7RbCzYDSZdYpOjVMPEJVnu3AMOeWC0259dzakAayVXSwQyrhBh7hVOG3QLXkXAFvTJC0K1aJ/5YgLCWK7c/WW0ZSbgPV42EmWsdBCPoAFuAIPn28zThoiRj3DU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1210.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Tue, 4 Jun
 2024 02:48:50 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Tue, 4 Jun 2024 02:48:50 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	"matthias.bgg@kernel.org" <matthias.bgg@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "duwe@suse.de"
	<duwe@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, "kernel@esmil.dk" <kernel@esmil.dk>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Minda Chen
	<minda.chen@starfivetech.com>
Subject: RE: [PATCH] riscv: dts: starfive: Update flash partition layout
Thread-Topic: [PATCH] riscv: dts: starfive: Update flash partition layout
Thread-Index: AQHatcqNxZBz/Lksg0yPg7MZoTCCa7G24f9Q
Date: Tue, 4 Jun 2024 02:48:50 +0000
Message-ID:
 <ZQ2PR01MB13075FDF73FE3292E050DF36E6F82@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
 <8e50216c-2a3a-4946-ad90-9d66c6aae20c@canonical.com>
In-Reply-To: <8e50216c-2a3a-4946-ad90-9d66c6aae20c@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1210:EE_
x-ms-office365-filtering-correlation-id: 21437f32-6c2c-4261-8d83-08dc8440dd7a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|41320700004|38070700009;
x-microsoft-antispam-message-info:
 wuLb7a4QakLy9qnqn1xwPpaEGX/vOB/3vVmAlB+JDA6Ela1S/5PPawEGB9HqYBSUUqHnwVlWxhab3bTrXqYZr8v6jKv2i9LU7wENRYDrCRfle7I+japrxUOOmbWxoy0Oc32Ru8irHgX38N2+ablAAxJHgDq/Qc8svg5TLN+JK1rBQyG0oNY2Kj+QbJERu/TQthpGVb+cJj3Z0QUcoTeGgsg5yTfLaDxOW74Dls3cSJsibFT9AvjofjwH+doXrs/EADQbUzPz63tnFAojxqicu2ebC1LAP83n4Gj+e2SiBR7QQ8XYGffe0O0eom/omcnQIMpCrUt/asSR1WPc68/8oiAOh+aoSGemSrqLZjLA4P3iGJ/aiJ0gO8EAL8vD+1T3EEiqLf5713JUifz3vIsPZnGbsMyAQJauGszNu5pcWAacX6nBpljdvUy6UZqPKRl/npGoKbSVDY5QwzEDGlC5l8D+e7eA9rianUS118ailHLBZCKi5crhvroEOM80R2CoranLGs2MCxFgwn2Y+nD6YecdCqdFof3X3jnwl5bV1Ncpdrjk2zOZ2CIlS0SST2QPG+e+DIHVocP5rT0vl3ld2GgwiSACCt2ihKt0lsA/mTojOvJyjydQu5YjcHBYG1NR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVFGL3RlM3BVdVFWMmxvU1UxV21LaGVtWE4rOW5XOVVXbEJCVjRCTldZUE1F?=
 =?utf-8?B?V0JWblN6ckVwRTM4N1lscVJ5Wk5IN1VKb1FhQW9vdWhMV3pHc1JObm9BMG1F?=
 =?utf-8?B?UGdzcm5TN05XbEk1Y3k1LzhSSnZuSVlKVk5VQkIwSzZCajFUbGRKNkNvcUN1?=
 =?utf-8?B?U2ZDMjUwTXhaTHB6aUhlYXJLdFF4Y0hsVXQvYjFrRWI3TU1BQjhocW90dGxk?=
 =?utf-8?B?NWkyd0J0YmJWL0ZDR3FrZGd1endiMFlhZWVPWHo0SjRkL2tsYXNsVnZ6V0kv?=
 =?utf-8?B?aFA2SG9ZZ0NrZkttQTNRL3ZyVDRzejgyZE5rU3crYlNKbFRMcmp1UGtka3gy?=
 =?utf-8?B?ZkhIcFQ2KzBvMnIwTTVyWHc1cEJ4anBGSnp6M3pwSkg1dmhUM1dVRjdQWFFv?=
 =?utf-8?B?ek5sS2h1eFlzbnpuZW1Ec1ZUeW84elp6c0ZURE1jMndXeTIyMzYwVHV3UjFF?=
 =?utf-8?B?SlBNZVg0TlA1LzVNdEpNK3N3WjdBMk1nOE9CK3VBcy8xazlxTlROUEZvcU8y?=
 =?utf-8?B?ZjdvQndMUEpYN29NV1NLaWx0aUpwcG1DR1hLeW15Q2ViSEVRa2JtNGw2OGlt?=
 =?utf-8?B?dTVRb2x4WENZMS9VMzRqVVhZemhvN0d4MnB5VGt3STRTdVBZN0dhOE1PTXB2?=
 =?utf-8?B?cy94QU84VGFCZzhjZXNEbU8zMzN4cTY3YWFuNlFZY1BqQnZjVHlPcEZZWVhG?=
 =?utf-8?B?TnZ1N09hZUUrc3pPRUFlUC9hMk9qQW1ZcHlqbmczemNUN1BDYndqUElWQk5D?=
 =?utf-8?B?Smh6VmFibi9UODV5bkxxNUlGbTNieDRIT1B0OE9ma1NhNEFOYSt4TWZUWFl5?=
 =?utf-8?B?amdReDBjZFZVL3YrNnc0bi9WSkRDTU9MbnhIZjJRSHQwcWV4ZmtiOEw1RW1W?=
 =?utf-8?B?cS8zQU90aVVvdGRMTUI3SUJrd2dwSlEycVgxOU10Z2hwYjFBbWZvaS9kTjFO?=
 =?utf-8?B?RWdHbWJYUkFaTXZtUzFhRUt3UFZMMHVqV0MrdXZIMkd5RGdNQW1iSVhKUlJo?=
 =?utf-8?B?LzFCUXAyd2JXNmJ4aklOUGlPL3NlZEt3ZytCdWxIT0gvMS9zT1JLVWsydjJV?=
 =?utf-8?B?N1NxR0hmdFdwYmZxaXE5MmtTc2RSQ2ltV2J3bWQ1WDQzQ2Z5M3ZNZ21xUVk2?=
 =?utf-8?B?WERUcVpIYVF6NWhZVG5XNHB4c2Y1MytldWJvcnorVDFpMzl4b3p6SGtLZDli?=
 =?utf-8?B?NVhZSG5mK1VESUFFOGY2UjhhVXZGNlJzQkZYcXlCVndteEowdlVUMkNQMUNG?=
 =?utf-8?B?U0hkZTh1MitJTElWdjhNQzNscW8zVThIcUI1Qk92aUI1dlhocnBJR1pybXIx?=
 =?utf-8?B?cXN0Q2twZnBaQkJqbE9jM0Q3WTBhSzFoS05mdXQ0SytCRW9YRE55dEFZSms1?=
 =?utf-8?B?UGJBUjl0c1FDR3FReVZFaGs5djBQdDZ1cDIxdk9HRzlOOW9LQXJNb0NFVlJj?=
 =?utf-8?B?bWFpL2gvQUxOZXBCOHg2bkJUanBOQkNURWkvNXdqQWMwSXJtTTR6WmxGdU1W?=
 =?utf-8?B?TzlRL1dMYkM2cUNWTThGVnRuZDlFamsvc0ZnK1FjOGp6djJ3clVBWm9xTkJB?=
 =?utf-8?B?Skw1c0hRRGg5TDRnSnN3aGNFbWRyZ2tzdXUyMHlqbmhDK3RTT3MzR1I5Q0Q3?=
 =?utf-8?B?SWQ3V0Foa1Q3UUxPeitNN2daV1lrM05DVWw3SUpicGZpTFMra3BYOEFvKzlZ?=
 =?utf-8?B?aGsvcm0zSDNJTGpYWlpmYWhsYXIwd2w4SVdIR1ZvaUE0R2IwVFFxV0M4R1lH?=
 =?utf-8?B?dFA0WE5MMnZFYzRubW1iS3g5T0lCZmtONEJMYTFUODNnSXBWcSt2TllQbUNL?=
 =?utf-8?B?QzFVS2M1eWpGaFhLUjBrZFQ2NGc1bko0OXlPclVoY1Y3WnMxV2N2b3dEdmJI?=
 =?utf-8?B?UGdRU0Z3WXBDT0tIN0htTHYwWmhxcWJ2UVpJQ29iM2wrd0lBKzFxZDdIeW82?=
 =?utf-8?B?Q3ZoTXBDT1picEFIb0l6R25xZHlaVDdVYk5JSFlualhKMU40MHIwYk1oM0Ru?=
 =?utf-8?B?bUlnaEY4SEFoTWVnSnkwb1ZsNFM0bVA0eWdrVUtucG1pd2JIekFZeG9PWFhU?=
 =?utf-8?B?UTJsZUowS2xZOFNSdzR5THZycmw5dit3TlZRVUgxVmtVb3Qwd3FwRk5tdHZ0?=
 =?utf-8?Q?8MgluT9edetVBd6P4GbdRInBr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 21437f32-6c2c-4261-8d83-08dc8440dd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:48:50.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lwliqh4aaelC4DYcqs6m/Q+Y9h7dT56mwTua8tHwiWJopIKQHYOd2qKe0+PaXfaf2hlXbx3Lw7YL3wfBWiltY7WALwynvLB+aPPONBk1lFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1210

PiBPbiAwMy4wNi4yNCAyMzoyNywgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMDMu
MDYuMjQgMTc6MDcsIG1hdHRoaWFzLmJnZ0BrZXJuZWwub3JnIHdyb3RlOg0KPiA+IEZyb206IE1h
dHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4NCj4gPiBVcCB0byBu
b3csIHRoZSBkZXNjcmliZSBmbGFzaCBwYXJ0aXRpb24gbGF5b3V0IGhhcyBzb21lIGdhcHMuDQo+
ID4gVXNlIHRoZSB3aG9sZSBmbGFzaCBjaGlwIGJ5IGdldHRpbmcgcmlkIG9mIHRoZSBnYXBzLg0K
PiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDxoZWlucmljaC5zY2h1
Y2hhcmR0QGNhbm9uaWNhbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhpYXMgQnJ1Z2dl
ciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gDQo+IEZvciBmbGFzaGluZyBsYXJnZXIgZmly
bXdhcmUgbGlrZSBFREsgSUkgaXQgaXMgaGVscGZ1bCB0byBtYXhpbWl6ZSB0aGUgcGFydGl0aW9u
IHNpemVzLg0KPiBUaGFua3MgZm9yIHNlbmRpbmcgdGhlIHBhdGNoLg0KPiANCj4gQ29tbWl0IDgz
ODQwODdhICgicmlzY3Y6IGR0czogc3RhcmZpdmU6IEFkZCBRU1BJIGNvbnRyb2xsZXIgbm9kZSBm
b3IgU3RhckZpdmUNCj4gSkg3MTEwIFNvQyIpIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXJpc2N2LzIwMjMwODA0MDIwMjU0LjI5MTIzOS00LQ0KPiB3aWxsaWFtLnFpdUBzdGFyZml2ZXRl
Y2guY29tLw0KPiBpbnRyb2R1Y2VkIHRoZSBjdXJyZW50IGxheW91dC4NCj4gDQo+IENDaW5nIFN0
YXJmaXZlJ3MgVS1Cb290IHJldmlld2Vycy4NCj4gDQo+IFJldmlld2VkLWJ5OiBIZWlucmljaCBT
Y2h1Y2hhcmR0IDxoZWlucmljaC5zY2h1Y2hhcmR0QGNhbm9uaWNhbC5jb20+DQoNCldlIGFkZGVk
IGEgInJlc2VydmVkLWRhdGEiIHBhcnRpdGlvbiBiZWNhdXNlIHRoZSB1LWJvb3Qgb2YgVkYyIGRp
ZG4ndA0KcmVxdWlyZSBhIGxhcmdlIHNwYWNlIGFuZCB1c2VycyBjYW4gdXNlIHRoaXMgcGFydGl0
aW9uIHRvIGRvIHNvbWV0aGluZw0KdGhleSB3YW50Lg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg0K
PiANCj4gPg0KPiA+IC0tLQ0KPiA+DQo+ID4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZl
L2poNzExMC1jb21tb24uZHRzaSB8IDcgKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1jb21tb24uZHRzaQ0KPiA+IGIvYXJjaC9y
aXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtY29tbW9uLmR0c2kNCj4gPiBpbmRleCA4ZmY2
ZWE2NGYwNDg5Li4zN2I0YzI5NGZmY2M1IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvc3RhcmZpdmUvamg3MTEwLWNvbW1vbi5kdHNpDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9i
b290L2R0cy9zdGFyZml2ZS9qaDcxMTAtY29tbW9uLmR0c2kNCj4gPiBAQCAtMzIxLDE2ICszMjEs
MTMgQEAgcGFydGl0aW9ucyB7DQo+ID4gICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPg0KPiA+
ICAgCQkJc3BsQDAgew0KPiA+IC0JCQkJcmVnID0gPDB4MCAweDgwMDAwPjsNCj4gPiArCQkJCXJl
ZyA9IDwweDAgMHhmMDAwMD47DQo+ID4gICAJCQl9Ow0KPiA+ICAgCQkJdWJvb3QtZW52QGYwMDAw
IHsNCj4gPiAgIAkJCQlyZWcgPSA8MHhmMDAwMCAweDEwMDAwPjsNCj4gPiAgIAkJCX07DQo+ID4g
ICAJCQl1Ym9vdEAxMDAwMDAgew0KPiA+IC0JCQkJcmVnID0gPDB4MTAwMDAwIDB4NDAwMDAwPjsN
Cj4gPiAtCQkJfTsNCj4gPiAtCQkJcmVzZXJ2ZWQtZGF0YUA2MDAwMDAgew0KPiA+IC0JCQkJcmVn
ID0gPDB4NjAwMDAwIDB4YTAwMDAwPjsNCj4gPiArCQkJCXJlZyA9IDwweDEwMDAwMCAweGYwMDAw
MD47DQo+ID4gICAJCQl9Ow0KPiA+ICAgCQl9Ow0KPiA+ICAgCX07DQoNCg==

