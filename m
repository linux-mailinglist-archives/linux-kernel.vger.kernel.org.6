Return-Path: <linux-kernel+bounces-446929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8C9F2B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF88E18842C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31AF1F7099;
	Mon, 16 Dec 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s30uDHqD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mXgS/lqC"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC21F708D;
	Mon, 16 Dec 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334754; cv=fail; b=sdEYwnBOgDApF4FF25gqS8u83FL5bhuegiIZ+Q4j7aKNRxznhbIXOr+tt0jZlJ9BKdjEj9ABmKwgtyhA/WSmogG9pLY6Z+6rs8ThWwPv/yzWPnY9ZY2O3c/ROI6Va4pBtZzs68QInT03ar3WevPCvLwa8ngBz904ZiucCn+RqwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334754; c=relaxed/simple;
	bh=pD6Tu55J4I7athSPRKqUxYOM42X3tfiU0fQEcGfsW2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyWR+xaQfdsFrfq+w2H1HproopLKKWZNR8h1TmNM0hmdGIDkSi4mKsL60vKuzUdLorlLEL9ePfk68sboHS/KbHXwg+M/lISd/z2Hdw9zUy0BIgoRzowO9kxcLzyF2azsPsJxHKcmNVLgtKBPrl8uERQJWmHEcLNWXCXNWirYxFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s30uDHqD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mXgS/lqC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2b63f6ebb8011efbd192953cf12861f-20241216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pD6Tu55J4I7athSPRKqUxYOM42X3tfiU0fQEcGfsW2k=;
	b=s30uDHqDyrPFca3DCzY+Y5kncAPEOXmYhHKQFsJdbWhp/dzalskEBM3eMhhYPeX9B3FqOqWofdFQd9cgosWb76Zqw4oBCFNQxdalrjXiJzQd6jZQflv0wo4QriRRKoallYXRMhzoHMjLiWZLvJGiMkJ+N7mItd81Vbyy6L1aXYU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:94950970-a364-4b6f-bd94-412a95b0c390,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:36b43213-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d2b63f6ebb8011efbd192953cf12861f-20241216
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2010646375; Mon, 16 Dec 2024 15:39:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Dec 2024 15:39:02 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Dec 2024 15:39:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGmM+d9j21RpX3vV2JMWJMdloCLxNSInEKW27Mee+HFbIVy1VZXpajPtUJBkEXrrJsKUS03R+YfNj82jKYENZ7+Tq7KdvainHvoSdFPICWR/xG8KK78xggDXKbcyJsLNbJ0d1CvQTXwjb+iJLKhodcHmRzjQuk6fhOXLlxvRbkN4EnRKqId622QCL/5dEx+TjLHjMZcz8CPnVzj84R/LEmViFdC9GdlfmJAK9FR6fDk2tceJs9lK0dNh/0qDjR2N79h5vbVAsIzDuib4We3ejxNX+pCiBg6I79gxBuLOw+c1vZZp2BxfFUO2cUlUsOfqzCcSACKzrYQIBKBYFrw0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD6Tu55J4I7athSPRKqUxYOM42X3tfiU0fQEcGfsW2k=;
 b=SdJeD9+K+fj+6axfEx9kingNNh9Sr3413bKk/6uJOD7m66DsKx5IiqPJ2eACb3Uaq0Wu1+cHSJKzsbUwUq3obO2dSckFI8lJe8uKu+6lHkff8TfMQz1ThrUhJiuNzIEzeHmQeoDHSRBJp8ah8Xpk5FHewtimS0w0uMhYZcCQhE39SXK3lS/zgPB88gR9U8ykSJc+GPRkfe60aYAcFqIcNGm/n+oXIQs0x79hQKoCjreQeWfP2I1jQ5ie5gbuIgsut75ulvdd56v0NK4PhrknMDFBzlnHBYyfB4+K2Blg6is48H4iIGjXYZYW039UYB5I09j3o7bYV05IGA14ZVneSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD6Tu55J4I7athSPRKqUxYOM42X3tfiU0fQEcGfsW2k=;
 b=mXgS/lqCvRrw/rRGNHlUei3s6PwUCvQ9bvgN3BsZUJBFMGYBql5Id/qD17uc7q8YB5NtDYiqP+v2u9Q3/HVs0JOXw7L0Pa0BCbaWP7zJ98Nf5ICnEpxpO1Yn71hrx37A1RgjjLfB3vW+CAXNwl4One9GvMf8F5vWnAz2Drmqmsc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8806.apcprd03.prod.outlook.com (2603:1096:405:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 07:38:59 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:38:59 +0000
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
Subject: Re: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbRwuDKzLMLP8gmEqSnf1CFqiN77LojQsA
Date: Mon, 16 Dec 2024 07:38:59 +0000
Message-ID: <ef02d09ce33ab249e877e779f75c3980f5a5939a.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8806:EE_
x-ms-office365-filtering-correlation-id: cf31f0a8-0d7b-4ca0-de75-08dd1da4b446
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3A4bys2NnQ2TDMyd3JIalBYVFA2dHQxWlA2NFlITEFXUllpTVpOaEF5VDlt?=
 =?utf-8?B?dzNJcElVMERHQVZFRFR0aTlSZWpKSFdINnJ5OTdiSUthYXIzYTRMNlBUa3J2?=
 =?utf-8?B?dzRydmlBekQrd3BqSFBTNFN0VDZwT0svYnBFWEVuRWhsQ0I5Sm9Oc21LK2Nq?=
 =?utf-8?B?ZFFGYjE4TWo5MnVCUExtakhYcjdkK1BqYWZKOGN2TFJEZE1FRWhXSkhUV0lI?=
 =?utf-8?B?amRSL3Bpb0d1MWFvK0tUdFNHY0RXdDVlT3MwWlJZNFR3SVhzQlBOZFZZcVl4?=
 =?utf-8?B?WjdNRGJ1bHdDQTFBM0FIOGhYSmQvN1pJdzdxbzBqcVMzRXV5OW5lbVN5TXZw?=
 =?utf-8?B?UzV4a29GTzdKa0RyUVZYcXhTd0dyeXlkdjhTektNeHRjTEFwNDNPejI1RTNy?=
 =?utf-8?B?WUdub0ZPRGdzWnVzYmhRQVZrd0lJTEhvQlhmQ1djMGM4OGZLYzE5YW9jNHZh?=
 =?utf-8?B?dHp2bkh1OW1TR1FqY3RuNTdvWVBGUjlzQWZWcnpCSXRGRDZQTVZhdE1JWlg5?=
 =?utf-8?B?aTk4aFRQZ202SDVReFZrdHZpT3ZDMmFmV0JHaWxzNFA5T1B2bHF2WXYxUjln?=
 =?utf-8?B?Y1JZN0tIcFVmZFBsd1dkT3ZoNHduMVpUNGVWcEY3eEhIQjUzTWtLRVJKaXI5?=
 =?utf-8?B?aFk0QzZNV0NHVVY2bTdZWTd3dUg5bjhVL2ZWcEpHUGdSdlNnOGpMLytBZnR2?=
 =?utf-8?B?cVJHazhPMGhIcWpwZ1czVkhuNkYvU1BDVk9BZG9DR3FIcVlzYkxFaVA4MTNu?=
 =?utf-8?B?Z1FST1o0QmIxMXZUdmRLWFhPMklaL0cwM2lPeFlRYUN1RHE4aXk1NU9XSEph?=
 =?utf-8?B?SCsvbEQ1ZDBkb0M4SlV5d1Y2OXNGQWtGcGs0cEMzbzVxT2xCWEFieUdRUkhJ?=
 =?utf-8?B?amE4TEJWWW5TdXkxbEp4cjg1b21CNis1cFVYQjErTEsyaFliZDlxeXZmY0Jh?=
 =?utf-8?B?YzdXQTB2RmF5MjZ3NUwwNEY1WEI0Y09vYkNLdUVBTDRpSFVxcFRDZ1ZrbWIw?=
 =?utf-8?B?eDRlRGFveXpBV2k3TkNEa0kwSnB1dTRtL3BwcTdrOG9ObTc0QjVIZ0lIOTIy?=
 =?utf-8?B?V2ZDRVQ5WTlYYzl4OU1iVW5sbi9QclJQTFZvVlBZUjI2TlhrVDV0TG85QWd5?=
 =?utf-8?B?bWdSVllUdGNKTm1zTy91T083MXZRbk8rOUVIU1pTLzJsTzBlKzhZTHljVEpE?=
 =?utf-8?B?NUFWaHdheGM2UjUydlFQZUlrUUNLbmV3U1VsMHhkb2NEUmxIUGpNYVNRWDRO?=
 =?utf-8?B?QXZ3elAzZU9jVXpYbnlkR0FYbWtJY0NPSUxSTUg3RHd1SlhHMi9QR3M0MEov?=
 =?utf-8?B?c0lOTjk0ZjgweHBuSUQ5ZmpFcG5LUGxVMXhzKzY2S2NKT1pwbk4zbTVxbENH?=
 =?utf-8?B?QXN3MnhsaTFhTmkwNWZjbjN5UVRWaml1WUc3cHJna3EreW02WmdYT05XdmR4?=
 =?utf-8?B?aGF1NGgwUWlFV3JERWhPN0M3RUdqb2IvbWlyUUFvcTJqdFhVUXhYUk1ISnQv?=
 =?utf-8?B?Z09VN0JIRmlNcEN2U2tObm9wQnAzVDJBSzkwdERrUXNMRFM2Z3lLVHJqTVJh?=
 =?utf-8?B?SUxuSytyNVJEUDJYL0pqZjd1TEJ0ckJjcDFiaUlyTTR5L3RTVE1zRStzUmwv?=
 =?utf-8?B?R0oyVmRTcUtMNDJycDEwdkdkYVc2a1Y3eXA1NnJWV0RkR05ZakZGS3o3bWhZ?=
 =?utf-8?B?UkNXZW04eDE3NDBlRlFMdnVGbVRWVjFuajhRd1BtazBHcmhaQVNJQ2oxanQ5?=
 =?utf-8?B?RTZzeklnYk02ZlhZa2c3QitvU01QSm45amMrMTR3dzVYbUhIQWN2VDVRc3Zz?=
 =?utf-8?B?MUlnMS9oc0hMQlQrNk5Kbnd3Rk5IMUM5a1NzcGl6UkRrbUdLZmZRbUJhSjhi?=
 =?utf-8?B?Z1NVWEVHQU9TQzNVeHYvTGY2OEw1U1RJdXA1TlZMMDZqT1hxVzVLdHkxLzJR?=
 =?utf-8?Q?thXqGAAOHqP4NocThJnG95DXTGas1oRl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmxYVmRIQUhVL0JObUZ2eWhhbm1zcnpLME5YcVFrS0Z0em5PNk9nWjZiTTlo?=
 =?utf-8?B?c2VrSDhIeWdDN2tqSFRxKzlHTWlBb3V2RWZtcXhTMzF5YXNHZDRqLzVkV24z?=
 =?utf-8?B?QlhmbEw1UzhoR0N2RFl4a2MwSm8xNmRJblhjakV5RWFlbC9TYXNTOWFVcWJT?=
 =?utf-8?B?TVUvTk9HTk40NmxWcjh5VUt0TEJmSEo0dFhXcU9yWGFja0hnV3JrKzlhQjk2?=
 =?utf-8?B?Ly9RbFNXKzVVUEo2bG1VcitxYU5JZFk5SWNDK0dQeXdkbGxtTjB3ZVg5RHNY?=
 =?utf-8?B?N21GbElYZk1venNmd3JzbEJXM091WkdWUWppOEFZUVdpRGpkT0hKZXNvTGNr?=
 =?utf-8?B?TWRHazRFMlJjWTNqdzQycGJyakt0NFZBS3VBWTYvbEl3c1E1Tmk0UGQrR0FI?=
 =?utf-8?B?TWZML0tzenE0QkVuKzFxVmVVYnA1SFhaczRaajZnNTNsTG9TYmVjR1A4ZDhW?=
 =?utf-8?B?b2ppa2xUclc0QU9LeEF4NlVkTHh4NWY2WGlpTExWdGMxc254azM1QWJrVkhU?=
 =?utf-8?B?M0ZPb09IWVhzUWtGQnNpR1k1ZjcyYXZJVzdXaHN4VzVnNGhVdnZHU2Q2eDR2?=
 =?utf-8?B?VnFkUWQwUzArV1lPMnA0U0JDdXpubzgyWUNTNHpGSWFxM1p0S3g2ZkFHZE5O?=
 =?utf-8?B?WHNrbkNFUEpwTWE3VEFaUzI0ZUVLTEc4UkRiQkdaRGc2dzdsMThzZ3BPaitG?=
 =?utf-8?B?blZidUlOaTRqVTlSVUpQZFFNMVNOWVJtOVU4Tng1V25pRm5ETkZZYkxPZjhk?=
 =?utf-8?B?QjBmRzhHQUt1czE2dkFoZEdvb3hlU3FUNm50Y2daYlJJZ0Z5SDhETndadDBR?=
 =?utf-8?B?dUE3bTRmRDBabzFwekNsaFZCSGdlWkZ1aGpSMmViQjZjcGVtZnNvcUpXWHh5?=
 =?utf-8?B?V2xnTDd5MlNMS2I4d2QvVkpsRkF4eUo5SmxHWXdEYTh3K294aXQyOHJMeFZR?=
 =?utf-8?B?TjEwNUFCMTI3SnV2N0pobjJnZlZhZGVxVlhzV0Q3QTdhME5hSGVHSW9RUkFs?=
 =?utf-8?B?TS9ISkROeEhOc3N4TmQ5RU9oMUFpWVZzWkVCRWZkbEYvc244cFdrbFI0S3B3?=
 =?utf-8?B?VHc1U3k0eTFIcDZyTjhnanhRcHNjczBtbEgwaEk5VHJXSGFSUExIVkpqNkZn?=
 =?utf-8?B?eGV4NndFcDJvazNlMnF0TnZlbHc2cXpZWmRtRTdZcTR0RGUvdWY4T29ZRWNq?=
 =?utf-8?B?QVpXZVZyMUxGbzZ3MFdMMWNzQjdoK2FmMm4xd2Z3Z1JYWmhOdURKVEdNUzM3?=
 =?utf-8?B?YmlUR1A1ZTl3Y3dQcDh4L0ZucmtuUEZVb0N0N3BselRyOGhyaUJoRVFkMmpF?=
 =?utf-8?B?eGp1MmJwQnIrTnNCTlp0STZCcUw1cDNYM1hxQk01QWlqKzQvWjV6cXFFelBK?=
 =?utf-8?B?VURqbHNMUTBrNkZaSUZEa2VEdzkxZXg2ajd0S3BLRU04QXhYckFCUGlZS21C?=
 =?utf-8?B?aDBGcnA3dXBPREFxU1ZQVkI4b3NFckdwT0NITlBZQTNDcmt0ZndWZGhXQVZ2?=
 =?utf-8?B?NVc4M1Z4cWxHT0dON3ByaHh6Z3ZUYnV0YlpZRTZKZHNmM1pLVzI0K0pzZC92?=
 =?utf-8?B?ZVI5b1c3eGdCc2tyMk9LMlUxRVJCYVUrUzJJRXJPeG8zNmhCYzFMT0tKd0FQ?=
 =?utf-8?B?UUZpd1hTMmdCM0ZKRkhnbUhjUDRyTlgxVlJWamM4eFljYWpLT1B6NHhkcWFS?=
 =?utf-8?B?RVdCM0ZZZ1NHam9Sd21BK254VmViYVhuK3hJTjVKbmR2MURoK0RKV0hGMU9N?=
 =?utf-8?B?LzBBOSswL1dwK01ma2V3aHZWeDEvaDhZNEVyTWt6ZjhaQTEwWEw2bXFhVjBE?=
 =?utf-8?B?Ry93TDhleXdrU2lMSkdRTEdsZzg0ZzRrK2tvR01ZbnJZOUtVdHgyWE9zWGtQ?=
 =?utf-8?B?SzQ0c29pcGRxRDYrOHdxMnI1THVwY1R5akdtalA2eitmRVJsaWZ6Vklad2Rw?=
 =?utf-8?B?a0V2Z0JFNVc2QzRQL0V6Qmo3dStmcUNrcnIxSnRpckxEdktGYVVWSjk3aWpT?=
 =?utf-8?B?a2QrM2laUWJFdU5tY2w5TkwwelFBbTJnVzBEOGh2dUgvdFpBL0cwN0FydTRB?=
 =?utf-8?B?M25vMjFHUjdMOTF1VWVyNWpZaUpKTExOOEdzdTA4OGRGYlNMSGM1cWcyZEcr?=
 =?utf-8?B?azdlRndJcndMUjhVaGtvTTJ4cUdncEl5a3NraWJrRTM4czZTVWZmdWFNbmI3?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53AA29DFACEF6E4EB55E5075930A12EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf31f0a8-0d7b-4ca0-de75-08dd1da4b446
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 07:38:59.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13vXFiJR0ekzJ4E6oUXL3whug3a0OPQeZMBm5/oRNykcxY7lVvoedu8B1Cgt++mxlE/uB15C4XAsWQosY0odjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8806

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIGEgbmV3IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91
dCB0aGUgZnVuY3Rpb25zIHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0K
PiBwcmVzZW50IG10a19oZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNp
bmNlIHRoZSBwcm9iZSBmbG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBh
IGNvbW1vbg0KPiBwcm9iZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBk
cml2ZXIncyAucHJvYmUoKQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxp
Y2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlw
XQ0KDQo+IC1zdHJ1Y3QgbXRrX2hkbWkgew0KPiAtICAgICAgIHN0cnVjdCBkcm1fYnJpZGdlIGJy
aWRnZTsNCj4gLSAgICAgICBzdHJ1Y3QgZHJtX2JyaWRnZSAqbmV4dF9icmlkZ2U7DQo+IC0gICAg
ICAgc3RydWN0IGRybV9jb25uZWN0b3IgKmN1cnJfY29ubjsvKiBjdXJyZW50IGNvbm5lY3RvciAo
b25seSB2YWxpZCB3aGVuICdlbmFibGVkJykgKi8NCj4gLSAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXY7DQo+IC0gICAgICAgY29uc3Qgc3RydWN0IG10a19oZG1pX2NvbmYgKmNvbmY7DQo+IC0gICAg
ICAgc3RydWN0IHBoeSAqcGh5Ow0KPiAtICAgICAgIHN0cnVjdCBkZXZpY2UgKmNlY19kZXY7DQo+
IC0gICAgICAgc3RydWN0IGkyY19hZGFwdGVyICpkZGNfYWRwdDsNCj4gLSAgICAgICBzdHJ1Y3Qg
Y2xrICpjbGtbTVRLX0hETUlfQ0xLX0NPVU5UXTsNCj4gLSAgICAgICBzdHJ1Y3QgZHJtX2Rpc3Bs
YXlfbW9kZSBtb2RlOw0KPiAtICAgICAgIGJvb2wgZHZpX21vZGU7DQo+IC0gICAgICAgdTMyIG1p
bl9jbG9jazsNCj4gLSAgICAgICB1MzIgbWF4X2Nsb2NrOw0KPiAtICAgICAgIHUzMiBtYXhfaGRp
c3BsYXk7DQo+IC0gICAgICAgdTMyIG1heF92ZGlzcGxheTsNCj4gLSAgICAgICB1MzIgaWJpYXM7
DQo+IC0gICAgICAgdTMyIGliaWFzX3VwOw0KPiAtICAgICAgIHN0cnVjdCByZWdtYXAgKnN5c19y
ZWdtYXA7DQo+IC0gICAgICAgdW5zaWduZWQgaW50IHN5c19vZmZzZXQ7DQo+IC0gICAgICAgc3Ry
dWN0IHJlZ21hcCAqcmVnczsNCj4gLSAgICAgICBlbnVtIGhkbWlfY29sb3JzcGFjZSBjc3A7DQo+
IC0gICAgICAgc3RydWN0IGhkbWlfYXVkaW9fcGFyYW0gYXVkX3BhcmFtOw0KPiAtICAgICAgIGJv
b2wgYXVkaW9fZW5hYmxlOw0KPiAtICAgICAgIGJvb2wgcG93ZXJlZDsNCj4gLSAgICAgICBib29s
IGVuYWJsZWQ7DQo+IC0gICAgICAgaGRtaV9jb2RlY19wbHVnZ2VkX2NiIHBsdWdnZWRfY2I7DQo+
IC0gICAgICAgc3RydWN0IGRldmljZSAqY29kZWNfZGV2Ow0KPiAtICAgICAgIHN0cnVjdCBtdXRl
eCB1cGRhdGVfcGx1Z2dlZF9zdGF0dXNfbG9jazsNCj4gfTsNCj4gDQo+ICtzdHJ1Y3QgbXRrX2hk
bWkgew0KPiArICAgICAgIHN0cnVjdCBkcm1fYnJpZGdlIGJyaWRnZTsNCj4gKyAgICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXY7DQo+ICsgICAgICAgY29uc3Qgc3RydWN0IG10a19oZG1pX2NvbmYgKmNv
bmY7DQo+ICsgICAgICAgc3RydWN0IHBoeSAqcGh5Ow0KPiArICAgICAgIHN0cnVjdCBpMmNfYWRh
cHRlciAqZGRjX2FkcHQ7DQo+ICsgICAgICAgc3RydWN0IGNsayAqKmNsazsNCj4gKyAgICAgICBz
dHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSBtb2RlOw0KPiArICAgICAgIGJvb2wgZHZpX21vZGU7DQo+
ICsgICAgICAgc3RydWN0IHJlZ21hcCAqc3lzX3JlZ21hcDsNCj4gKyAgICAgICB1bnNpZ25lZCBp
bnQgc3lzX29mZnNldDsNCj4gKyAgICAgICBzdHJ1Y3QgcmVnbWFwICpyZWdzOw0KPiArDQo+ICsg
ICAgICAgYm9vbCBwb3dlcmVkOw0KPiArICAgICAgIGJvb2wgZW5hYmxlZDsNCj4gKyAgICAgICB1
bnNpZ25lZCBpbnQgaXJxOw0KDQpZb3UgYWRkIHNvbWV0aGluZyB3aGljaCBpcyB1c2VkIGluIHYy
IGJ1dCBub3QgaW4gdjEuDQpNb3ZlIHRoZXNlIHRvIHRoZSB2MiBwYXRjaCwgb3Igc2VwYXJhdGUg
dGhlbSB0byBhIHByZWNvbmRpdGlvbiBwYXRjaCBvZiB2Mi4NCg0KPiArICAgICAgIGVudW0gaGRt
aV9ocGRfc3RhdGUgaHBkOw0KPiArDQo+ICsgICAgICAgLyogQXVkaW8gKi8NCj4gKyAgICAgICBz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICphdWRpb19wZGV2Ow0KPiArICAgICAgIHN0cnVjdCBoZG1p
X2F1ZGlvX3BhcmFtIGF1ZF9wYXJhbTsNCj4gKyAgICAgICBib29sIGF1ZGlvX2VuYWJsZTsNCj4g
Kw0KPiArICAgICAgIHN0cnVjdCBkcm1fY29ubmVjdG9yICpjdXJyX2Nvbm47LyogY3VycmVudCBj
b25uZWN0b3IgKG9ubHkgdmFsaWQgd2hlbiAnZW5hYmxlZCcpICovDQo+ICsgICAgICAgc3RydWN0
IG11dGV4IHVwZGF0ZV9wbHVnZ2VkX3N0YXR1c19sb2NrOw0KPiArICAgICAgIHN0cnVjdCBkZXZp
Y2UgKmNlY19kZXY7DQo+ICsgICAgICAgc3RydWN0IGRldmljZSAqY29kZWNfZGV2Ow0KPiArICAg
ICAgIGhkbWlfY29kZWNfcGx1Z2dlZF9jYiBwbHVnZ2VkX2NiOw0KPiArICAgICAgIHN0cnVjdCBk
cm1fYnJpZGdlICpuZXh0X2JyaWRnZTsNCg0KSSBkb24ndCBrbm93IHdoeSB5b3UgcmVvcmRlciB0
aGVzZS4NCklmIGl0J3MgbmVjZXNzYXJ5LCBzZXBhcmF0ZSB0aGVzZSByZW9yZGVyIHRvIGEgcmVm
aW5lbWVudCBwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gK307DQo+ICsNCg0K

