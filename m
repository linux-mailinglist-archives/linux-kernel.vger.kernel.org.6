Return-Path: <linux-kernel+bounces-423087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121BD9DA29E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73A12841FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A701494AB;
	Wed, 27 Nov 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JUC5I5G/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f8xt2cG2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E1142E67;
	Wed, 27 Nov 2024 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690959; cv=fail; b=l18Pk3joqkUUjWt+MdFe2KXwOCtRLQNigea3u6stxIFlyN2G5DJ8n21HPGOKXZ7haJrS1ZCPlAUG2OyW0HIBE0CU8FClq5SqqBijpx7HQppABPCaBKDgpqxeMpQ5nnpMOqU1xmB4wbUs8XAqQydKsI1MbD/litzG1JhI/tu1abw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690959; c=relaxed/simple;
	bh=+pqs5JOSoxXMR8VDmD/BwxDq7FivLyUP1+B2I63Sqs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h7ZfgIeQrRZYugOaF1x+gPei/2DDaEg2ls5Iiz4VjolwTCQB79H22qFhSYCydngSNt+llEtR1Iic8TdJRRUPt3Rxk69FguklcQmp2QYQZVWxQ7CduGILDDg4u0nI8TbSt8jbGsWcBPE57jl/YxE07/DF9dMz8uOZhv0cgqHQaTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JUC5I5G/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f8xt2cG2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90aa50daac8d11ef99858b75a2457dd9-20241127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+pqs5JOSoxXMR8VDmD/BwxDq7FivLyUP1+B2I63Sqs8=;
	b=JUC5I5G/qVuUJPlARxZy/ftf3dzgsXVNCkzjHL2F3agSRPKkYgTI/7EEhCmD/iPpyU7GbpcQPHah6M3yNpvBGx+RyO3eWM6E6MFD+rmww7mPg7B0pJfjnBQ/GoqtMANodkUKOAoz5VGNPjYOD1OWqVt4q+T222aK+V6FTvq4CTk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:615f06ff-9c7c-497c-b2ce-e3e36ccf0b31,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:6b1559e0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 90aa50daac8d11ef99858b75a2457dd9-20241127
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1607042202; Wed, 27 Nov 2024 15:02:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Nov 2024 15:02:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Nov 2024 15:02:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk4SMvD+C5SrnM1A9SBbInNzkuwec4jkoCs00M5r5q51PGC/cgYryXweVqrx23IxmYKwXnU6XFgjx43k+y9XD4oRSH66UYf+kEh/ZPOucMDsygeyA9OPT0wrM6hgFXTL2fjltv/tG4iObVCrHJwbpTPotnidfeV4ssJitrLm46hAB3NFL83avxpbu4hsTnIGSGFYl/dO5EY1MKGSSRiPmVDMgPUGrwDcgpVGTmtxzi+gPHhKlmYRAr8laTjo0KmmwhS/c2oJI/JVsOTTn6KfA7Pj4KzRH5ofGkiz7Rkdk77xbpUGDMYcqx0rxl8ruenrE1PPe6eC/EdbiG1+3lehfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pqs5JOSoxXMR8VDmD/BwxDq7FivLyUP1+B2I63Sqs8=;
 b=krm/17pHv4/hYRnWBl75sqyl1BB1qgQiYZh/9LI6voOnC9zi9pQ25E7fEsm11tU7PnCNhWyTOTeuJ8n827qTB5Cd9svP7Qe5UVMiZNhNCC4qY5PuGI/iofcmtF5RuGQ7I9TxbCk8/pCktI+LsldL+floK3sioDko6xp3Apcaahw/ODhViYGvfRGRMxBwIKP2CuIVO8dwEbAnuL9IwfTIk8P0jNJk7pEshWPyVm4EInkvlzT8jRILtW7DaXhwDz4kviZetjagZXhliIv3LWcS2CWw0zQdrMdP70wPKNxZ1/PnkW6I3lXGcuk4NgFUZKiagGE7Qbzt1YuRcMsiiUtqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pqs5JOSoxXMR8VDmD/BwxDq7FivLyUP1+B2I63Sqs8=;
 b=f8xt2cG2o0CL4dEMPzD1WK8u835rqO9MKaBPZ+hKqf2/zhIxxVs1GL1IMRUIGrneXEEh1ItARG3ddMn5tC0d4IWzgvlnQsuNrB30KtWsQpZiS6FKbYpPF60ctopiGZvd7JttiOvgrnhJvPxcCRLmN8TtjiJ4a3EqOjSuO97XNL8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8006.apcprd03.prod.outlook.com (2603:1096:101:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 07:02:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 07:02:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "kernel@collabora.com" <kernel@collabora.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Topic: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Index: AQHbO0o2kTOzG2fD30avrRutQMN1rbLC6GCAgAVWuwCAAKrhAIAAaa0AgAFqXYA=
Date: Wed, 27 Nov 2024 07:02:22 +0000
Message-ID: <a8ca9d1314f12dbb95ac4e4b9e8929adab35eaba.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-7-angelogioacchino.delregno@collabora.com>
	 <1b966a136f02b5586749a9c3d0bcec6c75224e49.camel@mediatek.com>
	 <33acccd3-e543-493e-a61c-282d894ef2b1@collabora.com>
	 <fd48c582e99d6c07be4b66919fb6c309379ad752.camel@mediatek.com>
	 <f1d16db0-a7e1-4cfd-85c6-8beef4385701@collabora.com>
In-Reply-To: <f1d16db0-a7e1-4cfd-85c6-8beef4385701@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8006:EE_
x-ms-office365-filtering-correlation-id: 1090bee5-885f-4283-26dc-08dd0eb170e8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFlvTnNnWmJZeXMxeXAzUC8zREtSWHlNUkYvTUJUamZSdWFzVU1OQzdYYk5X?=
 =?utf-8?B?RlRRT3BxdGpsbmtPcEx0c0IvT0F2d3F2NjRINDhjeDFPZUd6b1pLR1dqS1BT?=
 =?utf-8?B?VkFkMEtsN1Z6VitvdmxLalBDRGFWMEtmeW5Bc3ROMlRRMGpLODRKUjd2M011?=
 =?utf-8?B?Vk1taVdnVnlNZmtCWDlQMXJxUGR3d01IOFZFK1IwWGVKWjYyUGdaanFhS3dI?=
 =?utf-8?B?TGlQelYrRy80TTI3ZTk1ZFNqZkNWSi9taTJaZUZkenpHKzVRTGxwdUtBL0Rm?=
 =?utf-8?B?WmEwTGVmdEVkeWN1cjljMDRLdFBGdXdNcHEvTzBHeHViNWRJNWttb2ovWkdE?=
 =?utf-8?B?SzJBc2RRVXVzV0xMNnlTQktNRmhiYW5BaUFMR1VtYXdlbmJMWktaTHJpK0pB?=
 =?utf-8?B?dU1vNGllSTdDYmM5ZVZPYTdDNzR5SHJJaWZxaEdhR1hQZW1MV0RSdTZVR3Za?=
 =?utf-8?B?d05kckMrcXNXVm10QVBnY3hmakJkcG1Zci9tdlZMek5lZjRXeFZwQzF2UDlv?=
 =?utf-8?B?bk1zaDMvYVJmMEs3cmhmcFJGVlc0L0FoVnkrRnZVRDA4T2FGbDJEUFVvWFBo?=
 =?utf-8?B?aUR2c08rMEdlREVXSnVqQVFDckQ0NHlSQVBtTm1VelRqNStIWW1PazBIcVZP?=
 =?utf-8?B?Tjg4UU8zNU5vd0NNbk5Ldi84RVU3azR1aXh2YTdQcTZHREovUFNMaTlkdGZn?=
 =?utf-8?B?Yk9sbXlHK0lCemlEUjU0NHVIRmxJcUlLdFFMY1VFd0hCai9nZXZWdkVoUDhh?=
 =?utf-8?B?UytaZjdHSHBvWlc4R1dicmUwWjg4ME5ML01XVzl1ZVFCRzdNQTBRanNtem5y?=
 =?utf-8?B?V1RCaWZsclg4QVpiUXBhUDhqN2Q0RmVjdG0vbG94SDAxQVJJWUJRQ1JoQ2JC?=
 =?utf-8?B?dnRTTFVRZUwxd2xmSTJUQ0htcmxPZGcwM2lPd2FNeGVJWERCaG1tbFVWVUVs?=
 =?utf-8?B?dUxXUWUwYlUwRUxiZlQ4OHhhc3RLZFRLdUtJU1BlV3h0ZXhCQzBLZVBjbHlR?=
 =?utf-8?B?eU45bEd4Z1hPSldDZUZ6RzRvd0FxMkdXSUtpUEtlMFRyMkV4dHhhT2pVcTRX?=
 =?utf-8?B?VGc5alg4cS81U3FDQUR4RXFiZ0psOGhvMUxhVUx4amhhV3hBaXZJWVhzMVNF?=
 =?utf-8?B?MElRTzdoR1crWndQT3hheDVmVE5PeVhLZGg0MjVKdlNoSnZ3UnNqQ1ZmUXRP?=
 =?utf-8?B?TndPd0hwYStWMXBwZG0vK2hlT2FaZ3VlcmtWZkJjZ0FmeDVSVHVPMGoyazN5?=
 =?utf-8?B?Z1VwTWEwVDRBN1QxOUlqbFVaN2ZVNDlVa3pVV2R5VkZmVG1yYWZNWU94Vmxh?=
 =?utf-8?B?cTdjOUxJR2pXOE9ObFBkdVVKempYRHNpS1JCL1RpL3JHN2xEdkJJdkNsdGxM?=
 =?utf-8?B?MTBLczBZYVliVjhrZ2I0VW84T1N5OVN4M3hLRGtrdmR4dlBlYmFveUExM2RO?=
 =?utf-8?B?UXRaRFFVSk9jb2pmOXBGMXZvNFJpUUFYMDVxUlg4Wm1LNlVJaFB1THZ4TlRY?=
 =?utf-8?B?S2FMdE8rZ05UTldyTk5kVVhmRzVvWUZOWENxUXMwU0FHbVM2VTVyaWluNVhx?=
 =?utf-8?B?OTYwZDROYXNJRVJrc0d3NFg0bW40SitvM1R3d3V6cFkzczdrMjR2Z0pyOTAv?=
 =?utf-8?B?T2tTS3M4YVZhelVSeS80cE9nYmQzVDdmRDBkVUc5WXFYa29KZlpLeENEWkVu?=
 =?utf-8?B?N1Jad2pNUHByTC94b05XbFpSYVNYSGVlTUtLYnZ6R096cFBBTFZaM2tHN2dZ?=
 =?utf-8?B?U2Q5aXZ5UUx2aWhaakJNRU5OR0QybDhMYnBVeXYxVW5ueDF0TUQwYTg4N051?=
 =?utf-8?B?OXJRTjhjSHBSU0Q3Ky9mOGk4TCs4NEFwaXRYN2t4amZYc2tHSEpleHp0RHdJ?=
 =?utf-8?B?aWplVFMrdWRvdE1tZlU2VTNoWlRtVDFOaUt2bWtwc2ZlK1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmtETG9KdGFJSTRtVkFoTXNZdE91SENabEpKMjZkVG5pdzRiN1BCcDJDU3lG?=
 =?utf-8?B?cGxYcVdueDNubTNabUdRempDeHg3SG1jMXdSSEozYmVwTDUycnphbHByMjlo?=
 =?utf-8?B?THl2RmdsUGRtbkRnaVZsdWhFL2VmSTh4YzhiR3kwT3g4cUY5UjhFQWhSYlhy?=
 =?utf-8?B?eUZLaUdjZWFTbDFkT2hiTHV0RDNONFl1bGYwMWJGOTNoNUx6VDh5U2RCMnNQ?=
 =?utf-8?B?TTFMOHh3S3FYTW1RZEd2UmhnMjlGNHZYN1NlMnlVY1hEN3YxaGZsekd1L3Ft?=
 =?utf-8?B?TGo2dnpSMFZYVENFbFJxTTlyeXlabmdkWFJlZ0xJYW5hNjNXbS9hUGgwYURY?=
 =?utf-8?B?eTRSMGNScjdUQlRaY1JqOGprWW0xNEVER3BMYWpnU2JobTU3UzBPeEpIb1Ev?=
 =?utf-8?B?UVQzOEFBclgyczEySDl5NS9JaktEcGJweVo5Y0h6dWZTMkpUNHZMWm1zZzQ5?=
 =?utf-8?B?eFRiUnlPVkt6Sng1L2tFZHQwalhhemdsVGVIOUd4VXQwWGExQllYdG1BT2Fo?=
 =?utf-8?B?SkJSUDZkZUx6N1VTQ3d6MFBnb2M4RlFqbmdUSk1Fb293NSsrNGRtUmMxUWh0?=
 =?utf-8?B?ZmgyODVuL3dGcXh2WmhrcHRUYnVLWTNVY0ZIQm5wemNWNXc2R01sdGluUGpq?=
 =?utf-8?B?b2ptWW1uR1A2RlRPRkwyalg0SnBGTFlUS0kzaGdrZ1lwMlF6ZHptV0U1TzVN?=
 =?utf-8?B?UkdaYmdLN2h2eUV3SWJoYU9WTTlaN2VyZEtkN3NsTGg4OUhLRG9BYWN0U3JF?=
 =?utf-8?B?ejI0Y29zOXVzMm54VkxrbGV5STArdTFlVUJhQk1rQnRLdmFFbm53ai84S1Z1?=
 =?utf-8?B?S3dGcUR6Mm5Oenc0QzlqUVpWRll1ckE2RzJrSGRsWGhlbXNtanNCMDVITW1w?=
 =?utf-8?B?NUVRdi9rYVlVV1UrTkUyOWI1Z2tHMFY2NkNhMlgzVDBPS0Q3M25VeUhoY3Rl?=
 =?utf-8?B?a0YrWnMraXNwY2FVaERmU0RlRDh6SldUKzJvU2ZtYmpwR0k1b0VGOEU2SG1m?=
 =?utf-8?B?YUhoQXROZDNFY2NNdzJEa1ZBREN3Z20weUtXSkd6OENuVFJ0dndCYjQ1UGxt?=
 =?utf-8?B?dlgyOHBVM0JJUVJHYjd0aEZmekZqMHIrRlg5VElRU2hEeTBEa0FqZWdsVk96?=
 =?utf-8?B?cmVVOXZOVURJWG55K0FZYUZSbUFzMmJjWVFkZnRwR3lyTXo3UjN1S2ZPTHU3?=
 =?utf-8?B?alIrQ3VtN3NxUmZDN1psNDBRUmlRbFJ5Z2wwWk9nbW52YktldUdPMkpxdm1V?=
 =?utf-8?B?N0FVL1JqdXl4MFQ0NVpFaTcxcHppaUFmYnEvczhnUzl2RDFoTTdZQXFrekda?=
 =?utf-8?B?eWgzUEpwRGYvNGtSLzUwOXVGL2w3QWdWVjZTWExnajVYd0dtOG5KemJIaG9S?=
 =?utf-8?B?MzQ4UkM2R3VDQTdjajhncWpUOUtlckg0ZW1nRzg1N2xQNlBEYXlWT0h1L0Mz?=
 =?utf-8?B?R3ZYSkpXVUx1cXFrWWp4YkUxYm1nSXBRSmMwNTZiemJna0J3V0FzVUZGV1Iy?=
 =?utf-8?B?TjZpOTMvaDdHT1N0QVJEUmVPczY1clRLQXhKWElHN1N0VG9ncElXWlpMbzBX?=
 =?utf-8?B?MnNkbTh4eVJ6UWN3L3ExZ2dRWWJLQ3cxRUFoWHdUSG55QzMxTmxDOERGc0NP?=
 =?utf-8?B?OUxvSGxxZTFIS0dOL0oyU0R4MC9YbVZuNHJVVHlhSU9VMUR3T1pwc3Fta3VI?=
 =?utf-8?B?OE1iSzhkaUVWVzZxZUVKN3ZjZHR1MHhEN0RzaXB6cGp4K215aGN4cGFnUWxU?=
 =?utf-8?B?NVhLWmQwKzFTUkUvcW5sVVd1TC9TSFk4TjdwY0dpOThzR3NxWld2dERKc1h1?=
 =?utf-8?B?dU81RnVKMHdWbk5nSXR6QW5uR1FMWDNpaDVmbzlSMDZKa3Vxc3I4NUdLdkdO?=
 =?utf-8?B?b1AzWnRySjIwRDVOZTFnTGdFL3g1RWxkc3hKcWNxVGhPWld2aTJEZTd3eHlu?=
 =?utf-8?B?ZEZwdDZGbHRPY3R1MGtrcklIWkoxcXNTYjlUbzFXaGcyY3dxZHJPYkhiaXV2?=
 =?utf-8?B?ZzhSS3dBQ0dGOExMRzNIaFBlZnVIQVR1V0F1VTMzbHBIdlZSLzJUYjBvTTBq?=
 =?utf-8?B?VGYrTTd1V2RjbXdYaHdGenprNG9GRjRPRmRRc1ZrMWxDRHB1K1hGSjFaSHJP?=
 =?utf-8?Q?UqKd8YRaXBYJwbaHQEPrqKV6I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25CA73F8B375464B90D66D5E8AE1D490@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090bee5-885f-4283-26dc-08dd0eb170e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 07:02:22.2663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7730XaY9qsH+8Bbi9D+n8VP7OhfaTZcch2nrwWPovXDgWZLKPgADS/yMyvUmvow7GqJlDUgTiTSm8RAMC9zWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8006
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.222000-8.000000
X-TMASE-MatchedRID: EMyCvCfVN1ENtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCopoEWlZvizRmlaAItiONP35bNUY+JJjyFwpnAAvAwazxxE
	lGvP0lfjcjxfCJ/GHhhgY0ztehnm8D7+f/jfUYxK4jAucHcCqnRZO94uK1VSBKQU/vx3G/tFYLm
	JBTCeWS9/nCRCiwBYcO2RzUwv/GzdJ+HTEll5bHf28T9BUNXkhkos2tunL8DQs7eP5cPCWQ/4ZA
	Usty2ENDdtqlAQ6fUZoBua9UxitOnsRVu35DItMF6z9HGHKwNuSeMExjuIoEjg89vVcMJkhZfpd
	LFb2h+N9ix0TOFVSi7zzS1wmGiDmbqSoMCXyNc9H+PTjR9EWkm2siTY6Sb7GT7S4ZU4XTxD23ei
	pp00x0VrGJKVbbsUS8k+9WshUXGJfmyDIJjZQhFT/YzREB9OKreJWlnSW7AwA6s2mIXI3kIRct8
	i9Uuv4kzcRQVoIJ0Nui8O57z8o72GN6M1vhJ4H6Zzj+kMRBrZ9LQinZ4QefKU8D0b0qFy9suf7R
	WbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.222000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	65AD7B821E1E372723F421E2174068C198F18B139AE22C798AFA0C1FD0CD97002000:8

T24gVHVlLCAyMDI0LTExLTI2IGF0IDEwOjI1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyNi8xMS8yNCAwNDowNywgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBPbiBNb24sIDIwMjQtMTEtMjUgYXQgMTc6NTUgKzAxMDAs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBJbCAyMi8xMS8yNCAwODoyMywgQ0sgSHUgKOiDoeS/iuWFiSkgaGEgc2NyaXR0bzoN
Cj4gPiA+ID4gSGksIEFuZ2VsbzoNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0xMS0y
MCBhdCAxMzo0NCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4g
PiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIERQSSBibG9jayBmb3VuZCBpbiB0aGUgTVQ4MTk1IGFuZCBNVDgxODggU29Dcy4NCj4gPiA+
ID4gPiBJbnNpZGUgb2YgdGhlIFNvQywgdGhpcyBibG9jayBpcyBkaXJlY3RseSBjb25uZWN0ZWQg
dG8gdGhlIEhETUkgSVAuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBNVDgxNzMsIERQSTAgaXMgZGly
ZWN0bHkgY29ubmVjdGVkIHRvIEhETUkuDQo+ID4gPiA+IFRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRo
aXMgZHJpdmVyIGlzIGp1c3QgZm9yIE1UODE3MyBEUEkwLg0KPiA+ID4gPiBEb2VzIE1UODE3MyBE
UEkwIG5lZWQgdGhpcyBtb2RpZmljYXRpb24/DQo+ID4gPiA+IE9yIHRoaXMgbW9kaWZpY2F0aW9u
IGlzIGp1c3QgZm9yIE1UODE4OCBhbmQgTVQ4MTk1LCB0aGVuIHRoZSBkZXNjcmlwdGlvbiBzaG91
bGQgYmUgbW9yZSB0aGFuICdkaXJlY3RseSBjb25uZWN0ZWQnLg0KPiA+ID4gPiANCj4gPiA+IA0K
PiA+ID4gVGhpcyBpcyBvbmx5IGZvciBNVDgxODggYW5kIE1UODE5NSwgYW5kIE1UODE3MyBkb2Vz
ICpub3QqIG5lZWQgYW55IG1vZGlmaWNhdGlvbi4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlLCB3aGF0
IHdvdWxkIHlvdSBsaWtlIHRvIHNlZSBpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhpcyBjb21taXQ/
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBkb2VzIGZvdXIgam9icy4NCj4gPiANCj4gPiAxLiBFbmFi
bGUvZGlzYWJsZSB0dmRfY2xrIGZvciBNVDgxOTUvTVQ4MTg4IERQSS4NCj4gPiAyLiBEbyBub3Qg
c2V0IHBpeGVsIGNsb2NrIGZvciBNVDgxOTUvTVQ4MTg4IERQSS4NCj4gPiAzLiBOZXcgRFBJX0lO
UFVUX1hYWCBhbmQgRFBJX09VVFBVVF9YWFggY29udHJvbCBmb3IgTVQ4MTk1L01UODE4OCBEUEku
DQo+ID4gNC4gRG8gbm90IHBvd2VyIG9uL29mZiBmb3IgTVQ4MTk1L01UODE4OCBEUEkuDQo+ID4g
DQo+ID4gTWF5YmUgeW91IHNob3VsZCBicmVhayBpbnRvIDQgcGF0Y2hlcyBhbmQgZWFjaCBvbmUg
aGFzIGRpZmZlcmVudCByZWFzb24uDQo+IA0KPiBZZWFoIEkgdGhvdWdodCBhYm91dCB0aGF0IGFz
IHdlbGwsIGJ1dCB0aGVyZSdzIGEgZnVuZGFtZW50YWwgaXNzdWUgd2l0aCBzcGxpdHRpbmcNCj4g
dGhlIHRoaW5nIGluIG11bHRpcGxlIHBhdGNoZXMuLi4NCj4gDQo+IEZvciBlbmFibGluZyB0aGUg
dHZkX2NsayBpbiBhIHNlcGFyYXRlIHBhdGNoLCB0aGVyZSdzIG5vIHByb2JsZW0gLSBob3dldmVy
LCBmb3IgdGhlDQo+IG90aGVycy4uLi4NCj4gDQo+IDEuIFdlIG5lZWQgdG8gaW50cm9kdWNlIHN1
cHBvcnQgZm9yIE1UODE5NS84OCBEUEktSERNSSwgb3IgdGhlIG90aGVyIHBhdGNoZXMgd291bGQN
Cj4gICAgIG5vdCBtYWtlIHNlbnNlIChub3IgYXBwbHksIGFueXdheSk7IHRoZW4NCj4gMi4gV2Ug
c3RvcCBzZXR0aW5nIHBpeGVsIGNsb2NrIHdpdGggYW5vdGhlciBwYXRjaDsgdGhlbg0KPiAzLiB3
ZSBkb24ndCBwb3dlciBvbi9vZmYsIGV0YyBldGMNCj4gDQo+IFRoZSBwcm9ibGVtIHdpdGggZG9p
bmcgaXQgbGlrZSBzbyBpcyB0aGF0IHRoZSBwYXRjaCAjMSB0aGF0IEkgZGVzY3JpYmVkIHdvdWxk
IGJlDQo+IGludHJvZHVjaW5nICpmYXVsdHkgY29kZSosIGJlY2F1c2UgdGhlIHN1cHBvcnQgZm9y
IHRoYXQgcmVhbGx5IGRlcGVuZHMgb24gYWxsIG9mDQo+IHRoZSBvdGhlcnMgYmVpbmcgcHJlc2Vu
dCAob3RoZXJ3aXNlIHRoZSBibG9jayB3b24ndCB3b3JrIGNvcnJlY3RseSkuDQo+IA0KPiBTby4u
LiBpZiB5b3Ugd2FudCwgSSBjYW4gZWFzaWx5IHNwbGl0IG91dCB0aGUgdHZkX2NsayBlbmFibGUv
ZGlzYWJsZSwgYnV0IHNwbGl0dGluZw0KPiB0aGUgcmVzdCB3b3VsZG4ndCBiZSBjbGVhbi4NCj4g
DQo+IEJlc2lkZXMsIGtlZXAgaW4gbWluZCB0aGF0Li4uIGFjdHVhbGx5Li4uIGZvciBhbnl0aGlu
ZyBlbHNlIHRoYXQgaXMgbm90IE1UODE5NS84OA0KPiBEUEkwIChzbywgZm9yIG90aGVyIFNvQ3Mn
IERQSSBhbmQgZm9yIDk1Lzg4IERQSU5URikgdGhlIHR2ZF9jbGsgaXMgYWxyZWFkeSBnZXR0aW5n
DQo+IGVuYWJsZWQgYnkgaXRzIGNoaWxkLi4gc28sIGZvciB0aG9zZSBvbmVzLCBhIGNhbGwgdG8g
ZW5hYmxlIHR2ZF9jbGsgZG9lcyBleGFjdGx5DQo+IG5vdGhpbmcgYXBhcnQgZnJvbSBpbmNyZW1l
bnRpbmcgKGVuYWJsZSkgb3IgZGVjcmVtZW50aW5nIChkaXNhYmxlKSB0aGUgcmVmY291bnQgZm9y
DQo+IHRoaXMgY2xvY2sgYnkgMS4NCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCB0aGUgZW5hYmxlbWVu
dC9kaXNhYmxlbWVudCBvZiB0dmRfY2xrIGlzIGFjdHVhbGx5IGltcG9ydGFudCBvbmx5DQo+IGZv
ciB0aGUgTVQ4MTk1Lzg4IERQSSBhbmQgaGFzIGxpdGVyYWxseSBubyBlZmZlY3Qgb24gYW55dGhp
bmcgZWxzZSB0aGF0IGlzDQo+IGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgdGhlIG10a19kcGkgZHJp
dmVyIGFueXdheS4NCj4gDQo+IFN0aWxsIC0gaWYgeW91IHdhbnQgbWUgdG8gc3BsaXQgb3V0IHRo
ZSB0dmRfY2xrIGVuL2RpcyBwYXRjaCwganVzdCBjb25maXJtIGFuZCBJDQo+IHdpbGwgc3BsaXQg
dGhhdCBvbmUgb3V0Li4uDQo+IA0KPiA+IA0KPiA+IEZvciAjMSBhbmQgIzIsIEkndmUgbm90IHJl
dmlld2VkIHRoZSBIRE1JIGRyaXZlci4gSXMgdGhlIGNsb2NrIGNvbnRyb2wgaW5mbHVlbmNlZCBi
eSBuZXcgSERNSSBkcml2ZXIuDQo+IA0KPiBJdCBraW5kYSBpcyAtIHRoZSBIRE1JLVRYIGJsb2Nr
IGdldHMgaXRzIGNsb2NrIGZyb20gdGhlIEhETUkgUEhZJ3MgY2xvY2sgZ2VuLA0KPiBidXQgZXZl
bnR1YWxseSBpdCBpcyB0aGUgSERNSSBkcml2ZXIgdGhhdCB0ZWxscyB0byB0aGUgUEhZIGRyaXZl
ciB3aGF0IGNsb2NrIGl0DQo+IGFjdHVhbGx5IHdhbnRzLg0KPiANCj4gRm9yICMxLCBjbGtfcHJl
cGFyZV9lbmFibGUoKSBpcyB1bmdhdGluZyB0aGUgY2xvY2sgdGhhdCB3b3VsZCBvdGhlcndpc2Ug
Z2F0ZSB0aGUNCj4gUEhZJ3MgUExMIG91dHB1dCB0byB0aGUgSERNSSBibG9jay4NCj4gDQo+ID4g
SWYgaXQgaXMgc29mdHdhcmUgcmVhc29uLCBtYXliZSB3ZSBjYW4gbW9kaWZ5IHRoZSBuZXcgSERN
SSBkcml2ZXIgYW5kIG1ha2UgRFBJIGRyaXZlciBjb25zaXN0ZW50IHdpdGggTVQ4MTczLg0KPiA+
IElmIGl0IGlzIGhhcmR3YXJlIHJlYXNvbi4ganVzdCBkZXNjcmliZSB0aGUgaGFyZHdhcmUgcmVh
c29uLg0KPiANCj4gQWxyaWdodCAtIHRoZSBoYXJkd2FyZSByZWFzb24gaXMgdGhhdCB0aGUgSERN
SVBIWSBnZW5lcmF0ZXMgdGhlIGNsb2NrIGZvciB0aGUgSERNSQ0KPiBUWCBibG9jaywgYW5kIHRo
YXQgZW5hYmxpbmcgdGhlIGNsb2NrIGFzc2lnbmVkIHRvIHR2ZF9jbGsgaXMgbmVjZXNzYXJ5IHRv
IHVuZ2F0ZQ0KPiB0aGUgUEhZJ3MgY2tnZW4gb3V0cHV0IHRvIHRoZSBIRE1JLVRYIChhbmQgSSB0
aGluayAtIGJ1dCBub3Qgc3VyZSBhcyBJIGhhdmVuJ3QNCj4gYW5hbHl6ZWQgdGhhdCB5ZXQgLSB0
aGF0IEhETUktUlggc2hvdWxkIGhhdmUgdGhlIHNhbWUgZ2F0aW5nIHRlY2huaXF1ZSwgYnV0IHRo
YXQncw0KPiBkZWZpbml0ZWx5IG91dCBvZiBzY29wZSBmb3IgdGhpcyBzdWJtaXNzaW9uKS4NCg0K
SSB0aGluayB0dmRfY2xrIGlzIHRoZSBjbG9jayBzb3VyY2Ugb2YgRFBJLCBIRE1JLCBhbmQgSERN
SS1QSFksIHNvIHRoZXNlIGhhcmR3YXJlIGNvdWxkIHdvcmsgaW4gdGhlIHNhbWUgZnJlcXVlbmN5
Lg0KVGhhdCBtZWFucyBkcml2ZXJzIG9mIERQSSwgSERNSSwgYW5kIEhETUktUEhZIGFyZSBlcXVh
bCB0byBjb250cm9sIHR2ZF9jbGsuDQpJbiBNVDgxNzMuIHNvZnR3YXJlIGNob29zZSBEUEkgZHJp
dmVyIHRvIGNvbnRyb2wgdHZkX2Nsay4NCkluIE1UODE5NSwgc29mdHdhcmUgY2hvb3NlIEhETUkt
UEhZIGRyaXZlciB0byBjb250cm9sIHR2ZF9jbGsuDQoNCkkgd291bGQgbGlrZSB0byBoYXZlIHRo
ZSBzYW1lIGNvbnRyb2wgZmxvdy4NCklmICJIRE1JLVBIWSBkcml2ZXIgdG8gY29udHJvbCB0dmRf
Y2xrIiBpcyBiZXR0ZXIsIHdlIGNvdWxkIHRlbXBvcmFyaWx5IGxldCBNVDgxOTUgaGFzIGRpZmZl
cmVudCBmbG93IHdpdGggTVQ4MTczLg0KU28sIGlzICJIRE1JLVBIWSBkcml2ZXIgdG8gY29udHJv
bCB0dmRfY2xrIiBiZXR0ZXI/DQoNCj4gDQo+ID4gDQo+ID4gRm9yICM0LCBJIGRvbid0IGtub3cg
d2h5IERQSSBkbyBub3QgY29udHJvbCBwb3dlciBieSBpdHMgc2VsZj8NCj4gPiBFdmVuIHRob3Vn
aCBvdGhlciBkcml2ZXIgbWF5IGNvbnRyb2wgdGhlIHNhbWUgcG93ZXIsIHBvd2VyIG1hbmFnZXIg
aGFzIHJlZmVyZW5jZSBjb3VudCwNCj4gPiBzbyBlYWNoIGRyaXZlciBjb3VsZCBjb250cm9sIHRo
ZSBzYW1lIHBvd2VyIGJ5IGl0cyBzZWxmLg0KPiANCj4gIzQgaXMgdGhlcmUgYm90aCBmb3IgYSBT
VyBhbmQgZm9yIGEgSFcgcmVhc29uLg0KPiANCj4gVGhlIEhXIHJlYXNvbiBpcyB0aGF0IHRoZSBE
UEkgc2hhbGwgYmUgcG93ZXJlZCBvbiBpbiBhIHNwZWNpZmljIHNlcXVlbmNlIGluIHJlZ2FyZA0K
PiB0byBIRE1JLVRYLCBkdWUgdG8gdGhlIHNldHVwIHRoYXQgaXMgcmVxdWlyZWQgYnkgYm90aCAo
YW5kIHVuZ2F0aW5nIGNsb2NrcyBiZWZvcmUNCj4gZnVsbCBjb25maWd1cmF0aW9uIGhhcHBlbnMg
d291bGQgbG9jayB1cCB0aGUgaHcgYmxvY2spLg0KPiANCj4gVGhlIFNXIHJlYXNvbiBpcyB0aGF0
IG10a19jcnRjLmMgY2FsbHMgbXRrX2NydGNfZGRwX2h3X2luaXQoKS0+bXRrX2RkcF9jb21wX3N0
YXJ0KCkNCj4gaW4gaXRzIC5hdG9taWNfZW5hYmxlKCkgY2FsbGJhY2ssIHdoaWNoIGhhcHBlbnMg
aW4gdGhlIHdyb25nIHNlcXVlbmNlIGluIHJlZ2FyZCB0bw0KPiBIRE1JIGJlY2F1c2Ugb2YgdGhl
ICJuYXR1cmFsIiBjb21wb25lbnRzIG9yZGVyIGluIHRoZSBEUk0gZnJhbWV3b3JrIChmb3IgTVQ4
MTk1Lzg4IQ0KPiBiZWNhdXNlIGZvciB0aGUgb3RoZXJzIGl0IGVpdGhlciBpcyB0aGUgaW52ZXJz
ZSBvciBpdCBkb2VzIG5vdCBtYXR0ZXIgLSBzbyBmb3INCj4gcGVyZm9ybWFuY2UgaXQncyBva2F5
IGZvciBpdCB0byBiZSBsaWtlIHRoYXQgYm90aCBvbiBvbGRlciBTb0NzIGFuZCBvbiBEUElOVEYg
Zm9yDQo+IDk1Lzg4KSBhbmQgdGhpcyBtZWFucyB0aGF0IHdlICptdXN0IG5vdCogY2FsbCBkcGlf
cG93ZXJfb24oKSBhdCB0aGF0IHRpbWUgYnV0DQo+IHdlIG11c3QgcmF0aGVyIGZvbGxvdyB0aGUg
YXRvbWljX2VuYWJsZSgpL2JyaWRnZV9lbmFibGUoKSBvcmRlciBpbXBvc2VkIGJ5IERSTQ0KPiAq
YWxzbyogZm9yIHRoZSBjbG9jayBlbi9kaXMgY2FsbHMgaW4gRFBJLg0KDQpJdCBsb29rcyBsaWtl
IHRoZSAjNCBjb3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KVGhlIGNvbW1pdCBtZXNzYWdlIGlz
IHdoYXQgeW91IGRlc2NyaWJlIGhlcmUuDQpBbmQNCg0KaWYgKCFkcGktPmNvbmYtPnN1cHBvcnRf
aGRtaV9wb3dlcl9zZXF1ZW5jZSkNCgltdGtfZHBpX3Bvd2VyX29uKCk7DQoNClJlZ2FyZHMsDQpD
Sw0KDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+
IENLDQo+ID4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IEFuZ2Vsbw0KPiA+
ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IENLDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiANCj4gPiA+IA0KPiANCj4gDQo+IA0K

