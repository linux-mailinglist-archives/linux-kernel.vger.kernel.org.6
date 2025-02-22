Return-Path: <linux-kernel+bounces-527014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF0A40635
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB0F7A7546
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8582063E1;
	Sat, 22 Feb 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hlmIkc86";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZRY2HWCz"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBB1482F2;
	Sat, 22 Feb 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211671; cv=fail; b=puhFHSXqBF5rgkFkQ5dQ7jp39hD0tTYf7t5mCM0mjlXnPmbOK1ANFwU3ZG1SDDklkUPcyDffXvNCefozp9tM2uqVwXUfM/x0D95IYSOly9DA2flAvR6MXBMI46ewe69LTZ8rs2BNL1Che1sF8VRZXPt4yODGSIvzfgNcwcdeuVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211671; c=relaxed/simple;
	bh=LsXNmGhST6ayGmZnBbQ7J4sd/cCuBHNdUOPdEbwhWpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1RDpuLbdw9diC/VL0ZzHTnJpctAHQXTLURO/bjm9JePjduYgw/Qo602aLGlvCwJ7kI85pASANBjvwUCR+SFu80NXIgCGYUH9IRNicOHA6bqSsH9hr+jti04rB7XaoewAd3Z24byPnvqTebt68Ohnsaa2HH0c2I0ZMJwlcvrzaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hlmIkc86; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZRY2HWCz; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 143e211af0f411efaae1fd9735fae912-20250222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LsXNmGhST6ayGmZnBbQ7J4sd/cCuBHNdUOPdEbwhWpQ=;
	b=hlmIkc863E6Bh4SCUGSeFqiv/RbCL9FS+UxhlkyYEiGuw6kBPepuuO7rYheAqnGTYRUaUSW/AD1It7DwXxPkDVu45x9QYugpc6Cha9ZvoWxHQzLYrRwYXmgSbyqTbXM+lVdbRm85WdWVv10pev1dq0mUthWG07sF9aN9K/oyNig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:fa737582-40f8-43d1-a95e-ac92c44bdc60,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:97a770b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 143e211af0f411efaae1fd9735fae912-20250222
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1761442793; Sat, 22 Feb 2025 16:07:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 22 Feb 2025 16:07:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 22 Feb 2025 16:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqqIGhrk2/+zsNIQgEtXgwBxmzgkXPK50UpfaQrvqjnAAUcB9WXrcE93q3dLtHQQPI/wiL7F0JXDkFW1TZSn+1vkyeqFx8ZAwlTYMc6lXfIACklRRGV6e7rpxMXiZVXB/f4K9/X1TNCai/+yoT4UGp0+hMa6CelQTEPT2bSWZDuUXsomVo7bcCB5Tj79OC/TVJ1T7QBecsavEUEzegHnBEyG4fobLYnucg/uMVklKbUyYv0bXFREXVE850Ku4mjWRooi18bd5GjExgEInTOp5GoReL+ULV2bqoyaBFXNSZfo9IaYufy83AsYpzJDTwsvK1U4aLYerxaPztwO55LHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsXNmGhST6ayGmZnBbQ7J4sd/cCuBHNdUOPdEbwhWpQ=;
 b=CXr46VZ/STPNGzGMGHdS8Smze5pkeoxYQ6ERlbMPC1i92Q68mdMzBM2Lw8XlzFhLajzSLCglf4Nfdzy1hfiQXiT4s9x7BQN/cd0Gsq6N16IQ1OZGqrymN/hT9AnxmOE87VVUGhyath3KqNabKDhZ08n5xxvL5fyi+bv/pDoqUckeVsXtAA0R9CBWl7eWhK9i6Jc+AHcVPygG0UGnkLwxvXUx30e2PBh7ZhaWta782DmLg49W8maxDkx40iOckI6mAg1+9u7rjv2Q1yyzSLtRih7Hpg0rXxHmAYZpNwv7+er77E4rKv9zjxv6T7Ks6o+pXe68k+Xcjezq+AGUGc3pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsXNmGhST6ayGmZnBbQ7J4sd/cCuBHNdUOPdEbwhWpQ=;
 b=ZRY2HWCzqv+bH0bZ5TW8OAmtHE61d9p2hEDae91WDqWFDBd9rdgn9G87BcIRe/0zRFqPnPkmFMZASmnXkN7FkLjvhSL/QUh9rX7bsAsxf/Wax6/+hHJf2xysMyc88a5tZXm3az6kMgWTZQ+OzSsp4HmZap7cQzydpib9FDw1ILc=
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13)
 by SEYPR03MB7505.apcprd03.prod.outlook.com (2603:1096:101:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 08:07:33 +0000
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6]) by PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6%7]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:07:33 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of mt8196
Thread-Topic: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of
 mt8196
Thread-Index: AQHbf5FODIPLI9TKeUmeOfVo1d4u27NMxxGAgAY7cQA=
Date: Sat, 22 Feb 2025 08:07:33 +0000
Message-ID: <337c9b78d129aa8f47464893da49febe072f4af6.camel@mediatek.com>
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
	 <20250215100615.808-3-chunfeng.yun@mediatek.com>
	 <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
In-Reply-To: <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6236:EE_|SEYPR03MB7505:EE_
x-ms-office365-filtering-correlation-id: f1661b6e-11dd-4ff2-0e9b-08dd5317f5ea
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q0s5K1VtOTZ4VXNRRkpIaTY1bTNNNkphUnkwYmhmdHhqbWJoUnRvRnRVdXBU?=
 =?utf-8?B?ZEJEMkRMcWNxY3o4ODhqNXZDdUpvd1ZHeitmM3IxUU0yUVdRRXkyanJneE5l?=
 =?utf-8?B?Q0VMUWhXQitMVWp3YmVvci85SE5ZVDdHWExjcDFraTR1SHVzTE4ybXV6dlNV?=
 =?utf-8?B?RXFsOGl3ZSsrSi9hNU1Ob3RlTWJZVXF4S2g4SDFIYk44RnRxalFtTUt3c1Bm?=
 =?utf-8?B?OURaU3E4K1BJQ0RqYm5BcWZHNEpzN1BzQVYzOUlHVHhrMFZuT0cyQUYwSmpm?=
 =?utf-8?B?V1Q0Q2lSNS9Gd0NuWExSUm1XNHg5VzVqRTRnNUJ1V3EwK3IrZWpqWnFFOWtV?=
 =?utf-8?B?SFMwOHh6RWsxcmtJRlg1clo0aEtLbUFneWdZQjBEeWlKalhSZVZIcXR6Z2pY?=
 =?utf-8?B?WkEzdEdVRW5HSEJCakpLMkNyU2xrb1kwVXdSZUpOK2FZb1Z0TGt5amRSOGsy?=
 =?utf-8?B?VnlCOUpNYU43MVZmd1gvYm9samNDd2xYaWlQanJ2K0JEL0xET3o5SFd0SGUv?=
 =?utf-8?B?NEtTbHNncmlNR0ZjNXdNZmtwdGM3WmVickx5Z25BVGpHY3pFOEp4M29yN0FZ?=
 =?utf-8?B?U1ZaSVN5VGhOcHNUQlU2WFpsMlNLUUYzbW5KcDUycnR1RHBxakdTZkhraDVy?=
 =?utf-8?B?REJQTzFYRXo0QzdWSzdyUkRiOEVoUWxRR3dXTDZUVmExQU9xRkZyOElDWXlY?=
 =?utf-8?B?dk4yZnJJdEpDMDlDcGRhN1RCS2t5em1YM2pwdVlCbzc2SVQ4bEx0VEEySElN?=
 =?utf-8?B?VjlGV3BneDRaTTZhT3NTVjhjUUp2cDFRSTBoV0NGVWRIUlRINFpDa3kxOTZM?=
 =?utf-8?B?eGlnNHl5N3puZGx4aEtXUHk0a3BqUEZkNGZNNkRHMEIvRUw0NUhZck9SKys0?=
 =?utf-8?B?OXd2S1NTZytybDkwRm5JL3JVbTdaTzBPUG9TQ0Q3ZUpIOER1SU5ybUFKYm5V?=
 =?utf-8?B?UksxSldOUENtcnh2OHQwelowcU4rVGpjeVQxYVpiSGNIR05BTGRSQldnbFdJ?=
 =?utf-8?B?VStSQ3MwQ1ZITjJGT21NdEQyUjFISzhYSm1Td2JLYndQdTJER1NwUFA1V0FR?=
 =?utf-8?B?cDROT0x5SDhRbDA0ckRHSWVrWHlKR0ZDbEFEdTVCRkdQazFGamNJT0ZWb0NK?=
 =?utf-8?B?MEVYY2EzWmdxbVpjc240NHJiQ1pZMGFVbVVyRldDMlBGYndYd1lyOXhkSjU2?=
 =?utf-8?B?OW81R0Vxc3krbzNGak8xMTN3RHc1V1N2Mi91Z3hXZFptOEJDQklmVGRxeUU4?=
 =?utf-8?B?eDR6NjFELzBaZWtDeDVlZUE1NElJWHMweURjVEhjQS9GYTRwWWlvVlVvcjJH?=
 =?utf-8?B?TWg1U3hoeHk5NXFXTWVUUlVRTzN5ZERGQXlmdEFHR1U2dElEM2FlK1hHaXZJ?=
 =?utf-8?B?dVZYMlBUcXdZNlhkQ2VGbndtQlNmd0JORVJWNFFPVkw5Kzc3NkcvUTFTdStT?=
 =?utf-8?B?cFI2WXFZaStCeUtTeU1KbUt4QjQzWHlpZ3J6NFhhaThrNVdqM2RWTzZtUk00?=
 =?utf-8?B?ekh1QjY0U0w2cFZWb2k2MTJiN0hwQU5XUkJTeHFwS3dnNHZER1hYeEg2Zmto?=
 =?utf-8?B?RGJuT0ovbmNDZFBuNUxzQVp3ODRzckdwa0lJUEtQTG15clFYa0o0VTJTbytD?=
 =?utf-8?B?cC9ROVZIOEhZMEdSQ2FXL0Q2MWZ1RnM2UWQzcUpJL2pGQ1dxc3VMVlVRbElR?=
 =?utf-8?B?ZTUyWjFzL1ErdVpreVR0K0drbTc1OWd5MDhSRXhOUUYvbmpzdktTMkZ4K1lo?=
 =?utf-8?B?VGxPdDQ4bzQ0MTlDaEc5OHZtZEdXbkJWZmNFVWlhTEpVSVBJUVQ3c3BSWHZ2?=
 =?utf-8?B?aUxXZy9UZGFIdExKZ29KVHN1MllFT2xZaDJuOGdzWkhLYTJyZW9NK0s2RGdX?=
 =?utf-8?B?LzkwaGhaWWhtTXY4TTBDNUVRMHpobi9wUVdHVzlLUlRsQzlFRDVVTkRYSUhq?=
 =?utf-8?Q?n52SskcFBn0paQ9ogz/Xa1tS6P70G0Vn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6236.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUovRmZZdVZNc0FvMjhIUGgzOUUwRytZSWVaSkFRZ0p3ZTdlZGdWZVlZUmxL?=
 =?utf-8?B?YWRJdmtiVW1JZHpiZ3VYUDAzeXdQTVVhdGVTcGM3RU95YXBHMkhTYnorQ2pZ?=
 =?utf-8?B?TWJzdGdIZmhvSzhldFRLWmN1aDhDM1RZTm9SaE5FenlFWnJQTUx1ODBwaWYv?=
 =?utf-8?B?K0E2Ly9Mdkh2V0xuWmNBb0QvenBBSVJ0eEFITEhQZTZsaVhZalF4ZWRTVCs0?=
 =?utf-8?B?amR5RkFTQWJ4KzZKQnBXcGRZUGtCVGNYUjVQcFhla1ZuMTRnKzh3MUF4TXNT?=
 =?utf-8?B?R1dGblpXdmhrR2gxOUViclRaRFBXOGtQcmFIMkxhKy9xMElzNEFvQTFtQzJ3?=
 =?utf-8?B?UkF0RkVLaC9hZjVGWW5jc0tZaGN6UjZycHR5Ykd1YVBUSWVSK3k2d2V6SzBm?=
 =?utf-8?B?WFBkRjhLNWNMUk5RbmFWOUZqSzNjK005ZTFmT2pkR2R2dkZlTVVVeXV0RFZ0?=
 =?utf-8?B?TFVwZTl1c2ZUQ2VpdVhjaEdObGhFOTBUWXcyM3Q0Z282K0xYcWJHL2tuNWJH?=
 =?utf-8?B?enJ6RWZrZjc4NEJIbEI0WE9NcTl3VFVEQ1llZ25ESSsxTHlXUWZ3b2d3ZWZP?=
 =?utf-8?B?RWhPRVk1aFRHbzg3Q3U4N2ptL01QaDlYckZENjAyQjkxRFRzV0hYK01zNklD?=
 =?utf-8?B?ZUMzZ1oxUzkvYVpPR0pLNjY2SnJTdmdmKzlQSU1yL2RoRytRc05tblZ2Q3Qy?=
 =?utf-8?B?YTh2TS9jQXhhTjFyc3pvWi9wdElzRzNlNXZoK0Y3MCtTRDJwa1lHOVlQTW8x?=
 =?utf-8?B?UlI4RXp1VW10VWp6d2dWNkdBbTNjY2k1MmYxRkpqaTNtQXpaWUI5dXl6Zmg4?=
 =?utf-8?B?dzNZbDVKcm1BWmRpWlRnNVB4Q0JKTWQ1aG04WVBhNDVCNnVSQlYwL3QvNEh0?=
 =?utf-8?B?TjBzd3hReFNLK1hUNUplTVd2S0lLYU96SW5WSzZXRGQzandEc3ExRTlNSVB5?=
 =?utf-8?B?QUhhMkFkc3lsbjcxTGFpdTdWbVVadFovTDhMMmkxdGUxKytJd1ZvQ1hzak10?=
 =?utf-8?B?elJ6bFNhcmhaMVJjUEkrS21lblk3c0FhTm02Y29jQ1BVdDkvK2RUSVNWMFZG?=
 =?utf-8?B?VGdkV2dpeWhLNUtvR2svSkJIY0pvaGxXd05rUUpXbENMOGkyV2tSZ2d6cy9Q?=
 =?utf-8?B?UktPWnJ6Q1hLdmhQaTZFSUpNbE9CZmhvSks1QUlOa2orS2twUHVsUTJwMFkx?=
 =?utf-8?B?MkE5enpzY3FKQUFBWDlZdm4vZ1BrcnQyMVJUckxxYlJkS1lGclNQeDkySWl6?=
 =?utf-8?B?WFordTBjYkk3WFd1Skt0aERCYWNWMVhRNjg4cFR0T1JRc3EvSW1xbGxlUDQw?=
 =?utf-8?B?M2g1b0E5empTRXFuWmVHL2Jlam52Z2lENlRHN2lOaTlISlpiY2taeWg4dGJI?=
 =?utf-8?B?R1N5UU04cksrNEx5RnRTblkrNHVOTFpyZTQzcm40MmE5bG1wdVhEVmw4dFJ4?=
 =?utf-8?B?K2ZLUm96Q3Rta2grd2k1SEE2THk2QlFQNlh2L2c2elkrUUJCV3Vwa2k2UUpO?=
 =?utf-8?B?YnRjK0Vobm5ZOWhPWW1icHV6MFNqQ3plaGZRaXpTNWxIVWdmNzlEaGY1SStx?=
 =?utf-8?B?dE9RQi9WL0FmY2lYQy9XOEY2aW9hVWl2Rkd5VXZnMzJvY0c5UXMxaFJMQXVL?=
 =?utf-8?B?Y0xRYlg4ZDlEenl1bzdYTEtDUStJOXdJdTAzWWFzbndQUjJIdU9nK0pSSXJs?=
 =?utf-8?B?UkVRYkk1bUhPbTBTMFNGTkMwUk1ESTBDdlVIVnUxUk1zVnpIUlhvLzI0T0Qw?=
 =?utf-8?B?dDEyMThNaVEycndycFZBaExoVXRyVnZja3FHbHU4bmx4aS9hSEFGcTVYUUVX?=
 =?utf-8?B?U29na0hyamdDYXhSNXNhdW1RVGFoMmViVFQyamlQMXNEMnlIQWFnV0tFWjZW?=
 =?utf-8?B?UmJGdll0S3JSdjBGRHMycDJ2Y3FuS01NVEpqS2g4UFR6UHVmaFZyRDZ1Kzc4?=
 =?utf-8?B?YkJUTmFlTDdoZmw3aXFNazE0Zkd4NnMwV1FNWlA5Q1hpOEhvU1lIdW5qNklP?=
 =?utf-8?B?YkVIMVpJQ3grOTJHdktIUWFRTjNibEF2VXhsbm1iVUJjbHVmNDFZNkQ3aS9l?=
 =?utf-8?B?U3VUTEhZK1N2NWIzZ0d3R3NSSWNQWlVVZnRlNmdJdVNkU3RsNlE5ZElvVDdw?=
 =?utf-8?B?d3FVT2h6eHhURnMxczRRTWZXaXVSQ0l6dytwYm5HWXQvNFZrWElPeUN6QTI3?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F695962F24F64098BB81A4641C42A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6236.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1661b6e-11dd-4ff2-0e9b-08dd5317f5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:07:33.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQbpUpF0yKjssZ8KoO6TPskPT/w5h+Hl/V99GiEYyRhbY4RrsAkmpFwKB4mETVFQDkeW4Xspc0udepe6h7AZecAmfG3SerX/kphLzpzqmeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7505
X-MTK: N

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDA5OjU3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNS8wMi8yNSAxMTowNiwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gVGhlcmUgYXJlIHRocmVlIFVTQiBjb250cm9sbGVycyBvbiBt
dDgxOTYsIGVhY2ggY29udHJvbGxlcidzIHdha2V1cA0KPiA+IGNvbnRyb2wgaXMgZGlmZmVyZW50
LCBhZGQgc29tZSBzcGVjaWZpYyB2ZXJzaW9ucyBmb3IgdGhlbS4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0KPiBT
aW5jZSBhbGwgb2YgdGhlIFVTQiBjb250cm9sbGVycyBvZiB0aGUgTVQ4MTk2IFNvQyBhcmUgYmVo
aW5kIE1UVTMsDQo+IGFuZA0KPiBzaW5jZSB0aGUgd2FrZXVwIGNvbnRyb2wgZm9yIGFsbCBvZiB0
aGVtIHdpbGwgYmUgaGFuZGxlZCBieSB0aGUgTVRVMw0KPiBkcml2ZXINCj4gYW5kICpub3QqIGJ5
IHRoZSB4aGNpLW10ayBkcml2ZXIuLi4uDQpBcyBJIGV4cGxhaW5lZCBiZWZvcmUsIHRoaXMgaXMg
dXNlZCBmb3IgYmFjayBjb21wYXRpYmxlLCBhbmQgd2UgYWx3YXlzDQp1c2UgaG9zdCBvbmx5IGZv
ciBzb21lIHByb2plY3RzLCBhbmQgZG9uIG5vdCB1c2UgbXR1MyBkcml2ZXIsIHRoYXQgd2lsbA0K
bWFrZSBkdHMgY29tcGxpY2F0ZWQuDQoNCj4gDQo+IE5BQ0shDQo+IA0KPiBQbGVhc2UgZHJvcCB0
aGlzIGNvbW1pdC4NCkFuZCB4aGNpLW10aydzIHBhdGNoIGlzIGhpZ2hlciBwcmlvcml0eSB0aGFu
IG10dTMncywgSSBhbHJlYWR5IGFkZA0KbXR1MydzIHBhdGNoIGFzIHlvdSBzdWdnZXN0aW9uLCBi
dXQgSSBzdGlsbCBob3BlIHRvIGtlZXAgaXQuIHByb3ZpZGUNCm9uZSBtb3JlIG9wdGlvbiBpcyBi
ZXR0ZXIgZm9yIG91ciBjdXN0b21lcnMuDQoNClRoYW5rcy4NCg0KPiANCj4gQ2hlZXJzLA0KPiBB
bmdlbG8NCj4gDQo+ID4gLS0tDQo+ID4gdjM6IG5vIGNoYW5nZXMNCj4gPiB2MjogbW9kaWZ5IG1h
cmNvcyBuYW1lDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLQ0KPiA+IG10ay5jDQo+ID4gaW5kZXggOTA0
ODMxMzQ0NDQwLi4zZjhlMzdiMjUzMjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9z
dC94aGNpLW10ay5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4g
QEAgLTExMyw2ICsxMTMsMTQgQEANCj4gPiAgICNkZWZpbmUgV0MxX0lTX1BfOTUgICAgICAgICBC
SVQoMTIpDQo+ID4gICAjZGVmaW5lIFdDMV9JU19FTl9QMF85NSAgICAgICAgICAgICBCSVQoNikN
Cj4gPiANCj4gPiArLyogbXQ4MTk2ICovDQo+ID4gKyNkZWZpbmUgUEVSSV9XS19DVFJMMF84MTk2
ICAgMHgwOA0KPiA+ICsjZGVmaW5lIFdDMF9JU19FTl9QMF85NiAgICAgICAgICAgICAgQklUKDAp
DQo+ID4gKyNkZWZpbmUgV0MwX0lTX0VOX1AxXzk2ICAgICAgICAgICAgICBCSVQoNykNCj4gPiAr
DQo+ID4gKyNkZWZpbmUgUEVSSV9XS19DVFJMMV84MTk2ICAgMHgxMA0KPiA+ICsjZGVmaW5lIFdD
MV9JU19FTl9QMl85NiAgICAgICAgICAgICAgQklUKDApDQo+ID4gKw0KPiA+ICAgLyogbXQyNzEy
IGV0YyAqLw0KPiA+ICAgI2RlZmluZSBQRVJJX1NTVVNCX1NQTV9DVFJMIDB4MA0KPiA+ICAgI2Rl
ZmluZSBTU0NfSVBfU0xFRVBfRU4gICAgIEJJVCg0KQ0KPiA+IEBAIC0xMjksNiArMTM3LDkgQEAg
ZW51bSBzc3VzYl91d2tfdmVycyB7DQo+ID4gICAgICAgU1NVU0JfVVdLX1YxXzQsICAgICAgICAg
LyogbXQ4MTk1IElQMSAqLw0KPiA+ICAgICAgIFNTVVNCX1VXS19WMV81LCAgICAgICAgIC8qIG10
ODE5NSBJUDIgKi8NCj4gPiAgICAgICBTU1VTQl9VV0tfVjFfNiwgICAgICAgICAvKiBtdDgxOTUg
SVAzICovDQo+ID4gKyAgICAgU1NVU0JfVVdLX1YxXzcsICAgICAgICAgLyogbXQ4MTk2IElQMCAq
Lw0KPiA+ICsgICAgIFNTVVNCX1VXS19WMV84LCAgICAgICAgIC8qIG10ODE5NiBJUDEgKi8NCj4g
PiArICAgICBTU1VTQl9VV0tfVjFfOSwgICAgICAgICAvKiBtdDgxOTYgSVAyICovDQo+ID4gICB9
Ow0KPiA+IA0KPiA+ICAgLyoNCj4gPiBAQCAtMzgxLDYgKzM5MiwyMSBAQCBzdGF0aWMgdm9pZCB1
c2Jfd2FrZXVwX2lwX3NsZWVwX3NldChzdHJ1Y3QNCj4gPiB4aGNpX2hjZF9tdGsgKm10aywgYm9v
bCBlbmFibGUpDQo+ID4gICAgICAgICAgICAgICBtc2sgPSBXQzBfSVNfRU5fUDNfOTUgfCBXQzBf
SVNfQ185NSgweDcpIHwNCj4gPiBXQzBfSVNfUF85NTsNCj4gPiAgICAgICAgICAgICAgIHZhbCA9
IGVuYWJsZSA/IChXQzBfSVNfRU5fUDNfOTUgfCBXQzBfSVNfQ185NSgweDEpKSA6DQo+ID4gMDsN
Cj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgIGNhc2UgU1NVU0JfVVdLX1YxXzc6
DQo+ID4gKyAgICAgICAgICAgICByZWcgPSBtdGstPnV3a19yZWdfYmFzZSArIFBFUklfV0tfQ1RS
TDBfODE5NjsNCj4gPiArICAgICAgICAgICAgIG1zayA9IFdDMF9JU19FTl9QMF85NjsNCj4gPiAr
ICAgICAgICAgICAgIHZhbCA9IGVuYWJsZSA/IG1zayA6IDA7DQo+ID4gKyAgICAgICAgICAgICBi
cmVhazsNCj4gPiArICAgICBjYXNlIFNTVVNCX1VXS19WMV84Og0KPiA+ICsgICAgICAgICAgICAg
cmVnID0gbXRrLT51d2tfcmVnX2Jhc2UgKyBQRVJJX1dLX0NUUkwwXzgxOTY7DQo+ID4gKyAgICAg
ICAgICAgICBtc2sgPSBXQzBfSVNfRU5fUDFfOTY7DQo+ID4gKyAgICAgICAgICAgICB2YWwgPSBl
bmFibGUgPyBtc2sgOiAwOw0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgY2Fz
ZSBTU1VTQl9VV0tfVjFfOToNCj4gPiArICAgICAgICAgICAgIHJlZyA9IG10ay0+dXdrX3JlZ19i
YXNlICsgUEVSSV9XS19DVFJMMV84MTk2Ow0KPiA+ICsgICAgICAgICAgICAgbXNrID0gV0MxX0lT
X0VOX1AyXzk2Ow0KPiA+ICsgICAgICAgICAgICAgdmFsID0gZW5hYmxlID8gbXNrIDogMDsNCj4g
PiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgU1NVU0JfVVdLX1YyOg0KPiA+
ICAgICAgICAgICAgICAgcmVnID0gbXRrLT51d2tfcmVnX2Jhc2UgKyBQRVJJX1NTVVNCX1NQTV9D
VFJMOw0KPiA+ICAgICAgICAgICAgICAgbXNrID0gU1NDX0lQX1NMRUVQX0VOIHwgU1NDX1NQTV9J
TlRfRU47DQo+IA0KPiANCj4gDQo=

