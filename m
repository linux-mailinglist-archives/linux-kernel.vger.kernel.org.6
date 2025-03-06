Return-Path: <linux-kernel+bounces-548936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5CA54B25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0B93A990A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8F208966;
	Thu,  6 Mar 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WNm3XHSv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cq/WgJ0Q"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939F2E3370;
	Thu,  6 Mar 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265159; cv=fail; b=KKKCSDw9Tne9XfbTXnrFgP404d+abiX6hPHjlfAqA8d4JNbcSV+FNORFpiaMteh2qRed7SuOwGKs75uvf2l80DqiTile4VqPjHq5lGf+0NhnmsTv3QRXefo6gjxn99hR3CdSIAv+lo2LgJheeovA7FWYPIXA00zbAfT5frTJcD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265159; c=relaxed/simple;
	bh=iLGHSHCBCCAdSslWU95fQDJHgFFB743rcnGaK5RaWVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iXoFJ36aiBNPuVyxfp+SnGu7e/o4ddRz4p3EDXl7xf0ByqhBVW+RH4FRSJdDB0AWkdwIpPM0LfZPoFKpkIJsSCouKQg92wq+94jU37W0CH8A//ojhoOBFEXc77jj6zaRP7m4grHWGDN1z0cGmkApKUg74wK3g8TnVVRUHj/oth4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WNm3XHSv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cq/WgJ0Q; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f0d5dbd4fa8811efaae1fd9735fae912-20250306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iLGHSHCBCCAdSslWU95fQDJHgFFB743rcnGaK5RaWVc=;
	b=WNm3XHSvWqfaA5KhIbiYKOOxofaCnMFmajdbhrxG+BDhXz2Mo92Zq3PO09KYheKl3nXKEd1JYJB4phVrnj1dBJheJGhiRkldtDGXDtBA3qYu9sA9iOx4B+E8QHRHt1j/1PtnadecDKHgklUoqY6aV5qhZ6bYooQo+B9lmoFEvOU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:adf0cb04-d231-4533-bd10-681e0ccfe063,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:1f31098c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f0d5dbd4fa8811efaae1fd9735fae912-20250306
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1639215305; Thu, 06 Mar 2025 20:45:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Mar 2025 20:45:52 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 6 Mar 2025 20:45:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqZi3TpQiRalluKi7q0vM/Zt87UFGlO8XwUkKnM+HNyp90iFRkjYgx5vXwD/EBKkIhHG2ttz1KzEfwVShXt+DJv5ngsAntkObPYIxRcBCQQMbNCDUvzj6yrbi30nUiIlBw5ZxU4NIA5lJfiRxDFkFzicaj4MV+jpB11/o9QjN3nAKPyKaFpRhgOLrF/KW8z4KGHhqKg6hqmmnqjZ8i0+jhPn6RVUuUd2MQ++KuuJUShxYCkD7H2VTstTVdgHYpdN5lacG1/dmyd6nFLMq4vXa3ejXbDbDgobI0e2/82kziVP0HnHcEbtUyRmbhSDM0/4/cex0paTHz8TedgQBmVdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLGHSHCBCCAdSslWU95fQDJHgFFB743rcnGaK5RaWVc=;
 b=RVlRHtOBGP1BRQLcb0wsP1W+ATxIVYHq0BB5xdkPD8oMeWnAkGcGJwVlr9E8RQ8TuPWkGdcUob0yQsdkaS6hmklSuVFpZPXgZ2iCBu1VQePCWR6iGuzzPTmmWAshKcbzhtScgyWLcTW3HZE3zmpJlD4zM4kkSaCmZpCCFByxKizmoCC8WkQrGZatW3fj8Z4pzikIiXxX3M4WnXUPEZq+sHGXrI6NNS9baOOpC7wJQYshTaWNEvsuWDaefr5bHMhmf8EP7QhntYG9QFOcSz2TV81tbh9odDav7UNrNqyEI1AUZpqAaBM2/HCcq1YEk35sKKPoW8sUh509z3SZHuEp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLGHSHCBCCAdSslWU95fQDJHgFFB743rcnGaK5RaWVc=;
 b=cq/WgJ0Q64QXeELcWjVqhdXpvWPo6LtdwVOjaavRdm2YBM27xiUwybsYZ8MqypUJ95YV2YBJU1pg1niT1YHiJuUjvscxM6euSADwBF7Qgfxe0GL8RfCCzliqXi5L6Nj1yIDFsMWJOUwWRCF47ebpmZHSy57U767pgJ2YQ6VX4So=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB7599.apcprd03.prod.outlook.com (2603:1096:820:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 12:45:49 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 12:45:48 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Topic: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Index: AQHbhDU04J68TaDqUUGrlWTkL0+oIbNWJ1CAgA/7o4A=
Date: Thu, 6 Mar 2025 12:45:48 +0000
Message-ID: <264f78c1067e363c69e146543ebb77dbedfbd181.camel@mediatek.com>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
	 <20250221074846.14105-2-friday.yang@mediatek.com>
	 <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
In-Reply-To: <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB7599:EE_
x-ms-office365-filtering-correlation-id: 7267dfba-1403-407b-7db5-08dd5cacd22d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|13003099007;
x-microsoft-antispam-message-info: =?utf-8?B?bVJJWGpkYzhVTy9ydFN2alh1M3NNV2d4TlA1WVpmZmdvMWNBUFRWL1BDcXF1?=
 =?utf-8?B?U0dhd1BrQlBLbk9ITGVlb1d6cGcyRGxBY0o5aDBTTFhTZnRWYXh0UllSOWEw?=
 =?utf-8?B?RTNvZS9LR1VGRFFXOEx4YlVmTlhzMFNQSmlGUURKZmQ2U3pMTmM4OFlZZ2lK?=
 =?utf-8?B?OVNjZVlNUmRhZDRXbHlIdjRkazhQYVU1MTlJYWUrakpsUnZVS3JyZHFPTUQx?=
 =?utf-8?B?SUxDcVVZWDk5M3hyUHFTUXNHY09XSlJOdUQxanVhWEJqMy92YmVza0RaUVll?=
 =?utf-8?B?SWpuWWFreXRyMGx3ek1NcHc0a1VlWUdpWTlkenBTaWZsd3dwVlNDa2Uvc1B1?=
 =?utf-8?B?NWZ3TTgrNytuZ2kwQVNpQ0p4TFRGYU5WR2JRNHlSbXN6TjJFSXByN1dOTnZ1?=
 =?utf-8?B?SFRsY1ptcjJKSGZGK3NTcWRpSkQ4M3h3TXorN05VbGJZdlpYdlRHWlVtNk1u?=
 =?utf-8?B?MEFlbjZJZ1FlWm43SS9iUkcvYlNPWVE1ZmEyYkE5NTBEMUNoTFFuSDFaMWVn?=
 =?utf-8?B?RklYUS9nc3djRW5CYTVBOUpwd2RlRGNsbTlTVmh1R0VmR3NqMDNHMTZVcWdL?=
 =?utf-8?B?cWhZNnFSa2w2elFjNmo1bDZMZ2hLRHNOYlYwbGk2cFE5QWsySkJtMlcvYmRN?=
 =?utf-8?B?L0VRQXA1bVpvMExCNUpnSm01Q2xZbWoxcXRSWDlXQ1c3cFRQTnA2ZXVzV0s2?=
 =?utf-8?B?TTcxKzkvRDNKQmRvTnhlK3p3WjZ0RENUWUNCSTZIOGhUYnJvekVqdU9JM2pr?=
 =?utf-8?B?c2tuS2lHWnY1QmVUQ2twUmRxRzc3TFBzalowRGxhVFdGZHhrZTBIWlIwY05u?=
 =?utf-8?B?SzlmS0RRVDlwbUJpT3dLcEdUdzJGbURrUEtHYU55UHdNSnQwZkVFUWNvcEJs?=
 =?utf-8?B?VVVGcDY1RzRSQmxCd0pCaUdvOGFGNFJUQ1IzUXBoTzkzVXVlTXhXdWxlZy9R?=
 =?utf-8?B?bkJVZHZLQzBsQzJyMmh2MitUSDR1R0ZYUmJYOUdqeENVWHFiTnE3bEFIb2xl?=
 =?utf-8?B?SGJJbmdUTFdNT1ByK3Ryd0FNWThsR0RHS1RlQnlIR2dNcEZpU0RpcjluT3Ur?=
 =?utf-8?B?ZVpQZUErWFFuMmdWRWRzcEx3aW0xTzBHd2QzU0ZxOWlBSFc5RFBJRGpBNG03?=
 =?utf-8?B?a3BRQ2R4TUZuZHR5NzBzNmRyN3YwV1Erd2N4aWNBcCtLdXlTMnp3WXhPaE5l?=
 =?utf-8?B?a1huMUdyOXFtYzl5UWVxVkxhSmpkSTkvSVE4dzFZQVdFeUVmY1picTJyMTFG?=
 =?utf-8?B?L3dTcDA4RWllV1NMaS9IRFdtYkVmTEhJekFoanJDVm4zQ1FGaTFhV3o4ODNy?=
 =?utf-8?B?MkwxWjRWYWd1bHVyN09NWFhJWkR0TDJqYVB4cTIvYUpkNXFOVFA1NldQa2dh?=
 =?utf-8?B?dTlNL0ZIM09vQ21nY1h0WmdrK2xVTk9XUGJzdFJTRnNxaTFyU2VmWlY3REdK?=
 =?utf-8?B?OWk0ejhtL2d5Y2R2bThNUjB2ekRMZnpUWThSVC9wd2JBaXdZZ1VTeG5mZGVH?=
 =?utf-8?B?WnJFekxXVDBybGRhd0d5UCtMV1YwSGlqWnRJa29jQi9BQ0JqWVF1VzNLWkdG?=
 =?utf-8?B?Q2UvRHlvWlBjWGpaQkVGdmtuMElhZk5rMUZaVThESEkvVTFyMHhXemJvbXU5?=
 =?utf-8?B?UlpSRXovSk5CZTVDQUlFN0l6NXVBcDRrQTZWODRlWEl5dFNyVFAraG5xMXVx?=
 =?utf-8?B?UCtPaDk5QUFyYWtGdDZVeElxMjM1VWg5VVFHZWtKdXJNWWZ6a0xTRjdMZTFF?=
 =?utf-8?B?Y2tjUnYvQWs4VHJITkZ6eE43WDgyNVVmSWtjYm52Z011Ynd4VTE4RVpEdFpr?=
 =?utf-8?B?bStoQS9vT0oxUG13TmlJZkRNOFAvdzJOQXpLNWxEZ3Nsb011K1FzeVF0cGdH?=
 =?utf-8?B?UE1aZlFEZnltcU16Tmlrb2xFZ3ZjcFVNOWNCTi9LS1E2UXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3d0RWFBQ3hXTzJPa0drNml0L1BxMm15d0FndVRJSW1aRHBNeS93OFhDMVdE?=
 =?utf-8?B?QzlPaENKamdNaWlscCt0dTZqb2ZDZTVKYjdhSFprblA1MmRJT1JoOXJXWjRp?=
 =?utf-8?B?QmV4cWVxcWV4UDdJWGxXVHVPUFh1ak8xS3cySFpFMWpxVWxrT0JjQTlWZnhW?=
 =?utf-8?B?MGYycWZlS2t3ZWp1eWJWb0JtL01lbFhYMUpXVDk2NXI4ZDVwNGUwS3dybUZR?=
 =?utf-8?B?Y2ZWU2RmL0R6MlFyTDMzcHdhcDh3bGNRT25BNm5lRm1jejVkMFJxL2Y3TE9n?=
 =?utf-8?B?QVdLM0h5c0JBWVphRzBXWlZVekwwS08vM1FLYVZPZjcxeEJxTWM4K01FVUJR?=
 =?utf-8?B?YlpGQW9ML2R6SmVBbUdJR0hCTmJEWTZ1dlByODdSUHV3eUNvNGpwdjEzVGRq?=
 =?utf-8?B?bVJkWDRpdjI2K1FWS2Rqa0h6cUZwa0VoNVFVRTJ5RmRLN2FhMHIyY0UyeGJw?=
 =?utf-8?B?UEQxaksrcEJUb0hDSmxEU2dDQk1TVHE4SXBLMHNjNFo1Y3RFc05YbmxxeTBE?=
 =?utf-8?B?RGhrYU03eUQ0R3Y5d1pjNWZrRWd1SEdvdmdRR3JlK3V2TXZRK2FXSDg2QkY4?=
 =?utf-8?B?RW14eHl1RUFUamNQMVExSllpeFZIOTRrblIyVWF3dkp3eGVNdW9WM1NjQTFU?=
 =?utf-8?B?NDF4RzZSTnp3TEQycDVVMmpRN0JFeFpOdElGTlRIejErNXpWZzREeWwvd1lQ?=
 =?utf-8?B?NEtwNklCZ1gwQ0RtUHM4YnVxcmxhK0tJaHNJT2t2VUl0TnlKWWhsc0tkWHli?=
 =?utf-8?B?bHkwdmRlRzNJbTQ3Tm9ld2poVzNuVE0wZGZsTUJWbGVkZ1FhS3h6Q1lrL2V4?=
 =?utf-8?B?bWRJK3ZXZ2JiUmhxc0g0MktSTjN1UkNTcU1xeGViMWloMHlhNitnVTF0R2xy?=
 =?utf-8?B?WjdtSVkyQkNQM3BteldkZWZGZklsK1FIVnlPWldZM1VCOVQrS3Z1UWlCLytq?=
 =?utf-8?B?V2Z5VVFjRVVmbDRqR1kyNzYwSmpxUWc2NUZBMHFoRzd5MVl2ZzZocWViTE9v?=
 =?utf-8?B?QUxTa28xdXhpOC8zU1NKdi9yT0FXekZlbTg1RkhwbCtIMEVubFBpSEpCRTlP?=
 =?utf-8?B?OUsyRHBsSFc1T0RmZXM2U3ZKUHNXMFlRb0VSc29DZEtPNis2aGNqZmNUQ3Ra?=
 =?utf-8?B?WWlMZ0Y4VGVrYXJsbXVNYml3dlZXZDcxSCszU3BOZUc1M0QrYUVyWUY1S1RN?=
 =?utf-8?B?MHplcmN0Mm8wY3FWMGZ0c3ltQ3pFa0pTalViRUU3SFNJSytxd0c2Tm5nTHl4?=
 =?utf-8?B?MW0xd2c4eWtqLzREUW91QnJRUFRVQnk1WGdEUVphazloN1R3Rjc3TlBvcXRn?=
 =?utf-8?B?TVVNSjUvTEtBSkVaOWhHZ2k4Y3hvMVA4aU1sVG5BL1FhakxyTHdSU3JsT1h3?=
 =?utf-8?B?WFR4UldvZGlzYkFJb2w5dHdrcEtuV043RkliaVVLZkJEUC9BTnNFdDJjMnZO?=
 =?utf-8?B?cVdRMHczeEFpNG5pcTBYU0lmZnVvWENldmNuUkg3UDMwY1ZGWk1DMDNVd3c4?=
 =?utf-8?B?RmNrdC8wdGlTWDlPZUFQeElJTXA1T3o3RDRHUU1LbVNORFFPdndmTXQxSEU5?=
 =?utf-8?B?Y1RrdDJPWkRhckk5RkdCbXpRSjZYbEVpbzhsQU9rNFlaTWl4cE9Cc1lXSlFU?=
 =?utf-8?B?ako0dnh0MUp6Rm9KeVVNNG5wc0lxSEwyMWgyZVNnWWpBczhVTGphNXdIaDAx?=
 =?utf-8?B?d1BPQzYzRTZSaHAwYzBOMkM2cW5RQVZqQllwcThGcmVoWUpUQzNYUTdNNWEr?=
 =?utf-8?B?cDNQVjNPd3ZSN3hzQWdpdlNVV3ROZWJRMEdmRjVmOS9DRWRGWnZoOXRDRk1a?=
 =?utf-8?B?a1NROXFJekpJRXJzT25nSERoRnQ0enllanh2WjhEQlRjZXJpZ1ZJYlJPUnhx?=
 =?utf-8?B?bTk4MnJQaG1WeFhRZkg5OWFtTkRRM3ZPS3RDQkNxR3QyeFltSjQxanZTMSta?=
 =?utf-8?B?MzFqQVB0dksvRjRvbC9EV3VsWDVBVnk4RGs2NVppckxNTXcyNnhzYk0wSXJI?=
 =?utf-8?B?Rm9GeXkxOGtMSG16Wmd2TS9BTnFFN0lMN2U4Tkh4V1RLN2xnY0hhV0dOWGlU?=
 =?utf-8?B?OVNLbHdCWUV1NW1nazFacllTdnVsVVpBOUZHS2kyM05oYnl2OFl4Q0NETnlH?=
 =?utf-8?B?K2VkL1NOM1V0Nkh2RWphczVtbC9CM1ExNU9MV05rK3MyQU45cnlTU0hGSkRs?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AEB7194F6BE9A438990F8F27CDE88F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7267dfba-1403-407b-7db5-08dd5cacd22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 12:45:48.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLUuYpVOQz5Qbd3PdIet7BXWyyclf7iB/mW5Mkc+fVLPJQicrMIYXOc/gMhcdc+h2qu17brpiA3mCr21mk9LIsRDDk4PbN8mEytHFYf5i4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7599

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDA5OjQxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyMS8wMi8yNSAwODo0OCwgRnJpZGF5IFlh
bmcgaGEgc2NyaXR0bzoNCj4gPiBGcm9tOiAiRnJpZGF5IFlhbmciIDxmcmlkYXkueWFuZ0BtZWRp
YXRlay5jb20+DQo+ID4gDQo+ID4gT24gdGhlIE1lZGlhVGVrIHBsYXRmb3JtLCBzb21lIFNNSSBM
QVJCcyBhcmUgZGlyZWN0bHkgY29ubmVjdGVkIHRvDQo+ID4gdGhlIFNNSSBDb21tb24sIHdoaWxl
IG90aGVycyBhcmUgY29ubmVjdGVkIHRvIHRoZSBTTUkgU3ViLUNvbW1vbiwNCj4gPiB3aGljaCBp
biB0dXJuIGlzIGNvbm5lY3RlZCB0byB0aGUgU01JIENvbW1vbi4gVGhlIGhhcmR3YXJlIGJsb2Nr
DQo+ID4gZGlhZ3JhbSBjYW4gYmUgZGVzY3JpYmVkIGFzIGZvbGxvd3MuDQo+ID4gDQo+ID4gICAg
ICAgICAgICAgICBTTUktQ29tbW9uKFNtYXJ0IE11bHRpbWVkaWEgSW50ZXJmYWNlIENvbW1vbikN
Cj4gPiAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICB8DQo+ID4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgIHwNCj4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgfA0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8
DQo+ID4gICAgICAgICBsYXJiMCAgICAgICBTTUktU3ViLUNvbW1vbjAgICAgIFNNSS1TdWItQ29t
bW9uMQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgfCAgICAgIHwgICAgIHwgICAgICB8ICAgICAg
ICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgbGFyYjEgIGxhcmIyIGxhcmIzICBsYXJi
NyAgICAgICBsYXJiOQ0KPiA+IA0KPiA+IEZvciBwcmV2aW91cyBkaXNjdXNzaW9uIG9uIHRoZSBk
aXJlY3Rpb24gb2YgdGhlIGNvZGUgbW9kaWZpY2F0aW9ucywNCj4gPiBwbGVhc2UgcmVmZXIgdG86
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkdyZDlxWmhPYlFYdm0yX2FicWFY
ODN4TUxxeGpRRVRCMj0NCj4gPiB3WHBvYkRXVTFDbnZrQUBtYWlsLmdtYWlsLmNvbS8NCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FQRHlLRnBva1hWMmdKRGdvd2JpeFR2T0hfNVZM
M0I1SDhleQ0KPiA+IGhQK0tKNUZhc20yckZnQG1haWwuZ21haWwuY29tLw0KPiA+IA0KPiA+IE9u
IHRoZSBNZWRpYVRlayBNVDgxODggU29DIHBsYXRmb3JtLCB3ZSBlbmNvdW50ZXJlZCBwb3dlci1v
ZmYNCj4gPiBmYWlsdXJlcw0KPiA+IGFuZCBTTUkgYnVzIGhhbmcgaXNzdWVzIGR1cmluZyBjYW1l
cmEgc3RyZXNzIHRlc3RzLiBUaGUgaXNzdWUNCj4gPiBhcmlzZXMNCj4gPiBiZWNhdXNlIGJ1cyBn
bGl0Y2hlcyBhcmUgc29tZXRpbWVzIHByb2R1Y2VkIHdoZW4gTVRDTU9TIHBvd2VycyBvbg0KPiA+
IG9yDQo+ID4gb2ZmLiBXaGlsZSB0aGlzIGlzIGZhaXJseSBub3JtYWwsIHRoZSBzb2Z0d2FyZSBt
dXN0IGhhbmRsZSB0aGVzZQ0KPiA+IGdsaXRjaGVzIHRvIGF2b2lkIG1pc3Rha2luZyB0aGVtIGZv
ciB0cmFuc2FjdGlvbiBzaWduYWxzLiBXaGF0J3MNCj4gPiBtb3JlLCB0aGlzIGlzc3VlIGVtZXJn
ZWQgb25seSBhZnRlciB0aGUgaW5pdGlhbCB1cHN0cmVhbWluZyBvZiB0aGlzDQo+ID4gYmluZGlu
Zy4gV2l0aG91dCB0aGVzZSBwYXRjaGVzLCB0aGUgU01JIGJlY29tZXMgdW5zdGFibGUgZHVyaW5n
DQo+ID4gY2FtZXJhDQo+ID4gc3RyZXNzIHRlc3RzLg0KPiA+IA0KPiA+IFRoZSBzb2Z0d2FyZSBz
b2x1dGlvbnMgY2FuIGJlIHN1bW1hcml6ZWQgYXMgZm9sbG93czoNCj4gPiANCj4gPiAxLiBVc2Ug
Q0xBTVAgdG8gZGlzYWJsZSB0aGUgU01JIHN1Yi1jb21tb24gcG9ydCBhZnRlciB0dXJuaW5nIG9m
Zg0KPiA+IHRoZQ0KPiA+ICAgICBMQVJCIENHIGFuZCBiZWZvcmUgdHVybmluZyBvZmYgdGhlIExB
UkIgTVRDTU9TLg0KPiA+IDIuIFVzZSBDTEFNUCB0byBkaXNhYmxlL2VuYWJsZSB0aGUgU01JIHN1
Yi1jb21tb24gcG9ydC4NCj4gPiAzLiBJbXBsZW1lbnQgYW4gQVhJIHJlc2V0IGZvciBTTUkgTEFS
QnMuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBwcmltYXJpbHkgYWRkIHR3byBjaGFuZ2VzOg0KPiA+
IDEuIEFkZCBjb21wYXRpYmxlIGZvciBTTUkgc3ViLWNvbW1vbiBvbiBNVDgxODggU29DLg0KPiA+
IDIuIEFkZCAncmVzZXRzJyBhbmQgJ3Jlc2V0LW5hbWVzJyBwcm9wZXJ0aWVzIGZvciBTTUkgTEFS
QnMgdG8NCj4gPiAgICAgc3VwcG9ydCBTTUkgcmVzZXQgb3BlcmF0aW9ucy4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgLi4uL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbCAgICAgICAgICAgICAgICAg
IHwgIDIgKysNCj4gPiAgIC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIu
eWFtbCB8IDIwDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21p
LWNvbW1vbi55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVt
b3J5LQ0KPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KPiA+IGluZGV4
IDJmMzZhYzIzNjA0Yy4uNDM5MmQzNDk4NzhjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWss
c21pLWNvbW1vbi55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4g
PiBAQCAtMzksNiArMzksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTg2LXNtaS1jb21tb24NCj4gPiAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1z
bWktY29tbW9uLXZkbw0KPiA+ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21t
b24tdnBwDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWktc3ViLWNvbW1vbg0K
PiA+ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNtaS1jb21tb24NCj4gPiAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE5NS1zbWktY29tbW9uLXZkbw0KPiA+ICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTk1LXNtaS1jb21tb24tdnBwDQo+ID4gQEAgLTEwNyw2ICsxMDgsNyBAQCBh
bGxPZjoNCj4gPiAgICAgICAgICAgY29tcGF0aWJsZToNCj4gPiAgICAgICAgICAgICBjb250YWlu
czoNCj4gPiAgICAgICAgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxODgtc21pLXN1Yi1jb21tb24NCj4gPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTUtc21pLXN1Yi1jb21tb24NCj4gPiAgICAgICB0aGVuOg0KPiA+ICAgICAgICAgcmVxdWly
ZWQ6DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9t
ZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4gaW5kZXggMjM4MTY2MGIzMjRjLi4yZTg2YmIzNDU1
ZjkgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVy
cy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4gQEAgLTY5LDYgKzY5LDEyIEBAIHByb3BlcnRp
ZXM6DQo+ID4gICAgICAgZGVzY3JpcHRpb246IHRoZSBoYXJkd2FyZSBpZCBvZiB0aGlzIGxhcmIu
IEl0J3Mgb25seSByZXF1aXJlZA0KPiA+IHdoZW4gdGhpcw0KPiA+ICAgICAgICAgaGFyZHdhcmUg
aWQgaXMgbm90IGNvbnNlY3V0aXZlIGZyb20gaXRzIE00VSBwb2ludCBvZiB2aWV3Lg0KPiA+IA0K
PiA+ICsgIHJlc2V0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHJlc2V0
LW5hbWVzOg0KPiA+ICsgICAgY29uc3Q6IGxhcmINCj4gPiArDQo+ID4gICByZXF1aXJlZDoNCj4g
PiAgICAgLSBjb21wYXRpYmxlDQo+ID4gICAgIC0gcmVnDQo+ID4gQEAgLTEyNSw2ICsxMzEsMjAg
QEAgYWxsT2Y6DQo+ID4gICAgICAgICByZXF1aXJlZDoNCj4gPiAgICAgICAgICAgLSBtZWRpYXRl
ayxsYXJiLWlkDQo+ID4gDQo+ID4gKyAgLSBpZjogICMgb25seSBmb3IgaW1hZ2UsIGNhbWVyYSBh
bmQgaXBlIHN1YnN5cw0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBh
dGlibGU6DQo+ID4gKyAgICAgICAgICBjb25zdDogbWVkaWF0ZWssbXQ4MTg4LXNtaS1sYXJiDQo+
ID4gKyAgICAgICAgbWVkaWF0ZWssbGFyYi1pZDoNCj4gPiArICAgICAgICAgIG9uZU9mOg0KPiAN
Cj4gQXJlIHlvdSByZWFsbHkgc3VyZSB0aGF0IHlvdSBuZWVkICdvbmVPZicgaGVyZT8gOi0pDQo+
IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg0KWWVzLCBJIGhhdmUgdGVzdGVkIGl0LiBJZiBJIHRy
eSB0byBtb2RpZnkgdGhlICdleGFtcGxlcycNCmxpa2UgdGhpcy4gVGhhdCBpczoNCiAgY2hhbmdl
IHRoZSBjb21wYXRpYmxlIHRvICJtZWRpYXRlayxtdDgxODgtc21pLWxhcmIiLA0KICBhZGQgJ21l
ZGlhdGVrLGxhcmItaWQgPSA8MTA+OycNCg0KZXhhbXBsZXM6DQogIC0gfCsNCiAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTczLWNsay5oPg0KICAgICNpbmNsdWQNCmUgPGR0LWJp
bmRpbmdzL3Bvd2VyL210ODE3My1wb3dlci5oPg0KDQogICAgbGFyYjE6IGxhcmJAMTYwMTAwMDAg
ew0KICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtc21pLWxhcmIiOw0KICAgICAg
cmVnID0gPDB4MTYwMTAwMDAgMHgxMDAwPjsNCiAgICAgIG1lZGlhdGVrLHNtaSA9IDwmc21pX2Nv
bW1vbj47DQogICAgICBtZWRpYXRlayxsYXJiLWlkID0gPDEwPjsNCiAgICAgIHBvd2VyLWRvbWFp
bnMgPSA8JnNjcHN5cyBNVDgxODhfUE9XRVJfRE9NQUlOX1ZERUM+Ow0KICAgICAgY2xvY2tzID0g
PCZ2ZGVjc3lzIENMS19WREVDX0NLRU4+LA0KICAgICAgICAgICAgICAgPCZ2ZGVjc3lzIENMS19W
REVDX0xBUkJfQ0tFTj47DQogICAgICBjbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIjsNCiAgICB9
Ow0KDQpUaGUgJ2R0X2JpbmRpbmdfY2hlY2snIGNvdWxkIGdpdmUgdGhlIGZvbGxvd2luZw0KZXJy
b3JzOg0KDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xs
ZXJzL21lZGlhdGVrLHNtaS0NCmxhcmIuZXhhbXBsZS5kdGI6IGxhcmJAMTYwMTAwMDA6ICdyZXNl
dHMnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCmZyb20gc2NoZW1hICRpZDogDQpodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIu
eWFtbCMNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxl
cnMvbWVkaWF0ZWssc21pLQ0KbGFyYi5leGFtcGxlLmR0YjogbGFyYkAxNjAxMDAwMDogJ3Jlc2V0
LW5hbWVzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQpmcm9tIHNjaGVtYSAkaWQ6ICANCmh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWkt
bGFyYi55YW1sIw0KDQpBbmQgdGhpcyBpcyB3aGF0IEkgd2FudCB0byBhY2hpZXZlLiBPbiB0aGUg
TWVkaWFUZWsgTVQ4MTg4IFNvQw0KcGxhdGZvcm0sICdyZXNldHMnIGFuZCAncmVzZXQtbmFtZXMn
IGFyZSBvbmx5IHJlcXVpcmVkIGZvciBTTUkgTEFSQnMNCmxvY2F0ZWQgaW4gaW1hZ2UsIGNhbWVy
YSBhbmQgaXBlIHN1YnN5cy4gT3RoZXJzIGNhbiBiZSBpZ25vcmVkLiBBbmQgdGhlDQonbGFyYi1p
ZCcgb2YgdGhlc2UgU01JIExBUkJzIGFyZSBzaG93biBpbiB0aGlzIGFycmF5OiBbIDksIDEwLCAx
MSwgMTIsDQoxMywgMTYsIDE3LCAxOCwgMTksIDIwIF0uDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8g
bGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGRvdWJ0cy4NCg0KPiANCj4gPiArICAgICAgICAg
ICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgICAgWyA5LCAxMCwgMTEsIDEyLCAxMywgMTYs
IDE3LCAxOCwgMTksIDIwIF0NCj4gPiArDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICByZXF1
aXJlZDoNCj4gPiArICAgICAgICAtIHJlc2V0cw0KPiA+ICsgICAgICAgIC0gcmVzZXQtbmFtZXMN
Cj4gPiArDQo+ID4gICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiANCj4gPiAgIGV4
YW1wbGVzOg0KPiA+IC0tDQo+ID4gMi40Ni4wDQo+ID4gDQo+IA0KPiANCj4gDQo=

