Return-Path: <linux-kernel+bounces-177135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E28C3A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BC7B20B41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763E17550;
	Mon, 13 May 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p2hPgoRP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eI8HSlMv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10931EB2A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715572185; cv=fail; b=oAth5kFErGYXz8aOkM5TaGVznGNxzNrggxod0VlfRhJiwC9LH563q3a1R4KlkDmax0IX0NgPSaZKWF/3jyCg6+y00pjpRVUGDThFS2UEJSp0+cT0pX7rKIn8jYUYMY1B2HY3UKt2AJ0m4gUkYglV5lUqXbJ1oRwu3bn86tpLND0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715572185; c=relaxed/simple;
	bh=pPHmvGkROxx99ghZ7x6P92FeARHliLIgl+RLcQ42MWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsjdkfA3z+bAcgU8ICRBwnh2dwJD2tAeX76Ex2hNPdnZnoKqqGyA6psJrt9fcVeaTwgmmOEzpZ21m97gv9bOx6RqHbRjo8awwfFF9/gYRKAoYydq6TCruIfqrkiCtsxlZFABx/V4IID7FjtQN4f4jmLNELXAf8YdWVH/VniJSjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p2hPgoRP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eI8HSlMv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cca11a8610db11ef8065b7b53f7091ad-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pPHmvGkROxx99ghZ7x6P92FeARHliLIgl+RLcQ42MWQ=;
	b=p2hPgoRPyBUPxrDgV6eFZRmKxu3VpSRdnTKsoJmbHEEvZOSp7BJBHvfps+f+lr9jcDREhHUGVWHf6PCpAMUMxPyWCYmiigfA7oZFRXgyAHr0cN21OkgOSO2VC+PuWEMe9tHOM56ivXeWsqoVVtx6YtIWmM5hrrS+21KMEQ7M4gQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ba76f785-915b-4684-88a7-06141fcec27d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c60e02fc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cca11a8610db11ef8065b7b53f7091ad-20240513
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 696237788; Mon, 13 May 2024 11:49:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 11:49:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 11:49:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNd275E3W7dCEA41sThNnBHB8zq404BLRGZYImayY3CIHKnhaMd8pRWdHBAY17CqK/sVvRDpqyyNspl/7Oq0ry0aTMff/xD2HUzw+vCKGudBE1vabn0qVdFqCCyuzLON58x3EIG6E0exty3HrBzptb17p+R3SkkJhiHLYeFpWm/0MCeOG//H/ybIuZkOa+OAD/DZpgwA1i15yg/qi2eMK9jYAY5HrOM2xBiuoqRaovUp9whI6PtjthtZOpICxublXfxNfOHGO5hhEMOlTGg/6YybBrI5UVYix/JKM88Z3DaplGTGjC/EBQ3ViKr91vYXEj3osA38lSiBJBNnztatRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPHmvGkROxx99ghZ7x6P92FeARHliLIgl+RLcQ42MWQ=;
 b=KRFTUdqazLC+cuOwWMz2YnQrCM6q6ha6ydtdKas/lLt17qWOaxZd5NiRNIIbmip3LGA0kLJsjmvNf6o+taQPVFS9pWWr+uisd6QALFjYyY13b0OLN22k2ef6umgPcEO8SWzyh02IgvqArlU3MC7L1u6ZoUDCjlOPIedNUp2vKbzSwZG7jcnaiOvPcUMdxGS9X3g4+FgZYnk5OWo3RFssxFKUZ0xhgyT+o9yQ6NtqEnMgsfYIoFLwAz+L7UeyS3wHRm/M5KYMN1aX3VSB/c3rVLYTTTz4OY1D4JP0FmacKXJDyxfP3x2em7WsYdQerV9crFXJqFWX/Wy0v4Uh3kO81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPHmvGkROxx99ghZ7x6P92FeARHliLIgl+RLcQ42MWQ=;
 b=eI8HSlMva3vhmNFG5wU1CP//bAft9oYJUSBF0Qc3E7vsnDiopO6R5BtY9M/Bzj91FGo3BWE8h5CRgtzcRTwkbfzZgBMU1HdhiTQbF8V0bxFhKIVVjixz8qRVstCwY4QH9nMcaM+L49ZCYJ9P8mUCdkmvIm7nJkbysFkSGV9BZ48=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by JH0PR03MB7982.apcprd03.prod.outlook.com (2603:1096:990:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22; Mon, 13 May
 2024 03:49:26 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 03:49:26 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] Fix get efuse issue for MT8188 DPTX
Thread-Topic: [PATCH v1 1/1] Fix get efuse issue for MT8188 DPTX
Thread-Index: AQHaoqG6xjcGXP+E0ECiLfoD1Vz4NbGQPv2AgARM14A=
Date: Mon, 13 May 2024 03:49:26 +0000
Message-ID: <2f831b6ec2123001134933c2d75d33602696e528.camel@mediatek.com>
References: <20240510061716.31103-1-liankun.yang@mediatek.com>
	 <f72b241f-11ab-4165-af51-14413d4e9f7a@collabora.com>
In-Reply-To: <f72b241f-11ab-4165-af51-14413d4e9f7a@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|JH0PR03MB7982:EE_
x-ms-office365-filtering-correlation-id: b2d5ebb8-b078-43b0-7bcd-08dc72ffaf59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZmhnbEwyaE9VMTIzdkFRb3NWRHRtN3EyU01HWTdFUjZlaHEzNlBaK0xsRElE?=
 =?utf-8?B?THJwTWthU09MbXlsVUhINUtmdnVFSmMzSUxNelh6YzhKekRiZ0tlVVJiUS92?=
 =?utf-8?B?REtxM3EvbnpmU25HK3I1QmdidHBWRXE3dUxpNHBXU1lWRmVwYUxUS0IrYWJi?=
 =?utf-8?B?VGpwcVZSNjhBdkdqaGtTdkZ5aVF1VGRibzgwb3hWYmtzNU8wSHd1MCtBcFVG?=
 =?utf-8?B?bW9rb1ZxcERWQVhUaXd2Y2JOZGgwbE1MVVk4YXBnWC9kbUJkdEV2RlJIdzFz?=
 =?utf-8?B?V3NzczY5Y3pjVkJzYVZXMUI4MXVzZGpoK3hERE9XRVA3MVVZcWFCS01WQ1ph?=
 =?utf-8?B?bUdnaW5SU2FxQk15NDBmSXpRSXl4UUx4UU5JOVZTcVhIb2Q1ejJXLzh3SlRE?=
 =?utf-8?B?djlpLzdLa0h5ZzdiYlpxU0VoSklzUFlrYmpaNWlraXowWk5ZU3VoSEt0TUFT?=
 =?utf-8?B?RW5saW5PbHUwbWxkK2xYMFhOOTZXb2ZNazVoUnVZbWlabStyMFNjS016UUM2?=
 =?utf-8?B?M3Z3QTFtVVRrQlJyQUx1cDRvaWJnTXNVMi9MT2VtQXZjV1FMTW0xWVRuNGMx?=
 =?utf-8?B?SkZvZyttSnA4WjRYNHY2TDh2TEs0ZVlrSEszT1pjT1NCZnl1cnVzcGJhS0lk?=
 =?utf-8?B?ang4dHV0RW5ZSGFTbCtzV2s5NDdZTzBTRFgrd0lmUTdjVWV5OXRTTjc1L050?=
 =?utf-8?B?SnBVeGVncldHTm53bkx2Q1lnRkNLUHVNMC9LZ0xMZmJnMVJmMVJvaU9rbVZu?=
 =?utf-8?B?WVo4enRQKzhFVGU2V0NSZWYyc1I0UUJzMkloQW1rY1VWYVhkbnVCMDhlTkJC?=
 =?utf-8?B?WWRXT3crdjlOQkpTSE1FK1M0S0RMUXlUbDNabjFzM1UxcEJ4VnZJNjBNZWN0?=
 =?utf-8?B?dkRnTEgxVlhCcEZsM2t5VUtkWkVNV0F2ZHh3Q2JCY2FBaEcwcEVqcjRMbmo5?=
 =?utf-8?B?S0RIRkZZc3dwbzBOemxLc0NyeWFNMnF2UTdGNVhQUUtpL3pJNlZpTVNjOVZ4?=
 =?utf-8?B?cUZaTFFiRlBHNC84TzVKM0UvcU5pVEluejZUM0hoN3ZXcUVYRUtwWnQrb3dJ?=
 =?utf-8?B?d081eUx0SUcrRlBzSmJLanFSMDMvWW9HbUpHZm1JWWNSaHhjSHR2REQzbmN6?=
 =?utf-8?B?L0F2cUo1Zk9kUy8xaExJOEhWdVhqWWxlZkdYSXZ4bWlsT0tjMURVV0xlbktJ?=
 =?utf-8?B?YnBvNlIyc1pMTktQMHJoRHhTeVBWeHFzVDFydi9Oa09tQW5TVjRTbnVlSy9x?=
 =?utf-8?B?ank0S1VUd3RWZDVVMzR6NS8rNENLY3c4UEJhYlBWSTAzcDJoNytHbUwrcndh?=
 =?utf-8?B?L2xYdUcxRDNJRDMwQTNlQ1lGVWdUbFJLSVFMQndQYkpjNGRRYTdJOG9tNFdv?=
 =?utf-8?B?STlSTDMydXNsNzVlR29XOXV2WElsV3JueFJrMHl3VThXZWhxL1Z3c2liM3A1?=
 =?utf-8?B?WXpsV0MyazVqNHhYUWYyOVlZWURnR1RHcjN0ME5TL0piblVkZjFDeVBwWk5t?=
 =?utf-8?B?eTZ2VkVwY0M3YXpUZHRTWm93NTJsNHE3MTRlWndFQ3c0THpGalVvVkV5OEIz?=
 =?utf-8?B?MDBONTVkbUNmY2cyak00VmJ2YkFlRk8xSll2ZkZ5c1p0ZmtMWG90SVJVZEdw?=
 =?utf-8?B?MnRSYVJpeXNvc2RzRlNOSmp6L1VtQnNlZURRQWwvaFh6dy80VjVXZGU3Y0dL?=
 =?utf-8?B?Vk1mYm9XYWF4WkpldmI4OVZOZ1RxZWh6MUtnT2FIVDZUcjNqM0NTaU5RY3Iy?=
 =?utf-8?B?ek8yQzk5cHRKY3IvVlZlb2ZRWXVCVFFhbHhTVzRncEVDd0V5N2crNFhuNzlm?=
 =?utf-8?B?K0NLL3lIRG1LTWc1cUtKUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5OaHQ4OFhmRHVrNUtXWURFRFFsVkZGK3hRdG4zbXozSVJKVjhNVUVXTlZQ?=
 =?utf-8?B?V3A1SklxbFQrb1ZzMElZWC9NQTl0V21QTWl0emhUcU0xT1BxLzJNNjFwbFBa?=
 =?utf-8?B?bVFsZHlEaE84TFFDdDdyWjREZjlVYXJLM3ZzeFBTTzBNWE9aak1vZUsydkFJ?=
 =?utf-8?B?ajJ3eVpNMHhIY2FGN1g4V250dzBzQmErby9mTE9NY3ExVUdocHc4QTFHTVR2?=
 =?utf-8?B?a2s4L0RURURTRE53WU95K3lwcHBNK1BSbk51Z3I3Nnk3RUQ2UG5sWldOcUpG?=
 =?utf-8?B?TklkUUFIdi8vN0dnbjhOa2V6aXBzb3JmZFhQWElNNEpGeXAvQkhpQ2FWN3NJ?=
 =?utf-8?B?eEI1anRNZGpXSENnT3lla2RjdFdyYzhzUmtyNE1LSkp2Z1F6VmN2UjBRV204?=
 =?utf-8?B?cGpIcldtd1paL0dSNmNMWk9SL1RDZThIY2NHWmpUSFhhaTU2NTVMU2tybDVo?=
 =?utf-8?B?bVE5R2lWN2tBY0hIU1N0N2JIMmtGUWlOV1Q1bkNNZnJrUGpmR0FUSmpWcFFM?=
 =?utf-8?B?cWRSZGorUU4vR0Y1MENHT1JJYnhrWGdNUjV4Q2VUSTJISEpwa1Y5Wm5VOG5z?=
 =?utf-8?B?SXVHYWxsZDBSZ01aS01adHVjQWxNQzBQRk90VFFhbU11R2lXQkh5NFpXaFVG?=
 =?utf-8?B?YXpEOE9wV3RVNDNhTFhDbW44RDg5Y1F2U2xqUVhrTzBidUZVeU9FaUdDWkti?=
 =?utf-8?B?anNSYWZtSFRkNzM2SWtCbUZFTFJRWEg3eFRHOXJJb25KZVh5QnlaOG1HaC9B?=
 =?utf-8?B?ZjBJODkwbXVBNFRIVGR0TVFOcHNjeGN5YkYxRGJma3p4S2VyMUl5a1RTTStL?=
 =?utf-8?B?SDkzcWhnRmVQb2xjTlJscDh4UW04N3hiYXVxLytaSjNxNTRWMVJOcnJOOE1q?=
 =?utf-8?B?Q0RwbUJ0ZlpZOU13VEprdUloUzlvalhkUDFWdWVHWVFxNnpKMmJmN0pIcXN0?=
 =?utf-8?B?dnVZbXVUUWtKNWVYMzlTQ1BleklERGw1VFFRZFF2ejJFR2N1NHZrMVA4Tzhl?=
 =?utf-8?B?OGVvNWpDWFNiNjlUclZDVVRXUEdEUjhyUjhpbGx5bXZ0Z09uaDhIL3dhcTVC?=
 =?utf-8?B?NHJ0YytXb1NySkwrRzlsUTR6UVZsTVJ1ZnEzWGFLWVFOdktPK3VNcEZaOU81?=
 =?utf-8?B?dWR3cWZ3Rk9EaEJMMGxzZGRGVFVHUXRhbnRoRnoxZHJqcWViamIvQnRHVkEw?=
 =?utf-8?B?SGxaZmFsbEVSSHFIRnlEZ01mcXFtWlF6cXdxbWFPOXlFeHdld2xHQ3lqUDVo?=
 =?utf-8?B?SGVJYzhmUHI1dXZqUS9YeW1GbDFoei8yVVh4NVBEWVFQdytRU3dnbmJqd1VG?=
 =?utf-8?B?S1RWTGJyRWQwSWJqVnJZTktvUzE4S3Y2UjFweCtueEFlNzdiZUEvaUpTQ3g0?=
 =?utf-8?B?WlhESk1senJBQzdsYUd2cm1ESUl6WHRaV1VMWXo0Zi84R3pKdUNERmt0Wk5x?=
 =?utf-8?B?SDBZU2tqdlphQ3c1ZGwxdXhkQ0szaEl2MEJqeDhDT0F2Z28xNVl4SURvOGk3?=
 =?utf-8?B?dlpaZkxtR2wyL1crV3hDQ2lmbVBZUFI1R1dIcS9HZ0lxQnJxK3lLMFJyUU5G?=
 =?utf-8?B?TlNQenQ0VTdSNGs4cWpDazRsWEE3bEJDU1FUZFNyZ29JeFF0YTZvVENoYzV4?=
 =?utf-8?B?cXFZTFp5ZllBeWZwTDZJajNwS2NjQklXSHZWUElsS2JoUjVIQmp0VDJRNk92?=
 =?utf-8?B?OGFTaFhWSnRVWmVDTHBTbWhnbUFpcENhUFBGRjZnSDlrRFYrL0ZZRHhPMDY3?=
 =?utf-8?B?bTlQS2ZHbVRZdmdEQTA1VURVb3VPalVGOGZxZ1Nnd2JRWVVJUVRnQjlGaVpp?=
 =?utf-8?B?QzRKZWlhVkNlN1BDbmk3QWxjTzBOVU9rTU1zMnNkbHNpRXBQM1Ixb3BoWW5Q?=
 =?utf-8?B?VDl0UXRoU1BORlh0NjRneXAvQ0xJSEZwUzNCR0orM213akRvc0pubWlOYW01?=
 =?utf-8?B?Wnd3SHBVUFNSbDJhK29jVVlsZmd4a2hGeGhaUWFmb0c5MHhjNWd5NU04bER1?=
 =?utf-8?B?blpvMTZhWWtXUlZJSFg0U1dxZHgyVDJScm94OUh2UUozcmE5eFg0bU9DY0Zs?=
 =?utf-8?B?bkJBME93bnhkRHQ3SnRHdmh1QXFNZVdHbXpkZzNQMlJwbGd3dndlRjZnenhZ?=
 =?utf-8?B?WnVWV3NwSGtndXllT1dvUi9Ud3M2YWFnQmw3c3JjaUNNMk1Kc0RQdWNwRmI0?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1A783009D2D164691A77229839D1332@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d5ebb8-b078-43b0-7bcd-08dc72ffaf59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 03:49:26.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dba+2rhrciarueNg7SVh5lxPIXDjxtFB6HZ9bLxsaiVH5VXBZR9oKQ2MHyn31IFolyzyEF9nW8Xhpby+7SGmoAqHwItJ6Z0AqAg6siu6PZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7982

T24gRnJpLCAyMDI0LTA1LTEwIGF0IDEyOjA5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDUvMjQgMDg6MTYsIExpYW5rdW4gWWFuZyBoYSBzY3JpdHRv
Og0KPiA+IEZpeCBnZXQgZWZ1c2UgaXNzdWUgZm9yIE1UODE4OCBEUFRYLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IExpYW5rdW4gWWFuZyA8bGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbT4NCj4g
DQo+IEkgbWF5IGFncmVlIHdpdGggdGhpcyBjb21taXQsIGJ1dDoNCj4gMS4gVGhlIGNvbW1pdCB0
aXRsZSBpcyBpbmNvcnJlY3QgLSBJIGRvbid0IHNlZSAiZHJtL21lZGlhdGVrOiIgLQ0KPiBwbGVh
c2UgbG9vayBhdA0KPiAgICAgdGhlIGhpc3RvcnkgdG8gZmluZCBvdXQgdGhlIHJpZ2h0IHRpdGxl
cyBmb3IgeW91ciBjb21taXRzOyBhbmQNCj4gMi4gVGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBpc24n
dCBkZXNjcmliaW5nIGFueXRoaW5nLCB5b3UncmUganVzdA0KPiByZXBlYXRpbmcgdGhlDQo+ICAg
ICB0aXRsZTogcGxlYXNlIGFkZCBhIGRlc2NyaXB0aW9uLiBXaGF0IHdhcyB3cm9uZz8gV2hhdCBk
aWQgeW91IGZpeA0KPiBwcmVjaXNlbHk/DQo+IDMuIFRoZXJlJ3Mgbm8gRml4ZXMgdGFnLiBQbGVh
c2UgYWRkIHRoZSByZWxldmFudCBvbmUuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA4NQ0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcC5jDQo+ID4gaW5kZXggMjEzNmE1OTZlZmExLi4zMmIzNmI2M2E0ZTEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ID4gQEAgLTE0NSw2ICsxNDUs
ODkgQEAgc3RydWN0IG10a19kcF9kYXRhIHsNCj4gPiAgIAl1MTYgYXVkaW9fbV9kaXYyX2JpdDsN
Cj4gPiAgIH07DQo+ID4gICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZWZ1c2Vf
Zm10DQo+ID4gbXQ4MTg4X2RwX2VmdXNlX2ZtdFtNVEtfRFBfQ0FMX01BWF0gPSB7DQo+ID4gKwlb
TVRLX0RQX0NBTF9HTEJfQklBU19UUklNXSA9IHsNCj4gPiArCQkuaWR4ID0gMCwNCj4gPiArCQku
c2hpZnQgPSAxMCwNCj4gPiArCQkubWFzayA9IDB4MWYsDQo+ID4gKwkJLm1pbl92YWwgPSAxLA0K
PiA+ICsJCS5tYXhfdmFsID0gMHgxZSwNCj4gPiArCQkuZGVmYXVsdF92YWwgPSAweGYsDQo+ID4g
Kwl9LA0KPiA+ICsJW01US19EUF9DQUxfQ0xLVFhfSU1QU0VdID0gew0KPiA+ICsJCS5pZHggPSAw
LA0KPiA+ICsJCS5zaGlmdCA9IDE1LA0KPiA+ICsJCS5tYXNrID0gMHhmLA0KPiA+ICsJCS5taW5f
dmFsID0gMSwNCj4gPiArCQkubWF4X3ZhbCA9IDB4ZSwNCj4gPiArCQkuZGVmYXVsdF92YWwgPSAw
eDgsDQo+ID4gKwl9LA0KPiA+ICsJW01US19EUF9DQUxfTE5fVFhfSU1QU0VMX1BNT1NfMF0gPSB7
DQo+ID4gKwkJLmlkeCA9IDEsDQo+ID4gKwkJLnNoaWZ0ID0gMCwNCj4gPiArCQkubWFzayA9IDB4
ZiwNCj4gPiArCQkubWluX3ZhbCA9IDEsDQo+ID4gKwkJLm1heF92YWwgPSAweGUsDQo+ID4gKwkJ
LmRlZmF1bHRfdmFsID0gMHg4LA0KPiA+ICsJfSwNCj4gPiArCVtNVEtfRFBfQ0FMX0xOX1RYX0lN
UFNFTF9QTU9TXzFdID0gew0KPiA+ICsJCS5pZHggPSAxLA0KPiA+ICsJCS5zaGlmdCA9IDgsDQo+
ID4gKwkJLm1hc2sgPSAweGYsDQo+ID4gKwkJLm1pbl92YWwgPSAxLA0KPiA+ICsJCS5tYXhfdmFs
ID0gMHhlLA0KPiA+ICsJCS5kZWZhdWx0X3ZhbCA9IDB4OCwNCj4gPiArCX0sDQo+ID4gKwlbTVRL
X0RQX0NBTF9MTl9UWF9JTVBTRUxfUE1PU18yXSA9IHsNCj4gPiArCQkuaWR4ID0gMSwNCj4gPiAr
CQkuc2hpZnQgPSAxNiwNCj4gPiArCQkubWFzayA9IDB4ZiwNCj4gPiArCQkubWluX3ZhbCA9IDEs
DQo+ID4gKwkJLm1heF92YWwgPSAweGUsDQo+ID4gKwkJLmRlZmF1bHRfdmFsID0gMHg4LA0KPiA+
ICsJfSwNCj4gPiArCVtNVEtfRFBfQ0FMX0xOX1RYX0lNUFNFTF9QTU9TXzNdID0gew0KPiA+ICsJ
CS5pZHggPSAxLA0KPiA+ICsJCS5zaGlmdCA9IDI0LA0KPiA+ICsJCS5tYXNrID0gMHhmLA0KPiA+
ICsJCS5taW5fdmFsID0gMSwNCj4gPiArCQkubWF4X3ZhbCA9IDB4ZSwNCj4gPiArCQkuZGVmYXVs
dF92YWwgPSAweDgsDQo+ID4gKwl9LA0KPiA+ICsJW01US19EUF9DQUxfTE5fVFhfSU1QU0VMX05N
T1NfMF0gPSB7DQo+ID4gKwkJLmlkeCA9IDEsDQo+ID4gKwkJLnNoaWZ0ID0gNCwNCj4gPiArCQku
bWFzayA9IDB4ZiwNCj4gPiArCQkubWluX3ZhbCA9IDEsDQo+ID4gKwkJLm1heF92YWwgPSAweGUs
DQo+ID4gKwkJLmRlZmF1bHRfdmFsID0gMHg4LA0KPiA+ICsJfSwNCj4gPiArCVtNVEtfRFBfQ0FM
X0xOX1RYX0lNUFNFTF9OTU9TXzFdID0gew0KPiA+ICsJCS5pZHggPSAxLA0KPiA+ICsJCS5zaGlm
dCA9IDEyLA0KPiA+ICsJCS5tYXNrID0gMHhmLA0KPiA+ICsJCS5taW5fdmFsID0gMSwNCj4gPiAr
CQkubWF4X3ZhbCA9IDB4ZSwNCj4gPiArCQkuZGVmYXVsdF92YWwgPSAweDgsDQo+ID4gKwl9LA0K
PiA+ICsJW01US19EUF9DQUxfTE5fVFhfSU1QU0VMX05NT1NfMl0gPSB7DQo+ID4gKwkJLmlkeCA9
IDEsDQo+ID4gKwkJLnNoaWZ0ID0gMjAsDQo+ID4gKwkJLm1hc2sgPSAweGYsDQo+ID4gKwkJLm1p
bl92YWwgPSAxLA0KPiA+ICsJCS5tYXhfdmFsID0gMHhlLA0KPiA+ICsJCS5kZWZhdWx0X3ZhbCA9
IDB4OCwNCj4gPiArCX0sDQo+ID4gKwlbTVRLX0RQX0NBTF9MTl9UWF9JTVBTRUxfTk1PU18zXSA9
IHsNCj4gPiArCQkuaWR4ID0gMSwNCj4gPiArCQkuc2hpZnQgPSAyOCwNCj4gPiArCQkubWFzayA9
IDB4ZiwNCj4gPiArCQkubWluX3ZhbCA9IDEsDQo+ID4gKwkJLm1heF92YWwgPSAweGUsDQo+ID4g
KwkJLmRlZmF1bHRfdmFsID0gMHg4LA0KPiA+ICsJfSwNCj4gPiArfTsNCj4gPiArDQo+ID4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9mbXQNCj4gPiBtdDgxOTVfZWRwX2VmdXNl
X2ZtdFtNVEtfRFBfQ0FMX01BWF0gPSB7DQo+ID4gICAJW01US19EUF9DQUxfR0xCX0JJQVNfVFJJ
TV0gPSB7DQo+ID4gICAJCS5pZHggPSAzLA0KPiA+IEBAIC0yNzU4LDcgKzI4NDEsNyBAQCBzdGF0
aWMgU0lNUExFX0RFVl9QTV9PUFMobXRrX2RwX3BtX29wcywNCj4gPiBtdGtfZHBfc3VzcGVuZCwg
bXRrX2RwX3Jlc3VtZSk7DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10
ODE4OF9kcF9kYXRhID0gew0KPiA+ICAgCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RP
Ul9EaXNwbGF5UG9ydCwNCj4gPiAgIAkuc21jX2NtZCA9IE1US19EUF9TSVBfQVRGX1ZJREVPX1VO
TVVURSwNCj4gPiAtCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiA+ICsJLmVm
dXNlX2ZtdCA9IG10ODE4OF9kcF9lZnVzZV9mbXQsDQo+ID4gICAJLmF1ZGlvX3N1cHBvcnRlZCA9
IHRydWUsDQo+ID4gICAJLmF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSA9IHRydWUsDQo+ID4gICAJ
LmF1ZGlvX21fZGl2Ml9iaXQgPQ0KPiA+IE1UODE4OF9BVURJT19NX0NPREVfTVVMVF9ESVZfU0VM
X0RQX0VOQzBfUDBfRElWXzIsDQo+IA0KPiBTb3JyeS5JIHdpbGwgc2VuZCB0aGUgc2Vjb25kIGVk
aXRpb24sYW5kIGZpeGluZyB0aGUgY29tbWl0IHRpdGxlIGFuZA0KPiBjb21taXQgZGVzY3JpcHRp
b24uDQo=

