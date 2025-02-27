Return-Path: <linux-kernel+bounces-535623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4DA47546
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE98188BFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B88209F3E;
	Thu, 27 Feb 2025 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mjeNdxY8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X4vi8hpZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1E1EFFBB;
	Thu, 27 Feb 2025 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634623; cv=fail; b=EmV8B5awhsND6NaFyoL4TzIPB/2Y6qm69oRX3Ur7YIcEsuh8JynzjWtkKWvwVDVO+Ux63jWojdTb5Hj38jjXqaD5eGPrVwGDU/RFN0qeSxULKGYT1wzRBYktM3xqaorJmmJTTlgoq1kKiPKRNPCYjR+jLod8vCougv66ROtaCfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634623; c=relaxed/simple;
	bh=+GC4OU6Z7J3eCoy1txBseTzgjxWAQVgv3m7GXHY4+Gs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0NA3yKHCYcxQfnqN3kl+NFy18wQmO+jE2a8A17CiMa2O/af57EDwqWXwpu1eMzFjp1M9E34koNg0KXe8KVPU/VAvMDt31I3fdsOUldg2rBzn+ouTbJvmKDiNlIe7hA8kO5GUamMojL6UAc3cKrbRp78ls55mO9Ht42Zra6WpNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mjeNdxY8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=X4vi8hpZ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da5e92ccf4cc11efaae1fd9735fae912-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+GC4OU6Z7J3eCoy1txBseTzgjxWAQVgv3m7GXHY4+Gs=;
	b=mjeNdxY8RsTzW0Y05LU6zFIKuMoG+vmkEpnKk1aCs+RZJ6FmZhHxoFiseHw9LVMbEB0v1RFga5AMGt1mYaNV4yfeWNDKEaMsaRATlGg2pvDyXHggE44PQIz/kIxWvh01cn1tkVCX5jlsZZLbi3yLWjpiCWdqzpekD7zMorBygSY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:aa1af610-3e8a-4a81-af15-c748e0c91770,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:60aa074,CLOUDID:aa5dfbd9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: da5e92ccf4cc11efaae1fd9735fae912-20250227
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 993488425; Thu, 27 Feb 2025 13:36:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 13:36:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 13:36:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjkXGXEhqZ7tyb7IQX+aHy2cevzW2g7D29LYECErie0eS3/IuC57dsRfS6TtV0swWzZpIAwkG+KuLloBLdA8ZNWfzwTVTyZGgbsxpHVtdZzSLxBrXsSHA6hH6r76k4+/m/uoRWV6QmAZ/OU8sX9xGat428ZZHEFz2lLfaSvjRVU70am8G4MaJjD+heYH3ydR1O+P6iCCSmrTI1M58qvIfkeFAuur/JpKA4d5HUuFjgURlcn3Tpp0/+O4ozKfJlbmTK942coWDqv0VHWm3RQK0t4nLNHKLYj5F7oGF6bsXa4silMUqJ8tEuoSIv6VV20qhrZYR28r9hZ2vs2KSALQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GC4OU6Z7J3eCoy1txBseTzgjxWAQVgv3m7GXHY4+Gs=;
 b=DhrEJEOrpW0SsCqgJDj2vHpNPQ5WqKawZGIN4giuxu778HWSHP21lC2LnixIfbfkW4dZrp6jrj9a73nx4LwTcxX4t6tcsDGRQDxYgedlqM9XSQYqaQrglN5QLmECMK8H8r5LyJo0K9UFGnsnM7KNEjuSmHR99kBDtT8ZV1PBnodom9ZtQB24DPgDEd5zXdBrqBPkRMlHqpsP1p5XL30x59d/mQj8K/28aW4zseqfouY3nBaj6mugutlGNXtDEnWiZlptrFEQATZHM0iPufOkPbCs1Bg1/1x/spCVEYzcRhiQiV1RJFTK0bz7z3e+OR8IBlxn46JmcGyH8dMCijizoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GC4OU6Z7J3eCoy1txBseTzgjxWAQVgv3m7GXHY4+Gs=;
 b=X4vi8hpZECyl1TgEBSyVYWVdvKMFpiJHe4wx/eZ8g9YvULddYuHMr6je1Cd9LwwAiryxRAqxLSDcDlgqR+thFUjqBq80nIZlEMvna8+QeCdvL4VAyJ7Sj6SEadSLoKK1iKyNqv0W0PpYSlVdHk6Xv/lYNbVGU6MuY1ZmIbYaw2w=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8717.apcprd03.prod.outlook.com (2603:1096:405:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 05:36:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:36:50 +0000
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
Subject: Re: [PATCH v7 12/43] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Topic: [PATCH v7 12/43] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Index: AQHbgVRXXnAYLmNU4km5O/1OMNRluLNasIoA
Date: Thu, 27 Feb 2025 05:36:50 +0000
Message-ID: <6e301af02e349b7499f254fa618c4129cbfe8302.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8717:EE_
x-ms-office365-filtering-correlation-id: 7f0a8b6f-8f2f-4639-a1d7-08dd56f0bc3f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vm1pNEJKSmRRRG5DMHR1NGsrOFAyVEdHNm1XdTRuaC9zTGF3enVaMkhJcW9Y?=
 =?utf-8?B?UVdxZ1lXbWFoblAveE91czdQd3VRT2ExMTY2T3pXYi9pQUlKcFJPSmhUd1VG?=
 =?utf-8?B?Z0VRYTVHdWxITnFGbFlXYzlGeXQ2UFFxaFgvNmo0MVZaak04QTZwaGg2Q1Rv?=
 =?utf-8?B?MWkyVlhYM1FheGgvU045YSsveEZ4eGZmaEkyMk82QVMwM0lyaFZsa0NyUExm?=
 =?utf-8?B?Z0RWQ012aUZXb3UwbCtlMElNSmExTkhzZm9jU1BJTUVXSjVIWVZnaFNFREM3?=
 =?utf-8?B?cktiWkE1ak1JMUkySk9abGZmWlUzalJNOHBGcXVoZ2tqMUdpdWU2VHIrYmJt?=
 =?utf-8?B?S0dTY2hwa05YTUt5YnZzaEI3VjhwRWNhalhRZ3YxdnhHUnZ0cEgxcDZtZk9F?=
 =?utf-8?B?eDl4emtPbHNYVCtROTYwYXBKck1ZazdjWTJaNjJZQThiYkhEV0Fyb2tQR2l0?=
 =?utf-8?B?OHh3U1BHOVQ3OHNSVytzSFJ0NWk3Sk80WUdIMDl2b2hjWVhoTUJEbHJQc2U1?=
 =?utf-8?B?L1RwT2d4QmpxbVBNbE8zK1B2VFZxUzZ6a1V1NlY2QVRQeFREZjF4K1MwL3h4?=
 =?utf-8?B?RzBCdlFydVFVZjlMWGtoRTdIOUtnUjFOVS94RGxjc3k0cVlLNTFiY3VzVVlF?=
 =?utf-8?B?RW9uM0RNVThRL3ExME9EMEJjZWltY2tRUWdFTHhYMkQrQUJqczBhRDVKYXdR?=
 =?utf-8?B?SXlsREtKZXhlRHlIalh2aXRsSW5iT0tVbUlmRlJnczhaUjJtenk2NXBJTlJG?=
 =?utf-8?B?aWpQN01Cdzk2OGJVdWVUNTFHYlhHZXlickNianJnK0ZYakJUeUJzSUFrYXdW?=
 =?utf-8?B?dm9GdDlUblRxTFlaTkpxaFBzL3ZqZU1ka2RKckh4THNwc2l1SnNSTTVUUVZM?=
 =?utf-8?B?RUpINmdUMGJCZnBHNk0yUDdiUlZlL1I4azJtUnh2SGttWklsK28rQnlSY2dZ?=
 =?utf-8?B?Y2JNQlpYVFVGS3ZTZkFZczNiQnJEWThSQUFYUDJWaDhBaGxlZmVaUkxnQ3ZJ?=
 =?utf-8?B?YTUrN1V2TUQzRmEyYTMwUUVlZThkZHU3bWoxTlBtT2UzTDQyRnZOUjR3eWc0?=
 =?utf-8?B?a0txU0ZYOGU5eVZsSU5mYjBHdU5abU9aK0FoYUwwZjVZUVQ5VUxrUng4Tmtp?=
 =?utf-8?B?d3AvNkVVMTF1eWRqWGM4ZE1WY2xzY0IxVGNxZHVoanZ6WTMwWUVsNGdRS3da?=
 =?utf-8?B?SUtNV1JQVjJieHM1VSswUm1sNlVJSlNhTFlTY2h5bGY0eFBGdCs0ZlAvdkZ0?=
 =?utf-8?B?M3praCswQkdoMXEvc21MZGN6bzkzRS92VFpkb1lyalk3NWtHTVB4QlhWK3dD?=
 =?utf-8?B?d1JkMTluKzZGOE1pQ3ZpMDcrUEovNkE5aGdYMXoweHBoTnBhbDVlMk8vVThF?=
 =?utf-8?B?RVdSL2JZOENMelVSQ2J5Ri8xTGFwSHI5VHJyNW5hQlc5bEo5a1BVcVNnb25v?=
 =?utf-8?B?VSsxMGQ3UkdPRXJFZjk2QUloNmlINjkvZGdFRUliODA3VDcvWW8rWDRVL0s5?=
 =?utf-8?B?Z2pJbHFEcDUzMGc0ODhWNVJCOG1yNDJLODM2OVJCSnBneHpQb0dKcXV2MEMx?=
 =?utf-8?B?aURJTVg2T0hVbXhoNUJmUFNJRyt6bG9ocFZMSENHdmhKQUhPbC8razJaOFQ1?=
 =?utf-8?B?eFdUTjRpZDgyWEM3UmcwSnFwT2lXcUVyMkcrVG9RaTN4a1loSE1Qb3JPaW1J?=
 =?utf-8?B?OW1yeVZOc1ZmNTlvbG9kTC9WNGZJdC8vU0JCMUloQk5qTFB5aUNLOE9NbDlk?=
 =?utf-8?B?ZEpjZitOZEVGeHUyMFlyd3pxcDVmdnJpQm56cjhyd1o3UXJsZ3I0Q3A0MlRx?=
 =?utf-8?B?SExKaXBuYlJKMkhGRWFPRnhjUzZSSHQ5Ly9FSjFSNG9FTEZBUmJtWS8yUDlY?=
 =?utf-8?B?MjdMemRHZHZLeTladFdycFY4OUZLdTk2QUFnZVJkWWt5M3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elYxSUtjU0Y3YWNMLzNaZTRac1ZiWnlVQlVISFVxamx4RjdZMkI4RnI1ZlZH?=
 =?utf-8?B?VG5KNHJERVFyWCtEMVBKbGUvSHFWeDV5ckwzZUx4d1FNWitubTZTUllERnQ2?=
 =?utf-8?B?NTh6SDYrYWxzamlKc2xyYlE2WU14Q1lUVjk3QytKUmRkdWJDLy9zVE5PL3Qv?=
 =?utf-8?B?VXdCaGNnOCtsL0lNaGNZTW5DUFhZcDVGdHBENHVYRTA5ZHVRMzMxY20xZXlt?=
 =?utf-8?B?TWRFb1JneXZLVkF4SFQ2MUFaeDBUYUN1ZHo2ZDk3TitvSnppSlc3UXhMaEdP?=
 =?utf-8?B?TE51YzNWc0drUTZZSHJuVmZ6em1BUUFacDRNN2JKZUJ4S0p2U1ZEOVE3TTls?=
 =?utf-8?B?U0F0dStKZ09qcnpONVpUSXJpOFBGYW1TbzZTNGMwUjRqdXFwWGcyL25wN1cv?=
 =?utf-8?B?WEZ1aXlTUE1RTFIwY2hPOWVPZG1nTjUwZk1wbkordGhCREdSQlk0T3BJYmRT?=
 =?utf-8?B?TzNENGxIVzJLaTlXVUMvMzdOaWNCdnMxcWNVSllSTmFnZGw3aDlMb0hDRU1W?=
 =?utf-8?B?WkQxRGN1c2ZFQ0EvM0VvWFNCZnp4N3ZuVmhVczdtV1NUa0hKRllIYXc4SE96?=
 =?utf-8?B?VFZHT0doQm95am4yWE1za3UzdzJmU3NVMTZCbDl1N0EwRFk2bWlqNHc2eTB1?=
 =?utf-8?B?SHFxZTBwVFhtK3gvQ09FR2xoTzdwcHB5YmRYL3dDbUp2SG8vRFdaWFA0OXB1?=
 =?utf-8?B?dDBtUjVrOS85Ylo0L2o1eFZ5MzdpNU1RSkVRalRxNm0wZmNvcHdEc3I3UUFC?=
 =?utf-8?B?bktHdmJta3ZzbmM0YlphVTNKYTgyZWhVcEpSYmptM2tlUnpuZGlIb3ZHWFIr?=
 =?utf-8?B?Wm5sMWdsOUlldm56WjQ5QTh1RkU4ZHZoVUZEZ3BxTjd4OWlDRGxwdmNjbjJn?=
 =?utf-8?B?YzJvVGdpQmFqQTVsZmxNZmNaV1dTMkFXZTZGdzZyMUpiMXo2V1BnNTJPNm9T?=
 =?utf-8?B?Ny9wcWpleWdvRHBvNWU1aUoxWkM2TTBnUW5MTDFuWmpwanh5eU5BU01jU3hG?=
 =?utf-8?B?MWJudlh2ekpLTmZwSUdSUk9oUVhRNm03V1djb1pxY3p0YnNseVBYZGd3SEo5?=
 =?utf-8?B?dTJ5L0Jqc2tNZ0l5WWNkWGNpL3dQNTZERzJXMEV5S2tBN3ZWS3NXTy82RVBW?=
 =?utf-8?B?Q29NcWZVZ3Noc1l0VXZhQW4yUlV4TFpMRU53Q2ZLL1dMUkNEWFdzRTNUZWZL?=
 =?utf-8?B?ZzBxMk9NMGZESUpHbzZVMmlwMjBCZUdCUVNJSjg1OFpUOGJQUXJqRysvZ1Bj?=
 =?utf-8?B?OHdDbXNlenZ0Vm9UbGt5TTQ5VCthS1ZTbDVnWHpPWkU1Wkt0U2FiYTg1WjJM?=
 =?utf-8?B?YXdxTkt4ZjR1VGdVeGZuMzVvUGl3TWFuSUJqanBhWTgwTFQ1T0dMRU53R01M?=
 =?utf-8?B?eGpOdDQ1OGhFdHdGRktDaFhJeWprU1lsbC9jVmRaeFJhTU5XZHNYWlUwQUJO?=
 =?utf-8?B?SWxzNjNlaUQ5RDNJUzBQbkdSN3p5bE5Dd2hKeUZxNUxrck5aTjZEUU9iOVg5?=
 =?utf-8?B?Y2swSTEwdmkrQzhKQnRiUVF6UENZQ0ZZQXhxT2hGZW9uQU1nV0VQdWJaV1VH?=
 =?utf-8?B?aEpyN2JhMkQ0S3dSeEhEMDMvdElubll5Q2xTdCtQV01UYVp1QldzNUJOTWR4?=
 =?utf-8?B?Z2V1ejRlT2lwa2pMQm53MXhtK0h5L1hiNVkzNFMyTklEOGcrSklCazhPTVZJ?=
 =?utf-8?B?OC91ajlnSHpsZ2c0VEtVSS9SUU5zQldKc1FMRWl0YjNGdHRHL3pWRFNLY3RQ?=
 =?utf-8?B?VmFvcXhOemphQzNFbTRBWXVyMStVeUIySHdNdFlrUWlyalQ2RUp0bnU1N2hF?=
 =?utf-8?B?TlpiQWl1M1czS2N5NEdnVVpNZUZhRlhTbVRDUjUzdXVxRTdXeC83VlRWdnJw?=
 =?utf-8?B?SWlUV2pyTjhEeTZWcXdnNXV5OW13dWJHTnpFOGw0OENIR1JjdUJvcDZ2Rkgz?=
 =?utf-8?B?WmtHaVlna0VScFM2cWJMQk5KNnRVL290M2FRVUVwVmU5TXcrZ1ZTS1VlUm1T?=
 =?utf-8?B?ZjB1b2N2dHVLMEhNR3o2aUNuSW1LNmxtWFFoeHR3a2RRNFRnWlhOOVRPSis2?=
 =?utf-8?B?dHpyQTZuUXFqaElNamg1YlRtaDZkYzVKZnJ3dWMvQnVONmh0eHlidmhva2hY?=
 =?utf-8?Q?NIw6R1+pBl/Y+0pOEpSGU2fYX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C29FE4F8678D34FA5C0205C6B321FBD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0a8b6f-8f2f-4639-a1d7-08dd56f0bc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:36:50.6377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOAQExyRIjJ1CV9TbfwYoG82yJbbScALzeRhf6raOSaJ6IBQcS++onMZs7Qu+fftvyQgyzlD7Z4rcNjXBw1LEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8717

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgYSBiaW5kaW5nIGZvciB0aGUgSERNSSBUWCB2
MiBFbmNvZGVyIGZvdW5kIGluIE1lZGlhVGVrIE1UODE5NQ0KPiBhbmQgTVQ4MTg4IFNvQ3MuDQo+
IA0KPiBUaGlzIGZ1bGx5IHN1cHBvcnRzIHRoZSBIRE1JIFNwZWNpZmljYXRpb24gMi4wYiwgaGVu
Y2UgaXQgcHJvdmlkZXMNCj4gc3VwcG9ydCBmb3IgM0QtSERNSSwgUG9sYXJpdHkgaW52ZXJzaW9u
LCB1cCB0byAxNiBiaXRzIERlZXAgQ29sb3IsDQo+IGNvbG9yIHNwYWNlcyBpbmNsdWRpbmcgUkdC
NDQ0LCBZQ0JDUjQyMC80MjIvNDQ0IChJVFU2MDEvSVRVNzA5KSBhbmQNCj4geHZZQ0MsIHdpdGgg
b3V0cHV0IHJlc29sdXRpb25zIHVwIHRvIDM4NDB4MjE2MHBANjBIei4NCj4gDQo+IE1vcmVvdmVy
LCBpdCBhbHNvIHN1cHBvcnRzIEhEQ1AgMS40IGFuZCAyLjMsIFZhcmlhYmxlIFJlZnJlc2ggUmF0
ZQ0KPiAoVlJSKSBhbmQgQ29uc3VtZXIgRWxlY3Ryb25pY3MgQ29udHJvbCAoQ0VDKS4NCj4gDQo+
IFRoaXMgSVAgYWxzbyBpbmNsdWRlcyBzdXBwb3J0IGZvciBIRE1JIEF1ZGlvLCBpbmNsdWRpbmcg
SUVDNjA5NTgNCj4gYW5kIElFQzYxOTM3IFNQRElGLCA4LWNoYW5uZWwgUENNLCBEU0QsIGFuZCBv
dGhlciBsb3NzbGVzcyBhdWRpbw0KPiBhY2NvcmRpbmcgdG8gSERNSSAyLjAuDQo+IA0KPiBSZXZp
ZXdlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICAuLi4vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk1
LWhkbWkueWFtbCAgICAgICAgfCAxNTEgKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTUxIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUt
aGRtaS55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk1LWhkbWkueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG10
ODE5NS1oZG1pLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAw
MDAwLi4xYjM4MmY5OWQzY2UNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRt
aS55YW1sDQo+IEBAIC0wLDAgKzEsMTUxIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+
ICskaWQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwqX187SXch
IUNUUk5LQTl3TWcwQVJidyFoamF3NnJXMGZHY05hZVlXR2JDSGlseWQ2ajZWMWJ5UmgxWkdpcFpm
WWhYT3dQYzBZMlJDSTl5WUxGTnBxTkZHaVNhZ0EwVldzM1FxSnVFQkwtYlNRVkNpVVlneiQNCj4g
KyRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWhqYXc2clcw
ZkdjTmFlWVdHYkNIaWx5ZDZqNlYxYnlSaDFaR2lwWmZZaFhPd1BjMFkyUkNJOXlZTEZOcHFORkdp
U2FnQTBWV3MzUXFKdUVCTC1iU1FYN0VTWmtTJA0KPiArDQo+ICt0aXRsZTogTWVkaWFUZWsgTVQ4
MTk1IHNlcmllcyBIRE1JLVRYIEVuY29kZXINCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0g
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29s
bGFib3JhLmNvbT4NCj4gKyAgLSBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiArDQo+ICtk
ZXNjcmlwdGlvbjoNCj4gKyAgVGhlIE1lZGlhVGVrIEhETUktVFggdjIgZW5jb2RlciBjYW4gZ2Vu
ZXJhdGUgSERNSSBmb3JtYXQgZGF0YSBiYXNlZCBvbg0KDQpNZWRpYVRlayBNVDgxOTUgc2VyaWVz
IEhETUktVFggRW5jb2Rlcg0KDQpBZnRlciB0aGlzIG1vZGlmaWNhdGlvbiwNCg0KUmV2aWV3ZWQt
Ynk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gKyAgdGhlIEhETUkgU3BlY2lmaWNh
dGlvbiAyLjBiLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAg
IGVudW06DQo+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1oZG1pLXR4DQo+ICsgICAgICAtIG1l
ZGlhdGVrLG10ODE5NS1oZG1pLXR4DQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAx
DQo+ICsNCj4gKyAgaW50ZXJydXB0czoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGNs
b2NrczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEhETUkgUGVyaXBo
ZXJhbCBCdXMgKEFQQikgY2xvY2sNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEhEQ1AgYW5kIEhE
TUlfVE9QIGNsb2NrDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBIRENQLCBIRE1JX1RPUCBhbmQg
SERNSSBBdWRpbyByZWZlcmVuY2UgY2xvY2sNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFZQUCBI
RE1JIFNwbGl0IGNsb2NrDQo+ICsNCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+
ICsgICAgICAtIGNvbnN0OiBidXMNCj4gKyAgICAgIC0gY29uc3Q6IGhkY3ANCj4gKyAgICAgIC0g
Y29uc3Q6IGhkY3AyNG0NCj4gKyAgICAgIC0gY29uc3Q6IGhkbWktc3BsaXQNCj4gKw0KPiArICBp
MmM6DQo+ICsgICAgdHlwZTogb2JqZWN0DQo+ICsgICAgJHJlZjogL3NjaGVtYXMvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRtaS1kZGMueWFtbA0KPiArICAgIHVuZXZhbHVhdGVk
UHJvcGVydGllczogZmFsc2UNCj4gKyAgICBkZXNjcmlwdGlvbjogSERNSSBEREMgSTJDIGNvbnRy
b2xsZXINCj4gKw0KPiArICBwaHlzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsgICAgZGVzY3Jp
cHRpb246IFBIWSBwcm92aWRpbmcgY2xvY2tpbmcgVE1EUyBhbmQgcGl4ZWwgdG8gY29udHJvbGxl
cg0KPiArDQo+ICsgIHBoeS1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6
IGhkbWkNCj4gKw0KPiArICBwb3dlci1kb21haW5zOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsN
Cj4gKyAgJyNzb3VuZC1kYWktY2VsbHMnOg0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4gKyAgcG9y
dHM6DQo+ICsgICAgJHJlZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0cw0K
PiArDQo+ICsgICAgcHJvcGVydGllczoNCj4gKyAgICAgIHBvcnRAMDoNCj4gKyAgICAgICAgJHJl
ZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0DQo+ICsgICAgICAgIGRlc2Ny
aXB0aW9uOg0KPiArICAgICAgICAgIElucHV0IHBvcnQsIHVzdWFsbHkgY29ubmVjdGVkIHRvIHRo
ZSBvdXRwdXQgcG9ydCBvZiBhIERQSQ0KPiArDQo+ICsgICAgICBwb3J0QDE6DQo+ICsgICAgICAg
ICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydA0KPiArICAgICAgICBk
ZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICBPdXRwdXQgcG9ydCB0aGF0IG11c3QgYmUgY29ubmVj
dGVkIGVpdGhlciB0byB0aGUgaW5wdXQgcG9ydCBvZg0KPiArICAgICAgICAgIGEgSERNSSBjb25u
ZWN0b3Igbm9kZSBjb250YWluaW5nIGEgZGRjLWkyYy1idXMsIG9yIHRvIHRoZSBpbnB1dA0KPiAr
ICAgICAgICAgIHBvcnQgb2YgYW4gYXR0YWNoZWQgYnJpZGdlIGNoaXAsIHN1Y2ggYXMgYSBTbGlt
UG9ydCB0cmFuc21pdHRlci4NCj4gKw0KPiArICAgIHJlcXVpcmVkOg0KPiArICAgICAgLSBwb3J0
QDANCj4gKyAgICAgIC0gcG9ydEAxDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGli
bGUNCj4gKyAgLSByZWcNCj4gKyAgLSBpbnRlcnJ1cHRzDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0g
Y2xvY2stbmFtZXMNCj4gKyAgLSBwb3dlci1kb21haW5zDQo+ICsgIC0gcGh5cw0KPiArICAtIHBo
eS1uYW1lcw0KPiArICAtIHBvcnRzDQo+ICsNCj4gK2FsbE9mOg0KPiArICAtICRyZWY6IC9zY2hl
bWFzL3NvdW5kL2RhaS1jb21tb24ueWFtbCMNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svbXQ4MTk1LWNsay5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Bvd2VyL210ODE5NS1wb3dlci5oPg0KPiArDQo+ICsgICAgc29jIHsNCj4gKyAgICAg
ICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0K
PiArDQo+ICsgICAgICAgIGhkbWlAMWMzMDAwMDAgew0KPiArICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTUtaGRtaS10eCI7DQo+ICsgICAgICAgICAgICByZWcgPSA8MCAw
eDFjMzAwMDAwIDAgMHgxMDAwPjsNCj4gKyAgICAgICAgICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4g
Q0xLX1RPUF9IRE1JX0FQQj4sDQo+ICsgICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENM
S19UT1BfSERDUD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1Bf
SERDUF8yNE0+LA0KPiArICAgICAgICAgICAgICAgICAgICAgPCZ2cHBzeXMxIENMS19WUFAxX1ZQ
UF9TUExJVF9IRE1JPjsNCj4gKyAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImJ1cyIsICJoZGNw
IiwgImhkY3AyNG0iLCAiaGRtaS1zcGxpdCI7DQo+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgNjc3IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ICsgICAgICAgICAgICBwaHlz
ID0gPCZoZG1pX3BoeT47DQo+ICsgICAgICAgICAgICBwaHktbmFtZXMgPSAiaGRtaSI7DQo+ICsg
ICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTk1X1BPV0VSX0RPTUFJTl9IRE1J
X1RYPjsNCj4gKyAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAg
ICAgICAgICBwaW5jdHJsLTAgPSA8JmhkbWlfcGlucz47DQo+ICsgICAgICAgICAgICAjc291bmQt
ZGFpLWNlbGxzID0gPDE+Ow0KPiArDQo+ICsgICAgICAgICAgICBoZG1pdHhfZGRjOiBpMmMgew0K
PiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWhkbWktZGRj
IjsNCj4gKyAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsazI2bT47DQo+ICsgICAgICAgICAg
ICB9Ow0KPiArDQo+ICsgICAgICAgICAgICBwb3J0cyB7DQo+ICsgICAgICAgICAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47
DQo+ICsNCj4gKyAgICAgICAgICAgICAgICBwb3J0QDAgew0KPiArICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MD47DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgaGRtaV9pbjogZW5kcG9p
bnQgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkcGkx
X291dD47DQo+ICsgICAgICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAgICAgICAgfTsN
Cj4gKw0KPiArICAgICAgICAgICAgICAgIHBvcnRAMSB7DQo+ICsgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwxPjsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICBoZG1pX291dDogZW5kcG9p
bnQgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZoZG1p
X2Nvbm5lY3Rvcl9pbj47DQo+ICsgICAgICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAg
ICAgICAgfTsNCj4gKyAgICAgICAgICAgIH07DQo+ICsgICAgICAgIH07DQo+ICsgICAgfTsNCj4g
LS0NCj4gMi40OC4xDQo+IA0KDQo=

