Return-Path: <linux-kernel+bounces-194314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07A8D39F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9371C21F99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FDE15ADAA;
	Wed, 29 May 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mu++JHJt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iC+6b2wt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353117DE13;
	Wed, 29 May 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994154; cv=fail; b=QJANvbFvBEJAk9pdPii8xSiZ1LRJnKo0AKs35CR8BpFMZs0KtkwDrmRW6kykQFGkvnZ5IrllkvkJkIMhF3W3Fn5wyth17t6sB2l+IbSrlTiiYNpBjgeY637wkyuemU+LkaGGWmsETaKapkYnyKyWhR5dr02dSpkImiGtj257MA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994154; c=relaxed/simple;
	bh=QK089/vRTbxPkJL7I31xwfZhPOF+kdicELX2MfsD4HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DeWIbFvTbPEuXc5S6u9Oftk4zHE9d7/JOTYDd2H5TA78lWSgI2WpRABOEtWIdj+HdEFBIKBbDv6vUQ2M+GcTggfuHNpH9+tllCSnTSGsW7O55HScqXYFrXYT5JzjeW4jbbo35dULuBL+MXECIMQbldALHlDjIkMVzOsMiZYqZwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mu++JHJt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iC+6b2wt; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99e316161dca11ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QK089/vRTbxPkJL7I31xwfZhPOF+kdicELX2MfsD4HA=;
	b=mu++JHJtq6AQQopUAOhOtUaKYrrAdn0AcLOtBbFH6l0OYGEQRRL0bxJgzZXqiok9SlJ/Jtf0y50XDdR4s6QF9GkZv1bdzalggivdmzWNwPQLN8XrEUmSFjDlpIjIXqojSRgHvPGtZxo2WT64sQGHFFMdSfhD9ZDlq2KpYdOY4/s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:74ed5698-58fa-450c-91ba-6efbb112d238,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:875cf543-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 99e316161dca11ef8c37dd7afa272265-20240529
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 255148765; Wed, 29 May 2024 22:49:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 22:49:06 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 22:49:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4fO0/rJCsNB8PEa+8R5aa5vwNQwgSckZjCKg+lKuvBhCDTgGsvIpiQnUscICvC9oo/r9MPMJ1lZafMnGbu1lg1th2OgbiugHcjJRoopHr6ymxV1kBFTZlhxfcrgb7DNYF71Pfjl5iMElvqK4vsk7X/Xgz+yfaq9GvYtsQsuGa/YBaJXW+vWbwM20OkSdy6yJjdp7onsboj/V3LFF4CJMFLI/B2noGBpM2ozeruZLqwarJVwT+WV3qV2mc92953iiZ4r8gSJgAE2te2Cjz9ZoghuS8Wat2LaeOmz6n0XAJCXQC+imZrFYkKS7Cv8HkEFqf+59k0OkpJ1NZAcmU8U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK089/vRTbxPkJL7I31xwfZhPOF+kdicELX2MfsD4HA=;
 b=IsdoCzqUoNySGXlGjG50G9ZpnOT2yoh58+V46Qm/MjRQBxiQEZDPUcj6J/rZ8srtmalJxkXW36D/jv/P0N180iImoumrDN0ObHwhBlNyt/BqsrSkzGSQbGoTyDhwqm4klAiL89s1nHCNBCUACtA+xY/WxVxnolsT9RerXSeHry5L1mqmHYbMGWZu5sCbKiAVh8hPwnbRpNZmEAAOwupgdNIjw6Mczy1m8yDDj838jp95a67Kw/Dhiyo2M7v4lKb5azhuZd3LxIj7ArMaAusX3X5C0vSfTXwijzfPXCy0A1xWgicLMO8QyYw51Wg71j42HO3Vp1zpyO3y3cdqI/95Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK089/vRTbxPkJL7I31xwfZhPOF+kdicELX2MfsD4HA=;
 b=iC+6b2wtFAycmKS3qrD+8NbiVFupaXIJq3BH89qp+CJjLJvjiyD97Lua4cvod4C4Mp05DnHQ8RRtzao7WM8gXKfHflWeQ1//VrxR+q8KfRrcENsXvXWL2Hin/9K+tpNZIlLw1GQFZSZFlC3B63VtnxTC3/Z8JGlq92tOEPLw9wo=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7879.apcprd03.prod.outlook.com (2603:1096:990:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Wed, 29 May
 2024 14:49:04 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 14:49:04 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND,v6 8/8] soc: mediatek: mtk-cmdq: Add secure
 cmdq_pkt APIs
Thread-Topic: [PATCH RESEND,v6 8/8] soc: mediatek: mtk-cmdq: Add secure
 cmdq_pkt APIs
Thread-Index: AQHar3tfI4StAhxEi0CN3KPsYLIClbGr95IAgADSGoCAAK7SgIAA1z2A
Date: Wed, 29 May 2024 14:49:04 +0000
Message-ID: <4ad87d6caf7788de5cfae82d5bdfa3ddd2040745.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-9-jason-jh.lin@mediatek.com>
	 <98b5d60e0ca29e6ac126035c1594c8b0d0210aba.camel@mediatek.com>
	 <6141715c6f17ff5bb39460d87b88f93785a613a8.camel@mediatek.com>
	 <9959dc856288b30698c8990695b2ad50376dd21f.camel@mediatek.com>
In-Reply-To: <9959dc856288b30698c8990695b2ad50376dd21f.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7879:EE_
x-ms-office365-filtering-correlation-id: e7595217-9973-4ba8-4776-08dc7fee7c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Qzk3TEVZaEdzYW96bFF2SEQ2bFViNXcrekZwRkcyajgxYjhjZkpFQ0JIZmlw?=
 =?utf-8?B?U1U1Z3FUbXF0K28vZ2doeXh1YnQra0NNbTZXaVBJcmhDQ003WUJ2QmQ0Nm1S?=
 =?utf-8?B?Yk5NYjlBRXAwdFV3cCtCVFplamFNVkg2Nmd1dktvMzl2bHdURUNSSVFkTjIv?=
 =?utf-8?B?clZ1NWxzemVaV0FiYmNody9RbUtzc1cyN3U2QXBRbkRKK0ZTTUZ3bCs1ODBI?=
 =?utf-8?B?MkVxTlorMmhrb3JUUVQ5byt1dXNRVExqdWRYSXdkVncyQ0FwTEZodndBV0dw?=
 =?utf-8?B?YVJUeFZSWVRGN01JMHNoYndSaVJNOUhTUy92Z2lRWDMyaWZRRFQwVUNIMUJv?=
 =?utf-8?B?VDJDKzN2dlBDSjB3QlpyM0VuZGtMb3o0T29nQ0d4WlBpNXB1bnJUditESU5I?=
 =?utf-8?B?L1RqWEV1d0NSNCtIYnJVYnNxV3E4dHEyVzZOQ1M2OHpiUWdiZFdFdVY2b2c3?=
 =?utf-8?B?TmJhSTI2V1V6cE5yS0pZd25MNzJaMVFxYVdESXJyNm1ocTFjMFVVeWF2aG1t?=
 =?utf-8?B?Y3JhSFJaMy9LZUNJWnVYNzRFVG9LckI4N1FwTHM5OGwvZWUxcTZueEZXU3dZ?=
 =?utf-8?B?LzdlaEVrTWFtdUk1d3BGcC9kTDVNclhTOHlEWHV5VndGbWlCcTZxNzVJVmNJ?=
 =?utf-8?B?b0FGM0owTmFQMCsrSkEyZmZ3UHN0SnM3SFN1aERRUzlhcCt0RUhGWEtxbERH?=
 =?utf-8?B?NUxZVjhrKzJRdkN0M0lkTFpwaWpVNFd5Vm9ZVmtQV2hicWZ5R0NIbDlrbmhD?=
 =?utf-8?B?Y0pMb2loTnpETGMrRjQ3bmNRUEFPKzkxTDlJeFFCQ2YxWko0QlV5Zmd5aTBP?=
 =?utf-8?B?Mkd1NGNGT20xR1dRTnM4a1dzWEJ2Z3V3VWdPNmQ2eU8zQzBOQlM1RWpFS21t?=
 =?utf-8?B?cFhRR01NUUVuQ3RkbmlzR1UvQXBNclZXZTlQcHJ5TCtWaEY2NUhGc2l4THRm?=
 =?utf-8?B?K2FPQUUrM3dtN3hoT2h2M01lY1VRTVRwZjZzaEFnNXNIWXgwaUtaWEFLYmJW?=
 =?utf-8?B?L1Yzc0N4NEpTREdVUFlPOWlGWEhiSWYzYUpqM1F2ck5CdktHOC9ZQ0FZOEdt?=
 =?utf-8?B?VGhaWXF5UHd3b01HOStWdTdwNDc2aU90b2kyeG1ma2ZyTHBoMHpvMmlkb3Yy?=
 =?utf-8?B?K2lYcnE5b1hjdTdVM044NnROS3BQZkpYQi9PTGZQVWpiaU12aGdVT0hlUi85?=
 =?utf-8?B?SzZ4cFE0Z0RXTFBJRUtid2tqVXZVWTZoc1F2ekw2UUZVdjg2OHpSU05sSkVS?=
 =?utf-8?B?a0hQUTd0NmVLSkdmdHFYQnBvQXJqTWdISXRSQUdyZVo0cEVxL3VhdkU2RVBN?=
 =?utf-8?B?aFdaT3dGb1pseG01RXFCcGlsOHF4NFg0OWV1U1doSmkzT1BCNXVxSlJMU3dy?=
 =?utf-8?B?K25ZYW56RWJDajF6N1FCK3J0NTVqQUR3Zi9reFEyRVArdmtKTTlSRVRHN3lx?=
 =?utf-8?B?ekFtSEVJVTFkeWpMYktZUURJa2pkY1dUUnlVWnZidVJCR0dGVWtsNlpTOW8x?=
 =?utf-8?B?TDRCTmxZRHNsREdwTjd0VUQ2MUFHb1Z3eW9MNFZIWnIrWmE3Q1dvcTNUMmtE?=
 =?utf-8?B?alkyaGJvSFFCK1pqakdoZWJNTHdncXJNMStWUndUbnNneGEySXdoTjh6OWF3?=
 =?utf-8?B?S3VUZlIrQVJva0pVUlJkOHV2SHpnb3Q3Q0RCR2pJcENWWlA5V3c0WGdWUUw1?=
 =?utf-8?B?YmxhNXF5ZVhFWjF6eGpIU0wvQ0xnV3ZsckFieG1rRDg5NzBzaVNTZ0xSSnRi?=
 =?utf-8?B?cGdPc0ExbHhlTmNVYnYwaElkUTJCRmF4WkxJV2JqNE9BNmp2aVh3dXBEZ1Ax?=
 =?utf-8?B?K1ZUdHJvRGVEM1FvRDlBZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjB3SjdBanNPMHk2bXFvVEplNWdLdDRxcjRDS0YzQUxOUDFrKytHTVJoMTQ4?=
 =?utf-8?B?eEQ3bUZlSnNlQUlwcGVyNnZGcUpNbFgzd3h3VGpWSVhJbWVYcUtkMWRYa2Ft?=
 =?utf-8?B?clVpMFo1b29DQjIySjk0ci9WM3ZZU3pJUzBNcXduTVVWcjZGWXVlYi8rUmIx?=
 =?utf-8?B?YXgvRmg4QzZOakkxMHpLdE1RTTlqTDVmL3RHT0dRdmhOeVl5dUI2dXpKK3Ax?=
 =?utf-8?B?amUxekIrSGx1NjN1cndYQkVuQ1B0bjdXU2NEdzVySUI3cHhCejZlMlVqTWtq?=
 =?utf-8?B?ZHZjekUzK0lvc1JSdGk0MW5RNHV3Z3JyL0Y2YStzSFZaLzhxRFdoTVNSVEN5?=
 =?utf-8?B?VUk5Rzc0NVpFYm1Ic010ek1UVXczWEV1ZVRBZU5CR0dueElTTXN5aXZVblVI?=
 =?utf-8?B?S1FFVjNuSDFrNndLbTFPczI0czlQc1JBckdrbWMzNlFSbjVRZkhRZkRSOU9T?=
 =?utf-8?B?WTI2SEs4RDVsQThIRjRxb25MSmZtcDJaWENBYVJHWHhyVUpQclhEVFAwK0hE?=
 =?utf-8?B?VC9mNFQ5U2tMQ0FCUkg1T2ZHL3JFQk1QdGcxbFgzMjdQK1dSSWk1c0g1SkNP?=
 =?utf-8?B?NzRaekJVK0tpUGZEdVZyQkd6YWRZMlZBSFMrcXYxWEYxNzdmWU81aGx5MytH?=
 =?utf-8?B?L0dxUUtqbG9zWEVKMkxneDlEdGJxY2h6WkIyUDRYZ0lVMlJ0a05KaUxXRnE4?=
 =?utf-8?B?TWdpZ0xINURiQ0FTclBwWkNqOEtwL3RSalVUYlpEN0FqREcvdGE3TFNGQmxM?=
 =?utf-8?B?UlhxNEpDT2ZidFI5MHJLeXNlZnY0U1J0MUNaOGRybTRoeGdjTmMvWW9adzkr?=
 =?utf-8?B?cmVWWU1GOTQ3YTlhTVpJeUd0TDdJb3ZGbi9VVFN2L2xhZFpmdm5CVGlyZWR4?=
 =?utf-8?B?RERSRFVOUndxaEd2NTJyUFp5eDJoZFFEcXV6Vk1sYlpadTgveGN2MnBkY0Yy?=
 =?utf-8?B?K1ovNEVaNGRqc2ZndEs1ajd2OGdmejN0Q0ZVN2czVEFsck5vbEtiODB1M3Yr?=
 =?utf-8?B?MU9oN1IzZVpPL00vanMwNFAvOUNERjdRZnpPaWdlenJBUFFqQk5KWjJ3VzE4?=
 =?utf-8?B?eFVnMXN4WUQzVHQ2cG84S1NUQytFUGsyb1Yxd0VlOGtkbk1UMWcxdnZhRGRu?=
 =?utf-8?B?WWgzbDdrbVdIKzBvdC9kNVlXcW9qZDJnd0NrNHl1N2Z1Y29LRy9RcjQ5QVZz?=
 =?utf-8?B?alZ0bFVhOFlQa0xEc3Y0S3BrYjU2MlVSWU40ZENnNWtnTG9HQUhOTDYrZ09v?=
 =?utf-8?B?dndrMkk2cUdzMVlXVWJWU21iQ09JbGI0SWVRQ1JBQU1UQURFbjQrY25XY2Rq?=
 =?utf-8?B?R3RvSXNiOTFOM293NURoUWtqUy9tcnBJdzVHVVlLblpJR3A1cUJZK1ljaTBu?=
 =?utf-8?B?VGhuTjAwU3RMNHVvWHdjQmt1OXN1eEtON1ZBUmJDdUVYbWtsTXBER0ZSU1I3?=
 =?utf-8?B?ZFN1MG9nZ1NWaTFSWDdQbUc1cWt2SjJ1TXNtYkdRS1Z0OWQzMC80SU12ZzZp?=
 =?utf-8?B?S1o0eFJuaDBYUXdCUWpKdWluUmhXOHZIYk9LZjhNSFdlSWtFdjIweUJWdlBL?=
 =?utf-8?B?bnhReWdJaFoxMFdiM3g1dG1OZU1uNGc0cTJ1d2ErVkp4L0ZkbEl1SG1QNURs?=
 =?utf-8?B?VmhWazAyZ0t0SDdIRVZwcyt3cTRDZExxeHpGem1Rd2VwMC9PMnZEc2F5bDN5?=
 =?utf-8?B?cngyc25mcVR0RWMzcTZFZHpLOExWVWQzdlhqcVU0Smg3MnNDU2htSG4yOUcw?=
 =?utf-8?B?N3diT25USGZrOFJjR1p6dHR1NEExZzlDZFlyMVNQUUhUR0NCcGpMRzFPOWt6?=
 =?utf-8?B?cFRqV2JGU0V4Yi9pZHlEZnZTWGFsZnlsdk5UNXpFMndNR3lsUk9xY050eDh6?=
 =?utf-8?B?NjhGTHYwc3lGblBoQzNiNWpGWXAxY05YYlJ2Y0tSeWxKeTdKRExsUnRpNlpi?=
 =?utf-8?B?Sk5ldGlvamwybjliRUd5Ly9hUjZJSnorSXhPV3kxemIrZUQyY0tDYXQzRGYy?=
 =?utf-8?B?MU1GODN4TWZSbm1DV2lLVFIrei9TdXpSUTkwOWViRnJpMEU5dXc0dUNmcEpT?=
 =?utf-8?B?U0E2VDBPYlVoZHZ4cndCSnpiaUJpcnlyLyswaFEwN3dmRHRYS09BeTU5V0hK?=
 =?utf-8?B?aFpkMUNVWUl3cHFUQTN1Ym1zL2k4bEErczFURC84MUlQeFg1Z3hYVEprVjRS?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <194774024C7DF34A88675C593F682B89@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7595217-9973-4ba8-4776-08dc7fee7c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 14:49:04.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1OB01o+8pZpNZgY/r7bfoexd1xE8TlefiNvv0i7R4KfRXIqjx6Vv9Y/gakMZez7ZiLTyuN0K6fG/igOHCmZrD4YSxXPpO6lht1RcJ7ApnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7879

SGkgQ0ssDQoNCk9uIFdlZCwgMjAyNC0wNS0yOSBhdCAwMTo1OCArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAx
NTozMyArMDAwMCwgSmFzb24tSkggTGluICjmnpfnnb/npaUpIHdyb3RlOg0KPiA+IEhpIENLLA0K
PiA+IA0KPiA+IE9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAwMzowMSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+ID4gPiBIaSwgSmFzb246DQo+ID4gPiANCj4gPiA+IE9uIFN1biwgMjAy
NC0wNS0yNiBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gPiBPcGVu
IHNlY3VyZSBjbWRxX3BrdCBBUElzIHRvIHN1cHBvcnQgZXhlY3V0aW5nIGNvbW1hbmRzIGluDQo+
ID4gPiA+IHNlY3VyZQ0KPiA+ID4gPiB3b3JsZC4NCj4gPiA+ID4gDQo+ID4gPiA+IDEuIEFkZCBj
bWRxX3NlY19wa3RfYWxsb2Nfc2VjX2RhdGEoKSwNCj4gPiA+ID4gY21kcV9zZWNfcGt0X2ZyZWVf
c2VjX2RhdGEoKQ0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gICAgY21kcV9zZWNfcGt0X3NldF9kYXRh
KCkgdG8gcHJlcGFyZSB0aGUgc2VjX2RhdGEgaW4gY21kcV9wa3QNCj4gPiA+ID4gdGhhdA0KPiA+
ID4gPiB3aWxsDQo+ID4gPiA+ICAgIGJlIHJlZmVyZW5jZWQgaW4gdGhlIHNlY3VyZSB3b3JsZC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IDIuIEFkZCBjbWRxX3NlY19pbnNlcnRfYmFja3VwX2Nvb2tpZSgp
IGFuZCBjbWRxX3NlY19wa3Rfd3JpdGUoKQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiAgICBnZW5lcmF0
ZSBjb21tYW5kcyB0aGF0IG5lZWQgdG8gYmUgZXhlY3V0ZWQgaW4gdGhlIHNlY3VyZQ0KPiA+ID4g
PiB3b3JsZC4NCj4gPiA+ID4gICAgSW4gY21kcV9zZWNfcGt0X3dyaXRlKCksIHdlIG5lZWQgdG8g
cHJlcGFyZSB0aGUgbWV0YWRhdGEgdG8NCj4gPiA+ID4gc3RvcmUNCj4gPiA+ID4gICAgYnVmZmVy
IG9mZnNldCBvZiB0aGUgc2VjdXJlIGJ1ZmZlciBoYW5kbGUgYmVjYXVzZSBzZWN1cmUNCj4gPiA+
ID4gd29ybGQNCj4gPiA+ID4gY2FuDQo+ID4gPiA+ICAgIG9ubHkgdHJhbnNsYXRlIHRoZSBzdGFy
dCBhZGRyZXNzIG9mIHNlY3VyZSBidWZmZXIgYnkgc2VjdXJlDQo+ID4gPiA+IGhhbmRsZS4NCj4g
PiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGlu
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8
c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBbc25p
cF0NCj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICtpbnQgY21kcV9zZWNfcGt0X3NldF9kYXRh
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBlbnVtDQo+ID4gPiA+IGNtZHFfc2VjX3NjZW5hcmlvIHNj
ZW5hcmlvKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBjbWRxX3NlY19kYXRhICpzZWNf
ZGF0YTsNCj4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKCFwa3Qp
IHsNCj4gPiA+ID4gKwkJcHJfZXJyKCJpbnZhbGlkIHBrdDolcCIsIHBrdCk7DQo+ID4gPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldCA9
IGNtZHFfc2VjX3BrdF9hbGxvY19zZWNfZGF0YShwa3QpOw0KPiA+ID4gPiArCWlmIChyZXQgPCAw
KQ0KPiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcHJfZGVidWco
IlslcyAlZF0gcGt0OiVwIHNlY19kYXRhOiVwIHNjZW46JXUiLA0KPiA+ID4gPiArCQkgX19mdW5j
X18sIF9fTElORV9fLCBwa3QsIHBrdC0+c2VjX2RhdGEsDQo+ID4gPiA+IHNjZW5hcmlvKTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXNlY19kYXRhID0gKHN0cnVjdCBjbWRxX3NlY19kYXRhICopcGt0
LT5zZWNfZGF0YTsNCj4gPiA+ID4gKwlzZWNfZGF0YS0+c2NlbmFyaW8gPSBzY2VuYXJpbzsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gDQo+ID4gPiBX
aGF0IGRvZXMgY21kcV9zZWNfcGt0X3NldF9kYXRhKCkgZXhhY3RseSBkbz8gSXQgc2VlbXMgdG8N
Cj4gPiA+IGVuYWJsZS9kaXNhYmxlIHByb3RlY3Rpb24gb24gaGFyZHdhcmUgb2YgY2VydGFpbiBw
aXBlbGluZS4NCj4gPiA+IEluIGZ1dHVyZSwgeW91IHdvdWxkIHVzZSBzZWN1cmUgR0NFIGZvciBu
b3JtYWwgdmlkZW8gYW5kIHNlY3VyZQ0KPiA+ID4gdmlkZW8uDQo+ID4gPiBXb3VsZCB5b3UgYWxz
byB1c2Ugc2VjdXJlIGRpc3BsYXkgcGlwZWxpbmUgZm9yIGJvdGggbm9ybWFsIHZpZGVvDQo+ID4g
PiBhbmQNCj4gPiA+IHNlY3VyZSB2aWRlbz8NCj4gPiANCj4gPiBJIHRoaW5rIEkgd29uJ3QgZG8g
dGhhdC4NCj4gPiANCj4gPiA+IElmIHNvLCBJIHRoaW5rIHdlIGNvdWxkIGRyb3AgdGhpcyBmdW5j
dGlvbiBiZWNhdXNlIHRoZSBoYXJkd2FyZQ0KPiA+ID4gaXMNCj4gPiA+IGFsd2F5cyBwcm90ZWN0
ZWQuDQo+ID4gPiANCj4gPiANCj4gPiBCdXQgd2Ugd2lsbCB1c2UgRU5BQkxFIGFuZCBESVNBQkxF
IHNjZW5hcmlvIHRvIG5vdGlmeSBzZWN1cmUgd29ybGQNCj4gPiB0bw0KPiA+IGVuYWJsZS9kaXNh
YmxlIHRoZSBwcm90ZWN0aW9uIG9mIHNlY3VyZSBidWZmZXIgYW5kIHJlZ2lzdGVyIGJ5DQo+ID4g
c2V0dGluZw0KPiA+IGxhcmIgcG9ydCBhbmQgREFQQy4NCj4gPiANCj4gPiBJZiB0aGVyZSBpcyBz
ZWN1cmUgbWVtb3J5IG91dHB1dCBzY2VuYXJpbyAoV2lGaSBEaXNwbGF5IHNjZW5hcmlvKQ0KPiA+
IGluDQo+ID4gdGhlIHNhbWUgZGlzcGxheSBwaXBlbGluZSBhcyBtYWluIGRpc3BsYXkgc2NlbmFy
aW8sIHdlIHdpbGwgbmVlZCB0bw0KPiA+IHVzZQ0KPiA+IHRoaXMgc2NlbmFyaW8gdG8gZGlmZmVy
ZW50aWF0ZSB0aGVtLg0KPiANCj4gVGhpcyBBUEkgbG9va3Mgbm8gcmVsYXRpb24gd2l0aCBDTURR
LiBBbGwgdGhlIGpvYiBpcyB0aGF0IGRpc3BsYXkNCj4gY29udHJvbCBsYXJiLCBkYXBjIHRvIHR1
cm4gb24vb2ZmIHByb3RlY3Rpb24uDQo+IEFsbCB0aGUgcHJvY2VzcyBpcyBkb25lIGJ5IENQVSBu
b3QgR0NFLCByaWdodD8NCg0KV2UgbmVlIHRvIG1ha2Ugc3VyZSBhbGwgdGhlIHNldHRpbmdzIGFy
ZSBmaW5pc2hlZCBkdXJpbmcgdmJsYW5raW5nLCBzbw0KYWxsIHByb2Nlc3NlcyBhcmUgZG9uZSBi
eSBHQ0UsIHdlIHdpbGwgaW5zZXJ0IHRoZSBzZXR0aW5ncyBvZiBsYXJiIGFuZA0KZGFwYyBieSBy
ZWZlcmVuY2luZyB0byB0aGUgb3RoZXIgaW5zdHJ1Y3Rpb24gZm9yIGRpc3BsYXkgSFcgYW5kIGFs
c28NCnRoZSBzY2VuYXJpbyBoZXJlLg0KDQo+IElmIHNvLCB0aGlzIEFQSSBzaG91bGQgYmUgcHJv
dmlkZWQgYnkgZGlzcGxheSBUQSBub3QgQ01EUSBUQS4NCj4gDQpNYXliZSB3ZSBjb3VsZCBwYXJz
aW5nIE9WTCBsYXllciBjb250cm9sIGFuZCBXRE1BIGluc3RydWN0aW9ucyB0bw0KZGVjaWRlIHRv
IG9uL29mZiB0aGUgbGFyYiBhbmQgZGFwYyBzZXR0aW5ncyBhbmQgYWxzbyB0aGUgc2NlbmFyaW8g
aW4NCnNlY3VyZSB3b3JsZC4NCg0KSSB3b3VsZCB0cnkgdG8gcmVtb3ZlIHRoaXMgYXMgd2VsbCwg
dGhlbiB3ZSBvbmx5IG5lZWQgdG8gcGFzcyB0aGUNCmNvbW1hbmQgYnVmZmVyIGFuZCBtZXRhZGF0
YSBsaXN0IGZvciBidWZmZXIgaGFuZGxlIGFuZCBpdHMgb2Zmc2V0IHRvDQp0aGUgc2VjdXJlIHdv
cmxkLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+
ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBKYXNvbi1KSC5MaW4NCj4gPiANCj4gPiA+IFJlZ2FyZHMs
DQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChjbWRxX3NlY19w
a3Rfc2V0X2RhdGEpOw0KPiA+ID4gPiArDQo=

