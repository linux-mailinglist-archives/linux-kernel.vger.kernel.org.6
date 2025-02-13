Return-Path: <linux-kernel+bounces-512773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B43A33D97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9951633D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708D215F70;
	Thu, 13 Feb 2025 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NT5ASIjf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FPpRGOmv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCB2153E6;
	Thu, 13 Feb 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445345; cv=fail; b=uljz3+EL/NCzgvN7iW54oOTCUd3G+liP99BmnITw4fctcAMhuyvWMSqNxZOOlLkgLlPUhYbX8raEMS8ejo6a0SsDDFhMh36ppVqyg4QDaU68LPza+d/onIbh4UKGX2AjXoU39fR01Is2PEoWdI9hbhEC8ajXTREkDXco7BDNv00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445345; c=relaxed/simple;
	bh=SVEuNXxDhSXjzt7nWqWhPuKL0Xgg7/Ix6F/d6eb13rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNeXYGiFruVp/NVgG0SstsraZP/L459vds+29PVxzh9yJNyoHx3DlHu2RR0fvMy0KLx+h2FDJeSYZ5rMzrWInPUUEB+bBKi8cd1N81EMLJgbOa80DzJ72M/dT4gdGDVBCwyvKMrhAG0WLxALJ9E87ckFmqi9Xns9zkMzO81oaWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NT5ASIjf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FPpRGOmv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d8ad2c9ee9fb11efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SVEuNXxDhSXjzt7nWqWhPuKL0Xgg7/Ix6F/d6eb13rc=;
	b=NT5ASIjf4N4I883yasjqtahW7xd563RUUhQmURJMSdZHkbIlchfYSeK+M83/sBgL6nU1URNkc92Bp/YMSWIeUxe3eeSRIjZ/uLCZXsGEYDV5Kma7L+DGOGqTWiGGRAUBsZX219fl807KPW2hO3xbNfPbpgxHzZ0C+rXsbRtmxSs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4bfe22a7-4ee7-487b-a3d7-61b1fc4ef5a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:45b88427-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d8ad2c9ee9fb11efbd192953cf12861f-20250213
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1758236505; Thu, 13 Feb 2025 19:15:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 19:15:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 19:15:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgHNvBe21KGQBkbkBk5s8kVB9dUqxffzSliSkz+FTkcFWc4YxwiZOpHrGBgqfMYKYiT1xCbcJwTYMe2t4ed6Y/8dNABCVPRZtiOyAu5NNFVkQY3qCjT9EZxerCbJ3zTqKcnUBrx8WIu9WqJVReL5+0zDIdSvv9vVkdX0yEFfrNfOEmVsrlNU562J4vLNAKYAfZxCJlCaTww14sSJEaJgHQeTY0783AvG+cYP/eE3Rtyx7Ff5ihgP1xwYGP4Hl4M/x9XuxQ0pmFI6dSsn4zNQKsCjsE0jcDImHR2NkPpYEUK6unPEwfxskv7HZ4IZ8VZ7UkgWjgyF9P6B/03pRkQV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVEuNXxDhSXjzt7nWqWhPuKL0Xgg7/Ix6F/d6eb13rc=;
 b=qSeE5EBZ7mQDTdpcwvOcMWjKF3ASN1etZE8ABBsaOASkUeXBX5NYeT5yCNKqlSt+Cj0r11jPrcjviRPla4/SrdWJzQRVv8prWptq2+Q2iOcg6pTPEksjz1phEvXu7l8o6Ba5Qcchu1vcwv6NiFlGeYnmgN/97tAeNqV9D7oqiFWkZZM7XSn4Q1M1PsrX8XPghKyU3XYQ3UZWLwY6T/5yN5E7bSeSYjqCsVFgZ5dPKJ5unx6WBdkac+sfiKd6AnkDY3HO3bQkCdhO9d8SduDWstFMuCzHwX0t6Lu+rhiGMM0E6etOmnJcXPzPjDUnG7bNXEWVv/Z8XsBrjhEZ22J+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVEuNXxDhSXjzt7nWqWhPuKL0Xgg7/Ix6F/d6eb13rc=;
 b=FPpRGOmvsRERg9RHoE2jWNUIWu3oJ1l0ONDmcluLjLywsvDcHWWa4dXtOpw4rEzNEQ0K38wmnNSjxPD0qVEEcm1qZWfdKpKuWHCL9c8qpjyuEoXqIH1iNtEgdF0tAmcWG9i14p3Q+xpyJA5vGasNm+kGnmBPx7dLzfVEdQqWFJk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6488.apcprd03.prod.outlook.com (2603:1096:4:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 11:15:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 11:15:30 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "kernel@collabora.com" <kernel@collabora.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	=?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	=?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?= <Ives.Chenjh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v6 25/42] drm/mediatek: mtk_hdmi: Move CEC device parsing
 in new function
Thread-Topic: [PATCH v6 25/42] drm/mediatek: mtk_hdmi: Move CEC device parsing
 in new function
Thread-Index: AQHbfHpGTW2g3zxBEU2QXgoaf2WDibNE3JSAgAAwQ4CAAAtiAA==
Date: Thu, 13 Feb 2025 11:15:30 +0000
Message-ID: <1293073731db05a60e98724dbbe1bbca3bc9973c.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-26-angelogioacchino.delregno@collabora.com>
	 <0e164efeaa3cde827293bfed001d7a2c5fbb56fc.camel@mediatek.com>
	 <d7ca076e-4359-4e1e-a700-820198388a66@collabora.com>
In-Reply-To: <d7ca076e-4359-4e1e-a700-820198388a66@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6488:EE_
x-ms-office365-filtering-correlation-id: aad4baa2-7908-4a5b-f4d6-08dd4c1fba37
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Rkh4L3FYMFN5U01wY1pUeG96REZBaUZuNmZveXBiT1BkdUtDeUF3OVhUN0Rx?=
 =?utf-8?B?Q3VUY0xHRmxKZUNjQ3J0SHFQQnlmZTNvcHhLcEZqd2FwMnBZakRPb0FZVnVI?=
 =?utf-8?B?OG55ZjQzWmIzY2VUb09hbnd0V2FDeDFtUVA3Q01US0V1ZkRGWVF2UnJNMjZV?=
 =?utf-8?B?TGNOMHVXRnRKT1l5R05yVDFkSXVSeHNqb0NDNmxHVGhKUFBhSUZVUXFXSDlD?=
 =?utf-8?B?WE1kdkVINUpOQllOK3dxNVhWYll0TlZUVUVsd1FTaVBhbkx5NDdHVjdQSFV6?=
 =?utf-8?B?TFZJZkMwcjRNWWs0NGFJSkFINW9vUjMwbUpUV05MU3dUUnNncWxmcG9jaWVr?=
 =?utf-8?B?RUltTVJDaWVlSWVNdnV0L3hhWmlLNXFZaEhwUTUwaGJ0WkkrUGVHVWFpZmow?=
 =?utf-8?B?SmlKcmlXUmcreklmS2Mzc3hhREVGbXF0TzdEWWh3N3BmY0l0MGUwNUJ2R0Vr?=
 =?utf-8?B?T0FoYmlYTE8xOEUrTFZBR3ZLTTFtSDR5Y29Vd2QrMksyUDNMRlZJd0lEMTVO?=
 =?utf-8?B?eDViYldRVUNFK3NNWmVydVhvTFRBWHhSeFNQeTVtMk9QU1ZIVlU1K2Y1RFA1?=
 =?utf-8?B?UlowN3RpMmJlalcvZDMyU3JaZW9TcENNSWM5a1VVM1AxQjBBbTdEVXJuYWlM?=
 =?utf-8?B?ZjB2NWhZOW1xVUV5Njd1VmlvVkQwSU1hK3A4WHJwWVN4Qkd2SW9sZDI0czJE?=
 =?utf-8?B?eXVOajBJQ0hnNGN1VnI1UlEzdmI5bVp6ZWt2SVV0bVdBMXFDTjE4V0NaVzhX?=
 =?utf-8?B?dWZCamQvZlNOaFBaSmtEeXBiR0d1T3pmSWdJc09lQWxqOFNydlljdm1mNkNB?=
 =?utf-8?B?Vytpc1JvUVN5L3RjbEhJQzJBREVlSVBqckdxZ0k1QmMvL3p6K25tcG9vYXV5?=
 =?utf-8?B?bG90Q2wwcGRuMFYxWElnbTh1U2UzTGNBK2cvVEN5QlpwRDVCdStKSytNNFpN?=
 =?utf-8?B?QlduOVN4NzNEODhxdjRaWVpaVUNjN1hnanpDU3djbHZ2RXhFMlhlOHJtdUQz?=
 =?utf-8?B?dFg1NVp2dThYTjZiaDZSWklhS1FkWFFDaDBmMndqcEhraFExT0lVcHJEVjRI?=
 =?utf-8?B?c1hsa0ZPQkQvVVpSME5nVkJCalhMVDQ3K25wQ29QOXMraFM1N29tOTNNWm9q?=
 =?utf-8?B?djlCZE44TEQzZ0hmc09ONDRObEovV3hQZ1Y3ZndwekZlaGxkVGJ1VVBZL3pq?=
 =?utf-8?B?MVhNWCtxczM0b2VWVVlSeXdtcWw0ekNqYlBWWlFCRllTRXNmdUI2b1ZDNnBH?=
 =?utf-8?B?MXJjR3VYM0dCY3ZtUnBRM0JaRS9zdy9vaXMwQlVmVmtUMEMzWklzZXltc3RK?=
 =?utf-8?B?UGt0YUN1NGZXS1lsTm5ZTHE5Y0ZnZ3hod2pSUW43VjhhNjk0cnRoRjRST3NV?=
 =?utf-8?B?SWp0UnIwR3VJWEMrVkREQW9PakRORjNkWGZlSE0vMXREMlFvTExoZVE0TVZN?=
 =?utf-8?B?ckxUU0w3dXlHQmJxVmFZT3QzVnpSTTkzaVpjRlo2WGszZnhwbEFVWDlqSzVq?=
 =?utf-8?B?aDREMmxwdFNLR0lXWlRmMUhzTnBSaHBiMGVkYUtDczVzclhsUGhudnBKcmRE?=
 =?utf-8?B?SmxKY1ppS3U4UDBobzlnWFNET2tEZE94c01YWFFFemxMSnozbnhnVU1UK0Q1?=
 =?utf-8?B?VjF5d1IvVzBJZC8rOXpUMnRRK0tIUXgwRThCTHZ6MzdmVk1UMlpQU0V6emow?=
 =?utf-8?B?WkpEeWZuM05DMFJvdWNMcHZ4Qkp4Y1UvOG1mQ1pQRzdOVWpXRzQvUVV1YVZQ?=
 =?utf-8?B?a1RZWXBOQ3FwOENBc1JGdWFVQkk1Q0s1bmJ3REVzbTJDWEY1UXN6eVRGcXhN?=
 =?utf-8?B?YWVSWEhPUkRtYXAxUEFuMTFVYjRpcHFyYU5zbGx2b1Y2S00vd3JydGo1b1FP?=
 =?utf-8?B?NC95RWxzQ2pBU2FiQWVxVjhxb1RjRERoZFBSbi9CUE5OTVN4U3R5TVN0d01H?=
 =?utf-8?Q?0+qIYZpDjj+Z+l95pzKXLnnBl6/xN78+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHh5V3ZsNVBLTXdKYytoQXhycW5mcUdETGJVbWpnOFJSb0RjUkRXejhnQ0dE?=
 =?utf-8?B?WVFCTDRET3cxeGk2N3RnTkM1NFU0T0sxUmtveWJLTmYwc0NiaWF6ZzhnbHJY?=
 =?utf-8?B?TWx1a1BGZmtqL1FtdW1zazZicDFuK3EyTE12ekFWVVowc0JTSkNLcnN0K2JD?=
 =?utf-8?B?cThaMHR6RGNOSHMxR1RaL3dBRS9vWWNYQU93UTlWKzBzRWdzeSs0eVVCeVpm?=
 =?utf-8?B?dmd1M1RqaVcyK2cvOUVZdTRCK2RTZkMwanRvd2ZZOG1jYkVQWjIrU0ExK0ho?=
 =?utf-8?B?RzhmWkhtbUJOVUdacTJGV3dNUG1DVkhadm9EZlVWVjRBM0MxVVA1TVFPdHhJ?=
 =?utf-8?B?VlhoSHhoREhSUXV0TGRSbzljODhBQVdWdFlNakp6NzhBK3gxcFdjblhFQk52?=
 =?utf-8?B?T1cxdlRwaWNTam5SV2UwM2p2TTdDQUxzM215MW40Q0tEYlVtWUpEcCsrcm5j?=
 =?utf-8?B?anh3bG45SldZc0Q3WG5FeHoydE1wYUhWWk9KNE5abEdHNmtFNjh2MVNET3JY?=
 =?utf-8?B?UkdPaERXZ2MxaGNNWWdJNlllVHc2eDg2L0JVTERTTWFCNC95dmhVSE9QRlRD?=
 =?utf-8?B?SkRrRmFBL2NsZW5wZkxXT0h1OWxLMGFieFpURFh4TktlRU9BZ0oxWUYvMGho?=
 =?utf-8?B?YUJjVmdnbWpreFRzNlhmYzdBRnIvU3dudm1kWTN6V1Uvd1pBYzdOa0wvZDlV?=
 =?utf-8?B?cFd3bUlmTFBnNnpoaTVyaHRkTndDbi9nNUNLRjEybmlLdnl2S0JaTVdtMDNs?=
 =?utf-8?B?ZDg5Y1JQSkFvTGtldFlBUXdYdm9kUHFRTmY5L0tqQi95L0hlZWN4eUIydjRF?=
 =?utf-8?B?Syt0ZW0rYkt6RU54L0JGWWhkWkNWR0hMemVJaDBYUUtka2pleEliY3VsMTND?=
 =?utf-8?B?MjY0NitiUmRYalE1ajZyZUtVVjZ5bjd2TmQzY09Uc0Z3YlVyOXc2N3l0OThv?=
 =?utf-8?B?aTFvOTRSS25wUDg3NWl3YitxZVdkMEh2MkUraDJaSXorSVY5dGdrQXpoaTZr?=
 =?utf-8?B?dUV4MjNFR1h6enBINHhSV2lDY0dBZnJHR2FJMEcrdHgxb3JBd08vL211aVJC?=
 =?utf-8?B?QW5SN3VMeWxLQXhEVUNlQjZMVUhHL3RrTDdEMG1VUWpqOTlaNVY5VkR4TzMr?=
 =?utf-8?B?L3NJek9kaGEwc0ZFdE5ZRFkyd3BuK1VwaVNjS21RUWlGbEpzamxPOFBqNDI1?=
 =?utf-8?B?QUxvd0o5RW5ObW4yT3MwM0tjcTQ4MXZLVlNLZ2VFTk4wMlhERXk2OEI3VUZJ?=
 =?utf-8?B?R0o0VExxOGVocVpDKytMbGFvM3JQRjVDcExwdm9OaldqOFZCZW5KYmVKa0NJ?=
 =?utf-8?B?SVJ0VmZLdFVrWlQ2dHZZcnJNOGxWWXZoVSsxMW8rQW0vU2ZqQk1WK3hlQzhJ?=
 =?utf-8?B?NUpIaG13NVBtRHpoK1pkK0paRXRrVmYvYWxQbVU5LzlNUXpiUGpXQmsyUDdU?=
 =?utf-8?B?NTZsSm40NlJqS05za1IzQlpPcjJrcDA3NlVKdWI3OUNNOUZkek9lUENnUHNS?=
 =?utf-8?B?b01aejVPVFlVRGZGTE9VZnJ4QXBlZDZHbzNnTHIvRXB2c3J0N0kwL2pOZ0RK?=
 =?utf-8?B?Q1U0VlhPRUtZQTFhUXRIaWQ4b0VxZC9pc3lpVjlPdFc2emttMExDSVNGNHZQ?=
 =?utf-8?B?bmsyeW9vK2NwNFZNV2dTUWMxM1hMZDY0SmZoTEdONjhqSjNZdTRDVWJWaGh1?=
 =?utf-8?B?bllrNVYrTDRqeEpPWjAyemVxUnc4VTdMTGlKOTUrODViT1NZZ1FmR3dLMFIx?=
 =?utf-8?B?bldjL1YzQ29FTlN1bTZBY005YVRLK2FDb2hlZS9WNE5mYSswZWFiS2J6a1lI?=
 =?utf-8?B?dHE3bE50UWZYeFBSenRlNlR1TTlESUg1ZXFvZDR6OHJRZEF4c25uR1NJYVdQ?=
 =?utf-8?B?bTRONjN0L0VQaHVXUDdHaExYd3MyMTNLcmthcllhdVFERnRGSXFKUytZWTdv?=
 =?utf-8?B?VEttWFR2bzYxSU43WmhBSFdyWkhsanhTY2JOQmYwTkZLTXJrL0JSbWd2eFRF?=
 =?utf-8?B?MnQvT0NxbXBxVHdtdEVSWDlQc0hzcjlDMkVtckxBVXlpR25LOHRMZmRESnEv?=
 =?utf-8?B?RmdNYlE1R2QvL3NUNmRDc3V4aDlWZ1RrUzZLNjE0NmV2blBnRVc1cGxsM3BG?=
 =?utf-8?Q?aneqYDBSN0osv9B0lI8qlmY65?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B813CFE166774480623B36DAD7DE6C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad4baa2-7908-4a5b-f4d6-08dd4c1fba37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 11:15:30.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6cOYKEqdqqgRPrGdC+NW6Y83GihHomatpYIgjHWxnWEtZkparwtRxXRb20849jdBZBL+bCdKixeKTHUR577tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6488

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDExOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxMy8wMi8yNSAwODo0MiwgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBPbiBUdWUsIDIwMjUtMDItMTEgYXQgMTI6MzMgKzAxMDAs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBNb3ZlIHRoZSBDRUMgZGV2aWNlIHBhcnNpbmcgbG9naWMgdG8gYSBuZXcgZnVuY3Rp
b24gY2FsbGVkDQo+ID4gPiBtdGtfaGRtaV9nZXRfY2VjX2RldigpLCBhbmQgbW92ZSB0aGUgcGFy
c2luZyBhY3Rpb24gdG8gdGhlIGVuZA0KPiA+ID4gb2YgbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEo
KSwgYWxsb3dpbmcgdG8gcmVtb3ZlIGdvdG9zIGluIHRoaXMNCj4gPiA+IGZ1bmN0aW9uLCByZWR1
Y2luZyBjb2RlIHNpemUgYW5kIGltcHJvdmluZyByZWFkYWJpbGl0eS4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyB8IDgyICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlv
bnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gPiA+
IGluZGV4IDYxNDBiNTVjMjgzMC4uMDNiNTY1ODhmYzdkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+ID4gPiBAQCAtMTM2NywyMCArMTM2NywxMiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgbXRrX2hkbWlfYnJpZGdlX2Z1bmNz
ID0gew0KPiA+ID4gICAgICAgICAgLmVkaWRfcmVhZCA9IG10a19oZG1pX2JyaWRnZV9lZGlkX3Jl
YWQsDQo+ID4gPiAgIH07DQo+ID4gPiANCj4gPiA+IC1zdGF0aWMgaW50IG10a19oZG1pX2R0X3Bh
cnNlX3BkYXRhKHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwNCj4gPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ICtz
dGF0aWMgaW50IG10a19oZG1pX2dldF9jZWNfZGV2KHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwgc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiA+ID4gICB7DQo+ID4g
PiAtICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gPiAtICAgICAg
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+ID4gPiAtICAgICAgIHN0
cnVjdCBkZXZpY2Vfbm9kZSAqcmVtb3RlLCAqaTJjX25wOw0KPiA+ID4gICAgICAgICAgc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqY2VjX3BkZXY7DQo+ID4gPiAtICAgICAgIHN0cnVjdCByZWdtYXAg
KnJlZ21hcDsNCj4gPiA+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpjZWNfbnA7DQo+ID4g
PiAgICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gDQo+ID4gPiAtICAgICAgIHJldCA9IG10a19oZG1p
X2dldF9hbGxfY2xrKGhkbWksIG5wKTsNCj4gPiA+IC0gICAgICAgaWYgKHJldCkNCj4gPiA+IC0g
ICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBn
ZXQgY2xvY2tzXG4iKTsNCj4gPiA+IC0NCj4gPiA+ICAgICAgICAgIC8qIFRoZSBDRUMgbW9kdWxl
IGhhbmRsZXMgSERNSSBob3RwbHVnIGRldGVjdGlvbiAqLw0KPiA+ID4gICAgICAgICAgY2VjX25w
ID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQobnAtPnBhcmVudCwgIm1lZGlhdGVrLG10ODE3My1j
ZWMiKTsNCj4gPiA+ICAgICAgICAgIGlmICghY2VjX25wKQ0KPiA+ID4gQEAgLTEzOTQsNjUgKzEz
ODYsNjkgQEAgc3RhdGljIGludCBtdGtfaGRtaV9kdF9wYXJzZV9wZGF0YShzdHJ1Y3QgbXRrX2hk
bWkgKmhkbWksDQo+ID4gPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRVBST0JFX0RFRkVSOw0K
PiA+ID4gICAgICAgICAgfQ0KPiA+ID4gICAgICAgICAgb2Zfbm9kZV9wdXQoY2VjX25wKTsNCj4g
PiA+IC0gICAgICAgaGRtaS0+Y2VjX2RldiA9ICZjZWNfcGRldi0+ZGV2Ow0KPiA+ID4gDQo+ID4g
PiAgICAgICAgICAvKg0KPiA+ID4gICAgICAgICAgICogVGhlIG1lZGlhdGVrLHN5c2Nvbi1oZG1p
IHByb3BlcnR5IGNvbnRhaW5zIGEgcGhhbmRsZSBsaW5rIHRvIHRoZQ0KPiA+ID4gICAgICAgICAg
ICogTU1TWVNfQ09ORklHIGRldmljZSBhbmQgdGhlIHJlZ2lzdGVyIG9mZnNldCBvZiB0aGUgSERN
SV9TWVNfQ0ZHDQo+ID4gPiAgICAgICAgICAgKiByZWdpc3RlcnMgaXQgY29udGFpbnMuDQo+ID4g
PiAgICAgICAgICAgKi8NCj4gPiA+IC0gICAgICAgcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29r
dXBfYnlfcGhhbmRsZShucCwgIm1lZGlhdGVrLHN5c2Nvbi1oZG1pIik7DQo+ID4gPiAtICAgICAg
IHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KG5wLCAibWVkaWF0ZWssc3lzY29uLWhk
bWkiLCAxLA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
aGRtaS0+c3lzX29mZnNldCk7DQo+ID4gPiAtICAgICAgIGlmIChJU19FUlIocmVnbWFwKSkNCj4g
PiA+IC0gICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHJlZ21hcCk7DQo+ID4gPiAtICAgICAg
IGlmIChyZXQpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICBkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byBnZXQgc3lz
dGVtIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzXG4iKTsNCj4gPiA+IC0gICAgICAgICAgICAgICBn
b3RvIHB1dF9kZXZpY2U7DQo+ID4gPiAtICAgICAgIH0NCj4gPiA+IC0gICAgICAgaGRtaS0+c3lz
X3JlZ21hcCA9IHJlZ21hcDsNCj4gPiA+ICsgICAgICAgaGRtaS0+c3lzX3JlZ21hcCA9IHN5c2Nv
bl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsICJtZWRpYXRlayxzeXNjb24taGRtaSIpOw0K
PiA+ID4gKyAgICAgICBpZiAoSVNfRVJSKGhkbWktPnN5c19yZWdtYXApKQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhkbWktPnN5c19yZWdtYXApOw0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgICByZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChucCwgIm1lZGlhdGVr
LHN5c2Nvbi1oZG1pIiwgMSwgJmhkbWktPnN5c19vZmZzZXQpOw0KPiA+ID4gKyAgICAgICBpZiAo
cmV0KQ0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8g
Z2V0IHN5c3RlbSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyc1xuIik7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgIGhkbWktPmNlY19kZXYgPSAmY2VjX3BkZXYtPmRldjsNCj4gPiA+ICsgICAgICAgcmV0
dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgbXRrX2hkbWlfZHRf
cGFyc2VfcGRhdGEoc3RydWN0IG10a19oZG1pICpoZG1pLA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4g
K3sNCj4gPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+
ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCj4gPiA+ICsg
ICAgICAgc3RydWN0IGRldmljZV9ub2RlICpyZW1vdGUsICppMmNfbnA7DQo+ID4gPiArICAgICAg
IGludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJldCA9IG10a19oZG1pX2dldF9hbGxf
Y2xrKGhkbWksIG5wKTsNCj4gPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBnZXQgY2xvY2tz
XG4iKTsNCj4gPiA+IA0KPiA+ID4gICAgICAgICAgaGRtaS0+cmVncyA9IGRldmljZV9ub2RlX3Rv
X3JlZ21hcChkZXYtPm9mX25vZGUpOw0KPiA+ID4gLSAgICAgICBpZiAoSVNfRVJSKGhkbWktPnJl
Z3MpKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihoZG1pLT5yZWdzKTsN
Cj4gPiA+IC0gICAgICAgICAgICAgICBnb3RvIHB1dF9kZXZpY2U7DQo+ID4gPiAtICAgICAgIH0N
Cj4gPiA+ICsgICAgICAgaWYgKElTX0VSUihoZG1pLT5yZWdzKSkNCj4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gUFRSX0VSUihoZG1pLT5yZWdzKTsNCj4gPiA+IA0KPiA+ID4gICAgICAgICAg
cmVtb3RlID0gb2ZfZ3JhcGhfZ2V0X3JlbW90ZV9ub2RlKG5wLCAxLCAwKTsNCj4gPiA+IC0gICAg
ICAgaWYgKCFyZW1vdGUpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0K
PiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gcHV0X2RldmljZTsNCj4gPiA+IC0gICAgICAgfQ0K
PiA+ID4gKyAgICAgICBpZiAoIXJlbW90ZSkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPiA+IA0KPiA+ID4gICAgICAgICAgaWYgKCFvZl9kZXZpY2VfaXNfY29tcGF0
aWJsZShyZW1vdGUsICJoZG1pLWNvbm5lY3RvciIpKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAg
IGhkbWktPm5leHRfYnJpZGdlID0gb2ZfZHJtX2ZpbmRfYnJpZGdlKHJlbW90ZSk7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgIGlmICghaGRtaS0+bmV4dF9icmlkZ2UpIHsNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIldhaXRpbmcgZm9yIGV4dGVybmFsIGJyaWRn
ZVxuIik7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQocmVtb3Rl
KTsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FUFJPQkVfREVGRVI7DQo+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHB1dF9kZXZpY2U7DQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgfQ0KPiA+ID4gICAgICAgICAgfQ0KPiA+ID4gDQo+ID4gPiAgICAgICAgICBpMmNf
bnAgPSBvZl9wYXJzZV9waGFuZGxlKHJlbW90ZSwgImRkYy1pMmMtYnVzIiwgMCk7DQo+ID4gPiAg
ICAgICAgICBvZl9ub2RlX3B1dChyZW1vdGUpOw0KPiA+ID4gLSAgICAgICBpZiAoIWkyY19ucCkg
ew0KPiA+ID4gLSAgICAgICAgICAgICAgIHJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFM
LCAiTm8gZGRjLWkyYy1idXMgaW4gY29ubmVjdG9yXG4iKTsNCj4gPiA+IC0gICAgICAgICAgICAg
ICBnb3RvIHB1dF9kZXZpY2U7DQo+ID4gPiAtICAgICAgIH0NCj4gPiA+ICsgICAgICAgaWYgKCFp
MmNfbnApDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAt
RUlOVkFMLCAiTm8gZGRjLWkyYy1idXMgaW4gY29ubmVjdG9yXG4iKTsNCj4gPiA+IA0KPiA+ID4g
ICAgICAgICAgaGRtaS0+ZGRjX2FkcHQgPSBvZl9maW5kX2kyY19hZGFwdGVyX2J5X25vZGUoaTJj
X25wKTsNCj4gPiA+ICAgICAgICAgIG9mX25vZGVfcHV0KGkyY19ucCk7DQo+ID4gPiAtICAgICAg
IGlmICghaGRtaS0+ZGRjX2FkcHQpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICByZXQgPSBkZXZf
ZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIkZhaWxlZCB0byBnZXQgZGRjIGkyYyBhZGFwdGVyIGJ5
IG5vZGVcbiIpOw0KPiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gcHV0X2RldmljZTsNCj4gPiA+
IC0gICAgICAgfQ0KPiA+ID4gKyAgICAgICBpZiAoIWhkbWktPmRkY19hZHB0KQ0KPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIkZhaWxlZCB0
byBnZXQgZGRjIGkyYyBhZGFwdGVyIGJ5IG5vZGVcbiIpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAg
ICByZXQgPSBtdGtfaGRtaV9nZXRfY2VjX2RldihoZG1pLCBkZXYsIG5wKTsNCj4gPiA+ICsgICAg
ICAgaWYgKHJldCkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gDQo+
ID4gPiAgICAgICAgICByZXR1cm4gMDsNCj4gPiANCj4gPiByZXR1cm4gbXRrX2hkbWlfZ2V0X2Nl
Y19kZXYoaGRtaSwgZGV2LCBucCk7DQo+ID4gDQo+ID4gb3INCj4gPiANCj4gPiByZXQgPSBtdGtf
aGRtaV9nZXRfY2VjX2RldihoZG1pLCBkZXYsIG5wKTsNCj4gPiANCj4gPiByZXR1cm4gcmV0Ow0K
PiA+IA0KPiA+IEFmdGVyIHRoaXMsDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+IA0KPiBDYW4gd2UgcGxlYXNlIGF2b2lkIHRoaXMgY2hh
bmdlPw0KPiANCj4gVGhhdCdzIGRvbmUgc28gdGhhdCBhbnkgYWRkaXRpb24gdG8gdGhlIGVuZCBv
ZiB0aGUgZnVuY3Rpb24gcHJvZHVjZXMgYSBzbWFsbGVyIGRpZmYNCj4gYW5kIGZvciByZXR1cm4g
dmFsdWUgcmVhZGFiaWxpdHkuDQoNCk9LLA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gVGhhbmtzLA0KPiBBbmdlbG8NCj4gDQo+ID4gPiAtcHV0X2Rl
dmljZToNCj4gPiA+IC0gICAgICAgcHV0X2RldmljZShoZG1pLT5jZWNfZGV2KTsNCj4gPiA+IC0g
ICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICAgfQ0KPiA+ID4gDQo+ID4gPiAgIC8qDQo+ID4gPiAt
LQ0KPiA+ID4gMi40OC4xDQo+ID4gPiANCj4gPiANCj4gDQoNCg==

