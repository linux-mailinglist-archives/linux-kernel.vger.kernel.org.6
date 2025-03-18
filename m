Return-Path: <linux-kernel+bounces-565381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B693BA66714
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E1716B09F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61061991A9;
	Tue, 18 Mar 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JQYmFInv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pc07AOgZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF199EB2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267658; cv=fail; b=W5muq04Is0x6DzxoiOaKWmHHiitJ1UUyxe84e613UvWjHxITD5LgSy90Avq7WPfE6yVwYOWe42RH34MvHoD+2aTY2SvkQ5UZbkOTcm509jQhgAlv4FGh6SwKoLw63k1zD1Y9X1rNhwEfgMMzmv4cuF1+88GpLFPqlkzRx4Oeg+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267658; c=relaxed/simple;
	bh=nNBuzUUHXzud/JZYzCqw2IsKLIwZCpzJYhJ72e13ScU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCgh2eAz5MpwyPJnIy3fGDr9uvQYlb2RD5lfkYjUWYQCDICv383i04rUu491VWEs7nt+P12eiqvCJY/nJgxYxyoAz4eSI+tgQl1rRQRH2ELn/1qn30y/4Jn2jKSTcaIwjzqoinXsT25BSt1TMlPhqyam/67QGg+x8rI2Hm19juM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JQYmFInv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pc07AOgZ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 114579b603a711f0aae1fd9735fae912-20250318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nNBuzUUHXzud/JZYzCqw2IsKLIwZCpzJYhJ72e13ScU=;
	b=JQYmFInv8SRbzy8Y6A7g3xuEDh2T5B9grpdp8U0viHSWtxGMkwK7mgQM9DMrzV5edrIRv6+rrRGsesjrbDplu5f5aA3APrvkVfr7uI6lTIZSsYD7eURsQKnbK++KpPePcuuSxFc/dN6h6WTysBIYX+Ndy0GvDilrsk5Zfv8GAgg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:fa319f60-d942-4a00-b8ee-ac30e121e600,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:df483c4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 114579b603a711f0aae1fd9735fae912-20250318
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <sunny.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 180071484; Tue, 18 Mar 2025 11:14:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 18 Mar 2025 11:14:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 18 Mar 2025 11:14:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4Up54lRrbcjOmIHUdvvq2bNBNDVEk+ZVxSBGsOG6gwCWW8uy4KluePUk28n0LNc70dPMMaGRN/dy+RawFDela3kld5GvnklsVcVlB0ioqIRA9IAYMXWfkOqEpeDpZPK42tgX3U0BetUEpJOFH11BbKmpX0J7jr1drAI0aAhuIPdsoKJio67fZLrVV4I3T3v5evLgVM3r2sXfeYxZz/AHFhJbnbwKdlIdwga97WsFfFf8mJyzWZlKmbpdyVwhDD5vy7e9tQpSg5Pt8t0IdyOyZkTr84URDJwekv6O6crD3RhwKG5sAB7RYhDaaHMSt2bwTmMNaMQ6ORFVnd0vWqKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNBuzUUHXzud/JZYzCqw2IsKLIwZCpzJYhJ72e13ScU=;
 b=juM8hKMHiFQKeD+yueiUlLeszWlbTAyBDstxgkf+XjGv1LlvacpsVD7KBRF2nRkIqwn7YPIqgIvvgAiyyfkbyUHaI98Y6crWJkN5uqgF7OhDupdAAYTWVm1FPEE6YtDg25W8ACR7OsO9mMRSeE6wRV6mtYo8huLSI1EnYvTMkBo6y8x6pLlEReJQLw7h5zxz0bi5py5i9C42xSjPCywr3TLehQK8saZfUBg+ALucj+MdMJ4FybknDBXyA9E3V74x9Cv0NNz8xyK021+ZgO2I9foQipfKu9Z2w9WKKlORALhEW8mw16htS3U1RRAaoLG2gs8ITVDBKucJVFzx2Y6z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNBuzUUHXzud/JZYzCqw2IsKLIwZCpzJYhJ72e13ScU=;
 b=pc07AOgZaOvqZKZtLuu2+JuR8DlZ/V1pGM9uHZNhZ0p0CxGlYFe286nM/Pnl31qXgeaAVNiNNaGJM+cXE65TNPCxMGEUoHf6mOadel0NnSpaUR26AAqc0yAZf8MZYFhQgKVfJT6DNAF7FZn5eLh3s+KcCLvAY9fdT/GRtnf7EL8=
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com (2603:1096:405:1a::6)
 by KL1PR03MB7222.apcprd03.prod.outlook.com (2603:1096:820:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:14:07 +0000
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf]) by TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:14:07 +0000
From: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"fshao@chromium.org" <fshao@chromium.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Thread-Topic: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Thread-Index: AQHbfDA5jLoxTxf3wkWDuIJMLNCq1bNCY5mAgBLaqwCAAaZHAIAhirOA
Date: Tue, 18 Mar 2025 03:14:07 +0000
Message-ID: <76a6fc25a09dfddb55fdaf0a9d7dcf9a6129b00f.camel@mediatek.com>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
	 <20250211025317.399534-2-sunny.shen@mediatek.com>
	 <20250211-feed-shed-4b32f146cc54@spud>
	 <029f9fd7ab898769a7ae627b160e1dce446ccc9e.camel@mediatek.com>
	 <20250224-dreamland-tactile-bdb58daf6060@spud>
In-Reply-To: <20250224-dreamland-tactile-bdb58daf6060@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB8330:EE_|KL1PR03MB7222:EE_
x-ms-office365-filtering-correlation-id: d3b84957-0d90-489b-bdba-08dd65caf224
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVVtRkZtaFNDalc2clA0VnpoVWh1aXZDY0hZb1NST0VNNHVwemJLNll5S1Jj?=
 =?utf-8?B?ZlVnWmJaT2R1bUE3VDRXVllNWGVXQldEbTNheEtFZkt1YXdQRmZQdjZwUEVB?=
 =?utf-8?B?emxTQWVpbWEwQjFqamxSeUlPV3ljMWVYQmJ2Y1hVcHN3cmpVRHRvY0dHcjgr?=
 =?utf-8?B?WjU3bGx5cHcvQkpQTExlZkZHb2M0LzZJbUZLdExza3BtOUErSHRwS1QwS0R1?=
 =?utf-8?B?cHZsS2JSWHhSRmNMK2ZJVGlmY21Ec09zcHkzTFkxTEtXMzNsMjYzUUN0Unpz?=
 =?utf-8?B?MVNRZ2FaUWRTWEVXaWJnQXN0Y0p1bmpZeFpjcEJRYmJxSzNjUUZOMTBjcU5I?=
 =?utf-8?B?eUtYM29sR2hoZEo4M1kwNHpGbW5CVjF6cENXbXo1VzB5M0xsbG5Fa0hDenU4?=
 =?utf-8?B?cVVuMit1NGpySVRDNWo3aEppajdwbXZqQ0ZUYXUzY2pWZHd2VTZNTElYRzNo?=
 =?utf-8?B?dzdzNVlmR2NTbCtvVVp2azRGREJBd0crSnBkTmd6RHphNER1MlZRY3lzdWp4?=
 =?utf-8?B?TndvdE42WHBTYWptaWtKcUFITTM2S0VGcVpLQnpLM1MyWUs5ejgvdnZEZ2hh?=
 =?utf-8?B?alJOOU5sVGk1VzNzUkNPQ0M0VnowY1B3S1hrY0kyVWR5b25VY1hsSmRtY0g1?=
 =?utf-8?B?amZ2bXkxVk5DOHA1b0o0RTBUZzZjMjFJUnlJVC81UVFZamQ3Z1BaNnRWQmVz?=
 =?utf-8?B?TVJZVk8wdEdjYnc0K1oya21HeUFub1BiTEc4Q3diaTRXQjN4dGJ2NWJGOXVG?=
 =?utf-8?B?V0dVWktnTG5OUVNCa2VmRUo1NVhWbndqdHkrdEVjUDJSdEFmZXNIbmRyM2VC?=
 =?utf-8?B?R1h0c1NpVTlDdzkxOHNHMDcvVzZ2Tmg1bjkxM2NGZ2dlTWVtc0RGRG5VNlh2?=
 =?utf-8?B?ZDNFaXhIWU9PYlEwRXh4dUh1RGRjcks5WkdSQnUwU2pmem01SDRLNHBzaFEy?=
 =?utf-8?B?anhjRithOEc1NEFpV01yZ2kvM0I0QjZJTUxPR3V0Nm8wTGRYaDNJcFFvUU5Z?=
 =?utf-8?B?czNCTHo5Vk52QU0yWnRvWFU3NWIrZDVCb0wwbC9valk1cDFneGYyZTdpVkoy?=
 =?utf-8?B?dDlZY2hBTHZjcmtIalBsSDMvaGhhMFd4QlBoT3ZJRE03bDY3ME82R0thdjBI?=
 =?utf-8?B?Q3NXT1ZsTjJjMCsyYjJMTFIySkhwTXBRaHRncEU1ODVRdW9YZysxRXVBNitx?=
 =?utf-8?B?bWp3aGtzRDUrRmgxbGdaOVhmc01SeVB4bGNpVGRTVlIvR3BhejE4ayt1cUxU?=
 =?utf-8?B?ZFR0VGFBaXJtTEx4dDNuNVFPNGo2eEl0SVdyRWVSRXlZVzBDZ0o2OHVZWHJr?=
 =?utf-8?B?SHNOcWlaTFR3V1pTRXVaSFNHNFBsWXNDZ3h6TnFCVzNYbnEyUGNkV1QrTWlN?=
 =?utf-8?B?enVjczEzZGh4LzhHZmtPSWUzcE8wWTg1Mms0U2R6WWVDa3d0OUoxZ1J4TUU1?=
 =?utf-8?B?d1lscmt5Tlk4YVVueENPNmtiMEw4ZkVUNWsrMU52Mk12djhHQjVoTGtrYkU1?=
 =?utf-8?B?SjUrcnZZdHl6QTlRa1kyOXg4VHMxQ3luTDVvSXB1OWVVVlJoOWJBeTRWZGFj?=
 =?utf-8?B?VDV0SnI0WUhEcWh4U21yc0hzZEFmbWpkTitIQW02bExsSldBMGhzT0ZWT3pI?=
 =?utf-8?B?SzZsb3dQakkzcFI4R2FRQmxLbStXeElKcDBCWWlWVTBGRjNQcDE3TFVubmQ0?=
 =?utf-8?B?aFZUTWFQbnFPT2F4bXVrbmlCTHhMV2Rna2t3clB4eTVNQlN5OC9SbHBQTW9n?=
 =?utf-8?B?RWI0TENYd05kaFR2R3dmTEIxNzgxdVhJOFFiRmJZMEFjbTF6UGg3TUgzWGpV?=
 =?utf-8?B?SHhuNUtreS9od2gxZlRGczMxdWN6VHI3dmYrWFoxNkJVZE1ocncwdU9WZVV4?=
 =?utf-8?B?RUlmeVJOQ2laU3ZjZzd2ZVF2cnJBVlRQbnNEVXJUUjNFeG9MSU94Nm4xdFNB?=
 =?utf-8?Q?mBASSUBsaqWMg78zTZpV7yVWBuPEAlUV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB8330.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzUxMmQ2Zzd2M29kSEprRmhCTHgwSnVlbGk3WmxSMFdiRGIvc01CMGNVNElL?=
 =?utf-8?B?WGJqRklFcU1ybU1Ua2VhdlNnM1NCN2JiSXJVY2daWWlyZUpFZlQvWFJtSEx2?=
 =?utf-8?B?N3VCaWtQYklHMXNSOFhxWlJTcjNDU0c0WVNGZm5GeUJ4bGZWSm10MG82YURu?=
 =?utf-8?B?V1pQb2hkK1QybVNVRTFkM2FET3YyeWFTeUF0Q09iRFRHQVFqVUpOeDRPMVBh?=
 =?utf-8?B?Yk1xL0lxOHU5N2NmbVhYUFM0bnA5dmdDc2IxL0NDOGpUc0tPYmYzb1JzVE52?=
 =?utf-8?B?cVJHKzl6Q3VRVU10OU9VWlltSWN3b29Ld2hMaUhnRkkzaDZQL1NZUmFteGRV?=
 =?utf-8?B?N3BpbFFjNjREZ1dzZTQ1SmtZTzdDNElOczhMZnE5UmhZbVZvOVVxVy9wOWRr?=
 =?utf-8?B?YUxOa3ZTNTBrRmJJZG1qdTZtRXpkU3FKVVhoZVFleG5vVFFrczJhdTdKTzI3?=
 =?utf-8?B?UGYra0pOaDVyWXFXK3BZUENQYVcrekNOZEowNzBsd1lPYk5FVnJpYzN4WUNq?=
 =?utf-8?B?SGxITjdheTRNWDcwYzNnOVA3ekNwZldOdFh2ZEhaMU1FZWFkbjFUNXRjZ0p0?=
 =?utf-8?B?UklVNFZraTVVb1ZocFVzZnlXaGxiNllsaktwU1JXck1FVGpBZkVFNEVRUjZH?=
 =?utf-8?B?TE45L3JSTWJkU0cyY1dDUHArYVRYR2h1KzZ3RHdHUzN0cmFBdHVpTksvL2Iv?=
 =?utf-8?B?QUdvejN0a2xMcU1jek1XcnEreFJrU1FQN3NXdFA2a0RHdUlIWDlpakkrZWVR?=
 =?utf-8?B?M3RCaWZFem85YW5GN0dKQjRDOVhGbGdDUzJnQ2dLTnRRSHExN2hmQ2lFQ3Vm?=
 =?utf-8?B?QWMxMk5MUXM4T0ZWY1MvNHVKVk94UnluaGxVMm4zcmtGTEJRa1dFVTJKbkxn?=
 =?utf-8?B?Q3d6eHJkOEFwZ0F5cGhWYjA3MEVuOGVkRE5BZUpHRytpOHp5aDdFTkkzR0Vl?=
 =?utf-8?B?SFZYREsydElXSGlXZERGblZtV2lzeWdCQkZjM3JpbDlSVzAwODVoSmZITXg2?=
 =?utf-8?B?RFE0c3FQZ1hqQ2ZRLzRzM0RwRUFaVkRDUGlISVp2QUZ5alBrbUs1b2xWVzJv?=
 =?utf-8?B?NnFaNjh4amF6Qjg3Z0R0RTVQQ2xoTXdDRTFSdzBCNkhFckdpMzZNUDU2TXRi?=
 =?utf-8?B?VlhLUnhYTWRPZ0s3WDRtY1Nzc2FydFJkYnJNR2hlNFh5Y0loblh1QUp4MWcr?=
 =?utf-8?B?dnNycVNPVW9XOFJ5MW5vaVlTWTdGQm4rN0hLSEtZRnhzMVgySE4vSUZGbFh5?=
 =?utf-8?B?TlJxN21EdWtSTWxoakwxMWlTQUtESTJkYW1KUjg2QkxQSm1jRFpFbVMzYVJ0?=
 =?utf-8?B?MnNPS3U0NUpWSVJuM1ovcHo4UTlRVzB1RmhndHh4UjAyWVExUUNCbWE2Y3ky?=
 =?utf-8?B?anJLOWsvVG5aOHhOUXZCUi9qUVduWkJOa2x3eW1QVXQ0NkxYTnhGeUcrWUFv?=
 =?utf-8?B?bi9wcmJyS3laL3JGMG9FNWV2L3RzcVoyNGFsS1d5Q2FHcUs4dXl6VWlubGpj?=
 =?utf-8?B?K0ZjN1g5cEJ1bUFYU0xCSmhoL214aTBJRFhQdWJxZ3VCNmd0ODFCK2JLek0v?=
 =?utf-8?B?UUdqWG0wdm4veGEvMDFmdmh1UUJUTHFsYjZZSmdFOEg3YzRaaEllNkxBRHBI?=
 =?utf-8?B?MC9CVUNiZkdsT0FaT0d5VFh6S0sxTzFIdnp2VEJSYW45bHp5MGZ4ZEczRjBi?=
 =?utf-8?B?dFdnSFVleWtoZDFiK05lRlJqSmhCVC8xOEhtSGQrYXBuV210c282WlI0QTBp?=
 =?utf-8?B?TGpXaGtkOVpNMnBWTkowQm1CaWtqaGdRYS8xVzdWNnVwV1M0SHZMdFNIdUVD?=
 =?utf-8?B?TDd6MnI0TjFIME5WNkYxMGovbFhQaytrRnBIWDgvV3Q5Z29FdXZqMWRTeEQ0?=
 =?utf-8?B?cDBNZUhXY0RWRG1neGs5ZzNGQSswQjRLdWR6dkdZb09XKzRINDhVc0lJQTZP?=
 =?utf-8?B?ZlNFVnhyWnF0R1NleU1DMXJadms5SHRUMldVZFNDcmpBU0NwRDRhODcxMWM4?=
 =?utf-8?B?RnhCOTNHWlZ2Q3prR2RmZVVyN05UV3pSclZHelpGSnhJM0VaaGJlZFdjdnBj?=
 =?utf-8?B?Qnp5dGt0bUJISWNKOWErdWZUc1JuRUtiaDU0ZUlxZlpzUUFNam5JVnNiYWsr?=
 =?utf-8?B?OTQxci8ycCtxeGJMMTdXcnNNdUZPdWliUWhVamlxNUx5Y0tBU0ZzYTVhSU9p?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C9F7EED1B9F2449B5F70984370F77DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB8330.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b84957-0d90-489b-bdba-08dd65caf224
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:14:07.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fS5eq0uX0pETbRjRDlW/kf5pzdEl6AwtKwiNmuSTGpjwfkX8HUAIV8Y7vwtBPOXkCVUWlI2gzBBt5geIlCz2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7222

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDE5OjAxICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFN1biwgRmViIDIzLCAyMDI1IGF0IDA1OjQ5OjQ1UE0gKzAwMDAsIFN1bm55IFNoZW4gKOay
iOWnjeWnjSkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1LTAyLTExIGF0IDE3OjU0ICswMDAwLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBhdCAxMDo1Mjo1
MEFNICswODAwLCBTdW5ueSBTaGVuIHdyb3RlOg0KPiA+ID4gPiBBZGQgTURQLVJTWiBoYXJkd2Fy
ZSBkZXNjcmlwdGlvbiBmb3IgTWVkaWFUZWsgTVQ4MTk2IFNvQw0KPiANCj4gPiA+ID4gK2V4YW1w
bGVzOg0KPiA+ID4gPiArwqAgLSB8DQo+ID4gPiA+ICvCoMKgwqAgc29jIHsNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
IGRpc3BfbWRwX3JzejA6IGRpc3AtbWRwLXJzejBAMzIxYTAwMDAgew0KPiA+ID4gDQo+ID4gPiBB
bmQgImRpc3AtbWRwLXJzejAiIGlzbid0IGFueXRoaW5nIGNsb3NlIHRvIGEgZ2VuZXJpYyBub2Rl
IG5hbWUuDQo+ID4gDQo+ID4gV2lsbCBtb2RpZnkgImRpc3AtbWRwLXJzejBAMzIxYTAwMDAiIHRv
ICJtZHAtcnN6QDMyMWEwMDAwIg0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0J3MgYW4gaW1wcm92
ZW1lbnQuIEhpbnQ6IGZ1bGwgd29yZHMgd291bGQgYmUgYSBnb29kDQo+IHBsYWNlIHRvIHN0YXJ0
DQoNCsKgDQpIaSBDb25vciwNCg0KQWJvdXQgZnVsbCB3b3JkcyzCoA0KRG8geW91IG1lYW4gd29y
ZHMgbGlrZSB0aGlzP8KgDQptdWx0aW1lZGlhLWRpc3BsYXktcGF0aC1yZXNpemVyPw0Kb3IgbWRw
LXJlc2l6ZXI/DQoNCldlIGZvdW5kIHRoYXQgIm1kcC1yc3oiIHRoaXMga2luZCBvZiB3b3JkIGlz
IHVzZWQgYXQNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQoNCkknbSBub3Qgc3VyZSB3
aGF0IHdpbGwgYmUgYmV0dGVyLg0KQ2FuIHlvdSBwcm92aWRlIG1vcmUgZGV0YWlsZWQgc3VnZ2Vz
dGlvbiBhYm91dCB0aGlzIG5hbWluZz8NCg0KVGhhbmsgeW91DQoNCg0KQlIsDQpTdW5ueSBTaGVu
DQoNCg==

