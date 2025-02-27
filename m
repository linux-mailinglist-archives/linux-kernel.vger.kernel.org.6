Return-Path: <linux-kernel+bounces-535655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD122A4759A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088333A9F37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98221579C;
	Thu, 27 Feb 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KZ++OEOs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Fk0Sc4Jk"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD27214A96;
	Thu, 27 Feb 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635829; cv=fail; b=Pvy0/yfkVJYX/gsKPSHHFI3P083IWeEibao0QFNcf2dKV7cl8vwqJNgJqRd+VlhqrK3/mcqDq05pp9vTP8igze9KoUU9Y2X8x52QuZaJUtO51XAWHlrps76F5uJa87oSc0qAwpgotm6ZX7542Pd4cPChJkQd8ca2aqW2cPDpg9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635829; c=relaxed/simple;
	bh=s+0mRYXbviMqhI6H5GRDphVu2HAeJJG6gov92mkG6rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+CXYaFzxploykiPlTtJ/08b5pzdnVZNP5E01R20sIKwP805Q+XSObUPXITy1RsS7OhBBLjPUM3umxRy1fv+wYPFgZmiXUI3tUP0DnTN2RMncfsCtFWWiduB68Kk3vMC+Wgz1y/ftQ7yNc0fuNYAiU04m5mjvp1rISUSShz/rpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KZ++OEOs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Fk0Sc4Jk; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a7c30822f4cf11efaae1fd9735fae912-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s+0mRYXbviMqhI6H5GRDphVu2HAeJJG6gov92mkG6rA=;
	b=KZ++OEOsXoIdZ0byyXlNA2Uucy2Zc0K67Y3mYG3EFZMEP4/D9HLJUaWzW692f1Mmu7IODzsppJwqoxeGAEBwWsP7OKHO5L7ngX4XgRzmrJBrrYgj8+K9VIdbnY7v2lTL2/k6o9KekWCwbZmZRHLz029ERPhMq0S8pGei19+MotM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:60d2ae71-dd6d-499f-84b2-a874da06de22,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:4d74a3b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a7c30822f4cf11efaae1fd9735fae912-20250227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1510986908; Thu, 27 Feb 2025 13:56:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 13:56:56 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 13:56:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecr8BzQQOT5UMy1RZDRMcpdatzOX4Gq7ehWdJvThEMxWQ+uY1Ncern4b77189PAtRoNt631oRzIYWbuXTfSsOXmtxtmo11Q3W2oexcypEWCENeztBRtGj0Dp7q127IRdDGFcwM+v43WI7XDL4l3HC7qGvBSJbxiA7+GjvTOnKOgR2yBEUiKPA/xjlFzD59wkY421OrNcb/B+gB1OGFkCremwu/x+i0C8AnNrvwCf1NGUJr1ZIHg/iAwzrrMvM4+eKmJw0q333t5b9zCJqnnsIe2gSaJDW9vGwIl3ZEXjIhxXf82ke8xL0L81L0E0sjBuVbMeQ/lEt+jOvmNi4Ibbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+0mRYXbviMqhI6H5GRDphVu2HAeJJG6gov92mkG6rA=;
 b=WvQnetAsY1B3IAHyhyuTmYgkpKwIIlbOzSNhtcM1wkBzt5wS06OhfXPw/0sQuLVU219ackSV9J5K0c7L0KipK9onYCJgPCafWxNJLVOeId16ViVgmywWU0y+l83RPIYqbAWfqDR6Hoh12nwqls+anaJFCiDYW/I13ZCK/5Zxkx9igMUbQqamvU5hcjA72HidxAckbuzoomMKeQ8PCJl7HjXxyqQNs81DigytKulu7U9Q0m7rjaPfywq3Ws6w2pqdNepTXpo09fEvU7+Lezxo+eOWHYNHE0l46IAy7amgAo2oCBRqm0lP4vWy4ohKO5vi/pJlz3JyPSs9LxAjUSm4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+0mRYXbviMqhI6H5GRDphVu2HAeJJG6gov92mkG6rA=;
 b=Fk0Sc4JkhKwBNzEbRBZcSjiYWbIREMMp6sozrRByPjsdLiOArKmPwH0+HpCMDUzblCkbPW6P8f2/70XPc2KjinqXzCaLkBV18fbZY0b+2QrGLNMdIZNDr+03zLZym0hnsg26PItKTEA3NEGJIvRliIkMcQqA4YGmtH2RvXL6huA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB8330.apcprd03.prod.outlook.com (2603:1096:405:1a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 05:56:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:56:53 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v7 36/43] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v7 36/43] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbgVPaUrL84rLBJUW+q9OY+83ex7NatiWA
Date: Thu, 27 Feb 2025 05:56:53 +0000
Message-ID: <623a5cee0e64cb85f9156364c0ee3e4be937e57c.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-37-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-37-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB8330:EE_
x-ms-office365-filtering-correlation-id: eccf823f-755e-402f-e069-08dd56f38964
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djZ5c2JILzViWkJVMkJMNm1rV3F1aTdRbW9ORURjVUVVVmJrelFVYStteGVa?=
 =?utf-8?B?YktZWGlYM3VXUHpRV1A3VnFobk04bDJYMCtwUDhpQmttNHR5K3hKdWl1ckc2?=
 =?utf-8?B?QlAzY2pRTVdvbXJFS0Nqd0M1NGhhWXo2MWw3TXJMNzdyYjdDV2tZUm5mN2k1?=
 =?utf-8?B?eitma1drVmNCaHo4eGp6cDVyTkQrcENENmo1MUxUbjZ0N3ZxZzFlR2xVSWJw?=
 =?utf-8?B?Wk1JV0tvTnBrTVhPTGw0MWFMbHY0S1ZMQzJzSU1nSzI1NFNRZEZQMVdqWkVC?=
 =?utf-8?B?Tlc3ZHgvc1FwejM2eHdoWGd2MSt1ZUVVam5DVVdIL1U4QlpveHFUL3RQWHpa?=
 =?utf-8?B?QlMzTTd1L2VqNlJaTWtDMGxTWHpOS1FaSXkwdXo0Um1zWnUxSUswa3FHSXdm?=
 =?utf-8?B?VllCU0RmTmlYMjl0NHlLZFJVR00xV0ZtRXAyNURXemRJcTFPdnZMek1CUDh1?=
 =?utf-8?B?VE1hVTVFUG9MOTV3VklnL0R4MXJ1L21BcWR0M240dG01d21tdmtBNTR2WGFD?=
 =?utf-8?B?WXdLWUtnTFRlTXowSmI4Z2JWWVM5VWNjSjQ5ckdXdVkybkd4MFhlbXZYbXJu?=
 =?utf-8?B?cE53emcycDY2dHRTNnZBY25WR1V4bGdVTm12eWZyWTA3VGNOc0JwWlowM2Zz?=
 =?utf-8?B?YU80UnFVVUpubCsxeHA4dXJ6aDJyd1QyVkliRFZhY1RzUGJwQ3Y0dXdnZFZv?=
 =?utf-8?B?ams2c3haZE0vVzYyY2pHZG9QUHFCdXV2MldoWmdRWEIwRTE5Zk5NYzBlT05w?=
 =?utf-8?B?dEgwVkVyaW5wK0xBK2Q4QmF0TGYyZzFkeEFZc1JSd1JJclYyTndzWndLTGRq?=
 =?utf-8?B?VHJOd2RKNnAvWVF4UFhKL1IxZ3hZN1hzdlFsdC9PaXdTVHNhenFpMURhNTB3?=
 =?utf-8?B?cElEWTlIL3ZLM1JqSmsxcU41bHRpZW03OHZPL0JHc25xeTZNblNsTENicEhY?=
 =?utf-8?B?YjFUcy94VDFhWWtNTFQ3Z0YwNWJmOGhmZXNDZ3RGQVFhcTBOejFhY1F0UFQ2?=
 =?utf-8?B?NVZjY3VBZVJCT3NrTmZYZDc5dUcrRkd0YkFBOFAzaWZrM08xbDBUeTI2Vndl?=
 =?utf-8?B?TDYxYXNxanRJb1FCS3ByWjc0c0dDS3duMXVjMU1jcTU4Q3pkblZzb2tCZlJK?=
 =?utf-8?B?Q1VEY1RWVkw0QmNZVTZ0aFhDeGdKNytNdzdqbFpqcUlPOUlDazlqb1ViRk9r?=
 =?utf-8?B?MjNpc3NBV21WRzgrMnlNekd4NnRkdTRHdzBTd2Fla2JqakcvSTVoY2d1U3ZK?=
 =?utf-8?B?SHF5aG40OWNhWk1HeXhtbkV0RmdvT1JBQWJLUVlJTE1oaVlRTzhXS1A0c3RP?=
 =?utf-8?B?ZytFcGhPMS9UZFB1dktPdTZNOHZqc2JyWU4wd0RQWFRHRmhia1RseEUyRUpF?=
 =?utf-8?B?aHZjNEkrSDMxbkJZaWU2TzAwL2RtL2l2bnNHZW5pNGNaNmpHVWpaOEwxb0or?=
 =?utf-8?B?eFZNZWVWYjhPOUZLdU5NOXl1QWFjdU9Ld0Y0eVh0L0d3TSs5ZTFpbm9WcFpt?=
 =?utf-8?B?NC9BdTdaVjlEYzF6bS9DTnhwKzJUZlYxYW52Wk93RmhEUHJuZjFjcWZPTkVz?=
 =?utf-8?B?YzNJSnFsNXJwNjFOaWQvTS9razZnZmhwY0dZeWlHM1o2YUg2SEF3b3pUZmVB?=
 =?utf-8?B?SHRjL3lMNlZDRVZlQTFrc2VtNFV6ZFZpcjhTaU9WTFg1RmsvK1VtemswUERu?=
 =?utf-8?B?QUJkNUV3V0RIVlpTRVVYQWFNcER4U2JybnFuTVRnZFRrSFQycHc5Ri93UTI1?=
 =?utf-8?B?RjZsekFiRE9qYnhVYVJZRDQwMFN2MUtFY0d5T0hGQXF1b3NiRGQzYTlRZjZ4?=
 =?utf-8?B?T0NnL2JLUWxKUmlnUmZpWnZyd1lDRGVOOUxubEdpUCt6T3VJS3BranBKQ0Fi?=
 =?utf-8?B?bkM2ejBMK284SzlmTnNpSlNrekp0NC8rSGorb2lyZGRKYVhtbXFGWVlOTWtV?=
 =?utf-8?Q?oxc4/OVt4eZzqdDbSVCZsi4nil+2n2C7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZlWUhiZGRXc2xNV3VzN0RjYnRuT3VESWpERVJ1NWJ6cnhBbUFGR1I5TVkv?=
 =?utf-8?B?UDRkZDZ0RUNidFBIRmI3SjkwVGJmb2hPeG5nOUZvVk1CNzZVd3haQm52ZHdC?=
 =?utf-8?B?WWZnV1p4WWRWamtZVWxaemtLdHdpYXVjVHh1bWFuWG4rV25mcktmSk9xUzlr?=
 =?utf-8?B?QXRQcUJVY2NRN0Y4UHlPVWFjS0dSVlMwVG9mVWJ6dmlnMVdjaUZZRG5PWXZo?=
 =?utf-8?B?OXpIbzVRK3FIcUVOeGZOb0RHdUJ4YmZkamZQcExRMm11YWVaYkpwckxuZ3hW?=
 =?utf-8?B?bVFJRlJWamlKZ1hJVHBLZzVDeXFJSVJ1ekkvaWtIVTl2ejQyOGhHZ2hreWpw?=
 =?utf-8?B?dzFtN1doUkpPVlB5cFovblJ2aEpjRStCeVB0KzZhZHZGVTdUNEtvZEVWZ0x5?=
 =?utf-8?B?YkxHY2c0NFRvT2VTVUNUMm1PUWJnWlFmcWVNYTEzOUpVV25wVEt6Njg1VExw?=
 =?utf-8?B?MVYyZGEwb1NmdlN2UUJzOEtJaTNTSFVocUtnR2xhcUVyT0lhaEpnSE1XZVRL?=
 =?utf-8?B?OVRtUzhJQmVYc0J4d29jcnYyZGgveGxsTlFpMXdPVTFQZDgyQ2txelNuNnha?=
 =?utf-8?B?SFIzWUpuV1dSNkxCdExyRkpBOWdLU0hzSlRsM1RyWVBJUmFuWDNHNVc2RXF0?=
 =?utf-8?B?VU84Tk82eUFLb3pWNmhPUlN5QlIyN1RSeHJPcmovTnMvcU9SRDZFV3AwOUgv?=
 =?utf-8?B?bzdvVFdSZ2lRNDdtVUJlWkNpMDZIem5QeGl0Z2ZZaEdRREVycFlPMEhYeWk2?=
 =?utf-8?B?ZkpxaG5TQkZDY1dlZ3gzRXpDMDR5ZnkxdCtOTXA5bXZCd1NLWjM3VWFkRTBw?=
 =?utf-8?B?L3dScjZMT2RHZmdxaG5nRlhveFhCd3hLOGtrdGF1TncyREpNQTNtVThobjVH?=
 =?utf-8?B?TWdNY0RBTTRqWW1WbkM2TkpkYU5PcTVYMndRNmZzQXpjblloVmx4b3oxRTVu?=
 =?utf-8?B?QmdncmFKOUdGZmZwaGtDRWUwaGJCK3c1K3lDQzlvZjQzQmZKNUdnM0ZKMVVw?=
 =?utf-8?B?MmZ4NENhYnFid2tlUFNIK1crSTdWZTdObU5XYlI2akxseVk3THRwZFhDTHk0?=
 =?utf-8?B?OUNKQkFmWERtTUd0bStCQXdHdzMyODh4V094WmNCYmlNM3hoY1F5QmlpWkxW?=
 =?utf-8?B?WGZ5ZCt5NVg1QnlBcjRiQzNQSS9wZTVQSW9ZV0JsS1BPSWd3MTlpRW9rMjE2?=
 =?utf-8?B?Vyt3bkVuMGRWV3U2WlBUZXI3Q1J3L2hFWlN3aTNXamV4TW1MSVRORlQrWHN6?=
 =?utf-8?B?cURPYldlU0tzM3NWME5lS2hkV085U2RIcVpUaTY0ekxHa0Nvdi9Ibk9lbnMr?=
 =?utf-8?B?Y29qQ2piZzFRSWRUajYxblpkdThORUlVNW85SmxsV2hwR2FZaG1kME5SSkNa?=
 =?utf-8?B?bjJiOGVVVkc3MGZ5ZS9xRHVNSHhMUlQ0QkJvNmJBZFllampsN2RPdTNqaEFY?=
 =?utf-8?B?VElIMXZZbE9aRTRSd1hIWmdZWmU4NVFmUlhDREtCMXJkYU94Sm5yd2N3SVJE?=
 =?utf-8?B?Vk1xREd5K0hqK3F2V2IxM3BwQXpWdXJPa2R2Q3kvSG9wbWxwVEVVa0hEYU1x?=
 =?utf-8?B?cEo5NitFNTQ4OUhycjRpbmsvSW5nbUZYako0MWhKV2pseWxQVGpvR3V1NUxX?=
 =?utf-8?B?ZVNuSE5jNVRocU54MUlDNTRKd2M1NXF0VGJFVjkyU0c5Rk8rdThaNHJOT1RL?=
 =?utf-8?B?RWNsVDFDeWxJTHkvUlJnbE1DcGlXQWRBWlQrSXRtTERwU0tzZU1VOW8xcXdK?=
 =?utf-8?B?UnZlcy80YWhqRWo0NzNOaUJZUXdpMXY3TGhRNVdubnJRdi9pZmx4V2NsaG44?=
 =?utf-8?B?aTBNaWQ2Q3p0OFNUSEpsMk1vZnBCci9FbC9CWFRkZmZ5Y00wSmN5MlQ3WjFL?=
 =?utf-8?B?RkJtUFlUeUYzcnlCMTd4N0RGUGUxVExMbkNUT09SQ09vVzU1VFVtVUU4b1I3?=
 =?utf-8?B?a3MxRWZwRm5ZVGNjU0dZR0ZDMzN5dVJnQWgrYzcrK2thRUw0QlRadDFCbWVr?=
 =?utf-8?B?eFczak0vbC9PZHZXNEtURVB3YVR0dS9hNjhvYWtYOU84ckZLY3grL2pnMlgz?=
 =?utf-8?B?L1BPdU02aXJGZzhvTkhuN2V6T0NzcGZuQzE2Y3BrSkVXUktOdmsyMWFZZnln?=
 =?utf-8?Q?Ec1r8pkWVu97+EfzP9yGsH9fy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A02FBD927F4463478A9E66A300A0CCE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf823f-755e-402f-e069-08dd56f38964
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:56:53.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSROxzN9fxfROETeSJQsD93nmoQF1w6kZ8s2Er+gNofMWr3UogXNcmkyRV2CguLHo5Y6sFyiyZHTsmnKQTZMaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8330

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIGEgbmV3
IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91dCB0aGUgZnVuY3Rpb25z
IHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0KPiBwcmVzZW50IG10a19o
ZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNpbmNlIHRoZSBwcm9iZSBm
bG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBhIGNvbW1vbg0KPiBwcm9i
ZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBkcml2ZXIncyAucHJvYmUo
KQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxpY2F0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvS2NvbmZpZyAgICAgICAgICAgfCAgMTEgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2hkbWkuYyAgICAgICAgfCA1NDIgKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMgfCA0MjYgKysrKysrKysrKysr
KysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5oIHwgMTg4
ICsrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgNjMzIGluc2VydGlvbnMoKyksIDUzNSBkZWxl
dGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2hkbWlfY29tbW9uLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9LY29uZmln
DQo+IGluZGV4IGU0N2RlYmQ2MDYxOS4uOTk0YjQ4YjgyZDQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvS2NvbmZpZw0KPiBAQCAtMzAsOSArMzAsMTggQEAgY29uZmlnIERSTV9NRURJQVRFS19E
UA0KPiAgICAgICAgIGhlbHANCj4gICAgICAgICAgIERSTS9LTVMgRGlzcGxheSBQb3J0IGRyaXZl
ciBmb3IgTWVkaWFUZWsgU29Dcy4NCj4gDQo+ICtjb25maWcgRFJNX01FRElBVEVLX0hETUlfQ09N
TU9ODQo+ICsgICAgICAgdHJpc3RhdGUNCj4gKyAgICAgICBkZXBlbmRzIG9uIERSTV9NRURJQVRF
Sw0KPiArICAgICAgIHNlbGVjdCBEUk1fRElTUExBWV9IRE1JX0hFTFBFUg0KPiArICAgICAgIHNl
bGVjdCBEUk1fRElTUExBWV9IRUxQRVINCj4gKyAgICAgICBzZWxlY3QgU05EX1NPQ19IRE1JX0NP
REVDIGlmIFNORF9TT0MNCj4gKyAgICAgICBoZWxwDQo+ICsgICAgICAgICBNZWRpYVRlayBTb0Mg
SERNSSBjb21tb24gbGlicmFyeQ0KPiArDQo+ICBjb25maWcgRFJNX01FRElBVEVLX0hETUkNCj4g
ICAgICAgICB0cmlzdGF0ZSAiRFJNIEhETUkgU3VwcG9ydCBmb3IgTWVkaWF0ZWsgU29DcyINCj4g
ICAgICAgICBkZXBlbmRzIG9uIERSTV9NRURJQVRFSw0KPiAtICAgICAgIHNlbGVjdCBTTkRfU09D
X0hETUlfQ09ERUMgaWYgU05EX1NPQw0KPiArICAgICAgIHNlbGVjdCBEUk1fTUVESUFURUtfSERN
SV9DT01NT04NCj4gICAgICAgICBoZWxwDQo+ICAgICAgICAgICBEUk0vS01TIEhETUkgZHJpdmVy
IGZvciBNZWRpYXRlayBTb0NzDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUNCj4gaW5kZXgg
NDNhZmQwYTI2ZDE0Li43OGNmMmQ0ZmM4NWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFr
ZWZpbGUNCj4gQEAgLTIxLDYgKzIxLDcgQEAgbWVkaWF0ZWstZHJtLXkgOj0gbXRrX2NydGMubyBc
DQo+IA0KPiAgb2JqLSQoQ09ORklHX0RSTV9NRURJQVRFSykgKz0gbWVkaWF0ZWstZHJtLm8NCj4g
DQo+ICtvYmotJChDT05GSUdfRFJNX01FRElBVEVLX0hETUlfQ09NTU9OKSArPSBtdGtfaGRtaV9j
b21tb24ubw0KDQpUaGUgd2hvbGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCkJ1dCBtYWtlIGNv
bW1vbiBwYXJ0IHRvIGEgbW9kdWxlIGxvb2tzIGEgbGl0dGxlIGJpdCBtb3JlIG1vZHVsYXJpemVk
Lg0KTGV0IHRoaW5ncyB0byBiZSBzaW1wbGUsIEkgd291bGQgbGlrZSB0aGUgd2hvbGUgTWVkaWFU
ZWsgaGRtaSBkcml2ZXIgYmUgYSBzaW5nbGUgbW9kdWxlLg0KRm9yIE1lZGlhVGVrIGRybSBkcml2
ZXIsIGl0IGlzIGFscmVhZHkgYnJva2VuIHRvIG1lZGlhdGVrLWRybSwgaGRtaSwgZHAgbW9kdWxl
cy4NCk1heWJlIHNvbWVkYXkgZHNpIG9yIGRwaSB3b3VsZCBiZSBicm9rZW4gdG8gbW9kdWxlcy4N
ClNvIEkgd291bGQgbGlrZSBoZG1pIHRvIGJlIGEgc2luZ2xlIG1vZHVsZSB3aGljaCBpbmNsdWRl
IHYxLCB2MiBhbmQgY29tbW9uIHBhcnQuDQpJZiBzb21lZGF5IHdlIG5lZWQgdG8gb3B0aW1pemUg
Y29kZSBzaXplLCB0aGVuIHNlbmQgcGF0Y2ggdG8gYnJlYWsgaGRtaSBtb2R1bGUuDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+ICBvYmotJChDT05GSUdfRFJNX01FRElBVEVLX0hETUkpICs9IG10a19jZWMu
bw0KPiAgb2JqLSQoQ09ORklHX0RSTV9NRURJQVRFS19IRE1JKSArPSBtdGtfaGRtaS5vDQo+ICBv
YmotJChDT05GSUdfRFJNX01FRElBVEVLX0hETUkpICs9IG10a19oZG1pX2RkYy5vDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+IA0KDQo=

