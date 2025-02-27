Return-Path: <linux-kernel+bounces-535659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB2A475A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1120A3A6980
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9F217654;
	Thu, 27 Feb 2025 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tzzwaSpj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sVsIOx86"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3E21516A;
	Thu, 27 Feb 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635995; cv=fail; b=jKlcevg7hmhYrAI909PSusXEQlfBhh/Kc/rj3820EX3fKDZymnSGAP5zGJkSBT/svZs2T1hTuxWCjzfOGRlaYprICgrZO8hOoQ6qsLTsWk7U883NPqeOWMhxM/D/ShZfmiMrpXVawPnqvpWUKuvEGAkMwCwMjMPmpDT6fQwkqBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635995; c=relaxed/simple;
	bh=VE/UyFX/bc8THynRtKBtrh6SiyEjlEXHQ5Zx2asPVE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocfYfGaOqv3ZpXOX9cd89rtmYMihM7h2dzJV0kj1EHVKpXyPht+/BMB/cKZcwS1oWi0S3NaL8neoYL71WjD7/m5Bx6gXhdWOF5CIyt1348SIKJKtA5abouV2P3VxqfXlmobZx+ZmlESgYr6YaZgjds8zA1tCehwQjBCjMbIuo+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tzzwaSpj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sVsIOx86; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a04f996f4d011ef8eb9c36241bbb6fb-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VE/UyFX/bc8THynRtKBtrh6SiyEjlEXHQ5Zx2asPVE8=;
	b=tzzwaSpjdblg+uyCirXczVMCUAlcj4acu8sVoLIiCt2gpCKMkC8jQ/s4NlNOL8/J0hTHtW0lf/ffcrIPNlx1+YdJlrpbpuKCE8QYXPCwKJlgBf9c8rEcxf/Rak2iawXfb/XBVh5tSnZMFrePxTXqZsqvzcEhapy4mqcLN46WK7Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:e7d2bfce-3a60-4c87-82c0-f1bc5db5f248,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:547ca3b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a04f996f4d011ef8eb9c36241bbb6fb-20250227
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 10635799; Thu, 27 Feb 2025 13:59:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 13:59:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 13:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xjzrlhk/vfytnLPt9gBSB90GVeDhcdiAnCyySTyhhr1SzUY61iDWcxamudZmrj/mMMIJTLYWkFh6DQ4PgYNA1kEdjnWJzaADyMhaMRXyJFdxh8Gm1oEG1+HNJtm1VBjyq3WY+tPiCBbRrDbS/RSFfK8Sj8dQJ8mLfV97RJijB7gwK2yAhk1RyxAfq4UwjMgKEc2S+a6z9ZzaQV2uw468CScSRyji/oqzsxr2DnrOa7VKJHS0j0+s7E1UyGOaK82eqAdBAFHxAZGbQ1qJBh/c1OxRtjSV2q4g6P4JzvVSE8UCKPIKwUfJs8igP9QYT8Lsh6n9pVQZ7e1G3QVpNs8JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE/UyFX/bc8THynRtKBtrh6SiyEjlEXHQ5Zx2asPVE8=;
 b=mr4ZKVdFT6kHrNKJpDhVaeO+CltwH2KZLjorkKJ+QLPByrB1XufCF7HTHe4kBULLv8bEwxRP8+kG2byUUyko6EYDHgoVIejSVm7juuQuO1fcs12356Kq6dBKjCM1B/YdMxU1eM2SdLgU09eN7jU6d3iQxheell3ywMjwsB8gDdZcU1WHvaEXR8M8G4aOf9g6PuYlh2yIVfJlG+k4wbSaFWPfQd40mzPNrhmjlYo305d2WmQJOX+8vmzttPwMYDgS2bwtqdwceuM7F/R8xzBBPaKpDDq3T4vqL6nKTKwVsohgZ+AvPSmR9b6OGkO9xYeV1Ma+LJ331RKNW67HHslX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE/UyFX/bc8THynRtKBtrh6SiyEjlEXHQ5Zx2asPVE8=;
 b=sVsIOx86CtGQbgfMPdrlU/GOyVbZhCrtS7hGINYzRKoKRHo/kX7O5QbbYJ2l8HGXTo4W715QRCO77E2RlUJQK29/xggcjvYeKgzsm4CiZ1vsx5HJDz2wQz3jSuOLZXnG0zuRBjaGE63HvU6aQCt3oNe6+VLGVqQGJlq0ECZsJbM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB8330.apcprd03.prod.outlook.com (2603:1096:405:1a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 05:59:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:59:38 +0000
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
Subject: Re: [PATCH v7 42/43] drm/mediatek: mtk_hdmi_v2: Add debugfs ops and
 implement ABIST
Thread-Topic: [PATCH v7 42/43] drm/mediatek: mtk_hdmi_v2: Add debugfs ops and
 implement ABIST
Thread-Index: AQHbgVRGVeBcVzzosUKb1w92BmsosbNatueA
Date: Thu, 27 Feb 2025 05:59:38 +0000
Message-ID: <5018184aafdb59bd83003a785d54d18c73d237ce.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-43-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-43-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB8330:EE_
x-ms-office365-filtering-correlation-id: 275d1065-99c1-4de2-205e-08dd56f3eb6d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?am1kSEk1b1p0RkVGcG9JM0piSVZOWURhWDd5NUU0TDB4UkpMYmlkY2pSNWhu?=
 =?utf-8?B?T2xmdjZDQWhMSWl4WnNMODVnbXpta2F3aHI5YWF5V3kxUFhrNXExUWptZnE4?=
 =?utf-8?B?UThZWWpEengzNU9INHZGMkEwcDc0aENYY3NKd3hkeXNPeGFLT3NUV0s1by9B?=
 =?utf-8?B?UjRyRHVxOUt6cGUwMzdOdWZNeE50VFJiT0RzUndpWU96Q1FnN2I5K1htMHh1?=
 =?utf-8?B?bUIvb2RzNkNXbUtuRjVJSmtxdUNJRmhaUkplZWZFYnp5VjJYalpnY0dKMGQx?=
 =?utf-8?B?NG55RDVUeWNTTDlOcTMyOUxCaEVOZStVeSt6U3gzeTZGMkd1ZStQZytlTDh4?=
 =?utf-8?B?bnJzMnJKUVE1TStzdFpEWWppTGtmWVFUNFhLSWRKalc5NWcwaDJQTmxaK0kw?=
 =?utf-8?B?N2EvQXYwRFZwNnJrSGcxSzRqS3laQ2hzMGxBTnVTSmlFVmIzNCtIekxGNWM5?=
 =?utf-8?B?ZjJaQkdWR3AzTUhVWkdIWGd1ck5HTDlpdk1NbktsM1FvTXVkeHZjSzNwZ3Zi?=
 =?utf-8?B?QUw3L1BSTWo2NEdmenZ3STBUSElyNmZORGVKbkxKUVB2RHoyVFNFb3hXV3Z0?=
 =?utf-8?B?QU9qNHpVSXFTN1JDTHlYMitiTDFORkRHeVFrUlY0NWxyd1hXYy91akxxTXpt?=
 =?utf-8?B?dGMvZnA0dzZHSEhSVFlJQ014ZUp2Z1Nkc0JaZDdxODRvSXFhc2VIZFNPK0dX?=
 =?utf-8?B?NFhhU243MHA5NUplZUZFVy9Fak90bkM1cmY0b1BsZXhlK05uWnhpVGVKdm81?=
 =?utf-8?B?U01rNWxaTUtIM3VPSmVXRmVLRTRkQnRWQjByQndHanB2TzJRSkt4bElmNjlu?=
 =?utf-8?B?YStmWCtQUHNFQUJlRUZJQVRKeGxzWGNXNGdraSticHdORlVFRnZROW9Senpq?=
 =?utf-8?B?RmUvTFl0YVhRTG9FREhBS3g2UEJWbk5kdEEwUS9LZzk5UlQxcEdkTFg3RlFn?=
 =?utf-8?B?ZTBEbENhVm5KSDlXSTRRSWs4UFJjdXB5MEZnN3Z4djBTaHVZV1hrOUVrS3ZJ?=
 =?utf-8?B?TDRiVExnaHZHWTEwalBrcmdYZUNYTm5iVjBjeXVYbWU0c3RmOGcwNmozNmY0?=
 =?utf-8?B?RjhyckNWbFgwVjR5T3Y3SUpWa2c2b1FKZWR4TkV3enZ1WjVvYU03eHZhNVNP?=
 =?utf-8?B?WUIrdGo5U3JtalBxUnBEd3NaQnFGY0szOFkxSVZoVENUT2xHVTE5RjJKL1Vw?=
 =?utf-8?B?aTdWYzFUZkUrbXg3TW9KZEx1VFEzYnhLQ2FySFg3NGUyMXd4V0s0NWhaVDRR?=
 =?utf-8?B?ZjFxaXZBS21yQjhuNVh5OFU5S2Vza3ZTNSs0aUNKOU96L3hsVjlqK056eE5N?=
 =?utf-8?B?Q0x6OXdDWnVKc2RMTUxINWYwb2crUjRSVHJiQkxpdUE3Nnl5Wm9YaVdEcHFS?=
 =?utf-8?B?K0lTQkdMeiswWGE0MzJuYkNjdjhia0wramFNcTdieG5CTVJkSHlUeVhDSmdv?=
 =?utf-8?B?SGZkZlpNSkE4YTVsV29ocG5TcVBqWjB2Wkt2cFJMMTVDQmxYYXRtUURSb1BX?=
 =?utf-8?B?dXVzbjRvd1Q5S2ViSkh5Q0V6cGE2OGFzK2Jqd3M2Z1FqZGx6bEpGYmFiaEp5?=
 =?utf-8?B?VnE2L3VXNzU0TEhYNUhTUWc5MkdaZXFZUHY2UnBxKyt1Q2N0SmxFejF5RUxV?=
 =?utf-8?B?V0dHN2tlWERDRjY4cjN5N0sxbmNkWFFEM0JuZ2ZmN1JXamtJcDJ5VjlZQjk5?=
 =?utf-8?B?R0F1R2dZWkVwc08xcE1vOVMxZnZDcjllZ0YwRlM0bHEzSXV5YmVQYU1xOGdT?=
 =?utf-8?B?b01qeldpY2dZOWpSUXFmWDljNWZac09LczJXeGlWazJaN0xibDZvamtsdnh0?=
 =?utf-8?B?NFRwdlVPakN2Z0lYaC9Cc3FJTThhUkJQdi8vMXN0WHc0T1dwRDY3VnM3TlFa?=
 =?utf-8?B?WUU1Zkp1N2d0N2JXckxPOEp3ZWNqbkNWOXZPbTh0QVVIeFpRUWxab2hqWjBT?=
 =?utf-8?Q?/lYlkFdVTuHDQwzlbrExKM4Ep4znVWcF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTcva3VGdHc2K0RvTkFucGJqdnh1OStsaitiSDM4R0lVVWtWSUQ0YTVQUmFO?=
 =?utf-8?B?bGcxOTdTV1lOZTRZc2xMeGlOaTBWbnB4cTByWENUbjF4c1FTSlRaZzVjMUJx?=
 =?utf-8?B?ZWplMG9qekQyQzlWeWliK0o2WFIwYjFQKytENlU1Y05YQ2F0MmtlN3ZqdUpO?=
 =?utf-8?B?dm9nNnhVaXkrYnJUbUVHY1p2OVNoWEFPaXB2VGZyWDV5bXAxdDJwK3dsYWRO?=
 =?utf-8?B?SFJqS0s4TXFlZzlNQ2pkZjJ3VTU2amVCa0IzMGdJcVBOMUxBbElZc3hjZEcz?=
 =?utf-8?B?OEcxWVE1NTM4QmptK1dTL0FsUzZqQWx1N1N4aUhvT3VhcGkyaVdhNkN3bzdx?=
 =?utf-8?B?cjQxT0pNcHJ3cVlBK09QSGJDZVRoRnFVRTJtU0NQTVoweDJlem4vbGN6dVRI?=
 =?utf-8?B?clRBRHlnbnBieW8vaW1mRVNCZGI2SXFEeDRhYVdCazQvSmpQM0lEOXQ4M0c2?=
 =?utf-8?B?b0g2bzFFOVovNWF3MWFkRzhPdFVCMjNzVG9pYmZ3VFpZV1h5TWFRYllDNDFY?=
 =?utf-8?B?MVJmWkR6cHFLZ2o0RlFUSzAvSk5ldHpFNk9jS1R2TkxLeE9OQUQxVkZSUlQ5?=
 =?utf-8?B?aGpBc2dCZm13RHpoNXZpQncwNWpFa2Y5NWNiOXFGODFuMlFQUCswbUttTGpN?=
 =?utf-8?B?QzRrbzBpVG9pYm5heGVDbG55NW9iNGIrVVh3dFV1alNMU2VIMUl5LzdtcmtE?=
 =?utf-8?B?U3lwWHFkSjhHSVc5UlhVQWp3V1ZmRVgwUU5PMnk3a1hFOVd5ZlZ0QmI4cHg0?=
 =?utf-8?B?VUpySmlJSUw3WDVuOFBEQWV3azJQWUoxNUQvaWs4cmMvdjlKYUZCR1FtQmNq?=
 =?utf-8?B?TUloQXFad3l6YWdlTGJjdUpzRzIvOUV2aFRVVjVWM3B5UHh5bzJNZCtNNlBa?=
 =?utf-8?B?U3JXdXlvbXcxMExZcEhvZEw2WFphcGFnVnJUVEZFb3I4T0RZMjl1QjlKa3U2?=
 =?utf-8?B?dGl0cnJaM2NSQXNoR1FLSForaFR5M2tMeENNa2w5TVpNcHA1NkU3aXo2d2Jt?=
 =?utf-8?B?YVREWVJvUnBsN3Faak8yNWxYMWFWbjlpVVdIekpvNHJCamNhVjNqV3RXcVZm?=
 =?utf-8?B?a0FmYWoxcVRUT1R0TG9HZlZMNEdwVUJDTnZqTUg5UklySENGT1Q5ckp5b0pi?=
 =?utf-8?B?Rk5HWk5GY2J2TzFVcElDWjNzSFRBZmdkNGQxVUJzQW1BeXo2YnpSWWNaeDV4?=
 =?utf-8?B?VVVEeVRaemdNNDlGVzhzYS93S0dIV0QwRjVhKzY2bGZiSUVxNWd0a3hERjlL?=
 =?utf-8?B?VVQ5cnZnS0F5K0dzVGpJbmtYQmJnQXpqSWlDR3FZakFkaEJzRGtGY0tnT3c0?=
 =?utf-8?B?c1dEei9LcU1wWUZjYVdGa1czRVQ4ZVdHTmpFVkJNOVFGd3Y4VnFsRjJ2TFlu?=
 =?utf-8?B?SEYwSi9QbUkwekIxamkyWHVQS0pnOVZ4YUdaeE5kdUt0UUM5RkxHcjQvRU01?=
 =?utf-8?B?ZW56elVpd3djM0dTYjg3UW50aWFaM2tTTWExeTFPdCtHYncxcm05NE5OUXI0?=
 =?utf-8?B?R2ZOeUpzQng2UGhneXI4Qk96cGtGTEFpNjFKUTZBYkF4dGtyUS8zRE94TXdI?=
 =?utf-8?B?ZDZlbU1mNTZGQnBNTHI5SDkxZzRvZGRRNytBNXcrS2tpR3JvbEk5dUl2ZmU1?=
 =?utf-8?B?N2pqMWtkb29oR1VWcFIyUXVyS1o4WUgrR0J2YkJucmRUcUhpNnMwZjRFb1lD?=
 =?utf-8?B?Z3NEb2xnU2ZYeVRFUUFuMFp4WnNOdXBMVWlaVkhGd0JyU3BOcUxlK1I1QjJk?=
 =?utf-8?B?QlBIb3RYLzgra282ZUIwMDVVUVhVNW0vZEVLSHRQV05WcnJvckN2bGZzMytv?=
 =?utf-8?B?T3dLRjF2TUxmME5FN1QxRklTakJ1d1NtMlhwWlViSTVzdnFjWmRQNmpPaytw?=
 =?utf-8?B?WndkTVV6OTBxblJndzZzdVlJVzhlVkNvakpMS1o5Z2F2SGQ3S0I0ak9hVHBr?=
 =?utf-8?B?ZHByV3B4SStpd3RQREtYckJzTGlzNmVlTndaT3ZJdUpuK1EyY0ZIeVg5V0tN?=
 =?utf-8?B?TkdpcWpodXpvZ3dsVjhGV205VkJocFI1b2dFemN0V1lvajE2S0d0YWQ2UmVB?=
 =?utf-8?B?ZTZSWEtJS044dUtibGJrWXp3U3N0eXdwOWxEZTRMWUlOVlJ3U1lrcEhkRStr?=
 =?utf-8?Q?+TViQS7duHlcId0vt7wOIExC9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DF061C24A1BDF41938A23AEA2324A2F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d1065-99c1-4de2-205e-08dd56f3eb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:59:38.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grAiWzNjnUG+efUqAFllWzbx2Veb/40XpEbpMwLGiDTbhDKNLO+H8BEV0nIzE5m02Rquy07i9NNEveRN7waslw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8330

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbXBsZW1lbnQgdGhlIEF1dG9tYXRlZCBCdWlsdC1J
biBTZWxmLVRlc3QgQUJJU1QgZnVuY3Rpb25hbGl0eQ0KPiBwcm92aWRlZCBieSB0aGUgSERNSXYy
IElQIGFuZCBleHBvc2UgaXQgdGhyb3VnaCB0aGUgImhkbWlfYWJpc3QiDQo+IGRlYnVnZnMgZmls
ZS4NCj4gDQo+IFdyaXRlICIxIiB0byB0aGlzIGZpbGUgdG8gYWN0aXZhdGUgQUJJU1QsIG9yICIw
IiB0byBkZWFjdGl2YXRlLg0KPiANCj4gVGhlIEFCSVNUIGZ1bmN0aW9uYWxpdHkgY2FuIGJlIHVz
ZWQgdG8gdmFsaWRhdGUgdGhhdCB0aGUgSERNSQ0KPiBUcmFuc21pdHRlciBpdHNlbGYgd29ya3Mg
YW5kIHRoYXQgY2FuIG91dHB1dCBhIHZhbGlkIGltYWdlIHRvDQo+IHRoZSBIRE1JIERpc3BsYXkg
dGhhdCBpcyBjb25uZWN0ZWQuDQo+IA0KPiBUaGlzIGlzIGVzcGVjaWFsbHkgdXNlZnVsIHdoZW4g
dHJ5aW5nIHRvIHJ1bGUgb3V0IGFueSBwb3NzaWJsZQ0KPiBpc3N1ZSB0aGF0IGlzIHJlbGF0ZWQg
dG8gdGhlIGRpc3BsYXkgcGlwZWxpbmUsIGFzIHRoZSBIRE1JIFR4DQo+IGlzIGFsd2F5cyB0aGUg
bGFzdCBjb21wb25lbnQ7IHRoaXMgbWVhbnMgdGhhdCBIRE1JIEFCSVNUIGNhbiBiZQ0KPiB1c2Vk
IGV2ZW4gd2l0aG91dCBwcmlvciBkaXNwbGF5IGNvbnRyb2xsZXIgcGlwZWxpbmUgY29uZmlndXJh
dGlvbi4NCj4gDQo+IFRoZSBleHBlY3RlZCBvdXRwdXQgaXMgYSAxMDAlIGNvbG9yIGJhciAocmFp
bmJvdykgdGVzdCBwYXR0ZXJuLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+IA0KDQo=

