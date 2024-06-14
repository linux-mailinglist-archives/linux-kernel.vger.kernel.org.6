Return-Path: <linux-kernel+bounces-214387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4661908384
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2ED1C227FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A81474C5;
	Fri, 14 Jun 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ll0GATeA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t2/SzGRu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E35393
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345201; cv=fail; b=MjwLFwCL3z3Sp1vaTso+3CG3phqv0Clkj2EFatVpRRRh8u35TY1ca9okXlCl3zrZkDvAd87Qd++sbf2bTI+6XGi0Tl1ustR/eMyFHJquxxNK2AIfQtRcL5UvuMxu+jabtttQROImHGezcqwBxcrEKTfPwLz8GeJH3u0OIeYnn/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345201; c=relaxed/simple;
	bh=6nnm2yTdo9cvC2B2TK/xjBmx0lHjh9g89oUXpvF4zYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PruL7Wtb8unwROPtyr6a5KgyB9lGKsgAnqxDz2psWm/MBSBR6N5PUPzsCEFi89b+vxS09Auk86Gwbw1KT6VVIpo7wXDx5AeSG+8iOIrOhlL1ntFuzeEbikJOjj2xjVJXoOEwGygFIUleZ3RsfzBPiMH7WTyJxliJsPGPn2UHwMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ll0GATeA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=t2/SzGRu; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3fb646d02a1411efa22eafcdcd04c131-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6nnm2yTdo9cvC2B2TK/xjBmx0lHjh9g89oUXpvF4zYk=;
	b=Ll0GATeACPGjyMW/7fUqU308TJ27cnGOO/Vl7V4UDclPpi0PY3hQW6B4pZhe0Kd4Lt1JIa/AJmdwPRNESL56te8tUNUk39aqHwyqp1Lm8DG1jIG3W9Ymg5743gYRDt6ODu1NU+zbhdpZE23352XntVRyS6Oh+4QNtRciV7Fr2S4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:6f56bdf5-eae1-4602-b4e6-44a3958ea0ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:05769144-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3fb646d02a1411efa22eafcdcd04c131-20240614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1287891206; Fri, 14 Jun 2024 14:06:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 14:06:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 14:06:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7dEpIeKDJhLjK/FY0XO+pY4mpe2fRhcgu3AOMRM+HjJ21pi84Lf6F9VUZaGzTGlHHVLy28JEfNgfkXfXOd9XYePZA2Cbym7Qod8FE610gDThB4mkr2IsWO1zv/bjMxxD31x8xJb5Y044wF7iwqCWQbOO7R1y/pho0b3IlyeyNLuyRvgCK+4E3jlioPcF1RtXbc0qu8bvH1l0muTGTOIAEahIoydLgfzAzKodSpmEjm+qXoHT1JpcmIizSUJ7Zh5O2vibwpJ5PHXx5w/IXUyV5Gw7rL8Db4uIpu3N3sgWl4d54DW0ZGOS28CudTwDYEN7Y0/LU2EE1zDvKBN97vW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nnm2yTdo9cvC2B2TK/xjBmx0lHjh9g89oUXpvF4zYk=;
 b=mOm4sgywnhFhOgzXHTdqWxBXdeD9f8z1RrsFKv+Y8RXk5uEyu0t0Wk5FoKDudwDESr+ByBh5MHHM4O9v/W7Ip4IBv0JVXnzsItpnqUAipSTjG9t/o0LzjnF/e7y44kVDD5zwDhFw0JuGwQnFbr0tfPi1pnfbr0neMLRMsDpeg3EDhGv0gKDU17u3sVrpG0Iz+Z4uvYlTqrbFQpVYGrbP9a1795SbdW1h4t+eYgykgQh17nrhNq7jYlXNykGID/EC16oES6tSkk8Dyf52NCMoIpDjzgGdDxX8MY6BDPQ+MdQMM6AONUXv6s2JGGfxR3DeqMJqGUTbuRtudMXG/BLFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nnm2yTdo9cvC2B2TK/xjBmx0lHjh9g89oUXpvF4zYk=;
 b=t2/SzGRuIHVl0iu6yw9DFtfsNug67pO1mQTT08pCaJiffo3I+37Yqpw6/mjjp3dVMQ1FZ9Bs9w7u0MLthiyBUTJbW4EvbUU0VXIQ65ZBqIArobuzje3Cbxr8Rnm3Yz0+PKAng8wwFoDC3xS/NVXXWggiTE8LwG+mmdVHkgfJsoo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8014.apcprd03.prod.outlook.com (2603:1096:101:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 06:06:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 06:06:28 +0000
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
Subject: Re: [PATCH v9 09/21] drm/mediatek: Fix XRGB setting error in OVL
Thread-Topic: [PATCH v9 09/21] drm/mediatek: Fix XRGB setting error in OVL
Thread-Index: AQHavgU4D79W53ld2E+P0nF8/dKcRbHGxfIA
Date: Fri, 14 Jun 2024 06:06:28 +0000
Message-ID: <70a883a79c65c2ffc764a2cef5bd4bf763e2acbe.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-10-shawn.sung@mediatek.com>
In-Reply-To: <20240614024620.19011-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8014:EE_
x-ms-office365-filtering-correlation-id: 6764f393-ae66-4895-5f3f-08dc8c382172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?cWhXZTJlYTYrOXNsT2ZWbzBGamJXakJqVjZYNmw3a0hwUEJJN0NOWWFoak5X?=
 =?utf-8?B?UmlySW1ud2RCY3REbDlZT0pxSmFZNnpkRHB0eURMTTE5R2JqclFhRlhwejNY?=
 =?utf-8?B?QnZObjhXN3ZXbDBNVU02cVpwSzJSNzVUUnV6T1BxU25xTjV4L0Y4c0hwVDlO?=
 =?utf-8?B?NzArd2FkRXZtK3lwdXpLNzVqQWNrN2RNTWJ1UGU1UkJlWGsxQTNESk1JdS9P?=
 =?utf-8?B?T240VmN0Y2g3RUVEeCtTK3Z6eWlBejFPUm56bnJhTlppdlZkTWtLeW9GQVo2?=
 =?utf-8?B?WWVJRkNtUjFCZ2RSNWtScERyY1c1V1FuaW5IL09rNEpQWE90dGMvOS9TZzNY?=
 =?utf-8?B?bU9BRFpDSWM0ZktEbnBtSUt2Vk80Y0c2RWVjWTA2R1BhNWdoUzdXVkhzY0dB?=
 =?utf-8?B?cEw2cTNFNWNqQ21UZFViVTJqOWZGamFSLzdXRTdNUis2MjhrTlB4ZCtIYXFa?=
 =?utf-8?B?VGw3dHZOT1lHdXlYbS9hQ3FOYnduRGZpQm1VTkx6M1lLMlhFdzcvTURxUEtX?=
 =?utf-8?B?Q2g1Wk5BWVhmSURBV0NUdlJZeDArcnZmaXlkR3MvZzc1b3RxczZMaU02d3J5?=
 =?utf-8?B?NEJKMjVFa2NiK1ZORFZQOWdNMktYLzVsaVVpTU5OVzFFbEkvaEoxNlgwazVH?=
 =?utf-8?B?L0JzVTRPNHBEZmlNSXR2ZEtndzdlTlNobDA2OEhmMjVjb2ZCUWVEclloTW9n?=
 =?utf-8?B?MTR0bmV4RDhBNTBBa1NGWVUvdFkyc0hpTmN1QlllTHZGM3Fxd3l1c291S2xx?=
 =?utf-8?B?dnA0bFNpYnMzRUV6MDU0eStZZ3RGdHgrWk5OaEhqalBXeWlOSEU2Uk5Rczg1?=
 =?utf-8?B?c0YvQ1NXUWF6WFZIUmZOOXJxUmZCamxHSnA1NlM4b0JCZEhzYUFaMHZvRUs3?=
 =?utf-8?B?Sjd1Tnc3eXh1QVMxbE4yK0FOSzlCVkFxWEVvb1ZyVTZJc1ZCYVBOS0xySVBl?=
 =?utf-8?B?ajJwdVdSc1NNWWtXY3Y3b0tqNG41R0JabnVKSXVETng1SDlBNUVCQUdsb2ZG?=
 =?utf-8?B?VDZ3Q2RFUXlpUXRCc1JIbG5Db2VCQmlDM0VxQkhLRUFGcERqenZCVTFGTFFO?=
 =?utf-8?B?TXhWR3VaUnVMQll1RkNXaUZwTVFRWElYdjY2VEpDY2lUS3JmbVNkcW8yYUZ2?=
 =?utf-8?B?RWZaZXJGWkFIVzMwWHNINGhSUFVjWCtQYUpoLzhHMk5KUy9JaFhSTjV4Nnd3?=
 =?utf-8?B?RXRJc2FQT1RoNFNDYjcrVVoyTWJBM0NlTXlzbTdEaUIrYUdTQy81VU1sSEhW?=
 =?utf-8?B?VzV4SDNIcVdJbHB4aFczWEVUM2JNcElsNmdvdXp6MHFZSmFzdXhtNm5iQVJ0?=
 =?utf-8?B?WUhJaWU4Y2FqNmZsOUVXZ1BVcGxGYlljbHlxek1lV3A0VnRHWFp4U0dXOEc5?=
 =?utf-8?B?aVI5L3Z2d1FaNFBDVGMyb2VTS0VwWFZYQ2pTNzQzQWovMmJtcWtyWVZGTlZN?=
 =?utf-8?B?RDlPR2NBdGlONnlnNy82NENBK0gzbThQTnZjZEk1NHk2aUNTU1B5UXpGNFhT?=
 =?utf-8?B?VWF4eTVUMkUyTmRod1Rhb0hIZ1JWZk1CM3hKbytrRm9tZnZnWCtpUklQdkxJ?=
 =?utf-8?B?aG9hSmtjT0s4QmR4N1ZsMDJld0NiVTBQOTJqOWJtTEdQQUVuWHBiRXFXWmJD?=
 =?utf-8?B?bHBVZ01ISW83c2QvYjRKbDVvdmloOTQzL2V3QVRjMUo3WDdkdDRCUFNnMFh4?=
 =?utf-8?B?dTJHY3JpMG5KSk9pVTJYWDRST0xycEpXS1lBZmxQYmdNZ2U1N3RTTjdERGVB?=
 =?utf-8?B?dVQxUmc3cE5qWEpEdVpYZFBVR2VONUZZNFRGdWRoUC9oRnd1VmRVU1N0NTNj?=
 =?utf-8?Q?yVXSxfM66jNWXyH9eCRE12puoGTzxpLDoRvSg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmU3Q0tLTmR5bWJGSGs2aC9sUURwM3NMMFUwbmc3dmlYSU1KRzQ3WU1ReWZo?=
 =?utf-8?B?Q1k1VjYvcWpONTFaWml0QXRQK09yOXNlcFlFOTEyd1JvaGx6YjI3Vnp4ZUZV?=
 =?utf-8?B?SjNwdjhTWEFVSlNINVdKNUpaRXhkL2UrbnpYRDl5YUpEL05OZ2s1RTNuUUFp?=
 =?utf-8?B?K2t0NjFyVm1sYVQzR2p1Nlp1N2FlclEyNWxMT1BrSit1OG1pUGFmYkZUbkJQ?=
 =?utf-8?B?aHpKWHZ2K0VrRUY4Q0p4OUdvUFRqUHMvbTlvU0IwSkdrQStiR0luSk9EbXhX?=
 =?utf-8?B?OUJlKzArSkV2elBiOHpvcG4vdHFKVlg1clJZTU9Jc2lzdE9JZS80NHMxaXhw?=
 =?utf-8?B?VW5xUVRrVUNscHNCT01GVFI1RU9sRG41VjFhLzhGbFZqK0lTWmdRSmQ0UFgx?=
 =?utf-8?B?ek9ad2RURmFzMmorZkJhMmVXbDBZeXdFVnRtejgwQnRmRTJ1V0RuV3B1MmlK?=
 =?utf-8?B?cGpNR3phWTdyTzNDR1RCTjVaWUZ6TDl0eWhwdUIwbDlZZHJWS2hCcUUzdDZV?=
 =?utf-8?B?aGVzRmJkZHArdHpIT2VUR2paK213eG1FaVBXRjJOVXpBc0JjRGZKNEtnQ0tt?=
 =?utf-8?B?STg2M3NQU2UvSHcyV2IwWXlQbjgzbm5VdUt5L1I4UlBCOTA2QmhFNktGYmds?=
 =?utf-8?B?anpVRitseDRENkZWVXRZeDJjL1RSL2tUZGRQTkoyeit5ei9iTzF6T3Q1WVUr?=
 =?utf-8?B?Nk9KU0tnVXNOcUs0Q1llMFM0YmxtSHF5MjR2aWdSWndXbU1UNjVES1hrMlRl?=
 =?utf-8?B?YkNGOUppTWJBWUpMM2laelcyTHdzSVlSeG1JcWtTR3lEcWhpYTRsSUt4WGww?=
 =?utf-8?B?ZVpCYjJodW92cFM3Y2xDcHJDdFN1UVhacTBGREFZL2ZjSFB5VkdHRCthYWFH?=
 =?utf-8?B?emJFVmIyZzFybWpmV3lVU2tLSG8wenVDYWUydlFZMVNKZ3JlTURKUG1wWGta?=
 =?utf-8?B?ZGdveCs4M2VOR3VFaEg3aFd6REszdTU4N1lPMjNWSzl5Q3krc3VMZ0c5QURa?=
 =?utf-8?B?U1BzRFh3M3Fkb29SR3l1eFpSL3I5eE1BOTBRcVkrbklJbndaL0JTTWRpVkdx?=
 =?utf-8?B?d3k3VVJYMUF6dG8wUzY0Z0ZxK0E0WFJtVDY4cUFnTWViTjRlTjA5N1Y3d2M1?=
 =?utf-8?B?T2RhMGQ4VVpQSjVVNTZlRlVIK0x6SHlPVzQ4OThuU0Q5QlNyNVFGZDZJcWNR?=
 =?utf-8?B?d1drOHo5TkFNTGZhK0ttM2pQcFpKdkFmME1pNUtuQWdTV0U1RFg3U0xraEdP?=
 =?utf-8?B?QmpCUzduZVdQazhwNndQS0Fvc09naVFFNjBqeVdONDhXWkNVeU5qNkVEaG1B?=
 =?utf-8?B?b2ZHQlZmZDJxbWszYm1oNnhuUTVaanN0NitqS2xIV3ZPSTdhaU5laWRtOTFm?=
 =?utf-8?B?azVneDVib1YxUTBzRjdWV2NYNmhLR2ZBVXMrU2dqOGI0UkJDVm1IVG1pQllq?=
 =?utf-8?B?QXZURERmNHJ2VzRtSDAzNmpoK1YwaHJWbEZxQjk3UGI0cFljZzgzbXBuelhO?=
 =?utf-8?B?TlZZUnlNeTQ3d3hmeVJTbzl0a0U1M3FkNmYweWdRSnRlQlJQN3NOcXErN2lN?=
 =?utf-8?B?Q2NmaEpoT0FjZmFUSWpNbnV2ZklxUDY1bmkyNTQ2bGZBSHVhaHVqUmcrUEV6?=
 =?utf-8?B?U2lOaXoxR0RHTmFZdnhBTTRlM3RzUlowV1hSTm1zeDNpZFVRYjBtZjNrdkZJ?=
 =?utf-8?B?bGZYakRaR3ROa1RyQzR6LzZxYnZCNFJ6VHhwWGRiNmhLZG9ockJQWmY5WHZo?=
 =?utf-8?B?M1REY291RDN2eWZwaEMrK3ZYKzZtQUtQQ0JCMTBDdWk2NWhCWUdDVTJ0QWc3?=
 =?utf-8?B?M3djd1JpRWVoZXNxTXVMZEFGVTg0WkRXS0tZaWF2cVlNeGdsQlVOM2tHSXpL?=
 =?utf-8?B?bEVzVUFNQjV4V2w1YlZmZHNRV0R4QUo4YjhSa21DU2hJT0Nrakk4L2VLdmsy?=
 =?utf-8?B?c3dQdHFHQnZjdjZQT0ZtVGhzMDBBL0pvRTk4WTZ3SkJUT0gzeUZValE3Nzlp?=
 =?utf-8?B?UC80cS9yajA4UnJPanRxUklhNi96QVZ6N0tQdUZNUHRRb25EVys2bnpNRXZm?=
 =?utf-8?B?bUQrcFZ3cFdQK1NpaktwcXBUZkhneVkyMXFYNUpMZlkyVWpKUisrMk4ydzJ6?=
 =?utf-8?Q?1jDIPkYU1NMS8AvQJl0dOmgOk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <174224D1FD8FF04F9E89FC0F0431A21C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6764f393-ae66-4895-5f3f-08dc8c382172
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 06:06:28.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDPpdBPZEYQef6TbI+BpBHKyz3Pr2+LFSwjYW1ykt+6Z8nrqlx1XmtPitqUkDLVrr7t8MBTRjXINgsFy84a/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8014

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEwOjQ2ICswODAwLCBTaGF3biBTdW5nIHdyb3RlOg0KPiBG
cm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IENP
TlNUX0JMRCBtdXN0IGJlIGVuYWJsZWQgZm9yIFhSR0IgZm9ybWF0cyBhbHRob3VnaCB0aGUgYWxw
aGEgY2hhbm5lbA0KPiBjYW4gYmUgaWdub3JlZCwgb3IgT1ZMIHdpbGwgc3RpbGwgcmVhZCB0aGUg
dmFsdWUgZnJvbSBtZW1vcnkuDQo+IFRoaXMgZXJyb3Igb25seSBhZmZlY3RzIENSQyBnZW5lcmF0
aW9uLg0KPiANCj4gRml4ZXM6IGM0MTBmYTliMDdjMyAoImRybS9tZWRpYXRlazogQWRkIEFGQkMg
c3VwcG9ydCB0byBNZWRpYXRlayBEUk0gZHJpdmVyIikNCg0KRml4ZXM6IDExOWY1MTczNjI4YSAo
ImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1lZGlhdGVrIFNvQyBNVDgxNzMuIikN
Cg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrP2g9djYuMTAt
cmMzJmlkPTExOWY1MTczNjI4YWE3YTBjM2NmOWRiODM0NjBkNDA3MDllODI0MWQNCg0KUmVnYXJk
cywNCkNLDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5n
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMgfCAxNCArKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jDQo+IGluZGV4IDk0NmI4N2VjNDhjYS4uZmQzOTBmYjgzZDBlIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC0zOCw2ICszOCw3
IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSF9NU0IobikJCSgweDAwNDAgKyAweDIw
ICogKG4pKQ0KPiAgI2RlZmluZSBPVkxfUElUQ0hfTVNCXzJORF9TVUJCVUYJCQlCSVQoMTYpDQo+
ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSChuKQkJCSgweDAwNDQgKyAweDIwICogKG4pKQ0K
PiArI2RlZmluZSBPVkxfQ09OU1RfQkxFTkQJCQkJCUJJVCgyOCkNCj4gICNkZWZpbmUgRElTUF9S
RUdfT1ZMX1JETUFfQ1RSTChuKQkJKDB4MDBjMCArIDB4MjAgKiAobikpDQo+ICAjZGVmaW5lIERJ
U1BfUkVHX09WTF9SRE1BX0dNQyhuKQkJKDB4MDBjOCArIDB4MjAgKiAobikpDQo+ICAjZGVmaW5l
IERJU1BfUkVHX09WTF9BRERSX01UMjcwMQkJMHgwMDQwDQo+IEBAIC00MjgsNiArNDI5LDcgQEAg
dm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGlu
dCBpZHgsDQo+ICAJdW5zaWduZWQgaW50IGZtdCA9IHBlbmRpbmctPmZvcm1hdDsNCj4gIAl1bnNp
Z25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnkgPDwgMTYpIHwgcGVuZGluZy0+eDsNCj4gIAl1
bnNpZ25lZCBpbnQgc3JjX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IDw8IDE2KSB8IHBlbmRpbmct
PndpZHRoOw0KPiArCXVuc2lnbmVkIGludCBpZ25vcmVfcGl4ZWxfYWxwaGEgPSAwOw0KPiAgCXVu
c2lnbmVkIGludCBjb247DQo+ICAJYm9vbCBpc19hZmJjID0gcGVuZGluZy0+bW9kaWZpZXIgIT0g
RFJNX0ZPUk1BVF9NT0RfTElORUFSOw0KPiAgCXVuaW9uIG92ZXJsYXlfcGl0Y2ggew0KPiBAQCAt
NDQ5LDYgKzQ1MSwxNCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUt
PmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiAgCQljb24gfD0gT1ZMX0NPTl9BRU4gfCBP
VkxfQ09OX0FMUEhBOw0KPiAgDQo+ICsJLyogQ09OU1RfQkxEIG11c3QgYmUgZW5hYmxlZCBmb3Ig
WFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBjaGFubmVsDQo+ICsJICogY2FuIGJlIGln
bm9yZWQsIG9yIE9WTCB3aWxsIHN0aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVtb3J5Lg0KPiAr
CSAqIEZvciBSR0I4ODggcmVsYXRlZCBmb3JtYXRzLCB3aGV0aGVyIENPTlNUX0JMRCBpcyBlbmFi
bGVkIG9yIG5vdCB3b24ndA0KPiArCSAqIGFmZmVjdCB0aGUgcmVzdWx0LiBUaGVyZWZvcmUgd2Ug
dXNlICFoYXNfYWxwaGEgYXMgdGhlIGNvbmRpdGlvbi4NCj4gKwkgKi8NCj4gKwlpZiAoc3RhdGUt
PmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gKwkJaWdu
b3JlX3BpeGVsX2FscGhhID0gT1ZMX0NPTlNUX0JMRU5EOw0KPiArDQo+ICAJaWYgKHBlbmRpbmct
PnJvdGF0aW9uICYgRFJNX01PREVfUkVGTEVDVF9ZKSB7DQo+ICAJCWNvbiB8PSBPVkxfQ09OX1ZJ
UlRfRkxJUDsNCj4gIAkJYWRkciArPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkgKiBwZW5kaW5nLT5w
aXRjaDsNCj4gQEAgLTQ2NCw4ICs0NzQsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0
cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIA0KPiAgCW10a19kZHBfd3Jp
dGVfcmVsYXhlZChjbWRxX3BrdCwgY29uLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiAg
CQkJICAgICAgRElTUF9SRUdfT1ZMX0NPTihpZHgpKTsNCj4gLQltdGtfZGRwX3dyaXRlX3JlbGF4
ZWQoY21kcV9wa3QsIG92ZXJsYXlfcGl0Y2guc3BsaXRfcGl0Y2gubHNiLCAmb3ZsLT5jbWRxX3Jl
Zywgb3ZsLT5yZWdzLA0KPiAtCQkJICAgICAgRElTUF9SRUdfT1ZMX1BJVENIKGlkeCkpOw0KPiAr
CW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb3ZlcmxheV9waXRjaC5zcGxpdF9waXRj
aC5sc2IgfCBpZ25vcmVfcGl4ZWxfYWxwaGEsDQo+ICsJCQkgICAgICAmb3ZsLT5jbWRxX3JlZywg
b3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUElUQ0goaWR4KSk7DQo+ICAJbXRrX2RkcF93cml0ZV9y
ZWxheGVkKGNtZHFfcGt0LCBzcmNfc2l6ZSwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4g
IAkJCSAgICAgIERJU1BfUkVHX09WTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtfZGRwX3dyaXRl
X3JlbGF4ZWQoY21kcV9wa3QsIG9mZnNldCwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCg==

