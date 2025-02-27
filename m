Return-Path: <linux-kernel+bounces-535507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF8A473B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E670188F3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0D190497;
	Thu, 27 Feb 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EYSJ1NJp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YVukFnXe"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B01270031;
	Thu, 27 Feb 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627958; cv=fail; b=cEsak+nBqeBHiiT0G+pQVKKj42mvxVRg5AW76xF4YrPhyNzvcaVGcYFWVhVGL0NAZ56aOcJ5i6jAZO+fGulxnhbgGpKF8KDYEPLPqKgtnQTp9fBrmRaRWeyFHnr6jOi8AaZAlx3VGgXrV2GA2NEnQtMGCvj7iLWx76F8w/tGLu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627958; c=relaxed/simple;
	bh=bustT9EnOvRB6V+EgCcCHS6hC7st3QNy3XVNoYx+jY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UejfcVL2R3MmSkE6FS8Kg3xjcttutAf4U7pU7/uxI0bazyQfxEezus9wNmGELcFNtNSc39iEEMPflbxzZivuPZbJJ72H9xOQgq0N8u8L11WHpUJFbrF4qnoa6ERoguV0BmxV0C/lYw5WXoscPvPqCpMh3jNeEbLqh9g6IwD/iaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EYSJ1NJp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YVukFnXe; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55435906f4bd11efaae1fd9735fae912-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bustT9EnOvRB6V+EgCcCHS6hC7st3QNy3XVNoYx+jY0=;
	b=EYSJ1NJpF93g3osXIgsm/4dDr2eXsThhk/uJzOwjW7/9npkYA2jqLPGzWZOt2cL4mf6WTiDFPC1Bp/11yHOPEUPZpefGD3dQkF9YV3a2qZ1THhdgnQzCKrJae2n/7DSruNHDxb3S+uVdPCclCaHpLH/Hjk2ibuAcbCCrQ+x6SMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:92982ddb-dc28-495b-8177-923dd586a81f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:42c64f29-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55435906f4bd11efaae1fd9735fae912-20250227
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1317963159; Thu, 27 Feb 2025 11:45:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 11:45:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 11:45:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFuxKJ8/WJDeBddq0iVZw8bQwLNN0W1EmypFfcmij04tsacFw+QKr8tT7rvfk8xsQj9J0tCAcq3rclseKBIy3dLb6MA65r5NCLUAzrmfB85E2X+PHJMiEAl1c0ZbSJnRdDSA/PBTdgfu6fBJZgBIJxypppWEuUG7oaKlj7KAaZK54k/W+BK/pUHOXl1Jv+EZaNi4L9MXb/3toMVd6Rk/NJdlX3Fy5KbNPGRP8EI5j+xWSR9EVI7CEdCvBrhRmiBMuo3k89P5gjDxBUh1Gk3c2CQh3UUSdcEfGe6Yy3pfgErRaor4W5iVlJ4QTr/h6FTY5YAHkE0Df6ozRo8AfN/yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bustT9EnOvRB6V+EgCcCHS6hC7st3QNy3XVNoYx+jY0=;
 b=R/7/+74IjA0pala1IMmkfla76rfoTxLxCGacwOgF0zyeICwn9y0KIr0Edrxd5pgrpycNEAB1mA5Bwat3fGEwscGz3BKZ2+iUQXsn+OAbPYvG/McZ+MxkMnX4ydlgnt++FYJEexvGAW24kG9V7r+lf5kuJsmzAU4BzulrpYosVKpl2oH0DFh6hq5UoIgHYDqYiOOf33DtsYdnIPBp08IIGbLU8o8UjhhlQF2IWHRpi/qcYhcVWAqYNTx2kOX46u3zeFEaP9fW3BMDbmLsED/9B0ICmizvs/zcRbcopAGHQx5nIp0puyxJJvMvA0UjQlmBSfhNtTkXfYCZ9beds1wOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bustT9EnOvRB6V+EgCcCHS6hC7st3QNy3XVNoYx+jY0=;
 b=YVukFnXeXMvvyOEWkyXcXy4D6J7xL9qCvcMwp0j7IN7bemaJ+IHFOKSNMPYka1nMhAHc5OfT/RZRgr/QvwZG040WwwL/zQoqqKaXfC1BgGejclqw2I3b9Yo3yh1GqlL5sV7uWoYsjMTEmBXRoLJ6xO77RsW7M/ZHmwVdFwzqmLk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8073.apcprd03.prod.outlook.com (2603:1096:990:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 03:45:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 03:45:44 +0000
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
Subject: Re: [PATCH v7 07/43] drm/mediatek: mtk_dpi: Add support for DPI input
 clock from HDMI
Thread-Topic: [PATCH v7 07/43] drm/mediatek: mtk_dpi: Add support for DPI
 input clock from HDMI
Thread-Index: AQHbgVPCv0LYxISXX0+LZF8P1YhcqLNakYAA
Date: Thu, 27 Feb 2025 03:45:44 +0000
Message-ID: <f90ff4e2710aa329174e3d5f55c43270d31e3389.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8073:EE_
x-ms-office365-filtering-correlation-id: 63427fa1-6ae2-4550-67dd-08dd56e136f2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkZ0eHg4bEc0M0RKWWorK1RWOCsvY0lQdnRoZHF2dGxqSTVJbHorTlBGREtZ?=
 =?utf-8?B?eFVHNU1qZXJJN2xpSTI1elRFc1I3aU1uVVFiZ1l4YUpOSEJzbnNnOVBzaGdr?=
 =?utf-8?B?UEtBck1hZ1Z6NHNER3B4dEg4Q0Zjd2lHd1YzM01NQ3drUE5IRUxrOUZCSmYy?=
 =?utf-8?B?M29zY0FST2tVVVkvZHJBZnNrMDdpRWdxRjBjWEowZTVON1F4bGIyK2JURG5F?=
 =?utf-8?B?VWkwd2wrbmhYUzIrUW1zWXdkTDFzTEhhd2U0VG11NXk0T2krREdhLytCK0p5?=
 =?utf-8?B?T21VYmJReUp0RUtuNko2ZDYrQXBPOVd4Sm5ZdVZnbnVIcS9vOS9WNEV1bWVu?=
 =?utf-8?B?T012YWpIOHVKRGtpN1dJWnF3YWRPRzlWVHpJSFIzaG9HYnZIbXQxbG00emR0?=
 =?utf-8?B?ZlNGajlJdW1QM1pkYkFldFQwc0M3QnlyZ3lSSk5UQ3ZPZldBR0FIamdrekM5?=
 =?utf-8?B?ajBnazRBNFBnODE4ZEY5T2ZYTkZUMjRxSksrdkxjZ0lDNk9oTXQzdHJHWVRz?=
 =?utf-8?B?ZnkyNG9VRElCaldtY21ReHQ1OHNRaElqL21hcmtqZCtOdkNlSlRybEdVQ285?=
 =?utf-8?B?OFluSGMxNkk4S3lvcWExN0RXY1NiSmtOdW85em5LWXhwWi9SdVpORlhaMGVR?=
 =?utf-8?B?djJNc0tDejdqRGYwbmV1NjR0SnVnZ1RBa2Q3QUVOWTlxT2hGV1VMMjJ3a2VT?=
 =?utf-8?B?YXhHVkFCOUZKYXhJWit0akNrOG1KVGo1VnZVd2FjSnBHbUI3aU9xVFhWQjdM?=
 =?utf-8?B?Y3M0RkFMMmVpdGhkL0NFNFU0dEhIVlI2ZnAvN0lhWlZZdW1oMXpoUDkxbHQv?=
 =?utf-8?B?NGhTTmNCdFgrSk9hdm9jTlVrNFIyejB0RW1yQ1VCeGdGWXFLeHA3VEtndjVl?=
 =?utf-8?B?NHJId05WTnJPMjNKSUNkdnlLTHdTSEcxQnh2SVFDaXlpZmdSS0l4aTh1aytZ?=
 =?utf-8?B?SnZyKzEvWk5GS3BpTlZ0SnE5RGlWcjQvWnFHYk9XNlhpYmhpWUx4YXpTd296?=
 =?utf-8?B?dGdNTnR6MHFVWGE4L042NWpjVi8xOWZvSkt6K2NEMHhvRzExNk5QVzIwMVFk?=
 =?utf-8?B?RThmUXdXcHhIdUxBM1BKOGlxSWtIKzBMRlJ4ckpjNEg3ZCtGZ09uYWExZEI0?=
 =?utf-8?B?aE1iTTVrOC8zak4wSWFFTGp2RVg3RFBYaU1sLy9ycmNWeHROQmhIZDgyemdG?=
 =?utf-8?B?R1NhWHBrWUo2b3l6NW5KZ1Zac2JtRFVFcStYaERpMFhEc05ZTzRySUp0SGtX?=
 =?utf-8?B?RVUrSnpRaS9Ock9WZDJDMVp6RFBlbVpBcVl1MXdGYkdDaTZhWGxxeGl1NW9p?=
 =?utf-8?B?WjJqMmsreUF3Q0padDBiZEMwNlpSY2RjMWVwb1ZRTzRrR1lyMllDRGMxYWVr?=
 =?utf-8?B?R1k0N09VTGE0M1NNWjhTY29yT0p3R01ZcWJPYXdMUFphVjQ2QWQwWHU3ZU54?=
 =?utf-8?B?R2x5K21DcEx0YURPNXRsOWZZaEZTb3QwU3Z1RzlHbFJMTGVJT2hRMS9YbXJs?=
 =?utf-8?B?SzNYcWpoNklnWEpnM0RVVUlpTGhjd2NzQk5wVmFGZEtQQXgzeGhtdlJFb1BV?=
 =?utf-8?B?bVpkdVQ0M2MxQkNJU2s1VzFBTDRuY1R3elg4YkdWYmc0TGNKYTJYUStWMmFa?=
 =?utf-8?B?Y3E2Yk15Q1Nsc3dZRFhTOVo3d0VMTFZWZTd0VzRDaUtkU0hRemF1bGlOQ2Zz?=
 =?utf-8?B?dDdzZGw4ZVpXVVQzK2EzM1RwOWs4Z014Z0krY3lWRTBlOVBrWGZRUTRMZVVh?=
 =?utf-8?B?UzVwWDVUckswQ3dhNklwYTRzK3JMZWJCZldVczBSZUlrQWRqSWpTbmx6U1R5?=
 =?utf-8?B?NUZIekJ1dUNYWTJZRzNwSmlPQVBaQUErQTh6RGpTTGpQNk1mY1h3N1VIbGFE?=
 =?utf-8?B?V0N1N1JqNmdOdzRyRWsvTDAwVUdCZCtHclFaaVh5RGRBYnE4WjVnbXZUZkdi?=
 =?utf-8?Q?A65SLnszGrfIEfH195J+4hVOqHAwu4m8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21OWFJ4ODgyN0ZpVnZXeGo4NUV3VXZVYWVXb2dkVmdMTnFBeTV2ZWlqZE1O?=
 =?utf-8?B?TjhYTVFIcklRa0ZRT0p3S3BwVGI1RkVRaHp0S0tac25kbkZ6d0IzYUk1ZlI4?=
 =?utf-8?B?WXVZL1RrcXlMVUF4U3pNRXhpOWsrWWdYUC83ZkVZVk0rZVZaNnBSQUs1cE5j?=
 =?utf-8?B?UTJwRlFsNFNVOGxScmNzaHlXTGk0cHd1aDdaN256dkk4bEQxbTg3NE83eFI4?=
 =?utf-8?B?cDliU2piT1NxQjh6am13RUxkRGZCemI1VFJJRmJuLzMrREM3cTBGQVNBL0tC?=
 =?utf-8?B?WjRjWm5oM053MjM5SkhQOSswZlZwcll0YVd2T3NMUnV1M2hhS2JkbEo2cUdX?=
 =?utf-8?B?OVBzVnU0ZERPd3RyWExMZDVjZzBvWXNVY1U2SnZRRTBXUmhTTkcrbHYrSlY2?=
 =?utf-8?B?UTZ0UnVVUWtOVkNhdWhZckxIYlFCb2szKzZhYm5Ldm0xcFRKVkg3UjUxb3Ry?=
 =?utf-8?B?K1RvSTZWSDc0QXpWc3B6U3d3cUJWK1dGTmNwZ2RNRzlMd3BTOE1wRGRwZVNj?=
 =?utf-8?B?V2daaFV1MEJZQW55WTA1WlpHWk1YcDhaUHJuRHZ0eTBpRmc2SWQ0RmFsZzBE?=
 =?utf-8?B?ajkrL3lQRFhQZmZGQ3lMQmVWVnByWEN2dE1QUUozazRyeE1yckV1QThxZG8z?=
 =?utf-8?B?V3F4ZGEveTVJRjA2NXBRZHNHTXRUR1NFQk0vaVVkamtNM0FkeUJrUG50ZkVh?=
 =?utf-8?B?dFFMelF1YlRTRkVnN2swdFFsOVhKWGZRTnlaQ01nTlpQMVU3RjA5blJYcDJt?=
 =?utf-8?B?VjFndmxGbzhrZnRHdGRLbWdNY1hHZlBPYzZ6Qi8zdWtLekxONll5ZWk2ZHky?=
 =?utf-8?B?WE51Q0t3M3RrcGVxZ0RDWHRWdHY3VUYyYXE0eDdWZ0tDb2YvdndsWTRlL0Vi?=
 =?utf-8?B?bTgzK0drdVlXY0o1T3J4ZXVsQUxSUHJuOXNsdnorSHVydmhEU2krSEZObitS?=
 =?utf-8?B?VEZ5M0JwZ25wS2ZWajVra29SRUI1T1l3dGxGbGg0cktjeTBPZDhRZjgvNlN6?=
 =?utf-8?B?eFR4QytFbkFTdFk2NGkyTjVkcjdzRit5ZWVtUlpOTDV1N3g0Nms4a0dobXdS?=
 =?utf-8?B?TjZ1VXNYZEhyUU1GT01heGFTbHdhbGkxVlE2TzR0eEZrUS9TMkdsWmxTcnRS?=
 =?utf-8?B?QUVCVUN1bThKMWI5Q2RnSk90bzZ4eDAyL1FSUG1JS3VxaHRnYlFrcG5LbnV6?=
 =?utf-8?B?bmpMOGhhbkR6bDVkbktiNXJtK241ZThTNE11bGdlVmN4aExmZVpEZXN6UnNn?=
 =?utf-8?B?aEo2M1Z1cmY2d0lvWnFoYlQ2dzExSURUTU9oaE52SjNrajAxblNHRUlSSnpO?=
 =?utf-8?B?bFAwZ3Y3MXR1NGgrNHVXMndjZ1VhR2JrdStkZDZkdE5HQzZmaVM1LzhFYXJX?=
 =?utf-8?B?RUxuWjdxdWMvVFNFZmpaaGttbjRyYitpeHcvcHZXeW9ORFMwVlk4MHpScTlU?=
 =?utf-8?B?Uml1YnplOFRHM1BVVzR3UTh5OWc2MGxBMlBaOW9nemVtellSYUM2RncwMEFZ?=
 =?utf-8?B?U2JCTTFHdmFzU3RTRTF5M3VoalA5NkM3MTI3MDk2bmViWUpzZldSanJ0aFpM?=
 =?utf-8?B?eENLSTZwRVJCVmtiV3QweWlRU1k5ditCRkZZcmxnaDJPR2hxSkh0QlQzS1dP?=
 =?utf-8?B?NExOeFFQWGVPZ2NyQmQ4V2VobStqUWowR0p2ZlRBUDJucWJvbkc4WkI5Y1Zj?=
 =?utf-8?B?c2t2MHVGaVVnNjJQTGVJcXg1bGVIc3NwWTNqY0lHL3Y1OTlVTldPNy84MUlO?=
 =?utf-8?B?OS9rS0cyaCtUdldra1pkeTZmRUlnbXZrVWFDTjRLaWhqcjlIdU5yakdmMTMz?=
 =?utf-8?B?cEVvTVd6WjBYeERJaUNTZ2k0NmE0MzFMN2RpaVpsV0txcGc4ZUdPU2l4dXd5?=
 =?utf-8?B?d2hEWUdDdjk3Y3lZcFNDUDF3VkFwbUU2MUMvRmlBcmVLaS9mUmM2TWFYZW9C?=
 =?utf-8?B?WkFXR2w3Vnp4QTVSU3ZVWjV4TEg0eVNZaGFDYjcxWUROLytVNjkxVVNjMUFs?=
 =?utf-8?B?RjYzbWF2bTc0aWQwYkg1bm5EMTJwVHR0RGFlNkQyK2lqL3FiQ2dDWlhCVEFw?=
 =?utf-8?B?UzdkcDduQTJyM3F1ZVc2S1RTeHNGY0M1SjdZcS9OSjVvdSs0Q3pCanhhcUlp?=
 =?utf-8?Q?CDAuPRYMzsit2tV7OC8fDEPl8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF7EFF6BFB0C44EBD8411CDCC539636@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63427fa1-6ae2-4550-67dd-08dd56e136f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 03:45:44.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq3dplYqWe9HLHT6jmZsZXyY2I6WMBlxvQrkkJi5HkfIxX/c43LBel4klqXawuhnHNg4y3dzBp2c/R7nnrZqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8073

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBzb21lIFNvQ3MsIGxpa2UgTVQ4MTk1IGFuZCBN
VDgxODgsIHRoZSBEUEkgaW5zdGFuY2UgdGhhdCBpcw0KPiByZXNlcnZlZCB0byB0aGUgSERNSSBU
cmFuc21pdHRlciB1c2VzIGEgZGlmZmVyZW50IGNsb2NrIHRvcG9sb2d5Lg0KPiANCj4gSW4gdGhp
cyBjYXNlLCB0aGUgRFBJIGlzIGNsb2NrZWQgYnkgdGhlIEhETUkgSVAsIGFuZCB0aGlzIG91dHB1
dHMNCj4gaXRzIGNsb2NrIHRvIHRoZSBNTSBpbnB1dCBvZiBkcGlfcGl4ZWxfY2xrLCB3aGljaCBp
cyBlc3NlbnRpYWwgdG8NCj4gZW5hYmxlIHJlZ2lzdGVyIGFjY2VzcyB0byB0aGUgRFBJIElQLg0K
PiANCj4gQWRkIGEgYGNsb2NrZWRfYnlfaGRtaWAgbWVtYmVyIHRvIHN0cnVjdCBtdGtfZHBpX2Nv
bmYsIGFuZCBjaGVjaw0KPiBpdCB0byBhdm9pZCBlbmFibGluZyB0aGUgRFBJIGNsb2NrcyBpbiB0
aGUgbWVkaWF0ZWstZHJtIGludGVybmFsDQo+IC5zdGFydCgpIGNhbGxiYWNrIChhbmQgYXZvaWQg
ZGlzYWJpbmcgaW4gdGhlIC5zdG9wKCkgY29tcG9uZW50DQo+IGNhbGxiYWNrKTogdGhpcyB3aWxs
IG1ha2Ugc3VyZSB0aGF0IHRoZSBjbG9jayBjb25maWd1cmF0aW9uDQo+IHNlcXVlbmNlIGlzIHJl
c3BlY3RlZCBkdXJpbmcgZGlzcGxheSBwaXBlbGluZSBzZXR1cCBieSBmb2xsb3dpbmcNCj4gdGhl
IGJyaWRnZSBvcHMgYmV0d2VlbiBEUEkgYW5kIEhETUksIHdoZXJlIHRoZSBIRE1JIGRyaXZlciBp
cw0KPiBleHBlY3RlZCB0byBlbmFibGUgdGhlIGNsb2NrcyBpbiB0aGUgYnJpZGdlJ3MgcHJlX2Vu
YWJsZSgpLCBhbmQNCj4gRFBJIGluIHRoZSBlbmFibGUoKSBjYi4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDEzICsr
KysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGluZGV4IDlhNmMw
Zjc1Zjc2NC4uOWY4M2U4MjQzN2RkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBp
LmMNCj4gQEAgLTE0NSw2ICsxNDUsOCBAQCBzdHJ1Y3QgbXRrX2RwaV9mYWN0b3Igew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgSWYgcHJlc2VudCwgaW1wbGllcyB0aGF0IHRoZSBmZWF0dXJlIG11
c3QgYmUgZW5hYmxlZC4NCj4gICAqIEBwaXhlbHNfcGVyX2l0ZXI6IFF1YW50aXR5IG9mIHRyYW5z
ZmVycmVkIHBpeGVscyBwZXIgaXRlcmF0aW9uLg0KPiAgICogQGVkZ2VfY2ZnX2luX21tc3lzOiBJ
ZiB0aGUgZWRnZSBjb25maWd1cmF0aW9uIGZvciBEUEkncyBvdXRwdXQgbmVlZHMgdG8gYmUgc2V0
IGluIE1NU1lTLg0KPiArICogQGNsb2NrZWRfYnlfaGRtaTogSERNSSBJUCBvdXRwdXRzIGNsb2Nr
IHRvIGRwaV9waXhlbF9jbGsgaW5wdXQgY2xvY2ssIG5lZWRlZA0KPiArICogICAgICAgICAgICAg
ICAgICBmb3IgRFBJIHJlZ2lzdGVycyBhY2Nlc3MuDQo+ICAgKi8NCj4gIHN0cnVjdCBtdGtfZHBp
X2NvbmYgew0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciAqZHBpX2ZhY3Rv
cjsNCj4gQEAgLTE2NSw2ICsxNjcsNyBAQCBzdHJ1Y3QgbXRrX2RwaV9jb25mIHsNCj4gICAgICAg
ICB1MzIgaW5wdXRfMnBfZW5fYml0Ow0KPiAgICAgICAgIHUzMiBwaXhlbHNfcGVyX2l0ZXI7DQo+
ICAgICAgICAgYm9vbCBlZGdlX2NmZ19pbl9tbXN5czsNCj4gKyAgICAgICBib29sIGNsb2NrZWRf
YnlfaGRtaTsNCj4gIH07DQo+IA0KPiAgc3RhdGljIHZvaWQgbXRrX2RwaV9tYXNrKHN0cnVjdCBt
dGtfZHBpICpkcGksIHUzMiBvZmZzZXQsIHUzMiB2YWwsIHUzMiBtYXNrKQ0KPiBAQCAtNTg1LDcg
KzU4OCw5IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVjdCBtdGtf
ZHBpICpkcGksDQo+ICAgICAgICAgc3RydWN0IHZpZGVvbW9kZSB2bSA9IHsgMCB9Ow0KPiANCj4g
ICAgICAgICBkcm1fZGlzcGxheV9tb2RlX3RvX3ZpZGVvbW9kZShtb2RlLCAmdm0pOw0KPiAtICAg
ICAgIG10a19kcGlfc2V0X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiArDQo+
ICsgICAgICAgaWYgKCFkcGktPmNvbmYtPmNsb2NrZWRfYnlfaGRtaSkNCj4gKyAgICAgICAgICAg
ICAgIG10a19kcGlfc2V0X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiANCj4g
ICAgICAgICBkcGlfcG9sLmNrX3BvbCA9IE1US19EUElfUE9MQVJJVFlfRkFMTElORzsNCj4gICAg
ICAgICBkcGlfcG9sLmRlX3BvbCA9IE1US19EUElfUE9MQVJJVFlfUklTSU5HOw0KPiBAQCAtOTIw
LDE0ICs5MjUsMTYgQEAgdm9pZCBtdGtfZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+IA0KPiAtICAgICAgIG10a19kcGlfcG93ZXJfb24oZHBpKTsNCj4gKyAgICAgICBpZiAoIWRw
aS0+Y29uZi0+Y2xvY2tlZF9ieV9oZG1pKQ0KPiArICAgICAgICAgICAgICAgbXRrX2RwaV9wb3dl
cl9vbihkcGkpOw0KPiAgfQ0KPiANCj4gIHZvaWQgbXRrX2RwaV9zdG9wKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+IA0KPiAtICAgICAgIG10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICsgICAg
ICAgaWYgKCFkcGktPmNvbmYtPmNsb2NrZWRfYnlfaGRtaSkNCj4gKyAgICAgICAgICAgICAgIG10
a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICB9DQo+IA0KPiAgdW5zaWduZWQgaW50IG10a19kcGlf
ZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

