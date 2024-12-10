Return-Path: <linux-kernel+bounces-438814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DE9EA6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3695E169D34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889151D6DB3;
	Tue, 10 Dec 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZrnElB+d";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tPuTdHHQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251171D5CF8;
	Tue, 10 Dec 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801331; cv=fail; b=hErwpUUm4lAusP1TXkR4ouTFy8C2EMF5QzRHvLrjsqQHgrPRqBNQwBhxIw45kwTK1hM3Fd4kBeYp9Y83lduwVthCsxy5st3+X5iCfWmuHdjve4nqFWkQqiSsay4cdf8G6TNBrVi5VvsDJF8mANxwMnkyfKT+qXRBXQPdVire5fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801331; c=relaxed/simple;
	bh=/NQOga5uV0um5wW4unN5LBZpohSvljiFddx/3Ap23JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+bdkfz89QAqNjOSwBi6rPnZwwQRE7DUpzIXk4JZRwv839/ivYF1FSZRS6Ilcmt7xG0bPPyy+445oR8gfHAEGSBT+F2+RNn25PCbkjwRpY88mkfKf+9ZzCai+Csjlj9bxSzyPX4uIxsaMhXCQmcK98oS0weTb4ORSyr/DAkOBuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZrnElB+d; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tPuTdHHQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc402722b6a611efbd192953cf12861f-20241210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/NQOga5uV0um5wW4unN5LBZpohSvljiFddx/3Ap23JM=;
	b=ZrnElB+d7mLq+7Z1vKIbaguDjv/87139o97NXSZz4htay1ObabJqsL3QANTqlbbSGg3DMtm+elDVUckLeJNSz4yqZKiIk/Z3yuaSzNWukUteM3MUjtvLMWLZfZNoP4r4Fyahe4GlFFfoeG3FgZROkcm96IDzm06XkQ2/QgAJnYU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b252bfc3-75c0-473d-bbdb-bc13ea33be06,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f7b27804-b3ca-4202-ba41-09fe265db19f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc402722b6a611efbd192953cf12861f-20241210
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504884708; Tue, 10 Dec 2024 11:28:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Dec 2024 11:28:42 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Dec 2024 11:28:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWr2iC1ndP77Id8adDSMOscWkN2T7RwHJ6hi9udfbKmbfyMLRlhml0Xj2H2DeCGilO0KO3VjGRymyRN7usTo3AsSzb6TRzSLhyXJZnF/6iO+ISycKorNxA1jfIjIJoZUhYvDk5KTe9PcnpUshX1pWb7sMI6csKBSJjkDp40CYEzeSsF1jdSWELVR+rpWlPWpjI2t3TCMELstuUiHU6lE2PkNBoC6sB/iySOmljSa8sZ8H/sTs/mn0Bcz6JZRqV9FYNYKT404618jnOXoFW5SYUa4RI6+ECi2znys3JSHMkESjEeb0a/mjXQ5Wf5ABeVtWySopCtTU4KVL7qdqLy92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NQOga5uV0um5wW4unN5LBZpohSvljiFddx/3Ap23JM=;
 b=fTy0Jd5Exc3V3EhW/HfkCbQ/sKhVPI5gXF3vUYcqX22tAaQ12kLi2FHd/QziQAUOrPnTOKATOqsvClG3lN9Nddw2GxNnVj1WXx3xBtWXuwcVyzIQMv7c01rjdJZewGkWiYX5hFB0Vutiu93aAJb7L3K6m57FbfNd3aSXQM5Gk52D1qVSGVYu2/Ja4FNnZvX5/31tJRM0J5VCHjmXb/j7jbUc6Q/RCbdxcxigRSNFLrrCZyhUt5u3FrSkfzrpeadHPd3VQAoPkG6BJ+z0PAqOBetrEMAJfHF4iaFDEe2jGdxatnczX3EQfO6sKFZK4tVqcNtqpP2b708rv7W8GRoxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NQOga5uV0um5wW4unN5LBZpohSvljiFddx/3Ap23JM=;
 b=tPuTdHHQMBr0d8nWV2Fj8UxQfgqLTjr/YkwB3QonZyaiVJrlPUZHBB2OcsIVHO7J/shwtSZ5s5xHgnK+c6XawFGZ34w/f4q7mt0imZVVHt/Q2HpV/v/3bBao+r8H9sTwaqFvykXu1oNCYYFQEHImvjTUDPBAmMKdziXCfNbJoKE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7900.apcprd03.prod.outlook.com (2603:1096:101:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 03:28:40 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Tue, 10 Dec 2024
 03:28:39 +0000
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
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbRwuJJIpw1RNG4k2Br44bBPRYWbLe2RwA
Date: Tue, 10 Dec 2024 03:28:39 +0000
Message-ID: <631fdcdfd44e0d401e62df67acc206b0762248c7.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7900:EE_
x-ms-office365-filtering-correlation-id: aa4e3c56-1b28-411c-8e03-08dd18cabd34
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MUhObXkyeW11UVRZSHpyOWVPbHMrNlB6eU9COGY4Q2NsNm1mUkxPZ3VFbU54?=
 =?utf-8?B?dkQ3TFd1ZXFJOUo3c1J0R1JrWDdBK2tDS3NySDJPSXdpUzc0YjNTWHNHaW5E?=
 =?utf-8?B?eEFmUWowY3RsYncvRm5hWENicVJxK1QrWlQyeXloTmUxSlhkQlVPL1FESHN1?=
 =?utf-8?B?a2h1c0ZZSUlXbE5uZWVmR2lrVndCL04yVEpjeTRqdlo0RVlWMGRIUlluK0Vs?=
 =?utf-8?B?Q0tqSkhvK1BPUGY5V1NjbkZZdGRwc3lYdDhJaXFIaWtHR2tVcVBBY0VYMWlS?=
 =?utf-8?B?a3FYR0JxbnJlb2lTLzhEUUJ5cDdwK0VVQ0o3dk1tQ1JYUk0waGVSNFVDeU1x?=
 =?utf-8?B?WkQ0ZGF0Y0l3ZHZrbVArRGxYLzBFdzM2d0dPNFRoL014bEVKZS82bS9ITC93?=
 =?utf-8?B?cXE1TzlvMzdrVUNvK3FrUm9rVlcxRmwzM3NUWm1zQ1JwaGRLeFNxZW9uUjRm?=
 =?utf-8?B?ekVIYitpaXJRaXFFYlZUdHZOQlV4N25MWUNPekZQUE1BLzROR2p2Sy9KRkc5?=
 =?utf-8?B?ekFvaDF6L2o5b2dDTFo1eEd2Y0tiVzZOUzRUczRhYzRTL0NKUytuMTZzUG1P?=
 =?utf-8?B?M2UydkFXN3BrdU03bFZLcUZYekwvNHRZMVZGdDROdmdmL2tXNjFsaE1PQTdn?=
 =?utf-8?B?K1ZFZUhJYTZhQjBvbHpIa0dVYVpCWk1mQXBVK0J3d3BKaDRHdkJpaG1yU2gz?=
 =?utf-8?B?RlZZZWFoblhRZ2lFZUZSOTRnc3hmUmIwbWN4YmRJRGZWY1dlK3BxRFBQQkF6?=
 =?utf-8?B?Ymt0WnFwUlRUaEwxTzVxV3ZiN2xQN3dKY2R5V0RvS3hoWmJPTjJVejJzKzRr?=
 =?utf-8?B?VmduWFZDbGNqK2xuYmltZ0dKMzNCSG9TMWY4V0hnd2ZJMnZXenM5NFZ3a2Ux?=
 =?utf-8?B?a041NDRwcXFnU3E4RzFYRlZ6T05jbytTS0ZYOENPVnBCZzZhMEtSS0JFMDcy?=
 =?utf-8?B?Q2Jubk56U1NRd0ptUXpGOUxHTXE1YkVzeWtVUzRBZ1dUNEVtQ3JGblcyckZB?=
 =?utf-8?B?WFJaTjBmRm9QRnptU0Z2aE5pVlNrUkkyZFg2d1BsdlIrWlUzbktxOGhvL29N?=
 =?utf-8?B?ZUpVTzJPUzBjZjMveHdSeEJhNnhLWkxHV25jVDZZZzFXUjg1eFJkT1BEMTBs?=
 =?utf-8?B?dWpBa09Fdm1aOU9KajZaZ3AyalJ4VStvOVZwZ3VNQVVzbHppRG1wYUc0anRJ?=
 =?utf-8?B?U09CNGhYS0FZd0lZNDRMOFVhWm5SeU9oL3ROOW9BaDBpQ211WWgzSE1JejZJ?=
 =?utf-8?B?WEduUUpnL1lBUmJneTRxUENQQ2tWMWtOZ0FzbFRaL0lzOXZSZW4xQVhINVpJ?=
 =?utf-8?B?UmxrREtGV1Q5SHE5QVozRVhhR29Bc3BnSEJNNHJQWGl3emtkOTMxNkNQdk9B?=
 =?utf-8?B?ak4rRDliRWZOZmZJVWFVTWtRdFJ5SmNtdEZuaXhRNXBFWldpMlQva1dRaHlU?=
 =?utf-8?B?MkJ6UFRBNGVmbWg2cnhpMDNpMk9kait4cWNMeGJvbkQ3eUZGWjB2TVlmM0Fw?=
 =?utf-8?B?SkQrbG1rYTJkVDFKdUV4aWlWTEJYcTRTNTBhTzl5bjZtMHF5STBwdm5mWENS?=
 =?utf-8?B?VzhQOEljRG9OWXRsMjV2aXZMUHFaK21QM3Q3a0J4azR6UVRJZUNjTkNsN1pr?=
 =?utf-8?B?OUZZUjFMc2pEV210TmNZdzd6WktsK1pGTHViT3dPQzRUU1pDdll1ZE1aRlpL?=
 =?utf-8?B?ZG1iKzduN2l0ekI0NzFJQ05jeGpHb29RWUEvOENwZy9BdDV2Y1owbktwSVN1?=
 =?utf-8?B?eFRDdjI2dEZGWHhOV3VpWlY0dHVhZE9WZDhaUzRhdkpmbDhObmNXS3BDeUgz?=
 =?utf-8?B?TU1ZMTZRTG1GYkgvaHFVNDkyYVoreG5qUW1BM1ZDaDZWd0UyaW1xYUpUYmtq?=
 =?utf-8?B?cTIzZWJaa1hNT214UEd1MmRtR2d0TTFjZTBLTEJIZzFJWmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVJV3dQbitJTW51VDVqMHpZYmtpY2d3empIRjFRc2owZGVHdXlJRDdyRm5Q?=
 =?utf-8?B?N0FDcEpyY1FHaVdSdDV6ekJCdmg4b0lScVIvOEUveGtzZ056eGF0WFRuUzNC?=
 =?utf-8?B?NlF6U1pvQ2s5RWNHeUlzRCt0c2UvY1hFempmeWh3MDlHVkVGN1RkVk9tL0l5?=
 =?utf-8?B?c2pFenJIdXFZcWpUZFBsbklKaHNZVjY5Ly9qQXVFVnJKWVh6QXZWUmEzRWxv?=
 =?utf-8?B?VElGV1Z5Z0IxL2lrYlh2UFF4NjZWY200K2REODAvcG01Q2lmTDdHdytsdHJ2?=
 =?utf-8?B?U0w0cEJkcE5JUlRhKzBPWDl2c1NlWk1rN1R4RVVMTGZUdWM4aU9yQUdwZm5m?=
 =?utf-8?B?UTJTM3ZhUWJrZGxNSVJqQ2RKSXZvczFjK3RvNk1jaFBxM3dIdGJJaU9kSDND?=
 =?utf-8?B?TkhkZVpHZ2FFdCs4Z0tzUzR5aGNKOURxVUVZRnVLTXFURmRJeU9McGcvMVlr?=
 =?utf-8?B?czlnUm9LbUc5UXUwYkNkUkNJd3RnNGYwcW5LdE5JSS9oR1RId09xUXVxVC92?=
 =?utf-8?B?SFFHNmc5U3VwZTJBOTlZNG96TldFdFlCb2RsZjNmWjlFc3ZUeVdZOHlaSVdw?=
 =?utf-8?B?T2hWRzNQUEhzM1pkbjlQZ0ZidVN5aER3bVRzV29TTWo1ajVaai84TEpSdkFG?=
 =?utf-8?B?USsxNzk3cG1hOTlNWXRBK3p0MFk1Vi9RY1Q5TjhFd3VVTHNUQ2oraElvU2JM?=
 =?utf-8?B?Z2NSZTVCOWxiV3FTS1dCQlR0OVg5RWVVUno2RUhhNXBZVCtoU1J6TmFReFl0?=
 =?utf-8?B?SVMra1JVK3NPcmUwZGdEZG45UlU1YTJ5S3ZnNjBiZE0vSXdSV2Z5MXI4OEx6?=
 =?utf-8?B?eUpQaU9FV3MrQkI4MGlaYkFtcEdWSGJtTXo1S2hSRXhjK0Zwek1aMDVMejN6?=
 =?utf-8?B?LzlkcUY5NytrY0pYanduYzgrMDhxOVg2YzNTaCs5RGx3Wmx0TUZuRjh1c0h4?=
 =?utf-8?B?WEFiSFZxS2JweWZpMVB2Q2pqVUJWS1oxeHVRR0JvcmRicFVJMHVRbHlTbjAr?=
 =?utf-8?B?Mkx6NVJXaTlETHFqR2xXWlBHRDAvbFRGYi9CdkltcjVyTHB1MFdHeEFwVjNy?=
 =?utf-8?B?N0xGa0NYRlhJNEpjYW82R3BzaDRqNDRRYml5clhnUGdla0ZpczFPcy9tMmdZ?=
 =?utf-8?B?L3VMNGNRYjMxdll1TWE0R3N4OHR4anIwRzNKS01vUm9oTDAzMVJhb3g5Z2dN?=
 =?utf-8?B?aGY4enpRYVZDSTlNMm9BRSswblBqQ09LaVVleEZsT3NDWlpleEt5c2V6THha?=
 =?utf-8?B?cThEM1F1WlFQdm5oU01qdEdlK3ZGVy9Yd0VTMGhvK0h6K1h6czNaWlVZN2pJ?=
 =?utf-8?B?VHd4SjVPMG50R3k2TXRDSVJtTG5ncHhtME1SVHlHUTAxZnl6QWo0bU9IZTRy?=
 =?utf-8?B?dzZOVkdHVHF5Qmt1YzVIREFhb0NnK1FNWERYSTdKYVZjVTBqWFU1dmswZHoy?=
 =?utf-8?B?Nm81bnpTZy8rdlNSdk1YWVBhRnFNTlBSQWJYZWN1NzcxR3FiblF4V1B6RWFz?=
 =?utf-8?B?VDN2OXlhSzJ5Z29YQ0Fsd0Rlc0FpZUhsamtYYW1jS3dJRHZtRTc3NjdOQzl5?=
 =?utf-8?B?U0llbmY0ek9xWW9LbTRRNndFcVRMY2M2bUdUU2NzdjRJalIycEhQSlE5RVhj?=
 =?utf-8?B?d25lcVMwbStnL0lvbDZEdmpUSHFjUkJlR2YzYjNiTGNkdmVDQ1VTOFFPZHNV?=
 =?utf-8?B?UUpHVytEbDBFUFRCMFNvenhlRUloVDIwUHdQWXpYNjB3M0xQOE5aODhyTCtI?=
 =?utf-8?B?cE8veWdvYmVwbVRkcFFxWUZ0dUhJVHMxckFsdmx3RlZGZ3FhM3pROTEzQWVL?=
 =?utf-8?B?L0RES3pOR1M3TFJ5a2k2OUx6TG5rK053OXJsWjU2T2RIUnFzMXBScUNVbkNu?=
 =?utf-8?B?MFFKbWY3dlFBOExEcWtPYlVUc2tWMEgwUWVvQ2NSZ042TlVLMVFQZlZHYnF5?=
 =?utf-8?B?RXRLaWFpYU9DalBuNTZlT2Uza3FKbmlYU3JTT2FrMW92SHU5QkI5bmtRSlpC?=
 =?utf-8?B?TkpJc2tuSnVsNU9pUjFXNzVqTllJa2VnQXB1eXYxMGs5OWNJV09malA3WGwz?=
 =?utf-8?B?WEVlZXk0VkhNbi8zK0k0cld4WWgrRjRZb0o5Y085VjIrWGZXQ1MrWjZSczBh?=
 =?utf-8?Q?vCybsrs/FZSjp6dhsJy4TEm8O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD9DBA2C1807E4AB5E5E2F455D74AF8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4e3c56-1b28-411c-8e03-08dd18cabd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 03:28:39.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQp8Geh7HE7uHmWSXqPR/v1Se1YbH4YjirPWmZ4fowHfXUipQ7l2NXWl/jPiebANGsdi1IrlFiRis7P7hCDE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7900
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.518800-8.000000
X-TMASE-MatchedRID: UuaOI1zLN1gNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMBfVY7O+c8KYiActr2yXJYt9zZd3pUn7KEAi
	HpwMlPnM2GwJiqvFBX9qspQ7EuDzT0//3OV6Cj+ZH+PTjR9EWkiEdaywSZvzO+Cckfm+bb6AcaY
	+iIPlpkgHXJ8eVIgKFtauPEYeMK/XtzSKzUmDUV0LEoH0ynuZVYQXxsZnRwoJoWKGIJaqJUyAOg
	9E37d4vK4QKo0OX/Wl6PBB2sP26Z9TgPtgJJv6UTgoOmEwe/dqZf5btvM85AYfAYSb4KlgZdWx+
	ZaUPsLMbWOpXABSIQJ9vpuXVh9T3Qv21zJNl0CyDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO0CpgE
	TeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.518800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4133DB796403558A3FD23E6509311AB4445C9891AF25EF3DA4DA25EE37B1DF692000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdCBhbmQgdGhhdCBhbHNvIHBvc2Vz
IGEgc2xpZ2h0DQo+IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgVjIgYW5kIFYxIGNvbnRyb2xsZXJz
IGluIGhvdyB0aGV5IGhhbmRsZQ0KPiBIb3RwbHVnIERldGVjdGlvbiAoSFBEKS4NCj4gDQo+IFdo
aWxlIHRoZSB2MSBjb250cm9sbGVyIHdhcyB1c2luZyB0aGUgQ0VDIGNvbnRyb2xsZXIgdG8gY2hl
Y2sNCj4gSERNSSBjYWJsZSBjb25uZWN0aW9uIGFuZCBkaXNjb25uZWN0aW9uLCBpbiB0aGlzIGRy
aXZlciB0aGUgdjINCj4gb25lIGRvZXMgbm90Lg0KPiANCj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZh
Y3QgdGhhdCBvbiBwYXJ0cyB3aXRoIHYyIGRlc2lnbnMsIGxpa2UgdGhlDQo+IE1UODE5NSBTb0Ms
IHRoZXJlIGlzIG9uZSBDRUMgY29udHJvbGxlciBzaGFyZWQgYmV0d2VlbiB0aGUgSERNSQ0KPiBU
cmFuc21pdHRlciAoSERNSS1UWCkgYW5kIFJlY2VpdmVyIChIRE1JLVJYKTogYmVmb3JlIGV2ZW50
dWFsbHkNCj4gYWRkaW5nIHN1cHBvcnQgdG8gdXNlIHRoZSBDRUMgSFcgdG8gd2FrZSB1cCB0aGUg
SERNSSBjb250cm9sbGVycw0KPiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBzdXBwb3J0IGZvciBv
bmUgVFgsIG9uZSBSWCAqYW5kKiBmb3IgYm90aA0KPiBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICtzdGF0aWMg
dm9pZCBtdGtfaGRtaV92Ml9icmlkZ2VfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2Us
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9icmlk
Z2Vfc3RhdGUgKm9sZF9zdGF0ZSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbXRrX2hkbWkgKmhk
bWkgPSBoZG1pX2N0eF9mcm9tX2JyaWRnZShicmlkZ2UpOw0KPiArICAgICAgIHN0cnVjdCBkcm1f
YXRvbWljX3N0YXRlICpzdGF0ZSA9IG9sZF9zdGF0ZS0+YmFzZS5zdGF0ZTsNCj4gKyAgICAgICBp
bnQgcmV0Ow0KPiArDQo+ICsgICAgICAgcmV0ID0gZHJtX2F0b21pY19oZWxwZXJfY29ubmVjdG9y
X2hkbWlfdXBkYXRlX2luZm9mcmFtZXMoaGRtaS0+Y3Vycl9jb25uLCBzdGF0ZSk7DQo+ICsgICAg
ICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoaGRtaS0+ZGV2LCAiQ291bGQg
bm90IHVwZGF0ZSBpbmZvZnJhbWVzOiAlZFxuIiwgcmV0KTsNCj4gKw0KPiArICAgICAgIG10a19o
ZG1pX3YyX2h3X3ZpZF9tdXRlKGhkbWksIGZhbHNlKTsNCj4gKyAgICAgICBtdGtfaGRtaV92Ml9o
d19hdWRfbXV0ZShoZG1pLCBmYWxzZSk7DQoNCkluIHYxLCBpdCBkb2VzIG5vdCB1bm11dGUgd2hl
biBicmlkZ2UgZW5hYmxlLg0KSSB3b3VsZCBsaWtlIHYxIGFuZCB2MiBoYXMgdGhlIHNhbWUgYmVo
YXZpb3IuDQpJZiBwb3NzaWJsZSwgcmVtb3ZlIHRoZXNlIGNvZGUuDQpJZiByZW1vdmUgdGhlZSBj
b2RlIHdvdWxkIHJlc3VsdCBpbiBzb21lIHByb2JsZW0sDQphZGQgY29tbWVudCB0byBkZXNjcmli
ZSB3aHkgbmVlZCB0aGVzZSBjb2RlLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsgICAgICAg
Lyogc2lnbmFsIHRoZSBjb25uZWN0IGV2ZW50IHRvIGF1ZGlvIGNvZGVjICovDQo+ICsgICAgICAg
bXRrX2hkbWlfdjJfaGFuZGxlX3BsdWdnZWRfY2hhbmdlKGhkbWksIHRydWUpOw0KPiArDQo+ICsg
ICAgICAgaGRtaS0+ZW5hYmxlZCA9IHRydWU7DQo+ICt9DQo+ICsNCg0K

