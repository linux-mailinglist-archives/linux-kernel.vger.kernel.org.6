Return-Path: <linux-kernel+bounces-352849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61C99252F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CAFB20E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10F161326;
	Mon,  7 Oct 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n2DjVXn9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AHJLpIFa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7C1531CC;
	Mon,  7 Oct 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284240; cv=fail; b=FF3ZdsoWRiQB391LO37rYhYo3EAo3UmpdUZqyDsCpvI0LokxYKYA5E4z9zvh52/Yt7witXuADhyNzfM6mOd99r4tCSinNIjhb/FyJjxPdwq775gA7RNLTwbHVZGClmzXsap61gRBDU7VBSECYTm0D+UD3P5JWguYEqeqpvY1nW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284240; c=relaxed/simple;
	bh=dQO11BAl5ZTu9gLk43Nj2fOouJVmNXQte1wNTTEriLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCnluqYCApjQtkKLZJSLmoNijAhE92Bmx0eJDegOjDKONOIbXQ0ibYq1U0hyOGFsjCc6Z2cayv2FDrU+mIhYv6koS6JGx29D7nBqP5RYZ5e20tKamjOIph6erJtNI1/bVuhyudPlrLrFkoAIgpTBRijMP1ilkNFo9mjixiBdv4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n2DjVXn9; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AHJLpIFa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 60f40afc847911efb66947d174671e26-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dQO11BAl5ZTu9gLk43Nj2fOouJVmNXQte1wNTTEriLo=;
	b=n2DjVXn9dYxYr9QsgwP2wOKiH9Of6SQoujXsqPEpTTxhssPbK78u/qsgkw0WF0gALVGEKV0hh3EOoMub/l1h1fz7Y9MwZ9dR4e/HzaJLsR/Jpu+wlv9V+nh/O7H/qwduMiN5G7HtvQOn8SLTllCkgLsjn9ASJn6Qxtd6haY+arg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d7f814cf-76b7-4fef-a39b-73069ea61ce7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e848dc40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 60f40afc847911efb66947d174671e26-20241007
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1378855188; Mon, 07 Oct 2024 14:57:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 14:57:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 14:57:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvd7S/PgFL4zb+edp6pWbEKBoYNj+VIcRYGlFkoIGQUHUs0h9xeK0v9WSYCYrWl2M91wagWC3KGr0ng7++4E4MN1ToyqNCNlI+iwLMn2ShvxEg4G7ZUEct5Gc6J48To9tL2mBq1+gjpBj9IWH8yDsaBhhhohGl/sQ6TH9nIgcTJxB+5R+xHdILZ9Q1udH4wNwo+4qP8P4BUcjze3JzO1Kv8UxJpL8JWuU7Y34uWKvoa37BWf/LwDd3d91x0V0wjPX2BJBTt4ZjYz4mCvOXH2aJ9F0bA+XOxG44Z1i6OZv4WJUujir1JKzT1e6WrLpGw2q9dg3GJW333S8xpEkGhnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQO11BAl5ZTu9gLk43Nj2fOouJVmNXQte1wNTTEriLo=;
 b=IkoJGmeCtabKm/BzlV9CLfbIInaz53zYPEm+zk0EfFV4GtVqLEZq6zvp8Aw7D6K+a8tx7gpbp2m6iXrb8skefxczJug1VCItzItzHemAlfefirRLsF3TTCf0w4JckVwf1wXTqo0CxnoS0/T8g5OQVs0siLFjxz338bolWUXKnu32z/C4gUgPAYYQ16E6UEcObVk4HIia0ogtpPv9RiK98aKpYE6tj1leTyr954sVCpU7IIMXOBSmtipo6HwQmojcHhnOvras+nZWWqtbqpKUSkod17d6Yr85nVNPOnUNnBQWfFym1dtnEbokcb24kPGSwABVro2iTfyLn+gGsubTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQO11BAl5ZTu9gLk43Nj2fOouJVmNXQte1wNTTEriLo=;
 b=AHJLpIFa3leBHgocXRRGRNiZKegbVGNkAYfbrrDEnfyO3UnTMV5SSLvZNbx2/ryVqKmc8twLJ2Hq5sAv3IDkMfi7j9jYDlAGkaPm+1pLPoO4gL7tn2Z9H56+Z8C7dYmi1SGmiAA7THVBzN+YDOBzyH4cztSGlYh1FADV5vAbpr4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6645.apcprd03.prod.outlook.com (2603:1096:400:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 06:57:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 06:57:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbA292H5spe39bB06Ujog96ornebJxzKIAgAAX5YCABFrkAIAASFgAgAR9nIA=
Date: Mon, 7 Oct 2024 06:57:08 +0000
Message-ID: <04f1506b23b41c775e0735b5b3189b4118500715.camel@mediatek.com>
References: <20240910105054.125005-1-angelogioacchino.delregno@collabora.com>
	 <01020191db8f22cd-0f5d733b-420e-453c-8607-a3e9f70f32d6-000000@eu-west-1.amazonses.com>
	 <e3953947f5cf05e8e6a2ec3448cf0c08a8c39c1c.camel@mediatek.com>
	 <56c4e87c-6774-4542-8ae7-dab89750081c@collabora.com>
	 <58ee09aeb5a224dbc8faee236ed1a77ce3fbd011.camel@mediatek.com>
	 <d704a5b0-d503-4e6b-b6ef-32909a9aea77@collabora.com>
In-Reply-To: <d704a5b0-d503-4e6b-b6ef-32909a9aea77@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6645:EE_
x-ms-office365-filtering-correlation-id: 59bce6cf-bebf-4bcb-481f-08dce69d42df
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGdJZkEyMitPSnhUbnkyUDhTUUJ0cTVzTnYxU0tCb1JmZ0pqTFBIbEJmdUJU?=
 =?utf-8?B?N2VnUFRPOEZiWkdTU1lmc096YjNNOFhRNFRkajEvZUVNZzJYNDVUNldSQ0F6?=
 =?utf-8?B?Rm1QM1h2QlljaW5OVXpQa2ZWOGsrZUk4TjhQcEhxWldXRG15TWxwNk55N2tx?=
 =?utf-8?B?UjNDTHlsa3VqN1I0NFdEQ0ljRURlRnpadEVSdlpROUpoMGttWDFMZDhjaHVU?=
 =?utf-8?B?V0Y0WlZicUtQVkpqSDMzY1JKUTh5bkJXUGloYkxNV3RRNzZVOWJpN0xjbmhs?=
 =?utf-8?B?c2d4cFNRRXZnSjdTTzFXeFlqaEhKR2tEeGlGTU5PSVMrTjdiaThPbXgvYmU0?=
 =?utf-8?B?ekFRUlhKNit2VHlra0wyVXdMU3FBUlhKUHlOOHFzVkxYY2NXWFJCUmpYc0cy?=
 =?utf-8?B?MmE1dXo2WStSdkYxRDBiTjROOWQ5MmgwNi9EeU5qaEtsbEpLTGRRdm5rVU5M?=
 =?utf-8?B?SHdJczJEVU81Qmx3YlVLRjg1VFF4OTY1TXptdmlabjA1d1BwdTMxUnBFWmIv?=
 =?utf-8?B?VVpDQk9vcWZYTlNhUEd6eDlieHFxYW5zaWdMZVMyNEhXbkg3RjBaTElnOTZ5?=
 =?utf-8?B?QTFZT0hrSUFOVlU5ZStSQ21aQXQzRWJXQzhteWVuQkt6aHVvaEVmL0NRUnlJ?=
 =?utf-8?B?ZWdGUmE1RkordEtHWXVVWWczM1o5M1ZOK1UwUkFBVURaY2Z2N01mT1hZcUVH?=
 =?utf-8?B?Skd3YVNTL3lQWDFTRGU1UHo0Mit4a1ZadGxDeFhaaG5WbVhwYWF0KzdQcVJj?=
 =?utf-8?B?MnNDMEVOTUtPN2xwZmI2TG1aNGJ4bS9udVArQkxBVjZsNnA3VUF3QTIwOHpW?=
 =?utf-8?B?QmM2d2p0K1BaODIwaUV3T3V1TkI4bVdEbTB5T2JFYkN5VnBzOVBQajVMV205?=
 =?utf-8?B?OUhQUTVpY1NqUUQxSDhZdGhDNmtucWszZjhPOWg1VllickVUWUxKMXlwYkdR?=
 =?utf-8?B?RWtIcFB4L2E4SU11TUtSVC9TdTg4bDgwZDJlcEZWWkk0Y0hRVytFbkRGM0d4?=
 =?utf-8?B?L0xyb3hUckhwZmhYNHBtd2dyQ0dZM0pad1l4Mm1yVjBteStTSHFVQjAyeXhD?=
 =?utf-8?B?QnM1Y25yT2tZTXMxc0gwR2Q3RVZocnQzL3JuM25FUFR5dmxjZ0Z3cjBGSjFj?=
 =?utf-8?B?aXNjTG1HZDNpbTg4VnVHQUQreE01VWE2b3dKQnh6amNhejF3TEg3dkc3bjI1?=
 =?utf-8?B?c0VxbDh6ejNrbXoxekRpRkdBMFJ2UnFYLzVtdk9JbmlSREhwSHFaamlmVlhq?=
 =?utf-8?B?bWlBaVo4YTdSSno5ZXBkMDduMC8xdmxsdm94R3UveXZEZ3UzRnVraitsRzYv?=
 =?utf-8?B?K2d3dDBneFJsTjNSUk5TMHFVMU9zZnFmNHA3N0R6ZEFwQ1Qrc2lleXVjYTFU?=
 =?utf-8?B?Z2REdUw1NzkwdHk0RFlYdlFDY1cwL2E1UkVqMUd5VUZhYzVGUU9GUm5teS9L?=
 =?utf-8?B?R0dXQmlWMkI2aTZ4Q21FR0tjb0MxNXhiTlNwb3VWV1lnNjZONy9wTXVnZ0pY?=
 =?utf-8?B?TlgrUEtLVHY2YzZqbnRoZ2N0Zm1sTTVjZmx5K2wxZjE5YlFTRWdzVFZwbEJ1?=
 =?utf-8?B?bk9KNGlWNE1xbklMdi83QysyenEzSnZPWTFiYWVuUlNJN1VvTy9CcHpkNDZX?=
 =?utf-8?B?NE91cVNBZ2VyeWduQTVTK24wTXV6M2dKMi9jZ0FnL2wvMXVXRmJZRGtoNTEy?=
 =?utf-8?B?ZnBDdE5KSEhWVG9rQUpnY1R3OW0vQitjTUVDekdoQkE3NGFGNGkzUEo3WFFR?=
 =?utf-8?B?REJ6K2w4eGRCZnJsSGhFUzBUOWhGNnZrMHZ1c3RyckxYYVo3Z2k0MHZRaXVX?=
 =?utf-8?B?Tyt4cjUzZEx5QVpxUmc2QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE90MzE4T1N5Mkt1UXNYVEE4dXBWRXNsTEZZMWtrZG1RaEg1MUtodFJRMlFh?=
 =?utf-8?B?ZUhlckpXU3EzNzN3R3F3ZmZtMzBnd3hIeUcvOGFSbG41SU9NNStHTVVTaVJW?=
 =?utf-8?B?dGwycHJlYkdka2JSbEVkZWI1alFLSFp0MmVYYWlkZ0NDZ0NvWU9PZ1hSR090?=
 =?utf-8?B?cTVxL3pGbjNIUm1LbUlKTWlIMXhFOURmWHhxOWlPWG9FTzVjRkRYR1MxOE5J?=
 =?utf-8?B?dE1QTzUwSkliK2hzbnE5UmxwWEg0NlNvQW1rQjJqb1MrRkpMb3ExV2ZWZGRC?=
 =?utf-8?B?QzAzc3Y2ZE9tRU5xdmoza1pQcHlaeTZJdU1yV1NNVkxMdllId0grOGN2aGRU?=
 =?utf-8?B?dytWd0VQc3Z1d0FDUC9MdDlCMVI5d0tuTVRnVjRkQjl0TTlDY0xFNEY4TDdu?=
 =?utf-8?B?empqNFNSSVQ2VWFSeWRqdmtvL1Y5WlB3WlNHMmU0NVNvNStReC9sSzFKOVRU?=
 =?utf-8?B?M3BaOUlQSUEvMlJINHR5TXZqUnZZeTR2ajlBMWJ0L3gzYi9xUGd3OXg4WU5Z?=
 =?utf-8?B?QnlvYW9NQi9FNG4rRzV2VTM2R25SYk5wSmMveFdLenlreXJSN095Tnc1Z3l6?=
 =?utf-8?B?KzBKUjIvY3oxWE5Fa1JTaEpSRHROTmU1QTFvRWQzbUVQQm5CYkNqUElhRDRS?=
 =?utf-8?B?VUpFaVNhTWNpOFBVMWZNOW9ydVloMDJNQTJaWWphUU5GRmRFUUZDclNEV0VB?=
 =?utf-8?B?T3VwQjB3NU9PRnovdHh0eXhWazl5ZE50VG14ZlhUQklVUHV2eWVGV2wzcEpk?=
 =?utf-8?B?OWtyUDJvY3diK2pscFNyL0o5Qk9uWmI5N2FwRnIrWUhJRFNQL2thMm9RL3pE?=
 =?utf-8?B?YjNOWjhaQnJVa0tuNWVQcUlDb1VqcW5lb1JXQTZ2cjYwOWdqY05HYlpEdzZJ?=
 =?utf-8?B?WERVUFNBSExpQ0FVVXJuSDhuRU1lL2RqbXRvRmlBZnhOZmZtR3RtWTd0dVc0?=
 =?utf-8?B?VlBTQWlKVFRKRE1ZcnE5dHd3YTBNbFc2YWIybHdnWEFZY0V0MTlvOWNaWnpk?=
 =?utf-8?B?Vjg1T3hlVCtWaUprQmVrYS9JRzhRNzFoVER5Rm1GR0FIQkdUN1FRb1ZtczNr?=
 =?utf-8?B?cVRIQk0rc1F4TXpOWlFsSmhFKzVMZWNwNnFWKzFhTjQ2dXRyTzcxTWtNMnVu?=
 =?utf-8?B?SWVrc29RcnR4b3YrZzFsQVloYXBZeE0xSTcya0RJS1dKbWZRYkVzN2krODFR?=
 =?utf-8?B?WVUzK3FkWUFTWlUvNVRvZS9LQ2ZxL3ptSmVqcFViOE5rb3lJZnlvZm1iS0Rt?=
 =?utf-8?B?SHVBQ05KcmszWUIxWE5Sb0RMUmFBa1JVY1RDSkpqNlJ3ZWJqNTdGb1lzR0h5?=
 =?utf-8?B?R042SDJkZFpxdkNmZTU2ZnkrNGN6Y0M2RmJ6M3ZMeWdGN2YzK1J6cEhzWjNu?=
 =?utf-8?B?ckhqbGRrUWFLRW8vMkc4N3ROd1hkTHJ6SkpRMHl0Ym1ISkJ5Zm5TM3ZjK3My?=
 =?utf-8?B?WHhmUXhySklDTnpLUnFmQlZIKzBVUWQ2bkU3M3ZrL2JoeWNJWDA4cldJc0VB?=
 =?utf-8?B?U1B1aDRBYmpnWnpoVnRsbWF1OXNnZHhFdkJKaG1KZzA3c1pKelZrNmRjUDkz?=
 =?utf-8?B?Y0cxcnFaNzFZUUJ1cjVVYm4wbEErTGU4aXRKOGxuVVlScjhGS1Ayd3BWTVNy?=
 =?utf-8?B?TDRqMWtlbVBOdDZXVGYxc1cveWNXNmxMeXI0NVk4NXBpUm5BVUxSZ2ZSM0VG?=
 =?utf-8?B?ZDZWTyt1RFQ1d0E1N01IaGRMNDdSMC9kL2tzejRMUUVwYWxsTWxwci9QZnFu?=
 =?utf-8?B?OVhtcHYwRnJOL3dMQ1crdVVXd0phb0h5MFVoTFRBTTBZbkw1VU9VZUs5Z1lR?=
 =?utf-8?B?bExTK3IwODRYTlc4TG53bDdsYUd2RHlZeWFiYS9MZytlNFBxYUVYWFhjWGh3?=
 =?utf-8?B?NUpVQlpHZVZja29KT3RUdGNGTGcvMEJGc2t2R3VJWURTbG1yYnp4blhPeFZU?=
 =?utf-8?B?dmw1K25kSUNvNWFBdzMxS21GYXpTeG1jcjdUWjBIZm1OWFJGalJ2ODBSVUt1?=
 =?utf-8?B?NVd6V2RhUHJKajdzWXFRNjM1NHljaUU5cnUySkJZOUkvT0FQWXdOdkw5RVN1?=
 =?utf-8?B?RzdoWC85THo4c0RzSzhwdG5oMktkWGNJTE1EMkJ4VS9hZVFwamdNS3YrWk1X?=
 =?utf-8?Q?Q8MN+aHrB488y6nFYxOwHQP7D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AB2CBB8F75AA94F92D432212C5D5F04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bce6cf-bebf-4bcb-481f-08dce69d42df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 06:57:08.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqCGuLWNZKQO6DAh1xRO92aUPnWBjlPLkr4hgml0BIpamgbuV63AeFnSaiyLNZejkCCrFan8RDLGtsjLpToeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6645

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDI0LTEwLTA0IGF0IDEyOjIyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDQvMTAvMjQgMDg6MDMsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUs
IDIwMjQtMTAtMDEgYXQgMTM6MzMgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdy
b3RlOg0KPiA+ID4gSWwgMDEvMTAvMjQgMTI6MDcsIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNjcml0
dG86DQo+ID4gPiA+IEhpLCBBbmdlbG86DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBUdWUsIDIwMjQt
MDktMTAgYXQgMTA6NTEgKzAwMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0K
PiA+ID4gPiA+IEl0IGlzIGltcG9zc2libGUgdG8gYWRkIGVhY2ggYW5kIGV2ZXJ5IHBvc3NpYmxl
IEREUCBwYXRoIGNvbWJpbmF0aW9uDQo+ID4gPiA+ID4gZm9yIGVhY2ggYW5kIGV2ZXJ5IHBvc3Np
YmxlIGNvbWJpbmF0aW9uIG9mIFNvQyBhbmQgYm9hcmQ6IHJpZ2h0IG5vdywNCj4gPiA+ID4gPiB0
aGlzIGRyaXZlciBoYXJkY29kZXMgY29uZmlndXJhdGlvbiBmb3IgMTAgU29DcyBhbmQgdGhpcyBp
cyBnb2luZyB0bw0KPiA+ID4gPiA+IGdyb3cgbGFyZ2VyIGFuZCBsYXJnZXIsIGFuZCB3aXRoIG5l
dyBoYWNrcyBsaWtlIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCj4gPiA+ID4gPiBtdGtfZHJtX3JvdXRl
IHdoaWNoIGlzIGFueXdheSBub3QgZW5vdWdoIGZvciBhbGwgZmluYWwgcm91dGVzIGFzIHRoZQ0K
PiA+ID4gPiA+IERTSSBjYW5ub3QgYmUgY29ubmVjdGVkIHRvIE1FUkdFIGlmIGl0J3Mgbm90IGEg
ZHVhbC1EU0ksIG9yIGVuYWJsaW5nDQo+ID4gPiA+ID4gRFNDIHByZXZlbnRpdmVseSBkb2Vzbid0
IHdvcmsgaWYgdGhlIGRpc3BsYXkgZG9lc24ndCBzdXBwb3J0IGl0LCBvcg0KPiA+ID4gPiA+IG90
aGVycy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSBwcmFjdGljYWxseSBhbGwgZGlzcGxh
eSBJUHMgaW4gTWVkaWFUZWsgU29DcyBzdXBwb3J0IGJlaW5nDQo+ID4gPiA+ID4gaW50ZXJjb25u
ZWN0ZWQgd2l0aCBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIG90aGVyLCBvciB0aGUgc2FtZSwgSVBz
DQo+ID4gPiA+ID4gb3Igd2l0aCBkaWZmZXJlbnQgSVBzIGFuZCBpbiBkaWZmZXJlbnQgY29tYmlu
YXRpb25zLCB0aGUgZmluYWwgRERQDQo+ID4gPiA+ID4gcGlwZWxpbmUgaXMgZWZmZWN0aXZlbHkg
YSBib2FyZCBzcGVjaWZpYyBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElt
cGxlbWVudCBPRiBncmFwaHMgc3VwcG9ydCB0byB0aGUgbWVkaWF0ZWstZHJtIGRyaXZlcnMsIGFs
bG93aW5nIHRvDQo+ID4gPiA+ID4gc3RvcCBoYXJkY29kaW5nIHRoZSBwYXRocywgYW5kIHByZXZl
bnRpbmcgdGhpcyBkcml2ZXIgdG8gZ2V0IGEgaHVnZQ0KPiA+ID4gPiA+IGFtb3VudCBvZiBhcnJh
eXMgZm9yIGVhY2ggYm9hcmQgYW5kIFNvQyBjb21iaW5hdGlvbiwgYWxzbyBwYXZpbmcgdGhlDQo+
ID4gPiA+ID4gd2F5IHRvIHNoYXJlIHRoZSBzYW1lIG10a19tbXN5c19kcml2ZXJfZGF0YSBiZXR3
ZWVuIG11bHRpcGxlIFNvQ3MsDQo+ID4gPiA+ID4gbWFraW5nIGl0IG1vcmUgc3RyYWlnaHRmb3J3
YXJkIHRvIGFkZCBzdXBwb3J0IGZvciBuZXcgY2hpcHMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
UmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+
ID4gPiA+ID4gVGVzdGVkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUu
Y29tPg0KPiA+ID4gPiA+IEFja2VkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1aS5qaW5nZmVuZ0BsaW51
eC5kZXY+DQo+ID4gPiA+ID4gVGVzdGVkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVs
Lm9yZz4gIyBvbiBrb250cm9uLXNiYy1pMTIwMA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBbc25pcF0NCj4gPiA+
ID4gDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtib29sIG10a19vdmxfYWRhcHRvcl9pc19jb21w
X3ByZXNlbnQoc3RydWN0IGRldmljZV9ub2RlICpub2RlKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+
ID4gKwllbnVtIG10a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgdHlwZTsNCj4gPiA+ID4gPiArCWlu
dCByZXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0ID0gb3ZsX2FkYXB0b3Jfb2ZfZ2V0
X2RkcF9jb21wX3R5cGUobm9kZSwgJnR5cGUpOw0KPiA+ID4gPiA+ICsJaWYgKHJldCkNCj4gPiA+
ID4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJaWYgKHR5cGUg
Pj0gT1ZMX0FEQVBUT1JfVFlQRV9OVU0pDQo+ID4gPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qDQo+ID4gPiA+ID4gKwkgKiBFVEhEUiBhbmQgUGFkZGlu
ZyBhcmUgdXNlZCBleGNsdXNpdmVseSBpbiBPVkwgQWRhcHRvcjogaWYgdGhpcw0KPiA+ID4gPiA+
ICsJICogY29tcG9uZW50IGlzIG5vdCBvbmUgb2YgdGhvc2UsIGl0J3MgbGlrZWx5IG5vdCBhbiBP
VkwgQWRhcHRvciBwYXRoLg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGRv
bid0IGtub3cgeW91ciBsb2dpYyBoZXJlLg0KPiA+ID4gPiBUaGUgT1ZMIEFkYXB0b3IgcGlwZWxp
bmUgaXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBtZHBfcmRtYSAtPiBwYWRkaW5nIC0tLSsgICAgICAr
LS0tLS0tLSsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICBNZXJnZSAtPiB8ICAgICAg
IHwNCj4gPiA+ID4gbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAgfCAgICAgICB8DQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8DQo+ID4gPiA+IG1k
cF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAgICAgIHwgICAgICAgfA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgIE1lcmdlIC0+IHwgICAgICAgfA0KPiA+ID4gPiBtZHBfcmRtYSAtPiBwYWRk
aW5nIC0tLSsgICAgICB8ICAgICAgIHwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IEVUSERSIHwNCj4gPiA+ID4gbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAg
fCAgICAgICB8DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgTWVyZ2UgLT4gfCAgICAg
ICB8DQo+ID4gPiA+IG1kcF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAgICAgIHwgICAgICAgfA0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfA0KPiA+ID4gPiBt
ZHBfcmRtYSAtPiBwYWRkaW5nIC0tLSsgICAgICB8ICAgICAgIHwNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICBNZXJnZSAtPiB8ICAgICAgIHwNCj4gPiA+ID4gbWRwX3JkbWEgLT4gcGFk
ZGluZyAtLS0rICAgICAgKy0tLS0tLS0rDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBtZHBfcmRtYSBh
bmQgbWVyZ2UgaXMgbm90IE9WTCBBZGFwdG9yPw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWWVz
LCBhbmQgaW4gZGV2aWNlIHRyZWUsIHlvdSBleHByZXNzIHRoYXQgZXhhY3RseSBsaWtlIHlvdSBq
dXN0IHBpY3R1cmVkLg0KPiA+ID4gDQo+ID4gPiBPVkwgQWRhcHRvciBpcyB0cmVhdGVkIGxpa2Ug
YSBzb2Z0d2FyZSBjb21wb25lbnQgaW50ZXJuYWxseSwgYW5kIG1hbmFnZXMNCj4gPiA+IGl0cyBv
d24gbWVyZ2UgcGlwZXMgZXhhY3RseSBsaWtlIGJlZm9yZSB0aGlzIGNvbW1pdC4NCj4gPiA+IA0K
PiA+ID4gSW4gY2FzZSB0aGVyZSB3aWxsIGJlIGFueSBuZWVkIHRvIGV4cHJlc3MgT1ZMIEFkYXB0
b3IgYXMgaGFyZHdhcmUgY29tcG9uZW50LA0KPiA+ID4gaXQgd2lsbCBiZSBwb3NzaWJsZSB0byBk
byBzbyB3aXRoIG5vIG1vZGlmaWNhdGlvbiB0byB0aGUgYmluZGluZ3MuDQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+ID4gKwlyZXR1cm4gdHlwZSA9PSBPVkxfQURBUFRPUl9UWVBFX0VUSERSIHx8
IHR5cGUgPT0gT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICAgIA0KPiA+ID4gPiANCj4gPiA+ID4gW3NuaXBdDQo+ID4gPiA+IA0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAqIG10a19kcm1fb2ZfZGRw
X3BhdGhfYnVpbGRfb25lIC0gQnVpbGQgYSBEaXNwbGF5IEhXIFBpcGVsaW5lIGZvciBhIENSVEMg
UGF0aA0KPiA+ID4gPiA+ICsgKiBAZGV2OiAgICAgICAgICBUaGUgbWVkaWF0ZWstZHJtIGRldmlj
ZQ0KPiA+ID4gPiA+ICsgKiBAY3BhdGg6ICAgICAgICBDUlRDIFBhdGggcmVsYXRpdmUgdG8gYSBW
RE8gb3IgTU1TWVMNCj4gPiA+ID4gPiArICogQG91dF9wYXRoOiAgICAgUG9pbnRlciB0byBhbiBh
cnJheSB0aGF0IHdpbGwgY29udGFpbiB0aGUgbmV3IHBpcGVsaW5lDQo+ID4gPiA+ID4gKyAqIEBv
dXRfcGF0aF9sZW46IE51bWJlciBvZiBlbnRyaWVzIGluIHRoZSBwaXBlbGluZSBhcnJheQ0KPiA+
ID4gPiA+ICsgKg0KPiA+ID4gPiA+ICsgKiBNZWRpYVRlayBTb0NzIGNhbiB1c2UgZGlmZmVyZW50
IEREUCBoYXJkd2FyZSBwaXBlbGluZXMgKG9yIHBhdGhzKSBkZXBlbmRpbmcNCj4gPiA+ID4gPiAr
ICogb24gdGhlIGJvYXJkLXNwZWNpZmljIGRlc2lyZWQgZGlzcGxheSBjb25maWd1cmF0aW9uOyB0
aGlzIGZ1bmN0aW9uIHdhbGtzDQo+ID4gPiA+ID4gKyAqIHRocm91Z2ggYWxsIG9mIHRoZSBvdXRw
dXQgZW5kcG9pbnRzIHN0YXJ0aW5nIGZyb20gYSBWRE8gb3IgTU1TWVMgaGFyZHdhcmUNCj4gPiA+
ID4gPiArICogaW5zdGFuY2UgYW5kIGJ1aWxkcyB0aGUgcmlnaHQgcGlwZWxpbmUgYXMgc3BlY2lm
aWVkIGluIGRldmljZSB0cmVlcy4NCj4gPiA+ID4gPiArICoNCj4gPiA+ID4gPiArICogUmV0dXJu
Og0KPiA+ID4gPiA+ICsgKiAqICUwICAgICAgIC0gRGlzcGxheSBIVyBQaXBlbGluZSBzdWNjZXNz
ZnVsbHkgYnVpbHQgYW5kIHZhbGlkYXRlZA0KPiA+ID4gPiA+ICsgKiAqICUtRU5PRU5UIC0gRGlz
cGxheSBwaXBlbGluZSB3YXMgbm90IHNwZWNpZmllZCBpbiBkZXZpY2UgdHJlZQ0KPiA+ID4gPiA+
ICsgKiAqICUtRUlOVkFMIC0gRGlzcGxheSBwaXBlbGluZSBidWlsdCBidXQgdmFsaWRhdGlvbiBm
YWlsZWQNCj4gPiA+ID4gPiArICogKiAlLUVOT01FTSAtIEZhaWx1cmUgdG8gYWxsb2NhdGUgcGlw
ZWxpbmUgYXJyYXkgdG8gcGFzcyB0byB0aGUgY2FsbGVyDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4g
PiA+ICtzdGF0aWMgaW50IG10a19kcm1fb2ZfZGRwX3BhdGhfYnVpbGRfb25lKHN0cnVjdCBkZXZp
Y2UgKmRldiwgZW51bSBtdGtfY3J0Y19wYXRoIGNwYXRoLA0KPiA+ID4gPiA+ICsJCQkJCSBjb25z
dCB1bnNpZ25lZCBpbnQgKipvdXRfcGF0aCwNCj4gPiA+ID4gPiArCQkJCQkgdW5zaWduZWQgaW50
ICpvdXRfcGF0aF9sZW4pDQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbmV4dCwgKnByZXYsICp2ZG8gPSBkZXYtPnBhcmVudC0+b2Zfbm9kZTsNCj4gPiA+ID4g
PiArCXVuc2lnbmVkIGludCB0ZW1wX3BhdGhbRERQX0NPTVBPTkVOVF9EUk1fSURfTUFYXSA9IHsg
MCB9Ow0KPiA+ID4gPiA+ICsJdW5zaWduZWQgaW50ICpmaW5hbF9kZHBfcGF0aDsNCj4gPiA+ID4g
PiArCXVuc2lnbmVkIHNob3J0IGludCBpZHggPSAwOw0KPiA+ID4gPiA+ICsJYm9vbCBvdmxfYWRh
cHRvcl9jb21wX2FkZGVkID0gZmFsc2U7DQo+ID4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiArCS8qIEdldCB0aGUgZmlyc3QgZW50cnkgZm9yIHRoZSB0ZW1wX3BhdGgg
YXJyYXkgKi8NCj4gPiA+ID4gPiArCXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9lcF9jaWQodmRv
LCAwLCBjcGF0aCwgJm5leHQsICZ0ZW1wX3BhdGhbaWR4XSk7DQo+ID4gPiA+ID4gKwlpZiAocmV0
KSB7DQo+ID4gPiA+ID4gKwkJaWYgKG5leHQgJiYgdGVtcF9wYXRoW2lkeF0gPT0gRERQX0NPTVBP
TkVOVF9EUk1fT1ZMX0FEQVBUT1IpIHsNCj4gPiA+ID4gDQo+ID4gPiA+IG1kcF9yZG1hIHdvdWxk
IG5vdCBiZSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUi4NCj4gPiA+IA0KPiA+ID4gVGhp
cyBwaWVjZSBvZiBjb2RlIGp1c3QgYXZvaWRzIGFkZGluZyBPVkxfQURBUFRPUiBtb3JlIHRoYW4g
b25jZSB0byB0aGUgcGlwZWxpbmUuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gKwkJCWRl
dl9kYmcoZGV2LCAiQWRkaW5nIE9WTCBBZGFwdG9yIGZvciAlcE9GXG4iLCBuZXh0KTsNCj4gPiA+
ID4gPiArCQkJb3ZsX2FkYXB0b3JfY29tcF9hZGRlZCA9IHRydWU7DQo+ID4gPiA+ID4gKwkJfSBl
bHNlIHsNCj4gPiA+ID4gPiArCQkJaWYgKG5leHQpDQo+ID4gPiA+ID4gKwkJCQlkZXZfZXJyKGRl
diwgIkludmFsaWQgY29tcG9uZW50ICVwT0ZcbiIsIG5leHQpOw0KPiA+ID4gPiA+ICsJCQllbHNl
DQo+ID4gPiA+ID4gKwkJCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBmaW5kIGZpcnN0IGVuZHBvaW50
IGZvciBwYXRoICVkXG4iLCBjcGF0aCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiA+ICsJCX0NCj4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiArCWlkeCsr
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qDQo+ID4gPiA+ID4gKwkgKiBXYWxrIHRocm91
Z2ggcG9ydCBvdXRwdXRzIHVudGlsIHdlIHJlYWNoIHRoZSBsYXN0IHZhbGlkIG1lZGlhdGVrLWRy
bSBjb21wb25lbnQuDQo+ID4gPiA+ID4gKwkgKiBUbyBiZSB2YWxpZCwgdGhpcyBtdXN0IGVuZCB3
aXRoIGFuICJpbnZhbGlkIiBjb21wb25lbnQgdGhhdCBpcyBhIGRpc3BsYXkgbm9kZS4NCj4gPiA+
ID4gPiArCSAqLw0KPiA+ID4gPiA+ICsJZG8gew0KPiA+ID4gPiA+ICsJCXByZXYgPSBuZXh0Ow0K
PiA+ID4gPiA+ICsJCXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9lcF9jaWQobmV4dCwgMSwgY3Bh
dGgsICZuZXh0LCAmdGVtcF9wYXRoW2lkeF0pOw0KPiA+ID4gPiA+ICsJCW9mX25vZGVfcHV0KHBy
ZXYpOw0KPiA+ID4gPiA+ICsJCWlmIChyZXQpIHsNCj4gPiA+ID4gPiArCQkJb2Zfbm9kZV9wdXQo
bmV4dCk7DQo+ID4gPiA+ID4gKwkJCWJyZWFrOw0KPiA+ID4gPiA+ICsJCX0NCj4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gKwkJLyoNCj4gPiA+ID4gPiArCQkgKiBJZiB0aGlzIGlzIGFuIE9WTCBhZGFw
dG9yIGV4Y2x1c2l2ZSBjb21wb25lbnQgYW5kIG9uZSBvZiB0aG9zZQ0KPiA+ID4gPiA+ICsJCSAq
IHdhcyBhbHJlYWR5IGFkZGVkLCBkb24ndCBhZGQgYW5vdGhlciBpbnN0YW5jZSBvZiB0aGUgZ2Vu
ZXJpYw0KPiA+ID4gPiA+ICsJCSAqIEREUF9DT01QT05FTlRfT1ZMX0FEQVBUT1IsIGFzIHRoaXMg
aXMgdXNlZCBvbmx5IHRvIGRlY2lkZSB3aGV0aGVyDQo+ID4gPiA+ID4gKwkJICogdG8gcHJvYmUg
dGhhdCBjb21wb25lbnQgbWFzdGVyIGRyaXZlciBvZiB3aGljaCBvbmx5IG9uZSBpbnN0YW5jZQ0K
PiA+ID4gPiA+ICsJCSAqIGlzIG5lZWRlZCBhbmQgcG9zc2libGUuDQo+ID4gPiA+ID4gKwkJICov
DQo+ID4gPiA+ID4gKwkJaWYgKHRlbXBfcGF0aFtpZHhdID09IEREUF9DT01QT05FTlRfRFJNX09W
TF9BREFQVE9SKSB7DQo+ID4gPiA+IA0KPiA+ID4gPiBtZXJnZSB3b3VsZCBub3QgYmUgRERQX0NP
TVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IuDQo+ID4gPiA+IEZpbmFsbHksIHRoZSBwYXRoIHdvdWxk
IGJlOg0KPiA+ID4gPiANCj4gPiA+ID4gbWRwX3JkbWEgLT4gb3ZsIGFkYXB0b3IgKHBhZGRpbmcp
IC0+IG1lcmdlIC0+IChldGhkciBpcyBza2lwcGVkIGhlcmUpIC4uLg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gQWdhaW4sIHRoZSBwYXRoIGluIHRoZSBPRiBncmFwaCBpcyBleHByZXNzZWQgZXhh
Y3RseSBsaWtlIHlvdSBzYWlkLg0KPiA+IA0KPiA+IEkga25vdyB0aGUgT0YgZ3JhcGggaXMgZXhw
cmVzc2VkIGxpa2UgSSBzYWlkLg0KPiA+IEJ1dCBJIGNhcmUgYWJvdXQgdGhlIHBhdGggaW4gZHJp
dmVyIHNob3VsZCBsaWtlIHRoaXM6DQo+IA0KPiBPaywgbm93IEkgdW5kZXJzdGFuZCB5b3VyIGNv
bmNlcm4uDQo+IA0KPiA+IA0KPiA+IHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgbXQ4MTk1X210
a19kZHBfZXh0W10gPSB7DQo+ID4gICAgICAgICAgRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBU
T1IsDQo+ID4gICAgICAgICAgRERQX0NPTVBPTkVOVF9NRVJHRTUsDQo+ID4gICAgICAgICAgRERQ
X0NPTVBPTkVOVF9EUF9JTlRGMSwNCj4gPiB9Ow0KPiA+IA0KPiA+IEluIE9GIGdyYXBoLCB0aGUg
Zmlyc3QgY29tcG9uZW50IGlzIG1kcF9yZG1hIGFuZCBtdGtfb3ZsX2FkYXB0b3JfaXNfY29tcF9w
cmVzZW50KCkgd291bGQgcmV0dXJuIGZhbHNlIGZvciBtZHBfcmRtYS4NCj4gPiBTbyBJIHRoaW5r
IHRoaXMgd291bGQgbWFrZSBtdGtfZHJtX29mX2RkcF9wYXRoX2J1aWxkX29uZSgpIHJldHVybiBl
cnJvciBhbmQgdGhlIHBhdGggaXMgbm90IGNyZWF0ZWQuDQo+ID4gSWYgSSdtIHdyb25nLCBwbGVh
c2UgZXhwbGFpbiBob3cgdGhpcyBjb2RlIHdvdWxkIHJlc3VsdCBpbiB0aGUgcGF0aCBsaWtlIG10
ODE5NV9tdGtfZGRwX2V4dFtdLg0KPiA+IA0KPiANCj4gVGhlIE1EUF9SRE1BIHVzYWdlIGluIG10
a19kaXNwX292bF9hZGFwdG9yIGlzIGhhcmRjb2RlZDogaW4gZnVuY3Rpb24NCj4gbXRrX292bF9h
ZGFwdG9yX2xheWVyX2NvbmZpZygpLCB0aGUgcmRtYV9sL3IgYXJlIGFsd2F5cyBPVkxfQURBUFRP
Ul9NRFBfUkRNQXgsDQo+IHRoZW4gZnVuY3Rpb24gbXRrX292bF9hZGFwdG9yX2RtYV9kZXZfZ2V0
KCksIGFsd2F5cyByZXR1cm5zIHRoZSBNRFBfUkRNQTANCj4gY29tcG9uZW50LCBzYW1lIGZvciBt
dGtfb3ZsX2FkYXB0b3JfZ2V0X3tudW1fZm9ybWF0cyxmb3JtYXRzfSgpIHdoaWNoIGFsd2F5cw0K
PiBjYWxsIG10a19tZHBfcmRtYV9nZXRfZm9ybWF0cygpIGZvciBPVkxfQURBUFRPUl9NRFBfUkRN
QTAuDQo+IA0KPiBJIGhhdmUganVzdCByZWNoZWNrZWQgaG93IEkgZXhwcmVzc2VkIHRoZSBwYXRo
IGZvciBNVDgxOTUgVG9tYXRvLCB3aGVyZSB0aGUNCj4gZXh0ZXJuYWwgZGlzcGxheSB3b3JrcyB3
aXRoIE9GIEdyYXBocywgYW5kIGl0IHdhcyBtaXNzaW5nIE1EUF9SRE1BIGVudGlyZWx5Lg0KPiAN
Cj4gVGhlIHBhdGggd2FzIGV0aGRyIC0+IG1lcmdlIC0+IGRwX2ludGYxIC4uLiBhbmQgaXQgc2hv
dWxkIGJlIG1kcF9yZG1hIC0+IChldGMpLg0KPiANCj4gRWZmZWN0aXZlbHksIHRoYXQgaXMgaW5k
ZWVkIHdyb25nLCBhcyBhbGwgb2YgdGhlIHN0ZXBzIG11c3QgYmUgZXhwcmVzc2VkDQo+IGluc2lk
ZSBvZiB0aGUgZ3JhcGguDQo+IA0KPiBTaW5jZSB0aGUgT1ZMIEFkYXB0b3IncyBSRE1BIGluc3Rh
bmNlcycgY29tcGF0aWJsZSBzdHJpbmdzIGRvICpub3QqIGNvbGxpZGUNCj4gd2l0aCB0aGUgb3Ro
ZXJzLCBhcyBPVkwgQWRhcHRvciB1c2VzIGNvbXBhdGlibGUgbWVkaWF0ZWssbXQ4MTk1LXZkbzEt
cmRtYSwNCj4gYW5kIHRoZSByZWd1bGFyIG9uZSB1c2VzIGNvbXBhdGlibGUgbWVkaWF0ZWssbXQ4
MTk1LWRpc3AtcmRtYSwgd2UgY2FuIHJlc29sdmUNCj4gdGhpcyBpc3N1ZSBieSBjaGFuZ2luZyBm
dW5jdGlvbiBtdGtfb3ZsX2FkYXB0b3JfaXNfY29tcF9wcmVzZW50KCkNCj4gDQo+IGZyb20NCj4g
DQo+IHJldHVybiB0eXBlID09IE9WTF9BREFQVE9SX1RZUEVfRVRIRFIgfHwgdHlwZSA9PSBPVkxf
QURBUFRPUl9UWVBFX1BBRERJTkc7DQo+IA0KPiB0bw0KPiANCj4gcmV0dXJuIHR5cGUgPT0gT1ZM
X0FEQVBUT1JfVFlQRV9FVEhEUiB8fCB0eXBlID09IE9WTF9BREFQVE9SX1RZUEVfUEFERElORyB8
fA0KPiAgICAgICAgIHR5cGUgPT0gT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQTsNCj4gDQo+IGlz
IHRoYXQgb2theSBmb3IgeW91Pw0KDQpJIGp1c3Qgd2FudCB0aGUgcGF0aCB0byBiZSBsaWtlIG10
ODE5NV9tdGtfZGRwX2V4dFtdLiBJZiBzbywgSSdtIG9rLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAN
Cj4gPiBJZiB5b3UgZG9lcyBub3QgdGVzdCB0aGlzIHdpdGggbXQ4MTk1IGV4dGVybmFsIGRpc3Bs
YXkgcGF0aCwgbWF5YmUgd2UgY291bGQganVzdCBkcm9wIHRoZSBjb2RlIGFib3V0IE9WTCBhZGFw
dG9yIHdpdGggYSBUT0RPIGNvbW1lbnQuDQo+ID4gDQo+IA0KPiBBbmQgeWVzLCBhcyBJIHNhaWQs
IGV4dGVybmFsIGRpc3BsYXkgcGF0aHMgd2VyZSB0ZXN0ZWQgb24gODE5NSwgYWN0dWFsbHkgYm90
aA0KPiBvbiBLb250cm9uIGkxMjAwIGJ5IE1pY2hhZWwgV2FsbGUgYW5kIG9uIE1UODE5NSBUb21h
dG8gYnkgbXlzZWxmLg0KPiANCj4gVGhhbmtzIGFnYWluLA0KPiBBbmdlbG8NCj4gDQo+ID4gUmVn
YXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQW5nZWxv
DQo+ID4gPiANCj4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gQ0sNCj4gPiA+ID4gDQo+ID4gPiA+
ID4gKwkJCWlmICghb3ZsX2FkYXB0b3JfY29tcF9hZGRlZCkNCj4gPiA+ID4gPiArCQkJCW92bF9h
ZGFwdG9yX2NvbXBfYWRkZWQgPSB0cnVlOw0KPiA+ID4gPiA+ICsJCQllbHNlDQo+ID4gPiA+ID4g
KwkJCQlpZHgtLTsNCj4gPiA+ID4gPiArCQl9DQo+ID4gPiA+ID4gKwl9IHdoaWxlICgrK2lkeCA8
IEREUF9DT01QT05FTlRfRFJNX0lEX01BWCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJLyoN
Cj4gPiA+ID4gPiArCSAqIFRoZSBkZXZpY2UgY29tcG9uZW50IG1pZ2h0IG5vdCBiZSBlbmFibGVk
OiBpbiB0aGF0IGNhc2UsIGRvbid0DQo+ID4gPiA+ID4gKwkgKiBjaGVjayB0aGUgbGFzdCBlbnRy
eSBhbmQganVzdCByZXBvcnQgdGhhdCB0aGUgZGV2aWNlIGlzIG1pc3NpbmcuDQo+ID4gPiA+ID4g
KwkgKi8NCj4gPiA+ID4gPiArCWlmIChyZXQgPT0gLUVOT0RFVikNCj4gPiA+ID4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qIElmIHRoZSBsYXN0IGVudHJ5IGlz
IG5vdCBhIGZpbmFsIGRpc3BsYXkgb3V0cHV0LCB0aGUgY29uZmlndXJhdGlvbiBpcyB3cm9uZyAq
Lw0KPiA+ID4gPiA+ICsJc3dpdGNoICh0ZW1wX3BhdGhbaWR4IC0gMV0pIHsNCj4gPiA+ID4gPiAr
CWNhc2UgRERQX0NPTVBPTkVOVF9EUF9JTlRGMDoNCj4gPiA+ID4gPiArCWNhc2UgRERQX0NPTVBP
TkVOVF9EUF9JTlRGMToNCj4gPiA+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EUEkwOg0KPiA+
ID4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RQSTE6DQo+ID4gPiA+ID4gKwljYXNlIEREUF9D
T01QT05FTlRfRFNJMDoNCj4gPiA+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EU0kxOg0KPiA+
ID4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RTSTI6DQo+ID4gPiA+ID4gKwljYXNlIEREUF9D
T01QT05FTlRfRFNJMzoNCj4gPiA+ID4gPiArCQlicmVhazsNCj4gPiA+ID4gPiArCWRlZmF1bHQ6
DQo+ID4gPiA+ID4gKwkJZGV2X2VycihkZXYsICJJbnZhbGlkIGRpc3BsYXkgaHcgcGlwZWxpbmUu
IExhc3QgY29tcG9uZW50OiAlZCAocmV0PSVkKVxuIiwNCj4gPiA+ID4gPiArCQkJdGVtcF9wYXRo
W2lkeCAtIDFdLCByZXQpOw0KPiA+ID4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiA+
ICsJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWZpbmFsX2RkcF9wYXRoID0gZGV2bV9rbWVt
ZHVwKGRldiwgdGVtcF9wYXRoLCBpZHggKiBzaXplb2YodGVtcF9wYXRoWzBdKSwgR0ZQX0tFUk5F
TCk7DQo+ID4gPiA+ID4gKwlpZiAoIWZpbmFsX2RkcF9wYXRoKQ0KPiA+ID4gPiA+ICsJCXJldHVy
biAtRU5PTUVNOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWRldl9kYmcoZGV2LCAiRGlzcGxh
eSBIVyBQaXBlbGluZSBidWlsdCB3aXRoICVkIGNvbXBvbmVudHMuXG4iLCBpZHgpOw0KPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiArCS8qIFBpcGVsaW5lIGJ1aWx0ISAqLw0KPiA+ID4gPiA+ICsJKm91
dF9wYXRoID0gZmluYWxfZGRwX3BhdGg7DQo+ID4gPiA+ID4gKwkqb3V0X3BhdGhfbGVuID0gaWR4
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiA+ICt9DQo+ID4g
PiA+ID4gKw0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiANCj4gDQo=

