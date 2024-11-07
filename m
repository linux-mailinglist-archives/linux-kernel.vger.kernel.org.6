Return-Path: <linux-kernel+bounces-399424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94469BFEC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D1EB21CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7D195985;
	Thu,  7 Nov 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cbHuXJDZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mxfcxghM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58859802
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963119; cv=fail; b=ezgGF43v5nHrdEppTvPN//cCpQyrn9MytD8t9OhDjWH7HLoMaYDT1X6ryoLG2mJo+Tv0VZgakJyw0z60NSuI1txXZmUWVv2/L4XGYVKHzpCiuTeKdtZCWYAUjoXiFbtlQ53l7zNnhk3ciy9qEhe4FRQKLkEreCR6Yr6MAjzrVNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963119; c=relaxed/simple;
	bh=7bAuIIEjATT11EDNfHA7DSAD0zw6RAT4A1tYxsPVcXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8meXhZBs/bdFjl2pEl/Q94kPcf88l0JBhZymPkak5Cuc/RtZBEns3iYgSvALbUs+WlfQR+VAw7xmZ1WO0tp3hXVfzuTMc3sv5suITJJoN34hbxuVqRbRXy/TeEnB6522mIctsyjcmiyOIIw7JRS1mNU/GSVFLfP9T/ZSQ0FaPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cbHuXJDZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mxfcxghM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a125a2d29cd611efbd192953cf12861f-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7bAuIIEjATT11EDNfHA7DSAD0zw6RAT4A1tYxsPVcXw=;
	b=cbHuXJDZMpybyPzXFA3/hdYxFwKvr6JSZcr4bxV2TWAWx9/mxO6PG7RWz5Hhy651F/aZAlACkXBHA8yN7iC+FSHxf5GwAWgFGkvAjhQyxnAwt3on2TA0RX5EoKhCoTSwWHoMaaHqQGWr81WRw6GIOrXdyYI+axwkiKIY1VXDUVA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:98d36612-2568-413b-ae71-14a1337c1cec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:72d2b106-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a125a2d29cd611efbd192953cf12861f-20241107
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1912416282; Thu, 07 Nov 2024 15:05:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 15:05:08 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 15:05:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiEG8Me69RDuwg86gq0mETK0zVgHEBoLv0LDXgu7iBZaw+T/fCEZhnj5aQHT6aDBj2+V0i6syvYj8uC/5eoJgD649GSTQLAGKInzl8V7YcTwYdddDicMSp8rqEbVJyR+8Grzhd9vEA6LCbQjnEyd51w2Nb/UqfOX3zO3eFDz4ByQMR0Caq1lOTAkkaZfK638Ic/ABh9EM/jPvxWcMSyyrYtPGRCFsAgGWVWE41vo3Jm12W9FVgV3xhtrW1Ikv+vA+y8zZS7r6T/0rqakg6W7/HBVoeD0CdGHEYovzQ2c5/qBIzqevNbc02CUESguGN0ZEmYdfcx8ICDXIPRwFZQVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bAuIIEjATT11EDNfHA7DSAD0zw6RAT4A1tYxsPVcXw=;
 b=fAYvjrsXH7FGG2yQYjd06KjgXs7Eh2Q5UNr3suHDUpwNlxbLnc/2aqQQMghfnXW0jq7DrEi7oTmfJzpk0YeVfrORRbCxDh7Eu510M6ViE9nUKcqSd4+jn6Ts1nH8womUbBSCmghd+xFsFD2uVWNgfLMzk/qby8jMhYsKsgoyYYfxf5ZxRvMD87qqL2qWhHw+B2uCEZge1ae5pbFvEZCIuWc1KQdFJT1nuVdau2IugzYlSYAR8DzzRF+kDHGJmhOAsDQ7ABO4qEu7UeBicEVER6JA9CuCDcUL9a87JJ7cBJ5fELyO6yUgIYAyX7EEvw28oi8rxrQQcyaDqEhYfqeIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bAuIIEjATT11EDNfHA7DSAD0zw6RAT4A1tYxsPVcXw=;
 b=mxfcxghMbc5SY1aGr/mgFssL/lWqyYPSyg6aGAg07U0CicrsacTXUu4FHd7FyjgzwO6kri8WG3LO0/W7CQL6WUfuIpLXGXyaieSZmcC1k71Mosz96PutrH+0scg2waXwSwh6l1qnLMzNDFHz0bOA82UgBDVanZ+vyZfaCRctTMA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 07:05:04 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 07:05:03 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHauZvjSsoBOfJjC0GAI+NtmELueLKi6UOAgAlqPwA=
Date: Thu, 7 Nov 2024 07:05:03 +0000
Message-ID: <64d593e87d518dc109bbcbf8e1a3e2aef770a384.camel@mediatek.com>
References: <20240608120219.21817-1-mac.shen@mediatek.com>
	 <20240608120219.21817-3-mac.shen@mediatek.com>
	 <c44f75106e0b4bf04f8158231c1bf6cbdae93a64.camel@mediatek.com>
In-Reply-To: <c44f75106e0b4bf04f8158231c1bf6cbdae93a64.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7343:EE_
x-ms-office365-filtering-correlation-id: db414918-397a-4c5d-3018-08dcfefa80a9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Rml0ZmtodERmbTVTRzBMYjRyejFOSVFyREQ5S3pHSXRZTnJ4TzN0MVhCS2dT?=
 =?utf-8?B?ZlNIdHoxVXI0UFNHM0s2a01TRUhUQ0hydVovYzgwYzQyajdhbVNtbFVZSHpJ?=
 =?utf-8?B?bW9hekVvS3hQTGk0TDdlc3BrcHdVcjY2aWR1VDJvakxGMDYrNVNXWHZwbXVo?=
 =?utf-8?B?b1ZtdkVicVJaM3BHUER3bHlacXRrRTVSdEc1ZmNwakpqYlZSQVJ2TVFOai9s?=
 =?utf-8?B?bEVCaEttbEJBUmpKM2NXeWxjY1k1c3BERzUyZDhOUjBTZGYwNC9WMjA1YVIr?=
 =?utf-8?B?eUV3SWhsSXVNTHc1TWoyMEFFWHNCdjZPNDdWZDkwUGV5eVNraEVJeWhLWGVI?=
 =?utf-8?B?aDhqckpROEM1ZU80aFJTRjZzejN6OFRhZFFnTXFaVWY4b1FaWE9FSE9DYjVh?=
 =?utf-8?B?eGxIVmMxYkZtc094T1hDRDNHWWFOb1BwTGpDc09sWmEyL3ZyZHhKbjRZUTZp?=
 =?utf-8?B?WW15eGVkZDZrTWhtRmF3Y3dtVG5kOTQrR2l2MUk1eERaQlQ3VElYNy9XcmFn?=
 =?utf-8?B?WGJnZFVFSm8rc2d2RnlLUDdQYzJuUlpwYW9vbWlhSHF5M2tXY2lBSW9sYis0?=
 =?utf-8?B?STl4VHBXbVNLaHdkemdUc1cwUTZPYklUU3JUOU44VC96eWxDM1JGODZYZGtw?=
 =?utf-8?B?UHdxUU9NM0pMd2FmK01qTzNtVmNxdVEvTW5yc3hJVE1VM2JSRVlwRVdobkhN?=
 =?utf-8?B?anBqc25CaXh5RU5na3g5UDRJRm1JeHdTZzJnOENlcVE2UTJKZlh1Mk4yNWRG?=
 =?utf-8?B?RUdMN2tlNENQcDkwbUUrWXY0VnluSmlFL0YzazM3TUk4T2gvRnVKRVpQS1dG?=
 =?utf-8?B?eTNacC9GN1dNdmRLOWQ0enNnMGxrODIvN05jazNER3FyblY1bU45MUdCN1la?=
 =?utf-8?B?blZIRG1JQWpGWnZwZXZXR3ZPNjZ5RjRyVENyTG0vaU4yLzZpN2d6WWFLNnVJ?=
 =?utf-8?B?ZEhxbXN1TWt2RWVPNytHS005aDVSZkVta0xrMWhWM3VFOE1EaDBuK1ZjMmIv?=
 =?utf-8?B?cC9TR283TWw1N2RCOUtuaGZvZmV0bW9odk1NWDZZUmxGUlhaZjJ3WUMrNGo0?=
 =?utf-8?B?YXl6RHpFNW9Nb0R4b2N3Tk5OeCtaZTRhOTJyUmlQTFpIMWNJcVhDTUIyYlNQ?=
 =?utf-8?B?Yk5IamFZdFdidGt2Wlpnb1Y2SEpVd2JIMXdqQWpjNHR2NVE4ZG9neTJOa2tZ?=
 =?utf-8?B?eWlmTnEyTGxzcllkZC9QZWNzeUxHeHZHa01NU1BjU1FwL1lXMmQ5UlVGMHoy?=
 =?utf-8?B?dUcxQmtqSmVMaHJIU2N0bDRDbDJtTmg4YStORktuUmVSU1hJZE9FMnNrMGVP?=
 =?utf-8?B?b2FlTkM2ZVBuMHl3enZWbUJRYUJ3WGNoeFRNVCtHRXg1WFBuQms0ekllVVlQ?=
 =?utf-8?B?T09GYjd6OXlIVXlodTc5U1BHSUlZUXBBZnRLRkczaytIbU50cjRucWx3YWI4?=
 =?utf-8?B?cDBZRTA2VnBBd092NjROalRGL01XMWM3RzArSnBtZlNNOEdJTWloNG0wcDdX?=
 =?utf-8?B?NTk3QmRxQkZtWThyWXVIWElmeXdUKzducTNINFQyejRyUk5KbzEvaUJXZkY0?=
 =?utf-8?B?Y251MmpoNy90V3Z4a3c2M29YSm9TcE9uemp4UVNaMXMrSStjWEorL3p3OEZx?=
 =?utf-8?B?cVFKVkZtZ2g0a1IyU2dvUmZvOTdEL2ZxNnFWdmR3NFdYakk2d0F1dU1PVkxG?=
 =?utf-8?B?Qm5STjJEQUFGaHVTaXZCZEFlYXFvMVlXb01PWGppcFhYYkNFSHRPNmFzemtZ?=
 =?utf-8?B?Tk9sTnd6aTNBMUFWU3JHVGNSRXhjTFcyZEtIbUlsWUE5VU9XL0EwQkpwM3J2?=
 =?utf-8?B?MVBiNk1EQXI0QVdicExKSnRXd2hldFdHNTdGdmFKSVViWkQxalhhaDdESWMv?=
 =?utf-8?Q?5GyzCmFkRok0v?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktuNWd3Syt6aTE0L216RXljdFFjWXBIRENUSFE3YzdoOXZJWkZnczd2NTJw?=
 =?utf-8?B?NkRWZSs1aStKN3FFZmNNMyt4YnMveEJnZUQ5WDgwZGZzeU1uQXVhNmI0ZTY0?=
 =?utf-8?B?V1gzZFVGTXRqSG4zbk9pckYrOUpMQTNsajUvVTNTTTcwd0NXSmQ3NFFmN2Fq?=
 =?utf-8?B?a1JuWjIrUy9vc3ZkckdvQ2lrOFpuSURHUWNKc1pMUG1CYk5qdlg0UEY2SUJy?=
 =?utf-8?B?U1ZTWDI1Tmh0YnE1ODZlY0hyOFlIT2pPdy8yVmlnYzFiTTNaaDNGOXNTZWtU?=
 =?utf-8?B?UFI2Y250UnVpa1Yzd3pTUWhESG15THpJTHRrYXN6TjNrbGEzVkRyeTViaFdO?=
 =?utf-8?B?TUdlWUdyOENDaUN5WmtxOWwzWEovNG9vTHVGQ0FzZzhqQ1lVNit0ZlBaYnJN?=
 =?utf-8?B?V01hemxlTnhSNGRZOGlHRWVWQXhRVjBYalZCWFpscmlobjI0NGlnVjRrUWhW?=
 =?utf-8?B?MnJrZGsxQjd0YnVXZWphZDlXOXdkeC9XMEhpR1k5SS9hTWx3WUdhVHh4dmlo?=
 =?utf-8?B?OFNqY0cxRjUyRHBDZXJuUUdZTlNycXlPc1FmUXM0OWRBQThiQm1qK0hhNGpO?=
 =?utf-8?B?dlZXeTBlcnVZb0VTT01ZU0lxRVZkdm51Q09HTU5vd1J0aDFXMnExMEdqNVlE?=
 =?utf-8?B?RlJCb0RwNXFaK2QzUlVCNk5yazFvUkRmd2F4Nmd6WDZRdmtYQUZhbzdsRStL?=
 =?utf-8?B?NG1kQjlyT0Z6NUZaenFMYkIwQ3hGSk1hVHJ3UTkwcVdwVzlEUG1UbjcyQk42?=
 =?utf-8?B?VU1ncUo5OC9LdFdobXgvNituRXpiR2F5aDBLenNFaFBleERpNEt4M3RVZ2Zh?=
 =?utf-8?B?a2drZzRRc3hBQ1YwN0E1anpZMThFTnFUUmhxSlF0VllHcDlMQXkzQWF3VnRS?=
 =?utf-8?B?VHlKamRmYzN3aCtoUlhiTWxVRXM4M3RiZ01vcUR4cnp6ci9SQVkwZ29vd29u?=
 =?utf-8?B?dGh5QnpmbHhGd05jSUdqWlBHKy9YZ0NEa2JqVUF6d2FsZFdMcE5CbUxFa3J1?=
 =?utf-8?B?N0xQUExHa2N0WVZxa29aV1B1VTRjREV5dG9iSHd0ODZJQnAyVzkzNGFCVWE4?=
 =?utf-8?B?aTRwSGdLMThCODh2cnJ6WWxxd0cyV1V0SllZZ1p0Z2J0cG9abmgvRkJYc0w1?=
 =?utf-8?B?RGJhRXF5ZUg2WFgwMnVkUDFKcm51YS82cWxMc3gvUytqRUpOVFFHeHN1U2xh?=
 =?utf-8?B?RGNaNmtGai94SittT0IzMGRoTDZmbzd1WityemdGUzlvdDRpQ2ltb2JQV0FI?=
 =?utf-8?B?Uk5VbTNRZnJxZGQ5QmhxaFZjTW9mbUErRUlFdm1ORElaQnRsQ0JYTG1zZ054?=
 =?utf-8?B?RDl0bEg4K29WeDhtMXhTd2hZcUtaV1NzRlVVbkw2SWs2SGJHUzZyWWhIeUJZ?=
 =?utf-8?B?YmtyMmNWYVdkRll4Q3AwWXNVL29GeU5yQzNxNHpQS1l4QVIwcVA4V2Y4ajhz?=
 =?utf-8?B?ZGFIVkNhNE8yVTFTRWVlSlFyZ0hVNEkvRzdqNklvMW1SVmtGd05pUG0zNThE?=
 =?utf-8?B?eHc1SVZoZ0ZlU3REL2pQbXJIaXJ6OFVVY0pDeU16UStBZFBwUEtUMUxhYS9H?=
 =?utf-8?B?bUVFZjJJL05JcHF3ZUxFcmxicHZqRUxDakU0LzA2OFdmZW8yU3hIdFpuaUJ6?=
 =?utf-8?B?a25OZ2xWNmtvUXV6MUprYWFKazFOcDNPR1grQjAyS1FnOE9HV0ViRnZibkNJ?=
 =?utf-8?B?a3hHdE5jazBLbUt6ZnVhN2lDcldvRjY4MEFyUDkyWTBCQ1RGUUxIYXQ2V3Jp?=
 =?utf-8?B?VkxDa1JWQm1BZjdrRk9FbEZJelRpNXdndk9jTEtESFdrcldZSUs0RFVMcEx5?=
 =?utf-8?B?UW9RK1FISGZzTEt4WlFtY2JEWisza054eGYybnE0NEExYzFqQWVXZ0Q3djA1?=
 =?utf-8?B?REpGNEk1SDNHakFnVkxtOGpDcC9CRVREU3BtRkU4ZmZDRm1HbmNObzc1T2JT?=
 =?utf-8?B?WExkblBhMUwrVFlxNFp2Y3NkMElKMWljaldRdUhoQXpmeGpDZy9kSWpvdWNR?=
 =?utf-8?B?eVRzMjJjaXJSRjJvTzZ2NlJqL012aTFDazVQWWN3ckpBb0dvOTlPUERIUFBx?=
 =?utf-8?B?aldDRVBOMDhzaGJ5SW9LcU5ZZmJ5RkVkNWlsZFFXZjhGNytweDFpamNsbndK?=
 =?utf-8?B?RDdINEVyZC9rWkJzQWZHOVY2UzQ1L1VZRHFKMVEwQTloWDJPSUtXZkkwVFhu?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FCBED396C39A04580D0EB7407EF102E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db414918-397a-4c5d-3018-08dcfefa80a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 07:05:03.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66jX4wnXc9couor4ltMTaPKsYuwJ5+qqJDStgmFpkZ3xqfF/7fVctKr08eLIImGBPruyPcACMrSU1jGuZttvng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.494000-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsPHkpkyUphL9/HLmisMjYNWe9toQ6h6LE56S
	RXXLOh8Wj9Seo3OSvpJ39JHqy4RfgsbD4aZzngQUnVTWWiNp+v8oUVkB7ifJnlksP1I0n2wSG+g
	tTCI98hBWYmumQvMouVdTP5dw4GER9X41s3bshlZCxKB9Mp7mVWf6wD367VgtzUFc4X2GObIURF
	2cIQ7hcUkmuifZJY605luZbXSd+eNX3FZn4DvE8kOLK43kW8U2rokbkfZgmrrtXwvFfAG9FFkiH
	cktG75f4vM1YF6AJbY9l7H+TFQgdfnZI3fdS4AA3QfwsVk0UbtuRXh7bFKB7iUkWKgMxF4py35P
	dCPHGmbKo6Mf3NRmDZTbuXxRblNMlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.494000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AFED7CA4CF9C81B101870889D9C56275E9C376563DB24881223AABC87C8531B22000:8

SGksIE1hYzoNCg0KT24gRnJpLCAyMDI0LTExLTAxIGF0IDE1OjE4ICswODAwLCBDSyBIdSB3cm90
ZToNCj4gSGksIE1hYzoNCj4gDQo+IE9uIFNhdCwgMjAyNC0wNi0wOCBhdCAyMDowMSArMDgwMCwg
bWFjLnNoZW4gd3JvdGU6DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIHJlZmluZSB0aGUgZnVu
Y3Rpb24gdG8gZ2V0IHN5c3RlbSB0aW1lDQo+ID4gLSByZWZpbmUgdGhlIGZsb3cgdG8gZG8gSERD
UCB3aXRoIGNvbnRlbnQgdHlwZSBhbmQNCj4gPiAgIHByb3RlY3Rpb24gdmFsdWUgd2hpY2ggc2V0
IGJ5IHVzZXIgc3BhY2UNCj4gPiAtIHJlZmluZSB0aGUgZmxvdyB0byB1cGRhdGUgY29udGVudCBw
cm90ZWN0aW9uDQo+ID4gLSByZWZpbmUgdGhlIGZsb3cgdG8gZG8gSERDUDIueCBhdXRoZW50aWNh
dGlvbg0KPiA+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LW1lZGlhdGVrX187ISFDVFJOS0E5d01nMEFSYnchbWQ2eFVpWU44OEQyWW1F
VHM4RlFnYUV4TTJ6SDhTMVNtQUVVOUdSY2h3cE5zWE95REZ1bDN6aVZLaFJwQ0phajhSY24tZ3ZN
LTgwMXJ1bmp3QSQgDQo+ID4gL3BhdGNoLzIwMjQwMjA1MDU1MDU1LjI1MzQwLTMtbWFjLnNoZW5A
bWVkaWF0ZWsuY29tLw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hl
bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IGRwX3R4X2hkY3AyeF9yZWFkX3JlcF9zZW5kX3JlY3ZpZF9saXN0KHN0cnVjdCBt
dGtfaGRjcF9pbmZvICpoZGNwX2luZm8pDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfZHAgKm10
a19kcCA9IGNvbnRhaW5lcl9vZihoZGNwX2luZm8sIHN0cnVjdCBtdGtfZHAsIGhkY3BfaW5mbyk7
DQo+ID4gKwl1OCByeF9zdGF0dXMgPSAwOw0KPiA+ICsJc3NpemVfdCByZXQ7DQo+ID4gKw0KPiA+
ICsJZGV2X2RiZyhtdGtfZHAtPmRldiwgIltIRENQMi5YXSBIRENQXzJfMl9SRVBfU0VORF9SRUNW
SURfTElTVFxuIik7DQo+ID4gKw0KPiA+ICsJZHBfdHhfaGRjcDJ4X3dhaXRfZm9yX2NwX2lycSho
ZGNwX2luZm8sIEhEQ1BfMl8yX1JFQ1ZJRF9MSVNUX1RJTUVPVVRfTVMpOw0KPiA+ICsJaGRjcF9p
bmZvLT5oZGNwMl9pbmZvLmNwX2lycV9jYWNoZWQgPSBhdG9taWNfcmVhZCgmaGRjcF9pbmZvLT5o
ZGNwMl9pbmZvLmNwX2lycSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZHJtX2RwX2RwY2RfcmVhZCgm
bXRrX2RwLT5hdXgsIERQX0hEQ1BfMl8yX1JFR19SWFNUQVRVU19PRkZTRVQsICZyeF9zdGF0dXMs
DQo+ID4gKwkJCSAgICAgICBIRENQXzJfMl9EUF9SWFNUQVRVU19MRU4pOw0KPiA+ICsJaWYgKHJl
dCAhPSBIRENQXzJfMl9EUF9SWFNUQVRVU19MRU4pDQo+ID4gKwkJcmV0dXJuIHJldCA+PSAwID8g
LUVJTyA6IHJldDsNCj4gPiArDQo+ID4gKwlpZiAoIUhEQ1BfMl8yX0RQX1JYU1RBVFVTX1JFQURZ
KHJ4X3N0YXR1cykpIHsNCj4gPiArCQlkZXZfZXJyKG10a19kcC0+ZGV2LCAiW0hEQ1AyLlhdIFJY
IHN0YXR1cyBubyByZWFkeVxuIik7DQo+ID4gKwkJcmV0dXJuIC1FQUdBSU47DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJcmV0ID0gZHJtX2RwX2RwY2RfcmVhZCgmbXRrX2RwLT5hdXgsIERQX0hEQ1Bf
Ml8yX1JFUF9TRU5EX1JFQ1ZJRF9MSVNUX09GRlNFVCwNCj4gPiArCQkJICAgICAgIGhkY3BfaW5m
by0+aGRjcDJfaW5mby5oZGNwX3J4LnJlY3ZpZF9saXN0LnJ4X2luZm8sDQo+ID4gKwkJSERDUF8y
XzJfUlhJTkZPX0xFTik7DQo+IA0KPiBJbiBbMV0sIGludGVsIHVzZSBEUF9IRENQXzJfMl9SRUdf
UlhJTkZPX09GRlNFVCB0byBnZXQgZGV2aWNlIGNvdW50Lg0KPiBCdXQgaGVyZSB5b3UgdXNlIERQ
X0hEQ1BfMl8yX1JFUF9TRU5EX1JFQ1ZJRF9MSVNUX09GRlNFVCB0byBnZXQgZGV2aWNlIGNvdW50
Lg0KPiBTbyBib3RoIGNvbW1hbmQgY2FuIGdldCBkZXZpY2UgY291bnQ/IE9yIHNvbWV0aGluZyB3
cm9uZz8NCg0KRm9yZ2V0IG15IHByZXZpb3VzIGNvbW1lbnQuIEluIFsyXSwgaW50ZWwgdXNlIERQ
X0hEQ1BfMl8yX1JFUF9TRU5EX1JFQ1ZJRF9MSVNUX09GRlNFVCB0byBnZXQgZGV2aWNlIGNvdW50
Lg0KDQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9oZGNwLmM/aD12Ni4xMi1yYzYjbjE3NDkNCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFsxXSBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2hkY3Au
Yz9oPXY2LjEyLXJjNSNuNDk3DQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiArCWlmIChy
ZXQgPCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJaGRjcF9pbmZvLT5oZGNw
Ml9pbmZvLmRldmljZV9jb3VudCA9DQo+ID4gKwkoSERDUF8yXzJfREVWX0NPVU5UX0hJKGhkY3Bf
aW5mby0+aGRjcDJfaW5mby5oZGNwX3J4LnJlY3ZpZF9saXN0LnJ4X2luZm9bMF0pIDw8IDQgfA0K
PiA+ICsJSERDUF8yXzJfREVWX0NPVU5UX0xPKGhkY3BfaW5mby0+aGRjcDJfaW5mby5oZGNwX3J4
LnJlY3ZpZF9saXN0LnJ4X2luZm9bMV0pKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkcm1fZHBfZHBj
ZF9yZWFkKCZtdGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX1NFUV9OVU1fVl9PRkZTRVQsDQo+
ID4gKwkJCSAgICAgICBoZGNwX2luZm8tPmhkY3AyX2luZm8uaGRjcF9yeC5yZWN2aWRfbGlzdC5z
ZXFfbnVtX3YsDQo+ID4gKwkJSERDUF8yXzJfU0VRX05VTV9MRU4pOw0KPiA+ICsJaWYgKHJldCA8
IDApDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBkcm1fZHBfZHBjZF9y
ZWFkKCZtdGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX1ZQUklNRV9PRkZTRVQsDQo+ID4gKwkJ
CSAgICAgICBoZGNwX2luZm8tPmhkY3AyX2luZm8uaGRjcF9yeC5yZWN2aWRfbGlzdC52X3ByaW1l
LA0KPiA+ICsJCUhEQ1BfMl8yX1ZfUFJJTUVfSEFMRl9MRU4pOw0KPiA+ICsJaWYgKHJldCA8IDAp
DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBkcm1fZHBfZHBjZF9yZWFk
KCZtdGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX1JFQ1ZfSURfTElTVF9PRkZTRVQsDQo+ID4g
KwkJCSAgICAgICBoZGNwX2luZm8tPmhkY3AyX2luZm8uaGRjcF9yeC5yZWN2aWRfbGlzdC5yZWNl
aXZlcl9pZHMsDQo+ID4gKwkJaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmRldmljZV9jb3VudCAqIEhE
Q1BfMl8yX1JFQ0VJVkVSX0lEX0xFTik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gDQo=

