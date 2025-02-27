Return-Path: <linux-kernel+bounces-535814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81BA47791
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF6189039E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F621CC73;
	Thu, 27 Feb 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V3QyaaGI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tqetJOgu"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D84A59;
	Thu, 27 Feb 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644270; cv=fail; b=V0CEuVVEkptSU+kNZVSJtaTzgNmoMFYkFG87XdfCaL8Xd7LbTGSzj6NXp+0JqLiAIXUrlfHyNx/fFlMWSyWs6/KZkvaaw3r6jAlXbbcPW1pKaUVooTa8MuR08bl+1dW9v3IBRNG1MWhyUnZWYBFzOeeHdKjxH62FVrApXBhxrQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644270; c=relaxed/simple;
	bh=ji9HsPU9ErwEL5UMGEI4YM1TcauNO75Ppf01eKZ0JHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7YQxInjlG52u+m3QcEFd90DIJkedXVmXSY9mN2/oO1ErEiCvCQUmtRDgstSiuk6+tmDKQ+mBt7LsKLkGIDcX4Jnt/ocQBBX6yXLGgK5Mf4wRz8axjrE1cMRqB2+YHdvI+dkpjnND7uyJQKyGxQl0CHMvh29WFGh8VjOxV/YmlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V3QyaaGI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tqetJOgu; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ad9e5faf4e311efaae1fd9735fae912-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ji9HsPU9ErwEL5UMGEI4YM1TcauNO75Ppf01eKZ0JHs=;
	b=V3QyaaGINxw2I2vMGGw9b5bP3U4CPfuWqpFbWekl2yyNUxGVHYjM6n/Skb6AW8FwhCOtbt2bcCoxVjqa5oEIjEGIkGmjv6HX1ca1j20PN/A2/Ntiih6uvCZgxrejp+j2sS7iPjNSHrKkT2wNcDeJ+g14ziu5UOVqFfisxZ4Yckg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3face204-1faf-412d-8d0d-040a35f6e017,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:58f35229-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ad9e5faf4e311efaae1fd9735fae912-20250227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 253237030; Thu, 27 Feb 2025 16:17:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 16:17:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 16:17:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tihfGoHYCl3CzBb3nm+0vnec7zGrSMZNyziekbyaYI8SHM7xd1GZ4v0hwot8SRp6b5f1XYO+m/4nM+vKAWsO3YgZpziXhZZuyamdRIdy9moa9iGrS+8I/upmPO4dVYy4SdJ470sRalDdH21Po7UOR8KqRy4aLcjzGggmy8vEGXzhpvtkWwydv0dv96mV7lxmsPy2gb7K7PunzQZPh7speoEpKdX+mHKj/rsDywdYknryqByDxxIewNNc6VVSHTnpbJB97NoB/7BVlesAfO7JbKY4KlMnn55u8G+sFpBXOwmXVKd7wXV40F6m3RI7s9QxLE18KIy/6rgQI90pJ5HywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji9HsPU9ErwEL5UMGEI4YM1TcauNO75Ppf01eKZ0JHs=;
 b=Fb0rYBmYRfz5TC9+586qInYupi3tCfY4ZIl0UdvANfLhrM1mosmV0XRIsRR3A9Yxrr/iFIzubmxFxM26ffUvgYw5XH0AOouBybuYkdHPf6P7s3aFNTk3q/133//72l2njQ1Ikew9QAbzCiatQp1Iv1R2O22jel3DxVECQsg21I5imFaefJtoBeyG7mKloMXX+bWT1U3I5UDTcPdUyS5F/K/y6Jz7d2XmUthyqCuZbXkL5oqB4r0mWI2v5LJkAlCtAhWg324fTTkWjGD9VSYRuIBZmOv9vzTUIpqN/Z7129hhwwTbijy75PNhC98yqRhQNr7NY+k10EkJdUZnajsS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji9HsPU9ErwEL5UMGEI4YM1TcauNO75Ppf01eKZ0JHs=;
 b=tqetJOguJ4RbIxOLN5whbvTDsPhrl/t7GlyHjCFSY8Lju7/DlHP7gpSNDDKW2UyCFucdl9IRrOdiik4VDEU/gtBnrnUqVYxOchNKTMizWyO2kdrkwG380xViJjFh9lBWUddUni6r89mruMZQtHXsSzGsIqj0kC0KWXORuDeJUbc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7372.apcprd03.prod.outlook.com (2603:1096:400:416::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 08:17:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 08:17:01 +0000
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
Subject: Re: [PATCH v7 41/43] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v7 41/43] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbgVPbf6Y1reCT+UW6ply/6BHw17Na3UsA
Date: Thu, 27 Feb 2025 08:17:01 +0000
Message-ID: <651ecf74323fb97704dd177d0fe54550c5786384.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-42-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-42-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7372:EE_
x-ms-office365-filtering-correlation-id: 45f8eddb-d258-4ae7-804a-08dd57071c82
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QndkeWpOeUxGNCthT3FSeG1abDJkL1gxNGxNSlF6ZTkrUjF1NkN6TUJaNTYr?=
 =?utf-8?B?ZmVsRi9mU3Roc1ErdUpZKzEvc2pqN2Z5MkxpUnZYM0JPWnBJclVwSjZYYnZU?=
 =?utf-8?B?bk1teVUvZ1VVS3Z5R1c0c2hmV3dicmVkZXVYMUFra0FTZ2JBV3VFR1JCYld5?=
 =?utf-8?B?S2JKWlo3OWd4bDh1Yk5KRlZCQm9xSVJ2ZE1pODg1T1A5WFcvaXlGTjhWc2dV?=
 =?utf-8?B?Um54bmJGU3hpaVJnQTAycTVQQ3lHUm5HcnRKZWNIWUdWM3F1RG02cHJMVWQ0?=
 =?utf-8?B?aFJ2NUpER2IxVXBJWUI2QklWaDIxeE0weUY3MTA5K3krU3B4STNiRk0veGVL?=
 =?utf-8?B?QjROOFFYUEd1UHdSN2xjd3Vxb3JoMkFzREhaSnNUdUorVU1hL0NJSkxlbnBM?=
 =?utf-8?B?Rkdlb2ZmU04yMnZLbjBFY1N0ZU4wYnVvcWxpSE11eDVzUElXS1Y3WGlOUm1K?=
 =?utf-8?B?am84WXZaYjR1MCtwWGFrYkJrYlhPbk9FYVZUaUpmREFpOFNzZ3JNcUU4RHZF?=
 =?utf-8?B?Y3k0MEZndG9PSXNCNlEwbmFrSWlJa2JqTnA2UDRxRHc3a1RQK0pjQllRQ2hR?=
 =?utf-8?B?enZOMzc1Q3JBYSsxNzZ5NEd2QStXUzVBMksrdHFnZVVhSDZtK3RnRzkwbFp5?=
 =?utf-8?B?WEhCU1BPRHRhbS92OG4rWDVRdzdkZTJCZE04Nlk5aHZ6cDdjdWlxNHFwdXVv?=
 =?utf-8?B?bGdLL1lsNm5VVE41S2J6VTNPZ3FVUVJYVGxXVEN4N09ZTWl1ck1BMzlVT2tx?=
 =?utf-8?B?Q3QyaHNVenhIM0tyUzBZZnhaRllQazFKRVdWUUlLUjcwWDhwdENEcnBHbXcz?=
 =?utf-8?B?RkZoUWNyRGg1RERPaWEwVUF6WmxLakxZOXpVNG9mNVFrM0dvdHFMeEVQVWgz?=
 =?utf-8?B?SHlLdFRneHRKV1JaRjA1S0JPMXZJckc2dFBXQW13dWNFa01BS3FBTE5UNU5v?=
 =?utf-8?B?MTZkNHJkM0pJaE4wZzJqTDIwM041VXhuZFhpM1FiNGhwcjdIYUhranN3d1Fm?=
 =?utf-8?B?TkVvMkxLdUNvQmlKZ2Qyb1FsT2IxR0tmWnpYVHl1OHVRZDRBaUhXdTZpNFZo?=
 =?utf-8?B?Q3JDN01xeDJJMC9tMFVxWWxtN1c2UWQ2dS9KcHBtdE5TUDZ0S21FUjdkSks4?=
 =?utf-8?B?b2lHQkpra0JmdzhaQk43L2IrVU5NSWFHenVOSUFMdHlXSFN1Zkg2b0wwRFla?=
 =?utf-8?B?cS9SeU1lNWNDd0VxZEZxdkRXMnNBcWdkR3ZweU1KWWdGa3R0WjlVYjRkV3li?=
 =?utf-8?B?b2k3c3hhV01vUkRWSmhqY21oN1czQXBKMThhM1dSdVNlMVlTZ1hTVkNZVlNV?=
 =?utf-8?B?QUpBcXJvNmF1bFk4K1VtSWIwL3o0KzZpRWFHeXdKakJFZUowaitDZ1ZQTmx3?=
 =?utf-8?B?dk5vb2VJQ3NKbzA4ODVwakQydWlJdzdveWxYcHpleWE4ekJGc3JUdC9yRDds?=
 =?utf-8?B?U0c2NGpvQXBTVFpESGNSNUE1MHc3NTA0Vk5PRHhQTHBSbUpQTWlQa0I2RWhE?=
 =?utf-8?B?dHJVdDFzeGVaRU5sQjJMOGcwYzkwRmEyMndTMU1memhjY3VtcW5yNGVLSzZM?=
 =?utf-8?B?emtqcHhwSE90YVF2cEhJZitKemgzY29vdENDVjFWUGg0RnJOMjYxdjU0WXRR?=
 =?utf-8?B?OG05NVptRTUzcDRwRzJKd2E0YnRydGdaQ1NkUUpCTVkwZDdsakZPdVBibW9P?=
 =?utf-8?B?aXhGZXFrc0FjMldZY050YWlZUjRmZ3BoQitBaG1CVnV1R0Y0bGtwR0ppblAr?=
 =?utf-8?B?VHEzQVM5Rm5GekFESG1ZcGpOQXlrMkR2VFJwbVI1b1dJaDhoOFdsVDh4YVRT?=
 =?utf-8?B?S0JMRlpQK0I2Y2J5Z0YrK0lYdC9zYzJZdDBFb091aTJGTVhsTGtWTWQ5ZGJn?=
 =?utf-8?B?NDNJWVNJZUp5NkZDT1BwNTVKdkt2cVFDZ3kzRmQwdVkzbnhyYkRCam1idVA3?=
 =?utf-8?Q?QqJkQXyJNs0nObz82DZcr1lMa7Eyu9Ck?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHI0R2NxZmJiTUJiRldGRVFyeDNJWDRLTjBVUGl4WmlxN212ZW4zM1NtZnBM?=
 =?utf-8?B?eDZsSjJodVFuU2pRYzdFRWp5Y3RnN05COFlNWERwMmpkQ2tvQ1ZRNDhuM3lQ?=
 =?utf-8?B?YkJqb0t0aUdleS9GTitjM0RQNEpKL0N2TWNQb0REUSswcFBzSFlOY1RldVhX?=
 =?utf-8?B?QUhJWXE4UmFmMkdYWUNrL0RMT2lHVnFHc29MZ0Y4Y2NFdlFkOEFKdmdCcDZW?=
 =?utf-8?B?TDhtYnBQR04wbTMxUy9VZDVETC9uVHVxRFlQSVhhRTZLVm4ycGRSa3lBc2ha?=
 =?utf-8?B?WjdoV2xQMEJxbEFVbGV3NFhHZDdrS3FuQ09GbEoyYjY1cFhjRVgvUU1KWStr?=
 =?utf-8?B?ZXZveGp4ZEVSeFBwek5NaXQwUDlBVTROaHVaNGZSa1JGTzJNWVVGMCtQSysz?=
 =?utf-8?B?aWF0WS8yRGlTSWhpR0Q5aTFQbUtOWmJnb09JVGNNUzRLd2hxU0xCTnZNS0Jk?=
 =?utf-8?B?Q0FLRW5NWnZpWFJzZ2RER0hqZ0xBWjBISlY2UFAxenYxRk5WbWFqNkJXZTNo?=
 =?utf-8?B?bFJPb3h6bkg2cmw4Y1N4dkFZVFJMTDlHeVlyeDFuSElrTmhXMWRzdnloV2ZW?=
 =?utf-8?B?Z3JKWUIrWWxqUHhXSXdydGNwUGNOOFdFQitIWHh4TWdZNUw5U0NCZHphQ2pj?=
 =?utf-8?B?WWVuY2t0dm5uYlVKYkh6bUhBNm5Cb3NJZEVGZDN0aUVVamRkV2Mwbm5XSzhw?=
 =?utf-8?B?MlpnSDVjQkt0WEtRbE5LRUFDSzI5eFlqdHNyQ2UzQldJN09aL3pOVWRFYjFz?=
 =?utf-8?B?Zy9iY2dUUzhEOGo0dlZzakdCQSs1NDltTTlDUGNmQ09RMG1zQnA1TVl4NXFF?=
 =?utf-8?B?ekdaaVVWTDlmYjdMTVdXRVU3dXdmelpMb0c1Yzh2cWdBUVZkempXUmNxSk5B?=
 =?utf-8?B?SmFlWjBPbXdDelh0ekY3Z0N0b3l2QVlaRmVtZWVmK2YvbXlKTW1NLzk1UzEv?=
 =?utf-8?B?dFlCTVdrSGVaS0kxTUVCZGY4NUd0VlRyTDduaHlXbVcvZHRza2FYVmdzNGhG?=
 =?utf-8?B?RnJibWcvVDRYdG0vdFhwdEx3Sk1xcHNWWVIxT1VtblVxMGh5ODYvdVp0TDRl?=
 =?utf-8?B?dE5DMHNkckMrbWRxZUJadDZWM1BabFFkWXJUVEgwdXl1bG9SdGtVcER3Qjlo?=
 =?utf-8?B?S3FxQWVUWTB2MFFxa1gzcHgzNVQ1NzVBNFZLNXlwVFdkNlNDWjhhL1p1U3dy?=
 =?utf-8?B?K3YyT3I1R2krT1ZxMkMxL1l2K3R2L1RCSVRPa0VIQmZSbkxORHMrVndHQXU5?=
 =?utf-8?B?SElna2pxUlRaWHNtZTF1MzhJd0hmM2tleUg3N1g0QkoxS2YyZEpTOW1KcWhT?=
 =?utf-8?B?MHpkVEdsUk8ycCtmRDBNTDFvcUdNRzVZTmZXY240d2toeGxhdDd2YitMTmZ0?=
 =?utf-8?B?MUpxV1BKUkNEaDVvRDRCWUwySFEzaE96enFrb3JkK2JtWFZrSXhMM3Z6a1NV?=
 =?utf-8?B?eFZ5bXNobmlJVmZFcDlhMG1FWnZ1ODJlZnlrc2xTbXBFQ3prYW8vMUFUVUNq?=
 =?utf-8?B?RVJFVnBzcWFwT2d5ZkV0eVFlcjZaVG9PUlQyeENxd2RQQXF3YVVIRXFRcFlp?=
 =?utf-8?B?VlBYMTdDcXpoWTVtelM1T1ZZRFdKTjV6dldwbDBwckJBaFRJcGRiUCtXOU02?=
 =?utf-8?B?YTRGM1dBY2xZcUFud3o4SXFWNWgrWmZHRTlVRmVzTnVLckhneFRtUDJreGZo?=
 =?utf-8?B?Ri9pTE9sNWNTL2tuTjcyMGFFekNIZ3FXbUNPL21NdFE2d2RtOEYxVnpnQ2lu?=
 =?utf-8?B?MlBhalUzazBLRnlhSEI4cHpTNi9MU1kyelJncFkxaHEvUGlmNDdhMExzWFpq?=
 =?utf-8?B?S0ZUT2Vvd2JXc3E2VXMrMUt5b2g5MHlVSHljOUNXSXFlUlZlNmRUUURlZENQ?=
 =?utf-8?B?UWRBSTA3NndGK1NFZFM1aGNFY2tIY1dEVEgxSllrMW4xWjYrc2cvMHp3cC9n?=
 =?utf-8?B?ZDNkS0poakw1Z2VCK0lzbTFmbEpsTGJuMGt6MWc0OGdubU5ya0x4OXFYcEcx?=
 =?utf-8?B?WUJ0Wmw3RzhtY05vQ0dycUdoMzFXSVBONjlSZU4zSUh2QmtwNWdLK3loREZ1?=
 =?utf-8?B?SkJuUkFmUyswNUszaFpDWkljSjgzS3NyVHcyTmRxUnE5dHEralYzRkZud1ZJ?=
 =?utf-8?Q?RAnZ9zTURd5urSziKwevHywdg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74010B11A339304BAC41B48103B441FD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f8eddb-d258-4ae7-804a-08dd57071c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 08:17:01.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwnrM2ZjAb75xoMjgsEKX82Us+70JIL+8kcJwcrR5Le7A2LxaQmQyoJhWWUfDYRfz5i+OwnACOXkuUIM1DogqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7372

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIG5ld2VyIEhETUkt
VFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGluIE1lZGlhVGVrJ3MgTVQ4
MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+IGluY2x1ZGluZyBzdXBw
b3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBIRE1JDQo+IEF1ZGlvLCBh
cyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBDRUMgZnVuY3Rpb25hbGl0
aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0KPiBidXQgYXJlIG5vdCBp
bmNsdWRlZCBpbiB0aGlzIGNvbW1pdCBhbmQgdGhhdCBhbHNvIHBvc2VzIGEgc2xpZ2h0DQo+IGRp
ZmZlcmVuY2UgYmV0d2VlbiB0aGUgVjIgYW5kIFYxIGNvbnRyb2xsZXJzIGluIGhvdyB0aGV5IGhh
bmRsZQ0KPiBIb3RwbHVnIERldGVjdGlvbiAoSFBEKS4NCj4gDQo+IFdoaWxlIHRoZSB2MSBjb250
cm9sbGVyIHdhcyB1c2luZyB0aGUgQ0VDIGNvbnRyb2xsZXIgdG8gY2hlY2sNCj4gSERNSSBjYWJs
ZSBjb25uZWN0aW9uIGFuZCBkaXNjb25uZWN0aW9uLCBpbiB0aGlzIGRyaXZlciB0aGUgdjINCj4g
b25lIGRvZXMgbm90Lg0KPiANCj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZhY3QgdGhhdCBvbiBwYXJ0
cyB3aXRoIHYyIGRlc2lnbnMsIGxpa2UgdGhlDQo+IE1UODE5NSBTb0MsIHRoZXJlIGlzIG9uZSBD
RUMgY29udHJvbGxlciBzaGFyZWQgYmV0d2VlbiB0aGUgSERNSQ0KPiBUcmFuc21pdHRlciAoSERN
SS1UWCkgYW5kIFJlY2VpdmVyIChIRE1JLVJYKTogYmVmb3JlIGV2ZW50dWFsbHkNCj4gYWRkaW5n
IHN1cHBvcnQgdG8gdXNlIHRoZSBDRUMgSFcgdG8gd2FrZSB1cCB0aGUgSERNSSBjb250cm9sbGVy
cw0KPiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBzdXBwb3J0IGZvciBvbmUgVFgsIG9uZSBSWCAq
YW5kKiBmb3IgYm90aA0KPiBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29s
bGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9p
ZCBtdGtfaGRtaV92Ml9od19yZXNldF9hdl9tdXRlX3JlZ3Moc3RydWN0IG10a19oZG1pICpoZG1p
KQ0KPiArew0KDQpUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBvbmx5IGJ5IG10a19oZG1pX3YyX2h3
X2djcF9hdm11dGUoKSwgc28gbWVyZ2UgaXQgaW50byBtdGtfaGRtaV92Ml9od19nY3BfYXZtdXRl
KCkuDQpZb3VyIHBvaW50IGlzIHRoYXQgZnVuY3Rpb24gbmFtZSB3b3VsZCBzaG93IG1vcmUgaW5m
b3JtYXRpb24gYWJvdXQgdGhpcyByZWdpc3RlciBzZXR0aW5nLg0KSSB0aGluayB5b3UgY291bGQg
bWVyZ2UgdGhpcyBmdW5jdGlvbiBhbmQgdXNlIGNvbW1lbnQgdG8gZGVzY3JpYmUgYWJvdXQgdGhp
cyByZWdpc3RlciBzZXR0aW5nLg0KRnVuY3Rpb24gbmFtZSBqdXN0IHNob3cgZmV3IGluZm9ybWF0
aW9uLiBJZiB5b3Ugd2FudCB0byBzaG93IG1vcmUgdGhpbmdzLCBjb21tZW50IGlzIGJldHRlci4N
CklmIHlvdSB3b3JyeSB0aGF0IGNvbW1lbnQgaXMgdG9vIG1hbnksIHRoZSBjb21tZW50IG1heSBi
ZSBhcyBzaW1wbGUgYXMgZnVuY3Rpb24gbmFtZS4NCkl0J3MgYmV0dGVyIHRvIHVzZSBjb21tZW50
IHRvIGRlc2NyaWJlIHJlZ2lzdGVyIHVzYWdlIHRoYW4gYnJlYWsgdGhlbSBpbnRvIHNtYWxsIHBp
ZWNlcyBmdW5jdGlvbnMuDQoNCj4gKyAgICAgICAvKiBHQ1AgcGFja2V0ICovDQo+ICsgICAgICAg
cmVnbWFwX2NsZWFyX2JpdHMoaGRtaS0+cmVncywgVE9QX0NGRzAxLCBDUF9DTFJfTVVURV9FTiB8
IENQX1NFVF9NVVRFX0VOKTsNCj4gKyAgICAgICByZWdtYXBfY2xlYXJfYml0cyhoZG1pLT5yZWdz
LCBUT1BfSU5GT19SUFQsIENQX1JQVF9FTik7DQo+ICsgICAgICAgcmVnbWFwX2NsZWFyX2JpdHMo
aGRtaS0+cmVncywgVE9QX0lORk9fRU4sIENQX0VOIHwgQ1BfRU5fV1IpOw0KPiArfQ0KPiArDQo+
ICtzdGF0aWMgaW5saW5lIHZvaWQgbXRrX2hkbWlfdjJfaHdfZ2NwX2F2bXV0ZShzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWksIGJvb2wgbXV0ZSkNCj4gK3sNCj4gKyAgICAgICBtdGtfaGRtaV92Ml9od19y
ZXNldF9hdl9tdXRlX3JlZ3MoaGRtaSk7DQo+ICsNCj4gKyAgICAgICBpZiAobXV0ZSkNCj4gKyAg
ICAgICAgICAgICAgIHJlZ21hcF9zZXRfYml0cyhoZG1pLT5yZWdzLCBUT1BfQ0ZHMDEsIENQX1NF
VF9NVVRFX0VOKTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICByZWdtYXBfc2V0
X2JpdHMoaGRtaS0+cmVncywgVE9QX0NGRzAxLCBDUF9DTFJfTVVURV9FTik7DQo+ICsNCj4gKyAg
ICAgICByZWdtYXBfc2V0X2JpdHMoaGRtaS0+cmVncywgVE9QX0lORk9fUlBULCBDUF9SUFRfRU4p
Ow0KPiArICAgICAgIHJlZ21hcF9zZXRfYml0cyhoZG1pLT5yZWdzLCBUT1BfSU5GT19FTiwgQ1Bf
RU4gfCBDUF9FTl9XUik7DQo+ICt9DQo+ICsNCg0KW3NuaXBdDQoNCj4gKw0KPiArc3RhdGljIHZv
aWQgbXRrX2hkbWlfdjJfY2hhbmdlX3ZpZGVvX3Jlc29sdXRpb24oc3RydWN0IG10a19oZG1pICpo
ZG1pKQ0KPiArew0KPiArICAgICAgIG10a19oZG1pX3YyX2h3X3Jlc2V0KGhkbWkpOw0KPiArICAg
ICAgIG10a19oZG1pX3YyX3NldF9zd19ocGQoaGRtaSwgdHJ1ZSk7DQo+ICsgICAgICAgdWRlbGF5
KDIpOw0KPiArDQo+ICsgICAgICAgcmVnbWFwX3dyaXRlKGhkbWktPnJlZ3MsIEhEQ1BfVE9QX0NU
UkwsIDApOw0KPiArDQo+ICsgICAgICAgLyogRW5hYmxlIEhEQ1AgcmVhdXRoZW50aWNhdGlvbiBp
bnRlcnJ1cHQgKi8NCj4gKyAgICAgICByZWdtYXBfc2V0X2JpdHMoaGRtaS0+cmVncywgVE9QX0lO
VF9FTkFCTEUwMCwgSERDUDJYX1JYX1JFQVVUSF9SRVFfRERDTV9JTlQpOw0KDQpZb3UgaGF2ZSBt
ZW50aW9uZWQgdGhhdCBoYXJkd2FyZSB3b3VsZCBwcm9jZXNzIHRoaXMgaW50ZXJydXB0IGludGVy
bmFsbHkgc28gd2UgbmVlZCB0aGlzIGludGVycnVwdC4NCkFkZCBjb21tZW50IGZvciB0aGlzIGJl
Y2F1c2UgdGhpcyBpcyBub3QgdHJpdmlhbC4NCg0KPiArDQo+ICsgICAgICAgLyogRW5hYmxlIGhv
dHBsdWcgYW5kIHBvcmQgaW50ZXJydXB0cyAqLw0KPiArICAgICAgIG10a19oZG1pX3YyX2VuYWJs
ZV9ocGRfcG9yZF9pcnEoaGRtaSwgdHJ1ZSk7DQo+ICsNCj4gKyAgICAgICAvKiBGb3JjZSBlbmFi
bGluZyBIRENQIEhQRCAqLw0KPiArICAgICAgIHJlZ21hcF9zZXRfYml0cyhoZG1pLT5yZWdzLCBI
RENQMlhfQ1RSTF8wLCBIRENQMlhfSFBEX09WUik7DQo+ICsgICAgICAgcmVnbWFwX3NldF9iaXRz
KGhkbWktPnJlZ3MsIEhEQ1AyWF9DVFJMXzAsIEhEQ1AyWF9IUERfU1cpOw0KPiArDQo+ICsgICAg
ICAgLyogU2V0IDggYml0cyBwZXIgcGl4ZWwgKi8NCj4gKyAgICAgICByZWdtYXBfdXBkYXRlX2Jp
dHMoaGRtaS0+cmVncywgVE9QX0NGRzAwLCBUTURTX1BBQ0tfTU9ERSwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgRklFTERfUFJFUChUTURTX1BBQ0tfTU9ERSwgVE1EU19QQUNLX01PREVf
OEJQUCkpOw0KPiArICAgICAgIC8qIERpc2FibGUgZ2VuZXJhdGluZyBkZWVwY29sb3IgcGFja2V0
cyAqLw0KPiArICAgICAgIHJlZ21hcF9jbGVhcl9iaXRzKGhkbWktPnJlZ3MsIFRPUF9DRkcwMCwg
REVFUENPTE9SX1BLVF9FTik7DQo+ICsgICAgICAgLyogRGlzYWJsZSBhZGRpbmcgZGVlcGNvbG9y
IGluZm9ybWF0aW9uIHRvIHRoZSBnZW5lcmFsIHBhY2tldCAqLw0KPiArICAgICAgIHJlZ21hcF9j
bGVhcl9iaXRzKGhkbWktPnJlZ3MsIFRPUF9NSVNDX0NUTFIsIERFRVBfQ09MT1JfQUREKTsNCj4g
Kw0KPiArICAgICAgIGlmIChoZG1pLT5jdXJyX2Nvbm4tPmRpc3BsYXlfaW5mby5pc19oZG1pKQ0K
PiArICAgICAgICAgICAgICAgcmVnbWFwX3NldF9iaXRzKGhkbWktPnJlZ3MsIFRPUF9DRkcwMCwg
SERNSV9NT0RFX0hETUkpOw0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIHJlZ21h
cF9jbGVhcl9iaXRzKGhkbWktPnJlZ3MsIFRPUF9DRkcwMCwgSERNSV9NT0RFX0hETUkpOw0KPiAr
DQo+ICsgICAgICAgdWRlbGF5KDUpOw0KPiArICAgICAgIG10a19oZG1pX3YyX2h3X3ZpZF9tdXRl
KGhkbWksIHRydWUpOw0KPiArICAgICAgIG10a19oZG1pX3YyX2h3X2F1ZF9tdXRlKGhkbWksIHRy
dWUpOw0KPiArICAgICAgIG10a19oZG1pX3YyX2h3X2djcF9hdm11dGUoaGRtaSwgZmFsc2UpOw0K
PiArDQo+ICsgICAgICAgcmVnbWFwX3VwZGF0ZV9iaXRzKGhkbWktPnJlZ3MsIFRPUF9DRkcwMSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTF9QS1RfVlNZTkNfSElHSF9FTiB8IE5V
TExfUEtUX0VOLCBOVUxMX1BLVF9WU1lOQ19ISUdIX0VOKTsNCj4gKyAgICAgICB1c2xlZXBfcmFu
Z2UoMTAwLCAxNTApOw0KPiArDQo+ICsgICAgICAgLyogRW5hYmxlIHNjcmFtYmxpbmcgaWYgdG1k
cyBjbG9jayBpcyAzNDBNSHogb3IgbW9yZSAqLw0KPiArICAgICAgIG10a19oZG1pX3YyX2VuYWJs
ZV9zY3JhbWJsaW5nKGhkbWksIGhkbWktPm1vZGUuY2xvY2sgPj0gMzQwICogS0lMTyk7DQo+ICsN
Cj4gKyAgICAgICAvKiBEaXNhYmxlIFlVVjQyMCBkb3duc2FtcGxpbmcgKi8NCj4gKyAgICAgICBt
dGtfaGRtaV95dXY0MjBfZG93bnNhbXBsaW5nKGhkbWksIGZhbHNlKTsNCj4gK30NCj4gKw0KDQpb
c25pcF0NCg0KPiArDQo+ICtzdGF0aWMgdm9pZCBtdGtfaGRtaV9ocGRfZXZlbnQoZW51bSBoZG1p
X2hwZF9zdGF0ZSBocGQsIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKyAgICAgICBzdHJ1
Y3QgbXRrX2hkbWkgKmhkbWkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArICAgICAg
IGlmIChoZG1pICYmIGhkbWktPmJyaWRnZS5lbmNvZGVyICYmIGhkbWktPmJyaWRnZS5lbmNvZGVy
LT5kZXYpDQo+ICsgICAgICAgICAgICAgICBkcm1faGVscGVyX2hwZF9pcnFfZXZlbnQoaGRtaS0+
YnJpZGdlLmVuY29kZXItPmRldik7DQoNClRoaXMgZnVuY3Rpb24ganVzdCBkbyBvbmUgdGhpbmcg
YW5kIGlzIGNhbGxlZCBvbmx5IGJ5IGlzciB0aHJlYWQsIHNvIG1lcmdlIHRoaXMgZnVuY3Rpb24g
aW50byBpc3IgdGhyZWFkLg0KDQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBlbnVtIGhkbWlfaHBkX3N0
YXRlIG10a19oZG1pX3YyX2hwZF9wb3JkX3N0YXR1cyhzdHJ1Y3QgbXRrX2hkbWkgKmhkbWkpDQo+
ICt7DQo+ICsgICAgICAgdTggaHBkX3Bpbl9zdGEsIHBvcmRfcGluX3N0YTsNCj4gKyAgICAgICB1
MzIgaHBkX3N0YXR1czsNCj4gKw0KPiArICAgICAgIHJlZ21hcF9yZWFkKGhkbWktPnJlZ3MsIEhQ
RF9ERENfU1RBVFVTLCAmaHBkX3N0YXR1cyk7DQo+ICsgICAgICAgaHBkX3Bpbl9zdGEgPSBGSUVM
RF9HRVQoSFBEX1BJTl9TVEEsIGhwZF9zdGF0dXMpOw0KPiArICAgICAgIHBvcmRfcGluX3N0YSA9
IEZJRUxEX0dFVChQT1JEX1BJTl9TVEEsIGhwZF9zdGF0dXMpOw0KPiArDQo+ICsgICAgICAgaWYg
KGhwZF9waW5fc3RhICYmIHBvcmRfcGluX3N0YSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBI
RE1JX1BMVUdfSU5fQU5EX1NJTktfUE9XRVJfT047DQo+ICsgICAgICAgZWxzZSBpZiAoaHBkX3Bp
bl9zdGEpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gSERNSV9QTFVHX0lOX09OTFk7DQo+ICsg
ICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIEhETUlfUExVR19PVVQ7DQoNCklu
IHYxLCBjZWMgZHJpdmVyIHRyZWF0ICcoaHBkX3Bpbl9zdGEgJiYgcG9yZF9waW5fc3RhKSBpcyB0
cnVlJyBhcyBwbHVnIGluLCBvdGhlcndpc2UgcGx1ZyBvdXQuDQpJdCBzZWVtcyB0aGF0IHYxIGNv
dWxkIHN1cHBvcnQgMyBzdGF0dXMgYnV0IGl0IGNob29zZSAyIHN0YXR1cyBhbmQgbWFrZSBleHRl
cm5hbCBjb25uZWN0b3IgY29tcGxpY2F0ZWQ/DQpBZGQgY29tbWVudCBhYm91dCB0aGUgYmVuZWZp
dCBmb3IgZXh0ZXJuYWwgY29ubmVjdG9yLg0KDQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpcnFyZXR1
cm5fdCBtdGtfaGRtaV92Ml9pc3IoaW50IGlycSwgdm9pZCAqYXJnKQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCBtdGtfaGRtaSAqaGRtaSA9IGFyZzsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgaXJx
X3N0YTsNCj4gKyAgICAgICBpbnQgcmV0ID0gSVJRX0hBTkRMRUQ7DQo+ICsNCj4gKyAgICAgICBy
ZWdtYXBfcmVhZChoZG1pLT5yZWdzLCBUT1BfSU5UX1NUQTAwLCAmaXJxX3N0YSk7DQo+ICsNCj4g
KyAgICAgICAvKiBIYW5kbGUgSG90cGx1ZyBEZXRlY3Rpb24gaW50ZXJydXB0ICovDQo+ICsgICAg
ICAgaWYgKGlycV9zdGEgJiAoSFRQTEdfUl9JTlQgfCBIVFBMR19GX0lOVCB8IFBPUkRfRl9JTlQg
fCBQT1JEX1JfSU5UKSkgew0KDQppZiAoaXJxX3N0YSAmIEhQRF9QT1JEX0hXX0lSUVMpIHsNCg0K
PiArICAgICAgICAgICAgICAgbXRrX2hkbWlfdjJfZW5hYmxlX2hwZF9wb3JkX2lycShoZG1pLCBm
YWxzZSk7DQoNClRoZSByZWFzb24geW91IGR5bmFtaWNhbGx5IGVuYWJsZS9kaXNhYmxlIGhwZCBp
cnEgaXMgdG8gcHJldmVudCBpc3IgdGhyZWFkIHRvIGJlIGludGVycnVwdGVkLg0KQnV0IEkgdGhp
bmsgdGhlIGlzciB0aHJlYWQgY291bGQgYmUgaW50ZXJydXB0ZWQgYW5kIG5vdGhpbmcgd291bGQg
YmUgZXJyb3IuDQpJZiB0aGUgaXNyIHRocmVhZCBpcyByZXNoZWR1bGVkLCB0aGVuIGl0IGp1c3Qg
cmVhZCB0aGUgbGF0ZXN0IHBsdWcgc3RhdHVzIGFnYWluIGFuZCByZXBvcnQgaXQgdG8gZHJtIGNv
cmUuDQpJIGRvbid0IGtub3cgd2h5IHlvdSBkb24ndCB3YW50IHJlc2NoZWR1bGU/DQoNCj4gKyAg
ICAgICAgICAgICAgIHJldCA9IElSUV9XQUtFX1RIUkVBRDsNCj4gKyAgICAgICB9DQo+ICsNCj4g
KyAgICAgICAvKg0KPiArICAgICAgICAqIENsZWFyIGFsbCAzMiArIDE5IGludGVycnVwdHMgaW4g
Q0xSMDAgYW5kIENMUjAxOiB0aGlzIGlzIGltcG9ydGFudA0KPiArICAgICAgICAqIHRvIGF2b2lk
IHVud2FudGVkIHJldHJpZ2dlcmluZyBvZiBhbnkgaW50ZXJydXB0cw0KPiArICAgICAgICAqLw0K
DQpJZiB5b3UgZG9lcyBub3QgZW5hYmxlIGludGVycnVwdCBpbiBUT1BfSU5UX0VOQUJMRTAxIChJ
IG1lYW4gc29mdHdhcmUgZGlzYWJsZSB0aGVzZSBpbnRlcnJ1cHQpLA0KYW5kIGhhcmR3YXJlIHdv
dWxkIHN0aWxsIHRyaWdnZXIgdGhlc2UgaW50ZXJydXB0LCBhZGQgY29tbWVudCB0byBkZXNjcmli
ZSB0aGlzIHdlaXJkIGhhcmR3YXJlIGJlaGF2aW9yLg0KSSB3aWxsIHRyZWF0IHRoaXMgd2VpcmQg
YmVoYXZpb3IgYXMgaGFyZHdhcmUgYnVnLCBhbmQgZXhwZWN0IGl0IHdvdWxkIGJlIGZpeGVkIGlu
IG5leHQgU29DLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArICAgICAgIHJlZ21hcF93cml0ZShoZG1p
LT5yZWdzLCBUT1BfSU5UX0NMUjAwLCBHRU5NQVNLKDMxLCAwKSk7DQo+ICsgICAgICAgcmVnbWFw
X3dyaXRlKGhkbWktPnJlZ3MsIFRPUF9JTlRfQ0xSMDEsIEdFTk1BU0soMTgsIDApKTsNCj4gKw0K
PiArICAgICAgIC8qIFJlc3RvcmUgaW50ZXJydXB0IGNsZWFyaW5nIHJlZ2lzdGVycyB0byB6ZXJv
ICovDQo+ICsgICAgICAgcmVnbWFwX3dyaXRlKGhkbWktPnJlZ3MsIFRPUF9JTlRfQ0xSMDAsIDAp
Ow0KPiArICAgICAgIHJlZ21hcF93cml0ZShoZG1pLT5yZWdzLCBUT1BfSU5UX0NMUjAxLCAwKTsN
Cj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gDQoNCg==

