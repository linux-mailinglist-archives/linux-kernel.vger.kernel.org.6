Return-Path: <linux-kernel+bounces-431161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D69E3A20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047CBB35BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC71B6CFF;
	Wed,  4 Dec 2024 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BWoxSU1+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Nkg59rcV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77F1B4F21;
	Wed,  4 Dec 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314634; cv=fail; b=P6Y3P1BQowpMifBZb7bkmEX8+RoS/LYq0OYW/EFm5kO6Ms98SwSph0tm0IUejJnbJT1dRcUhVdBVzn8/zKPyF5GFVchV/PAtsTNWIbVO7s+FTonTdj+JMaLr86gs7utpHy5caaEKZTAHFbeNaQ8Yp2VzfEmOUR7xvVKabH3qNrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314634; c=relaxed/simple;
	bh=7xZGe1/Wncp1oNwanz/Fc8fhmWA5KoCVwiiRM3FDgSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blxFerGbUCpL384DBNjg6dhIK4yCgk0AAn6Fcx8VKnaSM5lGAfPc7cpO7qxwq6r86kSr4hLYfAiqARAQD2kpjSsuSaY4NM7lv9V9YuIY2J+D+s0XzkJV3swx2bLRUQhmIWoSKqWJ4el4n7uPZTZd+pfgEmF9C+RQgg/aOiz8ovA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BWoxSU1+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Nkg59rcV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ae2c651ab23911ef99858b75a2457dd9-20241204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7xZGe1/Wncp1oNwanz/Fc8fhmWA5KoCVwiiRM3FDgSQ=;
	b=BWoxSU1+SUkwzSlb0TUJ/y53sE90Db+SxMxVDaYDWnu8Dw6+M8jA1ZzqvK5R0t7ZkJkY33agLPAf/yo8myugQ6etrkGAoG/8Ri/tgBFg3c8Ik/msnJSOLHirl4KecBtajlwowou3MjWMlO6Qd9H0cjczpfogpkHTlkt9yWMYQZ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2160b5c6-31cc-4a9c-a2a2-8afaab8b4cef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5970ebf5-e524-4511-b681-7d630745cb54,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ae2c651ab23911ef99858b75a2457dd9-20241204
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 114257800; Wed, 04 Dec 2024 20:17:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Dec 2024 20:17:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Dec 2024 20:17:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtuV9DvcEGAryjF02bT0ivyn6OR4AW1dvO9TbiNLaATaxPpmIId/mI82EgsWotLTlY0PjfhGv/6aykGAMqkjLeF9J5ELlZ1FR9uTZpJxujWnqqPZ61iOTMEmhEnPXO3vjwLV3FOIhYfJkSYPeMd5W90+ElSSMiCQyuFkG3CXfOBuHx/6eP2VHnAjzbBMvBx6StoBjrg52p+Y7ajvNBNi5RxOdVgucFBrJEFkU879rcnoDqItx4HjdIxaTY7WF+j/cUcNovWmbF4rVlrReOTvHg3j5rBXd9BXT2Y1dzSYyPQaW2Uo0Eg2CBj9ozkab2yptlfo3RwZ3HIKCGU/0MuFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xZGe1/Wncp1oNwanz/Fc8fhmWA5KoCVwiiRM3FDgSQ=;
 b=mcvGt3loX02Ku4XhjGgCmFvfIi9Vi2RAKFRUzHgekd5FBra8pyYNJem5n3V/jPcQ0p4SRYJ1iYndVwaLyx0oGObNs9pGmkJQQBWN3LfkAwHNjTIQBpiYYcXLHkeOhi7iEo25ud3AMPR6oFBhOTwHxoXXYMd9SCI8iQ9P0uDe+7TreZMmCwf8n8Fl8g/75E9gApgTzxIcUSJOkwumNRjSU2fxPms6K1hUO6jIqygLdrxx1qW/JelV8jZgBjoQMTPc6TOs6MtZFrFAbhQHQPBVi/X5AOXjHQNY5wX7lhQIlIYdeOgRLMXo2e4Qj35d1LhcEpoenCkLlHzE4UY3G8U1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xZGe1/Wncp1oNwanz/Fc8fhmWA5KoCVwiiRM3FDgSQ=;
 b=Nkg59rcVWcRFb/R699vD+ZmWJ+HPkLa117Xp9QbU34FAowRImmIARrNgzMvt5krtkXxa4PbGn9uagQd4yUbgByHiiQ3yAJlCWaE9nMZErOPRhb7j43Op0x1tAEJI+an1LbiWZ1XS6tfGHyokyxZEpWhsufqTg2pGKsMHjljxk0c=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB8535.apcprd03.prod.outlook.com (2603:1096:405:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 12:17:01 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 12:17:01 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, Nicolas Prado <nfraprado@collabora.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Topic: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Index: AQHbRb9VohAiDdD8c0CabJesaGe9E7LWAVgA
Date: Wed, 4 Dec 2024 12:17:01 +0000
Message-ID: <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
In-Reply-To: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB8535:EE_
x-ms-office365-filtering-correlation-id: abfaf032-a846-4fe2-f2a3-08dd145d8e7d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0Z5U0QvYTkxTGhoZktyc0VsVUV6NW1FRnVNaTRKOHJ6RzM0ZjV4djFOeE1L?=
 =?utf-8?B?UnVNTmtTT2FIV3ZHRlRYNkdKZFo4QTl1ZzQ5SUtROGNrT3FuSUNJQVY4UGFs?=
 =?utf-8?B?amg4clZZSFIyRjRSKzV0Vk5QK29jckhQcmxxbjRHSFQ4L01TWHBnNTBDRjJE?=
 =?utf-8?B?bDJ5eG96TWhDN2JtOHNLYzgyZ1pTVWxqaWYvb1dteVc3TVd2T0liSFBaU2d6?=
 =?utf-8?B?dUwwWlVaQ1d2VmtrRHZENXVzUzZBemFzeUVOYU5kSTZGR0Z4NFg1WVVqRm5k?=
 =?utf-8?B?b0Rvd1FCYnllNVBYaHdOYmlHVkVBTnM1ZkpFZWpScVU0S2Fia09IUzlHOXRq?=
 =?utf-8?B?OUVrN2ViQjVxSWhUUUNWZ0VIMko3QzlSRWFTUUNTa1FyRkUxZmZCS0FZZHBC?=
 =?utf-8?B?SVBUQzZ5cVBvYmo5amJuMkpub0RueTVMOU0xWEFySjdIUHh0N2VXejJrTUdz?=
 =?utf-8?B?L2Q2WXVtdkdyczRqWFRXQUVKK2ZPeng0VG9LTVljTlNOdlBZNmRibHdCUzZU?=
 =?utf-8?B?Znp5OHFDcUNPVHQ2RC81RWF6clFlY3NIYVhHdDFFT0h3RC92Q0pRbHF2Rlhn?=
 =?utf-8?B?MENUbGV3VnlTUmU5dENvQVNrWFFHd1orTjFtSWFNMXIxTzZrcGM5ZURYNFV2?=
 =?utf-8?B?UkYwbXRWTXYwbWFLbUtkTnVHZzh1QUoxWGtIeXBjbnFrWnVnOHVjUUEyVVl0?=
 =?utf-8?B?SGFuRWp1NzhFU1J2VzFKYVpjd29rRmFORm1QRVpsditRSk80VjFyL0ppeFF3?=
 =?utf-8?B?cEtDQnV3ajZTSCsyV1lqYWdjNjVrK0VCdVB3bnczL3FieGhHekI5K2xqYkt1?=
 =?utf-8?B?Q28rV2ZFbVliMmNWcjZoT09FVzhwd2xtb29YdTFuKzdZS21nNjU3U0U5cnFT?=
 =?utf-8?B?SnhhZmR2bFA4NXFlYmpUZkx5V3J2MkFiVS9oVkphS3dkQ1cwM3FDWkpsa2tU?=
 =?utf-8?B?NGxWbTE3NWk0TXZYVXpDK0ljNWZFcE5pL0J3U2NpNlI1WDJjZmQrNHIzSXda?=
 =?utf-8?B?QUJIbkduVU5ad01sQ0pzZ3hqYStzS01uYjlWQXM0YTFPdjhiUkRBL1FmeEFt?=
 =?utf-8?B?UFpsei92YlJKUzFzUDRaTVNPU3pnbkgxUUtaWWEvMHpjRXNSS1RrMW9zUzhj?=
 =?utf-8?B?OE8vQlYxUU1kZHlLbzlVNkpTenB3eDZiVWxRcW94SzM5bldDczdyT2oyNkNr?=
 =?utf-8?B?T1I4Yy96Q3pYaW5IeU9MMStUVFRsVVBNVytwZ2VwQllHbDU4OS9hb1N5TnBK?=
 =?utf-8?B?b3ZiUnJuU0swMTVlN1dvcng2YWxLODlPWml6QVVQbzM5aW5OcThYNkVPQW1w?=
 =?utf-8?B?RXNZeEw4ZVBHd05hZnZNM3k5NDZRSUNrSnBRMUFMTUJWUVlYbUdEelZRV2l5?=
 =?utf-8?B?bk1ZNnNnS3ZnSUI1QXNRQ3dFZmRYTkJGcm1PUWNoWDFEMVErVmErNDFGVVl1?=
 =?utf-8?B?STFuSWZvNjBkbTdFTzFHSnZEWVlXL1pQVWYxNnFUa1BzcHc4cno1Y1FneUlX?=
 =?utf-8?B?ZDVOb3JLMjhmYmx3MHBBVnNvaStZNTgya0o0N2RYQnlaa0wrY2hzMTQxTkFI?=
 =?utf-8?B?ZUZzTGlRZXlxdU9BcWJJaDRRWmdrVHZLOUx3OEQ4cFZqTVVOVW5nZ3grZEtI?=
 =?utf-8?B?OVJ3ZEhUSUcxa3BpeEovNkQ5NTZUQUMyd0Vtc3VKWWxVNFpLNXVIR21XUnNB?=
 =?utf-8?B?V2FjT3Q4eWRMMm9jV015YlRqaVcwTEd1YUQxbkg2KzNsSExydjBKdnUyV1ll?=
 =?utf-8?B?UHlkZnQzQ1c0dHE5ZU4vajlxb05iRmlwNDNnTytJNFJGZU5BZlFSdlV2Mmpn?=
 =?utf-8?B?MENWdnI4dGtLbTZ5aHhzZEFPazZ0NmVONGZHK0grbmlwVVl2NHpVanhCSGt3?=
 =?utf-8?B?NmR5TkNEdEVXY1A2NTRTWUVjTEpsWnovTzFCOVlGeEd6Rmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEVmYkpGL1MzSHFtRExsMmJmU21LNnVCYWlvV0QzUEdEWUU5dktMaGFPanRu?=
 =?utf-8?B?NEJJSnp5S1ViNWdWRXVXWXhBcU9JR3U5akhwWnBqZ2QvN3lUaE56YTN0MHoy?=
 =?utf-8?B?Vk9HOHRhZWxlNHN5RDcwVkptMVc0cmkyRUJCMHRKdjR5SnBHQVV6bmJQb2k4?=
 =?utf-8?B?ZHZ0R0ptZ2lFT3ZKa2ZDSmNZNmdyYWhCQ29NK2twNzRlY3JudnljMlRIRzYy?=
 =?utf-8?B?YVFiMXlGYWl5aWYzT0xaUlNYUkV0ZVhPMFI5U3Q2UkxGOHhIYW4yU1hneGJ0?=
 =?utf-8?B?aGNVWjBmSWVEYm5ncG8yUzVhSVdmRzB3eFEvM1FFVWNySE5SMWFOMGZnYm9u?=
 =?utf-8?B?ZEJ0aCt4cDJlKzlpajFhdEs1b0ZvbXBXWG9Zd0F4bXYrY1FsZDZLRWQ2ZUpD?=
 =?utf-8?B?YU1GWU91akpZeVZoRDhPK3owL01oQnJFdmFYbkN1NVdoR09IS1lSdGdTSkVD?=
 =?utf-8?B?TDZ3VjdRcEVOVlJkLytBcFBoR2QvZG9RRmlaaXdWd01UU2xDdEw2WE4zQ0Nq?=
 =?utf-8?B?Lzl6TEN4YlVPc0hHTGo3QWgxQ2FnLzREVTlRa3pqdXZzYnJZN0xWWGI0QmVv?=
 =?utf-8?B?TUxpRW05UDNxc1RtdEtjWWdrRmxyOHdLME5YM1BhcGMzZjVhdys4aWp1T3Nk?=
 =?utf-8?B?eTFGWVpDb2NuV2RtUGhKUy83K3NKM25PMXVTWUhNaGIvV3QvU1lSbDc2alY4?=
 =?utf-8?B?VmhwUUtwYzBGa0dMeG9iSmpMVmZWay9heUppS0MyZjFKd1AwdzRCd0pFZVNJ?=
 =?utf-8?B?QWpBbTJ3RWx1OGRuOFlRUkMwTytxcGpEYU40M2FndHNrSkY0K3A4WWxZWmFJ?=
 =?utf-8?B?R1Z3a3dWTUt6YWVZWkY3cjNqR2dtYlp4bmdRU1BtemJqeDRtYm84SHRyMXFr?=
 =?utf-8?B?ZjJjdWRWa002NDAxbEJSa2xGMkpEeW9pYmtBMnpmczRWcVZTS1VkbEdUWkhj?=
 =?utf-8?B?a28wN29jTDYwWUYwQ05IdWNHR3B5SlJEYzlrWGF0VGxweDdDR29nWmFKNW1H?=
 =?utf-8?B?NmR6V2xnOUFjc2Y0d1h3UHpwOFloVEF3WE4wVU14QnFyODRERzgyTTVGOWZ3?=
 =?utf-8?B?cWVtR3Q1ZjBUb3Vod21FQlpxRm9zUlR6eE5QNG1yVG05ZW1KZFRTUkdXdGFU?=
 =?utf-8?B?OW5VSThmN1BDRCtPNXc3eXJ4cUVNTFVzUUU4ZDRCeGlkSUlmMSsvaG5pTkRJ?=
 =?utf-8?B?Vkt3ZjhVb0FwN01YNzdleWMvdHVBUDY4RUQ5bG5kQ1IvU0pCM0FkdERLcTds?=
 =?utf-8?B?WUIzWGM0elEzWU9iVVgxLzdFdjdpRndObE5zN2txeS9kWU4vcHVuUHlPVzZa?=
 =?utf-8?B?dXJKb2FJcUFObHBpQUE1dVlqQ2Z3ZThhUXVpeFN6ZkVXY1FTSlFacWlqTHVC?=
 =?utf-8?B?L0ZpUEVSUExIa09VVHptM0hUVFVKUmlSM2RWTmNEZHZJV2VBQjR3SnRDNUNZ?=
 =?utf-8?B?dUJMUmpIYjlFdzAxSEJaWko3L3Fsc1Zub0lWblF1UVljdG9IQ2llYWhpL3hX?=
 =?utf-8?B?STR2d2dpZjk4SDMxL3M3bXRvTGxGTEZxazBzQUpPUUVtUlc2Z2hIOFJSYXFa?=
 =?utf-8?B?Y3RzMjFtayt1ZElwcGpvaWZaZ3Y5VUw5ZGFCM0Y3bHFZVk5LOVpwUW4ybGlz?=
 =?utf-8?B?OG1wUjI4SmI3MC9FS2c2MGxDeUpGT3RPZ1dTRlc0d3pUQ3JYWE90aXpJYy9B?=
 =?utf-8?B?bUVSU1Z5bWtobWJwRGYyMDNPQ3BKWXhPTnRCOTh4U3c4cVZFM2czb3RsZEYw?=
 =?utf-8?B?eitQRlQvOEV6VTArTGpSeTJFYXpRZGsxS2QrNEdJaUcvaXRFY1RyOUVpUzJN?=
 =?utf-8?B?MExla2d5RlEydGNVUWF1YWZUcXpZV05oZEd2L1Y2SllKYlk1eTJDY25vYjFI?=
 =?utf-8?B?amxhUFRZLzZDd2NhZmFhQVphbVI4MlBSRTdZQkpSOUpUZFNBL0NsNDVJL3Rx?=
 =?utf-8?B?N0p4WGU3cTJBZlhZQ05uS3FsSExJWU5NNm1Ya2RmY21QZ1psc0ZlK2VWQk1T?=
 =?utf-8?B?czRDdE5HdWxUL3QwT0Z5dnVCdlRMQ2JyWlNMcXZNUGFHNG5NbnBIaTJNNWNM?=
 =?utf-8?B?SGNBalh6K0hGcll0NDVyaTZxTHBZTGc1cnBNN3pDd3k3Y0RZZzFmTXIvRHkx?=
 =?utf-8?B?QTRZTjcwMUFGcU5FZHc3TC9mamQyaG1Mc21LOVJaNEJtb1NjVnR3aUorU1Bk?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D7B8A59B2AF8046A98EBDF0D6451418@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfaf032-a846-4fe2-f2a3-08dd145d8e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 12:17:01.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heb33fGIYt2EcfXncgGNjA1HchXBVCAG0r3srFT/cFBf1CgjX4MfNleKGHybUVbrPvKtPuajf6VV/hWidmCMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8535
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.628700-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4ia1MaKuob8PC/ExpXrHizwBOMBsCslSyCQ5
	BpELg58DhGNB0waEVEUkG5+oba8+dPZomtZBUIXQTWuFDn5CUjQsCc2iFTIxrX7zXMne3nXu7fK
	xaM2xqkCgVtUBJhi867hXEYVAE0l4Ymoi4eoUtijDDmXNk+rLpUKzuF0egUUDu/jTz8Y/keq8KL
	DAbAhetbQs87SILJAaYsdjZJrbqMWH8Cgfv/I8cJ4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
	QCUU+jzjoczmuoPCq1mLLB7I88SFQpOjVQtwLai/3D3CASrUPb6afINuOix63wn959AYcNmUgC3
	1eH6OlePPQlK64O8GbEmbEgtPBz0AEVZO7kXBPlzloxQudlFT/XnUyc3kkvb4uuYo4M+pOhghix
	YhrO7v4iiSiO3Fb3zlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.628700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5A78E247F80A18F0D5FED23A4F513C19D9F237D1E73508C0850792DFC982BB142000:8
X-MTK: N

T24gVHVlLCAyMDI0LTEyLTAzIGF0IDE3OjA3IC0wMzAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCg0KPiANCj4gQ3VycmVudGx5LCBib290aW5nIHRoZSBHZW5pbyA3MDAgRVZLIGJv
YXJkIHdpdGggdGhlIE1UODE4OCBzb3VuZA0KPiBwbGF0Zm9ybSBkcml2ZXIgY29uZmlndXJlZCBh
cyBhIG1vZHVsZSAoQ09ORklHX1NORF9TT0NfTVQ4MTg4PW0pDQo+IHJlc3VsdHMNCj4gaW4gYSBz
eXN0ZW0gaGFuZyByaWdodCB3aGVuIHRoZSBIVyByZWdpc3RlcnMgZm9yIHRoZSBhdWRpbyBjb250
cm9sbGVyDQo+IGFyZSByZWFkOg0KPiANCj4gICBtdDgxODgtYXVkaW8gMTBiMTAwMDAuYXVkaW8t
Y29udHJvbGxlcjogTm8gY2FjaGUgZGVmYXVsdHMsIHJlYWRpbmcNCj4gYmFjayBmcm9tIEhXDQo+
IA0KPiBUaGUgaGFuZyBkb2Vzbid0IG9jY3VyIHdpdGggdGhlIGRyaXZlciBjb25maWd1cmVkIGFz
IGJ1aWx0aW4gYXMgdGhlbg0KPiB0aGUNCj4gdW51c2VkIGNsb2NrcyBhcmUgc3RpbGwgZW5hYmxl
ZC4NCj4gDQo+IEVuYWJsZSB0aGUgYXBsbDEgY2xvY2sgZHVyaW5nIHJlZ2lzdGVyIHJlYWQvd3Jp
dGUgdG8gcHJldmVudCB0aGUNCj4gaGFuZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE7DrWNvbGFz
IEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hZmUtY2xrLmMgfCA0ICsrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hZmUtY2xrLmMNCj4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsv
bXQ4MTg4L210ODE4OC1hZmUtY2xrLmMNCj4gaW5kZXgNCj4gZTY5YzFiYjJjYjIzOTU5NmRlZTUw
YjE2NmMyMDE5MmQ1NDA4YmUxMC4uZmI4Y2YyODZkZjNmMDJhYzA3NjUyOGI4OThmDQo+IGQwZDdh
NzA4ZWMxZWEgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4
LWFmZS1jbGsuYw0KPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hZmUt
Y2xrLmMNCj4gQEAgLTU4Nyw2ICs1ODcsOCBAQCBpbnQgbXQ4MTg4X2FmZV9lbmFibGVfcmVnX3J3
X2NsayhzdHJ1Y3QNCj4gbXRrX2Jhc2VfYWZlICphZmUpDQo+ICAgICAgICAgbXQ4MTg4X2FmZV9l
bmFibGVfY2xrKGFmZSwgYWZlX3ByaXYtDQo+ID5jbGtbTVQ4MTg4X0NMS19BVURfQTFTWVNfSFBd
KTsNCj4gICAgICAgICBtdDgxODhfYWZlX2VuYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPmNs
a1tNVDgxODhfQ0xLX0FVRF9BMVNZU10pOw0KPiANCj4gKyAgICAgICBtdDgxODhfYWZlX2VuYWJs
ZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPmNsa1tNVDgxODhfQ0xLX0FQTUlYRURfQVBMTDFdKTsN
Cj4gKw0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KSGkgTmljb2xhcywNCg0KSWYgSSB1bmRl
cnN0YW5kIGNvcnJlY3RseSwgQVBMTDEgc2hvdWxkIGJlIHRoZSBwYXJlbnQgY2xvY2sgb2YNCkFV
RF9BMVNZU19IUCBhbmQgQVVEX0ExU1lTLCBzbyBpdCBzaG91bGQgYmUgZW5hYmxlZCBhdXRvbWF0
aWNhbGx5IGJ5DQpDQ0YuDQoNCkknbSBub3Qgc3VyZSB3aHkgeW91IHJlc29sdmVkIHRoZSBoYW5n
IGlzc3VlIGFmdGVyIGVuYWJsaW5nIEFQTEwxLg0KQ291bGQgeW91IHNoYXJlIG1vcmUgZGV0YWls
cyBhYm91dCB0aGUgc29sdXRpb24/DQoNClRoYW5rcywNClRyZXZvcg0KDQo+IA0KPiBAQCAtNTk0
LDYgKzU5Niw4IEBAIGludCBtdDgxODhfYWZlX2Rpc2FibGVfcmVnX3J3X2NsayhzdHJ1Y3QNCj4g
bXRrX2Jhc2VfYWZlICphZmUpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IG10ODE4OF9hZmVfcHJp
dmF0ZSAqYWZlX3ByaXYgPSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+IA0KPiArICAgICAgIG10ODE4
OF9hZmVfZGlzYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPmNsa1tNVDgxODhfQ0xLX0FQTUlY
RURfQVBMTDFdKTsNCj4gKw0KPiAgICAgICAgIG10ODE4OF9hZmVfZGlzYWJsZV9jbGsoYWZlLCBh
ZmVfcHJpdi0NCj4gPmNsa1tNVDgxODhfQ0xLX0FVRF9BMVNZU10pOw0KPiAgICAgICAgIG10ODE4
OF9hZmVfZGlzYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPmNsa1tNVDgxODhfQ0xLX0FVRF9B
MVNZU19IUF0pOw0KPiAgICAgICAgIG10ODE4OF9hZmVfZGlzYWJsZV9jbGsoYWZlLCBhZmVfcHJp
di0NCj4gPmNsa1tNVDgxODhfQ0xLX0FVRF9BRkVdKTsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1p
dDogYjg1MmUxZTdhMDM4OWVkNjE2OGVmMWQzOGViMGJhZDcxYTZiMTFlOA0KPiBjaGFuZ2UtaWQ6
IDIwMjQxMjAzLW10ODE4OC1hZmUtZml4LWhhbmctZGlzYWJsZWQtYXBsbDEtY2xrLQ0KPiBiM2Mx
MTc4MmNiYWYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTsOtY29sYXMgRi4gUi4gQS4g
UHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiANCj4gDQo=

