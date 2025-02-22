Return-Path: <linux-kernel+bounces-527032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490EA40674
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4618019C3FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF2066EB;
	Sat, 22 Feb 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IeEcnAkM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RMOorXoQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1A1FFC65;
	Sat, 22 Feb 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213914; cv=fail; b=SuX2jYak7atpY7dj/PyyhNXINnGO5+hC7o73mex+H7FP/EykMieDdvhGRWsMZbfYtVTrhFpuf6CxBCXVXgzyWJuDK/QkG2IkWHTf+6ig8Mv2jttBTHc1tTb1TlpS0+eE5EKA0yfkWMxDBMM3evAMn6P5gqlOZfTpkwMqBePn8Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213914; c=relaxed/simple;
	bh=LPD4jhGaPrQFU8O6VgMWeck+sts+3IgiczWO0a7PwhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/SPs4Udaf+Kux/tDczqwAcvpLBWO2G1FEI0VcFe95yE+YDAgw2zUhasdNvdwPLKb/Ngg62GRr1aA2TV8zlTAszVQZTkwtcWMb3pCZx1p7wvkuy0Pd5rY9XRGVlBSJwtteZO7ZW5x2oIZdr7atzwaDNqk295K6D2jGviI3/uTqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IeEcnAkM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RMOorXoQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 50c7d2f2f0f911ef8eb9c36241bbb6fb-20250222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LPD4jhGaPrQFU8O6VgMWeck+sts+3IgiczWO0a7PwhM=;
	b=IeEcnAkMK0NlcPIzb+z0Czq9w18/wpP1rOSCAyazq+Wje1xbVx48AcSphB88tJUKZnNK90QcdyumrMgPh1dVe1+lel6Og9V0Q8fLmwelcPt07UIUS8i1Zx+yA81tHx8tFcJKajsUuJ2hKtSI2rfUKwSfaOVarp3cfE6unwgvBmw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:f6eb3866-9150-44ff-b36f-6d613aad8e18,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:edab32dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 50c7d2f2f0f911ef8eb9c36241bbb6fb-20250222
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1028578142; Sat, 22 Feb 2025 16:45:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 22 Feb 2025 16:45:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 22 Feb 2025 16:45:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpTbMuv6CedKNpDRR6LvWp8rVjKviqLrhZFmuBRHeerX4PKEq+28pzNflDcU+a1H2oa5p61cn6ccdx+rrYqQ7xDdeuPDWWBn3RKWOBCR/9Ag+uyQTywKtE+GNhzMhT7jamKY3Lma1PIgkoTp6d7MdgvMemU5Vqu9RVkyCOE2tcmWA3MES4ZSv/vdf0S9x82nIE+F2NYDtxtzj41WB5WGshbDR8fTSxF7JJiAv8iVebgC3LkPzYQ7QgzLFJHSNyj6/nd5fPXBzC04E1ZDwjrB6OHQHOzXGp/wO1RPMbTsX7ao5Zr6Le22XJUXQKRIRqKEeQeUVipPDI2unOEL+AglPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPD4jhGaPrQFU8O6VgMWeck+sts+3IgiczWO0a7PwhM=;
 b=TGezjeG50DijJQ6ye+opRKwBS4hfgQpUrhwqLovtIAgklRcKllzv1gSmsh5Ykt3NJze2QIx8jvaCG+SOMoFwB6mh0n070QzFZNLgpqamhrWuaMSO9350O8cICvPhzQObhwJFtb15feVN2X9OdSjN/polKbWc9SIBZgcE6oXYE09w7457kx2q/FGYCBofWCW3jiOTD6qYqV6auJifNSvC5+gB6uQJN8S8waV/CWbRzovHlEjFRO15S0ZTWvQzjy8eX3liNv/MleMaPgBwnwt8/5AsP8TU8mRr0iG9mSuTDQVl0CHRsZfcdZzjA6/pG4yp0+ZY+NFpalPWqw7nY+zdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPD4jhGaPrQFU8O6VgMWeck+sts+3IgiczWO0a7PwhM=;
 b=RMOorXoQq2IHpdC2V4N+BWVK/BJULWnGvCxxw4Faa/60V97bDD85F/qAX65hncvLJlXUX8VvuVMXNRGN8vhWsSH/EliJhfRsKFnCu+TbyE1eQo/uMMOlK9oXBTMz8xqaYBXp0b2DTTJ1m9clRpuTNL1a4mWIzCMFZCONpe0nHZo=
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13)
 by JH0PR03MB7596.apcprd03.prod.outlook.com (2603:1096:990:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 08:45:03 +0000
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6]) by PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6%7]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:45:03 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
Thread-Topic: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
Thread-Index: AQHbg4YRzp0sDx+K3kCO8xuWnMXsprNTBRMA
Date: Sat, 22 Feb 2025 08:45:03 +0000
Message-ID: <790ebe87fdaa8d785813a46269036562c405fb01.camel@mediatek.com>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6236:EE_|JH0PR03MB7596:EE_
x-ms-office365-filtering-correlation-id: a09d2ba8-5ea9-4923-b776-08dd531d3301
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXd1Wks2SXZIMUN0QjBrRlFxZmxVVHhuTEZIQ0RVb3ovakJRUVk1ZHZQaFZX?=
 =?utf-8?B?NmdmSURNY3Q3aHdySkViYXpDK1pjT1ltK2tUZnpaM010WG9jQ3pIamU3S3Bn?=
 =?utf-8?B?UTduM1VzRWlFK0lBQXgreUYzcCsyVVI4RjV3L3NSbzVDZHZGSlY2aGE1TUox?=
 =?utf-8?B?WUV1QUZrVGNrOVhZYU9xUmZIOVlmaW1WUXZhdWd2MDlwQk1lWWtzcHl4Q1FI?=
 =?utf-8?B?bmVQZCtQcndzb04xRDR1NWFaK3JvQ2M1MUNWRVFIQkJYWGZ3TXBjdjVrTWJ3?=
 =?utf-8?B?eHEwUWlTNHRHTE1ZYlhNeE9CRmJldGJpeWREYnEyd2d3YVRIczhpeFVSSTJo?=
 =?utf-8?B?ajRzWk5YRnZ2dHNNb2lLbWFnZWRMUGVKZ1VhU1hXaHljbHltQlpNd0lKNHp6?=
 =?utf-8?B?Y2NISzN5c01xZzVlWUdCZ25Wenpnd3FlK3EwMEhDNVE1UjlLMktyNUcybVRs?=
 =?utf-8?B?eGNPa2NVYVBqY3hGZU9qM1R6SGtrOGF1OC93eUJSYnlDWHZSLzVmVnhPekhQ?=
 =?utf-8?B?YnRnQ3IxVmVyeUs2VlE1R05YK2FQeFRLR1ptOEp5YlhZaG5mMU90UktEb1Y1?=
 =?utf-8?B?bmJSbmZhdjRCWXd0ZnhMTEV3VVF2czBsRVF0VUNwSmNVODRIRmF5dW5CeVF5?=
 =?utf-8?B?RWRCODRnYVZLZk1sOWJTYTh5VFJtNi96c3dxdFk5cmxNL1NFN1ViWVkyWkVk?=
 =?utf-8?B?d2txWW1LaDMxQW1HOURMYldkNHBqOW55em5keHVpc0ZPQzhVdHNzTkg3eWNz?=
 =?utf-8?B?NmZ1UFUzRVViNXRvOFhBU3VPZjhYZjI3eTI0OWdZTWoxamRrRkg1d21ka05p?=
 =?utf-8?B?Ui93cjNZaGdOQ0tiNkxsMG1IT2tJSFpTYVBDOC9XVmFkWmpNTzVSS2RGWTdq?=
 =?utf-8?B?SzQ1OWVORi9FeSt0NFUwVytsL0sxV3RZVVphZEFrVEtsdkdZWmRpTGk2UXpD?=
 =?utf-8?B?VnJoSEFtVWVNWTlqbDhISUlYWmFJVUZ1UnJCWXhsQTdPNU1ndldYanpSajcr?=
 =?utf-8?B?MGJkT0NjWUtGbmZFUDZhcE03cDREb1JwTEdRRjRhbW0rS0ExcHBrYWJCd2kv?=
 =?utf-8?B?a01TdzNHTDZRT3pucXNVNytGVnBpc2o4Wk4xc29RbDFteGEvQWc0bDEzcW1L?=
 =?utf-8?B?ZGlnTUR4NTBLREppT2tXcGNDZkF2cjBPR2FBa05MT1VVd01kM0orbDcza3FE?=
 =?utf-8?B?dVorU3BPSGZaejJvck8yN0J4bWJESTVUQjZHM0t4cHV3RzlaUXFEazUrU3U4?=
 =?utf-8?B?RklnSklZY2NWS2V3ZEozQit5L2t3Y2VObllnaUI4MWp6TW5VNTZ3QXRXT25N?=
 =?utf-8?B?c01BWGlQZWNjWVFNVUd3VTJXMS9sczBHaE9adE5mcGp6d2Z3blc0anJFeVZx?=
 =?utf-8?B?UHNKVHlCUzh4b2MyLzFnRjZTbWVmaGtvZVNwdEZId0tScTh1RDZCSm5HbE5n?=
 =?utf-8?B?U2Q1aDk2azFrQzRaZ2VaVVBFeWx1Mlg0NnhHRmtPOUtzc2pYUGxLbUpNK09y?=
 =?utf-8?B?TlRQSVVFUXpDV01wUzZNQ1pOdTM5T0srYWcxSjBoZVJVQ1g3QityeUN2dVE5?=
 =?utf-8?B?UVd4dEdRQlg1eFdjclZQYkZCZWgyRDJ2UFNEQUd0VkdCL0ZtaCtQQ0EwYzFo?=
 =?utf-8?B?TXpmMmdEbUFzd3pRTkZTY0MwcVVYdHZScm1CZXNCS2Zvc2JmTG9LMnpFOVZw?=
 =?utf-8?B?WENvUTNIc0FPSjhLcjBSN0RsS29obkZicmpld0RzVGFIVnczMW9iMEl2VytC?=
 =?utf-8?B?UlRFdDRnU2tDUnFSYVVFMk1RaTFQMUNRZ1pwdG9LSjVXNzBLb3lrbUYxWGZQ?=
 =?utf-8?B?T1F3MlQ4ZXk0V2NxWFprNjBqbnRCellPb1ZUbUh1STVWRnNlS25CWGJyUUdm?=
 =?utf-8?B?Vm11SFFuWDNTNVRPVmF6c0ZDSzdITXlUYWdUM2FWQ1RSS1Z6L3B2Tk1LRWNk?=
 =?utf-8?Q?U0P2XjHvoFeuyNkAOXk0z1gtE6I1vg05?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6236.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0NVdWJVOSs1QTREOGFlZUEzZG1QOFVjWTZSa3p0WnhISjJOK3N3ZVBuU0VI?=
 =?utf-8?B?blpSRC9zbi84VXNpbXdib21HR04ybVYybkl3VEdDc2FtZW9BUU9WWmNxR2wv?=
 =?utf-8?B?Tld2TFlmbFJFSE9VaUlQdVZpVEFEd3ZwM29jRC9YbDFabVpZRWZmalU4SERZ?=
 =?utf-8?B?dnM0bzBqTVlhU2tVcktTeHgzclRaUjhGQnNWS0dmcjhLWkEzRFdXd1M0SHMz?=
 =?utf-8?B?RnUvTTBybWJEMXN5OXZhbVhNamNacTFDNHRQQkJGTDdSeVpRanN0MUo3RDBr?=
 =?utf-8?B?WU5TOTN4TVlUZ2s2VzZOSWZ1Nmw1ZFlaeDMyZjFSVGpRT0kxdjMzY2tIVEtT?=
 =?utf-8?B?Slg4d1hrZ293YlIyY0pmUHBWRjFBSXJ0ZE1sd0NjZU1Kb0hUUFVITXRKVHRP?=
 =?utf-8?B?NjZnQm1iUzE1d2xpT1NGN1QzY0JFTmM1ZEk1M1BUa2VIQklFQXJqSTc0angr?=
 =?utf-8?B?WVVoRi9Oa3hnVklZdmFqd09mY0I0OUwrQVVVMzVNdnJOSWlENTR3eU5JSHlL?=
 =?utf-8?B?S2RoUGhjZTNxWEZ6aC8xL0JxYy9DeHVzM1FSVW5jVEJod000ZDNpbnJDRDVn?=
 =?utf-8?B?dkRSeEFKS1FFTkFZNjlWY1p3azluSUlFWWtDN0VoNGtMdHNEdTNFcnRHN3dV?=
 =?utf-8?B?QW10MU1pa0ltaTdKb1BhRFFiR2hYQzdEbnQ5OWlFR2xiTCtjRDQzdjlyUE95?=
 =?utf-8?B?MG5BWjlhdmtwRzhrY3J4ejNtY3pBaUpGMHNrenF4dEc5Q3pCTVRSZW1pVzMr?=
 =?utf-8?B?TVp3ME5IQjlBUjJFQXF2MzJKUEZxTk9oQ3lqRXFTVTludDFCVjM5VlNGTkZE?=
 =?utf-8?B?NUJVTDBpcjRhVEFESjNYSjdOTU1ZMmlDSXdkWHc4Q2JDczRNcmtoLyttZ2xD?=
 =?utf-8?B?SWdlWjRDd0tPbDJsck9yTFNJamFQaXZhNzRFVkN0S2lYWmorSkdXbUdaY3hO?=
 =?utf-8?B?eUNUdDNEWXFIMW9YTmcvR3lBRDY0T2xRVWVzNkRJbEFkbHZZNlBXcGN5SllE?=
 =?utf-8?B?bTFtYi9udzVVNktaSUFnMFZ5a0c5QTI1VHdFeUFaMDdrNDNQVjBqWU1rTzZi?=
 =?utf-8?B?TFFyTGNXdkZEZmR1RlZGMmlvMVhPTyt0R0tkUUJGMngvSHl5RHRHcGt5ekNw?=
 =?utf-8?B?QnkvUFgzWW5kYW5GcWVWZGl3WmxXWUhnUG5yUkw1b3h4aGhUb3J6WXpMYlFl?=
 =?utf-8?B?b1I3U3BqbmFTOUFOeDQvajFoRGYwVjV4S2Y1K2FTQ29KUW5kdzNTZTFsWEVU?=
 =?utf-8?B?Smd3djJaejdVMnVKKy9BMDAwenpaV0MyN2xQWmw5YkoxRU9HNjROR1gwaE5q?=
 =?utf-8?B?c1V2R2dNeUd4aVI1eXg3c2xuRFNXczNQdjRDY3RpRFNLeUNvUUI4S2NkZDRn?=
 =?utf-8?B?dVQ0bFVsWW9xT3JKSFFyODhFcDEvN2NDa0hEcTNpT3JkVER5cjRNWWpiOHVy?=
 =?utf-8?B?b29uTWNPcUFmTER4WFZwWTkwZy9rdzg1Z3phQ2xSZWNMZmNUUmwwMWIyQ3dI?=
 =?utf-8?B?Z2ZIb0o1Y1NPQVBXcTVCRVc3RllXVXNaOEZESmwrcHUxQ2hJYVNqd2tFS1VZ?=
 =?utf-8?B?UmZxbGdJblhOUXJhY1FxUDhyVmVTQ3lEWEJ3TmZNMnUrSlRFRzVtR1hCK0p2?=
 =?utf-8?B?Nk82VTkvUUI4SWFCNy85MmxPeDgyRHVNdDUzMW9JVlA5SHVJeDQvVHc5YVRU?=
 =?utf-8?B?SVEwY1UzOUcvMjBMeThBTnk0TUYwQmFSc2x5ZkhTcGVkdlZPUGZGUzRJOEZl?=
 =?utf-8?B?WXVZdHBqZGgwdk9KRzAzdnlDa1dkL3RoWW1PTHIzUWpSRkplR2RTQ0tMZStY?=
 =?utf-8?B?VlBhTEdxVWNPK3lOOFkyYWdHSmVmb0lRakQ4bjhhSGdOM2xBQTU3WjJhOTJk?=
 =?utf-8?B?Y0t2bDVlWHU5Tnpmb0hTYmFLa1IzeEsvaTBMWXFnLy9IK3ZMcXROMCtweDNJ?=
 =?utf-8?B?MTZkL1doS3NqRVY0clFlYWtzdnNzcEpoeTR0d0Ixam54YnRMeXJ2WHRibWNX?=
 =?utf-8?B?MVhEQk5iZEhFRTZ1bS9ORWxQS0t2bHFtZU02QWhNSjJkLzVFQzduc0doZHFV?=
 =?utf-8?B?aGQ2Z0wzTE9vZ0tkN2VtL1YzcEJLL1RqUGE1OHkvNXJzdUFIWEZkNkxhOXdP?=
 =?utf-8?B?cXZNUzdZSXRjbDZMQkx6czhkaDB0dVZSUFdrNU5QTkEwb01IMXZCaGM4QkRI?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38265BC14859A74185E4904756B63A31@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6236.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09d2ba8-5ea9-4923-b776-08dd531d3301
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:45:03.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSyC7I8vUiacV3XylODtuk4Qq0Jyv32vzi81wCzk0Wcz+VFvusNj0N4wZY4vGOUfQ+KI9tCwX84JNY8WrFiwydNtnqYSbr8C9iCpuXVdg4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7596
X-MTK: N

SGkgQW5nZWxvDQpPbiBUaHUsIDIwMjUtMDItMjAgYXQgMTE6NTUgKzAxMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmll
ZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMg
TVRVMyBub2RlcyB0byB0aGUgTVQ4MTg4IGJhc2UgZGV2aWNldHJlZSwgZml4ZXMgdGhlDQo+IEdl
cmFsdCBDaHJvbWVib29rcyB0byB1c2UgaXQsIGFuZCBhZGRzIHN1cHBvcnQgZm9yIGFsbCBvZiB0
aGUgVVNCDQo+IHBvcnRzLCBpbmNsdWRpbmcgVHlwZUMgUG93ZXIgRGVsaXZlcnksIEFsdGVybmF0
ZSBNb2RlcywgZXRjLCBmb3VuZA0KPiBvbiB0aGUgTWVkaWFUZWsgR2VuaW8gNTEwIGFuZCBHZW5p
byA3MDAgRXZhbHVhdGlvbiBLaXRzLg0KPiANCj4gVGhpcyBhbHNvIGFkZHMgdGhlIG1pc3Npbmcg
U3VwZXJTcGVlZCBwb3J0IHRvIHRoZSBtdGsteGhjaSBiaW5kaW5nLg0KPiANCj4gQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gKDMpOg0KPiAgIGR0LWJpbmRpbmdzOiB1c2I6IG1lZGlhdGVrLG10
ay14aGNpOiBBZGQgcG9ydCBmb3IgU3VwZXJTcGVlZCBFUA0KPiAgIGFybTY0OiBkdHM6IG1lZGlh
dGVrOiBtdDgxODg6IEFkZCBNVFUzIG5vZGVzIGFuZCBjb3JyZWN0bHkgZGVzY3JpYmUNCj4gICAg
IFVTQg0KPiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBtdDgzOTAtZ2VuaW8tNzAwOiBBZGQgVVNC
LCBUeXBlQyBDb250cm9sbGVyLA0KPiBNVVgNCj4gDQo+ICAuLi4vYmluZGluZ3MvdXNiL21lZGlh
dGVrLG10ay14aGNpLnlhbWwgICAgICAgfCAgIDQgKw0KPiAgLi4uL2Jvb3QvZHRzL21lZGlhdGVr
L210ODE4OC1nZXJhbHQuZHRzaSAgICAgIHwgIDE4ICsrKw0KPiAgYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODguZHRzaSAgICAgIHwgMTIxICsrKysrKysrKy0tLS0tDQo+ICAuLi4v
ZHRzL21lZGlhdGVrL210ODM5MC1nZW5pby1jb21tb24uZHRzaSAgICAgfCAxNTENCj4gKysrKysr
KysrKysrKysrKystDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI1MSBpbnNlcnRpb25zKCspLCA0MyBk
ZWxldGlvbnMoLSkNCkRvIHRoZXNlIHBhdGNoIGhhdmUgYWxzbyBjaGFuZ2VkIHRoZSBjaHJvbWVi
b29rJ3MgZHRzPw0KDQppZiBjaGFuZ2VkIGl0LCBkbyB0ZXN0IGl0IG9uIGNocm9tZWJvb2s/DQoN
ClRoYW5rcw0KDQoNCj4gDQo+IC0tDQo+IDIuNDguMQ0KPiANCg==

