Return-Path: <linux-kernel+bounces-192694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC578D20CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8123F1C22262
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EA17166F;
	Tue, 28 May 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="poDcSVJK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qq/VY11L"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD216DED4;
	Tue, 28 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911559; cv=fail; b=o1UmrlaWtPrT4lnnmQA5URUr3WUDO5pg3uY9omsWOwy09YGLU7NU6mmcH0hFgr5GmiewQInaEQ99383YU3PxvCkRsJ+9FWi+zSJ3USvABm+jXx4IjmeI4OHQfvB+AX4fJdUdjmJoiDrcF1tD7bLuT5YWF2qC3S87kYVe7TwfKDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911559; c=relaxed/simple;
	bh=TUjy/+J/EWtufdlkTVTX11xd4W32614M0LmsL8ytxgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAPmOuOLgJLnNbRo67KCkGPG8e4557lAqL1dVrU2FALNZI4y17+xQ8d8XuwybJ6x8QGH6QicrQJujTWP8Rz0O/U73Jy5PTfYBvF3KwDB8KSPH/kWyNKayhz6Hg1ZW8UrgVw3ixqwwEg2fN53HuBB/o8tJZM6V4Yf7/Mayo9zfqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=poDcSVJK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qq/VY11L; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4971e9981d0a11efbfff99f2466cf0b4-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TUjy/+J/EWtufdlkTVTX11xd4W32614M0LmsL8ytxgE=;
	b=poDcSVJKKHJEU3IGAxfVR5+XCONbzT3Jery/Q/Gq8NW2MPPTs1kEl4TuaoEKv1DzbSir2TRBBnaRx5HqI/FdLfkik7kkMdL/aPH157FcJWI873SKnYG5l0TYi4ogoWxRbd1LiFc0vY3Lbcj/Zd+5YcOtem5VhhVxAsTFFgmkpPs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:69123061-8231-4f57-b4f5-0b05ab6bf40b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f3236c84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4971e9981d0a11efbfff99f2466cf0b4-20240528
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1263717569; Tue, 28 May 2024 23:52:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 23:52:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 23:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9zLg31nOvgi2TPVSmHlC+7n4vcK+44QmVrh8QSN8DC3DeXj8gD30xYErEN6OnNCQxP2zSSesQuOtzue7OM8A6oQTzhxz3YGXKxotX34DenaIf+kyoDuK0cION77tg3NyDzWnVdebj6Xsk/j9XKu0M5sfgh52OtUo5x/w0KldzN44FxbXfocQfsTnkZfaNMhhz/GVB4NwXhmi2/tauoB5WyWZPmVQYJnH0sqMdrSEdFwPe0rZpMYHgnpqqalqL0pK7j3WSiGdExavOkbWONq3AX0toeuSmz9X84TYZkTG8DRKKQTh3ETCwvdnpvYB7Xefjgh/QEQF50Rstr7shoGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUjy/+J/EWtufdlkTVTX11xd4W32614M0LmsL8ytxgE=;
 b=c+BzJTPRsGWrIu+cwgpUokmcdSySzeSRiEm2RVUpGHBXPT4DwZSMEqae5TCKJUVwQM3BwNpritaSvk6kC8LMOEt6GxVhaG0sdQ3gh2dJzYsfvzeAb66josvy4O7FzfT2CvUc8RyntpZ77zwZXkoJSAVxvH3OG9X7so+3htF62mRlvHUqateMHMFz6qMIY/seITDYkmhiHVaTWZ9UdSO6HSdlztmVe/rSprne0KqTkucnCEb0xeosWm4VPEi0kCf2l0MfTIZndHaFflWuYAxSave1FzhldJeNGi3HnODpRYiCn3zIZ1RF9BcwZFdv/bJ++MEp8RScI+in+UWFYIKROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUjy/+J/EWtufdlkTVTX11xd4W32614M0LmsL8ytxgE=;
 b=qq/VY11Lr5cZjHefupdM78UV8c8v3sVLJou7tMfQxMkY8sWFwTXyAbzt1O1WUVQWI4enjyMWvknBH07ZgeXxSV58AJPsbcyTTZLdhybzphumKzmfbUNcOcMdewzrMG1rXL8IaLTHtx9WZcjy59mBYW2khBV5JtrDS6W8BnXhhfI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7847.apcprd03.prod.outlook.com (2603:1096:400:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.13; Tue, 28 May
 2024 15:52:24 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 15:52:24 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/8] soc: mediatek: cmdq: Add cmdq_pkt_logic_command to
 support math operation
Thread-Topic: [PATCH v6 3/8] soc: mediatek: cmdq: Add cmdq_pkt_logic_command
 to support math operation
Thread-Index: AQHarvhxTRgC47+tMk2FaVMuM7C7h7GsdJaAgABbiIA=
Date: Tue, 28 May 2024 15:52:24 +0000
Message-ID: <f26efcca21b9954a0137d391ca78ba9870afd2f9.camel@mediatek.com>
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
	 <20240525230810.24623-4-jason-jh.lin@mediatek.com>
	 <cd15d9c5-f7a8-45fd-b0e1-011a9832d023@collabora.com>
In-Reply-To: <cd15d9c5-f7a8-45fd-b0e1-011a9832d023@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7847:EE_
x-ms-office365-filtering-correlation-id: 5f6341f8-d7f3-4b64-ed29-08dc7f2e2b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cFVlemc2MnJsNStyMjFRUDU1MGI0dWFEU0JuNGxqV3V3N3YwUW9SWERmNktF?=
 =?utf-8?B?VHZadStUZUthQjFRTmxCV3I3L1hpWUFrQzMvcDg2Sks0Z3ZzY0dwM0xNcnVO?=
 =?utf-8?B?QWNxQnJNcE1tcUdyTzRMNy93ZWNWSmtQcmtQVFU5Q2hVN0szTTB0aFV2eG1n?=
 =?utf-8?B?eHAxbjdteFZLMnBTWlFPb1JROXRrbCtSdEdHMHMzR0RQZjhZOTJ6bzlEODZP?=
 =?utf-8?B?SXFMVFpBWEludEJsdUpoNEUrSFdCbFdmQ01EVEkwYW1tWm1Rc2RiR2hZUk5H?=
 =?utf-8?B?amxHMTd4cHllUUxqbWJHZTBWY2lYVElYYTdsYmRPT2c3b0g5VVVwdUE4Rnlh?=
 =?utf-8?B?S0tlZ1NhK0tDSDNZZU1hakk0VkF6eG1sZGlVMFd5eVMxNmp6Z1gxSzRNWUoz?=
 =?utf-8?B?TExjOEZnZExpcGJDbm5wajdNcGpVRGp4bXF5QUQxNkhsUUZsd1oxWW5ZOWJB?=
 =?utf-8?B?WjdGNG5IOGs4T2ZuZ3czK0hYaVBqRkdYL2w5NGNYUmdVNzVCWU5KVVBhejdH?=
 =?utf-8?B?Q3YxaExEaElDMUlTaE1mOFFmengvNEhPSnVWMThUREUvUElpZ0dmZlQ4WFFU?=
 =?utf-8?B?WnpOd0lFcjlWL044NVhDeTFORDRpTHJKWXNmN3l6d0hpS0FtK1llYjZlZEZp?=
 =?utf-8?B?Wm1nVlZXcUMrak9qTXdqeHhpOWY1Nm9tcjBwUC85cHlOaWhwak5tekdpQ29D?=
 =?utf-8?B?V08waS9LQmJZQktoaFZwbXU4akIwR1QwMFB0N2ZETGhkbkM1eHI2SzVsOG9Y?=
 =?utf-8?B?cm9jYlNtTnBFaFNoT0JFM2lmdXV6MTNBbjYvVnZSUXVJNEZ0TFpEbFVZbk1Q?=
 =?utf-8?B?eUlLN0t4NkNIY2MxY1Z1TzNQckVMaVhpaVpkOXVKam5wWmg2ZGpHTHY4UzBN?=
 =?utf-8?B?czFzSTlQVzVCOG56aVJBYWY5MDNsM2RvOHRJVnNLaG8zKzh5VHVsQkdoYjcx?=
 =?utf-8?B?dTZFdk5NZFVzWmVqQ2FFYkNGVUNqSnk1dkhMNXhJbnRvUy96RloxYUMxcWdx?=
 =?utf-8?B?ZldjSkpPLyt6NGtsNHZBbUxCNCtTbno4UjUrSzFrUExkVTlWcjRKdzQ5SytN?=
 =?utf-8?B?dXpPeGxqYjUwYlJMZks5bDRkcWVGeW8zQTZjdEM1RkJ2SFdGN2NDdmd6Ynl6?=
 =?utf-8?B?TUNWOHVuTmhDWXRsWVRaV0tYMWhDdkozM2I3RGxEcjRhUUcyQnNJQmZSOS9L?=
 =?utf-8?B?K21Edjg4Q2xPdEFkMll6VEFmOERNQlFNK3l0RXNaUEtjcFdNdStxK0xsR0tu?=
 =?utf-8?B?Rnk0UGtXbWcrUmhaUW14NFJlVTFDeG9BRVVKYjB5azdPaUlsMjlPMVhUNlFu?=
 =?utf-8?B?Q3gzNFlnVmVzY0YyQ1lKem9kdEhEd3duWlJ3UGNjb0NDUHRFOUZaaWJCU0M5?=
 =?utf-8?B?c0I1K3ZSbXg1bWNXSFNhQUJURWR3aWpPNVBYZEhVT21vK3Z3czdmcUdSSDhp?=
 =?utf-8?B?akVrWjlCTHV6TzgxZm9TdzAybjM5NUdXMkRBVHpSN25HaFN6aDREQWRXa2lD?=
 =?utf-8?B?R2lmUmJIcFFQK0hQMERkTzd1OUNVaXcwdXBDcDFUSThaV2tObFREL0lobHc3?=
 =?utf-8?B?RFlmSXNEejltL3dIcVdwOUc3TElVRCs0eHc3WVFNZ2phUUV0RlBWTXVrLyt5?=
 =?utf-8?B?MjJ1TVdudGhhOWhwQ0pnT01sak1pSE9QaWVLaXRlbmZMYzBqQXNrNU03THhs?=
 =?utf-8?B?ZDBmYnhhdUpwT0tzaExqMGV5SHJGR0FpME1rYkJzUVRidGU4VHBGbExRREl3?=
 =?utf-8?B?YXMzS2Z2RzdodkRUM0dkUWJLdmhmMVdleVluVXpsck9hKzRxSnM2ZGNqWlJx?=
 =?utf-8?B?RWo1QmJuVFdiTEpPY3dsdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDRBaFl5V0p6d1BnWUx1a3RyK1MySXY4WXh6cU5DaUdvTTd6N3lmTzdvdTNm?=
 =?utf-8?B?REhBUXAzZ3RRalNoejhTN0tsMzN0TGlEa29NNGVwaGcwQzFtMmJTZUlmS0E5?=
 =?utf-8?B?KzR6Z3E1QVdKUmRBcyt4NkF5UlZCOHkxS1RLb1Z4K041QnNVMGp4R21TcnlO?=
 =?utf-8?B?YVBRUU9MVi9lanJNZStNTm9ubWZjYzgvbXA2cU8zYzVCZ0xTRmxDV3BTeXdY?=
 =?utf-8?B?dHFrdUkvWURlbUcwclNLZVRxY2wvL3ZSYzJjcGlPU0NwV2luY2RGNk5tdVRX?=
 =?utf-8?B?d09RTkQ5eFFGRE9UaEhvSjlxWXdtanhnK2ZDQzRiajVCbWl5alBmVDV4Sy9a?=
 =?utf-8?B?NEVCWmVrVUpVcFpWcDFabTNmYzkzbURtSjJ5c1RPNlVsOFk1SlBvQm90eW1Y?=
 =?utf-8?B?M3lYT0tjV0FCcnA2SUtNUVg2eUpjeWZtVDg2RzMvbzRndDFFNEd1RXZGdHdI?=
 =?utf-8?B?TEpiNmlkOGdleFc3NXpnNUVUM2ZzS25NdUtWR282b0crOFlvM0hQSjEvWTBp?=
 =?utf-8?B?YlFIQlppNUdBeUthcnoydTdhNVp6eStlMFU5NllQb1hpV1I3Q0piamZ6c215?=
 =?utf-8?B?cjhNQWR4WHhhdFI4Wi9BdU95Mlk5ckpuWnFqcDYxR1F6ZStRZFc0anBwTmNk?=
 =?utf-8?B?RWVmdTEvaEU1VWFmM3hTNU84bHBPeERGS2EwVjBTcFBCcmY4Zm5VMEVRbXZo?=
 =?utf-8?B?U2pyOEFLbW41bnlneEJ0dXkwYzhxbFhKNXhIaTRvN2lDRDJsYXBHYWY2MGRZ?=
 =?utf-8?B?NCszT1hseDFadjA0dXN0SjhDMFpMZXFRUFJvc0g3NTkyUWFhc1NSek1pRFVl?=
 =?utf-8?B?QWFoaXJBL2pBV05lSS9PQXZGUWh4alR1NmdvMXBFSjJ4eWh6U0ZOUHVIV1R0?=
 =?utf-8?B?SEg0MXl0UG90dWZxMGIxcFBOaW1BcUJvYXV0SVlUN0xNMktBOXRaaEVYd1ZI?=
 =?utf-8?B?c0FDbzRuT2w4dW5haHBTZ0xPZGo5OGJLM2lWV1lyUWcxeFNkRnZuWEFIOWVm?=
 =?utf-8?B?SWxUZXJRRkt5N0lvYndUZ2FpOUMyOVVpU0xXRUxaTFR4dWpjNGR2Y0ZvbTZO?=
 =?utf-8?B?SkFVdkhheDlIL1BkQ2lwYitzZ0lTSHY5SGlvdWFZOG16WkxaTGhsRnZCeVNH?=
 =?utf-8?B?aktOeDBETktjTXhEQWJIdDZJQUw4TnNCMDJsSVNxSk80UWMxZUVDZ3Bad2hG?=
 =?utf-8?B?STVDVWdObGF4NmF5K292OGY3VjhaUFM0U0ppVHdMRHFPditBSXA0WGxQSDYr?=
 =?utf-8?B?YlVZWnB6Y2hIN0JacmVacTJmRHNWeGJrdWNVSG01K0trdlpGYjV5ZnF1OXlI?=
 =?utf-8?B?OUxLMy8xV0pyWW00RE0yWm8xUmEzZUo5TDNFSmVFcU5FRFVmY0ozR1NrMTFP?=
 =?utf-8?B?aXptVFYzMU1EWnUzM0hIZzN5cDZJQXgwMDhOYVFjK0syM1JTVHhGT29SM0k1?=
 =?utf-8?B?d2ZqYzlsZlVWM0FweWpQdnRvWFdOdktWcDRhNmRXVXM3K0YzS3B1c0xuYjFL?=
 =?utf-8?B?bElDSjlCdkRPTkFjN2hGa2JmUVRkaEMvY2lrdy9IQnlVRjROalNkUlYraTRx?=
 =?utf-8?B?NU9FOThNRnhDTEc5UE1DUjlSaWNPczZWV1pSSVV6b2svV3p3SUhUSFRWWlcy?=
 =?utf-8?B?UnFXd3Z0UHRIcnV1K3orYWVId1NHc2dHclhTTGc5UzVNUWkySDhUM3FoK2dY?=
 =?utf-8?B?bE5GQlNCQWNTZHFQZkg1WS8xNXFwVmhLV1lRcm9BWVhtcjVMVkpZekJUUEtM?=
 =?utf-8?B?VmpGbXNLU3pxS3N3cUVCVWZ4ZUlXaWkxaTBPWXp5dDFOTEVIa3BtdVRQdzFZ?=
 =?utf-8?B?QzliQkVLYmUveWZxL3BPMWVWNVAxbjRjRVNWZHBUYk9rNTN1dVNZT0kxWmVy?=
 =?utf-8?B?Zm5OeEJvS0t6WkdLMWxTS2VUeU1XMVd1SnkwSVpyMmpRM0JDdEp1eWtxcW1T?=
 =?utf-8?B?UkF1UmZsanpPWHFFUUErOTVqUm9FbmdFbTR0dnZNcTd2S3RvRHg2QURHTnd3?=
 =?utf-8?B?bjBQVVJ2R1FCZGliUWtSNE9IY0gzRElGREJZbHZwZUtuaFYvSmdTbllFZXZN?=
 =?utf-8?B?VnlhRngrK1VGc0puUW9ONmVocTVGREVBb3IxY3FjaS9BMk5ieVI4cWdNYXNN?=
 =?utf-8?B?Znd1WXFGWm5iSDkyY3V0aXU1OUNkSXN6KzVkYjgxdVF2UExoQUFUZUw4cFRm?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <933FE577FED7EE4885E9532FE2D6D18D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6341f8-d7f3-4b64-ed29-08dc7f2e2b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 15:52:24.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGwUKWzSGgIdYKsIIAtc5mR2lXKAy5Z+jT9ZSToNoyAzLh0Ktr0wh0TMhm/9ObsXDqZk2OplIDE9PQIou2uH+8WmcTz5qIByPf4oS0vfNag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7847

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjQtMDUtMjggYXQgMTI6MjQgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyNi8wNS8yNCAwMTowOCwgSmFzb24tSkgu
TGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGNtZHFfcGt0X2xvZ2ljX2NvbW1hbmQgdG8gc3VwcG9y
dCBtYXRoIG9wZXJhdGlvbi4NCj4gPiANCj4gPiBjbWRxX3BrdF9sb2dpY19jb21tYW5kIGNhbiBh
cHBlbmQgbG9naWMgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQsDQo+ID4gYXNrIEdDRSB0byBl
eGVjdXRlIGEgYXJpdGhtZXRpYyBjYWxjdWxhdGUgaW5zdHJ1Y3Rpb24sDQo+ID4gc3VjaCBhcyBh
ZGQsIHN1YnRyYWN0LCBtdWx0aXBseSwgQU5ELCBPUiBhbmQgTk9ULCBldGMuDQo+ID4gDQo+ID4g
Tm90ZSB0aGF0IGFsbCBhcml0aG1ldGljIGluc3RydWN0aW9ucyBhcmUgdW5zaWduZWQgY2FsY3Vs
YXRpb25zLg0KPiA+IElmIHRoZXJlIGFyZSBhbnkgb3ZlcmZsb3dzLCBHQ0Ugd2lsbCBzZW50IHRo
ZSBpbnZhbGlkIElSUSB0byBub3RpZnkNCj4gPiBDTURRIGRyaXZlci4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8
IDM2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCA0Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBiL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggMDQ2NTIyNjY0
ZGMxLi40MmZhZTA1ZjYxYTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiA+IEBAIC0xNSwxMCArMTUsMTkgQEANCj4gPiAgIC8qIGRlZGljYXRlIHRo
ZSBsYXN0IEdQUl9SMTUgdG8gYXNzaWduIHRoZSByZWdpc3RlciBhZGRyZXNzIHRvIGJlDQo+ID4g
cG9sbCAqLw0KPiA+ICAgI2RlZmluZSBDTURRX1BPTExfQUREUl9HUFIJKDE1KQ0KPiA+ICAgI2Rl
ZmluZSBDTURRX0VPQ19JUlFfRU4JCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIENNRFFfSU1NRURJQVRF
X1ZBTFVFCTANCj4gPiAgICNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KPiA+ICAgI2RlZmluZSBD
TURRX0pVTVBfUkVMQVRJVkUJMA0KPiA+ICAgI2RlZmluZSBDTURRX0pVTVBfQUJTT0xVVEUJMQ0K
PiA+ICAgDQo+ID4gKyNkZWZpbmUgQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUob3BlcmFuZCkg
XA0KPiA+ICsJKHsgXA0KPiA+ICsJCXN0cnVjdCBjbWRxX29wZXJhbmQgKm9wID0gb3BlcmFuZDsg
XA0KPiA+ICsJCW9wLT5yZWcgPyBvcC0+aWR4IDogb3AtPnZhbHVlOyBcDQo+ID4gKwl9KQ0KPiAN
Cj4gSSB0aGluayB0aGlzIENNRFFfT1BFUkFORF9HRVRfSURYX1ZBTFVFIHdvdWxkIGJlIGJldHRl
ciBleHByZXNzZWQgYXMNCj4gYSAoaW5saW5lPykNCj4gZnVuY3Rpb24gaW5zdGVhZC4uLg0KPiAN
Cg0KWWVzLCBJIGNhbiBjaGFuZ2UgdGhlbSB0byBzdGF0aWMgaW5saW5lIGZ1bmN0aW9uIHRvIHBh
c3MgdGhlaXIgdHlwZQ0KZGlyZWN0bHkuDQoNCj4gc3RhdGljIGlubGluZSB1MTYgY21kcV9vcGVy
YW5kX2dldF9pZHhfdmFsdWUoc3RydWN0IGNtZHFfb3BlcmFuZCAqb3ApDQo+IHsNCj4gCXJldHVy
biBvcC0+cmVnID8gb3AtPmlkeCA6IG9wLT52YWx1ZTsNCj4gfQ0KPiANCj4gYW5kIG1heWJlIHRo
ZSBzYW1lIGZvciB0aGUgb3RoZXIgZGVmaW5pdGlvbiB0b28uLg0KPiANCj4gc3RhdGljIGlubGlu
ZSB1MTYgY21kcV9vcGVyYW5kX3R5cGUoc3RydWN0IGNtZHFfb3BlcmFuZCAqb3ApDQo+IHsNCj4g
CXJldHVybiBvcC0+cmVnID8gQ01EUV9SRUdfVFlQRSA6IENNRFFfSU1NRURJQVRFX1ZBTFVFOw0K
PiB9DQo+IA0KPiBidXQgZGVmaW5pdGVseSB0aGUgZmlyc3Qgb25lIGlzIHdoYXQgSSBkb24ndCBs
aWtlIG11Y2gsIHRoZSBzZWNvbmQNCj4gb25lIGNhbiBwYXNzLg0KPiANCg0KWW91IG1lYW4gJyNk
ZWZpbmUgQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUoKScgaXMgdGhlIGZpcnN0IG9uZSBvcg0K
J3N0YXRpYyBpbmxpbmUgdTE2IGNtZHFfb3BlcmFuZF9nZXRfaWR4X3ZhbHVlKCknIGlzIHRoZSBm
aXJzdCBvbmU/DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBDaGVlcnMsDQo+IEFuZ2Vs
bw0KPiANCj4gPiArI2RlZmluZSBDTURRX09QRVJBTkRfVFlQRShvcGVyYW5kKSBcDQo+ID4gKwko
KG9wZXJhbmQpLT5yZWcgPyBDTURRX1JFR19UWVBFIDogQ01EUV9JTU1FRElBVEVfVkFMVUUpDQo+
ID4gKw0KPiA+ICAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KPiA+ICAgCXVuaW9uIHsNCj4g
PiAgIAkJdTMyIHZhbHVlOw0KPiA+IEBAIC00NjEsNiArNDcwLDMzIEBAIGludCBjbWRxX3BrdF9w
b2xsX2FkZHIoc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+ID4gZG1hX2FkZHJfdCBhZGRyLCB1MzIg
dmFsdWUsIHUzMiBtYXMNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfcG9s
bF9hZGRyKTsNCj4gPiAgIA0KPiA+ICtpbnQgY21kcV9wa3RfbG9naWNfY29tbWFuZChzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2DQo+ID4gcmVzdWx0X3JlZ19pZHgsDQo+ID4gKwkJCSAgIHN0cnVj
dCBjbWRxX29wZXJhbmQgKmxlZnRfb3BlcmFuZCwNCj4gPiArCQkJICAgZW51bSBjbWRxX2xvZ2lj
X29wIHNfb3AsDQo+ID4gKwkJCSAgIHN0cnVjdCBjbWRxX29wZXJhbmQgKnJpZ2h0X29wZXJhbmQp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0K
PiA+ICsJdTMyIGxlZnRfaWR4X3ZhbHVlOw0KPiA+ICsJdTMyIHJpZ2h0X2lkeF92YWx1ZTsNCj4g
PiArDQo+ID4gKwlpZiAoIWxlZnRfb3BlcmFuZCB8fCAhcmlnaHRfb3BlcmFuZCB8fCBzX29wID49
IENNRFFfTE9HSUNfTUFYKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWxl
ZnRfaWR4X3ZhbHVlID0gQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUobGVmdF9vcGVyYW5kKTsN
Cj4gPiArCXJpZ2h0X2lkeF92YWx1ZSA9IENNRFFfT1BFUkFORF9HRVRfSURYX1ZBTFVFKHJpZ2h0
X29wZXJhbmQpOw0KPiA+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9MT0dJQzsNCj4gPiArCWluc3Qu
ZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiA+ICsJaW5zdC5zcmNfdCA9IENNRFFfT1BFUkFORF9U
WVBFKGxlZnRfb3BlcmFuZCk7DQo+ID4gKwlpbnN0LmFyZ19jX3QgPSBDTURRX09QRVJBTkRfVFlQ
RShyaWdodF9vcGVyYW5kKTsNCj4gPiArCWluc3Quc29wID0gc19vcDsNCj4gPiArCWluc3QucmVn
X2RzdCA9IHJlc3VsdF9yZWdfaWR4Ow0KPiA+ICsJaW5zdC5zcmNfcmVnID0gbGVmdF9pZHhfdmFs
dWU7DQo+ID4gKwlpbnN0LmFyZ19jID0gcmlnaHRfaWR4X3ZhbHVlOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICt9DQo+ID4gK0VY
UE9SVF9TWU1CT0woY21kcV9wa3RfbG9naWNfY29tbWFuZCk7DQo+ID4gKw0KPiA+ICAgaW50IGNt
ZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1
ZSkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0ge307DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCBkNGE4
ZTM0NTA1ZTYuLjViZWU2ZjdmYzQwMCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0yNSw2ICsyNSwzMSBAQA0KPiA+ICAgDQo+ID4gICBzdHJ1
Y3QgY21kcV9wa3Q7DQo+ID4gICANCj4gPiArZW51bSBjbWRxX2xvZ2ljX29wIHsNCj4gPiArCUNN
RFFfTE9HSUNfQVNTSUdOID0gMCwNCj4gPiArCUNNRFFfTE9HSUNfQUREID0gMSwNCj4gPiArCUNN
RFFfTE9HSUNfU1VCVFJBQ1QgPSAyLA0KPiA+ICsJQ01EUV9MT0dJQ19NVUxUSVBMWSA9IDMsDQo+
ID4gKwlDTURRX0xPR0lDX1hPUiA9IDgsDQo+ID4gKwlDTURRX0xPR0lDX05PVCA9IDksDQo+ID4g
KwlDTURRX0xPR0lDX09SID0gMTAsDQo+ID4gKwlDTURRX0xPR0lDX0FORCA9IDExLA0KPiA+ICsJ
Q01EUV9MT0dJQ19MRUZUX1NISUZUID0gMTIsDQo+ID4gKwlDTURRX0xPR0lDX1JJR0hUX1NISUZU
ID0gMTMsDQo+ID4gKwlDTURRX0xPR0lDX01BWCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVj
dCBjbWRxX29wZXJhbmQgew0KPiA+ICsJLyogcmVnaXN0ZXIgdHlwZSAqLw0KPiA+ICsJYm9vbCBy
ZWc7DQo+ID4gKwl1bmlvbiB7DQo+ID4gKwkJLyogaW5kZXggKi8NCj4gPiArCQl1MTYgaWR4Ow0K
PiA+ICsJCS8qIHZhbHVlICovDQo+ID4gKwkJdTE2IHZhbHVlOw0KPiA+ICsJfTsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gICBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnIHsNCj4gPiAgIAl1OCBzdWJzeXM7
DQo+ID4gICAJdTE2IG9mZnNldDsNCj4gPiBAQCAtMjcyLDYgKzI5NywyMyBAQCBpbnQgY21kcV9w
a3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgNCj4gPiBzdWJzeXMsDQo+ID4gICBpbnQg
Y21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4g
ICAJCSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gPiAgIA0KPiA+
ICsvKioNCj4gPiArICogY21kcV9wa3RfbG9naWNfY29tbWFuZCgpIC0gQXBwZW5kIGxvZ2ljIGNv
bW1hbmQgdG8gdGhlIENNRFENCj4gPiBwYWNrZXQsIGFzayBHQ0UgdG8NCj4gPiArICoJCSAgICAg
ICAgICBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQgc3RvcmUgdGhlIHJlc3VsdA0KPiA+IG9m
IGxvZ2ljIG9wZXJhdGlvbg0KPiA+ICsgKgkJICAgICAgICAgIHdpdGggbGVmdCBhbmQgcmlnaHQg
b3BlcmFuZCBpbnRvDQo+ID4gcmVzdWx0X3JlZ19pZHguDQo+ID4gKyAqIEBwa3Q6CQl0aGUgQ01E
USBwYWNrZXQNCj4gPiArICogQHJlc3VsdF9yZWdfaWR4OglTUFIgaW5kZXggdGhhdCBzdG9yZSBv
cGVyYXRpb24gcmVzdWx0DQo+ID4gb2YgbGVmdF9vcGVyYW5kIGFuZCByaWdodF9vcGVyYW5kDQo+
ID4gKyAqIEBsZWZ0X29wZXJhbmQ6CWxlZnQgb3BlcmFuZA0KPiA+ICsgKiBAc19vcDoJCXRoZSBs
b2dpYyBvcGVyYXRvciBlbnVtDQo+ID4gKyAqIEByaWdodF9vcGVyYW5kOglyaWdodCBvcGVyYW5k
DQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3Ig
Y29kZSBpcyByZXR1cm5lZA0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0X2xvZ2ljX2NvbW1h
bmQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNg0KPiA+IHJlc3VsdF9yZWdfaWR4LA0KPiA+ICsJ
CQkgICBzdHJ1Y3QgY21kcV9vcGVyYW5kICpsZWZ0X29wZXJhbmQsDQo+ID4gKwkJCSAgIGVudW0g
Y21kcV9sb2dpY19vcCBzX29wLA0KPiA+ICsJCQkgICBzdHJ1Y3QgY21kcV9vcGVyYW5kICpyaWdo
dF9vcGVyYW5kKTsNCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIGNtZHFfcGt0X2Fzc2lnbigp
IC0gQXBwZW5kIGxvZ2ljIGFzc2lnbiBjb21tYW5kIHRvIHRoZSBDTURRDQo+ID4gcGFja2V0LCBh
c2sgR0NFDQo+ID4gICAgKgkJICAgICAgIHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBz
ZXQgYQ0KPiA+IGNvbnN0YW50IHZhbHVlIGludG8NCj4gDQo+IA0KPiANCj4gDQo=

