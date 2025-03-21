Return-Path: <linux-kernel+bounces-570776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12977A6B457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF1C4670C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF221EB19E;
	Fri, 21 Mar 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eaj3snnH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SjVkfPxx"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922131E9B3B;
	Fri, 21 Mar 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537980; cv=fail; b=Hh2j5hWe8wGkvdJLEb83iuOgzW3KFOGjqwZ1B8Ifn5L8HnN763KSiW0D7BB9BBgwrI4QR6CZMxXqAIPBOQG9fieN0303mJ+KXba9bhdo4EuMHCmQWXM5GICEUuSnEGOuF5S2YYzicB7i2SNqT+i5veOtI9M5/GvDxBFuP3X3Aos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537980; c=relaxed/simple;
	bh=M4nJGFi6/stCw4pBVCXTgngVKXGfaqoLLG4dTLIe+cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxbuBIBeMB/L64kEq8QkL+pvHZzCBKASu8lsyGmo7DapkK0/0DWXD4de3JKYIHs1Rp9gQXx1ZpsRvoN0TGZRolq47vw8nwBB6eiLpPjQAwquz8xRJNsU9Z7GIidgs0UgA5M5R01rEJDW28bJb0SXALbnPmflnEbstgcQBe0/4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eaj3snnH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SjVkfPxx; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73d08590061c11f08eb9c36241bbb6fb-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M4nJGFi6/stCw4pBVCXTgngVKXGfaqoLLG4dTLIe+cw=;
	b=eaj3snnHHocsdBgO0Bg19fjXra9u+Ul2KDtkg9PmlmOAY4CPP6vrSNpynJ9YPqr+dge/0/ZN4Ak7vLkCv2ios7zxpLkEahANUg6//Su57iNg/GERCkkNB0VV4W1Lu//JaSOAHkcTp3M3qXoKbF7qU4Kj3ngi2hylHAwBGCMiL/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:434990f1-3ed5-40c9-88c5-eda2cce576d8,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:0ef645f,CLOUDID:68ac634a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:83|11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 73d08590061c11f08eb9c36241bbb6fb-20250321
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1870836201; Fri, 21 Mar 2025 14:19:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 14:19:31 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 14:19:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvYcI+X3pO+1Iv3CNlN0NS17N0/UGGrczmBSgFdgNhY5D4LUm68EXOUpxJpH/X3LcKY8O0y9L+GFyAQDa0nirsWrXusMxqsVgikKcbMVH2LrVKenHN7TWnBx9zdGSUYTTV6Ilbw9uyx234V0gggSZ1hAw/ZC3cNDl65ZDvPyDQQSWFHTTwNxnXKMs+d9UKr15jSS4jHQTy23GakMhYbLdBRW7/MSBRSznSIm21T0+YHhYnbIXAyWvyia58oFUPAZraKmi08BskcmwPVwJ8mlfAhTgmLv40YsUTm1D7rXVRRXv5MA3wFAcsq+y8GGPpr0mqp5G7b8RA3SPgasatgN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4nJGFi6/stCw4pBVCXTgngVKXGfaqoLLG4dTLIe+cw=;
 b=Qe/lH0Y6Wu+DTWFN+OKkPT4aZ7UqJkQCqHhRkV5pF8obSO3o74l8piialGNIeiGOZ26nSCYpvoPuh7fedPZoaBJ/j/lPltvMRKKOGYLa9JKVkJoq2rnjQoHBZndEA2N+NqcA8dnOCd7hZqKzcxBVI3XT49O0el8flDxJz1c7Fr4sZ/URrd1RJJ6+G6clyQwoi1WjA+Hfmbo4hKrOXeBluaAbmWOmVsb2Z5eDNs8CChtgOBL7dHGnOrYOMHiL1SxzA1hwK9IJYeI0N9o+nvknDBiWPpUEQw1DCv/T4LPMYhLwJhvIxBKFSwAk5yy31nA+cx9449bebowuQA4OfeL6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4nJGFi6/stCw4pBVCXTgngVKXGfaqoLLG4dTLIe+cw=;
 b=SjVkfPxxeGxH5g0uzztDELojfcwzNcAm+twcnTc6Fr/OXJLrfJYtteEJpgqNxEhWf+W71575zy8Qz0tp+RODjPRbVU+Y0bheCfyU8ET3WXkp1sFtSyEApl1puHG8YrOyb5JcWu0MC0Z6xEK95P+nsNndL7l4gtUxuqjoKrwAfFE=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by TYSPR03MB7881.apcprd03.prod.outlook.com (2603:1096:400:482::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 06:19:28 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:19:28 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "perex@perex.cz" <perex@perex.cz>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?=
	<Jjian.Zhou@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>,
	=?utf-8?B?WGlhbmd6aGkgVGFuZyAo5ZSQ55u45b+XKQ==?=
	<Xiangzhi.Tang@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
	"sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH 2/2] dt-bindings: dsp: mediatek: add mt8196 dsp document
Thread-Topic: [PATCH 2/2] dt-bindings: dsp: mediatek: add mt8196 dsp document
Thread-Index: AQHbmUblUZ3pfhqjlES28a0UhofOOrN7prIAgAF5JYA=
Date: Fri, 21 Mar 2025 06:19:28 +0000
Message-ID: <a72988212d0d95bfe76eb9c53bbdb8c57c989377.camel@mediatek.com>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
	 <20250320031753.13669-3-hailong.fan@mediatek.com>
	 <20250320-divergent-soft-bird-bcd938@krzk-bin>
In-Reply-To: <20250320-divergent-soft-bird-bcd938@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|TYSPR03MB7881:EE_
x-ms-office365-filtering-correlation-id: 363cdb7f-9754-46f3-76f1-08dd6840560c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SExkNkRXZWJtS2hxaGZOR3plWWtZR1hGRjQ5czB4VnBpcitVWTZsMmw3UTJX?=
 =?utf-8?B?bVVub0cvWGJiVFpmTzE1Tmo2WHkzMkpyb24rQy9MV3hhck9QZy9OYWRDRnJR?=
 =?utf-8?B?N0tSMXN4UXJpbnZKVmFTdUh3b3M4L1QzWmd1UDNrVmJKVVZpaGVvZFpSN0tm?=
 =?utf-8?B?SXMxNlFEbnN0SnFGb04vMzdhRkNCNkloK2VBdmRBa2tSY1ZiUTZVTHV2ZEV4?=
 =?utf-8?B?aGtOK3NUZlZkb1E3RGtabjkwWXFnR2F5ekMwUVl6clBIQzYyQUpLV2ljMk90?=
 =?utf-8?B?R2pwVUUzUGdxTHJMRGo3LzFUSnNhMzVYT1JoMitUY2s3dElVVkcyQnQxUDA3?=
 =?utf-8?B?TjhoTU92WEVMVjFJSHJqU0tabmdiZGl3ejIvdEZOK2NVajExOTVqZHlCUHlr?=
 =?utf-8?B?SWI3YzEydUh3ajQ3bXNXZmx5bmxSSGY4Q0paWmlyQ3Z4bjV6UVVhYW9SdWFk?=
 =?utf-8?B?QjNuM2NJbG45TTRpZ1RLSWRVYU1MOUYyZ0NaaU9xalhzVklJUk1EWE9TdWtX?=
 =?utf-8?B?RGRIWXFSRkIyYmZheU5CV3ZoazBZclBsVWtYeTU1TmtZQzJjLy91czdaTWZy?=
 =?utf-8?B?djNsbEI4THpVcEZwMUZnMkRyQ1VMYkdSUlhGN0gzaUZLMmRGYTFvUXI2WEoy?=
 =?utf-8?B?aTF3Nm8xOGYzT0xtM3llUGJVc3NLbnZ3RXN2RE82aG9mOWVzTXF5a3NKUW01?=
 =?utf-8?B?SjI2YWRkOEtSZnZvcG9wSlVFbVpSQUc3M0RNV3ZjR0JMVkZ6c01tYURPYW5L?=
 =?utf-8?B?MmlDRitXUTV0OEVseUFkc1pDQmkwakd4aytVZzROM0t4aFU3dUVyYmh0bytV?=
 =?utf-8?B?anhSeVlpbkc1WkdhVlBPQUsxMTJEQml5Q2FnS01WMElqOVg2anEyNWJ2UW9z?=
 =?utf-8?B?UnJxSFI5R29MYmEwMTFmNTk5VGlzUDhhTjZDUXdxS09qMWs2Z0MwK3ZjNFZL?=
 =?utf-8?B?c2FPa21xMUVWSlYxemc0OGtReFo1Vi9BZzg3YU9aUkdoWFg4MFZldUhNWDVx?=
 =?utf-8?B?V1dWY2VSNTBjQUxqZXhqMlRoZW92Um1UOFhYYkhwakpaV1RsdzZpM28vNzN4?=
 =?utf-8?B?L3RVbUcrQ01FRFNiOHRmazU2NFY0TEk2WEx3QXlQZm5tcFFBNUFkWUFvNlRt?=
 =?utf-8?B?V2t0WEZQa3ZjandOUUZlMTN0bnZ2RUx3R1A0QjYxcC9jUHovRGdMSkJmUDRN?=
 =?utf-8?B?d1FOWFBhb2NuL3pmNVFZTkYwRW1jYkRrNGQ5WTBjdUxhVzY0bnR5V3FsaVpQ?=
 =?utf-8?B?R0pYRGZLMjhWS2VIYkdFR1NEcDdnaVVCdklYVk1XNTJaVkp0S1pWaytBZTFw?=
 =?utf-8?B?WDhGK2NrRFBSUTJNZFdQSFNQb1lsYzFPcU9OampSYUppVytFSldFRWR3VGM4?=
 =?utf-8?B?cytrb3d0MmtrSGR5cmRwazgzM0RrMEFYL2syVW5qQWl4TVV3TVU5bWIyZGht?=
 =?utf-8?B?dEk5dkJzeWJyVzFGUlBvTjhJcGNLOFhaTjhFLzlITlNqMnkzSWFJRU9xU1pS?=
 =?utf-8?B?djhGOWk3Wlh1bFpma1VSN04yeE5PbUNvTm41MDJqb1RaMzRBVnpONy84ZC9v?=
 =?utf-8?B?cFdlRWttNStCRkJreFdaK25CTnRuY3EyTFF6NCsrbkNlM3E2K0JCMU1yNUt0?=
 =?utf-8?B?TWlxWjV1TTJmZW5OcmExcFdNYThicm0vYWxEdWZSQ1h0cWZ0Ync5MEFYWXlC?=
 =?utf-8?B?dHd3N0tFcTZQSURvaWZRT3M1dGpTUWowOHVaaVVxa05zS09BQXp6a0VReTlW?=
 =?utf-8?B?Sk1HVjJFVWMyd1BKNkNTV2JXZEVEZXY4cGhMUWZBelZJVTBVYlRObUJ6L2VE?=
 =?utf-8?B?WjlYYUI5bkUyb2JIOFJXMTlzRmwvQXFkWUo5V2R2d2RXcTl0bFJkMjU3bHpk?=
 =?utf-8?B?ME5kTVhJMzh0RU1qc3F6WURwRVpscjVWZ3o4dEVaTVdmMTNMZXIvWmwwN3pV?=
 =?utf-8?Q?NiL1nusUMwKFeSJIf+9x4qhxt8exmV2Y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk91azRxU2VtSUVvZWJpUDUrMUF0alZabzJ2dUExWDJyMndCTUY4WURtaE50?=
 =?utf-8?B?aW52Zi9icUVQblNPMGYxcGhDZStuWlVZNW9Nd0RvSlhyZmNweVVmTnk4Mjl1?=
 =?utf-8?B?dWhqaVlQNGo5MUx1RDR1SDdvUTVZb251aU1STmd0SXQxZTRjMzFFeUpuaWs3?=
 =?utf-8?B?cWRaUTZBOUVlUXVMUUduZldFYndiY2Z2amxnYVhrOWxiWDBRTm8zYjNCRG9r?=
 =?utf-8?B?dHlDRXFyMDY3ZnZPSXBLMW1PR3Q5cFZZc1BnSzVQdTQ2WG5nU1VYOFYveHZB?=
 =?utf-8?B?amZRZS9lRS9BTGRGaGpwVWZsWjNScW92TTdjbmF0UERnUTNRZU1Rd2RoUVQy?=
 =?utf-8?B?c0ErMkxvRFpxam8yTmgxTTVlRU1RNVV0a0V3RXZ3MW85WG5kTERhUE9XOVAw?=
 =?utf-8?B?QzFrWTRZNXJWUXhoZE5OdEZsR0VuaTRvbjZOdDB5L0xkSzJ4WkFPWjBwVUFo?=
 =?utf-8?B?MDBpUHBFdlM1KzhiOHMwUEFWdjVJVU8zTzVTRDVBKytFK0FEekZJOGZhUCtm?=
 =?utf-8?B?YnRyaCtkT1FwckVib0NsTStlcWo4QmZkcmhObGowWU8rTWlYZFpodlN4THFm?=
 =?utf-8?B?Z2p4aEt5UVc1bWhQSmhHMDFDaTdYbFJqNDUyRnQxd0tlU1dCd2w3WDEwbDBa?=
 =?utf-8?B?V25DdkwzbHJRdllhSTBMeExDVGVHMjFmTkx4d25XTEJ4S1hSbHNqOFE4TWhq?=
 =?utf-8?B?Q01mTlJ4cFFzU2JicEJlbkhxejJkREV1eGwzUnRTc0VGeVg2cCsvMVkrL1lF?=
 =?utf-8?B?Y0tBamE5bytTM1EzdjVOTUlyTFlNdnFkOWVjUTRvNlV5Vnd1N0o5S08ySzNB?=
 =?utf-8?B?RjI5ODFiTDhoWmdWQzMxOFc5L3cvWWpJVzNBNSs1V1AzVjZPWmVjTnBIVGZI?=
 =?utf-8?B?dTFTSkxsV3pXWndjTVF2MHlYNXhUMTlsb05uaktZWjN5c01qaysvSHluNnJO?=
 =?utf-8?B?NmVhRCswbWdYelY0ZkM5SDU1UTU0akcxbnA1Qy9nRHpnRW1pYWp4cGovVGoy?=
 =?utf-8?B?N3NaV21NZGlZZlRrSkkwcXd0RktmZno2Qjh3S3gvMWVkTXI3SjhxSVVTSkFL?=
 =?utf-8?B?alpKTXlXL2szRlQreHN2cFVnbjdhQy9HQmpnUk55NTRuZjdjNEVaMmVUdmRp?=
 =?utf-8?B?L0tGTCtoZmZGWW1XREdaNnY3ZVhIeWIwNjdRMnhuU2tPMHoya3hFTEViUmZM?=
 =?utf-8?B?bXYyS3pPd214QTNNbkhsZ21mRFE0MFhsbkZrbEYxUFVWbFRBbE1EYlBvaTlj?=
 =?utf-8?B?ektMQjY2WEpyOGltZWtVZW5ESm9lV3RlbUdmeTNYTVV3N2I2TERXTHVWdDhv?=
 =?utf-8?B?NFlScktxeEh0dnNQQnZrVjN3dmdPWU1rZUlXdXNWTDU5dmpGdE1SRVFLUzBp?=
 =?utf-8?B?aGFOcE9DWlp5ZC93UmIrQ3VNY2JKLzErS2tuY2NzUE5mYlRkT0FYWXhTdVJz?=
 =?utf-8?B?dWgvN0lKdGtlMkc3OHY3VnpjRElCUzZLUEtRWTNzTHFWbFlVQ2grd0x3R2tr?=
 =?utf-8?B?MC9PMVlKMlF0MGQ2Z1YxS3BLbnAyMFZZZ0dqTFVsR2xCYkJQTjFSc0MxUzVJ?=
 =?utf-8?B?L2ZZSGFNUVdZSFpKc3B5SG1XWEVsWXlMYlhJTVFGMFM2OWNRaUliZEVGZ2N3?=
 =?utf-8?B?RjRWeVhvOVdMWUEwT2M5d0lSTDBxNmpBK0U2MCtuYWs0TkRRWUtqenRxYmtS?=
 =?utf-8?B?QkZyenRGd1hyK1p6dXFCWjJya2owdnB6S0x1Y0pDOTBOdVUra1JTRlUrTkJv?=
 =?utf-8?B?b3YxSE1POExXdlhvZXhVNkQxNGQxeHpIVENNS0tKMjEzdnJzTWlRdlYyUTg0?=
 =?utf-8?B?RjNoT2w5VitIWkFXOVpHVXZqVU96ZXJJaUtqdVNZbVBBaTBSMVNVZTZlL2dN?=
 =?utf-8?B?MHVKd0d4YlBTL1dBWlI5TDFNelJsUUZTdENwVzMxR3VlVjE0RHRCOUVNTnVw?=
 =?utf-8?B?MERZVWhCemhUTjdIa2lqQnBhY1dTUC82WWdTWUdmdytSc2lySHNoL0JnQkkw?=
 =?utf-8?B?Y3dtZzRKS2RHMSsrYzlGaXF0TStlRmVReWtiSDlxcllpdVV3bWtpWm9KdTVF?=
 =?utf-8?B?M1JRMVEvY2dxUDFDUkpON2RmMzJDTTR6R2YySlNRQUJHcFp4YnBicnlUbENH?=
 =?utf-8?B?WW5NWjdNSHdNUVNMTU4rNlAvVFdsWS9vTkhPVDZqRDlXNldna3IrUzZlanNL?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DDC68ECC51EA7449685963E48C3B1B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363cdb7f-9754-46f3-76f1-08dd6840560c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 06:19:28.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjcfHz4flbqQWQEtKv0JSKo+khPysfp5J0rMg4mb26RcTy7YcTSX8rp8ozRj7b0i+evfH29Ru64Sqw5/7/g034S2ZPA9bnLDqvk/DmzMREU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7881

T24gVGh1LCAyMDI1LTAzLTIwIGF0IDA4OjQ5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIFRodSwgTWFyIDIwLCAyMDI1IGF0IDExOjE3OjI1QU0g
KzA4MDAsIGhhaWxvbmcuZmFuIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBtdDgxOTYgZHNw
IGRvY3VtZW50LiBUaGUgZHNwIGlzIHVzZWQgZm9yIFNvdW5kIE9wZW4NCj4gPiBGaXJtd2FyZSBk
cml2ZXIgbm9kZS4gSXQgaW5jbHVkZXMgcmVnaXN0ZXJzLCAgY2xvY2tzLCBtZW1vcnkNCj4gPiBy
ZWdpb25zLA0KPiA+IGFuZCBtYWlsYm94IGZvciBkc3AuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogaGFpbG9uZy5mYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IERvbid0IHVz
ZSBsb2dpbiBhcyBmdWxsIG5hbWUsIGJ1dCBwcm9wZXIgTGF0aW4tYWxwaGFiZXQgdHJhbnNjcmlw
dGlvbg0KPiBvcg0KPiBvcmlnaW5hbCBuYW1lIGluIFVURi4NCj4gDQo+IFRoaXMgY2Fubm90IGJl
IHRlc3RlZCBkdWUgdG8gZGVwZW5kZW5jeSwgc28gbGltaXRlZCByZXZpZXcuDQpXaWxsIGZpeCBp
biB2MiwgdGh4Lg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2RzcC9tZWRpYXRlayxt
dDgxOTYtZHNwLnlhbWwgICAgIHwgOTYNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+IA0KPiBE
b24ndCBncm93IGRzcCBkaXJlY3RvcnkuIEVpdGhlciB0aGlzIGlzIHJlbW90ZXByb2Mgb3Igc29t
ZSBzb3VuZA0KPiBjb21wb25lbnQsIHNvIHBsYWNlIGl0IGFjY29yZGluZ2x5Lg0KVGhpcyBpcyBh
IHJlZmVyZW5jZSB0byB0aGUgYXBwcm9hY2ggdXNlZCBpbiBhIHByZXZpb3VzIE1lZGlhVGVrDQpw
cm9qZWN0Og0KDQpodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kc3ANCkRvIHdlIG5lZWQgdG8gbW92ZSBhbGwgdGhlIGZpbGVzIHVuZGVyIHRoZSBE
U1AgZGlyZWN0b3J5IHRvIHRoZSBzb3VuZA0KZGlyZWN0b3J5Pw0KPiANCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RzcC9tZWRpYXRlayxtdDgxOTYtZHNwLnlh
bWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RzcC9tZWRpYXRlayxtdDgxOTYtDQo+ID4gZHNwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZHNwL21lZGlhdGVrLG10ODE5Ni0NCj4gPiBkc3AueWFtbA0KPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42MmJjZDk3YmQw
ZjQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RzcC9tZWRpYXRlayxtdDgxOTYtDQo+ID4gZHNwLnlhbWwNCj4gPiBAQCAtMCww
ICsxLDk2IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJT
RC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9k
c3AvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchajRCU0Nu
MmNpS0kyZ2RvUWdMRlRCMFlVZXk1dTZIaWVSYTZOdldRdmFGN1hfbUVFeUhoQ0lzbHJGWUdCT1lF
YldMYUUySjVrRE9SbHhSSSQNCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9f
O0l3ISFDVFJOS0E5d01nMEFSYnchajRCU0NuMmNpS0kyZ2RvUWdMRlRCMFlVZXk1dTZIaWVSYTZO
dldRdmFGN1hfbUVFeUhoQ0lzbHJGWUdCT1lFYldMYUUySjVrOFQtWE44VSQNCj4gPiArDQo+ID4g
K3RpdGxlOiBNZWRpYXRlayBtdDgxOTYgRFNQIGNvcmUNCj4gPiArDQo+ID4gK21haW50YWluZXJz
Og0KPiA+ICsgIC0gSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiAr
DQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+IA0KPiBEbyBub3QgbmVlZCAnfCcgdW5sZXNzIHlvdSBu
ZWVkIHRvIHByZXNlcnZlIGZvcm1hdHRpbmcuDQpXaWxsIHVwZGF0ZSBpbiB2MiwgdGh4Lg0KPiAN
Cj4gPiArICBTb21lIGJvYXJkcyBmcm9tIG10ODE5NiBjb250YWluIGEgRFNQIGNvcmUgdXNlZCBm
b3INCj4gDQo+IEJvYXJkcyBvciBNVDgxOTY/IElmIGJvYXJkcywgaG93IGlzIHRoaXMgcmVsYXRl
ZCB0byBTb0MgaW4gdGhlIGZpcnN0DQo+IHBsYWNlPyBUaHVzIHdyb25nIGNvbXBhdGlibGUuDQo+
IA0KPiA+ICsgIGFkdmFuY2VkIHByZS0gYW5kIHBvc3QtIGF1ZGlvIHByb2Nlc3NpbmcuDQo+ID4g
Kw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDog
bWVkaWF0ZWssbXQ4MTk2LWRzcA0KPiANCj4gSWYgdGhpcyBpcyBwYXJ0IG9mIHRoZSBTb0MsIHRo
ZW4gd3JvbmcgZGVzY3JpcHRpb24uDQpTdXJlLCBpdCB3aWxsIGJlIHVwZGF0ZWQgaW4gVjIgYXMg
Zm9sbG93czogDQpNZWRpYVRlayBtdDgxOTYgU29DIGNvbnRhaW5zIGEgRFNQIGNvcmUgdXNlZCBm
b3INCmFkdmFuY2VkIHByZS0gYW5kIHBvc3QtIGF1ZGlvIHByb2Nlc3NpbmcuDQo+IA0KPiA+ICsN
Cj4gPiArICByZWc6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
QWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgRFNQIENmZyByZWdpc3RlcnMNCj4gDQo+IHMvQWRkcmVz
cyBhbmQgc2l6ZSBvZiB0aGUvLw0KPiANCj4gV3JpdGUgY29uY2lzZSBhbmQgYWNjdXJhdGUgZGVz
Y3JpcHRpb24uIFRoaXMgY2Fubm90IGJlIGFueXRoaW5nIGVsc2UsDQo+IHNvDQo+IG5vIG5lZWQg
dG8gc3RhdGUgb2J2aW91cy4NCldpbGwgdXBkYXRlIGluIHYyLCB0aHguDQo+IA0KPiA+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBBZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBEU1AgU1JBTQ0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBBZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBEU1Agc2VjdXJlIHJl
Z2lzdGVycw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBBZGRyZXNzIGFuZCBzaXplIG9mIHRo
ZSBEU1AgYnVzIHJlZ2lzdGVycw0KPiA+ICsNCj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBp
dGVtczoNCj4gPiArICAgICAgLSBjb25zdDogY2ZnDQo+ID4gKyAgICAgIC0gY29uc3Q6IHNyYW0N
Cj4gPiArICAgICAgLSBjb25zdDogc2VjDQo+ID4gKyAgICAgIC0gY29uc3Q6IGJ1cw0KPiA+ICsN
Cj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogbXV4IGZvciBkc3AgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogMjZNIGNsb2Nr
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFEU1AgUExMIGNsb2NrDQo+ID4gKw0KPiA+ICsg
IGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGFkc3Bf
c2VsDQo+ID4gKyAgICAgIC0gY29uc3Q6IGNsazI2bQ0KPiA+ICsgICAgICAtIGNvbnN0OiBhZHNw
cGxsDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0K
PiA+ICsNCj4gPiArICBtYm94ZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogbWFpbGJveCBmb3IgcmVjZWl2aW5nIGF1ZGlvIERTUCByZXF1ZXN0cy4NCj4gPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogbWFpbGJveCBmb3IgdHJhbnNtaXR0aW5nIHJlcXVlc3RzIHRv
IGF1ZGlvDQo+ID4gRFNQLg0KPiA+ICsNCj4gPiArICBtYm94LW5hbWVzOg0KPiA+ICsgICAgaXRl
bXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHJ4DQo+ID4gKyAgICAgIC0gY29uc3Q6IHR4DQo+ID4g
Kw0KPiA+ICsgIG1lbW9yeS1yZWdpb246DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogZG1hIGJ1ZmZlciBiZXR3ZWVuIGhvc3QgYW5kIERTUC4NCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogRFNQIHN5c3RlbSBtZW1vcnkuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoN
Cj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+
ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBwb3dlci1kb21h
aW5zDQo+ID4gKyAgLSBtYm94LW5hbWVzDQo+ID4gKyAgLSBtYm94ZXMNCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAg
LSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTk2LWNsay5oPg0K
PiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE5Ni1wb3dlci5oPg0KPiA+
ICsgICAgYWRzcDogYWRzcEAxYTAwMDAwMCB7DQo+IA0KPiBEcm9wIHVudXNlZCBsYWJlbA0KV2ls
bCB1cGRhdGUgaW4gdjIsIHRoeC4NCj4gDQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTYtZHNwIjsNCj4gPiArICAgICAgICByZWcgPSA8MHgxYTAwMDAwMCAweDUwMDA+
LA0KPiA+ICsgICAgICAgICAgICAgIDwweDFhMjEwMDAwIDB4ODAwMDA+LA0KPiA+ICsgICAgICAg
ICAgICAgIDwweDFhMzQ1MDAwIDB4MzAwPiwNCj4gPiArICAgICAgICAgICAgICA8MHgxYTAwZjAw
MCAweDEwMDA+Ow0KPiA+ICsgICAgICAgIHJlZy1uYW1lcyA9ICJjZmciLCAic3JhbSIsICJzZWMi
LCAiYnVzIjsNCj4gPiArICAgICAgICBwb3dlci1kb21haW5zID0gPCZzY3BzeXMNCj4gPiBNVDgx
OTZfUE9XRVJfRE9NQUlOX0FEU1BfVE9QX0RPUk1BTlQ+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9
IDwmY2tzeXNfY2xrIENMS19DS19BRFNQX1NFTD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZj
a3N5c19jbGsgQ0xLX0NLX1RDS18yNk1fTVg5PiwNCj4gPiArICAgICAgICAgICAgICAgICA8JmNr
c3lzX2NsayBDTEtfQ0tfQURTUFBMTD47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAiYWRz
cF9zZWwiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgImNsazI2bSIsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAiYWRzcHBsbCI7DQo+ID4gKyAgICAgICAgbWJveC1uYW1lcyA9ICJy
eCIsICJ0eCI7DQo+ID4gKyAgICAgICAgbWJveGVzID0gPCZhZHNwX21haWxib3gwPiwgPCZhZHNw
X21haWxib3gxPjsNCj4gDQo+IFJldmVyc2Ugb3JkZXIgb2YgbWJveGVzIGFuZCBtYm94LW5hbWVz
IHByb3BlcnRpZXMuIHh4eC1uYW1lcyBmb2xsb3dzDQo+IHRoZQ0KPiB4eHguDQpXaWxsIHVwZGF0
ZSBpbiB2MiwgdGh4Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gTQ0K

