Return-Path: <linux-kernel+bounces-512407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719CA338E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5901162B87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3020A5DA;
	Thu, 13 Feb 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k3occmGI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oPTAUdrs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BA207A3D;
	Thu, 13 Feb 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432065; cv=fail; b=KJbMxnZFVkVx7YtsE+L9L2cscQf4nEHRYxLT2QZhqN9XsPbI0dAeHx86xKqzCpxfwtfCZL9u9oMV3YwpgVsdd9uMl4PNlEGLh52GrOa7SL4kgtvu6f2oWgPo60+J1G0FKe5/DomU7hXu+MURKCKIjiO54o8qtUPBiaNaegOWYlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432065; c=relaxed/simple;
	bh=InENazQi24XHcqvsDg7rPgDHmoPoIeHtiXGie8rPCJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+4FvqSWXcilDPTSO99PW068mMQMWLMFp17LbX7bK2gcYMtJp+n4p9/Cfsj7yiDbWrWXhROsY92pnah2yS7o/b4u5r9Ir7/rD27fDQCZ3Or6v5lEX7k1jqWRZi+R4cTU5iSMsm68xUWf5YFLKX/u6hHvHharoFAc3hX020RfuFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k3occmGI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oPTAUdrs; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef5c5c9ae9dc11efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=InENazQi24XHcqvsDg7rPgDHmoPoIeHtiXGie8rPCJg=;
	b=k3occmGIU5HhDJullGsRkqFZ2DDQE8IodEPUsh70RvZPj+tY4EtlPBOKS17csFtsNP6jjxNTwBzkloq4mI9/kaA0ZsCr3q32P0zS7mHrdNrJ1Og/IApN/CQBJAOdPDjf/mY7OMED/hYZ9nj2iEfAV0970HMZ+xk6bNpVMNIFUdk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:5883c5f6-9e66-4117-9f93-2d9f4409214e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c99267a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ef5c5c9ae9dc11efbd192953cf12861f-20250213
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 78487734; Thu, 13 Feb 2025 15:34:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 15:34:17 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 15:34:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsdodH0+GWXhtIl9F2i+U3Xx32Dchbhwbv/S5lyxwEZXKLWVFgxg2fKiDVdgw0WbpVOjg3YV6RwlKm8OGIOZtIwimyHZamVtPFuO1GTmyaVr9wX0Y6bcS7MbCxDoTTMFcBh6ihOppeoc4JAQNpqv4IIUMGzdxf2roJAbdumjWKFx5Xui+8cZChVsOtLsnWn432N2WGVL/NmOPMgCdJMPoicXGPCv16TlyYl7Vw2xoYZGUTPYiyKrda8WydiMnGNdCVR5C+j9W9yaEq5TVQIMr4rIhqGoTLin+vkXYewvcfyjZrVbe0QyYewlmF36HWqu1VKgujenBP2yoNcGF42nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InENazQi24XHcqvsDg7rPgDHmoPoIeHtiXGie8rPCJg=;
 b=pH9J/vV6omtXRznmhnLueSHcMcAeEvTE18ziSfYd+q/VJP/Z299wveVLjc0MRaKYXDVfAFb9Tu2MocB5otpkjeD2QKkR6V9taOkdcgFQTW04hgiUJciFXy5b+UoZLoUjgFFK7TH/pFiGlQPqhTpiLyIjEsRzRKSdDwL3pqPCkgSrQhCM6ScncbbKRx33K39URADzxCaoiHHaimbfErS0Fsry1W7DR+wpgzJc0riSGlqxLmDuRoAlgbvGxzFPIk0D4ZWyoXSPq3mApCCwE493Luf+Tnpk8PfaIdCDzQc91IdPLh3QYxetTEsRfAqcPp04KTDQtk2TpJ+JKjgMKEmeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InENazQi24XHcqvsDg7rPgDHmoPoIeHtiXGie8rPCJg=;
 b=oPTAUdrsbui22/ix7Mm1JRR/CMRFFwUKsIRttCRq1qcSeAtGl6ycgO+hE+OlnDlQJ2+qEwvDgo6cMubVk7tlawp6y2SXiwD7n354geyoA2iAlN/pbRKKO7QXTtiSquhwhV61S1EKenwcURj7Yo/t8GUgYIomX/Njzgl46DCba08=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8776.apcprd03.prod.outlook.com (2603:1096:820:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Thu, 13 Feb
 2025 07:34:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:34:13 +0000
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
Subject: Re: [PATCH v6 24/42] drm/mediatek: mtk_hdmi: Use dev_err_probe() in
 mtk_hdmi_dt_parse_pdata()
Thread-Topic: [PATCH v6 24/42] drm/mediatek: mtk_hdmi: Use dev_err_probe() in
 mtk_hdmi_dt_parse_pdata()
Thread-Index: AQHbfHmVxRXHO70PHUGKPFjUSxNgcrNE2mYA
Date: Thu, 13 Feb 2025 07:34:12 +0000
Message-ID: <9eb0630216e07d2167ab63471c532ba0d92597cd.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-25-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-25-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8776:EE_
x-ms-office365-filtering-correlation-id: 5b8fc891-6c2f-4b96-e6ae-08dd4c00cffc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVJEK3RaYkFad2liNE81Z21zMUswVlhpakhic0tKVHFhSlE0OXZLS2dKZXl0?=
 =?utf-8?B?aGRMNXZFRy9MSEljbWc3VXJUdlRXWkE0RUVFR05Ic2puRmJZTWhPUmgwRzF0?=
 =?utf-8?B?NmpXNGdZTENjUXNFb2pGdkp5ZWg5bEc5YUNkMFdHQWloaWJVZS9UL1d3K1FS?=
 =?utf-8?B?NTlMbTlnaTRIMWJ0SmJTc3gwMlc2cVF3dUFCMHlLdk1LN204bTdnYVcyelpW?=
 =?utf-8?B?eC9vczNJZXVRUWtRREdQeDN1bkZlaCtHQk9QZloxdlFLdzZkYzdlQ1p2SWpU?=
 =?utf-8?B?R3JqRVVCTU9RdzRHaFNTYXErdjMvM3lCT0dtVjcxVTRsV3hQMjBkcUtBa1Rs?=
 =?utf-8?B?RFM3dlIxS08ycXI3NkJSMEhsbC84cUZiWTlnZVBhRDhVY3NVRmlWMkpoZ0Fh?=
 =?utf-8?B?Vmd3cDNIU1VOVFlXN3htN3UxaTVSUlhKbU84Z3l1YmJvaGhJOG9PcHRqbHZ2?=
 =?utf-8?B?aTQxdFRndnlWOTBQelZBTi9NRVBabHd0Zys4Y000TTRzekE1dk8yOUE1aWhF?=
 =?utf-8?B?dnl5d3dmODF4bFFUbGtLODNpN1BaYklxdXlGSVYybzFQSGpGaUViaUllUlJq?=
 =?utf-8?B?TXJLalh5OUJ3OXlkNk0yM1ZJNzdySUlneE40VVJ3a1ArYXJnUHBneWJraUdp?=
 =?utf-8?B?eTIzNHB5M0kzWWU5czllVW5Kb3FqZHFRSTBkNjZ1M1o0RVJjTmNLNXYvSm00?=
 =?utf-8?B?K0FSZ1RwMHZ2bG12aHJZQjNJNVFuSGU5VFdOOFlGZStlYjYwenQzUEtueGMw?=
 =?utf-8?B?QXhySHRka3BRMUtCbHJjOEphT1BPckxJOEt1S3ZOVjVDZTdPUWtVNE5CdTlt?=
 =?utf-8?B?U0dlQU1ML2pENUNHTWk5OFB6SmdBY1QyUVc3OEFrd3F6Qy9nL3g5b3EyUmZO?=
 =?utf-8?B?aHlEWExvZVFHNWxVbHlWK0xodmg2ZGMrUXQwdHdtbE53KzF5VmpXZEJxREVC?=
 =?utf-8?B?M0w3UVRUbXEveTc2MG1WR0Q4blY5T0pDbG4rNmdZR283aHA5ZktTcXVtcmxE?=
 =?utf-8?B?UkZ0Y2llejh0cCswQnVpQUgrSEQ4anR5OHZ6S3dmRGtPLzZFZFYyVUZPZWpu?=
 =?utf-8?B?ODBGR1N0OG9kM3ZTdjlYaUdCa2d0TDJVdE1QRjBpY2grM3Y4UnZXekRIbGU3?=
 =?utf-8?B?eSsyTmYyRWpIZWl4WVV1aVF5ZmhYTnRMSDBoeXhWY1RjUzFHNERsaStYMWNo?=
 =?utf-8?B?N2hnaTY2ei9TV3dWZkVxZGQ3WjZhTmwydjk3akVjOFp2Z01HcjhWQWU5bXIr?=
 =?utf-8?B?VUd0NnNkNDRiQVF1SWJYN2p0UUtSc2ZCa2pMKzhFR3RCSGdjMWhCNlZCV0tL?=
 =?utf-8?B?QUdMVjNBbjBvcHd5RGFzUTZmbGNtald2dEJ4Q2tZVE1yU2diSGNaOVNPL2lh?=
 =?utf-8?B?ZXZaMDAyNEczWTJxTW1Iayt1V2lqaWRFTmZrWmFhMjNwZ2YwWFRFeXdLTjU5?=
 =?utf-8?B?aGd6NW4wOVBnNU12bHA5MW5KZnVQZ1N3WW1ENFVhZUhXMkwvcGlWV0psRm5S?=
 =?utf-8?B?NkF3ODFyVXRzSFZsaW1TWHNXRFJhWVRDL1dReHNPMENWRm5CN0xxUFoxeWhq?=
 =?utf-8?B?enUrQkc1alk4VVM4K3d0WE5DVnFaSUNqeXgwcW9KSjhlWXlpT3ViQUF3WEd2?=
 =?utf-8?B?dU5OYU9EeGxKZUFYQ1FjNXN3RW9BaEpPOExzR1hUUjE1Q3NDNklBLzRuODh1?=
 =?utf-8?B?dk1EVU9wTXpkK2lZbjBQNk9EUnk2cnFGWHp0MUNyZTlneUcwV25EdDAyTzJ6?=
 =?utf-8?B?UXd3ZkhFRlZwaWZUTFl4aVZ6Y0J6c3Z3QnRLUFp6OUhjQnlMdUJwRUhMbUtF?=
 =?utf-8?B?KzdPVnpZc050K1pqMzdMck0vM1Z0R1RSUDZERHVVR0liSnJ3ZDRwSW5NUkJE?=
 =?utf-8?B?cE9EYTQ3ZkFRNGE1YlhzOUR5cm5tZzVOVktjczl6UDdKVjYxOXVHalF0cDlR?=
 =?utf-8?Q?UGCDluFiXU34lqb1yVbMIsp7wX4CkUC/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVJWbTlsd0RiMmhJQnJLOXVLSDlhTDA0aXBCdEJJNHNYc3J6ZHBuR1pGRHNB?=
 =?utf-8?B?SDNUbDFjald5bWVkV2YvdFVEd1orbzZzUm9VMGtDdkNzZ1ZIb1U1Z1k4dkNa?=
 =?utf-8?B?eGVSK2lHQ29DeHFnTWpXV2lNck5nU3NCaUNwMkFXMmdqcldGdmZHUDBqMVJP?=
 =?utf-8?B?NW85aFd2ZWFMUnJJOW5naWx2ek0yUVBnL1lVRk5JN1hvUWtXWkVmK1pITGVm?=
 =?utf-8?B?Q3VoUDcvM1FGa25NN250eTh5QjhOYmNrMjhrSENLalJ6SUVxbGpiYWZTQzUy?=
 =?utf-8?B?SWpaaGYxSlpnVGUvaUErR3E0R2NBLzQydG9hd1VPZmZtSDA4K1ZXbkszYnQr?=
 =?utf-8?B?U2FoVUtpRnE4WGVzOUhvOWxESlREZmlxRWZ5aTNacFovMWZHaXNWQ0cwRDVU?=
 =?utf-8?B?ajY5cVBpeUtiT0c1S095TnJBU0xpUU55Z2ljbXQyK2NTSzFWbitSRzNxWFla?=
 =?utf-8?B?d3hiNVowMlk1blQ3MUJQSFMrUVFZQmdEU3hzakpjaEJpU2NBUzdCN0VoM2RH?=
 =?utf-8?B?NldZT3pCZ29DNkZoSGNIK1pZVGp5bG41bnYvY3k3ZmJ4Zy9YT0RZamdwOXFH?=
 =?utf-8?B?NGFVTU9mTVhCcDBneXRjN2N4Y0pxV05TK1cxNzRqTVY2d0N5QmNvVHVXRVcw?=
 =?utf-8?B?Zmp5bDJlNjhCaWxBNW53SnF3dWtDdWNWTkxwTFB4SG9ISEk1N2lYK0NYakJ5?=
 =?utf-8?B?OGR6bGJ1OTVYaDJ1cmxDcmY1NHlwMzRHSGZZczB1Y0FTOUN0QmV2UUZ1YlMx?=
 =?utf-8?B?V3BHTjJSc3dlRy9WOWtCLzZnTFFHVU9JNlBOVFpieEo1TWhELzkyekFmK25k?=
 =?utf-8?B?c0N3TDZFTWxRaDNOczJJbzZiNUcyNXVWUUFnQ3g0NGd1ZUVYZlIwVnRrekp6?=
 =?utf-8?B?RW9xcHJBR3pkbGhtd3ZFTXpROHp0VWUrZEk5RGs2bE42S1B2Uk5kZkhBdkFa?=
 =?utf-8?B?ZWdjMFJ0cENOT2dJM1Y4S256U0g5bW5FbVZDelB3SWlpMjJGUWFYV044MXFU?=
 =?utf-8?B?d1dJdExYakttZTZ4QmRJOVY0amtPbUs4ZnFxVEtCSWhxSGpaNlI3OU5RM3Ni?=
 =?utf-8?B?aW0zak4rSy9JYUhpbXpwVFFRTW5iYWRZSmpnZklOQUtqVnBIN09BSmNEM2pT?=
 =?utf-8?B?SWgxQUpVWUJMY3VSb2FZZ1NsQU9tVWY0QnYwaE0wT3J1K3dwT0ZhUytKZ1da?=
 =?utf-8?B?dUhHSWI5ZVBTV2RZWGRWTEN4ZkZRODZlRnBtS0xUU3MrcExHN3pmRHg0SHl4?=
 =?utf-8?B?Z0tMYUhIdXl4ZG4yUjJKalNxSFREWHpZOW5FZTd4d0kvY2J6a0kwaFBzSXRj?=
 =?utf-8?B?N3cwMDJuTm9MRit1QTVxcGNjaE1qVXZzZnBRWE1oT2ZqTW5kNVkvOS90ejdq?=
 =?utf-8?B?dFVtZ2s2QUZPeU1NWEhTZDZFalo1ZlFVeE5DcXVTSERkRjRuakJNSVhrT21P?=
 =?utf-8?B?SUJzWDgrUnNkaUFLcjc4MFNzTHQ2TFNxNU9YNElFMEgxTklaRXZBNUNoRVpD?=
 =?utf-8?B?WW5tNjI1ZVF6YUNGNUtqYlRBcUZjZVJKZldMdENIWE5RbGtZN2JWbG9PeEYw?=
 =?utf-8?B?WDU4cnJ6Y3hUSklPbW9Jc0U5ZUFnRDRQQ05pOGhQMXl5RjhiQzhTcUV1RWt6?=
 =?utf-8?B?UkdYS29pKytDZ0Y0Zkord1h5Sk8ycEV5aXVTamNQQnZCSGRKRUdDNlNZdWRz?=
 =?utf-8?B?ZlQyb1NMOGdiQnRDSU9FcjZXd2VoZnM3V1QrMFBnVnROSityQ0NmTTA1bTBi?=
 =?utf-8?B?ek9Rcm55MFJndWdoRFRhejk5cjdSMlJkNGVJNXFTRENvODIvcGpUS3JXdWh4?=
 =?utf-8?B?MDVobHk3bCt5cmdudEFIZGc2NzJjeStSTmZuWkV0bEIva0xqVmJDa2Z2bjNt?=
 =?utf-8?B?REJYYU90ME1jUTZRN1FYWHV1WTZucFBwUk14RlVjdnhBdExGK1laTmh5S3ln?=
 =?utf-8?B?cFhKRDk3eEp6RW9zZzNCR1BkUExXRHJJRmp0VjdnNUMrRGlLRlpqbW9WMVN4?=
 =?utf-8?B?ODVyM1BvNXZQclI2NXVERnZHbFFaUDdmOExSOFMyK3NCVVZZb3pWeDFRUWVE?=
 =?utf-8?B?ZzgvUGtobFVWZkRrVm9uZ1UrTlowbG1jUUovUWdoZUJ5a3VPWU9QOEJXQjJR?=
 =?utf-8?Q?J4uQGsQKjMkgtXd7O/KeKY7w2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49AD19A1C8FF094099FCBEF102316D39@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8fc891-6c2f-4b96-e6ae-08dd4c00cffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:34:12.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXiuGvF369Jgs8bPpw1Ob+oUrTtWLF+b416Lq5v4pii7w0rB4CMSRC2Kgf26I6P2wS4GuzXzicPdgIy+59OwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8776

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBDaGFuZ2UgZXJyb3IgcHJpbnRzIHRvIHVzZSBkZXZf
ZXJyX3Byb2JlKCkgaW5zdGVhZCBvZiBkZXZfZXJyKCkNCj4gd2hlcmUgcG9zc2libGUgaW4gZnVu
Y3Rpb24gbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEoKSwgdXNlZCBvbmx5DQo+IGR1cmluZyBkZXZp
Y2UgcHJvYmUuDQo+IFdoaWxlIGF0IGl0LCBhbHNvIGJlYXV0aWZ5IHNvbWUgcHJpbnRzLg0KDQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2hkbWkuYyB8IDMxICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBpbmRleCA2NWU5NjI5YjZiNzcuLjYxNDBiNTVjMjgzMCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gQEAgLTEzNzIsMjUgKzEz
NzIsMTkgQEAgc3RhdGljIGludCBtdGtfaGRtaV9kdF9wYXJzZV9wZGF0YShzdHJ1Y3QgbXRrX2hk
bWkgKmhkbWksDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRl
djsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiAt
ICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2VjX25wLCAqcmVtb3RlLCAqaTJjX25wOw0KPiAr
ICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcmVtb3RlLCAqaTJjX25wOw0KPiAgICAgICAgIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmNlY19wZGV2Ow0KPiAgICAgICAgIHN0cnVjdCByZWdtYXAg
KnJlZ21hcDsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gICAgICAgICByZXQgPSBtdGtfaGRt
aV9nZXRfYWxsX2NsayhoZG1pLCBucCk7DQo+IC0gICAgICAgaWYgKHJldCkgew0KPiAtICAgICAg
ICAgICAgICAgaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgY2xvY2tzOiAlZFxuIiwgcmV0KTsNCj4g
LQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gLSAgICAgICB9DQo+ICsgICAgICAg
aWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LCAiRmFpbGVkIHRvIGdldCBjbG9ja3NcbiIpOw0KPiANCj4gICAgICAgICAvKiBUaGUgQ0VDIG1v
ZHVsZSBoYW5kbGVzIEhETUkgaG90cGx1ZyBkZXRlY3Rpb24gKi8NCj4gICAgICAgICBjZWNfbnAg
PSBvZl9nZXRfY29tcGF0aWJsZV9jaGlsZChucC0+cGFyZW50LCAibWVkaWF0ZWssbXQ4MTczLWNl
YyIpOw0KPiAtICAgICAgIGlmICghY2VjX25wKSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgIkZhaWxlZCB0byBmaW5kIENFQyBub2RlXG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICBpZiAoIWNlY19ucCkNCj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIkZhaWxlZCB0
byBmaW5kIENFQyBub2RlXG4iKTsNCj4gDQo+ICAgICAgICAgY2VjX3BkZXYgPSBvZl9maW5kX2Rl
dmljZV9ieV9ub2RlKGNlY19ucCk7DQo+ICAgICAgICAgaWYgKCFjZWNfcGRldikgew0KPiBAQCAt
MTQxMyw5ICsxNDA3LDggQEAgc3RhdGljIGludCBtdGtfaGRtaV9kdF9wYXJzZV9wZGF0YShzdHJ1
Y3QgbXRrX2hkbWkgKmhkbWksDQo+ICAgICAgICAgaWYgKElTX0VSUihyZWdtYXApKQ0KPiAgICAg
ICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihyZWdtYXApOw0KPiAgICAgICAgIGlmIChyZXQpIHsN
Cj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAiRmFpbGVkIHRvIGdldCBzeXN0ZW0gY29uZmlndXJhdGlvbiByZWdpc3RlcnM6ICVkXG4iLA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICByZXQpOw0KPiArICAgICAgICAgICAgICAgZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxl
ZCB0byBnZXQgc3lzdGVtIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzXG4iKTsNCj4gICAgICAgICAg
ICAgICAgIGdvdG8gcHV0X2RldmljZTsNCj4gICAgICAgICB9DQo+ICAgICAgICAgaGRtaS0+c3lz
X3JlZ21hcCA9IHJlZ21hcDsNCj4gQEAgLTE0NDMsMjAgKzE0MzYsMTYgQEAgc3RhdGljIGludCBt
dGtfaGRtaV9kdF9wYXJzZV9wZGF0YShzdHJ1Y3QgbXRrX2hkbWkgKmhkbWksDQo+ICAgICAgICAg
fQ0KPiANCj4gICAgICAgICBpMmNfbnAgPSBvZl9wYXJzZV9waGFuZGxlKHJlbW90ZSwgImRkYy1p
MmMtYnVzIiwgMCk7DQo+ICsgICAgICAgb2Zfbm9kZV9wdXQocmVtb3RlKTsNCj4gICAgICAgICBp
ZiAoIWkyY19ucCkgew0KPiAtICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8g
ZmluZCBkZGMtaTJjLWJ1cyBub2RlIGluICVwT0ZcbiIsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHJlbW90ZSk7DQo+IC0gICAgICAgICAgICAgICBvZl9ub2RlX3B1dChyZW1vdGUpOw0KPiAt
ICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGRl
dl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLCAiTm8gZGRjLWkyYy1idXMgaW4gY29ubmVjdG9yXG4i
KTsNCj4gICAgICAgICAgICAgICAgIGdvdG8gcHV0X2RldmljZTsNCj4gICAgICAgICB9DQo+IC0g
ICAgICAgb2Zfbm9kZV9wdXQocmVtb3RlKTsNCj4gDQo+ICAgICAgICAgaGRtaS0+ZGRjX2FkcHQg
PSBvZl9maW5kX2kyY19hZGFwdGVyX2J5X25vZGUoaTJjX25wKTsNCj4gICAgICAgICBvZl9ub2Rl
X3B1dChpMmNfbnApOw0KPiAgICAgICAgIGlmICghaGRtaS0+ZGRjX2FkcHQpIHsNCj4gLSAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBkZGMgaTJjIGFkYXB0ZXIgYnkg
bm9kZVxuIik7DQo+IC0gICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiArICAgICAgICAg
ICAgICAgcmV0ID0gZGV2X2Vycl9wcm9iZShkZXYsIC1FSU5WQUwsICJGYWlsZWQgdG8gZ2V0IGRk
YyBpMmMgYWRhcHRlciBieSBub2RlXG4iKTsNCj4gICAgICAgICAgICAgICAgIGdvdG8gcHV0X2Rl
dmljZTsNCj4gICAgICAgICB9DQo+IA0KPiAtLQ0KPiAyLjQ4LjENCj4gDQoNCg==

