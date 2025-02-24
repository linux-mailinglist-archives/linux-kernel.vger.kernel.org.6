Return-Path: <linux-kernel+bounces-528069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B6A41328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED06170CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E11198842;
	Mon, 24 Feb 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MLXO8aLm";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wSyoebo8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616B2A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362862; cv=fail; b=X4Vhz/6lyBaw+UGM2UMJm25paqSSRosFSaHPOY6VjVJPaNxTsL/A6oSZpJv/pikhZ/6o148vAr3xo8U7DVYqUs+v5HMSDHKnMePem7X10Eet/vtjvdFy3/P+qWNuvqoZn/yeD2GYYxYV14VjXbKFcVYMnrAeAKGq4bvcjpcNIhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362862; c=relaxed/simple;
	bh=ake0zDqoSYmtyiuejVfGhzxO8UJjQ0PfuDUa35bIwpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpQaAqow1jaw+KU7cRpLS9FjYIZoPuJdrCJgnAe7VcEjmaLA9nX9MDhJfnPBVU54KoS16O0gEf61tNF0e3CUomFVt83DdkpjAqzdxESykCDuNJiO/m7luFKXW98LFN/QCFKzPSqwA1BVNCtxcfxPI/kit2tyP2z8WkwlG6rym9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MLXO8aLm; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wSyoebo8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c77c6e0f25411ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ake0zDqoSYmtyiuejVfGhzxO8UJjQ0PfuDUa35bIwpw=;
	b=MLXO8aLmKwfKHx1ygBFuRnCb6mkFS3e05QRjzyBI9xdeNVQnYvTwJI8swa5tVrYwe2CG/a0FpBPNzfzmToWFAmdZT3j7EJVc1GSJhDEvw1M+hf1k615WYBqrikcujvNwSfz1OSDpfAWkwBnlzLrzK527P9hi3MJSPDrdBd4mw6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:fbf1b033-ea21-46ba-90b7-3f4b33cb72e2,IP:0,U
	RL:0,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:60aa074,CLOUDID:9b792929-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|51,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1c77c6e0f25411ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1552412766; Mon, 24 Feb 2025 10:07:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 10:07:33 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 10:07:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzKrmsWJ1p8Qw7COji9YiYnQFe/TiZIBU2phLKCCHsQGh4SyHqa9DZQm7lO2g2l22hgMpmr2nYRhPPa2wX2fFUFu4IWfgP5AxvMxiOIMwogSqvLMR9P3pIfZ77P/mymjFTyGs6LUUy3poUYdwn5laLEX5cQ4vW4esplGdYy/MkDBAzZNzB6yzs6EM7/ImrzI2kv5OXDlFDZL77fWmLu5YFjAMjQXjsRYNMdNobodGQUXLEckYiGOCq6Q0ki+qGtR8nbJLUiN5gaMKYxxPyYzE1nOHC/rB1xIJ5NtKX2T/kOFPQ6Cpo0YgduLWJWJWVM8Oh8EcoexEOKoJaJvQBFxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ake0zDqoSYmtyiuejVfGhzxO8UJjQ0PfuDUa35bIwpw=;
 b=aYPK8RIywU25Jo37IMKkO/7zhkZmm9XkK076K+ygihqL3FhLkb2U+d5i1dYs/zZwahzW/9u9CCiQgZ6DBf+MPv72ytqIearWizmQf0myeErpanYtURtbIfez9TmYFpfC4XPsjV0FCr+udxuJK0vIqRwb0lnHGbX91LHjfbsx2cnZ8ai8qe/Vh+rUOBEOCacqlFm9R74U3DRMWENPf7fNNnkXKCmEgsSCIdKHTv9LRs28JHaqhg3bCpSgzPrLDtygnDhgMoPq/cWeZxqvgURsQ0owZuRXYd9QzY01CZV1huSqqQdIvEMX63aWgCWGSpeT1Bh/j9eV7xUaVYHocbb2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ake0zDqoSYmtyiuejVfGhzxO8UJjQ0PfuDUa35bIwpw=;
 b=wSyoebo8knJyCcwxlyigpaTeUFYwoDC7ZlHo1+FcquNdPQ0BQgIPM0nILTijUW3Di4adPFAEjTc0MfIaLacYD5iD4HnG/PlbCffG6e4tPWw7fW3qy+m3EyrUobVADyM3itKfXx2PXf4zn3sZEMyXAnRsFQQjhXVOh3McqhjgBMs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7921.apcprd03.prod.outlook.com (2603:1096:101:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 02:07:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 02:07:30 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>
CC: "treapking@chromium.org" <treapking@chromium.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>
Subject: Re: [PATCH 4/5] drm/mediatek: Add MDP-RSZ component support for
 MT8196
Thread-Topic: [PATCH 4/5] drm/mediatek: Add MDP-RSZ component support for
 MT8196
Thread-Index: AQHbfDEQZ/cUZFoXjUibKpIU1qXg7LNLCzgAgAozwICAAIpdAA==
Date: Mon, 24 Feb 2025 02:07:30 +0000
Message-ID: <9963d5a73748db04e322d7bbe9247d71614f9766.camel@mediatek.com>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
	 <20250211025317.399534-5-sunny.shen@mediatek.com>
	 <58905e28726bb87e20bdfdef6fa78784656ba1c3.camel@mediatek.com>
	 <56c5f618269c75d5bff313dce44fd4887f7e70c3.camel@mediatek.com>
In-Reply-To: <56c5f618269c75d5bff313dce44fd4887f7e70c3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7921:EE_
x-ms-office365-filtering-correlation-id: 409d62e0-e653-446c-e8eb-08dd5477fea8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U04yTXFwb1lKMDlrUXNaTHhTZHg3SFlSZWJwL0NqTkdKc3BsOVFjd0ZrZW1F?=
 =?utf-8?B?TFVjaks0Q3h4cGs0Q3IzWDFEcGV0ZlpNSkNHR3YwNXNDWVh1TXFOUHRQT0wz?=
 =?utf-8?B?L01YUzVsY1BmYUZtYklZVTFCODVSc1NNc0hGbndKSUJlRHFzaktQNzlHTUpm?=
 =?utf-8?B?SXRpSy9RMHcvcndLZ2xqd1FnWjV2cDJkVkgxTnhhUGc4UmpTYVBJZkU1aE5J?=
 =?utf-8?B?Yk41enhJZWhoUHgwVTJOcEwrZzFQUGhYOC9RcmZWZzJHWDNlMjRET3J1dnl6?=
 =?utf-8?B?SzZnUEpnTzdZV1RpVTQ5bHg3SU14YkZIRmJmKzRtTHU2aU1vVm15ZWs3VkFL?=
 =?utf-8?B?NU9HQUpCTnN1My9qQnFOZnFWbmxjakNzVzBtQnpBUFUrbSsyZjlTUExZNlJr?=
 =?utf-8?B?YVNkVW1EMjdhbUtOdDFQTUVGcENNWjZlQWxyS09WaEFZRko5bnVTK2VzcVMz?=
 =?utf-8?B?MTlBUnphL3lCVEtrMEZGWEpwSTN6MUdTQnFnS1BNbmN6UU1hYWpvbStKcXBU?=
 =?utf-8?B?N1RsWEhmZnd5WFg3U1JGbW8vTnNtbC9KZElpRmZwY2p0Njh1MGM4aDV2YjEx?=
 =?utf-8?B?OThPK0NhZFdvUGg0N256WWc2UkVodkUybG4wVHNDT3IvS2ZrYzBSZnRuRkJk?=
 =?utf-8?B?S1lHSFk0OTZFMktIR0U0TVhTZlN3R3hLV1hyZmdaZ2lxeVRyV0Jtcm5ITmMx?=
 =?utf-8?B?M2hvb3JVaEthNlNWOE53azNhWlNKaVJ0QXlEelNlTHB2UDBKbmUvcEZ5ektO?=
 =?utf-8?B?Yy9PYitmVjVuMDZQWjZucHZFb1R5RzI5T1AwK3JnWStNQmVtOG5TOWlwRFpK?=
 =?utf-8?B?SnM1K3dPeDNUZmswVml1QWI3MzVjc0xUcUhjZzZSZ0Jpd2RBaE9tTnllN3Yy?=
 =?utf-8?B?WmNLbHhkN2NHcjArVW5KWjRZVStGM0xEZnVVeWhuNTN1QlE5Vi9DeGl3cFlu?=
 =?utf-8?B?NWNxRUhTanhRK3ZiNGx5ZDdVSFVPZFZnbVVpV2xzbzFadHBXL3hzRUxraE80?=
 =?utf-8?B?ajJ4eXBhUVMxTEwvSXhneWtRYUtVeERTUjh0ZXFBZHlBU0hxa1llRnVCK2dJ?=
 =?utf-8?B?M3M3dGFiU1Z6b2ZyaUFQUmE1cE5LVzI5UDJrZThhbWhKUHhmaUlGZGxzamVD?=
 =?utf-8?B?ZU83V2t2aGhDbTI3MkVQODF2VWt4RFRGaWZMNmRxTnFoT0kyWUhLWWNKRHl3?=
 =?utf-8?B?Szk0MnFRa2dSTDNGOXRsKzBERzNJQlc4OGNESnNVc0hMSnlXTHc2VFBSZll2?=
 =?utf-8?B?OEVyNncrSU9zbnAzY3pKZ2dYbGw3N3dSdW5VTVJNRUpaM0NLKzdEdTBNTEs4?=
 =?utf-8?B?cmVnWVFWTko0V1FGMEhJekN3MzBrK2VWNXc1Tk45aUFUUElzMHN3YVdVczNZ?=
 =?utf-8?B?Mi9ic2poNjEydVBUMlpta2gvd2EwSmhIejUvc0cxWWt6MXY0dmtuMkF6SlRy?=
 =?utf-8?B?WjEyQmtSNmNOb08raHpDK1ZRdHh6L2ZPbVN4aE11N3BPMDYvc0dIeFdQdU5I?=
 =?utf-8?B?QUF4dHRLYkk5bEZDTDB3d044WXFELzAvNndyZzJid21IbmVreFFuNWJzM2Vi?=
 =?utf-8?B?NTRRd0pPakt3L3U2cXlGVEtaZmNJaWFrQzFySWVqcW9WZ2dvNlF0Y3YrMzJG?=
 =?utf-8?B?cGtZd0dZMkZlL3JFVnUwMWxWSDB3ZUQ3cGc4UzlGL25Pb0d3anIrQXVDdGFB?=
 =?utf-8?B?a2t3NEIxNTVIN1pVS1lEWnBNODRSelFUR20vcXNVN2QvN1VESlJjbHA5MGRp?=
 =?utf-8?B?OGRJN1Z3NDBocmFkZTBiUFhheXFEbTM3MEpkbXRPUUJmQkNPTUlaNmhlei9W?=
 =?utf-8?B?c1lNdDBoMUdXL1NkSjdNYktMaCtJakdrajU3dGpDcnJYTGNRYnJWcit0OU81?=
 =?utf-8?B?NWk2ZFkyNmNKREQ0YVgxMVd0dWpvL1FjaWhuVzUzVEZjZkYxSHIzNUZ0N2xX?=
 =?utf-8?Q?dWDNGtKMZIfqNZQD9lksZu+/FdVLp4AF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG9ybVlhUXpNRmZ0cy8vQXpqdzQvM3Z4NFh4TGdLNFV0d3pZa2FyYkMweUVW?=
 =?utf-8?B?VWdqWTNXUlhJOVZVeGZ2d25IcFdsb1NNWENkYTliVk5POTA5eWRVU1JOMTBX?=
 =?utf-8?B?MmVZdzRLOFl2ZFJSOWxjWDNvaXVra0NzNUcwQzhYc2tHSkdXaGkra1VPMU1F?=
 =?utf-8?B?UGJZSWhwMTloUTVXeElxMUlibERwOXdQZEdJaFV1c01yN2hxY1NpNGNELzI2?=
 =?utf-8?B?RllkZWxKNzBZRmIvSWptRm5JMElkbjdPSHhyMm1SNXJjN0Q2aGNMOFVmRkYr?=
 =?utf-8?B?UEk3dUxKMjlOd1pJZzRPWVVKbDdGbVBORGZwaUxIZWg5THdTYmlqbGdXeVl2?=
 =?utf-8?B?RytOa0ZDTkhrZFRaRDcxajVhTVpLTG1MOTdTekpucVNZMkNsRWxRSkJXOEQ3?=
 =?utf-8?B?OE0wR0xOVUp6WjFKTkVzVnJ5cnpRZUp3UFhDY2IvS2tIZU1TSFVRbkczMENh?=
 =?utf-8?B?M0ZHUFdDczRRRGsxVUdiNXMwWWF3blRPM1FGQTdtV2Q1cCtFU2thRXlCNTND?=
 =?utf-8?B?YXpaUyt1eS94LzN3ZEl2VzFoM2p6LzVtSjRoV1RwUUdNdXA0WFlhZUxtTjhP?=
 =?utf-8?B?Y0tJR0hKSXZXblRkVDBuanl0UkZhMVhpL2d2cEtQS3owYitER3AvQ0EzZUxD?=
 =?utf-8?B?UmYzVjl5cFNPbVI3MnBvUmJTc1h1bkQwNTVKU3NNRWdPeWhCbWhMMFpwcEti?=
 =?utf-8?B?UTZzLzl5SG1YcDJSSythdmswcUwvclVuQ091U2N5UHpndXdjOE9qRnJwQnlJ?=
 =?utf-8?B?TWJqKzgvUTFJdm9pWnRRZDB2RkEyYUJqWnJ2T0RCWENYbXlVbnFieGZjZEJ6?=
 =?utf-8?B?VTdURE9Gb3k2QkhDMFJNY01HMVUxT2Ria0JRQWhVT0o1L3RhNUd1SmZ1MkJR?=
 =?utf-8?B?a2hWOEpRaW81ay9seXBjODNJRlZVUG1FeW1vUTlhMmk2dVJjNnYxWGRHalVk?=
 =?utf-8?B?LytLLzJ4V2tETEVWOEpGSE03UnZMYnJUKzdWajQxZ0ZSRmpCU0ZuZjZuRTAr?=
 =?utf-8?B?bFZocGZ3SVZCTGFnTjRjTmRmMllWOGFwZ21IdXpSdldVbHAxeWRoQVJjMDZH?=
 =?utf-8?B?YURoTG5oQ1BRQ2VwY3dGbFcvMzR0dE5WMlBrYkUxRVRRVVcxT05wVElhTHNq?=
 =?utf-8?B?MDNWQ3FrU1RoMVZEemJBQldyTk9EaUZpdmtvei9EWkN5enEwTFRpckZ0QUtk?=
 =?utf-8?B?YkJLMkU4Y0hqcERvNDNSMFZZTTE4L1NLbFF2MnRzYmhGVnI3RVdvTFBiaUdN?=
 =?utf-8?B?RHdCb1ZqL2N0U2VOL1VKY2J3ajlPb2JYYkhaYnNRd0syc2hnV0xOSGlqYmtI?=
 =?utf-8?B?ZDhRNVpBQk5keWVYbWNpUlhEdTY2SC9GVDA2dWNYWm91UTRyQ0ExemNzUURh?=
 =?utf-8?B?bU1vcncyMG4rSDNsYlc3VVBEZjNsR3JFU1NjcFprVnBRUzlOZ3RXLzJZZG5X?=
 =?utf-8?B?TVdFaUpzcWI1Nkl3aEgzcU5IbkdvVHFMSUZvRllmYWk1dUZmT3g1Z1FDVFZL?=
 =?utf-8?B?emhDajNwaFZabVd2K1hOWWxFcCtkelF3eVpLaXpPVGxCeGZpTVYxWlo5L1NJ?=
 =?utf-8?B?dW91dUo0eTZuN0U1SGs2ZzBlZFRVeG1kN082VjVWSlpMaXRWUlJ2ekVTa09T?=
 =?utf-8?B?QlVuT1FuNVIwU1ZXWjBCOVBsZEJsS2xGM1JkejZPRDZ3QnB6V1JYcTVXbW9y?=
 =?utf-8?B?YmJqcWcrL3A1WHI5SzhzdTYzM2RySk5jYzRKN2RCeG5vT2RUOWtVeUtvSEs5?=
 =?utf-8?B?aUxha1lLRUZjc2t5K09uNFNCSEsrWUtRL2NSTEMyaTQ1RENoWk1iejlRSnA2?=
 =?utf-8?B?TVA5QkhFeS9wRThCNlY1bktpeXJNK1lTS0VuanY5RDB0WW5IcVRqVExjNkpz?=
 =?utf-8?B?S01OL1hFYzdTRm5HenVPaXJsUHhuemlaekdsUkl3OHhUNW1sdkkxTzlTUU9M?=
 =?utf-8?B?aU8zeG9HcGpuVFV3LzFlSGRHSURYeGpZQXIrUU93RE9CMnFsVm9sV0EwYWZp?=
 =?utf-8?B?WlI0TGppZmNQUDFORy9qZ2pQRVRmdEluaWJyazBpbEtXWmlBb3Ftb3FNZHlV?=
 =?utf-8?B?ZnVLRWtzQ3dMSVNWZjJQaTh1d1JZcm1uVlVYSXJtRHlmNkNuMWxJTC9Cb3o0?=
 =?utf-8?Q?nR+ECuIDxShSwqKII3knmJoid?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C8F5E30ED34645B432E5D2F4C512EB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409d62e0-e653-446c-e8eb-08dd5477fea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 02:07:30.6568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eazXS31qK0rBXdpsY69lBeFNW7FuNCB/mzbI6vpOMzBoU/NvU9jclEopxJXLb72k21dRMpRUNfh0mRAqNL4o+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7921

T24gU3VuLCAyMDI1LTAyLTIzIGF0IDE3OjUyICswMDAwLCBTdW5ueSBTaGVuICjmsojlp43lp40p
IHdyb3RlOg0KPiBPbiBNb24sIDIwMjUtMDItMTcgYXQgMDY6MDQgKzAwMDAsIENLIEh1ICjog6Hk
v4rlhYkpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNS0wMi0xMSBhdCAxMDo1MiArMDgwMCwgU3Vu
bnkgU2hlbiB3cm90ZToNCj4gPiA+IEFkZCBNRFAtUlNaIGNvbXBvbmVudCBzdXBwb3J0IGZvciBN
VDgxOTYuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1bm55IFNoZW4gPHN1bm55LnNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGRwX2NvbXAuYyB8IDI0DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oIHzCoCAxICsN
Cj4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmPCoCB8wqAgMiAr
Kw0KPiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0K
PiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gPiA+IGlu
ZGV4IDdmMDlhODk3Nzk2NS4uNjU4NzhkM2ZlOGE5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gPiA+IEBAIC00Niw2ICs0NiwxMCBAQA0K
PiA+ID4gwqAjZGVmaW5lIERTQ19CWVBBU1MJCQkJQklUKDQpDQo+ID4gPiDCoCNkZWZpbmUgRFND
X1VGT0VfU0VMCQkJCUJJVCgxNikNCj4gPiA+IMKgDQo+ID4gPiArI2RlZmluZSBESVNQX1JFR19N
RFBfUlNaX0VOCQkJMHgwMDAwDQo+ID4gDQo+ID4gRG8geW91IGNvbmZpZyByZXNpemVyIGluIGJ5
cGFzcyBtb2RlIHNvIHlvdSBuZWVkIG5vdCB0byBlbmFibGUgaXQ/DQo+IA0KPiBZZXMsIGl0J3Mg
YnlwYXNzIG1vZGUNCj4gVG8gdXNlIHRoZSBoYXJkd2FyZSBwYXRoIGZvciBQUSwNCj4gd2UgbmVl
ZCBzZXQgdGhpcyByZXNpemVyIHRvIGJ5cGFzcyBtb2RlIGJlY2F1c2UgdGhlIHBhdGggbXV4IGRl
c2lnbiBvZg0KPiB0aGUgTVQ4MTk2DQo+IA0KPiA+IA0KPiA+ID4gKyNkZWZpbmUgRElTUF9SRUdf
TURQX1JTWl9JTlBVVF9TSVpFCQkweDAwMTANCj4gPiA+ICsjZGVmaW5lIERJU1BfUkVHX01EUF9S
U1pfT1VUUFVUX1NJWkUJCTB4MDAxNA0KPiA+ID4gKw0KPiA+ID4gwqAjZGVmaW5lIERJU1BfUkVH
X09EX0VOCQkJCTB4MDAwMA0KPiA+ID4gwqAjZGVmaW5lIERJU1BfUkVHX09EX0NGRwkJCQkweDAw
MjANCj4gPiA+IMKgI2RlZmluZSBPRF9SRUxBWU1PREUJCQkJQklUKDApDQo+ID4gPiBAQCAtMjM1
LDYgKzIzOSwxOCBAQCBzdGF0aWMgdm9pZCBtdGtfb2Rfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiA+ID4gwqAJd3JpdGVsKDEsIHByaXYtPnJlZ3MgKyBESVNQX1JFR19PRF9FTik7DQo+ID4g
PiDCoH0NCj4gPiA+IMKgDQo+ID4gPiArc3RhdGljIHZvaWQgbXRrX21kcF9yc3pfY29uZmlnKHN0
cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gPiArCQkJwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQNCj4gPiA+IHZyZWZyZXNoLA0KPiA+ID4gKwkJ
CcKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgYnBjLCBzdHJ1Y3QgY21kcV9wa3QNCj4gPiA+ICpj
bWRxX3BrdCkNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBtdGtfZGRwX2NvbXBfZGV2ICpwcml2
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPiArDQo+ID4gPiArCW10a19kZHBfd3JpdGUo
Y21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gPiA+ICsJCcKgwqDC
oMKgwqAgRElTUF9SRUdfTURQX1JTWl9JTlBVVF9TSVpFKTsNCj4gPiA+ICsJbXRrX2RkcF93cml0
ZShjbWRxX3BrdCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLA0KPiA+ID4gKwkJwqDC
oMKgwqDCoCBESVNQX1JFR19NRFBfUlNaX09VVFBVVF9TSVpFKTsNCj4gPiANCj4gPiBEbyB5b3Ug
Y29uZmlnIHJlc2l6ZXIgaW4gYnlwYXNzIG1vZGUgc28gd2lkdGggYW5kIGhlaWdodCBpcyBzZXQg
dG8NCj4gPiB6ZXJvPw0KPiANCj4gWWVzLCB3ZSBzZXQgcmVzaXplcidzIHdpZHRoIGFuZCBoZWln
aHQgdG8gMCBhbmQgdXNlIHRoZSBieXBhc3MgbW9kZQ0KDQpBZGQgY29tbWVudCBmb3IgdGhpcyBz
byBvdGhlcnMgd291bGQga25vdyB3aHkgbm90IGVuYWJsZSBpdCBhbmQgd2h5IHNldCB3aWR0aC9o
ZWlnaHQgdG8gemVyby4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+ID4gDQo+ID4gUmVnYXJkcywN
Cj4gPiBDSw0KPiA+IA0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+IMKgc3RhdGljIHZvaWQgbXRr
X3Bvc3RtYXNrX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludA0KPiA+ID4g
dywNCj4gPiA+IMKgCQkJCXVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQNCj4gPiA+IHZyZWZy
ZXNoLA0KPiA+ID4gwqAJCQkJdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+ID4g
PiAqY21kcV9wa3QpDQo+ID4gPiBAQCAtMzkxLDYgKzQwNywxMiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiA+ID4gZGRwX292bHN5c19hZGFwdG9yID0gew0KPiA+
ID4gwqAJLmdldF9udW1fZm9ybWF0cyA9IG10a19vdmxzeXNfYWRhcHRvcl9nZXRfbnVtX2Zvcm1h
dHMsDQo+ID4gPiDCoH07DQo+ID4gPiDCoA0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2RkcF9jb21wX2Z1bmNzIGRkcF9tZHBfcnN6ID0gew0KPiA+ID4gKwkuY2xrX2VuYWJsZSA9IG10
a19kZHBfY2xrX2VuYWJsZSwNCj4gPiA+ICsJLmNsa19kaXNhYmxlID0gbXRrX2RkcF9jbGtfZGlz
YWJsZSwNCj4gPiA+ICsJLmNvbmZpZyA9IG10a19tZHBfcnN6X2NvbmZpZywNCj4gPiA+ICt9Ow0K
PiA+ID4gKw0KPiA+ID4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBk
ZHBfcG9zdG1hc2sgPSB7DQo+ID4gPiDCoAkuY2xrX2VuYWJsZSA9IG10a19kZHBfY2xrX2VuYWJs
ZSwNCj4gPiA+IMKgCS5jbGtfZGlzYWJsZSA9IG10a19kZHBfY2xrX2Rpc2FibGUsDQo+ID4gPiBA
QCAtNDU0LDYgKzQ3Niw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4gPiA+IG10a19k
ZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0gPSB7DQo+ID4gPiDCoAlbTVRLX0RJ
U1BfRElUSEVSXSA9ICJkaXRoZXIiLA0KPiA+ID4gwqAJW01US19ESVNQX0RTQ10gPSAiZHNjIiwN
Cj4gPiA+IMKgCVtNVEtfRElTUF9HQU1NQV0gPSAiZ2FtbWEiLA0KPiA+ID4gKwlbTVRLX0RJU1Bf
TURQX1JTWl0gPSAibWRwLXJzeiIsDQo+ID4gPiDCoAlbTVRLX0RJU1BfTUVSR0VdID0gIm1lcmdl
IiwNCj4gPiA+IMKgCVtNVEtfRElTUF9NVVRFWF0gPSAibXV0ZXgiLA0KPiA+ID4gwqAJW01US19E
SVNQX09EXSA9ICJvZCIsDQo+ID4gPiBAQCAtNTE1LDYgKzUzOCw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RkcF9jb21wX21hdGNoDQo+ID4gPiBtdGtfZGRwX21hdGNoZXNbRERQX0NPTVBP
TkVOVF9EUk1fSURfTUFYXQ0KPiA+ID4gwqAJW0REUF9DT01QT05FTlRfRFNJMl0JCT0gew0KPiA+
ID4gTVRLX0RTSSwJCQkyLCAmZGRwX2RzaSB9LA0KPiA+ID4gwqAJW0REUF9DT01QT05FTlRfRFNJ
M10JCT0gew0KPiA+ID4gTVRLX0RTSSwJCQkzLCAmZGRwX2RzaSB9LA0KPiA+ID4gwqAJW0REUF9D
T01QT05FTlRfR0FNTUFdCQk9IHsNCj4gPiA+IE1US19ESVNQX0dBTU1BLAkJMCwgJmRkcF9nYW1t
YSB9LA0KPiA+ID4gKwlbRERQX0NPTVBPTkVOVF9NRFBfUlNaMF0JPSB7DQo+ID4gPiBNVEtfRElT
UF9NRFBfUlNaLAkJMCwgJmRkcF9tZHBfcnN6fSwNCj4gPiA+IMKgCVtERFBfQ09NUE9ORU5UX01F
UkdFMF0JCT0gew0KPiA+ID4gTVRLX0RJU1BfTUVSR0UsCQkwLCAmZGRwX21lcmdlIH0sDQo+ID4g
PiDCoAlbRERQX0NPTVBPTkVOVF9NRVJHRTFdCQk9IHsNCj4gPiA+IE1US19ESVNQX01FUkdFLAkJ
MSwgJmRkcF9tZXJnZSB9LA0KPiA+ID4gwqAJW0REUF9DT01QT05FTlRfTUVSR0UyXQkJPSB7DQo+
ID4gPiBNVEtfRElTUF9NRVJHRSwJCTIsICZkZHBfbWVyZ2UgfSwNCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgNCj4gPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ID4gPiBpbmRleCBiYWRiNDJiZDRm
N2MuLjg3ZjU3M2ZjYzkwMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGRwX2NvbXAuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5oDQo+ID4gPiBAQCAtMzYsNiArMzYsNyBAQCBlbnVtIG10a19kZHBfY29t
cF90eXBlIHsNCj4gPiA+IMKgCU1US19ESVNQX09WTFNZU19BREFQVE9SLA0KPiA+ID4gwqAJTVRL
X0RJU1BfT1ZMXzJMLA0KPiA+ID4gwqAJTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+ID4gPiArCU1U
S19ESVNQX01EUF9SU1osDQo+ID4gPiDCoAlNVEtfRElTUF9QT1NUTUFTSywNCj4gPiA+IMKgCU1U
S19ESVNQX1BXTSwNCj4gPiA+IMKgCU1US19ESVNQX1JETUEsDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiA+IGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiA+IGluZGV4IDUwZjVmODFhN2RhMS4u
YjgxMGExOTdmNThiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5jDQo+ID4gPiBAQCAtODg1LDYgKzg4NSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkDQo+ID4gPiBtdGtfZGRwX2NvbXBfZHRfaWRzW10gPSB7DQo+ID4gPiDCoAnC
oCAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfR0FNTUEsIH0sDQo+ID4gPiDCoAl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLWdhbW1hIiwNCj4gPiA+IMKgCcKgIC5kYXRhID0g
KHZvaWQgKilNVEtfRElTUF9HQU1NQSwgfSwNCj4gPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTYtZGlzcC1tZHAtcnN6IiwNCj4gPiA+ICsJwqAgLmRhdGEgPSAodm9pZCAqKU1U
S19ESVNQX01EUF9SU1ogfSwNCj4gPiA+IMKgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LWRpc3AtbWVyZ2UiLA0KPiA+ID4gwqAJwqAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX01F
UkdFIH0sDQo+ID4gPiDCoAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1kaXNwLW11
dGV4IiwNCj4gPiANCj4gDQoNCg==

