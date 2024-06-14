Return-Path: <linux-kernel+bounces-214354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91228908336
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23371283D01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097F146D76;
	Fri, 14 Jun 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U18MVXHn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="l9PoUgXn"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85B2F43
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342047; cv=fail; b=Zz235Jt0zsM43//4yewYYjey0p2+q2phsLviyy/ITVq5GqzXbXo1Q8j7n3dvFU+VuwgIAvnibwfweN9bE6zMCz4ZcUruOZUy0e41ZtdGdnQaxskXp9d0pTjF9YrvGej60T6qFf+ol2NgFkTMZBTQ+KRDzosNAQ27eAvOlOrXKj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342047; c=relaxed/simple;
	bh=hM1Oj3VZoBC2yoZg+7uXguf25hikdky+VFDFJBS959g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fq9TpjIu1cTyYLPhF1USSk78OP7BZ/SEHmiNnVMKl/YkdsR8nniljcuK3Aj4wqTy6oQMVyjUqnrsRZp7ESG9pI06QMufFhF8+WM2ybNB0JK66p1U0DJDWe7TRPWCqZFMBoqMdgWoNiEiKQ/S2NbuCMwqOi0Ig/ZS4m/lddcyh9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U18MVXHn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=l9PoUgXn; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e7579c842a0c11efa22eafcdcd04c131-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hM1Oj3VZoBC2yoZg+7uXguf25hikdky+VFDFJBS959g=;
	b=U18MVXHn2DCCGvzb8t1CBgl0DfG39BoWFKjC6cDcO9MZaUjRcxZblr7N8leRM3kfpqxiTznO3I/QiiNFM1vSEDq/9ege+4ju4dbo/+4MXVzuDB4h4VgPJvPk211yePEtgKL6Nx6LLpI+RBjf8WArjxHwul35j/y+P0kzI0YRwWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:7c693f60-d355-476d-b875-9c1847170777,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:393d96e,CLOUDID:29789388-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e7579c842a0c11efa22eafcdcd04c131-20240614
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 745842290; Fri, 14 Jun 2024 13:13:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 13:13:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 13:13:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfxkIXCkT6T7ciuVaYBb5kg22OGUSmW5djx/hMJ6SigPY9QmWTQ5Le1hmiQpbj9n9xT3CrMhIggpC1HwN2Tdknlx8iZ4S+IOvDaaRrDEWbZlCjcusvRE/sNkt31FmwHPb14uEhzTuxkTWF0a8FmqWV20gF4/e/DhBR6H13wawRHOtreP+Dj8Qj5xOlBaX+DP96GCkBj3i6JqvQ7RaRFJDnu66R+LLAmVt6Py4CxZXXGyOV54tsRObaaCyNS15ag0F//VH0SHdS05RvIetjSPkXeSb/t89+vV6JOch3PwgbZAOK4CZPUWmW7yYnv/3QSv2rXeQZwvPmX+K+0Ap3fpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM1Oj3VZoBC2yoZg+7uXguf25hikdky+VFDFJBS959g=;
 b=fdqf0NrciObfbUoayKWs2MBxaZGbQCrM6LAPLqUwdAb5hq/EVpv3vUm76ttSY7ZW+uL+ePE7Id5mSPIi+56hmIhkKUqbRutTR+iJx/e9oARw7xutZyZ1EaOosTlryJ9blLa32cLDAGuzPzf7BNigZKXwdiCd+8N0cC3p/lZH+f8GFBz9r3x8GCaMtwNmo/uNVY59pcodAvYQu9kk+uJjB1cKkNQmwvTNCH0jFvB+B+OMGJcXBGC9ryX+IiELRX+oalMbc9LxvMTzXZtumBkLMEPergl04lU9lpx+yCc14l519EL+5f43JyIXhp4VZZ8ZlQvQtecJNHe7iEeusHnU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM1Oj3VZoBC2yoZg+7uXguf25hikdky+VFDFJBS959g=;
 b=l9PoUgXnr07JUQwotsAQAvwrXt8THzs91UfL2Gf8avD7ao6+C91FCdWqkifpPAnxHfmJAlbRvv2kO4sb/+kysJROFlWfXAdTXgHHxpnrY010f2TjDJkLNrmrqr4znhLRolBVlM1nsEiOnFlNFq2wUpCpHvBTha65oP+sqrhTH78=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8324.apcprd03.prod.outlook.com (2603:1096:101:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:13:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:13:55 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 15/21] drm/mediatek: Support "None" blending in Mixer
Thread-Topic: [PATCH v9 15/21] drm/mediatek: Support "None" blending in Mixer
Thread-Index: AQHavgU13CywtfrIeEuF+lAWzMf8XrHGt0IA
Date: Fri, 14 Jun 2024 05:13:55 +0000
Message-ID: <d9dcb87b431aabe580db54624aa0754a479f7254.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-16-shawn.sung@mediatek.com>
In-Reply-To: <20240614024620.19011-16-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8324:EE_
x-ms-office365-filtering-correlation-id: 1f50c4cb-52cb-4535-df66-08dc8c30c9e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|7416009|366011|1800799019|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?cmJUNlA3Qk1xcWpHK05SVWFFTE1HWVhYSlYvTU80bW85czhYdUhhOEpKSWFP?=
 =?utf-8?B?TE1CY1UvdXdrVkxqdnRBV0QzN2s0bjEzQ3k2bENyRnFXM24yZ0hrZ1B6VEpR?=
 =?utf-8?B?dEE3S2xPRjNudHBnVnVWZU5pYWIrZU9jQVRnWmlaSXR3cEZrZjNaWXpQd0Ns?=
 =?utf-8?B?dERvN05TM0x5ZmpmWitWZEN6Uzduc2U0QnZDaVRrcUNsQks3R0ozRUdvYlB4?=
 =?utf-8?B?ckNlc1dZeEFMNldzUHVhWDRhNEhQeVpPYVh2WVhlYk84UWdnZ2lmZWVyNEls?=
 =?utf-8?B?NDFmMURVZ0ROeVVUS0FTV1hRVWhnNzBiWHMrUmxoNk04YkxSWk9ER2p2aXR2?=
 =?utf-8?B?ZFVEQkUrbVd0LzRuZ3gyWnpkRndOa3pvU2xEVENpYThBWFhjdUhuRTU3Y09N?=
 =?utf-8?B?ZWl6NjRlNUszMmFwOXowMEFicnJ3cEVwTHNYclVrYmNlWEwvNDhycS8vU1dI?=
 =?utf-8?B?K1piR0Z6SEpLdGpoWmthbTBSWmFmbXA1aWpXcXAwV1EveHFhb3RjSzd6ZW1l?=
 =?utf-8?B?Rzh5ZTYzUW9EQk5tQVlocHlBVHlncUVvTFhTanE5L0MwMnhvVTZkZ0JWZHd5?=
 =?utf-8?B?TTNpbTBHT3FjUjI5OVRyOFhYWEdwZFpjYk91S3BSUHVaZkYxV2dBK1kvS3pl?=
 =?utf-8?B?ZkxXRW1GVzk5eU5id21jdXlJbUwzMkwzVGZ0LzdsVFZkZFdKWTNpQm1CWlRQ?=
 =?utf-8?B?VWhVbWRMUEZWMnQxSmFZdi9TYkRnK2t0WFUzTXFhQ3VSdjQwcVFIRm5NN3FX?=
 =?utf-8?B?clNEUzJleVM0Uk82RXRTaWZUWHlGeDJvcjdBd1M3MnhtWGhaOFFPSjJiS3Bi?=
 =?utf-8?B?ZW9JeWxjRnNKak1YK2dTemQzNDQ3M1pldDJwbGVTL3hkd1ZnV1pFMVJScXkr?=
 =?utf-8?B?OEVpTDJuMW8vTTBoMW5DajlpVU5KVng1R1BRL2x3UmlXNjhhR2lWMjR0SWhW?=
 =?utf-8?B?UDBPaEI0b0lrVyt1S3BBTGdmbDV6Tm5CK2JoZWo3RWpDYVF5MjZpMmVJbTV5?=
 =?utf-8?B?dnFiMnFqWDd2VUdaMENndXg5OS9RbUNKZFhtWUl0czZwS3dieWdDck9vUFIw?=
 =?utf-8?B?TTRFRUN0RDBSNVk1dmJlbVlDcjNIYnRYWDAwTkd6cFNrZnJtSGNNaVFZbERI?=
 =?utf-8?B?WTgzSlVOZ3ptc0tzYjVuanJoZTB1N3hsQ012UE5pQjVFVUpodDIxRXJLS3ZM?=
 =?utf-8?B?dExCUDRyREJ6ZHRxZEtXaXFETUdMMEtLb284NDhma0hydXIwZG5pKzFnYW02?=
 =?utf-8?B?UmpsYU4rRnhWbm05TDE0bVZwTXl2d3AvYnVBbDVZZEtXcmdScS80enVpVHdu?=
 =?utf-8?B?dUVkYlFYak0yd0V1Nk5HcWFheXVrRCtMSTgzOTU5UGVia2EzSk53elJmbDBt?=
 =?utf-8?B?OGVyalZlOGY2dW5HRTBoSkVVVUtTSXdzc1RETExBdSs1YnZzRU8rN2dZdk1X?=
 =?utf-8?B?MVh2OHdhaUNUbHZJL0dudHZLNkdHeGtrSEsycytGbW9iMWVtSXQyc2Z2SHZW?=
 =?utf-8?B?cFpzZmI3ZGpYZmVZTUd6VmRtMHdtT1ZqemdkNkMvMDZUSVBDZVJXMllFYzZ2?=
 =?utf-8?B?RDVSMnl6aTdvM3d1aG1CY0pTRkhXdUxSUisrTzRIQ21URVRZblNJTVdKaWpS?=
 =?utf-8?B?dlJpd1o5SHB2S2NqWGFhbFVKVit4cFZYVTVXK25UZlNHVXhlU2swdHFuR01Y?=
 =?utf-8?B?ZEZPbXhkRkpIcEszUFcwQkNRUWNuaFM5TkFzU0wybHhLekFWRlBLOHNodytO?=
 =?utf-8?B?NUpzMXI4QkFFTEc1WUFuNnhYUVBRb3FmM2t1b0FPbmFRdWVFckFld3JSOGg1?=
 =?utf-8?Q?CsU8fozcurjrtkXQxURzJ0Htrz+1WLIlWRjHA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(366011)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2tVSHJjdnhMQlZiUE1WRE1QY1dCdnN3UkFxMFYyVisyRXExV1FCbVJaeWJ5?=
 =?utf-8?B?RlFQWlJ2eWs4Y2svWGRsMzQ0UEorcFNmd3czU2xsK0tPdmZWZGV0Q3NEQXRP?=
 =?utf-8?B?OURuNnVGekFnbW9FRnBRMnVVVDNKc2tQR2xTODZlemRNR0s1WS9ZTzNwbXRz?=
 =?utf-8?B?ams0clZKakV0MHBFeC9YdGkwby96VWlVUjFWN1hGaVNsZ21TUGdEKytwYXA2?=
 =?utf-8?B?SWM3STcreDc2bXZCSzhpV0tHVW00MFBCN3dCSUNvUlVPeXgycHVoTGwxZmNH?=
 =?utf-8?B?TUg1MXBkWVo0UkNtTGZUdE9laTc0Q2NFTVpBZWNvWDI5UGRTOFRiMEhLWW9S?=
 =?utf-8?B?WXhlaklzM2t1Y0ZoQjV6RmFRVWlwcklvb2pwd0dPK0xMUWo4cytFTnZiaTUz?=
 =?utf-8?B?THlvMmI1MnIrYWZlUmI4cm1DQTdoWGc4bGc2dzlhSzZ5dXBXejdKdkh3UlpG?=
 =?utf-8?B?TWRkR3kxSzRvNnhhenRoSDlBQTloNXRJWU5CdndRVmFJZzJOVjhKc3RCS1NT?=
 =?utf-8?B?Ky9MT2RqSkt2K29Wb1hsT29KZndJT0ZZaVVrK2JQOHZwakI4QkpPYzVSR3ln?=
 =?utf-8?B?YmllYW15MUtvT1QyWkJrZjdwemhRbzBQaFVDQ05QVEsvSU40c2dRUHFZNzdj?=
 =?utf-8?B?YzRScnhOZnNTUUx2ejZjbC90VDA4TmFFQW5tbmJ5TGExNkZTSllnejlGR0Q0?=
 =?utf-8?B?bXlOV1hsNFRUSUwxQWN6RkE4cDdvSWhKZks1V0RhUHJFd2ZBQ0p5NmtGNyth?=
 =?utf-8?B?d2J0Y0VjbVdMRVdQNE5mNmkrQWs2RXY5cWJsRWhYemlOS3dVNW8vbnFrMFgw?=
 =?utf-8?B?ZVVQa1hkRU1FVXpJZ3haOG95QVpmNzZIL3dsMkJGd2txYTUyTjJybnNDQStH?=
 =?utf-8?B?NTM0MjcvN1FKeGZldFdMa0RTNXMybHFHTEU4dzRKVnNObGNEL3h6c0Y0TEJi?=
 =?utf-8?B?dTlvR2JpUXdCWllDUC8xc0xmU1dlN244cEJCZzZ3QUN3SkRiNllVTWVMZC9a?=
 =?utf-8?B?d0tKaU5vMUNlS1R6YllreTRZVkRPaVFidFBMZysrOEVhRi9xWDdFa3pxaUo3?=
 =?utf-8?B?cVdva2IzQWRZMmR5dGRHdlJJdEthTTVEK3U1NWxHeDgvWkhpVTlSQnNKN1I3?=
 =?utf-8?B?R2FocDFJRTNBVnhtQ0xLaHVsdDVUSmVLVDBKVUE4dFgvNThac3pSUjg3a0lp?=
 =?utf-8?B?cU5FQVJOL24ySnNjSmFVVmkxbjdnZUM1RGtNRVBVeHRVQml6VFQ3Zm41Rkxp?=
 =?utf-8?B?MkRRK3lwejN3d2JRSjlIcHZmWU5mUXVyQ3ZyZ2tuUnZ3eE9kc21SbzV2clh2?=
 =?utf-8?B?WnNML0VaaDV1VGVkS1FFWFhWY1NVWGcybmVkT2dyc3BQdHdobzFmVVM3emxF?=
 =?utf-8?B?ZlVlNFF4UkZKS2NFOTJ5ZStDTzdRNTZpdmpsZUZ4dUF0T1ozYzRyMEdhMzQ1?=
 =?utf-8?B?VUpiVWQvR0dpeDZlUGp2ZEwzZ1RDZHV0VzV0S0VYT3F6cmM5UE5vR0NOOWFl?=
 =?utf-8?B?YkcraTBBcVRyQnJZd2ZXRDgrNmMyRGFBVEc0NCtDYU55cTRCWTNvbXVySmNU?=
 =?utf-8?B?L2Z3TlU3TEVoZHRZZVluWjN2YXFUcllYdDFxTUxHWEkxcDBPL0hUUlViMXNT?=
 =?utf-8?B?YXRGT3ZsclZtekRaSEs1azdVVTFKcCsrSWdpS1RUTFhoWGYvcENITVpQWnBM?=
 =?utf-8?B?cWMyeVBRQ1BMb2kwVVd6NmprV01UbHRXUGVQNWcyVlFkOUVDWmZra2JERkdT?=
 =?utf-8?B?RVl1QUQ1WjM1Um5BR0t4QW1tcmNVYmRwczNIbXlmb2k0eVVFUVo3NkJYbkdO?=
 =?utf-8?B?QTRqK1BVNHpzdnNiN0N0a1crc0hCbVFLS2RMWE1jWmFrY051RWM3TThra0RM?=
 =?utf-8?B?SXJ3c3pOUjdHOGR3eXllbFdxVnA0M1VKY1kxU29IQ1U5UWVUbXVueEZOc09K?=
 =?utf-8?B?MFlJSFJZMDhENHJvNFZCSWhHSHpoY3gwZTh4bldFTFRqUThydjdicXFjelZO?=
 =?utf-8?B?NzkrL0Z6cDVhajNlWXN6bHY1Nm9nY3NKSzhlRm5LMzVJR1lja1l1eEdRVGVn?=
 =?utf-8?B?Z2NiZ1V0ejU3VzFWdXBpWHZBZGpjbW55SXhpdGNoVEdNUytZWmFEa21aSW1Z?=
 =?utf-8?Q?gpo39FOELd/arF4mgsaPYh+BD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EA707BADADF2C4EBC0FC269CF3E131F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f50c4cb-52cb-4535-df66-08dc8c30c9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:13:55.3429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jarzAoXjmSat0VzwuxE84Ov8kUEMOv1O1wNDq5k6DE9xojnYT3Cnilasv8tCBPo4avoBGBh6hJUM6SxCJf6h+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8324

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDYtMTQgYXQgMTA6NDYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiTm9uZSIgYWxwaGEgYmxlbmRpbmcgbW9kZSBvbiBNZWRpYVRl
aydzIGNoaXBzLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jIHwg
NCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5j
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IGluZGV4IDdlYWFmZDQ0
ZjMyMC4uOTA3YzBlZDM0YzY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2V0aGRyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhk
ci5jDQo+IEBAIC0zLDYgKzMsNyBAQA0KPiAgICogQ29weXJpZ2h0IChjKSAyMDIxIE1lZGlhVGVr
IEluYy4NCj4gICAqLw0KPiAgDQo+ICsjaW5jbHVkZSA8ZHJtL2RybV9ibGVuZC5oPg0KPiAgI2lu
Y2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZl
ci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiBAQCAtMTc1LDcgKzE3Niw4IEBAIHZv
aWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGlu
dCBpZHgsDQo+ICAJCWFscGhhX2NvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE1JWEVSX0FMUEhB
Ow0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJhc2UuZmIt
PmZvcm1hdC0+aGFzX2FscGhhKSB7DQo+ICsJaWYgKChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUt
PmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB8fA0KPiArCSAgICBzdGF0ZS0+YmFzZS5waXhl
bF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpIHsNCj4gIAkJLyoNCj4g
IAkJICogTWl4ZXIgZG9lc24ndCBzdXBwb3J0IENPTlNUX0JMRCBtb2RlLA0KPiAgCQkgKiB1c2Ug
YSB0cmljayB0byBtYWtlIHRoZSBvdXRwdXQgZXF1aXZhbGVudA0K

