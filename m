Return-Path: <linux-kernel+bounces-533172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23EA45669
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BFE3A9676
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077326AA9E;
	Wed, 26 Feb 2025 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BAgKjeuE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gj3MuwF9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460119DF62;
	Wed, 26 Feb 2025 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553815; cv=fail; b=iCK3YJwoIAjgJLPG8N+IIQD41fYOK+spo2pA86RN5PFOw0tCiGlXQ2EkD+4NSSUx+irRKOs598LU+pmkZLjD4chkSNJx9LUIiJB9vs99yqFrlhgLrnlnQ58gMjgvqmRc4DEVNwC1hoow29hSXPaPVe+iPgPBB+yF+PtgHz8qgiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553815; c=relaxed/simple;
	bh=wYbG+CSo1tPTVxCWZ+YT0KFuwCxm38vucpWq+H2AmrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uH1AHPeOUi2L577NYBRPETEMU45KkB3MOrExi0U/yV+UcUOUGb6Q98WxM2O5WxzExdZa0lQPlWfIgSmZCHYwOJVR1d7Q7oLXqOCajkPURnkEQNX9cP6VeVa5OJRLnxt680HbiYB1bsjSoztQBgdw0Yo/HRQq4/IVTO1LYJuDy4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BAgKjeuE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gj3MuwF9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ad3de5c0f41011ef8eb9c36241bbb6fb-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wYbG+CSo1tPTVxCWZ+YT0KFuwCxm38vucpWq+H2AmrQ=;
	b=BAgKjeuEYOh5P3UDcu4etQpQH5xlLWHpRNgzliZhmo5baa3m278SZPFjjbygf2qd3etGsHsXvZpRZfmGnf2GAhNUoDSV4qh30jnkqmrunQftl99ros4AQwm8UbgFlaOCk1H5EEe8HBQz9tz7+ulY3MCe1n1HPIv5Yb1MY58NNT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a75b900b-7d5f-42f2-865c-1c17d4d208fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:285298b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ad3de5c0f41011ef8eb9c36241bbb6fb-20250226
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 685358270; Wed, 26 Feb 2025 15:09:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 15:09:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 15:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3vuDToVGb2kexQPOsGTwsuNvwhzwZP1VDzDIYYbQZYifSkBTfLR0zsmS/UuGS3/4epy5mtqDbA22yx0KIMMSd+SV3I767r+tQwdVxyUIhT2sLOAj9A276HgPteHRiC4nI+EynmvyQhHDQjDvfJ1bcjVTEIeYcaIAZhr24QZALmtkaC23qWrF+KNcCcoMmrJyWs8QXZ9Q5A7poWmwjsUCTbAU3W+DT+tKMZFFuQ87oHB4ZemEcOy/8qnOm2EnmLYmYGxp5Fz22Xce1Rhw2HSbJKL964LJsvJiekbWZJAOcYAvNZCcChOgl7tj7pQlfLk3/IUcMvVulz8kDv63r8+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYbG+CSo1tPTVxCWZ+YT0KFuwCxm38vucpWq+H2AmrQ=;
 b=OAjWBLmiVbTbyUS42MCJmR/8WTc9EXmvGRVEFfQ3X+M91EaMbBGa7eyWh9IKfNhnT+RdOzerLg2SyXQ6AuWlOshlqx6kd5QcFchWZEvUdxQjIUNt/cJ9FRXDTvG+FYzTG6lKMKD/b1Bo9QRDpBiOtmQ0MvYp7JagIdz0qTU9B9J7tlKM2FzibkpnKwWTQwXOpI4CrX5eXx6bm9LnKkd/CiQuzdoqte2PqyCkskfDT8kjwsVqEejDU3zQDnxwTaPY1JaeJXtRtjTNwHOsRWGNNT5t81gpNTog3ttCWGwAGHe/oqK48bzU4tQHJNbxgyIHiwnrom7HBgiG/dc8laodAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYbG+CSo1tPTVxCWZ+YT0KFuwCxm38vucpWq+H2AmrQ=;
 b=gj3MuwF9BK6BAnXcm01cgBoqZ+pr9SoBH3Uss74WpZlN6Wxr78Y3aRq0XwIvNt5KiA9Q1fvIeG+Di4k/DqGkuLF466HAU339nv6IpT16Q+PLIqCa8pNGRbZFewYURzEpLdKor3ZnfiKHBE6Fx33u89rbx6aLNnSUJxSewr3qMP8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8423.apcprd03.prod.outlook.com (2603:1096:405:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 07:09:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 07:09:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hsinyi@chromium.org" <hsinyi@chromium.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Topic: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Index: AQHbgq+qzYjJmWpf8EyFxOxZsNS0dbNZNXmA
Date: Wed, 26 Feb 2025 07:09:49 +0000
Message-ID: <7c04b8f86bd25e769e1003e4c4a18a12c4300d67.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-2-jay.liu@mediatek.com>
In-Reply-To: <20250219092040.11227-2-jay.liu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8423:EE_
x-ms-office365-filtering-correlation-id: 9fa6854d-07e5-49d4-bc92-08dd56348f2a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K0t5aDE0TUN6MTJnUmNJdDlOa1NnVDdKeC9qdEVkNEpRa1BlSHpjWGxOb0Yz?=
 =?utf-8?B?T1BjaXpyTW9yd3B2L2xpd3hYa1Fva0ZSd3JUNXlvQ1dMU3BXelJoLzcvN3Bs?=
 =?utf-8?B?WDJIZEJSRkpscFJZdFp2bFZNUndRQzcxMStzdkkxVjZSWE5NVDV2ZlJmRU1W?=
 =?utf-8?B?K01rRjhkN0VQNlorY0Y4eGpuV2NoMlpCUVNpZEtFbTFLdGtSMU5kTmZINjh1?=
 =?utf-8?B?cXE0a0NZYmUyRGJsbE9GTnNjWkJMVm01d1BmWUYrTUQwaXhEOHhnSkNtTGV4?=
 =?utf-8?B?L3NBRTE2MmkxRi9NWldQTm1XdDJydmhTcjlydnVzNTRtbUdCbGk3QnQrMDdo?=
 =?utf-8?B?aHNja0Y4N2dHNXhITE1jYlhTUHhRa3VLTUFTVTArbDE3NGlvYUhuMzduTHN5?=
 =?utf-8?B?bnNpcjBVeWh4MEU2RjVwZ3gwWkNMVEdEcE5PYWltTzh2NUxybEVmZEhHaHd6?=
 =?utf-8?B?Yk4xQzBSMVRRelhnNW4yWXFKajFQR2R1M1J2bGdxNXkyZXVBdTBLZ2JRWDha?=
 =?utf-8?B?R2JBQjVBcXBIYjBtNW81cU5EWkVkc1BHZzhEaHVTMFVVYmRNVWJ3QW5kdmk3?=
 =?utf-8?B?bVRMQTErREZKWjhBSUUrWEowa3BQaklTb2dhYzZHTFJsbFg0MTRBcm41ZTFn?=
 =?utf-8?B?ajlCeDFOaEttVDZCUUh5Y0c0U2RMODhXempOSkpIQVpoTVNJQ0h3dlVudlZR?=
 =?utf-8?B?Z1JxZldvajF2bExDbTJTc2FCL1dWMW4yRW9DSW80ZlZXeS9raWk1ekRwTTJ4?=
 =?utf-8?B?TDdEbXlaTVlMdk92b0wxT1VnSlBJNER1VnE5ektFWGhyUnBFSmdwMmwrbGR3?=
 =?utf-8?B?NzR5bFhJeTM3UWphSGZmRW0yV0NTRGVUeXc3bUtHSWwwOHdSVnhFQUhVTFpv?=
 =?utf-8?B?dmU5bXorcG1NZ2VORzRkdjBhRXpPaVdYbEpnekg2bkszUGxUVUcxMmpHZlgy?=
 =?utf-8?B?aXgyL3BCYmNPbUhsY1ZzczNiVW9SSFRVbFpoMVJPMWhwQWhqd29vT2ZOYXR2?=
 =?utf-8?B?YmhCRDZlVytScmgwd1g0bGhOK3ZjU2NlYlYrWGJjODh1c0dFRlFWeHhQOU1S?=
 =?utf-8?B?VUVyVHAvSDE2MUxQaVZucUZpZnJaTFJhQkNzelM2OW1qbmRXUnlHczJyQXZT?=
 =?utf-8?B?QUxyWC9sUGJSdFNLLzFGS0l3eFErTnJjcWwxMUJXNXVYTUozUVo2MTZla2xK?=
 =?utf-8?B?ckFLb0Rzbm9GMWlVQjRQNlM0eERDMDhKWUZIQVVFV3ovdmJmMktHN3A3NXNT?=
 =?utf-8?B?Q1ROUk9iWHI5QXl1bHJINkVSV0tvWnhibHZ5bUF0M3BBL2I4NW1qNmc1bW9B?=
 =?utf-8?B?d0JaYWs0MHFyaWhyNU1OVEN6Y2lzeDB2cTdzTGNXc3FCaWRVbHlBZUx5MnhP?=
 =?utf-8?B?akdZaTR4NVlla1ZrbnVIcTgyME5JSzlBN2lCTE5pdVE2VWYxNDJsNWpHeW1O?=
 =?utf-8?B?SlM0QVg4Skp1MExaU0QrdGd2cWFNOFpGQnFCSWhEd1ZON0pIOFpxcjNFUDRU?=
 =?utf-8?B?QzlEYWRwdVdDNGR6TXB1R0Z2a3YvOVhyOFJUOGRaZWxFcE14YVZGVzJOc05i?=
 =?utf-8?B?NS9PN3FVYXh0TjUrQnhhWkxRR0tQd3dHQzlwU0pNTkJESHRUQ3lPWms3aHRL?=
 =?utf-8?B?dkpkYnNZeGRwcnJ4TnRKbW5xdlZlejFWSXVtYURBaHBOaUtXRGN4cENPcW5k?=
 =?utf-8?B?WHRXcFJ5S21WbVBCZCsyaVZTSkZ5cWg0SG9TazhLQ3ZOSWFkamUrajE3ZXJE?=
 =?utf-8?B?NjAxVUNHNEh1S2lzSmpNQ1BKMTdjT1g3TUwyNXBYSXpOalVaTFRwam9WaUIr?=
 =?utf-8?B?MnhMbWZuNlhGSXAwZEdpVXBTaGN3Sml4QUJMWFl2NVdjbE5CQVVkUlBnZmxn?=
 =?utf-8?B?UzVFWEN6d1p5TTVQTDNtbDJzUU0xWU9GZ3NnN2hlZlBwR3YveU5CV3ZJM0dp?=
 =?utf-8?B?OTRoMjYxbm1wVldZbzJjTFFQTDJxTFhOcDZPMFhCVzdyUEUybG1GaFVrNmVH?=
 =?utf-8?B?SW9TQXhzcFR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3Y0MzkyMUo5emI2a3RxL0R5aWxDVDlrUUkvd2loRm5oKzJwdnF2SHNBYU1v?=
 =?utf-8?B?alA3RE4xNHd1YS9MVHZiaWdGMllYS2IxenRzWW5oYk5tNTFDSnlpaml4bGda?=
 =?utf-8?B?MDVTZXpjNUpkeURmYkRKRzJtcmVzZmxqRlNoMkt4UlhpVml6MUhpc3JlbFUr?=
 =?utf-8?B?aTRhOVR1OWt2bXJOMkwzWWlVMGcza2FQVHp6dGp2VlBHSXBQeWFPdjNQM1NP?=
 =?utf-8?B?MEI3UDBjSGJSVWpaeHNRbUw2SHBBbmFhMHcrOHBBdEFlaWp1dVVOWTMxQ1RV?=
 =?utf-8?B?cEdybWFjR0RyT3dIOHZDZVJkVVU3QVZ4bHdaaUs3Z0ZMYXROUjZxVjRlU3hE?=
 =?utf-8?B?V3ltR0FFUVd6dFB3SCtHRTdLTWhwOFJqSjIwSVJoM2FybFZoU2tieUs0Z0kw?=
 =?utf-8?B?TXU4cURtZzl2dmpqRGpPb2p6UFY3ZDZJcFdzT0R5bnVEYzgzNmhKUzh0Y0xU?=
 =?utf-8?B?SE5HUE9hTGtnWGM0RXRmSi82d0RJYklkWUtuRXEvMmpJSXJURnBZU0xqRU5O?=
 =?utf-8?B?NFMwNXhVRmQ2VnhPbVJIQlhrYVpqRzJ2bXU1eG1ubmVjbHlRVC8zZnhEdzlR?=
 =?utf-8?B?aEtRWUFWYjVHZ0dteitLNktWQzZUMnVVS05DRTRheHNyZEZFTldNZWZ3Q0ht?=
 =?utf-8?B?U0JTbStXYmxnYnBwQTlqcmZnTUF5Zk1lUUFpSG15bjNwdmoyRC96ZkVtcTdz?=
 =?utf-8?B?UkdYRUx0OG5DMjRmK213cS91dVNvQ2Jidyt5MzlSTDF0SERERzQ3T3plTTZV?=
 =?utf-8?B?TUJnSTNRNVIzbXMzcUtwZnhsMHJlcXJWS2hQYTRxVnlaSHhKOGFoTTZNbXlF?=
 =?utf-8?B?UUFZRHh1dWx5REFMcUhWVG9TQkxReG9SVTZoSE1pRjRsb2VWeVQrTjhDaXFi?=
 =?utf-8?B?aTlQS05FS2Erd2ozc3RIVzJGMWs2QVpzUTkrTmlrQWgyT1hSMzZDK1d6Qnlx?=
 =?utf-8?B?RnhsaFhnMlZjWHc5N3oyWTc5VFZPV3V1Uno3cHpVNysxWEdzcFVHendxMzJ0?=
 =?utf-8?B?T3BncTdZQ01laW02Nnc3WUZoUjYwRDFJNTNTUFQyNGwvY3pHaFRYSWVBU0kv?=
 =?utf-8?B?NUhveUZPczE3QTVWZGZaOGJwaWJGNVluaWFycHIzSmU0WUd5TUJZSEpSbktj?=
 =?utf-8?B?UWZMTlVrb0VxNnY5ekFpL1hSQXFPVFpSaTZoUUd0S0dxb0dnR0lPZkE5dHdj?=
 =?utf-8?B?TllvN2RYS3RUdTJlQTFLUHpPYVd4cHljWnQ1cDNVZXhCZVFSNlRMLzFWQlI5?=
 =?utf-8?B?V1BjblMrYmFheW0zVEhRcjRPYUd3WVFnNXhoaHd2djQyQWd3bTNOWFlWdito?=
 =?utf-8?B?Wld6MjFCMFZQNDRVcGtkb0xXc2JhNHd3VVFIcklCNHIwOXRLVkdVNXpRL2RH?=
 =?utf-8?B?VUMzWm9zWDEycWx3aE1rTUNDbUhaeHVnZVBYYlhKTTQybzVTMXVEZW1PSndB?=
 =?utf-8?B?cGhDWFhIdHFhWlFvUTVXQ2VJM3dWZ2xkTFM4dlNKSjNieU9WNUd4cUtIalFv?=
 =?utf-8?B?b0dhSWREVjlxYXZXT1VlQ3BvRWorZzVwYmlWOHYwcWdzQTZEejdtVWQ4RFNw?=
 =?utf-8?B?MFdXcWVxNHJ3aG5GOXRuQ0pZNVB6cDEyRzhCSy85ZnpzS2tmTG91VTFGSVkr?=
 =?utf-8?B?dndTZXdoYmhOYWh6NjIwdXRVcVppMTRRalFjZTF1UU5FYXRCNGZraURFVm9p?=
 =?utf-8?B?R1Z0Y1AxTld5eGhHRmZLb1J5OHlZZEh4czEwakxrYk5OZElpUzA2a2NDSDN3?=
 =?utf-8?B?RFM5bE5YeXZDUC9oSE93RWlzaGorNUtHNnZGd1NBVU1MbDdvWDZBWFNFekZX?=
 =?utf-8?B?QzVpdW9teXgzaVlMSnNPY1l1UHdUb1c3KzRwVWtvZ01hbktXUDRpV1k5eUh4?=
 =?utf-8?B?SFNDS2cvbkZzL3ZXREhjWFQvSnIxM0I4VUdjdDRlR2ZxVVEvQ212V1BYZ3pt?=
 =?utf-8?B?T2FTa1V4bHlMSzV3RnZsc1N2S2RqTmI3dkxtRUszMXpEVndsemREeTUvRkJh?=
 =?utf-8?B?S3Z5MVdxbmRLSHRmcitIc1RCU0dKWVJyRDA4QnBYTENJZzA3TTBpbmpjT3dx?=
 =?utf-8?B?SVY1dkZjMjJHYmhISlhuNjVXZjJmczV4WlNyeW5nV3FGRHV2TkI1Y2pRNFND?=
 =?utf-8?Q?wHyNooj88/u0qDSJZakP2Ims0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE9A351451499F40B8684CD960E7FBA6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6854d-07e5-49d4-bc92-08dd56348f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:09:49.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0Mh+qYl9S4y6T3M46AMlwtZUrKJ0zHj5sn8+/1mqGeCovVJdeVS1pRZBlGoqFthR48qTmYK9XihbUb+ClnfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8423

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE3OjIwICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
Q0NPUlIgY29tcG9uZW50IHN1cHBvcnQgZm9yIE1UODE5Ni4NCj4gDQo+IENDT1JSIGlzIGEgaGFy
ZHdhcmUgbW9kdWxlIHRoYXQgb3B0aW1pemVzIHRoZSB2aXN1YWwgZWZmZWN0cyBvZg0KPiBpbWFn
ZXMgYnkgYWRqdXN0aW5nIHRoZSBjb2xvciBtYXRyaXgsIGVuYWJsaW5nIGZlYXR1cmVzIHN1Y2gg
YXMNCj4gbmlnaHQgbGlnaHQuDQo+IA0KPiBUaGUgODE5NiBoYXJkd2FyZSBwbGF0Zm9ybSBpbmNs
dWRlcyB0d28gQ0NPUlIgKENvbG9yIENvcnJlY3Rpb24pIHVuaXRzLg0KPiBIb3dldmVyLCB0aGUg
YG10a19jY29ycl9jdG1fc2V0YCBBUEkgb25seSB1dGlsaXplcyBvbmUgb2YgdGhlc2UgdW5pdHMu
DQo+IFRvIHByZXZlbnQgdGhlIHVudXNlZCBDQ09SUiB1bml0IGZyb20gaW5hZHZlcnRlbnRseSB0
YWtpbmcgZWZmZWN0LA0KPiB3ZSBuZWVkIHRvIGJsb2NrIGl0IGJ5IGFkZGluZyBtYW5kYXRvcnlf
Y2NvcnIgZmxhZyBpbiB0aGUgZHJpdmVyX2RhdGEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkg
TGl1IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RkcF9jb21wLmMgICB8ICAzICsrLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Njb3JyLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gaW5kZXggZWRjNjQxNzYzOWU2Li5kN2UyMzBi
YWM1M2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2Nv
bXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4g
QEAgLTQ1Nyw3ICs0NTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9tYXRj
aCBtdGtfZGRwX21hdGNoZXNbRERQX0NPTVBPTkVOVF9EUk1fSURfTUFYXQ0KPiAgCVtERFBfQ09N
UE9ORU5UX0FBTDBdCQk9IHsgTVRLX0RJU1BfQUFMLAkJMCwgJmRkcF9hYWwgfSwNCj4gIAlbRERQ
X0NPTVBPTkVOVF9BQUwxXQkJPSB7IE1US19ESVNQX0FBTCwJCTEsICZkZHBfYWFsIH0sDQo+ICAJ
W0REUF9DT01QT05FTlRfQkxTXQkJPSB7IE1US19ESVNQX0JMUywJCTAsIE5VTEwgfSwNCj4gLQlb
RERQX0NPTVBPTkVOVF9DQ09SUl0JCT0geyBNVEtfRElTUF9DQ09SUiwJCTAsICZkZHBfY2NvcnIg
fSwNCj4gKwlbRERQX0NPTVBPTkVOVF9DQ09SUjBdCQk9IHsgTVRLX0RJU1BfQ0NPUlIsCQkwLCAm
ZGRwX2Njb3JyIH0sDQo+ICsJW0REUF9DT01QT05FTlRfQ0NPUlIxXQkJPSB7IE1US19ESVNQX0ND
T1JSLAkJMSwgJmRkcF9jY29yciB9LA0KPiAgCVtERFBfQ09NUE9ORU5UX0NPTE9SMF0JCT0geyBN
VEtfRElTUF9DT0xPUiwJCTAsICZkZHBfY29sb3IgfSwNCj4gIAlbRERQX0NPTVBPTkVOVF9DT0xP
UjFdCQk9IHsgTVRLX0RJU1BfQ09MT1IsCQkxLCAmZGRwX2NvbG9yIH0sDQo+ICAJW0REUF9DT01Q
T05FTlRfRElUSEVSMF0JCT0geyBNVEtfRElTUF9ESVRIRVIsCQkwLCAmZGRwX2RpdGhlciB9LA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiBpbmRleCAxMGQ2
MGQyYzJhNTYuLjk0ZTgyYjNmYTJkOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2Njb3JyLmMNCj4gQEAgLTMxLDExICszMSwxMyBAQA0KPiAgDQo+ICBzdHJ1Y3Qg
bXRrX2Rpc3BfY2NvcnJfZGF0YSB7DQo+ICAJdTMyIG1hdHJpeF9iaXRzOw0KPiArCWVudW0gbXRr
X2RkcF9jb21wX2lkIG1hbmRhdG9yeV9jY29ycjsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBtdGtf
ZGlzcF9jY29yciB7DQo+ICAJc3RydWN0IGNsayAqY2xrOw0KPiAgCXZvaWQgX19pb21lbSAqcmVn
czsNCj4gKwllbnVtIG10a19kZHBfY29tcF9pZCBjb21wX2lkOw0KPiAgCXN0cnVjdCBjbWRxX2Ns
aWVudF9yZWcgY21kcV9yZWc7DQo+ICAJY29uc3Qgc3RydWN0IG10a19kaXNwX2Njb3JyX2RhdGEJ
KmRhdGE7DQo+ICB9Ow0KPiBAQCAtMTE1LDYgKzExNyw5IEBAIHZvaWQgbXRrX2Njb3JyX2N0bV9z
ZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAg
CWlmICghYmxvYikNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICsJaWYgKGNjb3JyLT5jb21wX2lkICE9
IGNjb3JyLT5kYXRhLT5tYW5kYXRvcnlfY2NvcnIpDQo+ICsJCXJldHVybjsNCg0KQ2hhbmdlIG10
a19kZHBfY3RtX3NldCgpIHJldHVybiB2YWx1ZSB0byBib29sLg0KSWYgdGhpcyBjb21wb25lbnQg
c3VwcG9ydCBjdG1fc2V0KCksIHJldHVybiB0cnVlLCBlbHNlIHJldHVybiBmYWxzZS4NCkFuZCBp
biBtdGtfY3J0Y19hdG9taWNfZmx1c2goKSwgY2hlY2sgcmV0dXJuIHZhbHVlIG9mIG10a19kZHBf
Y3RtX3NldCgpLg0KSWYgb25jZSBhIGNvbXBvbmVudCBoYXMgc3VwcG9ydCBjdG1fc2V0KCksIGRv
IG5vdCBjYWxsIG10a19kZHBfY3RtX3NldCgpIGZvciB0aGUgcmVzdCBjb21wb25lbnQuDQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICsNCj4gIAljdG0gPSAoc3RydWN0IGRybV9jb2xvcl9jdG0gKilibG9i
LT5kYXRhOw0KPiAgCWlucHV0ID0gY3RtLT5tYXRyaXg7DQo+ICANCj4gQEAgLTE1NCw2ICsxNTks
NyBAQCBzdGF0aWMgaW50IG10a19kaXNwX2Njb3JyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1
Y3QgbXRrX2Rpc3BfY2NvcnIgKnByaXY7DQo+ICAJaW50IHJldDsNCj4gKwllbnVtIG10a19kZHBf
Y29tcF9pZCBjb21wX2lkOw0KPiAgDQo+ICAJcHJpdiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVv
ZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghcHJpdikNCj4gQEAgLTE2OSw2ICsxNzUs
MTQgQEAgc3RhdGljIGludCBtdGtfZGlzcF9jY29ycl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIocHJpdi0+
cmVncyksDQo+ICAJCQkJICAgICAiZmFpbGVkIHRvIGlvcmVtYXAgY2NvcnJcbiIpOw0KPiAgDQo+
ICsJY29tcF9pZCA9IG10a19kZHBfY29tcF9nZXRfaWQoZGV2LT5vZl9ub2RlLCBNVEtfRElTUF9D
Q09SUik7DQo+ICsJaWYgKGNvbXBfaWQgPCAwKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVk
IHRvIGlkZW50aWZ5IGJ5IGFsaWFzOiAlZFxuIiwgY29tcF9pZCk7DQo+ICsJCXJldHVybiBjb21w
X2lkOw0KPiArCX0NCj4gKw0KPiArCXByaXYtPmNvbXBfaWQgPSBjb21wX2lkOw0KPiArDQo+ICAj
aWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gIAlyZXQgPSBjbWRxX2Rldl9nZXRf
Y2xpZW50X3JlZyhkZXYsICZwcml2LT5jbWRxX3JlZywgMCk7DQo+ICAJaWYgKHJldCkNCj4gQEAg
LTE5MiwxMCArMjA2LDEyIEBAIHN0YXRpYyB2b2lkIG10a19kaXNwX2Njb3JyX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kaXNwX2Njb3JyX2RhdGEgbXQ4MTgzX2Njb3JyX2RyaXZlcl9kYXRhID0gew0KPiAgCS5tYXRy
aXhfYml0cyA9IDEwLA0KPiArCS5tYW5kYXRvcnlfY2NvcnIgPSBERFBfQ09NUE9ORU5UX0NDT1JS
MCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0
YSBtdDgxOTJfY2NvcnJfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLm1hdHJpeF9iaXRzID0gMTEsDQo+
ICsJLm1hbmRhdG9yeV9jY29yciA9IEREUF9DT01QT05FTlRfQ0NPUlIwLA0KPiAgfTsNCj4gIA0K
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2Rpc3BfY2NvcnJfZHJpdmVy
X2R0X21hdGNoW10gPSB7DQoNCg==

