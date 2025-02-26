Return-Path: <linux-kernel+bounces-533201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC79A456D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9AD176FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8A26B96D;
	Wed, 26 Feb 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oJKJkgrT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gX+RfnU/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A323CE;
	Wed, 26 Feb 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555626; cv=fail; b=qozYYMFGTVUQbq8qy6gsCHhvN3Bcil3BaBxROsSrViGdIbWGf4TVJpGi2l6wQ75dYiwNnZNuU3U0tImv84DhYPY16QtJVTuep/+2b++Fkp3NmXN5twhss5RhpXSJDr0ttoYnDScQ/1BvHs330Xk+RNo+4Z4alP4jgtIBpyY4ufA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555626; c=relaxed/simple;
	bh=oQSnnrN28YK99Yd+ws/BVkydxC091olH/5WpP9v7BZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yrhg4YG3VEOrM6ZUoDQzFo8U11PBupTyLVPPxadOPB1PJdq8ql75k/QF5g+5v6biYZOoGtVCoKIcyn0CYoHRNWr20CsUh/FRCi8G+EfFEUCaH+bbgw+evRHxe7bDX5Vr3S8nm66urHxXy0tI937d29fisQFklJngRkZdAfrcgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oJKJkgrT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gX+RfnU/; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ebbee480f41411ef8eb9c36241bbb6fb-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oQSnnrN28YK99Yd+ws/BVkydxC091olH/5WpP9v7BZ4=;
	b=oJKJkgrTZeb3QXOkgn/n5x4Jj1kS0Z74YVMhYnMS2HBjAoCHpnmqzVSF1PURHOeUY0kJMAncOnY5lJBuU2drai1xMq6Elve57/Eesx7McjrqBElCi6pAVAsIgciJ7Bsz1GIruGR5VJDfRe/UuxE1vTZs02L+zNrFsjC6to0Qzs8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:94e25f27-7073-47ca-947e-40bf9d5e6f41,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:f98993a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ebbee480f41411ef8eb9c36241bbb6fb-20250226
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1257405215; Wed, 26 Feb 2025 15:40:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 15:40:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 15:40:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfFCg5QcZ9tImuaxULuXIigUADJbn8yTJf0ZKTmVnWhYt0FvYEV67hk3gnPBrVrDqfaziImLqWeGv0winar+otxS9OS8SC42dJR8i3oHYtce3RfvvvB7OmzEbJzAe7Ez1xbEOaYGMSw+GHMTQNLur+hmARuSAkfUiS51ocB4vocD3yVuHQDs17sWDKsZ/9fK4PPJ6+9RVU1afz4hupK34JHHpJyKOrpsehtAwGM+2NHxx+KN5XazeVlyPMrFW7f/vfR6VhY/3CyXbXuhV/cho4tjBtgVK/Amh3wMll64G5y69aDH+YRp4DA8Bihupuw5/gKkCl854SioBRbQ1U1lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQSnnrN28YK99Yd+ws/BVkydxC091olH/5WpP9v7BZ4=;
 b=WjJ/aRpfAVm88QxNjwI7IKTNF0u5xady2qOj0PMIMUuIdjiQYa90w1PcZ906UdVkQvJPazAKCFxnGf8/QjRndKJLwgcLheL4jK3Wg2Xf3LA71ISikxTaIJE5GXxuy8uoIgs3pI+aM4IPgaXscf830VV+KVki87azw36inlzEWytbeCQplB3NStKmzeSN+PsQz2P9MP/bRJ/6MS6TWP00gOmLXHaPYyLhZZT/wtdRF9d0WHuXjDYcQsES1FJxVpbJGffeKzhwye/WVj4kojl6GspfgG5m8SN/5BNLfEQAsPVn6zhP4L+3kmBzMtN9cF38Z6Fb9Yed3phCspBTJYyskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQSnnrN28YK99Yd+ws/BVkydxC091olH/5WpP9v7BZ4=;
 b=gX+RfnU/h2srw06Zl0Hgw44Z76n5rMRHhhrtsOMsQExvAcrccV7Uj37517fq19lUWH0SsJxCPDPNEOt1w06Zv4sy3eFdnJecl5/LP7KVAX3Qm6Pb1SR3Una2PCMl87bbyEDh4gwfMljQ2B+aUkshSC1dO9oeROwuZZVhy0obRwM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6986.apcprd03.prod.outlook.com (2603:1096:301:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 07:40:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 07:40:12 +0000
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
Subject: Re: [PATCH 3/7] drm/mediatek: Add TDSHP component support for MT8196
Thread-Topic: [PATCH 3/7] drm/mediatek: Add TDSHP component support for MT8196
Thread-Index: AQHbgq+t5uYqq9hdlkOWkMDzCjOuFLNZPfYA
Date: Wed, 26 Feb 2025 07:40:12 +0000
Message-ID: <46c0c6ce0688d17000b6b05fa3f0ad0e5f33874a.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-4-jay.liu@mediatek.com>
In-Reply-To: <20250219092040.11227-4-jay.liu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6986:EE_
x-ms-office365-filtering-correlation-id: fd346916-4dd0-4f1c-1ece-08dd5638cdc8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWdCbFJ3VFE1andOQkdQaS94dko2Rkk4SjhIYmx2eXQ3SjNFd3hpMzFCRXhR?=
 =?utf-8?B?QzhZbWtoU0EyQ2hINDVIVVBQYW9xUjJGOTJtZUNzNHEwaW1LZ1lNQSs1NEc1?=
 =?utf-8?B?cFA3Uzd6OWR5eGI4RlYrcGdVZlB3clZleEtwMDJRL1JKTW1XZWhtZDEzc04y?=
 =?utf-8?B?blc2RU1WcDcyc1lPUEl5bUgxUVB4cjZmbEwrNGVFRXcwZkhmc3pKdWhXMm90?=
 =?utf-8?B?NG9aUnVxa1lVb1hrNWNTV2sxYk5GUEI5dzVRK3UrMVlnOFpYblN0S2N5WnVD?=
 =?utf-8?B?bldveEM3dHJiTHpJTzBSV1E2NHM2UkdyeXQrb2F3aTB4RDc4ZFJ3eXJHRHFh?=
 =?utf-8?B?Y2xiQVpRTTZ0MmN3Y1FkMW5wVFhyZDNkUUFWWVhXR0ZUZmo2di8xcktUMzRt?=
 =?utf-8?B?R0hhaG1qc3VjODcydUVZNURsdnhsR0luRzFzczk1SU5UT3ZOOWVGQzVLUkcz?=
 =?utf-8?B?LytVS1gySTBmSFhMWW1OOG0rRnQzTVVCY2JycnVkeFpsUTlvVlRHbTcwUWI0?=
 =?utf-8?B?OEg0bUZzK0RMUVBZRmxOcnVDZHo3Y2YyRVVkNGpuT1h0UHpjK1pod2hUVFRL?=
 =?utf-8?B?a2N5cUtVcW5FcjVBd3BTQ0c1NHlpNUx5RkJvZmFrSGhTM0M2aVlmTi84VldD?=
 =?utf-8?B?a0lxSTI1cU5JeHE5SXpuOEI5SUM0cXA3OU9TZmlrbWlHWlI4Ty90eWRkUFpS?=
 =?utf-8?B?RDhBS2Q5S09adTA3NFkwOUNDYm5JNGNRMm1lS05ZNGxyVzdPNk1SSTRCYnFP?=
 =?utf-8?B?NWxBR042WXBmZmhNT0tnMkdsUURONTFMYkdURUF6MENVK0FCejUzcVYra3NQ?=
 =?utf-8?B?REY0QVVadnRhZm9iU216VW1ldnlOMU1HcUNFM2FPdEFpNWpuNlVoYkwwR2JK?=
 =?utf-8?B?bFNXMUR4WFRvM2p3MWplYlFKcEorODdZQ2pJeU5yT0dnRjNGKzN2SmZ6TnVj?=
 =?utf-8?B?VGpyNjFOeHV5Ymo5K2VsZWZxbURYOEcrNVpia2lBdHFsR0VXRXRtL0VGR0M3?=
 =?utf-8?B?N3JLTkxJYUNmYVM5b1BUNURmVDN0WGtEVGhPYUs5eGZoV1lQOUxCR2hvK2FZ?=
 =?utf-8?B?R0p5WXhIV3U2Zmw4cVhVa2tKRWVUdU9QbStVNWh6UlhLalRHWG1hb3NRRlVW?=
 =?utf-8?B?aDJkeVJobHl2aC9WVFlHNmxYbnFMZ1FkakxOQ1R5d0Fsa016TDd3ZG5VeWJo?=
 =?utf-8?B?dTA5Z0J1eHU2OHkzUXJ0WUFLNTJFQittVGpXY0JveVNqc3pWVHN1dWtaZkdi?=
 =?utf-8?B?TzYzR0tGZkdGQ0dLelBoRmpSSkR0eGdSZWJDWng4a3ZoSFZqenVIUmRwa0Rt?=
 =?utf-8?B?aXBVQkg0ZGM3endMZTNyUFNwRWlyb0xVZXZwd1ZFV295VGlSL0pTeGNCWHNO?=
 =?utf-8?B?UUpJM2VFSEovckk3Tk92cTBEYVk5UU5iWjVONGpjS3pBZHp2cEhiTm1acDR4?=
 =?utf-8?B?UFZHeW0wQ2RTbExNZHBHcXIzWVVvZXJkUGJWRnM5SmduMDhjbml4K2dEaU1z?=
 =?utf-8?B?ZzBVRllWVnppdmdkMnRMUG5TZkw2TW5yS2EvOFBkSUwyWXBKTHFMWUYyV0Vi?=
 =?utf-8?B?NW1uMWsvVHdnZmdweStabXJNcER2NFJ0Ykk3RGY4WWZENTZDdkZpdGgzZDVO?=
 =?utf-8?B?OWdKT1JDYUo3eU5UTHpNNHhOTjJQdXdLRUN0Y1JxcVZ6N1M4eEdRRGlZdnBl?=
 =?utf-8?B?MmYwZGxWTGpiWlVESmlNSlFmWjUyWk1IT29NSXRRbzlMSmh4ekt1M2FEWUpK?=
 =?utf-8?B?eE1iWXVkdFdzVWNncExaYWZTVkJlekFYRXh2dlA3MDNaUXlmZm5acXRsRXFU?=
 =?utf-8?B?S0VOeFNIdGJUdWdwYTNaM3JPVjlMSnZIZmRjM3ErRnFQeWdhMDRRdGlGUWdC?=
 =?utf-8?B?cWUvdXpXcHh2SmtkTXZBcWpreGRDcXpydmViSEJ4N0tGZEo2cDV0UXRidjNx?=
 =?utf-8?B?OUJmbUt0Z1QwMXR5YnRBTU4wQkk3NWxXblI0MmhNQTJyWmZJVEk1V1FSeUUr?=
 =?utf-8?B?QXVTMjljRTlnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFpmSzhmSVRtMUhrVWNFYU9VVFk3N0NaL3ZGc1dUaDJYV1VaY3U1akFnb1hY?=
 =?utf-8?B?dG40QU9oSHcrclR4dDFLSGxrbXFXT0VmS0RsR0ZnSlFZOUNqSnBrRVY2ZkFw?=
 =?utf-8?B?THV0WkdudXlBNXFNZHQ4YWxmZG1qSUNrWWkrSGNZMWU2Ym0rSG5MQUJpaThw?=
 =?utf-8?B?cjk1TXNia3lSMnMyb3UraVJ3d01oTHZwY3RIQ0x2dHVWekhWOUlzaTlLMlo2?=
 =?utf-8?B?dUh5aG9maHpaRGpwMGlMa1RuelUyb2t4Sy81UGtsbE1zU2ozY2FleGdrNUVW?=
 =?utf-8?B?dGFnMEdHZjZ0cDMxUEdmWGlrRzZSVTV2V2NiSHFRSGxnVVpOVE05ZElVN05u?=
 =?utf-8?B?L1Jma0dPM2toV1dSTlBoN3BIeXBrRDZVVkNNV1MwQ0VYZkFqZHl3WGsxM2dn?=
 =?utf-8?B?M3NzSlJQVzh0RG16RnVqNlVaQXNQdlZBdDJENGZGQ2I2d0RuMUxLR2c0NTNZ?=
 =?utf-8?B?N1UwdUs1VHU1NHVCblFtVklqK0ZZSDczelh6bnFMWmxsTGlKYmJBNG5wUVBY?=
 =?utf-8?B?YnkwMjIwNzYzckhSTTI4aHZBT2Z5MHZwcTV1d2JDQThibm81WVRzbGZ4UHBH?=
 =?utf-8?B?L0RXejZURDUxa2FqMm5xaUg4aWxsaTByclNFSzkyTllXazdHeEZNRmF0MlFQ?=
 =?utf-8?B?SGNOU1ltSi9wOSs5aU8xSG9vOWxtQU9WRnlNQUMxVDZTak5BUTdDcTRSaXJC?=
 =?utf-8?B?ZnNCT0thMHcyRDRoS1lVSmtBMkJkdHNvN3F2cmxmSUNJUXhlRzYzb0lCMFNS?=
 =?utf-8?B?Si8wcG5KK2U1Tk1tak1yMko5ajZ0Uk5lNTdlUVg3UFpWTnA5bkFIOHJEQ0I4?=
 =?utf-8?B?d3NJTkw3Zi8rTTdMOFVvUGx2NHQrMXE3bkV6L0hUYzdIQ2kzZ1crd2dzZjdk?=
 =?utf-8?B?WEQ5S2pVMWh1VE1VNE94SHE2OW90M3JkRnRHNlFRM3Zrbzk0eGtyY013bkhD?=
 =?utf-8?B?VWxxeGFVbitNcVZkSndwMXJzMXpheTluWXcvMmpYK3J4TUZ4SmI3aE1Dc2hZ?=
 =?utf-8?B?WTVCQmtPU0JYOUtZQmtsd1lqMDN3RUk2SkVpTWIzVm5HejRyN1ZZUFlsRjBY?=
 =?utf-8?B?U2hvK2tpSEFXaDR6dEpMVWxaemdaeEdiOHE1bUtHcWtWMWVhVWJQN2RDRGY5?=
 =?utf-8?B?YmZBNlk0ZEZoUmVwQ0pZVTArYnFNR09XYm85elJWOXNTSkMrWDhUaEJLRTZK?=
 =?utf-8?B?MVlyRFFJOGpFdWJRcUQ4U2RTamlZWS90dDFWVHVLeG5CdGFqcHZTWUk5T3ZB?=
 =?utf-8?B?Vk05dnJtakpDb3hsMmpkRU95ZHhMblRkSGdKVDF1L01MVG5ncXFPN3lXZTh4?=
 =?utf-8?B?WjVMdE95STYycTNyak1aem85VXoyRzVuOFVKSHFOaHR6UFVwak5jRVByMkdS?=
 =?utf-8?B?MHgwdGRheFhxTjgrbmVRTVFjK2paTmUwVU91SHVENERVZDRKR2c3a05UYkVH?=
 =?utf-8?B?cFJQT1FEQWFHd3VUNHVrMnJqeWl2d3Z3N2k3aGNkc0U5anpCb3FvbGxZMFRB?=
 =?utf-8?B?NkRNMURUTXlWUFlXRHNLMnBNT2g2QU01NHlvSUZpL0VDSkhXTWVvVkw4KytN?=
 =?utf-8?B?dEw0cHZqUE1GekZnYXlUWHVObWpkcTlSM21nT25oQkJyV1BVR2F5d2VNL1Q3?=
 =?utf-8?B?WE5WZExZSVM2cXlUZEMrUlVCTVJHeUtBQmdQQjN2UlN6NUtrZkYvY0pMNXlR?=
 =?utf-8?B?OTJCK01TWkhheTZzeXRtdXNucFpYRG1mQk9sS2lyL1dwekpkSEt1N3JVcll0?=
 =?utf-8?B?MjdxWVlYa0k4OHcrT3VWT3N3VXBxUVRtdWp6WWtya1FZaDNTWU5mb1RqbDlr?=
 =?utf-8?B?NG9na0s3MFlSb1ErYWxzY2ZTcGZEY0hMMGZlZGh3Zmw4Wm9iRWlENDU1SnZy?=
 =?utf-8?B?TkZsR2NURmp3WjBhaUJsTi9vNFZKbUxGazFCeWRYaWM4MUZyQ1NRTzBuOHlm?=
 =?utf-8?B?NzdYVTB5QjBNZzBGV0ZjMlg0a3QxZW8xNlBVUGdMUy9QVFJCbjlqYUs3LzBl?=
 =?utf-8?B?WHVPQVYyUWozUkZwcU1LdS9uOVgvSGNnelk0aGZxSlVDMXN1R0lRMjdiQURK?=
 =?utf-8?B?eUxTTHVJTzNzeEFJR1I3TjZ6eitsVnlKREJ6bzlmSVJVRUhvSTBDdHdSM1lQ?=
 =?utf-8?Q?XhyKl29b2pbaw4+PWwWEyTZI3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14EE3B30A73ED04C95F2B0271FDEB1AB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd346916-4dd0-4f1c-1ece-08dd5638cdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:40:12.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7HQWcslBi+5/Pr/5seWtZl285uKl0VPFYFvMYNbR7YJKawxUfOvQCa0n4KUFTWnofatfaAiZAc6RjFw+PLc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6986

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE3OjIwICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
VERTSFAgY29tcG9uZW50IHN1cHBvcnQgZm9yIE1UODE5Ni4NCj4gVERTSFAgaXMgYSBoYXJkd2Fy
ZSBtb2R1bGUgZGVzaWduZWQgdG8gZW5oYW5jZSB0aGUgc2hhcnBuZXNzIGFuZA0KPiBjbGFyaXR5
IG9mIGRpc3BsYXllZCBpbWFnZXMgYnkgYW5hbHl6aW5nIGFuZCBpbXByb3ZpbmcgZWRnZXMgYW5k
DQo+IGZpbmUgZGV0YWlscyBpbiBmcmFtZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1
IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RkcF9jb21wLmMgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfCAgMSArDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgfCAgMiArDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDYxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9j
b21wLmMNCj4gaW5kZXggZDdlMjMwYmFjNTNlLi5iODdmZGU2NGVlNDkgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gQEAgLTU3LDYgKzU3LDE2IEBADQo+
ICAjZGVmaW5lIFBPU1RNQVNLX1JFTEFZX01PREUJCQkJQklUKDApDQo+ICAjZGVmaW5lIERJU1Bf
UkVHX1BPU1RNQVNLX1NJWkUJCQkweDAwMzANCj4gIA0KPiArI2RlZmluZSBESVNQX1JFR19URFNI
UF9FTgkJCTB4MDAwMA0KPiArI2RlZmluZSBESVNQX1REU0hQX1REU19FTgkJCUJJVCgzMSkNCj4g
KyNkZWZpbmUgRElTUF9SRUdfVERTSFBfQ1RSTAkJCTB4MDEwMA0KPiArI2RlZmluZSBESVNQX1RE
U0hQX0NUUkxfRU4JCQlCSVQoMCkNCj4gKyNkZWZpbmUgRElTUF9URFNIUF9QV1JfU0NMX0VOCQkJ
QklUKDIpDQo+ICsjZGVmaW5lIERJU1BfUkVHX1REU0hQX0NGRwkJCTB4MDExMA0KPiArI2RlZmlu
ZSBESVNQX1JFR19URFNIUF9JTlBVVF9TSVpFCQkweDAxMjANCj4gKyNkZWZpbmUgRElTUF9SRUdf
VERTSFBfT1VUUFVUX09GRlNFVAkJMHgwMTI0DQo+ICsjZGVmaW5lIERJU1BfUkVHX1REU0hQX09V
VFBVVF9TSVpFCQkweDAxMjgNCj4gKw0KPiAgI2RlZmluZSBESVNQX1JFR19VRk9fU1RBUlQJCQkw
eDAwMDANCj4gICNkZWZpbmUgVUZPX0JZUEFTUwkJCQlCSVQoMikNCj4gIA0KPiBAQCAtMjYxLDYg
KzI3MSw0NCBAQCBzdGF0aWMgdm9pZCBtdGtfcG9zdG1hc2tfc3RvcChzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICAJd3JpdGVsX3JlbGF4ZWQoMHgwLCBwcml2LT5yZWdzICsgRElTUF9SRUdfUE9TVE1B
U0tfRU4pOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBtdGtfZGlzcF90ZHNocF9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gKwkJCQkgIHVuc2lnbmVkIGlu
dCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICsJCQkJICB1bnNpZ25lZCBpbnQgYnBjLCBz
dHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGRwX2NvbXBf
ZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdTMyIHRkc2hwX2N0cmwgPSAo
YnBjID09IDgpID8gRElTUF9URFNIUF9QV1JfU0NMX0VOIHwgRElTUF9URFNIUF9DVFJMX0VOIDog
MDsNCj4gKw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIHRkc2hwX2N0cmwsICZwcml2LT5j
bWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJICAgICAgRElTUF9SRUdfVERTSFBfQ1RSTCk7DQo+
ICsNCj4gKwltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCB3IDw8IDE2IHwgaCwgJnByaXYtPmNtZHFf
cmVnLCBwcml2LT5yZWdzLA0KPiArCQkgICAgICBESVNQX1JFR19URFNIUF9JTlBVVF9TSVpFKTsN
Cj4gKwltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCB3IDw8IDE2IHwgaCwgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLA0KPiArCQkgICAgICBESVNQX1JFR19URFNIUF9PVVRQVVRfU0laRSk7DQo+
ICsJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJl
Z3MsDQo+ICsJCSAgICAgIERJU1BfUkVHX1REU0hQX09VVFBVVF9PRkZTRVQpOw0KPiArDQo+ICsJ
bXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgxLCAmcHJpdi0+Y21kcV9yZWcsDQo+ICsJCSAgICAg
IHByaXYtPnJlZ3MsIERJU1BfUkVHX1REU0hQX0NGRyk7DQoNClN5bWJvbGl6ZSAweDEuDQoNCj4g
Kw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgRElTUF9URFNIUF9URFNfRU4sICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJCSAgIERJU1BfUkVHX1REU0hQX0VOLCBE
SVNQX1REU0hQX1REU19FTik7DQoNCldoYXQncyB0aGUgZnVuY3Rpb24gb2YgRElTUF9URFNIUF9U
RFNfRU4/DQpJIHRoaW5rIGRlZmF1bHQgd291bGQgc2hvdWxkIG5vdCBlbmhhbmNlIHNoYXJwbmVz
cyBiZWNhdXNlIGl0IG1heSBjYXVzZSBzb21lIHNpZGUgZWZmZWN0IGZvciBzb21lIGltYWdlLg0K
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19kaXNwX3Rkc2hwX3N0YXJ0KHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2RkcF9jb21wX2RldiAqcHJpdiA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJd3JpdGVsKERJU1BfVERTSFBfQ1RSTF9FTiwg
cHJpdi0+cmVncyArIERJU1BfUkVHX1REU0hQX0NUUkwpOw0KDQpJIGRvbid0IGtub3cgd2h5IHlv
dSBzZXQgRElTUF9URFNIUF9DVFJMX0VOIGJvdGggaGVyZSBhbmQgaW4gbXRrX2Rpc3BfdGRzaHBf
Y29uZmlnKCkuDQpJZiBESVNQX1REU0hQX0NUUkxfRU4gaXMgdXNlZCB0byBlbmFibGUgdGRzaHAs
IHdoeSBtdGtfZGlzcF90ZHNocF9jb25maWcoKSBtYXkgZGlzYWJsZSB0ZHNocCBpbiBzb21lIGNh
c2U/DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19kaXNw
X3Rkc2hwX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGRw
X2NvbXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwl3cml0ZWwo
MHgwLCBwcml2LT5yZWdzICsgRElTUF9SRUdfVERTSFBfQ1RSTCk7DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyB2b2lkIG10a191Zm9lX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlz
dHJ1Y3QgbXRrX2RkcF9jb21wX2RldiAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiBA
QCAtMjY4LDYgKzMxNiwxNCBAQCBzdGF0aWMgdm9pZCBtdGtfdWZvZV9zdGFydChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAJd3JpdGVsKFVGT19CWVBBU1MsIHByaXYtPnJlZ3MgKyBESVNQX1JFR19V
Rk9fU1RBUlQpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29t
cF9mdW5jcyBkZHBfdGRzaHAgPSB7DQo+ICsJLmNsa19lbmFibGUgPSBtdGtfZGRwX2Nsa19lbmFi
bGUsDQo+ICsJLmNsa19kaXNhYmxlID0gbXRrX2RkcF9jbGtfZGlzYWJsZSwNCj4gKwkuY29uZmln
ID0gbXRrX2Rpc3BfdGRzaHBfY29uZmlnLA0KPiArCS5zdGFydCA9IG10a19kaXNwX3Rkc2hwX3N0
YXJ0LA0KPiArCS5zdG9wID0gbXRrX2Rpc3BfdGRzaHBfc3RvcCwNCj4gK307DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9hYWwgPSB7DQo+ICAJLmNs
a19lbmFibGUgPSBtdGtfYWFsX2Nsa19lbmFibGUsDQo+ICAJLmNsa19kaXNhYmxlID0gbXRrX2Fh
bF9jbGtfZGlzYWJsZSwNCj4gQEAgLTQ0MCw2ICs0OTYsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0gPSB7DQo+ICAJ
W01US19ESVNQX1BPU1RNQVNLXSA9ICJwb3N0bWFzayIsDQo+ICAJW01US19ESVNQX1BXTV0gPSAi
cHdtIiwNCj4gIAlbTVRLX0RJU1BfUkRNQV0gPSAicmRtYSIsDQo+ICsJW01US19ESVNQX1REU0hQ
XSA9ICJ0ZHNocCIsDQo+ICAJW01US19ESVNQX1VGT0VdID0gInVmb2UiLA0KPiAgCVtNVEtfRElT
UF9XRE1BXSA9ICJ3ZG1hIiwNCj4gIAlbTVRLX0RQX0lOVEZdID0gImRwLWludGYiLA0KPiBAQCAt
NDk1LDYgKzU1Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX21hdGNoIG10
a19kZHBfbWF0Y2hlc1tERFBfQ09NUE9ORU5UX0RSTV9JRF9NQVhdDQo+ICAJW0REUF9DT01QT05F
TlRfUkRNQTFdCQk9IHsgTVRLX0RJU1BfUkRNQSwJCTEsICZkZHBfcmRtYSB9LA0KPiAgCVtERFBf
Q09NUE9ORU5UX1JETUEyXQkJPSB7IE1US19ESVNQX1JETUEsCQkyLCAmZGRwX3JkbWEgfSwNCj4g
IAlbRERQX0NPTVBPTkVOVF9SRE1BNF0JCT0geyBNVEtfRElTUF9SRE1BLAkJNCwgJmRkcF9yZG1h
IH0sDQo+ICsJW0REUF9DT01QT05FTlRfVERTSFAwXQkJPSB7IE1US19ESVNQX1REU0hQLAkJMCwg
JmRkcF90ZHNocCB9LA0KPiAgCVtERFBfQ09NUE9ORU5UX1VGT0VdCQk9IHsgTVRLX0RJU1BfVUZP
RSwJCTAsICZkZHBfdWZvZSB9LA0KPiAgCVtERFBfQ09NUE9ORU5UX1dETUEwXQkJPSB7IE1US19E
SVNQX1dETUEsCQkwLCBOVUxMIH0sDQo+ICAJW0REUF9DT01QT05FTlRfV0RNQTFdCQk9IHsgTVRL
X0RJU1BfV0RNQSwJCTEsIE5VTEwgfSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRw
X2NvbXAuaA0KPiBpbmRleCAzOTcyMGIyN2Y0ZTkuLmZjOTBkMzJiOGMyZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaA0KPiBAQCAtMzgsNiArMzgsNyBAQCBl
bnVtIG10a19kZHBfY29tcF90eXBlIHsNCj4gIAlNVEtfRElTUF9QT1NUTUFTSywNCj4gIAlNVEtf
RElTUF9QV00sDQo+ICAJTVRLX0RJU1BfUkRNQSwNCj4gKwlNVEtfRElTUF9URFNIUCwNCj4gIAlN
VEtfRElTUF9VRk9FLA0KPiAgCU1US19ESVNQX1dETUEsDQo+ICAJTVRLX0RQSSwNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggZjIyYWQyODgyNjk3Li40ZWMw
OTg2NGJjOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+
IEBAIC03OTAsNiArNzkwLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRr
X2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX1JE
TUEgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLXJkbWEiLA0K
PiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX1JETUEgfSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Ni1kaXNwLXRkc2hwIiwNCj4gKwkgIC5kYXRhID0gKHZvaWQgKilN
VEtfRElTUF9URFNIUCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRp
c3AtdWZvZSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfVUZPRSB9LA0KPiAgCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRpc3Atd2RtYSIsDQoNCg==

